import os, subprocess, dotbot, platform

class System(dotbot.Plugin):
    '''
    Install system dependencies
    '''

    _directive = 'system'

    def can_handle(self, directive):
        return directive == self._directive

    def handle(self, directive, data):
        if directive != self._directive:
            raise ValueError('Shell cannot handle directive %s' %
                directive)
        return self._process(data)

    def _execute(self, cmd, output=False, silent=True):
        devnull = open(os.devnull, 'w')
        if silent:
            stdin = stdout = stderr = devnull
        else:
            stdin = stdout = stderr = None

        cwd = self._context.base_directory()
        ex = os.environ.get('SHELL')
        if output:
            res = subprocess.check_output(cmd, shell=True, stderr=subprocess.STDOUT, cwd=cwd, executable=ex)
            res = res.strip().decode('utf-8')
        else:
            res = subprocess.call(cmd, shell=True, stdin=stdin, stdout=stdout, stderr=stderr, cwd=cwd, executable=ex)

        devnull.close()
        return res

    def _get_platform(self):
        s = platform.system()
        if s == 'Darwin':
            return 'macos'
        elif s == 'Linux':
            d = platform.dist()[0]
            if d == 'Ubuntu':
                return 'ubuntu'
        self._log.warning('Could not determine platform. Currently supported: (Darwin|Ubuntu)')
        return 'unknown'

    def _process(self, data):
        success = True

        platform = self._get_platform()

        for (dep, props) in data.items():
            if not 'find' in props:
                self._log.warning("Could not search for {}, missing 'find' key".format(dep))
                success = False
                continue

            verbose = False
            if 'verbose' in props:
                verbose = props['verbose']
            
            installed = False
            try:
                stdout = self._execute(props['find'], output=True)
                self._log.lowinfo('Dependency installed {} -> {}'.format(dep, stdout))
                installed = True
            except subprocess.CalledProcessError as err:
                if 'any' in props:
                    install_cmd = props['any']
                elif platform in props:
                   install_cmd = props[platform]
                self._log.lowinfo('Installing {} -> {}'.format(dep, install_cmd))

                ret = self._execute(install_cmd, silent=False)

                if ret != 0:
                    installed = False
                    self._log.warning('Failed to install {}'.format(dep))

            if installed:
                if 'extras' in props:
                    extras = props['extras']
                    if not isinstance(extras, list):
                        extras = [extras]
                    for extra_cmd in extras:
                        self._log.lowinfo("-- Running extra command: {}".format(extra_cmd))
                        self._execute(extra_cmd, silent=(not verbose))


        if success:
            self._log.info('All system dependencies are installed')
        else:
            self._log.error('Some system dependencies were not installed')
        return success

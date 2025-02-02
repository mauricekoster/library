###############################################################
# launch Python programs with reusable launcher scheme classes;
# assumes 'python' is on your system path (but see Launcher.py)
###############################################################

import sys, os
pyfile = (sys.platform[:3] == 'win' and 'python.exe') or 'python'

def findPythonExe( ):
    try:                                                # get path to python
        pypath = sys.executable                         # use sys in newer pys
    except AttributeError:                              # else env or search
        try:
            pypath = os.environ['PP3E_PYTHON_FILE']     # run by launcher?
        except KeyError:                                # if so configs env
            from Launcher import which, guessLocation
            pypath = (which(pyfile, trace=False) or
                      guessLocation(pyfile, trace=False))
    return pypath

class LaunchMode:
    def __init__(self, label, command):
        self.what  = label
        self.where = command
    def __call__(self):                   # on call, ex: button press callback
        self.announce(self.what)
        self.run(self.where)                # subclasses must define run( )
    def announce(self, text):               # subclasses may redefine announce( )
        print text                          # methods instead of if/elif logic
    def run(self, cmdline):
        assert 0, 'run must be defined'

class System(LaunchMode):                          # run shell commands
    def run(self, cmdline):                        # caveat: blocks caller
        pypath = findPythonExe( )
        os.system('%s %s' % (pypath, cmdline))     # unless '&' added on Linux

class Popen(LaunchMode):                           # caveat: blocks caller
    def run(self, cmdline):                        # since pipe closed too soon
        pypath = findPythonExe( )
        os.popen(pypath + ' ' + cmdline)

class Fork(LaunchMode):
    def run(self, cmdline):
        assert hasattr(os, 'fork')                  # for Unix systems today
        cmdline = cmdline.split( )                  # convert string to list
        if os.fork( ) == 0:                         # start new child process
            pypath = findPythonExe( )
            os.execvp(pypath, [pyfile] + cmdline)  # run new program in child

class Start(LaunchMode):
    def run(self, cmdline):                        # for Windows only
        assert sys.platform[:3] == 'win'           # runs independent of caller
        os.startfile(cmdline)                      # uses Windows associations

class StartArgs(LaunchMode):
    def run(self, cmdline):                        # for Windows only
        assert sys.platform[:3] == 'win'           # args may require real start
        os.system('start ' + cmdline)              # creates pop-up window

class Spawn(LaunchMode):                           # for Windows or Unix
    def run(self, cmdline):                        # run python in new process
        pypath = findPythonExe( )                       # runs independent of caller
        os.spawnv(os.P_DETACH, pypath, (pyfile, cmdline)) # P_NOWAIT: dos box

class Top_level(LaunchMode):
    def run(self, cmdline):                           # new window, same process
        assert 0, 'Sorry - mode not yet implemented'  # tbd: need GUI class info

if sys.platform[:3] == 'win':
    PortableLauncher = Spawn            # pick best launcher for platform
else:                                   # need to tweak this code elsewhere
    PortableLauncher = Fork

class QuietPortableLauncher(PortableLauncher):
    def announce(self, text):
        pass

def selftest( ):
    myfile  = 'launchmodes.py'
    program = 'Gui/TextEditor/textEditor.py ' + myfile        # assume in cwd
    raw_input('default mode...')
    launcher = PortableLauncher('PyEdit', program)
    launcher( )                                                # no block

    raw_input('system mode...')
    System('PyEdit', program)( )                               # blocks

    raw_input('popen mode...')
    Popen('PyEdit', program)( )                                # blocks

    if sys.platform[:3] == 'win':
        raw_input('DOS start mode...')                        # no block
        StartArgs('PyEdit', os.path.normpath(program))( )

if __name__ == '__main__': selftest( )


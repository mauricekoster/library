''' Opvragen van de gebruiker settings directory '''
import os
import sys

class NoUserDir(Exception): pass

from os.path import expanduser
homedir = expanduser("~")
if homedir[-1] in r'\/':
    homedir = homedir[:-1]

settingsdir = os.path.join(  homedir , '.config' )

if sys.platform == 'linux2':
    if 'XDG_CONFIG_HOME' in os.environ:
        settingsdir = os.environ['XDG_CONFIG_HOME']

if not os.path.exists( settingsdir ):
    os.makedirs( settingsdir )

def SettingsDir(application=None):
    if application:
        d = os.path.join(settingsdir, application)
        if not os.path.exists( d ):
            os.makedirs( d )
        return d
    else:
        return settingsdir

if __name__ == '__main__':
    print 'Settings dir: %s' % SettingsDir('test')

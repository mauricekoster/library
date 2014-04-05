''' Opvragen van de gebruiker settings directory '''
import os
import sys

class NoUserDir(Exception): pass

try:
    homedir = os.environ['HOME']
except:
    homedir = ''

if not homedir:
    try:
        homedrive = os.environ['HOMESHARE']
    except:
        homedir = ''

if not homedir:
    try:
        homedrive = os.path.join(os.environ['HOMEDRIVE'], os.environ['HOMEPATH'])
    except:
        homedir = ''

if not homedir:
    import shellfolders
    homedir = shellfolders.MyDocuments()

if not homedir:
    raise NoUserDir

if homedir[-1] in r'\/':
    homedir = homedir[:-1]

settingsdir = os.path.join(  homedir , '.settings' )
if not os.path.exists( settingsdir ):
    os.makedirs( settingsdir )

def SettingsDir():
    return settingsdir

if __name__ == '__main__':
    print 'Settings dir: %s' % settingsdir


''' Opvragen van de gebruiker settings directory '''
import os
import sys

class NoUserDir(Exception): pass

import shellfolders
homedir = shellfolders.MyAppData()

if homedir[-1] in r'\/':
    homedir = homedir[:-1]

settingsdir = os.path.join(  homedir , '.settings' )
if not os.path.exists( settingsdir ):
    os.makedirs( settingsdir )

def SettingsDir():
    return settingsdir

if __name__ == '__main__':
    print 'Settings dir: %s' % settingsdir

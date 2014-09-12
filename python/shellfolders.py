import os
import registry

__common_shellfolders = registry.readValues( 'HKLM', r'Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders')

__personal_shellfolders = registry.readValues( 'HKCU', r'Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders')

def CommonAppData():
    return __common_shellfolders['Common AppData']

def MyDocuments():
    return __personal_shellfolders['Personal']

def MyTemp():
    return os.environ['TEMP']

def MyDesktop():
    return __personal_shellfolders['Desktop']

def MyAppData():
    return __personal_shellfolders['AppData']

def MyLocalAppData():
    return __personal_shellfolders['Local AppData']

if __name__ == '__main__':
    print "My Documents: %s" % MyDocuments()
    print "My AppData: %s" % MyAppData()
    print "My Temp: %s" % MyTemp()
    print "My Desktop: %s" % MyDesktop()

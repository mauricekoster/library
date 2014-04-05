from _winreg import *
mapping = { "HKLM":HKEY_LOCAL_MACHINE, "HKCU":HKEY_CURRENT_USER, "HKU":HKEY_USERS }

def readSubKeys(hkey, regPath):
    if not pathExists(hkey, regPath):
        return -1
    reg = OpenKey(mapping[hkey], regPath)
    subKeys = []
    noOfSubkeys = QueryInfoKey(reg)[0]
    for i in range(0, noOfSubkeys):
        subKeys.append(EnumKey(reg, i))
    CloseKey(reg)
    return subKeys

def readValues(hkey, regPath):
    if not pathExists(hkey, regPath):
        return -1
    reg = OpenKey(mapping[hkey], regPath)
    values = {}
    noOfValues = QueryInfoKey(reg)[1]
    for i in range(0, noOfValues):
        values[EnumValue(reg, i)[0]] = EnumValue(reg, i)[1]
    CloseKey(reg)
    return values

def pathExists(hkey, regPath):
    try:
        reg = OpenKey(mapping[hkey], regPath)
    except WindowsError:
        return False
    CloseKey(reg)
    return True

if __name__ == '__main__':
    v = readValues( 'HKCU', r'Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders')
    print "My Documents: %s" % v['Personal'] 


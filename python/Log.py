
LOG_SHEET = 0x1		#sheet (ignored)
LOG_FILE = 0x2		#file
LOG_DIRECT = 0x4	#console
LOG_DEBUGVIEW = 0x8		#outputdebug

_logmode = 0
_loglevel = 0

LOG_ERROR = 4
LOG_WARNING = 3
LOG_INFO = 2
LOG_DEBUG = 1

_loglevel_map = {
	'ERROR': LOG_ERROR,
	'WARNING': LOG_WARNING,
	'INFO': LOG_INFO,
	'DEBUG': LOG_DEBUG
	}
	
import sys
if sys.platform == 'win32':
	import win32api
	import _winreg
	
	def GetSetting( group, section, key, default=""):
		try:
			with _winreg.OpenKey(_winreg.HKEY_CURRENT_USER, 'Software\\VB and VBA Program Settings\\' + group + '\\' + section) as regkey:	
				value, type = _winreg.QueryValueEx( regkey, key )
		except:
			value = False

		if value:
			return value
		else:
			return default
			
	def SaveSetting(group, section, key, value):
		regkey = _winreg.CreateKeyEx(_winreg.HKEY_CURRENT_USER, 'Software\\VB and VBA Program Settings\\' + group + '\\' + section, 0, _winreg.KEY_SET_VALUE)	
		_winreg.SetValueEx( regkey, key, 0, _winreg.REG_SZ, str() )
		
	def outputdebug(msg):
		win32api.OutputDebugString(msg)
		
	def LogMode(mode=0):
		global _logmode
		
		if mode > 0:
			 SaveSetting( "All", "Logging", "Mode", mode )
		if _logmode != 0: return _logmode
		
		_logmode = int(GetSetting("All", "Logging", "Mode", LOG_DIRECT))
		return _logmode
		
	def LogLevel(level=0):
		global _loglevel
		
		if level:
			 SaveSetting( "All", "Logging", "Level", level )
			 _loglevel = level
			 
		if _loglevel != 0: 
			return _loglevel
		
		_loglevel = _loglevel_map[GetSetting("All", "Logging", "Level", "WARNING")]
		return _loglevel
		
		
else:
	def outputdebug(msg):
		print msg
	def LogMode(mode=0):
		_logmode = LOG_DEBUG # outputdebug
		return _logmode	


def LogError(msg):
	LogLevel()
	if _loglevel <= LOG_ERROR:
		LogMode()
		if _logmode & LOG_DIRECT: print "! " + msg
		if _logmode & LOG_DEBUGVIEW: outputdebug( "[error] " + msg )

def LogWarning(msg):
	LogLevel()
	if _loglevel <= LOG_WARNING:
		LogMode()
		if _logmode & LOG_DIRECT: print "- " + msg
		if _logmode & LOG_DEBUGVIEW: outputdebug( "[warning] " + msg )

def LogInfo(msg):
	LogLevel()
	print "..." + str(_loglevel)
	if _loglevel <= LOG_INFO:
		LogMode()
		if _logmode & LOG_DIRECT: print "  " + msg
		if _logmode & LOG_DEBUGVIEW: outputdebug( "[info] " + msg )

def LogDebug(msg):
	LogLevel()
	if _loglevel <= LOG_DEBUG:
		LogMode()
		if _logmode & LOG_DIRECT: print "> " + msg
		if _logmode & LOG_DEBUGVIEW: outputdebug( "[debug] " + msg )


if __name__ == '__main__':
	LogMode(LOG_DIRECT)
	LogLevel(LOG_DEBUG)
	LogError( 'Error' )
	LogWarning( 'Warning' )
	LogInfo( 'Info' )
	LogDebug( 'Debug' )
	       
# virtualenv wrapper
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  begin "Setting virtualenv stuff"
  export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
  export WORKON_HOME=$HOME/.virtualenvs
  export PROJECT_HOME=$HOME/MyProjects
  source /usr/local/bin/virtualenvwrapper.sh
  end
fi

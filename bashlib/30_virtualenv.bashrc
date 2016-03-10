# virtualenv wrapper
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  begin "Setting virtualenv stuff"
  export WORKON_HOME=$HOME/.virtualenvs
  export PROJECT_HOME=$HOME/MyProjects
  source /usr/local/bin/virtualenvwrapper.sh
  end
fi

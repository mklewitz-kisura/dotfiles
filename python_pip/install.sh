#!/bin/sh
#
#  this installation script automatically installs pip
#
cdir=`pwd`

#Check for pip
if test ! $(which pip)
then
  echo "  Installing `pip` for you."
  sudo easy_install pip
else
  echo "  pip already installed. Checking for updates..."
  sudo -H pip install --upgrade pip
fi

# now installing pip2
if test ! $(which pip2)
then
  echo "  Installing `pip2` for you."
  wget https://bootstrap.pypa.io/get-pip.py
  sudo python2 get-pip.py
  rm get-pip.py
else
  echo "  pip2 already installed."
fi


# Installing `requests` package
#
present=`pip list | grep requests | sed 's/^requests\ *//'`
if test ! $(echo $present)
then
	echo "   python package requests not found. Cloning git and installing it."
	mkdir -p /tmp/requests
	cd /tmp/requests
	git clone git://github.com/requests/requests.git
	cd requests
	pip install requests --user
	cd /tmp
	rm -rf requests
	cd $cdir
else
	echo "   found requests in version $present"
fi

# Installing `lxml` package
#
present=`pip list | grep lxml | sed 's/^lxml\ *//'`
if test ! $(echo $present)
then
	sudo -H pip install lxml
else
	echo "   found lxml in version $present"
fi


# Installing `tornado` package
#
present=`pip list | grep tornado | sed 's/^tornado\ *//'`
if test ! $(echo $present)
then
	sudo -H pip install tornado
else
	echo "   found tornado in version $present"
fi

# Installing `nose` package
#
present=`pip list | grep nose | sed 's/^nose\ *//'`
if test ! $(echo $present)
then
	sudo -H pip install nose
else
	echo "   found nose in version $present"
fi

function version { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }

# Installing `python-dateutil` package
#
present=`pip list | grep python-dateutil | sed 's/^python-dateutil\ *//'`
if [ $(version $present) -lt $(version "2.8.1") ]; then
	sudo -H pip install --ignore-installed python-dateutil
else
	echo "   found python-dateutil in version $present"
fi

# Installing `botocore` package
#
present=`pip list | pcregrep '^botocore ' | sed 's/^botocore\ *//'  | sed 's/\n*//'`
if test ! $(echo $present)
then
	sudo -H pip install botocore
else
	echo "   found botocore in version $present"
fi

# Installing `boto` package
#
present=`pip list | pcregrep '^boto '| sed 's/^boto\ *//'  | sed 's/\n*//'`
if test ! $(echo $present)
then
	sudo -H pip install boto
else
	echo "   found boto in version $present"
fi

# Installing `boto3` package
#
present=`pip list | pcregrep '^boto3 ' | sed 's/^boto3\ *//' | sed 's/\n*//'`
if test ! $(echo $present)
then
	sudo -H pip install boto3
else
	echo "   found boto3 in version $present"
fi

echo
echo "---------------------------------------------------"
echo "********** Upgrading all python packages **********"
sudo -H pip2 freeze — local | grep -v ‘^\-e’ | cut -d = -f 1 | xargs -n1 sudo -H pip2 install -U --user
echo " "
echo " "
echo "-----------------------------------------------------------------------------------------------------------"
echo "   Ugrade of Pyton finished. All packages should now be current. Please check any potential error messages."
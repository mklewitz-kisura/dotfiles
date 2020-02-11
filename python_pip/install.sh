#!/bin/sh
#
#  this installation script automatically installs pip
#
cdir=`pwd`

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

# Installing `docutils` package
#
present=`pip list | grep docutils | sed 's/^docutils\ *//'`
if test ! $(echo $present)
then
	sudo -H pip install docutils
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

echo "#----------------------------------------#"
echo "#     Upgrading all python packages      #"
echo "#     Keeping docutils at 0.15.2         #"
echo "#     Keeping pip from updating too      #"
echo "#----------------------------------------#"
echo " "
echo " "

pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | grep -v docutils | grep -v pip | xargs -n1 pip install -U

echo " "
echo " "
echo "#----------------------------------------#"
echo "#     Ugrade of Pyton finished.          #"
echo "#     All packages should now be         #"
echo "#     current. Please check any          #"
echo "#     potential error messages.          #"
echo "#----------------------------------------#"
echo

echo
echo "#----------------------------------------#"
echo "#   Upgrading all python packages done   #"
echo "#   Froze docutils and pip               #"
echo "#         0.15.2       19.3.1            #"
echo "#   See updatable python packages below  #"
echo "#----------------------------------------#"
echo " "
echo " "
pip list --outdated --format=columns
echo " "
echo " "

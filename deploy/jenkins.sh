#!/bin/bash

set -x

function wait_for_jenkins() 
{
	while (( 1 )); do
		echo "waiting for Jenkins to launch on port [8080] ..."
		
		netstat -antp | grep 8080
		if (( $? == 0 )); then
			break
		fi
		sleep 10
	done
	echo "Jenkins launched"
}

function install_packages ()
{
	cd /opt
	sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz"
	sudo tar -xzvf jdk-8u131-linux-x64.tar.gz
	cd jdk1.8.0_131/
	sudo alternatives --install /usr/bin/java java /opt/jdk1.8.0_131/bin/java 2
	cd ~

	yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
	yum -y install xmlstarlet
	wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

	yum install -y jenkins
	curl "https://bootstrap.pypa.io/get-pip.py" -o /tmp/get-pip.py > /var/lib/jenkins/pip.log 2>&1
	python /tmp/get-pip.py  >> /var/lib/jenkins/pip.log 2>&1
	pip install bcrypt >> /var/lib/jenkins/pip.log 2>&1
	
	systemctl enable jenkins
	systemctl restart jenkins
	sleep 10
}

function configure_jenkins_server ()
{
	# Jenkins cli
	echo "installing the Jenkins cli ..."
	cp /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar /var/lib/jenkins/jenkins-cli.jar
	
	# Getting initial password
	PASSWORD=$(cat /var/lib/jenkins/secrets/initialAdminPassword)
	sleep 10
	
	jenkins_dir="/var/lib/jenkins"
	plugins_dir="$jenkins_dir/plugins"
	
	cd $jenkins_dir
	
	# Open JNLP port
	xmlstarlet -q ed --inplace -u "/hudson/slaveAgentPort" -v 33453 config.xml
	
	cd $plugins_dir || { echo "unable to chdir to [$plugins_dir]"; exit 1; }
	
	# List of plugins that are needed to be installed 
	plugin_list="git-client git github-api github-oauth github MSBuild ssh-slaves workflow-aggregator ws-cleanup"
	
	# remove existing plugins, if any ...
	rm -rfv $plugin_list
	
	for plugin in $plugin_list; do
		echo "installing plugin [$plugin] ..."
		java -jar $jenkins_dir/jenkins-cli.jar -s http://127.0.0.1:8080/ -auth admin:$PASSWORD install-plugin $plugin
	done
	
	# Restart jenkins after installing plugins
	java -jar $jenkins_dir/jenkins-cli.jar -s http://127.0.0.1:8080 -auth admin:$PASSWORD safe-restart
}

function install_docker ()
{
	yum update -y
	sleep 10
	# Setting up Docker
    amazon-linux-extras install docker
	usermod -a -G docker ec2-user
	# Just to be safe removing previously available java if present
	yum remove -y java
	sleep 20
	yum install -y python2-pip jq unzip vim tree biosdevname nc bind-utils at screen tmux  git java-1.8.0-openjdk nc gcc-c++ make 
	
	systemctl enable docker
	systemctl enable atd
	systemctl enable --now docker
	sudo chmod 666 /var/run/docker.sock
	
	yum clean all
	rm -rf /var/cache/yum/
}

function install_ansible ()
{
	rpm -i epel-release-latest-7.noarch.rpm
	yum update -y 
	yum install ansible -y
}

function install_nginx() 
{
  yum install -y epel-release
  yum update -y
  yum install -y nginx
  systemctl enable nginx
  systemctl start nginx
}

### script starts here ###
install_packages
wait_for_jenkins
configure_jenkins_server
install_docker
install_ansible
install_nginx

echo "Done"
exit 

#!/bin/sh
#
# this installation script automatically installs vagrant additions 
# that are needed for the provisioning of the development vagrant box
#
command -v vagrant && vagrant plugin install vagrant-hostmanager
command -v vagrant && vagrant plugin install vagrant-disksize
command -v vagrant && vagrant plugin install vagrant-bindfs

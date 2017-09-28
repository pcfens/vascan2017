#!/bin/bash
#
# vagrant pre-puppet provisoning script.
# Runs before puppet (See the Vagrantfile):
#  runs apt-get update (otherwise pkgs can't get installed)
#  installs ruby-dev (pre-req for r10k)
#  installs r10k via gem
#  runs r10k to install puppet modules
#  creates /tmp/pre-puppet.ran file, so another provision won't bother running this script
#
PROGNAME=pre-puppet.sh
RANFILE=/tmp/pre-puppet.ran
echo ""
#
if [ -f ${RANFILE} ]; then
  echo "${PROGNAME} shell provisioner already ran, skipping it this time"
  echo "if you want it to run:"
  echo "vagrant ssh -c \"rm ${RANFILE}\""
  echo "vagrant provision"
  exit 0
fi
#
date > ${RANFILE}
#
echo -e "\n${PROGNAME} finished\n"
exit 0

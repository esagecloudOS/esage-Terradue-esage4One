#!/bin/sh 

# -------------------------------------------------------------------------- #
# Copyright 2013, Terradue S.r.l.                                            #
#                                                                            #
# Licensed under the Apache License, Version 2.0 (the "License"); you may    #
# not use this file except in compliance with the License. You may obtain    #
# a copy of the License at                                                   #
#                                                                            #
# http://www.apache.org/licenses/LICENSE-2.0                                 #
#                                                                            #
# Unless required by applicable law or agreed to in writing, software        #
# distributed under the License is distributed on an "AS IS" BASIS,          #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   #
# See the License for the specific language governing permissions and        #
# limitations under the License.                                             #
#--------------------------------------------------------------------------- #

# Update environment variables for Opennebula process
grep 'JAVA_HOME=' /etc/one/vmm_exec/vmm_execrc > /dev/null 2>&1

if [ $? -ne 0 ]; then
	echo 'JAVA_HOME=${JAVA_HOME}' >> /etc/one/vmm_exec/vmm_execrc
fi

grep 'JCLOUDS_LABS_CLI_PATH=' /etc/one/vmm_exec/vmm_execrc > /dev/null 2>&1

if [ $? -ne 0 ]; then
	echo 'JCLOUDS_LABS_CLI_PATH=${JCLOUDS_LABS_CLI_PATH}' >> /etc/one/vmm_exec/vmm_execrc
fi

grep 'JCLOUDS_LABS_CONTEXT_PATH=' /etc/one/vmm_exec/vmm_execrc > /dev/null 2>&1

if [ $? -ne 0 ]; then
	echo 'JCLOUDS_LABS_CONTEXT_PATH=${JCLOUDS_LABS_CONTEXT_PATH}' >> /etc/one/vmm_exec/vmm_execrc
fi

one stop
one start
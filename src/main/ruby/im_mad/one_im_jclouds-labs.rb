#!/usr/bin/env ruby

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

ONE_LOCATION=ENV["ONE_LOCATION"]

if !ONE_LOCATION
    RUBY_LIB_LOCATION="/usr/lib/one/ruby"
else
    RUBY_LIB_LOCATION=ONE_LOCATION+"/lib/ruby"
end

$: << RUBY_LIB_LOCATION

require 'pp'
require 'OpenNebulaDriver'

# The JClouds Information Manager Driver
class JCloudsLabsInformationManagerDriver < OpenNebulaDriver
    # Init the driver, and compute the predefined maximum capacity for this
    # JCloudsLabs cloud
    def initialize()
        super('',
            :concurrency => 1,
            :threaded => false
        )

        register_action(:MONITOR, method("action_monitor"))

        # Total memory in byte
        totalmemory = 1024 * 1024 * ENV["MAX_MEMORY_IN_GB"].to_i
        
        # Total CPU in shares
        totalcpu = 100 * ENV["MAX_CPU"].to_i

        @info="HYPERVISOR=jclouds\nTOTALMEMORY=#{totalmemory}\n"<<
              "TOTALCPU=#{totalcpu}\nCPUSPEED=1000\nFREEMEMORY=#{totalmemory}"<<
              "\nFREECPU=#{totalcpu}\n"
    end

    # The monitor action, just print the capacity info and hostname
    def action_monitor(num, host, not_used)
        info   = "HOSTNAME=\"#{host}\"\n#{@info}"
        info64 = Base64::encode64(info).strip.delete("\n")
        send_message("MONITOR", RESULT[:success], num, info64)
    end
end

# The JCloudsLabs Information Driver main program
im = JCloudsLabsInformationManagerDriver.new
im.start_driver

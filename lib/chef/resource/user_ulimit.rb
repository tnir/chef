#
# Copyright:: Copyright (c) Chef Software Inc.
# Copyright:: 2012, Brightcove, Inc
#
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require_relative "../resource"

class Chef
  class Resource
    class UserUlimit < Chef::Resource

      provides :user_ulimit, target_mode: true
      target_mode support: :full

      description "Use the **user_ulimit** resource to create individual ulimit files that are installed into the `/etc/security/limits.d/` directory."
      introduced "16.0"
      examples <<~DOC
      **Set filehandle limit for the tomcat user**:

      ```ruby
      user_ulimit 'tomcat' do
        filehandle_limit 8192
      end
      ```

      **Specify a username that differs from the name given to the resource block**:

      ```ruby
      user_ulimit 'Bump filehandle limits for tomcat user' do
        username 'tomcat'
        filehandle_limit 8192
      end
      ```

      **Set filehandle limit for the tomcat user with a non-default filename**:

      ```ruby
      user_ulimit 'tomcat' do
        filehandle_limit 8192
        filename 'tomcat_filehandle_limits.conf'
      end
      ```
      DOC

      property :username, String, name_property: true
      property :as_limit, [String, Integer]
      property :as_soft_limit, [String, Integer]
      property :as_hard_limit, [String, Integer]
      property :filehandle_limit, [String, Integer]
      property :filehandle_soft_limit, [String, Integer]
      property :filehandle_hard_limit, [String, Integer]
      property :process_limit, [String, Integer]
      property :process_soft_limit, [String, Integer]
      property :process_hard_limit, [String, Integer]
      property :locks_limit, [String, Integer]
      property :memory_limit, [String, Integer]
      property :maxlogins_limit, [String, Integer]
      property :maxlogins_soft_limit, [String, Integer]
      property :maxlogins_hard_limit, [String, Integer]
      property :msgqueue_limit, [String, Integer]
      property :msgqueue_soft_limit, [String, Integer]
      property :msgqueue_hard_limit, [String, Integer]
      property :core_limit, [String, Integer]
      property :core_soft_limit, [String, Integer]
      property :core_hard_limit, [String, Integer]
      property :cpu_limit, [String, Integer]
      property :cpu_soft_limit, [String, Integer]
      property :cpu_hard_limit, [String, Integer]
      property :sigpending_limit, [String, Integer]
      property :sigpending_soft_limit, [String, Integer]
      property :sigpending_hard_limit, [String, Integer]
      property :stack_limit, [String, Integer]
      property :stack_soft_limit, [String, Integer]
      property :stack_hard_limit, [String, Integer]
      property :rss_limit, [String, Integer]
      property :rss_soft_limit, [String, Integer]
      property :rss_hard_limit, [String, Integer]
      property :rtprio_limit, [String, Integer]
      property :rtprio_soft_limit, [String, Integer]
      property :rtprio_hard_limit, [String, Integer]
      property :virt_limit, [String, Integer]
      property :filename, String,
               coerce: proc { |m| m.end_with?(".conf") ? m : m + ".conf" },
               default: lazy { |r| r.username == "*" ? "00_all_limits.conf" : "#{r.username}_limits.conf" }

      action :create, description: "Create a ulimit configuration file." do
        template "/etc/security/limits.d/#{new_resource.filename}" do
          source ::File.expand_path("support/ulimit.erb", __dir__)
          local true
          mode "0644"
          sensitive new_resource.sensitive
          variables(
            ulimit_user: new_resource.username,
            as_limit: new_resource.as_limit,
            as_soft_limit: new_resource.as_soft_limit,
            as_hard_limit: new_resource.as_hard_limit,
            filehandle_limit: new_resource.filehandle_limit,
            filehandle_soft_limit: new_resource.filehandle_soft_limit,
            filehandle_hard_limit: new_resource.filehandle_hard_limit,
            process_limit: new_resource.process_limit,
            process_soft_limit: new_resource.process_soft_limit,
            process_hard_limit: new_resource.process_hard_limit,
            locks_limit: new_resource.locks_limit,
            memory_limit: new_resource.memory_limit,
            maxlogins_limit: new_resource.maxlogins_limit,
            maxlogins_soft_limit: new_resource.maxlogins_soft_limit,
            maxlogins_hard_limit: new_resource.maxlogins_hard_limit,
            msgqueue_limit: new_resource.msgqueue_limit,
            msgqueue_soft_limit: new_resource.msgqueue_soft_limit,
            msgqueue_hard_limit: new_resource.msgqueue_hard_limit,
            core_limit: new_resource.core_limit,
            core_soft_limit: new_resource.core_soft_limit,
            core_hard_limit: new_resource.core_hard_limit,
            cpu_limit: new_resource.cpu_limit,
            cpu_soft_limit: new_resource.cpu_soft_limit,
            cpu_hard_limit: new_resource.cpu_hard_limit,
            sigpending_limit: new_resource.sigpending_limit,
            sigpending_soft_limit: new_resource.sigpending_soft_limit,
            sigpending_hard_limit: new_resource.sigpending_hard_limit,
            stack_limit: new_resource.stack_limit,
            stack_soft_limit: new_resource.stack_soft_limit,
            stack_hard_limit: new_resource.stack_hard_limit,
            rss_limit: new_resource.rss_limit,
            rss_soft_limit: new_resource.rss_soft_limit,
            rss_hard_limit: new_resource.rss_hard_limit,
            rtprio_limit: new_resource.rtprio_limit,
            rtprio_soft_limit: new_resource.rtprio_soft_limit,
            rtprio_hard_limit: new_resource.rtprio_hard_limit,
            virt_limit: new_resource.virt_limit
          )
        end
      end

      action :delete, description: "Delete an existing ulimit configuration file." do
        file "/etc/security/limits.d/#{new_resource.filename}" do
          action :delete
        end
      end
    end
  end
end

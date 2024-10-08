#
# Author:: Jan Zimmek (<jan.zimmek@web.de>)
# Copyright:: Copyright 2010-2016, Jan Zimmek
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

require_relative "package"

class Chef
  class Resource
    class PacmanPackage < Chef::Resource::Package

      provides :pacman_package, target_mode: true
      target_mode support: :full

      allowed_actions :install, :upgrade, :remove, :purge

      description "Use the **pacman_package** resource to manage packages (using pacman) on the Arch Linux platform."
    end
  end
end

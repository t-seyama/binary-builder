require 'mini_portile2'
require_relative 'base'

class CppCMSRecipe < CMakeRecipe
  def cook
    super
    FileUtils.rm_f "#{port_path}/bin/LGPLv3.txt"
    FileUtils.cp "#{tmp_path}/cppcms-#{version}/LGPLv3.txt", "#{port_path}/bin"
  end

  def configure_options
    [
      "-DDISABLE_STATIC=ON",
    ]
  end

  def url
    "http://downloads.sourceforge.net/project/cppcms/cppcms/#{version}/cppcms-#{version}.tar.bz2"
  end

  def archive_files
    ["#{port_path}/*"]
  end
end

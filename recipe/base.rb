# encoding: utf-8
require 'mini_portile2'
require 'tmpdir'
require 'fileutils'
require_relative 'determine_checksum'
require_relative '../lib/yaml_presenter'

module BaseRecipeBehavior
  def self.included(base)
    base.class_eval do
      def initialize(name, version, options = {})
        super name, version

        options.each do |key, value|
          instance_variable_set("@#{key}", value)
        end

        @files = [{
            url: url
          }.merge(DetermineChecksum.new(options).to_h)]
      end

      def configure_options
        []
      end

      def compile
        execute('compile', [make_cmd, '-j4'])
      end

      def archive_filename
        "#{name}-#{version}-linux-x64.tgz"
      end

      def archive_files
        []
      end

      def archive_path_name
        ''
      end

      private

      # NOTE: https://www.virtualbox.org/ticket/10085
      def tmp_path
        "/tmp/#{@host}/ports/#{@name}/#{@version}"
      end
    end  
  end
end

class BaseRecipe < MiniPortile
  include BaseRecipeBehavior
end

class CMakeRecipe < MiniPortileCMake
  include BaseRecipeBehavior
end

require 'spec_helper'
require 'fileutils'

describe "building a binary", :integration do
  context "when cppcms is specified" do
    before do
      run_binary_builder('cppcms', '1.0.5', '--md5=d668c201dd31fff8090380ebdc0bcc2b')
      @binary_tarball_location = File.join(Dir.pwd, 'cppcms-1.0.5-linux-x64.tgz')
    end

    after do
      FileUtils.rm(@binary_tarball_location)
    end

    it 'builds the specified libraries, binaries and headers, tars them, and places it in your current working directory' do
      expect(File).to exist(@binary_tarball_location)

      ["bin/cppcms_run", "lib/libcppcms.so", "include/cppcms/http_file.h"].each do |file|
        expect(tar_contains_file(file))
      end
    end

    it 'includes the license in the tar file.' do
      expect(tar_contains_file('bin/LGPLv3.txt')).to eq true
    end
  end
end
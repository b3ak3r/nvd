require_relative '../../test_helper'

describe Nvd::Base do
  require 'open-uri'
  require 'zlib'

  unless File.exists? 'cve.xml'
    puts "Downloading CVE data..."
    cve_download = "http://static.nvd.nist.gov/feeds/xml/cve/nvdcve-2.0-2015.xml.gz"
    open('xml.gz', 'wb') do |file|
      file << open(cve_download).read
    end
  end

  puts "Decompressing CVE archive..."
  File.open('xml.gz') do |f|
    gz = Zlib::GzipReader.new(f)
    contents = gz.read
    gz.close

    fout = File.new('cve.xml', 'w')
    fout.write(contents)
    fout.close
  end

  subject { Nvd::Base.new('cve.xml') }

  it "must load xml file" do
    subject.parse()
    true
  end
end

require 'nokogiri'

module Nvd
  class Base
    def initialize(nvdfile)
      @nvdfile = nvdfile
      @vendor_map = {}
    end

    def do_cpe(node)
      node_type = node.node_name

      if node_type == 'logical-test'
        do_logical_test(node) # recursion, bitches!
      else
        cpe = node.attr('name')

        unless cpe.nil?
          # a - applications
          # o - operating systems
          # h - hardware platforms
          cpe_regex = '^cpe\:\/([aoh]{1}):([\w\-\_\.\%]+):?([\w\-\_\.\%]*):?([\w\d\.|\-]*):?'
          cpe_match = cpe.match cpe_regex
          cpe_type, cpe_vendor, cpe_product, cpe_version = cpe_match[1..4]
          puts " vendor #{cpe_vendor}, product #{cpe_product}, version #{cpe_version}"

          {:type => cpe_type,
           :vendor => cpe_vendor,
           :product => cpe_product,
           :version => cpe_version}
        end
      end
    end

    def do_logical_test(node)
      operator = node.attr('operator')
      negate = node.attr('negate')

      cpe_nodes = node.element_children
      cpe_nodes.map { |c| do_cpe c}
    end

    def do_vulnerable_configuration(node)
      id = node.attr('id')
      logical_test = node.first_element_child
      do_logical_test(logical_test)
    end

    def parse
      nvdxml = Nokogiri::XML(open(@nvdfile))
      entries = nvdxml.xpath("//xmlns:entry")

      puts "Found ", entries.count
      entries.each do |entry|
        puts "CVE -- #{entry.attr('id')}"
        entry_children = entry.children

        entry_children.each do |entry_child|
          node_type = entry_child.node_type
          if node_type == Nokogiri::XML::Node::ELEMENT_NODE
            case entry_child.node_name
            when "vulnerable-configuration"; do_vulnerable_configuration(entry_child)
            end
          end
        end

        #vulnerable_configuration = entry.xpath('//vuln:vulnerable-configuration', :vuln => 'http://scap.nist.gov/schema/vulnerability/0.4')
        #puts "Vulnerable"
        #logical_test = vulnerable_configuration.xpath('//cpe_lang:logical-test', :cpe_lang => 'http://cpe.mitre.org/language/2.0')
        #puts "Logical"
        #do_logical_test(logical_test)
      end
    end
  end
end

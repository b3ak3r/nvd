module Nvd::Types
  class Vendor
    attr_accessor :name
    attr_accessor :products
    attr_accessor :ticker
  end

  class Product
    attr_accessor :name
    attr_accessor :vendor
  end

  class CVE
    attr_accessor :cve
  end
end

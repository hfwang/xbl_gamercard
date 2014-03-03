module XblGamercard
  # Really simple scraper DSL for objects that have a root node and want to
  # extract data from the root node's children.
  #
  # The class must have a method called `element` that returns the root node.
  #
  # The various extract methods all take a CSS selector, and optionally a hash
  # of options and a block. The block is applied to the first node (for extract
  # methods), or mapped to each node (for extract_all methods).
  #
  # Options are:
  # * <tt>:as</tt> - The name of the method that is generated.
  # * <tt>:from</tt> - The name of the method that returns the root element.
  #
  #   class XblGamercard
  #     include XblGamercard::Microscraper
  #
  #     # The following are all equivalent
  #     extract("#Gamertag", :as => "gamertag") { |e| e.text }
  #     extract_text "#Gamertag"
  #
  #     extract_int "#Gamerscore"
  #     extract_text("#Gamerscore", &:to_i)
  #     extract("#Gamerscore") { |e| e.text.to_i }
  module MicroScraper
    module ClassMethods
      # Specifies a field that is simply extracted from the document
      def extract(selector, opts=nil, &block)
        opts = opts.nil? ? {} : opts.dup
        opts[:as] ||= ClassMethods.field_name(selector)
        opts[:from] ||= :element

        define_method(opts[:as]) do
          elem = send(opts[:from]).css(selector)[0]

          next block.call(elem) if block
          next elem
        end
      end

      def extract_text(selector, opts=nil, &block)
        extract(selector, opts) do |elem|
          next block.call(elem.text) if block
          next elem.text
        end
      end

      def extract_int(selector, opts=nil, &block)
        extract_text(selector, opts) do |elem|
          next block.call(elem.to_i) if block
          next elem.to_i
        end
      end

      # Specifies a field that returns an array of matched elements
      def extract_all(selector, opts=nil, &block)
        opts = opts.nil? ? {} : opts.dup
        opts[:as] ||= ClassMethods.field_name(selector)
        opts[:from] ||= :element

        define_method(opts[:as]) do
          elems = send(opts[:from]).css(selector).to_a

          next elems.map { |e| block.call(e) } if block
          next elems
        end
      end

      def self.field_name(selector)
        word = selector.split(/[ \#\.]/).last
        word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
        word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
        word.tr!("-", "_")
        word.downcase!
        word
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end

module ActiveRecordEmbeddedDoc
  module EmbeddedDocument
    extend ActiveSupport::Concern

    include ActiveModel::Model
    include ActiveModel::Dirty

    # TODO include Macros

    included do
      class_attribute :fields, instance_accessor: false
      self.fields = Hashie::Mash.new
      attr_accessor :embedded_in
    end

    def initialize(*)
      @pending_initialization = true
      super
      @pending_initialization = false
    end

    module ClassMethods
      def field(name, type = String, opts = {})
        self.fields = fields.merge(name.to_s => Field.new({name: name.to_s, type: type}.merge(opts)))
        define_accessors(name)
        send :define_attribute_methods, name
      end

      def define_accessors(name)
        define_method "#{name}" do
          instance_variable_get "@#{name}"
        end
        define_method "#{name}=" do |val|
          current_val = instance_variable_get "@#{name}"
          unless @pending_initialization || val == current_val
            send "#{name}_will_change!"
            embedded_in.parent.send "#{embedded_in.coder.name}_will_change!" unless embedded_in.nil?
          end
          instance_variable_set "@#{name}", val
        end
      end
    end

    def as_json(options = nil)
      hash = self.class.fields.keys.inject({}) do |h, field|
        h[field] = send "#{field}"
        h
      end
      {"#{self.class.model_name.element}" => hash}
    end

    def marked_for_destruction?
      false # for now just to make ActiveRecord::Validations::AssociatedValidator work
    end

    # Returns the contents of the record as a nicely formatted string.
    def inspect
      inspection =
          self.class.fields.keys.collect { |name|
            "#{name}: #{attribute_for_inspect(name)}"
          }.join(", ")

      "#<#{self.class} #{inspection}>"
    end

    # copy from ActiveRecord::AttributeMethods
    def attribute_for_inspect(attr_name)
      value = send(attr_name)

      if value.is_a?(String) && value.length > 50
        "#{value[0..50]}...".inspect
      elsif value.is_a?(Date) || value.is_a?(Time)
        %("#{value.to_s(:db)}")
      else
        value.inspect
      end
    end

  end
end
module ActiveRecordEmbeddedDoc
  module Relations
    class Many

      class << self
        def _load(klazz, context, values)
          return nil if values.nil?
          values = [values] unless values.is_a?(Array)
          values.map do |v|
            if v.is_a?(klazz)
              v.embedded_in = context if v.embedded_in.nil?
              v
            else
              obj = klazz.new(v)
              obj.embedded_in = context
              obj
            end
          end
        end

        def _dump(klazz, value)
          value.to_json
        end

        def field_changed(old, value)
          unwrap(old) != unwrap(value)
        end

        private

        def unwrap(value)
          value.is_a?(Attribute) ? value.value : value
        end
      end

    end
  end
end

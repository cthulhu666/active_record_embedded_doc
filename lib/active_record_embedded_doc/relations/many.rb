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
              if polymorphic?(klazz)
                obj = guess_class(klazz, v.keys.first).new(v.values.first)
                obj.embedded_in = context
                obj
              else
                obj = klazz.new(v)
                obj.embedded_in = context
                obj
              end
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

        def polymorphic?(klazz)
          klazz.subclasses.present?
        end

        def guess_class(klazz, s)
          name = s.to_s.classify
          klazz.const_get(name) rescue name.constantize
        end
      end

    end
  end
end

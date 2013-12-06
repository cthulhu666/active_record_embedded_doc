module ActiveRecordEmbeddedDoc
  class Type # :nodoc:
    attr_reader :column

    def initialize(column)
      @column = column
    end

    def type_cast(value)
      value.unserialized_value(column.type_cast(value.value))
    end

    def type
      column.type
    end
  end
end
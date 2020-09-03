class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.fancy_enum (values)
    values.each do |name, enum_values|
      key = name.to_s

      define_method(key) do
        value = read_attribute(key)
        enum_values[value].to_s
      end

      define_singleton_method(key.pluralize) do
        hash = Hash.new
        enum_values.each_with_index do |value, index|
          hash[value.to_s] = index
        end

        hash
      end

      enum_values.each_with_index do | value_name, index |
        define_method("is_in_#{value_name}?") { self[key] == index }
        define_method("#{value_name}?") { self[key] == index }
        define_method("#{value_name}!") { update!({ key => index }) }
      end
    end    
  end
end

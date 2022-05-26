module Accessors

  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_name_history = "@#{name}_history"
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}_history") { instance_variable_get(var_name_history) }
      define_method("#{name}=".to_sym) { |value| 
        if instance_variable_get(var_name_history).nil?
          instance_variable_set(var_name_history, [])
        else
          instance_variable_get(var_name_history) << instance_variable_get(var_name)
        end
        instance_variable_set(var_name, value)
      }
    end
  end

  def strong_attr_accessor(name, itsclass)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=") { |value|
      if value.is_a?(itsclass)
        instance_variable_set(var_name, value)
      else 
        raise TypeError
      end
    }
  end
end   


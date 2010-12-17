module NegativeMethod
  def method_missing(negative_method_name, *args)
    method = get_original_method negative_method_name.to_s
    if (method)
      if self.respond_to?(method)
        return !self.send(method, *args)
      else
        raise "Cannot call negative method #{negative_method_name}, original method undefined"
      end
    else
      super;
    end
  end

  def get_original_method method_name
    if method_name.match(/^not_/) || method_name.match(/_not_/)
      return method_name.sub(/not_/,'')
    elsif method_name.match(/_not$/) || method_name.match(/_not?/)
      return method_name.sub(/_not/,'')
    end
  end
end

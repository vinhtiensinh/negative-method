module NegativeMethod
  alias :_method_missing :method_missing
  def method_missing(negative_method_name, *args)

    positive_method = get_positive_method_from negative_method_name.to_s
    if ( positive_method && self.respond_to?(positive_method) )
        return !self.send(positive_method, *args)
    end

    _method_missing negative_method_name, *args
  end

  def get_positive_method_from method_name
    if method_name.match(/^not_/) || method_name.match(/_not_/)
      return method_name.sub(/not_/,'')
    elsif method_name.match(/_not$/) || method_name.match(/_not?/)
      return method_name.sub(/_not/,'')
    end
  end
end

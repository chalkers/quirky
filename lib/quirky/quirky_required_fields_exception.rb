class QuirkyRequirdFieldsException < RuntimeError
  def message
    "One of the require fields are missing"
  end
end

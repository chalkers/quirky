class QuirkyNotFoundException < RuntimeError
    def message
        "Quirky couldn't find the file"
    end
end
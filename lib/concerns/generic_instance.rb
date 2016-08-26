module Concerns

  module GenericInstance

    def save
      self.class.all.push(self)
      self
    end

  end

end
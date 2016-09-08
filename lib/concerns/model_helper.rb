module Concerns
  module ModelHelper
    def self.included(base)
      base.extend(ClassMethods)
    end

    def save
      self.class.all.push(self)
      self
    end

    module ClassMethods
      def create(name)
        new(name).save
      end

      def all
        class_variable_get(:@@all)
      end

      def destroy_all
        all.clear
      end
    end
  end
end
module Assignbot
  module Core
    ASSIGNABLES = {}

    extend self

    def get_assignable(target_class)
      fail DslError, "Pass in class" unless target_class.is_a?(Class)
      target_class_name = target_class.to_s

      asclass = ASSIGNABLES[target_class_name]
      if asclass.nil?
        asclass = Assignable.new(target_class)
        ASSIGNABLES[target_class_name] = asclass
      end
      asclass
    end
  end
end

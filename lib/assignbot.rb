require 'assignbot/version'
require 'assignbot/core'

require 'assignbot/dsl/assigner_dsl'

require 'assignbot/exceptions/unmasked_error'
require 'assignbot/exceptions/dsl_error'

require 'assignbot/foundations/assignable'
require 'assignbot/foundations/assigner'
require 'assignbot/foundations/variable'

module Assignbot
  def self.included(base)
    base.extend(Assignbot::ClassDsl)
  end

  def assignbot_assign(assigner_name, hash)
    assignable = Assignbot::Core.get_assignable(self.class)
    assigner = assignable.get_assigner(assigner_name)
    fail AssigningError, "Undefined assigner scope: #{assigner_name}" unless assigner_name.to_sym == :default

    if assigner && assigner.variables.any?
      # use explicitly from defined variables
      assigner.variables.each do |_, variable_ic|
        source_variable = variable_ic.source_variable
        value = hash[source_variable.to_s] || hash[source_variable.to_sym]
        send(variable_ic.receptor, value)
      end
    else
      hash.each do |target_variable, value|
        send(:"#{target_variable}=", value)
      end
    end
  end
  private :assignbot_assign

  def assign(hash)
    assignbot_assign(:default, hash)
  end

  def method_missing(name, *args, &block)
    if name =~ /assign_/i
      assigner_name = name.to_s.gsub(/^assign_/i, '')
      assignbot_assign(assigner_name, args[0])
    else
      super(name, *args, &block)
    end
  end

  # inner class that get extended to the base class
  module ClassDsl

    module_function

    def assigner(&block)
      assigner_dsl = AssignerDsl.new(self)
      assigner_dsl.instance_eval(&block)
    end
  end
end

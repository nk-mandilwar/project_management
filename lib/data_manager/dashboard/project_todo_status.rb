module DataManager
  module Dashboard
    module ProjectTodoStatus
      def self.included(base)
        base.include InstanceMethods
        base.extend ClassMethods
      end

      module InstanceMethods
      end

      module ClassMethods
      end
    end #ProjectTodoStatus end
  end #Dashboard end
end #DataManagerEnd
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
        def project_todo_list(page, limit)
          ActiveRecord::Base.connection.execute("select res.name, GROUP_CONCAT(res.todos || 
            '$' || res.status, '#') AS todos_statuses from (SELECT projects.name as name,
              GROUP_CONCAT(todos.name, '*') as todos, todos.status as status FROM projects INNER JOIN todos 
              ON todos.project_id = projects.id GROUP BY todos.status) AS res GROUP BY 
              res.name LIMIT #{limit} OFFSET #{page}")
        end

      end #ClassMethods end
    end #ProjectTodoStatus end
  end #Dashboard end
end #DataManagerEnd
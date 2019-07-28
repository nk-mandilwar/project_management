module DataManager
  module Dashboard
    module DeveloperTodoStatus
      def self.included(base)
        base.include InstanceMethods
        base.extend ClassMethods
      end

      module InstanceMethods
      end

      module ClassMethods
        def developer_todo_list(page, limit)
          ActiveRecord::Base.connection.execute("select res.employee_id, GROUP_CONCAT(res.todos || 
            '$' || res.status, '#') AS todos_statuses from (SELECT users.employee_id as employee_id,
              GROUP_CONCAT(todos.name, '*') as todos, todos.status as status FROM users INNER JOIN todos 
              ON todos.developer_id = users.id WHERE users.role_id IN (SELECT roles.id FROM roles
              WHERE roles.internal_identifier = 'developer') GROUP BY todos.status) AS res GROUP BY 
              res.employee_id LIMIT #{limit} OFFSET #{page}")
        end

      end #ClassMethods end
    end #DeveloperTodoStatus end
  end #Dashboard end
end #DataManagerEnd
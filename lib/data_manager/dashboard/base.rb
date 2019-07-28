module DataManager
  module Dashboard
    class Utility

      include ::DataManager::Dashboard::DeveloperTodoStatus
      include ::DataManager::Dashboard::ProjectTodoStatus

      def self.developer_todo_list(page, limit)
        page = 1 if page.blank?
        super(page-1, limit)
      end

      def self.project_todo_list(params)
        super(params)
      end
    end #Utility end
  end #Dashboard end
end #DataManager end
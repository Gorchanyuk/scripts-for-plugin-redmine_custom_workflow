if saved_change_to_status_id?
  if @issue.status_id == 7 # Если статус изменился на "Аудит"
    # ID ролей для создания задач
    role_ids = [5, 9]

    # Находим всех уникальных пользователей проекта, имеющих одну из ролей
    unique_users = @issue.project.users.select do |user|
      user.member_of?(@issue.project) && (role_ids & user.roles.map(&:id)).any?
    end
    unique_users = unique_users.uniq
    # Создаем задачу для каждого уникального пользователя
    unique_users.each do |user|
      new_issue = Issue.new(
        project: @issue.project,
        subject: "Новая задача для подтверждения закрытия задачи",
        description: "Эта задача создана автоматически при изменении статуса родительской задачи #{@issue.id} на статус Аудит",
        author: user,
        assigned_to: user,
        parent_id: @issue.id, # Устанавливаем родительскую задачу
        tracker_id: Tracker.find(3), # Задаем трекер "Акцептирование"
        priority_id: @issue.priority_id, # Копируем приоритет из родительской задачи
        status_id: 3, # Устанавливаем статус "Новая"
        start_date: Time.now,
        due_date: Time.now + 1.week # Устанавливаем срок выполнения
      )
      if new_issue.save
        Rails.logger.info "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Задача успешно создана++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
      else
        Rails.logger.error "---------------------------------------------------------------------Задача не создана-----------------------------------------------------------------------------------"
      end
    end
  end
end

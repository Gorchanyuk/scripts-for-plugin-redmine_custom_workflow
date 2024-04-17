# Вычисляем длительность работы в днях, если задача только создана или изменилось одно из полей start_date или due_date
if self.new_record? || self.start_date_changed? || self.due_date_changed?
 if self.start_date && self.due_date
    duration_days = (self.due_date - self.start_date).to_i
    # Находим настраиваемое поле с ID 9 и обновляем его значение
    custom_field_value = self.custom_field_values.find { |cfv| cfv.custom_field_id == 9 }
    if custom_field_value
      custom_field_value.value = duration_days.to_s # Обновляем значение, преобразуя длительность в строку, если это необходимо
    end
 end
end

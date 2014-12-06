module ReportsHelper

  # Creates a histogram out of an array, preserving the order and creating
  # a new count for identical but separated elements
  # pattern_histogram(["a","a","b","a"])
  # =>
  # [["a",2],["b",1],["a",1]]
  def pattern_histogram(array)
    result = []
    previous = nil
    array.each do |element|
      if element != previous
        result << [element, 1]
      else
        result[-1][1] = result[-1][1] + 1
      end
      previous = element
    end
    return result
  end

  # Compute the complex headers for the disaggregate fields.
  # There will be a row for every disaggregate pivot nest
  def report_header_rows(disaggregate_fields)
    header_rows = []
    if disaggregate_fields.present?
      disaggregate_fields.first.length.times.each do |i|
        header_rows << pattern_histogram(disaggregate_fields[1..-1].map{|v|v[i]})
      end
      #Replace every empty string with the value "All"
      header_rows = header_rows.map do |row|
        row.map do |header|
          header.map do |value|
            value.present? ? value : t('report.all')
          end
        end
      end
      #Append a totals column
      if header_rows.size > 0
        header_rows.first << [t('report.total'), 1]
        header_rows[1..-1].each do |row|
          row << ["", 1]
        end
      end
    end
    unless header_rows.present?
      header_rows = [[[t('report.total'),1]]]
    end
    return header_rows
  end

  def report_sidebar_value(aggregate_value)
    value = ""
    aggregate_value.reverse_each do |v|
      if v.present?
        value = v
        break
      end
    end
    return value
  end

  def report_row_type(aggregate_value)
    if aggregate_value.last.present?
      'report_row_values'
    else
      'report_row_aggregate'
    end
  end

end
require 'byebug'
class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    @boss.employees << self unless boss.nil?
  end


  def bonus(multiplier)
    @salary * multiplier
  end
end



class Manager < Employee
  attr_reader :employees

  def initialize(name, title, salary, boss = nil)
    @employees = []
    super
  end

  def bonus(multiplier)
    # debugger
    total = 0
    @employees.each do |employee|
      total += employee.bonus(multiplier)
      total += (employee.salary * multiplier) if employee.is_a?(Manager)
    end
    total
  end
end

ned = Manager.new("Ned", "Founder", 1000000)
darren = Manager.new('darren', 'TA manager', 78000, ned)
shawna = Employee.new('shawna', 'ta', 12000, darren)
david = Employee.new('Daive', 'TA', 10000, darren)

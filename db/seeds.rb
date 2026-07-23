teacher = User.find_or_create_by!(email: "teacher@example.com") do |u|
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role = :teacher
  u.first_name = "Anna"
  u.last_name = "Nowak"
end


courses = [
  { title: "Angielski B2", description: "Kurs dla zaawansowanych", start_date: Date.today + 2.weeks, end_date: Date.today + 3.months, capacity: 12 },
  { title: "Hiszpański A1", description: "Kurs dla początkujących", start_date: Date.today + 1.month, end_date: Date.today + 4.months, capacity: 15 },
  { title: "Joga dla początkujących", description: "Relaks i zdrowie", start_date: Date.today + 1.week, end_date: Date.today + 2.months, capacity: 8 },
  { title: "Python dla młodzieży", description: "Podstawy programowania", start_date: Date.today + 3.weeks, end_date: Date.today + 2.months, capacity: 10 }
]

courses.each do |course_attrs|
  Course.create!(course_attrs.merge(teacher: teacher, status: :published))
end
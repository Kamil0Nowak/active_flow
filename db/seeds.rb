puts "Czyszczenie bazy danych..."
Enrollment.destroy_all
Lesson.destroy_all
Course.destroy_all
User.destroy_all

puts "Tworzenie użytkowników..."

# Admin
admin = User.create!(
  first_name: "Adam",
  last_name: "Admin",
  email: "admin@activeflow.com",
  password: "password123",
  role: :admin
)

# Nauczyciele
teachers = []
2.times do |i|
  teachers << User.create!(
    first_name: "Nauczyciel",
    last_name: "#{i + 1}",
    email: "teacher#{i + 1}@activeflow.com",
    password: "password123",
    role: :teacher
  )
end

# Studenci
students = []
10.times do |i|
  students << User.create!(
    first_name: "Student",
    last_name: "#{i + 1}",
    email: "student#{i + 1}@activeflow.com",
    password: "password123",
    role: :user
  )
end

puts "Tworzenie kursów i lekcji..."

course_titles = [
  "Podstawy Ruby on Rails",
  "Zaawansowany JavaScript",
  "UX/UI Design dla początkujących",
  "DevOps w chmurze AWS",
  "React Hooks w praktyce",
  "Bazy danych SQL i NoSQL",
  "Testowanie w RSpec",
  "Architektura Microservices"
]

course_titles.each_with_index do |title, index|
  course = Course.create!(
    title: title,
    description: "To jest obszerny opis kursu #{title}. Nauczysz się tutaj praktycznych umiejętności, które pomogą Ci w karierze zawodowej.",
    teacher: teachers.sample,
    start_date: Date.today + (index * 7).days,
    end_date: Date.today + (index * 7).days + 1.month,
    capacity: rand(20..35),
    status: index == 0 ? :draft : :published
  )

  # Tworzenie 3-5 lekcji dla każdego kursu
  rand(3..5).times do |l|
    start_time = (DateTime.now + 7.day).change(hour: 10 + l)
    course.lessons.create!(
      title: "Lekcja #{l + 1}: Wprowadzenie do #{title.split.last}",
      description: "Szczegółowe omówienie zagadnień z lekcji numer #{l + 1}.",
      start_time: start_time,
      end_time: start_time + 1.hour
    )
  end
end

puts "Tworzenie przykładowych zapisów..."

# Zapisz losowych studentów na losowe lekcje pierwszego opublikowanego kursu
published_courses = Course.published
published_courses.each do |course|
  course.lessons.each do |lesson|
    # Zapisz 2-4 losowych studentów na każdą lekcję
    students.sample(rand(2..4)).each do |student|
      Enrollment.create!(
        user: student,
        lesson: lesson,
        status: [:pending, :confirmed].sample
      )
    end
  end
end

puts "Gotowe! Podsumowanie:"
puts "- Użytkownicy: #{User.count}"
puts "- Kursy: #{Course.count}"
puts "- Lekcje: #{Lesson.count}"
puts "- Zapisy: #{Enrollment.count}"
puts ""
puts "Dane logowania dla testów:"
puts "Admin: admin@activeflow.com / password123"
puts "Teacher: teacher1@activeflow.com / password123"
puts "Student: student1@activeflow.com / password123"
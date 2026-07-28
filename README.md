## Currently I'm developing my second project which utilizes more Turbo, you can check my progress <a href="https://github.com/Kamil0Nowak/temu_twitter_rails">Here</a>

<img width="1914" height="927" alt="Home" src="https://github.com/user-attachments/assets/32d16296-f9f2-404a-8335-d6579619eb6b" />
<img width="1914" height="927" alt="Create_course" src="https://github.com/user-attachments/assets/f532fc03-b235-46ba-9451-f90477843c19" />
<img width="1919" height="989" alt="student_view" src="https://github.com/user-attachments/assets/47d5afb7-d17d-4478-bb50-501b3ee3e04d" />
<img width="1900" height="989" alt="manage_page" src="https://github.com/user-attachments/assets/1ea561b7-5229-4472-a125-6a3664cd069a" />
<img width="1905" height="989" alt="edit_view" src="https://github.com/user-attachments/assets/289b7fc5-0948-4bf8-8dcc-b345cce74092" />
<img width="1913" height="990" alt="Teacher_course_page" src="https://github.com/user-attachments/assets/0dad4d57-f4cd-4446-82ef-7a17738c2010" />

# Active Flow - Course Management System

Active Flow is a modern web application built with Ruby on Rails 8, designed to manage educational courses and lessons. It features a robust enrollment system, role-based access control, and a responsive UI powered by Hotwire and Tailwind CSS.

## Key Features

-   **User Authentication**: Secure sign-up and login system using `Devise`.
-   **Role-Based Access Control (RBAC)**: Different permissions for `Students`, `Teachers`, and `Admins` powered by `Pundit`.
-   **Course & Lesson Management**: Full CRUD for courses and nested lessons.
-   **Enrollment System**: Students can enroll in specific lessons with capacity limits and status tracking (pending/confirmed).
-   **Advanced Search & Filtering**: Easy course discovery using `Ransack`.
-   **Modern Frontend**: Fast, SPA-like user experience using `Hotwire (Turbo)` and `Stimulus`.
-   **Responsive Design**: Built with `Tailwind CSS` and `DaisyUI` for a polished look.

## Tech Stack

-   **Backend**: Ruby 4.x, Rails 8.x
-   **Database**: SQLite (Simplicitly)
-   **Authentication**: Devise
-   **Authorization**: Pundit
-   **Frontend**: Hotwire (Turbo & Stimulus), Tailwind CSS, DaisyUI
-   **Pagination**: Kaminari
-   **Search**: Ransack

## Installation & Setup

Follow these steps to get the project running locally:

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/kamil0nowak/active_flow.git
    cd active_flow
    ```

2.  **Install dependencies:**
    ```bash
    bundle install
    yarn install
    ```

3.  **Setup the database:**
    ```bash
    rails db:setup
    ```

4.  **Start the development server:**
    ```bash
    bin/dev
    ```
    Go to `http://localhost:3000` to see the app in action.

##   User Roles

-   **Admin**: Full control over all courses, lessons, and user enrollments.
-   **Teacher**: Can create and manage their own courses and lessons. Can confirm or reject student enrollments.
-   **Student**: Can browse published courses and enroll in lessons (within capacity limits).

##  Future Roadmap

-   [ ] **Service Objects**: Moving business logic for enrollments to dedicated services.
-   [ ] **Automated Testing**: Implementing RSpec for models, services, and system flows.
-   [ ] **Real-time Updates**: Using Turbo Streams to update course capacity in real-time.
-   [ ] **Background Jobs**: Asynchronous email notifications for enrollment status changes.

---
Developed as a portfolio project. Feel free to ask a question or request a feature.

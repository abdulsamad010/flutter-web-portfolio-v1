import 'package:flutter/material.dart';
import 'package:portfolio/models/project_model.dart';


// =============================================================
// COLORS
// =============================================================

// Background gradient colors used in the portfolio.
Color kGradient1 = Colors.purple;
Color kGradient2 = Colors.pinkAccent;


// =============================================================
// PROFILE IMAGE
// =============================================================

String imagePath = "assets/images/abdul_samad.jpeg";


// =============================================================
// PERSONAL INFORMATION
// =============================================================

String name = "Abdul Samad";


// =============================================================
// PROFESSIONAL PROFILE LINKS
// =============================================================

// LinkedIn username.
String username = "abdulsamad010";

// LinkedIn profile URL.
String linkedInUrl =
    "https://www.linkedin.com/in/abdulsamad010/";


// =============================================================
// RESUME
// =============================================================

// Resume hosted on Google Drive.
String cvLink =
    "https://drive.google.com/file/d/1SMjEGVuiRPGjZ21Uuweqye90X8RRXp1x/view?usp=sharing";


// =============================================================
// CONTACT INFORMATION
// =============================================================

String contactEmail = "abdulsamadabbasi010@gmail.com";

String location = "Islamabad, Pakistan";


// =============================================================
// PROFESSIONAL INFORMATION DISPLAY VALUES
// =============================================================

// Text shown in Professional Information card.
String linkedInDisplay = "linkedin.com/in/abdulsamad010";

String emailDisplay = contactEmail;


// =============================================================
// ABOUT / EXPERIENCE
// =============================================================

String aboutWorkExperience = '''
Through academic projects and independent learning, I have gained practical experience in Flutter development, Firebase integration, Python programming, TensorFlow Lite, REST APIs, SQLite, and software development fundamentals.

My Final Year Project, SmartServeAI, is a cross-platform service marketplace developed using Flutter and Firebase. The project includes role-based functionality, real-time marketplace features, provider verification, ratings and reviews, portfolios, location-based services, and AI integration using a custom TensorFlow Lite intent recognition model.

I am currently seeking internship and entry-level software development opportunities where I can apply my technical skills, contribute to real-world projects, and continue growing as a software developer.
''';

String aboutMeSummary = '''
I am Abdul Samad, a Computer Science graduate interested in Flutter development, mobile application development, Artificial Intelligence, and Machine Learning.

I enjoy developing practical software solutions, working with modern technologies, and strengthening my technical skills through projects, certifications, and continuous learning.

🚀 Currently seeking internship and entry-level opportunities to gain industry experience, contribute to real-world software projects, and grow as a software developer.
''';


// =============================================================
// PROJECTS
// =============================================================

List<Project> projectList = [
  Project(
    name: "SmartServeAI",
    description:
    "Final Year Project: A cross-platform service marketplace developed with Flutter, Firebase, Cloudinary, TensorFlow Lite, and NLP-based AI assistance, featuring role-based functionality, service discovery, provider verification, ratings, portfolios, and location-based services.",
    link: "",
  ),

  Project(
    name: "AI Face Emotion Detection System",
    description:
    "A deep learning-based facial emotion recognition system developed to detect seven human emotions using Python, OpenCV, image preprocessing, model training, and evaluation techniques.",
    link: "",
  ),

  Project(
    name: "Image Compression System",
    description:
    "A MATLAB-based image processing project implementing image compression, image optimization, and noise reduction techniques.",
    link: "",
  ),

  Project(
    name: "Hospital Management System",
    description:
    "A Java-based desktop application developed for managing patient records, diagnosis information, and hospital billing operations.",
    link: "",
  ),

  Project(
    name: "Hospital Database Management System",
    description:
    "A relational database project focused on hospital data management, database implementation, ERD modeling, and SRS documentation using SQL Server.",
    link: "",
  ),

  Project(
    name: "Imtiaz Supermarket Billing System",
    description:
    "A C++-based supermarket billing and inventory management system featuring product management, shopping cart functionality, invoice generation, quantity handling, and pricing calculations.",
    link: "",
  ),

  Project(
    name: "Phone Book App",
    description:
    "A command-line Phone Book application developed in Python with functionality to add, view, edit, and delete contacts using file handling for persistent data storage.",
    link: "https://lnkd.in/gj92NHDf",
  ),

  Project(
    name: "Personal Portfolio Website",
    description:
    "A responsive developer portfolio built with Flutter Web to showcase my projects, technical skills, certifications, achievements, and professional profile.",
    link: "",
  ),
];
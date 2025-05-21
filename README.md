# 📊 Job Data – Operation Analytics - SQL Case Study with MySQL


This project analyzes operational job data from a content review system using SQL in MySQL Workbench. It focuses on evaluating job review throughput, user engagement patterns, and content language distribution, while also validating data integrity through duplication checks.

---

## 🧰 Tools & Technologies

- **Database**: MySQL 8.0
- **Interface**: MySQL Workbench
- **Language**: SQL

---

## 🗂️ Dataset Overview

The dataset consists of content moderation events with the following structure:

| Column Name  | Description                               |
|--------------|-------------------------------------------|
| `ds`         | Date of the job event                     |
| `job_id`     | Unique identifier for each job            |
| `actor_id`   | Unique identifier for each reviewer       |
| `event`      | Type of action: `decision`, `skip`, `transfer` |
| `language`   | Language of the content reviewed          |
| `time_spent` | Time (in seconds) spent reviewing the job |
| `org`        | Reviewer’s organization                   |

---

## 🎯 Project Objectives

1. **Hourly job review trend analysis** for November 2020
2. **Throughput analysis** using 7-day rolling averages
3. **Language distribution** among reviewed jobs
4. **Duplicate record detection** for data quality assurance

---

# 🍔 QuickBite Food Delivery Business Intelligence Platform

An end-to-end Business Intelligence and Analytics project designed to analyze food delivery operations, revenue performance, customer behavior, restaurant performance, discounts, complaints and delivery efficiency.

The project follows a structured data pipeline from raw order history through data cleaning, SQL-based transformation and validation to an interactive Power BI dashboard.

---

## 📌 Project Overview

QuickBite is a fictional food delivery business operating across restaurants and customers.

The objective of this project is to transform raw food delivery order data into actionable business insights that can help stakeholders understand:

- Revenue and sales performance
- Restaurant performance
- Customer behavior
- Customer complaints
- Order patterns
- Discount impact
- Delivery efficiency
- Kitchen preparation performance
- Cancellation patterns
- Peak-hour operational performance

The final solution provides a five-page Power BI dashboard supported by SQL-based data preparation and validation.

---

## 🎯 Business Objectives

The project focuses on answering key business questions:

1. How is revenue changing over time?
2. Which restaurants generate the highest revenue?
3. Which meal periods generate the most orders and revenue?
4. How effective are discounts in driving revenue?
5. Which restaurants receive the most customer complaints?
6. How does kitchen preparation time vary across restaurants?
7. How does peak-hour demand affect operational performance?
8. What are the major cancellation reasons?
9. How does delivery distance relate to operational performance?
10. Which restaurants require operational attention?

---

## 🏗️ Solution Architecture

```text
                Raw Food Delivery Dataset
                         │
                         ▼
                  Excel / CSV Data
                         │
                         ▼
              MySQL - Raw Layer
              order_history_raw
                         │
                         ▼
                Data Cleaning &
                 Transformation
                         │
                         ▼
             MySQL - Silver Layer
            order_history_clean
                         │
                         ▼
              Business SQL Queries
                    / Gold Layer
                         │
                         ▼
                    CSV Export
                         │
                         ▼
                   Power BI
                         │
                         ▼
             Interactive Dashboard
                         │
                         ▼
             Business Insights
             & Recommendations

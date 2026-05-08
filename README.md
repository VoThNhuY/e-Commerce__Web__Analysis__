# 🧸 Maven Fuzzy Factory eCommerce - Web Analysis
This project analyzes 3 years of operational data (2012-2015) for an e-commerce retailer.

The goal is to analyze website performance, marketing channel efficiency, and product sales growth to provide data-driven recommendations for the CEO
## 📂 Data Source
- The dataset is provided by Maven Analytics. Download the dataset here: [Maven Fuzzy Factory](https://drive.google.com/drive/folders/1DqTIKgIP646OIwg8jVKAFXoptxF0kGDc?hl=vi)
- The database contains six related tables with eCommerce data about:
  - Website Activity
  - Products
  - Orders

 ## 📝 Project Structure
- `sql_code`: [maven_fuzzy_analysis](https://github.com/VoThNhuY/e-Commerce__Web__Analysis__/blob/main/maven_fuzzy_analysis%20.sql)
- `images`: [screenshots_of_query_results_and_dashboard](https://github.com/VoThNhuY/e-Commerce__Web__Analysis__/tree/main/images)
- `dashboard`: [maven_fuzzy_dashboard](https://github.com/VoThNhuY/e-Commerce__Web__Analysis__/blob/main/maven_fuzzy_dashboard.pbix)

## 📑Project Workflow
#### Data Processing
- Cleaned and queried MSSQL databases (472,000+ sessions) using SQL.
#### Analytical Framework
- Developed a 7-step Conversion Funnel to identify user drop-off points.
- Segmented traffic by Device Type (Desktop/Mobile) and Marketing Source (UTM).
- Calculated Financial KPIs: Gross Revenue, Margin, Refund Rates, and YoY Growth.
#### Visualization
- Built interactive dashboards in Power BI to communicate insights to stakeholders.

## 🔍 Key Business Insights
<img width="1306" height="740" alt="dashboard_sessions" src="https://github.com/user-attachments/assets/411dbbff-b2ae-486f-ad88-8a0bbb830bb9" />

### Marketing & Traffic Performance
- **Gsearch** is the most important channel. It brings the highest number of visitors to our website.
- **Desktop sessions** were very high in 2014 **(0.43M)**. But in 2015, this number started to decline slightly.
- We should not only focus on Gsearch. We need to try other channels, such as **Social Media** or **Bsearch**, to attract more customers.

### Conversion Funnel Analysis
- **Issue**: Many people (45%) leave the website right after the Homepage. They do not go to the Product Page. Maybe the Homepage is slow or the information is not interesting enough to keep them.
- **Action**: We need to make the Homepage better and faster. This will help more people stay and buy our products.

### Financials & Product Mix
<img width="1310" height="751" alt="dashboard_product" src="https://github.com/user-attachments/assets/9991be6f-a0f5-4a23-a785-35f366961b63" />

- **Flagship Product**: "The Original Mr. Fuzzy" accounts for 72.95% of total revenue ($1.35M).
- **Profitability**: Maintained a strong 61.02% Margin
- **Quality Control**: Despite high in sales, "Mr. Fuzzy" has the highest absolute refund volume (68.1K), requiring a quality audit.

## 🛠 Technical Skills Demonstrated
1. **Database:** MSSQL
2. **Tool:** Azure Data Studio, Power BI (for Visualization)
3. **SQL Techniques:** Advanced Joins, CTEs (Common Table Expressions), Aggregate Functions
4. **Data Visualization**: Power BI, Dashboard Design
5. **Business Intelligence**: Funnel Analysis, Product Segmentation.

## 🚀 Summary Insights
1. **Optimize Mobile Experience**: Since Desktop accounts for 86% of revenue despite Mobile having significant traffic, there is a huge opportunity to increase CVR on mobile devices.
2. **Improve Homepage Retention**: Address the 45% drop-off identified in the funnel analysis through UI/UX improvements.
3. **Product Diversification**: Expand marketing for newer products like "The Forever Love Bear" to reduce reliance on the flagship product.

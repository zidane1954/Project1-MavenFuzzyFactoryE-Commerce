# Sales, Product & Marketing Performance Dashboard: Maven Fuzzy Factory

## 1. Project Overview

I worked on an e-commerce analytics project for Maven Fuzzy Factory, an online store that sells plush toys. The goal was to understand sales performance, product profitability, and marketing effectiveness using three years of data, from March 2012 to March 2015.

Over that period, the store recorded 472,871 website sessions, 32,313 orders, and about US$1.94 million in revenue, with a gross profit margin of 62.7%. I used MySQL to process and analyze the data, then built two interactive Power BI dashboards: **Sales & Product Performance** and **Marketing & Website Performance**.

The analysis surfaced several important business opportunities, from profit dependence on a single product to a conversion gap between desktop and mobile users. I also identified the stage of the customer journey where the most visitors leave the website before completing a purchase.

## 2. Background & Business Problem

Maven Fuzzy Factory saw significant traffic growth, from 1,879 sessions per month in March 2012 to nearly 30,000 sessions in December 2014. As it grew, the company also expanded its product range, from a single starting product, Mr. Fuzzy, to four products with different sales characteristics.

This growth raised one main question for me: **have the increase in traffic and the addition of new products translated into optimal sales and marketing performance?**

To answer it, I identified several areas to analyze. On the sales side, I wanted to know which products contribute the most profit and which ones have refund problems. On the marketing side, I wanted to evaluate how well each channel and visitor segment turns traffic into conversions. I also wanted to understand which stage of the customer journey loses the most visitors, and when website traffic peaks.

This matters because a high number of visitors doesn't always mean successful sales. According to the analysis, only about 6.83% of website sessions end in a purchase. With this much traffic, even a relatively small improvement in conversion can have a meaningful impact on orders and revenue.

Based on these questions, I built dashboards that bring together sales indicators, product profitability, visitor behavior, and marketing performance, so business patterns are easier to understand and can support data-driven decisions.

## 3. Project Objectives & Analytical Questions

After identifying the challenges Maven Fuzzy Factory faces, I wanted to dig deeper into the factors that influence business performance, from each product's contribution to profit to how effectively marketing drives purchases. I didn't want to look only at overall sales figures. I wanted to understand the patterns behind the numbers so I could find more specific opportunities for improvement.

To do that, I set five main questions to guide the analysis.

- First, which products contribute the most profit, and which ones have the highest refund rates?
- Second, which marketing channels are the most effective traffic sources for generating purchases?
- Third, where in the journey from landing page to checkout do the most visitors leave the website?
- Fourth, what do traffic and sales patterns look like by hour, day, and month, and when is activity highest?
- Finally, how likely are customers to buy again and to buy more than one item?

Through these five questions, I aimed to build a more complete picture of sales performance, marketing effectiveness, and customer experience. I then presented the results through two interactive Power BI dashboards, so key information is easier to understand, business patterns can be explored through different filters, and improvement opportunities can be identified as a basis for data-driven decisions.

## 4. Data Overview & Understanding

To answer the analytical questions I had set, the next step was to understand the available data and decide what information could be used to evaluate Maven Fuzzy Factory's business performance. I used the public Maven Fuzzy Factory dataset from [Maven Analytics](https://mavenanalytics.io/data-playground/toy-store-e-commerce-database), which covers March 19, 2012 to March 19, 2015, along with its *data dictionary* as a reference for the table structure and the definition of each variable.

The dataset consists of six CSV tables that complement each other. The `website_sessions` table holds 472,871 rows of visitor session data, while `website_pageviews` records 1,188,124 page view events. To analyze transactions, I used the `orders` table with 32,313 rows and `order_items` with 40,025 rows. Refund information is in the `order_item_refunds` table with 1,731 rows, and the `products` table contains the four products offered during the observation period.

I then identified the variables relevant to each part of the analysis. To understand traffic sources and marketing effectiveness, I used campaign and UTM content information, device type, repeat visit status, and `http_referer` from the website sessions table. To trace the visitor journey, I used the URLs of the pages visited, from the landing page and product pages to the cart, shipping, billing, and order confirmation pages. For sales and profitability, I used price, *cost of goods sold* (COGS), item status, the number of items per order, and refund data.

Beyond the variables already in the data, I also prepared several derived variables to support the analysis. These include profit (calculated as price minus COGS), visit sequence, total visits per user, a classification of new versus returning customers, and *conversion funnel* stages. These variables help turn raw data into information that is more relevant for evaluating product profitability, customer behavior, and the effectiveness of the visitor journey toward a purchase.

Although the dataset provides enough information to answer most of the analytical questions, there are a few limitations to keep in mind. The dataset doesn't include advertising costs, so *Return on Ad Spend* (ROAS) can't be calculated directly. Visitor demographics aren't available either, so the analysis can't describe customers by age, gender, or other demographic background. In addition, the 2015 data only runs through March 19, so year-over-year comparisons need to take the difference in period coverage into account.

By understanding the structure, characteristics, and limitations of the data from the start, I could choose a suitable processing approach and make sure the analysis stays within the limits of what the dataset actually supports.

## 5. Methodology & Tools

After understanding the structure and characteristics of the dataset, I moved on to build a workflow that connects raw data to information that is relevant for business decisions. I used MySQL 8.0 to import, check, and analyze the data, then Power BI to prepare the data I needed, visualize the results, and present the findings as interactive dashboards.

### Data Preparation & Exploratory Data Analysis with MySQL

I started by importing the six CSV files into MySQL using `LOAD DATA INFILE`, defining the table structure, *primary keys*, and appropriate data types along the way. Once the data was in place, I ran data quality checks, looking for duplicates and missing values to understand the condition of the data before going further.

Next, I used SQL to run *exploratory data analysis* (EDA) and dig into patterns related to sales, product profitability, customer behavior, and marketing effectiveness. In this process I used `JOIN` to combine information from several tables, Common Table Expressions (CTEs) to structure queries more clearly, *window functions* for calculations based on ordering or groups of data, and `CASE WHEN` to build classifications based on specific conditions.

This stage set the groundwork for understanding each product's contribution, identifying purchase and refund patterns, evaluating traffic sources, and tracing the visitor journey from the first page to a purchase.

### Data Transformation & Dashboard Development with Power BI

After the initial analysis in SQL, I moved on to processing and visualizing the data in Power BI. At this stage, I used Power Query to handle empty UTM values in the session data by filling them in from the user's first visit, so traffic source attribution could be analyzed more consistently.

I then built two connected dashboard pages: **Sales & Product Performance** and **Marketing & Website Performance**. The first dashboard focuses on sales performance, product profitability, purchase behavior, and refunds. The second focuses on marketing conversion, performance by device, the visitor journey through the *conversion funnel*, and traffic patterns over time.

To support data exploration, I used DAX for metric calculations and built slicers for year and product name. I also added navigation between the Sales and Marketing pages so users can move from sales analysis to marketing analysis more easily. With this approach, the dashboard doesn't just show a performance summary. It also lets users explore the data by the period and product they want to analyze.

### KPI Definition & Analytical Approach

To give every finding a clear basis for measurement, I defined the KPIs according to the goals of the analysis. Conversion rate is the number of sessions that result in an order divided by total sessions, while *revenue per session* is total revenue divided by total sessions. I also used the average `price_usd` per order as the average order value, and calculated the returning visitor rate as the proportion of sessions with `is_repeat_session = 1`.

To evaluate product returns, I calculated the *refund rate* as the number of refunded items divided by the number of items sold. Customers who *repurchase* are defined as buyers with more than one order. For the *conversion funnel* analysis, I counted the unique sessions that reached each page, from the landing page through to the order confirmation page, to see how visitor reach changes along the purchase journey. With these definitions, the session count at each stage represents the sessions that reached that page, not the sessions that stopped exactly on it.

Overall, my methodology follows the flow **CSV → MySQL → Power BI → Insights & Recommendations**. MySQL helped me prepare and analyze the data in a structured way, while Power BI helped me turn the results into visualizations that are easier to understand. By combining the two, I connected transaction and visitor behavior data to the business questions I had set, so the final results can be used to spot improvement opportunities in sales, marketing, and customer experience.

## 6. Data Cleaning & Preparation

Before moving on to analysis and visualization, I did some *data cleaning* and *preparation* to make sure the data was consistent and reliable. At this stage, I didn't just check data quality. I also looked for inconsistencies that could affect KPI calculations and the interpretation of results.

### Data Quality Checks

I started by checking for duplicates using `ROW_NUMBER()` based on each table's key, and by identifying missing values with `IS NULL` across all relevant columns. The results showed that the `orders`, `order_items`, `order_item_refunds`, `products`, and `website_pageviews` tables had no duplicates or missing values.

To make sure the tables were consistent with each other, I also verified the transaction data by comparing price, COGS, and item counts in the `orders` and `order_items` tables. They matched completely. I also confirmed that no item was recorded as sold before its product launch date, no refund occurred before the purchase, and no refund amount exceeded the purchase price. These checks gave me enough confidence that the transaction and refund data were consistent enough to use in the analysis.

### Handling Missing UTM Values

The main challenge I found was in the `utm_source`, `utm_campaign`, `utm_content`, and `http_referer` columns of the `website_sessions` table. In the early stage, I looked into the pattern of empty values to understand whether the problem was random or related to the order of a user's visits. I found that empty UTM values appeared on both first visits and later visits from the same user. This became the basis for handling the data differently depending on visit order, because each situation has different implications for identifying traffic sources.

Before making any changes, I copied the `website_sessions` table into `website_sessions_bersih` as a safeguard, so the original data would stay available for checking or recovery. In that copy, I converted the text `'NULL'` into real `NULL` values so missing values could be recognized and handled properly. After that, I decided to delete first-visit rows that had neither UTM information nor an `http_referer`, because the visitor's source on those sessions couldn't be identified from the available information. In this analysis, I treated that data as insufficient for determining traffic sources, while the original table stays in place as a backup.

### UTM Transformation in Power Query

For second, third, and later visits with empty UTM values, I used the **Fill Down** feature in Power Query in Power BI. This approach is based on the pattern I found: traffic source information from a user's first visit can be used as a reference to fill in their later visits. That way, empty UTM values on repeat visits can be filled in using information from the previous visit, in the right data order.

This process helped me keep traffic source information for repeat visits without having to delete every session with empty UTM values. It also reminded me that handling missing data should take context into account, rather than just deleting every row with an empty value. By handling first visits and repeat visits separately, I could apply a different approach to each, based on the information available.

Through this process, I learned that *data cleaning* isn't just about fixing formats or removing empty values. It's also about understanding the patterns in the data before deciding what to do. Keeping a backup, checking visit order, and using Fill Down show how important it is to protect data integrity while making sure the information used in the analysis has a clear basis.

### Preparing Data for Analysis

Once the checks and transformations were done, I prepared additional variables to support the analysis of visitor behavior and business performance. I marked each user's visit sequence and calculated total visits per user to tell new customers apart from returning ones. I also prepared the product, refund, and *conversion funnel* stage data so it could be used to evaluate product profitability, returns, and the visitor journey from landing page to purchase.

Throughout, I aimed to keep the data intact while making sure it fit the needs of the analysis. Cross-table consistency checks, careful handling of UTM values, and the preparation of analytical variables became the foundation for the KPI calculations and for building the Sales and Marketing dashboards in Power BI.

## 7. Exploratory Data Analysis (EDA)

After finishing data cleaning and preparation, I started the *Exploratory Data Analysis* (EDA) to understand sales patterns, product contributions, customer behavior, and the effectiveness of marketing at Maven Fuzzy Factory. At this stage, I didn't just look at overall business performance. I also compared different segments to find factors that could influence sales results and the visitor experience.

### Sales & Product Performance

I began on the sales side, looking at how revenue, profit, and each product's contribution developed. Over the observation period, Maven Fuzzy Factory generated total revenue of **US$1,938,510** and profit of **US$1,216,140**, with an average order value of **US$59.99** (or US$61.16 per buyer). In terms of growth, revenue rose from about US$129 thousand in 2012 to US$393 thousand in 2013, then reached US$1.08 million in 2014. I also found a seasonal pattern, with the highest sales activity in November and December.

Next, I compared the sales and profit contributions of the four products. The Original Mr. Fuzzy had the largest sales volume at 24,226 units, followed by The Forever Love Bear with 5,796 units, The Hudson River Mini Bear with 5,018 units, and The Birthday Sugar Panda with 4,985 units. In terms of profit, though, there's a clear dependence on one product: Mr. Fuzzy contributes **60.8% of total profit**, while Love Bear contributes 17.9%, Sugar Panda 12.9%, and Hudson Mini Bear 8.5%. Interestingly, even though their profit contribution is smaller, Sugar Panda and Hudson Mini Bear have margins of 68.5% and 68.4%, higher than Mr. Fuzzy's 61.0%.

I then looked at refunds to see whether sales quality differs between products. Sugar Panda has the highest refund rate at 6.04%, followed by Mr. Fuzzy at 5.11%, Love Bear at 2.23%, and Hudson Mini Bear at 1.28%. Overall, the refund value reached US$85,339, or about 4.4% of revenue, with a median refund time of around nine days after purchase. This suggests that products with strong sales contributions and good margins still need to be evaluated for returns.

To understand how customers buy, I also analyzed the composition of items in each order. 76.1% of orders contain just one item, while the other 23.9% contain two. Hudson River Mini Bear is the most frequent add-on, appearing in 4,437 of the 7,712 orders with two items. This suggests that Hudson Mini Bear plays a fairly strong role as an *add-on* product rather than as a main product in the shopping cart.

Beyond purchase patterns within a single transaction, I also looked at repurchase behavior. Of 31,696 buyers, only 591 (about 1.86%) bought again. A total of 565 customers made two purchases, and 26 made three. This shows that most buyers made only one transaction during the observation period, which leaves room to evaluate retention strategies and encourage repeat purchases.

### Website & Marketing Performance

After understanding sales and product performance, I turned to website activity to see how visitors interact with the online store and how well marketing activity drives purchases. I started by analyzing the *conversion funnel* based on the number of unique sessions that reached each page, from the landing page through to a successfully placed order.

The results show that 100% of sessions start at the landing page, then 55.2% reach the product page, 44.5% reach the product detail page, 20.1% reach the cart, 13.6% reach the shipping page, 11.0% reach the billing page, and finally only 6.83% result in an order. The biggest drop is between the product detail page and the cart, since only 45.2% of sessions that reach the product detail page continue to the cart. I also found drops from the landing page to the product page and from billing to the order. This pattern helps me pinpoint the stages of the visitor journey that need more attention, especially when visitors start considering a product and move forward with the purchase.

Next, I compared website performance by device type. Out of about 473 thousand sessions, desktop accounts for about 327 thousand sessions with a conversion rate of **8.50%**, while mobile records about 146 thousand sessions with a conversion rate of only **3.09%**. This shows that desktop visitors are far more likely to complete a purchase than mobile visitors, which makes the mobile user experience a worthwhile area to look into further.

I also analyzed the effectiveness of marketing channels based on traffic volume and conversion rate. Google non-brand search (`gsearch non-brand`) is the largest traffic source with 282,706 sessions, about 59.8% of total traffic, and a conversion rate of 6.66%. Brand search channels convert better, at 8.86% for `bsearch brand` and 7.53% for `gsearch brand`. On the other hand, Socialbook pilot produced a conversion rate of just 1.08%. This comparison shows that the amount of traffic a channel generates doesn't always line up with its ability to generate purchases.

To understand visitor activity patterns, I analyzed the distribution of traffic over time. Website activity is highest around 10:00 to 16:00, and the quietest period is around 03:00. By day, traffic on Saturday and Sunday is only about half of weekday traffic. The conversion rate on weekends is fairly similar, though, ranging from 6.6% to 7.0%. This suggests that even though visitor volume differs, visitors' tendency to buy doesn't vary much by day.

Finally, I looked at the behavior of visitors who come back to the website. Of 394,318 unique visitors, 51,270 (about 13.0%) visited more than once. By session, repeat visits account for about 16.6% of total traffic and have a conversion rate of **7.83%**, higher than the **6.64%** for new sessions. This suggests that sessions from returning visitors tend to convert better, which makes repeat visit behavior a relevant factor for understanding how to grow sales.

### Summary of EDA

This analysis gave me a picture of how Maven Fuzzy Factory's growth isn't driven only by higher traffic and sales, but also by each product's contribution, purchase behavior, the effectiveness of marketing channels, and the visitor experience on the website. The most interesting patterns were the profit dependence on Mr. Fuzzy, the high refund rate on Sugar Panda, the low repurchase rate, the conversion gap between desktop and mobile, and the large drop in visitors before they reach the shopping cart. These findings became the basis for the business insights and more focused recommendations in the next stage.

## 8. Insights & Key Findings

### Sales & Product Insights

#### 1. Profit dependence on a single product is a business risk.

On the product side, I found that The Original Mr. Fuzzy is still the main contributor to the business, accounting for about 60.8% of total profit. In other words, most of the company's profit depends on how one product performs. This could become a risk if demand drops, quality problems come up, or Mr. Fuzzy runs into stock availability issues.

On the other hand, the products launched later, such as Birthday Sugar Panda and Hudson River Mini Bear, actually have higher profit margins, around 68.5% and 68.4%, compared with Mr. Fuzzy's 61.0%. This suggests the company has an opportunity to grow the contribution of other products so profit isn't so dependent on one item. It matters because diversifying where sales come from can help keep profit stable, and it gives a basis for deciding product development priorities.

#### 2. Refunds are concentrated in two products.

The refund analysis shows that Birthday Sugar Panda has the highest refund rate at 6.04%, followed by The Original Mr. Fuzzy at 5.11%. Both are higher than The Forever Love Bear at 2.23% and Hudson River Mini Bear at 1.28%. This shows that product returns aren't spread evenly. They're concentrated in Panda and Mr. Fuzzy.

High refunds can reduce the revenue the company should be receiving, and they may point to product or order fulfillment issues that need to be looked at. The company should therefore pay closer attention to these two products by tracing the reasons for refunds, product quality, how well the description matches what customers receive, and the shipping process. This analysis matters so the company doesn't focus only on products with high sales and profit, but also watches for losses that appear after the transaction takes place.

#### 3. Hudson Mini Bear plays the role of an add-on product.

Interestingly, Hudson River Mini Bear shows a different sales pattern from the other products. It appears as the primary product in only 581 orders, but shows up as an additional item in 4,437 orders that bought more than one product. This suggests that Hudson is more often bought as a complement than as a product customers look for on its own.

This pattern gives a sense of how customers combine products when they shop. For the company, it's an opportunity to apply bundling, related product recommendations, or extra offers as customers complete a purchase. These strategies could increase the number of items per order and the transaction value without always depending on adding new customers. Understanding each product's role in the shopping cart is therefore important for choosing the right sales strategy.

#### 4. Customer retention is still a challenge for the business.

On customer behavior, I found that only 591 out of 31,696 buyers, or about 1.86%, bought again. Most customers made just one purchase, so the company still faces the challenge of keeping customers after their first transaction.

The data also shows that sessions from visitors who have been to the store before have a higher conversion rate at 7.83%, compared with 6.64% for new visitors. This suggests that visitors who already know the store are more likely to buy. That opens up opportunities to improve retention through loyalty programs, special promotions for existing customers, product recommendations, and post-purchase communication. This insight matters because keeping customers who have already bought is one way to drive repeat transactions, strengthen customer relationships, and reduce dependence on bringing in new visitors.

### Marketing & Website Insights

#### 5. Mobile has big potential for conversion improvement.

Mobile accounts for about 31% of total website sessions, yet its conversion rate is only 3.09%. That's quite far from desktop at 8.50%. In other words, even though mobile brings in a sizable share of traffic, not many of those visitors complete a purchase.

This gap points to an opportunity to evaluate the mobile shopping experience, such as page speed, product display, ease of navigation, button size, and the checkout process. If those barriers can be identified and fixed, the company could increase the number of transactions without significantly increasing the number of sessions. This finding matters because a small improvement in mobile conversion can make a real contribution when applied to a large volume of visitors.

#### 6. The biggest barrier is when visitors move from the product detail page to the cart.

The website funnel analysis shows that one of the largest drop-offs happens between the product detail page and the shopping cart. Of all the sessions that reach the product detail page, only about 45.2% continue to the cart page. Yet visitors who reach the cart are much more likely to finish the transaction, with about 34% of sessions at that stage going on to place an order.

This pattern suggests that the main challenge isn't only getting visitors to the website, but also getting them to make a decision after seeing the product details. Some aspects to evaluate include product information, photos, price, customer reviews, stock availability, and the clarity of the buy button. This finding matters because improving this stage could make the whole funnel more effective. In other words, the company could get more transactions from the traffic it already has, without always having to raise the marketing budget.

#### 7. Brand search converts best, while Socialbook pilot performs the worst.

By marketing channel, brand keyword search through Bing (bsearch brand) has the highest conversion rate at 8.86%. In contrast, the Socialbook pilot channel converts at only 1.08%. This shows that visitors who arrive through brand search are much more likely to buy than visitors from Socialbook pilot.

One possible explanation is that people searching for the brand name already have stronger awareness of, or interest in, the product. Visitors from social channels, meanwhile, may still be getting to know the product and may not have the same intent to buy. This finding can help prioritize marketing channels, for example by maintaining the performance of brand search and re-evaluating Socialbook's content strategy and audience targeting.

That said, conversion rate alone isn't enough to determine each channel's profitability, since marketing cost data isn't available. This insight is therefore useful as a basis for evaluating how effectively a channel generates transactions, not as a direct measure of return on marketing spend.

#### 8. Website traffic has fairly clear time-of-day and seasonal patterns.

The visit-time analysis shows that visitor activity is concentrated on weekdays, especially between 10:00 and 16:00. Weekend visits are relatively lower, at about half of weekday traffic. Over the course of the year, traffic and sales also rise from November through December. This suggests that customer activity isn't spread evenly, and that there are periods with noticeably higher intensity.

This information can be used to schedule marketing campaigns, time promotions, and prepare stock ahead of high-demand periods. The company could also consider adjusting operating schedules and customer support coverage for the hours with the highest traffic. This insight matters so marketing and inventory decisions are based on customer activity patterns, not just estimates or operating habits.

## 9. Recommendations & Impact

Based on the Sales, Product, Marketing, and Website analysis, I put together several recommendations that stakeholders can consider to improve Maven Fuzzy Factory's business performance. Each recommendation is aimed at the party responsible for the relevant decisions, so the findings from the dashboard can serve as a basis for evaluation and strategic planning.

### 1. Management & Decision Makers: Reduce Dependence on a Single Product

Management should consider a diversification strategy so profit contribution doesn't depend so heavily on The Original Mr. Fuzzy, which accounts for 60.8% of total profit. Other products, such as Birthday Sugar Panda and Hudson River Mini Bear, have higher profit margins and could be developed as additional sources of profit.

Management can evaluate product development strategies, set investment priorities, and keep stock balanced across products. Simulations of conversion and sales improvements can also be used when setting business targets. This step matters to reduce the risk of depending on one product and to keep the company's growth sustainable.

### 2. Marketing Team: Optimize Budget Allocation and Campaign Strategy

The marketing team is advised to evaluate each channel based on its contribution to conversions, not just the number of sessions it generates. Brand search, with the highest conversion at 8.86%, can be maintained and optimized, while Socialbook pilot's 1.08% conversion should be reviewed through an evaluation of its target audience, content, and campaign strategy.

The team can also use traffic patterns to time campaigns, especially on weekdays from 10:00 to 16:00 and during November–December. This recommendation should be paired with measurement of marketing costs, so the company can compare what it spends against the transactions and revenue it generates. That way, budget can be directed toward the channels and periods that perform better.

### 3. Product & Quality Control Team: Evaluate Product Quality and Refund Causes

The product and quality control team should give special attention to Birthday Sugar Panda and The Original Mr. Fuzzy, which have the highest refund rates at 6.04% and 5.11%, respectively. The evaluation can involve identifying the reasons for returns, checking product quality consistency, and making sure product descriptions match what customers receive.

Since refunds are typically recorded around nine days after purchase, the company can also use that window to monitor complaints and spot problems once orders have been received. Improvements here could reduce refund value while raising customer satisfaction. That matters because high sales for a product don't necessarily reflect optimal performance if they come with a high return rate.

### 4. Website & Development Team: Improve User Experience and the Purchase Funnel

The website and development team should prioritize evaluating the user experience on mobile devices, as well as the purchase process from the product detail page to the cart. Mobile's conversion rate of only 3.09%, compared with 8.50% on desktop, shows room to make shopping easier on that device.

The low rate at which visitors move from the product detail page to the cart can also be a starting point for evaluating how information, photos, prices, reviews, and the buy button are presented. The team can test design or feature changes step by step to find out which improvements work best. This recommendation matters because a better user experience can reduce barriers during the purchase process and lift conversion from the traffic that's already there.

### 5. Sales & Merchandising Team: Increase Order Value Through Cross-Selling

The sales and merchandising team can take advantage of the fact that Hudson River Mini Bear shows up more often as an add-on item than as a main product. Strategies could include offering bundles, showing complementary product recommendations on detail pages, or presenting an extra offer when customers add a main product to their cart.

This approach can help increase the number of items per order and the average order value. The team can also look at which products are most often bought together to decide which bundle combinations make sense. This recommendation matters because the company doesn't only need more transactions. It can also get more value out of every transaction it wins.

### 6. Customer Relationship Management (CRM) Team: Improve Retention and Repeat Purchases

With a repurchase rate of only 1.86%, the company needs a strategy to maintain relationships with customers after their first transaction. The CRM team can consider post-purchase emails, a loyalty program, special offers for existing customers, and product recommendations based on purchase history. These strategies can be aimed at bringing customers back to the website for their next purchase.

The company can also use different communication approaches for new customers and for those who have bought before. This recommendation matters because visitors who have been to the store before convert at a higher rate than new visitors. By building lasting customer relationships, the company has a chance to increase repeat purchases and customer lifetime value.

### 7. Operations & Supply Chain Team: Align Inventory with Demand Patterns

The operations and supply chain team should use traffic and sales patterns as one basis for inventory planning. The rise in activity in November–December means the company needs to prepare product availability before that period begins. Planning can also account for demand differences between products, so stock isn't concentrated only on the products with the highest historical sales.

In addition, the operations and marketing teams need to coordinate so promotional campaigns don't generate demand that exceeds available stock. This recommendation matters to reduce the risk of stockouts when demand rises, while also avoiding excess inventory during lower-demand periods.

### Closing Thoughts

Overall, these recommendations show that data analysis can support many business functions, from management, marketing, and website development to product management and operations. The dashboard isn't only a tool for monitoring performance. It's also a basis for identifying problems, setting priorities, and evaluating business strategy in a more measurable way.

## 10. Dashboard

The dashboard has two pages, with **Sales** and **Marketing** navigation buttons, **Year** and **Product Name** slicers, four KPI cards at the top, and four insight cards at the bottom. The design uses a navy, honey, and cream palette, with consistent product colors across all charts, a bear logo, and KPI icons.

### Sales & Product Performance
![Dashboard Sales & Product Performance](<Dashboard Sales Preview.png>)

- **KPIs:** Total Items Sold (40,025), Total Profit (US$1.216 million), Repurchase Customers (591), and Refund Rate (4.32%).
- **Charts:**
    - Total profit and total items sold by product.
    - Monthly product sales trend.
    - Items sold vs. items refunded by product.
    - Customer status (new vs. repeat) and items-per-order ratio (1 item 76.13% vs. 2 items 23.87%).
- **Insight cards:** 60.8% of profit from Mr. Fuzzy, Panda refund rate of 6.04%, Hudson as an add-on item (4,437), and retention of 1.86%.

### Marketing & Website Performance

![Dashboard Marketing & Website Performance](<Dashboard Sales Marketing.png>)

- **KPIs:** Conversion Rate, Revenue per Session, Average Order Value, and Returning Visitor Rate.
- **Charts:**
    - Marketing conversion rate by campaign content and by device type.
    - Visitor funnel through to checkout (472.87 thousand sessions down to 32.31 thousand orders, 6.83%).
    - Number of visitors by hour and by day.
    - Monthly website visitor trend vs. product sales.
- **Insight cards:** mobile lagging behind (3.09% vs. 8.50%), leakage from the product detail page to the cart (45.2%), brand search as the most effective channel (8.86% vs. 1.08% for Socialbook pilot), and peak traffic from 10:00 to 16:00 on weekdays.

**Live dashboard link:** **[Power BI Dashboard](https://ugm365-my.sharepoint.com/:u:/g/personal/muhammadzidane2004_365_ugm_ac_id/IQAEmmb09JvaQYVPob1xahM2AYeJoTUXMfrhQmMLKfjd2A4?e=yfVeh3)**

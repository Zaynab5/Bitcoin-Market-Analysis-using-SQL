-- 2. Simple price facts
SELECT 
    COUNT(*) as total_days,
    MIN(date) as first_day,
    MAX(date) as last_day,
    MIN(price) as lowest_price,
    MAX(price) as highest_price,
    ROUND(AVG(price), 2) as average_price
FROM bitcoin.prices;

-- 3. Best day (biggest gain)
SELECT date, price, change_percent 
FROM bitcoin.prices 
ORDER BY change_percent DESC 
LIMIT 1;

-- 4. Worst day (biggest loss)
SELECT date, price, change_percent 
FROM bitcoin.prices 
ORDER BY change_percent 
LIMIT 1;

-- 5. How many days were up vs down?
SELECT 
    CASE 
        WHEN change_percent > 0 THEN 'Up Day'
        WHEN change_percent < 0 THEN 'Down Day'
        ELSE 'No Change'
    END as day_type,
    COUNT(*) as number_of_days,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bitcoin.prices), 1) as percentage
FROM bitcoin.prices
GROUP BY day_type;

-- 6. Find 5 highest volume days
SELECT 
    date,
    volume,
    price,
    change_percent
FROM bitcoin.prices
ORDER BY volume DESC
LIMIT 5;

-- 7. Check next day after a down day
WITH simple_data AS (
    SELECT 
        date as bad_day,
        change_percent as bad_day_change,
        LEAD(date) OVER (ORDER BY date) as next_day,
        LEAD(change_percent) OVER (ORDER BY date) as next_day_change
    FROM bitcoin.prices
)
SELECT 
    COUNT(*) as total_down_days,
    SUM(CASE WHEN next_day_change > 0 THEN 1 ELSE 0 END) as days_that_recovered,
    ROUND(AVG(next_day_change), 2) as average_next_day_return
FROM simple_data
WHERE bad_day_change < 0;

-- 8. Which day of week is best?
SELECT 
    DAYNAME(date) as weekday,
    COUNT(*) as days_count,
    ROUND(AVG(change_percent), 3) as avg_change,
    CONCAT(ROUND(AVG(CASE WHEN change_percent > 0 THEN 1 ELSE 0 END) * 100, 1), '%') as win_rate
FROM bitcoin.prices
GROUP BY DAYNAME(date)
ORDER BY avg_change DESC;

-- 9. Where did Bitcoin trade most often?
SELECT 
    CONCAT('$', ROUND(price/1000)*1000) as price_zone,
    COUNT(*) as days_in_zone,
    CONCAT(ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bitcoin.prices), 1), '%') as percentage_time
FROM bitcoin.prices
GROUP BY CONCAT('$', ROUND(price/1000)*1000)
HAVING COUNT(*) >= 2
ORDER BY COUNT(*) DESC;

-- 10. Buy on Monday, sell on Friday strategy
SELECT 
    'Buy Monday, Sell Friday' as strategy,
    COUNT(*) as weeks_tested,
    SUM(CASE WHEN friday_price > monday_price THEN 1 ELSE 0 END) as winning_weeks,
    CONCAT(ROUND(SUM(CASE WHEN friday_price > monday_price THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1), '%') as win_rate
FROM (
    SELECT 
        MIN(CASE WHEN DAYNAME(date) = 'Monday' THEN price END) as monday_price,
        MIN(CASE WHEN DAYNAME(date) = 'Friday' THEN price END) as friday_price
    FROM bitcoin.prices
    GROUP BY YEARWEEK(date)
) weekly_data
WHERE monday_price IS NOT NULL AND friday_price IS NOT NULL;

-- 11. Everything you need in one table
SELECT 
    '📊 BITCOIN REPORT' as title,
    CONCAT(COUNT(*), ' days analyzed') as period,
    CONCAT('$', FORMAT(MIN(price), 2)) as lowest,
    CONCAT('$', FORMAT(MAX(price), 2)) as highest,
    CONCAT(ROUND((MAX(price)-MIN(price))/MIN(price)*100, 2), '%') as total_change,
    CONCAT(ROUND(AVG(change_percent), 3), '%') as avg_daily_change,
    CONCAT(ROUND(AVG(CASE WHEN change_percent > 0 THEN 1 ELSE 0 END)*100, 1), '%') as up_days,
    CONCAT(ROUND(MIN(change_percent), 2), '%') as worst_day,
    CONCAT(ROUND(MAX(change_percent), 2), '%') as best_day,
    DAYNAME(MIN(CASE WHEN change_percent = (SELECT MAX(change_percent) FROM bitcoin.prices) THEN date END)) as best_day_name
FROM bitcoin.prices;
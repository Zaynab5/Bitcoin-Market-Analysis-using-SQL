# 📊 Bitcoin Market Analysis with SQL

A comprehensive SQL project analyzing cleaned Bitcoin price data to discover market patterns, trading insights, and investment opportunities.

## 📁 Project Overview

This project analyzes **32 days of cleaned Bitcoin historical data** (Dec 2025 - Jan 2026) using SQL queries to extract meaningful trading patterns, volatility metrics, and market insights. The data was pre-cleaned in Excel for accuracy.

## 🎯 Key Features

- **Data Cleaning**: Pre-processed in Excel for data integrity
- **Comprehensive Analysis**: 11 SQL queries covering price trends, volatility, and patterns
- **Trading Insights**: Discover best/worst performing days and recovery patterns
- **Strategy Testing**: Backtest simple trading strategies with real data
- **Business Ready**: Production-quality analysis with clean data
- **Beginner Friendly**: Clear, well-commented SQL code

## 🧹 Data Cleaning Process (Done in Excel)

### **Pre-Processing Steps Applied:**
1. **Date Format Standardization** - All dates converted to YYYY-MM-DD format
2. **Missing Value Handling** - Verified no null values in critical columns
3. **Data Type Validation** - Ensured numeric columns contain only numbers
4. **Outlier Check** - Verified price data within reasonable ranges
5. **Consistency Verification** - Checked High ≥ Low, Close within daily range
6. **Volume Standardization** - Consistent 'K' notation for thousands

### **Data Quality Checks:**
- ✅ No duplicate dates
- ✅ Chronological order maintained
- ✅ Percentage changes calculated correctly
- ✅ Volume values consistent format
- ✅ All required columns present

## 📊 Clean Dataset Information

**Source**: Investing.com historical data  
**Period**: December 2025 - January 2026 (32 trading days)  
**Cleaning Tool**: Microsoft Excel  
**Final Format**: CSV with standardized structure

**Columns (After Cleaning):**
- `date` - Trading date (YYYY-MM-DD format)
- `price` - Daily closing price (USD)
- `open` - Daily opening price (USD)
- `high` - Daily highest price (USD)
- `low` - Daily lowest price (USD)
- `volume` - Trading volume (in thousands, e.g., "68.44K")
- `change_percent` - Daily percentage change

## 🛠️ Technical Skills Demonstrated

### **Excel Skills:**
- ✅ **Data Cleaning**: Format standardization, error checking
- ✅ **Data Validation**: Consistency checks, outlier detection
- ✅ **Quality Assurance**: Completeness verification
- ✅ **Pre-processing**: Preparation for SQL analysis

### **SQL Skills:**
- ✅ **Basic Queries**: SELECT, WHERE, ORDER BY, LIMIT
- ✅ **Aggregations**: COUNT, SUM, AVG, MIN, MAX
- ✅ **Grouping**: GROUP BY, HAVING
- ✅ **Advanced Functions**: CASE statements, Window Functions (LEAD)
- ✅ **Data Analysis**: Time-series, pattern recognition
- ✅ **Business Intelligence**: Insight generation from clean data

## 📈 Key Insights Discovered

### **1. Price Performance**
- **Total Range**: $87,217.70 to $93,862.20 (7.6% fluctuation)
- **Average Price**: $90,XXX
- **Trend**: [Upward/Downward/Sideways] during period

### **2. Market Behavior**
- **Positive Days**: 53% of trading days closed green
- **Average Daily Return**: +0.08%
- **Volatility**: 0.89% average daily change
- **Recovery Rate**: 60% after down days

### **3. Trading Patterns**
- **Best Day**: +3.07% on December 19, 2025
- **Worst Day**: -2.79% on January 7, 2026
- **High Volume Impact**: Days with >60K volume showed 2.1x larger moves
- **Weekly Pattern**: Monday most volatile, Thursday most consistent

### **4. Strategic Insights**
- **Buy Timing**: Optimal after significant drops
- **Risk Management**: Worst-case -2.79% single-day loss
- **Opportunity**: 53% positive days indicate bullish sentiment


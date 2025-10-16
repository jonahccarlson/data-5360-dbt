{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    o.Order_ID,
    c.Customer_ID,
    d.Date_ID,
    s.Store_ID,
    e.Employee_ID,
    Quantity,
    Quantity * Unit_Price AS Dollars_Sold,
    Unit_Price
FROM {{ source('oliver_landing', 'orderline') }} o
INNER JOIN {{ source('oliver_landing', 'orders') }} ord ON o.Order_ID = ord.Order_ID
INNER JOIN {{ source('oliver_landing', 'customer') }} c ON ord.Customer_ID = c.Customer_ID
INNER JOIN {{ ref('oliver_dim_date') }} d ON ord.Order_Date = d.Date_ID 
INNER JOIN {{ source('oliver_landing', 'store') }} s ON ord.Store_ID = s.Store_ID
INNER JOIN {{ source('oliver_landing', 'employee') }} e ON ord.Employee_ID = e.Employee_ID
view: f_lineitems {
  sql_table_name: "DATA_MART"."F_LINEITEMS" ;;

  dimension: l_availqty {
    type: number
    sql: ${TABLE}."L_AVAILQTY" ;;
  }
  dimension: l_clerk {
    type: string
    sql: ${TABLE}."L_CLERK" ;;
  }
  dimension: l_commitdatekey {
    type: number
    sql: ${TABLE}."L_COMMITDATEKEY" ;;
  }
  dimension: l_custkey {
    type: number
    sql: ${TABLE}."L_CUSTKEY" ;;
  }
  dimension: l_discount {
    type: number
    sql: ${TABLE}."L_DISCOUNT" ;;
  }
  dimension: l_extendedprice {
    type: number
    sql: ${TABLE}."L_EXTENDEDPRICE" ;;
  }
  dimension: l_linenumber {
    type: number
    sql: ${TABLE}."L_LINENUMBER" ;;
  }
  dimension: l_orderdatekey {
    type: number
    sql: ${TABLE}."L_ORDERDATEKEY" ;;
  }
  dimension: l_orderkey {
    type: number
    sql: ${TABLE}."L_ORDERKEY" ;;
  }
  dimension: l_orderpriority {
    type: string
    sql: ${TABLE}."L_ORDERPRIORITY" ;;
  }
  dimension: l_orderstatus {
    type: string
    sql: ${TABLE}."L_ORDERSTATUS" ;;
  }
  dimension: l_partkey {
    type: number
    sql: ${TABLE}."L_PARTKEY" ;;
  }
  dimension: l_quantity {
    type: number
    sql: ${TABLE}."L_QUANTITY" ;;
  }
  dimension: l_receiptdatekey {
    type: number
    sql: ${TABLE}."L_RECEIPTDATEKEY" ;;
  }
  dimension: l_returnflag {
    type: string
    sql: ${TABLE}."L_RETURNFLAG" ;;
  }
  dimension: l_shipdatekey {
    type: number
    sql: ${TABLE}."L_SHIPDATEKEY" ;;
  }
  dimension: l_shipinstruct {
    type: string
    sql: ${TABLE}."L_SHIPINSTRUCT" ;;
  }
  dimension: l_shipmode {
    type: string
    sql: ${TABLE}."L_SHIPMODE" ;;
  }
  dimension: l_shippriority {
    type: number
    sql: ${TABLE}."L_SHIPPRIORITY" ;;
  }
  dimension: l_suppkey {
    type: number
    sql: ${TABLE}."L_SUPPKEY" ;;
  }
  dimension: l_supplycost {
    type: number
    sql: ${TABLE}."L_SUPPLYCOST" ;;
  }
  dimension: l_tax {
    type: number
    sql: ${TABLE}."L_TAX" ;;
  }
  dimension: l_totalprice {
    type: number
    sql: ${TABLE}."L_TOTALPRICE" ;;
  }
  measure: total_sales_price {
    type: sum
    sql: ${l_totalprice} ;;
    value_format_name: decimal_2
    label: "Total Sales Price"
    description: "The total sales price of all items."
  }
  measure: average_sale_price {
    type: average
    sql: ${l_totalprice} ;;
    value_format_name: decimal_2
    label: "Average Sale Price"
    description: "The average sales price of items."
  }
  measure: total_sale_price_shipped_by_air {
    type: sum
    sql: ${l_totalprice} * CASE WHEN ${l_shipmode} = 'AIR' THEN 1 ELSE 0 END ;;
    value_format_name: decimal_2
    label: "Total Sales Price Shipped by Air"
    description: "The total sales price of items shipped by air."
  }
  measure: total_russia_sales {
    type: sum
    sql: ${l_totalprice} ;;
    filters: {
      field: d_customer.c_nation
      value: "RUSSIA"
    }
    value_format_name: decimal_2
    label: "Total Russia Sales"
    description: "The total sales price of items sold to customers in Russia."
  }
  measure: total_gross_revenue {
    type: sum
    sql: ${l_totalprice} ;;
    filters: {
      field: l_shipinstruct
      value: "DELIVER IN PERSON"
    }
    value_format_name: decimal_2
    label: "Total Gross Revenue"
    description: "The total gross revenue from items with 'DELIVER IN PERSON' shipping instruction."
  }
  measure: total_cost {
    type: sum
    sql: ${l_supplycost} ;;
    value_format_name: decimal_2
    label: "Total Cost"
    description: "The total supply cost of items."
  }
  measure: total_gross_margin_amount {
    sql: ${total_gross_revenue} - ${total_cost} ;;
    value_format_name: decimal_2
    label: "Total Gross Margin Amount"
    description: "The total gross margin amount calculated as total gross revenue minus total cost."
  }
  measure: gross_margin_percentage {
    sql: ${total_gross_margin_amount} / ${total_gross_revenue} ;;
    value_format_name: percent_2
    label: "Gross Margin Percentage"
    description: "The gross margin percentage calculated as the total gross margin amount divided by the total gross revenue."
  }
  measure: number_of_items_returned {
    type: sum
    sql: ${l_quantity} ;;
    filters: {
      field: l_returnflag
      value: "R"
    }
    label: "Number of Items Returned"
    description: "The total number of items that have been returned."
  }
  measure: total_number_of_items_sold {
    type: sum
    sql: ${l_quantity} ;;
    label: "Total Number of Items Sold"
    description: "The total number of items sold."
  }
  measure: item_return_value {
    sql: ${number_of_items_returned} / ${total_number_of_items_sold} ;;
    value_format_name: percent_2
    label: "Item Return Value"
    description: "The percentage of items returned calculated as the number of items returned divided by the total number of items sold."
  }
  measure: total_number_of_customers {
    type: count_distinct
    sql: d_customer.c_custkey ;;
    label: "Total Number of Customers"
    description: "The total number of distinct customers."
  }
  measure: average_spend_per_customer {
    sql: ${total_sales_price} / ${total_number_of_customers} ;;
    value_format_name: decimal_2
    label: "Average Spend per Customer"
    description: "The average spend per customer calculated as the total sales price divided by the total number of customers."
  }
  measure: count {
    type: count
  }
}

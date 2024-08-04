view: supplier_metrics {
  derived_table: {
    sql: SELECT
      l.l_suppkey AS supplier_id,
      s.s_name AS supplier_name,
      SUM(l.l_extendedprice) AS total_revenue,
      SUM(l.l_supplycost) AS total_cost,
      (SUM(l.l_extendedprice) - SUM(l.l_supplycost)) AS gross_margin_amount,
      ((SUM(l.l_extendedprice) - SUM(l.l_supplycost)) / SUM(l.l_extendedprice)) * 100 AS gross_margin_percentage
    FROM f_lineitems l
    JOIN d_supplier s ON l.l_suppkey = s.s_suppkey
    GROUP BY 1, 2 ;;
  }

  dimension: supplier_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.supplier_id ;;
  }

  dimension: supplier_name {
    type: string
    sql: ${TABLE}.supplier_name ;;
  }

  measure: total_revenue {
    type: sum
    sql: ${TABLE}.total_revenue ;;
    value_format_name: decimal_2
  }

  measure: gross_margin_amount {
    type: sum
    sql: ${TABLE}.gross_margin_amount ;;
    value_format_name: decimal_2
  }

  measure: gross_margin_percentage {
    type: number
    sql: ${TABLE}.gross_margin_percentage ;;
    value_format_name: percent_2
  }

  measure: total_revenue_percentage {
    type: number
    sql: (${total_revenue} / (SELECT SUM(total_revenue) FROM supplier_metrics)) * 100 ;;
    value_format_name: percent_2
    drill_fields: [d_supplier.s_acctbal, d_supplier.s_address, d_supplier.s_name, d_supplier.s_nation, d_supplier.s_phone, d_supplier.s_region]
  }
}

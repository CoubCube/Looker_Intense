view: d_supplier {
  sql_table_name: "DATA_MART"."D_SUPPLIER" ;;

  dimension: s_acctbal {
    type: number
    sql: ${TABLE}."S_ACCTBAL" ;;
  }
  dimension: s_address {
    type: string
    sql: ${TABLE}."S_ADDRESS" ;;
  }
  dimension: s_name {
    type: string
    sql: ${TABLE}."S_NAME" ;;
    link: {
      label: "Search Supplier on Google"
      url: "https://www.google.com/search?q={{s_name}}"
    }
  }
  dimension: s_nation {
    type: string
    sql: ${TABLE}."S_NATION" ;;
  }
  dimension: s_phone {
    type: string
    sql: ${TABLE}."S_PHONE" ;;
  }
  dimension: s_region {
    type: string
    sql: ${TABLE}."S_REGION" ;;
  }
  dimension: s_suppkey {
    type: number
    primary_key: yes
    sql: ${TABLE}."S_SUPPKEY" ;;
  }
  dimension: cohort_of_suppliers_according_to_account_balance {
    type: bin
    bins: [0, 3000, 5000, 7000]
    style: relational
    sql: ${s_acctbal} ;;
  }
  measure: count {
    type: count
    drill_fields: [s_name]
  }
}

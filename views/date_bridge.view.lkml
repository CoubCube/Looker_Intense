view: date_bridge {
  derived_table: {
    sql: SELECT DISTINCT
           l_commitdatekey,
           datekey
         FROM f_lineitems
         JOIN d_dates
         ON f_lineitems.l_commitdatekey = d_dates.datekey ;;
  }

  dimension: l_commitdatekey {
    type: number
    sql: ${TABLE}.l_commitdatekey ;;
  }

  dimension: datekey {
    type: number
    sql: ${TABLE}.datekey ;;
  }
}

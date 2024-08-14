view: d_dates {
  sql_table_name: "DATA_MART"."D_DATES" ;;

  dimension_group: date_val {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."DATE_VAL" ;;
  }
  dimension: datekey {
    type: number
    primary_key: yes
    sql: ${TABLE}."DATEKEY" ;;
  }
  dimension: day_of_week {
    type: number
    sql: ${TABLE}."DAY_OF_WEEK" ;;
  }
  dimension: dayname_of_week {
    type: string
    sql: ${TABLE}."DAYNAME_OF_WEEK" ;;
  }
  dimension: month_name {
    type: string
    sql: ${TABLE}."MONTH_NAME" ;;
  }
  dimension: month_num {
    type: number
    sql: ${TABLE}."MONTH_NUM" ;;
  }
  dimension: quarter {
    type: number
    sql: ${TABLE}."QUARTER" ;;
  }
  dimension: year {
    type: number
    sql: ${TABLE}."YEAR" ;;
  }
  dimension: day_num {
    type: number
    sql: EXTRACT(DAY FROM ${TABLE}."DATE_VAL") ;;
  }
  measure: count {
    type: count
    drill_fields: [month_name]
  }
  dimension: date_group {
    type: date
    sql:
    CASE
      WHEN {% parameter granularity %} = 'year' THEN DATE_TRUNC('YEAR', ${TABLE}.date_val)
      WHEN {% parameter granularity %} = 'quarter' THEN DATE_TRUNC('QUARTER', ${TABLE}.date_val)
      WHEN {% parameter granularity %} = 'month' THEN DATE_TRUNC('MONTH', ${TABLE}.date_val)
      ELSE DATE_TRUNC('YEAR', ${TABLE}.date_val)
    END ;;
  }
  parameter: granularity {
    type: string
    allowed_value: {
      label: "Yearly"
      value: "year"
    }
    allowed_value: {
      label: "Quarterly"
      value: "quarter"
    }
    allowed_value: {
      label: "Monthly"
      value: "month"
    }
    default_value: "year"
  }
  measure: dynamic_title {
    type: string
    sql:
    CASE
      WHEN {% parameter granularity %} = 'year' THEN 'Yearly Gross Margin Trends'
      WHEN {% parameter granularity %} = 'quarter' THEN 'Quarterly Gross Margin Trends'
      ELSE 'Monthly Gross Margin Trends'
    END ;;
  }
}

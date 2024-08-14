connection: "tpchlooker"

# Include all views and additional view files
include: "/views/**/*.view.lkml"   # This includes all view files under the /views/ directory
include: "/views/date_bridge.view.lkml"   # This includes the specific date_bridge view file
include: "/views/supplier_metrics.view.lkml" # Include the supplier metrics view file

datagroup: artem_markov_task1_default_datagroup {
  max_cache_age: "1 hour"
}

persist_with: artem_markov_task1_default_datagroup

explore: f_lineitems {
  label: "Order Items"
  join: d_supplier {
    type: left_outer
    sql_on: ${f_lineitems.l_suppkey} = ${d_supplier.s_suppkey} ;;
    relationship: many_to_one
  }

  join: d_part {
    type: left_outer
    sql_on: ${f_lineitems.l_partkey} = ${d_part.p_partkey} ;;
    relationship: many_to_one
  }

  join: d_customer {
    type: left_outer
    sql_on: ${f_lineitems.l_custkey} = ${d_customer.c_custkey} ;;
    relationship: many_to_one
  }

  join: date_bridge {
    type: left_outer
    sql_on: ${f_lineitems.l_commitdatekey} = ${date_bridge.l_commitdatekey} ;;
    relationship: many_to_one
  }

  join: d_dates {
    type: left_outer
    sql_on: ${date_bridge.datekey} = ${d_dates.datekey} ;;
    relationship: many_to_one
  }

  join: supplier_metrics {
    type: left_outer
    sql_on: ${f_lineitems.l_suppkey} = ${supplier_metrics.supplier_id} ;;
    relationship: many_to_one
  }
}

explore: optimization_test {
  label: "Optimization Test"

  join: d_supplier {
    type: left_outer
    sql_on: ${optimization_test.l_suppkey} = ${d_supplier.s_suppkey} ;;
    relationship: many_to_one
  }

  join: d_part {
    type: left_outer
    sql_on: ${optimization_test.l_partkey} = ${d_part.p_partkey} ;;
    relationship: many_to_one
  }

  join: d_customer {
    type: left_outer
    sql_on: ${optimization_test.l_custkey} = ${d_customer.c_custkey} ;;
    relationship: many_to_one
  }

  join: date_bridge {
    type: left_outer
    sql_on: ${optimization_test.l_commitdatekey} = ${date_bridge.l_commitdatekey} ;;
    relationship: many_to_one
  }

  join: d_dates {
    type: left_outer
    sql_on: ${date_bridge.datekey} = ${d_dates.datekey} ;;
    relationship: many_to_one
  }

  join: supplier_metrics {
    type: left_outer
    sql_on: ${optimization_test.l_suppkey} = ${supplier_metrics.supplier_id} ;;
    relationship: many_to_one
  }
}

# Place in `artem_markov_task1` model

explore: +optimization_test {
  aggregate_table: rollup__l_orderkey {
    query: {
      dimensions: [l_orderkey]
      measures: [number_of_items_returned, total_number_of_items_sold]
    }

    materialization: {
      datagroup_trigger: optimization_test_datagroup
    }
  }
}

datagroup: optimization_test_datagroup {
  max_cache_age: "24 hours"
  interval_trigger: "168 hours"
  sql_trigger: SELECT * FROM optimization_test ;;
}

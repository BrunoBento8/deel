{% macro generate_dynamic_columns_from_json(column_name) %}
    -- List for columns in json
    {% set columns = [] %}
    
    -- Using jsonb_object_keys function to extract keys JSONB
    {% set query %}
        SELECT DISTINCT jsonb_object_keys({{ column_name }}::jsonb) AS key
        FROM {{ this }}
    {% endset %}
    
    {% set results = run_query(query) %} -- The return is a list
    
    {% for row in results %}
        {% set key = row['key'] %}
        {% set column = column_name ~ "->>'" ~ key ~ "' AS " ~ key | lower ~ "_rate" %}
        {% do columns.append(column) %}
    {% endfor %}
    
    -- Join the columns extracted from an unique string
    {{ columns | join(', ') }}
{% endmacro %}

{% macro currency_rates(column_name) %}
    -- List for columns in json
    {% set columns = [] %}
    
    -- Using OBJECT_KEYS function to extract keys from JSON
    {% set query %}
        SELECT DISTINCT value AS key
        FROM {{ this }},
        LATERAL FLATTEN(input => OBJECT_KEYS({{ column_name }}))
    {% endset %}
    
    {% set results = run_query(query) %} -- The return is a list
   
    -- Looping through the list to create each column from the JSON column.
    {% for row in results %}
        {% set key = row['KEY'] %}
        {% if key %}
            {% set key_lower = key | lower %}
            {% set column =  column_name ~ ":" ~ key ~ " AS " ~ key_lower %}
            {% do columns.append(column) %}
        {% endif %}
    {% endfor %}

    
    -- Join the columns extracted from an unique string
    {{ columns | join(', ') }}
{% endmacro %}

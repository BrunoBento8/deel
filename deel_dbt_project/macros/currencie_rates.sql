{% macro generate_dynamic_columns_from_json(column_name) %}
    -- List for columns in json
    {% set columns = [] %}
    
    -- Using OBJECT_KEYS function to extract keys from JSON
    {% set query %}
        SELECT DISTINCT column_value AS key
        FROM {{ this }},
        LATERAL FLATTEN(input => OBJECT_KEYS({{ column_name }}))
    {% endset %}
    
    {% set results = run_query(query) %} -- The return is a list
    
    {% for row in results %}
        {% set key = row['key'] %}
        -- Aplica o filtro 'lower' na chave antes de fazer a concatenação
        {% set key_lower = key | lower %}
        -- Correção para a concatenação usando '~'
        {% set column = column_name ~ ":'" ~ key ~ "'" ~ " AS " ~ key_lower ~ "_rate" %}
        {% do columns.append(column) %}
    {% endfor %}
    
    -- Join the columns extracted from an unique string
    {{ columns | join(', ') }}
{% endmacro %}

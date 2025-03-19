{% set common_columns = [] %}

{% for col in source_columns %}
    {% if col in target_columns %}
        {% do common_columns.append(col) %}
    {% endif %}
{% endfor %}

{% do log("Common Columns: " ~ common_columns, info=True) %}

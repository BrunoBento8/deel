<!--- Columns block documentation

Pattern to write a block:

    {% docs < block_name > %}
    < Description. > 
    {% enddocs %}

Pattern to write in .yml file:

    '{{ doc( "block_name" ) }}'
--->


{% docs external_ref %}
"Unique identifier for each transaction."
{% enddocs %}

{% docs occured_at %}
"The timestamp of the transaction."
{% enddocs %}

{% docs state %}
"State of the transaction: Accepted or Declined."
{% enddocs %}

{% docs country %}
"The two-character ISO country code of the card."
{% enddocs %}

{% docs chargeback %}
"Identify if the transaction has been chargedback."
{% enddocs %}
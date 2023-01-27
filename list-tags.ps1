$mg = Get-AzManagementGroup -GroupName '296a2a1e-c1ca-475f-aaea-aaaaaaaaa'
$subscriptions = Get-AzSubscription | Where-Object { $_.TenantId -eq $mg.TenantId }

# Create an empty array to store the output data
$output = @()

# Iterate through the subscriptions, retrieve their tags, and add them to the output array
foreach ($subscription in $subscriptions) {
    $subsTags = (Get-AzSubscription -SubscriptionId $subscription.Id).Tags
    foreach ($tag in $subsTags.GetEnumerator()) {
        $subscriptionTag = [PSCustomObject]@{
            SubscriptionID = $subscription.Id
            TagKey         = $tag.Key
            TagValue       = $tag.Value
        }
        $output += $subscriptionTag
    }
}

# Format the output as a table
$output | Format-Table -AutoSize


# Export the output to a CSV file
$output | Export-Csv -Path "C:\path\to\subscription_tags.csv" -NoTypeInformation

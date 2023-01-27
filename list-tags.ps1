$mg = Get-AzManagementGroup -GroupName '296a2a1e-c1ca-475f-aaea-3d1bcf9eab8d'
$subscriptions = Get-AzSubscription | Where-Object { $_.TenantId -eq $mg.TenantId }

# Get all subscriptions
$subscriptions = Get-AzSubscription

# Create an empty array to hold the subscription tag information
$subscriptionTags = @()

foreach ($subscription in $subscriptions) {
    # Check if the subscription has tags
    if($subscription.Tags -ne $null) {
        # Iterate through each tag and add the subscription ID, tag name, and tag value to the array
        foreach ($tag in $subscription.Tags.GetEnumerator()) {
            $subscriptionTag = [PSCustomObject]@{
                SubscriptionId = $subscription.Id
                TagName = $tag.Key
                TagValue = $tag.Value
            }
            $subscriptionTags += $subscriptionTag
        }
    }else {
        $subscriptionTag = [PSCustomObject]@{
                SubscriptionId = $subscription.Id
                TagName = "null"
                TagValue = "null"
            }
            $subscriptionTags += $subscriptionTag
    }
}

# Format the array as a table and output to the console
$subscriptionTags | Format-Table

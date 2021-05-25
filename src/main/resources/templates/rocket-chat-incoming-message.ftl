<#if executionData.job.group??>
    <#assign jobName="${executionData.job.group} / ${executionData.job.name}">
<#else>
    <#assign jobName="${executionData.job.name}">
</#if>
<#assign message="RunDeck Job Notification:">
<#if trigger == "start">
    <#assign state="Started">
<#elseif trigger == "failure">
    <#assign state="Failed">
<#else>
    <#assign state="Succeeded">
</#if>

{
   "channel":"${channel}",
   "attachments":[
      {
	 "title":"RunDeck Job ${state}",
         "channel":"${channel}",
         "icon_emoji":":rundeck:",
         "fallback":"${state}: ${message}",
         "color":"${color}",
         "fields":[
            {
               "title":"Job Name",
               "value":"[${jobName}](${executionData.job.href})",
               "short":true
            },
            {
               "title":"Project",
               "value":"${executionData.project}",
               "short":true
            },
            {
               "title":"Status",
               "value":"${state}",
               "short":true
            },
            {
               "title":"Execution ID",
               "value":"[#${executionData.id}](${executionData.href})",
               "short":true
            },
            {
               "title":"Options",
               "value":"${(executionData.argstring?replace('"', '\''))!"N/A"}",
               "short":true
            },
            {
               "title":"Started By",
               "value":"${executionData.user}",
               "short":true
            }
<#if trigger == "failure">
            ,{
               "title":"Failed Nodes",
               "value":"${executionData.failedNodeListString!"- (Job itself failed)"}",
               "short":false
            }
</#if>
]
      }
   ]
}

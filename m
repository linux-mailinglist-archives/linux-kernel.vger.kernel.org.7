Return-Path: <linux-kernel+bounces-742013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 292EBB0EBEE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F405564BDC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36257276028;
	Wed, 23 Jul 2025 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U8ZZY2Ax"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A533526C3A6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255890; cv=none; b=o5AJnWIuBpmUSRNy2WBpzqkVQ3spKS5WOUfukBxkeSGkz6Jjcnq5gT+pggmWUoqjrs9MX+LA268iGKLqDElPg7UKYdm4QewJ8wSdLnsMyDVRZCUCyKU6I3k2DlFBB7JQTcQyjS9XeJttpoKbmR0icDHZ27++xzPNKd5/mlhiIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255890; c=relaxed/simple;
	bh=e++anjSF7gfE3Oxy+vlwdVOXgKDJUmfAqQ7biUNWTF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwQt6A4CW1XXEF6hWl2VBvyEMpPgtrsoUpbTrG05Xxgt/+nrlATrlPgobOca+8lIiBiu7XQfYiz7nMrIfWBwbjlxZIkaRygsmg7WxKgX4iZM1Hovbfw+nF6y+h2RQh+aLVik/pIWAhNzvploToEYkkCKKiiAkM5vxpgxQn8/l2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U8ZZY2Ax; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1bbddb30-05bb-43c4-b104-c127430b3915@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753255884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfPc46uad+wS0Sgmk8EYzFkUwXL6NtQyE0cjzekuP4U=;
	b=U8ZZY2AxrFW5+2kc49Jm/6lNs4GhNthsl70+Uo8Ea2bpAav+3fLL8fqAojhMUnOIapPvtM
	ZX3TiboJAeiZNRMiHwUFDaeLuXLYLb/3nkrFL/7nexvwKfIjRKHxIBzdwukLxR/4bPmma9
	dSiQ/cmnFZDcGibQM6MaZgWZ0n6eOLA=
Date: Wed, 23 Jul 2025 15:31:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] hung_task: add warning counter to blocked task report
To: Lance Yang <lance.yang@linux.dev>
Cc: Ye Liu <liuye@kylinos.cn>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Zi Li <zi.li@linux.dev>
References: <20250721031755.1418556-1-ye.liu@linux.dev>
 <0d15cf75-abbd-446d-86fa-49ea251f7a82@linux.dev>
 <582cf973-1290-493c-b821-f23480e75014@linux.dev>
 <83ac6ac0-a7c5-4475-8800-0beefa117164@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <83ac6ac0-a7c5-4475-8800-0beefa117164@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2025/7/21 14:19, Lance Yang 写道:
> 
> 
> On 2025/7/21 13:45, Ye Liu wrote:
>>
>>
>> On 2025/7/21 12:56, Lance Yang wrote:
>>> Hi Ye,
>>>
>>> Thanks for your patch!
>>>
>>> On 2025/7/21 11:17, Ye Liu wrote:
>>>> From: Ye Liu <liuye@kylinos.cn>
>>>>
>>>> Add a warning counter to each hung task message to make it easier
>>>> to analyze and locate issues in the logs.
>>>>
>>>> Signed-off-by: Ye Liu <liuye@kylinos.cn>
>>>> ---
>>>>    kernel/hung_task.c | 6 ++++--
>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
>>>> index 8708a1205f82..9e5f86148d47 100644
>>>> --- a/kernel/hung_task.c
>>>> +++ b/kernel/hung_task.c
>>>> @@ -58,6 +58,7 @@ EXPORT_SYMBOL_GPL(sysctl_hung_task_timeout_secs);
>>>>    static unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
>>>>      static int __read_mostly sysctl_hung_task_warnings = 10;
>>>> +static int hung_task_warning_count;
>>>>      static int __read_mostly did_panic;
>>>>    static bool hung_task_show_lock;
>>>> @@ -232,8 +233,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>>>>        if (sysctl_hung_task_warnings || hung_task_call_panic) {
>>>>            if (sysctl_hung_task_warnings > 0)
>>>>                sysctl_hung_task_warnings--;
>>>> -        pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
>>>> -               t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
>>>> +        pr_err("INFO: task %s:%d blocked for more than %ld seconds. [Warning #%d]\n",
>>>> +               t->comm, t->pid, (jiffies - t->last_switch_time) / HZ,
>>>> +               ++hung_task_warning_count);
>>>>            pr_err("      %s %s %.*s\n",
>>>>                print_tainted(), init_utsname()->release,
>>>>                (int)strcspn(init_utsname()->version, " "),
>>>
>>> A quick thought on this: we already have the hung_task_detect_count
>>> counter, which tracks the total number of hung tasks detected since
>>> boot ;)
>>>
>>> While this patch adds a counter inline with the warning message, the
>>> existing counter already provides a way to know how many hung task
>>> events have occurred.
>>>
>>> Could you elaborate on the specific benefit of printing this count
>>> directly in the log, compared to checking the global hung_task_detect_count?
>>>
>>> Also, if the goal is to give each warning a unique sequence number,
>>> I think the dmesg timestamp prefix serves the same purpose ;)
>>>
>>> Thanks,
>>> Lance
>>
>> Sorry for not noticing sysctl_hung_task_detect_count.
>> I just thought adding it directly to the warning message would make the
>> log easier to read and more intuitive than relying on timestamps.
>>
>> If accepted, I will send V2, like this:
> 
> Let's step back and considet the practical use case. when we are
> troubleshooting hung task issues in a production log, what information
> do we actually use?
> 
> Typically, we look for:
> 1) The timestamp, to correlate with other system events
> 2) The task name and PID (%s:%d)
> 3) The kernel stack trace that follows, to see where it's stuck
> 
> So, my question is: in what specific troubleshooting scenario would
> knowing the sequence number, like [#N], provide actionable information
> that the above data points do not?
> 
> Unless there's a compelling use case I'm missing, I'd prefer to keep
> the code as it is ;)

There is no specific use case—the system currently defaults to 10 printouts.
When multiple logs are present in the same window, I simply want to quickly
identify which one is the Nth instance (e.g., the 3rd out of 10). That’s all.

> Thanks,
> Lance
> 
>>
>> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
>> index 8708a1205f82..231afdb68bb2 100644
>> --- a/kernel/hung_task.c
>> +++ b/kernel/hung_task.c
>> @@ -232,8 +232,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>>          if (sysctl_hung_task_warnings || hung_task_call_panic) {
>>                  if (sysctl_hung_task_warnings > 0)
>>                          sysctl_hung_task_warnings--;
>> -               pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
>> -                      t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
>> +               pr_err("INFO: task %s:%d blocked for more than %ld seconds. [#%ld]\n",
>> +                      t->comm, t->pid, (jiffies - t->last_switch_time) / HZ,
>> +                      sysctl_hung_task_detect_count);
>>                  pr_err("      %s %s %.*s\n",
>>                          print_tainted(), init_utsname()->release,
>>                          (int)strcspn(init_utsname()->version, " "),
>>
>>
>>
>>
> 

-- 
Thanks,
Ye Liu



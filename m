Return-Path: <linux-kernel+bounces-738701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2965CB0BC13
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6547D7A2BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39671DF75A;
	Mon, 21 Jul 2025 05:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K6GySwEq"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371881B808
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753076741; cv=none; b=Eq30ksuKNp0hObvA9FA0vvf8UnDxreeCNnBT0IYHRUF69qSnGkdSWydtLqE52cl6cl1lt22D+750PjiUCtdcdmROHh4xiGXF0y7H6SNQduIjqikFMsyPL8wBaAEjWyUDHqxL5sQkqskMUjFbIk+VfW/VV89wdG806IzPb5z/y28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753076741; c=relaxed/simple;
	bh=sLMxyLcnMYIYD0GR7/8rBsIlL23NOAwbcxvefLa2rMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBxuPtQf031cjQSYgXSnuNDVpej2dUW52LK6BmNgrOveUDNZ+QrUnOQU2K0NBBsACmUQlgN0a4RETS845cVGbWhtm2M5Cv3DCEt0SNQGdrtVRy7hMsDQdjma01Lw6LQS5ZVctbLdzJaHS5Gx9W4Ukw4psfm9Bo53T5GomnSW8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K6GySwEq; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <582cf973-1290-493c-b821-f23480e75014@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753076737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v43Peb9TOW30pVEEMDHUgNR8xZiR7idm7eq6St72U58=;
	b=K6GySwEqj07wK4tfvISb4WBufil7TyZTDDU9V5vtsHjLQ2wUv/81mTq3As+af6EEtjQ3zq
	z3BMjONbFAPmamodo82piBKYPR5is3BVrD5lu4Z6z+xukNtbw9MdAk3fhJWalYeRXipK6X
	2En0pEx7IEmHra40TCET/WmnGIcRiyM=
Date: Mon, 21 Jul 2025 13:45:31 +0800
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <0d15cf75-abbd-446d-86fa-49ea251f7a82@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/21 12:56, Lance Yang wrote:
> Hi Ye,
> 
> Thanks for your patch!
> 
> On 2025/7/21 11:17, Ye Liu wrote:
>> From: Ye Liu <liuye@kylinos.cn>
>>
>> Add a warning counter to each hung task message to make it easier
>> to analyze and locate issues in the logs.
>>
>> Signed-off-by: Ye Liu <liuye@kylinos.cn>
>> ---
>>   kernel/hung_task.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
>> index 8708a1205f82..9e5f86148d47 100644
>> --- a/kernel/hung_task.c
>> +++ b/kernel/hung_task.c
>> @@ -58,6 +58,7 @@ EXPORT_SYMBOL_GPL(sysctl_hung_task_timeout_secs);
>>   static unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
>>     static int __read_mostly sysctl_hung_task_warnings = 10;
>> +static int hung_task_warning_count;
>>     static int __read_mostly did_panic;
>>   static bool hung_task_show_lock;
>> @@ -232,8 +233,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>>       if (sysctl_hung_task_warnings || hung_task_call_panic) {
>>           if (sysctl_hung_task_warnings > 0)
>>               sysctl_hung_task_warnings--;
>> -        pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
>> -               t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
>> +        pr_err("INFO: task %s:%d blocked for more than %ld seconds. [Warning #%d]\n",
>> +               t->comm, t->pid, (jiffies - t->last_switch_time) / HZ,
>> +               ++hung_task_warning_count);
>>           pr_err("      %s %s %.*s\n",
>>               print_tainted(), init_utsname()->release,
>>               (int)strcspn(init_utsname()->version, " "),
> 
> A quick thought on this: we already have the hung_task_detect_count
> counter, which tracks the total number of hung tasks detected since
> boot ;)
> 
> While this patch adds a counter inline with the warning message, the
> existing counter already provides a way to know how many hung task
> events have occurred.
> 
> Could you elaborate on the specific benefit of printing this count
> directly in the log, compared to checking the global hung_task_detect_count?
> 
> Also, if the goal is to give each warning a unique sequence number,
> I think the dmesg timestamp prefix serves the same purpose ;)
> 
> Thanks,
> Lance

Sorry for not noticing sysctl_hung_task_detect_count. 
I just thought adding it directly to the warning message would make the 
log easier to read and more intuitive than relying on timestamps.                            

If accepted, I will send V2, like this:

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 8708a1205f82..231afdb68bb2 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -232,8 +232,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
        if (sysctl_hung_task_warnings || hung_task_call_panic) {
                if (sysctl_hung_task_warnings > 0)
                        sysctl_hung_task_warnings--;
-               pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
-                      t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
+               pr_err("INFO: task %s:%d blocked for more than %ld seconds. [#%ld]\n",
+                      t->comm, t->pid, (jiffies - t->last_switch_time) / HZ,
+                      sysctl_hung_task_detect_count);
                pr_err("      %s %s %.*s\n",
                        print_tainted(), init_utsname()->release,
                        (int)strcspn(init_utsname()->version, " "),






Return-Path: <linux-kernel+bounces-835176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6B3BA6712
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B2F178D99
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FA0254AE1;
	Sun, 28 Sep 2025 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aRkXYT0R"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D05FE56A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 03:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759030163; cv=none; b=gg+dgGngVbiAnstG4SKJZjy4VWN0+wC8OgSwkKRtO2rssHi5/zJkHR/g2bkzYcheynSRWvw/3ZI6wJ4I/JOWyFzglJPM+AUFdxGo0NDGJEMyCx7Xsi7vnXgnisxxuKFm/ChpDou51Mn/fZ1O5glaHc+wXXSL/xquvCxZyCLQGUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759030163; c=relaxed/simple;
	bh=FRvaL2Wg4EyPFO/fEOEQG29vNIjx5ngsjCzgfCrtsC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUoLiTcFknt+BgYFQjZqgdCkEXv1gLbfPYZysoKA3VcWiqmm8ofVG75R2kME78IqVJqZwha7SE67oZ9zodxUKoJWybJTirWxOf9JOgoNm7SZCI3RNfWX+bJQjcRRZn8wPNiH9bZnMpV3szzDAe3NanFfpOJ5UVa7WU+eUrHmAlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aRkXYT0R; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4e49dc3f-55b9-4ce8-9c45-4973307e5501@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759030157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yn9qblu/XQyxqAgeFSH2EEU3bU1VWGtmwwNHu5zJnOs=;
	b=aRkXYT0RO2AXnL8R2SeadTCtLF8GIu5VukTu0GiZnEqToCgx3ytvAUcHFLQE+3ZGfZk863
	khVzUYxieVE9jbN4TdAIzI5pcCA9IZEUw6LfDYfCY2NaIYnQblpvxQuzTAnPUD7i79OPcv
	FyOwwp12E5Q260yUiPuqW9gL2CT3qlw=
Date: Sun, 28 Sep 2025 11:29:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdIGh1bmdfdGFzazog?=
 =?UTF-8?Q?Panic_after_fixed_number_of_hung_tasks?=
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "joel.granados@kernel.org" <joel.granados@kernel.org>,
 "feng.tang@linux.alibaba.com" <feng.tang@linux.alibaba.com>,
 "pauld@redhat.com" <pauld@redhat.com>, "kees@kernel.org" <kees@kernel.org>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "mingo@kernel.org" <mingo@kernel.org>,
 "paulmck@kernel.org" <paulmck@kernel.org>, "corbet@lwn.net"
 <corbet@lwn.net>, "mhiramat@kernel.org" <mhiramat@kernel.org>
References: <20250925060605.2659-1-lirongqing@baidu.com>
 <3ae5cbea-d320-4d28-a894-5e11e048158f@linux.dev>
 <819fbfed27cf4e57860645f9edc774a3@baidu.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <819fbfed27cf4e57860645f9edc774a3@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/28 11:19, Li,Rongqing wrote:
> 
> 
>> -----Original Message-----
>> From: Lance Yang <lance.yang@linux.dev>
>> Sent: 2025年9月27日 10:39
>> To: Li,Rongqing <lirongqing@baidu.com>
>> Cc: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; arnd@arndb.de;
>> joel.granados@kernel.org; feng.tang@linux.alibaba.com; pauld@redhat.com;
>> kees@kernel.org; rostedt@goodmis.org; pawan.kumar.gupta@linux.intel.com;
>> akpm@linux-foundation.org; dave.hansen@linux.intel.com; mingo@kernel.org;
>> paulmck@kernel.org; corbet@lwn.net; mhiramat@kernel.org
>> Subject: [外部邮件] Re: [PATCH] hung_task: Panic after fixed number of hung
>> tasks
>>
>>
>>
>> On 2025/9/25 14:06, lirongqing wrote:
>>> From: Li RongQing <lirongqing@baidu.com>
>>>
>>> Currently, when hung_task_panic is enabled, kernel will panic
>>> immediately upon detecting the first hung task. However, some hung
>>> tasks are transient and the system can recover fully, while others are
>>> unrecoverable and trigger consecutive hung task reports, and a panic is
>> expected.
>>>
>>> This commit adds a new sysctl parameter hung_task_count_to_panic to
>>> allows specifying the number of consecutive hung tasks that must be
>>> detected before triggering a kernel panic. This provides finer control
>>> for environments where transient hangs maybe happen but persistent
>>> hangs should still be fatal.
>>>
>>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
>>> ---
>>>    Documentation/admin-guide/sysctl/kernel.rst |  6 ++++++
>>>    kernel/hung_task.c                          | 14 +++++++++++++-
>>>    2 files changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/admin-guide/sysctl/kernel.rst
>>> b/Documentation/admin-guide/sysctl/kernel.rst
>>> index 8b49eab..4240e7b 100644
>>> --- a/Documentation/admin-guide/sysctl/kernel.rst
>>> +++ b/Documentation/admin-guide/sysctl/kernel.rst
>>> @@ -405,6 +405,12 @@ This file shows up if
>> ``CONFIG_DETECT_HUNG_TASK`` is enabled.
>>>    1 Panic immediately.
>>>    = =================================================
>>>
>>> +hung_task_count_to_panic
>>> +=====================
>>> +
>>> +When set to a non-zero value, after the number of consecutive hung
>>> +task occur, the kernel will triggers a panic
>>
>> Hmm... the documentation here seems a bit misleading.
>>
>> hung_task_panic=1 will always cause an immediate panic, regardless of the
>> hung_task_count_to_panic setting, right?
>>
>> Perhaps something like this would be more accurate?
>>
>> ```
>> hung_task_count_to_panic
>> ========================
>>
>> When set to a non-zero value, a kernel panic will be triggered if the number of
>> detected hung tasks reaches this value.
>>
>> Note that setting hung_task_panic=1 will still cause an immediate panic on the
>> first hung task, overriding this setting.
>> ```
>>
>>>
>>>    hung_task_check_count
>>>    =====================
>>> diff --git a/kernel/hung_task.c b/kernel/hung_task.c index
>>> 8708a12..87a6421 100644
>>> --- a/kernel/hung_task.c
>>> +++ b/kernel/hung_task.c
>>> @@ -83,6 +83,8 @@ static unsigned int __read_mostly
>> sysctl_hung_task_all_cpu_backtrace;
>>>    static unsigned int __read_mostly sysctl_hung_task_panic =
>>>    	IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
>>>
>>> +static unsigned int __read_mostly sysctl_hung_task_count_to_panic;
>>
>> Nit: while static variables are guaranteed to be zero-initialized, it's a good
>> practice and clearer for readers to initialize them explicitly.
>>
>> static unsigned int __read_mostly sysctl_hung_task_count_to_panic = 0;
>>
>>
> 
> ./scripts/checkpatch.pl reports error when initialise statics to 0, so I will keep it uninitialized
> 
> ERROR: do not initialise statics to 0
> #51: FILE: kernel/hung_task.c:86:
> +static unsigned int __read_mostly sysctl_hung_task_count_to_panic = 0;

Ah, good spot! Let’s leave it as is ;)

Cheers,
Lance

> 
> 
> thanks
> 
> -Li
> 
>> Otherwise, this patch looks good to me!
>> Acked-by: Lance Yang <lance.yang@linux.dev>
>>
>>> +
>>>    static int
>>>    hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
>>>    {
>>> @@ -219,7 +221,9 @@ static void check_hung_task(struct task_struct *t,
>>> unsigned long timeout)
>>>
>>>    	trace_sched_process_hang(t);
>>>
>>> -	if (sysctl_hung_task_panic) {
>>> +	if (sysctl_hung_task_panic ||
>>> +	    (sysctl_hung_task_count_to_panic &&
>>> +	     (sysctl_hung_task_detect_count >=
>>> +sysctl_hung_task_count_to_panic))) {
>>>    		console_verbose();
>>>    		hung_task_show_lock = true;
>>>    		hung_task_call_panic = true;
>>> @@ -388,6 +392,14 @@ static const struct ctl_table hung_task_sysctls[] = {
>>>    		.extra2		= SYSCTL_ONE,
>>>    	},
>>>    	{
>>> +		.procname	= "hung_task_count_to_panic",
>>> +		.data		= &sysctl_hung_task_count_to_panic,
>>> +		.maxlen		= sizeof(int),
>>> +		.mode		= 0644,
>>> +		.proc_handler	= proc_dointvec_minmax,
>>> +		.extra1		= SYSCTL_ZERO,
>>> +	},
>>> +	{
>>>    		.procname	= "hung_task_check_count",
>>>    		.data		= &sysctl_hung_task_check_count,
>>>    		.maxlen		= sizeof(int),
> 



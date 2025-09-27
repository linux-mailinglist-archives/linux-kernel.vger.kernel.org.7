Return-Path: <linux-kernel+bounces-834780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B95BA5820
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 04:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504E77A4D45
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 02:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205AA86337;
	Sat, 27 Sep 2025 02:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e+4GFmom"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B9F1A267
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 02:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758939536; cv=none; b=pxj3a07AhUWo0dxcVBS3SbgpMi6dUj7J87Z5uIYtFEs6ae45yCon/xos+tuFHtp1ywjoTUV6FJqOOJHpi8m5TdDp8rH/dPOX0JQzi+r8+dvwgsoe6CVxf5xRQvaNZSXJjhFT2ZDlWsNl1ZCGF1pGd6IHk+kw1Bs9Dxy1TZ6hngE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758939536; c=relaxed/simple;
	bh=ZVS1eO1Um6rqhXEtaP5wPvw3BqvNVotUvyjdq0qHJW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UF1W9pM6Ao3ox/kmiO6JgHP0c0aLgqXgwXSpA2Vfx4hMMCXESCV21+VCUxwigmmZVsyGF7Me1vP+rAZnpxQU6aTu8wyxd58SlVxNYPTlBbvgLSeNh1EpWQqN/0CR+ynxSv0qmoRYCJ9HYtMdrJk6NBy+OYtshn8xiJCsx8L9aXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e+4GFmom; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a7f06bf6-a17a-48b4-8dfa-308ad4c5c500@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758939530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqK3VAtm4+O1zznl68uNm3+z/IF4uHQnTCyJsdOOa5c=;
	b=e+4GFmomgzjaPmY4MVZrBl64t2WcvbMFwC/qk/aKYuAj/vAssORiWlT7oH2Pw60N7kBhbW
	179jQhUjAFmzZtqzZVtAPiWoLPzyAPGQtJZeJuzGDSgHEx+SHHVuGDubg5ZCLC/uY/+ADy
	cZO9u/+3sO02NGvFvobA23H6Rdet+o8=
Date: Sat, 27 Sep 2025 10:18:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] hung_task: Panic after fixed number of hung tasks
To: paulmck@kernel.org
Cc: lirongqing <lirongqing@baidu.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, arnd@arndb.de, feng.tang@linux.alibaba.com,
 joel.granados@kernel.org, kees@kernel.org, rostedt@goodmis.org,
 pauld@redhat.com, pawan.kumar.gupta@linux.intel.com, mhiramat@kernel.org,
 dave.hansen@linux.intel.com, corbet@lwn.net, akpm@linux-foundation.org,
 mingo@kernel.org
References: <20250925060605.2659-1-lirongqing@baidu.com>
 <8c4cd66c-9c3f-411a-82df-0130b78e889c@linux.dev>
 <81514e1d-4a10-4466-8a87-2d4b0927195b@paulmck-laptop>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <81514e1d-4a10-4466-8a87-2d4b0927195b@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/27 02:02, Paul E. McKenney wrote:
> On Thu, Sep 25, 2025 at 06:26:00PM +0800, Lance Yang wrote:
>>
>> Thanks for the patch!
>>
>> On 2025/9/25 14:06, lirongqing wrote:
>>> From: Li RongQing <lirongqing@baidu.com>
>>>
>>> Currently, when hung_task_panic is enabled, kernel will panic immediately
>>> upon detecting the first hung task. However, some hung tasks are transient
>>> and the system can recover fully, while others are unrecoverable and
>>> trigger consecutive hung task reports, and a panic is expected.
>>
>> The new hung_task_count_to_panic relies on an absolute count, but I
>> assume the real indicator you're trying to capture is the trend or
>> rate of increase over a time window (e.g., "panic if count increases
>> by 5 in 10 minutes").
>>
>> IMHO, this kind of time-windowed, trend-based logic seems much more
>> flexible and better suited for a userspace monitoring agent :)
>>
>> In other words, why is this the right place for this feature?
> 
> A possibly related question is "why are RCU CPU stall warnings implemented
> in the kernel instead of in userspace?"  One reason is that by the

Fair point. I was initially leaning towards the "let userspace
handle it" camp ...

> time that things get bad enough to trigger an RCU CPU stall warning,
> userspace might not be capable of doing much of anything.  Thus, there
> is an uncomfortably high probability that orchestrating RCU CPU stall
> warnings from userspace would cause these warnings to be lost entirely.

But you're right. When things really go sideways, userspace is likely
dead in the water.

> 
> Similar reasoning might (or might not) apply to the hung-task mechanism.

Yes. No objection from me ;)

Thanks,
Lance

> 
> 							Thanx, Paul
> 
>> Please sell it to us ;)
>> Lance
>>
>>>
>>> This commit adds a new sysctl parameter hung_task_count_to_panic to allows
>>> specifying the number of consecutive hung tasks that must be detected
>>> before triggering a kernel panic. This provides finer control for
>>> environments where transient hangs maybe happen but persistent hangs should
>>> still be fatal.
>>>
>>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
>>> ---
>>>    Documentation/admin-guide/sysctl/kernel.rst |  6 ++++++
>>>    kernel/hung_task.c                          | 14 +++++++++++++-
>>>    2 files changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
>>> index 8b49eab..4240e7b 100644
>>> --- a/Documentation/admin-guide/sysctl/kernel.rst
>>> +++ b/Documentation/admin-guide/sysctl/kernel.rst
>>> @@ -405,6 +405,12 @@ This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
>>>    1 Panic immediately.
>>>    = =================================================
>>> +hung_task_count_to_panic
>>> +=====================
>>> +
>>> +When set to a non-zero value, after the number of consecutive hung task
>>> +occur, the kernel will triggers a panic
>>> +
>>>    hung_task_check_count
>>>    =====================
>>> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
>>> index 8708a12..87a6421 100644
>>> --- a/kernel/hung_task.c
>>> +++ b/kernel/hung_task.c
>>> @@ -83,6 +83,8 @@ static unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
>>>    static unsigned int __read_mostly sysctl_hung_task_panic =
>>>    	IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
>>> +static unsigned int __read_mostly sysctl_hung_task_count_to_panic;
>>> +
>>>    static int
>>>    hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
>>>    {
>>> @@ -219,7 +221,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>>>    	trace_sched_process_hang(t);
>>> -	if (sysctl_hung_task_panic) {
>>> +	if (sysctl_hung_task_panic ||
>>> +	    (sysctl_hung_task_count_to_panic &&
>>> +	     (sysctl_hung_task_detect_count >= sysctl_hung_task_count_to_panic))) {
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
>>



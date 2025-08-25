Return-Path: <linux-kernel+bounces-784126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89880B33704
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB941889635
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443FD285CAD;
	Mon, 25 Aug 2025 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CXvIG/am"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343B62797A1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105134; cv=none; b=RiwUtZYP1U27umaqhSMOJxl+9Og6VZVQ1HWCjwnaCbKuVgd/nbBLwBTBoxn/zZjoMvaBK+/VYpA/ezaDfpuCRFHjYw6nhGePPLiqLpSrLQm5ckjjQlhb6y+V9R93D7d+HTJeE4oVmWbrPO2f1znjZlUnOrWiUsS9/HAB/rX5F4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105134; c=relaxed/simple;
	bh=igJLdp4OqUOPtstcosonJ3xZExx514LlIa2PMqf/EVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nAt/yYL3xAE5V4nW8uDWbUh4wEt3KXzkP7ROCWyqNkK/gCVB2GnyhNfbR1zWFxEw5p8K95SkqriEXo8s2blXLx9alIasv/JhxZLnDW/jzF2cnYxPvHNN6KjkhqW5bd1DD8LisUDg9XXVTebEzQUg412owBbB4dY9scX35uC3iU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CXvIG/am; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <68e34465-ecb6-409e-800c-3dd354156bb0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756105128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=roDy5SQzIC3+xyjshaCjl+HeMkRJun41FXqtW35DUw4=;
	b=CXvIG/amHEmWI6VBkL2u99w60HeTBhVNccTnVlvqqg/VJm21x4TIldQOs3jjOWorZtHUtQ
	bneVuEV0NBSIr+gELgFtOL1qDVQ3BsnQ3qU6gSnhmtIqwUPrP6gEr38PJ01RYSpupfsk/q
	AfO9UfgUVWpjAxRSO7GdjmxUo4u8Yhk=
Date: Mon, 25 Aug 2025 14:58:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] sched/fair: Remove sched_idle_cpu() usages in
 select_task_rq_fair()
To: Josh Don <joshdon@google.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
 "Chen, Yu C" <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org,
 mingo@redhat.com, bsegall@google.com, vschneid@redhat.com,
 juri.lelli@redhat.com, rostedt@goodmis.org, mgorman@suse.de,
 dietmar.eggemann@arm.com, vincent.guittot@linaro.org, peterz@infradead.org,
 viresh.kumar@linaro.org
References: <20250818124702.163271-1-chengming.zhou@linux.dev>
 <87212818-1f59-45e4-9a51-dca62ddb9633@arm.com>
 <e13c922f-2b51-4b4e-bcf8-617e4799522a@intel.com>
 <c0174dd7-86f5-4f4d-b0eb-dd60515e21c5@arm.com>
 <f3757eff-5ffd-4155-8cc5-a70231b4cd49@linux.dev>
 <CABk29NsqoF3U9nECBxh2cDWoPn=7cX+0sDfnpysNRb9HUcRyHg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CABk29NsqoF3U9nECBxh2cDWoPn=7cX+0sDfnpysNRb9HUcRyHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2025/8/22 02:13, Josh Don wrote:
> On Wed, Aug 20, 2025 at 6:53 PM Chengming Zhou <chengming.zhou@linux.dev> wrote:
>>
>> +cc Josh and Viresh, I forgot to cc you, sorry!
> 
> Thanks, missed this previously :)
> 
>>
>> On 2025/8/20 21:53, Christian Loehle wrote:
>>> On 8/19/25 16:32, Chen, Yu C wrote:
>>>> On 8/18/2025 9:24 PM, Christian Loehle wrote:
>>>>> On 8/18/25 13:47, Chengming Zhou wrote:
>>>>>> These sched_idle_cpu() considerations in select_task_rq_fair() is based
>>>>>> on an assumption that the wakee task can pick a cpu running sched_idle
>>>>>> task and preempt it to run, faster than picking an idle cpu to preempt
>>>>>> the idle task.
>>>>>>
>>>>>> This assumption is correct, but it also brings some problems:
>>>>>>
>>>>>> 1. work conservation: Often sched_idle tasks are also picking the cpu
>>>>>> which is already running sched_idle task, instead of utilizing a real
>>>>>> idle cpu, so work conservation is somewhat broken.
>>>>>>
>>>>>> 2. sched_idle group: This sched_idle_cpu() is just not correct with
>>>>>> sched_idle group running. Look a simple example below.
>>>>>>
>>>>>>           root
>>>>>>       /        \
>>>>>>       kubepods    system
>>>>>>       /    \
>>>>>> burstable    besteffort
>>>>>>           (cpu.idle == 1)
> 
> Thanks for bringing attention to this scenario, it's been a case I've
> worried about but haven't had a good idea about fixing. Ideally we
> could find_matching_se(), but we want to do these checks locklessly
> and quickly, so that's out of the question. Agree on it being a hard
> problem.

Yeah, right, we don't want to use find_matching_se() here.

> 
> One idea is that we at least handle the (what I think is fairly
> typical) scenario of a root-level sched_idle group well (a root level

You mean /kubepods and /system group in this case, right? Both of
them are not sched_idle here.

> sched_idle group is trivially idle with respect to anything else in
> the system that is not also nested under a root-level sched_idle
> group). It would be fairly easy to track a nr_idle_queued cfs_rq
> field, as well as cache on task enqueue whether it nests under a
> sched_idle group.

Ok, we can track if a task nests under a sched_idle group, like tasks
from /system and /kubepods/burstable are not under any sched_idle group,
there seems no way to distinguish them except using find_matching_se().

Thanks!

> 
> Best,
> Josh


Return-Path: <linux-kernel+bounces-878677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FF7C213D9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8763B3791
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55832ED869;
	Thu, 30 Oct 2025 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="eY0dsQe1"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30BC2E3B08
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842132; cv=none; b=BIQWez+la0dtxxqWKKNAxY1v2i3zRyN8hzofyokMrycqKnj37Z+gUszItRhBjvjq1WUBPwMaNVpOEKfowBWhgnWEOz5IIw4LHZB6q+E08V2RpJds4XOKKaeP/VG/2IglqbQsyGahGx2mCzJ/0vivsZOPNGGzrV1jpPm94v4B0ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842132; c=relaxed/simple;
	bh=SxmpJPhXHW/j28p9iOyotODBxk5VEWCNDG5cJr+XPYc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sipY4Iheo1UiVrR1r0lMOExdu1YC5KBZD52YWVeYp8QPtsFA0JQbTNlXQpROenmjlvWk/2AgLdzNMPdh8KxD7xPTTees1RLwzTguz5Hk519wjZZxHplp6gHJuJGiZbp6BlONWoMQo7SQ7E6lLzvB4FczlcAUyDoGj5eKCZb2Uhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=eY0dsQe1; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1761842123;
	bh=SxmpJPhXHW/j28p9iOyotODBxk5VEWCNDG5cJr+XPYc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=eY0dsQe11vVBtyY8DLbKSsqyIWgOQlEFuj28Pwv7t4I/GiAkBTtSQ0KqJ+VLeEhUK
	 AB1YCbEdKXym9rLUrz8BqTHi3lt/syb3PScgP8hQOaSLXPlyA6kM7X1HPFr2SnWm4e
	 R0zdfikkgM0t7XVUitkZnjDYZv5Bzl/dkHjifGAI=
Received: by gentwo.org (Postfix, from userid 1007)
	id D344E402BB; Thu, 30 Oct 2025 09:35:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id D106C400CA;
	Thu, 30 Oct 2025 09:35:23 -0700 (PDT)
Date: Thu, 30 Oct 2025 09:35:23 -0700 (PDT)
From: Shubhang <sh@gentwo.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, 
    shubhang@os.amperecomputing.com, Ingo Molnar <mingo@redhat.com>, 
    Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
    Vincent Guittot <vincent.guittot@linaro.org>, 
    Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
    Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
    Shijie Huang <Shijie.Huang@amperecomputing.com>, 
    Frank Wang <zwang@amperecomputing.com>
cc: Christopher Lameter <cl@gentwo.org>, Adam Li <adam.li@amperecomputing.com>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Prefer cache-hot prev_cpu for wakeup
In-Reply-To: <c22de852-f2f6-48d7-831f-ca2a06365783@arm.com>
Message-ID: <d1cbc53d-d4cf-bc5a-6468-89e9a1d86f33@gentwo.org>
References: <20251017-b4-sched-cfs-refactor-propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com> <c22de852-f2f6-48d7-831f-ca2a06365783@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

The system is an 80 core Ampere Altra with a two-level
sched domain topology. The MC domain contains all 80 cores.

I agree that placing the condition earlier in `select_idle_sibling()` 
aligns better with convention. I will move the check (EAS Aware) to the 
top of the function and submit a v2 patch.

Best,
Shubhang Kaushik

On Thu, 30 Oct 2025, Dietmar Eggemann wrote:

> On 18.10.25 01:00, Shubhang Kaushik via B4 Relay wrote:
>> From: Shubhang Kaushik <shubhang@os.amperecomputing.com>
>>
>> Modify the wakeup path in `select_task_rq_fair()` to prioritize cache
>> locality for waking tasks. The previous fast path always attempted to
>> find an idle sibling, even if the task's prev CPU was not truly busy.
>>
>> The original problem was that under some circumstances, this could lead
>> to unnecessary task migrations away from a cache-hot core, even when
>> the task's prev CPU was a suitable candidate. The scheduler's internal
>> mechanism `cpu_overutilized()` provide an evaluation of CPU load.
>>
>> To address this, the wakeup heuristic is updated to check the status of
>> the task's `prev_cpu` first:
>> - If the `prev_cpu` is  not overutilized (as determined by
>>   `cpu_overutilized()`, via PELT), the task is woken up on
>>   its previous CPU. This leverages cache locality and avoids
>>   a potentially unnecessary migration.
>> - If the `prev_cpu` is considered busy or overutilized, the scheduler
>>   falls back to the existing behavior of searching for an idle sibling.
>
> How does you sched domain topology look like? How many CPUs do you have
> in your MC domain?
>
>>
>> Signed-off-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
>> ---
>> This patch optimizes the scheduler's wakeup path to prioritize cache
>> locality by keeping a task on its previous CPU if it is not overutilized,
>> falling back to a sibling search only when necessary.
>> ---
>>  kernel/sched/fair.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index bc0b7ce8a65d6bbe616953f530f7a02bb619537c..bb0d28d7d9872642cb5a4076caeb3ac9d8fe7bcd 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8618,7 +8618,16 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>>  		new_cpu = sched_balance_find_dst_cpu(sd, p, cpu, prev_cpu, sd_flag);
>>  	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
>>  		/* Fast path */
>> -		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
>> +
>> +		/*
>> +		 * Avoid wakeup on an overutilized CPU.
>> +		 * If the previous CPU is not overloaded, retain the same for cache locality.
>> +		 * Otherwise, search for an idle sibling.
>> +		 */
>> +		if (!cpu_overutilized(prev_cpu))
>> +			new_cpu = prev_cpu;
>
> IMHO, special conditions like this one are normally coded at the
> beginning of select_idle_sibling().
>
> [...]
>


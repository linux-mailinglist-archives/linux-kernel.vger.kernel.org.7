Return-Path: <linux-kernel+bounces-778784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D3AB2EAFC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD27687883
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973A325BEF4;
	Thu, 21 Aug 2025 01:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ow9khxUe"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0321225B1EA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755741236; cv=none; b=agWt1T/6HSZZGjiXEgZrwNRqycX0+w8Afw4XhtnQNGBEr/KZ+hftX66Q3H4pfEHhnDNS5hyXouizOKr4ls3Km43ygAGYlD38g2obcaQYVW337VS16LXfpGvvcRy17c3PzDfWy+Oou/khljrOTMhCqnYyyH0rXIYascNQCsvrI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755741236; c=relaxed/simple;
	bh=4tWtZHV6W6gUwOfeLoUm/VSHTvscDnvROCy2S9MRFj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6T+Nv2W6bdZphoODa0F/AADCmpuXehmHKpEdpNJxa4u5AsVFoNSy2IcYRj/Rilm0wHVphHBnn409twtpPVSnoIwsJKIzJv65IZhPwEaDNte21uLrc7pVi6GCLBiYgEOCU7K04dKQ9O3gV0WkkX6Vz4L3erbiLN5Xqbyxtc0Hu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ow9khxUe; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f3757eff-5ffd-4155-8cc5-a70231b4cd49@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755741231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4rb+hSc1qDoPOQUC6oeKhWd2hkeF3v/ZlMJQhcY4Xo=;
	b=Ow9khxUemdGuDha+OyVEQK9RTpQFHBkpUMUzpRQ6QRqFTmtK6GKM+pSR4Vj2Sr9OdSNtbc
	9EM+Fmn8w2NwMXdgsyxbJ+osTE7oleQTL4DXJH2w5NRqnd9dF0OcjmUhfWJvqNjf7rgOE1
	nQiYXJ4qaS7lHwVeEA5fuNMQBUUBRjE=
Date: Thu, 21 Aug 2025 09:53:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] sched/fair: Remove sched_idle_cpu() usages in
 select_task_rq_fair()
To: Christian Loehle <christian.loehle@arm.com>,
 "Chen, Yu C" <yu.c.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, bsegall@google.com,
 vschneid@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org,
 mgorman@suse.de, dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
 peterz@infradead.org, viresh.kumar@linaro.org, Josh Don <joshdon@google.com>
References: <20250818124702.163271-1-chengming.zhou@linux.dev>
 <87212818-1f59-45e4-9a51-dca62ddb9633@arm.com>
 <e13c922f-2b51-4b4e-bcf8-617e4799522a@intel.com>
 <c0174dd7-86f5-4f4d-b0eb-dd60515e21c5@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <c0174dd7-86f5-4f4d-b0eb-dd60515e21c5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

+cc Josh and Viresh, I forgot to cc you, sorry!

On 2025/8/20 21:53, Christian Loehle wrote:
> On 8/19/25 16:32, Chen, Yu C wrote:
>> On 8/18/2025 9:24 PM, Christian Loehle wrote:
>>> On 8/18/25 13:47, Chengming Zhou wrote:
>>>> These sched_idle_cpu() considerations in select_task_rq_fair() is based
>>>> on an assumption that the wakee task can pick a cpu running sched_idle
>>>> task and preempt it to run, faster than picking an idle cpu to preempt
>>>> the idle task.
>>>>
>>>> This assumption is correct, but it also brings some problems:
>>>>
>>>> 1. work conservation: Often sched_idle tasks are also picking the cpu
>>>> which is already running sched_idle task, instead of utilizing a real
>>>> idle cpu, so work conservation is somewhat broken.
>>>>
>>>> 2. sched_idle group: This sched_idle_cpu() is just not correct with
>>>> sched_idle group running. Look a simple example below.
>>>>
>>>>          root
>>>>      /        \
>>>>      kubepods    system
>>>>      /    \
>>>> burstable    besteffort
>>>>          (cpu.idle == 1)
>>>>
>>>> When a sched_idle cpu is just running tasks from besteffort group,
>>>> sched_idle_cpu() will return true in this case, but this cpu pick
>>>> is bad for wakee task from system group. Because the system group
>>>> has lower weight than kubepods, work conservation is somewhat
>>>> broken too.
>>>>
>>>> In a nutshell, sched_idle_cpu() should consider the wakee task group's
>>>> relationship with sched_idle tasks running on the cpu.
>>>>
>>>> Obviously, it's hard to do so. This patch chooses the simple approach
>>>> to remove all sched_idle_cpu() considerations in select_task_rq_fair()
>>>> to bring back work conservation in these cases.
>>>
>>> OTOH sched_idle_cpu() CPUs are guaranteed to not be in an idle state and
>>> potentially already have DVFS on some higher level...
>>>
>> Is it because the schedutil governor considers the utilization
>> of SCHED_IDLE, thus causing schedutil to request a higher
>> frequency?
> 
> For intel_pstate active (HWP and !HWP) the same issue should persist, no?
> 
>>
>> The commit 3c29e651e16d ("sched/fair: Fall back to sched-idle
>> CPU if an idle CPU isn't found") mentions that choosing a CPU
>> running a SCHED_IDLE task can avoid waking a CPU from a deep
>> sleep state.
>>
>> If this is the case, can we say that if an administrator sets
>> the cpufreq governor to "performance" and disables deep idle
>> states, an idle CPU would be more preferable than a CPU running
>> a SCHED_IDLE task? On the other hand, if
>> per_cpu(cpufreq_update_util_data, cpu) is NULL and only shallow
>> idle states are enabled in idle_get_state(), should we skip
>> SCHED_IDLE to achieve work conservation?
> 
> That's probably getting the most out of it.
> That being said, strictly speaking the SCHED_IDLE CPU and the
> SHALLOW_IDLE CPU may still share a power and thermal budget, which
> may make preempting the sched-idle task on SCHED_IDLE CPU the
> better choice.

I admit these sched_idle_cpu() considerations are good motivation,
at least for !sched_idle tasks, to preempt sched_idle task instead of
waking a real idle cpu.

But it oversimplified the complicated situations we have, such as
the cases above, which make the scheduler's work conservation performance
really bad.

Thanks.


Return-Path: <linux-kernel+bounces-777848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5793B2DE7C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DADE1797AB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F3E1DE3DB;
	Wed, 20 Aug 2025 13:53:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BF0156F45
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698024; cv=none; b=G4qYrqGPJuCsnAQDS0Jq75a10h4IzclJHB71rTpPKMnBnCcqnoh+wPBL9E/0j7lh5G8qPSbvaW6LanIq07kKm6B3OUzeNr0JFrq47U3Ry01UboKZVHQG5MIFk9PlwTx0HlDrPlugp7qhv/9vebFprjxMHTtxaRmw+c0MKi3m+UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698024; c=relaxed/simple;
	bh=Ito1fiEo4kJ0ggjcdoG+NCsDO+PPv9e+WdQDBUrnQDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DL17hw+t+GuLbzDD5Dz1jOXC4PUDAry741kVmUWeWW0aGukB8oqH5/y/U4eL7fvg/if32VR53JBzMwb0vO35s+8mZortR01ECg07afCtkXKBTRV9ZZQ+bjT9xX9ZQZjXZoyGkBaZAtjw2pA8IpznIcpQYm+eD1G113SX+FPaekE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D860A1D31;
	Wed, 20 Aug 2025 06:53:32 -0700 (PDT)
Received: from [10.1.34.24] (unknown [10.1.34.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B15263F63F;
	Wed, 20 Aug 2025 06:53:38 -0700 (PDT)
Message-ID: <c0174dd7-86f5-4f4d-b0eb-dd60515e21c5@arm.com>
Date: Wed, 20 Aug 2025 14:53:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/fair: Remove sched_idle_cpu() usages in
 select_task_rq_fair()
To: "Chen, Yu C" <yu.c.chen@intel.com>,
 Chengming Zhou <chengming.zhou@linux.dev>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, bsegall@google.com,
 vschneid@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org,
 mgorman@suse.de, dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
 peterz@infradead.org
References: <20250818124702.163271-1-chengming.zhou@linux.dev>
 <87212818-1f59-45e4-9a51-dca62ddb9633@arm.com>
 <e13c922f-2b51-4b4e-bcf8-617e4799522a@intel.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <e13c922f-2b51-4b4e-bcf8-617e4799522a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/19/25 16:32, Chen, Yu C wrote:
> On 8/18/2025 9:24 PM, Christian Loehle wrote:
>> On 8/18/25 13:47, Chengming Zhou wrote:
>>> These sched_idle_cpu() considerations in select_task_rq_fair() is based
>>> on an assumption that the wakee task can pick a cpu running sched_idle
>>> task and preempt it to run, faster than picking an idle cpu to preempt
>>> the idle task.
>>>
>>> This assumption is correct, but it also brings some problems:
>>>
>>> 1. work conservation: Often sched_idle tasks are also picking the cpu
>>> which is already running sched_idle task, instead of utilizing a real
>>> idle cpu, so work conservation is somewhat broken.
>>>
>>> 2. sched_idle group: This sched_idle_cpu() is just not correct with
>>> sched_idle group running. Look a simple example below.
>>>
>>>         root
>>>     /        \
>>>     kubepods    system
>>>     /    \
>>> burstable    besteffort
>>>         (cpu.idle == 1)
>>>
>>> When a sched_idle cpu is just running tasks from besteffort group,
>>> sched_idle_cpu() will return true in this case, but this cpu pick
>>> is bad for wakee task from system group. Because the system group
>>> has lower weight than kubepods, work conservation is somewhat
>>> broken too.
>>>
>>> In a nutshell, sched_idle_cpu() should consider the wakee task group's
>>> relationship with sched_idle tasks running on the cpu.
>>>
>>> Obviously, it's hard to do so. This patch chooses the simple approach
>>> to remove all sched_idle_cpu() considerations in select_task_rq_fair()
>>> to bring back work conservation in these cases.
>>
>> OTOH sched_idle_cpu() CPUs are guaranteed to not be in an idle state and
>> potentially already have DVFS on some higher level...
>>
> Is it because the schedutil governor considers the utilization
> of SCHED_IDLE, thus causing schedutil to request a higher
> frequency?

For intel_pstate active (HWP and !HWP) the same issue should persist, no?

> 
> The commit 3c29e651e16d ("sched/fair: Fall back to sched-idle
> CPU if an idle CPU isn't found") mentions that choosing a CPU
> running a SCHED_IDLE task can avoid waking a CPU from a deep
> sleep state.
> 
> If this is the case, can we say that if an administrator sets
> the cpufreq governor to "performance" and disables deep idle
> states, an idle CPU would be more preferable than a CPU running
> a SCHED_IDLE task? On the other hand, if
> per_cpu(cpufreq_update_util_data, cpu) is NULL and only shallow
> idle states are enabled in idle_get_state(), should we skip
> SCHED_IDLE to achieve work conservation?

That's probably getting the most out of it.
That being said, strictly speaking the SCHED_IDLE CPU and the
SHALLOW_IDLE CPU may still share a power and thermal budget, which
may make preempting the sched-idle task on SCHED_IDLE CPU the
better choice.


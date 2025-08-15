Return-Path: <linux-kernel+bounces-769870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D0BB274A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAAC1CC52ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3052433C4;
	Fri, 15 Aug 2025 01:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHqul9nR"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C34DDA9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220622; cv=none; b=qo0BuwIob/vx8EIGuOATVNW+mFxDB3WDE52Z9gcXPa+EDwEx1+lWXr9kuSABwY57hF4a/KANll8QmdVBDWLBPsNOrcuEQqWTTVnkPem7qsAUOFa5EmKwZfuUiiXZ42UwLxX0FOkWdhy0ul9g/BXLoXkewwXkBSWMhVjx8bH0qiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220622; c=relaxed/simple;
	bh=zZEG3LWWA08tTwdZv95X+Lpb7oI8RieN4L3FTvVfiak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=poSqPfjYwIZRf02fdQSSZujjudU3+U94jrkT787ehgW1nzi8sAlFn8TS8G20A3+Dz7lqe36pjxZ0wL7tA7i+4Xou3+SM0DBs1FCr1iX6ZOePogIY+FZI3cfsqKb0awrODR4ZXbhiVvCAXzAQnUNrBJcGTv6IgzTggVSwVxymaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHqul9nR; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e87050b077so181137185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755220619; x=1755825419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uICUrcke/hbJnczM3jvLZzrWTVgYoliP4x88leQjwLM=;
        b=hHqul9nRRXDbKXXyepWIkoF+H2BbAKutOWUazbIWfBfbJsKp8JG/yHbmV2MQK+VY5U
         yEpga7KPpVRspTqbzarda2mBpNMJiQVOra1vvaV8/9a+9m44UGksPrjdanjyWEJLFqMX
         f419Cg/wGYyhXUDWjW1GyBt5KZn84NQRCbTQ9UIGn86RgF5LWkO5E3kPyYF+jMSJszCr
         TzKSyNtcGdCOr+cdhG4nVi0yCyVmK6adDEAYpCAyG/bJ1Moej4WyHV3KZn2VeKylW5HM
         oRkdHouyLoDeCmb4Es5smgXi3+cimTmOpA4NAUCkLAX3n00Kfpx4/L6SIw/D2HOWflRQ
         MRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220619; x=1755825419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uICUrcke/hbJnczM3jvLZzrWTVgYoliP4x88leQjwLM=;
        b=DmkIfVlwVH2MjBTeajAt4PatoL2fnpRwozL5vEGVlc6ymktFPWL9G5L3hF0YR+vGHP
         JDM3LjXW4+kplkBKC46QSm4OVUJF6ihki8bjdI/1lXEfbB+qZHFzFzCTJ3lJMlfD3Wl0
         68UmDFNSmwhFDGcisgwKoDCXkP0ANCBM0RnR7GobtjcVskKl52u059fnZTVurOgML9Su
         LifPBCtPDAbdOvx7FmE8Oqsu6mkhZThn9Dmj+pJmXySLCQLIlBOwCzSXzk1SBaPZ3HR0
         ci1b6A0yTaHs77JN5gdINC756hNzS3vdivS1r6s5Qrh9r0/NcUllBvVoL+w0vEa6X1e1
         4fPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy4Guy/GlDUEEjBI3CiZdHKu9CQP2bgiEPonD10lfmuj61wnm8Hc8NffcGQvHEBEmoy/0ZtNp1u6r6YrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS75wBoIXBK7gnBJe0tz3ao1flUkZJyQxNgtVc0a2UPijMY2no
	+QsqYS3dIhWUMnYtMinKH+tFmoprGk2o5JMPOjIT0rqqZyj9V3g/nAqshcX4NQ==
X-Gm-Gg: ASbGncvI4ywTCdORuWwlqADrpKen1JAiOJdvA736xmE2PlWt3T4EPcekfASGO1J/UFB
	joMN+zaO4VXY8GPB34TWWf7lmsQInKHWxMyOjFd/6hNQZIh61+bLNr2An/EVBuc+jIlDOafB+Tl
	nCtkEh1YthnRArcLLxC0KyzF8xiD7Ag33c8m/DWoe1FB2PQBIIkA1JH2shUAr4dpMhW6P8z1VV7
	3j8LGS/imrVMLEazpe1/B5Gb0oc+RhIhIb2PntOC9vvxLGHVvHn3w8eEZiBod58K+XGbCaw9jK/
	JGLz48FkOiioZMm9ZoTEljJE40a+XitXNQpgpxIncN3Ro/K0QNWQry7NwiPJ+/9vGU9/hHeKRDN
	OBzjMLJDIbeVF3LnwoOihk0SHvyYrLwev4TzCnQG8lr67
X-Google-Smtp-Source: AGHT+IH7W3Ef6JkK0rKgXCYBouppWE/bKrHfFHWJCyaWUvvzsWj8Q98vwwdyJ6szTQ1QnDE0+rbSUw==
X-Received: by 2002:a05:620a:1920:b0:7e8:5a78:22f6 with SMTP id af79cd13be357-7e87e0f9cb8mr41778885a.33.1755220619278;
        Thu, 14 Aug 2025 18:16:59 -0700 (PDT)
Received: from [192.168.12.218] ([172.58.119.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e066da8sm17676885a.25.2025.08.14.18.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 18:16:58 -0700 (PDT)
Message-ID: <64c66b54-f0a8-46b0-b013-c6a9f155d139@gmail.com>
Date: Thu, 14 Aug 2025 18:16:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/deadline: only set free_cpus for online runqueues
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org,
 Florian Fainelli <florian.fainelli@broadcom.com>
References: <20250811190536.661884-1-opendmb@gmail.com>
 <aJtaSgXf9fkRo-Rp@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <aJtaSgXf9fkRo-Rp@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/2025 8:14 AM, Juri Lelli wrote:
> Hi!
> 
> On 11/08/25 12:05, Doug Berger wrote:
>> Commit 16b269436b72 ("sched/deadline: Modify cpudl::free_cpus
>> to reflect rd->online") introduced the cpudl_set/clear_freecpu
>> functions to allow the cpu_dl::free_cpus mask to be manipulated
>> by the deadline scheduler class rq_on/offline callbacks so the
>> mask would also reflect this state.
>>
>> Commit 9659e1eeee28 ("sched/deadline: Remove cpu_active_mask
>> from cpudl_find()") removed the check of the cpu_active_mask to
>> save some processing on the premise that the cpudl::free_cpus
>> mask already reflected the runqueue online state.
>>
>> Unfortunately, there are cases where it is possible for the
>> cpudl_clear function to set the free_cpus bit for a CPU when the
>> deadline runqueue is offline. When this occurs while a CPU is
>> connected to the default root domain the flag may retain the bad
>> state after the CPU has been unplugged. Later, a different CPU
>> that is transitioning through the default root domain may push a
>> deadline task to the powered down CPU when cpudl_find sees its
>> free_cpus bit is set. If this happens the task will not have the
>> opportunity to run.
>>
>> One example is outlined here:
>> https://lore.kernel.org/lkml/20250110233010.2339521-1-opendmb@gmail.com
>>
>> Another occurs when the last deadline task is migrated from a
>> CPU that has an offlined runqueue. The dequeue_task member of
>> the deadline scheduler class will eventually call cpudl_clear
>> and set the free_cpus bit for the CPU.
>>
>> This commit modifies the cpudl_clear function to be aware of the
>> online state of the deadline runqueue so that the free_cpus mask
>> can be updated appropriately.
>>
>> It is no longer necessary to manage the mask outside of the
>> cpudl_set/clear functions so the cpudl_set/clear_freecpu
>> functions are removed. In addition, since the free_cpus mask is
>> now only updated under the cpudl lock the code was changed to
>> use the non-atomic __cpumask functions.
>>
>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>> ---
> 
> Thanks for this new approach, it looks good to me.
> 
> I would like to stress test it a little more, and have a comment below.
> 
Thanks for the review. I appreciate any testing you are willing to do.

>>   kernel/sched/cpudeadline.c | 34 +++++++++-------------------------
>>   kernel/sched/cpudeadline.h |  4 +---
>>   kernel/sched/deadline.c    |  8 ++++----
>>   3 files changed, 14 insertions(+), 32 deletions(-)
>>
>> diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
>> index cdd740b3f774..d612d5c6c61a 100644
>> --- a/kernel/sched/cpudeadline.c
>> +++ b/kernel/sched/cpudeadline.c
>> @@ -166,12 +166,13 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
>>    * cpudl_clear - remove a CPU from the cpudl max-heap
>>    * @cp: the cpudl max-heap context
>>    * @cpu: the target CPU
>> + * @online: the online state of the deadline runqueue
>>    *
>>    * Notes: assumes cpu_rq(cpu)->lock is locked
>>    *
>>    * Returns: (void)
>>    */
>> -void cpudl_clear(struct cpudl *cp, int cpu)
>> +void cpudl_clear(struct cpudl *cp, int cpu, bool online)
>>   {
>>   	int old_idx, new_cpu;
>>   	unsigned long flags;
>> @@ -184,7 +185,7 @@ void cpudl_clear(struct cpudl *cp, int cpu)
>>   	if (old_idx == IDX_INVALID) {
>>   		/*
>>   		 * Nothing to remove if old_idx was invalid.
>> -		 * This could happen if a rq_offline_dl is
>> +		 * This could happen if rq_online_dl or rq_offline_dl is
>>   		 * called for a CPU without -dl tasks running.
>>   		 */
>>   	} else {
>> @@ -195,9 +196,12 @@ void cpudl_clear(struct cpudl *cp, int cpu)
>>   		cp->elements[new_cpu].idx = old_idx;
>>   		cp->elements[cpu].idx = IDX_INVALID;
>>   		cpudl_heapify(cp, old_idx);
>> -
>> -		cpumask_set_cpu(cpu, cp->free_cpus);
>>   	}
>> +	if (unlikely(!online))
> 
> Isn't using likely(online) more direct and cleaner? :)
> 
Sure! V2 on the way.>> +		__cpumask_clear_cpu(cpu, cp->free_cpus);
>> +	else
>> +		__cpumask_set_cpu(cpu, cp->free_cpus);
>> +
>>   	raw_spin_unlock_irqrestore(&cp->lock, flags);
>>   }
> 
> Best,
> Juri
> 

Thanks again,
     Doug



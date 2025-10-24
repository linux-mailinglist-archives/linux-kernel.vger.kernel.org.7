Return-Path: <linux-kernel+bounces-868175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DF2C0492A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFE83BB150
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A5626ED3C;
	Fri, 24 Oct 2025 06:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSaLEQ0C"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF7824BD04
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761288698; cv=none; b=P3STbZyHkrtiazAdKEEKl5ONCs1WASkyCMhffk4I/lFGFtkTlal6iR/bMCjH/GWRXEpDlRrWEvv3UnFB6t9rIw/+P8HdOa49gZgKd25QAHoMZJIYrTKHGzcCMcUN9E4gPtyiip85gGvzfTC4isfTMh2FjM9y/2RuU38AzIp90r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761288698; c=relaxed/simple;
	bh=0URu6Oa0yrhVlMC9gwSZguvWRAO9uZqj8Zo9hQD05/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gV8HHPPlha0FKZDYmFcmKAU54KAVf9vvGDXMUsW0MOfKAKSd4zWSZVcZTcgIm5IJGwhNioVle+xoe/SQQxuMoydoS1/1X2snki75EnLtniftJuqLV8GbDn9YZn7VrGJKGKY/mhEV9qGZECCEpQQPngEU/gVhjtfUoLcMvv62s6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSaLEQ0C; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a27ab05a2dso1310259b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761288696; x=1761893496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9iVi+Ggsp/gaZsucL7vuuaaw3jiFKPtvB94kBfUHmM=;
        b=TSaLEQ0C4L+y7pC32w7JQXFsbmFlidJB3KYF0VhmwEpxZhNweRqnNpfGNN/uleJnzK
         Vqcx2CRMqEZbtYMQOrO8KOmzyfovu8fca3fj/taoL+IZktmOY+GBzZK0FKZKkK3hOwJb
         glyrvIV27kv/DyMT+KXHtw/ofXHGdqsne7WmZh8C2CEB8/G09Xt+SJN6KgKUBj1+qrXP
         O04MYdiq3HrQuRiIUq9eu8I06MP0KHtgC06s9jPpRwtHFcbXhvS3j4OURx6Ybd/eJb+L
         Qax+EBa/OTfZt79/BlYO+x0EbKafHqw5vSAgHPRoWW0sky1hSR1kM9E2P8UAko5EouX4
         8E5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761288696; x=1761893496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U9iVi+Ggsp/gaZsucL7vuuaaw3jiFKPtvB94kBfUHmM=;
        b=aoLXvppKADT06/J5Np5dwCcS8313Xm2tA5zofRLK2VGUrgjtKmdsBHrV2EmrnSGVvC
         clZs1jzLipQ1j+d75r+jlKJr+Hkd1v3YYGC7lEnpw1zS+Sxx9FvaWZ66zosvsK7V51Qe
         psHdxdVEaJAU+ePeXfHf3rs2s/fahURQwuHoUc43EasgbdUdljDgz8nTGtxqt3q1Jrak
         SVtiqnw8f29Oewz/fKXLZY59Z1baeOkiYP3UzO8zdlYRryOf4322lg7Z7AXEwZXXem/R
         M17Hq/bKdefCcfyFfqZxYh3+dqsGk1VlI3RoKb0fbDuCTTFqctlt1tj43MbR2Jt/y/xZ
         hGqA==
X-Forwarded-Encrypted: i=1; AJvYcCWXEQG1R/Ydi4bIzUmoWMx/5SO1b2nAzGhbeMpVh4EF9j2SmKb9m6e9HUHv+wVx0p3zNF+K+JX5ANt4ymw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywZ1qa2A+kzoCLO0vSk/qw8PMiTcuN88LIFYj6YkOuHCIgL53q
	OYCxBMC4tP/Q529qW3mgOQhYiA7nfRqdSVQn9LMBP2Ygo4dBdJ3tejf9
X-Gm-Gg: ASbGncsrJwuCM1C7UsoCLZAsWqiSQB0WmWyZ+OzGca6fHOaap2gcnZnRojthMY3yUht
	Sn/Z5+DXB9FdE8zeCHMLf6P3ES9BE1niJBEYrfKmY6pVThL9bxUbHVed4TL2gOC/yOUfecv/6US
	J8g/vXYVy2tyxED2FOxlYRjhnpHl9vYB/AvJC0x1UwrBIhGAqanyuYP/TljoIjj1xb4NOKsoBlx
	umo96G/BnSvtScCZrMzX4HPf+Ex/Lust/h3qlPVVev0DwGG+Dnp1O2fof+IdbHFed2el4m4c/Js
	8P3+y2uwrYCKyUPs8Pi03f51oDbj17HSLNkbW45UkeWmA4jbUy5G212ZeCrBunCSfs7HD++7F+S
	p+C4KcqvT+PVyXX6kYjHrBqstMW3ymNFK4EQQkinN+Ex0onIlWB4/ivmVrkA7suiWBtpo5ctrLc
	LriRQi37WPtl1zFrf5HeQg
X-Google-Smtp-Source: AGHT+IFH2sMtc95rN9L95LkYXZ0GgDJwVXBCqEHFYOJKIaNiEHBVgNPL/vt/pVFdpRzuP6LqFslt+A==
X-Received: by 2002:a05:6a20:a128:b0:33e:5d06:92d3 with SMTP id adf61e73a8af0-33e5d0694aamr246896637.36.1761288695805;
        Thu, 23 Oct 2025 23:51:35 -0700 (PDT)
Received: from [10.125.192.78] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a9d3c7sm4799322b3a.26.2025.10.23.23.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 23:51:35 -0700 (PDT)
Message-ID: <ee79013d-2fc5-b103-ce75-a9fcb5ce4977@gmail.com>
Date: Fri, 24 Oct 2025 14:51:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] sched/fair: Fix non-empty throttled_limbo_list warning in
 tg_throttle_down()
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>
References: <20251023121213.38282-1-jiahao.kernel@gmail.com>
 <20251024033955.GA39@bytedance>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <20251024033955.GA39@bytedance>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Aaron,

On 2025/10/24 11:39, Aaron Lu wrote:
> On Thu, Oct 23, 2025 at 08:12:13PM +0800, Hao Jia wrote:
>> From: Hao Jia <jiahao1@lixiang.com>
>>
>> Aaron Lu and I hit a non-empty throttled_limbo_list warning in
>> tg_throttle_down() during testing.
>>
>> WARNING: kernel/sched/fair.c:5975 at tg_throttle_down+0x2bd/0x2f0, CPU#20: swapper/20/0
>> Call Trace:
>>   ? __pfx_tg_nop+0x10/0x10
>>   walk_tg_tree_from+0x39/0xd0
>>   ? __pfx_tg_throttle_down+0x10/0x10
>>   throttle_cfs_rq+0x176/0x1f0
>>   enqueue_task_fair+0x4f5/0xd30
>>   ? unthrottle_cfs_rq+0x2f7/0x3a0
>>   tg_unthrottle_up+0x10c/0x2f0
>>   ? __pfx_tg_unthrottle_up+0x10/0x10
>>   walk_tg_tree_from+0x66/0xd0
>>   ? __pfx_tg_nop+0x10/0x10
>>   unthrottle_cfs_rq+0x16b/0x3a0
>>   __cfsb_csd_unthrottle+0x1f0/0x250
>>   ? __pfx___cfsb_csd_unthrottle+0x10/0x10
>>   __flush_smp_call_function_queue+0x104/0x440
>>   ? tick_nohz_account_idle_time+0x4c/0x80
>>   flush_smp_call_function_queue+0x3b/0x80
>>   do_idle+0x14f/0x240
>>   cpu_startup_entry+0x30/0x40
>>   start_secondary+0x128/0x160
>>   common_startup_64+0x13e/0x141
>>
>> cgroup hierarchy:
>>
>>            root
>>          /      \
>>          A*     ...
>>       /  |  \   ...
>>          B* ...
>>
>> Debugging shows the following:
>> A and B are configured with relatively small quota and large period.
>>
>> At some point, cfs_rq_A is throttled. Due to the throttling of cfs_rq_A,
>> the tasks on cfs_rq_B are added to cfs_rq_B's throttled_limbo_list.
>>
>> Resetting task_group B quota will set cfs_rq_B runtime_remaining to 0 in
>> tg_set_cfs_bandwidth().
>> Since task_group A is throttled, Therefore, task on cfs_rq_B cannot run,
>> and runtime_remaining stays 0. With task_group B has a small quota,
>> tasks on other CPUs in task_group B quickly consume all of
>> cfs_b_B->runtime, causing cfs_b_B->runtime to be 0.
>>
>> When cfs_rq_A is unthrottled later, tg_unthrottle_up(cfs_rq_B) will
>> re-queues task. However, because cfs_rq_B->runtime_remaining still 0,
>> and it cannot obtain runtime from cfs_b_B->runtime either. Therefore,
>> the task will be throttled in
>> enqueue_task_fair()->enqueue_entity()->check_enqueue_throttle(),
>> triggering a non-empty throttled_limbo_list warning in tg_throttle_down().
>>
>> Root Cause:
>> In unthrottle_cfs_rq(), we only checked cfs_rq_A->runtime_remaining, but
>> enqueue_task_fair() requires that the runtime_remaining of each cfs_rq
>> level be greater than 0.
>>
>> Solution:
>> One way to fix this warning is to add a runtime_remaining check for
>> each cfs_rq level of the task in unthrottle_cfs_rq(), but this makes code
>> strange and complicated.
>> Another straightforward and simple solution is to add a new enqueue flag
>> to ensure that enqueue in tg_unthrottle_up() will not immediately trigger
>> throttling. This may enqueue sched_entity with no remaining runtime, which
>> is not a big deal because the current kernel also has such situations [1].
>>
>> We still retain the runtime_remaining check in unthrottle_cfs_rq() for
>> higher-level cfs_rq to avoid enqueuing many entities with
>> runtime_remaining < 0.
>>
>> Also remove the redundant assignment to se in tg_throttle_down().
>>
>> [1]: https://lore.kernel.org/all/20251015084045.GB35@bytedance
>>
>> Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
>> Reported-by: Aaron Lu <ziqianlu@bytedance.com>
>> Closes: https://lore.kernel.org/all/20251016065438.GA32@bytedance
>> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
> 
> Tested-by: Aaron Lu <ziqianlu@bytedance.com>
> 
>> ---
>> Reproduction steps:
>> (1) Create a test.sh script and run it:
>> #!/bin/bash
>> set -e
>> CGP_ROOT="/sys/fs/cgroup/"
>> if ! mount | grep -q "type cgroup2"; then
>> 	echo "ERROR: Not in cgroup v2 mode."
>> 	exit 1
>> fi
>> echo 1 > /sys/kernel/debug/clear_warn_once
>> mkdir -p ${CGP_ROOT}/test
>> echo "+cpu +cpuset" > ${CGP_ROOT}/test/cgroup.subtree_control
>> for i in $(seq 1 2); do
>> 	SUB_DIR=${CGP_ROOT}/test/sub$i
>> 	mkdir -p ${SUB_DIR}
>> 	echo $$ > ${SUB_DIR}/cgroup.procs
>> 	perf bench sched messaging -g 10 -t -l 50000 &
>> 	echo $$ > /sys/fs/cgroup/cgroup.procs
>> 	echo "1000 100000" > ${SUB_DIR}/cpu.max
>> 	echo "Started stress in stress_sub$i"
>> done
>> echo "1000 100000" > ${CGP_ROOT}/test/cpu.max
>>
>> (2) Run the following command multiple times until the warning is triggered:
>> echo 1000 10000 > /sys/fs/cgroup/test/sub1/cpu.max
>>
>>   kernel/sched/fair.c  | 15 ++++++++++-----
>>   kernel/sched/sched.h |  3 +++
>>   2 files changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index b58e696d7ccc..7721466dc8f2 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5287,7 +5287,9 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>   	se->on_rq = 1;
>>   
>>   	if (cfs_rq->nr_queued == 1) {
>> -		check_enqueue_throttle(cfs_rq);
>> +		if (!(flags & ENQUEUE_THROTTLE))
>> +			check_enqueue_throttle(cfs_rq);
>> +
> 
> nit: might be better to place this check inside check_enqueue_throttle()
> after cfs_bandwidth_used()? I was thinking: in this way, it might save
> some cycles for systems with CONFIG_CFS_BANDWIDTH set but don't actually
> set any quota.

Thanks for your suggestion, I will do it in the next version.

> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 671cbf8dc00ee..688f74ee145c9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5229,7 +5229,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>   	se->deadline = se->vruntime + vslice;
>   }
>   
> -static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
> +static void check_enqueue_throttle(struct cfs_rq *cfs_rq, int flags);
>   static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
>   
>   static void
> @@ -5287,8 +5287,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>   	se->on_rq = 1;
>   
>   	if (cfs_rq->nr_queued == 1) {
> -		if (!(flags & ENQUEUE_THROTTLE))
> -			check_enqueue_throttle(cfs_rq);
> +		check_enqueue_throttle(cfs_rq, flags);
>   
>   		list_add_leaf_cfs_rq(cfs_rq);
>   #ifdef CONFIG_CFS_BANDWIDTH
> @@ -6408,7 +6407,7 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>    * expired/exceeded, otherwise it may be allowed to steal additional ticks of
>    * runtime as update_curr() throttling can not trigger until it's on-rq.
>    */
> -static void check_enqueue_throttle(struct cfs_rq *cfs_rq)
> +static void check_enqueue_throttle(struct cfs_rq *cfs_rq, int flags)
>   {
>   	if (!cfs_bandwidth_used())
>   		return;
> @@ -6421,6 +6420,10 @@ static void check_enqueue_throttle(struct cfs_rq *cfs_rq)
>   	if (cfs_rq_throttled(cfs_rq))
>   		return;
>   
> +	/* Do not attempt throttle on cfs_rq's unthrottle path */
> +	if (flags & ENQUEUE_THROTTLE)
> +		return;
> +
>   	/* update runtime allocation */
>   	account_cfs_rq_runtime(cfs_rq, 0);
>   	if (cfs_rq->runtime_remaining <= 0)
> @@ -6719,7 +6722,7 @@ static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
>   
>   static void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec) {}
>   static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq) { return false; }
> -static void check_enqueue_throttle(struct cfs_rq *cfs_rq) {}
> +static void check_enqueue_throttle(struct cfs_rq *cfs_rq, int flags) {}
>   static inline void sync_throttle(struct task_group *tg, int cpu) {}
>   static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
>   static void task_throttle_setup_work(struct task_struct *p) {}
> 
>>   		list_add_leaf_cfs_rq(cfs_rq);
>>   #ifdef CONFIG_CFS_BANDWIDTH
>>   		if (cfs_rq->pelt_clock_throttled) {
>> @@ -5912,7 +5914,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
>>   	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list, throttle_node) {
>>   		list_del_init(&p->throttle_node);
>>   		p->throttled = false;
>> -		enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP);
>> +		enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP | ENQUEUE_THROTTLE);
>>   	}
>>   
>>   	/* Add cfs_rq with load or one or more already running entities to the list */
>> @@ -6029,15 +6031,18 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>>   	 * unthrottled us with a positive runtime_remaining but other still
>>   	 * running entities consumed those runtime before we reached here.
>>   	 *
>> -	 * Anyway, we can't unthrottle this cfs_rq without any runtime remaining
>> +	 * We can't unthrottle this cfs_rq without any runtime remaining
>>   	 * because any enqueue in tg_unthrottle_up() will immediately trigger a
>>   	 * throttle, which is not supposed to happen on unthrottle path.
>> +	 *
>> +	 * Although the ENQUEUE_THROTTLE flag ensures that enqueues in
>> +	 * tg_unthrottle_up() do not trigger a throttle, we still retain the check
>> +	 * for cfs_rq->runtime_remaining. This prevents the enqueueing of many
>> +	 * entities whose runtime_remaining is less than 0.
>>   	 */
>>   	if (cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0)
>>   		return;
>>   
>> -	se = cfs_rq->tg->se[cpu_of(rq)];
>> -
>>   	cfs_rq->throttled = 0;
>>   
>>   	update_rq_clock(rq);
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index e7718f12bc55..6f45e00d1fc2 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -2368,6 +2368,8 @@ extern const u32		sched_prio_to_wmult[40];
>>    * ENQUEUE_REPLENISH - CBS (replenish runtime and postpone deadline)
>>    * ENQUEUE_MIGRATED  - the task was migrated during wakeup
>>    * ENQUEUE_RQ_SELECTED - ->select_task_rq() was called
>> + * ENQUEUE_THROTTLE  - Called in tg_unthrottle_up() to ensure that
>> + *                     task can be enqueued during unthrottle
>>    *
>>    * XXX SAVE/RESTORE in combination with CLASS doesn't really make sense, but
>>    * SCHED_DEADLINE seems to rely on this for now.
>> @@ -2399,6 +2401,7 @@ extern const u32		sched_prio_to_wmult[40];
>>   #define ENQUEUE_MIGRATED	0x00040000
>>   #define ENQUEUE_INITIAL		0x00080000
>>   #define ENQUEUE_RQ_SELECTED	0x00100000
>> +#define ENQUEUE_THROTTLE	0x00200000
> 
> Another nit: now EN/DEQUEUE_THROTTLE is a pair, they could share the
> same value in low word?
> 

I will do it in the next version.

Thanks,
Hao


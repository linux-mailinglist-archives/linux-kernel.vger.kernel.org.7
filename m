Return-Path: <linux-kernel+bounces-868067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DDFC0445B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F0664EE3B5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1162F26E701;
	Fri, 24 Oct 2025 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Bz6cP7Y6"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACDD35B130
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761277223; cv=none; b=KEWrh9TG9jDfc0dMlS2shE8lrkBONVzSDcbLUPQ8p9GekF/mvjYEWP2n80hdJVsB5NZGzoun6ntChZK6OvVYA+ztxSH8qr7L1AjnR2bLQTLkWYFreeogYM0brtXpWlhPchUieAONex0aW/cV5arNhwuxvi0wKYc/X5ldcwJilfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761277223; c=relaxed/simple;
	bh=ZHYg6vfts3RcNUijteD3pJ346OgPuHnSxHcBr90oIUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4/oNO01Os0IirCpDPfnvcku00mnDxNeLjy5wykVG328UMbr0gNvwCrXg/edjlTCt8h1H8vHwEbvzQHW0ITlmSZ6/5DEPFpmsY2UpoTnomlFjNCssMPnqC0HG4/LGiyEFj6HJ7GlsxYJczpw0RZ1awAuEAqRpV3giq2i7aCcFFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Bz6cP7Y6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a2738daea2so1399936b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761277220; x=1761882020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7034aypiBs6xX0tnI8XuVSNFiEYBIyQsMVxChxtOb0I=;
        b=Bz6cP7Y6H50QufMNn8u0oGsdlDQVaqI1hoGhbwXT26s1svrcrPaeOhstWbIjKzQqC4
         6IhvmBgp408B0uXJ8BcT+EjbtLTp0IYbeYRdWNrW4k1kM6Y9qDLMx1fDcoSvw9N33cil
         gcRFZCtchhSlgdZQ2hkG0Y9jn0ckoelNxYZtTpuJ4qKCapDLzxEAq2BXNQADFQdjqeQo
         XYm/yUA3E0nWZckMC4YAXbTLNjPrI5/m8uT49GcndnPAXiFnI0b+QKQv5mGn6xF2MM/A
         mgJf9sxWVHLQc/lgeEP/kQfo8q9O/ancfEEVMBbsE1FIR+C5foNPgwtuPLjCTwR/JHOF
         BuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761277220; x=1761882020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7034aypiBs6xX0tnI8XuVSNFiEYBIyQsMVxChxtOb0I=;
        b=q4MZoxzBm9tVIreI23c8NhpyaddX/MmFBK+ElwMrYH3JEXAbiVnorSaRatoKdVXCd2
         e55C4p6vfEy8skLqvgh9JdWOkjwyafF/KLw9LxwU9MQ8E3CCy3tAwLwsZXq4xGJ13Amz
         Rsnc5TIUdjhqQFyv2CgsPdkKTfRcvEiZ9yECknKLg/G9W8PoBCT6JJkrhnI9dObI2PP8
         FwMc2PPvB7nJQyhIKvBAsKUNwTKadYwNVwyWoXvGYa+SRCFkeSy0dOgk6dZZZPAItyt7
         5ce1Su9cl2LVf97qlcXHlzwXhPCsnUvKhQQcFKBIWW4MuYY8noatK35/QO3sKaygKLRZ
         eQ0g==
X-Forwarded-Encrypted: i=1; AJvYcCVHqeF5N6FXIRmUKpaMeQagmAk4EZXQ/gTyL1zxUfKpNrhOTNO6aCCgW9SANcdL/b1BIliAl9fuI+RAujE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmVuW3LLYGpCD4nPrbP5iwgiOa8AeUNEFMvQg/YT8/trhaGRyT
	U8FTgWbe2M+ropO7AFY4ecWfS0zuUCjF9SEggvB9Ry1fK5EJXn1DFyEaCa4NvE99Iw==
X-Gm-Gg: ASbGnctgRIvANM8YA9UpGMKnw2iNEs1u73Y72CVULapeC8rWZcPB58Sr9d0yQ/IOy2C
	CRUGG7Y8QnVM4QuOElSjFNorph3+YbtfsPfTiwiViVDj3hzxKt7t7nDLamXZKN5tRXrK/MhhZkE
	3NR5fNC8VLh83v6hcIQFH2GXi4jo6xynjmpe+m3jlsGtGXt0f7igIYvHIqAAL7LN4f7JNnAHFRr
	lGNqJIlQ/ZW54qUIEJ6QTegMtjP2jNgY+G3VI7G70Pi431j+649JwBu4QTk7XOoq/AywAdlLn7f
	Y3EUbjzBrqbPXE9XTL+/ab01jd6TzfrMgax3Lb146q1DRw81kjFe15qOyWuvG4OGBdhetTIsjPY
	bNnbeftegE++20FA3nBCXappL+JszDXI6XyUPkl0N44uLqnk8ZKhzUrTIrQo+AO9Uh6H/ElGICJ
	DKn5XgiT3l6ixLtML2O9ql
X-Google-Smtp-Source: AGHT+IEL8/qVy8t20+4b3DhYeCHdC7eo0HiLilv2p6LeZJ1AIPCJ1bieILBMUmgWjNkZmJt68DaOuA==
X-Received: by 2002:a05:6a20:2451:b0:33b:5a3f:3cbe with SMTP id adf61e73a8af0-33b5a3f4c82mr10929001637.54.1761277219842;
        Thu, 23 Oct 2025 20:40:19 -0700 (PDT)
Received: from bytedance ([61.213.176.59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2247a7cfsm7400434a91.11.2025.10.23.20.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 20:40:19 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:39:55 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH] sched/fair: Fix non-empty throttled_limbo_list warning
 in tg_throttle_down()
Message-ID: <20251024033955.GA39@bytedance>
References: <20251023121213.38282-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023121213.38282-1-jiahao.kernel@gmail.com>

On Thu, Oct 23, 2025 at 08:12:13PM +0800, Hao Jia wrote:
> From: Hao Jia <jiahao1@lixiang.com>
> 
> Aaron Lu and I hit a non-empty throttled_limbo_list warning in
> tg_throttle_down() during testing.
> 
> WARNING: kernel/sched/fair.c:5975 at tg_throttle_down+0x2bd/0x2f0, CPU#20: swapper/20/0
> Call Trace:
>  ? __pfx_tg_nop+0x10/0x10
>  walk_tg_tree_from+0x39/0xd0
>  ? __pfx_tg_throttle_down+0x10/0x10
>  throttle_cfs_rq+0x176/0x1f0
>  enqueue_task_fair+0x4f5/0xd30
>  ? unthrottle_cfs_rq+0x2f7/0x3a0
>  tg_unthrottle_up+0x10c/0x2f0
>  ? __pfx_tg_unthrottle_up+0x10/0x10
>  walk_tg_tree_from+0x66/0xd0
>  ? __pfx_tg_nop+0x10/0x10
>  unthrottle_cfs_rq+0x16b/0x3a0
>  __cfsb_csd_unthrottle+0x1f0/0x250
>  ? __pfx___cfsb_csd_unthrottle+0x10/0x10
>  __flush_smp_call_function_queue+0x104/0x440
>  ? tick_nohz_account_idle_time+0x4c/0x80
>  flush_smp_call_function_queue+0x3b/0x80
>  do_idle+0x14f/0x240
>  cpu_startup_entry+0x30/0x40
>  start_secondary+0x128/0x160
>  common_startup_64+0x13e/0x141
> 
> cgroup hierarchy:
> 
>           root
>         /      \
>         A*     ...
>      /  |  \   ...
>         B* ...
> 
> Debugging shows the following:
> A and B are configured with relatively small quota and large period.
> 
> At some point, cfs_rq_A is throttled. Due to the throttling of cfs_rq_A,
> the tasks on cfs_rq_B are added to cfs_rq_B's throttled_limbo_list.
> 
> Resetting task_group B quota will set cfs_rq_B runtime_remaining to 0 in
> tg_set_cfs_bandwidth().
> Since task_group A is throttled, Therefore, task on cfs_rq_B cannot run,
> and runtime_remaining stays 0. With task_group B has a small quota,
> tasks on other CPUs in task_group B quickly consume all of
> cfs_b_B->runtime, causing cfs_b_B->runtime to be 0.
> 
> When cfs_rq_A is unthrottled later, tg_unthrottle_up(cfs_rq_B) will
> re-queues task. However, because cfs_rq_B->runtime_remaining still 0,
> and it cannot obtain runtime from cfs_b_B->runtime either. Therefore,
> the task will be throttled in
> enqueue_task_fair()->enqueue_entity()->check_enqueue_throttle(),
> triggering a non-empty throttled_limbo_list warning in tg_throttle_down().
> 
> Root Cause:
> In unthrottle_cfs_rq(), we only checked cfs_rq_A->runtime_remaining, but
> enqueue_task_fair() requires that the runtime_remaining of each cfs_rq
> level be greater than 0.
> 
> Solution:
> One way to fix this warning is to add a runtime_remaining check for
> each cfs_rq level of the task in unthrottle_cfs_rq(), but this makes code
> strange and complicated.
> Another straightforward and simple solution is to add a new enqueue flag
> to ensure that enqueue in tg_unthrottle_up() will not immediately trigger
> throttling. This may enqueue sched_entity with no remaining runtime, which
> is not a big deal because the current kernel also has such situations [1].
> 
> We still retain the runtime_remaining check in unthrottle_cfs_rq() for
> higher-level cfs_rq to avoid enqueuing many entities with
> runtime_remaining < 0.
> 
> Also remove the redundant assignment to se in tg_throttle_down().
> 
> [1]: https://lore.kernel.org/all/20251015084045.GB35@bytedance
> 
> Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
> Reported-by: Aaron Lu <ziqianlu@bytedance.com>
> Closes: https://lore.kernel.org/all/20251016065438.GA32@bytedance
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>

Tested-by: Aaron Lu <ziqianlu@bytedance.com>

> ---
> Reproduction steps:
> (1) Create a test.sh script and run it:
> #!/bin/bash
> set -e
> CGP_ROOT="/sys/fs/cgroup/"
> if ! mount | grep -q "type cgroup2"; then
> 	echo "ERROR: Not in cgroup v2 mode."
> 	exit 1
> fi
> echo 1 > /sys/kernel/debug/clear_warn_once
> mkdir -p ${CGP_ROOT}/test
> echo "+cpu +cpuset" > ${CGP_ROOT}/test/cgroup.subtree_control
> for i in $(seq 1 2); do
> 	SUB_DIR=${CGP_ROOT}/test/sub$i
> 	mkdir -p ${SUB_DIR}
> 	echo $$ > ${SUB_DIR}/cgroup.procs
> 	perf bench sched messaging -g 10 -t -l 50000 &
> 	echo $$ > /sys/fs/cgroup/cgroup.procs
> 	echo "1000 100000" > ${SUB_DIR}/cpu.max
> 	echo "Started stress in stress_sub$i"
> done
> echo "1000 100000" > ${CGP_ROOT}/test/cpu.max
> 
> (2) Run the following command multiple times until the warning is triggered:
> echo 1000 10000 > /sys/fs/cgroup/test/sub1/cpu.max
> 
>  kernel/sched/fair.c  | 15 ++++++++++-----
>  kernel/sched/sched.h |  3 +++
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b58e696d7ccc..7721466dc8f2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5287,7 +5287,9 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  	se->on_rq = 1;
>  
>  	if (cfs_rq->nr_queued == 1) {
> -		check_enqueue_throttle(cfs_rq);
> +		if (!(flags & ENQUEUE_THROTTLE))
> +			check_enqueue_throttle(cfs_rq);
> +

nit: might be better to place this check inside check_enqueue_throttle()
after cfs_bandwidth_used()? I was thinking: in this way, it might save
some cycles for systems with CONFIG_CFS_BANDWIDTH set but don't actually
set any quota.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 671cbf8dc00ee..688f74ee145c9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5229,7 +5229,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	se->deadline = se->vruntime + vslice;
 }
 
-static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
+static void check_enqueue_throttle(struct cfs_rq *cfs_rq, int flags);
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
 
 static void
@@ -5287,8 +5287,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	se->on_rq = 1;
 
 	if (cfs_rq->nr_queued == 1) {
-		if (!(flags & ENQUEUE_THROTTLE))
-			check_enqueue_throttle(cfs_rq);
+		check_enqueue_throttle(cfs_rq, flags);
 
 		list_add_leaf_cfs_rq(cfs_rq);
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -6408,7 +6407,7 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
  * expired/exceeded, otherwise it may be allowed to steal additional ticks of
  * runtime as update_curr() throttling can not trigger until it's on-rq.
  */
-static void check_enqueue_throttle(struct cfs_rq *cfs_rq)
+static void check_enqueue_throttle(struct cfs_rq *cfs_rq, int flags)
 {
 	if (!cfs_bandwidth_used())
 		return;
@@ -6421,6 +6420,10 @@ static void check_enqueue_throttle(struct cfs_rq *cfs_rq)
 	if (cfs_rq_throttled(cfs_rq))
 		return;
 
+	/* Do not attempt throttle on cfs_rq's unthrottle path */
+	if (flags & ENQUEUE_THROTTLE)
+		return;
+
 	/* update runtime allocation */
 	account_cfs_rq_runtime(cfs_rq, 0);
 	if (cfs_rq->runtime_remaining <= 0)
@@ -6719,7 +6722,7 @@ static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
 
 static void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec) {}
 static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq) { return false; }
-static void check_enqueue_throttle(struct cfs_rq *cfs_rq) {}
+static void check_enqueue_throttle(struct cfs_rq *cfs_rq, int flags) {}
 static inline void sync_throttle(struct task_group *tg, int cpu) {}
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
 static void task_throttle_setup_work(struct task_struct *p) {}

>  		list_add_leaf_cfs_rq(cfs_rq);
>  #ifdef CONFIG_CFS_BANDWIDTH
>  		if (cfs_rq->pelt_clock_throttled) {
> @@ -5912,7 +5914,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
>  	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list, throttle_node) {
>  		list_del_init(&p->throttle_node);
>  		p->throttled = false;
> -		enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP);
> +		enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP | ENQUEUE_THROTTLE);
>  	}
>  
>  	/* Add cfs_rq with load or one or more already running entities to the list */
> @@ -6029,15 +6031,18 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  	 * unthrottled us with a positive runtime_remaining but other still
>  	 * running entities consumed those runtime before we reached here.
>  	 *
> -	 * Anyway, we can't unthrottle this cfs_rq without any runtime remaining
> +	 * We can't unthrottle this cfs_rq without any runtime remaining
>  	 * because any enqueue in tg_unthrottle_up() will immediately trigger a
>  	 * throttle, which is not supposed to happen on unthrottle path.
> +	 *
> +	 * Although the ENQUEUE_THROTTLE flag ensures that enqueues in
> +	 * tg_unthrottle_up() do not trigger a throttle, we still retain the check
> +	 * for cfs_rq->runtime_remaining. This prevents the enqueueing of many
> +	 * entities whose runtime_remaining is less than 0.
>  	 */
>  	if (cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0)
>  		return;
>  
> -	se = cfs_rq->tg->se[cpu_of(rq)];
> -
>  	cfs_rq->throttled = 0;
>  
>  	update_rq_clock(rq);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e7718f12bc55..6f45e00d1fc2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2368,6 +2368,8 @@ extern const u32		sched_prio_to_wmult[40];
>   * ENQUEUE_REPLENISH - CBS (replenish runtime and postpone deadline)
>   * ENQUEUE_MIGRATED  - the task was migrated during wakeup
>   * ENQUEUE_RQ_SELECTED - ->select_task_rq() was called
> + * ENQUEUE_THROTTLE  - Called in tg_unthrottle_up() to ensure that
> + *                     task can be enqueued during unthrottle
>   *
>   * XXX SAVE/RESTORE in combination with CLASS doesn't really make sense, but
>   * SCHED_DEADLINE seems to rely on this for now.
> @@ -2399,6 +2401,7 @@ extern const u32		sched_prio_to_wmult[40];
>  #define ENQUEUE_MIGRATED	0x00040000
>  #define ENQUEUE_INITIAL		0x00080000
>  #define ENQUEUE_RQ_SELECTED	0x00100000
> +#define ENQUEUE_THROTTLE	0x00200000

Another nit: now EN/DEQUEUE_THROTTLE is a pair, they could share the
same value in low word?

>  
>  #define RETRY_TASK		((void *)-1UL)
>  
> -- 
> 2.34.1
> 


Return-Path: <linux-kernel+bounces-873213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3387AC13643
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BC294F9B71
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2DB23D7DC;
	Tue, 28 Oct 2025 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9HtBwp4"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073D87494
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761637937; cv=none; b=R7ZMMjg1tj5uUS0q+N1Ml1TWZbn1cgW6u+byR0CIr7i+wJI5IdWPEKA+8ggbgqWmX4WIt5pnQN8nE+OLC37WVDyPfGZOpD+OiaBHHIepkUZi/kfWrhq5L3Q7G9DhB4lsiBCvFZTHAM7P3gAIDuCpvv76V9I/D9ISRTzBh+ujKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761637937; c=relaxed/simple;
	bh=2TLsqKUAJSlIDwzNt67dPER1waoF14AO7+SemfjmG+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N+U05Etik+UMFYcdtYLc7DgNvHmcdfcl7d18DWzXK3BV0FT9mjTjah273m71fHDYMrm5IhSaZUASu0rHVGxlGJKTn4lfIU96Z87MbCrLVsOCG0H1d8V3d+7YBFFJu9X07Z1ElP8qf+50ei22g7kLpM0iDWhqkPtSUdZ7H+z6d6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9HtBwp4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-78118e163e5so5530588b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761637935; x=1762242735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSrokT66Tzvef7LKxyB0Zo+SNa0Wi31xGiDyrSyf8zc=;
        b=h9HtBwp4GABUAHdQCi6bEw+ILCGxhOf8wEn7KCNjyoCGg3ON7q+QzdBf9nnvRHO2A5
         XdNv6O1KKyJEgFp7a33rebYHersgoQ6iEjZiSiyjjbgSZQ/avmDO0BxCzvAzB+PKLzdp
         zvPYTrglU9+fYtg/mdzmHGiqmye5RzW+rjKMkd3i7dNHwwG9dzyx1UWHYZL2pbUTysrZ
         K3H3XBaAzmBuPQt1ERSlXZa1N7TRmEqk3PQFnk8F2FkNIzhuQK5wp2Y52I6zrsBjSShV
         0BkfJQ7WnOx/oBxIbUdjlE4w4tgQIP1JKG1AeD1B9YnknZuFeUxdjJ2JfVPEZingWcNQ
         x2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761637935; x=1762242735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSrokT66Tzvef7LKxyB0Zo+SNa0Wi31xGiDyrSyf8zc=;
        b=Yz25bta624Y6kT7vd43M8ETLu12keXfGt/shZjLm8WCNgw10D2c7AgFW2IY1uctbDf
         TCsRuGumrsJVyaAwEu2I66Og2UB1YPH800c8S6xfNwLfs0CtTrBwtsJj8ghGv0Sv9cEu
         bE0m6B0p7CgRjYCnzLJviIX1TbmdKa4YaCq0zkrvi9EWDKYZYgzms7OeiGm9GvpxCCER
         7VUPMMNpJ2iBiiF+JMbs5o2US6CUpxyip5qi2PhwDd2DC2iWnApfUqzm/GnkgKCEAQKl
         spy6gHfzbK0bopR1CgZet9O9QmaHNRRVVvW7xrru7hjHD/JKiwF/o9UjwG/08MT0uEfY
         21og==
X-Gm-Message-State: AOJu0Yxo/w5oo9vVv7G3rBAevLjDHHc7WaZoh+XW6DsjUKFRtRK1y8qJ
	tZvkim/I3itLnLpRP5kfvbWoy3BNi1LEu5wjSvamvXmAJrRj+8iB5oXJ
X-Gm-Gg: ASbGncsdNKvdqRACGqNQ4OHX4fYk7efCWBLEFbhx1BMhokC1Vgo1DSEQTgTc0PVw4Qr
	DpDRKsvLWR1bVc2zMKCKJ0fv30NVcBk4aYkUXK7Au7DOTgLNSfkMS3bADAZPBGKxEIZX1yBP+9S
	sUgPsae4lcNfNPc6M+buPHYp4vBTFQ3KsLJORnhYTglsP9V8yqKmsWrsv+u25+FdQjGM+Q7AWIU
	yYbU9s4Fnwi5HMggEkNGHo4Suw6CvhqRjX7rz1Sg8dNybHmU1VwNHVsYicdk3ygz30kLwUqFQLD
	3AMc/v7Nf5XKxdtfHZ1z9ozXM0RFwvHgXnhH7VZouASsVntaURQwGvszqE8FCWd5cs7fruBZmQy
	sDl1ZvkUeEuWevfBLlSJAC1ObTEK/PsnSHF+dfn/PlofJKI7wWs+HnI+CNOq2w8XS3QuQTFGpgU
	WFrznU3JE5MGmKe5+gWRP23jnqKCYp
X-Google-Smtp-Source: AGHT+IFYNjjjoGOGtE6HON2xoA0mB3Wb8oXEz+UAnqVBQTxvDo3pjaBpZ4cZenwodZn/LEf1PcxJcA==
X-Received: by 2002:a05:6300:6c04:b0:334:91ab:f189 with SMTP id adf61e73a8af0-344deddd4eamr1872441637.22.1761637935171;
        Tue, 28 Oct 2025 00:52:15 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414049290sm10525549b3a.34.2025.10.28.00.52.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Oct 2025 00:52:14 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	mingo@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com
Cc: linux-kernel@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>,
	Aaron Lu <ziqianlu@bytedance.com>
Subject: [PATCH v3] sched/fair: Fix non-empty throttled_limbo_list warning in tg_throttle_down()
Date: Tue, 28 Oct 2025 15:52:01 +0800
Message-Id: <20251028075201.71422-1-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hao Jia <jiahao1@lixiang.com>

Aaron Lu and I hit a non-empty throttled_limbo_list warning in
tg_throttle_down() during testing.

WARNING: kernel/sched/fair.c:5975 at tg_throttle_down+0x2bd/0x2f0, CPU#20: swapper/20/0
Call Trace:
 ? __pfx_tg_nop+0x10/0x10
 walk_tg_tree_from+0x39/0xd0
 ? __pfx_tg_throttle_down+0x10/0x10
 throttle_cfs_rq+0x176/0x1f0
 enqueue_task_fair+0x4f5/0xd30
 ? unthrottle_cfs_rq+0x2f7/0x3a0
 tg_unthrottle_up+0x10c/0x2f0
 ? __pfx_tg_unthrottle_up+0x10/0x10
 walk_tg_tree_from+0x66/0xd0
 ? __pfx_tg_nop+0x10/0x10
 unthrottle_cfs_rq+0x16b/0x3a0
 __cfsb_csd_unthrottle+0x1f0/0x250
 ? __pfx___cfsb_csd_unthrottle+0x10/0x10
 __flush_smp_call_function_queue+0x104/0x440
 ? tick_nohz_account_idle_time+0x4c/0x80
 flush_smp_call_function_queue+0x3b/0x80
 do_idle+0x14f/0x240
 cpu_startup_entry+0x30/0x40
 start_secondary+0x128/0x160
 common_startup_64+0x13e/0x141

cgroup hierarchy:

          root
        /      \
        A*     ...
     /  |  \   ...
        B* ...

Debugging shows the following:
A and B are configured with relatively small quota and large period.

At some point, cfs_rq_A is throttled. Due to the throttling of cfs_rq_A,
the tasks on cfs_rq_B are added to cfs_rq_B's throttled_limbo_list.

Resetting task_group B quota will set cfs_rq_B runtime_remaining to 0 in
tg_set_cfs_bandwidth().
Since task_group A is throttled, Therefore, task on cfs_rq_B cannot run,
and runtime_remaining stays 0. With task_group B has a small quota,
tasks on other CPUs in task_group B quickly consume all of
cfs_b_B->runtime, causing cfs_b_B->runtime to be 0.

When cfs_rq_A is unthrottled later, tg_unthrottle_up(cfs_rq_B) will
re-queues task. However, because cfs_rq_B->runtime_remaining still 0,
and it cannot obtain runtime from cfs_b_B->runtime either. Therefore,
the task will be throttled in
enqueue_task_fair()->enqueue_entity()->check_enqueue_throttle(),
triggering a non-empty throttled_limbo_list warning in tg_throttle_down().

Root Cause:
In unthrottle_cfs_rq(), we only checked cfs_rq_A->runtime_remaining, but
enqueue_task_fair() requires that the runtime_remaining of each cfs_rq
level be greater than 0.

Solution:
One way to fix this warning is to add a runtime_remaining check for
each cfs_rq level of the task in unthrottle_cfs_rq(), but this makes code
strange and complicated.
Another straightforward and simple solution is to add a new enqueue flag
to ensure that enqueue in tg_unthrottle_up() will not immediately trigger
throttling. This may enqueue sched_entity with no remaining runtime, which
is not a big deal because the current kernel also has such situations [1].

We still retain the runtime_remaining check in unthrottle_cfs_rq() for
higher-level cfs_rq to avoid enqueuing many entities with
runtime_remaining < 0.

Also remove the redundant assignment to se in tg_throttle_down().

[1]: https://lore.kernel.org/all/20251015084045.GB35@bytedance

Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
Suggested-by: Aaron Lu <ziqianlu@bytedance.com>
Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reported-by: Aaron Lu <ziqianlu@bytedance.com>
Closes: https://lore.kernel.org/all/20251016065438.GA32@bytedance
Signed-off-by: Hao Jia <jiahao1@lixiang.com>
---
v3:
  Make the dequeue_throttle flag comment more accurate, as suggested by Aaron Lu.

v2 Link: https://lore.kernel.org/all/20251027090534.94429-1-jiahao.kernel@gmail.com

 kernel/sched/fair.c  | 31 ++++++++++++++++++++++---------
 kernel/sched/sched.h |  7 ++++++-
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 273e2871b59e..67ce46c532e2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5229,7 +5229,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	se->deadline = se->vruntime + vslice;
 }
 
-static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
+static void check_enqueue_throttle(struct cfs_rq *cfs_rq, int flags);
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
 
 static void
@@ -5287,7 +5287,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	se->on_rq = 1;
 
 	if (cfs_rq->nr_queued == 1) {
-		check_enqueue_throttle(cfs_rq);
+		check_enqueue_throttle(cfs_rq, flags);
+
 		list_add_leaf_cfs_rq(cfs_rq);
 #ifdef CONFIG_CFS_BANDWIDTH
 		if (cfs_rq->pelt_clock_throttled) {
@@ -5912,7 +5913,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list, throttle_node) {
 		list_del_init(&p->throttle_node);
 		p->throttled = false;
-		enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP);
+		enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP | ENQUEUE_THROTTLE);
 	}
 
 	/* Add cfs_rq with load or one or more already running entities to the list */
@@ -6029,15 +6030,18 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	 * unthrottled us with a positive runtime_remaining but other still
 	 * running entities consumed those runtime before we reached here.
 	 *
-	 * Anyway, we can't unthrottle this cfs_rq without any runtime remaining
+	 * We can't unthrottle this cfs_rq without any runtime remaining
 	 * because any enqueue in tg_unthrottle_up() will immediately trigger a
 	 * throttle, which is not supposed to happen on unthrottle path.
+	 *
+	 * Although the ENQUEUE_THROTTLE flag ensures that enqueues in
+	 * tg_unthrottle_up() do not trigger a throttle, we still retain the check
+	 * for cfs_rq->runtime_remaining. This prevents the enqueueing of many
+	 * entities whose runtime_remaining is less than 0.
 	 */
 	if (cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0)
 		return;
 
-	se = cfs_rq->tg->se[cpu_of(rq)];
-
 	cfs_rq->throttled = 0;
 
 	update_rq_clock(rq);
@@ -6403,7 +6407,7 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
  * expired/exceeded, otherwise it may be allowed to steal additional ticks of
  * runtime as update_curr() throttling can not trigger until it's on-rq.
  */
-static void check_enqueue_throttle(struct cfs_rq *cfs_rq)
+static void check_enqueue_throttle(struct cfs_rq *cfs_rq, int flags)
 {
 	if (!cfs_bandwidth_used())
 		return;
@@ -6418,6 +6422,13 @@ static void check_enqueue_throttle(struct cfs_rq *cfs_rq)
 
 	/* update runtime allocation */
 	account_cfs_rq_runtime(cfs_rq, 0);
+	/*
+	 * Do not attempt to throttle on the cfs_rq unthrottle path.
+	 * and it must be placed after account_cfs_rq_runtime() to
+	 * prevent a possible missed start of the bandwidth timer.
+	 */
+	if (flags & ENQUEUE_THROTTLE)
+		return;
 	if (cfs_rq->runtime_remaining <= 0)
 		throttle_cfs_rq(cfs_rq);
 }
@@ -6724,7 +6735,7 @@ static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
 
 static void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec) {}
 static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq) { return false; }
-static void check_enqueue_throttle(struct cfs_rq *cfs_rq) {}
+static void check_enqueue_throttle(struct cfs_rq *cfs_rq, int flags) {}
 static inline void sync_throttle(struct task_group *tg, int cpu) {}
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
 static void task_throttle_setup_work(struct task_struct *p) {}
@@ -6926,6 +6937,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int h_nr_runnable = 1;
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 	int rq_h_nr_queued = rq->cfs.h_nr_queued;
+	int throttle_flag = flags & ENQUEUE_THROTTLE;
 	u64 slice = 0;
 
 	if (task_is_throttled(p) && enqueue_throttled_task(p))
@@ -6983,7 +6995,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = 1;
 
-		flags = ENQUEUE_WAKEUP;
+		/* Ensure ENQUEUE_THROTTLE flag can be propagated through the hierarchy */
+		flags = ENQUEUE_WAKEUP | throttle_flag;
 	}
 
 	for_each_sched_entity(se) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e7718f12bc55..ce838cb00990 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2364,6 +2364,10 @@ extern const u32		sched_prio_to_wmult[40];
  * CLASS - going to update p->sched_class; makes sched_change call the
  *         various switch methods.
  *
+ * THROTTLE - invoked in throttle_cfs_rq_work() during throttle for
+ *            accounting purpose, and in tg_unthrottle_up() to avoid
+ *            throttling when enqueuing tasks.
+ *
  * ENQUEUE_HEAD      - place at front of runqueue (tail if not specified)
  * ENQUEUE_REPLENISH - CBS (replenish runtime and postpone deadline)
  * ENQUEUE_MIGRATED  - the task was migrated during wakeup
@@ -2381,9 +2385,9 @@ extern const u32		sched_prio_to_wmult[40];
 #define DEQUEUE_MIGRATING	0x0010 /* Matches ENQUEUE_MIGRATING */
 #define DEQUEUE_DELAYED		0x0020 /* Matches ENQUEUE_DELAYED */
 #define DEQUEUE_CLASS		0x0040 /* Matches ENQUEUE_CLASS */
+#define DEQUEUE_THROTTLE	0x0080 /* Matches ENQUEUE_THROTTLE */
 
 #define DEQUEUE_SPECIAL		0x00010000
-#define DEQUEUE_THROTTLE	0x00020000
 
 #define ENQUEUE_WAKEUP		0x0001
 #define ENQUEUE_RESTORE		0x0002
@@ -2393,6 +2397,7 @@ extern const u32		sched_prio_to_wmult[40];
 #define ENQUEUE_MIGRATING	0x0010
 #define ENQUEUE_DELAYED		0x0020
 #define ENQUEUE_CLASS		0x0040
+#define ENQUEUE_THROTTLE	0x0080
 
 #define ENQUEUE_HEAD		0x00010000
 #define ENQUEUE_REPLENISH	0x00020000
-- 
2.34.1



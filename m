Return-Path: <linux-kernel+bounces-740295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B029B0D255
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52696546BC5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B672D3735;
	Tue, 22 Jul 2025 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EiElhnfV"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB782D0298
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167992; cv=none; b=Z3V52u8t3iF++a/rebB8T+3xrJ8yF71dTvLCtAuReOXkuRM4RtqwumlUCQ9jtsuolFEDtfxncyCnIo+CZtQq4aVCDCUDM/FPSVhCn+/jKxY+E1+p/pVAxUW3j8kTURrGtvSZUDLzuaemo5Gh1LaJIPANQ0i/pB09/BxVdNrkyeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167992; c=relaxed/simple;
	bh=GOWYSERoZTLMI76tmnWxpW0TD5uG7IHIEFycpOWm4go=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=by3RuVxN4wXQmrDQ6qBRbiSX2fgo54cnTqVt1obYpOjSsc+SA59hMqSe6rVFBfaxU4/KYWhgAcC42IsxktuOPle/aYgnAYT9CNJk9DxD6Z3HpEAon01wwgCSL1l0xEjYwkd6ghHygIZcnCOAKhKtch2zQW+s7buhAiVSQ5nYITo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EiElhnfV; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-234a102faa3so44527335ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753167990; x=1753772790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bEiDhtjgc/gNaq1IhSIXuUoLupESkFjxJm5qn1iyONU=;
        b=EiElhnfVbFzlO5oW8m+0OitifFfUxKk5txYZ6oaKnzCBUaDEHcdZosGMRA0UdSYV5A
         Z5f7MQnprFk0qSxlxLIMUUJ3zRBNRL6Qf00nmrYVG29CES4AplCszRI93yU/ICQvPVte
         PIMztNPyhyRih87Gzb4o5oeMcXPfketkdaj7Q/pDQYOhuJPs2RfqbttKMnC62G72mTuT
         sTsucK0i9VqZ+Rr61ciLwgdiTDIrTU66pD3Le+ER0i+rd57Q55VmZU9zQnMto3dmj2BI
         w3ar8nHyOr7vyjF5ithy8C5UQ06+MGMn2UB5gadPjib2LRSeDuUR3/tI+DwC+iuvPtzx
         nRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753167990; x=1753772790;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bEiDhtjgc/gNaq1IhSIXuUoLupESkFjxJm5qn1iyONU=;
        b=JxsR2Re60hpVFYn0XpBtmX3+pquRGltPNjB7/DZKWU0WLwoJgUj05BJg3hIUDaaBLK
         s2lPO/i6Ka9CLRZ2FnOMZtfeIaLvYHGObBXKvk+VDQLfVPs6O0/qwuHkKgoOJe85tAQg
         P++St/qOke67ByoxU96lIqgaPjan1qRQOEP/P1h4KcW0dDtc0BLTxCcP71RgVUHNBOj9
         T4dIJrqsvjDJLEJ2JeKQRNEdpslBes3KfRQiIw/TryD39vTSx+iiVD+Pa2Hk/VGygQmQ
         nCyidbylQ1AiIdvQpo5gXS0RnoeiKRflPgaUUTi5AkQ4rPW6OsrhwPDIp3pAKDTyLVw3
         fATQ==
X-Gm-Message-State: AOJu0Yx/uA3/ma+Bk6dxG+3hKXERTxhWbI2TS8nIR8jk/IWm4rjbT3IX
	ibdqfKDS3xtujhtn9B0qt79yOTYfGyL20SWgjJLwzHpUTJPKrMBLAugLoMBCMadfWbvNdj8YRYi
	lUxAksyc/A5BN4WMc8fnyw4AdiJXEEugcLiBBjOmbhp0MFcCs8vTpL+DrehOPEb8L3bsLJF4eiD
	0LPzKc8GluVFl+tFWYiMlD3GEUEY/i6DLi08wPkO4sp8IRN+Rr
X-Google-Smtp-Source: AGHT+IGnMe8LJH39aMo3nbUdeHwj15rcy4s1iCLSlesNTPVNl1oC+1k9Last8v5G/blyEQh/oBMUrmEZlvG7
X-Received: from pjbrs12.prod.google.com ([2002:a17:90b:2b8c:b0:312:187d:382d])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19e7:b0:234:ed31:fc94
 with SMTP id d9443c01a7336-23e24f4af16mr339588185ad.26.1753167989581; Tue, 22
 Jul 2025 00:06:29 -0700 (PDT)
Date: Tue, 22 Jul 2025 07:05:51 +0000
In-Reply-To: <20250722070600.3267819-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722070600.3267819-1-jstultz@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722070600.3267819-6-jstultz@google.com>
Subject: [RFC][PATCH v20 5/6] sched: Add blocked_donor link to task for
 smarter mutex handoffs
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Valentin Schneider <valentin.schneider@arm.com>, "Connor O'Brien" <connoro@google.com>, 
	John Stultz <jstultz@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

From: Peter Zijlstra <peterz@infradead.org>

Add link to the task this task is proxying for, and use it so
the mutex owner can do an intelligent hand-off of the mutex to
the task that the owner is running on behalf.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: This patch was split out from larger proxy patch]
Signed-off-by: John Stultz <jstultz@google.com>
---
v5:
* Split out from larger proxy patch
v6:
* Moved proxied value from earlier patch to this one where it
  is actually used
* Rework logic to check sched_proxy_exec() instead of using ifdefs
* Moved comment change to this patch where it makes sense
v7:
* Use more descriptive term then "us" in comments, as suggested
  by Metin Kaya.
* Minor typo fixup from Metin Kaya
* Reworked proxied variable to prev_not_proxied to simplify usage
v8:
* Use helper for donor blocked_on_state transition
v9:
* Re-add mutex lock handoff in the unlock path, but only when we
  have a blocked donor
* Slight reword of commit message suggested by Metin
v18:
* Add task_init initialization for blocked_donor, suggested by
  Suleiman

Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: kuyo chang <kuyo.chang@mediatek.com>
Cc: hupu <hupu.gm@gmail.com>
Cc: kernel-team@android.com
---
 include/linux/sched.h  |  1 +
 init/init_task.c       |  1 +
 kernel/fork.c          |  1 +
 kernel/locking/mutex.c | 41 ++++++++++++++++++++++++++++++++++++++---
 kernel/sched/core.c    | 18 ++++++++++++++++--
 5 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ced001f889519..675e2f89ec0f8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1239,6 +1239,7 @@ struct task_struct {
 
 	enum blocked_on_state		blocked_on_state;
 	struct mutex			*blocked_on;	/* lock we're blocked on */
+	struct task_struct		*blocked_donor;	/* task that is boosting this task */
 	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
diff --git a/init/init_task.c b/init/init_task.c
index 6d72ec23410a6..627bbd8953e88 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -175,6 +175,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 						 &init_task.alloc_lock),
 #endif
 	.blocked_on_state = BO_RUNNABLE,
+	.blocked_donor = NULL,
 #ifdef CONFIG_RT_MUTEXES
 	.pi_waiters	= RB_ROOT_CACHED,
 	.pi_top_task	= NULL,
diff --git a/kernel/fork.c b/kernel/fork.c
index 5eacb25a0c5ab..61a2ac850faf0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2126,6 +2126,7 @@ __latent_entropy struct task_struct *copy_process(
 
 	p->blocked_on_state = BO_RUNNABLE;
 	p->blocked_on = NULL; /* not blocked yet */
+	p->blocked_donor = NULL; /* nobody is boosting p yet */
 
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index b5145ddaec242..da6e964498ad0 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -926,7 +926,7 @@ EXPORT_SYMBOL_GPL(ww_mutex_lock_interruptible);
  */
 static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigned long ip)
 {
-	struct task_struct *next = NULL;
+	struct task_struct *donor, *next = NULL;
 	DEFINE_WAKE_Q(wake_q);
 	unsigned long owner;
 	unsigned long flags;
@@ -945,6 +945,12 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		MUTEX_WARN_ON(__owner_task(owner) != current);
 		MUTEX_WARN_ON(owner & MUTEX_FLAG_PICKUP);
 
+		if (sched_proxy_exec() && current->blocked_donor) {
+			/* force handoff if we have a blocked_donor */
+			owner = MUTEX_FLAG_HANDOFF;
+			break;
+		}
+
 		if (owner & MUTEX_FLAG_HANDOFF)
 			break;
 
@@ -958,7 +964,34 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	debug_mutex_unlock(lock);
-	if (!list_empty(&lock->wait_list)) {
+
+	if (sched_proxy_exec()) {
+		raw_spin_lock(&current->blocked_lock);
+		/*
+		 * If we have a task boosting current, and that task was boosting
+		 * current through this lock, hand the lock to that task, as that
+		 * is the highest waiter, as selected by the scheduling function.
+		 */
+		donor = current->blocked_donor;
+		if (donor) {
+			struct mutex *next_lock;
+
+			raw_spin_lock_nested(&donor->blocked_lock, SINGLE_DEPTH_NESTING);
+			next_lock = __get_task_blocked_on(donor);
+			if (next_lock == lock) {
+				next = donor;
+				__set_blocked_on_waking(donor);
+				wake_q_add(&wake_q, donor);
+				current->blocked_donor = NULL;
+			}
+			raw_spin_unlock(&donor->blocked_lock);
+		}
+	}
+
+	/*
+	 * Failing that, pick any on the wait list.
+	 */
+	if (!next && !list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
 		struct mutex_waiter *waiter =
 			list_first_entry(&lock->wait_list,
@@ -966,7 +999,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
 		next = waiter->task;
 
-		raw_spin_lock(&next->blocked_lock);
+		raw_spin_lock_nested(&next->blocked_lock, SINGLE_DEPTH_NESTING);
 		debug_mutex_wake_waiter(lock, waiter);
 		WARN_ON_ONCE(__get_task_blocked_on(next) != lock);
 		__set_blocked_on_waking(next);
@@ -977,6 +1010,8 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
 
+	if (sched_proxy_exec())
+		raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1c249d1d62f5a..2c3a4b9518927 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6823,7 +6823,17 @@ static inline bool proxy_can_run_here(struct rq *rq, struct task_struct *p)
  * Find runnable lock owner to proxy for mutex blocked donor
  *
  * Follow the blocked-on relation:
- *   task->blocked_on -> mutex->owner -> task...
+ *
+ *                ,-> task
+ *                |     | blocked-on
+ *                |     v
+ *  blocked_donor |   mutex
+ *                |     | owner
+ *                |     v
+ *                `-- task
+ *
+ * and set the blocked_donor relation, this latter is used by the mutex
+ * code to find which (blocked) task to hand-off to.
  *
  * Lock order:
  *
@@ -6987,6 +6997,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 		 * rq, therefore holding @rq->lock is sufficient to
 		 * guarantee its existence, as per ttwu_remote().
 		 */
+		owner->blocked_donor = p;
 	}
 
 	WARN_ON_ONCE(owner && !owner->on_rq);
@@ -7083,6 +7094,7 @@ static void __sched notrace __schedule(int sched_mode)
 	unsigned long prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
+	bool prev_not_proxied;
 	int cpu;
 
 	trace_sched_entry_tp(preempt, CALLER_ADDR0);
@@ -7154,9 +7166,11 @@ static void __sched notrace __schedule(int sched_mode)
 		switch_count = &prev->nvcsw;
 	}
 
+	prev_not_proxied = !prev->blocked_donor;
 pick_again:
 	next = pick_next_task(rq, rq->donor, &rf);
 	rq_set_donor(rq, next);
+	next->blocked_donor = NULL;
 	if (unlikely(task_is_blocked(next))) {
 		next = find_proxy_task(rq, next, &rf);
 		if (!next) {
@@ -7220,7 +7234,7 @@ static void __sched notrace __schedule(int sched_mode)
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
 		/* In case next was already curr but just got blocked_donor */
-		if (!task_current_donor(rq, next))
+		if (prev_not_proxied && next->blocked_donor)
 			proxy_tag_curr(rq, next);
 
 		rq_unpin_lock(rq, &rf);
-- 
2.50.0.727.gbf7dc18ff4-goog



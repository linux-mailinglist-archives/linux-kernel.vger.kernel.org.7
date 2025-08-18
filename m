Return-Path: <linux-kernel+bounces-774544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D38BB2B400
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C40B1B28519
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF9E27B4FA;
	Mon, 18 Aug 2025 22:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4bkba2m9"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD4B27E7DA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755555192; cv=none; b=QDLy+gXSEbYtsW6groN6eEeaUnhVzyd2tP3TL9t3+Ui5xNServO3ZdbpP0T6j4xJ8WCxkhGoo6UPrCWf4TdXfTmtPcm1KGcmJyHBon/b0PzpdbK9+v+8mzxWaPNYUydCLV0Ij/xapVSFHwsUcItBIhOuenF+XR2jHBa0TdQ1fyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755555192; c=relaxed/simple;
	bh=VDDK279uoa+uOoXKaVQ4D9zhePDZ4Zhtkph9IiOXlBQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dN8GZphC+c6s81HerqbQgIEM736E2cIQhnsqh/Jw/Jxjg7ltvq9/A6xF6utY5PGDtpWjOg5/s7gM2TkieZwrf1CoO1arNZNPM/dMILZQKwap+xzmjLCVJUJc4lRpSCeOA09HqkfHiY+WfjxUQr4vJ8U9z9BB5LQFGzR6tbyB7ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4bkba2m9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2445806eab4so46983135ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755555190; x=1756159990; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFRTxhImeVc7v9MnOn784y9jmoVxz0NA9iOLuwegT4Q=;
        b=4bkba2m9hA+ZrKZvZWlMB51W+8yDX8aB0c/1h9aGW3rgB8YSMWoU7THQqCTd345k6t
         ciRg2Y6HOUZGjXGkS4oWpdPytQ60x2cnzE5J3Vw4M7qQ0Kku/ye3tDZ7uOfe4La8d2Rc
         /d1CUjdkiIkBg2URTHS0nj78RnnFfrh9JQ+979KroPSPSWdBe/jiFRT6yWJcR1UO3mz7
         ewIyqqVaaMnvsUO3txV9NGXAb/ysWagTo+kkBNaZH+NfbFKBYmmmzx/ETLG/vvsXDtPh
         vvHwlSIxmRn+l1g15x/24JJ2Jkc4Fx0DfRNUmds1Ss5AKvRwd/SS6TAvqIaDEVQWOpI0
         YIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755555190; x=1756159990;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFRTxhImeVc7v9MnOn784y9jmoVxz0NA9iOLuwegT4Q=;
        b=PgOIUnY0qkS+WG1C88p118GrqFLBnq7UhwYVzpcfT87emHgc6t/6QG72sqzxQwu6Y/
         L7pUsdJ7hb7OsmuDLmvqQswbF8IpLZuEOBy6cBCaN3v8Z5WO+YOHY5jnPlAg9OWRP+RY
         eRYElKeVeyMlN4KPqiyTNxLPE14fLXisZzXjwAf+5LGQ+WSnXiGTTfbZY9pHFeTksFnF
         zppT6g+PsAWQspJyRPWWujaOQ1/j1UFOd3QCo6n+dW6b+pHi9TNJNVCgR2LVEAlfJ/2z
         0mcp0ms24LBqBsXiZNpUXHNqyW4fafUXhjqAeH2o51cXFyecOHomMhqAll7eNEMRO+VB
         8G/Q==
X-Gm-Message-State: AOJu0YxpIkG94IFT7Ebw//5uFzJe5MhauNI5MMkAgn8rgIF6U0doKnPy
	1LF8PCF1vuDv9WYXH9BlKV2tXFGHuhudUuHiNcPr5Dy3xrGFppjS9bnIZmTtcAhrsfeYfVrtquM
	0IHfqUYqR+02yyenOzRh4UNYiIJCZmxSa5mRClC2Q+f3K6sp2jHUHSNVomlsyqTGzdJTP8zM3yd
	uebtNVXWDCVG81zLtBaUr+t9IRfUC1/1V/dSgkzcpZGPmtTHmZ
X-Google-Smtp-Source: AGHT+IF+h3AF529qkH4me/VhBo8H2Veplh9JmFeUgVlK2ewgMIh7x7aGvmPZONz2Rzm+/MS2BEkm/DuEGRVn
X-Received: from pjbsy14.prod.google.com ([2002:a17:90b:2d0e:b0:31e:c1fb:dbb2])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d548:b0:23f:cd4d:a91a
 with SMTP id d9443c01a7336-245e0486bc3mr2855705ad.30.1755555190035; Mon, 18
 Aug 2025 15:13:10 -0700 (PDT)
Date: Mon, 18 Aug 2025 22:12:55 +0000
In-Reply-To: <20250818221300.2948078-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818221300.2948078-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818221300.2948078-6-jstultz@google.com>
Subject: [PATCH v21 5/6] sched: Add blocked_donor link to task for smarter
 mutex handoffs
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
index 5801de1a44a79..ab12eb738c440 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1242,6 +1242,7 @@ struct task_struct {
 
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
index 4bd0731995e86..86fe43ee35952 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2131,6 +2131,7 @@ __latent_entropy struct task_struct *copy_process(
 
 	p->blocked_on_state = BO_RUNNABLE;
 	p->blocked_on = NULL; /* not blocked yet */
+	p->blocked_donor = NULL; /* nobody is boosting p yet */
 
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 42e4d2e6e4ad4..76cba3580fce7 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -921,7 +921,7 @@ EXPORT_SYMBOL_GPL(ww_mutex_lock_interruptible);
  */
 static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigned long ip)
 {
-	struct task_struct *next = NULL;
+	struct task_struct *donor, *next = NULL;
 	DEFINE_WAKE_Q(wake_q);
 	unsigned long owner;
 	unsigned long flags;
@@ -940,6 +940,12 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
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
 
@@ -953,7 +959,34 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
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
@@ -961,7 +994,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
 		next = waiter->task;
 
-		raw_spin_lock(&next->blocked_lock);
+		raw_spin_lock_nested(&next->blocked_lock, SINGLE_DEPTH_NESTING);
 		debug_mutex_wake_waiter(lock, waiter);
 		WARN_ON_ONCE(__get_task_blocked_on(next) != lock);
 		__set_blocked_on_waking(next);
@@ -972,6 +1005,8 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
 
+	if (sched_proxy_exec())
+		raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0f824446c6046..cac03f68cbcce 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6829,7 +6829,17 @@ static inline bool proxy_can_run_here(struct rq *rq, struct task_struct *p)
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
@@ -6989,6 +6999,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 		 * rq, therefore holding @rq->lock is sufficient to
 		 * guarantee its existence, as per ttwu_remote().
 		 */
+		owner->blocked_donor = p;
 	}
 
 	WARN_ON_ONCE(owner && !owner->on_rq);
@@ -7091,6 +7102,7 @@ static void __sched notrace __schedule(int sched_mode)
 	unsigned long prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
+	bool prev_not_proxied;
 	int cpu;
 
 	/* Trace preemptions consistently with task switches */
@@ -7163,9 +7175,11 @@ static void __sched notrace __schedule(int sched_mode)
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
@@ -7229,7 +7243,7 @@ static void __sched notrace __schedule(int sched_mode)
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
 		/* In case next was already curr but just got blocked_donor */
-		if (!task_current_donor(rq, next))
+		if (prev_not_proxied && next->blocked_donor)
 			proxy_tag_curr(rq, next);
 
 		rq_unpin_lock(rq, &rf);
-- 
2.51.0.rc1.167.g924127e9c0-goog



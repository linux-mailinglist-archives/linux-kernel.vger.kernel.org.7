Return-Path: <linux-kernel+bounces-740291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B57C7B0D252
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9C91AA711D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FF12BF3CF;
	Tue, 22 Jul 2025 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SfgK2FYP"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382F628C5B7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167986; cv=none; b=YgXhZLt2vhxpGh5RyLiNHC9EIqXwSO3HVS8sV7aCvYpW2ArwcvAF5W/NY9XS8SDTVmhTzB8EgJFzRC1cKBFYm0q7JCs4SxtrZkVx2k1JPd7sRf9flu2bxx3Ur2o4RfcdgGT/2V2vVo5G2F9kDEp2WGuUdqdDBCmaR5Xp8LMPzTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167986; c=relaxed/simple;
	bh=Psje1mevto8pvfTGZDIRWudsoohBi3eL3m8reKu6Ibk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VKRkgnzNmxUaMWZEAyiWohhh+a4U7A4P9/jcy/a3wLu7YFzzcrGn1GUQrQ5uhevHEw3GVM4Y0RkOomy5/ilTMO2wvqjqswF6q2bv8c4hpB9kXdZGtDv44i1EGENU0+9xTWT0Ka7spO8PtYvx8JlemNpcUmgLw7jcz7Tm7W9bn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SfgK2FYP; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311e98ee3fcso6710684a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753167983; x=1753772783; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kgnC2RSp82VPUFN2J9NjiMcyGkCawwSWUklDc5Bbz1Q=;
        b=SfgK2FYP/nk3/vlrs06i0SR/CO/WZN4fSWMnmjd6Y5HlPWeT8kBVCjv6NX5aiL2ekT
         V2r8JVfMhCOcTIU06DonfYc5KHQKuc3wMC7mUMXiUfwZ5F0jo0aPqKpnpaFDDgDcoQWu
         xrEw1HAB2nENqN3xLmt1bTf0e1dovrrRH3/WZdQb7HDLdxQ+9c87+kzoyRUrce/do17m
         V3fj8p4qZQR4IZ+vt8XZM19FEn4qI2cJ+n+eqycE26XyTxeh/aNHwYbV804ceh5qR2uk
         H24nd8JM/CjL81p8qcp1/szP0ipzR3G4SjB9NXn9aw52ILEVz7hlhBhKrLEts40q3dX0
         B2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753167983; x=1753772783;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kgnC2RSp82VPUFN2J9NjiMcyGkCawwSWUklDc5Bbz1Q=;
        b=k5IrMXXBWU5GxcrdLKNdD9EjzUIjicYKjuToPQt4bn9TMRPmsurguDAGGXIzL8v1UL
         V9UG+qn07HsnTUx1BbKaopLC/d0o4CcU2TAy11HQfXbZwtJMFV+QTNNvyWAFJwruecsf
         mwb9xzlgrdegs2BPn1rsc8uP/7wyu536iV2WEwCiClFatdDUQhTI/Jc+oLYGesBkUed7
         mTq1JP+3XERdxBUJr0SFsYy3y9whrl7pm5Vm6FzZXNsfcm+9xJ+WltAUJcvb0NiD4HJw
         cCK1Q+Cu0ZkCa6H7xNMszhpvk2GgZSJAOoffM9sRervugZn2bxpco1T9wqKlnCEbXLGl
         JlRA==
X-Gm-Message-State: AOJu0YxkF0lfhw+H1TVqu5dzP1h7C+5MlNxvONkFmArD+cqaMXtJHm4p
	LutAgvRDcbFP1QkCM2HB2BfYB95+4enMg7yGp03A/981v0XU8KTdqTg4QPVnnY2PlNakzjO2s1e
	ZKbgw1s3C/m/6t3tXULhuh8goBgHGxutwXuWftW8FRlaa9LXsyQfndw0kjY4oAiERqAvBsf4fiz
	yhDw/WxnSBHMor/Zr3HoSXcCSY4WLg7tKzWnb8QwqRpHfnX3eM
X-Google-Smtp-Source: AGHT+IEOeXOm3UfqBlfcHumMae4Hcv86E6kn1yAwIDIX+H3sk3NX6tJUhFnovBs/5EmdF1yB9V294bn7ffAU
X-Received: from pjbqa6.prod.google.com ([2002:a17:90b:4fc6:b0:315:f140:91a5])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:350a:b0:311:a5ab:3d47
 with SMTP id 98e67ed59e1d1-31e3e0fe307mr3757897a91.1.1753167982923; Tue, 22
 Jul 2025 00:06:22 -0700 (PDT)
Date: Tue, 22 Jul 2025 07:05:47 +0000
In-Reply-To: <20250722070600.3267819-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722070600.3267819-1-jstultz@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722070600.3267819-2-jstultz@google.com>
Subject: [RFC][PATCH v20 1/6] locking: Add task::blocked_lock to serialize
 blocked_on state
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
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

So far, we have been able to utilize the mutex::wait_lock
for serializing the blocked_on state, but when we move to
proxying across runqueues, we will need to add more state
and a way to serialize changes to this state in contexts
where we don't hold the mutex::wait_lock.

So introduce the task::blocked_lock, which nests under the
mutex::wait_lock in the locking order, and rework the locking
to use it.

Signed-off-by: John Stultz <jstultz@google.com>
---
v15:
* Split back out into later in the series
v16:
* Fixups to mark tasks unblocked before sleeping in
  mutex_optimistic_spin()
* Rework to use guard() as suggested by Peter
v19:
* Rework logic for PREEMPT_RT issues reported by
  K Prateek Nayak

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
 include/linux/sched.h     | 25 ++++++++++++++++++-------
 init/init_task.c          |  1 +
 kernel/fork.c             |  1 +
 kernel/locking/mutex.c    | 34 ++++++++++++++++++++++------------
 kernel/locking/ww_mutex.h |  6 ++++--
 kernel/sched/core.c       |  4 +++-
 6 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5b4e1cd52e27a..a6654948d264f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1232,6 +1232,7 @@ struct task_struct {
 #endif
 
 	struct mutex			*blocked_on;	/* lock we're blocked on */
+	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
 	/*
@@ -2145,8 +2146,8 @@ static inline void __set_task_blocked_on(struct task_struct *p, struct mutex *m)
 	WARN_ON_ONCE(!m);
 	/* The task should only be setting itself as blocked */
 	WARN_ON_ONCE(p != current);
-	/* Currently we serialize blocked_on under the mutex::wait_lock */
-	lockdep_assert_held_once(&m->wait_lock);
+	/* Currently we serialize blocked_on under the task::blocked_lock */
+	lockdep_assert_held_once(&p->blocked_lock);
 	/*
 	 * Check ensure we don't overwrite existing mutex value
 	 * with a different mutex. Note, setting it to the same
@@ -2158,15 +2159,14 @@ static inline void __set_task_blocked_on(struct task_struct *p, struct mutex *m)
 
 static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)
 {
-	guard(raw_spinlock_irqsave)(&m->wait_lock);
+	guard(raw_spinlock_irqsave)(&p->blocked_lock);
 	__set_task_blocked_on(p, m);
 }
 
 static inline void __clear_task_blocked_on(struct task_struct *p, struct mutex *m)
 {
-	WARN_ON_ONCE(!m);
-	/* Currently we serialize blocked_on under the mutex::wait_lock */
-	lockdep_assert_held_once(&m->wait_lock);
+	/* Currently we serialize blocked_on under the task::blocked_lock */
+	lockdep_assert_held_once(&p->blocked_lock);
 	/*
 	 * There may be cases where we re-clear already cleared
 	 * blocked_on relationships, but make sure we are not
@@ -2178,8 +2178,15 @@ static inline void __clear_task_blocked_on(struct task_struct *p, struct mutex *
 
 static inline void clear_task_blocked_on(struct task_struct *p, struct mutex *m)
 {
-	guard(raw_spinlock_irqsave)(&m->wait_lock);
+	guard(raw_spinlock_irqsave)(&p->blocked_lock);
+	__clear_task_blocked_on(p, m);
+}
+
+static inline void clear_task_blocked_on_nested(struct task_struct *p, struct mutex *m)
+{
+	raw_spin_lock_nested(&p->blocked_lock, SINGLE_DEPTH_NESTING);
 	__clear_task_blocked_on(p, m);
+	raw_spin_unlock(&p->blocked_lock);
 }
 #else
 static inline void __clear_task_blocked_on(struct task_struct *p, struct rt_mutex *m)
@@ -2189,6 +2196,10 @@ static inline void __clear_task_blocked_on(struct task_struct *p, struct rt_mute
 static inline void clear_task_blocked_on(struct task_struct *p, struct rt_mutex *m)
 {
 }
+
+static inline void clear_task_blocked_on_nested(struct task_struct *p, struct rt_mutex *m)
+{
+}
 #endif /* !CONFIG_PREEMPT_RT */
 
 static __always_inline bool need_resched(void)
diff --git a/init/init_task.c b/init/init_task.c
index e557f622bd906..7e29d86153d9f 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -140,6 +140,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.journal_info	= NULL,
 	INIT_CPU_TIMERS(init_task)
 	.pi_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.pi_lock),
+	.blocked_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.blocked_lock),
 	.timer_slack_ns = 50000, /* 50 usec default slack */
 	.thread_pid	= &init_struct_pid,
 	.thread_node	= LIST_HEAD_INIT(init_signals.thread_head),
diff --git a/kernel/fork.c b/kernel/fork.c
index 5f87f05aff4a0..6a294e6ee105d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2025,6 +2025,7 @@ __latent_entropy struct task_struct *copy_process(
 	ftrace_graph_init_task(p);
 
 	rt_mutex_init_task(p);
+	raw_spin_lock_init(&p->blocked_lock);
 
 	lockdep_assert_irqs_enabled();
 #ifdef CONFIG_PROVE_LOCKING
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 80d778fedd605..2ab6d291696e8 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -614,6 +614,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	}
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	raw_spin_lock(&current->blocked_lock);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
@@ -657,7 +658,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		 * the handoff.
 		 */
 		if (__mutex_trylock(lock))
-			goto acquired;
+			break;
 
 		/*
 		 * Check for signals and kill conditions while holding
@@ -675,18 +676,21 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 				goto err;
 		}
 
+		raw_spin_unlock(&current->blocked_lock);
 		raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 
 		schedule_preempt_disabled();
 
 		first = __mutex_waiter_is_first(lock, &waiter);
 
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
+		raw_spin_lock(&current->blocked_lock);
 		/*
 		 * As we likely have been woken up by task
 		 * that has cleared our blocked_on state, re-set
 		 * it to the lock we are trying to acquire.
 		 */
-		set_task_blocked_on(current, lock);
+		__set_task_blocked_on(current, lock);
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -697,23 +701,27 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			break;
 
 		if (first) {
-			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
+			bool opt_acquired;
+
 			/*
 			 * mutex_optimistic_spin() can call schedule(), so
-			 * clear blocked on so we don't become unselectable
+			 * we need to release these locks before calling it,
+			 * and clear blocked on so we don't become unselectable
 			 * to run.
 			 */
-			clear_task_blocked_on(current, lock);
-			if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
+			__clear_task_blocked_on(current, lock);
+			raw_spin_unlock(&current->blocked_lock);
+			raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
+			opt_acquired = mutex_optimistic_spin(lock, ww_ctx, &waiter);
+			raw_spin_lock_irqsave(&lock->wait_lock, flags);
+			raw_spin_lock(&current->blocked_lock);
+			__set_task_blocked_on(current, lock);
+			if (opt_acquired)
 				break;
-			set_task_blocked_on(current, lock);
 			trace_contention_begin(lock, LCB_F_MUTEX);
 		}
-
-		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	}
-	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-acquired:
 	__clear_task_blocked_on(current, lock);
 	__set_current_state(TASK_RUNNING);
 
@@ -739,6 +747,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
+	raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 	preempt_enable();
 	return 0;
@@ -750,6 +759,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 err_early_kill:
 	WARN_ON(__get_task_blocked_on(current));
 	trace_contention_end(lock, ret);
+	raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
@@ -959,7 +969,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		next = waiter->task;
 
 		debug_mutex_wake_waiter(lock, waiter);
-		__clear_task_blocked_on(next, lock);
+		clear_task_blocked_on(next, lock);
 		wake_q_add(&wake_q, next);
 	}
 
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 086fd5487ca77..bf13039fb2a04 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -289,7 +289,8 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 		 * blocked_on pointer. Otherwise we can see circular
 		 * blocked_on relationships that can't resolve.
 		 */
-		__clear_task_blocked_on(waiter->task, lock);
+		 /* nested as we should hold current->blocked_lock already */
+		clear_task_blocked_on_nested(waiter->task, lock);
 		wake_q_add(wake_q, waiter->task);
 	}
 
@@ -343,7 +344,8 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 			 * blocked_on pointer. Otherwise we can see circular
 			 * blocked_on relationships that can't resolve.
 			 */
-			__clear_task_blocked_on(owner, lock);
+			/* nested as we should hold current->blocked_lock already */
+			clear_task_blocked_on_nested(owner, lock);
 			wake_q_add(wake_q, owner);
 		}
 		return true;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f7f576ad9b223..52c0f16aab101 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6633,6 +6633,7 @@ static struct task_struct *proxy_deactivate(struct rq *rq, struct task_struct *d
  *   p->pi_lock
  *     rq->lock
  *       mutex->wait_lock
+ *         p->blocked_lock
  *
  * Returns the task that is going to be used as execution context (the one
  * that is actually going to be run on cpu_of(rq)).
@@ -6656,8 +6657,9 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 		 * and ensure @owner sticks around.
 		 */
 		guard(raw_spinlock)(&mutex->wait_lock);
+		guard(raw_spinlock)(&p->blocked_lock);
 
-		/* Check again that p is blocked with wait_lock held */
+		/* Check again that p is blocked with blocked_lock held */
 		if (mutex != __get_task_blocked_on(p)) {
 			/*
 			 * Something changed in the blocked_on chain and
-- 
2.50.0.727.gbf7dc18ff4-goog



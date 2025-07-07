Return-Path: <linux-kernel+bounces-720511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5D7AFBCB9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 225627A5F4A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2919C22B8D0;
	Mon,  7 Jul 2025 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mvnsGMyi"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70064221F01
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 20:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921061; cv=none; b=ZfVt5ilg/V6lFbsnJraU4/y6zmGJTyCH/UPFsr3pOAEQ1IdPe4Mu/rl072oMtoVBjzl4B/+bPor/8o/IyZplfO6dS5JeIuDM2z+pOEUG69EXYJ7CfUW8yNvV8MO/DXRx1VnHT3GZHlWNQYXdhCBZQexaBURhrzRtMrjOdeCoDdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921061; c=relaxed/simple;
	bh=lCYOFYCQ5X/O9LF0+RaTNfvNehIilJ5msdeFK7VN4CI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pGCMlA9GeGojSNaDEEpj3OGyTU1jMzRezdyyBULVTQ75y8W4IzsjVx26gd3de0HnzQpxvsk4OH4FxaYKl6gUL8vlyknVMeBIB+5UuDhggcghUK9CuXs3KPsfSkRtLnzeMiViU5X3d0uuH6Mcvo0LHemebE1t63eZZvDeknd/AAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mvnsGMyi; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c37558eccso2975756a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 13:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751921059; x=1752525859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+W26I4UoVcgtTG2t49WkryD3K6H1+lyiZhKPVWcdyM=;
        b=mvnsGMyiFSaF5MyGcxHOxvCsI4mQEGFrufsV/0kAbn9l9/xWuxu3CIiDg6z8SaL1GK
         MxV8VpKGf++un1O/MjkxVXGMTyubEqtM69uPsPyFG2TgpfRa6FKha0tEmqM298s9R1Zl
         vWY17FTyPQHv/oqZVd73ftzwDzbhvUSmMw2Aj+knwP8eG1DR25whDdVjyOF6D0dzBZfa
         JP/En8Lc/mE+FenoOnycDGvI7LeVukQ9apjJufr+owlA2pP+Oh6U5Kp7kasCFuuL97F8
         EoDI+dBbeZhsR3sxwrjscRaO1UJ3xX5pkIs5XLsW2HHap5lMqJgKbMdsaezd3un0I/k9
         /L+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751921059; x=1752525859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+W26I4UoVcgtTG2t49WkryD3K6H1+lyiZhKPVWcdyM=;
        b=hqp8FX7jaYotGfA3XjcQgOetaeKcHE+9wQRtU0l1mQSCyyNBPgD5YpL2BsoOv215Jc
         VWHvscFmeHaeqzC5K+qZ1ufBGAdXvg4p+fAWiVfl8KIJSfWDPdQo8kKHpxDgS4NmFGQf
         yHimWIdyqxpRFE5msMcUs4li89Ga972cCLcPEgd83yMAmfOqDrvJyo4at8yMHkF6J1Uz
         qnHitxd/y6wszNRzn+8HrFa1zwg+vy+Czz0MIS1msn9gDxDy6koQ4ybiZnToI7/DaTgR
         BoGBY5BCK5GSGOxXbFtL8cf6RghRgc94ssrRaYyVV6iKdNL2Q64fRjbFYbc6fQrA7gn7
         4GGQ==
X-Gm-Message-State: AOJu0YxT1XbNAjiTa1ezUZBbzk0/tzBdOnR3/eK7+sxvtHOLENyZUZjY
	Beg0eqCOo4uxnHt+j/P2JIjA75W0cJdq6T68sEWCnbbrmN1W7za3t7tEHMNTOTlaiHsYyUWTd8N
	m6F4Hv5rSgKeG4sdcZ9l/xFkwKbHJrC8NcdLY8nzUd2YKjV7H6aEBS9Egfsloq6G18noonZbqiy
	Uy2JrQpeZaQZ6XfyG7XYl9/Gll8MuancHThdtyCv/Ct+jPZfX/
X-Google-Smtp-Source: AGHT+IEh2nqsVZ8R4lb/7cnmZFdEFkJb3LTSruJ4cuFRbvE3mEQxIjclK8OFefnprMHPKh6PWBpRIWFt70hi
X-Received: from pgbdn3.prod.google.com ([2002:a05:6a02:e03:b0:b31:e758:d80])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6da0:b0:226:d285:302d
 with SMTP id adf61e73a8af0-22b4252ae70mr850302637.4.1751921058337; Mon, 07
 Jul 2025 13:44:18 -0700 (PDT)
Date: Mon,  7 Jul 2025 20:43:49 +0000
In-Reply-To: <20250707204409.1028494-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707204409.1028494-1-jstultz@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707204409.1028494-3-jstultz@google.com>
Subject: [RESEND][PATCH v18 2/8] locking/mutex: Rework task_struct::blocked_on
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Juri Lelli <juri.lelli@redhat.com>, "Connor O'Brien" <connoro@google.com>, 
	John Stultz <jstultz@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>, 
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

From: Peter Zijlstra <peterz@infradead.org>

Track the blocked-on relation for mutexes, to allow following this
relation at schedule time.

   task
     | blocked-on
     v
   mutex
     | owner
     v
   task

This all will be used for tracking blocked-task/mutex chains
with the prox-execution patch in a similar fashion to how
priority inheritance is done with rt_mutexes.

For serialization, blocked-on is only set by the task itself
(current). And both when setting or clearing (potentially by
others), is done while holding the mutex::wait_lock.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[minor changes while rebasing]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Fix blocked_on tracking in __mutex_lock_common in error paths]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Fixed blocked_on tracking in error paths that was causing crashes
v4:
* Ensure we clear blocked_on when waking ww_mutexes to die or wound.
  This is critical so we don't get circular blocked_on relationships
  that can't be resolved.
v5:
* Fix potential bug where the skip_wait path might clear blocked_on
  when that path never set it
* Slight tweaks to where we set blocked_on to make it consistent,
  along with extra WARN_ON correctness checking
* Minor comment changes
v7:
* Minor commit message change suggested by Metin Kaya
* Fix WARN_ON conditionals in unlock path (as blocked_on might already
  be cleared), found while looking at issue Metin Kaya raised.
* Minor tweaks to be consistent in what we do under the
  blocked_on lock, also tweaked variable name to avoid confusion
  with label, and comment typos, as suggested by Metin Kaya
* Minor tweak for CONFIG_SCHED_PROXY_EXEC name change
* Moved unused block of code to later in the series, as suggested
  by Metin Kaya
* Switch to a tri-state to be able to distinguish from waking and
  runnable so we can later safely do return migration from ttwu
* Folded together with related blocked_on changes
v8:
* Fix issue leaving task BO_BLOCKED when calling into optimistic
  spinning path.
* Include helper to better handle BO_BLOCKED->BO_WAKING transitions
v9:
* Typo fixup pointed out by Metin
* Cleanup BO_WAKING->BO_RUNNABLE transitions for the !proxy case
* Many cleanups and simplifications suggested by Metin
v11:
* Whitespace fixup pointed out by Metin
v13:
* Refactor set_blocked_on helpers clean things up a bit
v14:
* Small build fixup with PREEMPT_RT
v15:
* Improve consistency of names for functions that assume blocked_lock
  is held, as suggested by Peter
* Use guard instead of separate spinlock/unlock calls, also suggested
  by Peter
* Drop blocked_on_state tri-state for now, as its not needed until
  later in the series, when we get to proxy-migration and return-
  migration.
v16:
* Clear blocked on before optimistic spinning

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
 include/linux/sched.h        |  5 +----
 kernel/fork.c                |  3 +--
 kernel/locking/mutex-debug.c |  9 +++++----
 kernel/locking/mutex.c       | 22 ++++++++++++++++++++++
 kernel/locking/ww_mutex.h    | 18 ++++++++++++++++--
 5 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ba2a02ead8c7e..aa7966141a090 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1238,10 +1238,7 @@ struct task_struct {
 	struct rt_mutex_waiter		*pi_blocked_on;
 #endif
 
-#ifdef CONFIG_DEBUG_MUTEXES
-	/* Mutex deadlock detection: */
-	struct mutex_waiter		*blocked_on;
-#endif
+	struct mutex			*blocked_on;	/* lock we're blocked on */
 
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
 	/*
diff --git a/kernel/fork.c b/kernel/fork.c
index 1ee8eb11f38ba..5f87f05aff4a0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2123,9 +2123,8 @@ __latent_entropy struct task_struct *copy_process(
 	lockdep_init_task(p);
 #endif
 
-#ifdef CONFIG_DEBUG_MUTEXES
 	p->blocked_on = NULL; /* not blocked yet */
-#endif
+
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
 	p->sequential_io_avg	= 0;
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index 6e6f6071cfa27..758b7a6792b0c 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -53,17 +53,18 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 {
 	lockdep_assert_held(&lock->wait_lock);
 
-	/* Mark the current thread as blocked on the lock: */
-	task->blocked_on = waiter;
+	/* Current thread can't be already blocked (since it's executing!) */
+	DEBUG_LOCKS_WARN_ON(task->blocked_on);
 }
 
 void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 			 struct task_struct *task)
 {
+	struct mutex *blocked_on = READ_ONCE(task->blocked_on);
+
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
 	DEBUG_LOCKS_WARN_ON(waiter->task != task);
-	DEBUG_LOCKS_WARN_ON(task->blocked_on != waiter);
-	task->blocked_on = NULL;
+	DEBUG_LOCKS_WARN_ON(blocked_on && blocked_on != lock);
 
 	INIT_LIST_HEAD(&waiter->list);
 	waiter->task = NULL;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index a39ecccbd106a..e2f59863a866e 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -644,6 +644,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			goto err_early_kill;
 	}
 
+	WARN_ON(current->blocked_on);
+	current->blocked_on = lock;
 	set_current_state(state);
 	trace_contention_begin(lock, LCB_F_MUTEX);
 	for (;;) {
@@ -680,6 +682,12 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 		first = __mutex_waiter_is_first(lock, &waiter);
 
+		/*
+		 * As we likely have been woken up by task
+		 * that has cleared our blocked_on state, re-set
+		 * it to the lock we are trying to aquire.
+		 */
+		current->blocked_on = lock;
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -691,8 +699,11 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 		if (first) {
 			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
+			/* clear blocked_on as mutex_optimistic_spin may schedule() */
+			current->blocked_on = NULL;
 			if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
 				break;
+			current->blocked_on = lock;
 			trace_contention_begin(lock, LCB_F_MUTEX);
 		}
 
@@ -700,6 +711,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	}
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 acquired:
+	current->blocked_on = NULL;
 	__set_current_state(TASK_RUNNING);
 
 	if (ww_ctx) {
@@ -729,9 +741,11 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	return 0;
 
 err:
+	current->blocked_on = NULL;
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
+	WARN_ON(current->blocked_on);
 	trace_contention_end(lock, ret);
 	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 	debug_mutex_free_waiter(&waiter);
@@ -942,6 +956,14 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		next = waiter->task;
 
 		debug_mutex_wake_waiter(lock, waiter);
+		/*
+		 * Unlock wakeups can be happening in parallel
+		 * (when optimistic spinners steal and release
+		 * the lock), so blocked_on may already be
+		 * cleared here.
+		 */
+		WARN_ON(next->blocked_on && next->blocked_on != lock);
+		next->blocked_on = NULL;
 		wake_q_add(&wake_q, next);
 	}
 
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 37f025a096c9d..00db40946328e 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -284,6 +284,14 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 #ifndef WW_RT
 		debug_mutex_wake_waiter(lock, waiter);
 #endif
+		/*
+		 * When waking up the task to die, be sure to clear the
+		 * blocked_on pointer. Otherwise we can see circular
+		 * blocked_on relationships that can't resolve.
+		 */
+		WARN_ON(waiter->task->blocked_on &&
+			waiter->task->blocked_on != lock);
+		waiter->task->blocked_on = NULL;
 		wake_q_add(wake_q, waiter->task);
 	}
 
@@ -331,9 +339,15 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 		 * it's wounded in __ww_mutex_check_kill() or has a
 		 * wakeup pending to re-read the wounded state.
 		 */
-		if (owner != current)
+		if (owner != current) {
+			/*
+			 * When waking up the task to wound, be sure to clear the
+			 * blocked_on pointer. Otherwise we can see circular
+			 * blocked_on relationships that can't resolve.
+			 */
+			owner->blocked_on = NULL;
 			wake_q_add(wake_q, owner);
-
+		}
 		return true;
 	}
 
-- 
2.50.0.727.gbf7dc18ff4-goog



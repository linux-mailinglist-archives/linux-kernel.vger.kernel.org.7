Return-Path: <linux-kernel+bounces-601236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 589E1A86B33
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 08:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41BB81B8531C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 06:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988E419C54C;
	Sat, 12 Apr 2025 06:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHecZFDv"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BDC198A29
	for <linux-kernel@vger.kernel.org>; Sat, 12 Apr 2025 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744437797; cv=none; b=ky9cdzTxev65YSKTRTGNV9eR0E8yQP61AGDiGJ0tttskJjAinmeO9hDQPv/HKuF7JIq08dh+OtQSPsVOSRxyqM5WHrKYbmE6L+MsHJmD0VOEOHnpE/8iT3mqdTQbBLq+0gL8ovPqPuyrz/VGmYV9lPqbTuHnw4+JYIm9a1U40Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744437797; c=relaxed/simple;
	bh=P4LjumHh/z+dK8+rRpiX4HsoiipXYY7JIUy+sWGN32s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KYfbWlvKbtQx5oyBZnAdWkn/POFZ/PbeJE2khPIhdTA5xcrjm1PQEj45AVv1ndBmsVc0EKiVeymoDwljyxN9UpU6objJaCWnMHOr05khjcVVKskc4KaYQAKCMnaj1W3NKrQufj8YRpgb6wT1nsFvIetAjAod5vdYHINQfAkXiJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OHecZFDv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224347aef79so35160975ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 23:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744437794; x=1745042594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=naVwflgBNbBg0NLcXqLDTTYAuw4Vp+VwbWUapN6oLCc=;
        b=OHecZFDvYHB+JWpM9vd7LmmKUVKRaQFOJ4wVggTG2CPlxxx121OMLUZ9JmbUOYOHrB
         7Op6l1s44YHA39VRI0iNaSi3TDlYkztfR4XFoj7vmYHdzI6BTptcBFvuhUEHKP3Y+wh6
         cIU3vyFeCMP5okwvrZ9WbI9NMPWo8gWfqknSpkepsH2J052n836ub8VpkYqw+wiYQRqH
         7bQbnsgahRazACuwZe5vcxOGqIq+guImaG4uhZSXlU9kU1si17J9hsSS369R9vFitG8x
         Hy4yg25mBAr+E7NCprCtYKlDHKMaSNAdYu9P2GVs052RRJOIPBBX0tbAD7ImHdzj0dQI
         VeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744437794; x=1745042594;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=naVwflgBNbBg0NLcXqLDTTYAuw4Vp+VwbWUapN6oLCc=;
        b=bRInXMUdo3fwEDxAl54O4Vp84k7P9niYDIPEqaBS+VdKG8sL5mPjjH4HvFtkY4BrVY
         mW1a6bmRAQ5uuSjJQDeunv5mQiznXrvry5c3rLCnXJ+9SWRSwhuMO0vFZL2RWpVMsi3r
         8JLmKCTF7m8vBVv+hLxRlTKo/SK8IHTk+vrqutzBuEdF52kgkjdS1Kblfd2C3FDQ696O
         nT6CgYVMMWC3ykf5Y+7+mTISiuGIlM+jzL53BsxQLEte0Lzt5UdjUytK+7Bby+kRkJqS
         bcb1ss22QjUWUctj5ZgKDJ8hMPeRfDcbJqXzMkX4plGsj53KTXqqT1108LEsBXkWnGG4
         7j6A==
X-Gm-Message-State: AOJu0YzMv4YTZENs4Vu6LdRYE+AnpZMN0jOhXocUgay1xDoToB3KrnAD
	cXuCY5KJDA4n8QHKDg6BdNcprg0eWdHKUU6fOhpK8ZsM4OyxJVyABgOmYfTOvKTcfVyBjm2pFn2
	3mjFQdhKDPNK3NxG8nhjv4dZzD6nibQVqRumQF16s5cflXnLyLqzPIWcnIA9nIsTvrugj4vjLb7
	YwsGFsff2SPTSEqVoMTsuKlpNYR09MkuNJ6wRCGz2d9Olu
X-Google-Smtp-Source: AGHT+IEf7DGwnkqpsVBaZ9GPliFq+nyLl/3/Hol8NZMDKrMj8xAjm65Lqq8cIUhdrpcFACwmNxOWRDODIi6y
X-Received: from pjbsi10.prod.google.com ([2002:a17:90b:528a:b0:2ef:7af4:5e8e])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b27:b0:223:f408:c3dc
 with SMTP id d9443c01a7336-22bea4952f7mr71861345ad.9.1744437794244; Fri, 11
 Apr 2025 23:03:14 -0700 (PDT)
Date: Fri, 11 Apr 2025 23:02:39 -0700
In-Reply-To: <20250412060258.3844594-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250412060258.3844594-1-jstultz@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250412060258.3844594-6-jstultz@google.com>
Subject: [PATCH v16 5/7] sched: Add an initial sketch of the find_proxy_task() function
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
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Add a find_proxy_task() function which doesn't do much.

When we select a blocked task to run, we will just deactivate it
and pick again. The exception being if it has become unblocked
after find_proxy_task() was called.

Greatly simplified from patch by:
  Peter Zijlstra (Intel) <peterz@infradead.org>
  Juri Lelli <juri.lelli@redhat.com>
  Valentin Schneider <valentin.schneider@arm.com>
  Connor O'Brien <connoro@google.com>

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
Cc: kernel-team@android.com
[jstultz: Split out from larger proxy patch and simplified
 for review and testing.]
Signed-off-by: John Stultz <jstultz@google.com>
---
v5:
* Split out from larger proxy patch
v7:
* Fixed unused function arguments, spelling nits, and tweaks for
  clarity, pointed out by Metin Kaya
* Fix build warning Reported-by: kernel test robot <lkp@intel.com>
  Closes: https://lore.kernel.org/oe-kbuild-all/202311081028.yDLmCWgr-lkp@intel.com/
v8:
* Fixed case where we might return a blocked task from find_proxy_task()
* Continued tweaks to handle avoiding returning blocked tasks
v9:
* Add zap_balance_callbacks helper to unwind balance_callbacks
  when we will re-call pick_next_task() again.
* Add extra comment suggested by Metin
* Typo fixes from Metin
* Moved adding proxy_resched_idle earlier in the series, as suggested
  by Metin
* Fix to call proxy_resched_idle() *prior* to deactivating next, to avoid
  crashes caused by stale references to next
* s/PROXY/SCHED_PROXY_EXEC/ as suggested by Metin
* Number of tweaks and cleanups suggested by Metin
* Simplify proxy_deactivate as suggested by Metin
v11:
* Tweaks for earlier simplification in try_to_deactivate_task
v13:
* Rename rename "next" to "donor" in find_proxy_task() for clarity
* Similarly use "donor" instead of next in proxy_deactivate
* Refactor/simplify proxy_resched_idle
* Moved up a needed fix from later in the series
v15:
* Tweaked some comments to better explain the initial sketch of
  find_proxy_task(), suggested by Qais
* Build fixes for !CONFIG_SMP
* Slight rework for blocked_on_state being added later in the
  series.
* Move the zap_balance_callbacks to later in the patch series
v16:
* Move the enqueue_task_rt() out to later in the series, as
  suggested by K Prateek Nayak
* Fixup whitespace error pointed out by K Prateek Nayak
* Use put_prev_set_next_task as suggested by K Prateek Nayak
* Try to rework find_proxy_task() locking to use guard and
  proxy_deactivate_task() in the way Peter suggested.
---
 kernel/sched/core.c  | 100 +++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h |  10 ++++-
 2 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 82817650a635b..88acb47f50d0f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6600,7 +6600,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  * Otherwise marks the task's __state as RUNNING
  */
 static bool try_to_block_task(struct rq *rq, struct task_struct *p,
-			      unsigned long task_state)
+			      unsigned long task_state, bool deactivate_cond)
 {
 	int flags = DEQUEUE_NOCLOCK;
 
@@ -6609,6 +6609,9 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
 		return false;
 	}
 
+	if (!deactivate_cond)
+		return false;
+
 	p->sched_contributes_to_load =
 		(task_state & TASK_UNINTERRUPTIBLE) &&
 		!(task_state & TASK_NOLOAD) &&
@@ -6632,6 +6635,90 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
 	return true;
 }
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+static inline struct task_struct *proxy_resched_idle(struct rq *rq)
+{
+	put_prev_set_next_task(rq, rq->donor, rq->idle);
+	rq_set_donor(rq, rq->idle);
+	set_tsk_need_resched(rq->idle);
+	return rq->idle;
+}
+
+static bool __proxy_deactivate(struct rq *rq, struct task_struct *donor)
+{
+	unsigned long state = READ_ONCE(donor->__state);
+
+	/* Don't deactivate if the state has been changed to TASK_RUNNING */
+	if (state == TASK_RUNNING)
+		return false;
+	/*
+	 * Because we got donor from pick_next_task, it is *crucial*
+	 * that we call proxy_resched_idle before we deactivate it.
+	 * As once we deactivate donor, donor->on_rq is set to zero,
+	 * which allows ttwu to immediately try to wake the task on
+	 * another rq. So we cannot use *any* references to donor
+	 * after that point. So things like cfs_rq->curr or rq->donor
+	 * need to be changed from next *before* we deactivate.
+	 */
+	proxy_resched_idle(rq);
+	return try_to_block_task(rq, donor, state, true);
+}
+
+static struct task_struct *proxy_deactivate(struct rq *rq, struct task_struct *donor)
+{
+	if (!__proxy_deactivate(rq, donor)) {
+		/*
+		 * XXX: For now, if deactivation failed, set donor
+		 * as unblocked, as we aren't doing proxy-migrations
+		 * yet (more logic will be needed then).
+		 */
+		donor->blocked_on = NULL;
+	}
+	return NULL;
+}
+
+/*
+ * Initial simple sketch that just deactivates the blocked task
+ * chosen by pick_next_task() so we can then pick something that
+ * isn't blocked.
+ */
+static struct task_struct *
+find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
+{
+	struct task_struct *p = donor;
+	struct mutex *mutex;
+
+	mutex = p->blocked_on;
+	/* Something changed in the chain, so pick again */
+	if (!mutex)
+		return NULL;
+	/*
+	 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
+	 * and ensure @owner sticks around.
+	 */
+	guard(raw_spinlock)(&mutex->wait_lock);
+
+	/* Check again that p is blocked with blocked_lock held */
+	if (!task_is_blocked(p) || mutex != __get_task_blocked_on(p)) {
+		/*
+		 * Something changed in the blocked_on chain and
+		 * we don't know if only at this level. So, let's
+		 * just bail out completely and let __schedule
+		 * figure things out (pick_again loop).
+		 */
+		return NULL; /* do pick_next_task again */
+	}
+	return proxy_deactivate(rq, donor);
+}
+#else /* SCHED_PROXY_EXEC */
+static struct task_struct *
+find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
+{
+	WARN_ONCE(1, "This should never be called in the !SCHED_PROXY_EXEC case\n");
+	return donor;
+}
+#endif /* SCHED_PROXY_EXEC */
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -6742,12 +6829,19 @@ static void __sched notrace __schedule(int sched_mode)
 			goto picked;
 		}
 	} else if (!preempt && prev_state) {
-		try_to_block_task(rq, prev, prev_state);
+		try_to_block_task(rq, prev, prev_state,
+				  !task_is_blocked(prev));
 		switch_count = &prev->nvcsw;
 	}
 
-	next = pick_next_task(rq, prev, &rf);
+pick_again:
+	next = pick_next_task(rq, rq->donor, &rf);
 	rq_set_donor(rq, next);
+	if (unlikely(task_is_blocked(next))) {
+		next = find_proxy_task(rq, next, &rf);
+		if (!next)
+			goto pick_again;
+	}
 picked:
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 154f0aa0c6322..ea2c987005bc1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2264,6 +2264,14 @@ static inline int task_current_donor(struct rq *rq, struct task_struct *p)
 	return rq->donor == p;
 }
 
+static inline bool task_is_blocked(struct task_struct *p)
+{
+	if (!sched_proxy_exec())
+		return false;
+
+	return !!p->blocked_on;
+}
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 #ifdef CONFIG_SMP
@@ -2473,7 +2481,7 @@ static inline void put_prev_set_next_task(struct rq *rq,
 					  struct task_struct *prev,
 					  struct task_struct *next)
 {
-	WARN_ON_ONCE(rq->curr != prev);
+	WARN_ON_ONCE(rq->donor != prev);
 
 	__put_prev_set_next_dl_server(rq, prev, next);
 
-- 
2.49.0.604.gff1f9ca942-goog



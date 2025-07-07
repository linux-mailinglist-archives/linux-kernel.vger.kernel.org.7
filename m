Return-Path: <linux-kernel+bounces-720516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289FCAFBCBF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB9E560211
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2972690EA;
	Mon,  7 Jul 2025 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EW4obEXD"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D5026562C
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921069; cv=none; b=LeJBU5zh2ljVDIqfqwNJ891abr+uL8XrR11Qk96H+9b1KVXv7YBeJRl7wHv4udjs1CfZqv8pOzPQFn3TokZeYO0H9QhdpO53tZQBCuFe6CdhaXN5gxY/proaAsl3FjNu8i4RyYH8xlP8Q7bzpkzmrTuaF8eNz5HKFSkwOJm2B30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921069; c=relaxed/simple;
	bh=65aTOo3/PoW85wXoc+sQcKL+wkQ2DIJV8Su0O+nklrs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cE4RPIO41VO8+/Om82rgHuIMY2Gz/SwFH+pQwk0k4J+9pHVfWLF+igyiUHqrC6WRXgIpbxvNXD8/mNdlFJTqlFJnDOrLsa4xNp5mfifP/HgH0O+F0iSnF7Kuks2e++Gb6bX6jCkghw6pUR0Dk3N8Z8SVriM2gGemHMe8CNG6nxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EW4obEXD; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b38ec062983so2330245a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 13:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751921064; x=1752525864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl1xJj/1Ciw5/8ZxYlRHCnf/dLxcgLYG//PTqoDrKQo=;
        b=EW4obEXDk5IC7J3LGlEbnTG5RgxAxjYF/os6ZUnw2m4tUFLFNZLvXNeM0MSyjgE/ct
         4Xoj/WHYtqO1N5SNBKznoPlBbF5vczm5dZMYUa57Dhc//W3xc1huabPsGIYhWTsscbZJ
         imlMSlyL59/TuGS0JrNGiyOmAFvJ3AM/XNwykqVgPBWSSnej3z3XEwaSQWjTTB4LVXXp
         s+X8Y4ggKlrALuMdaJXqrBb1bAI6iy/Gyvvv215ylr19VuMLNPRdbYdAWy19Fn+B+XVk
         gy6rMlm/bOPHyWgpN7F26FMHNiXkZdysazBZbgFnwbeZSlbAHvTy+EtRxF2v7nfFE5vH
         x9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751921064; x=1752525864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl1xJj/1Ciw5/8ZxYlRHCnf/dLxcgLYG//PTqoDrKQo=;
        b=qgJbUeLGVcqvLXc8FrW1fye+bwSKrsnfmQYP+4OSx3NPUZDsR2nASDQT2rRk9PPo9F
         oa1dhR3J1MuJhoAlCk5QW/0IklAuM4oRoFvH7AJFsYeY7RnhE+nR5Cez72L461Z4C7In
         ih65D7/WEUdTh7infAlaZ4DD4B91lsIAO0uHVbo+HWf7lPUByirTybvEELwn0Iey/+sB
         CCpjqa8HFJb67tk4QTWeik9yN0No9z/posp0t1JdOfF7JJ9Qi9ZlfoNOrveAcbO8remR
         yfJTgpqaD1/upTpEi2cTFRtrItrNMOzZ+REON+6+gFj5JSfl5EnV3ugQQtW34dN/3l3E
         YRNg==
X-Gm-Message-State: AOJu0Yx4xtKAwRIqFERk3rF4ry+B3EZqT6kzYsfFZJJ7PDazGYSimvkm
	w8B+FrlJGYOe7iFT00h6hm9dijygsjow8g2/zYdNjWKHzWzRoa2dqQu06YRsysaqixn8D9kG+vn
	4rUq2igQoBZj6T1wmJLN7sd61tQ29TXl14Fx+krwkYEzLbdXTEnwbLJYcJ6lbHfOpMlrjv68aJ1
	Sih5S5be+AIhjc1SuyYVxqR/GGyHh8b92osOwqVFWIxbpprNLH
X-Google-Smtp-Source: AGHT+IG6a6yF/dP7r64wCMyq6s87oym3hIRvT2d4PAwKXLMFQOII6D+5XqBU4TKeo13VMyezyhkIA5nR2Z9K
X-Received: from pgcv10.prod.google.com ([2002:a05:6a02:530a:b0:b2e:c15e:3eb7])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4612:b0:220:3024:3d05
 with SMTP id adf61e73a8af0-22b1bc58967mr1529266637.16.1751921064381; Mon, 07
 Jul 2025 13:44:24 -0700 (PDT)
Date: Mon,  7 Jul 2025 20:43:53 +0000
In-Reply-To: <20250707204409.1028494-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707204409.1028494-1-jstultz@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707204409.1028494-7-jstultz@google.com>
Subject: [RESEND][PATCH v18 6/8] sched: Add an initial sketch of the
 find_proxy_task() function
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>, 
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Add a find_proxy_task() function which doesn't do much.

When we select a blocked task to run, we will just deactivate it
and pick again. The exception being if it has become unblocked
after find_proxy_task() was called.

This allows us to validate keeping blocked tasks on the runqueue
and later deactivating them is working ok, stressing the failure
cases for when a proxy isn't found.

Greatly simplified from patch by:
  Peter Zijlstra (Intel) <peterz@infradead.org>
  Juri Lelli <juri.lelli@redhat.com>
  Valentin Schneider <valentin.schneider@arm.com>
  Connor O'Brien <connoro@google.com>

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
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
v17:
* Slightly simplified variable names per suggestion from
  Juri Lelli
* Minor comment and commit message tweaks suggested by Peter

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
 kernel/sched/core.c  | 100 +++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h |  10 ++++-
 2 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 853157b27f384..dc82d9b8bee2c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6614,7 +6614,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  * Otherwise marks the task's __state as RUNNING
  */
 static bool try_to_block_task(struct rq *rq, struct task_struct *p,
-			      unsigned long *task_state_p)
+			      unsigned long *task_state_p,
+			      bool deactivate_cond)
 {
 	unsigned long task_state = *task_state_p;
 	int flags = DEQUEUE_NOCLOCK;
@@ -6625,6 +6626,9 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
 		return false;
 	}
 
+	if (!deactivate_cond)
+		return false;
+
 	p->sched_contributes_to_load =
 		(task_state & TASK_UNINTERRUPTIBLE) &&
 		!(task_state & TASK_NOLOAD) &&
@@ -6648,6 +6652,89 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
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
+	 * Because we got donor from pick_next_task(), it is *crucial*
+	 * that we call proxy_resched_idle() before we deactivate it.
+	 * As once we deactivate donor, donor->on_rq is set to zero,
+	 * which allows ttwu() to immediately try to wake the task on
+	 * another rq. So we cannot use *any* references to donor
+	 * after that point. So things like cfs_rq->curr or rq->donor
+	 * need to be changed from next *before* we deactivate.
+	 */
+	proxy_resched_idle(rq);
+	return try_to_block_task(rq, donor, &state, true);
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
+	struct mutex *mutex;
+
+	mutex = donor->blocked_on;
+	/* Something changed in the chain, so pick again */
+	if (!mutex)
+		return NULL;
+	/*
+	 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
+	 * and ensure @owner sticks around.
+	 */
+	guard(raw_spinlock)(&mutex->wait_lock);
+
+	/* Check again that donor is blocked with blocked_lock held */
+	if (!task_is_blocked(donor) || mutex != __get_task_blocked_on(donor)) {
+		/*
+		 * Something changed in the blocked_on chain and
+		 * we don't know if only at this level. So, let's
+		 * just bail out completely and let __schedule()
+		 * figure things out (pick_again loop).
+		 */
+		return NULL; /* do pick_next_task() again */
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
@@ -6760,12 +6847,19 @@ static void __sched notrace __schedule(int sched_mode)
 			goto picked;
 		}
 	} else if (!preempt && prev_state) {
-		try_to_block_task(rq, prev, &prev_state);
+		try_to_block_task(rq, prev, &prev_state,
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
index 6b61e0c7f6e78..590a44c0215fb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2290,6 +2290,14 @@ static inline int task_current_donor(struct rq *rq, struct task_struct *p)
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
@@ -2499,7 +2507,7 @@ static inline void put_prev_set_next_task(struct rq *rq,
 					  struct task_struct *prev,
 					  struct task_struct *next)
 {
-	WARN_ON_ONCE(rq->curr != prev);
+	WARN_ON_ONCE(rq->donor != prev);
 
 	__put_prev_set_next_dl_server(rq, prev, next);
 
-- 
2.50.0.727.gbf7dc18ff4-goog



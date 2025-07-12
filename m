Return-Path: <linux-kernel+bounces-728511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F24B02927
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 05:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F8358832E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B06E221703;
	Sat, 12 Jul 2025 03:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CEwH35ds"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CED219A72
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752291266; cv=none; b=qs3WEgUTihyo5/pKc/71kSbNjLO/q4x9hxdDUDYH6vfBI+Ireoa/cCaGNlD/HOaddM7booDYY69JtLdZtlQFm6nVKxgy07TcFXPv5pFgG37EOzagS9RPWCLYRA9SqpBscAl/+gng+MqE+MaT5bsdFss1vHJKDC2o1wvworBbT24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752291266; c=relaxed/simple;
	bh=MehgenUigdp3sAgb3bYrAt2AlAJ5FRx+0d1kZs5FhHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NBERr2goxGR3dn8qqWWJUNPCian10hjBTxGg9zmm3sD68tVKIcKuSM7HLiS2lpqgvDzPOsDKA61bT0v3/QED92OHtV0ucz09HONc0Z30JqHfSXC+1+Gs9g5zzSgHvXLzcPrTRKDnQ0nEyScEexd6L9wui8u+sr+QWgvDf5gGmuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CEwH35ds; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-740774348f6so2250900b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 20:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752291264; x=1752896064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q6K3DxGTztrWhfpK7W+fWPHaX3cUV0DOD5CR/NRGfQs=;
        b=CEwH35dsvehxfw0/5aJ6SEw3EU35B3Ap4Ucwf4QDko0VTgHY9tFlT++lpVfvN/FO5E
         STY8rTPhKyJg3OzrJsKfaqvis34cn1SFdF+LcUKtxf6jJ/ByI1TPJ1leEz6nmAO1y0zO
         6UZ0CseKNBEVfzakstaVDk5/Pia2FRXCT2nS6wKY4ewsYBG+zLn5Ho4Ar+33F0ZLeRpj
         fPQOFmpEa5KZsafk3XQ1W9DCqJRoxR8HMLtj+DUtSASemjsN+H3m7i3N9m0yX3dQtOE3
         PWC+duo0b96yLCV8EvzV8KHe2/pFsmEJer/5gcw761EYi0Hosv41sXkdwuCw9Oii6tzA
         ve/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752291264; x=1752896064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6K3DxGTztrWhfpK7W+fWPHaX3cUV0DOD5CR/NRGfQs=;
        b=kO29bSMHU8cUsliECG1s52pk8r89QKRNZmwXn99r3wdXny3VtjMS88bLk6tlX/mgW0
         V5sT8MmxKQvK+plwF85tcLy0fsKm+IlxmA8U5buupPYx4hYJ+rQ61knYkpdBBGyHIpXs
         c2rhNidHJp6pmQoQ4x30gOyW/HV0VhgV5Jx8zhZOlsK0pVHD3CCE7lKgVHUTwQILnxva
         YOrWK1TUCOcvTENJN3qTYYLNUR6UIdFcvRvHiB4H4kDbnGMtAD1+if4I+FRF0DWjhLmL
         Su01MC2rvyJhcZi4CSh7J40ZPboeYMW2aSOTACfvToD3KaS6OId+cDHcwhp6WnfPoXtd
         ij1Q==
X-Gm-Message-State: AOJu0YyRSw6l4Ey0seqA9dSXKhqdXdieyc/kqDOJXh1zDBcHG0Akq510
	zYkxWnO0ag1qUdSNak2dBxY14phVJZnYjxa1ApBjI5OJypnjI3UFKUyhFZ4/ZcZaD6WllgzqHF9
	bIvO+vGJALsLRKKch7y+apBOTsy/KSuV2g9HVB0ccvrkodfkzcc1x9fEnJd93lcFqYDlv5C51wR
	cQKGnfwKBxHi19WKym4gFgsulOxibYiZ7jvIcwwaCEpOhL+Hty
X-Google-Smtp-Source: AGHT+IHsOYKcABoOwN/fx5Bf4QB/gk/JWtKxibLqFHSyZPn8gxWaFaGGBukOeFXpQ4Zt8J3hPB7k5sJNyeHf
X-Received: from pfbbj10.prod.google.com ([2002:a05:6a00:318a:b0:748:da37:7e37])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:856:b0:748:fcfa:8bd5
 with SMTP id d2e1a72fcca58-74ee0bb022amr8522844b3a.3.1752291263833; Fri, 11
 Jul 2025 20:34:23 -0700 (PDT)
Date: Sat, 12 Jul 2025 03:33:48 +0000
In-Reply-To: <20250712033407.2383110-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712033407.2383110-1-jstultz@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712033407.2383110-8-jstultz@google.com>
Subject: [PATCH v19 7/8] sched: Fix proxy/current (push,pull)ability
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	"Connor O'Brien" <connoro@google.com>, John Stultz <jstultz@google.com>, 
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

From: Valentin Schneider <valentin.schneider@arm.com>

Proxy execution forms atomic pairs of tasks: The waiting donor
task (scheduling context) and a proxy (execution context). The
donor task, along with the rest of the blocked chain, follows
the proxy wrt CPU placement.

They can be the same task, in which case push/pull doesn't need any
modification. When they are different, however,
FIFO1 & FIFO42:

	      ,->  RT42
	      |     | blocked-on
	      |     v
blocked_donor |   mutex
	      |     | owner
	      |     v
	      `--  RT1

   RT1
   RT42

  CPU0            CPU1
   ^                ^
   |                |
  overloaded    !overloaded
  rq prio = 42  rq prio = 0

RT1 is eligible to be pushed to CPU1, but should that happen it will
"carry" RT42 along. Clearly here neither RT1 nor RT42 must be seen as
push/pullable.

Unfortunately, only the donor task is usually dequeued from the rq,
and the proxy'ed execution context (rq->curr) remains on the rq.
This can cause RT1 to be selected for migration from logic like the
rt pushable_list.

Thus, adda a dequeue/enqueue cycle on the proxy task before __schedule
returns, which allows the sched class logic to avoid adding the now
current task to the pushable_list.

Furthermore, tasks becoming blocked on a mutex don't need an explicit
dequeue/enqueue cycle to be made (push/pull)able: they have to be running
to block on a mutex, thus they will eventually hit put_prev_task().

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v3:
* Tweaked comments & commit message
v5:
* Minor simplifications to utilize the fix earlier
  in the patch series.
* Rework the wording of the commit message to match selected/
  proxy terminology and expand a bit to make it more clear how
  it works.
v6:
* Dropped now-unused proxied value, to be re-added later in the
  series when it is used, as caught by Dietmar
v7:
* Unused function argument fixup
* Commit message nit pointed out by Metin Kaya
* Dropped unproven unlikely() and use sched_proxy_exec()
  in proxy_tag_curr, suggested by Metin Kaya
v8:
* More cleanups and typo fixes suggested by Metin Kaya
v11:
* Cleanup of comimt message suggested by Metin
v12:
* Rework for rq_selected -> rq->donor renaming
v16:
* Pulled logic from later patch in to avoid sched_balance
  migrating blocked tasks.
* Moved enqueue_task_rt() logic from earlier into this patch
  as suggested by K Prateek Nayak
* Simplified changes to enqueue_task_rt to match deadline's
  logic, as pointed out by Peter
v17:
* Add similar logic to put_prev_task_dl as pointed out by
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
 kernel/sched/core.c     | 25 +++++++++++++++++++++++++
 kernel/sched/deadline.c |  7 +++++++
 kernel/sched/rt.c       |  5 +++++
 3 files changed, 37 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 917043f815335..adb4818ee7f7d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6747,6 +6747,23 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 }
 #endif /* SCHED_PROXY_EXEC */
 
+static inline void proxy_tag_curr(struct rq *rq, struct task_struct *owner)
+{
+	if (!sched_proxy_exec())
+		return;
+	/*
+	 * pick_next_task() calls set_next_task() on the chosen task
+	 * at some point, which ensures it is not push/pullable.
+	 * However, the chosen/donor task *and* the mutex owner form an
+	 * atomic pair wrt push/pull.
+	 *
+	 * Make sure owner we run is not pushable. Unfortunately we can
+	 * only deal with that by means of a dequeue/enqueue cycle. :-/
+	 */
+	dequeue_task(rq, owner, DEQUEUE_NOCLOCK | DEQUEUE_SAVE);
+	enqueue_task(rq, owner, ENQUEUE_NOCLOCK | ENQUEUE_RESTORE);
+}
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -6891,6 +6908,10 @@ static void __sched notrace __schedule(int sched_mode)
 		 * changes to task_struct made by pick_next_task().
 		 */
 		RCU_INIT_POINTER(rq->curr, next);
+
+		if (!task_current_donor(rq, next))
+			proxy_tag_curr(rq, next);
+
 		/*
 		 * The membarrier system call requires each architecture
 		 * to have a full memory barrier after updating
@@ -6925,6 +6946,10 @@ static void __sched notrace __schedule(int sched_mode)
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
+		/* In case next was already curr but just got blocked_donor */
+		if (!task_current_donor(rq, next))
+			proxy_tag_curr(rq, next);
+
 		rq_unpin_lock(rq, &rf);
 		__balance_callbacks(rq);
 		raw_spin_rq_unlock_irq(rq);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 89019a1408264..82ec60a713d7f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2166,6 +2166,9 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 	if (dl_server(&p->dl))
 		return;
 
+	if (task_is_blocked(p))
+		return;
+
 	if (!task_current(rq, p) && !p->dl.dl_throttled && p->nr_cpus_allowed > 1)
 		enqueue_pushable_dl_task(rq, p);
 }
@@ -2465,6 +2468,10 @@ static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct task_s
 	update_curr_dl(rq);
 
 	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 1);
+
+	if (task_is_blocked(p))
+		return;
+
 	if (on_dl_rq(&p->dl) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_dl_task(rq, p);
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e40422c370335..b1fc9e6cf4a60 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1488,6 +1488,9 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 
 	enqueue_rt_entity(rt_se, flags);
 
+	if (task_is_blocked(p))
+		return;
+
 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_task(rq, p);
 }
@@ -1768,6 +1771,8 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_s
 
 	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
 
+	if (task_is_blocked(p))
+		return;
 	/*
 	 * The previous task needs to be made eligible for pushing
 	 * if it is still active
-- 
2.50.0.727.gbf7dc18ff4-goog



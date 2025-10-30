Return-Path: <linux-kernel+bounces-877343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1150FC1DE35
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348841892CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B5422172E;
	Thu, 30 Oct 2025 00:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eVpfHkP5"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773C32153D4
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783559; cv=none; b=Cd/5+xxAQ3prqC+zkqN+iN0OzULHzmCg93rQHQCgfF02mZ7cNQrAL0v/hILohp2MJEy3QcFagRBXOg3N/vF5Wev3uaL5vMKUtwRiCeQYz+Mu9aZKHtjSa7O9VbbIhT4vl4LiRWgSpGXFp8HGqJKFQndwJYHJYusubhqakraqBj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783559; c=relaxed/simple;
	bh=+P7TO7VmrWMaR93SB6+alsEe+0z91aq0cUv1BeYykA8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=stUvHiehhrgtK/Jgu21AvmErqrThXCB4f3r64h0Ahl334jdmGiM1rqYDiEZU8nYg0TM9stZep6EFjMgC2vVQ7RUcYEAlQbLITYbNdT0/aCVYhafGq0Z2sNi78NPFoF40N4cc618spO+U0K9jMgknMjuAq0dOTV03Ho8zlmB4OG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eVpfHkP5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7a267606fe8so364082b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761783557; x=1762388357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YymTN7ZjNyXDosetoCN8yrsEVJlaareKAWv54RWXCuc=;
        b=eVpfHkP5lUtd3nRjYfBN3sH1PKZE0DR5VoOMfcJYJtLtjPuyRWP5o7e5akbSgeeYeW
         xPPQfHbb1GpSOEgW+0uG1hxwI7n05uWQmyaSdsEJj/MAJ5dks5aozCFhELaJ7sGMbgxz
         sbSSujFVbEOV8IsYdtXf7C8iAi+wGovVu+pgBBvyKXSHW9shOEzXUF+ZSE2KVq/rskPi
         cgAiVqdRKQumZbr4Pe5mONo7XAii0JKYv69hpL2Qy325CMLl/Ob2MyoLCZmcZnd2FnSn
         t0KSLZPMGq0oca5VV+RAxKodGe5Omej84QeGXnOZOSQSWfXV4rH+cGWbqGV7xDth2ZRY
         0kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783557; x=1762388357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YymTN7ZjNyXDosetoCN8yrsEVJlaareKAWv54RWXCuc=;
        b=WJ8adJWCizb6KW7USTD6QhpJy9i4HJbBrgrlhyu1IQglXhsR79Vt6dxsuisi9G3dDK
         IKgV3mpP4c+NTLqA4+FjIPO1RjqbnB2zKebBTeDjcJPF9t/r7GJz3DTwUq/VJRFXKxqg
         A/8mz1D16xjXluUC8Jjs4Kq2vP5b16oc60rpAgp6FTwwKHnNmvoflYimKX35VbIhv/mX
         9h/BPzJag4Zcz04TD5cA/Nwrth/I0FqRo/w2ebHEAOnEHLplF8UugJox3Riilf2daz+b
         tgo0IaiNiryoPwjolNQgdXedF7sXtFa2LvFqUQ3MvkznLysB9gT1uFV4iGqo0RuGsf86
         H2BA==
X-Gm-Message-State: AOJu0YyKkBBk38wF79hA7faVajebxAVzRbxZc2r76HzYj0eHYwMTJJar
	5+Q+vowsctMjXqqBDPjHQndGg0zNmSgdT5Jd1lT1sKZ//+g7sl6OL0+FGE8hheehXpyRG7ppiXh
	qWTBG9KM+MHPaOlOIK6NsK1U3b0nmqzfsvQ+zR0yLVcFK8BghuPz4PYVU16FC/fUmY+Qe+JIfJR
	/7kacYxCBKOd3VIyoEd8B2/+W2PeQDAxy3DC0eHLt8IrKSqBxW
X-Google-Smtp-Source: AGHT+IFk2/AWGfZxxb6gdiIvh+Df7R9aqsGY/uHdrrZa3UadLjMeSn9i1dBQj4UmMFvInh97o2zW4yZ0e22Z
X-Received: from pjbfh4.prod.google.com ([2002:a17:90b:344:b0:33b:a383:f4df])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3289:b0:340:c6cd:545b
 with SMTP id adf61e73a8af0-34787078c60mr1550958637.44.1761783556400; Wed, 29
 Oct 2025 17:19:16 -0700 (PDT)
Date: Thu, 30 Oct 2025 00:18:50 +0000
In-Reply-To: <20251030001857.681432-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030001857.681432-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030001857.681432-10-jstultz@google.com>
Subject: [PATCH v23 9/9] sched: Migrate whole chain in proxy_migrate_task()
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

Instead of migrating one task each time through find_proxy_task(),
we can walk up the blocked_donor ptrs and migrate the entire
current chain in one go.

This was broken out of earlier patches and held back while the
series was being stabilized, but I wanted to re-introduce it.

Signed-off-by: John Stultz <jstultz@google.com>
---
v12:
* Earlier this was re-using blocked_node, but I hit
  a race with activating blocked entities, and to
  avoid it introduced a new migration_node listhead
v18:
* Add init_task initialization of migration_node as suggested
  by Suleiman
v22:
* Move migration_node under CONFIG_SCHED_PROXY_EXEC as suggested
  by K Prateek
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
 include/linux/sched.h |  3 +++
 init/init_task.c      |  3 +++
 kernel/fork.c         |  3 +++
 kernel/sched/core.c   | 25 +++++++++++++++++--------
 4 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index bac1b956027e2..cd2453c2085c1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1243,6 +1243,9 @@ struct task_struct {
 	struct mutex			*blocked_on;	/* lock we're blocked on */
 	struct task_struct		*blocked_donor;	/* task that is boosting this task */
 	raw_spinlock_t			blocked_lock;
+#ifdef CONFIG_SCHED_PROXY_EXEC
+	struct list_head		migration_node;
+#endif
 
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
 	/*
diff --git a/init/init_task.c b/init/init_task.c
index 34853a511b4d8..78fb7cb83fa5d 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -178,6 +178,9 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 						 &init_task.alloc_lock),
 #endif
 	.blocked_donor = NULL,
+#ifdef CONFIG_SCHED_PROXY_EXEC
+	.migration_node = LIST_HEAD_INIT(init_task.migration_node),
+#endif
 #ifdef CONFIG_RT_MUTEXES
 	.pi_waiters	= RB_ROOT_CACHED,
 	.pi_top_task	= NULL,
diff --git a/kernel/fork.c b/kernel/fork.c
index 0a9a17e25b85d..a7561480e879e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2137,6 +2137,9 @@ __latent_entropy struct task_struct *copy_process(
 
 	p->blocked_on = NULL; /* not blocked yet */
 	p->blocked_donor = NULL; /* nobody is boosting p yet */
+#ifdef CONFIG_SCHED_PROXY_EXEC
+	INIT_LIST_HEAD(&p->migration_node);
+#endif
 
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index eabde9706981a..c202ae19b4ac8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6718,6 +6718,7 @@ static void proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
 			       struct task_struct *p, int target_cpu)
 {
 	struct rq *target_rq = cpu_rq(target_cpu);
+	LIST_HEAD(migrate_list);
 
 	lockdep_assert_rq_held(rq);
 
@@ -6734,11 +6735,16 @@ static void proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
 	 */
 	proxy_resched_idle(rq);
 
-	WARN_ON(p == rq->curr);
-
-	deactivate_task(rq, p, 0);
-	proxy_set_task_cpu(p, target_cpu);
-
+	for (; p; p = p->blocked_donor) {
+		WARN_ON(p == rq->curr);
+		deactivate_task(rq, p, 0);
+		proxy_set_task_cpu(p, target_cpu);
+		/*
+		 * We can abuse blocked_node to migrate the thing,
+		 * because @p was still on the rq.
+		 */
+		list_add(&p->migration_node, &migrate_list);
+	}
 	/*
 	 * We have to zap callbacks before unlocking the rq
 	 * as another CPU may jump in and call sched_balance_rq
@@ -6749,10 +6755,13 @@ static void proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
 	rq_unpin_lock(rq, rf);
 	raw_spin_rq_unlock(rq);
 	raw_spin_rq_lock(target_rq);
+	while (!list_empty(&migrate_list)) {
+		p = list_first_entry(&migrate_list, struct task_struct, migration_node);
+		list_del_init(&p->migration_node);
 
-	activate_task(target_rq, p, 0);
-	wakeup_preempt(target_rq, p, 0);
-
+		activate_task(target_rq, p, 0);
+		wakeup_preempt(target_rq, p, 0);
+	}
 	raw_spin_rq_unlock(target_rq);
 	raw_spin_rq_lock(rq);
 	rq_repin_lock(rq, rf);
-- 
2.51.1.930.gacf6e81ea2-goog



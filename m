Return-Path: <linux-kernel+bounces-799599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B99B42E15
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8D5488433
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998F11DF754;
	Thu,  4 Sep 2025 00:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xy/GqtBf"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00CC1C5485
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945335; cv=none; b=bB1fr4AAGwJgXNl+UxCP4FTBq4W2l2qwqGuz5v8SXD96sdtDGDzW2hnYaixlxxT5rLWOl6qEQhoJ5cv6qQrOU7KK4Os+lFpbCci8pcJE4c91kPdlKGwaYiBJNbM/1wKUGi6dxy2sFOBNK3gBtHd4QH568mqUl3G9AfqxULGKF0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945335; c=relaxed/simple;
	bh=OdTR+Z6yRt7APDDub9cJY5k3tOEgu+Ak4LyQWwGIwcM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=exD2T1UZGd1LipRT9WNtosk4W1JQNit5pydZZsrl3K2t1HuHxESa5ZMn1BlbJVulrDzc6MnQiCnR5CI193FGr+Qm7hrQLKP9BRDCBpw3JVnU561iYbnOVEg5ybyqk0N+2LJdTxUGkFfJK1hc6WmFoBf4hMVxrF8bVSlwS6fkYKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xy/GqtBf; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-325b2959306so734574a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 17:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756945333; x=1757550133; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lQF15GlGRoaddkA2sNzRo/0a+6h5l29yn4+US7wAy30=;
        b=xy/GqtBf0v9vViq8WQiIGxPGFJGdeND1/3FrjAIU85ULWcv17xzHyrv5jjbKj3z8Bc
         /rtTTv/7UFH0ZqnV/hMUfJHGrR+1KsszU1ODBeP1hjW59/DBcXoTgYl4uvr+31NcT8JW
         qbfCO9WK2AKy6nDNzFzeo7AGFwZpjBPl1loN8zJ/f+L2yEpRo3zLv81kSAPgj7e9TxmF
         6ik+rIQ0j9g6aIOieydxk+RrVNok9U0L1pVNBbxNin7PRCiwvFOtc/1EzpViyiEUWTsJ
         yyVfeTHasviMHagfdbZC9bxCEumgsvONWWO7lEL8pX8oepBgPTBgdUqc8WjyPCFK8/sX
         aEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945333; x=1757550133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQF15GlGRoaddkA2sNzRo/0a+6h5l29yn4+US7wAy30=;
        b=HQ3BFoN1dx0knOAaWL39qBRLBt66cP5ILF+7iMpcO0P9SKKhgW1NMOyKMjjfQYaOqf
         3R1DSOUqdTJ5BT6+5/Ri9BMu9TTUkGEtpGBNH70fALH2GxGVjwYI4eS4hsyjMi1qKROR
         R8Y7DPvUVoJZiSZ3SXfDe7/x1ipUbEJft0BC1sVCxTw05ls0RcxfcYrmx1/elJLwsAVa
         nT5yp5yjo1ctTpo8d8RNx5FMjlxGs2tk44KLWL2bCLa9k10FfY5v5DBh0sSMj8yHaAoC
         x5oUUnzl9bjRX0iv97QhI4ZVa0FBGM7P6q+qaP/g3cVCKWHIYtOnlyrv++0MYQC7Jwvx
         jU4A==
X-Gm-Message-State: AOJu0Yxv5Kd++uy1a4tRpPB+aXDzffoFyXiFidp8sK0AJCATxlAxFm9i
	92jbOhJykeU7k+pdMXG0f1XgG2CChC+VqbFBuQMO56e3WAcpSDvUqzRGFFaPFf1EVXBg9co5G2f
	Deb+xA7Jads0R319alAQB1lqbPckadVvI4BaQXqv3Epi5dChDO/8zMOSxrm9u/DSCbTFFcECqry
	MT+ENovFWV/sfLNJpzifENzOZbQYLQh+961vPFmS9rm+ciZAvs
X-Google-Smtp-Source: AGHT+IHUgQ+s77oJca63T2a0DSEjPICDEfhQi8xbh2RJZ5lQb+nv3Blij+Q52KcpfMpy0KJQ6GPj/CUUlArt
X-Received: from pjd5.prod.google.com ([2002:a17:90b:54c5:b0:31f:1ed:c76e])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1646:b0:32b:97ff:c95c
 with SMTP id 98e67ed59e1d1-32b97ffd2edmr21096a91.21.1756945333076; Wed, 03
 Sep 2025 17:22:13 -0700 (PDT)
Date: Thu,  4 Sep 2025 00:21:56 +0000
In-Reply-To: <20250904002201.971268-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904002201.971268-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904002201.971268-7-jstultz@google.com>
Subject: [RESEND][PATCH v21 6/6] sched: Migrate whole chain in proxy_migrate_task()
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
 include/linux/sched.h |  1 +
 init/init_task.c      |  1 +
 kernel/fork.c         |  1 +
 kernel/sched/core.c   | 25 +++++++++++++++++--------
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ab12eb738c440..176ec117f4041 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1243,6 +1243,7 @@ struct task_struct {
 	enum blocked_on_state		blocked_on_state;
 	struct mutex			*blocked_on;	/* lock we're blocked on */
 	struct task_struct		*blocked_donor;	/* task that is boosting this task */
+	struct list_head		migration_node;
 	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
diff --git a/init/init_task.c b/init/init_task.c
index 627bbd8953e88..65e0f90285966 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -176,6 +176,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 #endif
 	.blocked_on_state = BO_RUNNABLE,
 	.blocked_donor = NULL,
+	.migration_node = LIST_HEAD_INIT(init_task.migration_node),
 #ifdef CONFIG_RT_MUTEXES
 	.pi_waiters	= RB_ROOT_CACHED,
 	.pi_top_task	= NULL,
diff --git a/kernel/fork.c b/kernel/fork.c
index 86fe43ee35952..01fd08c463871 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2132,6 +2132,7 @@ __latent_entropy struct task_struct *copy_process(
 	p->blocked_on_state = BO_RUNNABLE;
 	p->blocked_on = NULL; /* not blocked yet */
 	p->blocked_donor = NULL; /* nobody is boosting p yet */
+	INIT_LIST_HEAD(&p->migration_node);
 
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cac03f68cbcce..26f7a11a39e0e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6747,6 +6747,7 @@ static void proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
 			       struct task_struct *p, int target_cpu)
 {
 	struct rq *target_rq = cpu_rq(target_cpu);
+	LIST_HEAD(migrate_list);
 
 	lockdep_assert_rq_held(rq);
 
@@ -6774,19 +6775,27 @@ static void proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
 	rq_set_donor(rq, rq->idle);
 	set_next_task(rq, rq->idle);
 
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
 	zap_balance_callbacks(rq);
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
2.51.0.338.gd7d06c2dae-goog



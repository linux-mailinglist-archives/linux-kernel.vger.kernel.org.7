Return-Path: <linux-kernel+bounces-833557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABA9BA24DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31331189FDF4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4112749CE;
	Fri, 26 Sep 2025 03:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Adzs9ryT"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146DB26FA50
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758857387; cv=none; b=ZGxeYdmkvkhmQ9H0GQJ6uakQB1ks0Rqnug35NwfWOZbQpOcppxNJz0sxi/B6PNXeiomT6IESQvoGrrcsg4niOO59OrvHFHudJyTvP42RCVUN0+6b3up6nRKTgBkUiOKfsa/upyL5LBrU4HBQ5Zn1ox1c3taeGMvgTWUJF/4A5VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758857387; c=relaxed/simple;
	bh=oxJYxf0D9wV8jG868hZUqa1ZKRfoGHriX6agd45f2Vs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TJmDQs6MMZBY7T5qYT0VAA9lrXCKl5pv45QuU0adFl901rSXm0mL5L2dFf9737hnn28j/iP7H0hVnqUH60AVgmNCrSztr/logAOtllp+M+Y8QomOUsXXIb+IhpEA46+CkLlxfG/42N8YE4SRTdtqPisuHGwWQhblAb4ddl3vi8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Adzs9ryT; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-780fb254938so1585503b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758857385; x=1759462185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cqb2NoUTnDZS2ow9iX9NrbUXLUr3u3oGiPzjXhRf4WI=;
        b=Adzs9ryTRVjutdUfOZo8MZ+Nv/pDd6RO82hM8TsUXKmNQlBF5u8DVlFCl9cLs0q1Vf
         bfAalpyJ5FZuLC5weLScqv60ydwyrzGY1AMZjMsJJ0sz0NRAxZa7jN78XwCfqAMn/lzi
         HgxkoE9oWY0yd0r0SzmO3sgdtW0MFN5j97w5DPxcHFidR9bOgIwet+AxQkabrnzFfkXJ
         yTjDUkamlkCPEtL74YMPvq9F4+sOEJLT9W6tw/cXVUz+Aaund27QZzmnr6kn6GCMDRqU
         6oRnAYovxp59kr8pkekIaDehX5v1TH+IVpeI55dqCMOPMhNXd3+dTu/y2PMySGX64uEW
         62vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758857385; x=1759462185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cqb2NoUTnDZS2ow9iX9NrbUXLUr3u3oGiPzjXhRf4WI=;
        b=n1lTQQOJUs/xHJhAcloVFZBBVdcbMFkSXUjrJgFPiAEzAAZN5zJM2P9xSdV9H0AGBZ
         pzAXEtfJYhmX7Rt2TWLQ4g/cnkkueSdj7iCP+ZGt5Cw/rH7n+MJGhI3ULzNEmUyPFz99
         sYAbLRU5OvS82D0FDUqT7O3xlIpCPynd4+5RBmsneyXQuGauNiu7MKAKCHSgYtwpDR7L
         2ut/7K90VguEogK2b1FEr/CRwJaKzVDMfBJcrEfd1975hOpngf7rDzIwo01qgQ9sCpGz
         9C34zFTLj9pVRWOWXyMZPcIfsFjbiByPVsJcIGTt9Vfc25StQk5MgLCEcoRY78zmCbay
         sC9Q==
X-Gm-Message-State: AOJu0YyEFYgXbpQlMIge5bnAlX7tUYlCnCkHBi2E6hoVfwU/e9aXdKcH
	Gwqm/2UUPqOs9YFfZ5dkr3WiIb1G+3yu93pEWAT28ktv/LJQ6dcL7cLtdpBJv7YFEGz/0y6hkDc
	tPHB3hCMCRxgv38agaFF+XjKiUYrsVLL+OUg3cgVWGzMtrVAXlW5EFcNN1C6IHrRNSVELFoTjEN
	qeA451AHj3YaFYwTxELsJlp9mAmMZXqzehyRjFpJta7eM6M7RI
X-Google-Smtp-Source: AGHT+IHfz31e/L7FazMfu8I2SfXMQ/HoIay4ORSfOQCBxSSNn+ogqXoP8JKxROYWd7iNLznlW4g3OHJ1n0sP
X-Received: from pgbfm2.prod.google.com ([2002:a05:6a02:4982:b0:b55:381:5559])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:258c:b0:252:2bfe:b65a
 with SMTP id adf61e73a8af0-2e7c4ea12b0mr6986315637.7.1758857385110; Thu, 25
 Sep 2025 20:29:45 -0700 (PDT)
Date: Fri, 26 Sep 2025 03:29:14 +0000
In-Reply-To: <20250926032931.27663-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926032931.27663-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926032931.27663-7-jstultz@google.com>
Subject: [PATCH v22 6/6] sched: Migrate whole chain in proxy_migrate_task()
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
 include/linux/sched.h |  1 +
 init/init_task.c      |  3 ++-
 kernel/fork.c         |  1 +
 kernel/sched/core.c   | 25 +++++++++++++++++--------
 4 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5ca495d5d0a2d..4a3c836d0bab3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1243,6 +1243,7 @@ struct task_struct {
 	raw_spinlock_t			blocked_lock;
 #ifdef CONFIG_SCHED_PROXY_EXEC
 	enum blocked_on_state		blocked_on_state;
+	struct list_head		migration_node;
 #endif
 
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
diff --git a/init/init_task.c b/init/init_task.c
index 4fb95ab1810a3..26dc30e2827cd 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -174,10 +174,11 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.mems_allowed_seq = SEQCNT_SPINLOCK_ZERO(init_task.mems_allowed_seq,
 						 &init_task.alloc_lock),
 #endif
+	.blocked_donor = NULL,
 #ifdef CONFIG_SCHED_PROXY_EXEC
 	.blocked_on_state = BO_RUNNABLE,
+	.migration_node = LIST_HEAD_INIT(init_task.migration_node),
 #endif
-	.blocked_donor = NULL,
 #ifdef CONFIG_RT_MUTEXES
 	.pi_waiters	= RB_ROOT_CACHED,
 	.pi_top_task	= NULL,
diff --git a/kernel/fork.c b/kernel/fork.c
index 651ebe85e1521..f195aff7470ce 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2133,6 +2133,7 @@ __latent_entropy struct task_struct *copy_process(
 	p->blocked_donor = NULL; /* nobody is boosting p yet */
 #ifdef CONFIG_SCHED_PROXY_EXEC
 	p->blocked_on_state = BO_RUNNABLE;
+	INIT_LIST_HEAD(&p->migration_node);
 #endif
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bccaa4bf41b7d..9dfc4d705e295 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6750,6 +6750,7 @@ static void proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
 			       struct task_struct *p, int target_cpu)
 {
 	struct rq *target_rq = cpu_rq(target_cpu);
+	LIST_HEAD(migrate_list);
 
 	lockdep_assert_rq_held(rq);
 
@@ -6766,11 +6767,16 @@ static void proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
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
@@ -6781,10 +6787,13 @@ static void proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
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
2.51.0.536.g15c5d4f767-goog



Return-Path: <linux-kernel+bounces-774545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFD1B2B402
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E7597A7554
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AE727B4FB;
	Mon, 18 Aug 2025 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oI0dVMDQ"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F82A27EFFA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755555194; cv=none; b=dyUF6jYOwSGF9a8VlvFX6wh9T05heBIBppdM1+q9TKYCQw7GckLIYjfhl0Bt5xP5yseI/D4TneyYMV8o1yB/GEIZtluGxbmkW3ps8zPmd44i0YEsQqZdYyDSPX7nOd+GoCDLabVxDSaXFiUCYTu0x5WXs+a1E3Va+RA898Whm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755555194; c=relaxed/simple;
	bh=5LmBBDqFOYskg7ms6H4wHoeRGNX+KQniVnjQMJE2WUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CCuLKzhV00EE2jNLI72YHLB76RTkX18n9yItjkU4yOgvj95tMoBFHa7EjaTzpdMr8oDDey2OM3LSjfEqhtsvN+yqzVxINMotXY/r5/1yNmXSwVJhJblg97b9Sc0PFEsG6qua31MgMogd1dcN8kHBWV13nVi6VMMDdAzMITDipkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oI0dVMDQ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b471737c5efso3473373a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755555191; x=1756159991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ndMdO3Tf+w2FRYTU7afKwsWLY2948xsCFyezPApkqdM=;
        b=oI0dVMDQj4lBd18h74L5nZM7dPP7h3Kx9/HyDq3nqxuWoC18sWM/w9lXVibsuZv7T4
         yozm4/U9niIslvcIHlSPtrEw2amEvNblmjVjQ4Gm8BH2gqQAUGX+OXjE3os3ONagxnvk
         JFi6X/bsH7lhrtqXdoBHeOQeFRLNawBFOjFjhBqN0prWPUc2BJmKVSiQ7QDaDYAOgFwX
         6CjUnRMrEgdwaLWAtJ7P97zvGsnkbSWUD7lctj6Bt3b98NdZpwYWdk4msocqa4LaaBuK
         w+kMUm61Xgmpt32wnL2iwQpU/OXGjH7bD/k3qVqXOCMhgubrNCbTrv1XxHz0Sw+qvO+B
         +Jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755555191; x=1756159991;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndMdO3Tf+w2FRYTU7afKwsWLY2948xsCFyezPApkqdM=;
        b=c4bBNptatDg5A2eJPUE5nwY86ti6X8UnP4Ssg6Uc5+ysK1uEyV4ytUDvP38/kJgpkm
         /4vmuH4BotGSce6lB94lIA0Be9U59xRl5hUwlofXWBbsFdhJSBwaqGUixz5+0hh9324+
         naGsw5ebvCe8MGzPwCvqKz2k+JI09V61Nw/fl98Yk9MmM7Fwz3/GlZjshx50UQYS4uJp
         0c4SJWLdJPpl0XeJq3hQ7sYeWumWbc4b3r/M1QUMlLPBU/Y2g9BrKJPqP61U7x8FKQF5
         xdA12k0ATcOIzkXTEhZOZRP1sjHcLRAPu3jzWmPvsn3X0HztLHAnQcOUvwDKld4XKnuX
         3BzA==
X-Gm-Message-State: AOJu0Yy2VM3u+hCXc3IBL1n16mmHpM+CFvZFjVIG6BGa1VdhHI8DDU8t
	VB8N9Yd3HKTvPnYthSc/ANQHHIAC1PrNdB8rXhTYzF+OEAYQNsPu5bG4Tywy7wOhCydyY+56RpE
	7oeA8Y9PqTnMwmmQBG64BQoFrDWN1QZExJBqpp0BsJ1wllhYw9uD3nO5gwNURgHwwhOs4YId69H
	bB/ZFnxrgxe5MGaWNZf52T+MRVo9Z1Q7nuCP5UTKq8xi/kOzvB
X-Google-Smtp-Source: AGHT+IGOuGUUz+OlZaKqx2JA8EJiDymsIyADQMIxP3xF7qDMlOTpVBBmdAqaUuq+YkO+EG/5R6C4ci913zxg
X-Received: from pjbsz5.prod.google.com ([2002:a17:90b:2d45:b0:311:ff0f:6962])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3c90:b0:240:265f:4eca
 with SMTP id adf61e73a8af0-2430d42de1amr268963637.36.1755555191358; Mon, 18
 Aug 2025 15:13:11 -0700 (PDT)
Date: Mon, 18 Aug 2025 22:12:56 +0000
In-Reply-To: <20250818221300.2948078-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818221300.2948078-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818221300.2948078-7-jstultz@google.com>
Subject: [PATCH v21 6/6] sched: Migrate whole chain in proxy_migrate_task()
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
2.51.0.rc1.167.g924127e9c0-goog



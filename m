Return-Path: <linux-kernel+bounces-794430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19365B3E19D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F492170BB3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69B93101CD;
	Mon,  1 Sep 2025 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b59B1LPS"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D229630F558
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726269; cv=none; b=TkER3sCn1wwN+vFWUmPqtssOmgz1hzq21/RKxmb6aej7mH3oRgBSo9cmg98H5pj3IwVoi85ZJX/0eAjhFsxJi9ETURmWzmQoXZWQ1h1rulhjxcfH+80qz248L3lzs/bcg0UareIcrgGrPywU+ZpHytsVlzSzwNSnRlHXHxLT4kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726269; c=relaxed/simple;
	bh=YU8V5hZHLLQyOv9IZ9CFbTgi+vD0/9ysa+TyP4ZHiVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZA61zQ1NUZ5Yabz5lqhIjctO5zhBXPnabjTg/IUj7nUwF0VBX80NlajptfTw18m8eS3GMmmi5MMHByAlgqgfxIdZNyakkiSQFcdQY8nEHeyxWfHwgi0QuytD4tWzDIAFAHNk1dGUhaNCgqBGWlO4kwOWyYbAPh+PmuGa/ARiQj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b59B1LPS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so1974387f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 04:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756726266; x=1757331066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K16zoObnr76blHb266X2WZODOudqowFO2iBWcxnwPNY=;
        b=b59B1LPSdzt3Au4HWB5kE7z9I2xQ4XLNBNar9701VPPxEpVkgu9WpPpEsgV6U3KQFS
         tkmTbbPM/Ib1NJzXKsWniuOotBcgNyn7Kt5i9zbKO4A6abYaYXvkqTrh12uOBg0Gtor4
         hKDH5AhuDq735Ft8OJlU9qho3TyHWWtTc4SSBNy+hYPjObLUuiGPojkvzXr0QRNoNSpj
         oleZfb+dQPxE3tKkhOtHeC1IuZzh8LbvJ9C1uafGktzB7wUaz+sqtj//4Xr1VYT5fwm7
         GLgBIRODVcR+iDDdCV3yY3L1rvhuG/enZzQOOMG/BFOtNYWEs5LrFkJJ0U+HDOfmmF7p
         4PhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756726266; x=1757331066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K16zoObnr76blHb266X2WZODOudqowFO2iBWcxnwPNY=;
        b=pxTxtsmFtuTrwYtc9DUwCfh7hKKjo086bvjHtWcDAGirkMknJoDy9pt6bxa3TKslCu
         +dpG4fY06AwLypM2bP8UgbTZCztP6u1MebfcnBbATLQHPhqjExBDrORVw0B/EJRZCeoh
         k3DiEbAgar7YN3Drlc49HQEnInWXDok2k9fZpAhFW5EFtslPiAsKZ/BykL0IzsfXOrqt
         Yj2+cBZTh6rfzCPEh4T2Dl8kKHg4C1l9rbPXjg7eqwIu2DGX4ZFvD7PGiUY1FV968RXt
         BFD8grF5SIdP4CH681pW8Yc24zKr/3brgLo1XSmI0oqKQ8NseRF6cZfBzrpqqqIyjO7T
         xxYA==
X-Gm-Message-State: AOJu0YxhDhm9OlGuh8wt+/cTC3tOSzDmC1NehbWFXO//NGwlUYIiKtm7
	tMH58r+QMAjG5JQP9Z9iwLWKD+/NOBb6ujEpsiJFggcLQscPE7MxDMk+
X-Gm-Gg: ASbGnctvexwWoxRytDx0GJNeNBGgsZ0TiLWYAt6EXp2VYZ5ht9xYq+cz0Br+1etF/8M
	mosZD5TDSg6Oehqc/CJ0u+bre/LC8Hpr8xlAQimvZmetVmGxaDtvFHjAdAwxs5GJ8pNGaIBQjal
	XvYkwDcSgfHoBu7BxnI9TCFzn0+nHz4M2Kv3nwGfYTSahHwhZHlI/ZFkDQGHmjv8b2OqzZVsd+7
	9EJ9ohoeervxPc6UVeoTWwX8idnI2YI+W1VjW6UJ6WVkQuRyYB5UlRu2Mq8FTqnXUCosSN7AO5R
	8SQMOlx69OLKb9FPcyz5HNLQMeUDzEYE27aOnadEK3BJfsqboeslKnw/sr5VCzHWt3taBURM+bI
	cM451oD7IUU3VPOB9F8YFGUvaCebsWA==
X-Google-Smtp-Source: AGHT+IEiacFTg8eVwm3sI/IpZu2rD13HmN1ht8nbBpl44hc/T4KUs7+uYXoJk/2Q/+iyJlQJ2pnzKQ==
X-Received: by 2002:a05:6000:2f86:b0:3b9:16a3:cf9b with SMTP id ffacd0b85a97d-3d1dd81c540mr6901980f8f.5.1756726265751;
        Mon, 01 Sep 2025 04:31:05 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d21a32dbc5sm10388269f8f.11.2025.09.01.04.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 04:31:05 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [PATCH v3] sched/deadline: Remove fair-servers from real-time task's bandwidth accounting
Date: Mon,  1 Sep 2025 13:31:03 +0200
Message-ID: <20250901113103.601085-1-yurand2000@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fair-servers are currently used in place of the old RT_THROTTLING mechanism to
prevent the starvation of SCHED_OTHER (and other lower priority) tasks when
real-time FIFO/RR processes are trying to fully utilize the CPU. To allow the
RT_THROTTLING mechanism, the maximum allocatable bandwidth for real-time tasks
has been limited to 95% of the CPU-time.

The RT_THROTTLING mechanism is now removed in favor of fair-servers, which are
currently set to use, as expected, 5% of the CPU-time. Still, they share the
same bandwidth that allows to run real-time tasks, and which is still set to 95%
of the total CPU-time. This means that by removing the RT_THROTTLING mechanism,
the bandwidth remaning for real-time SCHED_DEADLINE tasks and other dl-servers
(FIFO/RR are not affected) is only 90%.

This patch reclaims the 5% lost CPU-time, which is definitely reserved for
SCHED_OTHER tasks, but should not be accounted together with the other real-time
tasks. More generally, the fair-servers' bandwidth must not be accounted with
other real-time tasks.

Updates:
- Make the fair-servers' bandwidth not be accounted into the total allocated
  bandwidth for real-time tasks.
- Remove the admission control test when allocating a fair-server.
- Do not account for fair-servers in the GRUB's bandwidth reclaiming mechanism.
- Limit the max bandwidth to (BW_UNIT - max_rt_bw) when changing the parameters
  of a fair-server, preventing overcommitment.
- Add dl_bw_fair, which computes the total allocated bandwidth of the
  fair-servers in the given root-domain.
- Update admission tests (in sched_dl_global_validate) when changing the
  maximum allocatable bandwidth for real-time tasks, preventing overcommitment.
- Update admission tests (in dl_bw_manage) when offlining a CPU.

Since the fair-server's bandwidth can be changed through debugfs, it has not
been enforced that a fair-server's bw must be always equal to (BW_UNIT -
max_rt_bw), rather it must be less or equal to this value. This allows retaining
the fair-servers' settings changed through the debugfs when chaning the
max_rt_bw.

This also means that in order to increase the maximum bandwidth for real-time
tasks, the bw of fair-servers must be first decreased through debugfs otherwise
admission tests will fail, and viceversa, to increase the bw of fair-servers,
the bw of real-time tasks must be reduced beforehand.

This v3 version removed capacity/frequency scaling for fair-servers, given
commit fc975cfb3639 ("sched/deadline: Fix dl_server runtime calculation
formula"), and fixes a bug which prevented offlining CPUs. It also addresses
other comments mentioned in the v2 thread.

v1: https://lore.kernel.org/all/20250721111131.309388-1-yurand2000@gmail.com/
v2: https://lore.kernel.org/all/20250725164412.35912-1-yurand2000@gmail.com/

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/deadline.c | 84 ++++++++++++++---------------------------
 kernel/sched/sched.h    |  1 -
 kernel/sched/topology.c |  8 ----
 3 files changed, 29 insertions(+), 64 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f25301267e4..2329dfc6ab0 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -141,6 +141,24 @@ static inline int dl_bw_cpus(int i)
 	return cpus;
 }
 
+static inline u64 dl_bw_fair(int i)
+{
+	struct root_domain *rd = cpu_rq(i)->rd;
+	u64 fair_server_bw = 0;
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
+			 "sched RCU must be held");
+
+	if (cpumask_subset(rd->span, cpu_active_mask))
+		i = cpumask_first(rd->span);
+
+	for_each_cpu_and(i, rd->span, cpu_active_mask) {
+		fair_server_bw += cpu_rq(i)->fair_server.dl_bw;
+	}
+
+	return fair_server_bw;
+}
+
 static inline unsigned long __dl_bw_capacity(const struct cpumask *mask)
 {
 	unsigned long cap = 0;
@@ -1659,48 +1677,22 @@ void sched_init_dl_servers(void)
 	}
 }
 
-void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq)
-{
-	u64 new_bw = dl_se->dl_bw;
-	int cpu = cpu_of(rq);
-	struct dl_bw *dl_b;
-
-	dl_b = dl_bw_of(cpu_of(rq));
-	guard(raw_spinlock)(&dl_b->lock);
-
-	if (!dl_bw_cpus(cpu))
-		return;
-
-	__dl_add(dl_b, new_bw, dl_bw_cpus(cpu));
-}
-
 int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 period, bool init)
 {
-	u64 old_bw = init ? 0 : to_ratio(dl_se->dl_period, dl_se->dl_runtime);
 	u64 new_bw = to_ratio(period, runtime);
 	struct rq *rq = dl_se->rq;
 	int cpu = cpu_of(rq);
 	struct dl_bw *dl_b;
-	unsigned long cap;
-	int retval = 0;
-	int cpus;
 
 	dl_b = dl_bw_of(cpu);
 	guard(raw_spinlock)(&dl_b->lock);
 
-	cpus = dl_bw_cpus(cpu);
-	cap = dl_bw_capacity(cpu);
-
-	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
+	if (new_bw > BW_UNIT - dl_b->bw)
 		return -EBUSY;
 
 	if (init) {
 		__add_rq_bw(new_bw, &rq->dl);
-		__dl_add(dl_b, new_bw, cpus);
 	} else {
-		__dl_sub(dl_b, dl_se->dl_bw, cpus);
-		__dl_add(dl_b, new_bw, cpus);
-
 		dl_rq_change_utilization(rq, dl_se, new_bw);
 	}
 
@@ -1714,7 +1706,7 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 	dl_se->dl_bw = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
 	dl_se->dl_density = to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
 
-	return retval;
+	return 0;
 }
 
 /*
@@ -2945,17 +2937,6 @@ void dl_clear_root_domain(struct root_domain *rd)
 	rd->dl_bw.total_bw = 0;
 	for_each_cpu(i, rd->span)
 		cpu_rq(i)->dl.extra_bw = cpu_rq(i)->dl.max_bw;
-
-	/*
-	 * dl_servers are not tasks. Since dl_add_task_root_domain ignores
-	 * them, we need to account for them here explicitly.
-	 */
-	for_each_cpu(i, rd->span) {
-		struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
-
-		if (dl_server(dl_se) && cpu_active(i))
-			__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(i));
-	}
 }
 
 void dl_clear_root_domain_cpu(int cpu)
@@ -3139,9 +3120,10 @@ int sched_dl_global_validate(void)
 	u64 period = global_rt_period();
 	u64 new_bw = to_ratio(period, runtime);
 	u64 cookie = ++dl_cookie;
+	u64 fair_bw;
 	struct dl_bw *dl_b;
-	int cpu, cpus, ret = 0;
-	unsigned long flags;
+	int cpu, ret = 0;
+	unsigned long cap, flags;
 
 	/*
 	 * Here we want to check the bandwidth not being set to some
@@ -3155,10 +3137,12 @@ int sched_dl_global_validate(void)
 			goto next;
 
 		dl_b = dl_bw_of(cpu);
-		cpus = dl_bw_cpus(cpu);
+		cap = dl_bw_capacity(cpu);
+		fair_bw = dl_bw_fair(cpu);
 
 		raw_spin_lock_irqsave(&dl_b->lock, flags);
-		if (new_bw * cpus < dl_b->total_bw)
+		if (cap_scale(new_bw, cap) < dl_b->total_bw ||
+		    new_bw + fair_bw > BW_UNIT)
 			ret = -EBUSY;
 		raw_spin_unlock_irqrestore(&dl_b->lock, flags);
 
@@ -3444,7 +3428,6 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 	unsigned long flags, cap;
 	struct dl_bw *dl_b;
 	bool overflow = 0;
-	u64 fair_server_bw = 0;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
@@ -3476,28 +3459,19 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 		 */
 		cap -= arch_scale_cpu_capacity(cpu);
 
-		/*
-		 * cpu is going offline and NORMAL tasks will be moved away
-		 * from it. We can thus discount dl_server bandwidth
-		 * contribution as it won't need to be servicing tasks after
-		 * the cpu is off.
-		 */
-		if (cpu_rq(cpu)->fair_server.dl_server)
-			fair_server_bw = cpu_rq(cpu)->fair_server.dl_bw;
-
 		/*
 		 * Not much to check if no DEADLINE bandwidth is present.
 		 * dl_servers we can discount, as tasks will be moved out the
 		 * offlined CPUs anyway.
 		 */
-		if (dl_b->total_bw - fair_server_bw > 0) {
+		if (dl_b->total_bw > 0) {
 			/*
 			 * Leaving at least one CPU for DEADLINE tasks seems a
 			 * wise thing to do. As said above, cpu is not offline
 			 * yet, so account for that.
 			 */
 			if (dl_bw_cpus(cpu) - 1)
-				overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
+				overflow = __dl_overflow(dl_b, cap, 0, 0);
 			else
 				overflow = 1;
 		}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be9745d104f..01afa7424f8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -390,7 +390,6 @@ extern void sched_init_dl_servers(void);
 extern void dl_server_update_idle_time(struct rq *rq,
 		    struct task_struct *p);
 extern void fair_server_init(struct rq *rq);
-extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 977e133bb8a..4ea3365984a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -500,14 +500,6 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
 		set_rq_online(rq);
 
-	/*
-	 * Because the rq is not a task, dl_add_task_root_domain() did not
-	 * move the fair server bw to the rd if it already started.
-	 * Add it now.
-	 */
-	if (rq->fair_server.dl_server)
-		__dl_server_attach_root(&rq->fair_server, rq);
-
 	rq_unlock_irqrestore(rq, &rf);
 
 	if (old_rd)

base-commit: 5c3b3264e5858813632031ba58bcd6e1eeb3b214
-- 
2.51.0



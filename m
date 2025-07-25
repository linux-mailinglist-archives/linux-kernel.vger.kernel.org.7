Return-Path: <linux-kernel+bounces-746038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FC2B1223F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E813B615E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720972EF9B6;
	Fri, 25 Jul 2025 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgIBWhsk"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D72EF9A4
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461863; cv=none; b=OEeLuNpuKHvjGGBPglzdJE4HKFp/pSEXsIM5F8wgQAVK7EELSvDreL+/ppVWNV8/NvgvrYEcXvG6DtjTq1wjSyNQaUHwJORUu2H5eHjfm7/CGx9YQlc62jMB1bLmmofBUy+MhiVAxp28A8FBVgRLb/5XcRa0pMKK96Z/seyTlJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461863; c=relaxed/simple;
	bh=Gn3eebKWsSiS4NdjRP7uXI+MgMktAS5Qlxwi/pvtPe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=REX92QpetRo3jY0KYg8g3UfcnifYwt5GmBGMY9uyrBisvFPJJY5etSmAXNDcaBHhR37je+ZLXU9gxo8agNHIXmGGWZtwAmHU8IGsTxwuVGrigsZL+xWAShXqrgOzE5HhkgwK3Vi8uYl7oPzeHUAOA7/RYECci5JlVqiZSclqIF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgIBWhsk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4f379662cso1629325f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753461860; x=1754066660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VRbgCq4fNZlAkGb1/SMdXPANtDOovwal+EEfv4bwvyw=;
        b=lgIBWhskTxKXi5JjaKSa7l/HhyHK//Yq3Ua+ZCywNY7SK7A2PsByC9jdVUD3yWrjiy
         8PJThtj5hYZZZCyVRy4r/XW3dKnTbfvzhCD8OmKfP0lqkfqYSGs7FXOvf0mIqEl21pAl
         IsibbD57CIqsgtxNVkKxrtzEcwEDyOajxphiOkpIl8fu87RxCc5KBKNgvm/JS095Riaz
         2ErM8SFIbnRnI5vFQy06kFlYaVHTUvg+HJKqicvctqzKJ1WFsQ7kXeVjlEElfh9SFc2d
         aznYlSjpi9kQh9XnCXLZzTLE557O7B7KXaeEOObp7Y/EenLA+eo1OnOEOAofusjku4wY
         /w2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753461860; x=1754066660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRbgCq4fNZlAkGb1/SMdXPANtDOovwal+EEfv4bwvyw=;
        b=CxlQH8C5c/JmkJ6GuM0vpi1dXruzZo1/Reh02diWooiSy1Cv5W5U/eK7LH8F5BX7c4
         keFd7tXhiLI/0mA5A7iwHyigoRjJP5e/lAUUIpnQvZMTLyz5aaBBuDQXlA4UZeoHlqPW
         BTPxTUnDbW4VSP7WuLnr+V5j5KEAu64VJNv4RUq7ydQfrDW2wClQpjrHKD5+f0pKSc+K
         XTS5PcYvoZI0y2fDxZ7e1spwSO6vkE9OOahcAtnfbTrZNiCBp7s6QsJP+buu8NYpppjN
         dsPU1Fs0gEa2kOFjKWo+oRAQ9Q6X4l6bVJnW1xN5J/r9bnWldy27PVpqc0m7h9E/i7YI
         zVNg==
X-Gm-Message-State: AOJu0YwjUv0FZ8hepQm3t9EV9cDzkm0fFFr7gRrDQHztvRfgbWa+pl+Y
	XLHmOgJSkc9ma3WBxCdLeNlVIifZ0F4EV7cfr/7tgbjn7ZMVZpqteE5o
X-Gm-Gg: ASbGncsj28NDZqxakqjmux1DRIFPnKaq8aH2hJsE6z8WpVs7T/ERcMh0xvGbYBQ5AFI
	dTocgh3XvHl9x3lFQ36oov5m/OJGbLqejv62iJ+gJDB+6wO0wACENtSXYT9SzOlXC+qUNlpCe7c
	tsdNKN9YMyiuNbXvl3F+upyUOlFbs8lgXfANflkVUj3NXtSkrhn8j2N3TJOKxkFTKb6P+VW36AD
	2Xk8baoJ8u0MjhomRwFLq5fQpmjtJzUmrIyeNOfMaR1D2UZ/4iag8vPKLThg7QioyqWd1sgdTEV
	zduezasQ4h5AWHumcspCwVh4tHU5BN13Edvu7H17NKtDHYvi6RsydGGp4CoK4FfA6oyOJBYfDC6
	MZ0Q5bXxUMd9k4TYyjFO2KGWg3m3lSdzUhv4qdKUJc1BdNdhIYYI8bZMcqlVqJT6o
X-Google-Smtp-Source: AGHT+IEjFsKD5TQ383QRV4VZRgtItMZehoW+k/OX7TYpRsAY4Jqld53XLNvY//w/92Wrif+Y95ebMA==
X-Received: by 2002:a05:6000:4304:b0:3a3:4baa:3f3d with SMTP id ffacd0b85a97d-3b7767159a4mr2447707f8f.6.1753461859773;
        Fri, 25 Jul 2025 09:44:19 -0700 (PDT)
Received: from yuri-laptop.sca.unipi.it (opnsense-fib.sca.unipi.it. [131.114.30.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f03650sm356586f8f.44.2025.07.25.09.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:44:19 -0700 (PDT)
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
Subject: [PATCH v2] sched/deadline: Remove fair-servers from real-time task's bandwidth accounting
Date: Fri, 25 Jul 2025 18:44:12 +0200
Message-ID: <20250725164412.35912-1-yurand2000@gmail.com>
X-Mailer: git-send-email 2.50.1
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
SCHED_OTHER tasks, but should not be accounted togheter with the other real-time
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

Since the fair-server's bandwidth can be changed through debugfs, it has not
been enforced that a fair-server's bw must be always equal to (BW_UNIT -
max_rt_bw), rather it must be less or equal to this value. This allows retaining
the fair-servers' settings changed through the debugfs when chaning the
max_rt_bw.

This also means that in order to increase the maximum bandwidth for real-time
tasks, the bw of fair-servers must be first decreased through debugfs otherwise
admission tests will fail, and viceversa, to increase the bw of fair-servers,
the bw of real-time tasks must be reduced beforehand.

This v2 version addresses the compilation error on i386 reported at:
https://lore.kernel.org/oe-kbuild-all/202507220727.BmA1Osdg-lkp@intel.com/

v1: https://lore.kernel.org/all/20250721111131.309388-1-yurand2000@gmail.com/

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/deadline.c | 66 ++++++++++++++++++-----------------------
 kernel/sched/sched.h    |  1 -
 kernel/sched/topology.c |  8 -----
 3 files changed, 29 insertions(+), 46 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e2d51f4306..8ba6bf3ef6 100644
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
@@ -1657,25 +1675,9 @@ void sched_init_dl_servers(void)
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
-	u64 new_bw = to_ratio(period, runtime);
+	u64 max_bw, new_bw = to_ratio(period, runtime);
 	struct rq *rq = dl_se->rq;
 	int cpu = cpu_of(rq);
 	struct dl_bw *dl_b;
@@ -1688,17 +1690,14 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 
 	cpus = dl_bw_cpus(cpu);
 	cap = dl_bw_capacity(cpu);
+	max_bw = div64_ul(cap_scale(BW_UNIT - dl_b->bw, cap), (unsigned long)cpus);
 
-	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
+	if (new_bw > max_bw)
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
 
@@ -2939,17 +2938,6 @@ void dl_clear_root_domain(struct root_domain *rd)
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
@@ -3133,9 +3121,10 @@ int sched_dl_global_validate(void)
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
@@ -3149,10 +3138,13 @@ int sched_dl_global_validate(void)
 			goto next;
 
 		dl_b = dl_bw_of(cpu);
-		cpus = dl_bw_cpus(cpu);
+		cap = dl_bw_capacity(cpu);
+		fair_bw = dl_bw_fair(cpu);
 
 		raw_spin_lock_irqsave(&dl_b->lock, flags);
-		if (new_bw * cpus < dl_b->total_bw)
+		if (cap_scale(new_bw, cap) < dl_b->total_bw)
+			ret = -EBUSY;
+		if (cap_scale(new_bw, cap) + fair_bw > cap_scale(BW_UNIT, cap))
 			ret = -EBUSY;
 		raw_spin_unlock_irqrestore(&dl_b->lock, flags);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d3f33d10c5..8719ab8a81 100644
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
index 977e133bb8..4ea3365984 100644
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

base-commit: ee90c3bb525e6ea0845e5b70f0beef0abc8f2373
-- 
2.50.1



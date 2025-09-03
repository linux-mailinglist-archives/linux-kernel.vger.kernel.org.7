Return-Path: <linux-kernel+bounces-798395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E597B41D42
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 408364E21CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBF32FB973;
	Wed,  3 Sep 2025 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ix2vMYZT"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129E82FB62C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756899894; cv=none; b=OkexlYK3CWKV5tSe1batACVYVhM5PZ1CQwmUHNTDYaWnAv+w+5to9baOVK5szU/xSishhxgC4UDTAVk6waHauoi36RQ/CrBFNfk6wZXc+thuyX+aZ4fixPlg86bjJW3wR1Hcv7ixSul0DPlUGVeYj3dYEVVbMgd9WarGV628idw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756899894; c=relaxed/simple;
	bh=FgeaLRmJ98PxA0HzbWZHiowbs5UdLqUGz/eQEqut9vI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qlddh6raeSTVxpNumQp34XrYpZN0nGt///O0DscZw1o/TsZyskrV2zb0JW1ZS5FAVZToCO8/zdurC565An4NxDTlFCT9P12CsVxes+VkTRB45cBuQaRrY919RQ8jY56v58enLTmRSUI+5uXDs49WSmUPBBamnhaL1Fj02EjFljY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ix2vMYZT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45cb5e1adf7so5185545e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756899890; x=1757504690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qkHCi90Prsx7EhJyvb4hJ+KWmQTZHqZlClenCTV65TA=;
        b=ix2vMYZTAAISBOmnSCvWWjmMePCY9wNn8Bg5X9JCPjpeqMnLgPhBXDOOHZAUb+8TvH
         tgf2W0EbTx7PC9pLVYjqV8kuiE6kM/pljbio8zYTpGLtVxYmmNrAUEqOkhCI8AMtprA2
         35kLRM8TsqA4EneJwVbx7QcE/4Xm8Pvmf2G0wuOVdj7ySJVTYY/E4MRDqBafW712g85a
         j1M4GXdLT8tuiO6tqo2k/S8zKN3k2JDeRmT0yMDZ+WdDZW/yN+OHKG6FIozmxMmZPD+E
         kOL4E/Pn+8t1jK/L59Z9jWsUtztgdbj7swZPs1JFCFzGL+3NEncWEHl7YOEOyyk0dVCR
         4Ehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756899890; x=1757504690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkHCi90Prsx7EhJyvb4hJ+KWmQTZHqZlClenCTV65TA=;
        b=Q0ja0GIVBZOmF/HnUrQVW30MqM3tL9Mm9EGXaoMpf/X0NQlm9JVVOrf54k1YnjFwBU
         3HOp44qjtE01OAe6y4L0uZPIBJu82Vy4CBNUy97PzSOhv/ZVIJhd1fTtqemJkbc1xuZZ
         LY3L3RI9xm/zRLL7wZg/C68Jp4UpeXjkF/XcLtpE/rG2Kt+bmbZfu408FNQxrMt+629W
         CT07xna8hN1yDx+pUbwgEjLthdZ+Dp0OTrXESztV2Nsy/h4FH1OZuybs1sGBOECG9r7N
         LEfqG/Kwo0cvcoAPEIzVGGF0CN+i+Fm2shw3aMCAq7WaecIY45v1BDH5EwpnFjFhWm2D
         40Bg==
X-Gm-Message-State: AOJu0YxmW+WlGmUJwsm0BJa6WSN6pe5Ty4z8GOGcHwVcvJ4ktA0hq9me
	WcHyaWIrPRDio928LLTrAG7y/OlxCMLQmoPnYXziPyt9qb/bqp7XJhL6XWDb4205VkY=
X-Gm-Gg: ASbGnctacaFe+iejLYTRmMqdZ0Y0MWeHM2JV4q/tgeh630SNOxy1iZvR2DegXe8t/h4
	hKOYrXjTXGKsv7inXGFH6EIjytdi+VDyQpyXsouF4EssL33cNhc6Hzyh98rXvAKLgPpT2SjsXBS
	YKWN0reXceSOCqoTP0Thsk9AcT+713SNlHj/dMdREZuTMkw9NglexvxyzyceFOSRz/9hlWdaSyH
	WfF9gwq65ja4mGDdzLSWvuTySXacuOOVxeGZ5Gn6d0LDosSI0CcwCGEiIQOfXOb/d0HewvRxVSz
	4Vf8gXefPLh8tdfbb49AVMbgJtrNLN5RMhEmoW4vjM1w3+UGPwvHmq2wm1K1Ps4GWShvPzksUsV
	zPCtF/Wq77V00VNST6gI=
X-Google-Smtp-Source: AGHT+IGJRD4xpdmKr1eRs2wzmob0Wqf7qEeMnQKN85y3fhW+s1s36l9XCCq/QqAEzFcM/KPlq4tALQ==
X-Received: by 2002:a05:600c:1394:b0:45a:236a:23ba with SMTP id 5b1f17b1804b1-45b85575801mr115309525e9.22.1756899889964;
        Wed, 03 Sep 2025 04:44:49 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b990acebesm38518605e9.3.2025.09.03.04.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:44:49 -0700 (PDT)
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
Subject: [PATCH v4] sched/deadline: Remove fair-servers from real-time task's bandwidth accounting
Date: Wed,  3 Sep 2025 13:44:48 +0200
Message-ID: <20250903114448.664452-1-yurand2000@gmail.com>
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
same bandwidth that allows running real-time tasks, and which is still set to
95% of the total CPU-time. This means that by removing the RT_THROTTLING
mechanism, the remaining bandwidth for real-time SCHED_DEADLINE tasks and other
dl-servers (FIFO/RR are not affected) is only 90%.

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
- Update admission tests (in sched_dl_global_validate) when changing the
  maximum allocatable bandwidth for real-time tasks, preventing overcommitment.
- Update admission tests (in dl_bw_manage) when offlining a CPU.

Since the fair-server's bandwidth can be changed through debugfs, it has not
been enforced that a fair-server's bandwidth must be always equal to (BW_UNIT -
max_rt_bw), rather it must be less or equal to this value. This allows retaining
the fair-servers' settings changed through the debugfs when changing the
max_rt_bw.

This also means that in order to increase the maximum bandwidth for real-time
tasks, the bw of fair-servers must be first decreased through debugfs otherwise
admission tests will fail, and vice versa, to increase the bw of fair-servers,
the bw of real-time tasks must be reduced beforehand.

This v4 version removes dl_bw_fair, as it is not needed anymore since each fair
server's bw is now checked individually rather than globally. This is necessary
because different fair-servers can have different runtimes. The bandwidth
assignment is sound only if each CPU's rt-bw + fair-server-bw is less tahn or
equal to 1, rather than computing the total and checking if it is less than or
equal to the number of CPUs. The check on deadline tasks can be instead be done
globally (on a root-domain basis) as dl tasks are allowed to migrate between
cores. This new version fixes the error reported here:
https://lore.kernel.org/all/aLa3zdmyKuRMy3bm@jlelli-thinkpadt14gen4.remote.csb/

v1: https://lore.kernel.org/all/20250721111131.309388-1-yurand2000@gmail.com/
v2: https://lore.kernel.org/all/20250725164412.35912-1-yurand2000@gmail.com/
v3: https://lore.kernel.org/all/20250901113103.601085-1-yurand2000@gmail.com/

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/deadline.c | 81 +++++++++++++----------------------------
 kernel/sched/sched.h    |  1 -
 kernel/sched/topology.c |  8 ----
 3 files changed, 26 insertions(+), 64 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f25301267e4..35bcd360329 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1659,48 +1659,22 @@ void sched_init_dl_servers(void)
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
 
@@ -1714,7 +1688,7 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 	dl_se->dl_bw = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
 	dl_se->dl_density = to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
 
-	return retval;
+	return 0;
 }
 
 /*
@@ -2945,17 +2919,6 @@ void dl_clear_root_domain(struct root_domain *rd)
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
@@ -3139,9 +3102,10 @@ int sched_dl_global_validate(void)
 	u64 period = global_rt_period();
 	u64 new_bw = to_ratio(period, runtime);
 	u64 cookie = ++dl_cookie;
+	u64 fair_bw;
 	struct dl_bw *dl_b;
-	int cpu, cpus, ret = 0;
-	unsigned long flags;
+	int i, cpu, ret = 0;
+	unsigned long cap, flags;
 
 	/*
 	 * Here we want to check the bandwidth not being set to some
@@ -3155,11 +3119,28 @@ int sched_dl_global_validate(void)
 			goto next;
 
 		dl_b = dl_bw_of(cpu);
-		cpus = dl_bw_cpus(cpu);
+		cap = dl_bw_capacity(cpu);
 
 		raw_spin_lock_irqsave(&dl_b->lock, flags);
-		if (new_bw * cpus < dl_b->total_bw)
+		/* Check if the whole root domain can support the active dl tasks */
+		if (cap_scale(new_bw, cap) < dl_b->total_bw) {
 			ret = -EBUSY;
+			goto unlock;
+		}
+
+		/*
+		 * For each cpu in the root domain, check if there is enough
+		 * bandwidth for the fair server.
+		 */
+		for_each_cpu_and(i, cpu_rq(cpu)->rd->span, cpu_active_mask) {
+			fair_bw = cpu_rq(i)->fair_server.dl_bw;
+
+			if (new_bw + fair_bw > BW_UNIT) {
+				ret = -EBUSY;
+				goto unlock;
+			}
+		}
+unlock:
 		raw_spin_unlock_irqrestore(&dl_b->lock, flags);
 
 next:
@@ -3444,7 +3425,6 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 	unsigned long flags, cap;
 	struct dl_bw *dl_b;
 	bool overflow = 0;
-	u64 fair_server_bw = 0;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
@@ -3476,28 +3456,19 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
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



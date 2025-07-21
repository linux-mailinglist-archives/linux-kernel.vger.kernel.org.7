Return-Path: <linux-kernel+bounces-739144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4530B0C253
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC4118C367B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DEC293C5E;
	Mon, 21 Jul 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVESGMrV"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C948293C7C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096297; cv=none; b=e+6KKTQtFwjfgv9q2sgtrZmkb7CzjstCWplC5tBlePHRmFRUubtWQpXZKYnrhPxFLz+K75lGIVQr822rUQvny8gxeMZDY67lkU8HnCdEtDegtKWNUSxM2OtYnR2HOo5F8wBwAJMeMDcadNOgynczKXK1OoGveNCvPYJAccT2CAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096297; c=relaxed/simple;
	bh=Uxv8Ufc0YEmU/dEm5QctHDxZmjkPHSnfb1lKX7nSVg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LiL1UF74sYO3/1pcS0HVIENp7wDGaO3FmO/lN3nUIMzzNd3SlmPvU89Jd+XNaJ3wXC2ZJR2u+kltizQnqIDDGlEUeL5sEyPKUtjdynEnFFoQ9AKHSROeLjFzZCybreoVSCJv1ZftT8zf5QqSlDATT458Taxyyp4OQGDdzpgZTzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVESGMrV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451d6ade159so30416735e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753096293; x=1753701093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PzRWUOwmh6jQaA4dvwMb3cW3wU5FLdyw3hTFeO/UOVQ=;
        b=IVESGMrVUy+u8hXrQDMDfXPHyBGGyB8ZE8nLBDaQ/Swz7U3LypUHmnxrh0xED+nMwZ
         snNvjmpQUNq9Y+BhZJRZ2UyV01B7RCYnxpPwOpqPXF4G9Bzam7qQ2+gh8TCCbShjDgqg
         w7Tx6pnfEvXc2AXf83naFz/aL6AkZmiFAIUb+s6gxQ375GXYCUogPwD3/cxfMLUGBTo0
         fpmQ7Tm6w7KWBLyyCJVaJ2UxOPd8T3/tByrJJaVEEeSu9NqYWqJR/kLXcg6PLegPoQAK
         8lFSgYqTcrXmpBbueqP4YxkfPcKT1s7Obvh1ZTVHbUi53p4ZwNyKehle2UIubsy0/x/l
         mFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753096293; x=1753701093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzRWUOwmh6jQaA4dvwMb3cW3wU5FLdyw3hTFeO/UOVQ=;
        b=aFovyEqr5G0Rhr5K1hlq1Z+oOSh2ksBcX9qFJMW0J7cXv4qz5QrGeahWKC80+39X0K
         CEpt4KK01Ff40Sw1SEeBSNh8R1SmbkPKkGxlE2YZBfaRqgpdQX60y1T31TwmK01VO/JV
         +iLiF/htq+Pk1ikW9KtcuEO3NDkDRaaq7eESsKcaD+McRtEt4c4h4JhH5+UydzYGGXFE
         6gWokg/oKayfXTYtinYoOaZvjCsvyWQL4ZakaNfKm4PAIA6hbyLDC2eKkABTMFIOovNi
         FfFhU3xMn5btQztt0PB1rFaqtujjtGnL7ZVewdjXeFp0vD79qNsb43rEm4mOelAfuzMD
         nDPQ==
X-Gm-Message-State: AOJu0YxKc9xOaREDvIz+q4YmbKD3f3iaq6BXgtYm/s6hxFsDBEil9XUa
	83pVUmTzR9D/HFhyoE89Ri3mnZBCKK/DX3LPARqUI6OJlBe49VX3QIBp
X-Gm-Gg: ASbGncv/vrS78G9F9QJsMjuw7tfy2gJYZwbuJIzBMFAUXrW/UZNNsrsDvWuWXJgi4H1
	P1lFBMsMwZzg6Wyf5P4cemq9Rns4b7QUZZtkJDP6dKTmyL+Mn6n1lK+oEOI21lcx5CyHrtCYFne
	AHXzHFvUcB+aSW41h1LXHjRixPRSqTw8uFeUHedZfveBS13FB+Rdg96UKP364NRANdvt5wnTzcT
	dJ6oPxBoUPjM3IjtdTRZlxuOcauo2Po8zSy/F9/DAl7kLTRmdoqueA6n62TpYSZ35l3XjAH6nBb
	riSm2oaVZtiuOO/mtexNpmxyOi1gQPBoayhvKM0EZzH6LTcqT8XdiuViWZVg1niQH/QAdz18zex
	dbwt7TyYxWga84ENZW+k=
X-Google-Smtp-Source: AGHT+IEd3Lm44AqJpaqNLDKa18VZQEVZ51xZKIwLi9KoS0BXG31rmRjoNR1BcOD5Lwxi2tqpATftxQ==
X-Received: by 2002:a05:6000:40de:b0:3a4:eae1:a79f with SMTP id ffacd0b85a97d-3b60e5240damr18098393f8f.33.1753096292930;
        Mon, 21 Jul 2025 04:11:32 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b74f5f3sm95623615e9.25.2025.07.21.04.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 04:11:32 -0700 (PDT)
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
Subject: [PATCH] sched/deadline: Remove fair-servers from real-time task's bandwidth accounting
Date: Mon, 21 Jul 2025 13:11:31 +0200
Message-ID: <20250721111131.309388-1-yurand2000@gmail.com>
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

To demonstrate this, I've run the following script on the latest tip/master:
----------
PROCS=$(nproc)

echo "Allocate 95% bw per task/cpu"
for ((i = 0; i < $PROCS; i++))
do
    sleep infinity &
    chrt -d -T 95000000 -P 100000000 -D 100000000 -p 0 $!
done
killall sleep

echo "Allocate 90% bw per task/cpu"
for ((i = 0; i < $PROCS; i++))
do
    sleep infinity &
    chrt -d -T 90000000 -P 100000000 -D 100000000 -p 0 $!
done
killall sleep
----------

First-off we try to fully utilize the 95% rt-bandwidth by allocating #CPU
SCHED_DEADLINE tasks, requesting 95/100ms each. This will fail, because, as
mentioned, fair-servers are also accounted in the 95% realtime bw. With the
second allocation, it is possible to show that 90% bandwidth is instead allowed
by the scheduler. By playing with the numbers and chrt(s), it is possible to see
that the allocatable bandwidth for SCHED_DEADLINE tasks is exactly 90%, while it
is possible to see through stress-tests that on CPU-hog caused by FIFO/RR tasks
(of course SCHED_DEADLINE tasks are limited by the admission test, which as
mentioned fails at 90% total bw utilization), the fair-servers only allocate at
most 5% of the CPU-time to SCHED_OTHER tasks. There is clearly a 5% of CPU-time
lost somewhere.

This patch reclaims the 5% lost SCHED_DEADLINE CPU-time (FIFO/RR are not
affected, there is no admission test there to perform), by accounting the
fair-server's bandwidth separately. After this patch, the above script runs
successfully also when allocating 95% bw per task/cpu.

Changes:
- Make the fair-servers' bandwidth not be accounted into the total allocated
  bandwidth for real-time tasks.
- Do not account for fair-servers in the GRUB's bandwidth reclaiming mechanism.
- Remove the admission control test when allocating a fair-server, as its
  bandwidth is accounted differently.
- Limit the max bandwidth to (BW_UNIT - max_rt_bw) when changing the parameters
  of a fair-server, preventing overcommitment.
- Add dl_bw_fair, which computes the total allocated bandwidth of the
  fair-servers in the given root-domain.
- Update admission tests (in sched_dl_global_validate) when changing the
  maximum allocatable bandwidth for real-time tasks, preventing overcommitment.

Notes:
Since the fair-server's bandwidth can be changed through debugfs, it has not
been enforced that a fair-server's bw must be always equal to (BW_UNIT -
max_rt_bw), rather it must be less or equal to this value. This allows retaining
the fair-servers' settings changed through the debugfs when changing the
maximum realtime bandwidth.

This also means that in order to increase the maximum bandwidth for real-time
tasks, the bw of fair-servers must be first decreased through debugfs otherwise
admission tests will fail, and viceversa, to increase the bw of fair-servers,
the bw of real-time tasks must be reduced beforehand.

Testing:
This patch has been tested with basic regression tests, by checking that it is
not possible to overcommit the bandwidth of fair-servers and that SCHED_OTHER
tasks do use at least the specified amount of bw (also varying the ratio of
rt/non-rt bandwidth).

Additionally it has also been tested on top of this fix, ensuring that the
warning mentioned in the bug report is not re-triggered:
https://lore.kernel.org/all/aHpf4LfMtB2V9uNb@jlelli-thinkpadt14gen4.remote.csb/

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/deadline.c | 66 ++++++++++++++++++-----------------------
 kernel/sched/sched.h    |  1 -
 kernel/sched/topology.c |  8 -----
 3 files changed, 29 insertions(+), 46 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1af06e48227..e97a7feb59d 100644
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
+	max_bw = cap_scale(BW_UNIT - dl_b->bw, cap) / cpus;
 
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
 
@@ -2932,17 +2931,6 @@ void dl_clear_root_domain(struct root_domain *rd)
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
@@ -3126,9 +3114,10 @@ int sched_dl_global_validate(void)
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
@@ -3142,10 +3131,13 @@ int sched_dl_global_validate(void)
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
index ac953fad8c2..42b5d024dce 100644
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
-- 
2.50.1



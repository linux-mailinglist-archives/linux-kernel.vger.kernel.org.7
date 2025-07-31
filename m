Return-Path: <linux-kernel+bounces-751960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56991B16FE5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287C1170E11
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB2B2BE035;
	Thu, 31 Jul 2025 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqrfyk22"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0212BD031
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959349; cv=none; b=F0skDp7ayaccIDkbdQBgjWzWFd/v+Treqn7kmQX9EGi7LV8QzWsa0cYtiOwLCWdsRE2ZbVUOdAlNSJKeY0tvTXUC3aEDcWlp6CN/cIwTHHPUjdDhaRV1iSTW03DcV5aAYfV//fejZBd1k55vFflxnQdB6cdiFzr+A+c0GvqM6CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959349; c=relaxed/simple;
	bh=vxUvAjFI51ozTe7TYJ58k74HV+/JXtcjWQqC1kYa5n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOaeY0AZIt1GOxJdXd98ylk2fIrOCpkvLsR8xHHOyfv7eNndwEAo6I2+/IhYe7xF8KNTeijoXc7TyQ3WBb8eT7veKPbcUBEBtQiZ3SLntZ/kRS37zWH8G4QfwonEpV/giVwg21cVHHWUid28gcvHAEOa9ZVs+6MwEeI3PXAUk1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqrfyk22; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b78310b296so471979f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959346; x=1754564146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtBTnswHJbWz9qX4CMvDbzP7yVZaNKyeALd7dwNWNtU=;
        b=iqrfyk22xglFYuTYqZUu+vSIWm60SCppOlFrDb/bsgKngDsPMxY1GwQGt5yt9TVmJ8
         DdjWCiC94GPZiJJBeNuSIqTvLoSJAgbuqrrBW5LZmTtL3zborWpTnuM7vxSgUGZ3su0O
         SeOT7CvLvKg2HcHUDvugQ4GgojGbiOoObR57UImH9UKPg20qeKduXtXwQjFNsFGzYMjz
         nOE5mm7bEu5CWguFlwz/p5z6Dpt7cbdIIYKSjQj1VLd40lA4wTHufWLEs7/pkJ1ofcwD
         oTaBFvlrpwSPa2XrK8nAIDucGo0ndSoOQ47sc0oYIzos0JMW5/tHBbHXmoGC/vM0QD3t
         KqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959346; x=1754564146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtBTnswHJbWz9qX4CMvDbzP7yVZaNKyeALd7dwNWNtU=;
        b=eZoe/LplvG5iLpTWUYWC88oa6NglUJeiqObyxaJk/cSKUXERZC4OaXAdFdvLUEI2Fs
         N+7cNS7859EMNXvlt3pysAWiubHjRZWTZHxhSAbaTxCKyPkyOLdO9TmYRmKDZCzFGSAV
         3NGdyHZzUFfaDSGQ1mzNzoteN/c3CvdW4VcaUmXhoonMcvpaHsigcxDrXHqYE6oaXDQw
         HnYbxMMYBrNWOTKkVg74ownQZNqYmATw6FPAliIbK0KO0up65JjEBSyHp4HN1RJOMXmN
         tx1952EpB1RDQfmfXj4o/NNg+eM7NWcOYOrQMK+wnHdno4H57JxHMBZDbFW6MLhkDuhJ
         iy7A==
X-Gm-Message-State: AOJu0YwRWOH8/7O0XTS0oa/ZE2kYwVGcQn8yP7iP0Dvt4Ct+spn6PyAq
	7wahOhn7dymokIkPp13k6XTVsQN3ZhwT4oUOx3N6CQ7pWTQ2udCN5gLE
X-Gm-Gg: ASbGncseRzjTNYtqzop8NeFCd+tmcsiRzonnfEM08YyzE8zmhyxHvLHWFl5/z8l5ieO
	y0wWnyf6N+XOPT4lM5XcIFU3SSgB7jr1zVocSbokIW9ZpxUHb3MqFuifz3QVgJTFxbiLWCDxYTz
	a/FEQxpb8oziFvV0dYux/f43MAAdKsSad1MAwuoeEsdctn1HOT4wktkFoKHsn2f6fCa/418mwmX
	u1wA4MuVekJxUcBug+8ZSK+6aQMe6ZsmSLl0v7tQ7ZLNnumJMqJ3pDK5rMMyJhXxQzxbo/M8zXR
	NhwUxQSuynRrLtt/KCiDN0lWmkst9L6MRcC2viQ+PXvfLNHuD8Wh06pUJCIb67ExHF9dbdQMZ9Q
	+AwQGcsROq4DyJSMy69k=
X-Google-Smtp-Source: AGHT+IEQTOgRE7kWkIhApFMVKh0Arwhz81d+QiYAOCzqSinguylpX20jiLJLkn+G5YKgwD0a1l7MYw==
X-Received: by 2002:a5d:5d89:0:b0:3a3:67bb:8f3f with SMTP id ffacd0b85a97d-3b795033f01mr5418674f8f.53.1753959345437;
        Thu, 31 Jul 2025 03:55:45 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:55:45 -0700 (PDT)
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
Subject: [RFC PATCH v2 01/25] sched/deadline: Remove fair-servers from real-time task's bandwidth accounting
Date: Thu, 31 Jul 2025 12:55:19 +0200
Message-ID: <20250731105543.40832-2-yurand2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731105543.40832-1-yurand2000@gmail.com>
References: <20250731105543.40832-1-yurand2000@gmail.com>
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
index e2d51f4306b..8ba6bf3ef68 100644
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
index d3f33d10c58..8719ab8a817 100644
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



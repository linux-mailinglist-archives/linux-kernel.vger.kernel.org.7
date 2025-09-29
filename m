Return-Path: <linux-kernel+bounces-836021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDC5BA8966
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F201894B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22EF2C15A6;
	Mon, 29 Sep 2025 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2ksFtZN"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3E7291C07
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137752; cv=none; b=CQCjKal020WazboEQH/biXm2kER/HeDm1JeXZcKvMCF6Fd3/jJS1M0s7MTsmPKzJyFUaBWwMgbLCOBS+hm5r40AbvpI5le4R5dUbXY41qqbBrLwsbMwnPZS2j8jIz3RxRvvMxmNtkce2qypZHjpUh7F/hNz8fiu2CfbDPPGKAyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137752; c=relaxed/simple;
	bh=2vobuS75wZ3iblpIpVxl8dpvoj9aaH5YDpIN5T7o2tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzyysaTTvO+9le1GMaCe66yBBNZGnUa41WXIEOuVRyHlmX4lg5Pad6FkL0vCx6SczpXCe8Aq+MDZYRVP+bk+7h0PkLfR0Ka3zI+WBAR6+Csab0G5QBPWSOpv/PcWKlwWg+1jQqoFQkkPrHfhAMsodsFy/SkRjWNr80Ikfqw2lBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2ksFtZN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62fa0653cd1so6393675a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137749; x=1759742549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVIdjl25oNdyF+4lq9AqQ5rIdrsLQhC1m1Oil1Kj7Y0=;
        b=C2ksFtZNknBp5VwFgR0/g5hJbpiWmA/vWzrcYUVRSGflJnQwk3qn6RDgo3Spb7euJq
         9wFYPf4zIIESc66xuNatOsci2othcoyJZCVqSCOGmnRJ8E9gDs24T/DmWN42MCc5jtTU
         YOUSKnj9oF0te5zVkpdJ1+HX9BG2BCKyKU0b15KA9qzEqVPkuDAEE2YJKpuEUdcBIRd7
         +LLOTZ7G/0b+8efYFGaRMnFnG4WCrW4J/hM3a5/18MdJR8F4pBi7r300Z/MNf9/cOvSy
         fVnIq7xx55WjL2Qmx9ZfhvZMZ2CITUmHc4tKD4vOYBUDBzPWlud6O6sSJ5LIBY58TaQy
         RiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137749; x=1759742549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVIdjl25oNdyF+4lq9AqQ5rIdrsLQhC1m1Oil1Kj7Y0=;
        b=dOAAmTsXilLZE1Pe3uEm0MWKQIToW9WphkfK8LwO0Z9Rp09gTRrfhVZE2LN907p9T1
         jCUBmSAOb0+cjUHYUtlkkjWSOFa27jSSvmo0OSI4BYASQtss4zahHcGDtMw18R4HZnnQ
         P6JFG3tx/qt40mHw72bDILr7IzVJRwH66A5X3YTD283mYICcSx3hmxS4JJAK1qIII8JB
         z3xAnuhKm3147CKTrmb9fTz05UGcpdIrQNpiSrhZSRktmgHXBCw2WA1i+m9Esz/gcGrO
         0r7SjUM1RAN7g6HIegZid47cVM/oUjVrmn4+NRIP3UxXygxFveqS/0TKTz1FYO3N/7WH
         yqjw==
X-Gm-Message-State: AOJu0YzhkDNZhNxVwbcyG6YMjiMHqMkSKf22v/JK5+iPReoVQwmCTW2/
	nFVsGVjI+mO+mhyZSeE+mSIe3RDUfMumaQ5el2HDKf+rNgM7IDvPxndP
X-Gm-Gg: ASbGncv7w5nYa4rGmfm4PKrm920IzjnWgQPGRZmbTr2rZrQxiGPj3yD0CSAXnhdT+9B
	zPzSCDlV0FS6Il9SSGC+LvXAdwynD1v6TUMhofBOIzfwTSJCDfcx4QrG9uK/sjkxEDLlg0mDhlK
	81yKB53DWWCQrpc8qVFv6jDCIkmUm9q7h/5341+5MBvzViyNZVIXnauSNsYI6AaubhumwIaWLTK
	yxlzBR5c8lYgysYalPE2MfRVA5cNCKycuPJPV1fTG6Xp/LiYeT0FSXNjmWqTdmMMzwcgIN5O/Ec
	7SVpqdlW9hZvrnzWQtRQF6Pm3S55/eS8aHjvpLei4B14Xy0YrjYBlbe11Wqt8cojjmYNQvbV85L
	/sWqfsQ1f+IRgSUa7gMk=
X-Google-Smtp-Source: AGHT+IEI2xpAGbvRpY4BIV8ijaBZbVioGgATkA9IGkZ6XLAvSiH2w7owNTO9dsg+KYQVkVCJDO0NFw==
X-Received: by 2002:a17:907:6e8c:b0:b3f:c562:faf7 with SMTP id a640c23a62f3a-b3fc562fe27mr194433466b.55.1759137748476;
        Mon, 29 Sep 2025 02:22:28 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:28 -0700 (PDT)
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
Subject: [RFC PATCH v3 07/24] sched/core: Initialize root_task_group
Date: Mon, 29 Sep 2025 11:22:04 +0200
Message-ID: <20250929092221.10947-8-yurand2000@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929092221.10947-1-yurand2000@gmail.com>
References: <20250929092221.10947-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: luca abeni <luca.abeni@santannapisa.it>

Add the initialization function for task_group's dl_servers.
Initialize the default bandwidth for rt-cgroups and the root control group.
Add utility functions to check (and get) if a rt_rq entity is connected to a
real-time cgroup.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/autogroup.c |  4 ++--
 kernel/sched/core.c      |  9 +++++++--
 kernel/sched/deadline.c  |  8 ++++++++
 kernel/sched/rt.c        | 18 ++++++++----------
 kernel/sched/sched.h     | 32 +++++++++++++++++++++++++++++---
 5 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index cdea931aae3..017eadc0a0a 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -52,7 +52,7 @@ static inline void autogroup_destroy(struct kref *kref)
 
 #ifdef CONFIG_RT_GROUP_SCHED
 	/* We've redirected RT tasks to the root task group... */
-	ag->tg->rt_se = NULL;
+	ag->tg->dl_se = NULL;
 	ag->tg->rt_rq = NULL;
 #endif
 	sched_release_group(ag->tg);
@@ -109,7 +109,7 @@ static inline struct autogroup *autogroup_create(void)
 	 * the policy change to proceed.
 	 */
 	free_rt_sched_group(tg);
-	tg->rt_se = root_task_group.rt_se;
+	tg->dl_se = root_task_group.dl_se;
 	tg->rt_rq = root_task_group.rt_rq;
 #endif /* CONFIG_RT_GROUP_SCHED */
 	tg->autogroup = ag;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5791aa1f8c8..e5b4facee24 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8710,7 +8710,7 @@ void __init sched_init(void)
 		scx_tg_init(&root_task_group);
 #endif /* CONFIG_EXT_GROUP_SCHED */
 #ifdef CONFIG_RT_GROUP_SCHED
-		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
+		root_task_group.dl_se = (struct sched_dl_entity **)ptr;
 		ptr += nr_cpu_ids * sizeof(void **);
 
 		root_task_group.rt_rq = (struct rt_rq **)ptr;
@@ -8721,6 +8721,11 @@ void __init sched_init(void)
 
 	init_defrootdomain();
 
+#ifdef CONFIG_RT_GROUP_SCHED
+	init_dl_bandwidth(&root_task_group.dl_bandwidth,
+			global_rt_period(), global_rt_runtime());
+#endif /* CONFIG_RT_GROUP_SCHED */
+
 #ifdef CONFIG_CGROUP_SCHED
 	task_group_cache = KMEM_CACHE(task_group, 0);
 
@@ -8772,7 +8777,7 @@ void __init sched_init(void)
 		 * starts working after scheduler_running, which is not the case
 		 * yet.
 		 */
-		init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
+		init_tg_rt_entry(&root_task_group, rq, NULL, i, NULL);
 #endif
 		rq->sd = NULL;
 		rq->rd = NULL;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 277fbaff8b5..5c8fe80b585 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -513,6 +513,14 @@ static inline int is_leftmost(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq
 
 static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq);
 
+void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime)
+{
+	raw_spin_lock_init(&dl_b->dl_runtime_lock);
+	dl_b->dl_period = period;
+	dl_b->dl_runtime = runtime;
+}
+
+
 void init_dl_bw(struct dl_bw *dl_b)
 {
 	raw_spin_lock_init(&dl_b->lock);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index c625ea45ca7..84dbb4853b6 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -97,18 +97,16 @@ void free_rt_sched_group(struct task_group *tg)
 		return;
 }
 
-void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
-		struct sched_rt_entity *rt_se, int cpu,
-		struct sched_rt_entity *parent)
+void init_tg_rt_entry(struct task_group *tg, struct rq *served_rq,
+		struct sched_dl_entity *dl_se, int cpu,
+		struct sched_dl_entity *parent)
 {
-	struct rq *rq = cpu_rq(cpu);
+	served_rq->rt.highest_prio.curr = MAX_RT_PRIO-1;
+	served_rq->rt.rq = cpu_rq(cpu);
+	served_rq->rt.tg = tg;
 
-	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
-	rt_rq->rq = rq;
-	rt_rq->tg = tg;
-
-	tg->rt_rq[cpu] = rt_rq;
-	tg->rt_se[cpu] = rt_se;
+	tg->rt_rq[cpu] = &served_rq->rt;
+	tg->dl_se[cpu] = dl_se;
 }
 
 int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 59a154505d8..d433abe1c9c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -576,9 +576,9 @@ extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
 extern bool cfs_task_bw_constrained(struct task_struct *p);
 
-extern void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
-		struct sched_rt_entity *rt_se, int cpu,
-		struct sched_rt_entity *parent);
+extern void init_tg_rt_entry(struct task_group *tg, struct rq *s_rq,
+		struct sched_dl_entity *rt_se, int cpu,
+		struct sched_dl_entity *parent);
 extern int sched_group_set_rt_runtime(struct task_group *tg, long rt_runtime_us);
 extern int sched_group_set_rt_period(struct task_group *tg, u64 rt_period_us);
 extern long sched_group_rt_runtime(struct task_group *tg);
@@ -2668,6 +2668,7 @@ extern void resched_curr(struct rq *rq);
 extern void resched_curr_lazy(struct rq *rq);
 extern void resched_cpu(int cpu);
 
+void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime);
 extern void init_dl_entity(struct sched_dl_entity *dl_se);
 
 #define BW_SHIFT		20
@@ -3077,6 +3078,21 @@ static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
 	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
 	return rt_rq->rq;
 }
+
+static inline int is_dl_group(struct rt_rq *rt_rq)
+{
+	return rt_rq->tg != &root_task_group;
+}
+
+/*
+ * Return the scheduling entity of this group of tasks.
+ */
+static inline struct sched_dl_entity *dl_group_of(struct rt_rq *rt_rq)
+{
+	BUG_ON(!is_dl_group(rt_rq));
+
+	return rt_rq->tg->dl_se[cpu_of(rt_rq->rq)];
+}
 #else
 static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
 {
@@ -3101,6 +3117,16 @@ static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
 
 	return &rq->rt;
 }
+
+static inline int is_dl_group(struct rt_rq *rt_rq)
+{
+	return 0;
+}
+
+static inline struct sched_dl_entity *dl_group_of(struct rt_rq *rt_rq)
+{
+	return NULL;
+}
 #endif
 
 DEFINE_LOCK_GUARD_2(double_rq_lock, struct rq,
-- 
2.51.0



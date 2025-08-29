Return-Path: <linux-kernel+bounces-791338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0861FB3B599
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B793C3B5EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A43C29E115;
	Fri, 29 Aug 2025 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KEzC+uiJ"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE9329B8E2
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756455147; cv=none; b=CYE9fjvaDrPFQQ8ddn4A/n2ulsgdgvDTEOwgnShijGUcoBXIUnu5KFmTR0sSLDWaQlO2KlHW/+A5+A0cnfDZz0w4KsgPp001TXb9w6HZgmUgDp1cCUh5LU4srlSau9Kcu8nQya5QhQfkOZNARMlF3U+/NYIx8Hb5aNap+tZMDe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756455147; c=relaxed/simple;
	bh=bg/7+dgGc1AZ0w53qZiiMTqD+oSy0Fiv5NIrQq11l6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NHw/+y/XfASyfxRTKbjXZg9gPLjhNbJT8msgdM68fvhg+NTCpNHxbRjZ7EVvVVwF7yMO5keOCA2vff3apPftCAcQLSz8qzTImQVWSTFtrh5xXD2hSOJ0k4pKnBAgLHngKCld2usibnkHrAT0MmKzWUpLUY3tZVIKQDiLyZc6pIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KEzC+uiJ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-771fa8e4190so1325548b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756455145; x=1757059945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tpmka5WpquiocbwVRMGu4VeZFFUbLIkNFWPtxJMtoss=;
        b=KEzC+uiJYaPmIzVhFAul251UN40adP6EnqSuW8KK1HqvuINwKPl5VTYlyspckior4v
         xKghTFbeQJ4r6EEbjowbYp1I4rXk9s8xywyT3hWtfZ0IZha3X0xJ321h1unRTMNc9yEf
         UhXqnTbzPzeMkpuuo3qNKnMqHutN54+KKic169VB40GgEXdYf0QBH5P6LF1BeYlg5KJO
         wfKNzPrBOk6lpb9B6I1UBrXy5QKIrf+0dfazg0LqiueUfQKeDW/VTYn09F7wD384q/r5
         VCyV06dBisVUYTghfKSK8AF4qmRp4owhdxCyoRxYlRpmg5iKjY95HPACAYGaQ/tUW1fM
         E+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756455145; x=1757059945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tpmka5WpquiocbwVRMGu4VeZFFUbLIkNFWPtxJMtoss=;
        b=aPxUJqJwrSKjL7tNUb/l6v7lzChT2kj1F0kxevkR0cgwzyKKMpwDCTIlKX8Gif9aq9
         ddQgsdhCK9Izg3XIsaFYClt3lf8IDvKnS+syyAyUhO/6Pnn1YC3gdTBXjSZqmMKW29Wv
         2KjMhQLSW1awc6tc7xNhifxii970qSOod+AIJuD7pYsGhNfXd6A3L3xu5ml7BP7aw1iC
         UMYguIq58rfxHmAXSuoekk+vhafmfSWaSCsJuESpEozOUObYk1f9N853vx9wwVj14CVq
         NsjElBteMkMfpbVJ0GcBgURqZvybKeQDb7rgTMQN++E2k2DCRIBr9/7NZe76Bf5NIHA4
         RcnA==
X-Gm-Message-State: AOJu0Yy8K6B5e8eVQW4zO54lKZed+Owfa/kJVpE+i1A2NcObdrDwH7PS
	Xre5u15JND+1fBAXO8w9NNiezDgYjPBublMWsSFWmomT+r/b++RfExNEcu9GtQOozg==
X-Gm-Gg: ASbGncux2J0XSggEnwYxI47KhBOvj61TX4Gj3GCSWnWWpLVee1mK3kk+glV8ow6zevU
	NDvlNaAU/N3ivBg8kaMwMNIigRaEAinAZ9jTq9cnC5mCyJT7LHUhJWxO9XZg1+8Hgo4Kn5gM1bH
	68Yb7PhOkSU/TA7NU112iC+8AAkto5w3XvW9TpGlnd2KUaKy5nDuqy42ZAavf3lZpNHdDvFbVrV
	yZFSYS3dhOPffDesJYxbgG8M7eBmj1Yr1ge4F6xH5Qv37DKB74iZLsw6tmIcl5oyw4moCg0RtYU
	ocnA3fwPClF1Ge9QP3SqMCLp47Cs3RrVAAO/tau6hFV6QKbBqjcQZZ8jUx2NdkzRGmIu/qkHJAy
	z6+dBfsH4zTpVt4uVa8v5m/dlQ4aqQsi2FabNyxxh/TsTqhiTxrDlynqjJlxDN/9sidV9Dm9C7/
	aGho8=
X-Google-Smtp-Source: AGHT+IH+r/JZbb+L0NYQDnVunRx3t3q6kQ31U8MeN/ZGDyZ8GgpFh8CmISyjTuq0WMkWU1Eta8DZrA==
X-Received: by 2002:a05:6a20:6a25:b0:243:a96a:2c83 with SMTP id adf61e73a8af0-243a96a30d3mr9850242637.53.1756455144639;
        Fri, 29 Aug 2025 01:12:24 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2da9c6sm1601419b3a.42.2025.08.29.01.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:12:24 -0700 (PDT)
From: Aaron Lu <ziqianlu@bytedance.com>
To: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>
Cc: linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 4/5] sched/fair: Task based throttle time accounting
Date: Fri, 29 Aug 2025 16:11:19 +0800
Message-Id: <20250829081120.806-5-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829081120.806-1-ziqianlu@bytedance.com>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With task based throttle model, the previous way to check cfs_rq's
nr_queued to decide if throttled time should be accounted doesn't work
as expected, e.g. when a cfs_rq which has a single task is throttled,
that task could later block in kernel mode instead of being dequeued on
limbo list and accounting this as throttled time is not accurate.

Rework throttle time accounting for a cfs_rq as follows:
- start accounting when the first task gets throttled in its hierarchy;
- stop accounting on unthrottle.

Note that there will be a time gap between when a cfs_rq is throttled
and when a task in its hierarchy is actually throttled. This accounting
mechanism only starts accounting in the latter case.

Tested-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Suggested-by: Chengming Zhou <chengming.zhou@linux.dev> # accounting mechanism
Co-developed-by: K Prateek Nayak <kprateek.nayak@amd.com> # simplify implementation
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/sched/fair.c  | 56 ++++++++++++++++++++++++--------------------
 kernel/sched/sched.h |  1 +
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25b1014d4ef86..bdc9bfa0b9efa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5293,19 +5293,12 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		check_enqueue_throttle(cfs_rq);
 		list_add_leaf_cfs_rq(cfs_rq);
 #ifdef CONFIG_CFS_BANDWIDTH
-		if (throttled_hierarchy(cfs_rq)) {
+		if (cfs_rq->pelt_clock_throttled) {
 			struct rq *rq = rq_of(cfs_rq);
 
-			if (cfs_rq_throttled(cfs_rq) && !cfs_rq->throttled_clock)
-				cfs_rq->throttled_clock = rq_clock(rq);
-			if (!cfs_rq->throttled_clock_self)
-				cfs_rq->throttled_clock_self = rq_clock(rq);
-
-			if (cfs_rq->pelt_clock_throttled) {
-				cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
-					cfs_rq->throttled_clock_pelt;
-				cfs_rq->pelt_clock_throttled = 0;
-			}
+			cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
+				cfs_rq->throttled_clock_pelt;
+			cfs_rq->pelt_clock_throttled = 0;
 		}
 #endif
 	}
@@ -5393,7 +5386,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		 * DELAY_DEQUEUE relies on spurious wakeups, special task
 		 * states must not suffer spurious wakeups, excempt them.
 		 */
-		if (flags & DEQUEUE_SPECIAL)
+		if (flags & (DEQUEUE_SPECIAL | DEQUEUE_THROTTLE))
 			delay = false;
 
 		WARN_ON_ONCE(delay && se->sched_delayed);
@@ -5799,7 +5792,7 @@ static void throttle_cfs_rq_work(struct callback_head *work)
 		rq = scope.rq;
 		update_rq_clock(rq);
 		WARN_ON_ONCE(p->throttled || !list_empty(&p->throttle_node));
-		dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_SPECIAL);
+		dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_THROTTLE);
 		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
 		/*
 		 * Must not set throttled before dequeue or dequeue will
@@ -5959,6 +5952,17 @@ static inline void task_throttle_setup_work(struct task_struct *p)
 	task_work_add(p, &p->sched_throttle_work, TWA_RESUME);
 }
 
+static void record_throttle_clock(struct cfs_rq *cfs_rq)
+{
+	struct rq *rq = rq_of(cfs_rq);
+
+	if (cfs_rq_throttled(cfs_rq) && !cfs_rq->throttled_clock)
+		cfs_rq->throttled_clock = rq_clock(rq);
+
+	if (!cfs_rq->throttled_clock_self)
+		cfs_rq->throttled_clock_self = rq_clock(rq);
+}
+
 static int tg_throttle_down(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
@@ -5967,21 +5971,17 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 	if (cfs_rq->throttle_count++)
 		return 0;
 
-
-	/* group is entering throttled state, stop time */
-	WARN_ON_ONCE(cfs_rq->throttled_clock_self);
-	if (cfs_rq->nr_queued)
-		cfs_rq->throttled_clock_self = rq_clock(rq);
-	else {
-		/*
-		 * For cfs_rqs that still have entities enqueued, PELT clock
-		 * stop happens at dequeue time when all entities are dequeued.
-		 */
+	/*
+	 * For cfs_rqs that still have entities enqueued, PELT clock
+	 * stop happens at dequeue time when all entities are dequeued.
+	 */
+	if (!cfs_rq->nr_queued) {
 		list_del_leaf_cfs_rq(cfs_rq);
 		cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
 		cfs_rq->pelt_clock_throttled = 1;
 	}
 
+	WARN_ON_ONCE(cfs_rq->throttled_clock_self);
 	WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
 	return 0;
 }
@@ -6024,8 +6024,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	 */
 	cfs_rq->throttled = 1;
 	WARN_ON_ONCE(cfs_rq->throttled_clock);
-	if (cfs_rq->nr_queued)
-		cfs_rq->throttled_clock = rq_clock(rq);
 	return true;
 }
 
@@ -6733,6 +6731,7 @@ static void task_throttle_setup_work(struct task_struct *p) {}
 static bool task_is_throttled(struct task_struct *p) { return false; }
 static void dequeue_throttled_task(struct task_struct *p, int flags) {}
 static bool enqueue_throttled_task(struct task_struct *p) { return false; }
+static void record_throttle_clock(struct cfs_rq *cfs_rq) {}
 
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 {
@@ -7051,6 +7050,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	bool was_sched_idle = sched_idle_rq(rq);
 	bool task_sleep = flags & DEQUEUE_SLEEP;
 	bool task_delayed = flags & DEQUEUE_DELAYED;
+	bool task_throttled = flags & DEQUEUE_THROTTLE;
 	struct task_struct *p = NULL;
 	int h_nr_idle = 0;
 	int h_nr_queued = 0;
@@ -7084,6 +7084,9 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = h_nr_queued;
 
+		if (throttled_hierarchy(cfs_rq) && task_throttled)
+			record_throttle_clock(cfs_rq);
+
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
 			slice = cfs_rq_min_slice(cfs_rq);
@@ -7120,6 +7123,9 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = h_nr_queued;
+
+		if (throttled_hierarchy(cfs_rq) && task_throttled)
+			record_throttle_clock(cfs_rq);
 	}
 
 	sub_nr_running(rq, h_nr_queued);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 528af3ef8fc1e..c56a939c73fc4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2347,6 +2347,7 @@ extern const u32		sched_prio_to_wmult[40];
 #define DEQUEUE_SPECIAL		0x10
 #define DEQUEUE_MIGRATING	0x100 /* Matches ENQUEUE_MIGRATING */
 #define DEQUEUE_DELAYED		0x200 /* Matches ENQUEUE_DELAYED */
+#define DEQUEUE_THROTTLE	0x800
 
 #define ENQUEUE_WAKEUP		0x01
 #define ENQUEUE_RESTORE		0x02
-- 
2.39.5



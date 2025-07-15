Return-Path: <linux-kernel+bounces-731334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48140B052AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8374217D9E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3631B2D6603;
	Tue, 15 Jul 2025 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BXhOIqyl"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91DD274B41
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563871; cv=none; b=F8rikOBkuPRQQ0ud2zNeZ88zqaWMYcLcUsopUpnr/SD55fDJGZfZwJXTc5+z8FPIK+fgkpocVKBJCLc4j8qQlpQ1cY0yg8c1JrxnxFFy3/oVMki+AZB7fNTWA7nE7MtFsPy9MuvyK3WJpRwLs88WnCwWPliVhVbu7M8KdY3uWSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563871; c=relaxed/simple;
	bh=4QZzFDbanSVqBtO7SP+CHBCtZ4IeyyrN0JDtjgkqzTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oK72HOzLohw3KReEUQneieEGQK1OlaVNXE4lFDYID4K9z41raRxTEmcOGIAlqOQyBm8YC3AV2WzPzcXm9p27NBV6uB8VwfTnJMrQS9lRn9aIY30iU7ezV5UnXnIrDxtZ9uUmeWJeI+RhohGIpLPtVzO7NX23gfaETnVx4UE+rkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BXhOIqyl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-237e6963f63so30137805ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752563869; x=1753168669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EulDqtUuotSDsd2Q5jECOn9f5MW3ABQMTJUuJKS/Z0M=;
        b=BXhOIqylKTk5UsrG+bvgfT2scsfsU1VhVEIMofSls2ryI6sxSsCDreGs4hxC3Au47l
         yHy+jHpGn1fBhFSwCdQ3Is1S8/qYTCYc8Qa0tF21ozqCVp0o7eMgn3MAbhkhxFHLRcs/
         h0So7seyJvmmUPPyWb/NWYt+01GYyuO3DmwlagQiPZgJJX0PwVtx7rjhYQrfbpbZrJEP
         l66Up8PSbful7Xr7Qn3Mxwd1wySVNb/kDbN1x5Te8NBeASlMhibHTfoZo2Eh/wuDqE06
         625t9yy4VWAT5yhkf6s+D8bsTqSwYCv/r81rtrG6oA8IbnTZV1tYv12dGPaMQ8LCylth
         gGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752563869; x=1753168669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EulDqtUuotSDsd2Q5jECOn9f5MW3ABQMTJUuJKS/Z0M=;
        b=J3sIOyKtNybHCeMGvSnpGU1h7HS6qtmEUREj9XjIL4PJ4nTGTKVCiNdt3tAcwBhiBc
         fKO9VBUNMo9sFk8Jg2WZHDAKnUpbYUmFJP72Oy+2Hh7M27O+ZMoOSvXAS7byhICvkhXe
         rYH4gg0Y+O8R150Cltu0y4vKbeOf8KsDnMhyhFNzNgHjqhe2Pr0BZWsvUVR7sbWLgiHI
         hczkEMlp5s6B83AE2+kJoYdzjwewZQ0H1e2feRX1/vYSmetLPdjV0Bl0uXr2QC/BXI2X
         IIOixtC9PbPaNmN9SAwzhtYTP8tjFhKHtDJcWOOJ9oERbXzjBPT8AIhzm5/5/O0xbjp3
         rSGg==
X-Gm-Message-State: AOJu0YxVRj5LEWmXo2043GUzv3smDAaYxhj8+aLIAp6iNLyjDK5UabDd
	jvFd1TAb3m7UheIOJuMAAg2xmIfKoQ2zMaj92dAd+9y/Wg8lp6RwUEbuq75Tj2asSiVknOnz8a9
	m3Z4=
X-Gm-Gg: ASbGncv6fIxlQIk3s4VYMRTC0RwBB9sg+id8cT8giux5TWVxc5VTlaxgS8uqsSXE4A+
	6I+8DdjEBq6PJ1IUJS3Bbi/ZoBOiBO+VbSSAZdMkS2rXk8Z5pSUZGtXLUGp+9pt4IADxiqhTo0F
	eF9sQ778wUVy/MKYvXc6uVt2FoAT8F6ie4sk1aE3GBAkP8Yq6PmMUuxMTxaCSdKJ6sptX5yLxwb
	bIOa13zYGPjw+H8BR2UJFVbB1xaPA5wVl6WqlmAm+8emKYdou4ufzshcC08P4PFXmyw26yzYpWT
	zo3fphGhatKDLX4sGPHE8OMkiuYFeXnQhVnEkk+Ge5zPK3q54GdZVHIYEzunANk0ptfojTw7O39
	dHJFVAK88n1Rtf7rgziFvlAn08wM/de6Kl3PhoqYbzr1Pvphp/Mnf5aa57BYmZoHuZQM2
X-Google-Smtp-Source: AGHT+IF5OBlE3nhf1VOjTEkcvS8ti1Lyjs8uhfYSO3xrM5D6jZBBjmQz+gxVpajVAP4GE+ldBLChVw==
X-Received: by 2002:a17:90b:1845:b0:313:1a8c:c2d3 with SMTP id 98e67ed59e1d1-31c4f512a39mr21465311a91.22.1752563868999;
        Tue, 15 Jul 2025 00:17:48 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3017c9dasm15013418a91.25.2025.07.15.00.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 00:17:48 -0700 (PDT)
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
	Songtang Liu <liusongtang@bytedance.com>
Subject: [PATCH v3 4/5] sched/fair: Task based throttle time accounting
Date: Tue, 15 Jul 2025 15:16:57 +0800
Message-Id: <20250715071658.267-5-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250715071658.267-1-ziqianlu@bytedance.com>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
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
limbo list and account this as throttled time is not accurate.

Rework throttle time accounting for a cfs_rq as follows:
- start accounting when the first task gets throttled in its hierarchy;
- stop accounting on unthrottle.

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
index 0eeea7f2e693d..6f534fbe89bcf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5287,19 +5287,12 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
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
@@ -5387,7 +5380,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		 * DELAY_DEQUEUE relies on spurious wakeups, special task
 		 * states must not suffer spurious wakeups, excempt them.
 		 */
-		if (flags & DEQUEUE_SPECIAL)
+		if (flags & (DEQUEUE_SPECIAL | DEQUEUE_THROTTLE))
 			delay = false;
 
 		WARN_ON_ONCE(delay && se->sched_delayed);
@@ -5793,7 +5786,7 @@ static void throttle_cfs_rq_work(struct callback_head *work)
 		rq = scope.rq;
 		update_rq_clock(rq);
 		WARN_ON_ONCE(p->throttled || !list_empty(&p->throttle_node));
-		dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_SPECIAL);
+		dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_THROTTLE);
 		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
 		/*
 		 * Must not set throttled before dequeue or dequeue will
@@ -5948,6 +5941,17 @@ static inline void task_throttle_setup_work(struct task_struct *p)
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
@@ -5956,21 +5960,17 @@ static int tg_throttle_down(struct task_group *tg, void *data)
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
@@ -6013,8 +6013,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	 */
 	cfs_rq->throttled = 1;
 	WARN_ON_ONCE(cfs_rq->throttled_clock);
-	if (cfs_rq->nr_queued)
-		cfs_rq->throttled_clock = rq_clock(rq);
 	return true;
 }
 
@@ -6722,6 +6720,7 @@ static void task_throttle_setup_work(struct task_struct *p) {}
 static bool task_is_throttled(struct task_struct *p) { return false; }
 static void dequeue_throttled_task(struct task_struct *p, int flags) {}
 static bool enqueue_throttled_task(struct task_struct *p) { return false; }
+static void record_throttle_clock(struct cfs_rq *cfs_rq) {}
 
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 {
@@ -7040,6 +7039,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	bool was_sched_idle = sched_idle_rq(rq);
 	bool task_sleep = flags & DEQUEUE_SLEEP;
 	bool task_delayed = flags & DEQUEUE_DELAYED;
+	bool task_throttled = flags & DEQUEUE_THROTTLE;
 	struct task_struct *p = NULL;
 	int h_nr_idle = 0;
 	int h_nr_queued = 0;
@@ -7073,6 +7073,9 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = h_nr_queued;
 
+		if (throttled_hierarchy(cfs_rq) && task_throttled)
+			record_throttle_clock(cfs_rq);
+
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
 			slice = cfs_rq_min_slice(cfs_rq);
@@ -7109,6 +7112,9 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = h_nr_queued;
+
+		if (throttled_hierarchy(cfs_rq) && task_throttled)
+			record_throttle_clock(cfs_rq);
 	}
 
 	sub_nr_running(rq, h_nr_queued);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fc697d4bf6685..dbe52e18b93a0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2326,6 +2326,7 @@ extern const u32		sched_prio_to_wmult[40];
 #define DEQUEUE_SPECIAL		0x10
 #define DEQUEUE_MIGRATING	0x100 /* Matches ENQUEUE_MIGRATING */
 #define DEQUEUE_DELAYED		0x200 /* Matches ENQUEUE_DELAYED */
+#define DEQUEUE_THROTTLE	0x800
 
 #define ENQUEUE_WAKEUP		0x01
 #define ENQUEUE_RESTORE		0x02
-- 
2.39.5



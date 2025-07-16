Return-Path: <linux-kernel+bounces-733920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA17B07AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1681C24AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5D92F5480;
	Wed, 16 Jul 2025 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzEocr9p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701552F530E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682023; cv=none; b=p0Netm6M1Tc8xoldP9hjLY81w314BU6LnJo+8AGnSmpiqVIw5edCO6s+sBD0cQa3hWQmNEj1/qGx3eQkqwfEQigFXMX5loPGnCSgqaQevyzvD81pxGaW7wheKxzwhfSRn6RSW42DIt3Lq7vmWhSqadJvuD/4aX2/Npk6bBT/Egc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682023; c=relaxed/simple;
	bh=kdUikepQOPp7iFuazxVdT5rzKbgevZ33o4lVcsCV2lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKGJyHUyKkZmKk8TpVZbEvX8cgX/xY+Eb6AH2R/Y+VQtUIA/nPYxWC9OB6F3/dW4RObMspsAPhxKd0Pw1T+ZzC6Ii8iJAbdAn4v9HrG4ZtO0o+sVWO7ow9DfwUn4vgbtWkCyPXk52bIwBu/kt/xJb6nZnEQGW+UzMLzkzLP2sWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RzEocr9p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752682020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICf9beWgXfGrKSdsZJKdY+yXhXtYFoWe+KDS9YCRDxI=;
	b=RzEocr9pQdUeP/CvIAP6gJzoGG9Sy32q4AIC6GM13LpCVTJxmSJqNNiO8Zr7YpqPWmGlDy
	sEpVdSNYPf6Hm0JKvRkwHn5u2hK/F3Kp5JibV280HjlDhVW7bnHKzkuABUPIQ2/yae1ZRC
	qyzSSov2Xme+WdoAaZSur6Stp4ygBG8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-Iu7prPRiP8Cdi1wrCyuGtA-1; Wed,
 16 Jul 2025 12:06:56 -0400
X-MC-Unique: Iu7prPRiP8Cdi1wrCyuGtA-1
X-Mimecast-MFC-AGG-ID: Iu7prPRiP8Cdi1wrCyuGtA_1752682015
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28C7B1800C31;
	Wed, 16 Jul 2025 16:06:55 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.33.144])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7AD6319560AB;
	Wed, 16 Jul 2025 16:06:51 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-mm@kvack.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.org>
Subject: [PATCH v2 3/4] sched: Compact RSEQ concurrency IDs in batches
Date: Wed, 16 Jul 2025 18:06:07 +0200
Message-ID: <20250716160603.138385-9-gmonaco@redhat.com>
In-Reply-To: <20250716160603.138385-6-gmonaco@redhat.com>
References: <20250716160603.138385-6-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Currently, task_mm_cid_work() is called from resume_user_mode_work().
This can delay the execution of the corresponding thread for the entire
duration of the function, negatively affecting the response in case of
real time tasks.
In practice, we observe task_mm_cid_work increasing the latency of
30-35us on a 128 cores system, this order of magnitude is meaningful
under PREEMPT_RT.

Run the task_mm_cid_work in batches of up to CONFIG_RSEQ_CID_SCAN_BATCH
CPUs, this reduces the duration of the delay for each scan.

The task_mm_cid_work contains a mechanism to avoid running more
frequently than every 100ms. Keep this pseudo-periodicity only on
complete scans.
This means each call to task_mm_cid_work returns prematurely if the
period did not elapse and a scan is not ongoing (i.e. the next batch to
scan is not the first).
This way full scans are not excessively delayed while still keeping each
run, and introduced latency, short.

Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/mm_types.h | 15 +++++++++++++++
 init/Kconfig             | 12 ++++++++++++
 kernel/sched/core.c      | 37 ++++++++++++++++++++++++++++++++++---
 3 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e6d6e468e64b4..a822966a584f3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -995,6 +995,13 @@ struct mm_struct {
 		 * When the next mm_cid scan is due (in jiffies).
 		 */
 		unsigned long mm_cid_next_scan;
+		/*
+		 * @mm_cid_scan_batch: Counter for batch used in the next scan.
+		 *
+		 * Scan in batches of CONFIG_RSEQ_CID_SCAN_BATCH. This field
+		 * increments at each scan and reset when all batches are done.
+		 */
+		unsigned int mm_cid_scan_batch;
 		/**
 		 * @nr_cpus_allowed: Number of CPUs allowed for mm.
 		 *
@@ -1385,6 +1392,7 @@ static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
 	raw_spin_lock_init(&mm->cpus_allowed_lock);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
 	cpumask_clear(mm_cidmask(mm));
+	mm->mm_cid_scan_batch = 0;
 }
 
 static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *p)
@@ -1423,8 +1431,15 @@ static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumas
 
 static inline bool mm_cid_needs_scan(struct mm_struct *mm)
 {
+	unsigned int next_batch;
+
 	if (!mm)
 		return false;
+	next_batch = READ_ONCE(mm->mm_cid_scan_batch);
+	/* Always needs scan unless it's the first batch. */
+	if (CONFIG_RSEQ_CID_SCAN_BATCH * next_batch < num_possible_cpus() &&
+	    next_batch)
+		return true;
 	return time_after(jiffies, READ_ONCE(mm->mm_cid_next_scan));
 }
 #else /* CONFIG_SCHED_MM_CID */
diff --git a/init/Kconfig b/init/Kconfig
index 666783eb50abd..98d7f078cd6df 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1860,6 +1860,18 @@ config DEBUG_RSEQ
 
 	  If unsure, say N.
 
+config RSEQ_CID_SCAN_BATCH
+	int "Number of CPUs to scan at every mm_cid compaction attempt"
+	range 1 NR_CPUS
+	default 8
+	depends on SCHED_MM_CID
+	help
+	  CPUs are scanned pseudo-periodically to compact the CID of each task,
+	  this operation can take a longer amount of time on systems with many
+	  CPUs, resulting in higher scheduling latency for the current task.
+	  A higher value means the CID is compacted faster, but results in
+	  higher scheduling latency.
+
 config CACHESTAT_SYSCALL
 	bool "Enable cachestat() system call" if EXPERT
 	default y
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 27b856a1cb0a9..eae4c8faf980b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10591,11 +10591,26 @@ static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
 
 void task_mm_cid_work(struct task_struct *t)
 {
+	int weight, cpu, from_cpu, this_batch, next_batch, idx;
 	unsigned long now = jiffies, old_scan, next_scan;
 	struct cpumask *cidmask;
-	int weight, cpu;
 	struct mm_struct *mm = t->mm;
 
+	/*
+	 * This function is called from __rseq_handle_notify_resume, which
+	 * makes sure t is a user thread and is not exiting.
+	 */
+	this_batch = READ_ONCE(mm->mm_cid_scan_batch);
+	next_batch = this_batch + 1;
+	from_cpu = cpumask_nth(this_batch * CONFIG_RSEQ_CID_SCAN_BATCH,
+			       cpu_possible_mask);
+	if (from_cpu >= nr_cpu_ids) {
+		from_cpu = 0;
+		next_batch = 1;
+	}
+	/* Delay scan only if we are done with all cpus. */
+	if (from_cpu != 0)
+		goto cid_compact;
 	old_scan = READ_ONCE(mm->mm_cid_next_scan);
 	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
 	if (!old_scan) {
@@ -10611,17 +10626,33 @@ void task_mm_cid_work(struct task_struct *t)
 		return;
 	if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
 		return;
+
+cid_compact:
+	if (!try_cmpxchg(&mm->mm_cid_scan_batch, &this_batch, next_batch))
+		return;
 	cidmask = mm_cidmask(mm);
 	/* Clear cids that were not recently used. */
-	for_each_possible_cpu(cpu)
+	idx = 0;
+	cpu = from_cpu;
+	for_each_cpu_from(cpu, cpu_possible_mask) {
+		if (idx == CONFIG_RSEQ_CID_SCAN_BATCH)
+			break;
 		sched_mm_cid_remote_clear_old(mm, cpu);
+		++idx;
+	}
 	weight = cpumask_weight(cidmask);
 	/*
 	 * Clear cids that are greater or equal to the cidmask weight to
 	 * recompact it.
 	 */
-	for_each_possible_cpu(cpu)
+	idx = 0;
+	cpu = from_cpu;
+	for_each_cpu_from(cpu, cpu_possible_mask) {
+		if (idx == CONFIG_RSEQ_CID_SCAN_BATCH)
+			break;
 		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
+		++idx;
+	}
 }
 
 void init_sched_mm_cid(struct task_struct *t)
-- 
2.50.1



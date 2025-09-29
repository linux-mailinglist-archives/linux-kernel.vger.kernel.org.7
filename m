Return-Path: <linux-kernel+bounces-836243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F60BA9159
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5EA33A278A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35B5302169;
	Mon, 29 Sep 2025 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnywTWxI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBCC302166
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146177; cv=none; b=dFQfRP0+Dy4zcBd2GO/ceuoNU61V/w8kQ5DKmi3scAEqQXyzCmzOMhAHjbnGm2vp4uOCU9uh4cRGbltsnalCzu+mSCxWAEgZZ8xyzz/bSqtj0VqD3OYwD03GaSXowBYxraFq8N8euPWMu756YJAwuoND+0584MBRbk4pkoxs/0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146177; c=relaxed/simple;
	bh=NykoXUSyrKGkgbvux2M+5GWDOj5iJlu5MUP6n9HYUDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyBxriOVaYHcyQArO8NlG3rybGX/g+CklUzmsyNKDj2UfSRZElr7RtgIVYQZuBrgnRNacLpEnuvWo2l2Wc2St3Y53xXGV7PyqRgEv+TEAHi2JFdPC4Ooc2GZqVhCNN2g53LVV0xoL+4TeasmNQzbQJM+zCScurhZUWOTFCQgTsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnywTWxI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759146174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfADzoiCbyBtyAaLw463Wx6LUyiLBEBIcUcZudbfl5k=;
	b=fnywTWxILq+tOGB52U5Qm3AuquBxQqyZv9rm6C4295bksR42r1/OfIp5lJZrP4iwCuxPbv
	Oe78ViMEEgvKRCCaMUVfmkfvBJvWs0M6PYP+gcTrQ+mEsPIQ0t9AROCNeZtis0MQBGRjro
	pQJ6Xk5XKcO6NtKTmr2z1K60WMklULA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-M6vFsBw4NUqOLclGlyQs1Q-1; Mon,
 29 Sep 2025 07:42:50 -0400
X-MC-Unique: M6vFsBw4NUqOLclGlyQs1Q-1
X-Mimecast-MFC-AGG-ID: M6vFsBw4NUqOLclGlyQs1Q_1759146169
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4CE7195608E;
	Mon, 29 Sep 2025 11:42:48 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6910E19560A2;
	Mon, 29 Sep 2025 11:42:44 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v3 3/4] sched: Compact RSEQ concurrency IDs in batches
Date: Mon, 29 Sep 2025 13:42:24 +0200
Message-ID: <20250929114225.36172-4-gmonaco@redhat.com>
In-Reply-To: <20250929114225.36172-1-gmonaco@redhat.com>
References: <20250929114225.36172-1-gmonaco@redhat.com>
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
 kernel/sched/core.c      | 31 ++++++++++++++++++++++++++++---
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5dab88707014..83f6dc06b15f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -994,6 +994,13 @@ struct mm_struct {
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
@@ -1389,6 +1396,7 @@ static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
 	raw_spin_lock_init(&mm->cpus_allowed_lock);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
 	cpumask_clear(mm_cidmask(mm));
+	mm->mm_cid_scan_batch = 0;
 }
 
 static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *p)
@@ -1427,8 +1435,15 @@ static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumas
 
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
index 854b35e33318..8905d64c2598 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1918,6 +1918,18 @@ config DEBUG_RSEQ
 
 	  If unsure, say N.
 
+config RSEQ_CID_SCAN_BATCH
+	int "Number of CPUs to scan at every mm_cid compaction attempt"
+	range 1 NR_CPUS
+	default 16
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
index 30652bb4a223..14b79c143d26 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10784,11 +10784,11 @@ static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
 
 static void task_mm_cid_work(struct callback_head *work)
 {
+	int weight, cpu, from_cpu, this_batch, next_batch, idx;
 	unsigned long now = jiffies, old_scan, next_scan;
 	struct task_struct *t = current;
 	struct cpumask *cidmask;
 	struct mm_struct *mm;
-	int weight, cpu;
 
 	WARN_ON_ONCE(t != container_of(work, struct task_struct, cid_work));
 
@@ -10798,6 +10798,17 @@ static void task_mm_cid_work(struct callback_head *work)
 	mm = t->mm;
 	if (!mm)
 		return;
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
@@ -10813,17 +10824,31 @@ static void task_mm_cid_work(struct callback_head *work)
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
+		if (idx++ == CONFIG_RSEQ_CID_SCAN_BATCH)
+			break;
 		sched_mm_cid_remote_clear_old(mm, cpu);
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
+		if (idx++ == CONFIG_RSEQ_CID_SCAN_BATCH)
+			break;
 		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
+	}
 }
 
 void init_sched_mm_cid(struct task_struct *t)
-- 
2.51.0



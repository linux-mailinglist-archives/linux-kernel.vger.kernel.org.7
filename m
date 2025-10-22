Return-Path: <linux-kernel+bounces-865005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCE5BFC044
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B0E6561BB8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190B3348477;
	Wed, 22 Oct 2025 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1HTcitoY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AGhiwbv/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36DA347FC3
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137729; cv=none; b=g9GUlyuH+UGrjvGg23EBa0Nco55N3jfym+UBgroaRsn7sf/A1U67XmthD5TTgucJwVz3+IOzIt9ZqTjqobN0TnRTp5O2eywClMsqojlL/T/bXF5XywFNcpY3nkOtYB0evGLkF5DXiklpOWAJyIi+kTpAA9goN8qMZtsR6eRmjCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137729; c=relaxed/simple;
	bh=gdMgSk/0F0owVeYpIT+yMfQdWp7yp9FtNkok/BlzeZI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=h3+os5mNrzgYySMJWhR7DTsj8+GlYFDKZwvcNQlbkbWMkDBlYiFdQu2ZW6ND2mIgKHgKJGkWn36K7bCkg9JPNykkJ7iqbj8k3bDzxGWJlI45irRZTAa9kS3L/JkhXthIX9S+udJD/gH/M4WJqzHYF3zcRLxir1pvLP5ixXZywVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1HTcitoY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AGhiwbv/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022110555.711924877@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pq5f3X7zE4Uy3TxW2RkGficvYnAYg1R3XjmToNIXbKM=;
	b=1HTcitoYqKxMZKcD2qoj5hjnhgNco3+boBeGntAWdCmFiFzsPyiiOfiqmRZrlg8QEUDmpH
	USHzb2ZpWzSyiDa5AJ8fQGdEe1B1slxa8+PGYy66SIwXIdN0L6QCtftM1txLd7a8SQrTUl
	a2mIlzsbqxNQ9c3j6INW8+YV76wiHFJrdFaeY+wSy9WxDHfEmNPtQqKgwLvpcWd5mYkuaL
	kOxsATMxnBSIDCJdUmoc97tSMW8VcXBkZGJdyiIHu9vzI7bECksawTXLQ/qeauw7kTwnsm
	8gTTloPYBQfRVLy8Hg5tFiEp0xZpByZhm9PcP3YJDVzL9Jcx6g2F1VyizoIS3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pq5f3X7zE4Uy3TxW2RkGficvYnAYg1R3XjmToNIXbKM=;
	b=AGhiwbv/x+mFaoYqC1Ga/9Hk+jF7Pk86g5tH3W6ewdNXLICBtmGEMGgiA2koH1G1hCTcck
	uljXtg2VoU4/MAAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>,
 Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>
Subject: [patch V2 05/20] sched/mmcid: Move scheduler code out of global
 header
References: <20251022104005.907410538@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:55:25 +0200 (CEST)

This is only used in the scheduler core code, so there is no point to have
it in a global header.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mm_types.h |   13 -------------
 kernel/sched/core.c      |   20 ++++++++++++++++++--
 2 files changed, 18 insertions(+), 15 deletions(-)

--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1387,27 +1387,14 @@ static inline unsigned int mm_cid_size(v
 	return 2 * cpumask_size();	/* mm_cpus_allowed(), mm_cidmask(). */
 }
 
-static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumask *cpumask)
-{
-	struct cpumask *mm_allowed = mm_cpus_allowed(mm);
-
-	if (!mm)
-		return;
-	/* The mm_cpus_allowed is the union of each thread allowed CPUs masks. */
-	guard(raw_spinlock)(&mm->mm_cid.lock);
-	cpumask_or(mm_allowed, mm_allowed, cpumask);
-	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, cpumask_weight(mm_allowed));
-}
 #else /* CONFIG_SCHED_MM_CID */
 static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p) { }
 static inline int mm_alloc_cid(struct mm_struct *mm, struct task_struct *p) { return 0; }
 static inline void mm_destroy_cid(struct mm_struct *mm) { }
-
 static inline unsigned int mm_cid_size(void)
 {
 	return 0;
 }
-static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumask *cpumask) { }
 #endif /* CONFIG_SCHED_MM_CID */
 
 struct mmu_gather;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2669,6 +2669,8 @@ int push_cpu_stop(void *arg)
 	return 0;
 }
 
+static inline void mm_update_cpus_allowed(struct mm_struct *mm, const cpumask_t *affmask);
+
 /*
  * sched_class::set_cpus_allowed must do the below, but is not required to
  * actually call this function.
@@ -2728,7 +2730,7 @@ static void
 		put_prev_task(rq, p);
 
 	p->sched_class->set_cpus_allowed(p, ctx);
-	mm_set_cpus_allowed(p->mm, ctx->new_mask);
+	mm_update_cpus_allowed(p->mm, ctx->new_mask);
 
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
@@ -10370,6 +10372,18 @@ void call_trace_sched_update_nr_running(
  * When a task exits, the MM CID held by the task is not longer required as
  * the task cannot return to user space.
  */
+static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct cpumask *affmsk)
+{
+	struct cpumask *mm_allowed = mm_cpus_allowed(mm);
+
+	if (!mm)
+		return;
+	/* The mm_cpus_allowed is the union of each thread allowed CPUs masks. */
+	guard(raw_spinlock)(&mm->mm_cid.lock);
+	cpumask_or(mm_allowed, mm_allowed, affmsk);
+	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, cpumask_weight(mm_allowed));
+}
+
 void sched_mm_cid_exit_signals(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
@@ -10409,7 +10423,9 @@ void sched_mm_cid_fork(struct task_struc
 	WARN_ON_ONCE(!t->mm || t->mm_cid.cid != MM_CID_UNSET);
 	t->mm_cid.active = 1;
 }
-#endif /* CONFIG_SCHED_MM_CID */
+#else /* CONFIG_SCHED_MM_CID */
+static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct cpumask *affmsk) { }
+#endif /* !CONFIG_SCHED_MM_CID */
 
 #ifdef CONFIG_SCHED_CLASS_EXT
 void sched_deq_and_put_task(struct task_struct *p, int queue_flags,



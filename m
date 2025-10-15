Return-Path: <linux-kernel+bounces-854972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4DFBDFDD5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D93593545FC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5E4340DB3;
	Wed, 15 Oct 2025 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cy5jyVUq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BEYff9w4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4796340DB1
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549379; cv=none; b=dWqf/kluPyfKmIB0CLxmukVKT0+OinbDpTCUbqlTqxfPlEE7uuwAwI95VCGNXJKtEutOxPI7uMfISELiO7YWo8avLEQCpbGNx0gD6DEgVjhGHx9Xftt7zy0DEumZIRnuAxks3PJbQxpAf8MQoxZYbgVMLLgP182Hca8TbP2LKEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549379; c=relaxed/simple;
	bh=7fpwOABA3SzrIN9DCSw4qLEkvmleWEchFx4lA/unLrw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=OGfsG7IVOQhJZlvMfPxW6uwB/0Gt9u036QV7FtgJ8SNSihSCDD6EG+ESMWrq0AfSm3yzcQs1dWniwWbgjFv0HZ676oQMU2NW1oseMD+b7cfnIplDmLMGSvyMaOvyuo2Hsb+IsQTKaXBGJTUP01hn9hVQqYC6qvlfWAU6rMQJeUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cy5jyVUq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BEYff9w4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251015172834.631482357@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760549373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=79E8Bkn/ABS3eLdwGxQjGfkAWpdXEHtzjpjYM5kWPc0=;
	b=Cy5jyVUqXcNivDkPeTjWFXB3ReLXinHn7eiiev+r2cDxZg5JrP4+nU5T8Zl51wAw9ePOjT
	sXBATlX9RKqNqn3lYFkK6FtN1z6VlBjXiuztxKyfEQ0iSF+ygFAh4pEwQ7fbd1dZa9ev52
	YY3AHbCTrTUKIONamGhWxC9V9yQ1XgycQlRNHruFH1LeANF2m0CfsmPORkAC6+L2HugfRo
	MlKmOZBX4p5y0JDb4g37S8wClnsz3UCitc8Y293+2alHCMKdQgHINt6CCMdNnvCjijT4kR
	ZLs5l5z2rHVkuocwHnooedqc+FNfqJ/4p95sZuU64GGD6QWK8MmN02g0SsH5XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760549373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=79E8Bkn/ABS3eLdwGxQjGfkAWpdXEHtzjpjYM5kWPc0=;
	b=BEYff9w4t55VbgMm7qnr/dbOvDVnXls5XjImYBK81a4L9kH+4QV9FynE/C+92XimpxzN+l
	IxDqtIyPRYDIQ9Bg==
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
 TCMalloc Team <tcmalloc-eng@google.com>
Subject: [patch 05/19] sched/mmcid: Move scheduler code out of global header
References: <20251015164952.694882104@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 19:29:32 +0200 (CEST)

This is only used in the scheduler core code, so there is no point to have
it in a global header.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mm_types.h |   13 -------------
 kernel/sched/core.c      |   20 ++++++++++++++++++--
 2 files changed, 18 insertions(+), 15 deletions(-)

--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1341,27 +1341,14 @@ static inline unsigned int mm_cid_size(v
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
@@ -2704,6 +2704,8 @@ int push_cpu_stop(void *arg)
 	return 0;
 }
 
+static inline void mm_update_cpus_allowed(struct mm_struct *mm, const cpumask_t *affmask);
+
 /*
  * sched_class::set_cpus_allowed must do the below, but is not required to
  * actually call this function.
@@ -2763,7 +2765,7 @@ static void
 		put_prev_task(rq, p);
 
 	p->sched_class->set_cpus_allowed(p, ctx);
-	mm_set_cpus_allowed(p->mm, ctx->new_mask);
+	mm_update_cpus_allowed(p->mm, ctx->new_mask);
 
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
@@ -10404,6 +10406,18 @@ void call_trace_sched_update_nr_running(
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
@@ -10443,7 +10457,9 @@ void sched_mm_cid_fork(struct task_struc
 	WARN_ON_ONCE(!t->mm || t->mm_cid.cid != MM_CID_UNSET);
 	t->mm_cid.active = 1;
 }
-#endif /* CONFIG_SCHED_MM_CID */
+#else /* CONFIG_SCHED_MM_CID */
+static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct cpumask *affmsk) { }
+#endif /* !CONFIG_SCHED_MM_CID */
 
 #ifdef CONFIG_SCHED_CLASS_EXT
 void sched_deq_and_put_task(struct task_struct *p, int queue_flags,



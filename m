Return-Path: <linux-kernel+bounces-876112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 741E4C1A9F7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68F81A65CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1200633F398;
	Wed, 29 Oct 2025 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FbteK22I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XuKxcZMd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A845B33F378
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743350; cv=none; b=MzZK9V2ASW81yFS9X1REhZFvDATCjeIbMHEA1uvJbYWuPJLhO/08pJ8G8x4+wc07rJT7tWq1JQk2nw8eaeNorD1HGQZcJVq05iVQ8AN+xFLyvBd5z1ceTh8kdLmU+V/IkgsoqbBwAl9VUlVuOcU6DO0WRl/8jLMbtfzuf9xJCaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743350; c=relaxed/simple;
	bh=gdMgSk/0F0owVeYpIT+yMfQdWp7yp9FtNkok/BlzeZI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Z2Da1UMvDWss2VxxBTWXYvG4FprAXdEjdnvW6ZDtRU1qc090hblkWwMAX5kVLXOSVAbsjpI/ssRXeNrdc8w0M91gzl4crwtOxPY+BORspgR7SmCqdCklsIr0C21YlOfNeX4k9MVFFi3CrU4R0sTlXxacqT2rMCddAMi2P8tpIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FbteK22I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XuKxcZMd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029124515.592186000@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761743344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pq5f3X7zE4Uy3TxW2RkGficvYnAYg1R3XjmToNIXbKM=;
	b=FbteK22IMpV0Ia4ko+3awmye/+GSvIsJ5dqhKqd1OgZBJFxZY/Ctp8eD2ITYbeUicYnplk
	3H3T3gNl7k2j7Ri4I1ZNDXJqqr4/R1VF94e1RZgetrOEsen9a1MJ4/oCqqrvq2ZrVSHQi+
	q1AWl2aviWJ7UZNpqLg5W8fl4pabXEqjmn+dG7vv2hX2i9ZB6rMBcj+pwGryKhsEzvKuc4
	pc+ISAWbTID98gaZURrZg/LjX4reK7MK3ctNQGVwC4brmlfTTMHX4CdQZpncOCdgplunhq
	GS7jIE1K2W9g/65yHOfQ+IeDiHECsVSjFYO6DapPfH92qBGUlmDWCF8Tfe9ksQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761743344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pq5f3X7zE4Uy3TxW2RkGficvYnAYg1R3XjmToNIXbKM=;
	b=XuKxcZMdOLpnQsT76AXYUm0o7pWoGfi9ed4oX/0ZNvygb7/z77AYhdpA0QCusfup1m3dXo
	LBb/cMHAuH3MKODg==
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
 Yury Norov <yury.norov@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [patch V3 05/20] sched/mmcid: Move scheduler code out of global
 header
References: <20251029123717.886619142@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:09:03 +0100 (CET)

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



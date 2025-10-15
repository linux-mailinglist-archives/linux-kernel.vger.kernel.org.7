Return-Path: <linux-kernel+bounces-854979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46609BDFDE7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27A0A4F3745
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444B7342CA5;
	Wed, 15 Oct 2025 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pLq91Kwj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6FmyS+0A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EFD342C97
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549393; cv=none; b=rPQhYDFfpEJX8f0jYR3WqjuvBvNdlbfXWlYDhgocJ3haIuqqkoZdVHFUjwJdtMdYpk1T9RLol2rN6yg20YNRisP9fZmylm6JZvx+G1cZgtvWCSx0zTuvlnppsxCYJhR1/QijRl7W21hwTOCbFa0Izil6dS1ziYcf4NG34yKPOvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549393; c=relaxed/simple;
	bh=WiNcuGyRY58l9VyXAdWrg1hbcNj6k2rznNOlyX0sMjU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=R4LgNHGoMgqmvJMN+/e52L2yoUUC5rd3be/cdw4BUzTZzxivLnUbJiOtwv/NJ3K+swjJHNIQsBMXA/DpIgXlnoMWklpWaoGn0jN+KD2fDZU+PsYQAePgVDlFmuhZbPM05oD7aG6EYZ6PiXAK73z8KjlItKQuYuxv4gkIAlenbeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pLq91Kwj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6FmyS+0A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251015172835.128647487@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760549389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=rI5tG705H4SVQi23Z67G4+IXkytvRxi+xhu0kDxKPO4=;
	b=pLq91Kwj9DXG1V40UJ5gHhOOeT51cCviGZEWBcH1TcK/nxc8A79locLz6qOA619nICAcoN
	MzTwZk+cKM/nhREFKUPOPIcjVooP+Tym12/KS5VHyGDDdV8alLSMikFsZPRR2i244fk4c7
	lNXi9JKY4cJgvdhlWYlmuNEvyE2WaUf5lSO3R0fL41YsvKnI8e3hlh08VuO7kRKn7sHDsz
	pJ3yQxsP/FfNnEozHw38SKJ1ZzY9WYY+MxCWGEGLNcXBYlprGh85YAghA3JKeUkPi7WREN
	CAJ3LQU9vzwQMMXrjsKTZ6bGyuznZFfvuImjvKRM8tDImkfC6GMvikmkm6lROQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760549389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=rI5tG705H4SVQi23Z67G4+IXkytvRxi+xhu0kDxKPO4=;
	b=6FmyS+0AQHRjpSpI1xU2nw7bTft2/CyFwgFTcSAIdH5lZeel57svPRwZhCODB7FM6jPJfR
	TEEzmPY/lvm7XJCg==
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
Subject: [patch 13/19] sched/mmcid: Serialize sched_mm_cid_fork()/exit() with
 a mutex
References: <20251015164952.694882104@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 19:29:48 +0200 (CEST)

Prepare for the new CID management scheme which puts the CID ownership
transition into the fork() and exit() slow path by serializing
sched_mm_cid_fork()/exit() with it, so task list and cpu mask walks can be
done in interruptible and preemptible code.

The contention on it is not worse than on other concurrency controls in the
fork()/exit() machinery.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rseq_types.h |    2 ++
 kernel/sched/core.c        |   22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -125,6 +125,7 @@ struct mm_cid_pcpu {
  *			do not actually share the MM.
  * @lock:		Spinlock to protect all fields except @pcpu. It also protects
  *			the MM cid cpumask and the MM cidmask bitmap.
+ * @mutex:		Mutex to serialize forks and exits related to this mm
  */
 struct mm_mm_cid {
 	struct mm_cid_pcpu	__percpu *pcpu;
@@ -132,6 +133,7 @@ struct mm_mm_cid {
 	unsigned int		nr_cpus_allowed;
 	unsigned int		users;
 	raw_spinlock_t		lock;
+	struct mutex		mutex;
 }____cacheline_aligned_in_smp;
 #else /* CONFIG_SCHED_MM_CID */
 struct mm_cid { };
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10402,6 +10402,25 @@ void call_trace_sched_update_nr_running(
 
 #ifdef CONFIG_SCHED_MM_CID
 /*
+ * Concurrency IDentifier management
+ *
+ * Serialization rules:
+ *
+ * mm::mm_cid::mutex:	Serializes fork() and exit() and therefore
+ *			protects mm::mm_cid::users.
+ *
+ * mm::mm_cid::lock:	Serializes mm_update_max_cids() and
+ *			mm_update_cpus_allowed(). Nests in mm_cid::mutex
+ *			and runqueue lock.
+ *
+ * The mm_cidmask bitmap is not protected by any of the mm::mm_cid locks
+ * and can only be modified with atomic operations.
+ *
+ * The mm::mm_cid:pcpu per CPU storage is protected by the CPUs runqueue
+ * lock.
+ */
+
+/*
  * Update the CID range properties when the constraints change. Invoked via
  * fork(), exit() and affinity changes
  */
@@ -10452,6 +10471,7 @@ void sched_mm_cid_fork(struct task_struc
 
 	WARN_ON_ONCE(!mm || t->mm_cid.cid != MM_CID_UNSET);
 
+	guard(mutex)(&mm->mm_cid.mutex);
 	guard(raw_spinlock)(&mm->mm_cid.lock);
 	t->mm_cid.active = 1;
 	mm->mm_cid.users++;
@@ -10471,6 +10491,7 @@ void sched_mm_cid_exit(struct task_struc
 	if (!mm || !t->mm_cid.active)
 		return;
 
+	guard(mutex)(&mm->mm_cid.mutex);
 	guard(raw_spinlock)(&mm->mm_cid.lock);
 	t->mm_cid.active = 0;
 	mm->mm_cid.users--;
@@ -10507,6 +10528,7 @@ void mm_init_cid(struct mm_struct *mm, s
 	mm->mm_cid.nr_cpus_allowed = p->nr_cpus_allowed;
 	mm->mm_cid.users = 0;
 	raw_spin_lock_init(&mm->mm_cid.lock);
+	mutex_init(&mm->mm_cid.mutex);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
 	bitmap_zero(mm_cidmask(mm), nr_cpu_ids);
 }



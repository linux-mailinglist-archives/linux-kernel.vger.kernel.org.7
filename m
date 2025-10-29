Return-Path: <linux-kernel+bounces-876124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB0CC1AA5B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC6215884B0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4354934AB05;
	Wed, 29 Oct 2025 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y+GeEPIG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BGl4x806"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EB534BA50
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743365; cv=none; b=cZk0E5OLWSTsSLEl30neounfnqyIIMK+aK5UyB4GZu7LjD+wrtGqukzJhY6UES3sTav1n0TfSs4mOsYBH5dRMNQ9f8hqzUwyH2WhFmuZLwG8CHd7VazWXPctgg04Xlg5i9OHd4ENh2n9Z8I3LBiudDbLkOxSiAP45U2naQhVGY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743365; c=relaxed/simple;
	bh=K60IjKuMLYzzRcIxBflbg+VEOy7z6d5e7rVbGmd/Rrw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=lGywzR/rMM1OLH4nf7i4gOAaer9Qra2NDI2+tfZA7K8Jh5Tv9GmtGKdxdRler6fVM5xZV7CyWPBfC6k9qEIllGQzrNgE0Z6BIza8WnHXnq3OmnnAAx4AFQkQKIn8X12yzg3H7yENFA9MmVZ5iJ8SK38PQfjsRad+5qbwvg+Kc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y+GeEPIG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BGl4x806; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029124516.159532643@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761743361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=IzFMfVDvc7vz5fEEIX6wb+VS4+Na+PJShkvbBDeU/mU=;
	b=y+GeEPIG18PkiXy3CalfKtLC3mkpl8AcsP3rtPMP1EwhrxuTMhXfGiPk1FQSjksmz2h44d
	HzZUu8xXjf7WyXSCQsXunk3RiSf7GMEjToAN5QY33oDuINs7L7trPhxB7DcJxv5TEAlXk+
	tvvltm+eeQ/FT9fsP6yd5mSdikg/016OqLmHSy+LN5r+2EVenxe+iZYSHNfpB2GT5UTgac
	QUR1NkNJk1coXRNB9nkdHdebbprSflzWPktUdaE2Af5oSMe6dLBBJkxruwf34G2vcDNljo
	gEpJ8MvWHfUEK31sFKJn+tSYPF31DRCFSRgKHJfAaF0kAL8Dplte0xZou+TCBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761743361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=IzFMfVDvc7vz5fEEIX6wb+VS4+Na+PJShkvbBDeU/mU=;
	b=BGl4x806pObpRNXKDRtz7tthttJpw/KwN3LXtAep+QUd0ytHLWiM9UfQXF6E6nF9FD6fH3
	zuDS1nivMhgRbjCw==
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
Subject: [patch V3 14/20] sched/mmcid: Serialize sched_mm_cid_fork()/exit()
 with a mutex
References: <20251029123717.886619142@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:09:20 +0100 (CET)

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
 struct mm_mm_cid { };
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10368,6 +10368,25 @@ void call_trace_sched_update_nr_running(
 
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
@@ -10410,6 +10429,7 @@ void sched_mm_cid_fork(struct task_struc
 
 	WARN_ON_ONCE(!mm || t->mm_cid.cid != MM_CID_UNSET);
 
+	guard(mutex)(&mm->mm_cid.mutex);
 	guard(raw_spinlock)(&mm->mm_cid.lock);
 	t->mm_cid.active = 1;
 	mm->mm_cid.users++;
@@ -10429,6 +10449,7 @@ void sched_mm_cid_exit(struct task_struc
 	if (!mm || !t->mm_cid.active)
 		return;
 
+	guard(mutex)(&mm->mm_cid.mutex);
 	guard(raw_spinlock)(&mm->mm_cid.lock);
 	t->mm_cid.active = 0;
 	mm->mm_cid.users--;
@@ -10465,6 +10486,7 @@ void mm_init_cid(struct mm_struct *mm, s
 	mm->mm_cid.nr_cpus_allowed = p->nr_cpus_allowed;
 	mm->mm_cid.users = 0;
 	raw_spin_lock_init(&mm->mm_cid.lock);
+	mutex_init(&mm->mm_cid.mutex);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
 	bitmap_zero(mm_cidmask(mm), bitmap_size(num_possible_cpus()));
 }



Return-Path: <linux-kernel+bounces-865014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53A4BFC12C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9D56262C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EE434FF61;
	Wed, 22 Oct 2025 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ijf+f2HK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W83QOcsl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D7034B184
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137740; cv=none; b=thMcnuDcldb+YtTQKMDLI5tGeTqi2KqGtktf44q+VByZrquamqqhWcwYMCkofiLZdX5+CSju6UCyZU2CZ42Z+BDjH1v/xnh9ClrIypoO2LEyfcZQUiW1ECa9vphRR495a+c4QfAb4UaouRDP6myxfIknfE2XXYGJsj5Ln32StEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137740; c=relaxed/simple;
	bh=vBtpp9gJTrHSvlJrVvpl3eB7kuWVj2z1n2XKlsuFyXs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=XNj6FV7FvSt/Esc+Pclrst+83revC7Ml9A60UtgUk5epIyKb4d2TMGVPLNrnLzvCLQuiXDldV9/DyNJ5x3LbW6iAuN1mUOApjge4RFFUCXenYk6epD74A+yyY0qm/jzal1Wgr85OK/68QzElqG/ja2H7O7Fn6lV9lsOQeb/zOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ijf+f2HK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W83QOcsl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022110556.275412905@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Pl1CSdoGDqEPwRZ2tXyrOlR+ZVl9bhFOgqJc/H9i47I=;
	b=Ijf+f2HKc5IsX5lplLkoXcSG6mcXO6slX+Smg/4EWAya+QRORe38E4Fjle4AOu6qOkWhxt
	uf0hIvN0GhNKFU/G/hmY7Y2JCXiKw+TxqREiv3XTg3YIrKDqaCKkGY7qI1rW2RC5odXfq1
	lEBry3nuRXbVpKW/Hu+l0v9sP5yY2+kIprqg17ypGf2mc/jzjEdgCDrE1dHiCAxyeNx+pM
	qxD5V7m/TGjieLg2uA73KKO7a49ZuMhEH7+TQAqlVByTKM16PSEYYcqqGS3RPR4obq5K5R
	eZ+G40J1cszZO13hsGqgWMCN8eENpnFmtfV0HaXpdSkqAv7Yz+fOG/BIAqeUyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Pl1CSdoGDqEPwRZ2tXyrOlR+ZVl9bhFOgqJc/H9i47I=;
	b=W83QOcslUqeFfnYGx+fUnMQatZhKFCoD95puMLapBoqxOGp+hiJSTOwZMwQwryTZYsGOFo
	9PxGRRqYs9D4slDg==
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
Subject: [patch V2 14/20] sched/mmcid: Serialize sched_mm_cid_fork()/exit()
 with a mutex
References: <20251022104005.907410538@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:55:36 +0200 (CEST)

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
 	bitmap_zero(mm_cidmask(mm), cpumask_size());
 }



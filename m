Return-Path: <linux-kernel+bounces-876122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B232C1AA48
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84B01567256
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41792459DC;
	Wed, 29 Oct 2025 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zNEz8e4g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7arnEHil"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0873E24468A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743361; cv=none; b=UgvLSWzvGB925/htv5di21QtVP3onjeSaW89tW/+s6uHyuii4Sp3LJrWFTV0xN/vRMp9SQcahL3hOGPw2HaK8jKjwSiBRPyAlOAFX+0m7DyG+bpwox9m0RunyAnMxwzA+rN/7dX2EUsjCaAexsyrzER5C9jZStRlG7yPd1HnKzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743361; c=relaxed/simple;
	bh=Id1gUikkB+sX7CGiq6c3fMOJseSbh0pfdVERiaIE02I=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=l4oUGwSAvJGd/k6zTg8bQPg9kUN8+nR2F2miwIfwjKL2wsfp/IEYsE89mL/QpNx+/+hEY5yPIZcDsVR1lK7lUGlV0UGXm1PKqPbazvMPBP58zFobTYU/ZXDbdkPpvSVsqR6O9hT9UxYsx48dhURNKtDd3rA8ztez+e5SiurdV9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zNEz8e4g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7arnEHil; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029124516.034484128@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761743357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=GeJoM48zTPitDYvf/gK40WDFduH35MXllzEU6Qlrc30=;
	b=zNEz8e4gu9odCAc7r5sAJtEfWl3fxGjI6WsaVYu588QuXRoKLSeH3gu7aslrXaGv8t1vLn
	aU/3q/4vQkDJje7VMMXlOk4Yjf9hj6rvGeYf9F+oAKYFmA+G/dj99h8nacmKYTCua6e9el
	x2Zzw8JdtKT8lAgvdxzBGiRtMsaQ+R8+v7t1vR8ztxqPIXrR4K1BrfYYLWqJ/kNVomn26q
	n3cpi7ZEpUGFWxeGLn9ydYodRQha0Cs6VYkWQKR89yRpevXKvuh4mExhZ1jEOO1yiwet3/
	JxxqeIsmuGM3zfojpjOltmABHc8oN8Mv9wunTkXhkZ7LJiBJe9feiDyvCgQ44Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761743357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=GeJoM48zTPitDYvf/gK40WDFduH35MXllzEU6Qlrc30=;
	b=7arnEHiloGA0z5z+51wT3+/+K8odqIHl/t14NcVpdoHRpG+Ip01Hzha0I5uJVK+feI64H0
	FRsZDwIxPVlfLhCw==
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
Subject: [patch V3 12/20] sched/mmcid: Move initialization out of line
References: <20251029123717.886619142@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:09:16 +0100 (CET)

It's getting bigger soon, so just move it out of line to the rest of the
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mm_types.h |   15 +--------------
 kernel/sched/core.c      |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 14 deletions(-)

--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1351,20 +1351,7 @@ static inline unsigned long *mm_cidmask(
 	return (unsigned long *)cid_bitmap;
 }
 
-static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
-{
-	int i;
-
-	for_each_possible_cpu(i) {
-		struct mm_cid_pcpu *pcpu = per_cpu_ptr(mm->mm_cid.pcpu, i);
-
-		pcpu->cid = MM_CID_UNSET;
-	}
-	mm->mm_cid.nr_cpus_allowed = p->nr_cpus_allowed;
-	raw_spin_lock_init(&mm->mm_cid.lock);
-	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
-	bitmap_zero(mm_cidmask(mm), bitmap_size(num_possible_cpus()));
-}
+void mm_init_cid(struct mm_struct *mm, struct task_struct *p);
 
 static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *p)
 {
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10429,6 +10429,20 @@ void sched_mm_cid_fork(struct task_struc
 	WARN_ON_ONCE(!t->mm || t->mm_cid.cid != MM_CID_UNSET);
 	t->mm_cid.active = 1;
 }
+
+void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
+{
+	struct mm_cid_pcpu __percpu *pcpu = mm->mm_cid.pcpu;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		per_cpu_ptr(pcpu, cpu)->cid = MM_CID_UNSET;
+
+	mm->mm_cid.nr_cpus_allowed = p->nr_cpus_allowed;
+	raw_spin_lock_init(&mm->mm_cid.lock);
+	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
+	bitmap_zero(mm_cidmask(mm), bitmap_size(num_possible_cpus()));
+}
 #else /* CONFIG_SCHED_MM_CID */
 static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct cpumask *affmsk) { }
 #endif /* !CONFIG_SCHED_MM_CID */



Return-Path: <linux-kernel+bounces-747309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B77AB13245
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 00:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23511894835
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F056253925;
	Sun, 27 Jul 2025 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bmA4ZPn1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kXwTUPnF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E96E250BEC
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753655880; cv=none; b=AELPY/l8PAXquq9RyXqxmAPbppjbTVlV/nn1dMjmd15RzAFAnCnQ22HKzKmqyTbNEd0HrdzDYoXPmQHxezHl3nLrJ5A8+M8yKyZTJY4exY7QI7yYhBKFJppfxzj3nup/TZUwN3gLSklD0mMv8SFvl/qvVcNQGBu/4tpXwMHwt0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753655880; c=relaxed/simple;
	bh=wA6ULP4ed/37Zjsp6XVbsxOOKrbLIyb4hwg+q1j62Nw=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=sjXioEDQrzKp+ZE8KwFsGUhB0Y439KfUwq3D5yyzz5flGEAIZAaNpq1GRtU5RLx7XaK0FTyxyv2UvOt+C9qIVGm3OLSkE8oIA8Wa0HEaC26bEcV6G2BmUhr0pvwumkuP9nv/zCwwvVQ4EqEQaKFEFB8kLPnrW9758j1RFDMGBQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bmA4ZPn1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kXwTUPnF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753655877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=jwSUH23lQI7377ZMrztcFMA4c8YJLymu+B7kmWBCqsg=;
	b=bmA4ZPn1QFvXgPTOA6YvwgyTs3WrBOAdNyWpHJJMRMNFr0klczKo43AsixsJ9rgkPCcdCO
	WSybMib5GEiCr+Fdaz8dp36rFfMONtQeLxnApTO0HVOhukZxSoX5XUNgVlp5qHztmkbERS
	O+GyDTXoU6Dbqu12t2Sxx7V3hTEl8MxbajDSW4DzEpWfk38ffuMxEBk8kFCe7HSoI86ABx
	SgoeAD4xAURyb8d9JDFa1SyF3LRUu0OWrmQUY5jBctTKXwXImxxIMU4zlDy7B7Dhn2KU65
	P5rxjCF2nQdvYoAMF341xRAjfZBwPPhsr9Z5O4vk9ODg3NmG01d7cY2b7+9JNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753655877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=jwSUH23lQI7377ZMrztcFMA4c8YJLymu+B7kmWBCqsg=;
	b=kXwTUPnFrNmhakwOepHcP2bj1dvVX/g1c+aQtEk1ChsIhHme33MqUy2s85D3N43OF4nqBh
	G1jMyxd5z7WvKlBQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/core for v6.17-rc1
References: <175365567943.581055.6806236199247802443.tglx@xen13>
Message-ID: <175365568477.581055.6002001481718640290.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Jul 2025 00:37:56 +0200 (CEST)

Linus,

please pull the latest smp/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2025-07=
-27

up to:  946a72819825: smp: Wait only if work was enqueued

A set of updates for SMP function calls:

  - Improve localitu of smp_call_function_any() by utilizing
    sched_numa_find_nth_cpu() instead of picking a random CPU

  - Wait for work completion in smp_call_function_many_cond() only when
    there was actually work enqueued

  - Simplify functions by unutlizing the appropriate cpumask_*()
    interfaces

  - Trivial cleanups

Thanks,

	tglx

------------------>
Rik van Riel (1):
      smp: Wait only if work was enqueued

Viresh Kumar (1):
      smp: Fix typo in comment for raw_smp_processor_id()

Yury Norov [NVIDIA] (3):
      smp: Improve locality in smp_call_function_any()
      smp: Use cpumask_any_but() in smp_call_function_many_cond()
      smp: Defer check for local execution in smp_call_function_many_cond()


 include/linux/smp.h |  2 +-
 kernel/smp.c        | 44 ++++++++++++++------------------------------
 2 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index f1aa0952e8c3..bea8d2826e09 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -234,7 +234,7 @@ static inline int get_boot_cpu_id(void)
 #endif /* !SMP */
=20
 /**
- * raw_processor_id() - get the current (unstable) CPU id
+ * raw_smp_processor_id() - get the current (unstable) CPU id
  *
  * For then you know what you are doing and need an unstable
  * CPU id.
diff --git a/kernel/smp.c b/kernel/smp.c
index 974f3a3962e8..c5e1da7a88da 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -741,32 +741,19 @@ EXPORT_SYMBOL_GPL(smp_call_function_single_async);
  *
  * Selection preference:
  *	1) current cpu if in @mask
- *	2) any cpu of current node if in @mask
- *	3) any other online cpu in @mask
+ *	2) nearest cpu in @mask, based on NUMA topology
  */
 int smp_call_function_any(const struct cpumask *mask,
 			  smp_call_func_t func, void *info, int wait)
 {
 	unsigned int cpu;
-	const struct cpumask *nodemask;
 	int ret;
=20
 	/* Try for same CPU (cheapest) */
 	cpu =3D get_cpu();
-	if (cpumask_test_cpu(cpu, mask))
-		goto call;
-
-	/* Try for same node. */
-	nodemask =3D cpumask_of_node(cpu_to_node(cpu));
-	for (cpu =3D cpumask_first_and(nodemask, mask); cpu < nr_cpu_ids;
-	     cpu =3D cpumask_next_and(cpu, nodemask, mask)) {
-		if (cpu_online(cpu))
-			goto call;
-	}
+	if (!cpumask_test_cpu(cpu, mask))
+		cpu =3D sched_numa_find_nth_cpu(mask, 0, cpu_to_node(cpu));
=20
-	/* Any online will do: smp_call_function_single handles nr_cpu_ids. */
-	cpu =3D cpumask_any_and(mask, cpu_online_mask);
-call:
 	ret =3D smp_call_function_single(cpu, func, info, wait);
 	put_cpu();
 	return ret;
@@ -792,7 +779,6 @@ static void smp_call_function_many_cond(const struct cpum=
ask *mask,
 	bool wait =3D scf_flags & SCF_WAIT;
 	int nr_cpus =3D 0;
 	bool run_remote =3D false;
-	bool run_local =3D false;
=20
 	lockdep_assert_preemption_disabled();
=20
@@ -814,19 +800,8 @@ static void smp_call_function_many_cond(const struct cpu=
mask *mask,
 	 */
 	WARN_ON_ONCE(!in_task());
=20
-	/* Check if we need local execution. */
-	if ((scf_flags & SCF_RUN_LOCAL) && cpumask_test_cpu(this_cpu, mask) &&
-	    (!cond_func || cond_func(this_cpu, info)))
-		run_local =3D true;
-
 	/* Check if we need remote execution, i.e., any CPU excluding this one. */
-	cpu =3D cpumask_first_and(mask, cpu_online_mask);
-	if (cpu =3D=3D this_cpu)
-		cpu =3D cpumask_next_and(cpu, mask, cpu_online_mask);
-	if (cpu < nr_cpu_ids)
-		run_remote =3D true;
-
-	if (run_remote) {
+	if (cpumask_any_and_but(mask, cpu_online_mask, this_cpu) < nr_cpu_ids) {
 		cfd =3D this_cpu_ptr(&cfd_data);
 		cpumask_and(cfd->cpumask, mask, cpu_online_mask);
 		__cpumask_clear_cpu(this_cpu, cfd->cpumask);
@@ -840,6 +815,9 @@ static void smp_call_function_many_cond(const struct cpum=
ask *mask,
 				continue;
 			}
=20
+			/* Work is enqueued on a remote CPU. */
+			run_remote =3D true;
+
 			csd_lock(csd);
 			if (wait)
 				csd->node.u_flags |=3D CSD_TYPE_SYNC;
@@ -851,6 +829,10 @@ static void smp_call_function_many_cond(const struct cpu=
mask *mask,
 #endif
 			trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
=20
+			/*
+			 * Kick the remote CPU if this is the first work
+			 * item enqueued.
+			 */
 			if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu))) {
 				__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 				nr_cpus++;
@@ -869,7 +851,9 @@ static void smp_call_function_many_cond(const struct cpum=
ask *mask,
 			send_call_function_ipi_mask(cfd->cpumask_ipi);
 	}
=20
-	if (run_local) {
+	/* Check if we need local execution. */
+	if ((scf_flags & SCF_RUN_LOCAL) && cpumask_test_cpu(this_cpu, mask) &&
+	    (!cond_func || cond_func(this_cpu, info))) {
 		unsigned long flags;
=20
 		local_irq_save(flags);



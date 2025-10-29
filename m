Return-Path: <linux-kernel+bounces-876113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25D4C1A9FA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8CB1A65028
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC7C33B6FE;
	Wed, 29 Oct 2025 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ey8kSpsi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="acunwll1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0042A33F368
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743351; cv=none; b=Xkl23p0XUys1FYpLsdRUeZlvSd419HSv/enJFrmTbny10n9IsElv4fyu6aPpzrt+hQymwkjbbpK0STpsYoYDwAFOcRD1Z3UYRPsbgUKdZUfEGqCwfFcviTcfm0e9nkVOgY0gfg+dHck3Bn+1mWYWkPXaUOeqaCo+QSXszXSao88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743351; c=relaxed/simple;
	bh=DiZ01Gqp4aHjSx6CqIg0HfmaghchtrKTzkUvQvy8JGk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=kj8VxtGi5a5IjYrUGI3e+lyHyLVdSHwMne52sqmoGv26TuCkRRSdu0EtwfgJQuLKJneasc7NVSCJMfnLno5U6T42vI677xgTwyYWt/ZLKuzaeOy8Ze5KuQ9p6+I3DDPKYVZR4bDzdckOBCJoTQLFcds0KE889GlM0NOc2du9wiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ey8kSpsi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=acunwll1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029124515.655228863@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761743345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=hYzkxR86oLHC+c7l/D54HB2S4Pb9hocjhqj7Jxo0NFU=;
	b=Ey8kSpsiPB93tayUDwc0hJFaLUWl/gQkxSFhRfcm4zqWVdZCvHNe009KKuB7jsRFfycB3r
	EWKEd4Rl/QYuAeH9tBO8F3548y5xlBWm7Q3Tp/eNvoMN159Ok4xpMbArrJKCadGuQOBQ+F
	rFgkGpcs0JiqGcrQcL8ESQFFpininpxDPqxWnB4KaIDXcqPhIEvRtZYJtUmnO9wk9o4snd
	XmCISxIHS6TePe1lt6zx/YqBIro5pEHc8PW00g96SRy/UCGDMfdbidpg62C1Ymm9MDHXbO
	wrkCi7ZW9ZPMAJrF+RwBQEWiBp9basebYOoSRM39KyJdX/EyLL8iVajXEfDk7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761743345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=hYzkxR86oLHC+c7l/D54HB2S4Pb9hocjhqj7Jxo0NFU=;
	b=acunwll1LOyldpemOUQnCoEDjtGY587yofytjYw73XQAfVmn3Q3YYvTnjb0SADsK4jw8YB
	bTay3gaCtoGa6ICg==
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
Subject: [patch V3 06/20] sched/mmcid: Prevent pointless work in
 mm_update_cpus_allowed()
References: <20251029123717.886619142@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:09:05 +0100 (CET)

mm_update_cpus_allowed() is not required to be invoked for affinity changes
due to migrate_disable() and migrate_enable().

migrate_disable() restricts the task temporarily to a CPU on which the task
was already allowed to run, so nothing changes. migrate_enable() restores
the actual task affinity mask.

If that mask changed between migrate_disable() and migrate_enable() then
that change was already accounted for.

Move the invocation to the proper place to avoid that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Remove the nr_cpu_ids optimization which does not really work - PeterZ
---
 kernel/sched/core.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2684,6 +2684,7 @@ void set_cpus_allowed_common(struct task
 
 	cpumask_copy(&p->cpus_mask, ctx->new_mask);
 	p->nr_cpus_allowed = cpumask_weight(ctx->new_mask);
+	mm_update_cpus_allowed(p->mm, ctx->new_mask);
 
 	/*
 	 * Swap in a new user_cpus_ptr if SCA_USER flag set
@@ -2730,7 +2731,6 @@ static void
 		put_prev_task(rq, p);
 
 	p->sched_class->set_cpus_allowed(p, ctx);
-	mm_update_cpus_allowed(p->mm, ctx->new_mask);
 
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
@@ -10374,12 +10374,17 @@ void call_trace_sched_update_nr_running(
  */
 static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct cpumask *affmsk)
 {
-	struct cpumask *mm_allowed = mm_cpus_allowed(mm);
+	struct cpumask *mm_allowed;
 
 	if (!mm)
 		return;
-	/* The mm_cpus_allowed is the union of each thread allowed CPUs masks. */
+
+	/*
+	 * mm::mm_cid::mm_cpus_allowed is the superset of each threads
+	 * allowed CPUs mask which means it can only grow.
+	 */
 	guard(raw_spinlock)(&mm->mm_cid.lock);
+	mm_allowed = mm_cpus_allowed(mm);
 	cpumask_or(mm_allowed, mm_allowed, affmsk);
 	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, cpumask_weight(mm_allowed));
 }



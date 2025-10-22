Return-Path: <linux-kernel+bounces-865006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F1DBFC071
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922C862170A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7579934887F;
	Wed, 22 Oct 2025 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r67ElUH4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GK9r7a1y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81A1348442
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137730; cv=none; b=O5NmxoTGK3x2tpCywwg/i1JxjIfgX/lZXbgNm1bphgreSuyZd5hUGtjvUYNPwxdjQ5jQWK7RPHzbZ8JkvDBJ4hVLH4z2hD5E96Jbex90b+eb9I5x/xGfA4phCg1LJ/NRuRjame39JCV2w9MR+kShlsnurRfku60Zgk6Mze/ofbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137730; c=relaxed/simple;
	bh=uahusv6230DzZR52bXJoEVQt+Mw4Y9Bo0fSRg1hQFFo=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=X9GFjh10+ZLQxRmOJWU+AUquEa9acocWL1xrXskb4USyEySTXOMv7x5d1ZMgG+r3wsI4iMgcA1306FYW3505kGGMKZ5gSIPpkdLbhniZUm7WkUoh85IGSZ/2xk7oDzAFSS1Leja32j6hBynRbQC1Ql7QNzGhqjIuwOpEwaLMt3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r67ElUH4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GK9r7a1y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022110555.775050699@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=V282x1AHAWsgzEqulrax4eElPVH6mxnGPF0fhySJWfI=;
	b=r67ElUH4+X80z5zo3TCnnXkAeQ8mwtsT6xTJ4nsfWc4tebsstCkrD8V79i6xjnwiCPo4V0
	QKhgp8Hpzd4j5yv5KRP/e5fjExEnt+u6qAMqXiYwBC2YAXSUw9ksUor6xIUNQCvX9s7H23
	IykhiCRdG0i8FpYvhTSQY1Hxugzq05WzMJIb6Hv3sWtFXE3GOsXtJOvJxWVbFoIWRrGlzp
	J6Yer6XMMXfQL/mYdXtBxH2J0CXdcWWMXxQA2bxiTVTfA2SGtqXJLKOXE8LQ2VG3KICm7J
	jvSPY82fGaLfuR8FCY5bebnmm0M2ySNyMF+xrgKoW6A4bXG7v9fK5axQJy/UJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=V282x1AHAWsgzEqulrax4eElPVH6mxnGPF0fhySJWfI=;
	b=GK9r7a1yY8HYSJBCsaRr+70zSUqmVDoO/QavvvXPXGauR6y4BvlbXcf/7Tg97BXriAkz3H
	s0qLZUiuAGb1JGCg==
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
Subject: [patch V2 06/20] sched/mmcid: Prevent pointless work in
 mm_update_cpus_allowed()
References: <20251022104005.907410538@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:55:27 +0200 (CEST)

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



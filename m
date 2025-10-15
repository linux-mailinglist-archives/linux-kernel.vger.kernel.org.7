Return-Path: <linux-kernel+bounces-854971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF8FBDFDDB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6823A918A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242E0341640;
	Wed, 15 Oct 2025 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jXT79sOI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VsBM5X55"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4712340D85
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549379; cv=none; b=H6+jPaRC5XSvRwlrtdLRkW9aRVRnJNuFoMiSiwoGFyAJHsQ20VXhFl3KdpT8GSrTsn+rNG+P5eQ/Zr1kf3MlT7qWeZ9/Q4mkWDDEOk80J73lS4tMk/19VulZgpi4Kk1urrCA4a5iGAX+SpO98iMA2RavBgv2cxwfZXb4RgIKxCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549379; c=relaxed/simple;
	bh=9pWswLndSYH3OlKEHdAXCEVlAcboLxHWcLk6AbLtBBg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=LiVbEXe9zYLsXFyGVduD1SBcwkMyMn5DhOL2oMrNBqnJubC2gv1BPCYXUJZfPrtaQ4p4Cz1SKxVlMOXK/OM3+A/H3dP5BXaMVgbc36DZCSuieL+YwBftJA3sD1wowN+EMt4700TT90C3bCGPiPyE8R2egIKtwJ+WiCBmGwDhY7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jXT79sOI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VsBM5X55; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251015172834.694547089@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760549375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=l5dqy6vQM2tKFDkysaDM6Dpk5DSc9c4FVIzZnpmdwOo=;
	b=jXT79sOIkWPg2A6CvH8sbwR+buTNddLmZGcFXtnb12arGQozofxIDAwadTx8M311wXh5LK
	CxjtQVqAk/Tp0nOg3WDmTx283nbCukqKOJd3jC1aQKZbJPWSs/r1LKZpMszcK2KyVQkoeP
	uYsUWQxN1FIE5aV5wj6HqciG8AgsuH5cMAtyeIRJCss+aMveKJ5+WIqbPK+Dq+zQKzaEAb
	6VZkWvXgV41fl+1ialJeX556yP4LRTyr5sne4ddiWHOR5Xq1ootvLWUZMoDnRiJoLABDQu
	LWLIJfQitc38wVTnCxI7DfH3wBdxmiYNsBYdiR0cIEWv16ri3vTYlJ7IFHjFlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760549375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=l5dqy6vQM2tKFDkysaDM6Dpk5DSc9c4FVIzZnpmdwOo=;
	b=VsBM5X55zPNC3XSZHLMDPrulrN3Vniy7BPLHvG1CxWbhrY7YS9AQjX1SqgZuzWOXqFaSYx
	Tg4ZxkwO2Cf+SIDw==
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
Subject: [patch 06/19] sched/mmcid: Prevent pointless work in
 mm_update_cpus_allowed()
References: <20251015164952.694882104@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 19:29:34 +0200 (CEST)

The @nr_cpus_allowed management does way too much useless work for the
common case where a process starts with unrestricted affinity,
i.e. @nr_cpus_allowed is equal to the number of possible CPUs right
away.

Add a check whether that limit is reached already and then avoid the whole
cpumask update and evaluation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2719,6 +2719,7 @@ void set_cpus_allowed_common(struct task
 
 	cpumask_copy(&p->cpus_mask, ctx->new_mask);
 	p->nr_cpus_allowed = cpumask_weight(ctx->new_mask);
+	mm_update_cpus_allowed(p->mm, ctx->new_mask);
 
 	/*
 	 * Swap in a new user_cpus_ptr if SCA_USER flag set
@@ -2765,7 +2766,6 @@ static void
 		put_prev_task(rq, p);
 
 	p->sched_class->set_cpus_allowed(p, ctx);
-	mm_update_cpus_allowed(p->mm, ctx->new_mask);
 
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
@@ -10408,12 +10408,20 @@ void call_trace_sched_update_nr_running(
  */
 static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct cpumask *affmsk)
 {
-	struct cpumask *mm_allowed = mm_cpus_allowed(mm);
+	struct cpumask *mm_allowed;
 
-	if (!mm)
+	if (!mm || READ_ONCE(mm->mm_cid.nr_cpus_allowed) == nr_cpu_ids)
 		return;
-	/* The mm_cpus_allowed is the union of each thread allowed CPUs masks. */
+
+	/*
+	 * mm::mm_cid::mm_cpus_allowed is the superset of each threads
+	 * allowed CPUs mask which means it can only grow.
+	 */
 	guard(raw_spinlock)(&mm->mm_cid.lock);
+	/* Check again under the lock */
+	if (mm->mm_cid.nr_cpus_allowed == nr_cpu_ids)
+		return;
+	mm_allowed = mm_cpus_allowed(mm);
 	cpumask_or(mm_allowed, mm_allowed, affmsk);
 	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, cpumask_weight(mm_allowed));
 }



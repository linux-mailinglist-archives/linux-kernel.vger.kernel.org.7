Return-Path: <linux-kernel+bounces-854975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5BDBDFDF6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB1E189AE60
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C95341AB2;
	Wed, 15 Oct 2025 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uF267Tt0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IOtW3iuq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E612DFF18
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549384; cv=none; b=cS6XJqzsMrUKwpC/BpXKQP1rrh21VNnXG5O0L5AlIfmCwZDqQ2VEnjxheYmQJN6biuHeBrvtfioqHlA0Agy3NMtMfzh+h7u+hVkbRzRp218yNZA8cDTRuFZV7js8lsijiYuKJ7/1Uv4VcGfE24tYC2rkNH6JRhvc+3IjF9mqkcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549384; c=relaxed/simple;
	bh=sTLgufpAYUrvdEdtY1yc8s8j7BbqzgMcwvNAxTHLyVc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=dLdkrrGkUXaLoLnPXpQvkMZoKhJ514zmg3AhRjhikXYKP6URayMJjVpH4OPJ3NUwH32tb1mZDDF16otgtivywGY2IGFRBodZ7JvAYMRE0Zo5MTWLtnFbMZlW1eT1tfOASX3dybGEjccqVpw2fCDs0AMsINwQ0HymDU/IcKp+jFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uF267Tt0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IOtW3iuq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251015172834.884261347@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760549381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=J1lzC60maM+Wx9z41/PXq87Ndq3QPPxpl8N3vVQkT6I=;
	b=uF267Tt08mTkpaw74/xmNRIpLE8jkOk80iD6UjTDTNojLhDU1Snz5kUDAyHBscsIdF2BQG
	I469CNdNeaThz3ZRo35g6gwUsK/+sA6aGe1dcukLi9ED44P6+s6s2cO+bRCwj+oSpPwXvA
	poFrH4lS8kKjI8tnlKjVfQamdIGB4mbpY/JKhBWeQouLN5o97Bo8GgDnZ/HEQgbfukRG+h
	1gCxkCbcg29e155Q5fN7vrAZAznMI1R+SahFwAiKLgz0skBaBRHUQb01ecirGQdOPUpv5r
	PrUFjEP4D2ZCrvLm/oUHevZd/SYO1zSP2H8N3/ZJSVmkVOnWk7J6Pcfxn1m94Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760549381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=J1lzC60maM+Wx9z41/PXq87Ndq3QPPxpl8N3vVQkT6I=;
	b=IOtW3iuqj/wfXckQrMldoEVfffwocb384cJcY6QXHjpsgd7BqKZCNkCtbSAF3bem+2W0l+
	To09Gsrl0CwUusDw==
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
Subject: [patch 09/19] sched/mmcid: Convert mm CID mask to a bitmap
References: <20251015164952.694882104@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 19:29:40 +0200 (CEST)

This is truly a bitmap and just conveniently uses a cpumask because the
maximum size of the bitmap is nr_cpu_ids.

But that prevents to do searches for a zero bit in a limited range, which
is helpful to provide an efficient mechanism to consolidate the CID space
when the number of users decreases.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mm_types.h |    6 +++---
 kernel/sched/core.c      |    2 +-
 kernel/sched/sched.h     |    6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1296,13 +1296,13 @@ static inline cpumask_t *mm_cpus_allowed
 }
 
 /* Accessor for struct mm_struct's cidmask. */
-static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
+static inline unsigned long *mm_cidmask(struct mm_struct *mm)
 {
 	unsigned long cid_bitmap = (unsigned long)mm_cpus_allowed(mm);
 
 	/* Skip mm_cpus_allowed */
 	cid_bitmap += cpumask_size();
-	return (struct cpumask *)cid_bitmap;
+	return (unsigned long *)cid_bitmap;
 }
 
 static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
@@ -1317,7 +1317,7 @@ static inline void mm_init_cid(struct mm
 	mm->mm_cid.nr_cpus_allowed = p->nr_cpus_allowed;
 	raw_spin_lock_init(&mm->mm_cid.lock);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
-	cpumask_clear(mm_cidmask(mm));
+	bitmap_zero(mm_cidmask(mm), nr_cpu_ids);
 }
 
 static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *p)
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10437,7 +10437,7 @@ void sched_mm_cid_exit_signals(struct ta
 	guard(preempt)();
 	t->mm_cid.active = 0;
 	if (t->mm_cid.cid != MM_CID_UNSET) {
-		cpumask_clear_cpu(t->mm_cid.cid, mm_cidmask(mm));
+		clear_bit(t->mm_cid.cid, mm_cidmask(mm));
 		t->mm_cid.cid = MM_CID_UNSET;
 	}
 }
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3553,7 +3553,7 @@ static inline bool __mm_cid_get(struct t
 
 	if (cid >= max_cids)
 		return false;
-	if (cpumask_test_and_set_cpu(cid, mm_cidmask(mm)))
+	if (test_and_set_bit(cid, mm_cidmask(mm)))
 		return false;
 	t->mm_cid.cid = t->mm_cid.last_cid = cid;
 	__this_cpu_write(mm->mm_cid.pcpu->cid, cid);
@@ -3576,7 +3576,7 @@ static inline bool mm_cid_get(struct tas
 		return true;
 
 	/* Try the first zero bit in the cidmask. */
-	return __mm_cid_get(t, cpumask_first_zero(mm_cidmask(mm)), max_cids);
+	return __mm_cid_get(t, find_first_zero_bit(mm_cidmask(mm), nr_cpu_ids), max_cids);
 }
 
 static inline void mm_cid_select(struct task_struct *t)
@@ -3597,7 +3597,7 @@ static inline void switch_mm_cid(struct
 {
 	if (prev->mm_cid.active) {
 		if (prev->mm_cid.cid != MM_CID_UNSET)
-			cpumask_clear_cpu(prev->mm_cid.cid, mm_cidmask(prev->mm));
+			clear_bit(prev->mm_cid.cid, mm_cidmask(prev->mm));
 		prev->mm_cid.cid = MM_CID_UNSET;
 	}
 



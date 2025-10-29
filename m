Return-Path: <linux-kernel+bounces-876119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76810C1AA0F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A7D189FDFE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D31244671;
	Wed, 29 Oct 2025 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="STXHdnl3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WfUAv2EI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F3F33F368
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743358; cv=none; b=nwImH3ibII+ENcLaugOWlTlf+VKQdP+YmqFWj6IV779rit92ZlRO+B2/By8OnmYv3jlft7kAPcH7UmupSeyKZDQrhmPD60C+R9/3A1NEm6DC+h4AvkIa1n4qovAwHGzjZm8h0+m8XUwQOdFVtRZpSdLN9XUTr271cCO+Cx6MLxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743358; c=relaxed/simple;
	bh=JvKrqqhqQkNXSmdvSkuU4vrDYVUQjHoO1aeAOwIzFeY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=h5ielAVV9WK6931rRYa6FjRP+97PeAwwvi0wyih8rOatQNaGm4N7oDOMm6PfuAg+UDGNOCpKA9wzMT1YMoTX1Z8ZqPERPvNhStUwkegCqPwY8YJfmfq1V7tVZuwQtBQU1bPDWtY/B5VAsieOZCxno9sFLKDRBvzvXptr5Z69DZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=STXHdnl3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WfUAv2EI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029124515.909894811@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761743353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Ik7Fx3QFZtAvRlvj5JI5VccXVYmHNEv9gCKTCeStrbE=;
	b=STXHdnl3m/V0UvXQR2LpOOS5k3jp9QlfS1jjiqApWblEhio87bPnzB3nTkOgR8S8iuCN6I
	ZVdCyGOB499GFwy/DoYNdxyeXVGKW6gnNcfr6zIUseeXma0PstplHlbtoVjK6tjJefvPoc
	UHTmKBvrYdhvqroYoOQjbVJdcDRt2c/ffm9NdiiUX0KKDZh90zBr3bVNkw4HUetFqhPNBA
	nQ9Z9lAhAUo6VpH0x16006CGs/yZRXqyzX+XcN7qSQZhZ3dP/yMkLEJprMfg15JEW8Uje9
	SBzOmtJAWQFMf2snycxvqL4dxwo1sKW/0io7ZFVL8C325AeTLtcgGj2iJ0L9yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761743353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Ik7Fx3QFZtAvRlvj5JI5VccXVYmHNEv9gCKTCeStrbE=;
	b=WfUAv2EI+HneqB1OBFq4Mv5uIZ3JTH4lKHCQCz4BlQXqcLcx8yvrCKY4f8Z6zrhp0s/uDC
	Btyj5/unix/38rBg==
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
Subject: [patch V3 10/20] sched/mmcid: Convert mm CID mask to a bitmap
References: <20251029123717.886619142@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:09:12 +0100 (CET)

This is truly a bitmap and just conveniently uses a cpumask because the
maximum size of the bitmap is nr_cpu_ids.

But that prevents to do searches for a zero bit in a limited range, which
is helpful to provide an efficient mechanism to consolidate the CID space
when the number of users decreases.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
V3: Zero the bitmap with length of bitmap_size(nr_possible_cpus()) - Shrikanth
---
 include/linux/mm_types.h |    6 +++---
 kernel/sched/core.c      |    2 +-
 kernel/sched/sched.h     |    6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1342,13 +1342,13 @@ static inline cpumask_t *mm_cpus_allowed
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
@@ -1363,7 +1363,7 @@ static inline void mm_init_cid(struct mm
 	mm->mm_cid.nr_cpus_allowed = p->nr_cpus_allowed;
 	raw_spin_lock_init(&mm->mm_cid.lock);
 	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
-	cpumask_clear(mm_cidmask(mm));
+	bitmap_zero(mm_cidmask(mm), bitmap_size(num_possible_cpus()));
 }
 
 static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *p)
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10400,7 +10400,7 @@ void sched_mm_cid_exit_signals(struct ta
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
@@ -3558,7 +3558,7 @@ static inline bool __mm_cid_get(struct t
 
 	if (cid >= max_cids)
 		return false;
-	if (cpumask_test_and_set_cpu(cid, mm_cidmask(mm)))
+	if (test_and_set_bit(cid, mm_cidmask(mm)))
 		return false;
 	t->mm_cid.cid = t->mm_cid.last_cid = cid;
 	__this_cpu_write(mm->mm_cid.pcpu->cid, cid);
@@ -3581,7 +3581,7 @@ static inline bool mm_cid_get(struct tas
 		return true;
 
 	/* Try the first zero bit in the cidmask. */
-	return __mm_cid_get(t, cpumask_first_zero(mm_cidmask(mm)), max_cids);
+	return __mm_cid_get(t, find_first_zero_bit(mm_cidmask(mm), num_possible_cpus()), max_cids);
 }
 
 static inline void mm_cid_select(struct task_struct *t)
@@ -3602,7 +3602,7 @@ static inline void switch_mm_cid(struct
 {
 	if (prev->mm_cid.active) {
 		if (prev->mm_cid.cid != MM_CID_UNSET)
-			cpumask_clear_cpu(prev->mm_cid.cid, mm_cidmask(prev->mm));
+			clear_bit(prev->mm_cid.cid, mm_cidmask(prev->mm));
 		prev->mm_cid.cid = MM_CID_UNSET;
 	}
 



Return-Path: <linux-kernel+bounces-865010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF48BFC053
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E4D8560D21
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2054634AB11;
	Wed, 22 Oct 2025 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yxYpEy4a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LPBFUrpr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5EB3491FC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137735; cv=none; b=iREr1Uz5ho7Q05R2n8WIsdzuL078l6g2GalEYqpHr3HGBigU2wL62gAB5FixWdZWnJqpC2DlW51WQM53AEcTmLUWp7PcL8FbCjQyDm4UfZmv885coO17SZW56MrzjnDWAWKEveWkd6+DRldHcDGNJFeTVkVYzPJpCmhpvurIcik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137735; c=relaxed/simple;
	bh=zmSeg3GAj46dk7wW4jScL07/yltg9V0+INXyHKDTjrk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=lFOTj/K38+B2wsf02SBEXOAOzAnmro8LfoZYh9wDY5kKDATmzUmrjsI2oO1jOxXxTudtFg1wEB913MZYp28oqOTJ10zCcQpTqjFrVb7XDuFQ5hbz9QuARM+LC/lFmSa0/17x0Wo+NtJXvKzWh6U6IMZxwxHuQ/bLktc/ELOfoto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yxYpEy4a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LPBFUrpr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022110556.029862568@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5/lVt6qrQlW858HA8ahJtIUcMN8Q+Oem8wfsTePp2Js=;
	b=yxYpEy4argIXbyPief92RqFlif5mCg7E6EpotVV1LKdXkEEMpjGue1VTrfc4gvhfktrFTv
	01mFC/9exl8qxjl0nWR1QQ8ZF56rXneydpik7mJpjjDTGrWXuZTOAnRJeLWkyJHFbrlveC
	+UituQ3ma3u4s8tlwTuDB6ZTsvjQagtL+rWY73MBkKwMBqUwguZcp44i5Xhte4dZdEhtd3
	tQRvjm3NNsY7b06BFptVBpQrVM4cfNO2eSHWkbmJQNFGAEu+zM77MHKoIkjC8txCCmywGG
	lwdXeAMjipNiTW1e5XAmJu0phgSly0zeo1kK11hKyCXfI0METP2SpaSSet8cCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5/lVt6qrQlW858HA8ahJtIUcMN8Q+Oem8wfsTePp2Js=;
	b=LPBFUrprRfu2XXe0Lt4q53k44seWRBLoGh38NqnaCNFjoJMdp/rpKdO+lKlkW0idHn6g9k
	rLSUwdGfYzSgEADw==
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
Subject: [patch V2 10/20] sched/mmcid: Convert mm CID mask to a bitmap
References: <20251022104005.907410538@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:55:32 +0200 (CEST)

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
+	bitmap_zero(mm_cidmask(mm), cpumask_size());
 }
 
 static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *p)
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10399,7 +10399,7 @@ void sched_mm_cid_exit_signals(struct ta
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
 



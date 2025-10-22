Return-Path: <linux-kernel+bounces-865012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CA2BFC023
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 885FD345553
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0824C34DCC0;
	Wed, 22 Oct 2025 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SbjftQrF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LcLlxG2c"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E7634B189
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137738; cv=none; b=Z68GxS03asLMPh9wxkRbdvLagZ5RbVrIgeNstL3dj98aaTbwtpiupmuHUqf3ruj2WL8ytEDKbNnBwclGXmdAioYND4KbFEYttt5HL9xQxlF+7qkZY/3OCgT5KKVMoV/Pqhz3PDcHbgY4ZKK9Lt8JWscK2vVEUtxvBH4ZAZG6ImQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137738; c=relaxed/simple;
	bh=0yxOetEVeRa5k0wXaaiW6RQfM1FRkLmtoHtExORXUCE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ZLhh7tfF1kzVdfDvfXbfkfnFyjCc5n6T/D+/i5E4HyJG4AVWMqTWoR5PIFrR49sfWNga4uZyqONqGp1yL6YroQ2qj42/vfOleqSp1t3FUaBFHePjFieAiHqUR4+0VWqokQ12Pd2M/TmhUOesmXrqBo8/ZvlDWAH7lpOz+wP1bj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SbjftQrF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LcLlxG2c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022110556.151894768@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=3nmwDO1KNvwIn9P9I+ShFJNBsMWV0wtk1y0DS7IWlo4=;
	b=SbjftQrFsSta5TznAEx2EjIm3LtG2b9gqpbLcVcOAR2a9QfDgw9RsFsXbkOboE2IZvh/lU
	us9WKtZmE7rwJet1eljEAC/9bSsYp9tf6lJItPMUGCFS/kK8yqHm2Sd4diI5SoGm/cSkqJ
	ywiUMw5VYcsa9i6UHzCvyzJTdpOfrs+RWmslRKBzLFUvMAfzKTLhWSE3pbuGMH6YlH0AZH
	xK2xAu+o2PFSQs/GOffrbPNQH6YwbNjHcreKcv2Qet3PvMz5tpM5rFsP4q74IRxTg4beE+
	pBNoLe0vk4kvmvctCG0tQ5BdaW7RcSAF4QPGAaKgP3u7aZnGkqVR3feOJYx+Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=3nmwDO1KNvwIn9P9I+ShFJNBsMWV0wtk1y0DS7IWlo4=;
	b=LcLlxG2chhHITz282zsd7g9WAuWCYQKm80XFnuZNkN78knrsEwsOUvq/BwNZuJjniNZeYn
	D/xm4lssnh6CzbCA==
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
Subject: [patch V2 12/20] sched/mmcid: Move initialization out of line
References: <20251022104005.907410538@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:55:34 +0200 (CEST)

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
-	bitmap_zero(mm_cidmask(mm), cpumask_size());
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
+	bitmap_zero(mm_cidmask(mm), cpumask_size());
+}
 #else /* CONFIG_SCHED_MM_CID */
 static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct cpumask *affmsk) { }
 #endif /* !CONFIG_SCHED_MM_CID */



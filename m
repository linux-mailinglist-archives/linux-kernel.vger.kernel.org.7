Return-Path: <linux-kernel+bounces-854977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 729C6BDFDFF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E4019A55A4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D364133EAE7;
	Wed, 15 Oct 2025 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r7yvOYw4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DyrnmOso"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C967C341AC0
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549388; cv=none; b=lAmXJgEbMadBgHhuKH2YWLIH1TPvoZOqihwBdsmKfsSnbfjk3/gq0U0OQY4NoJaOM/QY7e6x/rp/i7VDW5VZX5pn7TZEGZzsdVvXnwiMdL3p5vM5nhMWUBZd5xcjZ3EfG41gItcRW2CvPc9zHY4u+M41wA5auzVVtESEq90/B0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549388; c=relaxed/simple;
	bh=Cn+g8jVsk1IyAMUDj5C16SswRIn6DXyX19WzMjIUxxw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=svZNQg0LDEwBIsyl653rh+WTv+cMv+0kv1zVaXHHVwUTzuRolyFERFjWP7lumwNnXXqZFry80/UuziTdJHSrOFqSEaBWWuox4SgAPMpusU2Nu1I2cGyS743qLCAbu/l8vZ43uJDzfU8A6fkRPWZJ1G7/9zqAZJ2ng3qIAF8O6I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r7yvOYw4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DyrnmOso; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251015172835.007019151@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760549385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pRibfw9Eka6K7CsuhEpXbYgthEZSPRccLhsB23qNyDs=;
	b=r7yvOYw46RcC5QB5+Fssn3NGecry4hLi5BRIrJuDR9gzCwix6B3BpXW54X89Fz6yfYmvym
	HoBoMPWlZhmNUC8p0VMvx1IosWXEjg7x1WfQhWrIm4q8EirvvnV3ppr+na/U/+Nixnhnba
	jPJAsTTqlNNhvHGD+lD9HTFQPF7Bbwn6DVhYWjRqXW/myjcALbRY2V07wCc0wFU9pVqDT2
	8seZKx4ebqGKu3h6Ll/UuhAoQQTSGXQ2ESzI+o6PcpRdCh0mIt1j+ljpj1mQ/XZ3tgN3cN
	JH0PknE6m8SWB5uHmXuP0B8SUizE1ONm/e2OMw6kIWyGcwM1EV/uLoKTaGNWsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760549385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pRibfw9Eka6K7CsuhEpXbYgthEZSPRccLhsB23qNyDs=;
	b=DyrnmOsovFnCwhu6gad5RkDbek6u3gN+j9jRFFSStl5SQMODBYlzSq085SR/I2uad19/MN
	3uyylJuM+xhgQAAQ==
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
Subject: [patch 11/19] sched/mmcid: Move initialization out of line
References: <20251015164952.694882104@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 19:29:44 +0200 (CEST)

It's getting bigger soon, so just move it out of line to the rest of the
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mm_types.h |   15 +--------------
 kernel/sched/core.c      |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 14 deletions(-)

--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1305,20 +1305,7 @@ static inline unsigned long *mm_cidmask(
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
-	bitmap_zero(mm_cidmask(mm), nr_cpu_ids);
-}
+void mm_init_cid(struct mm_struct *mm, struct task_struct *p);
 
 static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *p)
 {
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10466,6 +10466,20 @@ void sched_mm_cid_fork(struct task_struc
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
+	bitmap_zero(mm_cidmask(mm), nr_cpu_ids);
+}
 #else /* CONFIG_SCHED_MM_CID */
 static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct cpumask *affmsk) { }
 #endif /* !CONFIG_SCHED_MM_CID */



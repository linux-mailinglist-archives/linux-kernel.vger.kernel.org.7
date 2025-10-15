Return-Path: <linux-kernel+bounces-854974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 471D2BDFDEA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAEF51889092
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6DA33CEBB;
	Wed, 15 Oct 2025 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QLp81ZOL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="86Qc9Qlh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0946341651
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549382; cv=none; b=AHT0FxVdklqnFDgx8z1IQoQaD5VkZaiwvFGrZ2MecMS/IvnGPc7b6c/hDR3TgiVGxTNjOZ9jp6LKR+RDHAxqXHR6PvahSmvCttfr9BZXJBS/aDfa/sOzj3blQ5kCqW4a1PQMefi4C7mKLP4jPa74YQWoYvitIF4U/SZHgdjVBjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549382; c=relaxed/simple;
	bh=MtiEhz0wHdPyjeaAls39ddozfjqipwFqzCW6ZelbBxk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ndQQ25sLPy54R+fz3R8A5sJw2TcJ/Ztsyj8M8nJRd5DoPVMOri8k2OUkdDoQINNdyADHbZDD+wknuCix1Dei11tt1BgkLwGazCtH9pOd2OZrWe5yuFzR4j6oBcwanSDn2LtYuJ+5UtS9U0Mjc8G+tURQt9RoRR0V9PANyDDi47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QLp81ZOL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=86Qc9Qlh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251015172834.821167837@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760549379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6czr5gj00vNJ5vkTWTx9oZXFl88VrqJbsZtU7Kcm6x8=;
	b=QLp81ZOLhfcx3sO8rXZq+reWBE5w6cu1zukdwyArqCoq2F8EF0LtIMC1T9c0IOpSwEFYCj
	uY7Ak+B9O4CLNo9Ki/wzXicYEwEJ8QR1FTvPKUm5iRX+xXfZFh/Mq9TgnqxWsCgQelllaU
	PobX/6uzdKwD6UE/9XvrD/6p84ITXXK6Yu+9T0zlYrdis0CIvHiIVO+c3xpNZcqiUP3/bN
	meG08+FpWOSrie98uSGqr9CLskA8zcqKlBD8wCEGqsvyaUbliQKGQZGwlV5wd7l+/0azm0
	B7c3d+a9nKV0cEofPXs7lhLFtZkHiigExIgMUJBAtJIrwBBZVvDBp++40/tp8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760549379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6czr5gj00vNJ5vkTWTx9oZXFl88VrqJbsZtU7Kcm6x8=;
	b=86Qc9QlhxN1HtLpCnIgcpVvymUJ3058/OgLX10dTgFqNgA4UUuq36I9GC614w+XwA9ZD8h
	oUvP0XnOjdzOPrCw==
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
Subject: [patch 08/19] sched/mmcid: Use cpumask_or_weight()
References: <20251015164952.694882104@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 19:29:38 +0200 (CEST)

Use cpumask_or_weight() instead of cpumask_or() and cpumask_weight() on the
result, which walks the same bitmap twice.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10409,6 +10409,7 @@ void call_trace_sched_update_nr_running(
 static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct cpumask *affmsk)
 {
 	struct cpumask *mm_allowed;
+	unsigned int weight;
 
 	if (!mm || READ_ONCE(mm->mm_cid.nr_cpus_allowed) == nr_cpu_ids)
 		return;
@@ -10422,8 +10423,8 @@ static inline void mm_update_cpus_allowe
 	if (mm->mm_cid.nr_cpus_allowed == nr_cpu_ids)
 		return;
 	mm_allowed = mm_cpus_allowed(mm);
-	cpumask_or(mm_allowed, mm_allowed, affmsk);
-	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, cpumask_weight(mm_allowed));
+	weight = cpumask_or_weight(mm_allowed, mm_allowed, affmsk);
+	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, weight);
 }
 
 void sched_mm_cid_exit_signals(struct task_struct *t)



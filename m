Return-Path: <linux-kernel+bounces-865004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 017A7BFC03B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C321886B12
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69F3348441;
	Wed, 22 Oct 2025 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sFCFvxP4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n+W2/kNl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F54347BBA
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137728; cv=none; b=ZTdQdvusgMUlJ04SFSzoKg6AYx+ExpYHJIhCQSYaSMyvZN/POTuJU1rxu0KSNWHWMroACXmFHSdAwWKVuWq58vjEJaFCBPyEBQDb4rB5cS/186XN3TkvI161Z5epxRZCEYCvxEnDpE62bljDga8q+LD25S5z12xRiKtWhpfwTlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137728; c=relaxed/simple;
	bh=ttqBwccblDnlUgT85u24m8F8ReEsQpSy2xqoZ61jUTo=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ByKBH40wRWh2ypmOuZ7KBtxIhK+kyefw9V9tNKTaoNaQ6kC1nusPhnp/DnmW9mOBfnBvuz9bW9yFSRKHaAhm/xvgvQuQBPuohVo1nG5Ob8qUePvAfmg2/f8l7y7i8qiljSNTepWhSgSQnLR8VuM67Ryq8uW6dgcJI2Giae9J8uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sFCFvxP4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n+W2/kNl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022110555.648851773@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MyiYc5XDcaSkPhhdDFhhQoCiJrczopI5QkPnfs+aYFg=;
	b=sFCFvxP4SFlId6rsAY96Rw4/cb8q15Oray1FknLjNk/1+1D8jVIQSYlsxYlnjyxmruHljU
	XsjgXUgoWdpRO3kmXmM0uXq3tliS8FPp/ttyAqWWS8LA3EghfOmFpz7ywhZ26ms7adRlFk
	cMT0qSBtgNH8yVXE2N2zom4OXmDLv5bXI3gzsOpbR60CTOB6kqN8O3EzebKbsEqQ3KInZg
	AAbQd0/mYiTdAzLxXqASgF/CPWDxEyoJivIEIIF2VFXHMhFXCEd27ya2MT2qNHQ4HjTAUS
	5wnak4JYsYmm1O+k4i2UVgNKIHAHtB5al1ohZcDbhoveYFT7cHck9NA+2rVRMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MyiYc5XDcaSkPhhdDFhhQoCiJrczopI5QkPnfs+aYFg=;
	b=n+W2/kNlmqG2h042ne2Tf2vlQlfLES0LYpaEMXARiF3GySLsZpE50ktr8Qgkpi8IXmBDMq
	qCaen14ytLyt2TCQ==
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
Subject: [patch V2 04/20] sched: Fixup whitespace damage
References: <20251022104005.907410538@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:55:24 +0200 (CEST)

With whitespace checks enabled in the editor this makes eyes bleed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5277,19 +5277,16 @@ context_switch(struct rq *rq, struct tas
 	 *
 	 * kernel ->   user   switch + mmdrop_lazy_tlb() active
 	 *   user ->   user   switch
-	 *
-	 * switch_mm_cid() needs to be updated if the barriers provided
-	 * by context_switch() are modified.
 	 */
-	if (!next->mm) {                                // to kernel
+	if (!next->mm) {				// to kernel
 		enter_lazy_tlb(prev->active_mm, next);
 
 		next->active_mm = prev->active_mm;
-		if (prev->mm)                           // from user
+		if (prev->mm)				// from user
 			mmgrab_lazy_tlb(prev->active_mm);
 		else
 			prev->active_mm = NULL;
-	} else {                                        // to user
+	} else {					// to user
 		membarrier_switch_mm(rq, prev->active_mm, next->mm);
 		/*
 		 * sys_membarrier() requires an smp_mb() between setting
@@ -5302,7 +5299,7 @@ context_switch(struct rq *rq, struct tas
 		switch_mm_irqs_off(prev->active_mm, next->mm, next);
 		lru_gen_use_mm(next->mm);
 
-		if (!prev->mm) {                        // from kernel
+		if (!prev->mm) {			// from kernel
 			/* will mmdrop_lazy_tlb() in finish_task_switch(). */
 			rq->prev_mm = prev->active_mm;
 			prev->active_mm = NULL;



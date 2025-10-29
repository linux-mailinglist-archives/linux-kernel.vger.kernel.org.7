Return-Path: <linux-kernel+bounces-876111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D46BC1A9E8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF421A623D2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490A633F38E;
	Wed, 29 Oct 2025 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xiy7l/AD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="euZOs+5p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F2033F36F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743349; cv=none; b=f3ag9Do0cD8x6Iu1PrCxtX+Rhw0eTFsQZRBItG+HpnOtj3cWT8DASRNr+RxoKd3+IkC1nUggCIXe+bZ/1B7U6YOM2rbhs/aahwMCR1ogYdb4WwBS8t+ajaMUBNlDygsgP9IBwdFczyTnMKPxtgGX9R6+yxuHB2tJ3p6mWTFlz/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743349; c=relaxed/simple;
	bh=ttqBwccblDnlUgT85u24m8F8ReEsQpSy2xqoZ61jUTo=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=gCXNa41/lfsQSM9vNfdvnOGGzEJW277xBeWlCicmxbPYMOC0jMOc2x9B9bOSAkduX9sLl548bwPBZ4EfkhUPdLeB9k3dakpsoMCtPAF76kb96f1OQTPtcnILC0FNltD+Qk/bPzgVMKLOHgyConrqifpGICQLpeHu643dGF/TQas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xiy7l/AD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=euZOs+5p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029124515.529672945@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761743342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MyiYc5XDcaSkPhhdDFhhQoCiJrczopI5QkPnfs+aYFg=;
	b=Xiy7l/AD53MGis2PTrxuDJCQPFI8uTzNUysn5L3qHOeMfq8kLRGQrUBHig3D83OOxgYDrO
	dTZfddROpWXl4WkZW9YBKCIC9XeOfFYfRnyjJcLwRPqmKVIKzP5XjJQBhhOX4GX9i/2nxP
	dyLEG4exQ/hZIfWHVVIlZWF0dZzrd+tnCM/YaHcF3hvSwTfnkRYO1I7J5DtTHttRg2Pxho
	LdZ9P/MCGlQrg7lYgHgbSEkvgABIxXZpzjkyz9UaV76ZSn4p0rmZqvfHxx/goI6d5828k0
	PAoUwmms/NhNK5Lz1FotWF9Flh46dr5XPfUHr1qBXXdeGYLE4H2tn6ssLcUS4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761743342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MyiYc5XDcaSkPhhdDFhhQoCiJrczopI5QkPnfs+aYFg=;
	b=euZOs+5ppAgKYIfGIKd/RMYllvzBHZ5av3jDUbF0smwpOFm/GNTnFCWnSPT/BMqhWtVfNQ
	8i9QMz1FgVNx1NBA==
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
Subject: [patch V3 04/20] sched: Fixup whitespace damage
References: <20251029123717.886619142@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:09:01 +0100 (CET)

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



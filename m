Return-Path: <linux-kernel+bounces-854970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 721EFBDFDC9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D2C54F3E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9882340D8E;
	Wed, 15 Oct 2025 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2v8diJWF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JAsIVnJb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5697F33EB07
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549375; cv=none; b=ttSHlZYDOJhLDu8e0U/neuMRFhlkLdBkxru0wBUuPN6nweDQoZP42MO+rI0g6vcc1skeN2JsiAVpRql63C/t8wuHaexN+4FK7PmI6qmqtQIZKtvIj3WNgVnUOA4MGkEk4Ub1vDenhkXq+T1XPDxcs646Px/lz3DwCQ8iKvingZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549375; c=relaxed/simple;
	bh=fAulOyMtoDIHtPffcLIZNosiilQd7SnxrdYCJYwu6vc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=QLk75D4RVJ4P1VfJ+4QHtjnM/twr2GloWd+f5y5WL0iC9hYWRwAMjMv/7pWwSWixMoc4cVWUoWMrLXj5EGGMURu1hBwd9TMhk/DzH1GwjNqhLhrlJeXhe7az0Ix3N149GDrUmVJwdvWXK75DB0m16lkNHUVjmgQkxFO8ilhXV7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2v8diJWF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JAsIVnJb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251015172834.567565394@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760549371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=UAGiBz58l3yttdLeaOKha2U+mDMRTGzch+NUHw/3WXo=;
	b=2v8diJWFvvLFX7iIXY6/wKbLFHQqysbRUjDzo4wfeAyIpYc6KeiN1f7/mE94kCBWcp4Oqd
	qaQF+r9A9xZHeB0r4iMhpNTtaw9o2zvYtxC2HfVkW7JMZxUjMvMGojD2oVLcVFhFsUM0jz
	rEARAOpG+saBVoNDKDWWDgLwhTANQAhWXT2RsfmauF1UgAWzUjKosAFqWR77KHfpxEZXgL
	7rYiHKe8GkYQrcmkliisz/0DAb1FyybSRXaDAUVi4fLuutzY2uxGhAieCXHNdwheJW28Vw
	IR5RUkmFFLqyh1RdobgVOAv0DjfN+jRJX996OBGIrDVrXcy1oKDESevLIGLy7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760549371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=UAGiBz58l3yttdLeaOKha2U+mDMRTGzch+NUHw/3WXo=;
	b=JAsIVnJbHG4vYW9GpYj6LYu7QApv2grY7/wafdWNtNYnA4g+F8ACbnKWybCI3auxh1iGzM
	iEJqWWMnvy/McyDg==
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
Subject: [patch 04/19] sched: Fixup whitespace damage
References: <20251015164952.694882104@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 19:29:31 +0200 (CEST)

With whitespace checks enabled in the editor this makes eyes bleed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5309,19 +5309,16 @@ context_switch(struct rq *rq, struct tas
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
@@ -5334,7 +5331,7 @@ context_switch(struct rq *rq, struct tas
 		switch_mm_irqs_off(prev->active_mm, next->mm, next);
 		lru_gen_use_mm(next->mm);
 
-		if (!prev->mm) {                        // from kernel
+		if (!prev->mm) {			// from kernel
 			/* will mmdrop_lazy_tlb() in finish_task_switch(). */
 			rq->prev_mm = prev->active_mm;
 			prev->active_mm = NULL;



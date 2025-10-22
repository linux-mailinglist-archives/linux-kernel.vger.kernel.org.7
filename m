Return-Path: <linux-kernel+bounces-864977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79935BFBFED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051061A60C31
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A58C34B664;
	Wed, 22 Oct 2025 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DQJxdOfq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zI3UDrtW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F46E3491EE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137543; cv=none; b=i+AHsCRdTn8SLFHyGknk7O18b4verN8CitmbJrACq5luZYPSVJIPjQMWZXAtnxfoC0cimOHwNhZquGgzdrahgAPw/kI1c5xdVLAXDI8Kqtp7rEkgvqiL2NIALVirwp5Vg2lz4n1fl2AqBwJ6p+si4DhpYnGySweMKXfVRofAKMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137543; c=relaxed/simple;
	bh=nNcmc9NuBR5mKSpaY7pA17gsauTbI89Vg8sje15ed+M=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=AFtqWCQS7PgFn6QhJeO3OUNc+hNEC+yxkSdMTWqk55+op0pTJgJH/qXC7vgZX4phVv0tKPLLfEku2ar8k2g3FNp57jpZTM5/plTbxiWAap+A4npeP4rOaoC4rSroMAH+fw6v13/l0OkLSUyRW0ZBya5TESjgfel12sKWbQCq6fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DQJxdOfq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zI3UDrtW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121942.151711548@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=U9wZY6TfKM1n4wUTA4Xhxpku28PKV7TrzvWt6YuJk0w=;
	b=DQJxdOfqJTNZOi2CAc5yRDM2cnGhdlPnw2TvDe9IkhfYs/xsUNI8jFkIVqZItb1gbZ0/0N
	nJPN6pEVd5ABEpV3evFx3vcIKKVADujEQgQJ9ymgEYx9nBfXTtuzWt5hdiBkY3tTSZsiz9
	OjqbqsLG0YN0QuOoa8RPD2LvYyQMxK4JeUsL/VZ8Im0cHzNemwJ5STuzBvKP2OLi/679vj
	6fGKMPX/m0YkegPfpG8F++zgORa1d/aXFOHxnxJqmiOso9vSLgg0846IfE48f3emmklfWz
	dMA9KezjIoOKD87nxYF//dO+WRTU89UeTh+OJD0ZbPxLGkGa/0pphKqsLdZmpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=U9wZY6TfKM1n4wUTA4Xhxpku28PKV7TrzvWt6YuJk0w=;
	b=zI3UDrtWH4GIvs3moDEUJAXo2A++OJ0yUdbXeQaBT0eQ1NdPsrwmeLnF1POTweHiNEVMNd
	1EPYsHJXeu95O/DQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 x86@kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V5 12/31] entry: Inline
 irqentry_enter/exit_from/to_user_mode()
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:15 +0200 (CEST)

There is no point to have this as a function which just inlines
enter_from_user_mode(). The function call overhead is larger than the
function itself.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 include/linux/irq-entry-common.h |   13 +++++++++++--
 kernel/entry/common.c            |   13 -------------
 2 files changed, 11 insertions(+), 15 deletions(-)
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -278,7 +278,10 @@ static __always_inline void exit_to_user
  *
  * The function establishes state (lockdep, RCU (context tracking), tracing)
  */
-void irqentry_enter_from_user_mode(struct pt_regs *regs);
+static __always_inline void irqentry_enter_from_user_mode(struct pt_regs *regs)
+{
+	enter_from_user_mode(regs);
+}
 
 /**
  * irqentry_exit_to_user_mode - Interrupt exit work
@@ -293,7 +296,13 @@ void irqentry_enter_from_user_mode(struc
  * Interrupt exit is not invoking #1 which is the syscall specific one time
  * work.
  */
-void irqentry_exit_to_user_mode(struct pt_regs *regs);
+static __always_inline void irqentry_exit_to_user_mode(struct pt_regs *regs)
+{
+	instrumentation_begin();
+	exit_to_user_mode_prepare(regs);
+	instrumentation_end();
+	exit_to_user_mode();
+}
 
 #ifndef irqentry_state
 /**
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -62,19 +62,6 @@ void __weak arch_do_signal_or_restart(st
 	return ti_work;
 }
 
-noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
-{
-	enter_from_user_mode(regs);
-}
-
-noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
-{
-	instrumentation_begin();
-	exit_to_user_mode_prepare(regs);
-	instrumentation_end();
-	exit_to_user_mode();
-}
-
 noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 {
 	irqentry_state_t ret = {





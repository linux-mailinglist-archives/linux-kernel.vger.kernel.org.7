Return-Path: <linux-kernel+bounces-871099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B73C0C6E8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 057ED343DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFA130FC3F;
	Mon, 27 Oct 2025 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QusWIlPk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uHqxfnDV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A742F12AE
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554686; cv=none; b=AiX9t5gkvoOrcYIMdyZHrWIcnUNLVwJBYs+JM8oIaG9wDt/vZcPOUIbsh/HbEROWEZC8yCh11OHy177rojgl5lVRJqFs6HTfpeYGwd/ceCOPk5LVeyRlb/4EzgTWHqGWiiJK64uwzURwCToNxnTxDXmDj7TQT88zperKqqMlI9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554686; c=relaxed/simple;
	bh=nNcmc9NuBR5mKSpaY7pA17gsauTbI89Vg8sje15ed+M=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=DWEX8gSfkfTFdOrDKeKq3zWJKiJebcs/DqiU6EqYRqScqB2OjS4Nmp7f90JsB06h3elGzDKVoGHLYeAd2CBNZDt00QRfNxzQ8Sb80xUpTZqCEBNX+8WntVAajB3ca5zhdMeU2vA7Ui+2XxPMgqsTsH7d9khK9TGv2RkmIVAgsHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QusWIlPk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uHqxfnDV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084306.715309918@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=U9wZY6TfKM1n4wUTA4Xhxpku28PKV7TrzvWt6YuJk0w=;
	b=QusWIlPkq4ylmVy4EQTM1HUWvEtmaMiUKoe/OESrFqDOXz1qQmmqlIL+3o9eS0v29O/M/A
	kJ+vXT9dqklOaclas+qzfsAZZmE1x/nEVoZ9jH7u5grmrCnn41XdZlGkxPPXnUN8HqVDZZ
	4BQtau9zHwOM+KPglXrH1YLlwoUUdpodUzdaxu0GTw7VZ1ZGDphxjRlzu9+23QruRnyyl5
	t/1MUw8nJoM4uYA/grCbSbcFh2X0opSly2r0VuJH0GV/9roQ8N6ur/kbtb6CdJDmvLLcHe
	0UcuyvLVvenGISs75VmuZlk6577etOfscs9kSVZFwVtxQV6fuN8u+GAheHsKHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=U9wZY6TfKM1n4wUTA4Xhxpku28PKV7TrzvWt6YuJk0w=;
	b=uHqxfnDVV09FCFnQVoHbq+1KZfuVBxbE7mhChuPwsfGyzYB21KubpzvsUXQSfbnwssLl14
	UEDJsIZ2jR3KxnDg==
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
Subject: [patch V6 12/31] entry: Inline
 irqentry_enter/exit_from/to_user_mode()
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:44:40 +0100 (CET)

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





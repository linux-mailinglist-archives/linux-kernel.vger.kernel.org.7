Return-Path: <linux-kernel+bounces-783241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D974B32AEF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 052547ADB39
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682FE2ED165;
	Sat, 23 Aug 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0gCHuE4R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mY3IBPWP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555272ED15A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967178; cv=none; b=nMztt7Jr3TkPpz7t8dYpCMOTLT+mOJwKYW75C8G41WsdASWjmfjYwMunZRQ+h+rovNErOkSJxWnpel3hD19u2NgT/lfHGu+CTPyBd6Lg8xJeQRizjOywOXXrAeHWUlmlvvGo5yArElX6AJGkNvdQVorbOXOKoTSaef7Fk4xZQLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967178; c=relaxed/simple;
	bh=McxjK3YF4Tk0aC4xps1tzuK+1uuQYOoVjRa/x0Onvgk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=oi8k0WTP0r9gXULwIWTWx0zlCJ/uCf1vicfZXIAP7rmn6cQm+j5N80YWrXLSS3xo/tGik/xuzS+xCSlM2fLfA350iYkReLy4/ONYNU8tvC3dnjNdGbsnIcyWzHXjWAgzTbjXo4VYcdwzH0oxC5//W7cVOXnjwyeBp3W5ECnAfbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0gCHuE4R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mY3IBPWP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161654.038904706@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bXk/MLZ59A3tXGHauPbjPR/7KVfuJVMFZfmg9sxAdmE=;
	b=0gCHuE4RZRRREvcViajQ433BhvQ+p+oNSmPk2JaWLnCVf5pcWl9C0x5SToXS1w5T9v5tcF
	GhD18hqX/7+mikc3VU8zKav9rXFhv60UvfHZSZUeHK9g7arOKWxZyN7WEGA2T1Tb//KmEp
	4I56rdEmdRN6vSRVuOeyfEe9gvkFY3Hdkfvj+R3Teha/FZAm4F0GFPPimT0kPFTh57Rb1d
	PvliT2WK5+gopTnRtjiYbUxnnf/2KdXu3dR7Ty8WpTWfWikc145m8OchwmovzTfcLjaiqB
	8oS89R/fi/6/+5KpHTaLMFTOwEt27w2pd1QIsTORAqJUv6kLGZ8SCzz+ugudkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bXk/MLZ59A3tXGHauPbjPR/7KVfuJVMFZfmg9sxAdmE=;
	b=mY3IBPWPV5HkX56rM1yOw76MQoU2yjzCo56V53UnksfApNVPC9rAsRQhubiBqi0djzEvU9
	nVFVv2DdhWWoESAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [patch V2 12/37] entry: Inline
 irqentry_enter/exit_from/to_user_mode()
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:39:34 +0200 (CEST)

There is no point to have this as a function which just inlines
enter_from_user_mode(). The function call overhead is larger than the
function itself.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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



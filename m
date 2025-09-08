Return-Path: <linux-kernel+bounces-806801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82568B49C04
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CF94E20EC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7F72DFA5B;
	Mon,  8 Sep 2025 21:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fMVb+q6C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mGDxfKBV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40B72ECEAC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367114; cv=none; b=K/WBx6mRm9VgtW6ET8nhwG6AkwuEss1jIE77D9FiYYypzyTMiAAO9SLutHdTluHEqml6sFaQmoTZn9uuu/gjO61pvJk7pwOq8s045wQE5mSnmYN7O/eycnAv1+NRD0257s5jQD+y2WXgvIQK3rBcMYeM+fNF+mrgyTz2y52KGFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367114; c=relaxed/simple;
	bh=Loo+QyTLvpbhAvoJw1X39qPC32dcIwIgIxYPNSDRy74=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=W8acCHlLOm23Ut6zti2/hQgBsDOTesiYz2fWuniZduFPbgUQeJJ8BS8io+Zl/EyrxE3DNU2JH61HO74va5A5ZFqlN5YWNJ35HNDRJaDLfO2JWy9uJoeTKdzrY/SBGsKSpoIqzOwffpeftlVJx3w0P1XgbHTeoYuvafjyAHzu1o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fMVb+q6C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mGDxfKBV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212926.033244852@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xw2VQOj98q2ZP2ahwrRJcBJbM4GIN6znV47kBHB68HM=;
	b=fMVb+q6CBX7e4degEvva1mwmmZ6A3UfwNVFRMZbHXLWDp8XjJq5HU1OtWcaI9luxMUq4Vb
	eXLGOk+zZGUdjLDCphE/9LacnnI+VYzvxGouVJeLrynZe+yHCmr+pNZuhyZTUZAZnzyxLK
	w2jWwF0NKSR+fcJKGoC/MieGisb/Sf1dgwRN+Z/lTKWjzpt98DiIaW+EI7gcZWSlaZt3nK
	PyVJqxH932RUzz4E87H+ARAnII0mJWG04kSVQ6JD4ObZZFFGNli6kT8CAYPnxY1agsZ+Dk
	fS27eUfTlr1p1wS49WsNR3lNIrAPqqSZZQ8r/WolrvOp2YoI8R+njacBUjE6Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xw2VQOj98q2ZP2ahwrRJcBJbM4GIN6znV47kBHB68HM=;
	b=mGDxfKBVeT28PST1NxLsSN2cwBsbNrEjhhlq0KgCiZfJ2dyNwgy1FMeHMv5S8zlhKa54Bn
	fAbUiBBvp+tKTIAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
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
Subject: [patch V4 12/36] entry: Inline
 irqentry_enter/exit_from/to_user_mode()
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:31:49 +0200 (CEST)

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




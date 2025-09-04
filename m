Return-Path: <linux-kernel+bounces-801748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF82B4497D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4FD47A383C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C3A2F656D;
	Thu,  4 Sep 2025 22:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lTjEklPI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="myIF8++6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB712F546C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024460; cv=none; b=tRLbRqa4NZUAg+vcsOi7+0RHm5zYvVeEN8jfDOVmx7hZYvoGqqW2fovnLeaI1rZ4XvIN5ZQGoGoYl2iCMrADDmBUdfuMMJ7ra+8pLtt9W9C03+7Y7zF+OgpLSS3k9KbKnGCB77lGqKKwzwIM0pqeaMJqnd4rPHlS5f8Gm+lf0ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024460; c=relaxed/simple;
	bh=Loo+QyTLvpbhAvoJw1X39qPC32dcIwIgIxYPNSDRy74=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=HCerOqyBQkKkRIi8WGkCtOOf7PPSgLk8Ud3ruGPzkuu6YcYFUko4gaAytSVf6eB+Dq1Mn3ChXYaN8lseLlVAHvFqX+31SSRJ71pBzlEMjeiQSoEMFY5QJ25DWai9FE9DnoUI5Jm+oUc9ofORtoX9qmaXvBHf/Wm+oRlsVP/6N7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lTjEklPI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=myIF8++6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185719.900324235@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xw2VQOj98q2ZP2ahwrRJcBJbM4GIN6znV47kBHB68HM=;
	b=lTjEklPIzInvHd4JR+5yoXChkJGDH3lBNnM6gx9PJD8YVU4p7P4w13cQkek/nV8eZry8/w
	HIHeGWW1ssKpi/7f7noTHg6oD9U0A1QSktiyfh9ZrVOAEY44Znk2JwtOkCJIyT4NjHeFsZ
	c9bpAtF9TLtYDkBm2wNfJ7DbrrKv73G+IfZznd07Swv9bZQp3WFTpyGPWopjIhnxG3QcNy
	47N3gecBx1e0//bmukZ5H/wd50s0A4Mz7oLzizjA7zKGUwKhcF0x0smjH0BXf5sjrdNqfd
	gDnzS8npvs55KMT5doEBB3Si6P+jxhb70RHLizBDw/jbEs5qKuoAUHevKs9Sdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xw2VQOj98q2ZP2ahwrRJcBJbM4GIN6znV47kBHB68HM=;
	b=myIF8++6pdtj40f+2+HS4Nr5qaClEWEJ9RkpwrjtmmhmVeovrIN3fi1EbgznuLwSFV0JCw
	HsZIAEVP0arUSRCw==
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
Subject: [patch V3 12/37] entry: Inline
 irqentry_enter/exit_from/to_user_mode()
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:20:56 +0200 (CEST)

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




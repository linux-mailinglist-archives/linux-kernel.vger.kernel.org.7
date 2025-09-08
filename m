Return-Path: <linux-kernel+bounces-806793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3055CB49BFA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E608217EFCA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392662E0B42;
	Mon,  8 Sep 2025 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W+4n2j6Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sfcPgZNC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC651F4191
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367096; cv=none; b=HTRAqtIl872Wy+z9YaZrlySXZajNkdnEKFqsfD0y//WLzreqnx6BP5NtYb+xQSSAFdWZkFSv13htCwUGq9z/3apl8kKaGu9sTXWK3xTyCzb7voENm7J2XHJPJ9vPjO6cKeMlCXj3vpgieDdS+eTWfSSw9Vk4cybjPBI8zntTgQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367096; c=relaxed/simple;
	bh=ihiXdyQCQvh7oPi+69HBcHiCAt+KicxU0b2ElR0byyw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=M57GX09fxUVndvAwmSJnKtQGExLWxsYHMwKpyW9J3T9rj5/WEhhk5acNn2E/Xf8AUt5EZowzRSA961xaxEBlyeyQoC7m4kAcmlONOyoBZUntaP52iM0RgjbIIfnJgwSTIfIMSgSEjV/GY7mpkOjZnKMcHMj+fTe2ScFWYo/VJd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W+4n2j6Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sfcPgZNC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212925.516786362@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RfSSA4MHqIXwEYvfeMknGpP/TwXAyIgsCKYnISMLCNA=;
	b=W+4n2j6QeepPUvJ9Md+c22yvZ0BMN6Ieefd0wspEWo0Iqrc7q1uDB7kXyEaJtk1N+z4qpc
	OCb9lDHz9Pzwra/mB6nRIRatyHsxuFfbN5VjQuv2+JV0LnOeJsOl/X1XwDNpy0rifuQCpQ
	7cQA42O7jL59Sd32CG/WiTcdMjey1qK88aZrAJGoai79CNkoS6atHVhlSLcXjDGVrX0VpG
	M/9Niu8Tk97n3rsMGlw6qRf6rjA+5Zk9qBNVF7iCvoUqrPcZn4T5ZdBDgT4Nwtn19PURBq
	wnEYz73Em8lcYKqhocWKb538/EOLOZgahvBez+ioEUgK/sBL6x9Dzjj961hipA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RfSSA4MHqIXwEYvfeMknGpP/TwXAyIgsCKYnISMLCNA=;
	b=sfcPgZNCOSasne3uU9vEfB53Zh7Ta9beUCfqwcQpvWf3LJA1INnyU1TR3DeBAbRiv1ORH4
	eYUAu7xf7FLKM4Cw==
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
Subject: [patch V4 04/36] rseq: Remove the ksig argument from
 rseq_handle_notify_resume()
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:31:32 +0200 (CEST)

There is no point for this being visible in the resume_to_user_mode()
handling.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 include/linux/resume_user_mode.h |    2 +-
 include/linux/rseq.h             |   13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

--- a/include/linux/resume_user_mode.h
+++ b/include/linux/resume_user_mode.h
@@ -59,7 +59,7 @@ static inline void resume_user_mode_work
 	mem_cgroup_handle_over_high(GFP_KERNEL);
 	blkcg_maybe_throttle_current();
 
-	rseq_handle_notify_resume(NULL, regs);
+	rseq_handle_notify_resume(regs);
 }
 
 #endif /* LINUX_RESUME_USER_MODE_H */
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -37,19 +37,20 @@ static inline void rseq_set_notify_resum
 
 void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
 
-static inline void rseq_handle_notify_resume(struct ksignal *ksig,
-					     struct pt_regs *regs)
+static inline void rseq_handle_notify_resume(struct pt_regs *regs)
 {
 	if (current->rseq)
-		__rseq_handle_notify_resume(ksig, regs);
+		__rseq_handle_notify_resume(NULL, regs);
 }
 
 static inline void rseq_signal_deliver(struct ksignal *ksig,
 				       struct pt_regs *regs)
 {
-	scoped_guard(RSEQ_EVENT_GUARD)
-		__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
-	rseq_handle_notify_resume(ksig, regs);
+	if (current->rseq) {
+		scoped_guard(RSEQ_EVENT_GUARD)
+			__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
+		__rseq_handle_notify_resume(ksig, regs);
+	}
 }
 
 /* rseq_preempt() requires preemption to be disabled. */





Return-Path: <linux-kernel+bounces-801740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC760B44974
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBC6189BDAA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5842EBDCA;
	Thu,  4 Sep 2025 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i3a9VpY1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mEA6+D+s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1774B2EB872
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024446; cv=none; b=HM561POt48d7Jjeyjo2FgFcMuSNkZ4buZLQqikXh974DzaYmvxjFuSPK80fBUQUxDi1FOArdiwFrcvb1GTJXfppWIA7eCe/fejUI0edvwCRxhV7OIjh78WW4J0+WHz5pqs5MaRyax+91vGJAlVVwl4G0zFgkc8l4Hp/WZhyCp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024446; c=relaxed/simple;
	bh=ihiXdyQCQvh7oPi+69HBcHiCAt+KicxU0b2ElR0byyw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=T2ZER7pOijIRk4uPBdwK0Nia8yhoSCnqpUY/ibLrNVOtF6WF6iNdS3BWj1mfyDY4s14tTD94lb7pi9x8BQH18km4Z3ugoL6N+NxVRanVcMgkSCzQJIl+Ss1lA0QdaAAgaPMxqv0ik21LpSxTPacqUjdbIxffmehCjopHOgBUtHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i3a9VpY1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mEA6+D+s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185719.390140190@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RfSSA4MHqIXwEYvfeMknGpP/TwXAyIgsCKYnISMLCNA=;
	b=i3a9VpY1Cyu0IeHTnJu9rScLzPwunQ1CYvpyiKsb29faEnDyOtvfsntHzjyHX/m5Xd6VqS
	I8DySQZ1N3g5rsRazRZV4KYzE1ZCmkeUkpQyNWN9fhdvm0d31n/SZNXmAgjNCD4WUt1UIE
	hW3YQQxXHAzyDH53BJvq8egRa2f16SBRdfu2eWX/GVCQqfpcDbYTScfr0m54IUad2WMIQN
	gvqFT/HdY+bdcE9bH+HPoq8/JYu4+tw7VL5GyQ3fwkvY7tziOM1J1b8xJ1NUdmVpmLYn8o
	0jpYb3vxtElHH7ysf6HpT1Nd0e8c0dBbhoN6vB66nSzivBJKO7ROlHa6pHprqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RfSSA4MHqIXwEYvfeMknGpP/TwXAyIgsCKYnISMLCNA=;
	b=mEA6+D+sSd6lIXZLh3MpwHxdOTX42NxFnSxAmXSH8gzVxeVVqg2bksyqbHsAr/GHSyCwHS
	n3/3apwTNIZvfQCg==
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
Subject: [patch V3 04/37] rseq: Remove the ksig argument from
 rseq_handle_notify_resume()
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:20:41 +0200 (CEST)

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





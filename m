Return-Path: <linux-kernel+bounces-783234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24559B32AE9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E4C67ABF98
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9CC2EA46D;
	Sat, 23 Aug 2025 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AkjUuzlM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fd3FFgJY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AEE2580EE
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967162; cv=none; b=YrWd1xZtTMBVE/JjzFZp7aUeeDJzg5vo30a8ZKqv7tVaOBHSGDfUzrmC/5ED73YshzRqBOHjEVDeIxf5l3vY717NdWj1vSYcEqvmGK+Z268ycAcqQVMev/LpN2JIPjJ0zfd1+Dn0QcDyPq1P4hb/MaHMJyXdiX+4SlrvIbu6tlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967162; c=relaxed/simple;
	bh=rXN7Z9/AesfH6+Za0ocaGgdoax1B8BXrj0eYqRUhqZM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=mbS99C8I+WWy90NGa1tv3ByZ/gZ5gky7aObiyhwhIwPLBZSmjZHSPAOBI31Fd9NsitAUyleoZU+pBlbglrmDxuGHcpUxXCG7zyhdAW9LbgumGfsAmJDZ8DYjfYT9V0efsu5UVfipfPfGhrnsRFgb6fLj+qFwBAI/NMcqqb0YCIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AkjUuzlM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fd3FFgJY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161653.516925982@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Or+5diiw6i9tGuu8wO/QBs36bT0twehVD97jJCoFun0=;
	b=AkjUuzlMtu+sFgEaHdEHhoiAJtZ/KwAr7cUnu9n4Q3W/MC26XD/VVpDVC0Gk5nmeHwgQnH
	9S0tRwb7cd6CwBToTFSe0a7upiffo4QoAzJozfS+97QE4NIWU1crR1jsJ6/M25MS2TEOfH
	JXLPCrHsOgcQYElC65Dbkc1BxsHxpnuNirPaw7frSzmVPB4gv55FWAbdYs8MkxSV1dAGzL
	/o6cEXgX8Su71Xodh4VVZKRcSeTIesNlmidGOhY1tlcmarCfADDNHCpBo4Cb68o7mrlzcj
	fFZChzY3ioBcikjAzXhSZ2IP+CrWJLTMMy4RbDOHtg93S0x15BfdCRtpPvpRDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Or+5diiw6i9tGuu8wO/QBs36bT0twehVD97jJCoFun0=;
	b=fd3FFgJYityN9iMl5KoAwRn+LcfCXYPUE1I2x/riswXrZhKRNuiwF9PGRjFyEttq1RME6P
	kQTz2RoQOagE+xAQ==
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
Subject: [patch V2 04/37] rseq: Remove the ksig argument from
 rseq_handle_notify_resume()
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:39:14 +0200 (CEST)

There is no point for this being visible in the resume_to_user_mode()
handling.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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



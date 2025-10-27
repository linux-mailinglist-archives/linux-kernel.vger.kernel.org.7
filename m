Return-Path: <linux-kernel+bounces-871091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BC6C0C71B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B5E3A1EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A386130EF8E;
	Mon, 27 Oct 2025 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oVKibH/j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c5o2WPWv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AC730E0E7
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554666; cv=none; b=kLz/hl0mN5Jz/aqFJDIo6OLoWQ34w3UNhSOM//6IIwChevdjiMIplyKaEx4UWO6mYpVq13v7X2cOSw4cdbfeo3w5nm23Eadmd++wEEF+56sSAHWKJkSPKkMycZRx4YNFibbjG6TK4kXhPIIzHJzA6lmvOZcvmn/CwAjz/lGfOnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554666; c=relaxed/simple;
	bh=A1vRO+JC6wXvVRyZ6M6JYXziZGl5gDaaaQTk8Wtbe7w=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=OzwWTH5NH43E5MGozgGsGuUA50pk8hM7Ad511IlHyflE8y9bbkgxE7ta7NgBj6lWkwmhp331Q4Ud5AbB/V7ertMF5Ul3Vnb/UTq6BwcCH+TViEva/o/vmwqm0uJ7EGmioohE08MKQ2PbXNe2RWAZ9PYmeytRUTL5ekdf0BIRsng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oVKibH/j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c5o2WPWv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084306.211520245@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1gK10EHJk76APGnXrchUXEgYg86oZi63TuoER7ZkuNM=;
	b=oVKibH/jhCui5YorU+3u23kXJ0EZsEus5VItjqVFI27gyA47LlYyNq1iAfF68okA8AMTJA
	lFbKZIocmg6lxobu1A1jAfjd0gEHgdrKXIYpchrXige7lDE9a5c9mdmYm5TkdfjIMV9/mh
	7aswQEiMN8q2DDbRaT9WoXyQCQA/xl6ClkSjKvwDNl7KULIVzjuL9d2kauxvcvMDjbXQ+x
	NIy8VMcUOF1O0Hhi3EFabZCHdQjC7bsmicv9oLsTxjRm/Yxo0tox4696LukRHrfXRLDMyA
	I6wJUg6qwmxAznO99nByHIioS475CfOjK7IND7gv7MmT4UB9QAyNvvMZa/qMjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1gK10EHJk76APGnXrchUXEgYg86oZi63TuoER7ZkuNM=;
	b=c5o2WPWvI3ER9ksa/NUfP2tFixKLYoCTIhGA1X4TUpETwvi3P4OD6qaMX7oqlUzQP278TC
	LsHek3jJajXxxOCw==
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
Subject: [patch V6 04/31] rseq: Remove the ksig argument from
 rseq_handle_notify_resume()
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:44:22 +0100 (CET)

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






Return-Path: <linux-kernel+bounces-801757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4302B44989
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED00016D0AB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910B331158C;
	Thu,  4 Sep 2025 22:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FQhYrPS0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6+kbqhCJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF60301009
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024477; cv=none; b=ZfXMroK0QLvQCrm+M52jiE3letE5kvxbrXa+s3w1yC3raGBldcvaq/M/CNmd4R1SVGS10XfvQNricQq6sGYyT6EdO/WkCmlRl99wh/rz0InFtoP3Ma3uxGRP04xXhg2qvuQYe4kGB4e/NZxr4qSB3e1yYznIjHsFaNFaPv8mR5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024477; c=relaxed/simple;
	bh=kNYmSRU50YUAivixc6gv7PhCtu1rWHRdLhNs8c4aPHU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Gpp5WgPRrzM5Ro3tGJCXS0eknj5iVOW4vbYf75VK9VfeQjmWbElSp/oAzlKsOYTMx3Moph5suhTdcZAt+WxQlMAAlyVJ6eb49X4sXeu2gp/04lL/eF3RWepG+kEdvIdsS/TXCxJE3z06o2IavAGPEZ4NghxFYcQFzOh41wZQyaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FQhYrPS0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6+kbqhCJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185720.465343178@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=93xME4C2iVwuO0PKXV1UomsxAEhn+I0gsGktpnBAUc0=;
	b=FQhYrPS03dXE5hUFCykBgESAy4HS9rMUEHzDLP8YUXUMfW6gdZXYSPweVX7+HT+1PnnWl/
	VRJ481zNBgNR9618GDQoWLlZQrAwTLKTaGEPM6k5jTQ9y16QoXpW6HOEBEdFn1o+kzLryZ
	nDhasTEI0F4RDHNz3k5xltrnMe6jyiW7I5oP2EKusds+Gqi8M16IKz+9Q20PaL5dnoAnx2
	ysU9RK/ysc+B+XFX1e7wXBgesuZC+hiSpaIwISrjjPATOiRdbotLwLMa3ioE31GixwFhFd
	Dj08aIwZuHVFMnP7vIpReRHnOUC7yYTGwtXiEGasBP5mHBmyWb5fvl/J/FVIlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=93xME4C2iVwuO0PKXV1UomsxAEhn+I0gsGktpnBAUc0=;
	b=6+kbqhCJQAE3n/9RUrwG2dgRGh9y7UrDPfo4NWW1LCwcqrVL4LmIJ2U5uqNEfsOk3JZGGG
	6YR+inv0jlcf7WAw==
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
Subject: [patch V3 21/37] rseq: Make exit debugging static branch based
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:21:13 +0200 (CEST)

Disconnect it from the config switch and use the static debug branch. This
is a temporary measure for validating the rework. At the end this check
needs to be hidden behind lockdep as it has nothing to do with the other
debug infrastructure, which mainly aids user space debugging by enabling a
zoo of checks which terminate misbehaving tasks instead of letting them
keep the hard to diagnose pieces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 include/linux/rseq_entry.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -275,7 +275,7 @@ static __always_inline void rseq_exit_to
 
 	rseq_stat_inc(rseq_stats.exit);
 
-	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
+	if (static_branch_unlikely(&rseq_debug_enabled))
 		WARN_ON_ONCE(ev->sched_switch);
 
 	/*




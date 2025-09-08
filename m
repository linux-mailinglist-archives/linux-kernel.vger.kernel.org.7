Return-Path: <linux-kernel+bounces-806810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D60B49C0D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7DC97B1394
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCFB2DCC1A;
	Mon,  8 Sep 2025 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wPacL3cm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g512fLEQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B43164B0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367132; cv=none; b=l3yUHMtk2sVDuGuIDUrhv6BIlfZe3XjWKRIQRyRQ07hWcCA8yseRQpkjUfSY4j84MOelCsq0pK6qqUZZ5PGPGbtTF5dRXhXf/kOq09bWcu9Tn9jPwWDkjiubEp62g5hww4SFNeZnSzTgMqbGymDBdEhwAZt1FfaDq55oQodYt+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367132; c=relaxed/simple;
	bh=rItohp4Wb9omDATzVhLJy7ZYLjNPFTUd4YJ6L/Qf9LE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=QAn5mGI4nJW5Uy+A69lTYQYCIW09Qd6v6qoSMNiBwNY3396Jb6KJ/Q03/oPqyfEZKPzACuwJ9P7/WxZIoUTOWc2IO3xewz6xDToAGG7eahcFmmR7HmRTmnytBCoRjE1FmNKDY0+Dc7MeJqzmEzpl8sgBVa/Qk7J4yeHW85GW7R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wPacL3cm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g512fLEQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212926.610201307@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CfupfDAoGmTtXR5FZaniG4eYdWUXiawULslAxUWJxcw=;
	b=wPacL3cmJaLas3rB6Hf4YIgRxocXci+frWi439nuglWiuJmtAE6wLMumpXAv+Qnv913Zm3
	ns0UX086hV3aoC9Plv6QKlt6LM4P83ABev3sWubhu2a9O+KX0Xw7CS+zTag0LzwLv5cCpC
	iGW+MxEAo2qX9PpGD4JbirJo+VCNYAT6/Qooqw3yrCpbUvWwYwDRF//vQZ98qjYLmwf/vp
	jUKiRdjESb0NGyJyn2qs+LjFdKEp2EzYlWN5O0ki4PalKoOCD6BD6YpyMkI939J6kpWDu8
	E05FsAPLm830W1IuBNbdVQid3NpjsrIV17Z2fTwWRi3S7KChFCKAOadmP+T10w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CfupfDAoGmTtXR5FZaniG4eYdWUXiawULslAxUWJxcw=;
	b=g512fLEQ5q4UnYMxiDXXcWd7kXzHC/R/tzNYUzG9aHTHefX26pTJwpdsKgqEYYzqOzFfzE
	hNT3AOtD20+VCyCQ==
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
Subject: [patch V4 21/36] rseq: Make exit debugging static branch based
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:32:08 +0200 (CEST)

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
@@ -288,7 +288,7 @@ static __always_inline void rseq_exit_to
 
 	rseq_stat_inc(rseq_stats.exit);
 
-	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
+	if (static_branch_unlikely(&rseq_debug_enabled))
 		WARN_ON_ONCE(ev->sched_switch);
 
 	/*



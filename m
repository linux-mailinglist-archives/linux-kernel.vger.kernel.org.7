Return-Path: <linux-kernel+bounces-806794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 064A3B49BFB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03634E1B44
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F452E22BE;
	Mon,  8 Sep 2025 21:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AUSQexJG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M9yLzan3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB22C2E0930
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367098; cv=none; b=DOXXuLc/FVb8jPc9PEDFeZ8sTXbDJZoKJEPk6b/VvgXjDDmf+cC66+NMoiinb5I6m9OMIaMR3fuY41MkhXwvM3I6wQI058HVV+OXFJi+qNCTo5+BRVr0SKJ2SOJQUbnCDI0nxG1TIGgJXz/StQTlQZ6SqdTTwSUndawry1eum40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367098; c=relaxed/simple;
	bh=ilsWRIlTUDSO397wmVLey0NMCnh7abL9PKqWcoTcP8U=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=o5K0DaFHSWmOCt4BuIs1+DC7RORdbDzY0UAeMOqHk3WCCNlcyzBVGrJfxb53PjLzBW1eHq7Jst3R77T5ilJyH/gCXy9xuv+jFWZMzNNat608REm0j0WoTLcFDOE7FksGP7K+8fSwEBRM5w2W4/yJ8Q8Q6G3uWLu/JIjSm4zuFvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AUSQexJG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M9yLzan3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212925.580601763@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bIy1ehmj58WBraXODwjUxTQg3sClPka/a58Xjfls5JE=;
	b=AUSQexJGP96Ah0JxBk2uy7YwrzYgaKRXuiXZDB7N2lGKIzfBjyQa4xFSXAJt+iNPzgfJ8u
	a4IZWE5zWy92kGpQ48NVw5sed1Ma913msyBYtjQnh0N+nIBdbLDkIxWjWeQFqQMgT6Iffk
	nB1BG97q51xU4bSTYXNmO5KmFBdz+bGIA0RKEjGsBQHQf8HCllWsdzFq1zTmpzft/KT2kD
	CM+9vHUJcH2zoo8GTl/lBTOa0su0ys2QtmeCpaF6Bf57PAP9nB/6bvnu8dOMFW5LkpDBBN
	DN61kR/b5yVNP3aov1cIYAzS8f0hRyqwivBdrUMVTo0i2fQbSWCN0sR9Mw2Jtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bIy1ehmj58WBraXODwjUxTQg3sClPka/a58Xjfls5JE=;
	b=M9yLzan3PjBF32MlD6m8co7XqDRlr/hWuMvGyATGsDW9AQrJ3VfCOxrXLt507/EQQoHhLP
	sDBvXtpHtHZH1mCQ==
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
Subject: [patch V4 05/36] rseq: Simplify registration
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:31:34 +0200 (CEST)

There is no point to read the critical section element in the newly
registered user space RSEQ struct first in order to clear it.

Just clear it and be done with it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 kernel/rseq.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -492,11 +492,9 @@ void rseq_syscall(struct pt_regs *regs)
 /*
  * sys_rseq - setup restartable sequences for caller thread.
  */
-SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
-		int, flags, u32, sig)
+SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32, sig)
 {
 	int ret;
-	u64 rseq_cs;
 
 	if (flags & RSEQ_FLAG_UNREGISTER) {
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
@@ -557,11 +555,9 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 	 * avoid a potential segfault on return to user-space. The proper thing
 	 * to do would have been to fail the registration but this would break
 	 * older libcs that reuse the rseq area for new threads without
-	 * clearing the fields.
+	 * clearing the fields. Don't bother reading it, just reset it.
 	 */
-	if (rseq_get_rseq_cs_ptr_val(rseq, &rseq_cs))
-	        return -EFAULT;
-	if (rseq_cs && clear_rseq_cs(rseq))
+	if (put_user_masked_u64(0UL, &rseq->rseq_cs))
 		return -EFAULT;
 
 #ifdef CONFIG_DEBUG_RSEQ





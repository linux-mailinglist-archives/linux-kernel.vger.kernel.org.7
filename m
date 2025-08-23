Return-Path: <linux-kernel+bounces-783235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FC2B32AEA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D8B7AA9C3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1792C033C;
	Sat, 23 Aug 2025 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0fALuubN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DkFYUpu4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF9525C807
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967163; cv=none; b=jIzXK4OLyB2IvW1WR8NulED5nwyDDQxrfldH+pDIpEmcZ1j0g8+CxqC8fbiDIRuJyVWNkkj/bfq62TiUP/BqvaiHPG16FBOxYaEmSyRVhltsT00jj43RCqbD6ViBucEyxY5ipZa7j911SDEdvmqNuPkcQkGIFnR5Wi9sLXoGaG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967163; c=relaxed/simple;
	bh=vTJWIftlzUS6KOLWF7NYgAJL2AOBE+7TbvnS0fsCGRw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=u34DxsbWFHMI0T6A+/XVMADtdUK0cXoitZl2fsiRH2IJ+uV3zKuUR66HNUIGeCXGfucvhbtZsB+sSFbdretzJMZ2IeLv/smXNCM3gm0X6jFrfOjlyf+ItDvqLIrrhgF4Ar+6qr3PuWA0VmzTyzWu6W1RrrpC8MbEUD3mhNI4aLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0fALuubN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DkFYUpu4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161653.580926530@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HYnZPOxWRd8jkfi41zon+VDT5SBjHGx9ihBaem0vnNM=;
	b=0fALuubNu8QtNJevJehktDyEv2N3tZwCFxqH66UPekmm81B3hzTAGFiBZRnC9/T8FoPzSk
	U0Ve4eyfSSi6lpTVQGTEIbV8W48hUjZx43lf8SslY2NaAVS9WSr7Gdj9MGt1JW4MbpOUdx
	RtAPBCwHs4ac1XyxwG+WhB9f8nf7dlKtZenR8cye3tXx8qoKZOxo/5UIMKaSV2cgNMzDbY
	/bfeX3MQYlYl2qFPg4pbvohLs7E15G3AU60eodqhqPH3oRSb6k7SMWx7pmQgBan3+N0pHl
	glIrrvLhBSXWn6dmYXAzMgVlNJfVVJlb8y0tMbNQ1C2DCtqG48ktcX/G4EnsFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HYnZPOxWRd8jkfi41zon+VDT5SBjHGx9ihBaem0vnNM=;
	b=DkFYUpu4gAh/phExCwu714k43366vfz82bjUBT/O9uYCdhFJImN+NlA0prTC5uFOd8Uj4t
	6/SFK9pCqG9gPiBw==
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
Subject: [patch V2 05/37] rseq: Simplify registration
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:39:17 +0200 (CEST)

There is no point to read the critical section element in the newly
registered user space RSEQ struct first in order to clear it.

Just clear it and be done with it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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



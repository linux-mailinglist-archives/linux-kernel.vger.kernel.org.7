Return-Path: <linux-kernel+bounces-801741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 965BFB44976
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3035517EC38
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0972EC555;
	Thu,  4 Sep 2025 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I57FjL4t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2IgBcVgW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DD92EBB8C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024448; cv=none; b=ZNgYqtyAtWxt3lJUatxHYo0R5kNu/8Kcdd2nMFPJPyHRtGuVreDDhBAFvZp5Tnl+323zOwqDVwm18Vq7SoinT9QqSBR5044Pd190OcqY822HWdZcF+4bTZP+bN9vAbOkjz6K3kqw0h762XZKhcP7X0YSAWrvsPkKk7Wx3ZqA9zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024448; c=relaxed/simple;
	bh=ilsWRIlTUDSO397wmVLey0NMCnh7abL9PKqWcoTcP8U=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=L038pyGD//S7LfGsEFbpqSmFXyyFuktuO/Xv08wC1uF7xJz0R60cXZC4hwRbZKeIX7n3YRV2mTxT0MJFRaWFHiRlQ7mteFE6LeWT9OKddhhfQIv9Fi19ajx9PRp5L6es7dzrLQ9wkcPsezJhMGjWicFdBECD3UiY7Y4In/lFLmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I57FjL4t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2IgBcVgW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185719.454282511@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bIy1ehmj58WBraXODwjUxTQg3sClPka/a58Xjfls5JE=;
	b=I57FjL4tE8tN7emwtuiabDVMg4M6mQjScARNyhp4lfVHRZwddkctuugGt7l311OR0TEj5o
	683+cvpY8zfz5N6y4eleB4Stk9O37y1T1i2Itis8JpkC3dPhx+L1jfwiP342MmDJ7ww03u
	CmLxiTTRh8pb5eDDmEwoplO3HH+53gyHwkY+GIis2pupikN1J82w7vu+Mc4rYPDIP2scEq
	g5czqb59METF+D55foKvZhxl77ZMBa7MVBASl7oqLPoffYtr7hcaIgIrUzlUpivTg8zD5W
	yX3mxf+NHve5YGEnWSNaf+gmRCXcYfpIV5xPQ+yjR0ih7qGWIjjf+bDefpc1zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bIy1ehmj58WBraXODwjUxTQg3sClPka/a58Xjfls5JE=;
	b=2IgBcVgWamWZkHhSUTndfapaiZN6mHmRAkhSdr4SEgrvWo1MlrJEwORQfmFfvtOBb2ibgD
	95cQYPd9eXjQQrCg==
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
Subject: [patch V3 05/37] rseq: Simplify registration
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:20:43 +0200 (CEST)

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





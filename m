Return-Path: <linux-kernel+bounces-864970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 534F0BFBF8D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B87534FF723
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481E234A76F;
	Wed, 22 Oct 2025 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pMJNTRgp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XxSWPIqs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B533491C2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137533; cv=none; b=pYlyWFyRhIglWZsjcRBJy5ML3ehXaB4fIG0TZL91rzzmz/UpViLvvJjxzsWqEc8ru4YaehDRxm1ITKeUqX9l0BQv3tqLS+EPM4OH587R3ksdGHHWvRA6kRmEEk+soIbBBaL+9w/3naB3zJ+3I04FdlgHcgB4OZyXVApNxrUP1lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137533; c=relaxed/simple;
	bh=qy58vM+nY+BjQK+xrtw1SLFKhQ6e/JS7dfTLEMN1j00=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=uDFTA7d7PPf/cywbwug0hQnWAcMhfcKw7IrzQp2s+ynBocMMChxzw2eXNwZKzyu4aMCQor7yoS+DBKifPUFnpNTIglBXPoqGvzKwTwfZNxQJZs3R8Jam7By0wD85V1GQwl316zMcmsGmJ6SFMOBhA+fmN47XAyLDFF8pBgz+y04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pMJNTRgp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XxSWPIqs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121941.688065928@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QCSp39rY3Kb/sLl0RkVNht1m8WyhVaHdRitDN9VJ3QE=;
	b=pMJNTRgpUpMSvykWpaHJbJ+0D5nqZH7cjG9T0UCoL/dcNoCfp7IOy+LsoqDn4UyyYWGbqn
	bTiLz0MFMjMzHae9DYBAeM5gY/FNHDiFGZhLtRRLN4VUoeD8phZldnhlhBcP1OU1oUOkna
	j6dKkR4QDXsKKHNFHSY+9peEIa15PIkE1UaFK5RJfgwRiHs+3UfZtLW6WP7G6nu7TOxZBl
	hJgKBI+KJusM4uagxQIJDIfFWffPSVL1em74Pfbpu/7IiOtc4Qr+eEiiuGHXXe/7K8J2jh
	aTfS1m95/R0J72fMpke27GpSUaU2VjOCNiimFXyOtTuprKgqwZcsgjyB73CMgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QCSp39rY3Kb/sLl0RkVNht1m8WyhVaHdRitDN9VJ3QE=;
	b=XxSWPIqswrkN4/WCn7S1iKrIsvA8uCqJ7nKVymeB3ch+KZ3Q2/rPolLpE2Nk2GzsPrprj+
	yn1Rp1YgOSHQL1Dg==
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
Subject: [patch V5 05/31] rseq: Simplify registration
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:07 +0200 (CEST)

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
+	if (!put_user_scoped(0UL, &rseq->rseq_cs))
 		return -EFAULT;
 
 #ifdef CONFIG_DEBUG_RSEQ



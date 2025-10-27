Return-Path: <linux-kernel+bounces-871092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5487DC0C727
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4B53A4505
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A299F30F544;
	Mon, 27 Oct 2025 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nhwI5MhH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pXCI6MJ5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DB330EF7B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554668; cv=none; b=n+6MV4R4dfmeFi/bfJ31uVHrcXt0Vai6Sk8KfEB7rN/v6NJlHbIEehxpJ5/Mu9/ZkVHbel8ZE/QwlMWVudYXs8MrrpdmZaD/VH0JRJcUSw144rocY4o1vretCIqWE9INi4fPajyD0IlAfITXunt4wwZlh/BiO681h9A6EkC2xzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554668; c=relaxed/simple;
	bh=e3OJ4RiNIDe1v1kacOEr2FOq3U4L8U6FyFGNWvK7zdM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=VGMJKVBn7h5C5G5zU4/ly6XYKf+bkHfRALs/TIZR2AP9UTkT1ozv9SbnPuqTrS/YeWBkD0eBuOWdHxvC6J7V9SmSenDMjs2wmFXyrXJBDz1oa1Is9yeNSb4nJdzzYDZwQFOfpb8TrcYYx58fbfS+8ApYLlU+gZvQQJIsS1LZfNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nhwI5MhH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pXCI6MJ5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084306.274661227@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=M3IwPvLFzu7B9upSE/ixqLxD1KTuFCAN7ZgD7sx/C6U=;
	b=nhwI5MhHHLFyiVet+evYdAxiJFF5phIvNj86peMyGdm3YBvLh+3ElUsu17PaQXZnFy88Tb
	AIJ/zmBeiUmlf/6ScwpCcsOqyIc/vmhTOtXXLjaFgbf4Pny7UI0V+FG92HNyx0GyxJDiWh
	NZJeuwHQZmhD8ElxE75vRhaA5FyzwSoupQcbhCNjTaHWFvu/rtxPsCCels7JXS/Z3W5OE4
	Z0PSbgXxpqKeU42Q/hclj/rI1NCtvVYUHxpB4l7lpYgoIHlzggCaoxPmH/0khvc+xM3XxS
	lSv7hfk/1OEKtVTYhhtF7ugmGoy8g/Pkp9jaTOb1O7iiD1UVAlKVQhMI/Kgjkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=M3IwPvLFzu7B9upSE/ixqLxD1KTuFCAN7ZgD7sx/C6U=;
	b=pXCI6MJ58v9UHaHW9G+DOwVjnkxIV884GbrNoesLd2WIuiSX+xNjjRBDBuVsOwwflPXM0a
	tB6D1W70vANH4cDA==
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
Subject: [patch V6 05/31] rseq: Simplify registration
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:44:24 +0100 (CET)

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
+	if (put_user(0UL, &rseq->rseq_cs))
 		return -EFAULT;
 
 #ifdef CONFIG_DEBUG_RSEQ



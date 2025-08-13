Return-Path: <linux-kernel+bounces-767159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0998B24FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28794725EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07F129B239;
	Wed, 13 Aug 2025 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kJ6KVU5I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lIoljJvs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979F629AAE3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102585; cv=none; b=n0WGmnPSvr93+zlJBi3RhuWa3+XoF9xm4Wu+TQduV5PXQglj7wJdftyq7yVG5SIn8N2YVYENebU3SXCDkT+fMVX3GpjeuORq5TEC4/qq9EQ90OcX5sMAer+NHonodDwM4m1oyoR6QeY3gGep+y3rBM7U/L5zOPKZ+idP5bXh2iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102585; c=relaxed/simple;
	bh=cSSe48lgo94OmNsbAUAQqVvgKmEA2RWn8PLpW8TUuKQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=kSb7agjfDMiyNcwrqunF15/EPEZeQ1SHIZ/FRoDF30L4isjc5BHeaccxa45m22Mxa7QCXUQ398QFon9y3v8cos+Jx+ZGqD/qtjrHw08QxiJI+YhiESAe3U7YrkcfhO1wWB1OeBB/lrSZdxpgYaaiknBv6jEwZe+rwOCGsCG96c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kJ6KVU5I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lIoljJvs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250813162824.484590626@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755102581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=R8d6iV4UVddxDHLTJplt0kBT3CZago4jtYFo0SqhSyI=;
	b=kJ6KVU5INe/3BxYaK2ABxHcYVY2fCKRyc05uRFQbs8RtTuTT0d8Ex/GEN1XO44lq6D2Fo1
	xacUaC496K/oKFIIORFbnuehN0CGwfC9y6m/YmnVeMpnvS+h8PlPjHc98sHM0icMaQgaPO
	b2zZJvP1N2tKcaN24JqzNjTZp3RoaEIi9OV9zrCTNOuvfLiN5Hzn3UN7ZpXXQMqxo8XIq5
	r3/BsqUk7g5/rgAhrkXg0j+W2XLwGXLhlHVlflZ5RhDRq8feiBcJNpYCKZi9rxoNIdgHls
	0OfB2tX9FUxKD699h+ODDzClLfXnq2i3E+ZUc9a/JaK78fPe90vYJ12Ne3zu7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755102581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=R8d6iV4UVddxDHLTJplt0kBT3CZago4jtYFo0SqhSyI=;
	b=lIoljJvsNzkkBDbV0doyvQL3/cfNR47zDu10z733GDlbC1gYsOI/CqN/zlJRPaFm6M+bIJ
	94CqjKZB6x1HPiAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Wei Liu <wei.liu@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Subject: [patch 11/11] rseq: Convert to masked user access where applicable
References: <20250813155941.014821755@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 18:29:39 +0200 (CEST)

Masked user access optimizes the Spectre-V1 speculation barrier on
architectures which support it. As rseq_handle_notify_resume() is
frequently invoked, the access to the critical section pointer in the rseq
ABI is a hotpath, which is worth to optimize.

Replace also the clearing with the optimized version.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rseq.c |   23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -245,20 +245,9 @@ static int rseq_reset_rseq_cpu_node_id(s
 /*
  * Get the user-space pointer value stored in the 'rseq_cs' field.
  */
-static int rseq_get_rseq_cs_ptr_val(struct rseq __user *rseq, u64 *rseq_cs)
+static inline int rseq_get_rseq_cs_ptr_val(struct rseq __user *rseq, u64 *rseq_cs)
 {
-	if (!rseq_cs)
-		return -EFAULT;
-
-#ifdef CONFIG_64BIT
-	if (get_user(*rseq_cs, &rseq->rseq_cs))
-		return -EFAULT;
-#else
-	if (copy_from_user(rseq_cs, &rseq->rseq_cs, sizeof(*rseq_cs)))
-		return -EFAULT;
-#endif
-
-	return 0;
+	return get_user_masked_u64(rseq_cs, &rseq->rseq_cs);
 }
 
 /*
@@ -358,13 +347,7 @@ static int clear_rseq_cs(struct rseq __u
 	 *
 	 * Set rseq_cs to NULL.
 	 */
-#ifdef CONFIG_64BIT
-	return put_user(0UL, &rseq->rseq_cs);
-#else
-	if (clear_user(&rseq->rseq_cs, sizeof(rseq->rseq_cs)))
-		return -EFAULT;
-	return 0;
-#endif
+	return put_user_masked_u64(0UL, &rseq->rseq_cs);
 }
 
 /*



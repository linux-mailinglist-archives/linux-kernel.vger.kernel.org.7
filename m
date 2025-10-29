Return-Path: <linux-kernel+bounces-876116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0322C1B1AA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034D464117A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA653446BC;
	Wed, 29 Oct 2025 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pVFLiyVp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+eNE0K/P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C533F384
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743353; cv=none; b=KiEuL7NyiMbP5AdlIPFrlIUZV4Nfi9LZGK1Ym5KItpId/2+9QwwP3XJl0k66vSdvhC/LXNhrAxCrP3FkUBHsboUkiEUySe4WrWr4T57taEtVZmzk4BdrfsRzeZ25eoasetSENRd84ibUd9bYTgw78/tm1q8VxdpiaDG9UdGJiOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743353; c=relaxed/simple;
	bh=TldL7Db1J/HaEX++FVXGtQ+JtGKYs0HViJN+biox+Ug=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Q+UKw3RpInTYV2+Knve+NrRIe7GqLoBS6PxIKdaAz+Do60vDfS7VYKCJ2ymWcWBA4qgtPLKc6AXtjVJG9H/DYDaYuuk0PbliAVsZ80wXOJnvzeVdg+59CmXrjFrZHEfTB95mlznY03lWDk3ZFO1pHIVGVtJd3u7hsoIbUvGnQfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pVFLiyVp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+eNE0K/P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029124515.717519165@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761743347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mm1ssWuK6jNAmDTlM3vCwu4rXAH21gvCFv0vnZH2Au0=;
	b=pVFLiyVpPRMHZuhnRvh4w8DFUIG6m6xJzwcVskM/Z7JZ/dnwHtCbC3fB1T0ZIHWcQ8EEIg
	VM+Rk4WVEXnl/M1X7/IfJPo+GYCbyhmw3jD9WirNlalYo8nFd8t7FkYQfkclcs8qJNW5SL
	vvTyqYN11WgVEWuIUsFmiDlorZfGp3kU8OjlAy22/4UC0Ggng0vBiR2yPCwFbisGSdXG4+
	LXgb6RfPX1yeL46fPXmQhmr7Mrs9HAp8xHmk6KrzkKJ95jKc0Qe+uXDC8A9Jqutz3qKLfH
	edYpW4vsT9lA4xWaQCASaRUtIQozR9YBa4xG6GOCEM3SMiEmukC9zU0zNZr7vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761743347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mm1ssWuK6jNAmDTlM3vCwu4rXAH21gvCFv0vnZH2Au0=;
	b=+eNE0K/PyCA9ZLtGx/nZOiXci8D5S2lShN9xD5EC16+Wn7BrUSTncSVhOpX9B4uHk56MwC
	UtMTQg4oWfBDSiDw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>,
 Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [patch V3 07/20] cpumask: Introduce cpumask_weighted_or()
References: <20251029123717.886619142@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:09:07 +0100 (CET)

CID management OR's two cpumasks and then calculates the weight on the
result. That's inefficient as that has to walk the same stuff twice. As
this is done with runqueue lock held, there is a real benefit of speeding
this up. Depending on the system this results in 10-20% less cycles spent
with runqueue lock held for a 4K cpumask.

Provide cpumask_weighted_or() and the corresponding bitmap functions which
return the weight of the OR result right away.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
V3: Rename again - Yury
V2: Rename and use the BITMAP_WEIGHT() macro - Yury
---
 include/linux/bitmap.h  |   15 +++++++++++++++
 include/linux/cpumask.h |   16 ++++++++++++++++
 lib/bitmap.c            |    6 ++++++
 3 files changed, 37 insertions(+)

--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -45,6 +45,7 @@ struct device;
  *  bitmap_copy(dst, src, nbits)                *dst = *src
  *  bitmap_and(dst, src1, src2, nbits)          *dst = *src1 & *src2
  *  bitmap_or(dst, src1, src2, nbits)           *dst = *src1 | *src2
+ *  bitmap_weighted_or(dst, src1, src2, nbits)	*dst = *src1 | *src2. Returns Hamming Weight of dst
  *  bitmap_xor(dst, src1, src2, nbits)          *dst = *src1 ^ *src2
  *  bitmap_andnot(dst, src1, src2, nbits)       *dst = *src1 & ~(*src2)
  *  bitmap_complement(dst, src, nbits)          *dst = ~(*src)
@@ -165,6 +166,8 @@ bool __bitmap_and(unsigned long *dst, co
 		 const unsigned long *bitmap2, unsigned int nbits);
 void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int nbits);
+unsigned int __bitmap_weighted_or(unsigned long *dst, const unsigned long *bitmap1,
+				  const unsigned long *bitmap2, unsigned int nbits);
 void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
 		  const unsigned long *bitmap2, unsigned int nbits);
 bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
@@ -338,6 +341,18 @@ void bitmap_or(unsigned long *dst, const
 }
 
 static __always_inline
+unsigned int bitmap_weighted_or(unsigned long *dst, const unsigned long *src1,
+				const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits)) {
+		*dst = *src1 | *src2;
+		return hweight_long(*dst & BITMAP_LAST_WORD_MASK(nbits));
+	} else {
+		return __bitmap_weighted_or(dst, src1, src2, nbits);
+	}
+}
+
+static __always_inline
 void bitmap_xor(unsigned long *dst, const unsigned long *src1,
 		const unsigned long *src2, unsigned int nbits)
 {
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -729,6 +729,22 @@ void cpumask_or(struct cpumask *dstp, co
 }
 
 /**
+ * cpumask_weighted_or - *dstp = *src1p | *src2p and return the weight of the result
+ * @dstp: the cpumask result
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Return: The number of bits set in the resulting cpumask @dstp
+ */
+static __always_inline
+unsigned int cpumask_weighted_or(struct cpumask *dstp, const struct cpumask *src1p,
+				 const struct cpumask *src2p)
+{
+	return bitmap_weighted_or(cpumask_bits(dstp), cpumask_bits(src1p),
+				  cpumask_bits(src2p), small_cpumask_bits);
+}
+
+/**
  * cpumask_xor - *dstp = *src1p ^ *src2p
  * @dstp: the cpumask result
  * @src1p: the first input
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -355,6 +355,12 @@ unsigned int __bitmap_weight_andnot(cons
 }
 EXPORT_SYMBOL(__bitmap_weight_andnot);
 
+unsigned int __bitmap_weighted_or(unsigned long *dst, const unsigned long *bitmap1,
+				  const unsigned long *bitmap2, unsigned int bits)
+{
+	return BITMAP_WEIGHT(({dst[idx] = bitmap1[idx] | bitmap2[idx]; dst[idx]; }), bits);
+}
+
 void __bitmap_set(unsigned long *map, unsigned int start, int len)
 {
 	unsigned long *p = map + BIT_WORD(start);



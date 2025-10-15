Return-Path: <linux-kernel+bounces-854973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 921A5BDFDDE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD61F1A2309C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D388C341661;
	Wed, 15 Oct 2025 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4PYXNKF0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LHaZu2bF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE9833CEB1
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549381; cv=none; b=cNEkaWfp1rAshi2Pe6Opqh710KMj8WpXlc93VEkqaXVY15tT27c68f18yhod2PLOgqWHm8YcYmuVMpIKiz+I38+YO9VzOZ2fM0MVIf9CzYJ4UdPkjtfST6CwjaOq3+uUhRs+rmD+/KYxrBcQ2vNDeWZEop68L2/Ph9HVPBCo2LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549381; c=relaxed/simple;
	bh=3o3PKrl0qbbK1n7C9MNgQWn1awkfE6SwIZ71lmiq0xA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=VccOlsYr2C0cA6kVL1zVzBLI2AOdgEdj9jKT7pJXKDIgVL2yabb5r9Q08Md5OCCZQxPHEZLskQTRGMc2SKO/5zhT0HPJ4uMOzTna0/ftlxQKx/l7f4bThMZkiYlKXayBNgBqRXk+DNfm+qrB+dTNOLrBe0jYNdxIgJzjfXecVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4PYXNKF0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LHaZu2bF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251015172834.757776587@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760549377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=9gNMHN79jDZMeM2Dx/h4kedzc9Grels48SIn/1YFPyw=;
	b=4PYXNKF0hemvrKt5eLeD/ADcxpl2cSE0BQ6uGxfjgJm9eKzclkg72DkxJR0De5occ1URLH
	aK4h+UAyAmFd9fSZS4U54vaSFdQzSA6aWSCA1UORPftISPkSUq+MQEJJFqPaEKTyXy6XS3
	PdtZQ0y0qMZ+W/MuQioFE+0VgHVAF6KQDenFJeF4EeG+5hpMcPsAt4mzDOOyfacyNlv9cZ
	Z062c9wYRkUViDpnIpO+hq2o8xjxQv9/9raXoJN0nfAwR1iARd7J2Dyi+EaK8VI3B6c0y0
	BI+ishh5nIP7qumpVziXz5Iqr9lifGZhH1n6gkO9QmIPeIcLoUO64DIEIlpBtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760549377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=9gNMHN79jDZMeM2Dx/h4kedzc9Grels48SIn/1YFPyw=;
	b=LHaZu2bFXlmmcSSfPUZ1Llf/Bmfv7mZickml05TSSWfpHPi0/qbGr483cwq9NuAz3jBISH
	jX3QbqD+7Bnk7SDg==
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
 TCMalloc Team <tcmalloc-eng@google.com>,
 Yury Norov <yury.norov@gmail.com>
Subject: [patch 07/19] cpumask: Introduce cpumask_or_weight()
References: <20251015164952.694882104@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 19:29:36 +0200 (CEST)

CID management OR's two cpumasks and then calculates the weight on the
result. That's inefficient as that has to walk the same stuff twice. As
this is done with runqueue lock held, there is a real benefit of speeding
this up.

Provide cpumask_or_weight() and the corresponding bitmap functions which
return the weight of the OR result right away.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h  |   15 +++++++++++++++
 include/linux/cpumask.h |   16 ++++++++++++++++
 lib/bitmap.c            |   17 +++++++++++++++++
 3 files changed, 48 insertions(+)

--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -45,6 +45,7 @@ struct device;
  *  bitmap_copy(dst, src, nbits)                *dst = *src
  *  bitmap_and(dst, src1, src2, nbits)          *dst = *src1 & *src2
  *  bitmap_or(dst, src1, src2, nbits)           *dst = *src1 | *src2
+ *  bitmap_or_weight(dst, src1, src2, nbits)    *dst = *src1 | *src2. Returns Hamming Weight of dst
  *  bitmap_xor(dst, src1, src2, nbits)          *dst = *src1 ^ *src2
  *  bitmap_andnot(dst, src1, src2, nbits)       *dst = *src1 & ~(*src2)
  *  bitmap_complement(dst, src, nbits)          *dst = ~(*src)
@@ -165,6 +166,8 @@ bool __bitmap_and(unsigned long *dst, co
 		 const unsigned long *bitmap2, unsigned int nbits);
 void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int nbits);
+unsigned int __bitmap_or_weight(unsigned long *dst, const unsigned long *bitmap1,
+				const unsigned long *bitmap2, unsigned int nbits);
 void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
 		  const unsigned long *bitmap2, unsigned int nbits);
 bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
@@ -338,6 +341,18 @@ void bitmap_or(unsigned long *dst, const
 }
 
 static __always_inline
+unsigned int bitmap_or_weight(unsigned long *dst, const unsigned long *src1,
+			      const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits)) {
+		*dst = *src1 | *src2;
+		return hweight_long(*dst & BITMAP_LAST_WORD_MASK(nbits));
+	} else {
+		return __bitmap_or_weight(dst, src1, src2, nbits);
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
+ * cpumask_or_weight - *dstp = *src1p | *src2p and return the weight of the result
+ * @dstp: the cpumask result
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Return: The number of bits set in the resulting cpumask @dstp
+ */
+static __always_inline
+unsigned int cpumask_or_weight(struct cpumask *dstp, const struct cpumask *src1p,
+			       const struct cpumask *src2p)
+{
+	return bitmap_or_weight(cpumask_bits(dstp), cpumask_bits(src1p),
+				cpumask_bits(src2p), small_cpumask_bits);
+}
+
+/**
  * cpumask_xor - *dstp = *src1p ^ *src2p
  * @dstp: the cpumask result
  * @src1p: the first input
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -253,6 +253,23 @@ void __bitmap_or(unsigned long *dst, con
 }
 EXPORT_SYMBOL(__bitmap_or);
 
+unsigned int __bitmap_or_weight(unsigned long *dst, const unsigned long *bitmap1,
+				const unsigned long *bitmap2, unsigned int bits)
+{
+	unsigned int k, w = 0;
+
+	for (k = 0; k < bits / BITS_PER_LONG; k++) {
+		dst[k] = bitmap1[k] | bitmap2[k];
+		w += hweight_long(dst[k]);
+	}
+
+	if (bits % BITS_PER_LONG) {
+		dst[k] = bitmap1[k] | bitmap2[k];
+		w += hweight_long(dst[k] & BITMAP_LAST_WORD_MASK(bits));
+	}
+	return w;
+}
+
 void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
 				const unsigned long *bitmap2, unsigned int bits)
 {



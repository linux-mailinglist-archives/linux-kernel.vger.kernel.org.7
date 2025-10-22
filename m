Return-Path: <linux-kernel+bounces-865007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E92BFC056
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44077560738
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF88D3491C5;
	Wed, 22 Oct 2025 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xYa3ThX7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FPj7AVO+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27605348478
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137732; cv=none; b=YsOyECTGqAHVzlJXFNSf5krBX1nO0SWSLJiRPeyHMS4/SvTcaichXRifcQQP4vYAFlXCr+hmEygEJqLMAD+8++5R3r/GYMRsauu4siE4vqyfG7VF133DCLSe2ND3mmP1JM+VGfo9hFC4Jb9/UNLuya5wp02XEsmDATEsj2qzpuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137732; c=relaxed/simple;
	bh=NTZoShsNR+J8kCww4ozphOKRjKRSG/mizxhEkOmTQqY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=oyOTkNzPS+cw3Uk04vT/MDKqa+Ry86Vj/4funcCdgWKQof4YWjJkusw9xMOgCGqtwFxCveST8yfx1ONACA1+lE3w+f+Z+Fu17GQ50SrwQ2iKF1Gw3EklTWp0Rw9DYclL4l5j/jjZQrS6iQ4cDEGGBQ36CRC7D0qcfRj1P67ipAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xYa3ThX7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FPj7AVO+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022110555.837390652@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=oz7OK/7UsoC++Ly7q5ByidN18zDSAyoZKN8IhdKbmR8=;
	b=xYa3ThX7XBSs2zmfA7DYAYaRJKzssA8N9v2xshE1bdAnLi1I2HeUiFeGkq+IDfhTYzeKvO
	1r4sj3MP4YUrcYf5R+zcwelz/aaX7hCFMet8IoY+8lPCk4n/2f56BwecFn+1xURA5c3Zof
	NoF7az8kvNnpduvWkzUSCNmWtlyYlPDX3ZKpR5ahY8zbndV+zXNAiYY05hpFlTOEcqPF9+
	WFyinyXrGRbd3DUjJZH0neWEOlWXGh2vLI1Nkh3MCZmp5iwq9hNKsIYUbGDzLvJfrYKOqu
	SOTaupxrzkHa+o7Zpf+7ecNuUNZJ0kqpPtkMxMEdJazy1pWuvmGZxaVRPsQBtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=oz7OK/7UsoC++Ly7q5ByidN18zDSAyoZKN8IhdKbmR8=;
	b=FPj7AVO+z/QnuZByhnpmUaw7rYFLvmwnhNgNoj/JiWdqcWLVMGxWIuYRZF95JCPs0PX6ZM
	tfD5qG7K3HIjqdBA==
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
 Yury Norov <yury.norov@gmail.com>
Subject: [patch V2 07/20] cpumask: Introduce cpumask_or_and_calc_weight()
References: <20251022104005.907410538@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:55:28 +0200 (CEST)

CID management OR's two cpumasks and then calculates the weight on the
result. That's inefficient as that has to walk the same stuff twice. As
this is done with runqueue lock held, there is a real benefit of speeding
this up. Depending on the system this results in 10-20% less cycles spent
with runqueue lock held for a 4K cpumask.

Provide cpumask_or_and_calc_weight() and the corresponding bitmap functions
which return the weight of the OR result right away.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Yury Norov <yury.norov@gmail.com>
---
V2: Rename and use the BITMAP_WEIGHT() macro - Yury
---
 include/linux/bitmap.h  |   16 ++++++++++++++++
 include/linux/cpumask.h |   16 ++++++++++++++++
 lib/bitmap.c            |    6 ++++++
 3 files changed, 38 insertions(+)

--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -45,6 +45,8 @@ struct device;
  *  bitmap_copy(dst, src, nbits)                *dst = *src
  *  bitmap_and(dst, src1, src2, nbits)          *dst = *src1 & *src2
  *  bitmap_or(dst, src1, src2, nbits)           *dst = *src1 | *src2
+ *  bitmap_or_and_calc_weight(dst, src1, src2, nbits)
+ *						*dst = *src1 | *src2. Returns Hamming Weight of dst
  *  bitmap_xor(dst, src1, src2, nbits)          *dst = *src1 ^ *src2
  *  bitmap_andnot(dst, src1, src2, nbits)       *dst = *src1 & ~(*src2)
  *  bitmap_complement(dst, src, nbits)          *dst = ~(*src)
@@ -165,6 +167,8 @@ bool __bitmap_and(unsigned long *dst, co
 		 const unsigned long *bitmap2, unsigned int nbits);
 void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int nbits);
+unsigned int __bitmap_or_and_calc_weight(unsigned long *dst, const unsigned long *bitmap1,
+					 const unsigned long *bitmap2, unsigned int nbits);
 void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
 		  const unsigned long *bitmap2, unsigned int nbits);
 bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
@@ -338,6 +342,18 @@ void bitmap_or(unsigned long *dst, const
 }
 
 static __always_inline
+unsigned int bitmap_or_and_calc_weight(unsigned long *dst, const unsigned long *src1,
+				       const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits)) {
+		*dst = *src1 | *src2;
+		return hweight_long(*dst & BITMAP_LAST_WORD_MASK(nbits));
+	} else {
+		return __bitmap_or_and_calc_weight(dst, src1, src2, nbits);
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
+ * cpumask_or_and_calc_weight - *dstp = *src1p | *src2p and return the weight of the result
+ * @dstp: the cpumask result
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Return: The number of bits set in the resulting cpumask @dstp
+ */
+static __always_inline
+unsigned int cpumask_or_and_calc_weight(struct cpumask *dstp, const struct cpumask *src1p,
+					const struct cpumask *src2p)
+{
+	return bitmap_or_and_calc_weight(cpumask_bits(dstp), cpumask_bits(src1p),
+					 cpumask_bits(src2p), small_cpumask_bits);
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
 
+unsigned int __bitmap_or_and_calc_weight(unsigned long *dst, const unsigned long *bitmap1,
+					 const unsigned long *bitmap2, unsigned int bits)
+{
+	return BITMAP_WEIGHT(({dst[idx] = bitmap1[idx] | bitmap2[idx]; dst[idx]; }), bits);
+}
+
 void __bitmap_set(unsigned long *map, unsigned int start, int len)
 {
 	unsigned long *p = map + BIT_WORD(start);



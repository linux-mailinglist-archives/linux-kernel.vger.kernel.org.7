Return-Path: <linux-kernel+bounces-777831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FDBB2DE4E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E34177A37
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA881F4174;
	Wed, 20 Aug 2025 13:45:13 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02944321F5D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697513; cv=none; b=Tm7p22MhzfZNierRXdskLiYiZ7RAq1KWHdwU9d86LHfQv/lWN6Or/5dHyQdjYFfuW6B1N1qsXKkJ2Nt6qC2kVBMpkTwiC8nyE1sXxM4DRnEgiKxcjwJoSo1PIP1xY+kGUMf/LW6GV2ItAPSOPzcWKAZzk0HyyL+kS3Tnyzh+RDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697513; c=relaxed/simple;
	bh=URO3yM+bou/dZBHqBIIdbeS/iZ0OKFhoqXQrWWr8jy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mJ3E4394MIYfiZNxeAqt4CE3oT2CaNTHPwlYjwRGgXyeihASugYCR6Crv56ZJ0dE1LdYD2nWIdzsIZYhH0E0vXKMOdmDsTCHsKP8nT/vn1CbqpMWRL6suUpDZB9L55zNJ8O9s2BRrQKZYyOJeDrKKj3Wc/O24tb1pQ0g3n0AIbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowABHN6tT0aVogOTBDQ--.24665S8;
	Wed, 20 Aug 2025 21:44:52 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Wed, 20 Aug 2025 21:44:50 +0800
Subject: [PATCH 6/6] riscv: cmpxchg: Convert to use_alternative_likely
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-riscv-altn-helper-wip-v1-6-c3c626c1f7e6@iscas.ac.cn>
References: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn>
In-Reply-To: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, Vivian Wang <uwu@dram.page>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowABHN6tT0aVogOTBDQ--.24665S8
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4UZry8tryfXFWfuFW5trb_yoW5ury5pF
	n3CwsrKFWvg343uF9Iy392g3W5t397Kr4qyr9IkF95XF13Krs5ZF1Yk3sa9ry8JFWxJwn8
	tFyYkr95WF1jqrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Use use_alternative_likely() to check for RISCV_ISA_EXT_ZAWRS, replacing
the use of asm goto with ALTERNATIVE.

The "likely" variant is used to match the behavior of the original
implementation using ALTERNATIVE("j %l[no_zawrs]", "nop", ...).

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 arch/riscv/include/asm/cmpxchg.h | 125 +++++++++++++++++++--------------------
 1 file changed, 61 insertions(+), 64 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 0b749e7102162477432f7cf9a34768fbdf2e8cc7..1ef6e9de5f6d2721d325fa07f2e636ebc951dc7e 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -370,74 +370,71 @@ static __always_inline void __cmpwait(volatile void *ptr,
 	u32 *__ptr32b;
 	ulong __s, __val, __mask;
 
-	asm goto(ALTERNATIVE("j %l[no_zawrs]", "nop",
-			     0, RISCV_ISA_EXT_ZAWRS, 1)
-		 : : : : no_zawrs);
-
-	switch (size) {
-	case 1:
-		__ptr32b = (u32 *)((ulong)(ptr) & ~0x3);
-		__s = ((ulong)(ptr) & 0x3) * BITS_PER_BYTE;
-		__val = val << __s;
-		__mask = 0xff << __s;
-
-		asm volatile(
-		"	lr.w	%0, %1\n"
-		"	and	%0, %0, %3\n"
-		"	xor	%0, %0, %2\n"
-		"	bnez	%0, 1f\n"
-			ZAWRS_WRS_NTO "\n"
-		"1:"
-		: "=&r" (tmp), "+A" (*(__ptr32b))
-		: "r" (__val), "r" (__mask)
-		: "memory");
-		break;
-	case 2:
-		__ptr32b = (u32 *)((ulong)(ptr) & ~0x3);
-		__s = ((ulong)(ptr) & 0x2) * BITS_PER_BYTE;
-		__val = val << __s;
-		__mask = 0xffff << __s;
-
-		asm volatile(
-		"	lr.w	%0, %1\n"
-		"	and	%0, %0, %3\n"
-		"	xor	%0, %0, %2\n"
-		"	bnez	%0, 1f\n"
-			ZAWRS_WRS_NTO "\n"
-		"1:"
-		: "=&r" (tmp), "+A" (*(__ptr32b))
-		: "r" (__val), "r" (__mask)
-		: "memory");
-		break;
-	case 4:
-		asm volatile(
-		"	lr.w	%0, %1\n"
-		"	xor	%0, %0, %2\n"
-		"	bnez	%0, 1f\n"
-			ZAWRS_WRS_NTO "\n"
-		"1:"
-		: "=&r" (tmp), "+A" (*(u32 *)ptr)
-		: "r" (val));
-		break;
+	if (use_alternative_likely(0, RISCV_ISA_EXT_ZAWRS)) {
+		switch (size) {
+		case 1:
+			__ptr32b = (u32 *)((ulong)(ptr) & ~0x3);
+			__s = ((ulong)(ptr) & 0x3) * BITS_PER_BYTE;
+			__val = val << __s;
+			__mask = 0xff << __s;
+
+			asm volatile(
+			"	lr.w	%0, %1\n"
+			"	and	%0, %0, %3\n"
+			"	xor	%0, %0, %2\n"
+			"	bnez	%0, 1f\n"
+				ZAWRS_WRS_NTO "\n"
+			"1:"
+			: "=&r" (tmp), "+A" (*(__ptr32b))
+			: "r" (__val), "r" (__mask)
+			: "memory");
+			break;
+		case 2:
+			__ptr32b = (u32 *)((ulong)(ptr) & ~0x3);
+			__s = ((ulong)(ptr) & 0x2) * BITS_PER_BYTE;
+			__val = val << __s;
+			__mask = 0xffff << __s;
+
+			asm volatile(
+			"	lr.w	%0, %1\n"
+			"	and	%0, %0, %3\n"
+			"	xor	%0, %0, %2\n"
+			"	bnez	%0, 1f\n"
+				ZAWRS_WRS_NTO "\n"
+			"1:"
+			: "=&r" (tmp), "+A" (*(__ptr32b))
+			: "r" (__val), "r" (__mask)
+			: "memory");
+			break;
+		case 4:
+			asm volatile(
+			"	lr.w	%0, %1\n"
+			"	xor	%0, %0, %2\n"
+			"	bnez	%0, 1f\n"
+				ZAWRS_WRS_NTO "\n"
+			"1:"
+			: "=&r" (tmp), "+A" (*(u32 *)ptr)
+			: "r" (val));
+			break;
 #if __riscv_xlen == 64
-	case 8:
-		asm volatile(
-		"	lr.d	%0, %1\n"
-		"	xor	%0, %0, %2\n"
-		"	bnez	%0, 1f\n"
-			ZAWRS_WRS_NTO "\n"
-		"1:"
-		: "=&r" (tmp), "+A" (*(u64 *)ptr)
-		: "r" (val));
-		break;
+		case 8:
+			asm volatile(
+			"	lr.d	%0, %1\n"
+			"	xor	%0, %0, %2\n"
+			"	bnez	%0, 1f\n"
+				ZAWRS_WRS_NTO "\n"
+			"1:"
+			: "=&r" (tmp), "+A" (*(u64 *)ptr)
+			: "r" (val));
+			break;
 #endif
-	default:
-		BUILD_BUG();
-	}
+		default:
+			BUILD_BUG();
+		}
 
-	return;
+		return;
+	}
 
-no_zawrs:
 	asm volatile(RISCV_PAUSE : : : "memory");
 }
 

-- 
2.50.1



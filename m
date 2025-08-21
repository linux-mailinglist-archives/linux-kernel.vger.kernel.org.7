Return-Path: <linux-kernel+bounces-779401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80149B2F3B2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62DA117C6BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE1F2EF676;
	Thu, 21 Aug 2025 09:16:48 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C99625BEFD
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767808; cv=none; b=JyMYdS+j+RA9YLrQkeXp/vZC6b0+60niccIgf229tkx9NyqhMQhwgaunctzKNFwckfxGvYnc1zPqz/roCJwFlWAPJmN9Pe/UKkt7FPR5kV/3xfmM5cRyOd3JJlZqsPzWgnMS6/CkERfEw/Ypv9NqblWF++J2q1xRi8GVjbeAH78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767808; c=relaxed/simple;
	bh=RzVMbyfIw88o56ceYeW+D+aMoxm6XkUGsU3lztONo5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DavHzj7PxL11ZeRTxB8Enwjc3wxfghB9xaGzWkAGxYXBJglWkBDV8GCrj9IJgBPFdXGTgZPzjNtnUlZc6q9hueEOaKondHE/XSlUso7FJR+7qLm0jXfr/BZ8Pua5VYtQFN/cU9KVyuNY3kXN2wDVteVEShgKkrwKzdYbOSd4rsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowADXAqfv46ZovXADDg--.14435S6;
	Thu, 21 Aug 2025 17:16:32 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Thu, 21 Aug 2025 17:16:34 +0800
Subject: [PATCH v2 4/5] riscv: bitops: Use __riscv_has_extension_likely
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-riscv-altn-helper-wip-v2-4-9586fa702f78@iscas.ac.cn>
References: <20250821-riscv-altn-helper-wip-v2-0-9586fa702f78@iscas.ac.cn>
In-Reply-To: <20250821-riscv-altn-helper-wip-v2-0-9586fa702f78@iscas.ac.cn>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Charlie Jenkins <charlie@rivosinc.com>, 
 Xiao Wang <xiao.w.wang@intel.com>, 
 =?utf-8?q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, Vivian Wang <uwu@dram.page>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowADXAqfv46ZovXADDg--.14435S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW8Kw1DZrW3Wry8Wr4rXwb_yoW5Ww47pr
	n3K3sxKFWDta45uFy2yr1fXr45Z3y7J393GrWS9a4kJa4UA3ya9r909w1rAr1UAFWvga47
	ZrWUA3s3C3WUXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbPC7UUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Use __riscv_has_extension_likely() to check for RISCV_ISA_EXT_ZBB,
replacing the use of asm goto with ALTERNATIVE.

The "likely" variant is used to match the behavior of the original
implementation using ALTERNATIVE("j %l[legacy]", "nop", ...).

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 arch/riscv/include/asm/bitops.h | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index d59310f74c2ba70caeb7b9b0e9221882117583f5..f70ccc0c2ffb86a6fda3bc373504143d0c6a1093 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -47,9 +47,8 @@
 
 static __always_inline unsigned long variable__ffs(unsigned long word)
 {
-	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
-				      RISCV_ISA_EXT_ZBB, 1)
-			  : : : : legacy);
+	if (!__riscv_has_extension_likely(0, RISCV_ISA_EXT_ZBB))
+		return generic___ffs(word);
 
 	asm volatile (".option push\n"
 		      ".option arch,+zbb\n"
@@ -58,9 +57,6 @@ static __always_inline unsigned long variable__ffs(unsigned long word)
 		      : "=r" (word) : "r" (word) :);
 
 	return word;
-
-legacy:
-	return generic___ffs(word);
 }
 
 /**
@@ -76,9 +72,8 @@ static __always_inline unsigned long variable__ffs(unsigned long word)
 
 static __always_inline unsigned long variable__fls(unsigned long word)
 {
-	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
-				      RISCV_ISA_EXT_ZBB, 1)
-			  : : : : legacy);
+	if (!__riscv_has_extension_likely(0, RISCV_ISA_EXT_ZBB))
+		return generic___fls(word);
 
 	asm volatile (".option push\n"
 		      ".option arch,+zbb\n"
@@ -87,9 +82,6 @@ static __always_inline unsigned long variable__fls(unsigned long word)
 		      : "=r" (word) : "r" (word) :);
 
 	return BITS_PER_LONG - 1 - word;
-
-legacy:
-	return generic___fls(word);
 }
 
 /**
@@ -105,9 +97,8 @@ static __always_inline unsigned long variable__fls(unsigned long word)
 
 static __always_inline int variable_ffs(int x)
 {
-	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
-				      RISCV_ISA_EXT_ZBB, 1)
-			  : : : : legacy);
+	if (!__riscv_has_extension_likely(0, RISCV_ISA_EXT_ZBB))
+		return generic_ffs(x);
 
 	if (!x)
 		return 0;
@@ -119,9 +110,6 @@ static __always_inline int variable_ffs(int x)
 		      : "=r" (x) : "r" (x) :);
 
 	return x + 1;
-
-legacy:
-	return generic_ffs(x);
 }
 
 /**
@@ -137,9 +125,8 @@ static __always_inline int variable_ffs(int x)
 
 static __always_inline int variable_fls(unsigned int x)
 {
-	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
-				      RISCV_ISA_EXT_ZBB, 1)
-			  : : : : legacy);
+	if (!__riscv_has_extension_likely(0, RISCV_ISA_EXT_ZBB))
+		return generic_fls(x);
 
 	if (!x)
 		return 0;
@@ -151,9 +138,6 @@ static __always_inline int variable_fls(unsigned int x)
 		      : "=r" (x) : "r" (x) :);
 
 	return 32 - x;
-
-legacy:
-	return generic_fls(x);
 }
 
 /**

-- 
2.50.1



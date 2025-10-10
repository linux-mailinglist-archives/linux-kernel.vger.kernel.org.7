Return-Path: <linux-kernel+bounces-848887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7470BCEC23
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69CB93518B0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2904327FD71;
	Fri, 10 Oct 2025 23:36:54 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902A126D4FB
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760139413; cv=none; b=GdfdNTNJeuDsozpimyLHaG9bICO9A26Hs9a2LwiML51OF4jhNSgAEB55fErboCpdTvYIKNN8o7BIglJz/5XQLneWnoXG79nyor8YsLJBhNwHGcUb4FEKbxSqQYJbDiptta47Dm6Vf9bwAwLtohtvdIISFVjqvRHBST/RYL15ox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760139413; c=relaxed/simple;
	bh=ghgiJUgkRjxf6jV6m/wcwpQ2gdPxTctlj+mDuwjuOA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M7yUmO73NX5kxCOK6Sqwx5bUFNJzG1qWN8juuM6EUeNss1KZ/PWOkMvVB9uUpg/YZWOOlu6ikTXYd4OzA52vhPwLCDj+GC7/T9Z9+YkqbRaziWPY62rUzZERdkWN6VUGqs3eQZw1UoBTkaaWaBg8/TzZcKO7/9o2ulYTtzR/9JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.81.247])
	by APP-05 (Coremail) with SMTP id zQCowADHaxVUmOloXC2IDQ--.41211S6;
	Sat, 11 Oct 2025 07:35:49 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Sat, 11 Oct 2025 07:35:46 +0800
Subject: [PATCH v3 4/5] riscv: bitops: Use __riscv_has_extension_likely
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-riscv-altn-helper-wip-v3-4-d40ddaa1985a@iscas.ac.cn>
References: <20251011-riscv-altn-helper-wip-v3-0-d40ddaa1985a@iscas.ac.cn>
In-Reply-To: <20251011-riscv-altn-helper-wip-v3-0-d40ddaa1985a@iscas.ac.cn>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Paul Walmsley <pjw@kernel.org>
Cc: Charlie Jenkins <charlie@rivosinc.com>, 
 Xiao Wang <xiao.w.wang@intel.com>, 
 =?utf-8?q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, Vivian Wang <uwu@dram.page>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-CM-TRANSID:zQCowADHaxVUmOloXC2IDQ--.41211S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW8Kw18Kw4kWr15tr18Krg_yoW5Crykpr
	95K347JFWDta45uFZFyryfXr4ruw47G393GrWS93y8AFWUA39a9r90k3WFkr15AFWvga47
	Zr4UJ3s3W3W5Xw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
	1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j
	6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
	C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
	6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x0262
	8vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
	WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
	CTnIWIevJa73UjIFyTuYvjfUOyIUUUUUU
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
index 77880677b06e03875721f33515a6d2ac9166c373..d566747a341bb2e04a63eb5455656fd73585bc55 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -47,9 +47,8 @@
 
 static __always_inline __attribute_const__ unsigned long variable__ffs(unsigned long word)
 {
-	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
-				      RISCV_ISA_EXT_ZBB, 1)
-			  : : : : legacy);
+	if (!__riscv_has_extension_likely(0, RISCV_ISA_EXT_ZBB))
+		return generic___ffs(word);
 
 	asm volatile (".option push\n"
 		      ".option arch,+zbb\n"
@@ -58,9 +57,6 @@ static __always_inline __attribute_const__ unsigned long variable__ffs(unsigned
 		      : "=r" (word) : "r" (word) :);
 
 	return word;
-
-legacy:
-	return generic___ffs(word);
 }
 
 /**
@@ -76,9 +72,8 @@ static __always_inline __attribute_const__ unsigned long variable__ffs(unsigned
 
 static __always_inline __attribute_const__ unsigned long variable__fls(unsigned long word)
 {
-	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
-				      RISCV_ISA_EXT_ZBB, 1)
-			  : : : : legacy);
+	if (!__riscv_has_extension_likely(0, RISCV_ISA_EXT_ZBB))
+		return generic___fls(word);
 
 	asm volatile (".option push\n"
 		      ".option arch,+zbb\n"
@@ -87,9 +82,6 @@ static __always_inline __attribute_const__ unsigned long variable__fls(unsigned
 		      : "=r" (word) : "r" (word) :);
 
 	return BITS_PER_LONG - 1 - word;
-
-legacy:
-	return generic___fls(word);
 }
 
 /**
@@ -105,9 +97,8 @@ static __always_inline __attribute_const__ unsigned long variable__fls(unsigned
 
 static __always_inline __attribute_const__ int variable_ffs(int x)
 {
-	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
-				      RISCV_ISA_EXT_ZBB, 1)
-			  : : : : legacy);
+	if (!__riscv_has_extension_likely(0, RISCV_ISA_EXT_ZBB))
+		return generic_ffs(x);
 
 	if (!x)
 		return 0;
@@ -119,9 +110,6 @@ static __always_inline __attribute_const__ int variable_ffs(int x)
 		      : "=r" (x) : "r" (x) :);
 
 	return x + 1;
-
-legacy:
-	return generic_ffs(x);
 }
 
 /**
@@ -137,9 +125,8 @@ static __always_inline __attribute_const__ int variable_ffs(int x)
 
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



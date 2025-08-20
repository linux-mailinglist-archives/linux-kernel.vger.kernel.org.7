Return-Path: <linux-kernel+bounces-777832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4B9B2DE4A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85DFCA00F99
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29EF1F4CBF;
	Wed, 20 Aug 2025 13:45:13 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0289B321F5C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697513; cv=none; b=RW0GYDcTx8yD7+47y4PpKaXZSGntqZL5VIuLnGTjHPGLst1ziicO3fL8DwH1eUc3gzT+VQ7IBRGp/Wf836R0bEeeYQb8IO7KNBNqjq4dzod+gArqZSa0IduNlXUNI3WFahd+gXE6+Jsc+t6pgVpupEfCwMwstpUyisaIiydtc7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697513; c=relaxed/simple;
	bh=le57gNwHYQnmJmjrHAge3cBUX2EEkP4b/lkxD1Aej6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bhq/CKMKdhqdUfYJXdhCG4eZu+K2ZyteiqO6bAQXM6qptQypRkpMCXXvsEb+cb54MuhuLOlHlrRpJHBLnANKVUmtJpt7ICVeWEfboVUQ5/weW5PGc9qLVgmubTWfXTct0AwDHcz2iXOGu8DPEaLHGNEbswUFduZDqEdjEgcO31M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowABHN6tT0aVogOTBDQ--.24665S5;
	Wed, 20 Aug 2025 21:44:52 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Wed, 20 Aug 2025 21:44:47 +0800
Subject: [PATCH 3/6] riscv: checksum: Convert to use_alternative_likely
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-riscv-altn-helper-wip-v1-3-c3c626c1f7e6@iscas.ac.cn>
References: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn>
In-Reply-To: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, Vivian Wang <uwu@dram.page>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowABHN6tT0aVogOTBDQ--.24665S5
X-Coremail-Antispam: 1UD129KBjvJXoW3ArWrAF43ur1fWFyDWr17ZFb_yoW7XrWrpF
	s3trWrKFykCa4Sk34qyrZ8Wrn8Xw4kGwn8KrsxGry8AF90y3sxKr1DtF13Ary5XFyIqa4S
	yayfuw1a93W5AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUHWlkUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Use use_alternative_likely() to check for RISCV_ISA_EXT_ZBB, replacing
the use of asm goto with ALTERNATIVE.

The "likely" variant is used to match the behavior of the original
implementation using ALTERNATIVE("j %l[no_zbb]", "nop", ...).

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 arch/riscv/include/asm/checksum.h | 13 +++-----
 arch/riscv/lib/csum.c             | 65 +++++++++++++++------------------------
 2 files changed, 28 insertions(+), 50 deletions(-)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
index da378856f1d590e22271b90e803c7e55e8dd22e3..14f3942007b55646a0feb82bf73351323350347e 100644
--- a/arch/riscv/include/asm/checksum.h
+++ b/arch/riscv/include/asm/checksum.h
@@ -49,16 +49,11 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
 	 * worth checking if supported without Alternatives.
 	 */
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB) &&
+	    use_alternative_likely(0, RISCV_ISA_EXT_ZBB)) {
 		unsigned long fold_temp;
 
-		asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
-					      RISCV_ISA_EXT_ZBB, 1)
-		    :
-		    :
-		    :
-		    : no_zbb);
-
 		if (IS_ENABLED(CONFIG_32BIT)) {
 			asm(".option push				\n\
 			.option arch,+zbb				\n\
@@ -81,7 +76,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 		}
 		return (__force __sum16)(csum >> 16);
 	}
-no_zbb:
+
 #ifndef CONFIG_32BIT
 	csum += ror64(csum, 32);
 	csum >>= 32;
diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
index 9408f50ca59a8901f7cfbcf3297d1492172c6ea2..659d3b51d0db1010deda042134bdef1f79cf8b42 100644
--- a/arch/riscv/lib/csum.c
+++ b/arch/riscv/lib/csum.c
@@ -40,20 +40,15 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	uproto = (__force unsigned int)htonl(proto);
 	sum += uproto;
 
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB)) {
+	/*
+	 * Zbb is likely available when the kernel is compiled with Zbb
+	 * support.
+	 */
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB) &&
+	    use_alternative_likely(0, RISCV_ISA_EXT_ZBB)) {
 		unsigned long fold_temp;
 
-		/*
-		 * Zbb is likely available when the kernel is compiled with Zbb
-		 * support, so nop when Zbb is available and jump when Zbb is
-		 * not available.
-		 */
-		asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
-					      RISCV_ISA_EXT_ZBB, 1)
-				  :
-				  :
-				  :
-				  : no_zbb);
 		asm(".option push					\n\
 		.option arch,+zbb					\n\
 			rori	%[fold_temp], %[sum], 32		\n\
@@ -66,7 +61,7 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 		: [sum] "+r" (sum), [fold_temp] "=&r" (fold_temp));
 		return (__force __sum16)(sum >> 16);
 	}
-no_zbb:
+
 	sum += ror64(sum, 32);
 	sum >>= 32;
 	return csum_fold((__force __wsum)sum);
@@ -151,22 +146,16 @@ do_csum_with_alignment(const unsigned char *buff, int len)
 	end = (const unsigned long *)(buff + len);
 	csum = do_csum_common(ptr, end, data);
 
+	/*
+	 * Zbb is likely available when the kernel is compiled with Zbb
+	 * support.
+	 */
 #ifdef CC_HAS_ASM_GOTO_TIED_OUTPUT
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB) &&
+	    use_alternative_likely(0, RISCV_ISA_EXT_ZBB)) {
 		unsigned long fold_temp;
 
-		/*
-		 * Zbb is likely available when the kernel is compiled with Zbb
-		 * support, so nop when Zbb is available and jump when Zbb is
-		 * not available.
-		 */
-		asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
-					      RISCV_ISA_EXT_ZBB, 1)
-				  :
-				  :
-				  :
-				  : no_zbb);
-
 #ifdef CONFIG_32BIT
 		asm_goto_output(".option push			\n\
 		.option arch,+zbb				\n\
@@ -204,7 +193,7 @@ do_csum_with_alignment(const unsigned char *buff, int len)
 end:
 		return csum >> 16;
 	}
-no_zbb:
+
 #endif /* CC_HAS_ASM_GOTO_TIED_OUTPUT */
 #ifndef CONFIG_32BIT
 	csum += ror64(csum, 32);
@@ -234,21 +223,15 @@ do_csum_no_alignment(const unsigned char *buff, int len)
 	end = (const unsigned long *)(buff + len);
 	csum = do_csum_common(ptr, end, data);
 
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB)) {
+	/*
+	 * Zbb is likely available when the kernel is compiled with Zbb
+	 * support.
+	 */
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB) &&
+	    use_alternative_likely(0, RISCV_ISA_EXT_ZBB)) {
 		unsigned long fold_temp;
 
-		/*
-		 * Zbb is likely available when the kernel is compiled with Zbb
-		 * support, so nop when Zbb is available and jump when Zbb is
-		 * not available.
-		 */
-		asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
-					      RISCV_ISA_EXT_ZBB, 1)
-				  :
-				  :
-				  :
-				  : no_zbb);
-
 #ifdef CONFIG_32BIT
 		asm (".option push				\n\
 		.option arch,+zbb				\n\
@@ -274,7 +257,7 @@ do_csum_no_alignment(const unsigned char *buff, int len)
 #endif /* !CONFIG_32BIT */
 		return csum >> 16;
 	}
-no_zbb:
+
 #ifndef CONFIG_32BIT
 	csum += ror64(csum, 32);
 	csum >>= 32;

-- 
2.50.1



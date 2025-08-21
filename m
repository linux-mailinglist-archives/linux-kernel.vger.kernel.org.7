Return-Path: <linux-kernel+bounces-779406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F6BB2F3B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD53BA277B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149532F5321;
	Thu, 21 Aug 2025 09:16:51 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D091DDA15
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767810; cv=none; b=dBQL7ISVkeby7ifcXFCzcE1YkmaIVTUyAjOw2og9ESLTlM4IaxOJJimZ2ur6UfO5Gs0Y0VRn+lxs6N7WDOveHTWCx4NXjqzi8aI87SaCljG1g1vrm2zzmTadnX5Oi6zG2Zjytd5vZq+iPq6APxKK7VhjPTGK8a0dKVQZirVd0js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767810; c=relaxed/simple;
	bh=JhbNMI1B7M18uxQZ3XO2Ol1EQQ3PiVwFl5Jk7IpeBJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IMDrmnSa17JIGMNvf6oGiZqjpoILApaicl+UDMAtdFnCjhhejD5SILus1PIOiYpB9SGig+96FJw0zgZehEzXaSo9Xb6QsyZqdBHX9s1vD9cHGqyen7QFL1k8zkNZD6jqXyiICeqhcWWI4PxLncOgB0FrveF7Xwj/PygSprqgdAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowADXAqfv46ZovXADDg--.14435S4;
	Thu, 21 Aug 2025 17:16:31 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Thu, 21 Aug 2025 17:16:32 +0800
Subject: [PATCH v2 2/5] riscv: checksum: Use __riscv_has_extension_likely
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-riscv-altn-helper-wip-v2-2-9586fa702f78@iscas.ac.cn>
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
X-CM-TRANSID:qwCowADXAqfv46ZovXADDg--.14435S4
X-Coremail-Antispam: 1UD129KBjvJXoW3WFy7CF17XF4DXw47JFW5Wrg_yoW7XF17pr
	s3trWfKrykAa4YkryqyrZ5urn8Xw4kGwn8KrsxGry8JF90y3y3Kr95tF1fAry5XFyxta4S
	vayfuw13uF1Yya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7VUbH5lUUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Use __riscv_has_extension_likely() to check for RISCV_ISA_EXT_ZBB,
replacing the use of asm goto with ALTERNATIVE.

The "likely" variant is used to match the behavior of the original
implementation using ALTERNATIVE("j %l[no_zbb]", "nop", ...).

While we're at it, also remove bogus comment about Zbb being likely
available. We have to choose between "likely" and "unlikely" due to
limitations of the asm goto feature, but that does not mean we should
put a bad comment on why we pick "likely" over "unlikely".

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 arch/riscv/include/asm/checksum.h | 13 +++-------
 arch/riscv/lib/csum.c             | 53 +++++++++------------------------------
 2 files changed, 16 insertions(+), 50 deletions(-)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
index da378856f1d590e22271b90e803c7e55e8dd22e3..70eb50173fb6ab636f9e1534ce2ba58de5ee5c54 100644
--- a/arch/riscv/include/asm/checksum.h
+++ b/arch/riscv/include/asm/checksum.h
@@ -49,16 +49,11 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
 	 * worth checking if supported without Alternatives.
 	 */
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB) &&
+	    __riscv_has_extension_likely(0, RISCV_ISA_EXT_ZBB)) {
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
index 9408f50ca59a8901f7cfbcf3297d1492172c6ea2..420e9eb93e8531bb988823e46f23b0bbb7ca0afb 100644
--- a/arch/riscv/lib/csum.c
+++ b/arch/riscv/lib/csum.c
@@ -40,20 +40,11 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	uproto = (__force unsigned int)htonl(proto);
 	sum += uproto;
 
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB) &&
+	    __riscv_has_extension_likely(0, RISCV_ISA_EXT_ZBB)) {
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
@@ -66,7 +57,7 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 		: [sum] "+r" (sum), [fold_temp] "=&r" (fold_temp));
 		return (__force __sum16)(sum >> 16);
 	}
-no_zbb:
+
 	sum += ror64(sum, 32);
 	sum >>= 32;
 	return csum_fold((__force __wsum)sum);
@@ -152,21 +143,11 @@ do_csum_with_alignment(const unsigned char *buff, int len)
 	csum = do_csum_common(ptr, end, data);
 
 #ifdef CC_HAS_ASM_GOTO_TIED_OUTPUT
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB) &&
+	    __riscv_has_extension_likely(0, RISCV_ISA_EXT_ZBB)) {
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
@@ -204,7 +185,7 @@ do_csum_with_alignment(const unsigned char *buff, int len)
 end:
 		return csum >> 16;
 	}
-no_zbb:
+
 #endif /* CC_HAS_ASM_GOTO_TIED_OUTPUT */
 #ifndef CONFIG_32BIT
 	csum += ror64(csum, 32);
@@ -234,21 +215,11 @@ do_csum_no_alignment(const unsigned char *buff, int len)
 	end = (const unsigned long *)(buff + len);
 	csum = do_csum_common(ptr, end, data);
 
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB) &&
+	    __riscv_has_extension_likely(0, RISCV_ISA_EXT_ZBB)) {
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
@@ -274,7 +245,7 @@ do_csum_no_alignment(const unsigned char *buff, int len)
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



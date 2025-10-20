Return-Path: <linux-kernel+bounces-860422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE970BF0191
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 465DA4F0CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB9A2ED873;
	Mon, 20 Oct 2025 09:10:19 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36342E972D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951419; cv=none; b=jbSO3awdL/k92BsJWZ28Qvx9ZbolvaQDGwLo89Kcd6IQD06HZIuDhnVj1FdtaCHYzGWkIk4okk2CuhXiz2in+nJxKCDitvemRXkWC1MM9VVUvkFYOx2jWZifUeQvNRAhqVYp0g5v/NlA38omqUiC/1AdTLoakEOq47IenIEtqNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951419; c=relaxed/simple;
	bh=gOJ3RLg3I+sBxYWfMfz0EbOy65mgRETHDaLC6Mc+IMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YraGlDDN4RHZZ6q6EGpygdDd4UkErWe+ag30iKdwfQ/EmNsZkrc8Og1S+RWrR3XGfVhDpUG/lCjxAfHtZNzfIcWXiklz8l4UYVKYy9PPNidY+lQNiEf3x7pRLjKdVQxroO3DTxeWupFAK0HAFRf/wQTWWmaNPcic4ERYeU4S6xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.85.109])
	by APP-03 (Coremail) with SMTP id rQCowAD3RoFo_PVo4mflEQ--.23190S4;
	Mon, 20 Oct 2025 17:10:01 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Mon, 20 Oct 2025 17:09:57 +0800
Subject: [PATCH v4 2/5] riscv: checksum: Use riscv_has_extension_likely
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-riscv-altn-helper-wip-v4-2-ef941c87669a@iscas.ac.cn>
References: <20251020-riscv-altn-helper-wip-v4-0-ef941c87669a@iscas.ac.cn>
In-Reply-To: <20251020-riscv-altn-helper-wip-v4-0-ef941c87669a@iscas.ac.cn>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Paul Walmsley <pjw@kernel.org>
Cc: Charlie Jenkins <charlie@rivosinc.com>, 
 Xiao Wang <xiao.w.wang@intel.com>, 
 =?utf-8?q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, Vivian Wang <uwu@dram.page>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-CM-TRANSID:rQCowAD3RoFo_PVo4mflEQ--.23190S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCry5uFW5Kw1rCw4fCw4Durg_yoW7Gr47pr
	s3trWfKrykAa4YkryqyrZ5urn8Xws5Gwn8KrsxGry8JFyqv3yrKr95tF1fAry5XFyxtFyS
	vayfuw13uF1Yya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUF5rcDUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Use riscv_has_extension_likely() to check for RISCV_ISA_EXT_ZBB,
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
index da378856f1d5..945cce34be92 100644
--- a/arch/riscv/include/asm/checksum.h
+++ b/arch/riscv/include/asm/checksum.h
@@ -49,16 +49,11 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
 	 * worth checking if supported without Alternatives.
 	 */
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB) &&
+	    riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {
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
index 9408f50ca59a..75bd0abffd63 100644
--- a/arch/riscv/lib/csum.c
+++ b/arch/riscv/lib/csum.c
@@ -40,20 +40,11 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	uproto = (__force unsigned int)htonl(proto);
 	sum += uproto;
 
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB)) {
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB) &&
+	    riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {
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
+	    riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {
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
+	    riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {
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
2.51.0



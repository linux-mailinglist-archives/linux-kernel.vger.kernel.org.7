Return-Path: <linux-kernel+bounces-860426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2AEBF01AF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 715AE4F1471
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B8F2F12B9;
	Mon, 20 Oct 2025 09:10:21 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0732ECEA8
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951420; cv=none; b=F1NGshLI/5MUFpz+2poIW1W1lpoHF8nP5NEhVai/JKPUX9TEbcci/qnODeOQnGeD9BdfocUQNNPnps17wqd6BmhOE4D5bX9Ck+pJnvBuwizGE8JNAWgZQmIqnvkdjmhiiaCXktfxdOdVw9S1OFf/+KOGqM5fqqyICTUQqJDPxRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951420; c=relaxed/simple;
	bh=DvygtP/oWx3SFrnB40ewkvAYD0VwnbQaYufVL3pLMbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2W+NuurtDODhhlEzEqoJRSTdNu9MLqiPgPmrCxS4eVqkWAKqEGKpciVAX1PTIVt66SkIDAKe2FZfbrPB1+w6dQkawPLvkgZFE4pbnP82l8oHVZ1Uy4vvpajvUY2NDzcrMQv5xFHPeH7z4JhOQKTHWNr3t0VbnbBimI9cX0QUwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.85.109])
	by APP-03 (Coremail) with SMTP id rQCowAD3RoFo_PVo4mflEQ--.23190S5;
	Mon, 20 Oct 2025 17:10:01 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Mon, 20 Oct 2025 17:09:58 +0800
Subject: [PATCH v4 3/5] riscv: hweight: Use riscv_has_extension_likely
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-riscv-altn-helper-wip-v4-3-ef941c87669a@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAD3RoFo_PVo4mflEQ--.23190S5
X-Coremail-Antispam: 1UD129KBjvJXoW7AF43ArW3Jr45KF4fJr4xJFb_yoW8tw4rpF
	4Iy393GFWDKa18uF9Iyr1kZF4rZan3G347GrW3u3yxXFyjy3yYyrn8KFn8Cr98tFyvv3WS
	vFW3A343u3W2vaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7VU1sYFtUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Use riscv_has_extension_likely() to check for RISCV_ISA_EXT_ZBB,
replacing the use of asm goto with ALTERNATIVE.

The "likely" variant is used to match the behavior of the original
implementation using ALTERNATIVE("j %l[legacy]", "nop", ...).

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 arch/riscv/include/asm/arch_hweight.h | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/include/asm/arch_hweight.h b/arch/riscv/include/asm/arch_hweight.h
index 0e7cdbbec8ef..f3c0831beefc 100644
--- a/arch/riscv/include/asm/arch_hweight.h
+++ b/arch/riscv/include/asm/arch_hweight.h
@@ -19,10 +19,10 @@
 
 static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
-#if defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)
-	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
-				      RISCV_ISA_EXT_ZBB, 1)
-			  : : : : legacy);
+	if (!(IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	      IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB) &&
+	      riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)))
+		return __sw_hweight32(w);
 
 	asm (".option push\n"
 	     ".option arch,+zbb\n"
@@ -31,10 +31,6 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 	     : "=r" (w) : "r" (w) :);
 
 	return w;
-
-legacy:
-#endif
-	return __sw_hweight32(w);
 }
 
 static inline unsigned int __arch_hweight16(unsigned int w)
@@ -50,10 +46,10 @@ static inline unsigned int __arch_hweight8(unsigned int w)
 #if BITS_PER_LONG == 64
 static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
-#if defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)
-	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
-				      RISCV_ISA_EXT_ZBB, 1)
-			  : : : : legacy);
+	if (!(IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	      IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB) &&
+	      riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)))
+		return __sw_hweight64(w);
 
 	asm (".option push\n"
 	     ".option arch,+zbb\n"
@@ -62,10 +58,6 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 	     : "=r" (w) : "r" (w) :);
 
 	return w;
-
-legacy:
-#endif
-	return __sw_hweight64(w);
 }
 #else /* BITS_PER_LONG == 64 */
 static inline unsigned long __arch_hweight64(__u64 w)

-- 
2.51.0



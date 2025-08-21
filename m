Return-Path: <linux-kernel+bounces-779403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA7DB2F39A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F292D1C281EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46922F1FC5;
	Thu, 21 Aug 2025 09:16:49 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E152EE27D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767809; cv=none; b=jmKdD3nBY+kJDwAey8fcHYHBxJQ8H90oiJrHCJrsf8S9PDHnu4OvlwAuqCxG6dsjZoKEDRw3NMGcIMzmr5S6AhkR/jS7MUH5N0dY3OWLWuxxp9nYIlfXu//c1VM/agdf07cmopwtm5dwCOmy6ChNfF3LiydSB7PUUQqeNBgzeLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767809; c=relaxed/simple;
	bh=FFka5n39TNHtjOEHhQvzXdQxF9OR9QCVkKcO9IfY9QI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tn+131EgUAyx6KU6qGcovWToK8Ekr80Z3cvqfb15ozNhsJW1fx4/bQRlelX77PYSfaO90HJTUHuRo4Ir8f/CpeEWTTQh15zCC3QjGg/8AvhKmkXMrwcUiPPnKzmrpSI0QElczZKJdI8HSHze9yt/WsVMc6nJKJW5YOAinPs9l/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowADXAqfv46ZovXADDg--.14435S5;
	Thu, 21 Aug 2025 17:16:32 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Thu, 21 Aug 2025 17:16:33 +0800
Subject: [PATCH v2 3/5] riscv: hweight: Use __riscv_has_extension_likely
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-riscv-altn-helper-wip-v2-3-9586fa702f78@iscas.ac.cn>
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
X-CM-TRANSID:qwCowADXAqfv46ZovXADDg--.14435S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4kWFy8WrWDtF43Zw48Xrb_yoW8KF4kpF
	4Iy3s3GFWkJa18uF90yr1kZa1rZan3G347GrW3u3yxXFyjyw4Ykrn8KFn8Cr98tFyvv3WS
	qFWfA343u3W2qaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUO_MaUUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Use __riscv_has_extension_likely() to check for RISCV_ISA_EXT_ZBB,
replacing the use of asm goto with ALTERNATIVE.

The "likely" variant is used to match the behavior of the original
implementation using ALTERNATIVE("j %l[legacy]", "nop", ...).

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 arch/riscv/include/asm/arch_hweight.h | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/include/asm/arch_hweight.h b/arch/riscv/include/asm/arch_hweight.h
index 0e7cdbbec8efd3c293da2fa96a8c6d0a93faf56f..021bc671de299d604a33301e68c10cb1c28ad2c1 100644
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
+	      __riscv_has_extension_likely(0, RISCV_ISA_EXT_ZBB)))
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
+	      __riscv_has_extension_likely(0, RISCV_ISA_EXT_ZBB)))
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
2.50.1



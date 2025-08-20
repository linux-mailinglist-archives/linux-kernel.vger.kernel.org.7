Return-Path: <linux-kernel+bounces-777828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E6EB2DE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C50189DF47
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E981F181F;
	Wed, 20 Aug 2025 13:45:13 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6DC321F55
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697513; cv=none; b=WwVkKG5DEfBfaftA/lFjvPm4qEEDrNCXRsJm2hfIIeENeXhxk03YvnqE1HAqDh8uizVLbjAC8DYhuHiF586CdUwzZ8dVeksX9UCf0raY5dK3RPtYTpNX2QEIH1T6hqzNTLO2JEuMblaIp7M0Wq6uwxQv2z3a20w0xPPqboil/1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697513; c=relaxed/simple;
	bh=NpzORn97GESos8tdB/QDdUeNSnxDvCcvqgwce60Fzho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HphR4yew2EYCcc7wsQggcVbPQ912izhJuBe9Hzb8YANj6KZMPW2iWn5VEvVy/5FIiapVlsmyssHPePxxqOCjfimzqXbFbZsfGy27ibWNN1ZULTa2m9CQdyYO6FWUJhAhwWaermhbSbqJJwFJljlyiwMnZa1NTbEUaYHji4WyuzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowABHN6tT0aVogOTBDQ--.24665S6;
	Wed, 20 Aug 2025 21:44:52 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Wed, 20 Aug 2025 21:44:48 +0800
Subject: [PATCH 4/6] riscv: hweight: Convert to use_alternative_likely
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-riscv-altn-helper-wip-v1-4-c3c626c1f7e6@iscas.ac.cn>
References: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn>
In-Reply-To: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, Vivian Wang <uwu@dram.page>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowABHN6tT0aVogOTBDQ--.24665S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4rXF13uFW3Jry3uryDKFg_yoW8uF1fpr
	4Ik397Ca48Ka1xuF9Iyrn5Xa1rW395G343GrW3urW8XFyYkw4Yyr18K3Z5Gr95tFyvq3Wx
	XrW7Aa43u3WjyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Use use_alternative_likely() to check for RISCV_ISA_EXT_ZBB, replacing
the use of asm goto with ALTERNATIVE.

The "likely" variant is used to match the behavior of the original
implementation using ALTERNATIVE("j %l[legacy]", "nop", ...).

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 arch/riscv/include/asm/arch_hweight.h | 42 +++++++++++++++--------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/include/asm/arch_hweight.h b/arch/riscv/include/asm/arch_hweight.h
index 0e7cdbbec8efd3c293da2fa96a8c6d0a93faf56f..58ed7a3b2d7882f6a7913c4bfdb9bce4a4394956 100644
--- a/arch/riscv/include/asm/arch_hweight.h
+++ b/arch/riscv/include/asm/arch_hweight.h
@@ -20,20 +20,17 @@
 static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 #if defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)
-	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
-				      RISCV_ISA_EXT_ZBB, 1)
-			  : : : : legacy);
+	if (use_alternative_likely(0, RISCV_ISA_EXT_ZBB)) {
+		asm (".option push\n"
+		     ".option arch,+zbb\n"
+		     CPOPW "%0, %1\n"
+		     ".option pop\n"
+		     : "=r" (w) : "r" (w) :);
 
-	asm (".option push\n"
-	     ".option arch,+zbb\n"
-	     CPOPW "%0, %1\n"
-	     ".option pop\n"
-	     : "=r" (w) : "r" (w) :);
-
-	return w;
-
-legacy:
+		return w;
+	}
 #endif
+
 	return __sw_hweight32(w);
 }
 
@@ -51,20 +48,17 @@ static inline unsigned int __arch_hweight8(unsigned int w)
 static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
 #if defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)
-	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
-				      RISCV_ISA_EXT_ZBB, 1)
-			  : : : : legacy);
+	if (use_alternative_likely(0, RISCV_ISA_EXT_ZBB)) {
+		asm (".option push\n"
+		     ".option arch,+zbb\n"
+		     "cpop %0, %1\n"
+		     ".option pop\n"
+		     : "=r" (w) : "r" (w) :);
 
-	asm (".option push\n"
-	     ".option arch,+zbb\n"
-	     "cpop %0, %1\n"
-	     ".option pop\n"
-	     : "=r" (w) : "r" (w) :);
-
-	return w;
-
-legacy:
+		return w;
+	}
 #endif
+
 	return __sw_hweight64(w);
 }
 #else /* BITS_PER_LONG == 64 */

-- 
2.50.1



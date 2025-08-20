Return-Path: <linux-kernel+bounces-777825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D765B2DE3C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5FD726D79
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C951DC198;
	Wed, 20 Aug 2025 13:45:12 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02800321F5B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697512; cv=none; b=YvWcRfqa+xxdlzLqyoYd2HqK48XJazSKzvw0fGLmuy4YSJWPGp+yo4ZslE3a5vKZJBwJsIZUQGrlLIAKClfMlQZ9PKio3UfQh5PhkHKmYR8qrhpE7ysF/w53UoGAs7w1k9MmTt2ThSB4HZkjt+G27BvRSQC4sr3/Z+mp3wML1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697512; c=relaxed/simple;
	bh=9Bb/39yuIfYm4QnC8/6dotXjRhj+voskjZfoJY7Zs4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VScNkHhl2qdYx9earBPLw91LrOVGNC8PKm5Lr0SFtWxVm2th7tpR87AzC9GOJ28hXugp/LpMat8YrwGeCTxWi9BHVhbx5w0qHE/jghPWRSGGGGrtNBGiPh58pO5/Uy8UMMriTvX+O/nZia/bRc+xSTsB08fWSjbQdNTHiFXBd/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowABHN6tT0aVogOTBDQ--.24665S7;
	Wed, 20 Aug 2025 21:44:52 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Wed, 20 Aug 2025 21:44:49 +0800
Subject: [PATCH 5/6] riscv: bitops: Convert to use_alternative_likely
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-riscv-altn-helper-wip-v1-5-c3c626c1f7e6@iscas.ac.cn>
References: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn>
In-Reply-To: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, Vivian Wang <uwu@dram.page>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowABHN6tT0aVogOTBDQ--.24665S7
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4UZry5Aw47ur1UtryrJFb_yoW5tFWxpr
	1kKws7CayDKa4ruFn2yr1fW3WrWrW7J39rGr93GF1kJa4DC39Ykr1Fk3WfKr95AFWvq347
	ZrWUAF95C3WUZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
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
 arch/riscv/include/asm/bitops.h | 112 ++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 62 deletions(-)

diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index d59310f74c2ba70caeb7b9b0e9221882117583f5..0257d547a96293909d90b017c8a48b508d0fd642 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -47,20 +47,17 @@
 
 static __always_inline unsigned long variable__ffs(unsigned long word)
 {
-	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
-				      RISCV_ISA_EXT_ZBB, 1)
-			  : : : : legacy);
-
-	asm volatile (".option push\n"
-		      ".option arch,+zbb\n"
-		      "ctz %0, %1\n"
-		      ".option pop\n"
-		      : "=r" (word) : "r" (word) :);
-
-	return word;
-
-legacy:
-	return generic___ffs(word);
+	if (use_alternative_likely(0, RISCV_ISA_EXT_ZBB)) {
+		asm volatile (".option push\n"
+			      ".option arch,+zbb\n"
+			      "ctz %0, %1\n"
+			      ".option pop\n"
+			      : "=r" (word) : "r" (word) :);
+
+		return word;
+	} else {
+		return generic___ffs(word);
+	}
 }
 
 /**
@@ -76,20 +73,17 @@ static __always_inline unsigned long variable__ffs(unsigned long word)
 
 static __always_inline unsigned long variable__fls(unsigned long word)
 {
-	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
-				      RISCV_ISA_EXT_ZBB, 1)
-			  : : : : legacy);
-
-	asm volatile (".option push\n"
-		      ".option arch,+zbb\n"
-		      "clz %0, %1\n"
-		      ".option pop\n"
-		      : "=r" (word) : "r" (word) :);
-
-	return BITS_PER_LONG - 1 - word;
-
-legacy:
-	return generic___fls(word);
+	if (use_alternative_likely(0, RISCV_ISA_EXT_ZBB)) {
+		asm volatile (".option push\n"
+			      ".option arch,+zbb\n"
+			      "clz %0, %1\n"
+			      ".option pop\n"
+			      : "=r" (word) : "r" (word) :);
+
+		return BITS_PER_LONG - 1 - word;
+	} else {
+		return generic___fls(word);
+	}
 }
 
 /**
@@ -105,23 +99,20 @@ static __always_inline unsigned long variable__fls(unsigned long word)
 
 static __always_inline int variable_ffs(int x)
 {
-	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
-				      RISCV_ISA_EXT_ZBB, 1)
-			  : : : : legacy);
-
-	if (!x)
-		return 0;
-
-	asm volatile (".option push\n"
-		      ".option arch,+zbb\n"
-		      CTZW "%0, %1\n"
-		      ".option pop\n"
-		      : "=r" (x) : "r" (x) :);
-
-	return x + 1;
-
-legacy:
-	return generic_ffs(x);
+	if (use_alternative_likely(0, RISCV_ISA_EXT_ZBB)) {
+		if (!x)
+			return 0;
+
+		asm volatile (".option push\n"
+			      ".option arch,+zbb\n"
+			      CTZW "%0, %1\n"
+			      ".option pop\n"
+			      : "=r" (x) : "r" (x) :);
+
+		return x + 1;
+	} else {
+		return generic_ffs(x);
+	}
 }
 
 /**
@@ -137,23 +128,20 @@ static __always_inline int variable_ffs(int x)
 
 static __always_inline int variable_fls(unsigned int x)
 {
-	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
-				      RISCV_ISA_EXT_ZBB, 1)
-			  : : : : legacy);
-
-	if (!x)
-		return 0;
-
-	asm volatile (".option push\n"
-		      ".option arch,+zbb\n"
-		      CLZW "%0, %1\n"
-		      ".option pop\n"
-		      : "=r" (x) : "r" (x) :);
-
-	return 32 - x;
-
-legacy:
-	return generic_fls(x);
+	if (use_alternative_likely(0, RISCV_ISA_EXT_ZBB)) {
+		if (!x)
+			return 0;
+
+		asm volatile (".option push\n"
+			      ".option arch,+zbb\n"
+			      CLZW "%0, %1\n"
+			      ".option pop\n"
+			      : "=r" (x) : "r" (x) :);
+
+		return 32 - x;
+	} else {
+		return generic_fls(x);
+	}
 }
 
 /**

-- 
2.50.1



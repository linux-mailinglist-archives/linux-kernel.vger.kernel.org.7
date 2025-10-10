Return-Path: <linux-kernel+bounces-848889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4DDBCEC29
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D99719A60BA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5424828136B;
	Fri, 10 Oct 2025 23:36:55 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0627FB2D
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760139414; cv=none; b=Q0riOrmtExxxx95wNBDCCJ7r519YCk6P44UNPku36HXaOZ2eEuSE75Tb8/G0yFjAWvZxH8YyBChC0Tcsh8cL5kpxf+b7pIMMBSWJ15I+HZpKO0SD0HQQ2pfEPeTHg4rQeGm8Yokz3TuleXpPrXCnB247SRHdgLQXTjPrKV0Sk+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760139414; c=relaxed/simple;
	bh=/cjWM9B6MHhzFGr1s94rKhuylFFFt+DUkBI8mGM9If4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lz9Aj/0ET8+w6Dy/3B62a+VinlFkRhvYobD10cfLzZ7ib2TFJuruPORVejNv9fQI+RM2SF8KLwGNcx/O7msgvtLHRLI65ETAau/hr5V1b6BjB59o+RtJNDkMtQMuMefGEJtOIEnUjYhhNQaOyhuPzBQ/N2nuEEMDs/pTsjEE36s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.81.247])
	by APP-05 (Coremail) with SMTP id zQCowADHaxVUmOloXC2IDQ--.41211S7;
	Sat, 11 Oct 2025 07:35:49 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Sat, 11 Oct 2025 07:35:47 +0800
Subject: [PATCH v3 5/5] riscv: cmpxchg: Use __riscv_has_extension_likely
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-riscv-altn-helper-wip-v3-5-d40ddaa1985a@iscas.ac.cn>
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
X-CM-TRANSID:zQCowADHaxVUmOloXC2IDQ--.41211S7
X-Coremail-Antispam: 1UD129KBjvJXoW7CF48uw17uw4rKF1fKrW5GFg_yoW8JFyxpr
	ZxCr1jkFyDCw4xZa9Yyr9xXw4rX39xK3W3CFWj9a48JFWUAryfArn0v3W5ur1UJFZ2q34Y
	vFWrC3s3Z3W7trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8
	JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
	WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
	CTnIWIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Use __riscv_has_extension_likely() to check for RISCV_ISA_EXT_ZAWRS,
replacing the use of asm goto with ALTERNATIVE.

The "likely" variant is used to match the behavior of the original
implementation using ALTERNATIVE("j %l[no_zawrs]", "nop", ...).

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 arch/riscv/include/asm/cmpxchg.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 122e1485d39a0ad44ec4357cb23148dc6e58dc6b..6fca79f5c3475cc03745e481f964d2899373235b 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -373,9 +373,10 @@ static __always_inline void __cmpwait(volatile void *ptr,
 	u32 *__ptr32b;
 	ulong __s, __val, __mask;
 
-	asm goto(ALTERNATIVE("j %l[no_zawrs]", "nop",
-			     0, RISCV_ISA_EXT_ZAWRS, 1)
-		 : : : : no_zawrs);
+	if (!__riscv_has_extension_likely(0, RISCV_ISA_EXT_ZAWRS)) {
+		ALT_RISCV_PAUSE();
+		return;
+	}
 
 	switch (size) {
 	case 1:
@@ -437,11 +438,6 @@ static __always_inline void __cmpwait(volatile void *ptr,
 	default:
 		BUILD_BUG();
 	}
-
-	return;
-
-no_zawrs:
-	ALT_RISCV_PAUSE();
 }
 
 #define __cmpwait_relaxed(ptr, val) \

-- 
2.50.1



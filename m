Return-Path: <linux-kernel+bounces-779404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B72CB2F391
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51A33B60FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B821F2F068B;
	Thu, 21 Aug 2025 09:16:49 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E942EF657
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767809; cv=none; b=iHhD3HiasXaTMrgRCo5lI3DKT+MmQbSp+3u+cJdhwj8plD68CrVa519bJGcc+j8MBhNA6pPUB9215HlWgSCMJ1aDCjThvdsYHSEacYtfhnGecNa/tP/NeiCsFxVuOrzhqPGB3XVS9HZljxzRh2bTRf7V+SZr43bXbM69qjki0xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767809; c=relaxed/simple;
	bh=1Y/Fou4ZurQ/wQhq9ImyPN1I0Tf/s+8iwrwAiRDSuyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mrJxSZTfxiDL4CFTdwU1eM88ZGjRbuG/rPVxJN0i+G9ZZHL9lJOQ+66j/2UYJvqQYMLIUT9xrvdJZCpPsyqF5kvFB7sDWJ1nFknHbrZAlWls9KXyC643xxO8/4z7dkDHsODlB+UbvUxwfSyvsYZpekBebX9t1/gbLVDGQ2W1CBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowADXAqfv46ZovXADDg--.14435S7;
	Thu, 21 Aug 2025 17:16:32 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Thu, 21 Aug 2025 17:16:35 +0800
Subject: [PATCH v2 5/5] riscv: cmpxchg: Use __riscv_has_extension_likely
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-riscv-altn-helper-wip-v2-5-9586fa702f78@iscas.ac.cn>
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
X-CM-TRANSID:qwCowADXAqfv46ZovXADDg--.14435S7
X-Coremail-Antispam: 1UD129KBjvJXoW7CF48uw17uw4rKF1fKrW5GFg_yoW8Gr18pF
	Z3Cr1qkF98Cw4xua4vyr9xXw4rXa93K3W3CrW09a4kXF4UArWxArn093Wavr1UJFZ2q34j
	vFWfC3s3Z3W7trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbPC7UUUUUU==
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
index 0b749e7102162477432f7cf9a34768fbdf2e8cc7..6a372ab9bcf68ba5eb712ad9d082ec66198b7160 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -370,9 +370,10 @@ static __always_inline void __cmpwait(volatile void *ptr,
 	u32 *__ptr32b;
 	ulong __s, __val, __mask;
 
-	asm goto(ALTERNATIVE("j %l[no_zawrs]", "nop",
-			     0, RISCV_ISA_EXT_ZAWRS, 1)
-		 : : : : no_zawrs);
+	if (!__riscv_has_extension_likely(0, RISCV_ISA_EXT_ZAWRS)) {
+		asm volatile(RISCV_PAUSE : : : "memory");
+		return;
+	}
 
 	switch (size) {
 	case 1:
@@ -434,11 +435,6 @@ static __always_inline void __cmpwait(volatile void *ptr,
 	default:
 		BUILD_BUG();
 	}
-
-	return;
-
-no_zawrs:
-	asm volatile(RISCV_PAUSE : : : "memory");
 }
 
 #define __cmpwait_relaxed(ptr, val) \

-- 
2.50.1



Return-Path: <linux-kernel+bounces-860423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1648BF0194
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59DA54F0B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC102EDD69;
	Mon, 20 Oct 2025 09:10:19 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9BE2E9ECE
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951419; cv=none; b=fz92FGp0isyLpCcPBFMdGR+N/kkEI/rsPh1TtTVNXoZDeKjQppapPceDIdgtuoZTFnsqE16YWhrk+W/15C5N3SEVitn5iYYcSNgfsKLzgBTiPJ40dAiu4tPSRFVedGxAoT774z4TVGdA4jqJD9snPgM+kk2gB6QPTJ2tZdSP4xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951419; c=relaxed/simple;
	bh=FpfjV/GyS3d2FiKJMbVRAHlFGMJCVKttBJKuK1oI7ww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eETjV5ALF2nQ12+5B+L4nXQw4SN8lnl2HjVLnOMV2hvowxYS/Jm0wKMmOmXMAK6iOULhSMP5IPG+rTO3zITl77hEe6CPAe7ti5MnuDZ/k7HJkACXfUKAw25fUry7W3huKGjvzzIQbPw8a9VmjNRFlUiX004JPbX9M+cIvON/Mxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.85.109])
	by APP-03 (Coremail) with SMTP id rQCowAD3RoFo_PVo4mflEQ--.23190S7;
	Mon, 20 Oct 2025 17:10:01 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Mon, 20 Oct 2025 17:10:00 +0800
Subject: [PATCH v4 5/5] riscv: cmpxchg: Use riscv_has_extension_likely
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-riscv-altn-helper-wip-v4-5-ef941c87669a@iscas.ac.cn>
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
X-CM-TRANSID:rQCowAD3RoFo_PVo4mflEQ--.23190S7
X-Coremail-Antispam: 1UD129KBjvJXoWrtFyktrWfJw4fKw47GFW3Jrb_yoW8Jr1rpr
	Z3Cr1jkayDCw4xZ3Zayr9xXa18Xa93K3W3CrW093y8XFWUArWfAr90va4a9r1UJFZ2qw1j
	vF4rGr93Z3W7trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
	3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
	vfC2KfnxnUUI43ZEXa7VU1zpBDUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Use riscv_has_extension_likely() to check for RISCV_ISA_EXT_ZAWRS,
replacing the use of asm goto with ALTERNATIVE.

The "likely" variant is used to match the behavior of the original
implementation using ALTERNATIVE("j %l[no_zawrs]", "nop", ...).

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 arch/riscv/include/asm/cmpxchg.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 122e1485d39a..8712cf9c69dc 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -373,9 +373,10 @@ static __always_inline void __cmpwait(volatile void *ptr,
 	u32 *__ptr32b;
 	ulong __s, __val, __mask;
 
-	asm goto(ALTERNATIVE("j %l[no_zawrs]", "nop",
-			     0, RISCV_ISA_EXT_ZAWRS, 1)
-		 : : : : no_zawrs);
+	if (!riscv_has_extension_likely(RISCV_ISA_EXT_ZAWRS)) {
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
2.51.0



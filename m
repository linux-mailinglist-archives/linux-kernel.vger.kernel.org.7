Return-Path: <linux-kernel+bounces-777829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B77B2DE4F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A0A1776A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7741F3B98;
	Wed, 20 Aug 2025 13:45:13 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026C0321F58
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697513; cv=none; b=nmWjNiNB+DeYRjG5DIskKQ/F3qmhjLDDUOLKePAG2eZSpLSLqgBQ8G/rs7nvCfbPu2M6IYeC6o2Uylp4E8Ibj5uD4LnZU+fFBY8YqxAEgK2A4q8SUGm/3opdcCw4DM61wnJNBXjmnkOUryXoOvNjo1BGNS8fqmrO/qhNh2EK9OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697513; c=relaxed/simple;
	bh=BEifChlpfU0M076HlGeRnhxqkcPP9GmalCnVSG1+o9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gMzpmt20YErW0tk0ykS5EG6Vdp7gJXtHz6wM2oY/RX9+aWzsjuu+U0FWxd02FC9pvQB3B/b4b5NGa5u8t1Q4jSlmDdp0T+xibZEtRpvNzHx5sk3X82m6eLxE+QIYfv7umCeuGPdZJAHc71Cw0kLJU7b0PeulKZXToQy6N3iszu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowABHN6tT0aVogOTBDQ--.24665S3;
	Wed, 20 Aug 2025 21:44:52 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Wed, 20 Aug 2025 21:44:45 +0800
Subject: [PATCH 1/6] riscv: Introduce use_alternative_{likely,unlikely}
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250820-riscv-altn-helper-wip-v1-1-c3c626c1f7e6@iscas.ac.cn>
References: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn>
In-Reply-To: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, Vivian Wang <uwu@dram.page>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ayd=C4=B1n_Mercan?= <aydin@mercan.dev>
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowABHN6tT0aVogOTBDQ--.24665S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4fWF4rXw45Ar43JF1UKFg_yoW5Ww4UpF
	s3Ga45AFZ5G3WIyF9xZw1qqr4Yk3yfK3sxXasxKF1jka1jy3yrtr18Jr4Yvr9rA3sxWry7
	JFn7t3W8C3WjkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmj14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
	62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
	AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
	0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI
	1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kfnx
	nUUI43ZEXa7VUjnXo7UUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Introduce convenience helpers use_alternative_likely() and
use_alternative_unlikely() to implement the pattern of using asm goto to
check if an alternative is selected. Existing code will be converted in
subsequent patches.

Similar to arm64 alternative_has_cap_{likely,unlikely}, but for riscv,
alternatives are not all CPU capabilities.

Suggested-by: Aydın Mercan <aydin@mercan.dev>
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 arch/riscv/include/asm/alternative-macros.h | 73 +++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
index 231d777d936c2d29c858decaa9a3fa5f172efbb8..be9835b5e4eba03d76db3a73da19ac9e2981c4db 100644
--- a/arch/riscv/include/asm/alternative-macros.h
+++ b/arch/riscv/include/asm/alternative-macros.h
@@ -158,4 +158,77 @@
 	_ALTERNATIVE_CFG_2(old_content, new_content_1, vendor_id_1, patch_id_1, CONFIG_k_1,	\
 					new_content_2, vendor_id_2, patch_id_2, CONFIG_k_2)
 
+/*
+ * use_alternative_{likely,unlikely}() returns true if the alternative is
+ * applied and false otherwise, but in a way where the compiler can optimize
+ * this check down to a nop instruction that's patched into a jump, or vice
+ * versa.
+ *
+ * Always returns false if the alternatives mechanism is not available.
+ *
+ * Usage example:
+ *   if (use_alternative_likely(0, RISCV_ISA_ZBB))
+ *
+ * Similar to static keys, "likely" means use a nop if the alternative is
+ * selected, and jump if unselected; "unlikely" is the other way around.
+ */
+
+#ifndef __ASSEMBLER__
+
+#include <linux/types.h>
+
+#ifdef CONFIG_RISCV_ALTERNATIVE
+
+static __always_inline bool use_alternative_likely(u16 vendor_id, u32 patch_id)
+{
+	BUILD_BUG_ON(!__builtin_constant_p(vendor_id));
+	BUILD_BUG_ON(!__builtin_constant_p(patch_id));
+
+	asm goto(ALTERNATIVE("j %l[no_alt]", "nop", %[vendor_id], %[patch_id], 1)
+		 :
+		 : [vendor_id] "i"(vendor_id),
+		   [patch_id] "i"(patch_id)
+		 :
+		 : no_alt);
+
+	return true;
+
+no_alt:
+	return false;
+}
+
+static __always_inline bool use_alternative_unlikely(u16 vendor_id, u32 patch_id)
+{
+	BUILD_BUG_ON(!__builtin_constant_p(vendor_id));
+	BUILD_BUG_ON(!__builtin_constant_p(patch_id));
+
+	asm goto(ALTERNATIVE("nop", "j %l[alt]", %[vendor_id], %[patch_id], 1)
+		 :
+		 : [vendor_id] "i"(vendor_id),
+		   [patch_id] "i"(patch_id)
+		 :
+		 : alt);
+
+	return false;
+
+alt:
+	return true;
+}
+
+#else
+
+static inline bool use_alternative_likely(u16 vendor_id, u32 patch_id)
+{
+	return false;
+}
+
+static inline bool use_alternative_unlikely(u16 vendor_id, u32 patch_id)
+{
+	return false;
+}
+
+#endif /* CONFIG_RISCV_ALTERNATIVE */
+
+#endif /* __ASSEMBLER__ */
+
 #endif

-- 
2.50.1



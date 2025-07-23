Return-Path: <linux-kernel+bounces-743141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F49B0FB1E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B51177074
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9277229B21;
	Wed, 23 Jul 2025 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="vjJPy8D2"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A591E9906
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753300099; cv=none; b=Zt0MqvC7KkeCzc39Khln5vz8HyfUnRcTLvcmglNTBdU2labRMIU9VdfssqWyBs/zA7L56ORIDgyGRPp97+1X1hK81YKLHYiLaKftjJ1D66ptkCYnAIB0FxD3SuYJMKw8NO9gV+FMjpAE8DiHRjKyApJHLm4Q54ZsaBbZMVSP/B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753300099; c=relaxed/simple;
	bh=fjW18v6vhzrUXB8LA096q7hD4dSBcyTZvUGV4oxCBuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FfAAuybXdI9r0jD3hPA8DtlKGjoswDy6RyM/6wGqvPB8Q5d9Gc1qj8LV2qIIXmg8pPr66V/P3PlpasysQpy5pInbEQG+N8TYfUfAic79DrZkd32zZhRV7tkRa1gS1qkMGoNQVBLZes2Z8sErUhcFqucCZh0IBbgq7ly5G50LreM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=vjJPy8D2; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1753300094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UlZ5tG6/MqMLi3OqYJIZjahAOWvu1Yqz/tvUfudcSsI=;
	b=vjJPy8D2AAgbT89wOLDUOghqfQIQVzJJrkvqjEfEx6vQiZP9zPgwexyGVdi4BEMPgLnI29
	QVzLU7WmVpIYDObmKyjqJ6z56bwTiOsBHgCkG0GYeKkaheAfv3WdKSyCHu/acffHGhh4aC
	i2mAMzO//ZyupOaBNjVWdhx6BZzYyFuGcl+FAF3u4D3KFThrVGhhw7p9HWDs6bzqSTEfdF
	s04vG+nSRnvH620S2Bnp+dx1VVcgB+uoX4y+NKR8/u+Qg3FMaQx3yVAbQbzRSyMANPpqLT
	1+H2yV8KPZFbt0CAOI0k69t9sN+z5jTK0ThtU3e/xH5BtQdibw95hk1wtungNQ==
From: Ignacio Encinas <ignacio@iencinas.com>
Date: Wed, 23 Jul 2025 20:47:29 +0100
Subject: [PATCH v6] riscv: introduce asm/swab.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-riscv-swab-v6-1-fc11e9a2efc9@iencinas.com>
X-B4-Tracking: v=1; b=H4sIAFA8gWgC/23Qz07EIBDH8VfZcBYzwwAtnnwP44E/U5eDrQGDm
 k3fXXZjsq3p8Ufy+SbDRVQumat4Ol1E4ZZrXuY+7MNJxLOf31jm1LdQoAwQDLLkGpusXz7IMGJ
 w2jsfMYgOPgpP+fsWe3nt+5zr51J+bu2G19e/DMI201CiJG2N4gmZnX3OPMc8+/oYl3dxLTW11
 W6nlQSZDAWbrA8OzYGmu9ZAO01dU5gGMGkEJjrQeqOV3WndtdUKUIP2dowH2tz1gLvva6bfjcm
 EMEStJhr/6XVdfwGSSrwlnwEAAA==
X-Change-ID: 20250307-riscv-swab-b81b94a9ac1b
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Ignacio Encinas <ignacio@iencinas.com>
X-Migadu-Flow: FLOW_OUT

Implement endianness swap macros for RISC-V.

Use the rev8 instruction when Zbb is available. Otherwise, rely on the
default mask-and-shift implementation.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
---
Motivated by [1]. Tested with crc_kunit as pointed out here [2]. I can't 
provide performance numbers as I don't have RISC-V hardware.

[1] https://lore.kernel.org/all/20250302220426.GC2079@quark.localdomain/
[2] https://lore.kernel.org/all/20250216225530.306980-1-ebiggers@kernel.org/
---
Changes in v6:
- Fix kernel test robot report using Alex's fix from [4] 
- Link to v5: https://lore.kernel.org/r/20250717-riscv-swab-v5-1-1d5bb7c42f38@iencinas.com

[4] https://lore.kernel.org/all/6ec13c2a-764c-4a88-a419-b4d7433c0731@ghiti.fr/

Changes in v5:
- Duplicate ___constant_swab helpers in arch/riscv/include/asm/swab.h to
  avoid delaying the patch as suggested by Alex in [3] (drop patch 1 and
  convert this into a 1-patch series)
- Link to v4: https://lore.kernel.org/r/20250426-riscv-swab-v4-0-64201404a68c@iencinas.com

[3] https://lore.kernel.org/linux-riscv/7e22a448-3cee-4475-b69b-3dd45b57f168@ghiti.fr/

Changes in v4:

- Add missing include in the 1st patch, reported by
  https://lore.kernel.org/all/202504042300.it9RcOSt-lkp@intel.com/
- Rewrite the ARCH_SWAB macro as suggested by Arnd
- Define __arch_swab64 for CONFIG_32BIT (Ben)
- Link to v3: https://lore.kernel.org/r/20250403-riscv-swab-v3-0-3bf705d80e33@iencinas.com

Changes in v3:

PATCH 2:
  Use if(riscv_has_extension_likely) instead of asm goto (Eric). It
  looks like both versions generate the same assembly. Perhaps we should
  do the same change in other places such as arch/riscv/include/asm/bitops.h
- Link to v2: https://lore.kernel.org/r/20250319-riscv-swab-v2-0-d53b6d6ab915@iencinas.com

Changes in v2:
- Introduce first patch factoring out the default implementation into
  asm-generic
- Remove blank line to make checkpatch happy
- Link to v1: https://lore.kernel.org/r/20250310-riscv-swab-v1-1-34652ef1ee96@iencinas.com
---
 arch/riscv/include/asm/swab.h | 87 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/riscv/include/asm/swab.h b/arch/riscv/include/asm/swab.h
new file mode 100644
index 0000000000000000000000000000000000000000..c1da22aa13268f872a672f12a86fd9f18f3e645b
--- /dev/null
+++ b/arch/riscv/include/asm/swab.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_RISCV_SWAB_H
+#define _ASM_RISCV_SWAB_H
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <asm/cpufeature-macros.h>
+#include <asm/hwcap.h>
+#include <asm-generic/swab.h>
+
+#if defined(CONFIG_TOOLCHAIN_HAS_ZBB) && defined(CONFIG_RISCV_ISA_ZBB) && !defined(NO_ALTERNATIVE)
+
+// Duplicated from include/uapi/linux/swab.h
+#define ___constant_swab16(x) ((__u16)(				\
+	(((__u16)(x) & (__u16)0x00ffU) << 8) |			\
+	(((__u16)(x) & (__u16)0xff00U) >> 8)))
+
+#define ___constant_swab32(x) ((__u32)(				\
+	(((__u32)(x) & (__u32)0x000000ffUL) << 24) |		\
+	(((__u32)(x) & (__u32)0x0000ff00UL) <<  8) |		\
+	(((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |		\
+	(((__u32)(x) & (__u32)0xff000000UL) >> 24)))
+
+#define ___constant_swab64(x) ((__u64)(				\
+	(((__u64)(x) & (__u64)0x00000000000000ffULL) << 56) |	\
+	(((__u64)(x) & (__u64)0x000000000000ff00ULL) << 40) |	\
+	(((__u64)(x) & (__u64)0x0000000000ff0000ULL) << 24) |	\
+	(((__u64)(x) & (__u64)0x00000000ff000000ULL) <<  8) |	\
+	(((__u64)(x) & (__u64)0x000000ff00000000ULL) >>  8) |	\
+	(((__u64)(x) & (__u64)0x0000ff0000000000ULL) >> 24) |	\
+	(((__u64)(x) & (__u64)0x00ff000000000000ULL) >> 40) |	\
+	(((__u64)(x) & (__u64)0xff00000000000000ULL) >> 56)))
+
+#define ARCH_SWAB(size, value)						\
+({									\
+	unsigned long x = value;					\
+									\
+	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {            \
+		asm volatile (".option push\n"				\
+			      ".option arch,+zbb\n"			\
+			      "rev8 %0, %1\n"				\
+			      ".option pop\n"				\
+			      : "=r" (x) : "r" (x));			\
+		x = x >> (BITS_PER_LONG - size);			\
+	} else {                                                        \
+		x = ___constant_swab##size(value);                      \
+	}								\
+	x;								\
+})
+
+static __always_inline __u16 __arch_swab16(__u16 value)
+{
+	return ARCH_SWAB(16, value);
+}
+
+static __always_inline __u32 __arch_swab32(__u32 value)
+{
+	return ARCH_SWAB(32, value);
+}
+
+#ifdef CONFIG_64BIT
+static __always_inline __u64 __arch_swab64(__u64 value)
+{
+	return ARCH_SWAB(64, value);
+}
+#else
+static __always_inline __u64 __arch_swab64(__u64 value)
+{
+	__u32 h = value >> 32;
+	__u32 l = value & ((1ULL << 32) - 1);
+
+	return ((__u64)(__arch_swab32(l)) << 32) | ((__u64)(__arch_swab32(h)));
+}
+#endif
+
+#define __arch_swab64 __arch_swab64
+#define __arch_swab32 __arch_swab32
+#define __arch_swab16 __arch_swab16
+
+#undef ___constant_swab16
+#undef ___constant_swab32
+#undef ___constant_swab64
+
+#undef ARCH_SWAB
+
+#endif /* defined(CONFIG_TOOLCHAIN_HAS_ZBB) && defined(CONFIG_RISCV_ISA_ZBB) && !defined(NO_ALTERNATIVE) */
+#endif /* _ASM_RISCV_SWAB_H */

---
base-commit: 155a3c003e555a7300d156a5252c004c392ec6b0
change-id: 20250307-riscv-swab-b81b94a9ac1b

Best regards,
-- 
Ignacio Encinas <ignacio@iencinas.com>



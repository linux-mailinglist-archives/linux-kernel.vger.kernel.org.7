Return-Path: <linux-kernel+bounces-621585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52743A9DB9C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 16:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC433B779B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4D325D1F9;
	Sat, 26 Apr 2025 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="Cynu4gWm"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962CA25CC57
	for <linux-kernel@vger.kernel.org>; Sat, 26 Apr 2025 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745679403; cv=none; b=r7UDHL9aQ/4GFjkjbKsq4+FYsU5PYI2fHKfbqLYrIIayUC0r5L3rBfUmeBjs/Y3sQJmYVv8nNtqJQ7YHpaWjbGDZtqZQEWz6neghTGB3QeQGYH2r19tKOfekGacu48M/PcQFnlEi3oefTc7Ci4HqHBPSgQnILBrc7Ff/+q8u8W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745679403; c=relaxed/simple;
	bh=khH4WkE0mEFj9busZOZ8flLqC6GG3A9JhSqOV9SegDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hDXkuzUZs+DFpv0JL/7/H/9w4eqWwt8rHam8hPGnjMflFriihcea0KF9p+bm4/HJ+JAsOBqJNd6223E86OyHBIWdU8bkcO0xbV/lOx3uJCFg7nbwVhCgYz0FF4iSFStjrORcF8jU4zP14tjfnoITY7FlMeOBtn35K17HBRNeM+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=Cynu4gWm; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1745679399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2kGESmUc5K4aE63sF+pKXsYXoXR44233ot7fuIdc7eY=;
	b=Cynu4gWmcHLMMh351vsuhpvZBlrDwJN2/KOCWh5A3hAyULSfEYOXSXewFSphEDseSyuP9v
	dV5Ez5gCNMYOGlS9N7LgVeLYvDcFg6l2yidT5oVjD1MP3cAjs6lIaoQFy255/djZqLMx37
	G83QxgEd0YA1aGKOmeVxETiwZUeGNIwZsUTBcEmLzwJtaBzNYnFm+w0Z1Po1YDt/HTDHjd
	XxaVGqV5dHAc3WFg/6Via63St3EqkjbAL7xjS6/HpMVwuQ+HztkXazkwfzMulJrFU0d7oE
	hHMdeeMGEGIrtqbVJoZlO0baceoMVP8T9ygPzWF0yGpS5s4bHSx38JYsZ1rH/w==
From: Ignacio Encinas <ignacio@iencinas.com>
Date: Sat, 26 Apr 2025 16:56:19 +0200
Subject: [PATCH v4 2/2] riscv: introduce asm/swab.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250426-riscv-swab-v4-2-64201404a68c@iencinas.com>
References: <20250426-riscv-swab-v4-0-64201404a68c@iencinas.com>
In-Reply-To: <20250426-riscv-swab-v4-0-64201404a68c@iencinas.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
 skhan@linuxfoundation.org, Zhihang Shao <zhihang.shao.iscas@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 linux-arch@vger.kernel.org, Ignacio Encinas <ignacio@iencinas.com>
X-Migadu-Flow: FLOW_OUT

Implement endianness swap macros for RISC-V.

Use the rev8 instruction when Zbb is available. Otherwise, rely on the
default mask-and-shift implementation.

Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
---
 arch/riscv/include/asm/swab.h | 62 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/riscv/include/asm/swab.h b/arch/riscv/include/asm/swab.h
new file mode 100644
index 000000000000..629f6164c1f3
--- /dev/null
+++ b/arch/riscv/include/asm/swab.h
@@ -0,0 +1,62 @@
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
+#if defined(CONFIG_RISCV_ISA_ZBB) && !defined(NO_ALTERNATIVE)
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
+#undef ARCH_SWAB
+
+#endif /* defined(CONFIG_RISCV_ISA_ZBB) && !defined(NO_ALTERNATIVE) */
+#endif /* _ASM_RISCV_SWAB_H */

-- 
2.49.0



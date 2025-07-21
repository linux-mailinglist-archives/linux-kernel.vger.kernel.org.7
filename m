Return-Path: <linux-kernel+bounces-738927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3F0B0BF21
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04EDD3BE690
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F77A28A1E2;
	Mon, 21 Jul 2025 08:36:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDEF28A1C0
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753087006; cv=none; b=TzZfI0pR9+RxL6PaT30gcPM36v27Mi066SXuYZt2JBN6Laci/zxHt58VypSCtmUACDzAZMvhwZLd78vqmlyEHnVeK1EPRLqBfhkuePt6pcVyl+iV4ncCUFXvcGoSi0TD1up2Sxf5+6qhBawaWurcf1DhyUXCLOLbqGy066z/FCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753087006; c=relaxed/simple;
	bh=1Pq3fWCbMme7can5L1VXxkKY/ixp6vJKLVRm1fVwo3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ArzTOHtlxPrZ4nB3zRzALBaWwQx+IA/JCkQVKUeGDJAKDA9HWxFy7NcDx8zzzwsnXhfoRbBAkiVyg5eBt6j4ID2GYrKCmDBRvtygWysQ1icXHwf0LCtj5bWsE44TuVKm8OsfE+RcHMraoPgg+1YjXnIb34NlXh++G6oMG5SWUDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F56E153B;
	Mon, 21 Jul 2025 01:36:39 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2758F3F66E;
	Mon, 21 Jul 2025 01:36:43 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	ardb@kernel.org,
	frederic@kernel.org,
	james.morse@arm.com,
	joey.gouly@arm.com,
	scott@os.amperecomputing.com,
	maz@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v4 6/7] arm64/asm: introduce lsui.h
Date: Mon, 21 Jul 2025 09:36:17 +0100
Message-Id: <20250721083618.2743569-7-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250721083618.2743569-1-yeoreum.yun@arm.com>
References: <20250721083618.2743569-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces lsui.h header file for applying runtime patch
to use load/store unprevileged instructions when cpu supports
FEAT_LSUI otherwise uses method implemented via ll/sc way with
clearing PSTATE.PAN bit

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/include/asm/lsui.h | 37 +++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 arch/arm64/include/asm/lsui.h

diff --git a/arch/arm64/include/asm/lsui.h b/arch/arm64/include/asm/lsui.h
new file mode 100644
index 000000000000..39bf232f3eb7
--- /dev/null
+++ b/arch/arm64/include/asm/lsui.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Arm Ltd.
+ */
+#ifndef __ASM_LSUI_H
+#define __ASM_LSUI_H
+
+#define LL_SC_MAX_LOOPS	128 /* What's the largest number you can think of? */
+
+#include <asm/futex_ll_sc_u.h>
+
+#ifdef CONFIG_AS_HAS_LSUI
+
+#define __LSUI_PREAMBLE	".arch_extension lsui\n"
+
+#include <linux/compiler_types.h>
+#include <linux/export.h>
+#include <linux/stringify.h>
+#include <asm/alternative.h>
+#include <asm/alternative-macros.h>
+#include <asm/cpucaps.h>
+
+#include <asm/futex_lsui.h>
+
+#define __lsui_ll_sc_u_body(op, ...)					\
+({									\
+	alternative_has_cap_likely(ARM64_HAS_LSUI) ?		\
+		__lsui_##op(__VA_ARGS__) :				\
+		__ll_sc_u_##op(__VA_ARGS__);				\
+})
+
+#else	/* CONFIG_AS_HAS_LSUI */
+
+#define __lsui_ll_sc_u_body(op, ...)		__ll_sc_u_##op(__VA_ARGS__)
+
+#endif	/* CONFIG_AS_HAS_LSUI */
+#endif	/* __ASM_LSUI_H */
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}



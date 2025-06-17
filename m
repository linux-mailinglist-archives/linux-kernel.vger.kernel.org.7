Return-Path: <linux-kernel+bounces-690735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A55ADDB85
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 20:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1013318867B4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 18:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB112EE98D;
	Tue, 17 Jun 2025 18:36:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8083F2EAB81
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750185409; cv=none; b=eXzrtfKx06x+PvvnZBWDJ2ERmRxZ1zfp4jLxbLjE2Wz9Y1rzc3VIcnnJWDFs6tGf1WmjbPCDTkxiurwKUSrJc8OZYA6Dazlr4jpcdBb1zrJBTUiHGzrT73XEW4yflVlJcoIRmABQ1sKfq0oHU9Licj1FEcyYZ1GEyw+5+mhQ+AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750185409; c=relaxed/simple;
	bh=Xty6o4O/6jE/zrmvBD8pJ9Znos7innQaLeWnUhWql2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EqweOB7I5MrZtMZi85/RZk5d6OZ4WPC/mkxWMTBlapuys/Fjf1lG9x33M/5OqPG5tLOtWX8sjHT7S+fUaua9L5X36Fpg6qwce2MeLlOZMNKb7ljf29VUqu8h52fvTDp87t9OZj43D8UoVgEuwcniYfUF7n9NUU2FCaRBOUnWoXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 337111595;
	Tue, 17 Jun 2025 11:36:26 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4993D3F58B;
	Tue, 17 Jun 2025 11:36:45 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	ardb@kernel.org,
	frederic@kernel.org,
	james.morse@arm.com,
	joey.gouly@arm.com,
	scott@os.amperecomputing.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v3 4/7] arm64/futex: move futex atomic logic with clearing PAN bit
Date: Tue, 17 Jun 2025 19:36:32 +0100
Message-Id: <20250617183635.1266015-5-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617183635.1266015-1-yeoreum.yun@arm.com>
References: <20250617183635.1266015-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move current futex atomic logics which uses ll/sc method with cleraing
PSTATE.PAN to separate file (futex_ll_sc_u.h) so that
former method will be used only when FEAT_LSUI isn't supported.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/include/asm/futex_ll_sc_u.h | 115 +++++++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 arch/arm64/include/asm/futex_ll_sc_u.h

diff --git a/arch/arm64/include/asm/futex_ll_sc_u.h b/arch/arm64/include/asm/futex_ll_sc_u.h
new file mode 100644
index 000000000000..6702ba66f1b2
--- /dev/null
+++ b/arch/arm64/include/asm/futex_ll_sc_u.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Arm Ltd.
+ */
+#ifndef __ASM_FUTEX_LL_SC_U_H
+#define __ASM_FUTEX_LL_SC_U_H
+
+#include <linux/uaccess.h>
+#include <linux/stringify.h>
+
+#define FUTEX_ATOMIC_OP(op, asm_op)					\
+static __always_inline int						\
+__ll_sc_u_futex_atomic_##op(int oparg, u32 __user *uaddr, int *oval)	\
+{									\
+	unsigned int loops = LL_SC_MAX_LOOPS;				\
+	int ret, val, tmp;						\
+									\
+	uaccess_enable_privileged();					\
+	asm volatile("// __ll_sc_u_futex_atomic_" #op "\n"		\
+	"	prfm	pstl1strm, %2\n"				\
+	"1:	ldxr	%w1, %2\n"					\
+	"	" #asm_op "	%w3, %w1, %w5\n"			\
+	"2:	stlxr	%w0, %w3, %2\n"					\
+	"	cbz	%w0, 3f\n"					\
+	"	sub	%w4, %w4, %w0\n"				\
+	"	cbnz	%w4, 1b\n"					\
+	"	mov	%w0, %w6\n"					\
+	"3:\n"								\
+	"	dmb	ish\n"						\
+	_ASM_EXTABLE_UACCESS_ERR(1b, 3b, %w0)				\
+	_ASM_EXTABLE_UACCESS_ERR(2b, 3b, %w0)				\
+	: "=&r" (ret), "=&r" (val), "+Q" (*uaddr), "=&r" (tmp),		\
+	  "+r" (loops)							\
+	: "r" (oparg), "Ir" (-EAGAIN)					\
+	: "memory");							\
+	uaccess_disable_privileged();					\
+									\
+	if (!ret)							\
+		*oval = val;						\
+									\
+	return ret;							\
+}
+
+FUTEX_ATOMIC_OP(add, add)
+FUTEX_ATOMIC_OP(or, orr)
+FUTEX_ATOMIC_OP(and, and)
+FUTEX_ATOMIC_OP(eor, eor)
+
+#undef FUTEX_ATOMIC_OP
+
+static __always_inline int
+__ll_sc_u_futex_atomic_set(int oparg, u32 __user *uaddr, int *oval)
+{
+	unsigned int loops = LL_SC_MAX_LOOPS;
+	int ret, val;
+
+	uaccess_enable_privileged();
+	asm volatile("//__ll_sc_u_futex_xchg\n"
+	"	prfm	pstl1strm, %2\n"
+	"1:	ldxr	%w1, %2\n"
+	"2:	stlxr	%w0, %w4, %2\n"
+	"	cbz	%w3, 3f\n"
+	"	sub	%w3, %w3, %w0\n"
+	"	cbnz	%w3, 1b\n"
+	"	mov	%w0, %w5\n"
+	"3:\n"
+	"	dmb	ish\n"
+	_ASM_EXTABLE_UACCESS_ERR(1b, 3b, %w0)
+	_ASM_EXTABLE_UACCESS_ERR(2b, 3b, %w0)
+	: "=&r" (ret), "=&r" (val), "+Q" (*uaddr), "+r" (loops)
+	: "r" (oparg), "Ir" (-EAGAIN)
+	: "memory");
+	uaccess_disable_privileged();
+
+	if (!ret)
+		*oval = val;
+
+	return ret;
+}
+
+static __always_inline int
+__ll_sc_u_futex_cmpxchg(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
+{
+	int ret = 0;
+	unsigned int loops = LL_SC_MAX_LOOPS;
+	u32 val, tmp;
+
+	uaccess_enable_privileged();
+	asm volatile("//__ll_sc_u_futex_cmpxchg\n"
+	"	prfm	pstl1strm, %2\n"
+	"1:	ldxr	%w1, %2\n"
+	"	eor	%w3, %w1, %w5\n"
+	"	cbnz	%w3, 4f\n"
+	"2:	stlxr	%w3, %w6, %2\n"
+	"	cbz	%w3, 3f\n"
+	"	sub	%w4, %w4, %w3\n"
+	"	cbnz	%w4, 1b\n"
+	"	mov	%w0, %w7\n"
+	"3:\n"
+	"	dmb	ish\n"
+	"4:\n"
+	_ASM_EXTABLE_UACCESS_ERR(1b, 4b, %w0)
+	_ASM_EXTABLE_UACCESS_ERR(2b, 4b, %w0)
+	: "+r" (ret), "=&r" (val), "+Q" (*uaddr), "=&r" (tmp), "+r" (loops)
+	: "r" (oldval), "r" (newval), "Ir" (-EAGAIN)
+	: "memory");
+	uaccess_disable_privileged();
+
+	if (!ret)
+		*oval = val;
+
+	return ret;
+}
+
+#endif /* __ASM_FUTEX_LL_SC_U_H */
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}



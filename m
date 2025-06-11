Return-Path: <linux-kernel+bounces-681986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24D6AD5A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 17:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A947817B0B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 15:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A311D86D6;
	Wed, 11 Jun 2025 15:12:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB731DB375
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654732; cv=none; b=UYz0ebZd5o3HpLqqxv3sf59ib1VduKRQ8dd9J/utXo4eVvP7BSBxaPQePn3r2JzL/iiGh67fj5ui2Zyf07c5K1FsuIIUYDWAgBcGBG/jFfPBrmDMycjzzBVI55w775ymWXhqmJyOtD80fP/7BNTqwghflBo1Xrrj2yOMU6U6suc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654732; c=relaxed/simple;
	bh=Xty6o4O/6jE/zrmvBD8pJ9Znos7innQaLeWnUhWql2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bt5Xd+37IuWWraJvC5hJHUSuVnt+gkuQV3NVB0Ku1AIyCCfFZmJafbc9MfXrGK8fx+xC7SNK4PHOUNE4J/AMZGb/8BAKTtr2P2lh2X8ocBWhFzwsW5cwUk8N0rXMzUSTHxiMQvp9JlbU3omEqCYyeVDm4qBBgjJAVjOGFQ3K/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD71115A1;
	Wed, 11 Jun 2025 08:11:49 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 751703F59E;
	Wed, 11 Jun 2025 08:12:07 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	broonie@kernel.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	ardb@kernel.org,
	frederic@kernel.org,
	james.morse@arm.com,
	joey.gouly@arm.com,
	scott@os.amperecomputing.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v2 3/6] arm64/futex: move futex atomic logic with clearing PAN bit
Date: Wed, 11 Jun 2025 16:11:51 +0100
Message-Id: <20250611151154.46362-4-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611151154.46362-1-yeoreum.yun@arm.com>
References: <20250611151154.46362-1-yeoreum.yun@arm.com>
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



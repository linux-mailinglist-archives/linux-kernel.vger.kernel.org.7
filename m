Return-Path: <linux-kernel+bounces-772122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12988B28F04
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F4D7BE6C5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466752FAC01;
	Sat, 16 Aug 2025 15:19:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3693A2F9C44
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755357586; cv=none; b=t4mzOukkgYwSxOCumhcUgHe/0CTjN40HNv1+28nc0P9/54z0lnzUS23l4nGLsMB5LFjRFRFOnK7gTgb5bIgSLRG7uddZfuDXkSV0QrF/C33G0+dl1v9xnwSi2X26UwcBC0vUassWJ0g6bKnOJHKqAqlv/pDa3Kg0HfPQjViS7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755357586; c=relaxed/simple;
	bh=4tVwnujaVzmf9D4FqWqzPkXwte1Rmun7X3lZ81BPefc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F9xbk0Ig245CgwRkfI6pid3j25xWfSV3/ibFitjdlo5lXujgvvxsXUS4aa0gc8M6sJXaPcFNlvjYaz5AzTKZTGDRe1RD+/9lP6IgbaIWUSVu7lZJVb1ENogTnD6ohO2cjjPPrSNJ2AIOFW+T0AoKL88zwqUAE/QIFX2r2PGzgQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 713441688;
	Sat, 16 Aug 2025 08:19:36 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6894A3F5A1;
	Sat, 16 Aug 2025 08:19:42 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	broonie@kernel.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	james.morse@arm.com,
	ardb@kernel.org,
	scott@os.amperecomputing.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH RESEND v7 4/6] arm64: futex: refactor futex atomic operation
Date: Sat, 16 Aug 2025 16:19:27 +0100
Message-Id: <20250816151929.197589-5-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250816151929.197589-1-yeoreum.yun@arm.com>
References: <20250816151929.197589-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor futex atomic operations using ll/sc method with
clearing PSTATE.PAN to prepare to apply FEAT_LSUI on them.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/include/asm/futex.h | 132 +++++++++++++++++++++------------
 1 file changed, 84 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
index bc06691d2062..ab7003cb4724 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -7,17 +7,21 @@

 #include <linux/futex.h>
 #include <linux/uaccess.h>
+#include <linux/stringify.h>

 #include <asm/errno.h>

-#define FUTEX_MAX_LOOPS	128 /* What's the largest number you can think of? */
+#define LLSC_MAX_LOOPS	128 /* What's the largest number you can think of? */

-#define __futex_atomic_op(insn, ret, oldval, uaddr, tmp, oparg)		\
-do {									\
-	unsigned int loops = FUTEX_MAX_LOOPS;				\
+#define LLSC_FUTEX_ATOMIC_OP(op, insn)					\
+static __always_inline int						\
+__llsc_futex_atomic_##op(int oparg, u32 __user *uaddr, int *oval)	\
+{									\
+	unsigned int loops = LLSC_MAX_LOOPS;				\
+	int ret, oldval, tmp;						\
 									\
 	uaccess_enable_privileged();					\
-	asm volatile(							\
+	asm volatile("// __llsc_futex_atomic_" #op "\n"			\
 "	prfm	pstl1strm, %2\n"					\
 "1:	ldxr	%w1, %2\n"						\
 	insn "\n"							\
@@ -35,45 +39,103 @@ do {									\
 	: "r" (oparg), "Ir" (-EAGAIN)					\
 	: "memory");							\
 	uaccess_disable_privileged();					\
-} while (0)
+									\
+	if (!ret)							\
+		*oval = oldval;						\
+									\
+	return ret;							\
+}
+
+LLSC_FUTEX_ATOMIC_OP(add, "add	%w3, %w1, %w5")
+LLSC_FUTEX_ATOMIC_OP(or, "orr	%w3, %w1, %w5")
+LLSC_FUTEX_ATOMIC_OP(and, "and	%w3, %w1, %w5")
+LLSC_FUTEX_ATOMIC_OP(eor, "eor	%w3, %w1, %w5")
+LLSC_FUTEX_ATOMIC_OP(set, "mov	%w3, %w5")
+
+static __always_inline int
+__llsc_futex_cmpxchg(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
+{
+	int ret = 0;
+	unsigned int loops = LLSC_MAX_LOOPS;
+	u32 val, tmp;
+
+	uaccess_enable_privileged();
+	asm volatile("//__llsc_futex_cmpxchg\n"
+"	prfm	pstl1strm, %2\n"
+"1:	ldxr	%w1, %2\n"
+"	eor	%w3, %w1, %w5\n"
+"	cbnz	%w3, 4f\n"
+"2:	stlxr	%w3, %w6, %2\n"
+"	cbz	%w3, 3f\n"
+"	sub	%w4, %w4, %w3\n"
+"	cbnz	%w4, 1b\n"
+"	mov	%w0, %w7\n"
+"3:\n"
+"	dmb	ish\n"
+"4:\n"
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
+#define FUTEX_ATOMIC_OP(op)						\
+static __always_inline int						\
+__futex_atomic_##op(int oparg, u32 __user *uaddr, int *oval)		\
+{									\
+	return __llsc_futex_atomic_##op(oparg, uaddr, oval);		\
+}
+
+FUTEX_ATOMIC_OP(add)
+FUTEX_ATOMIC_OP(or)
+FUTEX_ATOMIC_OP(and)
+FUTEX_ATOMIC_OP(eor)
+FUTEX_ATOMIC_OP(set)
+
+static __always_inline int
+__futex_cmpxchg(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
+{
+	return __llsc_futex_cmpxchg(uaddr, oldval, newval, oval);
+}

 static inline int
 arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *_uaddr)
 {
-	int oldval = 0, ret, tmp;
-	u32 __user *uaddr = __uaccess_mask_ptr(_uaddr);
+	int ret;
+	u32 __user *uaddr;

 	if (!access_ok(_uaddr, sizeof(u32)))
 		return -EFAULT;

+	uaddr = __uaccess_mask_ptr(_uaddr);
+
 	switch (op) {
 	case FUTEX_OP_SET:
-		__futex_atomic_op("mov	%w3, %w5",
-				  ret, oldval, uaddr, tmp, oparg);
+		ret = __futex_atomic_set(oparg, uaddr, oval);
 		break;
 	case FUTEX_OP_ADD:
-		__futex_atomic_op("add	%w3, %w1, %w5",
-				  ret, oldval, uaddr, tmp, oparg);
+		ret = __futex_atomic_add(oparg, uaddr, oval);
 		break;
 	case FUTEX_OP_OR:
-		__futex_atomic_op("orr	%w3, %w1, %w5",
-				  ret, oldval, uaddr, tmp, oparg);
+		ret = __futex_atomic_or(oparg, uaddr, oval);
 		break;
 	case FUTEX_OP_ANDN:
-		__futex_atomic_op("and	%w3, %w1, %w5",
-				  ret, oldval, uaddr, tmp, ~oparg);
+		ret = __futex_atomic_and(~oparg, uaddr, oval);
 		break;
 	case FUTEX_OP_XOR:
-		__futex_atomic_op("eor	%w3, %w1, %w5",
-				  ret, oldval, uaddr, tmp, oparg);
+		ret = __futex_atomic_eor(oparg, uaddr, oval);
 		break;
 	default:
 		ret = -ENOSYS;
 	}

-	if (!ret)
-		*oval = oldval;
-
 	return ret;
 }

@@ -81,40 +143,14 @@ static inline int
 futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *_uaddr,
 			      u32 oldval, u32 newval)
 {
-	int ret = 0;
-	unsigned int loops = FUTEX_MAX_LOOPS;
-	u32 val, tmp;
 	u32 __user *uaddr;

 	if (!access_ok(_uaddr, sizeof(u32)))
 		return -EFAULT;

 	uaddr = __uaccess_mask_ptr(_uaddr);
-	uaccess_enable_privileged();
-	asm volatile("// futex_atomic_cmpxchg_inatomic\n"
-"	prfm	pstl1strm, %2\n"
-"1:	ldxr	%w1, %2\n"
-"	sub	%w3, %w1, %w5\n"
-"	cbnz	%w3, 4f\n"
-"2:	stlxr	%w3, %w6, %2\n"
-"	cbz	%w3, 3f\n"
-"	sub	%w4, %w4, %w3\n"
-"	cbnz	%w4, 1b\n"
-"	mov	%w0, %w7\n"
-"3:\n"
-"	dmb	ish\n"
-"4:\n"
-	_ASM_EXTABLE_UACCESS_ERR(1b, 4b, %w0)
-	_ASM_EXTABLE_UACCESS_ERR(2b, 4b, %w0)
-	: "+r" (ret), "=&r" (val), "+Q" (*uaddr), "=&r" (tmp), "+r" (loops)
-	: "r" (oldval), "r" (newval), "Ir" (-EAGAIN)
-	: "memory");
-	uaccess_disable_privileged();
-
-	if (!ret)
-		*uval = val;

-	return ret;
+	return __futex_cmpxchg(uaddr, oldval, newval, uval);
 }

 #endif /* __ASM_FUTEX_H */
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}



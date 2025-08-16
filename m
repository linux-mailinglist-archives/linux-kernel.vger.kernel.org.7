Return-Path: <linux-kernel+bounces-772111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ABFB28ECF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D1A1CC55BD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FB12F9C2E;
	Sat, 16 Aug 2025 15:13:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A3D2F99A2
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755357225; cv=none; b=gdp3MW+BtOlzPK1MNeLJ3BeatQrEt726JJwBLbayOckRQfLPpMv4TzKWJL6LxeOJx2hJwFPkZxPLl1NQA+p4IePYHNP1RaMrytf9AE4bunZ/J1xyOdbocF0c+rplg2LWTC7ZFMg0NbWF1FXaray0On6QeH8iF+0nL5C1h3EXp3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755357225; c=relaxed/simple;
	bh=bxGJuEjvPjF4yFrCWGj1q5In9+QiCT/patkRplFoqiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MH/MFfB4pyShN1titWOgtWdbxOgx6a+oL4q/fYKqbQQFushUNTCykpc9vXSRBUBMplrQ+8JYt5DeDSMEq+pZtow6M23J2qks2cmKl8tOHcbWJaOAusEkJkaSLWJEWalNy2K1Ax9v1fSU9ZsRFVUTkuhsBOSNQb256ti7qCep2Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F06C61691;
	Sat, 16 Aug 2025 08:13:35 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E77643F5A1;
	Sat, 16 Aug 2025 08:13:41 -0700 (PDT)
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
Subject: [PATCH v7 5/6] arm64: futex: small optimisation for __llsc_futex_atomic_set()
Date: Sat, 16 Aug 2025 16:13:25 +0100
Message-Id: <20250816151326.195587-6-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250816151326.195587-5-yeoreum.yun@arm.com>
References: <20250816151326.195587-1-yeoreum.yun@arm.com>
 <20250816151326.195587-2-yeoreum.yun@arm.com>
 <20250816151326.195587-3-yeoreum.yun@arm.com>
 <20250816151326.195587-4-yeoreum.yun@arm.com>
 <20250816151326.195587-5-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__llsc_futex_atomic_set() is implmented using
LLSC_FUTEX_ATOMIC_OP() macro with "mov  %w3, %w5".
But this instruction isn't required to implement fux_atomic_set()
so make a small optimisation by implementing __llsc_futex_atomic_set()
as separate function.

This will make usage of LLSC_FUTEX_ATOMIC_OP() macro more simple.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/include/asm/futex.h | 43 ++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
index ab7003cb4724..22a6301a9f3d 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -13,7 +13,7 @@
 
 #define LLSC_MAX_LOOPS	128 /* What's the largest number you can think of? */
 
-#define LLSC_FUTEX_ATOMIC_OP(op, insn)					\
+#define LLSC_FUTEX_ATOMIC_OP(op, asm_op)				\
 static __always_inline int						\
 __llsc_futex_atomic_##op(int oparg, u32 __user *uaddr, int *oval)	\
 {									\
@@ -24,7 +24,7 @@ __llsc_futex_atomic_##op(int oparg, u32 __user *uaddr, int *oval)	\
 	asm volatile("// __llsc_futex_atomic_" #op "\n"			\
 "	prfm	pstl1strm, %2\n"					\
 "1:	ldxr	%w1, %2\n"						\
-	insn "\n"							\
+"	" #asm_op "	%w3, %w1, %w5\n"				\
 "2:	stlxr	%w0, %w3, %2\n"						\
 "	cbz	%w0, 3f\n"						\
 "	sub	%w4, %w4, %w0\n"					\
@@ -46,11 +46,40 @@ __llsc_futex_atomic_##op(int oparg, u32 __user *uaddr, int *oval)	\
 	return ret;							\
 }
 
-LLSC_FUTEX_ATOMIC_OP(add, "add	%w3, %w1, %w5")
-LLSC_FUTEX_ATOMIC_OP(or, "orr	%w3, %w1, %w5")
-LLSC_FUTEX_ATOMIC_OP(and, "and	%w3, %w1, %w5")
-LLSC_FUTEX_ATOMIC_OP(eor, "eor	%w3, %w1, %w5")
-LLSC_FUTEX_ATOMIC_OP(set, "mov	%w3, %w5")
+LLSC_FUTEX_ATOMIC_OP(add, add)
+LLSC_FUTEX_ATOMIC_OP(or, orr)
+LLSC_FUTEX_ATOMIC_OP(and, and)
+LLSC_FUTEX_ATOMIC_OP(eor, eor)
+
+static __always_inline int
+__llsc_futex_atomic_set(int oparg, u32 __user *uaddr, int *oval)
+{
+	unsigned int loops = LLSC_MAX_LOOPS;
+	int ret, oldval;
+
+	uaccess_enable_privileged();
+	asm volatile("//__llsc_futex_xchg\n"
+"	prfm	pstl1strm, %2\n"
+"1:	ldxr	%w1, %2\n"
+"2:	stlxr	%w0, %w4, %2\n"
+"	cbz	%w3, 3f\n"
+"	sub	%w3, %w3, %w0\n"
+"	cbnz	%w3, 1b\n"
+"	mov	%w0, %w5\n"
+"3:\n"
+"	dmb	ish\n"
+	_ASM_EXTABLE_UACCESS_ERR(1b, 3b, %w0)
+	_ASM_EXTABLE_UACCESS_ERR(2b, 3b, %w0)
+	: "=&r" (ret), "=&r" (oldval), "+Q" (*uaddr), "+r" (loops)
+	: "r" (oparg), "Ir" (-EAGAIN)
+	: "memory");
+	uaccess_disable_privileged();
+
+	if (!ret)
+		*oval = oldval;
+
+	return ret;
+}
 
 static __always_inline int
 __llsc_futex_cmpxchg(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}



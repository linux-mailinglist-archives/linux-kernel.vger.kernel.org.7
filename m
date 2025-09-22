Return-Path: <linux-kernel+bounces-827040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47CBB8FFC0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5972A1418
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820372FE58F;
	Mon, 22 Sep 2025 10:23:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550863009D4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536585; cv=none; b=Pa3RSN1pXNZcVItrPEMLQVxvvUIrkwMtWpyBDeiBJbkzXDYtjBGpUYaIedyV+q6cFFqD4DUxgdZV/NZNnsbHWVokf0FhBz4GvD7OquRoFTQ4MIAUiJD8wGoDNVbjvVZe9NWW91YHBtzQHNH+WpHi53r/uWEC+QGlVecPCAqdFrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536585; c=relaxed/simple;
	bh=+cttgyCvPZgqqI+cXrQZqwMLdb8U9U1WNJj5VLXe5F4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YpyfgMd6Z6kY/oELdYUgzEv9ODfZvMjDEdktVxRH/VArak6izzqOMMJvIVb+MWctw9Ddckg1OQSt1ELi4DyE7S9zlkwy7mxD2O0MMFcnwa3fSzL/Vu6+tx5a4rrGp+sGMPkaSz9mXJ/F3fLO8GtKw/2xQoU64rb1goaf7ZmKX3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA7391515;
	Mon, 22 Sep 2025 03:22:54 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9A9433F66E;
	Mon, 22 Sep 2025 03:23:00 -0700 (PDT)
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
Subject: [PATCH v9 5/5] arm64: futex: support futex with FEAT_LSUI
Date: Mon, 22 Sep 2025 11:22:44 +0100
Message-Id: <20250922102244.2068414-6-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922102244.2068414-1-yeoreum.yun@arm.com>
References: <20250922102244.2068414-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current futex atomic operations are implemented with ll/sc instructions
and clearing PSTATE.PAN.

Since Armv9.6, FEAT_LSUI supplies not only load/store instructions but
also atomic operation for user memory access in kernel it doesn't need
to clear PSTATE.PAN bit anymore.

With theses instructions some of futex atomic operations don't need to
be implmented with ldxr/stlxr pair instead can be implmented with
one atomic operation supplied by FEAT_LSUI.

However, some of futex atomic operation don't have matched
instructuion i.e) eor or cmpxchg with word size.
For those operation, uses cas{al}t to implement them.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/include/asm/futex.h | 178 ++++++++++++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
index f8cb674bdb3f..ee79944df6fe 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -9,6 +9,8 @@
 #include <linux/uaccess.h>
 #include <linux/stringify.h>
 
+#include <asm/alternative.h>
+#include <asm/alternative-macros.h>
 #include <asm/errno.h>
 
 #define FUTEX_MAX_LOOPS	128 /* What's the largest number you can think of? */
@@ -86,11 +88,185 @@ __llsc_futex_cmpxchg(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
 	return ret;
 }
 
+#ifdef CONFIG_AS_HAS_LSUI
+
+/*
+ * When the LSUI feature is present, the CPU also implements PAN, because
+ * FEAT_PAN has been mandatory since Armv8.1. Therefore, there is no need to
+ * call uaccess_ttbr0_enable()/uaccess_ttbr0_disable() around each LSUI
+ * operation.
+ */
+
+#define __LSUI_PREAMBLE	".arch_extension lsui\n"
+
+#define LSUI_FUTEX_ATOMIC_OP(op, asm_op, mb)				\
+static __always_inline int						\
+__lsui_futex_atomic_##op(int oparg, u32 __user *uaddr, int *oval)	\
+{									\
+	int ret = 0;							\
+	int oldval;							\
+									\
+	asm volatile("// __lsui_futex_atomic_" #op "\n"			\
+	__LSUI_PREAMBLE							\
+"1:	" #asm_op #mb "	%w3, %w2, %1\n"					\
+"2:\n"									\
+	_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w0)				\
+	: "+r" (ret), "+Q" (*uaddr), "=r" (oldval)			\
+	: "r" (oparg)							\
+	: "memory");							\
+									\
+	if (!ret)							\
+		*oval = oldval;						\
+									\
+	return ret;							\
+}
+
+LSUI_FUTEX_ATOMIC_OP(add, ldtadd, al)
+LSUI_FUTEX_ATOMIC_OP(or, ldtset, al)
+LSUI_FUTEX_ATOMIC_OP(andnot, ldtclr, al)
+LSUI_FUTEX_ATOMIC_OP(set, swpt, al)
+
+static __always_inline int
+__lsui_cmpxchg64(u64 __user *uaddr, u64 *oldval, u64 newval)
+{
+	int ret = 0;
+
+	asm volatile("// __lsui_cmpxchg64\n"
+	__LSUI_PREAMBLE
+"1:	casalt	%x2, %x3, %1\n"
+"2:\n"
+	_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w0)
+	: "+r" (ret), "+Q" (*uaddr), "+r" (*oldval)
+	: "r" (newval)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline int
+__lsui_cmpxchg32(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
+{
+	u64 __user *uaddr64;
+	bool futex_on_lo;
+	int ret = -EAGAIN, i;
+	u32 other, orig_other;
+	union {
+		struct futex_on_lo {
+			u32 val;
+			u32 other;
+		} lo_futex;
+
+		struct futex_on_hi {
+			u32 other;
+			u32 val;
+		} hi_futex;
+
+		u64 raw;
+	} oval64, orig64, nval64;
+
+	uaddr64 = (u64 __user *) PTR_ALIGN_DOWN(uaddr, sizeof(u64));
+	futex_on_lo = (IS_ALIGNED((unsigned long)uaddr, sizeof(u64)) ==
+			IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN));
+
+	for (i = 0; i < FUTEX_MAX_LOOPS; i++) {
+		if (get_user(oval64.raw, uaddr64))
+			return -EFAULT;
+
+		nval64.raw = oval64.raw;
+
+		if (futex_on_lo) {
+			oval64.lo_futex.val = oldval;
+			nval64.lo_futex.val = newval;
+		} else {
+			oval64.hi_futex.val = oldval;
+			nval64.hi_futex.val = newval;
+		}
+
+		orig64.raw = oval64.raw;
+
+		if (__lsui_cmpxchg64(uaddr64, &oval64.raw, nval64.raw))
+			return -EFAULT;
+
+		if (futex_on_lo) {
+			oldval = oval64.lo_futex.val;
+			other = oval64.lo_futex.other;
+			orig_other = orig64.lo_futex.other;
+		} else {
+			oldval = oval64.hi_futex.val;
+			other = oval64.hi_futex.other;
+			orig_other = orig64.hi_futex.other;
+		}
+
+		if (other == orig_other) {
+			ret = 0;
+			break;
+		}
+	}
+
+	if (!ret)
+		*oval = oldval;
+
+	return ret;
+}
+
+static __always_inline int
+__lsui_futex_atomic_and(int oparg, u32 __user *uaddr, int *oval)
+{
+	return __lsui_futex_atomic_andnot(~oparg, uaddr, oval);
+}
+
+static __always_inline int
+__lsui_futex_atomic_eor(int oparg, u32 __user *uaddr, int *oval)
+{
+	u32 oldval, newval, val;
+	int ret, i;
+
+	/*
+	 * there are no ldteor/stteor instructions...
+	 */
+	for (i = 0; i < FUTEX_MAX_LOOPS; i++) {
+		if (get_user(oldval, uaddr))
+			return -EFAULT;
+
+		newval = oldval ^ oparg;
+
+		ret = __lsui_cmpxchg32(uaddr, oldval, newval, &val);
+		if (ret)
+			return ret;
+
+		if (val == oldval) {
+			*oval = val;
+			return 0;
+		}
+	}
+
+	return -EAGAIN;
+}
+
+static __always_inline int
+__lsui_futex_cmpxchg(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
+{
+	return __lsui_cmpxchg32(uaddr, oldval, newval, oval);
+}
+
+#define __lsui_llsc_body(op, ...)					\
+({									\
+	alternative_has_cap_likely(ARM64_HAS_LSUI) ?			\
+		__lsui_##op(__VA_ARGS__) : __llsc_##op(__VA_ARGS__);	\
+})
+
+#else	/* CONFIG_AS_HAS_LSUI */
+
+#define __lsui_llsc_body(op, ...)	__llsc_##op(__VA_ARGS__)
+
+#endif	/* CONFIG_AS_HAS_LSUI */
+
+
 #define FUTEX_ATOMIC_OP(op)						\
 static __always_inline int						\
 __futex_atomic_##op(int oparg, u32 __user *uaddr, int *oval)		\
 {									\
-	return __llsc_futex_atomic_##op(oparg, uaddr, oval);		\
+	return __lsui_llsc_body(futex_atomic_##op, oparg, uaddr, oval);	\
 }
 
 FUTEX_ATOMIC_OP(add)
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}



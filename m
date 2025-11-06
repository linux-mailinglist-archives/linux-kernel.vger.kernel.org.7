Return-Path: <linux-kernel+bounces-888922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE02C3C4A2
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D00423C36
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF134887C;
	Thu,  6 Nov 2025 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="auuKwiOQ"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554AA304BB9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445274; cv=none; b=Lv8NABUVieOkHlZeByFMFfBoGCFKnKirj/r4C9nQ1adz9UzG3psln5ahKTkLcwn/UHgcNUAtyZt2scLiW40Vu3p562qJleuvOHJLOWKCKsmVdawfhaW8FOUCu4mKDjMR366eFq3bykW7z10rbqKNrE2WRxstG6GXPiCJpJ/Ct+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445274; c=relaxed/simple;
	bh=AqltwXlRApVL7XO/vDtahYD4sZveWnpr5NrsXbhIMqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDbj2PqVzVmSny/BcboaoD+czc0gzxLnVReVBZxNXtkx/86op4lcfACCcJg/MI8Nrvv5ZLdl+tTMfbfkFBz4FaCW84G4VWPp3QFIJ1v4oNUXgdl5fRFkjh4oGCeHgTGyTEjyq1K8/sFIgW2YKkueRsXagqbelQ6kHw55TPCRYhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=auuKwiOQ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/NZcAZhP4Zghdyd2BfdRPY7JveQ+oefPRtoJSjHbAAM=; b=auuKwiOQJ53h1UklL7LaJUlfOX
	HFpGrt2YbbO+V951ZW/zaPHmismr3D0FWvwPp2NxFfVd8SW0jZ6J3QA8t4R+E7PhAvWh79lEqcsDc
	UwdiMuKvmACVoZfSMbRsr4VYIyvJJv2C6wvl+gt1QwkywW62hd+ViIypPjbn1wNVN6RBdCueeEVos
	Ak14yFFAee7gzMV87tDVTlI4J7hikC7iI/pkp1lM5/7pU+7bT8HmUpHv6d0jcbqFVI9ZJliQwMksD
	r1oQxDw8zV2cULo7+zS8FmFppeC7XvRtQ0BTWxUmJw2aLEiO+RRGZ6RtT6YatFeUJb+KftnjBLQIy
	9Ayp2yAg==;
Received: from [191.8.29.151] (helo=steammachine)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vH2WV-0034gL-B9; Thu, 06 Nov 2025 17:07:43 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Ryan Houdek <houdek.ryan@fex-emu.org>,
	Billy Laws <blaws05@gmail.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [RFC PATCH 1/1] arch: arm64: Implement unaligned atomic emulation
Date: Thu,  6 Nov 2025 13:07:35 -0300
Message-ID: <20251106160735.2638485-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251106160735.2638485-1-andrealmeid@igalia.com>
References: <20251106160735.2638485-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement support for emulating unaligned atomic operations on arm64.
User applications that wish to enable support for this should use the
pctrl() flag `PR_ARM64_UNALIGN_ATOMIC_EMULATE`.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 arch/arm64/include/asm/exception.h   |   1 +
 arch/arm64/include/asm/processor.h   |   3 +
 arch/arm64/include/asm/thread_info.h |   1 +
 arch/arm64/kernel/Makefile           |   2 +-
 arch/arm64/kernel/process.c          |  15 +
 arch/arm64/kernel/unaligned_atomic.c | 520 +++++++++++++++++++++++++++
 arch/arm64/mm/fault.c                |  10 +
 include/uapi/linux/prctl.h           |   5 +
 kernel/sys.c                         |   7 +-
 9 files changed, 562 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/kernel/unaligned_atomic.c

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index a2da3cb21c24..f6dd1b9afe69 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -82,6 +82,7 @@ void do_sp_pc_abort(unsigned long addr, unsigned long esr, struct pt_regs *regs)
 void bad_el0_sync(struct pt_regs *regs, int reason, unsigned long esr);
 void do_el0_cp15(unsigned long esr, struct pt_regs *regs);
 int do_compat_alignment_fixup(unsigned long addr, struct pt_regs *regs);
+int do_unaligned_atomic_fixup(struct pt_regs *regs, u64 *fault_addr);
 void do_el0_svc(struct pt_regs *regs);
 void do_el0_svc_compat(struct pt_regs *regs);
 void do_el0_fpac(struct pt_regs *regs, unsigned long esr);
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 61d62bfd5a7b..bc62a690cd00 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -437,5 +437,8 @@ int set_tsc_mode(unsigned int val);
 #define GET_TSC_CTL(adr)        get_tsc_mode((adr))
 #define SET_TSC_CTL(val)        set_tsc_mode((val))
 
+int set_unalign_atomic_ctl(unsigned int val);
+#define ARM64_SET_UNALIGN_ATOMIC_CTL(val)	set_unalign_atomic_ctl((val))
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index f241b8601ebd..636a44d72064 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -86,6 +86,7 @@ void arch_setup_new_exec(void);
 #define TIF_TSC_SIGSEGV		30	/* SIGSEGV on counter-timer access */
 #define TIF_LAZY_MMU		31	/* Task in lazy mmu mode */
 #define TIF_LAZY_MMU_PENDING	32	/* Ops pending for lazy mmu mode exit */
+#define TIF_UNALIGN_ATOMIC_EMULATE	33
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 76f32e424065..54ce606d0552 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -34,7 +34,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o	\
 			   syscall.o proton-pack.o idle.o patching.o pi/	\
-			   rsi.o jump_label.o
+			   rsi.o jump_label.o unaligned_atomic.o
 
 obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
 					   sys_compat.o
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 95d4bb848096..c47ec1ac8fe2 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -967,3 +967,18 @@ int set_tsc_mode(unsigned int val)
 
 	return do_set_tsc_mode(val);
 }
+
+int set_unalign_atomic_ctl(unsigned int val)
+{
+	unsigned long valid_mask = PR_ARM64_UNALIGN_ATOMIC_EMULATE;
+	if (val & ~valid_mask)
+		return -EINVAL;
+
+	/*
+	 * TODO: check if this is running in a ARM v8.1 or greater.
+	 * Refuse otherwise.
+	 */
+
+	update_thread_flag(TIF_UNALIGN_ATOMIC_EMULATE, val & PR_ARM64_UNALIGN_ATOMIC_EMULATE);
+	return 0;
+}
diff --git a/arch/arm64/kernel/unaligned_atomic.c b/arch/arm64/kernel/unaligned_atomic.c
new file mode 100644
index 000000000000..fc1a7f4ddfdd
--- /dev/null
+++ b/arch/arm64/kernel/unaligned_atomic.c
@@ -0,0 +1,520 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Unaligned atomic emulation by André Almeida <andrealmeid@igalia.com>
+ * Derived from original work by Billy Laws <blaws05@gmail.com>
+ */
+
+#include <linux/cacheflush.h>
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/semaphore.h>
+#include <linux/uaccess.h>
+
+#include <asm/alternative-macros.h>
+#include <asm/asm-extable.h>
+#include <asm/exception.h>
+#include <asm/ptrace.h>
+#include <asm/traps.h>
+
+#define __LOAD_ACQUIRE_RCPC(sfx, regs...) \
+	ALTERNATIVE("ldar" #sfx "\t" #regs,     \
+			".arch_extension rcpc\n"    \
+			"ldapr" #sfx "\t" #regs,    \
+			ARM64_HAS_LDAPR)
+
+struct fault_info {
+	int error;
+	u64 addr;
+	u64 size;
+};
+
+#define ATOMIC_MEM_MASK 0x3b200c00
+#define ATOMIC_MEM_INST 0x38200000
+
+#define RCPC2_MASK  0x3fe00c00
+#define LDAPUR_INST 0x19400000
+#define STLUR_INST  0x19000000
+
+#define LDAXR_MASK 0x3ffffc00
+
+#define LDAXP_MASK 0xbfff8000
+#define LDAXP_INST 0x887f8000
+
+#define LDAR_INST  0x08dffc00
+#define LDAPR_INST 0x38bfc000
+#define STLR_INST  0x089ffc00
+
+#define ATOMIC_ADD_OP	0x0
+#define ATOMIC_CLR_OP	0x1
+#define ATOMIC_EOR_OP	0x2
+#define ATOMIC_SET_OP	0x3
+#define ATOMIC_SWAP_OP	0x8
+
+#define get_reg(gprs, reg) (reg == 31 ? 0 : gprs[reg])
+#define set_reg(gprs, reg, val) do { if (reg != 31) gprs[reg] = val; } while (0)
+
+#define get_addr_reg(instr) ((instr >> 5) & 0b11111)
+#define get_size(instr) (1 << (instr >> 30))
+
+static DEFINE_MUTEX(buslock);
+
+static struct fault_info do_load_acquire_128(u64 addr, u128 *result)
+{
+	u64 lower, upper, orig_addr = addr;
+	int ret;
+
+	addr = (u64)__uaccess_mask_ptr((void __user *)addr);
+
+	if (!access_ok((void __user *)orig_addr, 16))
+		return (struct fault_info) {.error = -EFAULT, .addr = orig_addr, .size = 16};
+
+	uaccess_enable_privileged();
+	asm volatile("1: ldaxp %[resultlower], %[resultupper], [%[addr]]\n"
+			"   clrex\n"
+			"2:\n"
+			_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w[ret])
+			: [resultlower] "=r"(lower), [resultupper] "=r"(upper), [ret] "+r"(ret)
+			: [addr] "r"(addr)
+			: "memory");
+	uaccess_disable_privileged();
+
+	if (ret)
+		return (struct fault_info) {.error = ret, .addr = orig_addr, .size = 16};
+
+	*result = (u128)upper << 64 | lower;
+
+	return (struct fault_info) {0};
+}
+
+/*
+ * Do a load acquire at address `addr` and save it at `result`
+ */
+static struct fault_info do_load_acquire_64(u64 addr, u64 *result)
+{
+	u64 orig_addr = addr;
+	int ret = 0;
+
+	addr = (u64)__uaccess_mask_ptr((void __user *)addr);
+
+	if (!access_ok((void __user *)orig_addr, 8))
+		return (struct fault_info) {.error = -EFAULT, .addr = orig_addr, .size = 8};
+
+	uaccess_enable_privileged();
+	asm volatile("1: " __LOAD_ACQUIRE_RCPC(, %[result], [%[addr]]) "\n"
+			"2:\n"
+			_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w[ret])
+			: [result] "=r"(*result), [ret] "+r"(ret)
+			: [addr] "r"(addr)
+			: "memory");
+	uaccess_disable_privileged();
+
+	return (struct fault_info) {.error = ret, .addr = orig_addr, .size = 8};
+}
+
+/*
+ * If *expected value is found in addr, swap it for val
+ * Otherwise, write the value found at addr at expected address
+ */
+static struct fault_info do_store_cas_64(u64 *expected, u64 val, u64 addr)
+{
+	u64 orig_addr = addr, tmp, oldval;
+	int ret = 0;
+
+	addr = (u64)__uaccess_mask_ptr((void __user *)addr);
+
+	if (!access_ok((void __user *)orig_addr, 8))
+		return (struct fault_info) {.error = -EFAULT, .addr = orig_addr, .size = 8};
+
+	uaccess_enable_privileged();
+	asm volatile("1: ldxr %[oldval], [%[addr]]\n"
+			"   cmp  %[oldval], %[expected]\n"
+			"   b.ne 3f\n"
+			"2: stlxr %w[tmp], %[val], [%[addr]]\n"
+			"   cbnz %w[tmp], 1b\n"
+			"3:\n"
+			_ASM_EXTABLE_UACCESS_ERR(1b, 3b, %w[ret])
+			_ASM_EXTABLE_UACCESS_ERR(2b, 3b, %w[ret])
+			: [tmp] "=&r"(tmp), [oldval] "=&r"(oldval), [ret] "+r"(ret)
+			: [addr] "r"(addr), [expected] "r"(*expected), [val] "r"(val)
+			: "memory", "cc");
+	uaccess_disable_privileged();
+
+	if (ret)
+		return (struct fault_info) {.error = ret, .addr = orig_addr, .size = 8};
+
+	if (oldval != *expected) {
+		*expected = oldval;
+		return (struct fault_info) {.error = -EAGAIN};
+	}
+
+	return (struct fault_info) {0};
+}
+
+/*
+ * If possible, do one 128 bit load. Otherwise, do two 64 bit loads and combine
+ * the results.
+ */
+static struct fault_info do_load_64(u64 addr, u64 *result)
+{
+	u64 alignment_mask = 0b1111, align_offset = addr & alignment_mask;
+	struct fault_info fi = {0};
+	u128 tmp;
+
+	/* The address crosses a 16 byte boundary and needs two loads */
+	if (align_offset > 8) {
+		u64 alignment = addr & 0b111, upper_val, lower_val;
+
+		addr &= ~0b111ULL;
+
+		fi = do_load_acquire_64(addr + 8, &upper_val);
+		if (fi.error)
+			return fi;
+
+		fi = do_load_acquire_64(addr, &lower_val);
+		if (fi.error)
+			return fi;
+
+		tmp = ((u128) upper_val << 64) | lower_val;
+		*result = tmp >> (alignment * 8);
+	} else {
+		addr &= ~alignment_mask;
+
+		fi = do_load_acquire_128(addr, &tmp);
+		if (fi.error)
+			return fi;
+
+		*result = tmp >> (align_offset * 8);
+	}
+
+	return fi;
+}
+
+static u64 do_atomic_mem_op(u8 op, u64 src_val, u64 desired)
+{
+	switch (op) {
+	case ATOMIC_ADD_OP:
+		return src_val + desired;
+	case ATOMIC_CLR_OP:
+		return src_val & ~desired;
+	case ATOMIC_EOR_OP:
+		return src_val & desired;
+	case ATOMIC_SET_OP:
+		return src_val ^ desired;
+	case ATOMIC_SWAP_OP:
+		return desired;
+	default:
+		BUG();
+	}
+
+	/* Unreachable */
+	return 0;
+}
+
+static struct fault_info load_cas(u64 desired_src, u64 addr, u8 op, u64 alignment,
+				     u128 *aux_desired, u128 *aux_expected,
+				     u128 *aux_actual)
+{
+	u128 tmp_expected, tmp_desired, tmp_actual, mask = ~0ULL, desired, expected, neg_mask;
+	u64 addr_upper, load_order_upper, load_order_lower;
+	struct fault_info fi;
+
+	mask <<= alignment * 8;
+	addr_upper = addr + 8;
+	neg_mask = ~mask;
+
+	fi = do_load_acquire_64(addr_upper, &load_order_upper);
+	if (fi.error)
+		return fi;
+	fi = do_load_acquire_64(addr, &load_order_lower);
+	if (fi.error)
+		return fi;
+
+	tmp_actual = (u128)load_order_upper << 64 | load_order_lower;
+
+	desired = do_atomic_mem_op(op, tmp_actual >> (alignment * 8), desired_src);
+	expected = (tmp_actual >> (alignment * 8));
+
+	tmp_expected = tmp_actual;
+	tmp_expected &= neg_mask;
+	tmp_expected |= expected << (alignment * 8);
+
+	tmp_desired = tmp_expected;
+	tmp_desired &= neg_mask;
+	tmp_desired |= desired << (alignment * 8);
+
+	*aux_desired = tmp_desired;
+	*aux_expected = tmp_expected;
+	*aux_actual = tmp_actual;
+
+	return (struct fault_info) {0};
+}
+
+/*
+ * After CAS failed, check if we need to try again or if we should return error.
+ * Returns true if needs to retry.
+ */
+static bool handle_fail(u128 tmp_expected, u128 tmp_desired, u128 mask,
+			u64 *result, bool retry, bool tear,
+			u64 alignment)
+{
+	u128 neg_mask = ~mask,
+	     failed_result_our_bits = tmp_expected & mask,
+	     failed_result_not_our_bits = tmp_expected & neg_mask,
+	     failed_desired_not_our_bits = tmp_desired & neg_mask;
+	u64 failed_result = failed_result_our_bits >> (alignment * 8);
+
+	/*
+	 * If the bits changed weren't part of our regular CAS, then we retry.
+	 */
+	if ((failed_result_not_our_bits ^ failed_desired_not_our_bits) != 0)
+		return true;
+
+	/*
+	 * This happens in the case that between load and CAS that something has
+	 * store our desired in to the memory location. This means our CAS fails
+	 * because what we wanted to store was already stored.
+	 */
+	if (retry) {
+		/* If we are retrying and tearing then we can't do anything */
+		if (tear) {
+			*result = failed_result;
+			return false;
+		} else {
+			return true;
+		}
+	} else {
+		/*
+		 * With we were called without retry, then we have failed
+		 * regardless of tear. CAS failed but handled successfully
+		 */
+		*result = failed_result;
+	}
+
+	return false;
+}
+
+/*
+ * This instruction reads a 64-bit doubleword from memory, and compares it
+ * against the value held in a first register. If the comparison is equal, the
+ * value in a second register is written to memory. If the comparison is not
+ * equal, the architecture permits writing the value read from the location to
+ * memory.
+ *
+ * To handle an unaligned CAS, the code first loads two 64-bit words. Then, if
+ * what is found in the word is the same as the expected value, the code tries
+ * to do two 64-bit writes in the address. If both stores works then return
+ * success. If only the first store works, then the code is in a "tear" state
+ * and returns with the word found in the address.
+ *
+ * TODO: here we threat every operation as it's a cross cache address,
+ * meaning that we need two 64 bit ops to make it work. That works for
+ * all cases, but it's slower and unnecessary for the cases that doesn't
+ * cross it and can do a single 128 bit operation.
+ */
+static struct fault_info do_cas_64(bool retry, u64 desired_src, u64 expected_src,
+				   u64 addr, u8 op, u64 *result)
+{
+	u128 tmp_expected, tmp_desired, tmp_actual, mask = ~0ULL;
+	u64 alignment = addr & 0b111, addr_upper;
+	struct fault_info fi;
+	bool tear = false;
+
+	mask <<= alignment * 8;
+	addr &= ~0b111ULL;
+	addr_upper = addr + 8;
+
+	/*
+	 * TODO: take this lock only if we need to emulate a split lock
+	 */
+	guard(mutex)(&buslock);
+
+retry:
+	fi = load_cas(desired_src, addr, op, alignment, &tmp_desired, &tmp_expected, &tmp_actual);
+	if (fi.error)
+		return fi;
+
+	if (tmp_expected == tmp_actual) {
+		u128 expected = (tmp_actual >> (alignment * 8));
+		u64 tmp_expected_lower = tmp_expected,
+		    tmp_expected_upper = tmp_expected >> 64,
+		    tmp_desired_lower = tmp_desired,
+		    tmp_desired_upper = tmp_desired >> 64;
+
+		fi = do_store_cas_64(&tmp_expected_upper, tmp_desired_upper, addr_upper);
+		if (fi.error && fi.error != -EAGAIN)
+			return fi;
+
+		if (fi.error == 0) {
+			fi = do_store_cas_64(&tmp_expected_lower, tmp_desired_lower, addr);
+			if (fi.error && fi.error != -EAGAIN)
+				return fi;
+
+			/* Both store() worked, CAS succeeded */
+			if (fi.error == 0) {
+				*result = expected;
+				return fi;
+			/* A partial store() happened, tear state */
+			} else {
+				tear = true;
+			}
+		}
+
+		tmp_expected = tmp_expected_upper;
+		tmp_expected <<= 64;
+		tmp_expected |= tmp_expected_lower;
+	} else {
+		tmp_expected = tmp_actual;
+	}
+
+	if (handle_fail(tmp_expected, tmp_desired, mask, result, retry, tear, alignment))
+		goto retry;
+
+	return (struct fault_info) {0};
+}
+
+/*
+ * For a giving atomic memory operation, parse it and call the desired op
+ */
+static struct fault_info handle_atomic_mem_op(u32 instr, u64 *gprs)
+{
+	u32 size = get_size(instr), result_reg = instr & 0b11111,
+		   source_reg = (instr >> 16) & 0b11111,
+		   addr_reg = get_addr_reg(instr);
+	u64 addr = get_reg(gprs, addr_reg);
+	u8 op = (instr >> 12) & 0xf;
+	struct fault_info fi = {0};
+
+	if (size == 8) {
+		u64 res = 0;
+
+		switch (op) {
+		case ATOMIC_ADD_OP:
+		case ATOMIC_CLR_OP:
+		case ATOMIC_EOR_OP:
+		case ATOMIC_SET_OP:
+		case ATOMIC_SWAP_OP:
+			break;
+		default:
+			pr_warn("Unhandled atomic mem op 0x%02x\n", op);
+			return (struct fault_info) {.error = -EINVAL};
+		}
+
+		fi = do_cas_64(true, get_reg(gprs, source_reg), 0, addr, op, &res);
+
+		/*
+		 * If the operation succeeded and our dest reg is not zero, we
+		 * need to update the result reg with what was in memory
+		 */
+		if (!fi.error)
+			set_reg(gprs, result_reg, res);
+	} else {
+		fi.error = -EINVAL;
+	}
+
+	return fi;
+}
+
+static struct fault_info handle_atomic_load(u32 instr, u64 *gprs, s64 offset)
+{
+	u32 size = get_size(instr), result_reg = instr & 0b11111,
+		   addr_reg = get_addr_reg(instr);
+	u64 addr = get_reg(gprs, addr_reg) + offset, res;
+
+	struct fault_info fi = {0};
+
+	if (size == 8) {
+		fi = do_load_64(addr, &res);
+		if (!fi.error)
+			set_reg(gprs, result_reg, res);
+	} else {
+		fi.error = -EINVAL;
+	}
+
+	return fi;
+}
+
+static struct fault_info handle_atomic_store(u32 instr, u64 *gprs, s64 offset)
+{
+	u32 size = get_size(instr), data_reg = instr & 0x1F, addr_reg = get_addr_reg(instr);
+	u64 addr = get_reg(gprs, addr_reg) + offset;
+	struct fault_info fi = {0};
+
+	if (size == 8) {
+		u64 res;
+
+		fi = do_cas_64(false, get_reg(gprs, data_reg), 0, addr, ATOMIC_SWAP_OP, &res);
+	} else {
+		fi.error = -EINVAL;
+	}
+
+	return fi;
+}
+
+static struct fault_info decode_instruction(u32 instr, u64 *gprs)
+{
+	struct fault_info fi = {0};
+	s32 offset = (s32)(instr) << 11 >> 23, size = get_size(instr);
+
+	/* TODO: We only support 64-bit instructions for now */
+	if (size != 8)
+		goto exit;
+
+	if ((instr & LDAXR_MASK) == LDAR_INST || (instr & LDAXR_MASK) == LDAPR_INST)
+		return handle_atomic_load(instr, gprs, 0);
+
+	if ((instr & LDAXR_MASK) == STLR_INST)
+		return  handle_atomic_store(instr, gprs, 0);
+
+	if ((instr & RCPC2_MASK) == LDAPUR_INST)
+		return handle_atomic_load(instr, gprs, offset);
+
+	if ((instr & RCPC2_MASK) == STLUR_INST)
+		return handle_atomic_store(instr, gprs, offset);
+
+	if ((instr & ATOMIC_MEM_MASK) == ATOMIC_MEM_INST)
+		return handle_atomic_mem_op(instr, gprs);
+
+	/* TODO: Handle CASAL and CASPAL as well */
+
+exit:
+	fi.error = -EINVAL;
+	return fi;
+}
+
+/*
+ * After a fault access happened, move the pointer to the end of the bad section
+ */
+static void increment_fault_address(u64 **fault_addr, int size)
+{
+	u64 *addr = *fault_addr;
+	u8 tmp;
+	int i;
+
+	for (i = 0; i < size - 1 && !get_user(tmp, (u8 __user *)(addr + i)); i++)
+		(*fault_addr)++;
+}
+
+int do_unaligned_atomic_fixup(struct pt_regs *regs, u64 *fault_addr)
+{
+	u32 *pc = (u32 *)regs->pc, instr;
+	u64 *gprs = (u64 *)regs->regs;
+	struct fault_info fi;
+
+	if (get_user(instr, (u32 __user *)(pc)))
+		return -EFAULT;
+
+	fi = decode_instruction(instr, gprs);
+
+	if (fi.error) {
+		*fault_addr = fi.addr;
+		if (fi.error == -EFAULT)
+			increment_fault_address(&fault_addr, fi.size);
+
+		return fi.error;
+	}
+
+	arm64_skip_faulting_instruction(regs, 4);
+	return 0;
+}
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index d816ff44faff..7bd93aaa5140 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -798,6 +798,16 @@ static int do_alignment_fault(unsigned long far, unsigned long esr,
 	if (IS_ENABLED(CONFIG_COMPAT_ALIGNMENT_FIXUPS) &&
 	    compat_user_mode(regs))
 		return do_compat_alignment_fixup(far, regs);
+
+	if (user_mode(regs) && test_thread_flag(TIF_UNALIGN_ATOMIC_EMULATE)) {
+		u64 page_fault_address;
+		int ret = do_unaligned_atomic_fixup(regs, &page_fault_address);
+
+		if (!ret)
+			return 0;
+		else if (ret == -EFAULT)
+			return do_translation_fault(page_fault_address, ESR_ELx_FSC_FAULT | ESR_ELx_WNR, regs);
+	}
 	do_bad_area(far, esr, regs);
 	return 0;
 }
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 51c4e8c82b1e..1202ce10e386 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -386,4 +386,9 @@ struct prctl_mm_map {
 # define PR_FUTEX_HASH_SET_SLOTS	1
 # define PR_FUTEX_HASH_GET_SLOTS	2
 
+#define PR_ARM64_SET_UNALIGN_ATOMIC 0x46455849
+# define PR_ARM64_UNALIGN_ATOMIC_EMULATE	(1UL << 0)
+# define PR_ARM64_UNALIGN_ATOMIC_BACKPATCH	(1UL << 1)
+# define PR_ARM64_UNALIGN_ATOMIC_STRICT_SPLIT_LOCKS	(1UL << 2)
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 8b58eece4e58..5966ce4a075c 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -158,7 +158,9 @@
 #ifndef PPC_SET_DEXCR_ASPECT
 # define PPC_SET_DEXCR_ASPECT(a, b, c)	(-EINVAL)
 #endif
-
+#ifndef ARM64_SET_UNALIGN_ATOMIC_CTL
+# define ARM64_SET_UNALIGN_ATOMIC_CTL(a)		(-EINVAL)
+#endif
 /*
  * this is where the system-wide overflow UID and GID are defined, for
  * architectures that now have 32-bit UID/GID but didn't in the past
@@ -2868,6 +2870,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_FUTEX_HASH:
 		error = futex_hash_prctl(arg2, arg3, arg4);
 		break;
+	case PR_ARM64_SET_UNALIGN_ATOMIC:
+		error = ARM64_SET_UNALIGN_ATOMIC_CTL(arg2);
+		break;
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error = -EINVAL;
-- 
2.51.1



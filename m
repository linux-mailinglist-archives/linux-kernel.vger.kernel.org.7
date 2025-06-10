Return-Path: <linux-kernel+bounces-678728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3857AD2D56
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 07:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE363AE93F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 05:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A773225E81D;
	Tue, 10 Jun 2025 05:31:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F4425F785
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 05:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749533510; cv=none; b=l0Bn1hYIU/Bn1fSrOShm5b8er0xtIQhCX5jqDI9V2Uncf9rhlIT+91vMC6+PxRXMq5zOYvL3P0+sqA+u+LTyNaT0IsOl9lLkGRhKP95cwMFUzazq+Te2csDxPEgGi5/wx8v9IqC8t4IJaSaVxPI6NultcDwUTPknno104RbyGOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749533510; c=relaxed/simple;
	bh=KboGtS/QhdEOkGmEM/YVgdu8Xv7IF9+rEoKSC1df1b0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qHKgYe4aRXYqt1UAWR8p/BRBW/hy54Irv+yL8+Q1NnHiptxZI1ZMKmhIzwjHuhNTgBh9lesWMjCRB/Qc9eysT4XLZLIX2zicX7DoEBZRlJjYYSNfsQne5s4uUGeg6pdh/dR0ci4ergxRuUsytyP3NDQRZMHspsPp8AqxeoA2j/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 438AB16A3;
	Mon,  9 Jun 2025 22:31:23 -0700 (PDT)
Received: from a076716.blr.arm.com (a076716.blr.arm.com [10.164.21.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 04C153F59E;
	Mon,  9 Jun 2025 22:31:39 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/2] arm64/debug: Drop redundant DBG_MDSCR_* macros
Date: Tue, 10 Jun 2025 11:01:27 +0530
Message-Id: <20250610053128.4118784-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250610053128.4118784-1-anshuman.khandual@arm.com>
References: <20250610053128.4118784-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MDSCR_EL1 has already been defined in tools sysreg format and hence can be
used in all debug monitor related call paths. Subsequently all DBG_MDSCR_*
macros become redundant and hence can be dropped off completely. While here
convert all variables handling MDSCR_EL1 register as u64 which reflects its
true width as well.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/assembler.h      |  4 ++--
 arch/arm64/include/asm/debug-monitors.h |  6 ------
 arch/arm64/kernel/debug-monitors.c      | 22 +++++++++++-----------
 arch/arm64/kernel/entry-common.c        |  4 ++--
 4 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index ad63457a05c5..f229d96616e5 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -53,7 +53,7 @@
 	.macro	disable_step_tsk, flgs, tmp
 	tbz	\flgs, #TIF_SINGLESTEP, 9990f
 	mrs	\tmp, mdscr_el1
-	bic	\tmp, \tmp, #DBG_MDSCR_SS
+	bic	\tmp, \tmp, #MDSCR_EL1_SS
 	msr	mdscr_el1, \tmp
 	isb	// Take effect before a subsequent clear of DAIF.D
 9990:
@@ -63,7 +63,7 @@
 	.macro	enable_step_tsk, flgs, tmp
 	tbz	\flgs, #TIF_SINGLESTEP, 9990f
 	mrs	\tmp, mdscr_el1
-	orr	\tmp, \tmp, #DBG_MDSCR_SS
+	orr	\tmp, \tmp, #MDSCR_EL1_SS
 	msr	mdscr_el1, \tmp
 9990:
 	.endm
diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 8f6ba31b8658..1f37dd01482b 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -13,14 +13,8 @@
 #include <asm/ptrace.h>
 
 /* Low-level stepping controls. */
-#define DBG_MDSCR_SS		(1 << 0)
 #define DBG_SPSR_SS		(1 << 21)
 
-/* MDSCR_EL1 enabling bits */
-#define DBG_MDSCR_KDE		(1 << 13)
-#define DBG_MDSCR_MDE		(1 << 15)
-#define DBG_MDSCR_MASK		~(DBG_MDSCR_KDE | DBG_MDSCR_MDE)
-
 #define	DBG_ESR_EVT(x)		(((x) >> 27) & 0x7)
 
 /* AArch64 */
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 58f047de3e1c..08f1d02507cd 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -34,7 +34,7 @@ u8 debug_monitors_arch(void)
 /*
  * MDSCR access routines.
  */
-static void mdscr_write(u32 mdscr)
+static void mdscr_write(u64 mdscr)
 {
 	unsigned long flags;
 	flags = local_daif_save();
@@ -43,7 +43,7 @@ static void mdscr_write(u32 mdscr)
 }
 NOKPROBE_SYMBOL(mdscr_write);
 
-static u32 mdscr_read(void)
+static u64 mdscr_read(void)
 {
 	return read_sysreg(mdscr_el1);
 }
@@ -79,16 +79,16 @@ static DEFINE_PER_CPU(int, kde_ref_count);
 
 void enable_debug_monitors(enum dbg_active_el el)
 {
-	u32 mdscr, enable = 0;
+	u64 mdscr, enable = 0;
 
 	WARN_ON(preemptible());
 
 	if (this_cpu_inc_return(mde_ref_count) == 1)
-		enable = DBG_MDSCR_MDE;
+		enable = MDSCR_EL1_MDE;
 
 	if (el == DBG_ACTIVE_EL1 &&
 	    this_cpu_inc_return(kde_ref_count) == 1)
-		enable |= DBG_MDSCR_KDE;
+		enable |= MDSCR_EL1_KDE;
 
 	if (enable && debug_enabled) {
 		mdscr = mdscr_read();
@@ -100,16 +100,16 @@ NOKPROBE_SYMBOL(enable_debug_monitors);
 
 void disable_debug_monitors(enum dbg_active_el el)
 {
-	u32 mdscr, disable = 0;
+	u64 mdscr, disable = 0;
 
 	WARN_ON(preemptible());
 
 	if (this_cpu_dec_return(mde_ref_count) == 0)
-		disable = ~DBG_MDSCR_MDE;
+		disable = ~MDSCR_EL1_MDE;
 
 	if (el == DBG_ACTIVE_EL1 &&
 	    this_cpu_dec_return(kde_ref_count) == 0)
-		disable &= ~DBG_MDSCR_KDE;
+		disable &= ~MDSCR_EL1_KDE;
 
 	if (disable) {
 		mdscr = mdscr_read();
@@ -415,7 +415,7 @@ void kernel_enable_single_step(struct pt_regs *regs)
 {
 	WARN_ON(!irqs_disabled());
 	set_regs_spsr_ss(regs);
-	mdscr_write(mdscr_read() | DBG_MDSCR_SS);
+	mdscr_write(mdscr_read() | MDSCR_EL1_SS);
 	enable_debug_monitors(DBG_ACTIVE_EL1);
 }
 NOKPROBE_SYMBOL(kernel_enable_single_step);
@@ -423,7 +423,7 @@ NOKPROBE_SYMBOL(kernel_enable_single_step);
 void kernel_disable_single_step(void)
 {
 	WARN_ON(!irqs_disabled());
-	mdscr_write(mdscr_read() & ~DBG_MDSCR_SS);
+	mdscr_write(mdscr_read() & ~MDSCR_EL1_SS);
 	disable_debug_monitors(DBG_ACTIVE_EL1);
 }
 NOKPROBE_SYMBOL(kernel_disable_single_step);
@@ -431,7 +431,7 @@ NOKPROBE_SYMBOL(kernel_disable_single_step);
 int kernel_active_single_step(void)
 {
 	WARN_ON(!irqs_disabled());
-	return mdscr_read() & DBG_MDSCR_SS;
+	return mdscr_read() & MDSCR_EL1_SS;
 }
 NOKPROBE_SYMBOL(kernel_active_single_step);
 
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 7c1970b341b8..171f93f2494b 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -344,7 +344,7 @@ static DEFINE_PER_CPU(int, __in_cortex_a76_erratum_1463225_wa);
 
 static void cortex_a76_erratum_1463225_svc_handler(void)
 {
-	u32 reg, val;
+	u64 reg, val;
 
 	if (!unlikely(test_thread_flag(TIF_SINGLESTEP)))
 		return;
@@ -354,7 +354,7 @@ static void cortex_a76_erratum_1463225_svc_handler(void)
 
 	__this_cpu_write(__in_cortex_a76_erratum_1463225_wa, 1);
 	reg = read_sysreg(mdscr_el1);
-	val = reg | DBG_MDSCR_SS | DBG_MDSCR_KDE;
+	val = reg | MDSCR_EL1_SS | MDSCR_EL1_KDE;
 	write_sysreg(val, mdscr_el1);
 	asm volatile("msr daifclr, #8");
 	isb();
-- 
2.25.1



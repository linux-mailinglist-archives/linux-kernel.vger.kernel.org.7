Return-Path: <linux-kernel+bounces-656496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF4DABE6EF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 00:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB52A4C7CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 22:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFFA2620E4;
	Tue, 20 May 2025 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="et6zK3p3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6959261588;
	Tue, 20 May 2025 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780090; cv=none; b=kDqLh/tBsAIUWX7fEw3VkTPsZnlmfzqksvcbNBy1zMhTFdJXRePf6znAlT/en3vvf+ahOuEu2Jk2eXLyZkzmvyHpos+zGLrPxNioAiFIUCncDJ1pweQcTB1bJmixNkp8ZzKY098ooIB3l9fOjPRypfBOm0bGDHqckhcfpvjRum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780090; c=relaxed/simple;
	bh=De2YwkVc5JbJgGUVRzrj39R60riU62P53vG0PIGx1bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yi6HdqdQDXil5AxywVa/dL3kBXTDzg8qdWWbJiCJ3JwgmCpFzTSeTy1VWiB/efiIXuySba1NZqvp02OWJoDUBgKoiylfhmHcC7hV0cRgyicJDerKwa19z2aeltdGEYyXwz68htXwFsd0V2RAq59jfQhVp/0UdkdOZgYBfqTget0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=et6zK3p3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1A0C4CEEF;
	Tue, 20 May 2025 22:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747780090;
	bh=De2YwkVc5JbJgGUVRzrj39R60riU62P53vG0PIGx1bk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=et6zK3p3/iE+/hyH5tevDzMYjhAcPztTLKBL/fPy54ONgO19ZUTO+owN289eC/8LX
	 gJJFKTwdiMmG51sn6uCdIKO0dcECdzH52KiYszVYobKSZbLeYV8rr6JcQXtSg/nG1l
	 +u/5S9dk6TNxeJgOATlkDgyW/y6U7dDMDTpnyPwBCtg/Z6aPnq/wXwpPMcv0t3KkSp
	 kx+GGQev/z98/PGO+SKf4fGHZdo5/UOL4bBWwXfqp/nCez9H9aoa0E2WF2C6d+MJVw
	 S5jwmWxOI6sVvvpou02C9Y2qdS4vR7DkBwGmftNAnzr8dInbde4NTdAuVSQAS1GW4s
	 caGyaEN2gK7Tw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 20 May 2025 17:27:38 -0500
Subject: [PATCH v22 3/5] arm64: Handle BRBE booting requirements
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-arm-brbe-v19-v22-3-c1ddde38e7f8@kernel.org>
References: <20250520-arm-brbe-v19-v22-0-c1ddde38e7f8@kernel.org>
In-Reply-To: <20250520-arm-brbe-v19-v22-0-c1ddde38e7f8@kernel.org>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev
X-Mailer: b4 0.15-dev

From: Anshuman Khandual <anshuman.khandual@arm.com>

To use the Branch Record Buffer Extension (BRBE), some configuration is
necessary at EL3 and EL2. This patch documents the requirements and adds
the initial EL2 setup code, which largely consists of configuring the
fine-grained traps and initializing a couple of BRBE control registers.

Before this patch, __init_el2_fgt() would initialize HDFGRTR_EL2 and
HDFGWTR_EL2 with the same value, relying on the read/write trap controls
for a register occupying the same bit position in either register. The
'nBRBIDR' trap control only exists in bit 59 of HDFGRTR_EL2, while bit
59 of HDFGWTR_EL2 is RES0, and so this assumption no longer holds.

To handle HDFGRTR_EL2 and HDFGWTR_EL2 having (slightly) different bit
layouts, __init_el2_fgt() is changed to accumulate the HDFGRTR_EL2 and
HDFGWTR_EL2 control bits separately. While making this change the
open-coded value (1 << 62) is replaced with
HDFG{R,W}TR_EL2_nPMSNEVFR_EL1_MASK.

The BRBCR_EL1 and BRBCR_EL2 registers are unusual and require special
initialisation: even though they are subject to E2H renaming, both have
an effect regardless of HCR_EL2.TGE, even when running at EL2. So we
must initialize BRBCR_EL2 in case we run in nVHE mode. This is handled
in __init_el2_brbe() with a comment to explain the situation.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
[Mark: rewrite commit message, fix typo in comment]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Co-developed-by: "Rob Herring (Arm)" <robh@kernel.org>
Signed-off-by: "Rob Herring (Arm)" <robh@kernel.org>
---
v22:
- Reword booting.rst section name (s/feature/the/) and move next to
  other PMU related features instead of in the middle of SME features.
- Drop setting SYS_BRBCR_EL1
- Drop CONFIG_ARM64_BRBE ifdef
- Rework initialization of HFGITR_EL2

v20:
 - Document that MDCR_EL3.SBRBE can be 0b01 also
 - Fix "HDFGWTR_EL2 is RES0" in commit msg
---
 Documentation/arch/arm64/booting.rst | 21 +++++++++++
 arch/arm64/include/asm/el2_setup.h   | 71 ++++++++++++++++++++++++++++++++++--
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index dee7b6de864f..fbdc4b071755 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -388,6 +388,27 @@ Before jumping into the kernel, the following conditions must be met:
 
     - SMCR_EL2.EZT0 (bit 30) must be initialised to 0b1.
 
+  For CPUs with the Branch Record Buffer Extension (FEAT_BRBE):
+
+  - If EL3 is present:
+
+    - MDCR_EL3.SBRBE (bits 33:32) must be initialised to 0b01 or 0b11.
+
+  - If the kernel is entered at EL1 and EL2 is present:
+
+    - BRBCR_EL2.CC (bit 3) must be initialised to 0b1.
+    - BRBCR_EL2.MPRED (bit 4) must be initialised to 0b1.
+
+    - HDFGRTR_EL2.nBRBDATA (bit 61) must be initialised to 0b1.
+    - HDFGRTR_EL2.nBRBCTL  (bit 60) must be initialised to 0b1.
+    - HDFGRTR_EL2.nBRBIDR  (bit 59) must be initialised to 0b1.
+
+    - HDFGWTR_EL2.nBRBDATA (bit 61) must be initialised to 0b1.
+    - HDFGWTR_EL2.nBRBCTL  (bit 60) must be initialised to 0b1.
+
+    - HFGITR_EL2.nBRBIALL (bit 56) must be initialised to 0b1.
+    - HFGITR_EL2.nBRBINJ  (bit 55) must be initialised to 0b1.
+
   For CPUs with the Performance Monitors Extension (FEAT_PMUv3p9):
 
  - If EL3 is present:
diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 30f57b0334a3..c55a8bb8a961 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -189,6 +189,28 @@
 .Lskip_set_cptr_\@:
 .endm
 
+/*
+ * Configure BRBE to permit recording cycle counts and branch mispredicts.
+ *
+ * At any EL, to record cycle counts BRBE requires that both BRBCR_EL2.CC=1 and
+ * BRBCR_EL1.CC=1.
+ *
+ * At any EL, to record branch mispredicts BRBE requires that both
+ * BRBCR_EL2.MPRED=1 and BRBCR_EL1.MPRED=1.
+ *
+ * Set {CC,MPRED} in BRBCR_EL2 in case nVHE mode is used and we are
+ * executing in EL1.
+ */
+.macro __init_el2_brbe
+	mrs	x1, id_aa64dfr0_el1
+	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
+	cbz	x1, .Lskip_brbe_\@
+
+	mov_q	x0, BRBCR_ELx_CC | BRBCR_ELx_MPRED
+	msr_s	SYS_BRBCR_EL2, x0
+.Lskip_brbe_\@:
+.endm
+
 /* Disable any fine grained traps */
 .macro __init_el2_fgt
 	mrs	x1, id_aa64mmfr0_el1
@@ -196,20 +218,62 @@
 	cbz	x1, .Lskip_fgt_\@
 
 	mov	x0, xzr
+	mov	x2, xzr
 	mrs	x1, id_aa64dfr0_el1
 	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
 	cmp	x1, #3
 	b.lt	.Lskip_spe_fgt_\@
 	/* Disable PMSNEVFR_EL1 read and write traps */
-	orr	x0, x0, #(1 << 62)
+	orr	x0, x0, #HDFGRTR_EL2_nPMSNEVFR_EL1_MASK
+	orr	x2, x2, #HDFGWTR_EL2_nPMSNEVFR_EL1_MASK
 
 .Lskip_spe_fgt_\@:
+	mrs	x1, id_aa64dfr0_el1
+	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
+	cbz	x1, .Lskip_brbe_fgt_\@
+
+	/*
+	 * Disable read traps for the following registers
+	 *
+	 * [BRBSRC|BRBTGT|RBINF]_EL1
+	 * [BRBSRCINJ|BRBTGTINJ|BRBINFINJ|BRBTS]_EL1
+	 */
+	orr	x0, x0, #HDFGRTR_EL2_nBRBDATA_MASK
+
+	/*
+	 * Disable write traps for the following registers
+	 *
+	 * [BRBSRCINJ|BRBTGTINJ|BRBINFINJ|BRBTS]_EL1
+	 */
+	orr	x2, x2, #HDFGWTR_EL2_nBRBDATA_MASK
+
+	/* Disable read and write traps for [BRBCR|BRBFCR]_EL1 */
+	orr	x0, x0, #HDFGRTR_EL2_nBRBCTL_MASK
+	orr	x2, x2, #HDFGWTR_EL2_nBRBCTL_MASK
+
+	/* Disable read traps for BRBIDR_EL1 */
+	orr	x0, x0, #HDFGRTR_EL2_nBRBIDR_MASK
+
+.Lskip_brbe_fgt_\@:
 
 .Lset_debug_fgt_\@:
 	msr_s	SYS_HDFGRTR_EL2, x0
-	msr_s	SYS_HDFGWTR_EL2, x0
+	msr_s	SYS_HDFGWTR_EL2, x2
 
 	mov	x0, xzr
+	mov	x2, xzr
+
+	mrs	x1, id_aa64dfr0_el1
+	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
+	cbz	x1, .Lskip_brbe_insn_fgt_\@
+
+	/* Disable traps for BRBIALL instruction */
+	orr	x2, x2, #HFGITR_EL2_nBRBIALL_MASK
+
+	/* Disable traps for BRBINJ instruction */
+	orr	x2, x2, #HFGITR_EL2_nBRBINJ_MASK
+
+.Lskip_brbe_insn_fgt_\@:
 	mrs	x1, id_aa64pfr1_el1
 	ubfx	x1, x1, #ID_AA64PFR1_EL1_SME_SHIFT, #4
 	cbz	x1, .Lskip_sme_fgt_\@
@@ -250,7 +314,7 @@
 .Lset_fgt_\@:
 	msr_s	SYS_HFGRTR_EL2, x0
 	msr_s	SYS_HFGWTR_EL2, x0
-	msr_s	SYS_HFGITR_EL2, xzr
+	msr_s	SYS_HFGITR_EL2, x2
 
 	mrs	x1, id_aa64pfr0_el1		// AMU traps UNDEF without AMU
 	ubfx	x1, x1, #ID_AA64PFR0_EL1_AMU_SHIFT, #4
@@ -324,6 +388,7 @@
 	__init_el2_hcrx
 	__init_el2_timers
 	__init_el2_debug
+	__init_el2_brbe
 	__init_el2_lor
 	__init_el2_stage2
 	__init_el2_gicv3

-- 
2.47.2



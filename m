Return-Path: <linux-kernel+bounces-780375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18401B30100
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B5F189CE0C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D5D1DFCE;
	Thu, 21 Aug 2025 17:24:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2341331813A;
	Thu, 21 Aug 2025 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797071; cv=none; b=toeh0zDGYI18+eGaS8yuq42/bIWFh3O8abGBfaKLEFmNpVStX76/w0HP2r6w5GylGW8JZ+y11GI/oBidPpbbX3xg40c5Smc3Sta4Lr9bVIrdk1GkVPPFoI5vDdQUmJWjCy0NYDUbHWfaKjEsCcvLoJg9D0YnwNEiAB0kSRkghCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797071; c=relaxed/simple;
	bh=PL0UNaYZECGBHUmLZq8Ka9uXFeGS/M4r4a90fTZSCZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dn6X++Fgadhpz6JBbA+eo6YMS55jb1c1zQ34p5lktYTDso2yTh6SeyoRUdxDmn6UvDDnqd7lpHwJoUR3nedcm3tJq5AQ+p+RRP0SbpTeStLhwbv6eTjOMK8YcxzR2vWxXrSpA/Swp7/xzNopum4EpBwV1P5PgwrkPtbbJerQgIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B13C168F;
	Thu, 21 Aug 2025 10:24:21 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0877B3F59E;
	Thu, 21 Aug 2025 10:24:25 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	anshuman.khandual@arm.com,
	robh@kernel.org,
	james.morse@arm.com,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	Dave.Martin@arm.com,
	ahmed.genidi@arm.com,
	kevin.brodsky@arm.com,
	scott@os.amperecomputing.com,
	mbenes@suse.cz,
	james.clark@linaro.org,
	frederic@kernel.org,
	rafael@kernel.org,
	pavel@kernel.org,
	ryan.roberts@arm.com,
	suzuki.poulose@arm.com,
	maz@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v4 4/5] arm64: initialise SCTLR2_EL1 at cpu_soft_restart()
Date: Thu, 21 Aug 2025 18:24:07 +0100
Message-Id: <20250821172408.2101870-5-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821172408.2101870-1-yeoreum.yun@arm.com>
References: <20250821172408.2101870-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explicitly initialize the SCTLR2_ELx register before launching
a new kernel via kexec() to avoid leaving SCTLR2_ELx with an
arbitrary value when the new kernel runs.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/kernel/cpu-reset.S      | 4 ++++
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index c87445dde674..c8888891dc8d 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -37,6 +37,10 @@ SYM_TYPED_FUNC_START(cpu_soft_restart)
 	 * regime if HCR_EL2.E2H == 1
 	 */
 	msr	sctlr_el1, x12
+
+	mov_q	x12, INIT_SCTLR2_EL1
+	set_sctlr2_elx	1, x12, x8
+
 	isb
 
 	cbz	x0, 1f				// el2_switch?
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index aada42522e7b..cc569656fe35 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -255,6 +255,9 @@ SYM_CODE_START(__kvm_handle_stub_hvc)
 	mov	x0, xzr
 reset:
 	/* Reset kvm back to the hyp stub. */
+	mov_q 	x5, INIT_SCTLR2_EL2
+	set_sctlr2_elx	2, x5, x4
+
 	mov_q	x5, INIT_SCTLR_EL2_MMU_OFF
 	pre_disable_mmu_workaround
 	msr	sctlr_el2, x5
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}



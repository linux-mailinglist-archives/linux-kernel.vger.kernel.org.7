Return-Path: <linux-kernel+bounces-722193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D11AFD65E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411C0585B8F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CFF2E9EAB;
	Tue,  8 Jul 2025 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zxoc272L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UzHWsFVe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED982E92B6
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998837; cv=none; b=ErUWjNUadr+Ktj9R21jXREs3+RfdWmJ7VJ0EKA45ejmgA38jBHdq9RJXv5aaEQ3pIIb4hrwK5ga9r2+tQ8cgV3ddSzrPMR6yZ9RyHf4xPX6gdvVSq3zut2yf/Icwfn7BVhHKvKz+1C4J5kgAgUVfbLwqwavDTvhSuDxeVkx9yVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998837; c=relaxed/simple;
	bh=+u7ft2VzueCof1Ygo3T5Cw6+TQlpKLssRVWbabqf47M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nXcWZXvCIg6C8IGdKC5Hyy8+zAYWcCydsAi6FNlGxsDW0Do42QTnFdfuGPwASK953TPmvF1FN6eX8T4IEGdGsYX8bNde7dnKIq3/Kpu/OH1/yQM6NNzL547tK4v82IKqcfVjlzauNeqcf8jkEOOy2m0ampdxMZ5x5eS6bLPGAa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zxoc272L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UzHWsFVe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998834;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDzdlLDediLJxQX4rYz8KPbDVaSeOcZ0x8BBZHd76bs=;
	b=zxoc272LZ+PmJT/UYPsTFFDMzx38AytQRXmp2azsS025B5GiIqnVGe8f2Gx2qQi3Ok2G8j
	wZEVKWY1a3jCLB2u/1xLW4EjS8LLQlpjOdYDQuTuzCiZ9jgzkfROGQQzONdnBAx1czNDl1
	Buv+MR9aq/vyaBK+M1RORj50FUrv0GuCv8n3r8FJrAc/jhFX8+FKMwXsamI/89O8K/ylxC
	IVlHiyGRbrYYgi07icLAvx6eeGRBMs7W+xQUGEHRoLB1anbMeDS1W8273YtjxrS3n/LQjd
	31JYCcNMLKE1v/38hjCCVE5yKgWoM/uygxrFkgaAiADHVUG5JJLOxeuzfGkUPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998834;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDzdlLDediLJxQX4rYz8KPbDVaSeOcZ0x8BBZHd76bs=;
	b=UzHWsFVeImWZPidZxKTv2vgDbH2mP4ENF475r2OUyUd4gM4HkK3efwthNm/6tBfVsmQ4KP
	4kwvCLN2a6wZi5Cw==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject:
 [irqchip: irq/irqchip-next] arm64: Disable GICv5 read/write/instruction traps
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 tglx@linutronix.de
In-Reply-To: <20250703-gicv5-host-v7-15-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-15-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199883302.406.9694549597896811215.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     25374470f91aebbb1ca3f589f0ce57fd39b2d6d3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/25374470f91aebbb1ca3f589f0ce57fd39b2d6d3
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:25:05 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:51 +01:00

arm64: Disable GICv5 read/write/instruction traps

GICv5 trap configuration registers value is UNKNOWN at reset.

Initialize GICv5 EL2 trap configuration registers to prevent
trapping GICv5 instruction/register access upon entering the
kernel.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-15-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/el2_setup.h | 45 +++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index ba5df0d..54abcb1 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -165,6 +165,50 @@
 .Lskip_gicv3_\@:
 .endm
 
+/* GICv5 system register access */
+.macro __init_el2_gicv5
+	mrs_s	x0, SYS_ID_AA64PFR2_EL1
+	ubfx	x0, x0, #ID_AA64PFR2_EL1_GCIE_SHIFT, #4
+	cbz	x0, .Lskip_gicv5_\@
+
+	mov	x0, #(ICH_HFGITR_EL2_GICRCDNMIA		| \
+		      ICH_HFGITR_EL2_GICRCDIA		| \
+		      ICH_HFGITR_EL2_GICCDDI		| \
+		      ICH_HFGITR_EL2_GICCDEOI		| \
+		      ICH_HFGITR_EL2_GICCDHM		| \
+		      ICH_HFGITR_EL2_GICCDRCFG		| \
+		      ICH_HFGITR_EL2_GICCDPEND		| \
+		      ICH_HFGITR_EL2_GICCDAFF		| \
+		      ICH_HFGITR_EL2_GICCDPRI		| \
+		      ICH_HFGITR_EL2_GICCDDIS		| \
+		      ICH_HFGITR_EL2_GICCDEN)
+	msr_s	SYS_ICH_HFGITR_EL2, x0		// Disable instruction traps
+	mov_q	x0, (ICH_HFGRTR_EL2_ICC_PPI_ACTIVERn_EL1	| \
+		     ICH_HFGRTR_EL2_ICC_PPI_PRIORITYRn_EL1	| \
+		     ICH_HFGRTR_EL2_ICC_PPI_PENDRn_EL1		| \
+		     ICH_HFGRTR_EL2_ICC_PPI_ENABLERn_EL1	| \
+		     ICH_HFGRTR_EL2_ICC_PPI_HMRn_EL1		| \
+		     ICH_HFGRTR_EL2_ICC_IAFFIDR_EL1		| \
+		     ICH_HFGRTR_EL2_ICC_ICSR_EL1		| \
+		     ICH_HFGRTR_EL2_ICC_PCR_EL1			| \
+		     ICH_HFGRTR_EL2_ICC_HPPIR_EL1		| \
+		     ICH_HFGRTR_EL2_ICC_HAPR_EL1		| \
+		     ICH_HFGRTR_EL2_ICC_CR0_EL1			| \
+		     ICH_HFGRTR_EL2_ICC_IDRn_EL1		| \
+		     ICH_HFGRTR_EL2_ICC_APR_EL1)
+	msr_s	SYS_ICH_HFGRTR_EL2, x0		// Disable reg read traps
+	mov_q	x0, (ICH_HFGWTR_EL2_ICC_PPI_ACTIVERn_EL1	| \
+		     ICH_HFGWTR_EL2_ICC_PPI_PRIORITYRn_EL1	| \
+		     ICH_HFGWTR_EL2_ICC_PPI_PENDRn_EL1		| \
+		     ICH_HFGWTR_EL2_ICC_PPI_ENABLERn_EL1	| \
+		     ICH_HFGWTR_EL2_ICC_ICSR_EL1		| \
+		     ICH_HFGWTR_EL2_ICC_PCR_EL1			| \
+		     ICH_HFGWTR_EL2_ICC_CR0_EL1			| \
+		     ICH_HFGWTR_EL2_ICC_APR_EL1)
+	msr_s	SYS_ICH_HFGWTR_EL2, x0		// Disable reg write traps
+.Lskip_gicv5_\@:
+.endm
+
 .macro __init_el2_hstr
 	msr	hstr_el2, xzr			// Disable CP15 traps to EL2
 .endm
@@ -314,6 +358,7 @@
 	__init_el2_lor
 	__init_el2_stage2
 	__init_el2_gicv3
+	__init_el2_gicv5
 	__init_el2_hstr
 	__init_el2_nvhe_idregs
 	__init_el2_cptr


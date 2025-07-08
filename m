Return-Path: <linux-kernel+bounces-722191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC52AFD65A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60AA91C24D47
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E428F2E9728;
	Tue,  8 Jul 2025 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iA6Qs896";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y/+3IRV0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2753B21CC44
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998836; cv=none; b=A4RQ9ebOKeiqOgiazYx5TGVhd/KAbbbMtgCij6CDu/Avq8bV5JAxmRu08lmS9JW4Ti3Iu+rtKen8qmEtD1RQxMtuzrSdBFWq12k4JZpmA6tpdjCJ/uXdY5HQmn+YBqR7ctjBTsXsHxdEYNQcbgO6qS0sad4T1GFhH31AFolRj1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998836; c=relaxed/simple;
	bh=w3eU8WULaDLZbPW/zfygCj7wAiTpqHvBg9M9MfqkWVs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IcVmp+aH+jqn/mVIDDMzP1lh8EYKFRsa9eNf+sVc6zThJLbTnjSmgY5CPAb97KNNhjbwCmNJCGHz+kxtz1H0l6q1nEMtmL67azIThFjvEtg5IeQaNftzNYCztyR2gkOzL97kE0FRnOK9IvUE6YUbEqYLnv52aOtpHPcjYudfbTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iA6Qs896; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y/+3IRV0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998832;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtasPYvFqkxwfZSnTtb7sIJzmOMwu7TyDZFDiu3kIJw=;
	b=iA6Qs89667+BcSL3UaBqLZb3g8liKsR/uhzzKYnzP/BmZ4vR+AZQVv22njo/bGMSTY3SCf
	u1mcZmODVoIpOsXy2ujKj99gspmL8QEUoRgICc+7JEMwrkJEmdhhKHc+VhPbxI0SfSF1Pv
	W+8NwMfObb02r8ZbriCQ3p8o6CC1FWJINZbGekFL/1IRo5gSfjvT7pbmg/fEkyPDNJdlLZ
	s/G3J+emw7F9Vj0UxBgL3SNNJZSluCGkJJTrZ0ynn9J4TmwEIbebbaQWLWuxUdmA8Vy86u
	WcLp8lC5xCl55UMPDFkZjOxh7afHU7Dn/HfzZ5LrBeH3CglDplF2eHKkIYwMXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998832;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtasPYvFqkxwfZSnTtb7sIJzmOMwu7TyDZFDiu3kIJw=;
	b=Y/+3IRV0uN1V+bTqCfkJA4KYVyW2mqVzoGjHJDGfBWc+3FNnpeS95TZ+/7IM/tVAUN9uHc
	CKQanabzj9WcT9AA==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] arm64: cpucaps: Add GICv5 CPU interface
 (GCIE) capability
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 tglx@linutronix.de
In-Reply-To: <20250703-gicv5-host-v7-17-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-17-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199883123.406.10390811721292732320.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     988699f9e6b61d25a1448f7ff3c4a80b41e9d9e6
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/988699f9e6b61d25a1448f7ff3c4a80b41e9d9e6
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:25:07 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:51 +01:00

arm64: cpucaps: Add GICv5 CPU interface (GCIE) capability

Implement the GCIE capability as a strict boot cpu capability to
detect whether architectural GICv5 support is available in HW.

Plug it in with a naming consistent with the existing GICv3
CPU interface capability.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-17-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 7 +++++++
 arch/arm64/tools/cpucaps       | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 42ba76b..2fa2612 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3061,6 +3061,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_pmuv3,
 	},
 #endif
+	{
+		.desc = "GICv5 CPU interface",
+		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
+		.capability = ARM64_HAS_GICV5_CPUIF,
+		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64PFR2_EL1, GCIE, IMP)
+	},
 	{},
 };
 
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index a7a4d9e..8665e4c 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -36,6 +36,7 @@ HAS_GENERIC_AUTH_ARCH_QARMA3
 HAS_GENERIC_AUTH_ARCH_QARMA5
 HAS_GENERIC_AUTH_IMP_DEF
 HAS_GICV3_CPUIF
+HAS_GICV5_CPUIF
 HAS_GIC_PRIO_MASKING
 HAS_GIC_PRIO_RELAXED_SYNC
 HAS_HCR_NV1


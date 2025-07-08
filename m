Return-Path: <linux-kernel+bounces-722192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C72AFD65C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA261C25691
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A01E2E9751;
	Tue,  8 Jul 2025 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p4idZkVc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9wy1wvr2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066FC2E92A3
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998836; cv=none; b=iV4NJh19y0iQw6Z6v1NRwdJw64Gg0W2DchxgRrgjioxlVz8iV3XB5+pD4fEFEX7kuwSjkm5w7UUu1K8jGLuUuV4Xfd0KI6zXiXveLR2ardwkRgtHsW3rIp47JuwR7wBlbVsfoRnUZGrmNi9SRmY+KW21ZtrOaYxzH7GMOwmRg5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998836; c=relaxed/simple;
	bh=G9GhzFEdu6N1o0Q1oeKckVz+LLUKKRYQYaypLS5zKPs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CtCFEEdE233UFJSmZUnaG2O0gA5huj6OfctBdPRzCQTDx1igvOizBzIwc2w+QXz/8ae/2NZnY7Py/pfeaDKAGcqV4USxAGX8elyuRnolNNvFo/ubmWgKDID+jvca5Yk5LMbE0ZU0vfXinxtavoBBgzL06Z92hf2x4m67tbmWNoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p4idZkVc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9wy1wvr2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjKoMupbJlk9vQ1EfEh9akXE1oZytg5liCNty63w7Ek=;
	b=p4idZkVctZwz9TQaZjOL4FvAf9XWrh3fS/QgJDRzfd2x4Nw71NLeGtr2UlbUmtW1ZycV5G
	1o4RiR6Zi+XvUenVYKNO8CYD7hwwYzb5bjUpGqlLAhEs5j35c+le+QtQhMneFrHPR6lL6c
	FZQ3wpeIbg1nvN+qG3iNaQoGUbjfhyrPieW47xP/eTMUkSJF5WyrE8pXkHgr/e4x4+9zG+
	6EKE1MeOijiYgo/b0pHjgQjDL1N1vsU+6ilGCKjuKmVLeQ4M52Wv/vkrro2CC3k5V+DgMS
	6cOC9Gx9NU68vHr1iSd5ne5B+2uV+rRiTfFTdxYMsDkBF7sfvE6yWmnr7JKZjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjKoMupbJlk9vQ1EfEh9akXE1oZytg5liCNty63w7Ek=;
	b=9wy1wvr29EuPwHupXqXXlSDtPU/bExMSQZYzro5xyDN3YRn5+8Ns0Lo0khRir389aoRhTU
	qzrzEkh99LzjUJBA==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] arm64: cpucaps: Rename GICv3 CPU
 interface capability
Cc: Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 tglx@linutronix.de
In-Reply-To: <20250703-gicv5-host-v7-16-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-16-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199883211.406.827303119421819439.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     0bb5b6faa0d562f6f392ba94873f6aa01cf75c2b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/0bb5b6faa0d562f6f392ba94873f6aa01cf75c2b
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:25:06 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:51 +01:00

arm64: cpucaps: Rename GICv3 CPU interface capability

In preparation for adding a GICv5 CPU interface capability,
rework the existing GICv3 CPUIF capability - change its name and
description so that the subsequent GICv5 CPUIF capability
can be added with a more consistent naming on top.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-16-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 10 +++++-----
 arch/arm64/tools/cpucaps       |  2 +-
 drivers/irqchip/irq-gic.c      |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b34044e..42ba76b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2296,11 +2296,11 @@ static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
 				   int scope)
 {
 	/*
-	 * ARM64_HAS_GIC_CPUIF_SYSREGS has a lower index, and is a boot CPU
+	 * ARM64_HAS_GICV3_CPUIF has a lower index, and is a boot CPU
 	 * feature, so will be detected earlier.
 	 */
-	BUILD_BUG_ON(ARM64_HAS_GIC_PRIO_MASKING <= ARM64_HAS_GIC_CPUIF_SYSREGS);
-	if (!cpus_have_cap(ARM64_HAS_GIC_CPUIF_SYSREGS))
+	BUILD_BUG_ON(ARM64_HAS_GIC_PRIO_MASKING <= ARM64_HAS_GICV3_CPUIF);
+	if (!cpus_have_cap(ARM64_HAS_GICV3_CPUIF))
 		return false;
 
 	return enable_pseudo_nmi;
@@ -2496,8 +2496,8 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_always,
 	},
 	{
-		.desc = "GIC system register CPU interface",
-		.capability = ARM64_HAS_GIC_CPUIF_SYSREGS,
+		.desc = "GICv3 CPU interface",
+		.capability = ARM64_HAS_GICV3_CPUIF,
 		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
 		.matches = has_useable_gicv3_cpuif,
 		ARM64_CPUID_FIELDS(ID_AA64PFR0_EL1, GIC, IMP)
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 10effd4..a7a4d9e 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -35,7 +35,7 @@ HAS_GENERIC_AUTH
 HAS_GENERIC_AUTH_ARCH_QARMA3
 HAS_GENERIC_AUTH_ARCH_QARMA5
 HAS_GENERIC_AUTH_IMP_DEF
-HAS_GIC_CPUIF_SYSREGS
+HAS_GICV3_CPUIF
 HAS_GIC_PRIO_MASKING
 HAS_GIC_PRIO_RELAXED_SYNC
 HAS_HCR_NV1
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 6503573..1269ab8 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -54,7 +54,7 @@
 
 static void gic_check_cpu_features(void)
 {
-	WARN_TAINT_ONCE(this_cpu_has_cap(ARM64_HAS_GIC_CPUIF_SYSREGS),
+	WARN_TAINT_ONCE(this_cpu_has_cap(ARM64_HAS_GICV3_CPUIF),
 			TAINT_CPU_OUT_OF_SPEC,
 			"GICv3 system registers enabled, broken firmware!\n");
 }


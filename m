Return-Path: <linux-kernel+bounces-722194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E75AFD65F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BED2166F32
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C612A2E9EC1;
	Tue,  8 Jul 2025 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DeplXg/q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VAnF6Avk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2DC21CC74
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998838; cv=none; b=dH0I5V5HPpObIorUOrZA8w10zSfR5alc0Ao/yEJIlq9cYy6eGOEI8uwXgTX0i1Jl6mrba3AeD+Ehc066Y7LkIdDgB14bY67jTiEvLpu/Zj60gfPByipYeBYasZae8kploSKwyFouSid3SGFxf11w3Zibm8Dgha6/EKBLUFMRCAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998838; c=relaxed/simple;
	bh=fH97T5Vlt7bG+aZfAM/asrk7LbYlZSJDu3SL/VSotr0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JEfvXi003lqgDWbGBRFx6S/E4pgsSd6K/l4G1Yug8YvUj88R45DK4FhAo2v8KhzAklMCclvHjf8GzJeSKC42pnvgrTpgefIGVDrBMKs9IVZ1HEWoLsvtK5JOe2TD3HWAHiJIiFPfLCcuU8OiVoewzGZkfozUnwcb6OGe8ZsWSsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DeplXg/q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VAnF6Avk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998835;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T09n3LGm3Btk9VtVKNsOgMjaktwGCK2JwQSTi6Xf3+k=;
	b=DeplXg/qlcV71UNtAjJtHQCDZnpKA5RkkSaQrLfCGV/fUlUmO3fcW9oJRMJrezrGB9WJcW
	tgkUuC7AoEaWUacyESz+diqv/rsMXqHPIrl8UcTg6s7kerKUdflXe93k56cdXU8l5LEfmT
	UuiRfizG5gDvIMWla3AN2Xu9PxlCpPsHwQtZUsMt4G7EVDgzgKHKoi56bB+CSRIwvD//Q/
	K+pzSlNq7GfYsm8jlFn0pqbm6NLFtKl1HCcw4YZKpHm2A/2/2FwXHH+XqwmFW+S260PgWh
	ENKnrMidE9aLPLJS3EV4VbjJrQd+f+pM1EZtT4WdnsIYJlxYaS7a6V9nbkA67w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998835;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T09n3LGm3Btk9VtVKNsOgMjaktwGCK2JwQSTi6Xf3+k=;
	b=VAnF6AvkRMPhZPlN/9Taje2BG5aHuTfOmWQ6cCgiN637ZBBd7JOk9zTxOejRjMl83RoGFB
	sZQnUgoc2DKTD0BA==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] arm64/sysreg: Add ICH_HFGITR_EL2
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 tglx@linutronix.de
In-Reply-To: <20250703-gicv5-host-v7-14-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-14-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199883391.406.15082064657603519773.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     42555929dd250e3502a6963aa57332bb1672f5f2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/42555929dd250e3502a6963aa57332bb1672f5f2
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:25:04 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:51 +01:00

arm64/sysreg: Add ICH_HFGITR_EL2

Add ICH_HFGITR_EL2 register description to sysreg.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-14-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 9def240..aab58bf 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -4467,6 +4467,21 @@ Res0	1
 Field	0	ICC_APR_EL1
 EndSysreg
 
+Sysreg	ICH_HFGITR_EL2	3	4	12	9	7
+Res0	63:11
+Field	10	GICRCDNMIA
+Field	9	GICRCDIA
+Field	8	GICCDDI
+Field	7	GICCDEOI
+Field	6	GICCDHM
+Field	5	GICCDRCFG
+Field	4	GICCDPEND
+Field	3	GICCDAFF
+Field	2	GICCDPRI
+Field	1	GICCDDIS
+Field	0	GICCDEN
+EndSysreg
+
 Sysreg	ICH_HCR_EL2	3	4	12	11	0
 Res0	63:32
 Field	31:27	EOIcount


Return-Path: <linux-kernel+bounces-722197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2907AFD663
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3D917E391
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4625F2EA736;
	Tue,  8 Jul 2025 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hHUghy4s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ElHVOY3X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F372EA15A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998841; cv=none; b=t+se2RgjjAzTEfndZf4zX8rnWFVKTOUesSxh/63XkZ83Yu91y11S3HDj2CiVq/XuAOcfksx5tP/5Gl97MIpu+WJa0vGJBuCMW6attF5LX4pn4q2rBcDiF/r2fCYXt0ALebhWkBkR+ZwuMadx+7d45Q3UI9+tx8hMmtrRL5FdOjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998841; c=relaxed/simple;
	bh=7vnM2FkUl6y6+zlfdy2jeMvS692y+lKx81z31bL5EtM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=odqEx7871fw1fPYzi8BNkKEGyWVhpjCHLibSfKom7jeaKWiI8mELradqrDiD5DQWQiGn2XZRXk0qe6CZu2LgHmlO7yR5VFpMkW79INstu1mlJ2A9bXG17o/ycqZ+OLJCy7pYEfNKcxGWc78n9HmAaxtaDbT2jmRyblI8l3kmowo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hHUghy4s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ElHVOY3X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998836;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1h5pG0ALwOvNtlUMjmZLE4E6lRfg8qDnDN6n2S7Gzc=;
	b=hHUghy4sNmaUrtDqTSPFraaXJkDmQaXpwQ5KWwSvpsyVbQIY4mLeGmtlQ9LMl19ZSSRSIR
	lij+By4LwgRLc9YLNpkPR5LRSssUrt9NW1FaEC2Zf1i5VZM5r6ypF7ExMFjEfUm1v+m/aA
	sk7op5tGke66JJhUu6VtwxncoZKgLP+bvZfXHeLG8vXcktvYier3w8qCyxorykRiK9G/gt
	Ernf/CCdKCoA2FJ/ECLQxVf7D0VDbbrUkpwGR7DkdwxoSuvkPrfuexcjaKCHnvuWDA2L4n
	DfTHvmkGXN8nGosxRTavWhmgiQnitkR6Xsm3f/GVdDwV1bnxR0s5PTFpbmlKSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998836;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1h5pG0ALwOvNtlUMjmZLE4E6lRfg8qDnDN6n2S7Gzc=;
	b=ElHVOY3XBl5IRHaAodX63l9SJN/83eIfaCyN1aRLiOjSefERBnqMzTr7IsyaSDvAw0OyC8
	wTbDHYWzIsSVXzCg==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] arm64/sysreg: Add ICH_HFGRTR_EL2
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 tglx@linutronix.de
In-Reply-To: <20250703-gicv5-host-v7-12-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-12-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199883572.406.14669785533662440233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     2e00c5463f6c19b096a016501d50862cf0e3e610
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/2e00c5463f6c19b096a016501d50862cf0e3e610
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:25:02 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:51 +01:00

arm64/sysreg: Add ICH_HFGRTR_EL2

Add ICH_HFGRTR_EL2 register description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-12-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 8be5e4a..0202b3b 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -4434,6 +4434,24 @@ Field	31:16	PhyPARTID29
 Field	15:0	PhyPARTID28
 EndSysreg
 
+Sysreg	ICH_HFGRTR_EL2	3	4	12	9	4
+Res0	63:21
+Field	20	ICC_PPI_ACTIVERn_EL1
+Field	19	ICC_PPI_PRIORITYRn_EL1
+Field	18	ICC_PPI_PENDRn_EL1
+Field	17	ICC_PPI_ENABLERn_EL1
+Field	16	ICC_PPI_HMRn_EL1
+Res0	15:8
+Field	7	ICC_IAFFIDR_EL1
+Field	6	ICC_ICSR_EL1
+Field	5	ICC_PCR_EL1
+Field	4	ICC_HPPIR_EL1
+Field	3	ICC_HAPR_EL1
+Field	2	ICC_CR0_EL1
+Field	1	ICC_IDRn_EL1
+Field	0	ICC_APR_EL1
+EndSysreg
+
 Sysreg	ICH_HCR_EL2	3	4	12	11	0
 Res0	63:32
 Field	31:27	EOIcount


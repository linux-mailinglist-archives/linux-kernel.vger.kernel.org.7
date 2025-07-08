Return-Path: <linux-kernel+bounces-722199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53169AFD664
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFD41C26165
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3252EAB6B;
	Tue,  8 Jul 2025 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x3kdHxbL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hTtP1YAZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38832EA47F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998842; cv=none; b=B4L8/U56qYBxNNGrV0pw9Zt09LiTE9qSeG/VhgyH/E7ETXHyCegKXPBL0/ZcArWjFe+i92YV/mwVnwPPV6G4/81OhUsbp9EkPylOzSxa+T9z2vPFLIfx43iSHNAkKd57/N3Jy8O4PEws8aWOPLBd8ykSezA2SQNXlbL3LuDGXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998842; c=relaxed/simple;
	bh=G93lDJ/Uz+3CpMhr/08qWXyoqMDFloU5ceHH/Ky4tjo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z7xNNsXF759A8iqny9BYQat25X5qB7H+ZDnWifanPluQdI/f+pdYhuM6D+05ofKFSymXogzZ/FDJ+TnO+CT1ZR+4A47M+FW0cgJKhHLY8ERNBVDetcwtpjtjFSyvZQmaFzLFz/OrqBEwE4kYtNCteOnrN0dDMY8xf+oFOTeTfFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x3kdHxbL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hTtP1YAZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=744lRR+N3v/ml8pCIQnlBp2T4jJP6VW5hboRH8B+row=;
	b=x3kdHxbLH1RGrB2Z+ja/SSx2BK0dVzeJJ6VuzmBqLWRBlXHgiw5Gvbnnd3lbQFddBUBRWC
	O3pmpUthQweLD0KcF6Ts1vp3L/6OSGs71Z6UNu5qJ4eOL2uvK1nrEHPW+86SpfiLEe1E2E
	1q65bbQ0fIi9pNohfD7paTh31b9R+R8sWtZP0/L9jtYrA+qWod2/HJD4CG5S/TE49sg5Eb
	il+rsMEZJ3t9jcjcWE5aZdTZ8PAxmmbYs6aSS139NVGB4MTXSb0/xEENMYOOwVv69TDe2m
	ShVMgtXf9XNqYBj19zqIIdVFLp7qzOsan3Z3nxNECaLd49vXT2LqcPARkDqIyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=744lRR+N3v/ml8pCIQnlBp2T4jJP6VW5hboRH8B+row=;
	b=hTtP1YAZjzahPBrAkZZ5sk0bh1U2GFyXSN9OE4I2n2DiuE0BR/JW/+sSoMK924TiJaCGx3
	7iw8iWx0kBSi3gAw==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] arm64/sysreg: Add ICC_CR0_EL1
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 tglx@linutronix.de
In-Reply-To: <20250703-gicv5-host-v7-9-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-9-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199883830.406.8280637884200225795.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     4edcfaf951a28b0663f4e05222d00ac992fab82c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4edcfaf951a28b0663f4e05222d00ac992fab82c
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:24:59 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:50 +01:00

arm64/sysreg: Add ICC_CR0_EL1

Add ICC_CR0_EL1 register description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-9-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 78a51fb..ebbb22e 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3519,6 +3519,14 @@ Res0	14:12
 Field	11:0	AFFINITY
 EndSysreg
 
+Sysreg	ICC_CR0_EL1	3	1	12	0	1
+Res0	63:39
+Field	38	PID
+Field	37:32	IPPT
+Res0	31:1
+Field	0	EN
+EndSysreg
+
 Sysreg	CSSELR_EL1	3	2	0	0	0
 Res0	63:5
 Field	4	TnD


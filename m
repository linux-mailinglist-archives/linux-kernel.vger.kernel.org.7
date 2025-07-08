Return-Path: <linux-kernel+bounces-722195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E45E6AFD660
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986267B4690
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593092EA46F;
	Tue,  8 Jul 2025 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cT5M8dee";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tXrPLa/j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A952E9759
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998839; cv=none; b=ApxfjU3F6fTiL9qn7XgRPEJvrjCFHo0R2nYKLDMiXKJtPTQns8YWZCD1j+oFbaybn95WDWhivFkNdrRkdORvDWpit3eO41FuQYDqsQl752S8WrpWNZE/RYYKvIsWhAN9Q5W19+j72Wrkt6lnHqNBk+3mW0suSse13+9v6bXaHsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998839; c=relaxed/simple;
	bh=cUudDwA6saZc/1LQZpnv+IdO/6TlZmvfPwA5cAOPmQ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FosHRnG4wv0e8AqHAbr+Y4E0Pf/qfAtBXYK2AEVMTvvp0soaYIKXrsEEfha/2eS/sntc4LTVjhDMncJeO+LfS5s1XmnShfH86Wnj08vxbIYVtKLxPNsxkYkzqQe1PjOwH4lO6VIXo773XLUpNEf2qnKt5JFgduaA+A29gVRmeNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cT5M8dee; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tXrPLa/j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998835;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T6UBjb/86+0bKdwI/Wzy8mevHrIJ56FyrtkzaBDa0cc=;
	b=cT5M8dee2+J62wPkTuMpC17moBDWvVJwskMMYqc1JembT9TOO+ec7qkWeOQbs5VOayWNkh
	PA4VArfWJ6X/lSPLnozBy6Wd+sp22IKyD1GEj2oh3K4AuUPdvOuVNm050ktfTc3IYke162
	deRQ+dVscidhph8XOfZx4qBkxllN4C+KX6OqCHoVbRg4OVcYJLUbTJZl8j/8f8AMMwOPb1
	SKgBkbGEGxGviGDP+8Ab1btCcJb9L7cv2b42v7fdNAKOaiJLdh9hBDLbxN32ZS/hHqFlyd
	3nhR7wb7PO/mlCP4YEdbfwYx+rNLPHu76tQx5JYYFq93FAdDG0BOqQ9Ax9QoUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998835;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T6UBjb/86+0bKdwI/Wzy8mevHrIJ56FyrtkzaBDa0cc=;
	b=tXrPLa/jYowt6vqZ+X/SQT3HyJYE1xUKC+zZ+O6MHzpzTd9ez7Xp6SEZtBMtfEzCnAI92m
	tS3F0gyz07HzDuAg==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] arm64/sysreg: Add ICH_HFGWTR_EL2
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 tglx@linutronix.de
In-Reply-To: <20250703-gicv5-host-v7-13-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-13-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199883481.406.431378584117828698.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     45d9f8e195cf1374270fedf7d1e0f697068eb49f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/45d9f8e195cf1374270fedf7d1e0f697068eb49f
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:25:03 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:51 +01:00

arm64/sysreg: Add ICH_HFGWTR_EL2

Add ICH_HFGWTR_EL2 register description to sysreg.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-13-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 0202b3b..9def240 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -4452,6 +4452,21 @@ Field	1	ICC_IDRn_EL1
 Field	0	ICC_APR_EL1
 EndSysreg
 
+Sysreg	ICH_HFGWTR_EL2	3	4	12	9	6
+Res0	63:21
+Field	20	ICC_PPI_ACTIVERn_EL1
+Field	19	ICC_PPI_PRIORITYRn_EL1
+Field	18	ICC_PPI_PENDRn_EL1
+Field	17	ICC_PPI_ENABLERn_EL1
+Res0	16:7
+Field	6	ICC_ICSR_EL1
+Field	5	ICC_PCR_EL1
+Res0    4:3
+Field	2	ICC_CR0_EL1
+Res0	1
+Field	0	ICC_APR_EL1
+EndSysreg
+
 Sysreg	ICH_HCR_EL2	3	4	12	11	0
 Res0	63:32
 Field	31:27	EOIcount


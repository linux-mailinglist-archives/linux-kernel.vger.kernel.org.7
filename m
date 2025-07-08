Return-Path: <linux-kernel+bounces-722177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32FEAFD64D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35E01BC22B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C12A21B9CD;
	Tue,  8 Jul 2025 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZKiwvZi0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jOFHf+nU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481401754B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998822; cv=none; b=HC20BqQRcQ+VuPKaWVqj6JzWEnmKdhLOItbPsAzbb9F7sa/aR13dwS4nAAeKDf+libpPqvfELAUIBSf0iZaKNjdQ1Ln+MLVpbzuF7pjveo7nR4zCfmHE/7R+kfVnNSeSGIH48Fl1wFWB2V9t5UABQ9pmnIslHqNEYUw9o+4MXxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998822; c=relaxed/simple;
	bh=cKSp24tAq+G+8TAbCCpsRG7TYkovQc/z2bFWehwzPrE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K+hzYq/zMzuRyKBDcUT5zo+9gMu1dFd4Usi27eSq6+Q7jUHRlwHFP6oDccL9rKgYgMuD3K4LqbLOeSbNU2izTbyexa9bp5wpvou39P4YS314Hc4J87tjK+oRD4JoO2j8O87Fk7fmesKZEWhJhl3TstfIXPmlM/FwCTjM58ssBy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZKiwvZi0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jOFHf+nU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998819;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PNHS8e5MJciQgfMA0gZZS27B2XFNGeR5oJfowBRoomg=;
	b=ZKiwvZi0rISlPyh8T9/LxLoW7D9RPVBqWZyghucrncJZW9MIRBoz9m2BKpvtODL4CMmLIe
	UNoWSvwiMEqzjzKFflXIdWJ5+X/rkVzKO3kK4J7XvgtI/14Vx5eCoyjE3h4tPOKQ6Upt1m
	oH01AvCs39Ks1Yja5MsF32tcR1eEsfXyIGNd2h57poiEbXdGlHt2a+fnxRt/XvCBL6Ge66
	IaWUkWZcjto8mLhY7e15BWHIK+cRjSOPoBJ27xGiXq7AS15IqkWzTp+3QiJK+HaK9pG18T
	nXISrLoSgzD0Tnys8oE7yCmRDbEJV5HTWVpdjwoQrPYqpTSmsDutHy3X8/2kTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998819;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PNHS8e5MJciQgfMA0gZZS27B2XFNGeR5oJfowBRoomg=;
	b=jOFHf+nUeXY9m1zN5aWNeTKmOYJpSBaRCvsMitMpSnB6twrxnSLLERInpiRfVHJwtL6cBg
	C3PnPQVfvV/bsmCQ==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] arm64: Kconfig: Enable GICv5
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 tglx@linutronix.de
In-Reply-To: <20250703-gicv5-host-v7-31-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-31-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199881775.406.17937840693522584038.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     53bb952a625fd3247647c7a28366ce990a579415
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/53bb952a625fd3247647c7a28366ce990a579415
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:25:21 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:52 +01:00

arm64: Kconfig: Enable GICv5

Enable GICv5 driver code for the ARM64 architecture.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-31-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 55fc331..5ff757c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -129,6 +129,7 @@ config ARM64
 	select ARM_GIC_V2M if PCI
 	select ARM_GIC_V3
 	select ARM_GIC_V3_ITS if PCI
+	select ARM_GIC_V5
 	select ARM_PSCI_FW
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS


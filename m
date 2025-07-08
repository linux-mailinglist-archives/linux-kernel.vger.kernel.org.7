Return-Path: <linux-kernel+bounces-722196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760E9AFD662
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39D9545B71
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6641D21CC74;
	Tue,  8 Jul 2025 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F5oDdwY3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CR0qpj2N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EBF2EA157
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998841; cv=none; b=gYSkZF0Tiy5T1Ii5Xt61i+DTmJaDExmIJKzO3J1YCsSF1IvXij8tzbiYvdygbE0jSJlphUmkmpG16qeUu1lnkJXLIBjJraIxFjw7ZvBhp/htFTj5rwkan4zcnE4Aqx0LIC890rYSuUTMyHaEREaZExmV3HsEVaHrTCLfb5B/cgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998841; c=relaxed/simple;
	bh=E2Y4eOxhLebLLL7egPUGfkiKftksazE9unCbI9LBENk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fXwtzITawhsGKIb9WmP1y5PP0TjtKCzxSL/rEy2ZoNiJ0wCgKLx6Hyki8gPt7uLpAcIOPKNcZK0mu81l15BQ82gyzyO0OIemRQuw25OuCoUIyr9p+FXByNj5PRqCH7aEHNnzV6tmLKjVXCMyWKinlLqrNtCxnk0I0nipQO+H/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F5oDdwY3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CR0qpj2N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0KeYx62F/TICSw7/5Qy9Dysk2+K/JJpB3Mcq+qzdGY=;
	b=F5oDdwY3Y8NsKLKhH8++LcxenJbP1cOekUuDHYemfLOR1ll2CvJpdeGMGqdxqx5yNp6Zuo
	COqf7Bs52LSF3Ykh8v+exY8beLRMCpadCKduHL5MKfJamUmvzA5QiLlfHXKro6BM2DQiNZ
	eQlOgplxKnXjW7Sf6ShH7IKEN7CDi5na4FiqJ50ngxBA6G091tYmKAJNfv4sXvJ3LW/Mbx
	Z+pr5PJah4GalnCzPqzPwE929EiEcwYKSrnevjMwyIstAf/zBOV2AhOeli2dEICEb9ozu/
	4Tu5vMOLIJKT6Sn0o9HSRPTG5YE0N0ILyw9Lo08wjfuXHavAkmCjqtr4RLHRlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0KeYx62F/TICSw7/5Qy9Dysk2+K/JJpB3Mcq+qzdGY=;
	b=CR0qpj2NQL2uGCjgncSvvmhk1/G3NflGpsw0ODRksP+xbB3PpXSoniWw+Xv9jngZgHeP9v
	JIf2buVgkqCPkpBQ==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] arm64/sysreg: Add ICC_IDR0_EL1
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 tglx@linutronix.de
In-Reply-To: <20250703-gicv5-host-v7-11-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-11-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199883657.406.13466161153295191439.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     f987581aa78ee4bba5fd1b83296f4a6ddd228c79
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/f987581aa78ee4bba5fd1b83296f4a6ddd228c79
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:25:01 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:51 +01:00

arm64/sysreg: Add ICC_IDR0_EL1

Add ICC_IDR0_EL1 register description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-11-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 5e15d69..8be5e4a 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3099,6 +3099,22 @@ Sysreg	ICC_PPI_HMR1_EL1	3	0	12	10	1
 Fields ICC_PPI_HMRx_EL1
 EndSysreg
 
+Sysreg	ICC_IDR0_EL1	3	0	12	10	2
+Res0	63:12
+UnsignedEnum	11:8	GCIE_LEGACY
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	7:4	PRI_BITS
+	0b0011	4BITS
+	0b0100	5BITS
+EndEnum
+UnsignedEnum	3:0	ID_BITS
+	0b0000	16BITS
+	0b0001	24BITS
+EndEnum
+EndSysreg
+
 Sysreg	ICC_ICSR_EL1	3	0	12	10	4
 Res0	63:48
 Field	47:32	IAFFID


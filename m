Return-Path: <linux-kernel+bounces-722204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 325ABAFD66A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4EC16D1D8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E52F2EBB89;
	Tue,  8 Jul 2025 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XRWuNQdC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bTwAYiB1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9D32EB5A1
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998847; cv=none; b=SQyO9N9cyOgGSn7dM2GzhL5L7wpXnmPIwVzWTdSiBv3yXgFM75I6xfDleIHKoXUEsaB6TCa6V8zbBux/EqBUSoBe29XapWGI065/sElhYIRIYa6K/w70Oof65wPi1YlRmav+mTYMgUqLyCpZRBp2zADdoKP2ZbV097b03/tNIEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998847; c=relaxed/simple;
	bh=vE9iw56c8Xe0HRFg9rgZDiBsn0vnX5ACffBB9ucpwYA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hVXUW9AtlB5aNxsJYdThpCY44NsMdClDAQwfqERQ719pvHg4B4QCG3nMlvbq4tQOdM/4J13OUqXAGoSS5Kp89tnbLgml5bQNJb9IVtYaAUpJcb2WVUetedDUpcUrhi4g8/ND61RBcZYAbGyo+cqE3hus65vKInweDk3U4xOgJJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XRWuNQdC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bTwAYiB1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998843;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xSDVawNowmlUtaV4RlrzWIKOj82yMlgn7h24H3aDjvg=;
	b=XRWuNQdCq8vfV/+kgJDCE9qMtshhqoPpfsVQeuD6UjmuCoLHDbmYHnaXDnnpbDhXg5BQmh
	VL0XgfmXmhXnEmXgX6FFGMKmqdkbPdx7gxeiAT8aVofwaPaBENkP6YFk0U0PTS/7g24H62
	oeKshuzDKeXpmcW1ivSVplKKsCT6i4RLUKrLfEANQq8AKJfmgazk3jbc6SslYW5mRw826h
	nOOzUknkgCgIHC6jeJ2+mC+suL4vZcm7BCpM7W1+e5H4e7f+0uBREve9V75mKZDsugjny3
	8bav2JaJQ6hrpzIyOj3XtuFsNK+pVMPeY8vJwfFAObqfxfII+Uiap7wah0jxuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998843;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xSDVawNowmlUtaV4RlrzWIKOj82yMlgn7h24H3aDjvg=;
	b=bTwAYiB1nSqAvbXA0k1a5odwWNuXo3/i1rkV0SkxbcDXnnyB7qcVVy7aZiySxGhVRbvQLy
	d4Uknm3/4hHB9wCw==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] arm64/sysreg: Add ICC_ICSR_EL1
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 tglx@linutronix.de
In-Reply-To: <20250703-gicv5-host-v7-4-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-4-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199884277.406.15374769706733472864.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     fb0ad5ed5676f0a8cbee4cd148db1b692bda8a4b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/fb0ad5ed5676f0a8cbee4cd148db1b692bda8a4b
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:24:54 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:50 +01:00

arm64/sysreg: Add ICC_ICSR_EL1

Add ICC_ICSR_EL1 register sysreg description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-4-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index fc17e19..81b32f5 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3024,6 +3024,20 @@ Sysreg	PMIAR_EL1	3	0	9	14	7
 Field	63:0	ADDRESS
 EndSysreg
 
+Sysreg	ICC_ICSR_EL1	3	0	12	10	4
+Res0	63:48
+Field	47:32	IAFFID
+Res0	31:16
+Field	15:11	Priority
+Res0	10:6
+Field	5	HM
+Field	4	Active
+Field	3	IRM
+Field	2	Pending
+Field	1	Enabled
+Field	0	F
+EndSysreg
+
 SysregFields	ICC_PPI_PRIORITYRx_EL1
 Res0	63:61
 Field	60:56	Priority7


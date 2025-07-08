Return-Path: <linux-kernel+bounces-722198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAD5AFD661
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEEF4189381F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36E92EA73F;
	Tue,  8 Jul 2025 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XHN8FNC0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="65gChCFu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03E32EA179
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998842; cv=none; b=bQmzbZNMmt5CJUc9uYVzUW7lz1RPgu9E8DYa8WnHNQdQckvgFIDogJcJSLDLLkMXAB3/yYCMhxh92+fnTSSVolYB04ZAolYJm2PtqHbPFuZK97Tqk6Ls8Gt9cg8uUF8YV7ziIZ6lsl43QSnOYUAKQZqygI96UbpO/mXJ4tc5uFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998842; c=relaxed/simple;
	bh=p2iNZLTzdWWYOb79eiOxVRrMXvhbBTDFwY4Al5UWPbg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HtC6kav3TOQX1vTOu5aod9VQjGf5QqKx7WfHhbX2tIAfbmOcq/v2XeWkko4x2PkrLLZZCy1K/XhlVXlM2fpbFVdHvoT4a3YZVy1RVbWozkH0vSuZSV+hBjDF29jpZt2wdUvsQoF6N39kV7X+yrK7bYbv0iRBFst258Wl746i70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XHN8FNC0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=65gChCFu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eODi1/2edQKqaToIpT1KRdj6puJdrV7wTq2F1quHCtk=;
	b=XHN8FNC0v8ecyZFsJC+Mfqr4Flwo41rooI4/GaXYVAVKOQb6RG1GB8y3DQLdU74jRqhbgr
	QAvCJwWj3wuXItwmbfg7kAq5kPRDiUvLPnXTuCcEa+0qVrnjXeV6NXeV879hQdsaf4I6bA
	l1r5BXaWbn8kEfqJHExWe97krBuNU1ahNUUtxQMqfnJwOpreb8l1w2hazQm8FeNHvQlYNp
	9o5kP81a0B025sBFhNz+tlLfOgZfyrZ9UaoGdmG/aR60dbVwxSHFY0DfXirQgLcw7YexxO
	kR9PZZ6DGHPwhVDPEaw8vGtCRURWBgH3hwKbG/JOO75t6U3QoGncDUAPbyX4pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eODi1/2edQKqaToIpT1KRdj6puJdrV7wTq2F1quHCtk=;
	b=65gChCFu+Bp7Os7xkwygrrP7dKGpUXOyKYLf+49z/KOU0AsP7MFDe2q1GXccugVdwJHpvF
	7QrL9ot+ex7DZTDQ==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] arm64/sysreg: Add ICC_PCR_EL1
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 tglx@linutronix.de
In-Reply-To: <20250703-gicv5-host-v7-10-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-10-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199883745.406.12045774544720304330.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     cfd051c5c83112e9b69e8b24546207191643f41b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/cfd051c5c83112e9b69e8b24546207191643f41b
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:25:00 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:51 +01:00

arm64/sysreg: Add ICC_PCR_EL1

Add ICC_PCR_EL1 register description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-10-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index ebbb22e..5e15d69 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3527,6 +3527,11 @@ Res0	31:1
 Field	0	EN
 EndSysreg
 
+Sysreg	ICC_PCR_EL1	3	1	12	0	2
+Res0	63:5
+Field	4:0	PRIORITY
+EndSysreg
+
 Sysreg	CSSELR_EL1	3	2	0	0	0
 Res0	63:5
 Field	4	TnD


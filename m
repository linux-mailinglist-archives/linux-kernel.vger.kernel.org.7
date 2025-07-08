Return-Path: <linux-kernel+bounces-722202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84683AFD667
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 480E97AEA1E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2725E2EAD19;
	Tue,  8 Jul 2025 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hwLGPw1O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bP85I8pX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A602EAB7D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998845; cv=none; b=ibTg7dPTiOhnWWjguukjZCyqwjaZNBQEgPm7KCSKGT7L4OGGc/u3L/SIWnYtEh+3O0GVamkk4uH6AVk2oaakP0IE6bIY/ifw6DdKj35KdaWuR3qbKseHNtwuLR3Bf4w7jl+XsgQZoomHTivwE5AtdZKP3WOMIF6cHfolHJgfPqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998845; c=relaxed/simple;
	bh=HzzKHEH56uoWLo7XvNuv3w561RQqrsyoKxiFnxCDVIQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ti+RDIIp8aNp+tZX5If/tKlKmM7S0MBul/RGkzblcgpXvxNsGBxln23Y7JTAiZ028Nt5tpNvLKAiRr1bA029XFhw5fq61d8zLxYkBrSnUZqayPrX4L8Bys6h4mh+G8JMSF87/3WxyXtjpJlCa6jKs0F+xW4SVx6atgtHLJLrmWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hwLGPw1O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bP85I8pX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998842;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02XAchA+BOA46QPWdP/ls9Poh7k2cydTPXZMyEl4JwI=;
	b=hwLGPw1O0Ksz184wH1VG/zjGNo5j91UIYfgveR9/O7BSuirVxEBA6BJRa7qhYKCJAWvzK4
	2KBhdDcg9u33dGqvcaporoY/HQ7DsRDjRHscgXnksCvQAFCZLO+ZqFuXTMF/Kw8Vh2VTBP
	Q1W8O1dxwlEsI5iVl5GyTHCO7ANm8bc5fwjzF0OVM57mSdny+sMvQk/UDZq9Zpf3Uue7uK
	5gjOgMcznhCRq+Uqdt2zMYnWfyyZneqp0GK5fsbp9KcDdVfOWs0ufUXOX8CJizkLZ+Jn0q
	JvagcnKCHdkxjZN8bNp46MD4eI4vWbXRGLBBIgwzSARMpsld/r5GNZKA9Re3jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998842;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02XAchA+BOA46QPWdP/ls9Poh7k2cydTPXZMyEl4JwI=;
	b=bP85I8pX7ozqrHMdTONJp4b7q6eftMzXyijh5FL1ExxZ6N0FmUt8iUgmnrnyH69yx7Ks1B
	y7Fmu8ozzJXbTXBA==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] arm64/sysreg: Add ICC_PPI_ENABLER<n>_EL1
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 tglx@linutronix.de
In-Reply-To: <20250703-gicv5-host-v7-6-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-6-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199884083.406.1272323666787784625.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     231d9dd790bf160d8441912116bbf7435aa32fc1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/231d9dd790bf160d8441912116bbf7435aa32fc1
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:24:56 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:50 +01:00

arm64/sysreg: Add ICC_PPI_ENABLER<n>_EL1

Add ICC_PPI_ENABLER<n>_EL1 registers sysreg description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-6-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 75 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 7f096ef..728223d 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3113,6 +3113,81 @@ Field	1	Enabled
 Field	0	F
 EndSysreg
 
+SysregFields	ICC_PPI_ENABLERx_EL1
+Field	63	EN63
+Field	62	EN62
+Field	61	EN61
+Field	60	EN60
+Field	59	EN59
+Field	58	EN58
+Field	57	EN57
+Field	56	EN56
+Field	55	EN55
+Field	54	EN54
+Field	53	EN53
+Field	52	EN52
+Field	51	EN51
+Field	50	EN50
+Field	49	EN49
+Field	48	EN48
+Field	47	EN47
+Field	46	EN46
+Field	45	EN45
+Field	44	EN44
+Field	43	EN43
+Field	42	EN42
+Field	41	EN41
+Field	40	EN40
+Field	39	EN39
+Field	38	EN38
+Field	37	EN37
+Field	36	EN36
+Field	35	EN35
+Field	34	EN34
+Field	33	EN33
+Field	32	EN32
+Field	31	EN31
+Field	30	EN30
+Field	29	EN29
+Field	28	EN28
+Field	27	EN27
+Field	26	EN26
+Field	25	EN25
+Field	24	EN24
+Field	23	EN23
+Field	22	EN22
+Field	21	EN21
+Field	20	EN20
+Field	19	EN19
+Field	18	EN18
+Field	17	EN17
+Field	16	EN16
+Field	15	EN15
+Field	14	EN14
+Field	13	EN13
+Field	12	EN12
+Field	11	EN11
+Field	10	EN10
+Field	9	EN9
+Field	8	EN8
+Field	7	EN7
+Field	6	EN6
+Field	5	EN5
+Field	4	EN4
+Field	3	EN3
+Field	2	EN2
+Field	1	EN1
+Field	0	EN0
+EndSysregFields
+
+Sysreg	ICC_PPI_ENABLER0_EL1	3	0	12	10	6
+Fields ICC_PPI_ENABLERx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_ENABLER1_EL1	3	0	12	10	7
+Fields ICC_PPI_ENABLERx_EL1
+EndSysreg
+
 SysregFields	ICC_PPI_PRIORITYRx_EL1
 Res0	63:61
 Field	60:56	Priority7


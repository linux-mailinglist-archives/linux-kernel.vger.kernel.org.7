Return-Path: <linux-kernel+bounces-722200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D88AFD666
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7483AD113
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A102EAB98;
	Tue,  8 Jul 2025 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hX8mmJhA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kw1lij6W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10052EA727
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998843; cv=none; b=Chp9HLYjkvBV3aBxQC83oDP78Zyt43I33K4gqizYgilsKZFT8aMDH2zUey+Hhyq/gKSVTtsKBH0OfrpV/jt8BXjRM2GM5g7XHXkylk2Zho69tRKi7H0sAA7ELhC+9JV1wzOrKOZ+OQzla0yISRoqRAkwJsbYUy7E20NihkI3PoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998843; c=relaxed/simple;
	bh=53IU1Td5kT2HA33czjrBHTr+XYvQI5taoJKh5FcKuaw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FMN5sHkg3CJZkMthWQwvZ//1uOHp/ycxWUDqOK3Erde0fp4DOoRgjeJvMshu2NeDcvg0gw/wj5adT9EGcbDboPwNxSOCBqwNpAmu9k6PRZmfSi0rK22BNdXPdK/pmRuhTw0a5vrliMXPG3AAc0zweL+LcAy7dg8Qdgkln3l48DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hX8mmJhA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kw1lij6W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YOycKbqe9I20/SGxtTQcez5zRhq29cFMr7ZVAaEzom8=;
	b=hX8mmJhAd+XRMQlqt3fQEFyb2sEsWo6jmXAsF1gNI0EHnBbZW8/oVbHILcWTD1sAe9vbfH
	148QgxVINImniJOmqNKS1xNKNlLjs1ugGq8BRc5LtoJbVUpytW2Uybn2/0aZQP3luu7rnY
	BDbdK/FFqFiQDIARNqFkeiKTURsAgjm7xCvuFKa/Sun0OwEW3OGYFr9qKaQ6BoeWllRQwQ
	desDH4kLHoz7duVNbFne8yQ5AYay025o8NLaf3M/f8pVD8P4RpjxHkKojVDw1TN+SA4/fL
	dr96IYCVihbtfyocgFiIJ9FDn6rp7cMTh/2mV2M8A+qV7MtnyIlX7sCc4pgUTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YOycKbqe9I20/SGxtTQcez5zRhq29cFMr7ZVAaEzom8=;
	b=Kw1lij6WqjDRVqbfrW+yJv6B0Dx+TbFFfKeA6h/qWEiUws9bj7RDV2Ge68CqitJLwf3Vls
	sLeTM99kRY7XoYDQ==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject:
 [irqchip: irq/irqchip-next] arm64/sysreg: Add ICC_PPI_{C/S}PENDR<n>_EL1
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 tglx@linutronix.de
In-Reply-To: <20250703-gicv5-host-v7-8-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-8-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199883915.406.6561129099685600749.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     3037134b1b627afce46669a781a8e9d42437de4c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3037134b1b627afce46669a781a8e9d42437de4c
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:24:58 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:50 +01:00

arm64/sysreg: Add ICC_PPI_{C/S}PENDR<n>_EL1

Add ICC_PPI_{C/S}PENDR<n>_EL1 registers description.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-8-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 83 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index f165003..78a51fb 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3271,6 +3271,89 @@ Sysreg	ICC_PPI_SACTIVER1_EL1	3	0	12	13	3
 Fields ICC_PPI_ACTIVERx_EL1
 EndSysreg
 
+SysregFields	ICC_PPI_PENDRx_EL1
+Field	63	Pend63
+Field	62	Pend62
+Field	61	Pend61
+Field	60	Pend60
+Field	59	Pend59
+Field	58	Pend58
+Field	57	Pend57
+Field	56	Pend56
+Field	55	Pend55
+Field	54	Pend54
+Field	53	Pend53
+Field	52	Pend52
+Field	51	Pend51
+Field	50	Pend50
+Field	49	Pend49
+Field	48	Pend48
+Field	47	Pend47
+Field	46	Pend46
+Field	45	Pend45
+Field	44	Pend44
+Field	43	Pend43
+Field	42	Pend42
+Field	41	Pend41
+Field	40	Pend40
+Field	39	Pend39
+Field	38	Pend38
+Field	37	Pend37
+Field	36	Pend36
+Field	35	Pend35
+Field	34	Pend34
+Field	33	Pend33
+Field	32	Pend32
+Field	31	Pend31
+Field	30	Pend30
+Field	29	Pend29
+Field	28	Pend28
+Field	27	Pend27
+Field	26	Pend26
+Field	25	Pend25
+Field	24	Pend24
+Field	23	Pend23
+Field	22	Pend22
+Field	21	Pend21
+Field	20	Pend20
+Field	19	Pend19
+Field	18	Pend18
+Field	17	Pend17
+Field	16	Pend16
+Field	15	Pend15
+Field	14	Pend14
+Field	13	Pend13
+Field	12	Pend12
+Field	11	Pend11
+Field	10	Pend10
+Field	9	Pend9
+Field	8	Pend8
+Field	7	Pend7
+Field	6	Pend6
+Field	5	Pend5
+Field	4	Pend4
+Field	3	Pend3
+Field	2	Pend2
+Field	1	Pend1
+Field	0	Pend0
+EndSysregFields
+
+Sysreg	ICC_PPI_CPENDR0_EL1	3	0	12	13	4
+Fields ICC_PPI_PENDRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_CPENDR1_EL1	3	0	12	13	5
+Fields ICC_PPI_PENDRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_SPENDR0_EL1	3	0	12	13	6
+Fields ICC_PPI_PENDRx_EL1
+EndSysreg
+
+Sysreg	ICC_PPI_SPENDR1_EL1	3	0	12	13	7
+Fields ICC_PPI_PENDRx_EL1
+EndSysreg
+
 SysregFields	ICC_PPI_PRIORITYRx_EL1
 Res0	63:61
 Field	60:56	Priority7


Return-Path: <linux-kernel+bounces-722206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9548AAFD66B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B8C54501F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4B82EACF5;
	Tue,  8 Jul 2025 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x2MVeQWT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I/yL68p2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFBD2E6133
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998849; cv=none; b=Z3DHAeCFd5ylT6pNaAkxIdiZiBuQmlUcuJod2qR4y4QHfPIMHaggCwjj84lDY1IZ4LvfSDWb65a5ueTiIhrw711QV8Wf9h+BQF/CqJc61Ug0uHqdrg3jhGi7snBMwFIf5va+qV0ZCi50VcOouMQYT7pXmVq4V3NhmA2KGklyA/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998849; c=relaxed/simple;
	bh=Qhdqh5Xn0fxGv1NuEMJ5L9JVsO1QsUXA01/BGTntQrI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nSstM8fTGdjYaBNvLhGstqH7c98ZKEoNoqM+39R9u4mWpdYm05doJtmbwe5GWPx/XkKa+q157itZ/pRrUHPoxGLTEBFSl1Md0wfReu2G8P4CVnADS10420MncugbBM2A51Wo1Hf9JjNUNl1b8ljWeWqbZP8+1oMdMxYSvEONlTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x2MVeQWT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I/yL68p2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998845;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WlQ0IXtijJ/JWORjXD6UYQOzYqOJRjRliW7jyHTr0zU=;
	b=x2MVeQWT6UOxs4Rbq1jGfBAB9QB6NSEgMGRNSyS4E2zQByU0+Ghztil6/p6yNBfFdq/Ce3
	23U0WehkUxkr/MYWAeIhViJOCpIg+gRPSR9EhcQ+YLDbop1aMj1UQlmFOowtbPOEPK2tMO
	biwWxSIf/VpE1ApJd1xS6y02hH9bQDLyMlnCBLXn3XOSUGjBUcDtGDa2FWYtPznRUJF2YV
	yUs5HWWdzLJrP9T8wp+XXQlXO1wz64erxoVN7z1hg1xSYkjkniDCIayIngIDF07Ax0VfY3
	TlNpLAU0BsvQqXB3q7hBofY7vv7lGi4yhBsWlcRl7db+5RBOsu625dr3l0vh6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998845;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WlQ0IXtijJ/JWORjXD6UYQOzYqOJRjRliW7jyHTr0zU=;
	b=I/yL68p2SQAYcfDqN1lz2wtGWSDB/2oR06dAwoglVfQMybWQ+SKcQpSBNiFdJUZaydoodI
	CDD/jfjCb0hrY+Aw==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject:
 [irqchip: irq/irqchip-next] arm64/sysreg: Add GCIE field to ID_AA64PFR2_EL1
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 tglx@linutronix.de
In-Reply-To: <20250703-gicv5-host-v7-2-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-2-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199884443.406.175735847062526729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     2a30a8124c55804b03a2ec064dbbe1a2bd1d9ad8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/2a30a8124c55804b03a2ec064dbbe1a2bd1d9ad8
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:24:52 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:50 +01:00

arm64/sysreg: Add GCIE field to ID_AA64PFR2_EL1

Add field reporting the GCIE feature to ID_AA64PFR2_EL1 sysreg.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-2-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/tools/sysreg | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 8a8cf68..fb5bddc 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1314,7 +1314,10 @@ UnsignedEnum	19:16	UINJ
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	15:12
+UnsignedEnum	15:12	GCIE
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 UnsignedEnum	11:8	MTEFAR
 	0b0000	NI
 	0b0001	IMP


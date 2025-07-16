Return-Path: <linux-kernel+bounces-732982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 334E0B06E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4D71A621FE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5C628937A;
	Wed, 16 Jul 2025 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rQq2RcuW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tgveTgXl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5885A28AAFD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649289; cv=none; b=oGct62LGjyK9k4+G0oCnIlDdaQXv426oDiJPtVKydeaUqcSj8FzX9Q4hJHbRLrfhWtmQT2U32VHeogfA0fG46RPmk8+NEdFx0oPIwP7tFyuneUIbELtDbMh6m5R/dHoRD9EMRtLisqIWxHiO55gWfHLeYWao8V8on5gJNiIcVTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649289; c=relaxed/simple;
	bh=8ZuR3rD6nGMrbJd9zESMGNwg89XIQI6u5f1o0xzubkY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ZPeeMMiVWK8TAaYkRHJqwvxySIqmFidOe4Vt4KEt1EFKeZmvCy6jxp/Gy37ifGuNqjKPZsh0AQTVOYsOpNOx7sJ2h2CGYNRHztohi9gf3sF10chUA5xKF51E5utg7RhQy71q0dUgGvBv+RJSLy+lyjdU0jpb+tQlFWdeK3FU20M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rQq2RcuW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tgveTgXl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 07:01:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752649285;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=K3SkNrJ9Llpr0XwksIqYmAQhU6mUacji1sJ6KUe2Mi8=;
	b=rQq2RcuWMS0H+ViWONrAPnuPOw30vAmBIzGy4DOWxJJICYPooviru7Qyzuk5UZUBldh/Zy
	EMpHB6G9gBzfPq16v0MMXt+gAakQfvK0/U2MaVK1Ehh6WzoqfR1HP88iFLjA16WCYJPQ1c
	CDzJxMEnFbSNJl4chdlh9X1K4bkPkPN3nrZxXpJCfHANoyxSC96AXTcHF4osyf3SXVPiGo
	bBBFdnn2J79vD33rctiABWdUxEVDAGzJG5phlshDFQ6Gm6C3LDtEiFTNGG07GwAe1OT4oe
	yrgJwAw9UoFtz1PFD+6ctdSI7FQ3jJTcNJfIGQxQHXjcPPrRaX0CAPa/I33RPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752649285;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=K3SkNrJ9Llpr0XwksIqYmAQhU6mUacji1sJ6KUe2Mi8=;
	b=tgveTgXlnT3TNvYstYnLV1rpeVhN+GUVq4bB0p6HOiJXowK6kKZqTWVnQ+/o4bpmv5/XRM
	7RUw1sRnEj5NxWBw==
From: "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject:
 [irqchip: irq/irqchip-next] arm64: smp: Fix pNMI setup after GICv5 rework
Cc: Breno Leitao <leitao@debian.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 tglx@linutronix.de
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175264928403.406.14073386220629108833.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     65a5520a27570787b17e6f0b093829fc7e0514e2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/65a5520a27570787b17e6f0b093829fc7e0514e2
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 15 Jul 2025 18:11:12 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 15 Jul 2025 18:11:12 +01:00

arm64: smp: Fix pNMI setup after GICv5 rework

Breno reports that pNMIs are not behaving the way they should since
they were reworked for GICv5. Turns out we feed the IRQ number to
the pNMI helper instead of the IPI number -- not a good idea.

Fix it by providing the correct number (duh).

Fixes: ba1004f861d16 ("arm64: smp: Support non-SGIs for IPIs")
Reported-by: Breno Leitao <leitao@debian.org>
Suggested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 4797e2c..a900835 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1093,7 +1093,7 @@ static void ipi_setup_sgi(int ipi)
 
 	irq = ipi_irq_base + ipi;
 
-	if (ipi_should_be_nmi(irq)) {
+	if (ipi_should_be_nmi(ipi)) {
 		err = request_percpu_nmi(irq, ipi_handler, "IPI", &irq_stat);
 		WARN(err, "Could not request IRQ %d as NMI, err=%d\n", irq, err);
 	} else {


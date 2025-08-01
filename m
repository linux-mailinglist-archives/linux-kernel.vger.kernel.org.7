Return-Path: <linux-kernel+bounces-753026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2469CB17DE2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591513AD040
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF59E21B185;
	Fri,  1 Aug 2025 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVNXkKfP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A3421A43D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035128; cv=none; b=SNYk4aelK/i/XK8V6qmVDVeArCAuXao8w2WUekosisoLyQatUgf+B896eiWNM6n+24bzt0OcmO7+71lyrtblRu0TzuE3tQVGV1MsXy/ySJhxuqmbLzBErZMReoW1tC2oG9V8qxtx3CA6uahbQgFh4OpWnnWx+UfY4INiuoYJ5c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035128; c=relaxed/simple;
	bh=hTPka0+81M201oPI7GZI6XuIue8ZoP/MzhVc+eZGACg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q+qjXqkTWNrVWlt5NCCZAA1AA6ALDCLhtjzXt2jYB1x55mQl3u+6c9rZr0Awm2yyAL9N8xwFEDkJZhMw/LDILd5uwe7G8DhD5d5XI3f5Fqu69vTowOuGAQ+onwYoH8B8smjAgxe4KBa3J9x2eTTD5qO2O59mZZ2twuppttyl/q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVNXkKfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B706C4CEF8;
	Fri,  1 Aug 2025 07:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754035127;
	bh=hTPka0+81M201oPI7GZI6XuIue8ZoP/MzhVc+eZGACg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gVNXkKfPSVCJTbgWig5KIlQBcYWtKG/dz0HXi8RJz3eZKzie1Cstp/+pt/XVoLtws
	 vpecW5OF2dlDv5JxPC1DwggmQBLQXdD5OY5QsFVSdhdWk+G/nMPkA/6/51Whg4NviA
	 zQPNAAuePCRlplcnTiSMVqaqBL8xnEaUDU/rEp9Vg4lbKoFvlg28ma3n5p7FKBWmKg
	 UlLh5YR0SBz+1rClqyKaA3tLQ33h5EngqH72ZQ1d+Ek/b40pHG6cxPMGp4VnL5udIY
	 PHOz+akB45uPdJXNm4bGUO8V/2C+LJeV1oe4ZYpGlXmZUahumR0BlB5ZQgC8ch2lGM
	 JekxPyAUVloPA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Fri, 01 Aug 2025 09:58:20 +0200
Subject: [PATCH 3/3] irqchip/gic-v5: Remove IRQD_RESEND_WHEN_IN_PROGRESS
 for ITS IRQs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-gic-v5-fixes-6-17-v1-3-4fcedaccf9e6@kernel.org>
References: <20250801-gic-v5-fixes-6-17-v1-0-4fcedaccf9e6@kernel.org>
In-Reply-To: <20250801-gic-v5-fixes-6-17-v1-0-4fcedaccf9e6@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Sascha Bischoff <sascha.bischoff@arm.com>, 
 Timothy Hayes <timothy.hayes@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.15-dev-6f78e

GICv5 LPI interrupts have an active state hence they cannot retrigger
while the IRQ is being handled.

Therefore setting IRQD_RESEND_WHEN_IN_PROGRESS for GICv5 ITS
interrupts provides no benefit and it is useless (and confusing),
it solves an issue that cannot happen.

Remove it.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v5-its.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
index 340640fdbdf6..9290ac741949 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -973,7 +973,6 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain *domain, unsigned int vi
 		irqd = irq_get_irq_data(virq + i);
 		irqd_set_single_target(irqd);
 		irqd_set_affinity_on_activate(irqd);
-		irqd_set_resend_when_in_progress(irqd);
 	}
 
 	return 0;

-- 
2.48.0



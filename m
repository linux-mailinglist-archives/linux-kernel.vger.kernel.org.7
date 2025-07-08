Return-Path: <linux-kernel+bounces-722185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2731AFD656
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F5A27B42D0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C6821ADC9;
	Tue,  8 Jul 2025 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bh6pkGc9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QAwPmK9W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EE82E7636
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998830; cv=none; b=Z8HUW0Jo2jMFVS+E3eX2xxktATYJCBoOhuNvAaaryXk2z7ao6jCjSPq3ShMiNwP+2BJiaSj49uAuT1pUMu6s4gZu7flCRY4r3cFVb6fSq2DBpQvBJpltHRWnHpcM1KJFrrACRpRzt92i9uYDyy7tU/1bGWl5qKPMIOQgB5LW7Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998830; c=relaxed/simple;
	bh=GWelOcTJiAKlFe7sEwL46MQsflKO+H0Qv0qVdzpqBpQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pA6pEhlqFNf/u0uEdFYIABPd5rD8TZREBV9+pF07r+LIz8wM+4pZa2rFNVXLdlBVyN5ZG265bh06Qgxj+//t13Xbz47PFZXvB/5ss6ONqzo70zPQZjt0gjLs0xS6EDJDTfpHyH7upUCRGk7LrRvNjS5FXMbl7h8v86DrKx4wTU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bh6pkGc9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QAwPmK9W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998826;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hVAvfZUvAR8qJ1ePMfXBXVWL+5J5WsEft2m6jEAR8o=;
	b=bh6pkGc9xivUMP2XR/2RhWlZS/OlwmHAaPO54VyDKl6XyaHveyegLvP6AyXmBhDBSypoQw
	V3Ddwq/H72JyRCX5krbG1VLtQsljZCT/7B0c3Kwdjcb/cn1hLhPEn+MLnXlcGUwAcdjlj9
	qHCeZBpsuEIR5iKC0Ew8EsLEa5bXCGG9QI4/hxYb8sgG9difE+zl0yo2JjO3az/OLyz31n
	B8X8/sEoDsppQkdJKrJyOLVNu8E0iasPpMop7KfD6JEdLgiQ4sdCcph9uCrBv9y/j6BIMq
	ROhyoBojmdrMJS6Ht1nbcUDDKKWDlSeQXW1dfaa6pHMa6q0MyjR9kwnOzYQ0Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998826;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hVAvfZUvAR8qJ1ePMfXBXVWL+5J5WsEft2m6jEAR8o=;
	b=QAwPmK9WK1RvpF49j9UMZ0Wv2I/MWrybzIJF0C5Gbt6+KcuuFtUkohYpG2tX9bq91P8jS8
	lsnr2Y5/rErpCADA==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v5: Enable GICv5 SMP booting
Cc: Sascha Bischoff <sascha.bischoff@arm.com>,
 Timothy Hayes <timothy.hayes@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20250703-gicv5-host-v7-23-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-23-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199882553.406.1390196092183256486.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     03a28dc39838e67164728ad410081352b1589d78
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/03a28dc39838e67164728ad410081352b1589d78
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:25:13 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:52 +01:00

irqchip/gic-v5: Enable GICv5 SMP booting

Set up IPIs by allocating IPI IRQs for all cpus and call into
arm64 core code to initialise IPIs IRQ descriptors and
request the related IRQ.

Implement hotplug callback to enable interrupts on a cpu
and register the cpu with an IRS.

Co-developed-by: Sascha Bischoff <sascha.bischoff@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
Co-developed-by: Timothy Hayes <timothy.hayes@arm.com>
Signed-off-by: Timothy Hayes <timothy.hayes@arm.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-23-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v5.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
index 84ed13c..97ff935 100644
--- a/drivers/irqchip/irq-gic-v5.c
+++ b/drivers/irqchip/irq-gic-v5.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt)	"GICv5: " fmt
 
+#include <linux/cpuhotplug.h>
 #include <linux/idr.h>
 #include <linux/irqdomain.h>
 #include <linux/slab.h>
@@ -918,6 +919,8 @@ static void gicv5_cpu_enable_interrupts(void)
 	write_sysreg_s(cr0, SYS_ICC_CR0_EL1);
 }
 
+static int base_ipi_virq;
+
 static int gicv5_starting_cpu(unsigned int cpu)
 {
 	if (WARN(!gicv5_cpuif_has_gcie(),
@@ -929,6 +932,22 @@ static int gicv5_starting_cpu(unsigned int cpu)
 	return gicv5_irs_register_cpu(cpu);
 }
 
+static void __init gicv5_smp_init(void)
+{
+	unsigned int num_ipis = GICV5_IPIS_PER_CPU * nr_cpu_ids;
+
+	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
+				  "irqchip/arm/gicv5:starting",
+				  gicv5_starting_cpu, NULL);
+
+	base_ipi_virq = irq_domain_alloc_irqs(gicv5_global_data.ipi_domain,
+					      num_ipis, NUMA_NO_NODE, NULL);
+	if (WARN(base_ipi_virq <= 0, "IPI IRQ allocation was not successful"))
+		return;
+
+	set_smp_ipi_range_percpu(base_ipi_virq, GICV5_IPIS_PER_CPU, nr_cpu_ids);
+}
+
 static void __init gicv5_free_domains(void)
 {
 	if (gicv5_global_data.ppi_domain)
@@ -1050,6 +1069,8 @@ static int __init gicv5_of_init(struct device_node *node, struct device_node *pa
 	if (ret)
 		goto out_int;
 
+	gicv5_smp_init();
+
 	return 0;
 
 out_int:


Return-Path: <linux-kernel+bounces-722183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9439DAFD651
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2E71BC5DED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7102E7647;
	Tue,  8 Jul 2025 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NSEnKiaJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GXLH7Uy5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB402E7160
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998828; cv=none; b=p7Rdynrx3T0CatQ5A8OPpx1tyPkoYHYNCutirtlITvJyEhI5Zc9aKp8dXi1YU0EALb3hdktMJGVaHItCVN+6NKlZB2zsL5jNXDFP24kR9zI01+YsVbTeDv6LW7BXKgET264ljj/3LAXdEnIS1Huvq/VabTR7wwWSZuYFQwARxJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998828; c=relaxed/simple;
	bh=w9kVMABScZKulbreto7ecaBu72jruf3g4O7+vdNWIk0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NYsX5ZaCfknhXdT9TZGhb0VxR5qEBzdum5umsBHcYchg+rfxi3pUHsCsZkAG2nNsYrXOjPC38BqJZM5gs0pft/RNKFTeXowq2juJRO7zouF/JIr7ThhQptXMYXjtI3jI8lO/ZXSOU4chiSymDYkKfhMMeW8/z7+y3+1Xus3RMtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NSEnKiaJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GXLH7Uy5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998824;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9y9OB04F3K7QiIUckjftrBZpHY+IlfnxBL/Qtplq38o=;
	b=NSEnKiaJSJhUdQCiWwWv7xuCj9A0MB4MvwsvyfYScGe2tNcwHsLYJCFDNoPrQTaOkxygwy
	3kTG3rtt5/QrfvId0XWoXJhL1J2fOu9m1T5twrEEDkUqLIgbwNshyCTN04t/ADSN14AVUf
	e3bBIOLzkgtiqjiORR4EPulC1Cza0g+NT0LEamXYN1dczAxyYqtdWviKedI6sGHEtkmVSn
	FVD2lBhZoUw4GYGRXAUZ2zeAV+XOTjEr4p1tHAR8DKTbUDA6SLHhVv7gNXxcAeBy0loU9w
	SoZQ/n0qRpigmK128VAU5JrhIHIqGe1iAGykA2SBP/LuClkK+SNzE/OR/nqh2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998824;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9y9OB04F3K7QiIUckjftrBZpHY+IlfnxBL/Qtplq38o=;
	b=GXLH7Uy5/eXKjQM3EIvkJRrhnerdNM/O5Xh6M2/eUK4bUqg2FIi4Ognj+KeklkNNr1WbFN
	A9uZvkclV8Xos3Ag==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] PCI/MSI: Add pci_msi_map_rid_ctlr_node()
 helper function
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20250703-gicv5-host-v7-25-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-25-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199882378.406.5689367628653201552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     cd0ec59affb1f31347170bbafadb9c5cc716bca9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/cd0ec59affb1f31347170bbafadb9c5cc716bca9
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:25:15 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:52 +01:00

PCI/MSI: Add pci_msi_map_rid_ctlr_node() helper function

IRQchip drivers need a PCI/MSI function to map a RID to a MSI
controller deviceID namespace and at the same time retrieve the
struct device_node pointer of the MSI controller the RID is mapped
to.

Add pci_msi_map_rid_ctlr_node() to achieve this purpose.

Cc  Bjorn Helgaas <bhelgaas@google.com>

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-25-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/msi/irqdomain.c | 20 ++++++++++++++++++++
 include/linux/msi.h         |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index c051527..8a6e80d 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -428,6 +428,26 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 }
 
 /**
+ * pci_msi_map_rid_ctlr_node - Get the MSI controller node and MSI requester id (RID)
+ * @pdev:	The PCI device
+ * @node:	Pointer to store the MSI controller device node
+ *
+ * Use the firmware data to find the MSI controller node for @pdev.
+ * If found map the RID and initialize @node with it. @node value must
+ * be set to NULL on entry.
+ *
+ * Returns: The RID.
+ */
+u32 pci_msi_map_rid_ctlr_node(struct pci_dev *pdev, struct device_node **node)
+{
+	u32 rid = pci_dev_id(pdev);
+
+	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
+
+	return of_msi_xlate(&pdev->dev, node, rid);
+}
+
+/**
  * pci_msi_get_device_domain - Get the MSI domain for a given PCI device
  * @pdev:	The PCI device
  *
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 6863540..a418e26 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -705,6 +705,7 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
+u32 pci_msi_map_rid_ctlr_node(struct pci_dev *pdev, struct device_node **node);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
 #else /* CONFIG_PCI_MSI */
 static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)


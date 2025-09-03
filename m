Return-Path: <linux-kernel+bounces-798793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C7CB422FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2001BA33CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DB030FC19;
	Wed,  3 Sep 2025 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LsEahmPS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NpJErwMq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105B230EF6A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908293; cv=none; b=InMd66NE+WYEdgZ3AV0o8SSz7uAEjfjjwgxpalHLSD2YlFQvPgbgZR/COuJ9fNZRTINkcxNhGRDHisIr+XQziJsur9jnN7o+eRy2qIw8dEjql3IE83fQMniN4zL883aU8Tis/gRo+UBuB/IQOlNZXUqd/1JbgG6SWy1eujgm+4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908293; c=relaxed/simple;
	bh=XJsdfKXolKL7MQMpmsEoCa/sJdGQ8gQET+iiNg76i88=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=BQIqcudp813sga4Wnf0RskJoQe0LsJHlTBdc4pB90Jqje/Xp6hnWsQRT+P9FNrHhmb4AV2FQH/IBu1w8fQPgDJLHSM9bAAT41dgSTEgfCRS4+t71zhS0yNUb8EpFYaXCODD67/s5OQ+7M+2X76y+brh1DYnKZft83mpoEFyswqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LsEahmPS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NpJErwMq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250903135433.444329373@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756908289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QKiSmAlCPU4t8RZAP+5VMuWb25EaM54GJSGXdcx/Xvo=;
	b=LsEahmPSXjRVb2sYx+imvHKn2gIcyw5vrivjxXFuO2tgtzFzqkkWgYSXhvLghnm+9F/5JW
	V3iq/ccXBfinrwpvLiK6fXBVX7JiXFJbql//84nqHshBuC+DCPo2iVUR6Mw7D7DU4DniG3
	WmwlrmvhJYclWXOxPNH9I0iEBe3QuAK6bZszH2gUvnSOxNLHKZqm7RzKoHocZNi4r6jotf
	iCwLeQ6VqA/loCYGzYEYbMER92Mpj6M7oZiPHvzro75xcvg+TQqTjtuedNWgvnNJhUwRmT
	uWIhZVmxYolPgPkSY/qAJ/JMpDeNfBLdn8oKyXV8sDgwxO4zxMqHfCAMmhzALQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756908289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QKiSmAlCPU4t8RZAP+5VMuWb25EaM54GJSGXdcx/Xvo=;
	b=NpJErwMqUCIJxMSLpwtrkRG6ahIsq+ORuUAsr//0UQI44xSMgYcWeyAVCukzX4u+TNINuU
	VagEt3mGKRWfEcBA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [patch 2/2] PCI/MSI: Remove the conditional parent [un]mask logic
References: <86o6vjelw2.wl-maz@kernel.org>
 <87ecv1ob9q.ffs@tglx>
 <20250903134437.863638669@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed,  3 Sep 2025 16:04:48 +0200 (CEST)

Now that msi_lib_init_dev_msi_info() overwrites the irq_[un]mask()
callbacks when the MSI_FLAG_PCI_MSI_MASK_PARENT flag is set by the parent
domain, the conditional [un]mask logic is obsolete.

Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi/irqdomain.c |   20 --------------------
 1 file changed, 20 deletions(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -170,22 +170,6 @@ static unsigned int cond_startup_parent(
 	return 0;
 }
 
-static __always_inline void cond_mask_parent(struct irq_data *data)
-{
-	struct msi_domain_info *info = data->domain->host_data;
-
-	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
-		irq_chip_mask_parent(data);
-}
-
-static __always_inline void cond_unmask_parent(struct irq_data *data)
-{
-	struct msi_domain_info *info = data->domain->host_data;
-
-	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
-		irq_chip_unmask_parent(data);
-}
-
 static void pci_irq_shutdown_msi(struct irq_data *data)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
@@ -208,14 +192,12 @@ static void pci_irq_mask_msi(struct irq_
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
 
 	pci_msi_mask(desc, BIT(data->irq - desc->irq));
-	cond_mask_parent(data);
 }
 
 static void pci_irq_unmask_msi(struct irq_data *data)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
 
-	cond_unmask_parent(data);
 	pci_msi_unmask(desc, BIT(data->irq - desc->irq));
 }
 
@@ -268,12 +250,10 @@ static unsigned int pci_irq_startup_msix
 static void pci_irq_mask_msix(struct irq_data *data)
 {
 	pci_msix_mask(irq_data_get_msi_desc(data));
-	cond_mask_parent(data);
 }
 
 static void pci_irq_unmask_msix(struct irq_data *data)
 {
-	cond_unmask_parent(data);
 	pci_msix_unmask(irq_data_get_msi_desc(data));
 }
 



Return-Path: <linux-kernel+bounces-843549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B09BBFB43
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E099E3BF645
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9258221578;
	Mon,  6 Oct 2025 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fkKhLkEY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E4621ABDC
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759790359; cv=none; b=tge8sUwyN3JvZTYbCPdDoDTqQcOolkVchjEI+BMNC7WOPkRFUCHCQE2D4fBGWQKZMZCvMJJpTiPSt2e1A7snL2yWIj+szt1m9UAqlHnAaimaWbS4s9Dlv3sN1vpSqrKzNkdFAw20B8QBoFsNV0UwYjTyEgjXnIYGzWmbt7xxzFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759790359; c=relaxed/simple;
	bh=v2balxYhfEcJ/EnYHNW7wLHYTl9HcdUj5/hX6D7UW/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdSGz4p/3TlyGi1WyIa3RqYcH5gdTrhpsuffcpv9CHfq6vEGCMENTYnjR1S0o87+dvVTMy2mVePJaIe8EzUZe/E/DtOlivOUIKbBxyIbqsWqozXuOAl/wsuJwS5HTDRt+ABNLCMQ6s+o4JSVZNW0/QpOjuMX+uyGxFSv9i1M9uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fkKhLkEY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759790356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lwjp3opGuGuGO1UbSv0/ykaLEKgKP087rhwfN3x+wIs=;
	b=fkKhLkEY31GezgBaNQJFoyHCpBdwX6yh2jpcpC5Ke5Rssxd8ba+PTp5NLXsRcqch+TovgP
	iffKme9U4Anmokw1VtTo4P02x0cX2H0BKDlVXMovJCrJoOuxr3cZLgD2N229e6VuXVU11c
	JrPk2jUtZTFDV0ALOtHYXW7KL84trr0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-CNVj4OsaMEWI-_rzL31j5Q-1; Mon,
 06 Oct 2025 18:39:11 -0400
X-MC-Unique: CNVj4OsaMEWI-_rzL31j5Q-1
X-Mimecast-MFC-AGG-ID: CNVj4OsaMEWI-_rzL31j5Q_1759790349
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C18A19560A2;
	Mon,  6 Oct 2025 22:39:09 +0000 (UTC)
Received: from thinkpad-p1.kanata.rendec.net (unknown [10.22.90.133])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 574B01800452;
	Mon,  6 Oct 2025 22:39:06 +0000 (UTC)
From: Radu Rendec <rrendec@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Daniel Tsai <danielsftsai@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Brian Masney <bmasney@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Jared Kangas <jkangas@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] PCI: dwc: Enable MSI affinity support
Date: Mon,  6 Oct 2025 18:38:13 -0400
Message-ID: <20251006223813.1688637-4-rrendec@redhat.com>
In-Reply-To: <20251006223813.1688637-1-rrendec@redhat.com>
References: <20251006223813.1688637-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Thomas Gleixner <tglx@linutronix.de>

Leverage the interrupt redirection infrastructure to enable CPU affinity
support for MSI interrupts. Since the parent interrupt affinity cannot
be changed, affinity control for the child interrupt (MSI) is achieved
by redirecting the handler to run in IRQ work context on the target CPU.

This patch was originally prepared by Thomas Gleixner (see Link tag
below) in a patch series that was never submitted as is, and only
parts of that series have made it upstream so far.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/linux-pci/878qpg4o4t.ffs@tglx/
Co-developed-by: Radu Rendec <rrendec@redhat.com>
Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 33 ++++++++++++++++---
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 69051b1d72c2e..fb07a028f6d77 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -25,9 +25,27 @@
 static struct pci_ops dw_pcie_ops;
 static struct pci_ops dw_child_pcie_ops;
 
+#ifdef CONFIG_SMP
+static void dw_irq_noop(struct irq_data *d) { }
+#endif
+
+static bool dw_pcie_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				      struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+#ifdef CONFIG_SMP
+	info->chip->irq_ack = dw_irq_noop;
+	info->chip->irq_pre_redirect = irq_chip_pre_redirect_parent;
+#else
+	info->chip->irq_ack = irq_chip_ack_parent;
+#endif
+	return true;
+}
+
 #define DW_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
 				    MSI_FLAG_USE_DEF_CHIP_OPS		| \
-				    MSI_FLAG_NO_AFFINITY		| \
 				    MSI_FLAG_PCI_MSI_MASK_PARENT)
 #define DW_PCIE_MSI_FLAGS_SUPPORTED (MSI_FLAG_MULTI_PCI_MSI		| \
 				     MSI_FLAG_PCI_MSIX			| \
@@ -39,9 +57,8 @@ static const struct msi_parent_ops dw_pcie_msi_parent_ops = {
 	.required_flags		= DW_PCIE_MSI_FLAGS_REQUIRED,
 	.supported_flags	= DW_PCIE_MSI_FLAGS_SUPPORTED,
 	.bus_select_token	= DOMAIN_BUS_PCI_MSI,
-	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
 	.prefix			= "DW-",
-	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+	.init_dev_msi_info	= dw_pcie_init_dev_msi_info,
 };
 
 /* MSI int handler */
@@ -62,7 +79,7 @@ void dw_handle_msi_irq(struct dw_pcie_rp *pp)
 			continue;
 
 		for_each_set_bit(pos, &status, MAX_MSI_IRQS_PER_CTRL)
-			generic_handle_domain_irq(pp->irq_domain, irq_off + pos);
+			generic_handle_demux_domain_irq(pp->irq_domain, irq_off + pos);
 	}
 }
 
@@ -139,10 +156,16 @@ static void dw_pci_bottom_ack(struct irq_data *d)
 
 static struct irq_chip dw_pci_msi_bottom_irq_chip = {
 	.name			= "DWPCI-MSI",
-	.irq_ack		= dw_pci_bottom_ack,
 	.irq_compose_msi_msg	= dw_pci_setup_msi_msg,
 	.irq_mask		= dw_pci_bottom_mask,
 	.irq_unmask		= dw_pci_bottom_unmask,
+#ifdef CONFIG_SMP
+	.irq_ack		= dw_irq_noop,
+	.irq_pre_redirect	= dw_pci_bottom_ack,
+	.irq_set_affinity	= irq_chip_redirect_set_affinity,
+#else
+	.irq_ack		= dw_pci_bottom_ack,
+#endif
 };
 
 static int dw_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
-- 
2.51.0



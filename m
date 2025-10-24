Return-Path: <linux-kernel+bounces-869453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EEFC07EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3E11AA4AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C7C2C0295;
	Fri, 24 Oct 2025 19:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ogxgI7YP"
Received: from smtp.smtpout.orange.fr (smtp-81.smtpout.orange.fr [80.12.242.81])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4332BEFF2;
	Fri, 24 Oct 2025 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761334762; cv=none; b=BWrWK7ApvLCzuzlE0+KQ0iYS+tT6O8nDJDax0hbKzebWHDUnM3oDUKr3CVKNF8jfe7FpmrKlAXEhl7U8XsqDX1g2te8bLik41pMt0Ml3EGtKpaTwPMaWU8KVcDLsgDLW55iU7FNuAihABhvoRP+l8DqP0nVfIWb7iHweFMdHpt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761334762; c=relaxed/simple;
	bh=ag+B16IygtW9FZgyE/zLeMJ4TjYkwMnN7o2cwPigeAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WAzlAoHTAoFk/psGTaWLcsixSWr8okN/QMqJNPXIST+dr/sRs59FFz0rb8I84M4dxv5SYXtdwPijM/aVaDDYOJTOWEacB1Kqi5z6yU6FdsYl/hV2n6G2ysL374wcSmnZfmgkJnAwzDEt71gQne2KW7yU4R9NZ093fYrEZVlaN+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ogxgI7YP; arc=none smtp.client-ip=80.12.242.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id CNcyvReICRty5CNcyvau3E; Fri, 24 Oct 2025 21:39:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1761334750;
	bh=VU+BxUzO6Y/jMbH69ytGtPE5+48qwtEjO6D6PpvMXWc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ogxgI7YPNHw1Mj6VB9BzdsFQbm4ZZby8PvWgMX31KwZMDsoVZk8FbYJynWEH87lr8
	 8R1NtJANej2zrg8HL4WSW4G/F8HNg8X/8lRnvRSFt3+SezfuieolAwjfIMaMZ+bGKY
	 kW5oHaOi+ehCjWwcLDaorh92ncx9ESAsEuvJHcIDftB0zEUTUpMKf3y6sTwiO/gXUx
	 Zo07w0E39fWVQZKz60iC4VchfP16vnGDILC0Zd7dNvYLlXIc/zThoOk/o6amWOVAJm
	 W/j3BceQ2vIEiywCOf1hKYtnbMNuVkd8G8rFSJLfmCvVglsrd3G5Hsj47kKTP4bBBB
	 FzbsNB8ihZJgQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 24 Oct 2025 21:39:10 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Andrea della Porta <andrea.porta@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2] misc: rp1: Fix a reference leak
Date: Fri, 24 Oct 2025 21:36:11 +0200
Message-ID: <8f55f8866a6680830c9d318201a29293ac50a591.1761334487.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reference taken by of_find_node_by_name() in the probe is not released
in the remove function.

In order to avoid a reference leak, use cleanup.h to automatically
release the reference at the end of the probe when it is not needed
anymore.

In order to do so, a reference also needs to be taken when DT is not used.

This simplifies the error handling path and makes direct returns possible
in several places.

While at it, also add a missing \n at the end of an error message.

Fixes: 49d63971f963 ("misc: rp1: RaspberryPi RP1 misc driver")
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is compile tested only.

This change is speculative. Review with care.

Changes in v2:
  - implement Dan's suggestions

v1: https://lore.kernel.org/lkml/4e92a271fdb98560c4e659556a1f3e99e7d0d38e.1760987458.git.christophe.jaillet@wanadoo.fr/
---
 drivers/misc/rp1/rp1_pci.c | 42 ++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/misc/rp1/rp1_pci.c b/drivers/misc/rp1/rp1_pci.c
index 803832006ec8..0abfeb4a28e3 100644
--- a/drivers/misc/rp1/rp1_pci.c
+++ b/drivers/misc/rp1/rp1_pci.c
@@ -5,6 +5,7 @@
  * All rights reserved.
  */
 
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -185,9 +186,9 @@ static void rp1_unregister_interrupts(struct pci_dev *pdev)
 static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	u32 dtbo_size = __dtbo_rp1_pci_end - __dtbo_rp1_pci_begin;
+	struct device_node *rp1_node __free(device_node) = NULL;
 	void *dtbo_start = __dtbo_rp1_pci_begin;
 	struct device *dev = &pdev->dev;
-	struct device_node *rp1_node;
 	bool skip_ovl = true;
 	struct rp1_dev *rp1;
 	int err = 0;
@@ -200,42 +201,40 @@ static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rp1_node = of_find_node_by_name(NULL, "rp1_nexus");
 	if (!rp1_node) {
 		rp1_node = dev_of_node(dev);
+		/*
+		 * Take a reference to match of_find_node_by_name()
+		 * behavior. This makes cleanup.h usable in both cases.
+		 */
+		of_node_get(rp1_node);
 		skip_ovl = false;
 	}
 
 	if (!rp1_node) {
 		dev_err(dev, "Missing of_node for device\n");
-		err = -EINVAL;
-		goto err_put_node;
+		return -EINVAL;
 	}
 
 	rp1 = devm_kzalloc(&pdev->dev, sizeof(*rp1), GFP_KERNEL);
-	if (!rp1) {
-		err = -ENOMEM;
-		goto err_put_node;
-	}
+	if (!rp1)
+		return -ENOMEM;
 
 	rp1->pdev = pdev;
 
 	if (pci_resource_len(pdev, 1) <= 0x10000) {
 		dev_err(&pdev->dev,
 			"Not initialized - is the firmware running?\n");
-		err = -EINVAL;
-		goto err_put_node;
+		return -EINVAL;
 	}
 
 	err = pcim_enable_device(pdev);
-	if (err < 0) {
-		err = dev_err_probe(&pdev->dev, err,
-				    "Enabling PCI device has failed");
-		goto err_put_node;
-	}
+	if (err < 0)
+		return dev_err_probe(&pdev->dev, err,
+				     "Enabling PCI device has failed\n");
 
 	rp1->bar1 = pcim_iomap(pdev, 1, 0);
 	if (!rp1->bar1) {
 		dev_err(&pdev->dev, "Cannot map PCI BAR\n");
-		err = -EIO;
-		goto err_put_node;
+		return -EIO;
 	}
 
 	pci_set_master(pdev);
@@ -243,13 +242,11 @@ static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	err = pci_alloc_irq_vectors(pdev, RP1_INT_END, RP1_INT_END,
 				    PCI_IRQ_MSIX);
 	if (err < 0) {
-		err = dev_err_probe(&pdev->dev, err,
-				    "Failed to allocate MSI-X vectors\n");
-		goto err_put_node;
+		return dev_err_probe(&pdev->dev, err,
+				     "Failed to allocate MSI-X vectors\n");
 	} else if (err != RP1_INT_END) {
 		dev_err(&pdev->dev, "Cannot allocate enough interrupts\n");
-		err = -EINVAL;
-		goto err_put_node;
+		return -EINVAL;
 	}
 
 	pci_set_drvdata(pdev, rp1);
@@ -295,9 +292,6 @@ static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	of_overlay_remove(&rp1->ovcs_id);
 err_unregister_interrupts:
 	rp1_unregister_interrupts(pdev);
-err_put_node:
-	if (skip_ovl)
-		of_node_put(rp1_node);
 
 	return err;
 }
-- 
2.51.0



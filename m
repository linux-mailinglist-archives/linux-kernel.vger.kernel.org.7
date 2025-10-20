Return-Path: <linux-kernel+bounces-861611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27288BF32E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C316D3A9F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937AD2D9481;
	Mon, 20 Oct 2025 19:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UsDV1yOl"
Received: from smtp.smtpout.orange.fr (smtp-76.smtpout.orange.fr [80.12.242.76])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D43325394B;
	Mon, 20 Oct 2025 19:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988038; cv=none; b=kDbg3O2kBg9cLTnyJtj3U0YW8W0aCk39zNJ2lcqIPaiFQfOFKh54slYcp6an5eRSKcj65fHOcWXhYMnAciGb8uq+/i8gk5tOxpqo8hxqy4b1FA9YBRqkU++V/ZQbwicHtoxzj2iMAKSgME+avh/6cD1RYwqXj5liYHZ8QEGvIrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988038; c=relaxed/simple;
	bh=L4UsWSzuusmlizFglphTpMbVFFClnAflcd2d6Tv4uYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ppZ9X43WNlSJrubRCLwnNMQVJMITteW7/UrauwC54+GawBBVuwJAGRRBMm1U73SYdDjBWB7XJ49JK4WuhC2NerQzK+F7w3jiHQOcxVg6/gbPnKJIWQ3LAl0uGdNnUFzSLNjHDWoiVttsh2E2gXiBJKtDJHlZB55yz1mLJxOvpjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UsDV1yOl; arc=none smtp.client-ip=80.12.242.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id AvHuvxg21KmV9AvHuvJma1; Mon, 20 Oct 2025 21:11:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1760987484;
	bh=xnC6hSP77KC5LZzIcnY+I3sTuSG/mCUZB+qcZYzF0fs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UsDV1yOlmsSNe1We7aX1s6h3ih42qyfDQYb9I4YEApoHPKvcly61lJmuw9zpCdxsW
	 87jpQqqPSEiY3gYh/cThVbIyFmjJl0Cg7q0jAE3QipIzF4ZxV4DrqM03NWKTQfrPO2
	 v8yN2KQ6FBKSCiKArNpiNdyBEwMcohzM6t+MeO5/6Nr0gq2HyDulLXbV8BnHJyS/pR
	 0TkHUIsGQheFRjv4m0/ZBjKCXtKIIPrLNWKSRV21m4Dp1l++Fu9eznY443i4LthCoQ
	 iTpGhTHjnthLID+owISCtHYUnZYAF/K0kSzmkSjnkcUDfBu1e1oi6gVykH8tEV0l2Z
	 B4gQAEun4E0vg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 20 Oct 2025 21:11:24 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Andrea della Porta <andrea.porta@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	devicetree@vger.kernel.org
Subject: [PATCH] misc: rp1: Fix some error handling paths
Date: Mon, 20 Oct 2025 21:11:16 +0200
Message-ID: <4e92a271fdb98560c4e659556a1f3e99e7d0d38e.1760987458.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Error handling in the probe and the clean-up path in the remove function
should be adjusted depending on if data is taken from DT or from overlay at
runtime.

of_overlay_remove() should not be called when of_overlay_remove() was not
called.

of_node_put() should be called in the remove function to avoid a potential
reference leak.

Fixes: 49d63971f963 ("misc: rp1: RaspberryPi RP1 misc driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is compile tested only.

I think (hope...) that a cleaner solution is possible. So feel free to
improve it or completely change it if needed.
---
 drivers/misc/rp1/rp1_pci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/rp1/rp1_pci.c b/drivers/misc/rp1/rp1_pci.c
index 803832006ec8..9105269488a9 100644
--- a/drivers/misc/rp1/rp1_pci.c
+++ b/drivers/misc/rp1/rp1_pci.c
@@ -44,6 +44,8 @@ struct rp1_dev {
 	struct irq_data *pcie_irqds[64];
 	void __iomem *bar1;
 	int ovcs_id;	/* overlay changeset id */
+	struct device_node *rp1_node;	/* useful only if skip_ovl == true */
+	bool skip_ovl;
 	bool level_triggered_irq[RP1_INT_END];
 };
 
@@ -289,10 +291,14 @@ static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_unload_overlay;
 	}
 
+	rp1->skip_ovl = skip_ovl;
+	rp1->rp1_node = rp1_node;
+
 	return 0;
 
 err_unload_overlay:
-	of_overlay_remove(&rp1->ovcs_id);
+	if (!skip_ovl)
+		of_overlay_remove(&rp1->ovcs_id);
 err_unregister_interrupts:
 	rp1_unregister_interrupts(pdev);
 err_put_node:
@@ -308,8 +314,12 @@ static void rp1_remove(struct pci_dev *pdev)
 	struct device *dev = &pdev->dev;
 
 	of_platform_depopulate(dev);
-	of_overlay_remove(&rp1->ovcs_id);
+	if (!rp1->skip_ovl)
+		of_overlay_remove(&rp1->ovcs_id);
 	rp1_unregister_interrupts(pdev);
+
+	if (rp1->skip_ovl)
+		of_node_put(rp1->rp1_node);
 }
 
 static const struct pci_device_id dev_id_table[] = {
-- 
2.51.0



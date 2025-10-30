Return-Path: <linux-kernel+bounces-877992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 846D0C1F82F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 734994E8B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF32D354AF3;
	Thu, 30 Oct 2025 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cuKxX9me"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7474F351FC3
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819872; cv=none; b=MSVYJbJ64HRgEqObJC/68/qO1hBBnGmTN7yv8wGI8MdtRkhmcjYf8/vPbbNcL6VFQlZYEjNB9fwvLF4xlRJyNf1bvsjgXiF2XjwhOBMiw8ZOsGJj9sATE5KwOTbNzyZq/ATE1MAFLp1fpyMvkhgm6Tbul/l9R8EU2L5nmRzr0jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819872; c=relaxed/simple;
	bh=Ez7a+wreIh7UMIo9IVUU+O2bN8hhAvrjsWtYzNG/hJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igLWanG+zH+LkZ6DhffmkylW46l4gvpMGLoQx/Ay/z8RFamfFiE1D8KC8AWI/OqEKyIxTmssYxIN5Isitez11LUUABxplvqGu5iuEPuk/PQx0Yr4YMnde6Byd4ty7Nrbpq9F74Z7mQvGwV+tLd0dZbVjy7918kitFn7RoD5KZ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cuKxX9me; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B2546C0DAAB;
	Thu, 30 Oct 2025 10:24:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 284156068C;
	Thu, 30 Oct 2025 10:24:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D81911808821;
	Thu, 30 Oct 2025 11:24:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761819868; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=RoyBPsQbxCeIyoPQ2zrzEdmuX54xkmjv6HtTh7tX2pE=;
	b=cuKxX9meA+bNJDneTgaqLKGwAeRY7C04U2PFcPPzTSTA9uWBDYQ0LRTaKNwIBFSD3I7Bzi
	ObVIj158RqAaCWrwRf9txLznrlOKryzaZB4nwF/0oqyKVx6pQk4raE090zw2mci+BK9iQT
	IibgK5D/5bmfhh3kOoQ/0WCrv+mWKZ6GYTSxggeieViKa0kDvlnHHMpZgXhRGX83uf6qMn
	LMz1d22VP5UDc72kb0mtMhlR5Nbd7K9ZX/GJJuets1I14b0pBELKf/wU/HCy6VqQjljV8h
	fEl0yPKiC2m8yS8kVIGzr9BoMaobqKdZWONokoR5helRQmT8GiWYVCRPXvtaUA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] net: altera-tse: Don't use netdev name for the PCS mdio bus
Date: Thu, 30 Oct 2025 11:24:16 +0100
Message-ID: <20251030102418.114518-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251030102418.114518-1-maxime.chevallier@bootlin.com>
References: <20251030102418.114518-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The PCS mdio bus must be created before registering the net_device. To
do that, we musn't depend on the netdev name to create the mdio bus
name. Let's use the device's name instead.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/altera/altera_tse_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index c74b1c11d759..a601ba57190e 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -1404,7 +1404,7 @@ static int altera_tse_probe(struct platform_device *pdev)
 			 (unsigned long) control_port->start, priv->rx_irq,
 			 priv->tx_irq);
 
-	snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-pcs-mii", ndev->name);
+	snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-pcs-mii", dev_name(&pdev->dev));
 	pcs_bus = devm_mdio_regmap_register(&pdev->dev, &mrc);
 	if (IS_ERR(pcs_bus)) {
 		ret = PTR_ERR(pcs_bus);
-- 
2.49.0



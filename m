Return-Path: <linux-kernel+bounces-882695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC0CC2B233
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47BB83494E7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57273016E0;
	Mon,  3 Nov 2025 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g0VtCmZg"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A27D301039
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166983; cv=none; b=dSGeVaS47if+lRBfX+Lo/0osbk7k4u3HzI9SbmajtuYPSChhBVyNCYihtsbaARmkZDqMmGGsRsmPyqdZmeFn0Aho7qynqO4SlCZLAdswJ2yUUTZhYkkzzM8+ObcJUw1RRZiZ1c8lb2eodD4yC4gmRutWMWolHJPuBgSrh8/rLU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166983; c=relaxed/simple;
	bh=xOzYIPM8KTs0S15N0TQI3qQZXr+215520Jm+o6h1zcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glIALn5ueQyGrs4JBiNygxgGBcx+MTimXRNSZMkFc68S3/J/XTwM2eXJYN2tddIA73RXt5yXcQfK/SZ1UyB83ISKWg4/1/bsKbDUUePoDpASUSqoac2BvJYU5yvy7dzsaowTx8VPWm+3BaAQCMlMzT3/MFbnXQN1+w74a9gO8Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g0VtCmZg; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D4EA41A183D;
	Mon,  3 Nov 2025 10:49:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A93DF60628;
	Mon,  3 Nov 2025 10:49:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55E0510B50014;
	Mon,  3 Nov 2025 11:49:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762166978; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=om6wHCpy7rTQ5fiCmhmBYc/5JN7l85iZJ6/YxQjLX1c=;
	b=g0VtCmZgHjb0pB3bwDcm4QpSfQDoVXlx0ge0ujYmBzpxsc12xZLGyWFZTAaYNfbId3dhGV
	olfOQFok4HXzsdG3dY6uxHaIeX3RL2InA90S6PHg8MBTgwKvJt3wAuvBFO3E6v1B8DtBzg
	269c+J6DqN7glyEr4XK55f+Wnkq+qO6I6uU6a5b81PfosIlPgoZKHFgrqH3baCFxq63WJ+
	WnDVFKDnZh3OxNWxvkSMTGJMytT2Rz7fY/7sykFBAaTkXzZ6nIuUBeUunIqQzoE2iiC5eC
	tP2QiWAzjjIvjCaSoOmpKay4VAahWk1XtqYi1fZpEzxzDR8fH4vPUOWxitaaDg==
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
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v2 3/4] net: altera-tse: Don't use netdev name for the PCS mdio bus
Date: Mon,  3 Nov 2025 11:49:26 +0100
Message-ID: <20251103104928.58461-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251103104928.58461-1-maxime.chevallier@bootlin.com>
References: <20251103104928.58461-1-maxime.chevallier@bootlin.com>
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

Note that this changes the bus name in /sys/bus/mdiobus

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/altera/altera_tse_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 343c78a493a1..003df8970998 100644
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



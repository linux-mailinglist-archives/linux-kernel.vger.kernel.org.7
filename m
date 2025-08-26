Return-Path: <linux-kernel+bounces-785727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AC3B3501C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619233A8669
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48CE191F84;
	Tue, 26 Aug 2025 00:14:50 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0445376025;
	Tue, 26 Aug 2025 00:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167290; cv=none; b=cIkPxwNKG07oqY10vY1P7mNp4u7j+dOsewGefc7HHQqRVNkYYbVzJXS9Yeiy+k30Mmwh6XaVCI2RmXb8rZ8VqOGceLe4LkWdGlx0OgrViz+zpL7ZFdz91P6Y7KdxMvnuKVLNVrywDfg0xljXFeYsw9yys183W0ZB+yZfm1bIv+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167290; c=relaxed/simple;
	bh=n9cbzdH7ESYKvouQ9dEpgVRV9hTKecz7pQalOglGV+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lpjz7DWddxu4aGtf0FVobeV3U+s/ZwumEo1M8qkgME26DX3Z1WPYWWD8/q+pSMZLNsRB82o9C5SvdAoBC3y0H+Io15T2l6Z8oTpH1dFivdZmzQq9kN86uby5fwfCbhTVC9ZMSC0m7EjHN5H3HXXvaosam+yJqArO+3VLXypmimo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uqhKm-000000005mQ-1rYd;
	Tue, 26 Aug 2025 00:14:44 +0000
Date: Tue, 26 Aug 2025 01:14:41 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next 6/6] net: dsa: lantiq_gswip: move MDIO bus
 registration to .setup()
Message-ID: <916803a5a597e9f8b4814cdbc9516c51f078d65a.1756163848.git.daniel@makrotopia.org>
References: <cover.1756163848.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756163848.git.daniel@makrotopia.org>

Instead of registering the switch MDIO bus in the probe() function, move
the call to gswip_mdio() into the .setup() DSA switch op, so it can be
reused independently of the probe() function.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 23b68047f3c4..9ec262ec3a11 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -627,6 +627,13 @@ static int gswip_setup(struct dsa_switch *ds)
 	/* Configure the MDIO Clock 2.5 MHz */
 	gswip_mdio_mask(priv, 0xff, 0x09, GSWIP_MDIO_MDC_CFG1);
 
+	/* bring up the mdio bus */
+	err = gswip_mdio(priv);
+	if (err) {
+		dev_err(priv->dev, "mdio bus setup failed\n");
+		return err;
+	}
+
 	/* Disable the xMII interface and clear it's isolation bit */
 	for (i = 0; i < priv->hw_info->max_ports; i++)
 		gswip_mii_mask_cfg(priv,
@@ -1973,13 +1980,6 @@ static int gswip_probe(struct platform_device *pdev)
 					     "gphy fw probe failed\n");
 	}
 
-	/* bring up the mdio bus */
-	err = gswip_mdio(priv);
-	if (err) {
-		dev_err_probe(dev, err, "mdio probe failed\n");
-		goto gphy_fw_remove;
-	}
-
 	err = dsa_register_switch(priv->ds);
 	if (err) {
 		dev_err_probe(dev, err, "dsa switch registration failed\n");
-- 
2.50.1


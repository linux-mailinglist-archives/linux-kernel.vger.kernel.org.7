Return-Path: <linux-kernel+bounces-892699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E995DC45A54
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 497474EF4C1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C26E30214B;
	Mon, 10 Nov 2025 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Brw7OafZ"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEAB30171E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766715; cv=none; b=CegjezaMkzQW84j0ydkhkk4T5yWwH2B9jk9ExHkRUbV3Y+TSpVapbkFadciM6t2K6gPYOAIgdjsIhsN2uKPSvrGRDkPjiFz3TvIHpspupOQZNUQNvI5OUhQ4diUFvyfYQO1ld8U/GFPSa+m+59+nTiYtDTB2wsFRqjLPGBaHusw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766715; c=relaxed/simple;
	bh=0mYOw504mpyLIBgV4h9ftaM/tLaxCJPSshXoASlqmAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bgsbg49zzkv7mFHLqUD9q/pQMt8rIoEHGjsU8O+Uq/ihSBDPAR15lM5EJrowmyhfV7Ie4C+yRLBMFhYf25KmM8a/QQTR7FAiaYC4YB/MX75uEIWLLdugTbWS90hAe5iDNw5E6n0SvkyGrAw/b45lsF6bvWya005dUzVsK+JmxfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Brw7OafZ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 24B0E1A19A9;
	Mon, 10 Nov 2025 09:25:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E79AF606F5;
	Mon, 10 Nov 2025 09:25:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 48AF6103718CE;
	Mon, 10 Nov 2025 10:25:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762766705; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3ze1dF69IP7aJ3cJEOstZE1O5bfy3wqjR16eOM96GZo=;
	b=Brw7OafZLDrOqKp6bk0yfl9gEGGpf32+l4MIiZql2sJ/jqeHyE+5WNkhwQ319WNAGA0mOE
	rji1nXf++9TSkwpMNM0uUKXvDGhkbjXNiFBznVcC9/z+wXKsBdHOd/2DuOjrFJjpekE3OK
	IuGvxXJYfRgf3lPZl26cbXpqw+XfLJa/cX7MYuBIxke1ZGroEyExadPxMf6sSxURtoiq5t
	XyTNGLSWFaKEO7wvwS+IBTSSWOrOHxM1e3AwHotOV5fMCoinkxws/S0pXn8jgcETpOo4Dt
	HPOiyMdUwQpGffFVGlvd90rqlvWo7j89yfZ+KIp3NUjPNBjH71TOfc1nujZW8g==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 10 Nov 2025 10:24:55 +0100
Subject: [PATCH net-next v2 3/3] net: phy: dp83869: Support 1000Base-X SFP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-sfp-1000basex-v2-3-dd5e8c1f5652@bootlin.com>
References: <20251110-sfp-1000basex-v2-0-dd5e8c1f5652@bootlin.com>
In-Reply-To: <20251110-sfp-1000basex-v2-0-dd5e8c1f5652@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Associate with an SFP cage described in the device tree and provide the
module_insert() callback that will set the appropriate DP83869 operation
mode when an SFP module is inserted.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/phy/dp83869.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index 143b75842fc7..407518e6077f 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/phy.h>
+#include <linux/sfp.h>
 #include <linux/delay.h>
 #include <linux/bitfield.h>
 
@@ -877,6 +878,57 @@ static int dp83869_config_init(struct phy_device *phydev)
 	return ret;
 }
 
+static void dp83869_module_remove(void *upstream)
+{
+	struct phy_device *phydev = upstream;
+
+	phydev_info(phydev, "SFP module removed\n");
+
+	/* Set speed and duplex to unknown to avoid downshifting warning. */
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+}
+
+static int dp83869_module_insert(void *upstream, const struct sfp_eeprom_id *id)
+{
+	struct phy_device *phydev = upstream;
+	const struct sfp_module_caps *caps;
+	struct dp83869_private *dp83869;
+	int ret;
+
+	caps = sfp_get_module_caps(phydev->sfp_bus);
+
+	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+			       caps->link_modes)) {
+		phydev_err(phydev, "incompatible SFP module inserted\n");
+		return -EINVAL;
+	}
+
+	dp83869 = phydev->priv;
+
+	dp83869->mode = DP83869_RGMII_1000_BASE;
+	phydev->port = PORT_FIBRE;
+
+	ret = dp83869_configure_mode(phydev, dp83869);
+	if (ret)
+		return ret;
+
+	/* Reconfigure advertisement */
+	if (mutex_trylock(&phydev->lock)) {
+		ret = dp83869_config_aneg(phydev);
+		mutex_unlock(&phydev->lock);
+	}
+
+	return ret;
+}
+
+static const struct sfp_upstream_ops dp83869_sfp_ops = {
+	.attach = phy_sfp_attach,
+	.detach = phy_sfp_detach,
+	.module_insert = dp83869_module_insert,
+	.module_remove = dp83869_module_remove,
+};
+
 static int dp83869_probe(struct phy_device *phydev)
 {
 	struct dp83869_private *dp83869;
@@ -893,6 +945,12 @@ static int dp83869_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	if (of_property_read_bool(phydev->mdio.dev.of_node, "sfp")) {
+		ret = phy_sfp_probe(phydev, &dp83869_sfp_ops);
+		if (ret)
+			return ret;
+	}
+
 	if (dp83869->mode == DP83869_RGMII_100_BASE ||
 	    dp83869->mode == DP83869_RGMII_1000_BASE)
 		phydev->port = PORT_FIBRE;

-- 
2.51.2



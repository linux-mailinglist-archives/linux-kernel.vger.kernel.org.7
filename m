Return-Path: <linux-kernel+bounces-851093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAD7BD57F5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9DB18A4C92
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B398729C326;
	Mon, 13 Oct 2025 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="v6PXfwYo"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AD23081A3;
	Mon, 13 Oct 2025 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760376622; cv=none; b=kwiRSGwPeGWztKD4lJAZRNgc2t5Ec5kC9Yf+nuoot+cqsnDjBsIWbk19MHxHSf8OtXNuXMevveXfjTTD5uxsGGzc90C6/xo+CoEjyHTFBitSnzOGOU8psRChC9Et8ulYwWT7z1moOcpMRrXtNKDSpuNyymwNq7TqOuGztu9nsOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760376622; c=relaxed/simple;
	bh=4AIX/fhBXi6apAU21YIhJmoAOPOGxuGkR0jEWrkHbcg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F59/x/SPUSMwZ4fcDwCzP4B4VGyD1AM4V+Zrxbq8BFNpypZyy7gCeBIboa5CMseVuQ0xhEWTVsDEH9AC/G6j+HjbWKDYyuV6Ubq/IF7iMUyOku52WfxAN3dzY2CfVookEw7GlSakYyg0uX9f7D8ZonkV+kvHGKm1N21wNX94l7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=v6PXfwYo; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 699FDC0000D0;
	Mon, 13 Oct 2025 10:23:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 699FDC0000D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1760376189;
	bh=4AIX/fhBXi6apAU21YIhJmoAOPOGxuGkR0jEWrkHbcg=;
	h=From:To:Cc:Subject:Date:From;
	b=v6PXfwYoxcVVyVdt1q8wOHZmeXc2IlTkefj+c/SMnSP6SUYQTwFnp1ZePvkNLd/JA
	 EkNi1t8aMo6MYJSfLLeJ17LDhmsT6O0+O5Ky6IOlt7B9e5pEeHqarID7G6OipzrNvI
	 nJawqeuZSxBT+WGVobHxQkPzLnNtXScIUmCv3qQU=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 68C394002F44;
	Mon, 13 Oct 2025 13:23:08 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Justin Chen <justin.chen@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM ASP 2.0 ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: bcmasp: Add support for PHY-based Wake-on-LAN
Date: Mon, 13 Oct 2025 10:23:06 -0700
Message-Id: <20251013172306.2250223-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If available, interrogate the PHY to find out whether we can use it for
Wake-on-LAN. This can be a more power efficient way of implementing that
feature, especially when the MAC is powered off in low power states.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 .../ethernet/broadcom/asp2/bcmasp_ethtool.c   | 34 +++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
index 63f1a8c3a7fb..dd80ccfca19d 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
@@ -163,11 +163,30 @@ static void bcmasp_set_msglevel(struct net_device *dev, u32 level)
 static void bcmasp_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct bcmasp_intf *intf = netdev_priv(dev);
+	struct bcmasp_priv *priv = intf->parent;
+	struct device *kdev = &priv->pdev->dev;
+	u32 phy_wolopts = 0;
+
+	if (dev->phydev) {
+		phy_ethtool_get_wol(dev->phydev, wol);
+		phy_wolopts = wol->wolopts;
+	}
+
+	/* MAC is not wake-up capable, return what the PHY does */
+	if (!device_can_wakeup(kdev))
+		return;
+
+	/* Overlay MAC capabilities with that of the PHY queried before */
+	wol->supported |= BCMASP_SUPPORTED_WAKE;
+	wol->wolopts |= intf->wolopts;
+
+	/* Return the PHY configured magic password */
+	if (phy_wolopts & WAKE_MAGICSECURE)
+		return;
 
-	wol->supported = BCMASP_SUPPORTED_WAKE;
-	wol->wolopts = intf->wolopts;
 	memset(wol->sopass, 0, sizeof(wol->sopass));
 
+	/* Otherwise the MAC one */
 	if (wol->wolopts & WAKE_MAGICSECURE)
 		memcpy(wol->sopass, intf->sopass, sizeof(intf->sopass));
 }
@@ -177,10 +196,21 @@ static int bcmasp_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 	struct bcmasp_intf *intf = netdev_priv(dev);
 	struct bcmasp_priv *priv = intf->parent;
 	struct device *kdev = &priv->pdev->dev;
+	int ret = 0;
+
+	/* Try Wake-on-LAN from the PHY first */
+	if (dev->phydev) {
+		ret = phy_ethtool_set_wol(dev->phydev, wol);
+		if (ret != -EOPNOTSUPP && wol->wolopts)
+			return ret;
+	}
 
 	if (!device_can_wakeup(kdev))
 		return -EOPNOTSUPP;
 
+	if (wol->wolopts & ~BCMASP_SUPPORTED_WAKE)
+		return -EINVAL;
+
 	/* Interface Specific */
 	intf->wolopts = wol->wolopts;
 	if (intf->wolopts & WAKE_MAGICSECURE)
-- 
2.34.1



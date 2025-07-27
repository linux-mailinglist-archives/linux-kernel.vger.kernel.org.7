Return-Path: <linux-kernel+bounces-747217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAD5B13110
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39B21724E4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B77C229B18;
	Sun, 27 Jul 2025 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="ZMZQPXLV"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B219225A32
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753639412; cv=none; b=U0hkaROuTSp+3mAr+Tm+Exi9jtpRxM5e8l9Qx85u2rIf6wCa7OP7ubkCUHjUgEC3N/bpbvUhm/2s/zqzmPp9mN72ytmwjUVFZeat+plZuVpNFClaZvNUbi/Pz4vJzN9xHfuqllPihQJkgcTNIH5doB6sfYmS7XL4rJ+TLO8x0sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753639412; c=relaxed/simple;
	bh=38m2SPryUnJAv/Hzt+CHmkXIGXr7hdL8wmqIXo2Ec7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGijAywEXLr6aRPxMkOTPl0TpKiqv4gENELSdMcvigg8F8iDumhXk+dCqklg1cphG9Ihv5RMWW36mxKaJ7Gocv6slzF9hTcFWJ5w2TKTvK2agQFVZpAnJxxvDTALhemr0C49l0g+oIzORz7dwTyrj7dxWprIVSRcwfzr671qEtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=ZMZQPXLV; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753639409; bh=YWL3aOX28KQzuVWsTQMiXAVfLLtLJhYtG+UmgpEGycA=;
 b=ZMZQPXLVeXsQKfPrhaHe/s8vpf570YH4lB1d7lUwPfpz/iVBuqq3LIKPCcu7QUujsLg1UqJpO
 NAjtjZh96umYpf06oV2WzKgKIJrKB+BsD1FKgj1HVzsYoqDrEJxVR6Bz68VcznYBcPXIDWuDkBV
 jEXqtL/iRUUWCPTiWLTXUiGWSaNNydp3wAiWAsA1Nzy5BUGhnG4sCsLOoMoo6+AzCUuzX9gjssu
 ZED9Gs7pQR6cTxCcImEfQ4kzzIjnlYb1dISH/k/7lHpwl9QVNBwfETskiH/Bl7kHBSMTCH2i+Yg
 pQg0mqot4WhKCeL8ebKtwdrc2MeQictds7S1MGeKnR8w==
X-Forward-Email-ID: 688669e9c509b9ee169cf326
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Heiko Stuebner <heiko@sntech.de>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH net-next 2/3] net: dsa: realtek: Add support for use of an optional mdio node
Date: Sun, 27 Jul 2025 18:02:59 +0000
Message-ID: <20250727180305.381483-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250727180305.381483-1-jonas@kwiboo.se>
References: <20250727180305.381483-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dt-bindings schema for Realtek switches for unmanaged switches
contains a restriction on use of a mdio child OF node for MDIO-connected
switches, i.e.:

  if:
    required:
      - reg
  then:
    not:
      required:
        - mdio
    properties:
      mdio: false

However, the driver currently requires the existence of a mdio child OF
node to successfully probe and properly function.

Relax the requirement of a mdio child OF node and assign the dsa_switch
user_mii_bus to allow a MDIO-connected switch to probe and function
when a mdio child OF node is missing.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/dsa/realtek/rtl83xx.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 9a05616acea8..47a09b27c4fa 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/of_mdio.h>
@@ -64,7 +65,7 @@ static int rtl83xx_user_mdio_write(struct mii_bus *bus, int addr, int regnum,
  * @ds: DSA switch associated with this user_mii_bus
  *
  * Registers the MDIO bus for built-in Ethernet PHYs, and associates it with
- * the mandatory 'mdio' child OF node of the switch.
+ * the optional 'mdio' child OF node of the switch.
  *
  * Context: Can sleep.
  * Return: 0 on success, negative value for failure.
@@ -75,11 +76,14 @@ int rtl83xx_setup_user_mdio(struct dsa_switch *ds)
 	struct device_node *mdio_np;
 	struct mii_bus *bus;
 	int ret = 0;
+	int irq;
+	int i;
 
 	mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
-	if (!mdio_np) {
-		dev_err(priv->dev, "no MDIO bus node\n");
-		return -ENODEV;
+	if (mdio_np && !of_device_is_available(mdio_np)) {
+		dev_err(priv->dev, "no available MDIO bus node\n");
+		ret = -ENODEV;
+		goto err_put_node;
 	}
 
 	bus = devm_mdiobus_alloc(priv->dev);
@@ -95,6 +99,20 @@ int rtl83xx_setup_user_mdio(struct dsa_switch *ds)
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s:user_mii", dev_name(priv->dev));
 	bus->parent = priv->dev;
 
+	if (!mdio_np) {
+		ds->user_mii_bus = bus;
+		bus->phy_mask = ~ds->phys_mii_mask;
+
+		if (priv->irqdomain) {
+			for (i = 0; i < priv->num_ports; i++) {
+				irq = irq_find_mapping(priv->irqdomain, i);
+				if (irq < 0)
+					continue;
+				bus->irq[i] = irq;
+			}
+		}
+	}
+
 	ret = devm_of_mdiobus_register(priv->dev, bus, mdio_np);
 	if (ret) {
 		dev_err(priv->dev, "unable to register MDIO bus %s\n",
-- 
2.50.1



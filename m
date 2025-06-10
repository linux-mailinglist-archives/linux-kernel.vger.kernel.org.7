Return-Path: <linux-kernel+bounces-679705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D83EAD3AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 16:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9420017A895
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 14:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3E72BD036;
	Tue, 10 Jun 2025 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="JY2RX8zi"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38AC244677;
	Tue, 10 Jun 2025 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564493; cv=pass; b=XkEJr2OOAgKDI46hiz5S7itdK1VJlRe3OR8++eYFT6c3KDeCL5yEUoFfmFt0b0gfql0SZDe7O+MwM1Z+2iMmMTEIkzGHGL9GQ+62EdfiIabHzSJ479G4ZJOiZ7VDnNOuBEZpGBDRXB48kokXOLE1l0YpmUfUDcwG9KFCc0NhSrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564493; c=relaxed/simple;
	bh=pIo2s4qlTjVxM8klbgilgVrQm0tEEavw9/+l3CSFaiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bJgHpzp7Dp5x2DLOblH52aPrQ5U0tyab2IWg0/beMAEoSaRVU4s2xKMYQAulwz8LwxMZDMVMOaMUrYYN5i+/+Ch40Lnm3zncpp8UBZJ1UYG9LCh0HLRYLQcvmLHw0GXo4xqJxyJYT57BMjebM+Ku6xft+dPTAPCyoEni5HC/2+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=JY2RX8zi; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749564459; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oCrMh5MLOVv1OO4SCjZ7DXW7dz+AIeOPdJUfRdH0EDs1btM7rTCkdpkKuH6WTfjlybfP0nFGNRAg2HS1jlrI1IOzfrv4UsjEYWVr4L6UhhbFY4b0BCx5VP+DZl6xljLUljIbiNFuD8BjwdiH8ctt47QmhzujDqid7ER+g+bmMrE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749564459; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Fn+l9xBCy5WR8GoNtLczRCzjBhn3HX+EkjyiiCOwVno=; 
	b=BVp0kGq+5dLEVZeIPsMb+ScQkr5Sm6Oxnsi+t55krxsIjvVh+eY9nYolw5wAHT123OdsZI8ExWfxJZzAwRcrx4Fx7KbyHdudF+rND7JGPxs85sMWkw/cOV9BR6D+ACt4l6979NenQuO29m/a81YJ4v4Dbq8BWacIKUiURnkFi6M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749564459;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Fn+l9xBCy5WR8GoNtLczRCzjBhn3HX+EkjyiiCOwVno=;
	b=JY2RX8zixUovH9a5MuXtsBTSSPD3UsUaiAHXKBN22EUjRiOx1B4OktLsUNBXUi8Q
	Xo9ySQRASfEk9xQZktoqX1qM4Qaby90qsG8zd2d1Yq8g0CCGlyxHjRnlgYNp3YuNfm+
	fRHP7NqTauFDJ7Dj3EVvXqSigeq1TxyvtcU6WlcI=
Received: by mx.zohomail.com with SMTPS id 174956445793867.38873063460528;
	Tue, 10 Jun 2025 07:07:37 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 10 Jun 2025 16:07:09 +0200
Subject: [PATCH v4 1/4] phy: rockchip: inno-usb2: add soft vbusvalid
 control
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-rk3576-sige5-usb-v4-1-7e7f779619c1@collabora.com>
References: <20250610-rk3576-sige5-usb-v4-0-7e7f779619c1@collabora.com>
In-Reply-To: <20250610-rk3576-sige5-usb-v4-0-7e7f779619c1@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Frank Wang <frank.wang@rock-chips.com>
Cc: Alexey Charkov <alchark@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

With USB type C connectors, the vbus detect pin of the OTG controller
attached to it is pulled high by a USB Type C controller chip such as
the fusb302. This means USB enumeration on Type-C ports never works, as
the vbus is always seen as high.

Rockchip added some GRF register flags to deal with this situation. The
RK3576 TRM calls these "soft_vbusvalid_bvalid" (con0 bit index 15) and
"soft_vbusvalid_bvalid_sel" (con0 bit index 14).

Downstream introduces a new vendor property which tells the USB 2 PHY
that it's connected to a type C port, but we can do better. Since in
such an arrangement, we'll have an OF graph connection from the USB
controller to the USB connector anyway, we can walk said OF graph and
check the connector's compatible to determine this without adding any
further vendor properties.

Do keep in mind that the usbdp PHY driver seemingly fiddles with these
register fields as well, but what it does doesn't appear to be enough
for us to get working USB enumeration, presumably because the whole
vbus_attach logic needs to be adjusted as well either way.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 113 +++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index b0f23690ec3002202c0f33a6988f5509622fa10e..4f89bd6568cd3a7a1d2c10e9cddda9f3bd997ed0 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/of_irq.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -114,6 +115,8 @@ struct rockchip_chg_det_reg {
 /**
  * struct rockchip_usb2phy_port_cfg - usb-phy port configuration.
  * @phy_sus: phy suspend register.
+ * @svbus_en: soft vbus bvalid enable register.
+ * @svbus_sel: soft vbus bvalid selection register.
  * @bvalid_det_en: vbus valid rise detection enable register.
  * @bvalid_det_st: vbus valid rise detection status register.
  * @bvalid_det_clr: vbus valid rise detection clear register.
@@ -140,6 +143,8 @@ struct rockchip_chg_det_reg {
  */
 struct rockchip_usb2phy_port_cfg {
 	struct usb2phy_reg	phy_sus;
+	struct usb2phy_reg	svbus_en;
+	struct usb2phy_reg	svbus_sel;
 	struct usb2phy_reg	bvalid_det_en;
 	struct usb2phy_reg	bvalid_det_st;
 	struct usb2phy_reg	bvalid_det_clr;
@@ -203,6 +208,7 @@ struct rockchip_usb2phy_cfg {
  * @event_nb: hold event notification callback.
  * @state: define OTG enumeration states before device reset.
  * @mode: the dr_mode of the controller.
+ * @typec_vbus_det: whether to apply Type C logic to OTG vbus detection.
  */
 struct rockchip_usb2phy_port {
 	struct phy	*phy;
@@ -222,6 +228,7 @@ struct rockchip_usb2phy_port {
 	struct notifier_block	event_nb;
 	enum usb_otg_state	state;
 	enum usb_dr_mode	mode;
+	bool typec_vbus_det;
 };
 
 /**
@@ -495,6 +502,13 @@ static int rockchip_usb2phy_init(struct phy *phy)
 	mutex_lock(&rport->mutex);
 
 	if (rport->port_id == USB2PHY_PORT_OTG) {
+		if (rport->typec_vbus_det) {
+			if (rport->port_cfg->svbus_en.enable &&
+					rport->port_cfg->svbus_sel.enable) {
+				property_enable(rphy->grf, &rport->port_cfg->svbus_en, true);
+				property_enable(rphy->grf, &rport->port_cfg->svbus_sel, true);
+			}
+		}
 		if (rport->mode != USB_DR_MODE_HOST &&
 		    rport->mode != USB_DR_MODE_UNKNOWN) {
 			/* clear bvalid status and enable bvalid detect irq */
@@ -535,8 +549,7 @@ static int rockchip_usb2phy_init(struct phy *phy)
 			if (ret)
 				goto out;
 
-			schedule_delayed_work(&rport->otg_sm_work,
-					      OTG_SCHEDULE_DELAY * 3);
+			schedule_delayed_work(&rport->otg_sm_work, 0);
 		} else {
 			/* If OTG works in host only mode, do nothing. */
 			dev_dbg(&rport->phy->dev, "mode %d\n", rport->mode);
@@ -666,8 +679,17 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
 	unsigned long delay;
 	bool vbus_attach, sch_work, notify_charger;
 
-	vbus_attach = property_enabled(rphy->grf,
-				       &rport->port_cfg->utmi_bvalid);
+	if (rport->port_cfg->svbus_en.enable && rport->typec_vbus_det) {
+		if (property_enabled(rphy->grf, &rport->port_cfg->svbus_en) &&
+		    property_enabled(rphy->grf, &rport->port_cfg->svbus_sel)) {
+			vbus_attach = true;
+		} else {
+			vbus_attach = false;
+		}
+	} else {
+		vbus_attach = property_enabled(rphy->grf,
+					       &rport->port_cfg->utmi_bvalid);
+	}
 
 	sch_work = false;
 	notify_charger = false;
@@ -1276,6 +1298,83 @@ static int rockchip_otg_event(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static const char *const rockchip_usb2phy_typec_cons[] = {
+	"usb-c-connector",
+	NULL,
+};
+
+static struct device_node *rockchip_usb2phy_to_controller(struct rockchip_usb2phy *rphy)
+{
+	struct device_node *np;
+	struct device_node *parent;
+
+	for_each_node_with_property(np, "phys") {
+		struct of_phandle_iterator it;
+		int ret;
+
+		of_for_each_phandle(&it, ret, np, "phys", NULL, 0) {
+			parent = of_get_parent(it.node);
+			if (it.node != rphy->dev->of_node && rphy->dev->of_node != parent) {
+				if (parent)
+					of_node_put(parent);
+				continue;
+			}
+
+			/*
+			 * Either the PHY phandle we're iterating or its parent
+			 * matched, we don't care about which out of the two in
+			 * particular as we just need to know it's the right
+			 * USB controller for this PHY.
+			 */
+			of_node_put(it.node);
+			of_node_put(parent);
+			return np;
+		}
+	}
+
+	return NULL;
+}
+
+static bool rockchip_usb2phy_otg_is_type_c(struct rockchip_usb2phy *rphy)
+{
+	struct device_node *controller = rockchip_usb2phy_to_controller(rphy);
+	struct device_node *ports;
+	struct device_node *ep = NULL;
+	struct device_node *parent;
+
+	if (!controller)
+		return false;
+
+	ports = of_get_child_by_name(controller, "ports");
+	if (ports) {
+		of_node_put(controller);
+		controller = ports;
+	}
+
+	for_each_of_graph_port(controller, port) {
+		ep = of_get_child_by_name(port, "endpoint");
+		if (!ep)
+			continue;
+
+		parent = of_graph_get_remote_port_parent(ep);
+		of_node_put(ep);
+		if (!parent)
+			continue;
+
+		if (of_device_compatible_match(parent, rockchip_usb2phy_typec_cons)) {
+			of_node_put(parent);
+			of_node_put(controller);
+			return true;
+		}
+
+		of_node_put(parent);
+	}
+
+	of_node_put(controller);
+
+	return false;
+}
+
 static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 					  struct rockchip_usb2phy_port *rport,
 					  struct device_node *child_np)
@@ -1297,6 +1396,8 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 
 	mutex_init(&rport->mutex);
 
+	rport->typec_vbus_det = rockchip_usb2phy_otg_is_type_c(rphy);
+
 	rport->mode = of_usb_get_dr_mode_by_phy(child_np, -1);
 	if (rport->mode == USB_DR_MODE_HOST ||
 	    rport->mode == USB_DR_MODE_UNKNOWN) {
@@ -2050,6 +2151,8 @@ static const struct rockchip_usb2phy_cfg rk3576_phy_cfgs[] = {
 		.port_cfgs	= {
 			[USB2PHY_PORT_OTG] = {
 				.phy_sus	= { 0x0000, 8, 0, 0, 0x1d1 },
+				.svbus_en	= { 0x0000, 15, 15, 0, 1 },
+				.svbus_sel	= { 0x0000, 14, 14, 0, 1 },
 				.bvalid_det_en	= { 0x00c0, 1, 1, 0, 1 },
 				.bvalid_det_st	= { 0x00c4, 1, 1, 0, 1 },
 				.bvalid_det_clr = { 0x00c8, 1, 1, 0, 1 },
@@ -2087,6 +2190,8 @@ static const struct rockchip_usb2phy_cfg rk3576_phy_cfgs[] = {
 		.port_cfgs	= {
 			[USB2PHY_PORT_OTG] = {
 				.phy_sus	= { 0x2000, 8, 0, 0, 0x1d1 },
+				.svbus_en	= { 0x2000, 15, 15, 0, 1 },
+				.svbus_sel	= { 0x2000, 14, 14, 0, 1 },
 				.bvalid_det_en	= { 0x20c0, 1, 1, 0, 1 },
 				.bvalid_det_st	= { 0x20c4, 1, 1, 0, 1 },
 				.bvalid_det_clr = { 0x20c8, 1, 1, 0, 1 },

-- 
2.49.0



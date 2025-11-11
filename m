Return-Path: <linux-kernel+bounces-895214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0665CC4D359
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F71E34FAEF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882F4357A3B;
	Tue, 11 Nov 2025 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="tQOz4Cin"
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045273570C8;
	Tue, 11 Nov 2025 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858288; cv=none; b=U8Q/yg8JuFBSkGfrvPJoLVKqrAXdDWTKgsGW6mmzL6nskFfdp/2nAoUzPIGpUS3bSmj5hHCgbbwnsJxmuRfasNB+7myC94fLDsHqf/CVbrFiVR9RVbJy5hAKpI0OLcHBh34Y1iJFj0T5rvvsB+zagEqRBBEgFdbkOWuEiA4kwvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858288; c=relaxed/simple;
	bh=ktQe0TBZJXNabRClR1zK2GRlgnwznm7iN6OWZIxNePg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PxU1u9mWrfuWA3xXJioxuXIyehEZKKw/zXGs5/fQPeFuHiJZESRZKUGrlFqkLA/ZOzAwaY76XX2FUYYjDooDiiKzpZc5OSOIlG4lsUPzCRKadAVu6Gtd+E27McOFu3iGgMA5dSjtsGgnxsE4zyPhOXleBFPVWlOUBcuc5b2F3CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=tQOz4Cin; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1762858282;
	bh=sEWMlrnina66f1mkg7MgIF551DMwzRk8lseSsYVXv/E=;
	h=From:To:Subject:Date:Message-Id;
	b=tQOz4Cin+mLCfj9sjw+zFe4WQkA8ZW1g+oLTvoV4MCzkHSqDboN4Maj2hhoi1oVx7
	 Owi8EgX+0oYQ2EESAz4CJ2v4Lr+s2oSWK1WE5m/7oEVKTI8tRNrQdZf7jHDwjrhkuF
	 ZNnnhRxdqsHggOsyCuxdhgQnZ1rwcEk3JFTTzyqc=
X-QQ-mid: zesmtpsz9t1762858278t101ea436
X-QQ-Originating-IP: KIZLeegrDP7BdwpoI03I1Jn77fOqzylhUhpOTTA1aKg=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Nov 2025 18:51:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9277144909567469895
From: Chaoyi Chen <kernel@airkyi.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Peter Chen <hzpeterchen@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Yubing Zhang <yubing.zhang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Peter Robinson <pbrobinson@gmail.com>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v9 07/10] drm/rockchip: cdn-dp: Support handle lane info without extcon
Date: Tue, 11 Nov 2025 18:50:37 +0800
Message-Id: <20251111105040.94-8-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251111105040.94-1-kernel@airkyi.com>
References: <20251111105040.94-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MoXwTY6T4qpUZUqmSovu0Ac1+5W83o5i8kU7W4URJdfU8R8z0FMC8u1F
	c6GjFVuuMZefjCC8iURyP1sN9JiIMH/UvQykgmrB9YPsBage4AfRbtQuRkNVVsX5q9rUyl6
	Gk1bVLWSkofYwoTjOCNR2gVxrj0Uc+udyzCOhL3W5d1oidZ2296maUKkcpYaiU15H6nkj7A
	7+TNyQEeSXXKavhFClLRc5LEsSl2MYD2YExUIF2KI6ocDu274DBkW04S/hXOg3IXi0fBDQi
	dnK8rhhzQd6fypd+qQqo6Gv5qGhJgsRtYcxedbxBjR1bpCDKxTQ+FIiUeo3l+f5a6e3l1Bd
	d12bByvSeS0dSoypgJn11iKrsnLnDmZPSnHwEJFk3DutQtJDwizzBqqfKQAgvaH2SKTQ1dy
	jSWA64ktrbaYhgQ3JYufaZM3a/xmPY/jMrJL0hVqfYKePjf6KpIxdq75jvbhjs8h/0zht3c
	uV4b3QZuRYVVgeyM2pv49EpmjS0mN5Gz750Vn5CI0DpA/U3dOA7OpoLF+PBxTHgTX6g2zR/
	H6Dd1adazHL7he41DH16mVm2d23lzynmO2jtOEr/0oHqWhofK/k+/5k2cryj454otzytHW3
	HTasWmRbRYXdO4Pbs04zYIs7o1K/dlu9Da7TuGUV17VZC2CiIDGwOK2OnH8mk9STmlNCrlu
	NjKEZ30ek+JDFoIoNZagJYszvTMhUhSCkcibUHd8lm3aO7vELYFPG6F8T2bhLcDKuGpqUU1
	ocPIqNoHOElul6tSOY/5S5Jhdg8qR8lr8bHGC9KOx13BoYEosGlXz2kisrBz7YR6GzcoN93
	Yi/sR0R100eKJ93wBkaG/6DyuvEOFjcsP6T3eumvURJt2lNb/r8uAeUFTvj6oq3nnow5cnr
	lRtwHXYrE6ttfrByxkVVCuXoQP8QSqLuEVsLzxNQURbhGLFpVkAxQ/e/HCtwxOoC/A3JCET
	SaQuCixTgWti3rxXd3Dg9cXpCpS0sXkAO4ItweB5qvFk/ovB3JA1bGi6lzn/7P0T4XWz9MR
	QdLaeFGxo7hxr13tmefip5sVOvwCA=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

This patch add support for get PHY lane info without help of extcon.

There is no extcon needed if the Type-C controller is present. In this
case, the lane info can be get from PHY instead of extcon.

The extcon device should still be supported if Type-C controller is
not present.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---

(no changes since v5)

Changes in v4:
- Remove cdn_dp_hpd_notify().

(no changes since v3)

Changes in v2:
- Ignore duplicate HPD events.

 drivers/gpu/drm/rockchip/cdn-dp-core.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index b7e3f5dcf8d5..1e27301584a4 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -156,6 +156,9 @@ static int cdn_dp_get_port_lanes(struct cdn_dp_port *port)
 	int dptx;
 	u8 lanes;
 
+	if (!edev)
+		return phy_get_bus_width(port->phy);
+
 	dptx = extcon_get_state(edev, EXTCON_DISP_DP);
 	if (dptx > 0) {
 		extcon_get_property(edev, EXTCON_DISP_DP,
@@ -219,7 +222,7 @@ static bool cdn_dp_check_sink_connection(struct cdn_dp_device *dp)
 	 * some docks need more time to power up.
 	 */
 	while (time_before(jiffies, timeout)) {
-		if (!extcon_get_state(port->extcon, EXTCON_DISP_DP))
+		if (port->extcon && !extcon_get_state(port->extcon, EXTCON_DISP_DP))
 			return false;
 
 		if (!cdn_dp_get_sink_count(dp, &sink_count))
@@ -385,11 +388,14 @@ static int cdn_dp_enable_phy(struct cdn_dp_device *dp, struct cdn_dp_port *port)
 		goto err_power_on;
 	}
 
-	ret = extcon_get_property(port->extcon, EXTCON_DISP_DP,
-				  EXTCON_PROP_USB_TYPEC_POLARITY, &property);
-	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "get property failed\n");
-		goto err_power_on;
+	property.intval = 0;
+	if (port->extcon) {
+		ret = extcon_get_property(port->extcon, EXTCON_DISP_DP,
+					  EXTCON_PROP_USB_TYPEC_POLARITY, &property);
+		if (ret) {
+			DRM_DEV_ERROR(dp->dev, "get property failed\n");
+			goto err_power_on;
+		}
 	}
 
 	port->lanes = cdn_dp_get_port_lanes(port);
@@ -1028,6 +1034,9 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 	for (i = 0; i < dp->ports; i++) {
 		port = dp->port[i];
 
+		if (!port->extcon)
+			continue;
+
 		port->event_nb.notifier_call = cdn_dp_pd_event;
 		ret = devm_extcon_register_notifier(dp->dev, port->extcon,
 						    EXTCON_DISP_DP,
@@ -1120,14 +1129,14 @@ static int cdn_dp_probe(struct platform_device *pdev)
 		    PTR_ERR(phy) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 
-		if (IS_ERR(extcon) || IS_ERR(phy))
+		if (IS_ERR(phy) || PTR_ERR(extcon) != -ENODEV)
 			continue;
 
 		port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
 		if (!port)
 			return -ENOMEM;
 
-		port->extcon = extcon;
+		port->extcon = IS_ERR(extcon) ? NULL : extcon;
 		port->phy = phy;
 		port->dp = dp;
 		port->id = i;
-- 
2.51.1



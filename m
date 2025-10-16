Return-Path: <linux-kernel+bounces-855444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A5ABE13FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 04:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E7119C6210
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42999221721;
	Thu, 16 Oct 2025 02:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="Bw472g63"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEC721CC56;
	Thu, 16 Oct 2025 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760581726; cv=none; b=RyV6G2CCCcHL173DXcDCXXKt8qxzzDbBOP0RwNZz/PzTlLkpOoVuRg7n03XsVOY7CJyD0mSvLOcWdElMaoOA5iKcQomi+kpyOUBh+kKt8nYSwJTAuaaYyBx14kg3nzScSj8TeB3wwzux3FNiC+osqvBemI6Igr6s2SdoI4RybsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760581726; c=relaxed/simple;
	bh=M4nUEX7h4FeSk6XVEQszUpUpBE3mjUtZPXnyDXgdiFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MNj5cN6d2pkQUipxUo96cCnI0cWyq67IpcN8x8hQPX1rHnTiYrjNOBViXajZqy4MMV1fKyBu6wpPcwgCGNQNCRdLirS0Iwz+oGm0z4m2G11X3gHJLIspl8GvD7tY4JvVMAg/rRuMA+rGm1e49eTMjCKBNxHg9HuXjCRUZET81/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=Bw472g63; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1760581698;
	bh=nQG0w7dhU7Aew5bKV30plkPn0nBnVdgTnfwSbxYLntU=;
	h=From:To:Subject:Date:Message-Id;
	b=Bw472g63hnshVM/rG0XxziDyhCywS2vTxA0imz+PNliiwRr94KJxcr8vMButxCHLP
	 ukEQSurTxAJzm3SWO9eVDWmeSQOEqjofz4CRrKRYPtpGC4y0pv5d7yrNrM573r3R9b
	 d1vqueU7q4JUOynJTlWH4Hvv5c+Z7G+/8+ZPQw/0=
X-QQ-mid: zesmtpgz1t1760581697tf65e1f89
X-QQ-Originating-IP: 6NbQJeS/+dGFQkjM52rtrshJx1shko+6S27zLhjeTRw=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Oct 2025 10:28:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6632506262232562505
From: Chaoyi Chen <kernel@airkyi.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Yubing Zhang <yubing.zhang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Peter Robinson <pbrobinson@gmail.com>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v6 5/8] drm/rockchip: cdn-dp: Support handle lane info without extcon
Date: Thu, 16 Oct 2025 10:27:38 +0800
Message-Id: <20251016022741.91-6-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251016022741.91-1-kernel@airkyi.com>
References: <20251016022741.91-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Mo29KZ8DTxVyj0Tul/DDy2zwezEXvJzU01bxOq6uj59q38k9jpNfZxPs
	4jyhuIWNwIFHZrP89abCSjTjUUBSmBu+qjUO+q6UXkTyBDQpEmpKe/pfQr7HZ6BHiUwokC4
	0e4VDzy2Ux9taohThMbZhsxOKqpwaz3/mtDJnD0ZKr2lLWwcQAdFmC9mhHKH7xdeSooG6+f
	0Ch2rLRfIt0mT//VNM8rINAH57SDoP7rtBbrm6s9tWRy1GNifYgWYOF7NoMzgj04l7ozvfT
	0sspI/0oyOoDe2/HAo6bPmqxMcMfFYMccT3/GDp9SpElM0C2j5WN7HMBAMfE+3nB34vHp7o
	6+dtQ32inRugwoCFnV70Bk/Txx7SB4Tlg5tr3axETMx1RXyqrbGg5MmxhV0lFLsQrBmZxfH
	An9DUTyLhy5NcIgwbUrmCO0s4YQLVmJG0ue0ZKbZ9TQUsT3tvcZA4vSurQC0S5czNviZU5+
	YDjn3GKEl5/jn9SP2yDiHi4Gl+NcpN3+S/EszUpstBbIiGjr9Gv2I/VZA093IefWFUJeViR
	ClJUjJIgsNnxq94IwAv0/iHkbhQvt6+LK84NMBlS5Xysd1UpB9US04koLIMnukU11ZgL+o3
	kBt35xyLf7DumDMHn8xvnb/RXJ1A4tIQbe8/sAdy3oBnot1rt/vG4iSb5JHg2Q5PoMWhEEl
	MZj+6LV+N4aT8Ovg8WTpMAQcIYPSCsoOkutv6/O+RwzWcVr3BjM4byph5q5NWrHa4wEFTJ8
	3mFFJj+pwqv4b9mUHPRHhDOZ4gm8sq4S94bsVbjiFgDe8Dh29ZF6BPGUV3Ul5niwKEEHkuA
	3KzMXUszP8jCuc7RxmafB9w7xrPkYB3UaMl15RCr7caJiiDM4Ok4UYPZH9XXFg4OfkHPa2z
	37ytoXNPZCwv8sZNJftEzQcyOc7YYWKIFzg/CsH16uyMIEzE1CCcM70EdguJcNl0S8ECHHw
	0zg65iZmDLLzIaTy7vdI2YQLZt6KkVCdgO+0MSdDvQRkvxHxLAbaHmbVxCZ3iBrozEqjHUb
	JmC3tJfIZUljAuRUdb/gCEpAooQYsIma/ikQfXsw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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
2.49.0



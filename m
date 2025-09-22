Return-Path: <linux-kernel+bounces-826499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 467D7B8EAD1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150F0189B75F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAAF1B4248;
	Mon, 22 Sep 2025 01:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="hp5OAXZn"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B7A17332C;
	Mon, 22 Sep 2025 01:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758504096; cv=none; b=d7o2cLb4cs+K/kn9l3YhoBZM28iCH/f3v2DNRsT2hva7Jz67EwinCQ21ARC4MQCYdGDeA1ZP9NJwFi60H5GTycTFL+QK8ZA1wEBWEdzfNExY+0ZYCZfblRuR9DJr2xVr8bUDQ0z0u2HwS+IUn4wPE2MwPfO9QSNralGWdCB34so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758504096; c=relaxed/simple;
	bh=u8Zr+mWZOjLQIv8KovRN/165RoC4n1Ipx2xQvrNpJpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RQhzld6FdtUh6eEaBRZHaqYbgA/pl8Pfakk8dQyJopFef5atOrGkTwni4HagefklspkfHTFdYUc018eaPqWjD4K44jE9tpbGmdKlRKqSp49OMvXIojClcBeMDvc4ySC+C2EuRSyxfsTFAWZlrio+EQ0r+WB8IYqRtsHBra1+A/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=hp5OAXZn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1758504065;
	bh=bU2sAmzXCR713CrWSoUTQXsce2x0+sMC5yQVrxIUCRM=;
	h=From:To:Subject:Date:Message-Id;
	b=hp5OAXZnfvcYiEOnalIQqkanqol5thjeWSEc3caa+ilFkfSMFi0r4Wp8j8gh5mfAj
	 +N9MeNwucQMVlA8zwkoVM+RzUQiXFd7zcVD0V1xyQjq+7cml19YrZuycIPHrvTCCC3
	 5UBnR9m6YilgTP3jNOFU5kmh5WSmYkDt73284U7M=
X-QQ-mid: zesmtpgz1t1758504063t10fb6b9b
X-QQ-Originating-IP: DDHFghLsHmSB71st719yB2ojgwG4K8hbUJVFjP+vjd8=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Sep 2025 09:21:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17509678942044025662
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
Subject: [PATCH v4 4/7] drm/rockchip: cdn-dp: Support handle lane info without extcon
Date: Mon, 22 Sep 2025 09:20:36 +0800
Message-Id: <20250922012039.323-5-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250922012039.323-1-kernel@airkyi.com>
References: <20250922012039.323-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OB07sFyS3L6p+Qvod07WZ2wWVQ3R2+r1sYbsl6Xuc1dBkdjKARRQs5S0
	msulJV0mEe4uDQL0gRbm/EKE9W14yHcdfCA35KiEzPcbv4kFjLpXIO5kRRvrLtX3+QaB6Do
	TH7IwhbE01khFAH9IUGFDMpKGPBDfgACbDQHGfCIEHxHKDGdZKc+8zeD0AVhA/GmAxqwDd0
	Poq9+cwa+ZRm/vuOh7CV+JkKFVoy1ilas+5ZaXJ9YSlSfe8YPUT+btUXTrxPBeNQGB/7bti
	ifxgStCaxnsZTmgxwYnlzdBefr4umCQuA60tUgxYG+rJiyoW5hiJRpC8pNSSIqXtf5kvP5z
	HPB/eqfQa+yH1FgejL52ypUTf0jGLuWoa4M9sOmDhCiYjSjxTZo84dODDbBVefIGgo8eOTr
	/cap6RCNyokuoKSs8tC9YBUPHS+k05FzvJ9ag+n4eyx082OKboEmSFjEvO56V67AuPN4tRt
	wkgco8VyH/8N3XEyXnh7pVwpY+vNBkM1u/I/TYGj5RVATxtZZRLwNWk25anFlgjG8CFcxP3
	zMIF8MYY93pNR5GQ2/iB+SDclBO/1DciPzLS32efSLIb8IRguT0H0R0b9DXyounZ2+qCOx4
	z1Ck/+bJzEktryq74U8wrtIMgqPq1rWzduDyXcWBafHEPT1Mwhd6rbGgKhrtNifS9M7dXBm
	F2BVvCeraVi/oH4MWWptTqhLSo4UnYeq0h5LpYqN/lPqifW4/BpkWAWZPblfURwQL0z2SFZ
	ueMRuluV7L4m2x62xLudSf8p58qMx+Sve4774lf2+s9pXhPZa/gfKA/9FXmRX4+QJHPK+7+
	xlk1U9/gd1ZpO5BkrveycDc/PL61qmQ1f3/PCq3TekzWtUJU7hjgYuY0zXrZh3xXO8gAZc4
	SxvV7tyJdEb3GdBI59w2q74L8wFBCDq/wRHSt3pcEIzsVWs28Ir5mfivebln5J4OPSz95MJ
	wKtUIOTc8eOFUC+XOb6P2AHAi/5X7NQjEgJvPz/8jcZl0DkHGLIDGZhAe
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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



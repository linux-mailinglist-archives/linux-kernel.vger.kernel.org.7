Return-Path: <linux-kernel+bounces-749148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FD3B14AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C761AA0C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8400428724F;
	Tue, 29 Jul 2025 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="Z4+EPtqB"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B959182;
	Tue, 29 Jul 2025 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779747; cv=none; b=DDFMgE/TgyexVoauWCXGzYEu6u7u89HhS6hVDr6h3BYhLCtR7nXFgFvdNXZ2DnMaSNWO0RoHcr9L2lGBZWZv5/SXNw9b5hsUjiW1SbXEkvtCRa1IhH8Xs66c+g8oQImHhEuB+LLykXvuR0WknobAR32t/9a8K7B7XyTvXTj1O3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779747; c=relaxed/simple;
	bh=ObLvx2l/ijQLa5xRrPNGnhM9n5LhIgt+A4KmOOJyhZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eODmkCe+v0+HicjSnWGPOET4Znp/ssiAxRMQkMlNU67k7uEhZFQYUo69SyPt7HqZy/ROu+S27KxOmDd+q6HAjTX14hgZMrn+OkiVTRma/WyNBSlTcywQqCaDN9mNJNfVMhpyxLLNbGM2lm8k5j8ByV4sacMBXy0gL8kyVFq7FFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=Z4+EPtqB; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1753779656;
	bh=RN1WwuxpO4LBAyRHMTh9poQETUIZdvEm0QRwkE/4D2M=;
	h=From:To:Subject:Date:Message-Id;
	b=Z4+EPtqBzVjO4OoUTgOay8Vfed7OotRc0B7G1gf2JrrUF7f7XaDB0JelDXzs15hRk
	 iKKUeJ/8cWlO2I2NyCsmqDc8FMy2llfHuz7BNKubCEwyzgc3DPvVA3NZEwCvWDqqtq
	 vps+4iZ27/AUDFCeCRNLpnBv+6C1AvgIEIPG6Lmc=
X-QQ-mid: zesmtpgz1t1753779650tbf9605c9
X-QQ-Originating-IP: HOYsq8iA7FlhH8Rvf76IYCZ9Rt5I5SBH31MTUBKXFD4=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 29 Jul 2025 17:00:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18407573237461644155
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Peter Robinson <pbrobinson@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 3/5] drm/rockchip: cdn-dp: Support handle lane info and HPD without extcon
Date: Tue, 29 Jul 2025 17:00:30 +0800
Message-Id: <20250729090032.97-4-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250729090032.97-1-kernel@airkyi.com>
References: <20250729090032.97-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N0JG5d2dvsRDvRDstdXZf0SEwJJEdFHvVsC71c5F7Xr7QJeJXG0XvryL
	phJLF4Yrdn+mxMuFZFq4cddG+uBzSmcxjVvOHO8z9LdQPwRqD6x+pfOL/J1BuFco1Ch1LQW
	5orkjKx15/eKpIliRF9u37990N8J9rdUG4FnSKQ0QsnvK4n5QLIearpXZ5quWKQyTYP3eYg
	agQ+q2ElLpeIXfzi2C0FpANj3QCGWBG0qejbowqPesbL6T6jEjY8b2+IAkCf3DrXccu90/b
	5UqtyI1VhSD78veZd0P68G5qSuj4CepQuDAACeBz5Iilw72iWnO7AYTFKLVbJulo40b/sPU
	gRZLIGTb9BTqovhYJVg1QHQusvw3EhIQ+hXbD9+XGNJzL6RxLG5cHugfny9eeC/0JkcM+M8
	icXkQqvf28W7HgrhD18CtM+tTnlbVj+u82d2FdzuWeUH20ajOkQnOccqEzeSb+XzamP0H8h
	NEcKrJ2lGpMpsV7ADPtLxcCBlFogPo54PUqxYjl/z34pjhQz3+YTirx8aT3v3fV0k1C4edM
	qlMPphue18znrLK7sd9S7Pby0XdSeW6BHBE45pPyWToyxoyUGofByQEEJF5K65pbVkztImS
	f10moLnn+awIRYqTFp8Zyx66pqE5nOQNTvdF4ADx+vAzfmtg8gEHBPt51hKPbThOGkCLzsj
	eeHvWem4JI1ppVQ1DmTpKiDJ4CEIkYpnZFOXwIM2dnJvl3CdELv/ksglwIJwtY/7RNgStDp
	gDPmlMUOzdlPxULXFQEfdDZvZ9H+Ja1fJ6Dib86yzq9PM7dG4Ww+arnC0O+KZHpOMK/Wcl4
	ym28ibx4Is01E8tiRUrDifzv69dmQJvlVbfuwK046bPeet1tvBHzseJn87TNcJ+wJu7T7Kx
	kjPrVNmZwTI49filvCAUJMB3+WdC/Quztg4Fov/rsFYbdAUymm5CVb5DTTKko8wtmqA9VAN
	kLMpmVmg+TjxnT10FIOh9NDlpSf5Wrq/zNQvd/es9zUsph3BZpnQFMHei4O4EQ5r93U1Kss
	31hiJzjCKlA+St0wnD
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

This patch add support for get PHY lane info and handle HPD state
without help of extcon.

There is no extcon needed if the Type-C controller is present. In this
case, cdn_dp_hpd_notify() will handle HPD event from USB/DP combo PHY,
and the lane info can be get from PHY instead of extcon.

The extcon device should still be supported if Type-C controller is
not present.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---

Changes in v2:
- Ignore duplicate HPD events.

 drivers/gpu/drm/rockchip/cdn-dp-core.c | 37 ++++++++++++++++++++------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 24f6b3879f4b..b574b059b58d 100644
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
@@ -821,6 +827,17 @@ static int cdn_dp_audio_mute_stream(struct drm_connector *connector,
 	return ret;
 }
 
+static void cdn_dp_hpd_notify(struct drm_bridge *bridge,
+			      enum drm_connector_status status)
+{
+	struct cdn_dp_device *dp = bridge_to_dp(bridge);
+	enum drm_connector_status last_status =
+		dp->connected ? connector_status_connected : connector_status_disconnected;
+
+	if (last_status != status)
+		schedule_work(&dp->event_work);
+}
+
 static const struct drm_bridge_funcs cdn_dp_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
@@ -831,6 +848,7 @@ static const struct drm_bridge_funcs cdn_dp_bridge_funcs = {
 	.atomic_disable = cdn_dp_bridge_atomic_disable,
 	.mode_valid = cdn_dp_bridge_mode_valid,
 	.mode_set = cdn_dp_bridge_mode_set,
+	.hpd_notify = cdn_dp_hpd_notify,
 
 	.dp_audio_prepare = cdn_dp_audio_prepare,
 	.dp_audio_mute_stream = cdn_dp_audio_mute_stream,
@@ -1028,6 +1046,9 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 	for (i = 0; i < dp->ports; i++) {
 		port = dp->port[i];
 
+		if (!port->extcon)
+			continue;
+
 		port->event_nb.notifier_call = cdn_dp_pd_event;
 		ret = devm_extcon_register_notifier(dp->dev, port->extcon,
 						    EXTCON_DISP_DP,
@@ -1120,14 +1141,14 @@ static int cdn_dp_probe(struct platform_device *pdev)
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



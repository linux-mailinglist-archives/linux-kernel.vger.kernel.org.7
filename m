Return-Path: <linux-kernel+bounces-731732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B951FB058BC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0EF3A7669
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F862DEA6D;
	Tue, 15 Jul 2025 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="E8cHG9do"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F17C2DE6ED;
	Tue, 15 Jul 2025 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578733; cv=none; b=hhpPSkd0uyKTR5mdzsqd9otB0tF9KEk39uDUdb6JiV7vSQjhtkgULPOid4vS2LGC4Uo+pU5li8sXHhgbFeanKFzMpc/V6OmZF6dnOJhOEJEpzmrekcSwKboBh1yhYeQNp7+6Ivv5GuuSyy/BiK8+Nlo/eFIMNG0XGS+qE1TSVLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578733; c=relaxed/simple;
	bh=4FsiX6RUU3fRxbqUZRBFaMPrgVBPWcb0ZWgsUliivsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=osKQmTF/PAm/jeOQ2Ojh/m5eQiVmjYMw+A+ar7dmPW34RdjTAR2CERAyiG6/+oBLSuNyuSWi2yxQhw/spUhAav2pM1ji9ozKy9iLLlLe+mhawl9Ez57TJrEoK1t/Er0VFn5FY3HDSnHVNep+TJWOTOBpO4h9k6ZpSWq6LNtstDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=E8cHG9do; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1752578719;
	bh=/b/lAhCvsonGE8Z852+2G/07p0p8yhZ5USq40tfyzbw=;
	h=From:To:Subject:Date:Message-Id;
	b=E8cHG9doUmvgIe91ixrxp7NGGFU91Z+nfPnlc1kJZvHLL7x3LwPgV0bngLpoPqpJ5
	 2/zNuTXR+oarxdq2vZKHzqVoO1lPW1JRRcRJPY7v/mETlffiAt62Bgkbb4yrsDkXFa
	 60x4S0lTEM5+XIuJdAbRfuo3bqguwwLlIeCe6aJc=
X-QQ-mid: zesmtpsz3t1752578718t9af83c66
X-QQ-Originating-IP: 9mUY+DgpKeGKBIqUqnlFegV3kCI4AR72owXY37bfQwc=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 19:25:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15861609550683848417
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
	Diederik de Haas <didi.debian@cknow.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 4/5] drm/rockchip: cdn-dp: Add support for Type-C TCPM
Date: Tue, 15 Jul 2025 19:24:55 +0800
Message-Id: <20250715112456.101-5-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250715112456.101-1-kernel@airkyi.com>
References: <20250715112456.101-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NYz8c2bcbB9MQnNn3zMpWCyy1wOJpwH1FI3r+N0Of+zkM4IeDaarohS6
	2TB+9N1Q5HxUwcddBd1NwAaMW+owNwEHngX+SJM8ipoVSgPy5GLFccR6d65+flcYIrrKXnD
	iekzUip/Phux2bJ5vgX22crFnC5moFuaclTB2sOO1RNGAHUX/nFB0mof2uhl5LYHsbdKg3G
	66o3ehFXcxXLi+xWgEsJH1aiQxvH8JhCDayo8gj+NowF+V3BzLyJd46qoxFxHfgKr4MoL9J
	/R4/LhJcNWO+Nm3TtlZqmtSOzp/EQl8MfsEWVMCrUeSn9iqq3BOmwCiiT6H8EVFszGobsho
	l6WCukfoYv7aLx/egZlBkaZ8gEjLqO4xeTRERq8tc8RSulhbxT9QXnuWa0rhMbgLQH5G3Iu
	7W8ZE6YiMlhy7vQbNfp3u5Jfc9TloFaAR3F1RuTPzc4CyNH0qLRSTVcAR9ksrJBu+FXqvTP
	OBb4IsVwP5jJGPfEpTn3eW71tSByYaMaVJvdUB3zTOSdCIKnIf+Mb8f3qjmNOWAf/l+Enon
	7SCv193aALXdKgPToJWOCle2FLzGQko7BSDUVKLqNZZIYHH+R9gw63KmtcUC7z/Nr3+BBjz
	HW0/xAWVCo3l16Rmwo1PkkLXyWenrLO9jO01pQdC5foHq3y5cwgGIszUE2Bo2cZliGYeoOq
	FDE/ukclS3z5tl9FqvT3aboEVifNc5RkNCYNJ56BUz9EI2TCRBclPqNxQ/1m82e6YH1z7YO
	dV2aYYuGUbLF3Z4SvZdCUQC0UCx7LJLYB/SNjpbOy3Ef60c+jOpD5fM1RhGrr8QUErT0ZWG
	34SpWsU0Cc6l1VaHPaUC4kgmjpRgvrbch/S/D5EiqaJr6sTDKBouNLXPhPCPvnRr+uFDTHG
	GZWoN+6l+6o4nPRiqnTDTcM4lJgsKNt9j9ORUCLfUfIi024p/99WRL1qD5R94GDLDK3xTsL
	OxS7ezP71+E6B96iLeNW/GcBz4SvkasqHG/Q7AQtu/v1yKw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

This patch add support for Type-C Port Manager. If the Type-C
controller is present, the DP hot plug events can be notified with
the help of TCPM and without the need for extcon.

The extcon device should still be supported.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c | 37 ++++++++++++++++++--------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 24f6b3879f4b..3354d0e4ae4f 100644
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
@@ -821,6 +827,14 @@ static int cdn_dp_audio_mute_stream(struct drm_connector *connector,
 	return ret;
 }
 
+static void cdn_dp_hpd_notify(struct drm_bridge *bridge,
+			   enum drm_connector_status status)
+{
+	struct cdn_dp_device *dp = bridge_to_dp(bridge);
+
+	schedule_work(&dp->event_work);
+}
+
 static const struct drm_bridge_funcs cdn_dp_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
@@ -831,6 +845,7 @@ static const struct drm_bridge_funcs cdn_dp_bridge_funcs = {
 	.atomic_disable = cdn_dp_bridge_atomic_disable,
 	.mode_valid = cdn_dp_bridge_mode_valid,
 	.mode_set = cdn_dp_bridge_mode_set,
+	.hpd_notify = cdn_dp_hpd_notify,
 
 	.dp_audio_prepare = cdn_dp_audio_prepare,
 	.dp_audio_mute_stream = cdn_dp_audio_mute_stream,
@@ -938,9 +953,6 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 
 out:
 	mutex_unlock(&dp->lock);
-	drm_bridge_hpd_notify(&dp->bridge,
-			      dp->connected ? connector_status_connected
-					    : connector_status_disconnected);
 }
 
 static int cdn_dp_pd_event(struct notifier_block *nb,
@@ -1028,6 +1040,9 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 	for (i = 0; i < dp->ports; i++) {
 		port = dp->port[i];
 
+		if (!port->extcon)
+			continue;
+
 		port->event_nb.notifier_call = cdn_dp_pd_event;
 		ret = devm_extcon_register_notifier(dp->dev, port->extcon,
 						    EXTCON_DISP_DP,
@@ -1120,14 +1135,14 @@ static int cdn_dp_probe(struct platform_device *pdev)
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




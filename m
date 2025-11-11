Return-Path: <linux-kernel+bounces-895218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAA0C4D44D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5453818907A7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035843590BB;
	Tue, 11 Nov 2025 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="oQFGJoTh"
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2C93587BA;
	Tue, 11 Nov 2025 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858296; cv=none; b=FS1Aro88QicREksuDZJHWD7sfucetGsJLqsehJWPeH1zeI8w7b3flUvsPiGZbax2JlDoXLMlCsOj38mUt6MeTm8/6YXdyjrzLh1vkRlqnncmBu+UU//lyhnG0Ld5+JfyQKUBPYc/Z/BwrF4m1/lJP+e6sp1PIWZqrmtWmOzZV+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858296; c=relaxed/simple;
	bh=uG4ACee89o5yDAx8jl0XQ3Ej30wl3vyq3DFGW2WuGOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hLPR76x2/OjMfVAHDutyP4/Bem95QZRCFdX3TM6jT5jL4cyUOY+p+d552g6qCkAuL97d74PwjtwzBRwS2pqg2oZUJNcXnWuXpmz2QF/VuH204WQ3bTHI0uPUeKYSTPgwnlTMaYjgsQf2wkIufN+HYSbGWOjNY7iAtGYD6fHKlAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=oQFGJoTh; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1762858286;
	bh=vW7i3csX12V3fwAT7AMdFBxlvR1nMoxQ7dR1U2yhBis=;
	h=From:To:Subject:Date:Message-Id;
	b=oQFGJoThU2nKhY2kAm6bD7DH2MlXhJ/TkYF89YRiT64ZYB8JYgsZZitMR624l1Lqa
	 Q9szvoKO7WmJPOZMCxe5vS9D0JsJ7mtcYEAouyF1Vmq9pYy4qf9wPtQaqLrFSJXyMh
	 R3odZxren/yiTwxMpUTdR+dy1dIojY6G9EPcOPTM=
X-QQ-mid: zesmtpsz9t1762858282tdafe9850
X-QQ-Originating-IP: wyzPTYXjSD/oKTZmDvyOXUmdUWTX2813dJRRjsTLuKg=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Nov 2025 18:51:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13309204121972102905
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
Subject: [PATCH v9 08/10] drm/rockchip: cdn-dp: Add multiple bridges to support PHY port selection
Date: Tue, 11 Nov 2025 18:50:38 +0800
Message-Id: <20251111105040.94-9-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251111105040.94-1-kernel@airkyi.com>
References: <20251111105040.94-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N9DIJtFs/avns4hvy0i9PlQnzUKMcR9PMBIHO1WJNv0mYLGs2SuQu8Ep
	3BpdYmkzaAtmDXHsoVhPoEwkIMZoxbb3Xg/ohwkMMgE22FSeIhVpvtcytMtGnQyLub4q/ot
	eJPUZrLPm8QRG6536pvRaUrxZlPwMBSFe5Ao4It3IJuueaFAhFC+vDqA3Z2xglk1+QYl4/r
	qu3rpu+TCJbpN3GtgZqA+BtYK4mOlNy4K6e5PwfOKJGYg/41n/UhyJKCm13Uxvbbluh5R+p
	7RTQ4bbVMYMlKxhW6dUtledHHblw5uf/psfMp2znBda83YNVTSSERmhdvPmAV5ea4/7kiAw
	sap/zb3MYlejUzrCe7Mivwhkso6MoU4AlrZGpE+sVPiCtQ2RWw5WDRGCzhnjcUM8o3FyMh6
	trMTnlzDLVLEJRWD/pIP/ZKPby2VSrOKid+VTONgOVGKCsNAV5AYprBbPx/HM/axlc2bCz8
	iwrYwLcLDt35VTrmFbKEW0/ByCnmB2T2YE6pzxLujwGOO8hCfeR38ZI5l/JAHvJ7fHHiSOG
	b+cxgeFml/26JfJcF0ukDcL7JbdarBQD64DSKFaQUj1iuUdkNwL38TwsUUVHQPFZYV4OV+I
	Ai1Und8JCyIMwRHyMdrOP/bIsAP07iE5Rl+M+GZU7IO+yf8YS7N+c0GxrywwpgXgFRC01X0
	gBlzPZH0NLKrdwbl3XZhL0bnIFEXIk6cA1sGSeq2R8VKNEloOC9bhUgrG8bSYD98HeFOwg4
	wbOz16Ni4NAE3bZ+YQYTLnOtjcuOgF9LS1btpCK7ms1HfGW318PKsNfENHHMVe/TG7P4hXa
	ep9xhTvfhFEjJBBr3locRb9hczzGpfsiIaYVT5eOMyfDmyxK1IXcZiARLzExuEcP8BwESwE
	TyisTHMXlgR1KLGJ364oGOvPCAMxh3j4KgBRtik/V2Ba+WHcSSwDYNWHL8lksGoKsqSl1DU
	3rfxTFQVim8Z0I9pQqYHjPA+P0h9KROTf1UfzS5N8jNnqW6tMZ6DyVumjZi5fLcbJV3XaTr
	qIbuWHIoqG7BK0V/g7q076AOLe4fE=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The RK3399 has two USB/DP combo PHY and one CDN-DP controller. And
the CDN-DP can be switched to output to one of the PHYs. If both ports
are plugged into DP, DP will select the first port for output.

This patch adds support for multiple bridges, enabling users to flexibly
select the output port. For each PHY port, a separate encoder and bridge
are registered.

The change is based on the DRM AUX HPD bridge, rather than the
extcon approach. This requires the DT to correctly describe the
connections between the first bridge in bridge chain and DP
controller. For example, the bridge chain may be like this:

PHY aux birdge -> fsa4480 analog audio switch bridge ->
onnn,nb7vpq904m USB reminder bridge -> USB-C controller AUX HPD bridge

In this case, the connection relationships among the PHY aux bridge
and the DP contorller need to be described in DT.

In addition, the cdn_dp_parse_next_bridge_dt() will parses it and
determines whether to register one or two bridges.

Since there is only one DP controller, only one of the PHY ports can
output at a time. The key is how to switch between different PHYs,
which is handled by cdn_dp_switch_port() and cdn_dp_enable().

There are two cases:

1. Neither bridge is enabled. In this case, both bridges can
independently read the EDID, and the PHY port may switch before
reading the EDID.

2. One bridge is already enabled. In this case, other bridges are not
allowed to read the EDID. So we will try to return the cached EDID.

Since the scenario of two ports plug in at the same time is rare,
I don't have a board which support two TypeC connector to test this.
Therefore, I tested forced switching on a single PHY port, as well as
output using a fake PHY port alongside a real PHY port.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---

Changes in v9:
- Select DRM_AUX_HPD_BRIDGE when using DP driver.

(no changes since v7)

Changes in v6:
- Rename some variable names.
- Attach the DP bridge to the next bridge.

Changes in v5:
- By parsing the HPD bridge chain, set the connector's of_node to the
of_node corresponding to the USB-C connector.
- Return EDID cache when other port is already enabled.

 drivers/gpu/drm/rockchip/Kconfig       |   1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c | 329 ++++++++++++++++++++-----
 drivers/gpu/drm/rockchip/cdn-dp-core.h |  24 +-
 3 files changed, 297 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index b7b025814e72..10d9f29a3d44 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -56,6 +56,7 @@ config ROCKCHIP_CDN_DP
 	select DRM_DISPLAY_HELPER
 	select DRM_BRIDGE_CONNECTOR
 	select DRM_DISPLAY_DP_HELPER
+	select DRM_AUX_HPD_BRIDGE
 	help
 	  This selects support for Rockchip SoC specific extensions
 	  for the cdn DP driver. If you want to enable Dp on
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 1e27301584a4..5c0e5209d3b8 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -27,16 +27,17 @@
 #include "cdn-dp-core.h"
 #include "cdn-dp-reg.h"
 
-static inline struct cdn_dp_device *bridge_to_dp(struct drm_bridge *bridge)
+static int cdn_dp_switch_port(struct cdn_dp_device *dp, struct cdn_dp_port *prev_port,
+			      struct cdn_dp_port *port);
+
+static inline struct cdn_dp_bridge *bridge_to_dp_bridge(struct drm_bridge *bridge)
 {
-	return container_of(bridge, struct cdn_dp_device, bridge);
+	return container_of(bridge, struct cdn_dp_bridge, bridge);
 }
 
-static inline struct cdn_dp_device *encoder_to_dp(struct drm_encoder *encoder)
+static inline struct cdn_dp_device *bridge_to_dp(struct drm_bridge *bridge)
 {
-	struct rockchip_encoder *rkencoder = to_rockchip_encoder(encoder);
-
-	return container_of(rkencoder, struct cdn_dp_device, encoder);
+	return bridge_to_dp_bridge(bridge)->parent;
 }
 
 #define GRF_SOC_CON9		0x6224
@@ -191,14 +192,27 @@ static int cdn_dp_get_sink_count(struct cdn_dp_device *dp, u8 *sink_count)
 static struct cdn_dp_port *cdn_dp_connected_port(struct cdn_dp_device *dp)
 {
 	struct cdn_dp_port *port;
-	int i, lanes;
+	int i, lanes[MAX_PHY];
 
 	for (i = 0; i < dp->ports; i++) {
 		port = dp->port[i];
-		lanes = cdn_dp_get_port_lanes(port);
-		if (lanes)
+		lanes[i] = cdn_dp_get_port_lanes(port);
+		if (!dp->next_bridge_valid)
 			return port;
 	}
+
+	if (dp->next_bridge_valid) {
+		/* If more than one port is available, pick the last active port */
+		if (dp->active_port > 0 && lanes[dp->active_port])
+			return dp->port[dp->active_port];
+
+		/* If the last active port is not available, pick an available port in order */
+		for (i = 0; i < dp->bridge_count; i++) {
+			if (lanes[i])
+				return dp->port[i];
+		}
+	}
+
 	return NULL;
 }
 
@@ -253,12 +267,45 @@ static const struct drm_edid *
 cdn_dp_bridge_edid_read(struct drm_bridge *bridge, struct drm_connector *connector)
 {
 	struct cdn_dp_device *dp = bridge_to_dp(bridge);
-	const struct drm_edid *drm_edid;
+	struct cdn_dp_bridge *dp_bridge = bridge_to_dp_bridge(bridge);
+	struct cdn_dp_port *port = dp->port[dp_bridge->id];
+	struct cdn_dp_port *prev_port;
+	const struct drm_edid *drm_edid = NULL;
+	int i, ret;
 
 	mutex_lock(&dp->lock);
+
+	/* More than one port is available */
+	if (dp->bridge_count > 1 && !port->phy_enabled) {
+		for (i = 0; i < dp->bridge_count; i++) {
+			/* Another port already enable */
+			if (dp->bridge_list[i] != dp_bridge && dp->bridge_list[i]->enabled)
+				goto get_cache;
+			/* Find already enabled port */
+			if (dp->port[i]->phy_enabled)
+				prev_port = dp->port[i];
+		}
+
+		/* Switch to current port */
+		if (prev_port) {
+			ret = cdn_dp_switch_port(dp, prev_port, port);
+			if (ret)
+				goto get_cache;
+		}
+	}
+
 	drm_edid = drm_edid_read_custom(connector, cdn_dp_get_edid_block, dp);
+	/* replace edid cache */
+	if (dp->edid_cache[dp_bridge->id])
+		drm_edid_free(dp->edid_cache[dp_bridge->id]);
+	dp->edid_cache[dp_bridge->id] = drm_edid_dup(drm_edid);
+
 	mutex_unlock(&dp->lock);
+	return drm_edid;
 
+get_cache:
+	drm_edid = drm_edid_dup(dp->edid_cache[dp_bridge->id]);
+	mutex_unlock(&dp->lock);
 	return drm_edid;
 }
 
@@ -267,12 +314,13 @@ cdn_dp_bridge_mode_valid(struct drm_bridge *bridge,
 			 const struct drm_display_info *display_info,
 			 const struct drm_display_mode *mode)
 {
+	struct cdn_dp_bridge *dp_bridge = bridge_to_dp_bridge(bridge);
 	struct cdn_dp_device *dp = bridge_to_dp(bridge);
 	u32 requested, actual, rate, sink_max, source_max = 0;
 	u8 lanes, bpc;
 
 	/* If DP is disconnected, every mode is invalid */
-	if (!dp->connected)
+	if (!dp_bridge->connected || !dp->connected)
 		return MODE_BAD;
 
 	switch (display_info->bpc) {
@@ -550,6 +598,54 @@ static bool cdn_dp_check_link_status(struct cdn_dp_device *dp)
 	return drm_dp_channel_eq_ok(link_status, min(port->lanes, sink_lanes));
 }
 
+static int cdn_dp_switch_port(struct cdn_dp_device *dp, struct cdn_dp_port *prev_port,
+			      struct cdn_dp_port *port)
+{
+	int ret;
+
+	if (dp->active)
+		return 0;
+
+	ret = cdn_dp_disable_phy(dp, prev_port);
+	if (ret)
+		goto out;
+	ret = cdn_dp_enable_phy(dp, port);
+	if (ret)
+		goto out;
+
+	ret = cdn_dp_get_sink_capability(dp);
+	if (ret) {
+		cdn_dp_disable_phy(dp, port);
+		goto out;
+	}
+
+	dp->active = true;
+	dp->lanes = port->lanes;
+
+	if (!cdn_dp_check_link_status(dp)) {
+		dev_info(dp->dev, "Connected with sink; re-train link\n");
+
+		ret = cdn_dp_train_link(dp);
+		if (ret) {
+			dev_err(dp->dev, "Training link failed: %d\n", ret);
+			goto out;
+		}
+
+		ret = cdn_dp_set_video_status(dp, CONTROL_VIDEO_IDLE);
+		if (ret) {
+			dev_err(dp->dev, "Failed to idle video %d\n", ret);
+			goto out;
+		}
+
+		ret = cdn_dp_config_video(dp);
+		if (ret)
+			dev_err(dp->dev, "Failed to configure video: %d\n", ret);
+	}
+
+out:
+	return ret;
+}
+
 static void cdn_dp_display_info_update(struct cdn_dp_device *dp,
 				       struct drm_display_info *display_info)
 {
@@ -571,6 +667,7 @@ static void cdn_dp_display_info_update(struct cdn_dp_device *dp,
 static void cdn_dp_bridge_atomic_enable(struct drm_bridge *bridge, struct drm_atomic_state *state)
 {
 	struct cdn_dp_device *dp = bridge_to_dp(bridge);
+	struct cdn_dp_bridge *dp_bridge = bridge_to_dp_bridge(bridge);
 	struct drm_connector *connector;
 	int ret, val;
 
@@ -580,7 +677,7 @@ static void cdn_dp_bridge_atomic_enable(struct drm_bridge *bridge, struct drm_at
 
 	cdn_dp_display_info_update(dp, &connector->display_info);
 
-	ret = drm_of_encoder_active_endpoint_id(dp->dev->of_node, &dp->encoder.encoder);
+	ret = drm_of_encoder_active_endpoint_id(dp->dev->of_node, &dp_bridge->encoder.encoder);
 	if (ret < 0) {
 		DRM_DEV_ERROR(dp->dev, "Could not get vop id, %d", ret);
 		return;
@@ -599,6 +696,9 @@ static void cdn_dp_bridge_atomic_enable(struct drm_bridge *bridge, struct drm_at
 
 	mutex_lock(&dp->lock);
 
+	if (dp->next_bridge_valid)
+		dp->active_port = dp_bridge->id;
+
 	ret = cdn_dp_enable(dp);
 	if (ret) {
 		DRM_DEV_ERROR(dp->dev, "Failed to enable bridge %d\n",
@@ -631,6 +731,7 @@ static void cdn_dp_bridge_atomic_enable(struct drm_bridge *bridge, struct drm_at
 		goto out;
 	}
 
+	dp_bridge->enabled = true;
 out:
 	mutex_unlock(&dp->lock);
 }
@@ -638,9 +739,11 @@ static void cdn_dp_bridge_atomic_enable(struct drm_bridge *bridge, struct drm_at
 static void cdn_dp_bridge_atomic_disable(struct drm_bridge *bridge, struct drm_atomic_state *state)
 {
 	struct cdn_dp_device *dp = bridge_to_dp(bridge);
+	struct cdn_dp_bridge *dp_bridge = bridge_to_dp_bridge(bridge);
 	int ret;
 
 	mutex_lock(&dp->lock);
+	dp_bridge->enabled = false;
 
 	if (dp->active) {
 		ret = cdn_dp_disable(dp);
@@ -827,6 +930,16 @@ static int cdn_dp_audio_mute_stream(struct drm_bridge *bridge,
 	return ret;
 }
 
+static void cdn_dp_bridge_hpd_notify(struct drm_bridge *bridge,
+			   enum drm_connector_status status)
+{
+	struct cdn_dp_bridge *dp_bridge = bridge_to_dp_bridge(bridge);
+	struct cdn_dp_device *dp = bridge_to_dp(bridge);
+
+	dp->bridge_list[dp_bridge->id]->connected = status == connector_status_connected;
+	schedule_work(&dp->event_work);
+}
+
 static const struct drm_bridge_funcs cdn_dp_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
@@ -837,6 +950,7 @@ static const struct drm_bridge_funcs cdn_dp_bridge_funcs = {
 	.atomic_disable = cdn_dp_bridge_atomic_disable,
 	.mode_valid = cdn_dp_bridge_mode_valid,
 	.mode_set = cdn_dp_bridge_mode_set,
+	.hpd_notify = cdn_dp_bridge_hpd_notify,
 
 	.dp_audio_prepare = cdn_dp_audio_prepare,
 	.dp_audio_mute_stream = cdn_dp_audio_mute_stream,
@@ -885,7 +999,8 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 {
 	struct cdn_dp_device *dp = container_of(work, struct cdn_dp_device,
 						event_work);
-	int ret;
+	bool connected;
+	int i, ret;
 
 	mutex_lock(&dp->lock);
 
@@ -944,9 +1059,12 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 
 out:
 	mutex_unlock(&dp->lock);
-	drm_bridge_hpd_notify(&dp->bridge,
-			      dp->connected ? connector_status_connected
-					    : connector_status_disconnected);
+	for (i = 0; i < dp->bridge_count; i++) {
+		connected = dp->connected && dp->bridge_list[i]->connected;
+		drm_bridge_hpd_notify(&dp->bridge_list[i]->bridge,
+				      connected ? connector_status_connected
+						: connector_status_disconnected);
+	}
 }
 
 static int cdn_dp_pd_event(struct notifier_block *nb,
@@ -966,28 +1084,16 @@ static int cdn_dp_pd_event(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
-static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
+static int cdn_bridge_add(struct device *dev,
+			  struct drm_bridge *bridge,
+			  struct drm_bridge *next_bridge,
+			  struct drm_encoder *encoder)
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
-	struct drm_encoder *encoder;
+	struct drm_device *drm_dev = dp->drm_dev;
+	struct drm_bridge *last_bridge = NULL;
 	struct drm_connector *connector;
-	struct cdn_dp_port *port;
-	struct drm_device *drm_dev = data;
-	int ret, i;
-
-	ret = cdn_dp_parse_dt(dp);
-	if (ret < 0)
-		return ret;
-
-	dp->drm_dev = drm_dev;
-	dp->connected = false;
-	dp->active = false;
-	dp->active_port = -1;
-	dp->fw_loaded = false;
-
-	INIT_WORK(&dp->event_work, cdn_dp_pd_event_work);
-
-	encoder = &dp->encoder.encoder;
+	int ret;
 
 	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
 							     dev->of_node);
@@ -1002,26 +1108,38 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 
 	drm_encoder_helper_add(encoder, &cdn_dp_encoder_helper_funcs);
 
-	dp->bridge.ops =
-			DRM_BRIDGE_OP_DETECT |
-			DRM_BRIDGE_OP_EDID |
-			DRM_BRIDGE_OP_HPD |
-			DRM_BRIDGE_OP_DP_AUDIO;
-	dp->bridge.of_node = dp->dev->of_node;
-	dp->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
-	dp->bridge.hdmi_audio_dev = dp->dev;
-	dp->bridge.hdmi_audio_max_i2s_playback_channels = 8;
-	dp->bridge.hdmi_audio_spdif_playback = 1;
-	dp->bridge.hdmi_audio_dai_port = -1;
-
-	ret = devm_drm_bridge_add(dev, &dp->bridge);
+
+	bridge->ops =
+		DRM_BRIDGE_OP_DETECT |
+		DRM_BRIDGE_OP_EDID |
+		DRM_BRIDGE_OP_HPD |
+		DRM_BRIDGE_OP_DP_AUDIO;
+	bridge->of_node = dp->dev->of_node;
+	bridge->type = DRM_MODE_CONNECTOR_DisplayPort;
+	bridge->hdmi_audio_dev = dp->dev;
+	bridge->hdmi_audio_max_i2s_playback_channels = 8;
+	bridge->hdmi_audio_spdif_playback = 1;
+	bridge->hdmi_audio_dai_port = -1;
+
+	ret = devm_drm_bridge_add(dev, bridge);
 	if (ret)
 		return ret;
 
-	ret = drm_bridge_attach(encoder, &dp->bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 	if (ret)
 		return ret;
 
+	if (next_bridge) {
+		ret = drm_bridge_attach(encoder, next_bridge, bridge,
+					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+		if (ret)
+			return ret;
+
+		last_bridge = next_bridge;
+		while (drm_bridge_get_next_bridge(last_bridge))
+			last_bridge = drm_bridge_get_next_bridge(last_bridge);
+	}
+
 	connector = drm_bridge_connector_init(drm_dev, encoder);
 	if (IS_ERR(connector)) {
 		ret = PTR_ERR(connector);
@@ -1029,8 +1147,102 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 	}
 
+	if (last_bridge)
+		connector->fwnode = fwnode_handle_get(of_fwnode_handle(last_bridge->of_node));
+
 	drm_connector_attach_encoder(connector, encoder);
 
+	return 0;
+}
+
+static int cdn_dp_parse_next_bridge_dt(struct cdn_dp_device *dp)
+{
+	struct device_node *np = dp->dev->of_node;
+	struct device_node *port __free(device_node) = of_graph_get_port_by_id(np, 1);
+	struct drm_bridge *bridge;
+	int count = 0;
+	int ret = 0;
+	int i;
+
+	/* If device use extcon, do not use hpd bridge */
+	for (i = 0; i < dp->ports; i++) {
+		if (dp->port[i]->extcon) {
+			dp->bridge_count = 1;
+			return 0;
+		}
+	}
+
+
+	/* One endpoint may correspond to one next bridge. */
+	for_each_of_graph_port_endpoint(port, dp_ep) {
+		struct device_node *next_bridge_node __free(device_node) =
+			of_graph_get_remote_port_parent(dp_ep);
+
+		bridge = of_drm_find_bridge(next_bridge_node);
+		if (!bridge) {
+			ret = -EPROBE_DEFER;
+			goto out;
+		}
+
+		dp->next_bridge_valid = true;
+		dp->next_bridge_list[count].bridge = bridge;
+		dp->next_bridge_list[count].parent = dp;
+		dp->next_bridge_list[count].id = count;
+		count++;
+	}
+
+out:
+	dp->bridge_count = count ? count : 1;
+	return ret;
+}
+
+static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
+{
+	struct cdn_dp_device *dp = dev_get_drvdata(dev);
+	struct drm_bridge *bridge, *next_bridge;
+	struct drm_encoder *encoder;
+	struct cdn_dp_port *port;
+	struct drm_device *drm_dev = data;
+	struct cdn_dp_bridge *dp_bridge;
+	int ret, i;
+
+	ret = cdn_dp_parse_dt(dp);
+	if (ret < 0)
+		return ret;
+
+	ret = cdn_dp_parse_next_bridge_dt(dp);
+	if (ret)
+		return ret;
+
+	dp->drm_dev = drm_dev;
+	dp->connected = false;
+	dp->active = false;
+	dp->active_port = -1;
+	dp->fw_loaded = false;
+
+	for (i = 0; i < dp->bridge_count; i++) {
+		dp_bridge = devm_drm_bridge_alloc(dev, struct cdn_dp_bridge, bridge,
+						    &cdn_dp_bridge_funcs);
+		if (IS_ERR(dp_bridge))
+			return PTR_ERR(dp_bridge);
+		dp_bridge->id = i;
+		dp_bridge->parent = dp;
+		if (!dp->next_bridge_valid)
+			dp_bridge->connected = true;
+		dp->bridge_list[i] = dp_bridge;
+	}
+
+	for (i = 0; i < dp->bridge_count; i++) {
+		encoder = &dp->bridge_list[i]->encoder.encoder;
+		bridge = &dp->bridge_list[i]->bridge;
+		next_bridge = dp->next_bridge_list[i].bridge;
+		ret = cdn_bridge_add(dev, bridge, next_bridge, encoder);
+		if (ret)
+			return ret;
+	}
+
+	INIT_WORK(&dp->event_work, cdn_dp_pd_event_work);
+
 	for (i = 0; i < dp->ports; i++) {
 		port = dp->port[i];
 
@@ -1058,10 +1270,17 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 static void cdn_dp_unbind(struct device *dev, struct device *master, void *data)
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
-	struct drm_encoder *encoder = &dp->encoder.encoder;
+	struct drm_encoder *encoder;
+	int i;
 
 	cancel_work_sync(&dp->event_work);
-	encoder->funcs->destroy(encoder);
+	for (i = 0; i < dp->bridge_count; i++) {
+		encoder = &dp->bridge_list[i]->encoder.encoder;
+		encoder->funcs->destroy(encoder);
+	}
+
+	for (i = 0; i < MAX_PHY; i++)
+		drm_edid_free(dp->edid_cache[i]);
 
 	pm_runtime_disable(dev);
 	if (dp->fw_loaded)
@@ -1112,10 +1331,10 @@ static int cdn_dp_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 
-	dp = devm_drm_bridge_alloc(dev, struct cdn_dp_device, bridge,
-				   &cdn_dp_bridge_funcs);
-	if (IS_ERR(dp))
-		return PTR_ERR(dp);
+	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
+	if (!dp)
+		return -ENOMEM;
+
 	dp->dev = dev;
 
 	match = of_match_node(cdn_dp_dt_ids, pdev->dev.of_node);
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
index e9c30b9fd543..ce1707a5c746 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
@@ -38,6 +38,8 @@ enum vic_pxl_encoding_format {
 	Y_ONLY = 0x10,
 };
 
+struct cdn_dp_device;
+
 struct video_info {
 	bool h_sync_polarity;
 	bool v_sync_polarity;
@@ -63,16 +65,34 @@ struct cdn_dp_port {
 	u8 id;
 };
 
+struct cdn_dp_bridge {
+	struct cdn_dp_device *parent;
+	struct drm_bridge bridge;
+	struct rockchip_encoder encoder;
+	bool connected;
+	bool enabled;
+	int id;
+};
+
+struct cdn_dp_next_bridge {
+	struct cdn_dp_device *parent;
+	struct drm_bridge *bridge;
+	int id;
+};
+
 struct cdn_dp_device {
 	struct device *dev;
 	struct drm_device *drm_dev;
-	struct drm_bridge bridge;
-	struct rockchip_encoder encoder;
+	int bridge_count;
+	struct cdn_dp_bridge *bridge_list[MAX_PHY];
+	struct cdn_dp_next_bridge next_bridge_list[MAX_PHY];
+	const struct drm_edid *edid_cache[MAX_PHY];
 	struct drm_display_mode mode;
 	struct platform_device *audio_pdev;
 	struct work_struct event_work;
 
 	struct mutex lock;
+	bool next_bridge_valid;
 	bool connected;
 	bool active;
 	bool suspended;
-- 
2.51.1



Return-Path: <linux-kernel+bounces-736309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AF2B09B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B371C231B5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9179321A436;
	Fri, 18 Jul 2025 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="pBn2lw6B"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE6207A08;
	Fri, 18 Jul 2025 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820016; cv=none; b=mVfUzFzpLTOa3zMB5sRvHcemgkSF35DMkYkIT9QvFnIC8S/+4CFhGCKIycLGMnqzSZIvmW7X1lfes9kOOjUjteQEUjs8umGsQefVYyz6yjZeGFCekOF8v6wQOV0AmxbJ8BsqXVWad9eojPgSXcFkoYuonkvdthEY4aSxR4OaZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820016; c=relaxed/simple;
	bh=ObLvx2l/ijQLa5xRrPNGnhM9n5LhIgt+A4KmOOJyhZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=L2wctuymezUN4ZnX46qIkzzuY6cR/17j3cxA9d7oHpXmCS9i7CZeL9xAXTmqlAzNOi5Ukx97SROCzL1UjoF+41Bg2PssTEdq/FKeuRsTkuRJp2IXf6pTQVpsb1WD7vN6VPBbubNapbFBxHsCi9kJnLGM7pj8bAbkeXo/qjFZa+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=pBn2lw6B; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1752820001;
	bh=RN1WwuxpO4LBAyRHMTh9poQETUIZdvEm0QRwkE/4D2M=;
	h=From:To:Subject:Date:Message-Id;
	b=pBn2lw6B3Sg7GitpCCucGLDo2HXaKxT6IJZnb7TOtGHl3MbQwBL2s141WB64ML/xp
	 //AMo4MmOOXSL1mmol3WbWZROsPv11yMazXUijs8SBgWeIAsEAbg61Bgu9Rfkmxn+7
	 DesfWrLb4sYTj+lsMkS9AZ3hcvzlwLBaWcG3BFAw=
X-QQ-mid: zesmtpgz7t1752819996t97191eb6
X-QQ-Originating-IP: kzXOt25riktyxVYSJcZnz65OhKPsh6RSYah7TO6HhiY=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Jul 2025 14:26:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10748363964261664298
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 3/5] drm/rockchip: cdn-dp: Support handle lane info and HPD without extcon
Date: Fri, 18 Jul 2025 14:26:17 +0800
Message-Id: <20250718062619.99-4-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250718062619.99-1-kernel@airkyi.com>
References: <20250718062619.99-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MgfWL/YQZpWPbLmgi8KmaCxOgn85GbPN6a+MriCJECfwqv9Q8ec0wr9f
	9B+/C3TZNYMBRg9dD4Ivptnd/kFY/dO8G8kLxDkqEWkPUE4STw3mp/uiU9dEVsP1EZyIwI4
	Wo8HgOrowOVHJZd6qUj2khhQaoCVETeurrmvQkHOtDx9AtFUQa3PnAtr1N7HaIy40bhtFkv
	G7V76dfyRzRjsS7XB953PorBZi/QpQT6Aj9DulTVZihy7Gmb3GZhgIjA/WfPKzIqNFLcP6g
	5uNhP8tl8GcnXQGX90TsQMMF9Mam3kudxvv5lXabVVM8YgoiFGONk0I4umplbhkgZJSFacG
	a4tNLwORMs0eoM8SlCC8+Ai479274HSCpvJNv+bHuGWPycoKR55nQKYKnGKeiNeXC26bJCe
	85KrxEnAlXgUqqKjXsYbMlY2mXJHhLRCXxobfsy6OOZiXgZI5+xOrcEspO0GRiHhkfOxYym
	AmkciVFC4ArxLzaZZUls+SF2SA+Y5AqC9N1gmvaF5MslL96cUDDC9ip8xpAgVdZ0Tk+MA0/
	CfyDsajERz7TsNasugNxlC/JPQ7BDlR/9Sblmb2bHwVYLnAzWWYVuq51LDaqq1b8oH+Ker8
	MaIi9Dc/V/elagkH49f4McfA04JHsI8MDEfR62sNTryfI7C9Mk0vD8kMWQSKTTTPIPYXJoL
	NVuZoolJj6TThxKv50ncCilf9DUI2Q8dIovZWU/Lin4udzsiiWf4IoQ80mZZtFVhhoqfhAx
	uzN78wrpnlGi+X1GUB43BTNevU4I+v7qtIkm0X+efiAkBX1cmLidK8rIkpBaFFwCEbfTzum
	yNr2eOxnW2vMETeYXY6VCfSEYt3DaRr7TRzipikViU75FwarQwZQsn0s5VbDjV40ZB5kVYB
	E2bpvH1k0/2RUEgm5DW39fK2Cj+D2Lb7ilRowyADvpCU7jZgprOQPfN6txsaLftvNbTyxto
	hm0ZuqQb2HObuIkgDvMkwGiCL0J+QFc9blCxgj4UzYhzwjW4/fyJqfkyQpev8XI+X8iiTIu
	3bemNrKQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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



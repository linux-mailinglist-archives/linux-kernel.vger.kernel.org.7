Return-Path: <linux-kernel+bounces-875303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E50C18A90
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D234427E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7B8315786;
	Wed, 29 Oct 2025 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="HN//Psng"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985E314A8F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722193; cv=none; b=LQLqHoiDEx7C28HCYXFs8n58BgWAemIzyaOIcd5mkeIpd5LTyzaJsh2LVJ1ffSN6A7rUFtHf2FAO3lAoELO0deBwIwx1G8nsOvkTFzC1qM1Lgh2oE2Agf6E311BsBIN9jsVkwD4vuNIjGE9lRgbn5dkFQHnxqB9OYENSEabYj9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722193; c=relaxed/simple;
	bh=M4nUEX7h4FeSk6XVEQszUpUpBE3mjUtZPXnyDXgdiFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=B+r7wyxhngotZCSZmMAnxGPnKtNOcNXHLIn4rq1l/xHLH+mXEY0K3RGe/+lLIUBpk6ZCFeIfXllTO1NsDC5059jHsLCBrrme30U3GRu0mDiz+6Ts8+k0i8Wlk/rFXstgviKH0VTTJBoz5Acz67oV1BElMbpTD7pPklCtXhj0368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=HN//Psng; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1761722122;
	bh=nQG0w7dhU7Aew5bKV30plkPn0nBnVdgTnfwSbxYLntU=;
	h=From:To:Subject:Date:Message-Id;
	b=HN//Psng4UWIAXQuItcyhOMHu7Dq+gDdQCi4pOBr2/h0pxW0oUD3mqLm5oJxAQb2/
	 3Dr9I8rgxmXpVyH9f7SrNuUD4YKBWTja56UYiYU0YEELUU/+yMNXPvV/hdmRiDTIo9
	 6agCnidfxv0z5BNWLqVBBX9QzUwWVKopfAySwPcY=
X-QQ-mid: zesmtpsz6t1761722120tb092f96d
X-QQ-Originating-IP: IvyddLy9KbD2cvJM24xB9IzAVzZki3T5MpHuel05bj4=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 29 Oct 2025 15:15:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2981954368563909056
From: Chaoyi Chen <kernel@airkyi.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
Subject: [PATCH v8 07/10] drm/rockchip: cdn-dp: Support handle lane info without extcon
Date: Wed, 29 Oct 2025 15:14:32 +0800
Message-Id: <20251029071435.88-8-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251029071435.88-1-kernel@airkyi.com>
References: <20251029071435.88-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OW8nL0XA5GqlUhPJoOErPUPlgT5YGY1oJwz4RFWOF1nWFluuzq+FKJOv
	2m5x3pEHURyNACWM0xwmzEsvq1mgA3PG7OK1CtVSl5ocgS7Ma8ji0KqksXb1rx8b2DhMdLf
	PNNGnfw63KjILlIF/Ef2A1YP2gjgjwPAi6oyYGMXKygALVIvyHqcgVqszyliI/8IPilgwC1
	w9ugLphYuNlgDcRW2nVHoxcxROg0zJU0rzfMbb4o1OD0kgweWHExvSDp0A7KeGSJOwGYE9y
	mnGekSxw2AUJATY7pEav3PYCeiry2Pmcy1Iikmx4iLorVs2vbul6KeU9puBXcn1gQpd68xa
	fg/XL3pEvPz1CaeUOMGBs/fGD/r97Dt7rQ0QA/DdM0wD3q4Wa81X7/Y1imBwH0BIg+jxJ9h
	GkxaS95+55Dkw1gc7fyOJPaE3JK/4FNV5DYoEWhlV4WeCtHzXgT4+9eo7wDBIwFuWocnF84
	vjht4oKAp6NSdOpXM8DWBCsCBlND1+nlUuwcoo+gPvpOYXolcc88PuzpK5rcIeVPtCp5e+H
	1+4GfkZ7kIcdGg8G1umhrrw5BeW08N2sXDqgY0CPIJFLgjyezxiFKISvQTU6ly+O/666+ye
	WGZ2CDmFh54zE42xnVEe29+cVI0llNgYqrlMV+NiVjkYc/tWzd4sBpHUjrAEK1k8v825Tya
	XOx7zzBYMRL0UYtcr987w4DchMqdWk/BdDRwXh64gmAB3701gTYT7oLnCX/RS2lRK9Vi+SC
	+mmzDBXPbxBW0vdvaWqoJAPhobZw5FASZF2D5U6CeJR3h/h3dlhXWXvLXIccXm7NI0A9znj
	5kHa6074x8MbR8lhFMsVL/8EVFUSi7Tl50DJ/P+P0nuJV+EBVmjPrqzJ1Tgd5J6Y4BhCEq8
	TH1heHdJ9+mDiX0H7n11DSwLeBxE7P3CxsQVeZzgDZDb/D9Z7Yj6wv2XGhivAEsfeibxnhE
	BD2vFtSQIkc4+QtID4XnDKHSjVvBSwQjRXwkIXwTrLpl467yOms1+kxYLHTVfiRluezK6is
	DoZJl5I+FqB51Dn9rD6nQSXK9GXit6YgMkfMVWYw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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



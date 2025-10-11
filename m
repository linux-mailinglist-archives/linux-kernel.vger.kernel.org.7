Return-Path: <linux-kernel+bounces-848974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2429BCEF09
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 159314F64A5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60541D88D7;
	Sat, 11 Oct 2025 03:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="Xh28myMq"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE951EEA5F;
	Sat, 11 Oct 2025 03:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760153608; cv=none; b=DtUf/bMxi2vSVtmtiqDUyw8dOoDtxTw2YKAa+pVSZtTofB0yfQdFm/UXJsq7Zh6jWOPfggf4JAGlCjiTo7lpOU1u65ooJ+eGUo2RkoQcO7NzkJ+FYIg3oB/Me/ZN8wTPD1mwin/oqSNcXXUG+wj/PEvzqaS89JWJofaIIt4rGuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760153608; c=relaxed/simple;
	bh=M4nUEX7h4FeSk6XVEQszUpUpBE3mjUtZPXnyDXgdiFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=i98l1+ip30wA9kDTDEuuZbkOSHzRRAuQSRCNOac49if2VwE3gpcMlvCTF1zf9FKAjhjbA5sabIPaydJb5ueDoih+2K/In7cM1aEGCQXSoSGZpvKKr1XAVlZVlfIgVjzDS2gz1l3X1ajWJGw1cAJrjn7x/w7hzXWcTwL+l7QMpO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=Xh28myMq; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1760153581;
	bh=nQG0w7dhU7Aew5bKV30plkPn0nBnVdgTnfwSbxYLntU=;
	h=From:To:Subject:Date:Message-Id;
	b=Xh28myMqhV9i2CVkS8+rCBcb8w9Fjo+ujmgXLyD8nw1TmDZ3gvnGlIQ6GyYqEIVj3
	 pCBDjI0Sgt6einiW79bKQYyQOPY2h/+XbzYx1Kn1ModeIYwmufAnGUFm4EJH+6DbB0
	 SNsV0QzNpUipMYLt24whCSY2aHBKP/kia3y2Y4mY=
X-QQ-mid: zesmtpgz4t1760153579t96022b44
X-QQ-Originating-IP: Frmd3Nj0ACfLGSy/LlGB4y0vuie5FM7XIF9dzJwwTnM=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 11 Oct 2025 11:32:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15541258530940907442
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
Subject: [PATCH v5 5/8] drm/rockchip: cdn-dp: Support handle lane info without extcon
Date: Sat, 11 Oct 2025 11:32:30 +0800
Message-Id: <20251011033233.97-6-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251011033233.97-1-kernel@airkyi.com>
References: <20251011033233.97-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MTR5disOECbF/ByToAPNP2VJ4AvE4J202c0hfHNWSY+/D/5XeG6iKzop
	KjRKIF2YHyo4Y/fJZhT7huDd4ycSmRzkv+sAzwgt2Jp6QYaNOpcTCwocHTDs8U2sh8+ibFg
	LsRv1qJKjooOdstLYfBMPpti0AEKr8vP4SZpdwPW/Rxxwfeag/9pIVKMKMWFvNB7Yjv4Y/Y
	avAlT/dqYqwqgyAjv3ZDiyi7iqPaUh1g7DgKRC01upA+QIDIQ8SmjROSItwY7KED9XXWNxq
	NwIGaYw/pPxHLAtPRRjZehE+sheL7FELBvGt9ywMs+seSPDMmS/zInac745JWgcpjps6+cR
	9SALbwogujVwJAlXwKrKmoMpslSOyqIeM2VaUhW2U0q9O8jDKi80OilTNAMWs7vfUnyA3o9
	lKykUFFvb+S98Crqxxbej4jaiViPONIkOMKiCGHcPdjGXt1zjjB1sOAMcfslKTULWn9VAam
	9KxghgNzH/dLBpAuYYf4dOtBWQ4RapJqJvqm0s7bOTuckbwkRZSUHFGhYUncjCPddgy19BM
	vTpae9QifQuFEaMjhOpb9JGLowgZ6U2LpD2bfY3bLIwInOU2h5RSYqZG/5AgyLi4yjb11vE
	VLAs7KZSu1qE9SStnVN2I3Q770gJLrcPHe4hUqrsx9EJgcVJYLMuX4/8q/ddRbBaQDgVxb6
	d723aVX6JZn5+jd92DK1TfiF+CtqIS/b349NqmSjIHRLL3zK//xwH6iBbK5h+NtGcsgTF0M
	dg4zO9yGZBHrT0+m7vpEjjI8pajnlt9bIOVW1M1fYiyKiZsTirahECr7k5L1KgUNqgEV9ZF
	v4Ayh24OIdUCrwW1+2ps0XKH6P5kuSrR0lKe/E+cRnveSxE2/L9DRYXCcWSrZrORbO/entB
	4lHUdTgcshzNIpQQ43qXEgfVzmE1rann+ZDhmUaxZhpTxjOsW0z5eYD02cGVT4Knbv3JVCq
	2dvY6xhY95+wkZADDFq5Bqz0b5BO/vz50X62YihJojHVVI27CiYZkTFcHGox4mXFwMH9sJk
	W0BWmF9dR6+KQiZigb
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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



Return-Path: <linux-kernel+bounces-866149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA99BFF03E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A196352546
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE812367B8;
	Thu, 23 Oct 2025 03:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="Bl6Jik6J"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC82DA76D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761190353; cv=none; b=RgTsmV5+3xdJFfHmNYNGOp8LISsmlRdjdGqYK4cI+q+6TO72mQ8Cb9XmZ+2iqBsvtrfT8bq/t9rEfz6QJdBYpwlyDNlQ230fhxHqyDM0K+bC7KbbSFcE2wCbdIln/Mgs36/lASRNGiM42fwJy4L3iZocNRiT0q0rpznW5zNqP0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761190353; c=relaxed/simple;
	bh=M4nUEX7h4FeSk6XVEQszUpUpBE3mjUtZPXnyDXgdiFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Pw2s9avewS0KJcB0xsNHyIFjxm/cuamFvhGH9TIomfLj9uA7JkFr4DywX+mhLRsiAHLEUEqjt8U125stU36iJdVQUnC5xK1/wOtvMDRHABFSsfMmEe5IdGtwOLRJeKKNwnIosDGjOFQFHAM6cV3HFXai0Rj7ijaz6oUkDvuZ90s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=Bl6Jik6J; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1761190256;
	bh=nQG0w7dhU7Aew5bKV30plkPn0nBnVdgTnfwSbxYLntU=;
	h=From:To:Subject:Date:Message-Id;
	b=Bl6Jik6Jxip/hTqiPay47yYQOKK0urbSQ+11av+8o1jdXKbPTwFeWy2ByYb9MANdS
	 q3IhxOhu5V1re2mD+0huqAId/Z7+805LGqrxh3HRvCvbq/7vy0IiTM24aCmGqyjRRQ
	 oain0HVh0EXyaC9aokU+vXoMQ5D2CV3C4CVOUUJU=
X-QQ-mid: esmtpsz16t1761190254t76ee6809
X-QQ-Originating-IP: ry/u4/8KR4C2zosHm3ALD9iejKzqUxaT+ZTDF/OGwF0=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Oct 2025 11:30:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13604929082984056362
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
Subject: [PATCH v7 6/9] drm/rockchip: cdn-dp: Support handle lane info without extcon
Date: Thu, 23 Oct 2025 11:30:06 +0800
Message-Id: <20251023033009.90-7-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251023033009.90-1-kernel@airkyi.com>
References: <20251023033009.90-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N+aOzryTDkdC5TOsXVCC0WKSzV5F98nb9pI8IwZiHMt3xvfr+pGitVZ4
	3l06+XIvSFBbVjWWdoqBF23sQYxAQBo/q8gkxB3OvdRna9WfofjaBfSYJSQa+uNkXT1UAiE
	0tfIhEa9XHDqR2CZRDM8GCVouPV5RNrPTuA1CvhWmA/FDIVOFDB/KfzhVkunwY01Nhz5WKh
	uDArCOSG1pUdR8B5MJijKDyzQ1qrPOMADTpAKAAsG3ocHphE4nDahZELBlfE9CY7oL/ikoS
	rNxSClIqQiKFp3jTEbxOFMhJ5aUeUs5GAsz9jasGqraYRCi1USNYGUCM/d6BHzPLmNaLWKw
	2SuJTq49Rbq/g5o7brJfXMn9wGudqA6jLBk8iwqujqdbXmf4mAFyvwHBC2TR0mvILHw1cGB
	FgvwGbeTE3l1epCVZcjLVby0TDKAVXCIw23RLtvuaoW0DPYreYmW4kGMWOHHPSKTNgSLGzF
	/NVs+B74nde/Jq6l+mA/SzdYJ79MuTauzOqkGxZqd3qzqhSCFqbnAT8A4I5Coc1KUZ2BQEB
	F8I3tKL1HhR+KkZg3I9YaII9WTKpZVsodsXYHhMmWGjWFBfI9jlv9QbdcJZa14XvIWQqAvt
	EObHv+6lGrMo7oPoFDug/K13KtZnYQ01OziWVx769wI8RjqRfiJLC/RUjWe4dxUynfS8Ig5
	8mMCZWopgwK6CpYGHrT+nkKysuJ2IBpJckTl/HHnCQpxpRn7uxHXkUnaUdBLtTbcK+N0jyh
	Va2ZUhxlhF6TH5eA4NG0hLhw+bbwgRag0pXQfzhymvg0EBYwLhXM35SukPIDtzgSCrTISlJ
	iUGptvRAz3Qh/Pr+A0cQ+8Osr1HSlkK9e8bhyKBfku7wKo8nbKq98GSRhAChXiBSirh9lwk
	ngMUlHt+fG0V1ZrjhGc94d7aETWXAf7lL2fMIGi0amDyMGdwHJP6aMmCzQknQ1NRQ9sODUT
	JpbeQIKErwpzCD6n4Yly9f23vN+pGJ7yiKOaekCkW1bkiYWevbe0PEqCdZAY/Mq+VmzCRmH
	jaOTLw/71n6+4XhZahiPb1uMFTWGVyid8AaIroRA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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



Return-Path: <linux-kernel+bounces-866147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A66DFBFF034
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88458353D45
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595E82C0F76;
	Thu, 23 Oct 2025 03:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="Rwkoae0F"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97262BF012
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761190336; cv=none; b=knoKxVqDH37/M1X64uG80fmEHIqzBT/ywTireiScMUO92SH9gGL1xHdm7+hhJsLnig2PGRPcemg8f8YYkhRHNmX8cd4CvHhCpJyBSezGlnYaTHIRqor6J5VrGSZ6kBx++4K2ECmGblRqodGMw0wVlE1JdLXXt3zzBsbuL1V8Exc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761190336; c=relaxed/simple;
	bh=HysgThJSB58INGyifNQGXbmX0lFauL5Bf5bQD741kwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=o2Soaw5P1sOisQYnndctuKqFhh1vmm4oQjuheqcgGhu8bVCz29+iMoKABgl0/j/nkJkqWrDuMRlvjkpE5QVVTX/RnyYgUlfVZOewzvU0hB2FpzO2DjKjvLLjYTcH6QpCWWYA/sBAO9nlXuNzCE3U8QS1DSnFomThKRaFuBphw+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=Rwkoae0F; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1761190250;
	bh=AFQcoHE/dlPx/r75ImuKZ7C8fGQ0d+TgBuYEF1fP98Q=;
	h=From:To:Subject:Date:Message-Id;
	b=Rwkoae0F7jLs4NMnDIsKk4B5emn7Hjk9ujRhKjsp/NpDiOwnhsUPkcZnAy2GKij3f
	 iTDDuBSDOg9t4GeXHDu7ecqaYJm/tgFju2qMcMT2ur4yM80WcpLko7VP+0rBMsRJM+
	 XcYbTCiasx60tdd3GBq8sAWgDfrbgGPDbtm3GtKc=
X-QQ-mid: esmtpsz16t1761190248tddc1db9c
X-QQ-Originating-IP: 79hG5RSiNIqAGUfWumvqMnoN1zJNDnasQCzDIp5dXnM=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Oct 2025 11:30:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1756416242830638748
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
Subject: [PATCH v7 5/9] phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge
Date: Thu, 23 Oct 2025 11:30:05 +0800
Message-Id: <20251023033009.90-6-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251023033009.90-1-kernel@airkyi.com>
References: <20251023033009.90-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MVbvI5amSZ2YjBsber5S6w8cbLdG5azchJryTpxne12o2m8/bPxGcFiK
	ItQxomtF3h1xnIRVgjBRIEdz5ogr7qt2MDbeuWTp8utviuS037yUitZ4jJnTycR/TxNrere
	5+IW8H1en1MMcrsmKAGjXpGsKFYj4FHfotCqpjdhfxfCWEk8GYLnhOYE7QzMDdSR4OT0OZN
	lCpO2K8rzRmf5KaJFsg4/X5OFLdeYxA57LQMOZhoF08lLluR4e9RcpOUEYYOOhv8eEqK7L5
	kCiWkuUixmT4wizV8Dz9CQcBLPuk3P2dtwaxN/7XuKUUBESOraa5OtoJ/+TsCYrNNnqVBtY
	JK9fqotWe/cVHSv+EWRVXZ2wEAxa17st4H4H6G/VWBswNK++7N5Nh5NQsYbGbItoYRrw06x
	ps8iYctDjW9pO+PoAd2BSa7Nh6viPsWvzb8bi59+k2CrhguHeTMJe1mphVr+BZOUh8aOQX6
	MJwCXCpNrPaxdVvDN5CR+mFyo4ELbbR1uzfe6ypA7i30fIWCw6cMHH6bzV6QQpNPxVj1bLk
	hH/cpbuEDWfgcCz4yPhsPeojoxcI/MipPPG2jHWabWK2AQQeJkoYI2Gwip/Du3udBQ0l0VY
	byomHswWk/vUQhF8wPBfzsK2FOFncfuWDij+TbYOGmjigvoy0YHccJ2nY6lLf0S2dKg7cgw
	csnONUymONqX7rotQ0uGg6Sf6AuRkxRW9cjq0K9qCAj+Vc4IFfwIr7Gei4M5vw/XI3RlFiz
	qHjZD273uFjD2BZGLh+62zQ2neXgj0zuUSAxA4Do7mVVCaiNF0ijuR/vfFx+5U1rMkc1ayE
	98YAK34NqbdJlDZ4Rix1PwDtzF4N5G/hgolPREVTmRy5VqEiupWTK19NFztFYgE6ykOv2nw
	b2tq/TyZ5IwT0bRZV6nkAhyfvzh9zITsvcUc7c7Qc275nyAeq6QW6dVgjR4B+bGaG6xKdad
	lBHDuL1QqdqsDEflN4ATAkfTjCI2WAZEHn/pml0jRXZdks8aPU5OABt2FbosLSLK9eaFgeK
	N+oufLORfiR+IsdDA1WEW3xTcR0ERNkme/T7Teag==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Using the DRM_AUX_BRIDGE helper to create the transparent DRM bridge
device.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---

(no changes since v7)

Changes in v6:
- Fix depend in Kconfig. 

 drivers/phy/rockchip/Kconfig              |  2 +
 drivers/phy/rockchip/phy-rockchip-typec.c | 52 +++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index db4adc7c53da..bcb5476222fc 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -120,6 +120,8 @@ config PHY_ROCKCHIP_TYPEC
 	tristate "Rockchip TYPEC PHY Driver"
 	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
 	depends on TYPEC || TYPEC=n
+	depends on DRM || DRM=n
+	select DRM_AUX_BRIDGE if DRM_BRIDGE
 	select EXTCON
 	select GENERIC_PHY
 	select RESET_CONTROLLER
diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index 1f5b4142cbe4..748a6eb8ad95 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -36,6 +36,7 @@
  * orientation, false is normal orientation.
  */
 
+#include <linux/auxiliary_bus.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
@@ -56,6 +57,7 @@
 #include <linux/phy/phy.h>
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_mux.h>
+#include <drm/bridge/aux-bridge.h>
 
 #define CMN_SSM_BANDGAP			(0x21 << 2)
 #define CMN_SSM_BIAS			(0x22 << 2)
@@ -415,6 +417,7 @@ struct rockchip_usb3phy_port_cfg {
 
 struct rockchip_typec_phy {
 	struct device *dev;
+	struct auxiliary_device dp_port_dev;
 	void __iomem *base;
 	struct extcon_dev *extcon;
 	struct typec_mux_dev *mux;
@@ -1299,6 +1302,51 @@ static void tcphy_typec_mux_unregister(void *data)
 	typec_mux_unregister(tcphy->mux);
 }
 
+static void tcphy_dp_port_dev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	of_node_put(adev->dev.of_node);
+}
+
+static void tcphy_dp_port_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static int tcphy_aux_bridge_register(struct rockchip_typec_phy *tcphy, struct device_node *np)
+{
+	struct auxiliary_device *adev = &tcphy->dp_port_dev;
+	int ret;
+
+	adev->name = "dp_port";
+	adev->dev.parent = tcphy->dev;
+	adev->dev.of_node = of_node_get(np);
+	adev->dev.release = tcphy_dp_port_dev_release;
+
+	ret = auxiliary_device_init(adev);
+
+	if (ret) {
+		of_node_put(adev->dev.of_node);
+		return ret;
+	}
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	devm_add_action_or_reset(tcphy->dev, tcphy_dp_port_unregister_adev, adev);
+
+	ret = drm_aux_bridge_register(&adev->dev);
+
+	return 0;
+}
+
 static int tcphy_setup_typec_mux(struct rockchip_typec_phy *tcphy)
 {
 	struct typec_mux_desc mux_desc = {};
@@ -1312,6 +1360,10 @@ static int tcphy_setup_typec_mux(struct rockchip_typec_phy *tcphy)
 	if (!of_property_read_bool(np, "mode-switch"))
 		goto put_np;
 
+	ret = tcphy_aux_bridge_register(tcphy, np);
+	if (ret)
+		goto put_np;
+
 	mux_desc.drvdata = tcphy;
 	mux_desc.fwnode = device_get_named_child_node(tcphy->dev, "dp-port");
 	mux_desc.set = tcphy_typec_mux_set;
-- 
2.49.0



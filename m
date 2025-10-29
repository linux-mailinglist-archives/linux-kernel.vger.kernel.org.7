Return-Path: <linux-kernel+bounces-875298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED58C18A80
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E6942688A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B48830FC38;
	Wed, 29 Oct 2025 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="ZA36WjG8"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163AB30E856
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722178; cv=none; b=iX2jVmVWr66QdEjpHq6plw8QxaPt0rTWbNeRxd9CmxEmCzeCpokkWw+buy0nbZ8g/K4Nk0O58rNFxTEaTtNFQ8IRARVeW82vyAwCYbn7O2EmopNnOHsiecJ/y+SM+3svfcql70CVsrFIjece3/MV67Rsvfs2jB0P8NEbl2M+LQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722178; c=relaxed/simple;
	bh=HysgThJSB58INGyifNQGXbmX0lFauL5Bf5bQD741kwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cmMxMmNderSpzVMfDiVz9+z2pHKS6mFXN00UA4ZJS0IAO8c4vg8UFkZVzOBFpD1Y+RZFmMit8AE6faaEdvzrn5OSZoN0a8sMD1NioLZ0BHomthTmwUCLUCz2mWMHhrRXBn3an0Bmv/D5muHV4e1MkXRRib2DrBA4ugFEN5F0Zis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=ZA36WjG8; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1761722116;
	bh=AFQcoHE/dlPx/r75ImuKZ7C8fGQ0d+TgBuYEF1fP98Q=;
	h=From:To:Subject:Date:Message-Id;
	b=ZA36WjG8lUhyCNfN8X+g6+oiDFK43UsQ+3/VGANeCeklTPe+WntJapcggALLRBnum
	 IgNak6kvYBnXr0xZeJx3q1ZYI3Aj+95IIEFDRH+nhwO+df1mKF8WtE0tV8fCN1PWb+
	 hJzB0GTHs8yd6i3UFkUnh4QYGMRYpeNrr4Av9KXs=
X-QQ-mid: zesmtpsz6t1761722113t4c4a24c5
X-QQ-Originating-IP: WMfK1js/UW7s6StnIpjDkyDreu4Jf2mWtPcMyatS3g4=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 29 Oct 2025 15:15:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14311052351362136618
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
Subject: [PATCH v8 06/10] phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge
Date: Wed, 29 Oct 2025 15:14:31 +0800
Message-Id: <20251029071435.88-7-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251029071435.88-1-kernel@airkyi.com>
References: <20251029071435.88-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NnBlO8MsmACrRff/5IWYDaIcxcnVMxjOCZjMKnz7TA01DAkSJzQId/Gm
	lGe0VHLlyDOkxjAK6l1URU32pwzsHr3NB1Dh8AIFMd9nGrY2ktN/+j7jFCmYdruOGMOVw8x
	BLUmY3dJ0lFuKLCyRSrCbpfVkhzxASwsy5kL5Ob0l8KQDVrM1LWm32VzNzB39Fxi0JxxNul
	/XlP+9TRgWB0JMlnF0AXYHRdHvuU7X484Ua1TjMlzwg7xNkTaAX4sXZQph3Enh1K1o6gXfV
	R1bdh8GF7m4oFZ/pvKE9yLhJlHveepAgYsYt0Jl6WbG8LVitO/L2RdXyL91PPMPMp4IU5cZ
	QZscCQ0mEQINC2s3Xdi3kdnj4z1+Bp4s+BxLT2jE+rd33R/IjdSHCy2p/X2KU1Z1KhWDErM
	rCKlk8WEfi/vtyORRwT3jmQvsnkPvbxiO+J0TRDAK7t6EbKkPa6LjkwN+Y9IV+eFqbxNfl3
	2BaTzahrrWE5rkdYS3ri8jnjMhkTowDNIU+3l7+7EKZY/8Lem5IK5eaoGESpjkutZY86nrE
	wt+yLCLMF9/C8kPAJ/0u7vQJk70vl3bmiyZVkIiKrUBjQ0kqyiRyRKXUaWvFY/tfRj40Tbv
	1vF3Qi05rORYB6QQQ0oem6bUqRfPtml0iW1COO37eOlyMW6m6ev73+f6Zv5Ro+73+WKy/o/
	CnndJlvu9jCC9HP2RlKjik4pw4yMOYOD2j7VHUsdQbNj5lEEFM3nVLQ/zKttuseYAJ77Ibv
	isysfa4ZvcUmNnlQRx+5NDYmgd8QtCEWPooOdyYcaP3PMEBqPQsW9zv3vi4ygRRaTTU1yMv
	U6jXxmC8CmuQeKIFv4OExzv71+g5C9H2ZYHOqqM0E6/PVNvL1dBhUS6M5uP2a2fo0xkB88l
	fU5tU/BSdojyDj7SqZZNbBGCcSriuSSIyd3Ru3s3H2Xq5OIYwS8OPVH8zvRzj0xNMO2b/ql
	oDhuzDOQSndjhTNzTl70Z6opBGTzrORRNJ1O/PhrUm+tav1M8DYaAASvQ2lb5p6332Nir+y
	ba6bF8UagMkIAKQaFGDmL0ktTQ4lYGUrzBmBDRNA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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



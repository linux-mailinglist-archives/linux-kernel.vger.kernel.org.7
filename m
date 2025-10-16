Return-Path: <linux-kernel+bounces-855445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF9DBE1405
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 04:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C87A428887
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC218221F34;
	Thu, 16 Oct 2025 02:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="GPUk5rh7"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDC8214812;
	Thu, 16 Oct 2025 02:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760581726; cv=none; b=qgVSMoJ4h4KhH/V9D50ZTYQEgLqRIQr0mMI3j9IECMt1zylr22XUdccVyT6GJRGVTxKnoqKesFXrZnD6e1v5A6vXFsisuT5SXaKLeixAVqR5SMcN2Vbb/r6o1YyHfbV9b9xZDW9tseMB+/0jHhYJwA7/A5rWRFouifZ/KOch68g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760581726; c=relaxed/simple;
	bh=3IrJq2eY7H58BhtqUIT1x/6vJnGaTeTxDX146pHI90M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=V5hRl3Hx2MjaqP3m0EeEw9KrY+iy5mG9P3dXuxspb1eYmv2MbGz6xsZstvgkm20w0bfbdfh3k0KWEq/Xiwdqo85rHR5o9DxKE83GbevjVVhDA+shL/7YingrfOTvYLe7zNgZUvDiI4JwNqobLxYXhb4KE3fcVnr8KpFo2x3enTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=GPUk5rh7; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1760581695;
	bh=i25gNlDAtw8b5HK1jAZXBoV/IQCgdqvoMWGREg/E/KM=;
	h=From:To:Subject:Date:Message-Id;
	b=GPUk5rh7mMqjgsxEC1/munKSS+h9QPAfQvRACESSoENYcTw5clr8Kpqwis4Zs84un
	 BqpQjvxAM7BY9mzpV92DqVhakILGXv/0EVPWa6Vd9LwYCDsZeCsPhKDNWqPrFwK/RJ
	 YNcJycuncnHwcCF2fW9mG1KTTh/EqwbBiV9nTRkQ=
X-QQ-mid: zesmtpgz1t1760581693tcd70b443
X-QQ-Originating-IP: VcuS+Dxp0BYExURU8Vsw6C9TnS/E0vZwDdscGFf6LgY=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Oct 2025 10:28:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12339062551155621707
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
Subject: [PATCH v6 4/8] phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge
Date: Thu, 16 Oct 2025 10:27:37 +0800
Message-Id: <20251016022741.91-5-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251016022741.91-1-kernel@airkyi.com>
References: <20251016022741.91-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N2bAIxLK0elnxzwM3GPcOMqS01K4312xqBbjR7dK+BPWVl+VPlGReoLj
	vmqTEScDKZK+c5TBsvDAitd/kYLsI22wObvHJVvy3tj06Y+CJKyR6p5Z5qrjCbmB+MssEb6
	aHtodOzYBiJDTeyEIC0O0vPK16rtyOD7Q9Bqs1SQGxNKvHMutOEe8ynVz3vpj2+FatLK0aH
	D/rztYL3jwF/NSKXQBCccgp5lDSS3Dn6oshsODQAsuXLNAem3//0dek5d1YsCApoUwGyxTJ
	E6hQJZGQVwA/PIlO937X/OisBCx3OjruiFZN81s1cosbh1OkuMLnh4GPWKj/q2H3HVJwbeK
	xu82FMZxJI6lfTJTpaRSNeERbfk8npm61zguFRu7gnziYW8gUubJONZGEByqvFHH0iFuQS3
	ni/E00gU2N3qeTAoUm0H4P0DPBc3U5qt1mvJ9X8kJ1fGak8g5Xw1PYWW34mnpLCk3ojwxHI
	XUiUHa5+6crSiOmQz7Ae5EiOq3qRQCHmQXAdQNCnLk3RYcYk2evcCQkL2Q3ljIPNeqFFk9R
	gUzCMog/evEY+kEVVaZFNoRSoesWtUnVv9Fne259q/Dhkgujq+HH6J0V55XAZU2fbPBeuAB
	6Lgtnyfk4yVt60hBSXkfcciiuspqtVQKCtHkN5YB3e1fAND372L9S2Omfi4wykikXc7XPjH
	N7ESDA8Hp+jp8jF0htTBL7MMy9UI/3IZuP0o/33ipUhMOyoZefPcTuLDne5s/mrdn0A8Wvr
	MXI+qV16re9DfWaq6VRGPuWd1O0pd2hSicIrGVPYTiGdo7w2BsBEdPRJY0ONPRNkx4rk2wK
	PwfVcVQJzHwrnGQlA0S4JTbOzVn4D2IV+DPM0AEm00oT0pEz94osWn8o7r5n9SjswkyiwcY
	wXrl1dq9ss1FrImzXqwtLkboJIWsrlKkbmmtrdLSfWsU+VUVkmYB6nKPa6rUgdGRsCv7p9U
	k9wjdvxBbS12bXlxO14XkL5gzpkpTPaxHD0D9lewry8ZumSo+kW5UNlwkGzQn13W71rJZl6
	qHteDqqA==
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



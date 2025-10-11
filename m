Return-Path: <linux-kernel+bounces-848977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E4EBCEF24
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5E4423EE3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B54D347B4;
	Sat, 11 Oct 2025 03:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="ZXOUrBAY"
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4771F09A3;
	Sat, 11 Oct 2025 03:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760153629; cv=none; b=LW2yc37Dx0QuN+t9Gd7NAtPOlzac7HVKFnxVgGutan8VYZvxmsdozEmeD3MVSE3+F1nhXSH7LmhaIsq+8olu6LpJhmu2ccdnJfltmJsOWCNqvkLrkb10zywru6CK8UeoEzuYo407kcIa2ThAc/XWNe2d8v5S3vKK80e+gLhcTjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760153629; c=relaxed/simple;
	bh=BLOArQMb5h21uuWzsT5Q5Cv67c99nGmGeZO3KWSsi6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kUCAxk7NMlcqXTXdImuMLWSO/L08jyE3A734yf3QzCz+5NHC2nNq0YJiaJEouJ5X0pXz2406mVyPz8I6v41DTTwGIbH6KYB+cRH8AonxwbJbF5gzk9H6sVzFzkYANJWOE89WTzXFzoot2p1JqTEgni1tV1YCFQ42da9AbIMuk80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=ZXOUrBAY; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1760153578;
	bh=wwgcFk1rqH+p7dv0YhigDs5nbBu8CmNY3pNEURrA3U4=;
	h=From:To:Subject:Date:Message-Id;
	b=ZXOUrBAYeKL/wI3nrvhpOyFIcldRUbURuP9ta0rgrrLYSK9yVysB7ojFABsOWahE+
	 3x7DF2Ex8jR/ZsxyyV31hxdB6Nt79KJemdwbfgr2mHtQcN/05Gp21HA07g5HOOQp/f
	 ghaiJUvHlgGkLGfR27kBwB3Y9z3PFSdUkr+tbxB8=
X-QQ-mid: zesmtpgz4t1760153576t79eb2061
X-QQ-Originating-IP: MsjTdjXOtbpLDUqFopOqkAaQaYefGgccpSyNy4463zQ=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 11 Oct 2025 11:32:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12447018638261968175
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
Subject: [PATCH v5 4/8] phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge
Date: Sat, 11 Oct 2025 11:32:29 +0800
Message-Id: <20251011033233.97-5-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251011033233.97-1-kernel@airkyi.com>
References: <20251011033233.97-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M5r28j6evhA1DjNe5xof7fEpzgBH7+YwXBpQsupV/KdjDlWywX6w3rR2
	l3p6o/RqLtji8wKAk+T9FKj40Dj89sq1rgoWzG+JvGuVv94TO4JtCBs5ERpSMAul/6NIbp4
	kd1UzYmOq71HMeD3vtwluW4b7guNoE7ICHFy2RfVMgKfYt3FcGfesxcErwCiqPM1HYsMdEc
	IFgvWoSUVgTczLvJnZPJ/rSPdwquHEskJ7dqeavGSdKfLclZykzKYH0sOc7vY5H2fV6uG5V
	3fDkMGdKkuTfWZqRjhTAWroFQGrJFqENgJbICi+hXWE4xtHVrPJcFkXoE1tihlqT4ohE3m/
	5+k7MJ0bGjty9WqlpqHvqaZ32lKMAl/KQrVczVyryLTEQXVn4qmmCb+EpKVI2Nx0+df+S87
	3yG61ghBPs2ImDwnTgFobTYbF7qbQaggXqm7Djnsp0YWdk6qdDtxsjFFBvCGJe6otcyQhbZ
	W27EhFf/nrYSzW2ktqgAYl7REP9f2QC7eb/W8z/O19e5OQuR2UQSuHBPsfMqQQPbx67hXiF
	gGJ9CgF2UaKW4tza/+ZWxc67ksPAl/vEsn2Wmd0HHYIHJr9MckFasPjM2XXNV4ljz0Bdfp5
	UsGMGYKivO+PVhf9khhLpNeM+e1fQ4+LmkWAimhIU4KdvfdWRYlgfgBs9+WS97c0LxQYsyx
	CW1oIMhIJh+KndFdZhWi/1PCjVTl/E1FH6kPbz7WY22qLaxBCsIxAwDB9lIb0b99OcTJDNZ
	UBYfZkZ7LK+E80nNBEtHtE1f7Mv6qCqMaOK7vCET/ldM7uVyGY6HxLR7Q5lDkcn4C6/ddX7
	DrsIGhu/T1Uw/h+smsnuq5M9KXQR19Nh4c0zk3tsq/6PNOWpS55/7sK0wLd6i1O9NPKQcVP
	m8HvBmdVX3usTNA25puY2TEc4Xshjx8ltLqsIu8n+zYbGojb+kbOVzQz9WGhiAeidB+ekxw
	NBKm7wsD9099oiDlJlFP+uAwuwbRqE6Z9JV+Fo301DJmpGCyj79rkK99x721TD2GkaP4+iC
	V68fCLDgfOh+kVZLG1nkD24BOE0g0=
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
 drivers/phy/rockchip/phy-rockchip-typec.c | 52 +++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index 4a1dfa8d65c7..8003a41de5c6 100644
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
@@ -1296,6 +1299,51 @@ static void tcphy_typec_mux_unregister(void *data)
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
@@ -1309,6 +1357,10 @@ static int tcphy_setup_typec_mux(struct rockchip_typec_phy *tcphy)
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



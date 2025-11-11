Return-Path: <linux-kernel+bounces-895211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD84C4D426
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D84E24F92E6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799F4354AD7;
	Tue, 11 Nov 2025 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="eUf5o4VI"
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED2435471E;
	Tue, 11 Nov 2025 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858282; cv=none; b=HapO+KY56mVW3+g3m7ecd5K3frtHcZN92PvNlx+z+FPjbXFkMMfcseRdgQDRRcYqn2n77C5IMpyN7DLMHnijBQDXwHbx4M48jyR+IYbLjJNcWaCNK2PwODdRyy1NTDILygGMsYgL7aSsU1oozGqF8ZRmYlqvEHna9D4b4Y/oq4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858282; c=relaxed/simple;
	bh=Pet5C3nSfDMCbfvoxji0xnrkRGCFNeRfignYldr3uw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uS9c5xwp3B6hSDjJD84VY54E8bgn48Kpn0QvL67TtovTYp2QDJLIuVwnK4nSway5c9Cu1qudjDlZM7nMzf8q6M8nyb0R23OyQryrgJ1aLVFn1TmBsVk0c+kW8cXd5gT3kP8YzE4zm3lyR52MOoZ9AFtWlFrWK3NtJuo9krqu0V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=eUf5o4VI; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1762858269;
	bh=qha7kTMIFWTImkRefy7JrZ1sr78KHWgow87P2iHBbnU=;
	h=From:To:Subject:Date:Message-Id;
	b=eUf5o4VIzzXhPAO3kf4zP7CMdasB8PRcXsT9bAC/dKx/koc3ua87CCYmQurMWOjS2
	 V5TODOxPiwV7RLF/Xrf3M6WPby4xacVrVfmYc+Jv1DGoqeeZcupFfU3QVFjMlJhJ97
	 FnDHYfAK5lSOwKR68Gd1JKQXf9jkJho9DBqo2lmw=
X-QQ-mid: zesmtpsz9t1762858260t14c220c6
X-QQ-Originating-IP: 8yzyQt1WcUQiRY5qQzutWDddM3dqogZr+H0JtzK+Gg8=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Nov 2025 18:50:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16669197487587565882
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
Subject: [PATCH v9 03/10] drm/bridge: Implement generic USB Type-C DP HPD bridge
Date: Tue, 11 Nov 2025 18:50:33 +0800
Message-Id: <20251111105040.94-4-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251111105040.94-1-kernel@airkyi.com>
References: <20251111105040.94-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NPgAY+7cethfznNSp3gZfZmqGADW0pPLxP/H+PmYcc4VPPW25ia2nzZL
	WTwS78ThlXXHHErIL57O0yfomyCd5s7mN24+r44rdQhI3nBQAfKA+N5pQpcBn58apd4nlD9
	cdG5fxQBvysusmFrV7WEbu9h4b8gOIj0cJ6gupR1tL1F2n6J1GHdMGW6O26yWwbJUuziQyn
	AmJiVegax0V1Z3srRKm2cT9XbnQm9/xmgyVpSDWpyWFpfIn5GiVmm5KnyVb6WCQrzO6i/bY
	8v6jRhZuNKb8DTzxh/ELzIMr6bjb6Nx+GLTcc338zY67SM4grsGdTxKgLRP9BtxQdDlDRL3
	u0zqN2hHcxclDKg4S+ES2XBIIgF9mcrL5NesOmISNcaurfJJuUAgze6GN/5E6RIo8cP/PxW
	7HfACNOOf4E4HIFeBeWIq5OFq5MKQx9B3hHtf0oYJhnUahD6yKw5HE6IDbQIm4PUcPZxciZ
	8sRZtj6nq+f3/Rn3hLMJxRDWdpjxOYqmHUmtODmBjSIoWcnQwSBhRhW90LtOSasntuNyyUU
	a7MMc27VOXcTpTzx11EoZOEyPT6vgL/T+n/lJGBd/C7qEORmprg9MgLe0huiRIlJv3i3SJF
	hEFjbHpAANcR6tp1tZP3vfataXBIsbunrMlB5W3Vptts5GoYjxYakiqH6Ix6sOk7kl+Ejrw
	ADm4c5bBnOcA7yAsmkFiilBsMh2Ugi+G4y2sFCDNWAJ8wxsMhdi4/tBk8rsR5q8+pXMJlWm
	f2AWLaeXz5qu1Q02VIKte1YYQBjSw72l9gxNJMQRRmgz5D+/gQCQ+aFRLkrqkttG5XFZoQe
	P2D5358Y4BCaqWC+ZW7lzON3hU8O1NaIBLJMqXGgx12OCUOGyvc9ceQ5V7ULqIeKHrjQ7n4
	7hTZhJKGgU9453wUSki1tlkNxTZpMVy6RvrfrL8kDyJT5jb6jZBt7os1cVhUSkTO3RUll3U
	6Au8zvSCdmdfHdiVu5lkY4JxusGdKR52y7quiq7Ws8LJIx+bQyqSu0bMDbibv3tGAvRSY5b
	7cxTpBV+rjBzQCCYv3FbbMQQFzxdDxE59eMuZq4A==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The HPD function of Type-C DP is implemented through
drm_connector_oob_hotplug_event(). For embedded DP, it is required
that the DRM connector fwnode corresponds to the Type-C port fwnode.

To describe the relationship between the DP controller and the Type-C
port device, we usually using drm_bridge to build a bridge chain.

Now several USB-C controller drivers have already implemented the DP
HPD bridge function provided by aux-hpd-bridge.c, it will build a DP
HPD bridge on USB-C connector port device.

But this requires the USB-C controller driver to manually register the
HPD bridge. If the driver does not implement this feature, the bridge
will not be create.

So this patch implements a generic DP HPD bridge based on
aux-hpd-bridge.c. It will monitor Type-C bus events, and when a
Type-C port device containing the DP svid is registered, it will
create an HPD bridge for it without the need for the USB-C controller
driver to implement it.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---

Changes in v9:
- Remove the exposed DRM_AUX_HPD_BRIDGE option, and select
DRM_AUX_HPD_TYPEC_BRIDGE when it is available.
- Add more commit comment about problem background.

Changes in v8:
- Merge generic DP HPD bridge into one module.

 drivers/gpu/drm/bridge/Kconfig                | 10 ++++
 drivers/gpu/drm/bridge/Makefile               |  1 +
 .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  | 50 +++++++++++++++++++
 3 files changed, 61 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index a250afd8d662..559487aa09a9 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -30,6 +30,16 @@ config DRM_AUX_HPD_BRIDGE
 	  Simple bridge that terminates the bridge chain and provides HPD
 	  support.
 
+if DRM_AUX_HPD_BRIDGE
+config DRM_AUX_HPD_TYPEC_BRIDGE
+	tristate
+	depends on TYPEC || !TYPEC
+	default TYPEC
+	help
+	  Simple bridge that terminates the bridge chain and provides HPD
+	  support. It build bridge on each USB-C connector device node.
+endif
+
 menu "Display Interface Bridges"
 	depends on DRM && DRM_BRIDGE
 
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index c7dc03182e59..a3a0393d2e72 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DRM_AUX_BRIDGE) += aux-bridge.o
 obj-$(CONFIG_DRM_AUX_HPD_BRIDGE) += aux-hpd-bridge.o
+obj-$(CONFIG_DRM_AUX_HPD_TYPEC_BRIDGE) += aux-hpd-typec-dp-bridge.o
 obj-$(CONFIG_DRM_CHIPONE_ICN6211) += chipone-icn6211.o
 obj-$(CONFIG_DRM_CHRONTEL_CH7033) += chrontel-ch7033.o
 obj-$(CONFIG_DRM_CROS_EC_ANX7688) += cros-ec-anx7688.o
diff --git a/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
new file mode 100644
index 000000000000..9cb6a0cb0f0a
--- /dev/null
+++ b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <linux/of.h>
+#include <linux/usb/typec_altmode.h>
+#include <linux/usb/typec_dp.h>
+
+#include <drm/bridge/aux-bridge.h>
+
+static int drm_typec_bus_event(struct notifier_block *nb,
+			       unsigned long action, void *data)
+{
+	struct typec_altmode *alt = (struct typec_altmode *)data;
+
+	if (action != TYPEC_ALTMODE_REGISTERED)
+		goto done;
+
+	if (is_typec_partner(&alt->dev) || alt->svid != USB_TYPEC_DP_SID)
+		goto done;
+
+	/*
+	 * alt->dev.parent->parent : USB-C controller device
+	 * alt->dev.parent         : USB-C connector device
+	 */
+	drm_dp_hpd_bridge_register(alt->dev.parent->parent,
+				   to_of_node(alt->dev.parent->fwnode));
+
+done:
+	return NOTIFY_OK;
+}
+
+static struct notifier_block drm_typec_event_nb = {
+	.notifier_call = drm_typec_bus_event,
+};
+
+static void drm_aux_hpd_typec_dp_bridge_module_exit(void)
+{
+	typec_altmode_unregister_notify(&drm_typec_event_nb);
+}
+
+static int __init drm_aux_hpd_typec_dp_bridge_module_init(void)
+{
+	typec_altmode_register_notify(&drm_typec_event_nb);
+
+	return 0;
+}
+
+module_init(drm_aux_hpd_typec_dp_bridge_module_init);
+module_exit(drm_aux_hpd_typec_dp_bridge_module_exit);
+
+MODULE_DESCRIPTION("DRM TYPEC DP HPD BRIDGE");
+MODULE_LICENSE("GPL");
-- 
2.51.1



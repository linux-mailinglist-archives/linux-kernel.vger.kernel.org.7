Return-Path: <linux-kernel+bounces-866152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C07BFF050
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01F524F1020
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4310A2C0297;
	Thu, 23 Oct 2025 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="OXkT7nnh"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8DF2DC777
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761190362; cv=none; b=ogi5VUDix+jpWOKdaNLBNuKUaQ89KFJZ/JGawjW0hprmCc8MiTgEUWBa9ytofp/dDlFL9uzihaJGkLTBjRlmbQmyFTvWaDZ5BKMzQzQfzI9vnPQQGL4utpwQcofgjWzER+S1hQH8A5VQlZbKBaLGNUnuEg0MRoidjIKYSur4Rps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761190362; c=relaxed/simple;
	bh=VHSKA2HFsM9+jjFn1th+KI+Eh4o3xbpE+Vm5UfGT46M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jP7UqqbKQCH1UcAkmcWNevbzTc3U3wjybINpR087cvLv4ZSePMOl1SRfaNgZO3/I8L6f4IrPwIVj7M4cgcqlVymn9a69n6TB/mTC7O5EwZfvIp1SyOJEuG7iHN3/cfbaphv+YIXsychUfCnrs38WQnNecIJbl9JIxL1uoFKI84s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=OXkT7nnh; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1761190234;
	bh=umNcsJfQXn20u9b8R1M4KUZg1ShG0gK3GbHIbkBThtI=;
	h=From:To:Subject:Date:Message-Id;
	b=OXkT7nnhBVPpNBUhTmED0A8BDwM39R6EvAktks43nN8Htg5clFG0Nac3yuGHSjq4h
	 msBCY1Fnag+1s1uCKTQ5XkTruWcoIJMWHBGT/xsrKMkNkloTBF+DUFZS7RtREC4STP
	 vm7oD1UdQ5c7a1EU49AaAfVNF/MbW0rR/Pynrzfw=
X-QQ-mid: esmtpsz16t1761190231tebd0ea05
X-QQ-Originating-IP: lmB1WZeKvtf5VM4hJL0jYLeppT9A2VeZOLIbFh5pRJk=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Oct 2025 11:30:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18264625426006429648
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
Subject: [PATCH v7 2/9] drm/bridge: Implement generic USB Type-C DP HPD bridge
Date: Thu, 23 Oct 2025 11:30:02 +0800
Message-Id: <20251023033009.90-3-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251023033009.90-1-kernel@airkyi.com>
References: <20251023033009.90-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MI8xiyr9SLuAXVPvvA1fD2USjttncnOPXxABKJaZLl1ydENCdNmpS63R
	/3diLaEzy1tctr5bPdOlG6ijcyH7URCdTO7f0CgLK30QUnJsul2FUH/Yl61mmhWQrGH2R/C
	3XZQx9IX+QypkmlztuZxvqGhKXgT+S6dl6vGyakfhW7zNdqwAjXdfy6IUv7DvfavhETi/aH
	1E2ov4ryHoZ7pfbG2/Ql64KTxF5sAOoRublXLVqHL7lG/MvsfuW2wupYlgkTfE0xo3c2uWo
	gwD3OTUpQQmil5oXLn8cl4ZvwBsaxjPZmKgcPO9ki17/xN3uve6pU70f7vzTayO+JulfWJJ
	MvnH24f+F9xYo379DYa/xiwJyHY1V9f53hXWpZbphFlEty12+5dfNzEYvnE8gVbupjgF+ZN
	iS9qya1raE0GMR8Uw56f22XYaUatjLH9Ccfk+ZXwnqK1/+wBUKJ4a1dfGJKAyFnawOVJqQn
	4lUQb+jcdCPalhB/Uf34w0duWqIlVhWfBbIAN5uK5uv4UunTvGaeP6U0uxxFPLF2eLbXmcz
	7B0BAPTjdwV9HeQLjeqDXizRGeYmBHZNwLSUcGLR5w0LoqII2CeKD0khkWqyM4TL+9Ue0tF
	6toF7YGbwOlhXRQDTXqmRRk9VKE89ZgmLW6mdGDAwNCFw1bXJ2FtbO8t8WYd7qIsIFU0/T4
	HU5lbyMlMHgQWEmYa3uyZTGjwFx23HM8YQ/iua5i0iGIDs7/Fd+8cR/aqtkkXQ7ffOYv/6g
	vXj0As+FBqvRfoIoNHsdlIZ6VA/4wGidqlN1RB/6X/Tv5cFDi20KAzzvSMpl5s0I6MIFE0U
	rOU7pYiTVWWmIQbza04Z+E+lVPmti/F8uS3j38tyAvnveXB1APrAOhPqZ/FGaP0rQKV3rM9
	9GjC2D9Qy77rCCA3wpP6Pq6FaIWdtQMiwxxD7gYjqBkCq/doN46EvwlSyjUoqngRdAgNi3C
	oGHX/GG55I6wCgreezRdIYkWaheljyOGFgbZ8aR3TLOdsAjAMPCLdmIqNhc+VlXHziButfr
	QWGByxWagGAOyN8dO9zjfqBw5c9z4=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Several USB-C controller drivers have already implemented the DP HPD
bridge function provided by aux-hpd-bridge.c, but there are still
some USB-C controller driver that have not yet implemented it.

This patch implements a generic DP HPD bridge based on aux-hpd-bridge.c,
so that other USB-C controller drivers don't need to implement it again.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 drivers/gpu/drm/bridge/Kconfig                | 11 ++++
 drivers/gpu/drm/bridge/Makefile               |  1 +
 .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  | 51 +++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index b9e0ca85226a..9f31540d3ad8 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -33,6 +33,17 @@ config DRM_AUX_HPD_BRIDGE
 menu "Display Interface Bridges"
 	depends on DRM && DRM_BRIDGE
 
+config DRM_AUX_TYPEC_DP_HPD_BRIDGE
+	tristate "TypeC DP HPD bridge"
+	depends on DRM_BRIDGE && OF && TYPEC
+	select DRM_AUX_HPD_BRIDGE
+	help
+	  Simple USB Type-C DP bridge that terminates the bridge chain and
+	  provides HPD support.
+
+	  If the USB-C controller driver has not implemented this and you need
+	  the DP HPD support, say "Y" or "m" here.
+
 config DRM_CHIPONE_ICN6211
 	tristate "Chipone ICN6211 MIPI-DSI/RGB Converter bridge"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 245e8a27e3fc..e91736829167 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DRM_AUX_BRIDGE) += aux-bridge.o
 obj-$(CONFIG_DRM_AUX_HPD_BRIDGE) += aux-hpd-bridge.o
+obj-$(CONFIG_DRM_AUX_TYPEC_DP_HPD_BRIDGE) += aux-hpd-typec-dp-bridge.o
 obj-$(CONFIG_DRM_CHIPONE_ICN6211) += chipone-icn6211.o
 obj-$(CONFIG_DRM_CHRONTEL_CH7033) += chrontel-ch7033.o
 obj-$(CONFIG_DRM_CROS_EC_ANX7688) += cros-ec-anx7688.o
diff --git a/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
new file mode 100644
index 000000000000..2235b7438fe9
--- /dev/null
+++ b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <linux/of.h>
+#include <linux/usb/typec_altmode.h>
+#include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_notify.h>
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
+	if (alt->svid != USB_TYPEC_DP_SID)
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
+	typec_unregister_notify(&drm_typec_event_nb);
+}
+
+static int __init drm_aux_hpd_typec_dp_bridge_module_init(void)
+{
+	typec_register_notify(&drm_typec_event_nb);
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
2.49.0



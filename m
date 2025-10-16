Return-Path: <linux-kernel+bounces-855441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8CDBE13CF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 04:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 727764E3C28
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034652139C9;
	Thu, 16 Oct 2025 02:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="T73qDtJH"
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CBC946C;
	Thu, 16 Oct 2025 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760581708; cv=none; b=oD7jnGcMUHvfoRPW6cJPMK/lrhU+0DZB4SK4ojnqSXQF8VMcPhTvl3UZYZB2yTuaTVARpH5gKcljb53NFlT5j1STTunRtarGXSkp9KHnY64VY9XX2WcLZq3Rl6IDuaZKcVQf0PkVNUr7L6hXPeUaIo/xhoTq+wuvh0mXZ+XIC5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760581708; c=relaxed/simple;
	bh=UElW6+tvG8/iKEmkoRcs7rVIPtVKGX/BFPBAupTKCEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=m3Coe+TXTli2VAG4PBNhYOD7dLxEw2lXHnEPrZ0OIgwTRreYpGYKxLa3JCQNSz8hsILStFqk7Z3+5ArCLM3VtFvOsE9YC6qVR62N47lp9gmc3+aExZ4Ro7DT30B5wgDylomwMBVs5MQugkFnT6fet1/dHyG6GtwFPVKP5AfwsuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=T73qDtJH; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1760581684;
	bh=AlMiAnu04or0UGQaGW/qka23taZ4VUW7EHDn8WHbWS4=;
	h=From:To:Subject:Date:Message-Id;
	b=T73qDtJHdvfokrryu399G/b1QyU4IUWOoEfIlyCt1PiFhmANDZUv4tXuhqZPLSbDi
	 3BrIU4YMNDkJpplWc+mEe1KPjO8JVIUrW1aeiPt9grdHfjyhFIzyZZLVuMAP23wuW/
	 5f1iPtTTRiKbSGP6yaW7kJW/WwlohoGCi9gt24wc=
X-QQ-mid: zesmtpgz1t1760581683t6699f087
X-QQ-Originating-IP: dRL8Fgzddpf7C4ifv6ilM/yZbCupdu3op2UO1npiUEE=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Oct 2025 10:28:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4592435285348485794
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
Subject: [PATCH v6 1/8] usb: typec: Add default HPD device when register DisplayPort altmode
Date: Thu, 16 Oct 2025 10:27:34 +0800
Message-Id: <20251016022741.91-2-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251016022741.91-1-kernel@airkyi.com>
References: <20251016022741.91-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NENrrmtYLi890+bHytffGpEWHX0V0f8DHxBLmeek2iRAzA6N7CwxZuJE
	Xm+mYNomYPGRw0299yrm0+uOm8OOo7MToqEo2XlWweAwpIKFwawwLVxpu8q4W5QMSYeL6sU
	WiqSNJxHA+FDJqBkEmfdR8i9+61ULclvTX+qpR+j14KaP0ssEFY63aohfnlu85MloxxOta+
	ZFG7BJ0L0Y7jhQKSCdObIws8YiAeEzQWeZLGXo+/o/uICUod8lU0mEIfzdP82nxPD0tuWSc
	7Y5v6PDjIzqS1zv+kGLn+Qzd10N+Qvmk0AymVr1W3nKFNkIC9KcDB9qcp9f/qZ5uB6VV2vf
	amugJ6lG5KqQPdpdC4p+A9gLnM2OCR2Owsv5/xprtTNmdJ41ufio5dDiZ6mBJQUUX0KtW3O
	d7xQy3gAI9dQXfvDh1vcvdaWVX9ir+MDMI4XY9D7fIIjq/llhf/9mNAf3Rcg8vLSiXPW/X1
	PuCJFFm+q9Z8d2CSeMXW+Z8j+re1EUt0zqvlDp91aH8JoZ+FbKz0WQmKmof3IkueybC8BO1
	hVjzbcxyxMJhzoekEWPT0ZdakJwpJZHijv3CX8Zr9OIyKj2095HCfih+hmyZ4qM5z5IwHki
	oGIdJ3lNqgfBjUpjObpNZHW/2j2giP7uaEsiazX0bKBkDpPIyzdamR/TLQlkZPaDapXJxBc
	Vlht+kDqGz9erALgV5QePZqbixn+KuRHNS+xCL/ulDxR9tGykYyi+qKsFLxhgQhZKtM2IiQ
	xQTVIHfIvTnfUmryV7+762kftwD3DGZ9aJa3QkkMyUM+U4D27PRadIUaqwU476kgytEPuoh
	y7JRB0GqyCQofdXg8jP+6g1oE5/kxC8ahj4gfJI5QhEfLB2jIQZygRct1D/E5XaXs/w9fAA
	9xrwP0oHiB8u9BRope21qAPsgAAVjsN/s2gqAnYfJh794JYS1tUGz5U71HNIP2O6AlaWDAm
	C4c9JYDlFfjZ4wmVN7Z21xZnGEJgXKehpA3adcWXIfQBoyjylRBztcXt0OiMX+Gmco0CgaD
	I/9I1RapKyvH+Mf7gr
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Add default DRM AUX HPD bridge device when register DisplayPort
altmode. That makes it redundant for each Type-C driver to implement
a similar registration process in embedded scenarios.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---

Changes in v6:
- Fix depend in Kconfig.

Changes in v5:
- Remove the calls related to `drm_aux_hpd_bridge_notify()`.
- Place the helper functions in the same compilation unit.
- Add more comments about parent device.

 drivers/usb/typec/Kconfig         |  2 ++
 drivers/usb/typec/class.c         | 26 ++++++++++++++++++++++++++
 include/linux/usb/typec_altmode.h |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index 2f80c2792dbd..a6730fbb576b 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -2,6 +2,8 @@
 
 menuconfig TYPEC
 	tristate "USB Type-C Support"
+	depends on DRM || DRM=n
+	select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF
 	help
 	  USB Type-C Specification defines a cable and connector for USB where
 	  only one type of plug is supported on both ends, i.e. there will not
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 67a533e35150..e9d7772d1a8f 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -8,14 +8,18 @@
 
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/string_choices.h>
 #include <linux/usb/pd_vdo.h>
+#include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_mux.h>
 #include <linux/usb/typec_retimer.h>
 #include <linux/usb.h>
 
+#include <drm/bridge/aux-bridge.h>
+
 #include "bus.h"
 #include "class.h"
 #include "pd.h"
@@ -538,6 +542,21 @@ const struct device_type typec_altmode_dev_type = {
 	.release = typec_altmode_release,
 };
 
+static void dp_altmode_hpd_device_register(struct typec_altmode *alt)
+{
+	if (alt->svid != USB_TYPEC_DP_SID)
+		return;
+
+	/*
+	 * alt->dev.parent->parent : USB-C controller device
+	 * alt->dev.parent         : USB-C connector device
+	 */
+	alt->hpd_dev = drm_dp_hpd_bridge_register(alt->dev.parent->parent,
+						  to_of_node(alt->dev.parent->fwnode));
+	if (IS_ERR(alt->hpd_dev))
+		alt->hpd_dev = NULL;
+}
+
 static struct typec_altmode *
 typec_register_altmode(struct device *parent,
 		       const struct typec_altmode_desc *desc)
@@ -600,6 +619,13 @@ typec_register_altmode(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
+	/*
+	 * It is too late to register the HPD device when the DisplayPort
+	 * altmode device becomes ready. If the current altmode is DP,
+	 * register a static HPD device.
+	 */
+	dp_altmode_hpd_device_register(&alt->adev);
+
 	return &alt->adev;
 }
 
diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index b3c0866ea70f..acb0af1b9d5d 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -21,6 +21,7 @@ struct typec_altmode_ops;
  * @desc: Optional human readable description of the mode
  * @ops: Operations vector from the driver
  * @cable_ops: Cable operations vector from the driver.
+ * @hpd_dev: HPD device for DisplayPort
  */
 struct typec_altmode {
 	struct device			dev;
@@ -32,6 +33,7 @@ struct typec_altmode {
 	char				*desc;
 	const struct typec_altmode_ops	*ops;
 	const struct typec_cable_ops	*cable_ops;
+	struct device			*hpd_dev;
 };
 
 #define to_typec_altmode(d) container_of(d, struct typec_altmode, dev)
-- 
2.49.0



Return-Path: <linux-kernel+bounces-848972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6239BCEEEB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7A63B7BB7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC70B1E9905;
	Sat, 11 Oct 2025 03:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="vfIhEJ+J"
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADAF347B4;
	Sat, 11 Oct 2025 03:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760153603; cv=none; b=CWxOWYQEiwgEgvmp47mC9QCUzqR7c9oeZFtqaJaskgvEhK1zBFS0Z5X9YHBPXQcjCzUuVQNxgLLKEj8IA7hI/kB2zAiecoZh1HAUyprkX+OPq8GjFF4rmmfSKp50JZeU1Bl/EAByEMG35N8Id0QG+EIw3fVjJiGMc0bjwBei+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760153603; c=relaxed/simple;
	bh=j3Xql/3I0MvnnN19XIMTBrW8tYc6+0mdZZqT+Voym3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nESFLpVrBD0x6GBtjjssT3nq74xS15G57OB2a281yyQYlmymCn1z50COEypX3GqZNzKkqtehG+PSXgKa22+mJQ/6/DnPHAd25zQh5HG/Lb/JcCEJpESqca9y58VPve3fY4uCHBxb30wVYfG2Ck6Og/Pd2hAHh8KUQHkDCXVRF9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=vfIhEJ+J; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1760153568;
	bh=FwncydjEpKrZABF7OX/m91T9YSWh4FrlMTek2hhLtmc=;
	h=From:To:Subject:Date:Message-Id;
	b=vfIhEJ+JICAeJaIlQXqYzPbQRLbafYO/1eJjVFloy46ljo1M4gO9uA5xafpxBG+yJ
	 oatcm6p8F3rdpRzYhFkMfO++sdnK1j6WhS9KYpK5BXVORd8i5fMvKZllTPMa4rHi+H
	 M/ogZ1SuxMYVrFN6jpkW9xe/gE0ooE9tItRsGnD0=
X-QQ-mid: zesmtpgz4t1760153567t933226b5
X-QQ-Originating-IP: pzI+jTj2UtCmWD2N0Oeh+IAPExt3pVROubErMs+KBy4=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 11 Oct 2025 11:32:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8809100551469140614
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
Subject: [PATCH v5 1/8] usb: typec: Add default HPD device when register DisplayPort altmode
Date: Sat, 11 Oct 2025 11:32:26 +0800
Message-Id: <20251011033233.97-2-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251011033233.97-1-kernel@airkyi.com>
References: <20251011033233.97-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Nw9C1WBu09hP4CwqJ7PmBrcHbpQBqn1gKNYpFi6gVRLtKH8ed502wsNo
	vzW3rU/TLC4fPgx4ucwRApMbFP4JoednMHFYF5vu6lMEbPOGaONvuEHK1P9RhMnqkej6k3V
	n0YR8Yk/L6pA+zbOxj5tCDf8dKBDzyc8ueNuirYFQNWtnArLVm7XX210YXOBnTWGSLCkAQA
	CwKxUiMJ396xKABeKMmoDti+NHo1tCu7etHP+ixebUMcJmBizlkWuZn3N1GKVGtHSy2JB6+
	Z/qJ5YT0yoSLU7RgGzvDbS/uLKZW7I5frO/Et5tz4pj/hHTS4v1jODxvacESWVHQHv+W63k
	QwJauWdt97hBt6+Pwf7yV/i56xnHhdHOPM96hpEmRsGyH/w9vnrRSjpS9wFM3is6qLQFLsl
	ltpUPK4h7G4rTsFBu1huilUWP+xgTdE7c5K6tfyXmxftMUByWaHIqk94rqFNSKyd6Uq/wmZ
	js6Ma0Vz+vH/U8GvBaoUhp7pBMsZYpb45ZIj0ZWz28CD5YqgZRBOEijrCOw0NDJz2qFrQim
	gHyMeKQwgwYR8reJeyoM2MHTSJa3wucbvDAoGK4d9dOxM3lhkVDHzWfOJIjPw5JGd04BAVU
	dZo7LvqrfBObYd74uFgS4NqAlrNVCrXrh6i/c4oRPz+CcqhsoFXY4yh+Iui+Kr6OfiydVHL
	r3QNjZRvo4FoMFvr/JsJDvA9nqgOmOfnCqgJgS2LpDGsDjpQ5bLVLan32FOTyZa6FDJd49Z
	hEEIfXLb235aZkxRE0l8u9YCdOgap9r9yO3pK/NmwCT0yUXFJBG9cFPlYdK5Sp/Dqtv/4it
	uoqwcGcL3ofXQanQbO6ica67VgmJR+iQPw8ZjrIIlyVPPHQQJsvXyErWY9ia/DQC8WmPkF9
	nUmYpnwSdC80UqakVuzu4Msexf3krAU3Fc8BTXjo03YotRtRj2qpH7HSdnEfq4Bk3ZUbZKK
	MqT05yJyrRLung+gMnZMUAT9hg8Qz4jjh9sVPdiUXh3d1qg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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

Changes in v5:
- Remove the calls related to `drm_aux_hpd_bridge_notify()`.
- Place the helper functions in the same compilation unit.
- Add more comments about parent device.

 drivers/usb/typec/class.c         | 26 ++++++++++++++++++++++++++
 include/linux/usb/typec_altmode.h |  2 ++
 2 files changed, 28 insertions(+)

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



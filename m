Return-Path: <linux-kernel+bounces-866144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 927F3BFF02D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 789D34E7044
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43D329BDB8;
	Thu, 23 Oct 2025 03:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="fvQh5Rx/"
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D9913D2B2
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761190324; cv=none; b=Zy12Vq+9aLwbpCJUQJZha6Zr066ae6znBfErO7F1czBdKGlaJeu/XdX1xaGtKoeGrtRFzQLzXQvhW4jptxR6Wqaf6kdjcKW9oQ5ArnHRXo2k1sb7MzqVxdD9Esn7CQTwoBZ+fjsV4Th4MmLxxEzKntHfUgCxVbUd6uRKwZW7BMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761190324; c=relaxed/simple;
	bh=Km0tnPpSvB7hKaQPVLRA5Qgjl88/xHP2CenuDJI6+u8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FGDXRsMTHMh1uKG9HFFcUU2TthKeegOywfzctj0AMW9s2mGCo4uOrcrqahwd+d2spREvzI5vytb+ErGcvtWXEtf4399P3IdrLZ1PRcnaSFvLR2TJAwkRXVgeeA+MQHhyiLg/+JdMYKR2iHfNYkebQL8fIZKe/VQvaUmruYfHdSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=fvQh5Rx/; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1761190228;
	bh=z3Z+FuiRydfa9KXtfzUasAoRXAzbkbbUPpgJYhzIq0U=;
	h=From:To:Subject:Date:Message-Id;
	b=fvQh5Rx/qOdUPwL/NmSRGR/O9HBASU/O5L60P0fi0XssvgAV+Y9TPUnGudA584Uxd
	 BbAhG5kwanEqIjneHVpoxEr5qcJ5Ih3idZVeqmdgGPD+b+gbmkv4/md71spaIdtdw2
	 ZCfpaeTMTENtbrIEacWHQlviev0pB0iumuS44X7s=
X-QQ-mid: esmtpsz16t1761190226t700443f6
X-QQ-Originating-IP: CR3cgQmOsWIwA9RJdPHoa1hKzkyO00I9vsk6MHfqamI=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Oct 2025 11:30:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8850868920315239972
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
Subject: [PATCH v7 1/9] usb: typec: Add notifier functions
Date: Thu, 23 Oct 2025 11:30:01 +0800
Message-Id: <20251023033009.90-2-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251023033009.90-1-kernel@airkyi.com>
References: <20251023033009.90-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N9DIJtFs/avns4hvy0i9PlTO1llTc6+s5DYNrWvUUGtIy9BgBfmcWslQ
	1UTPV5mBaQDktx8W5kLRsCl6ibq5kbjHck7obp8QhRFSjAoZt6JUi7p5HQ7spXZN1mHCrJH
	QyNNHkC4cXqKg/ECqvNQ1sqgVJFCz92Eh+6mCtmcw261pLPHY1ZtRvE23Z/I0AKQ+bsSS7U
	o6ocUzGUDM65QCwpfGB4X7goi+A91idEFwsl2wp4Wan6sKZVtHqIaUr0K3MxqFgsi2jZIzs
	i9Q8RINJrcf86xyZxKDRl8rV2SBQAq61jPlPXwikXqyEZS1+cqHvkhB2+h/FSmC+YmefBMa
	2Z8Oy7+F3FvnRQhHa02kww/d6e6RoCQ4T4JF76FNkmGFqfvFHddrygNtIuysC4PUHSuIa4X
	9C14/2XdN86zzv9Qc9/BaqHGC1ubCpogMByZTZ/eGtr9T1r3DdKZFsdO0fpY4Tbm0urdmYc
	XIqjU11npO2M9c5O+yT1L2IN1SE6farad0FJHjhQirZOfY3wKlmaUfuPNQ9B9+KC5BeR3xt
	qVWzH6fQBFRl7cCHrWftcbUaxh8P37Gtrf7JHHa1bUuS9cbwiPG78Dxc1dBbirhvtouJhsy
	DfeC+uG9DauwTI0fcChRtD5NFEGFhs8YuPPIwrTVYfKA9o6gt8oOMLJH3uTzgO+iPhe7mvz
	N5w14N/RzoUcatyc0h4/R16/jl8ZaABi/OTyx7nUR4mKAtsaDrVqC9uHCDVadV+N+Kc/4+/
	YPkpvUER8desoALEvxl3iM/q27iHPd7/nFmXpjMlKUNJoDIjyIjkAC4Cej6omKYVpKgQJqs
	gbLKbX+VdJgTLbYNng2fGaeWFPuoDWESdlw13TW4sUWiqbXkH2el45gEeyh2r42yO5NRxzT
	yyibbI+hs6naBC7N7mXogZ29J0nAoHGJPaRZRI79XUaUlTSFgsMaw4RzlP3cGqAkhEieGGx
	Ofo0AhMtwH7dj5g+OrqhRspGpLlwc6T7KwICTwgiWatNvLnn5iWjDsHVtOXDc7Nl0zVE=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Some other part of kernel may want to know the event of typec bus.

This patch add common notifier function to notify these event.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 drivers/usb/typec/Makefile       |  2 +-
 drivers/usb/typec/class.c        |  3 +++
 drivers/usb/typec/notify.c       | 22 ++++++++++++++++++++++
 include/linux/usb/typec_notify.h | 17 +++++++++++++++++
 4 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/typec/notify.c
 create mode 100644 include/linux/usb/typec_notify.h

diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
index 7a368fea61bc..20d09c5314d7 100644
--- a/drivers/usb/typec/Makefile
+++ b/drivers/usb/typec/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TYPEC)		+= typec.o
-typec-y				:= class.o mux.o bus.o pd.o retimer.o
+typec-y				:= class.o mux.o notify.o bus.o pd.o retimer.o
 typec-$(CONFIG_ACPI)		+= port-mapper.o
 obj-$(CONFIG_TYPEC)		+= altmodes/
 obj-$(CONFIG_TYPEC_TCPM)	+= tcpm/
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 67a533e35150..11c80bc59cda 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -13,6 +13,7 @@
 #include <linux/string_choices.h>
 #include <linux/usb/pd_vdo.h>
 #include <linux/usb/typec_mux.h>
+#include <linux/usb/typec_notify.h>
 #include <linux/usb/typec_retimer.h>
 #include <linux/usb.h>
 
@@ -600,6 +601,8 @@ typec_register_altmode(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
+	typec_notify_event(TYPEC_ALTMODE_REGISTERED, &alt->adev);
+
 	return &alt->adev;
 }
 
diff --git a/drivers/usb/typec/notify.c b/drivers/usb/typec/notify.c
new file mode 100644
index 000000000000..4ae14dd1f461
--- /dev/null
+++ b/drivers/usb/typec/notify.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/notifier.h>
+#include <linux/usb/typec_notify.h>
+
+static BLOCKING_NOTIFIER_HEAD(typec_notifier_list);
+
+int typec_register_notify(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&typec_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(typec_register_notify);
+
+int typec_unregister_notify(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&typec_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(typec_unregister_notify);
+
+void typec_notify_event(unsigned long event, void *data)
+{
+	blocking_notifier_call_chain(&typec_notifier_list, event, data);
+}
diff --git a/include/linux/usb/typec_notify.h b/include/linux/usb/typec_notify.h
new file mode 100644
index 000000000000..a3f1f3b3ae47
--- /dev/null
+++ b/include/linux/usb/typec_notify.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __USB_TYPEC_NOTIFY
+#define __USB_TYPEC_NOTIFY
+
+#include <linux/notifier.h>
+
+enum usb_typec_event {
+	TYPEC_ALTMODE_REGISTERED
+};
+
+int typec_register_notify(struct notifier_block *nb);
+int typec_unregister_notify(struct notifier_block *nb);
+
+void typec_notify_event(unsigned long event, void *data);
+
+#endif /* __USB_TYPEC_NOTIFY */
-- 
2.49.0



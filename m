Return-Path: <linux-kernel+bounces-895209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C08F8C4D3A7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10FF18C161E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B773351FCD;
	Tue, 11 Nov 2025 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="Nk+qfpJ9"
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35669350A3B;
	Tue, 11 Nov 2025 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858274; cv=none; b=hOzxs02wC0OKM8Bsq/k2mwCASuOiX0pdd1nGsF5+X7Q0PE+edhn+U+PaW9EDYKARQUGqH/pwnolX/HLRfRoaX1DBEeQbE7xgftDTYSksx/iDKKKXIdBesuadM6AT2zxpDpsSOcPh3Hjf+pdC7xoGW4kfXVOrJTlF/Kfuz0Jczzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858274; c=relaxed/simple;
	bh=Hph8zBRgkEl5bsXHuqo9OKoVbkY7ij5bPY5xAR4Aii8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mm04R3XUzrOftgVi0QHQgoCiEGIbrfmP6cMZvPGwa3qoP2wPxgo3w0czAoul1LxVGmosii986fuCi2Rzy7gu4LcGa0Ww2QiyQzYERmn/1OX9bkVOqDP+vOBRYfGj9Ef24agDlkOLkkiwCUX2ZuyQ3btHFBvUo7Gd+Nh06OpWJUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=Nk+qfpJ9; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1762858257;
	bh=3KVgbAMLqk9xskfSyH7zcOVwcHIfJ+/kd/q1XTa1m00=;
	h=From:To:Subject:Date:Message-Id;
	b=Nk+qfpJ9ewTcExuBBLpwLuALH30SowqFYwlZAP3IDc65zssyvPZqE8/6CxTOHG3cb
	 2K2nRKVwhJ6iZUnYAG1PocXYwxOehgxHvFyWgvTQ8VB45MtXdsR7rh/nsNmyEgUrSn
	 yR7g1H7S55xBdUFKVbARuQByF7B8rTr5YbPgJkMM=
X-QQ-mid: zesmtpsz9t1762858252t9993007f
X-QQ-Originating-IP: QIEzzurO6Fp6z4rwWPRwhcxu3akUrwReXd3stTEf5Lk=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Nov 2025 18:50:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9719519489223886703
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
Subject: [PATCH v9 01/10] usb: typec: Add notifier functions
Date: Tue, 11 Nov 2025 18:50:31 +0800
Message-Id: <20251111105040.94-2-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251111105040.94-1-kernel@airkyi.com>
References: <20251111105040.94-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NSXtYWcyD5KOJ/WAmZMlCfNWBjpTa1WtLqaVQ8wXYopUPgZro2Xon46a
	XS9sJ99VaNFd72j7fNEVg77lMGY6B4XZKcgA89oNgHqGgJ6SZcKuKCCwjv/NOJFqkq6zxrI
	udyDOrw62QiytuHHy5kNFc9BzSyKqrPsVKtvIdg5tUs2aNhkVqaL8BNqtd7lTAvXXuOUFUj
	cpVnX+LeeaVJfXMDo9cuLTrokssIka8xdlzPoiIkQRKtOopmH79CiPYGyfueJxvINp+8EA8
	y6o8uXInQfJZDZx+DWzXB2zAhFJBo5trnsk6DAINhaeimno2uAG+a7dm/5ESDLrG8+X7PrV
	4QejTTEdG+jcKmce4XJTuK+xGhmxlOe5c0/16QaTK7Zr8IHLr2Mf/E3xPwkLo7g0/35KO6p
	lpArGBBw8A60RG9dTW60oYP//orUmch6137Teobu2An7Kc/aPXM9+PSiF+FL2Fr28Eved1P
	XHlPEUyzTC0TnX+XIQeCYjJCgzGYyxiFYPs9Ky2zCmMP8oSTGsEnMLhsX+PF0JcwKkPOnlX
	3IaRc4FRMi+JdsX5md1SI7nRuKUDXzU8736R5so2TOGRdmGRbnDV3UdeL4RZ8wagqyRer/P
	x7p+mLSeR0G6EdF5/Jvjy377MM5E5SiSQZ0TsTojBe8lbUAI5ID0vtk7peKFPuGlh7fXxwo
	tu1azXCqusTpfhHZAO8ByVDCtNhjqwZZzyPp0FplK8hozV7/gfnsUi72Re8mLOOJLE5hk23
	gqlgCEjpEmUH1dxkK6LWctjyblVUb9VwGdMznFeifY3FpsRoUBy5evhgUGBtve4fO/unaZl
	n9aAkvHfkY8YSvtNMpexAUOeA3tCF+O79H/W7vkWh+KpYJVau/sMB89LRtVUNo29AByCQze
	+R8mG2OFSQQ9dvwfv8q6MoJ+w3BVjEShmC3gyswUuvj5mPzvceWLgKF925LU0h6rbpeEF+F
	nJniIo+PaThCj8KDrwAXau+YEjMaf2kR3X3amp2BBaEJ92M+XclXeQjSlBOpJypkcOsM=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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

Changes in v9:
- Remove redundant header files.

Changes in v8:
- Fix coding style.

 drivers/usb/typec/Makefile        |  2 +-
 drivers/usb/typec/bus.h           |  2 ++
 drivers/usb/typec/class.c         |  2 ++
 drivers/usb/typec/notify.c        | 23 +++++++++++++++++++++++
 include/linux/usb/typec_altmode.h |  9 +++++++++
 5 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/typec/notify.c

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
diff --git a/drivers/usb/typec/bus.h b/drivers/usb/typec/bus.h
index 643b8c81786d..820b59b6d434 100644
--- a/drivers/usb/typec/bus.h
+++ b/drivers/usb/typec/bus.h
@@ -26,6 +26,8 @@ struct altmode {
 	struct altmode			*plug[2];
 };
 
+void typec_notify_event(unsigned long event, void *data);
+
 #define to_altmode(d) container_of(d, struct altmode, adev)
 
 extern const struct bus_type typec_bus;
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 9b2647cb199b..9d2aa3dd3f56 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -600,6 +600,8 @@ typec_register_altmode(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
+	typec_notify_event(TYPEC_ALTMODE_REGISTERED, &alt->adev);
+
 	return &alt->adev;
 }
 
diff --git a/drivers/usb/typec/notify.c b/drivers/usb/typec/notify.c
new file mode 100644
index 000000000000..9e50b54da359
--- /dev/null
+++ b/drivers/usb/typec/notify.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/notifier.h>
+
+#include "bus.h"
+
+static BLOCKING_NOTIFIER_HEAD(typec_notifier_list);
+
+int typec_altmode_register_notify(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&typec_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(typec_altmode_register_notify);
+
+int typec_altmode_unregister_notify(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&typec_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(typec_altmode_unregister_notify);
+
+void typec_notify_event(unsigned long event, void *data)
+{
+	blocking_notifier_call_chain(&typec_notifier_list, event, data);
+}
diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index f7db3bd4c90e..59e20702504b 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -10,6 +10,7 @@
 #define MODE_DISCOVERY_MAX	6
 
 struct typec_altmode_ops;
+struct notifier_block;
 
 /**
  * struct typec_altmode - USB Type-C alternate mode device
@@ -77,6 +78,14 @@ int typec_altmode_notify(struct typec_altmode *altmode, unsigned long conf,
 const struct typec_altmode *
 typec_altmode_get_partner(struct typec_altmode *altmode);
 
+enum usb_typec_event {
+	TYPEC_ALTMODE_REGISTERED,
+	TYPEC_ALTMODE_UNREGISTERED,
+};
+
+int typec_altmode_register_notify(struct notifier_block *nb);
+int typec_altmode_unregister_notify(struct notifier_block *nb);
+
 /**
  * struct typec_cable_ops - Cable alternate mode operations vector
  * @enter: Operations to be executed with Enter Mode Command
-- 
2.51.1



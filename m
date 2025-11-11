Return-Path: <linux-kernel+bounces-895210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C15E0C4D417
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5311B4F9504
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD7135470D;
	Tue, 11 Nov 2025 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="Oh88cWI9"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7F8350D6D;
	Tue, 11 Nov 2025 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858277; cv=none; b=hRNLky3kxMDNa87KTqSwoQCchmjAy3U7qqYAzpJPiWQ9UlkUQIrka/5Zqhzi20fUho8nks46XmTevNT+5nyN9JePg70UFN03iQfUtY9TJtviO9cR1wcTrDIBf9tWg5jYFQ+n99kI0BlXXngOT6N0ugBAfGddbcfH+PsnCbmzOzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858277; c=relaxed/simple;
	bh=saJYASZoDmHvBZigfXZm9m+GDgk6vGp0Z9kz1QpmUow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TXFLFRTJ1Rr0jYUW0mNbmsF9ijNVWNpwvLGTOx6GEzxp7X/XdubT785ZVrZOhH5Nu5rqUySGVdgjmn2QVYpwe+T30UAx2rUS+cQYVA4jTNBEdRVCQzoURBxwPiF5XBzsufz17tU6/EItoMnW+zTnv1hYC5HvjhTsxA5oyebTgBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=Oh88cWI9; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1762858260;
	bh=iH4TyyzlCs63+PYsRRwCgixuDYK1uZRjwAYMJ2JsaAI=;
	h=From:To:Subject:Date:Message-Id;
	b=Oh88cWI9mwcltmI6mzCqokG7anVyG0wGkPHNw9RQkikYJhzW4CK+vpuXosddWOSHr
	 e+raMD5q41iNqHC+rlTnG+MwbJIbV6epzHX4+3j8y6W+lGiy66ah6X/A6VYbJjWnew
	 EoE03dvc5jmkrCQR+kGQrL9DgMBmeH8flH81qzoY=
X-QQ-mid: zesmtpsz9t1762858256t97625740
X-QQ-Originating-IP: uB8mCGoHOoLZ1YWe3fAK9YaOMzLs1IbVHP3rribHjTI=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Nov 2025 18:50:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18215502699769285738
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
Subject: [PATCH v9 02/10] usb: typec: Export all typec device types
Date: Tue, 11 Nov 2025 18:50:32 +0800
Message-Id: <20251111105040.94-3-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251111105040.94-1-kernel@airkyi.com>
References: <20251111105040.94-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M8JnMGwRo1mQ6Zj1L8Z6+mPZz/J9Qctn0KuWzPd7LVH5r/u+chG5HR08
	LFckGIcHBoHG/2ARuCuCTN7wWLmMQyBdBIfultcICgtxbz5r2eaLUGmBz4M0k5z8CRSE1nt
	S3t6u8GZNZTuCK9M+4BjwamDQQkEn6JJ+H81yA8kvlZPO/NZZtdzOea6kLSvN85ttzPgdLj
	IqWyZgnYLbhveOOxy0oB9iBYF3oAE+nJzFHDVyPxZ7fdvm0UVDVjewAssPmJrmtco+DxQ6t
	FnHnoLjEfMfV1qHpK5IFNFAvtYAslZXQGMU5CHFbAEr/yvmEGcC+h5MlU0CzXIgwuzBn4ci
	EQXyjvOc3MMqUmbR+XsS3mTRgDgS8rC7yJrazE8cKxUYfGeDCMyP9x3Ad/Mz00/LdGbQkzb
	NogE8HnXig6JIlxYQp/dWZpTrWaQfiOtpOLMJLEzuB4KW6LsLtzGNzcMm8e973OBgVBcbh9
	IzdYD4OB5TCoKhqyQwUwEAgFfxh+5/MsL7lFOTSgsd35bie8dqnViEjwe/gWG2IEtDiUekQ
	WEy1zIuKtpHftwL3l7UCmCniHMAkppLh4taL3m0nDh5P4udwpIqDjFQ8TaSnOq4dX8EJngd
	kDgnV3V4Awwlqwt5IsnRypVpsMoe73K9P7M78+k8x96nHP+C3Hiim4OQxMr8+xVv2NAxm50
	aKDWNfuTSTavd6k+lIbSHKrOujPHWmU111s6+V1Z3G5Qj0BvoPqPdbGFXROuEAVEBkdvJRb
	QXomNHEIHBVJ3ahrPgZIrGOpcmypBE91VssP+xjUlqAE4RUJXGy0FIm5GS+7ig+Ee+wrn+Y
	exMcwuJrV8U+mG3AqqZ0eKJ3hnNKPI4OL0k09x1PSvHTXSFXQRF7RznkTeDNYbYU4Cxdyxc
	luCcfa9ER/uqspGt6LxVoQwXWNmBNMgTZky4J+cshlD9F+aGHnT8kUeCiZZ6yIOExnG7XM0
	qmIV8SoUs36P3ol9ZqIGSuO5z8lTwdF1f72JtJ9u8PEpHB64P8M8sjBBlog+ZUspTdXU=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Export all typec device types for identification.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---

(no changes since v9)

 drivers/usb/typec/class.c |  4 ++++
 drivers/usb/typec/class.h | 10 ----------
 include/linux/usb/typec.h | 10 ++++++++++
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 9d2aa3dd3f56..449f921acd9c 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -792,6 +792,7 @@ const struct device_type typec_partner_dev_type = {
 	.groups = typec_partner_groups,
 	.release = typec_partner_release,
 };
+EXPORT_SYMBOL_GPL(typec_partner_dev_type);
 
 static void typec_partner_link_device(struct typec_partner *partner, struct device *dev)
 {
@@ -1146,6 +1147,7 @@ const struct device_type typec_plug_dev_type = {
 	.groups = typec_plug_groups,
 	.release = typec_plug_release,
 };
+EXPORT_SYMBOL_GPL(typec_plug_dev_type);
 
 /**
  * typec_plug_set_num_altmodes - Set the number of available plug altmodes
@@ -1294,6 +1296,7 @@ const struct device_type typec_cable_dev_type = {
 	.groups = typec_cable_groups,
 	.release = typec_cable_release,
 };
+EXPORT_SYMBOL_GPL(typec_cable_dev_type);
 
 /**
  * typec_cable_get - Get a reference to the USB Type-C cable
@@ -2033,6 +2036,7 @@ const struct device_type typec_port_dev_type = {
 	.uevent = typec_uevent,
 	.release = typec_release,
 };
+EXPORT_SYMBOL_GPL(typec_port_dev_type);
 
 /* --------------------------------------- */
 /* Driver callbacks to report role updates */
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index db2fe96c48ff..f04f6987bed8 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -87,16 +87,6 @@ struct typec_port {
 #define to_typec_cable(_dev_) container_of(_dev_, struct typec_cable, dev)
 #define to_typec_partner(_dev_) container_of(_dev_, struct typec_partner, dev)
 
-extern const struct device_type typec_partner_dev_type;
-extern const struct device_type typec_cable_dev_type;
-extern const struct device_type typec_plug_dev_type;
-extern const struct device_type typec_port_dev_type;
-
-#define is_typec_partner(dev) ((dev)->type == &typec_partner_dev_type)
-#define is_typec_cable(dev) ((dev)->type == &typec_cable_dev_type)
-#define is_typec_plug(dev) ((dev)->type == &typec_plug_dev_type)
-#define is_typec_port(dev) ((dev)->type == &typec_port_dev_type)
-
 extern const struct class typec_mux_class;
 extern const struct class retimer_class;
 extern const struct class typec_class;
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 309251572e2e..02fed8293415 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -56,6 +56,16 @@ enum typec_role {
 	TYPEC_SOURCE,
 };
 
+extern const struct device_type typec_partner_dev_type;
+extern const struct device_type typec_cable_dev_type;
+extern const struct device_type typec_plug_dev_type;
+extern const struct device_type typec_port_dev_type;
+
+#define is_typec_partner(dev) ((dev)->type == &typec_partner_dev_type)
+#define is_typec_cable(dev) ((dev)->type == &typec_cable_dev_type)
+#define is_typec_plug(dev) ((dev)->type == &typec_plug_dev_type)
+#define is_typec_port(dev) ((dev)->type == &typec_port_dev_type)
+
 static inline int is_sink(enum typec_role role)
 {
 	return role == TYPEC_SINK;
-- 
2.51.1



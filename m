Return-Path: <linux-kernel+bounces-859863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8CEBEECDF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 23:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F4FC4E5ACE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 21:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1631F238C07;
	Sun, 19 Oct 2025 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="z5u6zmGS"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6AF22D7B6;
	Sun, 19 Oct 2025 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760907932; cv=pass; b=MwbuJCRSJJKnjPYGuPlkGJfOK0w3HGEv1Wku0EvNRJ44yoN2z1tL72WXuDx49uBTV2HV6GFBfn7HwM6g5cbj+7VZkUFDNaw68G0KJ1G1ZtyArqbfi4KQiikLFRDejIDRzxngpJzRf1IaqAi3d/4TNXubnVlj/bjWom8eA2xChk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760907932; c=relaxed/simple;
	bh=y8XfVv9LLUcyg0lrce3+MTbM/zQator+qblF5SJiE3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JetwhLHmib4GDREcQucowddvW6/UlS9IhmKoaf+2IGL0mdwyATKk83lJKg343VjSXjZ9xYXnR/KuQNk0oB1SReMiqiRYROXHPzTG69/gLmNSCCnB53bKSf3T0GfqBkGa005tnd9RZjfYeK0BMlrsQdK6VRP0bKZoLY12aa4B2lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=z5u6zmGS; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1760907910; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RwSZV8+D/Klf9v+AAnW9JGkZvC3j1keZvfxg9uhzHvyov1jfBnWne8wXVMHOPW2DDjNtDVPCOSgAmpSUrrnNo9XP9DCpwPFiuyiGi40tADoOkm6xj5pTeORn+0+h4hJCoimizd1CYFS5V/BzjuJ5OIv4kENBdWWlRNnQt5gjuhI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760907910; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BhIp2tdbDW8YVIbRRVL0xruboPT8ZYoMJmZA4xuCPXk=; 
	b=P4ubz2ayRG8RqgbRvaFfyNyLvaSSeP/teYK0DiI3xVsj+TYbzeMQIqNmRy8qcVAdcLygxBFv3fl5gSbwSjXToqmipTuWixXGwvHjctmOwBHVn/tQPOyKWpCgThG4uxR+DXanDBWXv+VnNpZsjuRsClgJ2flVZ6jbQV0p3DG+a7E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760907910;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=BhIp2tdbDW8YVIbRRVL0xruboPT8ZYoMJmZA4xuCPXk=;
	b=z5u6zmGSqTkuaGTyLy7VFAYsmLum9Pb/ivGnxVXtm+YTGQF0PqNApSIbT3TTH/6e
	a4SBjhnyKXBWaJ5RHYTq2KF0REsJuJytlNDrKWVEGP/lkkilc9NB3BjK+5andn5wiru
	RFNL4c1ZOSOwmo8whQ5kmXMhJ+cDkz1XWhvXevuI=
Received: by mx.zohomail.com with SMTPS id 1760907907432613.0884958227238;
	Sun, 19 Oct 2025 14:05:07 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Rong Zhang <i@rong.moe>,
	Guenter Roeck <linux@roeck-us.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH 3/6] platform/x86: lenovo-wmi-capdata: Add support for Capability Data 00
Date: Mon, 20 Oct 2025 05:04:46 +0800
Message-ID: <20251019210450.88830-4-i@rong.moe>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019210450.88830-1-i@rong.moe>
References: <20251019210450.88830-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add support for LENOVO_CAPABILITY_DATA_00 WMI data block that comes on
"Other Mode" enabled hardware. Provides an interface for querying if a
given attribute is supported by the hardware, as well as its default
value.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 .../wmi/devices/lenovo-wmi-other.rst          |  8 +++++++
 drivers/platform/x86/lenovo/wmi-capdata.c     | 23 ++++++++++++++++++-
 drivers/platform/x86/lenovo/wmi-capdata.h     |  8 +++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/wmi/devices/lenovo-wmi-other.rst b/Documentation/wmi/devices/lenovo-wmi-other.rst
index d7928b8dfb4b5..adbd7943c6756 100644
--- a/Documentation/wmi/devices/lenovo-wmi-other.rst
+++ b/Documentation/wmi/devices/lenovo-wmi-other.rst
@@ -31,6 +31,14 @@ under the following path:
 
   /sys/class/firmware-attributes/lenovo-wmi-other/attributes/<attribute>/
 
+LENOVO_CAPABILITY_DATA_00
+-------------------------
+
+WMI GUID ``362A3AFE-3D96-4665-8530-96DAD5BB300E``
+
+The LENOVO-CAPABILITD_DATA_00 interface provides information on whether the
+device supports querying or setting fan speed.
+
 LENOVO_CAPABILITY_DATA_01
 -------------------------
 
diff --git a/drivers/platform/x86/lenovo/wmi-capdata.c b/drivers/platform/x86/lenovo/wmi-capdata.c
index 14175fe19247e..6927de409b09d 100644
--- a/drivers/platform/x86/lenovo/wmi-capdata.c
+++ b/drivers/platform/x86/lenovo/wmi-capdata.c
@@ -5,6 +5,9 @@
  * Lenovo Capability Data provides information on tunable attributes used by
  * the "Other Mode" WMI interface.
  *
+ * Capability Data 00 includes if the attribute is supported by the hardware,
+ * and the default_value. All attributes are independent of thermal modes.
+ *
  * Capability Data 01 includes if the attribute is supported by the hardware,
  * and the default_value, max_value, min_value, and step increment. Each
  * attribute has multiple pages, one for each of the thermal modes managed by
@@ -14,7 +17,7 @@
  *   - Initial implementation (formerly named lenovo-wmi-capdata01)
  *
  * Copyright (C) 2025 Rong Zhang <i@rong.moe>
- *   - Unified implementation
+ *   - Unified implementation for Capability Data 00 and 01
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -36,12 +39,14 @@
 
 #include "wmi-capdata.h"
 
+#define LENOVO_CAPABILITY_DATA_00_GUID "362A3AFE-3D96-4665-8530-96DAD5BB300E"
 #define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3BE018154"
 
 #define ACPI_AC_CLASS "ac_adapter"
 #define ACPI_AC_NOTIFY_STATUS 0x80
 
 enum lwmi_cd_type {
+	LENOVO_CAPABILITY_DATA_00,
 	LENOVO_CAPABILITY_DATA_01,
 };
 
@@ -57,6 +62,7 @@ static const struct lwmi_cd_info {
 	const char *name;
 	enum lwmi_cd_type type;
 } lwmi_cd_table[] = {
+	LWMI_CD_TABLE_ITEM(LENOVO_CAPABILITY_DATA_00),
 	LWMI_CD_TABLE_ITEM(LENOVO_CAPABILITY_DATA_01),
 };
 
@@ -72,6 +78,7 @@ struct cd_list {
 	u8 count;
 
 	union {
+		DECLARE_FLEX_ARRAY(struct capdata00, cd00);
 		DECLARE_FLEX_ARRAY(struct capdata01, cd01);
 	};
 };
@@ -95,6 +102,9 @@ static int lwmi_cd_component_bind(struct device *cd_dev,
 	struct lwmi_cd_binder *binder = data;
 
 	switch (priv->list->type) {
+	case LENOVO_CAPABILITY_DATA_00:
+		binder->cd00_list = priv->list;
+		break;
 	case LENOVO_CAPABILITY_DATA_01:
 		binder->cd01_list = priv->list;
 		break;
@@ -136,6 +146,9 @@ static const struct component_ops lwmi_cd_component_ops = {
 		return -EINVAL;									\
 	}
 
+DEF_LWMI_CDXX_GET_DATA(cd00, LENOVO_CAPABILITY_DATA_00, struct capdata00);
+EXPORT_SYMBOL_NS_GPL(lwmi_cd00_get_data, "LENOVO_WMI_CD");
+
 DEF_LWMI_CDXX_GET_DATA(cd01, LENOVO_CAPABILITY_DATA_01, struct capdata01);
 EXPORT_SYMBOL_NS_GPL(lwmi_cd01_get_data, "LENOVO_WMI_CD");
 
@@ -154,6 +167,10 @@ static int lwmi_cd_cache(struct lwmi_cd_priv *priv)
 	void *p;
 
 	switch (priv->list->type) {
+	case LENOVO_CAPABILITY_DATA_00:
+		p = &priv->list->cd00[0];
+		size = sizeof(priv->list->cd00[0]);
+		break;
 	case LENOVO_CAPABILITY_DATA_01:
 		p = &priv->list->cd01[0];
 		size = sizeof(priv->list->cd01[0]);
@@ -199,6 +216,9 @@ static int lwmi_cd_alloc(struct lwmi_cd_priv *priv, enum lwmi_cd_type type)
 	count = wmidev_instance_count(priv->wdev);
 
 	switch (type) {
+	case LENOVO_CAPABILITY_DATA_00:
+		list_size = struct_size(list, cd00, count);
+		break;
 	case LENOVO_CAPABILITY_DATA_01:
 		list_size = struct_size(list, cd01, count);
 		break;
@@ -346,6 +366,7 @@ static void lwmi_cd_remove(struct wmi_device *wdev)
 	.context = &lwmi_cd_table[_type]
 
 static const struct wmi_device_id lwmi_cd_id_table[] = {
+	{ LWMI_CD_WDEV_ID(LENOVO_CAPABILITY_DATA_00) },
 	{ LWMI_CD_WDEV_ID(LENOVO_CAPABILITY_DATA_01) },
 	{}
 };
diff --git a/drivers/platform/x86/lenovo/wmi-capdata.h b/drivers/platform/x86/lenovo/wmi-capdata.h
index 1e5fce7836cbf..a6f0cb006e745 100644
--- a/drivers/platform/x86/lenovo/wmi-capdata.h
+++ b/drivers/platform/x86/lenovo/wmi-capdata.h
@@ -11,6 +11,12 @@ struct component_match;
 struct device;
 struct cd_list;
 
+struct capdata00 {
+	u32 id;
+	u32 supported;
+	u32 default_value;
+};
+
 struct capdata01 {
 	u32 id;
 	u32 supported;
@@ -21,9 +27,11 @@ struct capdata01 {
 };
 
 struct lwmi_cd_binder {
+	struct cd_list *cd00_list;
 	struct cd_list *cd01_list;
 };
 
+int lwmi_cd00_get_data(struct cd_list *list, u32 attribute_id, struct capdata00 *output);
 int lwmi_cd01_get_data(struct cd_list *list, u32 attribute_id, struct capdata01 *output);
 void lwmi_cd_match_add_all(struct device *master, struct component_match **matchptr);
 
-- 
2.51.0



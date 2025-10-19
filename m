Return-Path: <linux-kernel+bounces-859865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD36BEED00
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 23:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E7A3A2C2B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 21:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C73023EAAB;
	Sun, 19 Oct 2025 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="ABLKUXbX"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B9239E79;
	Sun, 19 Oct 2025 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760907940; cv=pass; b=PiFHLaOEjZQ0AdtuKZfDA236AP0U4l8WP8x2Zj91rDpDIQG2UvARXebJYfIZU9g5Wz+aupRzst8534/o+/O2KCqV3NrR96ltwCvlKDEVoWVehid7BXqT8CxAjFQ0zRuZdVaw5dfqXoy3jpYc4OVEVtnUcdUtDW2Utwkbdv5VHXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760907940; c=relaxed/simple;
	bh=1If2IpgEUuSY0i0LqD5MWN2VRfH2k74qG/d84vMU+xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Om+ocGLFqLC3JH3HaZFOgJA29Z47B/y5ri8V7FUy5Yw/SOiF9mwNdVa95gSjPNwhk3d9k/XlqwpP9RgE5UJiQnw4U1tiyt3z/LrPGI05/uVFv3eo91hIdMT7eT7U32FoMv/RqMFd9WH4+86QHwkbf+oACo8olIppaxXZjS5HeWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=ABLKUXbX; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1760907916; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VFBFaHJ2Wik1uF6cmRn3com95pJUn2sJAMtL7WIp8HUxWyhcc8NcjHkdVTlFC6n44+RBhFfFe8kBVFLIe+VFooxSraI2kGsWJvH9E8j8PIe2ivGDYnxrRrvbVEU2f2JmJeGCzqCOPxvSk7Cx6gqt4d5B/zZmAl1sgZJ0zRPccrk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760907916; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ce+zgvLE06DFHtkJAjiC6HTjBORK3iPZS0TzMHoUQXI=; 
	b=KOHagQAnxlwsNZJtmHQldYX7D6Xfrhv6v6UVgEwPakNr/109i6BCvl89aVHBx1GxZP+UhUhbuMVuJYnROkYy8cpALWlZ4y5FA7jeqf5D/+aP0ZsYQm4+XPJi64A60//JgZdg/9t94w1p6qnjai4iAulFs5RjBmTkQgxqdAaal+4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760907916;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ce+zgvLE06DFHtkJAjiC6HTjBORK3iPZS0TzMHoUQXI=;
	b=ABLKUXbX93Bj7rAEWjr9M7SVZ+JzLyBDx/AeC2dpOhDVFed/B7GX2yuZUvg45DVR
	k0fptjykN3nEGob7Vtb/ejTgDpqE80WukD7Zm2FlnrLNVflOlilNeRoJCKxnczagQp7
	Y8GpRSc9J+4iOOgjcPlUHb9P+cTMnfI7/ChqG08k=
Received: by mx.zohomail.com with SMTPS id 1760907913708259.65175883917107;
	Sun, 19 Oct 2025 14:05:13 -0700 (PDT)
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
Subject: [PATCH 5/6] platform/x86: lenovo-wmi-capdata: Add support for Fan Test Data
Date: Mon, 20 Oct 2025 05:04:48 +0800
Message-ID: <20251019210450.88830-6-i@rong.moe>
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

Add support for LENOVO_FAN_TEST_DATA WMI data block. Provides an
interface for querying the min/max fan speed RPM (reference data) of a
given fan ID.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 .../wmi/devices/lenovo-wmi-other.rst          |  17 +++
 drivers/platform/x86/lenovo/wmi-capdata.c     | 104 +++++++++++++++++-
 drivers/platform/x86/lenovo/wmi-capdata.h     |   8 ++
 3 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/Documentation/wmi/devices/lenovo-wmi-other.rst b/Documentation/wmi/devices/lenovo-wmi-other.rst
index cb6a9bfe5a79e..cca96862ae9c4 100644
--- a/Documentation/wmi/devices/lenovo-wmi-other.rst
+++ b/Documentation/wmi/devices/lenovo-wmi-other.rst
@@ -66,6 +66,13 @@ The following attributes are implemented:
  - ppt_pl2_sppt: Platform Profile Tracking Slow Package Power Tracking
  - ppt_pl3_fppt: Platform Profile Tracking Fast Package Power Tracking
 
+LENOVO_FAN_TEST_DATA
+-------------------------
+
+WMI GUID ``B642801B-3D21-45DE-90AE-6E86F164FB21``
+
+The LENOVO-LENOVO_FAN_TEST_DATA interface provides reference data for self-test
+of cooling fans, including minimum and maximum fan speed RPM.
 
 WMI interface description
 =========================
@@ -119,3 +126,13 @@ data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
     [WmiDataId(3), read, Description("Data Size.")] uint32 DataSize;
     [WmiDataId(4), read, Description("Default Value"), WmiSizeIs("DataSize")] uint8 DefaultValue[];
   };
+
+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("Definition of Fan Test Data"), guid("{B642801B-3D21-45DE-90AE-6E86F164FB21}")]
+  class LENOVO_FAN_TEST_DATA {
+    [key, read] string InstanceName;
+    [read] boolean Active;
+    [WmiDataId(1), read, Description("Mode.")] uint32 NumOfFans;
+    [WmiDataId(2), read, Description("Fan ID."), WmiSizeIs("NumOfFans")] uint32 FanId[];
+    [WmiDataId(3), read, Description("Maximum Fan Speed."), WmiSizeIs("NumOfFans")] uint32 FanMaxSpeed[];
+    [WmiDataId(4), read, Description("Minumum Fan Speed."), WmiSizeIs("NumOfFans")] uint32 FanMinSpeed[];
+  };
diff --git a/drivers/platform/x86/lenovo/wmi-capdata.c b/drivers/platform/x86/lenovo/wmi-capdata.c
index 6927de409b09d..c861f2dd75c32 100644
--- a/drivers/platform/x86/lenovo/wmi-capdata.c
+++ b/drivers/platform/x86/lenovo/wmi-capdata.c
@@ -13,11 +13,15 @@
  * attribute has multiple pages, one for each of the thermal modes managed by
  * the Gamezone interface.
  *
+ * Fan Test Data includes the max/min fan speed RPM for each fan. This is
+ * reference data for self-test. If the fan is in good condition, it is capable
+ * to spin faster than max RPM or slower than min RPM.
+ *
  * Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
  *   - Initial implementation (formerly named lenovo-wmi-capdata01)
  *
  * Copyright (C) 2025 Rong Zhang <i@rong.moe>
- *   - Unified implementation for Capability Data 00 and 01
+ *   - Unified implementation for Capability Data 00/01 and Fan Test Data
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -41,6 +45,7 @@
 
 #define LENOVO_CAPABILITY_DATA_00_GUID "362A3AFE-3D96-4665-8530-96DAD5BB300E"
 #define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3BE018154"
+#define LENOVO_FAN_TEST_DATA_GUID "B642801B-3D21-45DE-90AE-6E86F164FB21"
 
 #define ACPI_AC_CLASS "ac_adapter"
 #define ACPI_AC_NOTIFY_STATUS 0x80
@@ -48,6 +53,7 @@
 enum lwmi_cd_type {
 	LENOVO_CAPABILITY_DATA_00,
 	LENOVO_CAPABILITY_DATA_01,
+	LENOVO_FAN_TEST_DATA,
 };
 
 #define LWMI_CD_TABLE_ITEM(_type)		\
@@ -64,6 +70,7 @@ static const struct lwmi_cd_info {
 } lwmi_cd_table[] = {
 	LWMI_CD_TABLE_ITEM(LENOVO_CAPABILITY_DATA_00),
 	LWMI_CD_TABLE_ITEM(LENOVO_CAPABILITY_DATA_01),
+	LWMI_CD_TABLE_ITEM(LENOVO_FAN_TEST_DATA),
 };
 
 struct lwmi_cd_priv {
@@ -80,6 +87,7 @@ struct cd_list {
 	union {
 		DECLARE_FLEX_ARRAY(struct capdata00, cd00);
 		DECLARE_FLEX_ARRAY(struct capdata01, cd01);
+		DECLARE_FLEX_ARRAY(struct capdata_fan, cd_fan);
 	};
 };
 
@@ -108,6 +116,14 @@ static int lwmi_cd_component_bind(struct device *cd_dev,
 	case LENOVO_CAPABILITY_DATA_01:
 		binder->cd01_list = priv->list;
 		break;
+	case LENOVO_FAN_TEST_DATA:
+		/*
+		 * Do not expose dummy data.
+		 * See also lwmi_cd_fan_list_alloc_cache().
+		 */
+		if (priv->list->count)
+			binder->cd_fan_list = priv->list;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -152,6 +168,9 @@ EXPORT_SYMBOL_NS_GPL(lwmi_cd00_get_data, "LENOVO_WMI_CD");
 DEF_LWMI_CDXX_GET_DATA(cd01, LENOVO_CAPABILITY_DATA_01, struct capdata01);
 EXPORT_SYMBOL_NS_GPL(lwmi_cd01_get_data, "LENOVO_WMI_CD");
 
+DEF_LWMI_CDXX_GET_DATA(cd_fan, LENOVO_FAN_TEST_DATA, struct capdata_fan);
+EXPORT_SYMBOL_NS_GPL(lwmi_cd_fan_get_data, "LENOVO_WMI_CD");
+
 /**
  * lwmi_cd_cache() - Cache all WMI data block information
  * @priv: lenovo-wmi-capdata driver data.
@@ -175,6 +194,9 @@ static int lwmi_cd_cache(struct lwmi_cd_priv *priv)
 		p = &priv->list->cd01[0];
 		size = sizeof(priv->list->cd01[0]);
 		break;
+	case LENOVO_FAN_TEST_DATA:
+		/* Done by lwmi_cd_alloc() => lwmi_cd_fan_list_alloc_cache(). */
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -197,6 +219,78 @@ static int lwmi_cd_cache(struct lwmi_cd_priv *priv)
 	return 0;
 }
 
+/**
+ * lwmi_cd_fan_list_alloc_cache() - Alloc and cache Fan Test Data list
+ * @priv: lenovo-wmi-capdata driver data.
+ * @listptr: Pointer to returned cd_list pointer.
+ *
+ * Return: count of fans found, or an error.
+ */
+static int lwmi_cd_fan_list_alloc_cache(struct lwmi_cd_priv *priv, struct cd_list **listptr)
+{
+	u32 count, *fan_ids, *fan_min_rpms, *fan_max_rpms;
+	union acpi_object *ret_obj __free(kfree) = NULL;
+	struct block { u32 nr; u32 data[]; } *block;
+	struct cd_list *list;
+	size_t size;
+	int idx;
+
+	ret_obj = wmidev_block_query(priv->wdev, 0);
+	if (!ret_obj)
+		return -ENODEV;
+
+	/*
+	 * This is usually caused by a dummy ACPI method. Do not return an error
+	 * as failing to probe this device will result in master driver being
+	 * unbound - this behavior aligns with lwmi_cd_cache().
+	 */
+	if (ret_obj->type != ACPI_TYPE_BUFFER) {
+		count = 0;
+		goto alloc;
+	}
+
+	size = ret_obj->buffer.length;
+	block = (struct block *)ret_obj->buffer.pointer;
+
+	count = size >= sizeof(*block) ? block->nr : 0;
+	if (size < struct_size(block, data, count * 3)) {
+		dev_warn(&priv->wdev->dev,
+			 "incomplete fan test data block: %zu < %zu, ignoring\n",
+			 size, struct_size(block, data, count * 3));
+		count = 0;
+	}
+
+	if (count == 0)
+		goto alloc;
+
+	if (count > U8_MAX) {
+		dev_warn(&priv->wdev->dev,
+			 "too many fans reported: %u > %u, truncating\n",
+			 count, U8_MAX);
+		count = U8_MAX;
+	}
+
+	fan_ids = &block->data[0];
+	fan_max_rpms = &block->data[count];
+	fan_min_rpms = &block->data[count * 2];
+
+alloc:
+	list = devm_kzalloc(&priv->wdev->dev, struct_size(list, cd_fan, count), GFP_KERNEL);
+	if (!list)
+		return -ENOMEM;
+
+	for (idx = 0; idx < count; idx++) {
+		list->cd_fan[idx] = (struct capdata_fan) {
+			.id = fan_ids[idx],
+			.min_rpm = fan_min_rpms[idx],
+			.max_rpm = fan_max_rpms[idx],
+		};
+	}
+
+	*listptr = list;
+	return count;
+}
+
 /**
  * lwmi_cd_alloc() - Allocate a cd_list struct in drvdata
  * @priv: lenovo-wmi-capdata driver data.
@@ -222,6 +316,12 @@ static int lwmi_cd_alloc(struct lwmi_cd_priv *priv, enum lwmi_cd_type type)
 	case LENOVO_CAPABILITY_DATA_01:
 		list_size = struct_size(list, cd01, count);
 		break;
+	case LENOVO_FAN_TEST_DATA:
+		count = lwmi_cd_fan_list_alloc_cache(priv, &list);
+		if (count < 0)
+			return count;
+
+		goto got_list;
 	default:
 		return -EINVAL;
 	}
@@ -230,6 +330,7 @@ static int lwmi_cd_alloc(struct lwmi_cd_priv *priv, enum lwmi_cd_type type)
 	if (!list)
 		return -ENOMEM;
 
+got_list:
 	ret = devm_mutex_init(&priv->wdev->dev, &list->list_mutex);
 	if (ret)
 		return ret;
@@ -368,6 +469,7 @@ static void lwmi_cd_remove(struct wmi_device *wdev)
 static const struct wmi_device_id lwmi_cd_id_table[] = {
 	{ LWMI_CD_WDEV_ID(LENOVO_CAPABILITY_DATA_00) },
 	{ LWMI_CD_WDEV_ID(LENOVO_CAPABILITY_DATA_01) },
+	{ LWMI_CD_WDEV_ID(LENOVO_FAN_TEST_DATA) },
 	{}
 };
 
diff --git a/drivers/platform/x86/lenovo/wmi-capdata.h b/drivers/platform/x86/lenovo/wmi-capdata.h
index a6f0cb006e745..52bc215ac43d8 100644
--- a/drivers/platform/x86/lenovo/wmi-capdata.h
+++ b/drivers/platform/x86/lenovo/wmi-capdata.h
@@ -26,13 +26,21 @@ struct capdata01 {
 	u32 max_value;
 };
 
+struct capdata_fan {
+	u32 id;
+	u32 min_rpm;
+	u32 max_rpm;
+};
+
 struct lwmi_cd_binder {
 	struct cd_list *cd00_list;
 	struct cd_list *cd01_list;
+	struct cd_list *cd_fan_list;
 };
 
 int lwmi_cd00_get_data(struct cd_list *list, u32 attribute_id, struct capdata00 *output);
 int lwmi_cd01_get_data(struct cd_list *list, u32 attribute_id, struct capdata01 *output);
+int lwmi_cd_fan_get_data(struct cd_list *list, u32 attribute_id, struct capdata_fan *output);
 void lwmi_cd_match_add_all(struct device *master, struct component_match **matchptr);
 
 #endif /* !_LENOVO_WMI_CAPDATA_H_ */
-- 
2.51.0



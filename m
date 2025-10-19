Return-Path: <linux-kernel+bounces-859866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AE2BEED01
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 23:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 073D64EC8CC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 21:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B7623AB98;
	Sun, 19 Oct 2025 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="La9QjMIt"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5140D23A995;
	Sun, 19 Oct 2025 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760907942; cv=pass; b=EX/puvGHAqs9tHxlGRGvAagHpQNeBO/TGNnABYtJmR9NfOi96zoNRjp4npe02iwuU/OCla5WPz88vHSP4re4bY0NRRCFuMqVwhP54caltv4P+brlXfxyMnNdcN0UpEdNe2nJz4K2bSHh+phsgssCHd488CNS6fcfgxAoR8+VkjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760907942; c=relaxed/simple;
	bh=s6pqm3zRlTbHHWxcmHvpGQAmgOvd4nI3aEs1DMn+Fqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrNR5phfcqO41dU3AS0GtCurZTpdtDYK0k5whi+IHkZX8Uo5IKPJxqHsQsjXXnrjm6YB0dpi8H7HLWc8VueS9qGobNrxJFZkFYHmS/rTHrq00yjScsj8f0fJdT2jyfkI98nqhqQcMNKo993J8Y/cBlOhBBU9/XCzRagMle706HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=La9QjMIt; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1760907918; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h8RN2ep8QJ+4weax1siLWIVq/KzqolA6KkBlkDTWznLcof3HPmUgPXzGVFqF2uE8xK65gleoQTI0TFaJC2iFARqqEx2FEKPAXHHoX4l0pnrx3wo8A9pyrCkdbwf39tkCdKxgADhE2s/wagg7zmw+dS2ADP83hlvmIVa3s4+5734=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760907918; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=88GnnzyCTjv54tzZiuroylaB6WMz0DKGgfQhhvwTf/M=; 
	b=d4URiw/a8zLnX9PYlYfQ89YHPXN6W5Czx46ydkWNWRqj0hlM+MMeGkEyl16BWe7TeCuXG0DERVKF2JnjNKifmWpnDVttappKGgfnJy4NhMGCkQ3n/y/t61xGN+TM8qeFqZgmUb2RuXisqmp79RouDx5+ECo3Uc55rA8qg8OQP2w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760907918;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=88GnnzyCTjv54tzZiuroylaB6WMz0DKGgfQhhvwTf/M=;
	b=La9QjMItfi60ibKtol96DvuhCQGFjAYfo+jUJyu7Ij5Fv3og/xVxHUqGc1D2oMRX
	kPd4lwsRfwj9o504/XanswOBxQ56oCIAN/9LZOlMRVwiyFSwBFxB+mYPbHDyWSYaZ4Z
	PsRQvdRUNQv3eElTRjmXRuPRFhrOfKSp0FFTE8fw=
Received: by mx.zohomail.com with SMTPS id 1760907916838767.9713060470293;
	Sun, 19 Oct 2025 14:05:16 -0700 (PDT)
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
Subject: [PATCH 6/6] platform/x86: lenovo-wmi-other: Report min/max RPM and hide dummy fans
Date: Mon, 20 Oct 2025 05:04:49 +0800
Message-ID: <20251019210450.88830-7-i@rong.moe>
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

When Fan Test Data is available, make fans without such data invisible
by default (opt-out with option ignore_fan_cap). Besides, report extra
data for reference:

 - fanX_max: maximum RPM
 - fanX_min: minimum RPM

Signed-off-by: Rong Zhang <i@rong.moe>
---
 .../wmi/devices/lenovo-wmi-other.rst          |  2 +
 drivers/platform/x86/lenovo/wmi-other.c       | 74 +++++++++++++++++--
 2 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/Documentation/wmi/devices/lenovo-wmi-other.rst b/Documentation/wmi/devices/lenovo-wmi-other.rst
index cca96862ae9c4..06ee7fe77e6ef 100644
--- a/Documentation/wmi/devices/lenovo-wmi-other.rst
+++ b/Documentation/wmi/devices/lenovo-wmi-other.rst
@@ -34,6 +34,8 @@ under the following path:
 Besides, this driver also exports fan speed RPM to HWMON:
  - fanX_enable: enable/disable the fan (tunable)
  - fanX_input: current RPM
+ - fanX_max: maximum RPM
+ - fanX_min: minimum RPM
  - fanX_target: target RPM (tunable)
 
 LENOVO_CAPABILITY_DATA_00
diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index f8771ed3c6642..aded709c1ba4a 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -14,7 +14,8 @@
  * These attributes typically don't fit anywhere else in the sysfs and are set
  * in Windows using one of Lenovo's multiple user applications.
  *
- * Besides, this driver also exports tunable fan speed RPM to HWMON.
+ * Besides, this driver also exports tunable fan speed RPM to HWMON. Min/max RPM
+ * are also provided for reference when available.
  *
  * Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
  *   - fw_attributes
@@ -22,7 +23,7 @@
  *
  * Copyright (C) 2025 Rong Zhang <i@rong.moe>
  *   - HWMON
- *   - binding to Capability Data 00
+ *   - binding to Capability Data 00 and Fan
  */
 
 #include <linux/acpi.h>
@@ -106,6 +107,7 @@ struct lwmi_om_priv {
 	/* only valid after capdata bind */
 	struct cd_list *cd00_list;
 	struct cd_list *cd01_list;
+	struct cd_list *cd_fan_list;
 
 	struct device *hwmon_dev;
 	struct device *fw_attr_dev;
@@ -116,11 +118,20 @@ struct lwmi_om_priv {
 
 	struct fan_info {
 		u32 supported;
+		long min_rpm;
+		long max_rpm;
 		long target;
 	} fan_info[LWMI_FAN_NR];
 };
 
-/* ======== HWMON (component: lenovo-wmi-capdata 00) ======== */
+static bool ignore_fan_cap;
+module_param(ignore_fan_cap, bool, 0444);
+MODULE_PARM_DESC(ignore_fan_cap,
+	"Ignore fan capdata. "
+	"Results in fans missing from capdata keep visible. "
+	"Effectively disables mix/max fan speed RPM reporting.");
+
+/* ======== HWMON (component: lenovo-wmi-capdata 00 & fan) ======== */
 
 /**
  * lwmi_om_fan_get_set() - Get or set fan RPM value of specified fan
@@ -184,6 +195,12 @@ static umode_t lwmi_om_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_t
 		case hwmon_fan_input:
 			r = priv->fan_info[channel].supported & LWMI_SUPP_MAY_GET;
 			break;
+		case hwmon_fan_min:
+			r = priv->fan_info[channel].min_rpm >= 0;
+			break;
+		case hwmon_fan_max:
+			r = priv->fan_info[channel].max_rpm >= 0;
+			break;
 		}
 	}
 
@@ -233,6 +250,12 @@ static int lwmi_om_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			else
 				*val = priv->fan_info[channel].target;
 			return 0;
+		case hwmon_fan_min:
+			*val = priv->fan_info[channel].min_rpm;
+			return 0;
+		case hwmon_fan_max:
+			*val = priv->fan_info[channel].max_rpm;
+			return 0;
 		}
 	}
 
@@ -271,6 +294,9 @@ static int lwmi_om_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
 					return -EINVAL;
 			} else {
 				/*
+				 * We don't check fan capdata here as it is just
+				 * reference value for self-test.
+				 *
 				 * val > U16_MAX seems safe but meaningless.
 				 */
 				if (val < 0 || val > U16_MAX)
@@ -293,8 +319,10 @@ static int lwmi_om_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
 static const struct hwmon_channel_info * const lwmi_om_hwmon_info[] = {
 	/* Must match LWMI_FAN_NR. */
 	HWMON_CHANNEL_INFO(fan,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET,
-			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET),
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET |
+			   HWMON_F_MIN | HWMON_F_MAX,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET |
+			   HWMON_F_MIN | HWMON_F_MAX),
 	NULL
 };
 
@@ -319,6 +347,7 @@ static const struct hwmon_chip_info lwmi_om_hwmon_chip_info = {
  */
 static int lwmi_om_hwmon_add(struct lwmi_om_priv *priv)
 {
+	struct capdata_fan capdata_fan;
 	struct capdata00 capdata00;
 	int i, err;
 
@@ -330,8 +359,42 @@ static int lwmi_om_hwmon_add(struct lwmi_om_priv *priv)
 
 		priv->fan_info[i] = (struct fan_info) {
 			.supported = capdata00.supported,
+			.min_rpm = -ENODATA,
+			.max_rpm = -ENODATA,
 			.target = -ENODATA,
 		};
+
+		if (!(priv->fan_info[i].supported & LWMI_SUPP_VALID))
+			continue;
+
+		if (ignore_fan_cap) {
+			dev_notice_once(&priv->wdev->dev, "fan capdata ignored\n");
+			continue;
+		}
+
+		if (!priv->cd_fan_list) {
+			dev_notice_once(&priv->wdev->dev, "fan capdata unavailable\n");
+			continue;
+		}
+
+		/*
+		 * Fan attribute from capdata00 may be dummy (i.e.,
+		 * get: constant dummy RPM, set: no-op with retval == 0).
+		 *
+		 * If fan capdata is available and a fan is missing from it,
+		 * make the fan invisible.
+		 */
+		err = lwmi_cd_fan_get_data(priv->cd_fan_list, LWMI_FAN_ID(i), &capdata_fan);
+		if (err) {
+			dev_dbg(&priv->wdev->dev,
+				"fan %d missing from fan capdata, hiding\n",
+				LWMI_FAN_ID(i));
+			priv->fan_info[i].supported = 0;
+			continue;
+		}
+
+		priv->fan_info[i].min_rpm = capdata_fan.min_rpm;
+		priv->fan_info[i].max_rpm = capdata_fan.max_rpm;
 	}
 
 	priv->hwmon_dev = hwmon_device_register_with_info(&priv->wdev->dev, LWMI_OM_HWMON_NAME,
@@ -862,6 +925,7 @@ static int lwmi_om_master_bind(struct device *dev)
 
 	priv->cd00_list = binder.cd00_list;
 	if (priv->cd00_list) {
+		priv->cd_fan_list = binder.cd_fan_list;
 		ret = lwmi_om_hwmon_add(priv);
 		if (ret)
 			return ret;
-- 
2.51.0



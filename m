Return-Path: <linux-kernel+bounces-847450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6F8BCADD5
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 22:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B2FC4F4E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 20:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB31277818;
	Thu,  9 Oct 2025 20:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGQI0j2r"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E3A275852
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043432; cv=none; b=sw8QArvqCED3h7L5PCOT8AqUo+co5JNf2zbDfUtk8Ow+3twWaK9HAmUv05jJRNeW5ml0+BK6G64XgZZrBNcsxPHA/D9miwkeQzfJEWn02GWpgFEqGcwiRCP3UIwpmnUl/XvvvSOMlIIdeJIsQImhqP3hj3AmLrUG8oQf6VL80jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043432; c=relaxed/simple;
	bh=T0PVueyZAQppF4N+039OGDfCHzmf4XUC8Q9rGzQVMC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEjbE3zZV7IkV6tyBKJnB/mEtPgk2D+iSffVkjSQsO8Gj4AktCDL39+OFWPb2C3Yu7swRTax91YbiXdS11V2Rk2+143EozauMa0NQFovsw0Vn6UjkiaInKvdo90h3nG3krNaP1HFWxcNz4n/iVkxwDBnyqlfm3ctn9WXELhYZ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGQI0j2r; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso2813716a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760043430; x=1760648230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBU9CIin0aSQlgiuIOoBqzV8Cr1MkEV15GdrNj0ffJ0=;
        b=bGQI0j2rmNWR5awbzS1re9z5/qYEMGf4sA63zSpiWlS4fP8erLsm9F3onF6BeQoWvb
         RowKu2o6BnpbvNIkxq4EVlA40w4hYbkd8bW8Xnqy8sOKqEfSKGHkDD1nreKfO9A5AsQh
         CSlK3YPemNxlIY3y8wyLCoh4HuQJcqtvjRV7bzY7nI/K5C7eGV2L2pRkhIDjUHYv2ArM
         SiEn+i6M+OldrCUlLg/+gX46iF+6BnrQrqJq+c2VhGprZRGOeXtsGP3hPAv1EK2PhJ1m
         EGbB6gdTwf78izd31ovNLQ4t44/GyujaQHvTukWds4TkbKjwz5xcLwL9ZexKW+KVojd9
         Pm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760043430; x=1760648230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBU9CIin0aSQlgiuIOoBqzV8Cr1MkEV15GdrNj0ffJ0=;
        b=tfKai/frVUMB8Ty3Sj7Zys+HnqlDYX6INKYb3jwMy+rlBQeIjILp6rl1i7qT2j5KBk
         szqeWJbTONQ7xv9eq7mkVCECysx5dpCjbauFqvA1DhH9MWLN1n51cO78+9Ez1Wy4uk87
         muB8yzoft2tjONUgmvoFkfDmSOiNHQzu6/neOppBDvyjvbNTSU3pnC2lv6mqCMIlq6Cg
         NO15oyxf8zwkBUPAY16doOhY3sEVYkO3P2FY2eIiVKf4hVrBbRfgfRAX3c/fW/83Xxhx
         5q8+Z4fhztGZyzR5flJQRiiN+lLVYWgn7P6VfYsXsy/A0UCha2rqbtGrrWHbWZFNv/8i
         zU7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwBdYIc9V+ivcunDV5wdzQ9Tb5lN/F7S971iUSfuveECoT2z/rwjG2NZmsg4Iefvs2M01IlyjL0GN6K8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/hj9u3W1i96/dn1lqSWc3ouWaULJTe9JX5BfRVst1q+BR38YO
	617D272E9hoPsiHdiPzCpqxbo5O7HsgNZw/xJt1OLxV3XYmvmoWlWKpz
X-Gm-Gg: ASbGncvv2caYSWAbpia2TIq+bfkUKyYLHauIf9byCjA5HmYoCR17wM8CD5YlKs6BNWC
	B+VmoYUQ/wQpPxsIxzx/cd1OhmFKFBL1ts/4VMfxLk1Usn0D6aWX+Ce6Bze8gGomY7D+3kxwVtH
	kJcOdjMBcrU4oCNGO1nwwdwuyEwB/nBxCQRpzxZBqGCCNy17eHarqkL12OoAfIFq1rgVItVzadb
	IVq3VGu7pcvvyGV7IArVQczfl0Y+UN3cFAXJUx0/BteBwAjY0Tydw6lgGWtfeoGwfiZUkUuns5q
	KWkwiyhsbjddxmwwlVa/0pVDFq6n/uSyd/yQvK6OZ2UO+u2wh+9asZqL/X3lygGnTISxj0MeFFk
	pRe/lLpugjsj/74LDfn6VYQN7CVbxAWJDX5sxl3LPZWhIzlYrskyARpopCdkdmVo4WzXJ62wREW
	Y/LO0GTSWA5JIlxjLLnIM/840XaOc+erRIw90ZQQc5SrGrMMIcyGuTZmda7Q==
X-Google-Smtp-Source: AGHT+IHl2mOpDKBPpXarWDHHNYXvl1CEg/AVpUbnT9Eoq+n8NtVfEFDOX6JKVLzFZOBNuGomTFB9OQ==
X-Received: by 2002:a17:90b:514e:b0:32d:a37c:4e31 with SMTP id 98e67ed59e1d1-339edadd3bdmr17245338a91.17.1760043429652;
        Thu, 09 Oct 2025 13:57:09 -0700 (PDT)
Received: from cosmo-ubuntu-2404.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61ac8d7fsm787678a91.21.2025.10.09.13.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 13:57:09 -0700 (PDT)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	corbet@lwn.net
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH v2 2/2] hwmon: (pmbus) add driver for MPS MP9945
Date: Fri, 10 Oct 2025 04:54:58 +0800
Message-ID: <20251009205458.396368-2-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009205458.396368-1-chou.cosmo@gmail.com>
References: <20251009205458.396368-1-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for mp9945 device from Monolithic Power Systems, Inc.
(MPS) vendor. This is a single phase digital step down converter.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
v2:
  - Fix build error related to MODULE_IMPORT_NS usage.

 Documentation/hwmon/index.rst  |   1 +
 Documentation/hwmon/mp9945.rst | 117 ++++++++++++++++
 MAINTAINERS                    |   7 +
 drivers/hwmon/pmbus/Kconfig    |   9 ++
 drivers/hwmon/pmbus/Makefile   |   1 +
 drivers/hwmon/pmbus/mp9945.c   | 243 +++++++++++++++++++++++++++++++++
 6 files changed, 378 insertions(+)
 create mode 100644 Documentation/hwmon/mp9945.rst
 create mode 100644 drivers/hwmon/pmbus/mp9945.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 51a5bdf75b08..c75486c9cd4a 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -184,6 +184,7 @@ Hardware Monitoring Kernel Drivers
    mp5920
    mp5990
    mp9941
+   mp9945
    mpq8785
    nct6683
    nct6775
diff --git a/Documentation/hwmon/mp9945.rst b/Documentation/hwmon/mp9945.rst
new file mode 100644
index 000000000000..f406f96efcf9
--- /dev/null
+++ b/Documentation/hwmon/mp9945.rst
@@ -0,0 +1,117 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver mp9945
+=====================
+
+Supported chips:
+
+  * MPS mp9945
+
+    Prefix: 'mp9945'
+
+Author:
+
+	Cosmo Chou <chou.cosmo@gmail.com>
+
+Description
+-----------
+
+This driver implements support for Monolithic Power Systems, Inc. (MPS)
+MP9945 Digital Single-phase Controller.
+
+Device compliant with:
+
+- PMBus rev 1.3 interface.
+
+The driver exports the following attributes via the 'sysfs' files
+for input voltage:
+
+**in1_input**
+
+**in1_label**
+
+**in1_crit**
+
+**in1_crit_alarm**
+
+**in1_lcrit**
+
+**in1_lcrit_alarm**
+
+**in1_max**
+
+**in1_max_alarm**
+
+**in1_min**
+
+**in1_min_alarm**
+
+The driver provides the following attributes for output voltage:
+
+**in2_input**
+
+**in2_label**
+
+**in2_crit**
+
+**in2_crit_alarm**
+
+**in2_lcrit**
+
+**in2_lcrit_alarm**
+
+**in2_min**
+
+**in2_min_alarm**
+
+The driver provides the following attributes for input current:
+
+**curr1_input**
+
+**curr1_label**
+
+**curr1_max**
+
+**curr1_max_alarm**
+
+The driver provides the following attributes for output current:
+
+**curr2_input**
+
+**curr2_label**
+
+**curr2_crit**
+
+**curr2_crit_alarm**
+
+**curr2_max**
+
+**curr2_max_alarm**
+
+The driver provides the following attributes for input power:
+
+**power1_input**
+
+**power1_label**
+
+The driver provides the following attributes for output power:
+
+**power2_input**
+
+**power2_label**
+
+**power2_max**
+
+**power2_max_alarm**
+
+The driver provides the following attributes for temperature:
+
+**temp1_input**
+
+**temp1_crit**
+
+**temp1_crit_alarm**
+
+**temp1_max**
+
+**temp1_max_alarm**
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a27901781c2..0b9835dccb66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17481,6 +17481,13 @@ S:	Maintained
 F:	Documentation/hwmon/mp9941.rst
 F:	drivers/hwmon/pmbus/mp9941.c
 
+MPS MP9945 DRIVER
+M:	Cosmo Chou <chou.cosmo@gmail.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/mp9945.rst
+F:	drivers/hwmon/pmbus/mp9945.c
+
 MR800 AVERMEDIA USB FM RADIO DRIVER
 M:	Alexey Klimov <alexey.klimov@linaro.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index da04ff6df28b..9829c7a37333 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -471,6 +471,15 @@ config SENSORS_MP9941
 	  This driver can also be built as a module. If so, the module will
 	  be called mp9941.
 
+config SENSORS_MP9945
+	tristate "MPS MP9945"
+	help
+	  If you say yes here you get hardware monitoring support for MPS
+	  MP9945.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called mp9945.
+
 config SENSORS_MPQ7932_REGULATOR
 	bool "Regulator support for MPQ7932"
 	depends on SENSORS_MPQ7932 && REGULATOR
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 4c5ff3f32c5e..1629c8b71ac5 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
 obj-$(CONFIG_SENSORS_MP5920)	+= mp5920.o
 obj-$(CONFIG_SENSORS_MP5990)	+= mp5990.o
 obj-$(CONFIG_SENSORS_MP9941)	+= mp9941.o
+obj-$(CONFIG_SENSORS_MP9945)	+= mp9945.o
 obj-$(CONFIG_SENSORS_MPQ7932)	+= mpq7932.o
 obj-$(CONFIG_SENSORS_MPQ8785)	+= mpq8785.o
 obj-$(CONFIG_SENSORS_PLI1209BC)	+= pli1209bc.o
diff --git a/drivers/hwmon/pmbus/mp9945.c b/drivers/hwmon/pmbus/mp9945.c
new file mode 100644
index 000000000000..34822e0de812
--- /dev/null
+++ b/drivers/hwmon/pmbus/mp9945.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Hardware monitoring driver for MPS Single-phase Digital VR Controllers(MP9945)
+ */
+
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include "pmbus.h"
+
+#define MFR_VR_MULTI_CONFIG_R1	0x08
+#define MFR_SVID_CFG_R1		0xBD
+
+/* VOUT_MODE register values */
+#define VOUT_MODE_LINEAR16	0x17
+#define VOUT_MODE_VID		0x21
+#define VOUT_MODE_DIRECT	0x40
+
+#define MP9945_PAGE_NUM		1
+
+#define MP9945_RAIL1_FUNC	(PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | \
+				PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | \
+				PMBUS_HAVE_PIN | PMBUS_HAVE_POUT | \
+				PMBUS_HAVE_TEMP | \
+				PMBUS_HAVE_STATUS_VOUT | \
+				PMBUS_HAVE_STATUS_IOUT | \
+				PMBUS_HAVE_STATUS_TEMP | \
+				PMBUS_HAVE_STATUS_INPUT)
+
+enum mp9945_vout_mode {
+	MP9945_VOUT_MODE_VID,
+	MP9945_VOUT_MODE_DIRECT,
+	MP9945_VOUT_MODE_LINEAR16,
+};
+
+struct mp9945_data {
+	struct pmbus_driver_info info;
+	enum mp9945_vout_mode vout_mode;
+	int vid_resolution;
+	int vid_offset;
+};
+
+#define to_mp9945_data(x) container_of(x, struct mp9945_data, info)
+
+static int mp9945_read_vout(struct i2c_client *client, struct mp9945_data *data)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(client, PMBUS_READ_VOUT);
+	if (ret < 0)
+		return ret;
+
+	ret &= GENMASK(11, 0);
+
+	switch (data->vout_mode) {
+	case MP9945_VOUT_MODE_VID:
+		if (ret > 0)
+			ret = (ret + data->vid_offset) * data->vid_resolution;
+		break;
+	case MP9945_VOUT_MODE_DIRECT:
+		break;
+	case MP9945_VOUT_MODE_LINEAR16:
+		/* LSB: 1000 * 2^-9 (mV) */
+		ret = DIV_ROUND_CLOSEST(ret * 125, 64);
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return ret;
+}
+
+static int mp9945_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
+	if (ret < 0)
+		return ret;
+
+	switch (reg) {
+	case PMBUS_VOUT_MODE:
+		/*
+		 * Override VOUT_MODE to DIRECT as the driver handles custom
+		 * VOUT format conversions internally.
+		 */
+		return PB_VOUT_MODE_DIRECT;
+	default:
+		return -ENODATA;
+	}
+}
+
+static int mp9945_read_word_data(struct i2c_client *client, int page, int phase,
+				 int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct mp9945_data *data = to_mp9945_data(info);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
+	if (ret < 0)
+		return ret;
+
+	switch (reg) {
+	case PMBUS_READ_VOUT:
+		ret = mp9945_read_vout(client, data);
+		break;
+	case PMBUS_VOUT_OV_FAULT_LIMIT:
+	case PMBUS_VOUT_UV_FAULT_LIMIT:
+		ret = i2c_smbus_read_word_data(client, reg);
+		if (ret < 0)
+			return ret;
+
+		/* LSB: 1.95 (mV) */
+		ret = DIV_ROUND_CLOSEST((ret & GENMASK(11, 0)) * 39, 20);
+		break;
+	case PMBUS_VOUT_UV_WARN_LIMIT:
+		ret = i2c_smbus_read_word_data(client, reg);
+		if (ret < 0)
+			return ret;
+
+		ret &= GENMASK(9, 0);
+		if (ret > 0)
+			ret = (ret + data->vid_offset) * data->vid_resolution;
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+
+	return ret;
+}
+
+static int mp9945_identify(struct i2c_client *client,
+			   struct pmbus_driver_info *info)
+{
+	struct mp9945_data *data = to_mp9945_data(info);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, PMBUS_VOUT_MODE);
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
+	case VOUT_MODE_LINEAR16:
+		data->vout_mode = MP9945_VOUT_MODE_LINEAR16;
+		break;
+	case VOUT_MODE_VID:
+		data->vout_mode = MP9945_VOUT_MODE_VID;
+		break;
+	case VOUT_MODE_DIRECT:
+		data->vout_mode = MP9945_VOUT_MODE_DIRECT;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 3);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_word_data(client, MFR_VR_MULTI_CONFIG_R1);
+	if (ret < 0)
+		return ret;
+
+	data->vid_resolution = (FIELD_GET(BIT(2), ret)) ? 5 : 10;
+
+	ret = i2c_smbus_read_word_data(client, MFR_SVID_CFG_R1);
+	if (ret < 0)
+		return ret;
+
+	data->vid_offset = (FIELD_GET(BIT(15), ret)) ? 19 : 49;
+
+	return i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
+}
+
+static struct pmbus_driver_info mp9945_info = {
+	.pages = MP9945_PAGE_NUM,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = direct,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_CURRENT_OUT] = linear,
+	.format[PSC_POWER] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.m[PSC_VOLTAGE_OUT] = 1,
+	.R[PSC_VOLTAGE_OUT] = 3,
+	.b[PSC_VOLTAGE_OUT] = 0,
+	.func[0] = MP9945_RAIL1_FUNC,
+	.read_word_data = mp9945_read_word_data,
+	.read_byte_data = mp9945_read_byte_data,
+	.identify = mp9945_identify,
+};
+
+static int mp9945_probe(struct i2c_client *client)
+{
+	struct mp9945_data *data;
+	int ret;
+
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	memcpy(&data->info, &mp9945_info, sizeof(mp9945_info));
+
+	/*
+	 * Set page 0 before probe. The core reads paged registers which are
+	 * only on page 0 for this device.
+	 */
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
+	if (ret < 0)
+		return ret;
+
+	return pmbus_do_probe(client, &data->info);
+}
+
+static const struct i2c_device_id mp9945_id[] = {
+	{"mp9945"},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mp9945_id);
+
+static const struct of_device_id __maybe_unused mp9945_of_match[] = {
+	{.compatible = "mps,mp9945"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mp9945_of_match);
+
+static struct i2c_driver mp9945_driver = {
+	.driver = {
+		.name = "mp9945",
+		.of_match_table = of_match_ptr(mp9945_of_match),
+	},
+	.probe = mp9945_probe,
+	.id_table = mp9945_id,
+};
+
+module_i2c_driver(mp9945_driver);
+
+MODULE_AUTHOR("Cosmo Chou <chou.cosmo@gmail.com>");
+MODULE_DESCRIPTION("PMBus driver for MPS MP9945");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("PMBUS");
-- 
2.43.0



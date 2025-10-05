Return-Path: <linux-kernel+bounces-842448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B171FBBCC08
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 22:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F95C4E3F8E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 20:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9AC264A92;
	Sun,  5 Oct 2025 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BULN2O6P"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E326463A
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759697474; cv=none; b=W8PxyEB20INUXoFOLcX9EEK6mLVpn18nkdtoKm8t+xG0vaV8MCmAkRft20nrSkIf2EdtVGsvCGDIx6AB5aKhza0Pf6iT2RP4RXf0BpD+fPCd+k//jEdBvJ9P0qmxCKhZ3czhwEnbxPj+c39D8tmxttPzTpuo2PvEckDBol3oYCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759697474; c=relaxed/simple;
	bh=hQu6tR1/EdWyA3EXykpfIO3cH2ZZdDRaBGCNJ9nQj4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Brbh3P5Pk7QMhzAVAcZwJbYzEAKbim24fu25vc6QcMD2Q/iuQOoZpkMJ6p8fwlPTrxldxcUEQc3jVvVtnXIrBRcFyxUH8LBfr4w0k5bqF1YRYtrYxVrfNSwmBYDUoCzg9/W+Ar8rByi6SRqkbC6ANKA/8iD3Bof5uQhpxYm6log=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BULN2O6P; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2698384978dso29760665ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 13:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759697472; x=1760302272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSTXTIJHciew708jLGQ++4MrRZ27YXddQSmSZdIqrdw=;
        b=BULN2O6PwqP2thSjHsBNMaad9Lx7CBMkfU5jeAbwl683WMcW2EhvbywtE5Cp0T2zty
         6tAkvVTiBFkzMDm+316y+PdVUlukcXkqlHCM1xegXB5FJ5WKAU+xZCWgrRUGw00lCKwx
         wwqZN4VdrDRa3FOPTnqy2gY2w3fHqQfHzD+OELm4y8qVlGuzp4Y2kbyPkDeMeLdo/0KO
         Ay2OUsYem1jMqEvpRR3aZQZ3J1Ar0k5oAHBbgbGxsXXuzqQzoKeCXBTH1krjagdUU71v
         r0AOmd3on02801LlC75TV41QrihvgEwVRAcUH2NDqwwqzU+rLy+Dbxqbcw869HcoCMaj
         vHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759697472; x=1760302272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSTXTIJHciew708jLGQ++4MrRZ27YXddQSmSZdIqrdw=;
        b=CLC7T83OraQRGkBIJ8fM9s4FcMjYDPCx3hJEZ3yGnJugBIyXvCiG69KYyePWGW21dM
         Tjar7pBW3eaHsbAXaQIJ9PvIr0FbP3OvOdMopAxfzVsuiQVoDEIj22DZbLO5pOetKH/I
         6s2hYrm+zohTWRllwtD8tr+2MqacnYbMz4D543Xsc3055yebvhVjk8vlrdzSYXe9Ozjj
         F7KWt9nroxpI81QquzW4tu0ZNmJNclGGQ2D9uPo920hAFZ25FN5FeRdcAfNJVaBMpG6j
         M7xdCVWQJk2KmOBwxE6Q/NtgRMDSm4k5UFJy4C33Y7oeJdAXe2og+rlp9hEjdTq6HjKm
         gxCg==
X-Forwarded-Encrypted: i=1; AJvYcCWwRyniiOV4NzpIIgLwcz79iqi4u5s57O4R/h904shM0xLysEMwBjf2ymowGlqmMNdK1I3aIJ0FHdb1dqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGf+I0Gwed3KWWIVuGFz1u37r2els4PnxXawVG62a3qnJk9bhM
	Is07/ghNsQoFHO7YUlUy4dxuAYfMpeXjVgm7YZ7aU2aaTjFi3TMQo6JV
X-Gm-Gg: ASbGncsd4QXBux7qmJz/ZZ2YDd/HfnnlP0C4KH+9ZZRT7bJcU60uu+htU5NDXVgOVZL
	FFL5/riRdMsTrxP8FD5cLHxJCH16KXwPxoNPQgREMsUvUK0hm4cd81q2NAbYV2MRrSackB586xD
	h6jVuiAPxxGNbVfObogCK/X+dwrTVp9xGvHy9KG2HPx7vMALGG/JSvAU/Bcwhd43F+KqOOE0Qr+
	cOWquFHUgSFzWpGk/G2P3P6zYLzi2vXJRcXr/DQdet1jIwHUi/D23tAP6HZSkrXpG1n9zH9Cqwj
	i3eG5ISqwsFPpsGWkT7egYLyrkUdgYtPiXsr1LeuhNhjAPzMCWrk/h2XMz56gZ7xPXmOBawMkpx
	5lrfNlZpbHEfkF42Xyi1s40ccCkOrsa1vskEb4Q+YDC93cVL35WZo59KkYpKZn/8or8ObrT1/7h
	rBDdIGNnLp+SDUrZnauGTLkSGK3Ij1/wnTes0UNVMpAEGDhPU=
X-Google-Smtp-Source: AGHT+IGvUTPWFcYy+yEzNtenRCiJNJX6wGVEFFQ+drBuLUOHUjR/U2O4nc1PEXp2BVtRaLilpWZ65Q==
X-Received: by 2002:a17:902:f78a:b0:263:7b6e:8da0 with SMTP id d9443c01a7336-28e9a56660emr135939285ad.15.1759697472171;
        Sun, 05 Oct 2025 13:51:12 -0700 (PDT)
Received: from cosmo-ubuntu-2404.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1267d7sm110498115ad.49.2025.10.05.13.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 13:51:11 -0700 (PDT)
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
Subject: [PATCH 2/2] hwmon: (pmbus) add driver for MPS MP9945
Date: Mon,  6 Oct 2025 04:48:55 +0800
Message-ID: <20251005204855.190270-2-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251005204855.190270-1-chou.cosmo@gmail.com>
References: <20251005204855.190270-1-chou.cosmo@gmail.com>
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
index 8f5208ad442b..62eb5e01c9df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17463,6 +17463,13 @@ S:	Maintained
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
index 000000000000..b38209e00e64
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
+MODULE_IMPORT_NS(PMBUS);
-- 
2.43.0



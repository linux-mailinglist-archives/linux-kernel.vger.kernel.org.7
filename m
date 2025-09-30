Return-Path: <linux-kernel+bounces-837128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01915BAB73D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DAB11925C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85909269D06;
	Tue, 30 Sep 2025 05:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eBegKKyt"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F42266581;
	Tue, 30 Sep 2025 05:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759208594; cv=none; b=iuWactFPTCOHha6y/hrwu5HqPMjLvu/24O3aIqandmaBQfj1aZ4+JYiUPsxdLuQV2cGgnTeaDumsAKNA6mpZQix1VNmXThlJhOIm8AF8T3r9EbVnTRNJvaHSiVR6ZIWFWgZgcfS5HfLl1L2gOftDNt5o05UiVIV2Ilzgrj/BPXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759208594; c=relaxed/simple;
	bh=5FXykaWHsJjMtxQTc2k+eqKVyuIuc+D/hCxJEHm9k6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XMELsvAVLZZ7p1O0eC2JFgLT7n9U3+oHU1FWDOhzpiiUJLv1CNcYCCvqTcFZAQplJOaGEzAzQSUvU8e4mKouhoSgGIYhqg6nFldJPaalfWlrkwFAnDgy+ko8347cUq513YMuS9M6xgbHVCXO2GDW7Kp5pKJ/ms7m3HBMlp5OtHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eBegKKyt; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U3xB0n026774;
	Tue, 30 Sep 2025 01:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FUgDR
	+MS9uAKtoFiXJRBeEcsAoD4NmTd6inmfmCnc0k=; b=eBegKKyta5kaMjI3iWMAV
	K52EBcAl2+SYZdDmsjawiNj9OXMMTgBhnRX0t4kfpWyE14Dr7gKObaPtirjqkdPJ
	kDT3HPb1DNdt3tI5mLFj3Ay7UfAiJZevA3fBkKMHmhdV7DLhP+TAV+fTGnomkPd2
	8C4AyTBekjkutpOefrHwjngATjxZQAi51UlH+B72OeYkJz7JT+lUfIaHEnxt24xl
	mD5Jjx0mr16E3Ny+KB99FCXRlWicfp5M9iRMQHC/3M6Mok0XoLeYXY5b9O7VKPbS
	8ZYr14RYMMtIDpxqAOD0qR9Sv/rAVXWX6WamukvEWULQCuZFeOGfTvF1SVK5MZPD
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49g7sjg8wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 01:02:56 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58U52tgq050898
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Sep 2025 01:02:55 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 30 Sep
 2025 01:02:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 30 Sep 2025 01:02:55 -0400
Received: from [10.0.2.15] (MDONATO-T01.ad.analog.com [10.117.223.49] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58U52YIS032686;
	Tue, 30 Sep 2025 01:02:47 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Tue, 30 Sep 2025 13:02:21 +0800
Subject: [PATCH 2/2] hwmon: (pmbus/max17616): add driver for max17616
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250930-upstream-max17616-v1-2-1525a85f126c@analog.com>
References: <20250930-upstream-max17616-v1-0-1525a85f126c@analog.com>
In-Reply-To: <20250930-upstream-max17616-v1-0-1525a85f126c@analog.com>
To: Kim Seer Paller <kimseer.paller@analog.com>,
        Guenter Roeck
	<linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>
CC: <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759208553; l=7338;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=5FXykaWHsJjMtxQTc2k+eqKVyuIuc+D/hCxJEHm9k6k=;
 b=RA+8t45QJPjAu8BGfl1GFsptpRKD+KSYbEtnibhwEAd0JlkTEmTMOxtAcb01eLyyTYuVJWipv
 EORZLRfpUM9CaRvccQz/uK9JSamI5WckNDQSL0efAOnlM+LaAg2Z7qM
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 9fmkAGjDfU9vpCKy25rj7CyflowyG2uY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDAzMyBTYWx0ZWRfX0aa+rsUDxlz7
 SAmx6Bh7tMbEU0FVZxY5HdW+CL/DosUUCTcg+8jS8nnXDwf/socDUGdxpuvVAtW33vf+4HwUy9r
 eCygconLWlbEYdDKy9YYfeNnRl5btdw9ElXxeLimP7viHS244WUAm3CZL7rbc/2u1TCyiR1lwxo
 2oKBt/zzdwjQBX7AdHhOF4djqWW0JcluWQqIYPnwUYnYnlws9tHaBmxajVafy31SMIxmDjWmwB+
 yOdVoHPghsGH5+dpOkgCRhRhoy7dR4kPeoXAMf/rn3bkxvmF3TefsAoTQJT6BiXa1ZDIL+oJL18
 Aq7/RvC8RMc/WFDkDgvJMcLuL+DYWAKrYWMG7hC+keLKZN1z/VUzC4/2LredYfVehR4AyplYCiI
 WeOtZh5pCP13/zNv8yUAjWgD3J7drw==
X-Proofpoint-GUID: 9fmkAGjDfU9vpCKy25rj7CyflowyG2uY
X-Authority-Analysis: v=2.4 cv=U/CfzOru c=1 sm=1 tr=0 ts=68db6480 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=Z29R-gRe8ZKq3Wf3YHsA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509300033

Add support for MAX17616/MAX17616A current-limiter with
overvoltage/surge, undervoltage, reverse polarity, loss of ground
protection with PMBus interface. The PMBus interface allows monitoring
of input/output voltages, output current and temperature.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 Documentation/hwmon/index.rst    |  1 +
 Documentation/hwmon/max17616.rst | 62 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                      |  2 ++
 drivers/hwmon/pmbus/Kconfig      |  9 +++++
 drivers/hwmon/pmbus/Makefile     |  1 +
 drivers/hwmon/pmbus/max17616.c   | 73 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 148 insertions(+)

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 51a5bdf75b08656ee6499c6b5c50a51fc4d7c210..62c5d10f16ae722dd2e6a4f8953ae24b5f541666 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -151,6 +151,7 @@ Hardware Monitoring Kernel Drivers
    max1619
    max16601
    max1668
+   max17616
    max197
    max20730
    max20751
diff --git a/Documentation/hwmon/max17616.rst b/Documentation/hwmon/max17616.rst
new file mode 100644
index 0000000000000000000000000000000000000000..936447159f87a9c6b270b903c46b43a90caddb23
--- /dev/null
+++ b/Documentation/hwmon/max17616.rst
@@ -0,0 +1,62 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver max17616
+====================
+
+Supported chips:
+
+  * Analog Devices MAX17616/MAX17616A
+
+    Prefix: 'max17616'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/max17616-max17616a.pdf
+
+Author:
+
+  - Kim Seer Paller <kimseer.paller@analog.com>
+
+
+Description
+-----------
+
+This driver supports hardware monitoring for Analog Devices MAX17616/MAX17616A
+Current-Limiter with OV/Surge, UV, Reverse Polarity, Loss of Ground Protection
+with PMBus Interface.
+
+The MAX17616/MAX17616A is a 3V to 80V, 7A current-limiter with overvoltage,
+surge, undervoltage, reverse polarity, and loss of ground protection. Through
+the PMBus interface, the device can monitor input/output voltages, output current
+and temperature.
+
+The driver is a client driver to the core PMBus driver. Please see
+Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate
+the devices explicitly. Please see Documentation/i2c/instantiating-devices.rst
+for details.
+
+Platform data support
+---------------------
+
+The driver supports standard PMBus driver platform data.
+
+Sysfs entries
+-------------
+
+================= ========================================
+in1_label         "vin"
+in1_input         Measured input voltage
+in1_alarm	  Input voltage alarm
+in2_label	  "vout1"
+in2_input	  Measured output voltage
+curr1_label	  "iout1"
+curr1_input	  Measured output current.
+curr1_alarm	  Output current alarm
+temp1_input       Measured temperature
+temp1_alarm       Chip temperature alarm
+================= ========================================
diff --git a/MAINTAINERS b/MAINTAINERS
index 89d35faf93c9d2e984b73f5c09d09044ee6eddb2..267ab428260a29c38fa508190bdfa2677bba58c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14923,6 +14923,8 @@ L:	linux-hwmon@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/hwmon/pmbus/adi,max17616.yaml
+F:	Documentation/hwmon/max17616.rst
+F:	drivers/hwmon/pmbus/max17616.c
 
 MAX2175 SDR TUNER DRIVER
 M:	Ramesh Shanmugasundaram <rashanmu@gmail.com>
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index da04ff6df28bd12909c9140662d6b932a150bd97..def5faad8fdf56eb31fe216322ead57ee43a1ac5 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -320,6 +320,15 @@ config SENSORS_MAX16601
 	  This driver can also be built as a module. If so, the module will
 	  be called max16601.
 
+config SENSORS_MAX17616
+	tristate "Analog Devices MAX17616/MAX17616A"
+	help
+	  If you say yes here you get hardware monitoring support for Analog
+	  Devices MAX17616/MAX17616A.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called max17616.
+
 config SENSORS_MAX20730
 	tristate "Maxim MAX20710, MAX20730, MAX20734, MAX20743"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 4c5ff3f32c5ecbea069dce8af3e3e8365892b278..9cebe488fdf18b2aa164c0fc2ac7d1d8ffd2b970 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_SENSORS_LTC4286)	+= ltc4286.o
 obj-$(CONFIG_SENSORS_MAX15301)	+= max15301.o
 obj-$(CONFIG_SENSORS_MAX16064)	+= max16064.o
 obj-$(CONFIG_SENSORS_MAX16601)	+= max16601.o
+obj-$(CONFIG_SENSORS_MAX17616)	+= max17616.o
 obj-$(CONFIG_SENSORS_MAX20730)	+= max20730.o
 obj-$(CONFIG_SENSORS_MAX20751)	+= max20751.o
 obj-$(CONFIG_SENSORS_MAX31785)	+= max31785.o
diff --git a/drivers/hwmon/pmbus/max17616.c b/drivers/hwmon/pmbus/max17616.c
new file mode 100644
index 0000000000000000000000000000000000000000..1d4a0ddb95bb6e8349932062be0d918f935cd846
--- /dev/null
+++ b/drivers/hwmon/pmbus/max17616.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hardware monitoring driver for Analog Devices MAX17616/MAX17616A
+ *
+ * Copyright (C) 2025 Analog Devices, Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+
+#include "pmbus.h"
+
+static struct pmbus_driver_info max17616_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = direct,
+	.m[PSC_VOLTAGE_IN] = 512,
+	.b[PSC_VOLTAGE_IN] = -18,
+	.R[PSC_VOLTAGE_IN] = -1,
+
+	.format[PSC_VOLTAGE_OUT] = direct,
+	.m[PSC_VOLTAGE_OUT] = 512,
+	.b[PSC_VOLTAGE_OUT] = -18,
+	.R[PSC_VOLTAGE_OUT] = -1,
+
+	.format[PSC_CURRENT_OUT] = direct,
+	.m[PSC_CURRENT_OUT] = 5845,
+	.b[PSC_CURRENT_OUT] = 80,
+	.R[PSC_CURRENT_OUT] = -1,
+
+	.format[PSC_TEMPERATURE] = direct,
+	.m[PSC_TEMPERATURE] = 71,
+	.b[PSC_TEMPERATURE] = 19653,
+	.R[PSC_TEMPERATURE] = -1,
+
+	.func[0] =  PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
+		    PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_VOUT |
+		    PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT |
+		    PMBUS_HAVE_STATUS_TEMP,
+};
+
+static int max17616_probe(struct i2c_client *client)
+{
+	return pmbus_do_probe(client, &max17616_info);
+}
+
+static const struct i2c_device_id max17616_id[] = {
+	{ "max17616" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max17616_id);
+
+static const struct of_device_id max17616_of_match[] = {
+	{ .compatible = "adi,max17616" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max17616_of_match);
+
+static struct i2c_driver max17616_driver = {
+	.driver = {
+		.name = "max17616",
+		.of_match_table = max17616_of_match,
+	},
+	.probe = max17616_probe,
+	.id_table = max17616_id,
+};
+module_i2c_driver(max17616_driver);
+
+MODULE_AUTHOR("Kim Seer Paller <kimseer.paller@analog.com>");
+MODULE_DESCRIPTION("PMBus driver for Analog Devices MAX17616/MAX17616A");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("PMBUS");

-- 
2.34.1



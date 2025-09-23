Return-Path: <linux-kernel+bounces-828712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CF2B9542A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFFB3AB0E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262E1320A34;
	Tue, 23 Sep 2025 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monolithicpower.com header.i=@monolithicpower.com header.b="Fi39XWul"
Received: from mx0a-002bf204.pphosted.com (mx0a-002bf204.pphosted.com [205.220.160.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB122DEA6F;
	Tue, 23 Sep 2025 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.160.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619898; cv=none; b=lkGDvPSaSoD8atov667a/olxVaFei0tIO1FaTKfLMunle4bbpqV8L91hpeFy94RTPzEMTND+tEmeSwG0CRFW5s78Xs3GZTZL3E6Tucrc8+nnJynS2gvP3vUBnZMSTpOWRLPT1h5GRksd3V1TK9MStbaqLhtibgUxB4m3WyeoUQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619898; c=relaxed/simple;
	bh=OVanE9fiAaU6eaojZh86x0XNDRwE5LbaLgVOlGiLnbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sB9TwlmTY6bGuv3wyqUzoQH3pAeIj/iLhQdK6pC4za16ADCOX9wGfbDOPcr/wrLL2utAFPzVcgvqxYR4inVjFSR1uNkmaVBi3PYiVgfpTX4S2xBbbiCMc1KOlkm0p/XfllcWR/7NSQXkR0QFYi/4XxXouNtvTcYQvBvIavyPGiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monolithicpower.com; spf=pass smtp.mailfrom=monolithicpower.com; dkim=pass (2048-bit key) header.d=monolithicpower.com header.i=@monolithicpower.com header.b=Fi39XWul; arc=none smtp.client-ip=205.220.160.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=monolithicpower.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monolithicpower.com
Received: from pps.filterd (m0207524.ppops.net [127.0.0.1])
	by mx0a-002bf204.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58N58bji1331671;
	Tue, 23 Sep 2025 02:09:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	monolithicpower.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to; s=pps1; bh=1EgPaygCBoeItMM/IcftjVCi1S9wAIyXqckZqzK6
	eHE=; b=Fi39XWulRH3adq07uBi/kzNv+jh5LGnHeDeBRrU0N1DxpqfUOBiNXTER
	/u1Iv9BuXOHqIcMz1x3jnA8vTWXCitSS8xPi/NFC1wbo1mX8xXacG1tHjqTDN6aD
	4Mmaj5BK2J/azaiYgkIb58mucMxGTDHcQd5SWsv5190tNMIhnHm7dvX3/Wi0mRXj
	ErklZiSvyIkzqTMGbAlHXDdgfW8Z8YV2SdmhgHdi6Efh69BC7/6BOOdMHdibG5JQ
	unNoSEoUcLFQpiryVIsOAujgMhJp1Vf7qQWzCpkCxecjZenGd+3akl1YStXXEsl9
	QNwUvvEkdoqHUTbdhBCPxJ1wDoe5Og==
Received: from webmail.monolithicpower.com (mps-vpn.monolithicpower.com [12.33.0.20] (may be forged))
	by mx0a-002bf204.pphosted.com (PPS) with ESMTPS id 499qpnhh6q-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 23 Sep 2025 02:09:53 -0700 (PDT)
Received: from CD-MSH04.monolithicpower.com (10.10.70.213) by
 mps-mslbn03.monolithicpower.com (10.10.10.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Tue, 23 Sep 2025 02:09:45 -0700
Received: from HZ-200L-YUWANG.monolithicpower.com (10.10.86.73) by
 CD-MSH04.monolithicpower.com (10.10.70.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Tue, 23 Sep 2025 17:09:43 +0800
From: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
To: <Yuxi.Wang@monolithicpower.com>, <corbet@lwn.net>, <linux@roeck-us.net>,
        <jdelvare@suse.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <wyx137120466@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 2/2] hwmon: add mp5998 driver
Date: Tue, 23 Sep 2025 17:09:25 +0800
Message-ID: <20250923090926.619-3-Yuxi.Wang@monolithicpower.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <20250923090926.619-1-Yuxi.Wang@monolithicpower.com>
References: <20250923090926.619-1-Yuxi.Wang@monolithicpower.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CD-MSLBN02.monolithicpower.com (192.168.86.32) To
 CD-MSH04.monolithicpower.com (10.10.70.213)
X-Proofpoint-GUID: bVkm0xQZmIAOh0FN-6D3wCAm2Nc2g7Y2
X-Authority-Analysis: v=2.4 cv=S8jZwJsP c=1 sm=1 tr=0 ts=68d263e1 cx=c_pps
 a=Zb4R73zfuCEKbQz3U9Wi8g==:117 a=Zb4R73zfuCEKbQz3U9Wi8g==:17
 a=Mn2HaNVs01YA:10 a=yJojWOMRYYMA:10 a=oOyOvuMWAAAA:8 a=VwQbUJbxAAAA:8
 a=UqCG9HQmAAAA:8 a=B7mzDJisyf8LYfc8S9UA:9 a=G8TaXjCCXnGpTNG3tzU6:22
X-Proofpoint-ORIG-GUID: bVkm0xQZmIAOh0FN-6D3wCAm2Nc2g7Y2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDA4NCBTYWx0ZWRfX8RikJh8V9FvF
 oVIES+WFG2TDNnJRpYEndfreDLeGMNS9Y57xuThXdvnk3QQChR9CZdjo4vkb1EUFiP9DqsSzMwN
 byK07kzpto+9Y0mMq7xsz5PWYGutHGzOSDoLlFZmO3hkgUmZ5SISIfS/LM3ik67F1CL2COlgR4B
 iiPlpgHEobSvNpysdTR6UlSNRfB8O25H/oXQWj55I6krHVJffwgAmj5NoS89Kj6SHkfH9Ei+RU9
 nNx4jg6aOCjmNEvlh6px/8VOwxebhRlV/EkCpIumGNb1cjg2hCV9m2vAQdEz/d/PFVDTezhh8b4
 j84lyedd7AYF0uGSuxRhFpPSJNL5ZoxDYOlVefqtLTb+TEUCcUmIgo9t2C8AIA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507300000 definitions=firstrun

Add support for MPS mp5998.
Signed-off-by: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
---
 Documentation/hwmon/index.rst  |   1 +
 Documentation/hwmon/mp5998.rst |  92 +++++++++++++++++++
 MAINTAINERS                    |   7 ++
 drivers/hwmon/pmbus/Kconfig    |   9 ++
 drivers/hwmon/pmbus/Makefile   |   1 +
 drivers/hwmon/pmbus/mp5998.c   | 162 +++++++++++++++++++++++++++++++++
 6 files changed, 272 insertions(+)
 create mode 100644 Documentation/hwmon/mp5998.rst
 create mode 100644 drivers/hwmon/pmbus/mp5998.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index d292a86ac5da..0b9ee6e8e922 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -180,6 +180,7 @@ Hardware Monitoring Kernel Drivers
    mp5023
    mp5920
    mp5990
+   mp5998
    mp9941
    mpq8785
    nct6683
diff --git a/Documentation/hwmon/mp5998.rst b/Documentation/hwmon/mp5998.rst
new file mode 100644
index 000000000000..b5609a5a5103
--- /dev/null
+++ b/Documentation/hwmon/mp5998.rst
@@ -0,0 +1,92 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver mp5998
+====================
+
+Supported chips:
+
+  * MPS mp5998
+
+    Prefix: 'mp5998'
+
+  * Datasheet
+    https://www.monolithicpower.com/en/
+
+Author:
+
+	Yuxi Wang <Yuxi.Wang@monolithicpower.com>
+
+Description
+-----------
+
+This driver implements support for Monolithic Power Systems, Inc. (MPS)
+MP5998 Hot-Swap Controller.
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
+The driver provides the following attributes for output voltage:
+
+**in2_input**
+
+**in2_label**
+
+**in2_lcrit**
+
+**in2_lcrit_alarm**
+
+**in2_rated_max**
+
+**in2_rated_min**
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
index f6206963efbf..d6bc9c10d908 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17192,6 +17192,13 @@ S:	Maintained
 F:	Documentation/hwmon/mp2993.rst
 F:	drivers/hwmon/pmbus/mp2993.c
 
+MPS MP5998 DRIVER
+M:	Yuxi Wang <Yuxi.Wang@monolithicpower.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/mp5998.rst
+F:	drivers/hwmon/pmbus/mp5998.c
+
 MPS MP9941 DRIVER
 M:	Noah Wang <noahwang.wang@outlook.com>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 55e492452ce8..35862f011a5b 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -443,6 +443,15 @@ config SENSORS_MP5990
 	  This driver can also be built as a module. If so, the module will
 	  be called mp5990.
 
+config SENSORS_MP5998
+	tristate "MPS MP5998"
+	help
+	  If you say yes here you get hardware monitoring support for MPS
+	  MP5998.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called mp5998.
+
 config SENSORS_MP9941
 	tristate "MPS MP9941"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 29cd8a3317d2..4fb45a7e3ac4 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_SENSORS_MP2993)	+= mp2993.o
 obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
 obj-$(CONFIG_SENSORS_MP5920)	+= mp5920.o
 obj-$(CONFIG_SENSORS_MP5990)	+= mp5990.o
+obj-$(CONFIG_SENSORS_MP5998)	+= mp5998.o
 obj-$(CONFIG_SENSORS_MP9941)	+= mp9941.o
 obj-$(CONFIG_SENSORS_MPQ7932)	+= mpq7932.o
 obj-$(CONFIG_SENSORS_MPQ8785)	+= mpq8785.o
diff --git a/drivers/hwmon/pmbus/mp5998.c b/drivers/hwmon/pmbus/mp5998.c
new file mode 100644
index 000000000000..1f192d85c250
--- /dev/null
+++ b/drivers/hwmon/pmbus/mp5998.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * mp5998.c  - pmbus driver for mps mp5998
+ *
+ * Copyright 2025 Monolithic Power Systems, Inc
+ *
+ * Author: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include "pmbus.h"
+
+/*Common Register*/
+#define PAGE	0x01
+#define EFUSE_CFG 0xC4
+#define MP5998_FUNC	(PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | \
+					PMBUS_HAVE_IOUT | PMBUS_HAVE_IIN | \
+					PMBUS_HAVE_PIN | PMBUS_HAVE_POUT | \
+					PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_IOUT | \
+					PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP)
+
+static int mp5998_read_word_data(struct i2c_client *client, int page,
+				 int phase, int reg)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_READ_VIN...PMBUS_READ_TEMPERATURE_1:
+	case PMBUS_READ_POUT...PMBUS_READ_PIN:
+	case PMBUS_STATUS_WORD:
+		ret = -ENODATA;
+	break;
+	default:
+		ret = -EINVAL;
+	break;
+	}
+
+	return ret;
+}
+
+static int mp5998_read_byte_data(struct i2c_client *client, int page,
+				 int reg)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_STATUS_BYTE:
+	case PMBUS_STATUS_IOUT:
+	case PMBUS_STATUS_INPUT:
+	case PMBUS_STATUS_TEMPERATURE:
+	case PMBUS_STATUS_CML:
+	case PMBUS_STATUS_MFR_SPECIFIC:
+	   ret = -ENODATA;
+	break;
+	default:
+		ret = -EINVAL;
+	break;
+	}
+	return ret;
+}
+
+static struct pmbus_driver_info mp5998_info_linear = {
+	.pages = PAGE,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = linear,
+	.format[PSC_CURRENT_OUT] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.format[PSC_POWER] = linear,
+
+	.read_word_data = mp5998_read_word_data,
+	.read_byte_data = mp5998_read_byte_data,
+	.func[0] = MP5998_FUNC,
+};
+
+static struct pmbus_driver_info mp5998_info_direct = {
+	.pages = PAGE,
+	.format[PSC_VOLTAGE_IN] = direct,
+	.format[PSC_CURRENT_IN] = direct,
+	.format[PSC_VOLTAGE_OUT] = direct,
+	.format[PSC_CURRENT_OUT] = direct,
+	.format[PSC_TEMPERATURE] = direct,
+	.format[PSC_POWER] = direct,
+
+	.m[PSC_VOLTAGE_IN] = 64,
+	.b[PSC_VOLTAGE_IN] = 0,
+	.R[PSC_VOLTAGE_IN] = 0,
+
+	.m[PSC_CURRENT_IN] = 16,
+	.b[PSC_CURRENT_IN] = 0,
+	.R[PSC_CURRENT_IN] = 0,
+
+	.m[PSC_VOLTAGE_OUT] = 64,
+	.b[PSC_VOLTAGE_OUT] = 0,
+	.R[PSC_VOLTAGE_OUT] = 0,
+
+	.m[PSC_CURRENT_OUT] = 16,
+	.b[PSC_CURRENT_OUT] = 0,
+	.R[PSC_CURRENT_OUT] = 0,
+
+	.m[PSC_TEMPERATURE] = 1,
+	.b[PSC_TEMPERATURE] = 0,
+	.R[PSC_TEMPERATURE] = 3,
+
+	.m[PSC_POWER] = 2,
+	.b[PSC_POWER] = 0,
+	.R[PSC_POWER] = 0,
+
+	.read_word_data = mp5998_read_word_data,
+	.read_byte_data = mp5998_read_byte_data,
+	.func[0] = MP5998_FUNC,
+};
+
+static int mp5998_probe(struct i2c_client *client)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(client, EFUSE_CFG);
+
+	if (ret < 0)
+		return ret;
+
+	if (ret & BIT(9))
+		ret = pmbus_do_probe(client, &mp5998_info_linear);
+	else
+		ret = pmbus_do_probe(client, &mp5998_info_direct);
+
+	if (!ret)
+		dev_info(&client->dev, "%s chip found\n", client->name);
+	return ret;
+}
+
+static const struct i2c_device_id mp5998_id[] = {
+	{ "mp5998", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mp5998_id);
+
+static const struct of_device_id mp5998_of_match[] = {
+	{ .compatible = "mps,mp5998" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mp5998_of_match);
+
+static struct i2c_driver mp5998_driver = {
+	.probe = mp5998_probe,
+	.driver = {
+			.name = "mp5998",
+			.of_match_table = mp5998_of_match,
+		   },
+	.id_table = mp5998_id,
+};
+
+module_i2c_driver(mp5998_driver);
+MODULE_AUTHOR("Yuxi Wang <Yuxi.Wang@monolithicpower.com>");
+MODULE_DESCRIPTION("MPS MP5998 HWMON driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("PMBUS");
-- 
2.39.2



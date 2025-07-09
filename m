Return-Path: <linux-kernel+bounces-722824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B682AFDF71
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83C987B7B07
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE7326C3A6;
	Wed,  9 Jul 2025 05:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="NKni7zc3"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3BB26AA93;
	Wed,  9 Jul 2025 05:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752039867; cv=none; b=i44d1WFmOe1U9Dv+SQ0abQdmiRPI6on66Ict6zcBPX1HJ38BNitrxS5RKq9LvOsCyLoDLczxEfh4toqlnpw9qdZ8EmoZTZKMX1Rq147NMCek3LySyWz9DtRlE/SBnITAQTclVxM/Yb7nEGhiQAJ3M1RRRtnR6GuQdciZBamSUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752039867; c=relaxed/simple;
	bh=0PbKzSG1IWGOqvdcy2KAqXaqJRmGvQC8ob1UAinffyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pTo7xWI+8NVZDT/LK8WWXGmg6gmZAbkFtXNjKbXHbRTCa3YdKMAnskxoXvjqJc/J16ji7Vy/oLpJ0dX71eiBHo72TQ28onqeFp0r+sNkOd0sqqFjCBVrY544wA2HXfbmBq5laTazwUa7EQpEhZpdiihvwb3wXRhaTvfF1qFq71c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=NKni7zc3; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56946N8f003608;
	Wed, 9 Jul 2025 01:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=I/iGC
	SUOyMCESDGrlCA1msWDM8e0UK1Ub4auNq1yJK4=; b=NKni7zc3xQk6iOfMBVx9n
	AtnNp6ADgHsH36yRLfTlRyS3s756feZ9lVaUKnhfomWxySkHRQo5p5iZRTIqTGG2
	CIc+GnGAsg53F3fcNEvlC4QKwRjw6u+zGpIORbNx3KCAXuxTqshxpZeyaiZ7BGbn
	/NhU/wOa05d8gE5oAx1++Xr8nagkmymBl5Av2rabwh9fYrmZvEgeET/FV/ziBhU8
	G1GQkN+o4hRTi8uptyvKxEBhF8sN8RFRA+Rq0IkFr5XNQ65sJDJkogZ7TIlNHbeI
	j8HO8RIuYceEvdAucZVii+M4ff/Y4gTDSeoPzRzA86J2b7Dz+T9uf48HBZXtQh+X
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47r7truq3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 01:44:01 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5695i0KC013753
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Jul 2025 01:44:00 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 9 Jul 2025 01:44:00 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 9 Jul 2025 01:44:00 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 9 Jul 2025 01:43:59 -0400
Received: from CENCARNA-L02.ad.analog.com (CENCARNA-L02.ad.analog.com [10.117.222.48])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5695hQ2i024058;
	Wed, 9 Jul 2025 01:43:50 -0400
From: Cedric Encarnacion <cedricjustine.encarnacion@analog.com>
Date: Wed, 9 Jul 2025 13:43:26 +0800
Subject: [PATCH v5 2/3] hwmon: (pmbus/adp1050): Add support for adp1051,
 adp1055 and ltp8800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250709-adp1051-v5-2-539254692252@analog.com>
References: <20250709-adp1051-v5-0-539254692252@analog.com>
In-Reply-To: <20250709-adp1051-v5-0-539254692252@analog.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Delphine CC Chiu
	<Delphine_CC_Chiu@Wiwynn.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: Radu Sabau <radu.sabau@analog.com>,
        Alexis Czezar Torreno
	<alexisczezar.torreno@analog.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Cedric Encarnacion
	<cedricjustine.encarnacion@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752039806; l=8541;
 i=cedricjustine.encarnacion@analog.com; s=20250707;
 h=from:subject:message-id; bh=0PbKzSG1IWGOqvdcy2KAqXaqJRmGvQC8ob1UAinffyU=;
 b=gSuK1ArkwCposgHEyfG/+DnKIm4VofhIqAB2pgr8WfmgqmE7KrdQgf6F/z1R7VEVzALZS7MYf
 kRu2CjWdHJLD8dKzhkeMIt92SBUI/ShbGwwqIvvRJipzFXdAnPlR8Uh
X-Developer-Key: i=cedricjustine.encarnacion@analog.com; a=ed25519;
 pk=YAch4cyWjsctl/d3LfcMhkS/GNaUfXHkd658Mw3k5Kg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: cqCRY2VtIGoScltf4skgSV6YyBxgSoiZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA0OSBTYWx0ZWRfX5pc9p2lr/jDy
 yEfN1iqkamg5Yehrrsndg5xjgM4o51HNXyve6hGZe1V0bQQhhe8R6FaUCG9jo6yk3ap2IxrsZ3T
 Z+tKkUPnipqF9DLjCBshGVVEmdfXaYJmbuAG1NlxIqVVz+kTHpHQrWxKayql0QVNzq2WalawKlW
 tPzdxbN0NR3Aad6P6sBroT6NKGTx6BgSTmtXOXQVla07laRnuzHXGyuxnjMAruAbb1nBld0Tc1d
 5JJ9pIpnb7Kv7/I47g/2WRwZBV1kEMgKS7ej3DVDNQIzTWCmKieqowDKSt1mY8d0hwhD8euwedg
 LwjqZa4J5cZyi2KKzqUJFfJGPjXQmf3b+J+VaG4HfWZMovBuTqE7rh3v8Wn1q3ouetappXLSjqH
 mSpLmx4V/oTdmJvLf5NT+v6egBgP6M+GB7G56etTztzAoc3/FrFS1M0N29FF0DQxoQl8oNRe
X-Proofpoint-GUID: cqCRY2VtIGoScltf4skgSV6YyBxgSoiZ
X-Authority-Analysis: v=2.4 cv=S8fZwJsP c=1 sm=1 tr=0 ts=686e01a1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=gAnH3GRIAAAA:8 a=QyXUC8HyAAAA:8
 a=4le2q06FsVg0c7Pe3eQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090049

Introduce hardware monitoring support for the following devices:

    ADP1051: 6 PWM for I/O Voltage, I/O Current, Temperature
    ADP1055: 6 PWM for I/O Voltage, I/O Current, Power, Temperature
    LTP8800-1A/-2/-4A: 150A/135A/200A DC/DC µModule Regulator

The ADP1051 and ADP1055 are similar digital controllers for high
efficiency DC-DC power conversion while the LTP8800 is a family of
step-down μModule regulators that provides microprocessor core voltage
from 54V power distribution architecture. All of the above components
features telemetry monitoring of input/output voltage, input current,
output power, and temperature over PMBus.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Co-developed-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Signed-off-by: Cedric Encarnacion <cedricjustine.encarnacion@analog.com>
---
 Documentation/hwmon/adp1050.rst | 71 +++++++++++++++++++++++++++++++++++++----
 drivers/hwmon/pmbus/adp1050.c   | 62 +++++++++++++++++++++++++++++++++--
 2 files changed, 124 insertions(+), 9 deletions(-)

diff --git a/Documentation/hwmon/adp1050.rst b/Documentation/hwmon/adp1050.rst
index 8fa937064886aba7098884c458265722411be553..32514084fbdca5d7fc5a8a2b0df97c7380d76516 100644
--- a/Documentation/hwmon/adp1050.rst
+++ b/Documentation/hwmon/adp1050.rst
@@ -13,6 +13,32 @@ Supported chips:
 
     Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADP1050.pdf
 
+  * Analog Devices ADP1051
+
+    Prefix: 'adp1051'
+
+    Addresses scanned: I2C 0x70 - 0x77
+
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADP1051.pdf
+
+  * Analog Devices ADP1055
+
+    Prefix: 'adp1055'
+
+    Addresses scanned: I2C 0x4B - 0x77
+
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADP1055.pdf
+
+  * Analog Devices LTP8800-1A/-2/-4A
+
+    Prefix: 'ltp8800'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/LTP8800-1A.pdf
+         https://www.analog.com/media/en/technical-documentation/data-sheets/LTP8800-2.pdf
+         https://www.analog.com/media/en/technical-documentation/data-sheets/LTP8800-4A.pdf
+
 Authors:
 
   - Radu Sabau <radu.sabau@analog.com>
@@ -21,14 +47,17 @@ Authors:
 Description
 -----------
 
-This driver supprts hardware monitoring for Analog Devices ADP1050 Digital
-Controller for Isolated Power Supply with PMBus interface.
+This driver supports hardware monitoring for Analog Devices ADP1050, ADP1051,
+and ADP1055 Digital Controller for Isolated Power Supply with PMBus interface,
+and the LTP8800 step-down μModule regulators.
 
-The ADP1050 is an advanced digital controller with a PMBus™
+The ADP1050, ADP1051, and ADP1055 are advanced digital controllers with PMBus™
 interface targeting high density, high efficiency dc-to-dc power
-conversion used to monitor system temperatures, voltages and currents.
-Through the PMBus interface, the device can monitor input/output voltages,
-input current and temperature.
+conversion used to monitor system temperatures, voltages and currents. The
+LTP8800 is a family of step-down μModule regulators that provides microprocessor
+core voltage from 54V power distribution architecture. Through the PMBus
+interface, the device can monitor input/output voltages, input current and
+temperature.
 
 Usage Notes
 -----------
@@ -49,16 +78,46 @@ Sysfs Attributes
 in1_label         "vin"
 in1_input         Measured input voltage
 in1_alarm	  Input voltage alarm
+in1_crit          Critical maximum input voltage
+in1_crit_alarm    Input voltage high alarm
+in1_lcrit         Critical minimum input voltage
+in1_lcrit_alarm   Input voltage critical low alarm
 in2_label	  "vout1"
 in2_input	  Measured output voltage
 in2_crit	  Critical maximum output voltage
 in2_crit_alarm    Output voltage high alarm
 in2_lcrit	  Critical minimum output voltage
 in2_lcrit_alarm	  Output voltage critical low alarm
+in2_max           Critical maximum output voltage
+in2_max_alarm     Output voltage critical max alarm
+in2_min           Critical minimum output voltage
+in2_min_alarm     Output voltage critical min alarm
 curr1_label	  "iin"
 curr1_input	  Measured input current.
 curr1_alarm	  Input current alarm
+curr1_crit        Critical maximum input current
+curr1_crit_alarm  Input current high alarm
+curr2_label       "iout1"
+curr2_input       Measured output current
+curr2_alarm	  Output current alarm
+curr2_crit        Critical maximum output current
+curr2_crit_alarm  Output current high alarm
+curr2_lcrit       Critical minimum output current
+curr2_lcrit_alarm Output current critical low alarm
+curr2_max         Critical maximum output current
+curr2_max_alarm   Output current critical max alarm
+power1_label      "pout1"
+power1_input      Measured output power
+power1_crit       Critical maximum output power
+power1_crit_alarm Output power high alarm
 temp1_input       Measured temperature
 temp1_crit	  Critical high temperature
 temp1_crit_alarm  Chip temperature critical high alarm
+temp1_max         Critical maximum temperature
+temp1_max_alarm   Temperature critical max alarm
+temp2_input       Measured temperature
+temp2_crit        Critical high temperature
+temp2_crit_alarm  Chip temperature critical high alarm
+temp2_max         Critical maximum temperature
+temp2_max_alarm   Temperature critical max alarm
 ================= ========================================
diff --git a/drivers/hwmon/pmbus/adp1050.c b/drivers/hwmon/pmbus/adp1050.c
index ef46c880b168bd0378030fda2397d075221f3723..353758a6ffd69e33203e8d1447accf2c75ebecd5 100644
--- a/drivers/hwmon/pmbus/adp1050.c
+++ b/drivers/hwmon/pmbus/adp1050.c
@@ -23,19 +23,75 @@ static struct pmbus_driver_info adp1050_info = {
 		| PMBUS_HAVE_STATUS_TEMP,
 };
 
+static struct pmbus_driver_info adp1051_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = linear,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN
+		| PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT
+		| PMBUS_HAVE_TEMP
+		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT
+		| PMBUS_HAVE_STATUS_INPUT
+		| PMBUS_HAVE_STATUS_TEMP,
+};
+
+static struct pmbus_driver_info adp1055_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = linear,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN
+		| PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT
+		| PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3
+		| PMBUS_HAVE_POUT
+		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT
+		| PMBUS_HAVE_STATUS_INPUT
+		| PMBUS_HAVE_STATUS_TEMP,
+};
+
+static struct pmbus_driver_info ltp8800_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = linear,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN
+		| PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT
+		| PMBUS_HAVE_TEMP
+		| PMBUS_HAVE_POUT
+		| PMBUS_HAVE_STATUS_VOUT
+		| PMBUS_HAVE_STATUS_INPUT
+		| PMBUS_HAVE_STATUS_TEMP,
+};
+
 static int adp1050_probe(struct i2c_client *client)
 {
-	return pmbus_do_probe(client, &adp1050_info);
+	struct pmbus_driver_info *info;
+
+	info = (struct pmbus_driver_info *)i2c_get_match_data(client);
+	if (!info)
+		return -ENODEV;
+
+	return pmbus_do_probe(client, info);
 }
 
 static const struct i2c_device_id adp1050_id[] = {
-	{"adp1050"},
+	{ .name = "adp1050", .driver_data = (kernel_ulong_t) &adp1050_info },
+	{ .name = "adp1051", .driver_data = (kernel_ulong_t) &adp1051_info },
+	{ .name = "adp1055", .driver_data = (kernel_ulong_t) &adp1055_info },
+	{ .name = "ltp8800", .driver_data = (kernel_ulong_t) &ltp8800_info },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, adp1050_id);
 
 static const struct of_device_id adp1050_of_match[] = {
-	{ .compatible = "adi,adp1050"},
+	{ .compatible = "adi,adp1050", .data = &adp1050_info },
+	{ .compatible = "adi,adp1051", .data = &adp1051_info },
+	{ .compatible = "adi,adp1055", .data = &adp1055_info },
+	{ .compatible = "adi,ltp8800", .data = &ltp8800_info },
 	{}
 };
 MODULE_DEVICE_TABLE(of, adp1050_of_match);

-- 
2.39.5



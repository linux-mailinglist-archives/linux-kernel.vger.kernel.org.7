Return-Path: <linux-kernel+bounces-722823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1739AFDF6D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38693B936D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C1226B754;
	Wed,  9 Jul 2025 05:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bgsO1DFQ"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D59926A0F8;
	Wed,  9 Jul 2025 05:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752039866; cv=none; b=Ktx4LRNHJ0hm0A3VCwX2sRmXeqVHc/OmxiBJrS+jFyNUp/T2ZHtKKKGuv6bvHwu3dtvwhg/1Wi0nL8ChADc2hzaBsjsTlYVnzD26wbHbAL7enkuauJD/OZV14ve4nVv+nQACLF+sngT5ZEjWe96Af5UJ2qm9fVYiHbMdJjKU0Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752039866; c=relaxed/simple;
	bh=YsE9zx6xPrmRMjJfSWDPOF4U5F7BsfhxAHXh55Enj2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jYBAhIWyyOIgrFiuijruvvhVsH4jw9w6tsgJhX4eq82GxVQbwMnKzvvpaQjyockTB0mAAlQunCAIWYi2NfuTIGfQZztU3gc9ZyOZ8nEDiA74J7ctxXF2S6PmHLmaiZ+EStTkYCoYzyqo0FqFUr018nMN/opyQPbvbKMJbrFLYqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bgsO1DFQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5694EJOD003927;
	Wed, 9 Jul 2025 01:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tHZjP
	9C26fO/MLaULR0SIUzS2i9X04DTIx+cSAH5XMw=; b=bgsO1DFQGGl9gt5vqiqP+
	c4ioV6xSie22bc2z+rKm36BjUfvq9Dx0p+eF+3x77BkP39+WB9JcYkahGs+DlHS7
	sDPI6rksXwAdn9b0BJnXrlMHPLE6JuJLyNV7WduQENkdi6uMkqdL4MZXa5Y/OSZM
	JTHVkUinrA/vd7NYnt0XAHjN/IbBFpwC3VeM/RSeyOBcB03nJGmGw83aS1YB8HuI
	dUcakGUZ3ZpXgEHohJqKicO9C1ceKAcct74EAKj5ncBKxCuU8C6X6vJ1apmgWKXL
	fVXNRrhCcIVEUWyuewyu842GJsW8Y0m+myCOMXb8NP1ZXZLjAFkY6y9MLpNd8Avj
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47r7truq4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 01:44:07 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5695i6Zv013765
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Jul 2025 01:44:06 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 9 Jul 2025 01:44:05 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 9 Jul 2025 01:44:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 9 Jul 2025 01:44:05 -0400
Received: from CENCARNA-L02.ad.analog.com (CENCARNA-L02.ad.analog.com [10.117.222.48])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5695hQ2j024058;
	Wed, 9 Jul 2025 01:43:56 -0400
From: Cedric Encarnacion <cedricjustine.encarnacion@analog.com>
Date: Wed, 9 Jul 2025 13:43:27 +0800
Subject: [PATCH v5 3/3] hwmon: (pmbus/adp1050): Add regulator support for
 ltp8800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250709-adp1051-v5-3-539254692252@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752039806; l=2193;
 i=cedricjustine.encarnacion@analog.com; s=20250707;
 h=from:subject:message-id; bh=YsE9zx6xPrmRMjJfSWDPOF4U5F7BsfhxAHXh55Enj2c=;
 b=yMDXnErE9xLtpHhCRAFrftwRYv2RsmQa5QTQXG0QDL9QbxixTEWxFNLYxYxbASj5AqAD7uRSw
 JXJx/YNEmraDXBhOo5w6o2H5oPElQi4/y7gH1E/VTfx5pzDhPOxLUwF
X-Developer-Key: i=cedricjustine.encarnacion@analog.com; a=ed25519;
 pk=YAch4cyWjsctl/d3LfcMhkS/GNaUfXHkd658Mw3k5Kg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ecFlmawsVSdyxsb1gTwDtinQAFYFWEbG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA0OSBTYWx0ZWRfX01ZeeCUS8wlh
 kBNqmbTEV9fwNN3fSUxFHvH+O0zFb+26ccUt9t79HpdFSSpwvVRF/XJvZ8BBovUavq0zdKhOT51
 fdvcMIvK1TJs9bfYXJRzpsLX3SBxpUZrb1UkHQY6yukWst9gdqGQWpg/gtUwjQsZGc5BhX+cGzS
 /vvAqGnvpQYeFooQ2bkZZUkcH2NiE0GXdTv5aJRiLydl4HR1oKjse7pipMz8YNAy9sO1LhNio7p
 rN0+bNa5N8EC4Dw8+qWjjpIVtTfKJ+5qTq3Ki6eVpe1BqMpf4iTqzVX0qn/iyyrPY4kYW78mYs1
 Y+AH/eOhi8BuKuiCZxzThmyMagVANWH6Vk4yh6UCMfke7Io0cUzPO6+60rwLBNKBxq9DCRmRu1v
 /1pujfckY1BKYLxpJRYmdU/wqtAZRLSisbv/xBEGxEvCr+EdHjFH6IzwtemMkqdpCHqcRseg
X-Proofpoint-GUID: ecFlmawsVSdyxsb1gTwDtinQAFYFWEbG
X-Authority-Analysis: v=2.4 cv=S8fZwJsP c=1 sm=1 tr=0 ts=686e01a7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=PZ2ELaWS3HQQyzacMHMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090049

Add regulator support for the single-channel LTP8800-1A/-2/-4A
150A/135A/200A DC/DC µModule Regulator.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Cedric Encarnacion <cedricjustine.encarnacion@analog.com>
---
 drivers/hwmon/pmbus/Kconfig   |  9 +++++++++
 drivers/hwmon/pmbus/adp1050.c | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 441f984a859dd935e5248793f1bf54204ce2c371..55e492452ce8115419718256de38dda1bd39fd9a 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -67,6 +67,15 @@ config SENSORS_ADP1050
 	  This driver can also be built as a module. If so, the module will
 	  be called adp1050.
 
+config SENSORS_ADP1050_REGULATOR
+	bool "Regulator support for ADP1050 and compatibles"
+	depends on SENSORS_ADP1050 && REGULATOR
+	help
+	  If you say yes here you get regulator support for Analog Devices
+	  LTP8800-1A, LTP8800-4A, and LTP8800-2. LTP8800 is a family of DC/DC
+	  µModule regulators that can provide microprocessor power from 54V
+	  power distribution architecture.
+
 config SENSORS_BEL_PFE
 	tristate "Bel PFE Compatible Power Supplies"
 	help
diff --git a/drivers/hwmon/pmbus/adp1050.c b/drivers/hwmon/pmbus/adp1050.c
index 353758a6ffd69e33203e8d1447accf2c75ebecd5..0c23f53a287bee36d9b4873013556493d8964970 100644
--- a/drivers/hwmon/pmbus/adp1050.c
+++ b/drivers/hwmon/pmbus/adp1050.c
@@ -11,6 +11,12 @@
 
 #include "pmbus.h"
 
+#if IS_ENABLED(CONFIG_SENSORS_ADP1050_REGULATOR)
+static const struct regulator_desc adp1050_reg_desc[] = {
+	PMBUS_REGULATOR_ONE("vout"),
+};
+#endif /* CONFIG_SENSORS_ADP1050_REGULATOR */
+
 static struct pmbus_driver_info adp1050_info = {
 	.pages = 1,
 	.format[PSC_VOLTAGE_IN] = linear,
@@ -65,6 +71,10 @@ static struct pmbus_driver_info ltp8800_info = {
 		| PMBUS_HAVE_STATUS_VOUT
 		| PMBUS_HAVE_STATUS_INPUT
 		| PMBUS_HAVE_STATUS_TEMP,
+#if IS_ENABLED(CONFIG_SENSORS_ADP1050_REGULATOR)
+	.num_regulators = 1,
+	.reg_desc = adp1050_reg_desc,
+#endif
 };
 
 static int adp1050_probe(struct i2c_client *client)

-- 
2.39.5



Return-Path: <linux-kernel+bounces-838298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A40BEBAEE58
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D675F1C5EB8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494781F461A;
	Wed,  1 Oct 2025 00:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UkJlMWNR"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAE81E521A;
	Wed,  1 Oct 2025 00:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759279091; cv=none; b=tMKWMN2n+AdF5ImPKsiEbFgrFm8XLC6sQo/S9g7iQWXf7pREeCDBk0ZwLIi9I77VzKC2nT3PjNCs8YnUMVW8RQp3ZuBU5RHUrv7HW0Sl4zeCGXa0CsbBAGzqkV9vGMdEYFHyPKv7aTjizMQpeA7E9U8rII98NjWk/rlU/jTK+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759279091; c=relaxed/simple;
	bh=UMWqs2khOitWsV/u4aRY+yb3z3t8IP/3pibFACUxx0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=sxVWDS1eMVI10NH15IGLW/JO6mtWntG4l1N2Irj6rhyYLsj94aPS1NNwKcVWSJZp2zXE8X3bdNSnmnWz9Qm5+O6lkcdj8M/1qSE1J/uS1hSvCU3C/0kNm9R9u/40DdfotY1lnamxxOHbhoQ8L4oWf7JQkQG/F5/am4rtnYxZEEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UkJlMWNR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UKRVCo001019;
	Tue, 30 Sep 2025 20:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ddQyw
	sqFxwj83bW+/u8XZwm1+webpmUQVdAWANbCwxg=; b=UkJlMWNRlEINcGhgbseiw
	YRlurR62LfQfHw+ztUXTeOBXLbk2ey7TVtdm732vsUC362rzSm3PqpOunfwMee4T
	9BK2GopDcru2L+OGsxTp8SZRDQjlCTcemKUZWF7lypu7q15+pJzxo/BfGMO4CC4R
	oQ+W5GvEEMXB0H//N8IIC9EL2dCRB5i0fd/+SspHbZllK5uXOplWG5bt3KPXoW6P
	g7IGd2PK7NttA0ckrlQ6CAQgXJJkYYtbfR+C14uUlc/0d5wgpKbO5q9rE9u8qXt4
	TOnn5sHrt+G2P9Wnd9stMenXzOuEFZNH5zCm/wFV9TE85aBRWIgkkOhkvfwy5dYB
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49ecu1vb1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 20:37:55 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5910bsxd061065
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Sep 2025 20:37:54 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 30 Sep
 2025 20:37:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 30 Sep 2025 20:37:54 -0400
Received: from ATORRENO-L02.ad.analog.com (CAV-GBS-L25.ad.analog.com [10.118.9.50] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5910bcY3015453;
	Tue, 30 Sep 2025 20:37:47 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Date: Wed, 1 Oct 2025 08:37:08 +0800
Subject: [PATCH 2/2] hwmon: (pmbus/max34440): add support adpm12200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251001-hwmon-next-v1-2-f8ca6a648203@analog.com>
References: <20251001-hwmon-next-v1-0-f8ca6a648203@analog.com>
In-Reply-To: <20251001-hwmon-next-v1-0-f8ca6a648203@analog.com>
To: Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        Alexis Czezar Torreno
	<alexisczezar.torreno@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759279058; l=7112;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=UMWqs2khOitWsV/u4aRY+yb3z3t8IP/3pibFACUxx0g=;
 b=6hmXOCh8bB+40wr8xgCmkE0IIZYthPLOyqIq96skt174YsN3wRYN5u1zWKdrpKZfGs+8Q3Utm
 jJzgTgt4usmA3hEyb2JOzxhi4eKlSkz5RbHXVynmmI/WK5kWx4fB0SC
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 5angTm86RY-hsWG63OEEbSJvq8BSByZA
X-Proofpoint-GUID: 5angTm86RY-hsWG63OEEbSJvq8BSByZA
X-Authority-Analysis: v=2.4 cv=A5Nh/qWG c=1 sm=1 tr=0 ts=68dc77e3 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=hqrpksVibXk-ru3-KdsA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA4NCBTYWx0ZWRfX9FVDhrBfqsON
 DvD0JEo/hfUX4acvE026dYVZ6fPR+Y1Xs7N5/GnV5bGaiNmZlyZ3D5ho0WUB9wUHJktsQj5OaZe
 auGchNOpLkkjxxW7nOx7oo4Ipxn2eDrLuyxFL17Z8RAukjzy0pzKEBJg2fxlM7nc8HOxzEBXpVx
 JLW9UVW02sOJUqhfSHznkPoHVc6uM3qch0t0RWE9rxmQ8UWBotfRDjfBrASOW+bituwoFWoMvB3
 ivlvXStibFDajhbPG9GqlRCl6qbZpITq1sSmZDABEKF88Aiho3qmnRCl6x0IOed8rP7MpDMdBQu
 CVJtWGRemFYc/qzrzH7gZrybxVomJEkOIA8Tz5YAuIsf9uWI9DmVEOARQJWLix6SjRddZEUeakL
 FwaxkIUtp34J0gerZ+CFl0IBWCBgUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270084

ADPM12200 is a quarter brick DC/DC Power Module. It is a high power
non-isolated converter capable of delivering regulated 12V with
continuous power level of 2000W. Uses PMBus.

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
---
 Documentation/hwmon/max34440.rst | 25 ++++++++++++++++-------
 drivers/hwmon/pmbus/Kconfig      |  1 +
 drivers/hwmon/pmbus/max34440.c   | 44 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/Documentation/hwmon/max34440.rst b/Documentation/hwmon/max34440.rst
index 8591a7152ce580a04b6965301f9bacd9b0a1a661..34a6e0e1b9632c8bae2c2865975297bd54b42f5d 100644
--- a/Documentation/hwmon/max34440.rst
+++ b/Documentation/hwmon/max34440.rst
@@ -11,6 +11,14 @@ Supported chips:
 
     Datasheet: -
 
+  * ADI ADPM12200
+
+    Prefixes: 'adpm12200'
+
+    Addresses scanned: -
+
+    Datasheet: -
+
   * Maxim MAX34440
 
     Prefixes: 'max34440'
@@ -79,10 +87,11 @@ This driver supports multiple devices: hardware monitoring for Maxim MAX34440
 PMBus 6-Channel Power-Supply Manager, MAX34441 PMBus 5-Channel Power-Supply
 Manager and Intelligent Fan Controller, and MAX34446 PMBus Power-Supply Data
 Logger; PMBus Voltage Monitor and Sequencers for MAX34451, MAX34460, and
-MAX34461; PMBus DC/DC Power Module ADPM12160. The MAX34451 supports monitoring
-voltage or current of 12 channels based on GIN pins. The MAX34460 supports 12
-voltage channels, and the MAX34461 supports 16 voltage channels. The ADPM1260
-also monitors both input and output of voltage and current.
+MAX34461; PMBus DC/DC Power Module ADPM12160, and ADPM12200. The MAX34451
+supports monitoring voltage or current of 12 channels based on GIN pins. The
+MAX34460 supports 12 voltage channels, and the MAX34461 supports 16 voltage
+channels. The ADPM12160, and ADPM12200 also monitors both input and output
+of voltage and current.
 
 The driver is a client driver to the core PMBus driver. Please see
 Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
@@ -140,7 +149,8 @@ in[1-6]_reset_history	Write any value to reset history.
 .. note::
 
     - MAX34446 only supports in[1-4].
-    - ADPM12160 only supports in[1-2]. Label is "vin1" and "vout1" respectively.
+    - ADPM12160, and ADPM12200 only supports in[1-2]. Label is "vin1"
+      and "vout1" respectively.
 
 Curr
 ~~~~
@@ -162,7 +172,8 @@ curr[1-6]_reset_history	Write any value to reset history.
 
     - in6 and curr6 attributes only exist for MAX34440.
     - MAX34446 only supports curr[1-4].
-    - For ADPM12160, curr[1] is "iin1" and curr[2-6] are "iout[1-5].
+    - For ADPM12160, and ADPM12200, curr[1] is "iin1" and curr[2-6]
+      are "iout[1-5]".
 
 Power
 ~~~~~
@@ -198,7 +209,7 @@ temp[1-8]_reset_history	Write any value to reset history.
 .. note::
    - temp7 and temp8 attributes only exist for MAX34440.
    - MAX34446 only supports temp[1-3].
-   - ADPM12160 only supports temp[1].
+   - ADPM12160, and ADPM12200 only supports temp[1].
 
 
 .. note::
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index da04ff6df28bd12909c9140662d6b932a150bd97..e1c023d1e16fb0ef87ed653b1406b4abdb1fc495 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -352,6 +352,7 @@ config SENSORS_MAX34440
 	help
 	  If you say yes here you get hardware monitoring support for Maxim
 	  MAX34440, MAX34441, MAX34446, MAX34451, MAX34460, and MAX34461.
+	  Other compatible are ADPM12160, and ADPM12200.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called max34440.
diff --git a/drivers/hwmon/pmbus/max34440.c b/drivers/hwmon/pmbus/max34440.c
index ef981ed97da8def9bf37d67839c8d6d04083e1d4..8ea4e68d4e9de00d5f29516b93ec707c4f862547 100644
--- a/drivers/hwmon/pmbus/max34440.c
+++ b/drivers/hwmon/pmbus/max34440.c
@@ -17,6 +17,7 @@
 
 enum chips {
 	adpm12160,
+	adpm12200,
 	max34440,
 	max34441,
 	max34446,
@@ -98,7 +99,7 @@ static int max34440_read_word_data(struct i2c_client *client, int page,
 		break;
 	case PMBUS_VIRT_READ_IOUT_AVG:
 		if (data->id != max34446 && data->id != max34451 &&
-		    data->id != adpm12160)
+		    data->id != adpm12160 && data->id != adpm12200)
 			return -ENXIO;
 		ret = pmbus_read_word_data(client, page, phase,
 					   MAX34446_MFR_IOUT_AVG);
@@ -183,7 +184,7 @@ static int max34440_write_word_data(struct i2c_client *client, int page,
 		ret = pmbus_write_word_data(client, page,
 					    MAX34440_MFR_IOUT_PEAK, 0);
 		if (!ret && (data->id == max34446 || data->id == max34451 ||
-			     data->id == adpm12160))
+			     data->id == adpm12160 || data->id == adpm12200))
 			ret = pmbus_write_word_data(client, page,
 					MAX34446_MFR_IOUT_AVG, 0);
 
@@ -364,6 +365,42 @@ static struct pmbus_driver_info max34440_info[] = {
 		.read_word_data = max34440_read_word_data,
 		.write_word_data = max34440_write_word_data,
 	},
+	[adpm12200] = {
+		.pages = 19,
+		.format[PSC_VOLTAGE_IN] = direct,
+		.format[PSC_VOLTAGE_OUT] = direct,
+		.format[PSC_CURRENT_IN] = direct,
+		.format[PSC_CURRENT_OUT] = direct,
+		.format[PSC_TEMPERATURE] = direct,
+		.m[PSC_VOLTAGE_IN] = 125,
+		.b[PSC_VOLTAGE_IN] = 0,
+		.R[PSC_VOLTAGE_IN] = 0,
+		.m[PSC_VOLTAGE_OUT] = 125,
+		.b[PSC_VOLTAGE_OUT] = 0,
+		.R[PSC_VOLTAGE_OUT] = 0,
+		.m[PSC_CURRENT_IN] = 250,
+		.b[PSC_CURRENT_IN] = 0,
+		.R[PSC_CURRENT_IN] = -1,
+		.m[PSC_CURRENT_OUT] = 250,
+		.b[PSC_CURRENT_OUT] = 0,
+		.R[PSC_CURRENT_OUT] = -1,
+		.m[PSC_TEMPERATURE] = 1,
+		.b[PSC_TEMPERATURE] = 0,
+		.R[PSC_TEMPERATURE] = 2,
+		/* absent func below [18] are not for monitoring */
+		.func[2] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
+		.func[4] = PMBUS_HAVE_STATUS_IOUT,
+		.func[5] = PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
+		.func[6] = PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
+		.func[7] = PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
+		.func[8] = PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
+		.func[9] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT,
+		.func[10] = PMBUS_HAVE_IIN | PMBUS_HAVE_STATUS_INPUT,
+		.func[14] = PMBUS_HAVE_IOUT,
+		.func[18] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.read_word_data = max34440_read_word_data,
+		.write_word_data = max34440_write_word_data,
+	},
 	[max34440] = {
 		.pages = 14,
 		.format[PSC_VOLTAGE_IN] = direct,
@@ -600,7 +637,7 @@ static int max34440_probe(struct i2c_client *client)
 		rv = max34451_set_supported_funcs(client, data);
 		if (rv)
 			return rv;
-	} else if (data->id == adpm12160) {
+	} else if (data->id == adpm12160 || data->id == adpm12200) {
 		data->iout_oc_fault_limit = PMBUS_IOUT_OC_FAULT_LIMIT;
 		data->iout_oc_warn_limit = PMBUS_IOUT_OC_WARN_LIMIT;
 	}
@@ -610,6 +647,7 @@ static int max34440_probe(struct i2c_client *client)
 
 static const struct i2c_device_id max34440_id[] = {
 	{"adpm12160", adpm12160},
+	{"adpm12200", adpm12200},
 	{"max34440", max34440},
 	{"max34441", max34441},
 	{"max34446", max34446},

-- 
2.34.1



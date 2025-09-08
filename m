Return-Path: <linux-kernel+bounces-806282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FCAB49490
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12763A6466
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1577930F7F1;
	Mon,  8 Sep 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Fey6fkA8";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="eg5pVMlf"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD3F30DD18;
	Mon,  8 Sep 2025 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347135; cv=fail; b=a0npPzKmCucnIbNIh3Vu3o4eSmciGRd/xyct3Ma860wKBiB7x2wjxu1UNCtmhD9A5ocmFLgxk74F9uN3Nxz+RexnCGNHip86HzA7vLv8h3Pm6tfAPj2eJ1UcOJsSPM4xQo6qh8lNZJwfIXovo+7luj6EsC1LMmLB4jxBPyAvz6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347135; c=relaxed/simple;
	bh=An8C+eWTpaJ/ogMYU8+WICytSYEVaLcQ/MNZhlsorAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQKHIlVSedBr6NL0KlBQvzrymp9NFkWBhR+hKbeymzg8dZA0lqco0qTfA/Z0jXt1d/F73oiZlGHiX2WnNqZ+DToN6KLIH5w6Te8g9CkRppdTFliG+bCRusF0RjWgs3kMc4TE3TWd+qA+SSx9ACmxVIatk85e4ub5SfxVCzbSVjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Fey6fkA8; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=eg5pVMlf; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 588FuabP812520;
	Mon, 8 Sep 2025 10:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=1OOg6dO91+A3Knc4yiSKiJxKV3O0GVI5it7rrZy/lwc=; b=
	Fey6fkA8Rpiwdz9UfSZyctj5OxOjwOS7r6unEJJFJHAmzwm3FZy61NwlR85/+JDp
	nI8M3ui4TYWs5lI/AKvvcGxV9k868vhmoTcVQpS4BrXB6HaI3HpPderOYEmsmmZV
	MP5tXjh2vr2lOoeZs28fGeck/+a/YNLDs4RxinmuMJ7ugKSDbEe3VCnbmDKJ5dtZ
	XuLSSsSfW3i8rSoqKQk01amY61UwldHKdCoXtxtyNbRMNJ88LeK1O7mndExx7dYC
	EriEJUcJTjHvUBsrp4GfgTnhn75Mw4yurbYJkD+T5a3xwPpa7BD7G+jrzFn5B3v7
	gZqjyIF/NoAPVuoGBzjb1Q==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2096.outbound.protection.outlook.com [40.107.237.96])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49227r803q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 10:58:50 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+FmXvfOzMrRC/I+sRdvacky1py6tupqGhmJ4mtkscfTAY5PJsRGQy+1IBdPItuqo7cz+K83q0F/mwy/a6lN27c0c+5hrYIGr1iPtZH7oUp5fds12WdiJUPbe9HEsz7Js2ev0bLW61asC9baoT9DKXt8i+0Widl//F4zDWKx/n44O4HHF/zjJDxD+HFzIeLjcR4TwxYwJlMxJ5ndm9mAauIAymMFBndePlcqrG7qAc2PZcHXtJjhc+9MH+gmTuaqceofJyt1OQnMT9leCj4IGbqdPaokjHY2seOKuEVoa07tP3AfJxY9qD2OfO2FKKingphQd6j8WGKL92aHsnesew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OOg6dO91+A3Knc4yiSKiJxKV3O0GVI5it7rrZy/lwc=;
 b=GGp5AdmjjOozWaRQT6K4rqq1+tCiy0T2h4ZTBgRqE2/ZFL72qr0Yu4Jw1XsgXDsKB23zYmh+D5qA4uM2QCDK93RXmUbhQd6KzIvf3J752bH6ryNzHmoJRpswEgCApaWq9arQqeUKY9iydFFAbVszHFMiGmJPnoaC0/jbkjsb7s8/9VS/VbPRj8e7oBWScrAeHjt7l94ZVCgaysVLskaUHG+X+oseehaweHXxXCGHdysKVvaFlZYHEaGNiuNtuKP2q7oyd9HCuXv35WpDxGm+8L6n/SXQznHV/XJYgP7TngK9GshBLNws+8eEeF3Md/HcPVABitaK+S4lRxA3ixGqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OOg6dO91+A3Knc4yiSKiJxKV3O0GVI5it7rrZy/lwc=;
 b=eg5pVMlfXhB7RbAGkwP1oBLS1Qcz01mWDq0h2mnAL4Xgs0elT/825Q2zZ21GaqU15FVHuUCmPWGnt3W3LFjZt3JQhAltCWtt7g19P890kCKWBjP0p6J6O0zei48cZDh8msPtF0HWXDdrTedAwCksFqbk4jnMk8MIQE8Fmb/sxLU=
Received: from CH0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:610:b0::25)
 by CH9PR19MB9347.namprd19.prod.outlook.com (2603:10b6:610:2e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 15:58:47 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::5b) by CH0PR03CA0020.outlook.office365.com
 (2603:10b6:610:b0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via
 Frontend Transport; Mon, 8 Sep 2025 15:58:46 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id A943340655A;
	Mon,  8 Sep 2025 15:58:42 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 99F7982025A;
	Mon,  8 Sep 2025 15:58:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 6/6] ASoC: cs-amp-lib-test: Add test for getting cal data from HP EFI
Date: Mon,  8 Sep 2025 16:58:42 +0100
Message-Id: <20250908155842.599459-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250908155842.599459-1-rf@opensource.cirrus.com>
References: <20250908155842.599459-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CH9PR19MB9347:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f17a18a9-92f5-4685-df7d-08ddeef09812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C1aby6KFUVTyCvXcMlr7AaV+PNXzvBUIvP4rovktDoQkdVZ28S62w8V/poOe?=
 =?us-ascii?Q?YFLyDTH/irjiwh3woguj+KIKAaRRHnNKm4h7H9JyD5peSWwka/xdWs15DLrc?=
 =?us-ascii?Q?pOwM58kzd0zSnQDmFrCs2ip0iJfgkMQGXAIxYqrHYgLllj/9kaSCx6vlEi/u?=
 =?us-ascii?Q?8mxSTa1OtVL9i4rmznp6vIoUU5x6xWNr5YvdeL3aL6Hbh84vrGKhkALxK0K/?=
 =?us-ascii?Q?lO1/3ozvI2q0jMNsA+ZYnny3831Y5LrsrDlw9kBI7rCpCrVgi2rUftAf+b69?=
 =?us-ascii?Q?66p8gw8/nEmKal4zcx0VUNFwIkXlhfBermBnxC0zWYy1LMF0yRnkd4pwDGtT?=
 =?us-ascii?Q?yJIuH8XCrrsJLQKQZhuf6lD66oktk4AZpx8WLxP1dysF3YWaaWLE6KLZPB/J?=
 =?us-ascii?Q?WFo3OdqjiV5jmXD95XmqeoNUpbtbozUVlmfHcuP6UwsKjHrFSHtVIuVWZpn3?=
 =?us-ascii?Q?iKx5IJr31+VSTyuGKItAFMqsRtGFvpr2qYppU1C5EPx2czMgHj2RIXZYOZ2g?=
 =?us-ascii?Q?g/0MRUp1fnUkJX+YZmDQ9mYsdEw4T4/ssIij+uWmkGX757+1N1w00Z1g8wEt?=
 =?us-ascii?Q?rqvS9k9zefGcAbZBWAKABMWjvMRTIs2hu8fPYotdKkb4vJS3wQOVQ5TpuKcJ?=
 =?us-ascii?Q?ASe1G0mbj/s0spuJ8Zo3uV8BmYAMkgHn31pPi11kRPTzfZsH7mVC36IJ3kN5?=
 =?us-ascii?Q?tYgiz720SaSlRrdQ9H7VVhy4QQdR0MU+gqDFu5ZH6Dg8gi7zUp/NOVXtBZCF?=
 =?us-ascii?Q?SpECdM6GJMQ+IVwpdeYXL9dMaxDPV9SK9VCBJUDEJ6+h27eSnta1nlWL2/fM?=
 =?us-ascii?Q?+V9Vl5X81OD0utuSXl0Llk50J2nDVdB1ZEAbq/heoBvLmbz4OGZBYtnHcgsK?=
 =?us-ascii?Q?2l8ib59Zq1vzgMbh+Q63RIORDlXSmGmBDq2Cb2/C5UtXZVACXaJfNdPzk8HS?=
 =?us-ascii?Q?rUsCI8R7xLY4Z1UGkGM/qMCBohKyLEuTMejry0eeMU5swp5s0W7eTjltCqAy?=
 =?us-ascii?Q?QiI88UV6Pn9LjgsWfCggSbR3/Hf93CCQoDIL/dm+YNZJOj2g+ZGC9myE9+t4?=
 =?us-ascii?Q?U2qKQsp3qDaT+yfgeeFaujeemkttOBIEwoTJfsabqDBeN0jD22AZEvcg54xL?=
 =?us-ascii?Q?iU7X2/ut8jwk0Lc+W4ak4OSWPndZYh8ufpd/f5Fc5esUImmXTqI7iySdERcp?=
 =?us-ascii?Q?g6ncMwed3JZQL3WkQrcEg7QH4Wqj2+mBHFlYT61llMOHxi67RXxbQJEEUdEK?=
 =?us-ascii?Q?pWfe8J4mZ+nLQJmHrmaefzm7nPEpOSZPrv6gAAwdCv4eJBigabwy+rLxDEZC?=
 =?us-ascii?Q?vi7tyCMRxODJ4miipIIBBTuR11c1anavZXf/aSN9ltEmv89UP4PtjN2eZEjS?=
 =?us-ascii?Q?Et06a/QxDyBO+rgIOnlPjoYJ5TURm0PRdaaP1quif6BXG+/N9KCgus9cjac4?=
 =?us-ascii?Q?/cZgI7Cd2BZzqPaMpAUR0WlnRho48ToaQOt0D27ujDr7u4licatbA8FD+QaZ?=
 =?us-ascii?Q?ooyuUWzJh5K5QsbWlXpg2IwMzDev8SPIAQge?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:58:46.4371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f17a18a9-92f5-4685-df7d-08ddeef09812
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR19MB9347
X-Authority-Analysis: v=2.4 cv=f+FIBPyM c=1 sm=1 tr=0 ts=68befd3a cx=c_pps
 a=XYC6++eb3LU7Tn/YozfASw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=erahUydJdZyVaCJA8SoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1NyBTYWx0ZWRfX2/OGR+71K6hv
 +/G8idgck07BDIBZcw5JP7EAnjwNid/Ss/BlD9Ue/xjDPg0F3PDC3YSaB9ksiYT47UG4/bQDMcw
 MsR47ZJqWwSy6Xqd1goxGYoNq3zZvk0xS0vJ7JwRj4aX9Cy03vUNmBA4N64S5i+7dARxCyG0yWe
 5NUcGuUAKFzDeewpBimmFmrUIc4xDGaWaPAb5kQQGnkHdR/yjJapR9xVHEKa9MnjqqpJ32a/HvF
 xHaM0F3+IGJdI1B4fyLeWy9rLGTx7e7fA0GMNLCVY9ST6SHkDXa/w+7oHIFreDITsHvjmRJzhXn
 ZzR7dzoA//1g/Zyzc6Ot55boTR0kF+Fvql4xj2C0t8du7gXB+iyM1zbJ84mHfw=
X-Proofpoint-GUID: YBAObZCsIwCGeP4AjX_6DrNwW3HdWbhg
X-Proofpoint-ORIG-GUID: YBAObZCsIwCGeP4AjX_6DrNwW3HdWbhg
X-Proofpoint-Spam-Reason: safe

Add a test case that cs_amp_get_efi_calibration_data() returns data
when it is in the HP-specific EFI variable.

This uses redirected implementation of cs_amp_get_efi_variable() that
only returns data if the passes name and GUID match the HP EFI variable.
A simple test case installs this function hook and then checks that
calibration data is returned.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs-amp-lib-test.c | 53 ++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/sound/soc/codecs/cs-amp-lib-test.c b/sound/soc/codecs/cs-amp-lib-test.c
index c090498cbf78..02fb28edd985 100644
--- a/sound/soc/codecs/cs-amp-lib-test.c
+++ b/sound/soc/codecs/cs-amp-lib-test.c
@@ -220,6 +220,58 @@ static efi_status_t cs_amp_lib_test_get_efi_variable(efi_char16_t *name,
 	return EFI_SUCCESS;
 }
 
+static efi_status_t cs_amp_lib_test_get_hp_cal_efi_variable(efi_char16_t *name,
+							    efi_guid_t *guid,
+							    unsigned long *size,
+							    void *buf)
+{
+	static const efi_char16_t expected_name[] = L"SmartAmpCalibrationData";
+	static const efi_guid_t expected_guid =
+		EFI_GUID(0x53559579, 0x8753, 0x4f5c, 0x91, 0x30, 0xe8, 0x2a, 0xcf, 0xb8, 0xd8, 0x93);
+	struct kunit *test = kunit_get_current_test();
+	struct cs_amp_lib_test_priv *priv = test->priv;
+
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, name);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, guid);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, size);
+
+	if (memcmp(name, expected_name, sizeof(expected_name)) ||
+	    efi_guidcmp(*guid, expected_guid))
+		return -EFI_NOT_FOUND;
+
+	if (!buf) {
+		*size = priv->cal_blob->size;
+		return EFI_BUFFER_TOO_SMALL;
+	}
+
+	KUNIT_ASSERT_GE_MSG(test, ksize(buf), priv->cal_blob->size, "Buffer to small");
+
+	memcpy(buf, priv->cal_blob, priv->cal_blob->size);
+
+	return EFI_SUCCESS;
+}
+
+/* Get cal data block from HP variable. */
+static void cs_amp_lib_test_get_hp_efi_cal(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct cirrus_amp_cal_data result_data;
+	u64 target_uid;
+	int ret;
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 2);
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_hp_cal_efi_variable);
+
+	target_uid = cs_amp_lib_test_get_target_uid(test);
+	ret = cs_amp_get_efi_calibration_data(&priv->amp_dev->dev, 0, 0, &result_data);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_MEMEQ(test, &result_data, &priv->cal_blob->data[0], sizeof(result_data));
+}
+
 /* Get cal data block for a given amp, matched by target UID. */
 static void cs_amp_lib_test_get_efi_cal_by_uid_test(struct kunit *test)
 {
@@ -910,6 +962,7 @@ static struct kunit_case cs_amp_lib_test_cases[] = {
 	KUNIT_CASE(cs_amp_lib_test_get_efi_cal_no_uid_index_not_found_test),
 	KUNIT_CASE(cs_amp_lib_test_get_efi_cal_no_uid_no_index_test),
 	KUNIT_CASE(cs_amp_lib_test_get_efi_cal_zero_not_matched_test),
+	KUNIT_CASE(cs_amp_lib_test_get_hp_efi_cal),
 	KUNIT_CASE_PARAM(cs_amp_lib_test_get_efi_cal_by_uid_test,
 			 cs_amp_lib_test_get_cal_gen_params),
 	KUNIT_CASE_PARAM(cs_amp_lib_test_get_efi_cal_by_index_unchecked_test,
-- 
2.39.5



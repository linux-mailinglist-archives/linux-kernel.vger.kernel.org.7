Return-Path: <linux-kernel+bounces-806281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8551B4948E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDE81BC1504
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9368C30E82C;
	Mon,  8 Sep 2025 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="FV/g+Oay";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="nXBCrP1T"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12253054ED;
	Mon,  8 Sep 2025 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347133; cv=fail; b=nRGL/wH2QZVHMoXxv11BwoivoPyIIIxtKpNYtxcWDZbUtv16ctzoZz9G7CDftTW4DhGmCS/YmW0rDrhYD7KlxzyqT44rQoETrSU+OQnbky9NUvoBeJ9k2BmySb1H9VeENG+ymNtxA9NyOlb27iDrgz2msAV0Olj42CvxiTLg3TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347133; c=relaxed/simple;
	bh=Fk/a1g+io6oCMJJhpgA9T5RQsVgVkoIlfN9T5kxfpP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOgmsMEMmpm1exoHUtwdAz9sTCmwp9qcuo1JgW+nsMuEdQLzzLSxYtcYjITqp6I+KVc14dhYbkcapxTxoMu7Hz4tXXp4u9tg63WXmpL0WBJCyf7491ae5R0sLX6AByZadrxlOtsMBwnDvU6246vv4oJCC8gX5XBFOfVO2Sy1tuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=FV/g+Oay; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=nXBCrP1T; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 588FuSli812009;
	Mon, 8 Sep 2025 10:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=APpcDRBfdcj4G2DWvBwtmFIgJYnpYz7AKZvkufUY1mI=; b=
	FV/g+Oayyxw06iFfZxoMJFCGAFyJwdNhEAzAwzqCsqU1cl8vNiobR0PJqhwZjobM
	Nqv00wQ4oEm68SsblSAo1Eyez7e3c2Wud6M+CoVlFafgosfkbnC709x+ZBecD+ld
	yNKsq75o9VVEz+/T69YGgXssXfgYUAlWepwt21VYjjCEYncFx0cV+gJ05n4m3mq0
	/g/0mlYJwLmvPw6/XY0G7ZRFdnk0j6+vBD6i/qNnx66m5iARu6LSFfbnW+UkPSHH
	ivc+Kq/Ud5UM2M8YVrIwMeUhh991Z7YxW4qV6TgfdwMrZnPbldRS0RA8+1aYZ5uv
	1e2sFQCyldEaQcbUdMheGw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2123.outbound.protection.outlook.com [40.107.93.123])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49227r803n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 10:58:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aipZPSOVEENmCd4ZipLXYL3uisgVLrSw2tXHQReehrEXSHVoT95L67Y+3IRe3KwuI63JuZ0xG6dYYi+3d4G9McQFK99ZOeUBkwHX9eNHkfQHomREvWJVL+HCeUJ1Xy01CI33tR9FGhlBaI1+3dgc+y/984k3FkqKEO4Ixwu8vtibHG6klU3uEsuLLs0shLfDeXuDJ+5vMkZsKe3vZaz1u8r0woK70lyzAEWTxBF+DQfGIkUcQmyo16GPVyQQMrraSMYtk5n1nOTVUorpXxvTGiZ3K3WKw86cy4OsyzAH2PxcmTX1dIOvFhG7u46MeEsdOQsuLTrVKMjzYda9mb4Djw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APpcDRBfdcj4G2DWvBwtmFIgJYnpYz7AKZvkufUY1mI=;
 b=hOU+1iwzQqSvbx8FF+sJSlYfYgoOLjdqJvdYQv5s8iVK08AVriVa6SNSfzSya/s8qo1hn5dvNzVgvMmvvlCHG9QsLWms7L2kwCpg4AUPs7daWkatMVJU2eUeK66dyT4gkbWUgtLff8puZF9cvnq6ealcV2trXW9T9K0kNRZJRsvRNyRNYP9UcZyvaT7JpFsUJoMMl/K6lTsLMIUsYeEJ7wwTiXq3Hk9qvu6rjuoQtQ8eiepUII9w3wwPpa+CRE00MrIlIwlNHZxa5DJQflYLytjmqSUk2mWWX7RFkr11FSgwR7eBRIeW4z9HqKe+egdySDbt7pDC0h2FaE1sIesjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APpcDRBfdcj4G2DWvBwtmFIgJYnpYz7AKZvkufUY1mI=;
 b=nXBCrP1T0ib+lMmNlGf3d9p9dUuef5mp6jheUE6pClvo69ZC2cOUw6Bd1Pswno8W9j7Q6I5pyzns/XXQ/gpMx8CS5616qHc9bQpziiuhfYjlg9Q0LDsc2mPwAoT4vNBeXKrI+mSMW1dR00pOPkn3aVt7tt85Jz3aRDlX15A6XX0=
Received: from BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::7)
 by PH7PR19MB7512.namprd19.prod.outlook.com (2603:10b6:510:26a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 15:58:45 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::5) by BY1P220CA0020.outlook.office365.com
 (2603:10b6:a03:5c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 15:58:44 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 9396C406545;
	Mon,  8 Sep 2025 15:58:42 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 842EF820247;
	Mon,  8 Sep 2025 15:58:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 2/6] ASoC: cs-amp-lib: Add handling for Lenovo and HP UEFI speaker ID
Date: Mon,  8 Sep 2025 16:58:38 +0100
Message-Id: <20250908155842.599459-3-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|PH7PR19MB7512:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0770d830-2258-4339-b991-08ddeef096c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lf7Y6nztSqw4iXXmbLNA2jpKo/OJstRgaQRtIbNNoxY3hPtqEHZrCvkw8MBH?=
 =?us-ascii?Q?WVry61YO5FTFG7uX8qxoD16ClVF9lrhHFjXRYXnfp2tQ5RUca0PbI16X7Oi0?=
 =?us-ascii?Q?UKKz/rXde0zJOZesD7Qa04NQScXaNHzPh6XrSz+i5xqSfRVn82WYCqI1veyx?=
 =?us-ascii?Q?vna1r9w4ovTdqMkiFLYFE5Cx5jQJNbkgIkbosegw9Y7pyJFwt7sHgG1JMnbW?=
 =?us-ascii?Q?nCXz29GyZjOA2N8Bx0GisASw4iaCGSKzJ9QksUmD1lfnzCRAmNvPpWJRmfHz?=
 =?us-ascii?Q?H37Gzdzn+3DBAI/UIJ3vSIDuTmMcllSxGeprOqvUeQ1dzXb1EPu51JA8TjXp?=
 =?us-ascii?Q?4I+PeuKB2wcXmHIhzRP+Bolqh8tXuQovjiznVTKtXS4JfONi8WQKcGWxkltK?=
 =?us-ascii?Q?55jjPdhO7dRMkeyGoLg7+LkDCIinOnWIXcGd40N7XwXhXZfCLTg9Ml91Lsoe?=
 =?us-ascii?Q?H40IgdSf3AlPGWS4myVXkgKaUxfjECmA1B0vSUemkkpeQEhfCGJaaTELOde4?=
 =?us-ascii?Q?5qtscFYxPGkytHkjsAIJ6fAWOSKYm+e01jZK2f8kpl4SBsT1neov0EUEm5g0?=
 =?us-ascii?Q?eOrxk7xWQar3EM3ui5ZFp3S+Tt2e38alJsRfOvrLEdY7wwBtpQcwx0pu6tIR?=
 =?us-ascii?Q?0KSz59o74oS5XKpxJcPV9NXBHm+OCJSTskNeU//t/DLSij2CQGDzHXtYtGsQ?=
 =?us-ascii?Q?OxKSgAxX6b2Sy9UIg5ByQVMArfkclxskQc8xvpW1OLaVl9hQ/IDmgKJgOs3o?=
 =?us-ascii?Q?4mqFb24eUDZwaihXbDRZehPJQhz39zg2MwR0QGAh6dKqOp04RnJ4VUcZBMXQ?=
 =?us-ascii?Q?KSyiqfKvCW9fBJGWdY0BUZdkLn3eODoo15oFj/oHQ44r3i16c2dySdcyQjkL?=
 =?us-ascii?Q?ULy1DNStOXchp1wLPzPR+M6WVBQneI2wZ0efTBD4HEAAWkke9mGz61lmXC1Y?=
 =?us-ascii?Q?F1g/lQxaDlGzQUH6/L46rCu4U896g2cxwp6gNEseTq/0GLMPNRK3buqJw/a1?=
 =?us-ascii?Q?HvBBk7jbJt2xq+HWjGeRZhGxsdih5o/ecjkdyu5ZQEzOvBjnrgqkTag1NHdx?=
 =?us-ascii?Q?usugfSCW5Oo3CV99lyyRPW2l9dkmrhA1jbB4kmYPyq41blXWi3e2fZG/sLyy?=
 =?us-ascii?Q?xcQekfoKiNgb0cdNXdomiml+Jz303dVRpkZNffXL2LA46bKbJ+M7Qq4K3nqC?=
 =?us-ascii?Q?apcV+DBYRxLDh02FnJLA0HRsf2tMJZYfKqFcV5OQeR2iO18nmRix/+MtuHOS?=
 =?us-ascii?Q?wS26+FcXSdh8JrDTDT9olDjK9B4KwkIlw1gMlb5Z+Sn/DwZDrgh32YSNHvCz?=
 =?us-ascii?Q?ShvwG2D98BS1RwOv61Fpq/J8vAoW0v3K2Kyxv3wJrG6aPbHopyCrKvkZwKmt?=
 =?us-ascii?Q?sWaz06edngeGnvaFe1BCRcDMMG+/4GrMwroMZMleH6uoMj2QTOwe4p6gDd0H?=
 =?us-ascii?Q?myhCRM7p3CTFMM52UXJhClk9iSz5SMcHzVmeyU7XMouhv2L3MeMKzp4x9I1S?=
 =?us-ascii?Q?gCjb40TV8K6RYuT224aW9jsWnFsOI2AvYXSC?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:58:44.2491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0770d830-2258-4339-b991-08ddeef096c9
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7512
X-Authority-Analysis: v=2.4 cv=f+FIBPyM c=1 sm=1 tr=0 ts=68befd38 cx=c_pps
 a=i3ALAGCV60MuQowHJNr0Ow==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=wKYcr39KdBWZLYmsaBcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1NyBTYWx0ZWRfX1vb/21ZISmYs
 fPnqAL9Yi5O5DsOXqMomXocdvPzgGrH15DPetM4nTcIqz4nSLJwMeQKsW7JDL/fB+sKka1UpiEj
 wxOmF7Ze5dG+Yu/Ak3X3du0GROv6VW4+CYGJBojspmA0vSaY60qoc2C/5loZRWiIoSTJXX0dbZ8
 vVwgqzPaJaCuZbbKgibd2op5ApAjcFinYR960yz87RST/wRo7h8luKNV+40Ug/3+xW+czjyvgtE
 cDQo74l4kfvawUQTZehyqTqQ3vA/UGgaPQ/yIFaJDHuep4+64VgQLZYQI6ZVH51utGbTO6Dd/qU
 8brUpbLtASxNaHren/56r5Lc3j9KYOxATSwxuWH/MmKrZXh5FXaXE+UC4WIRpg=
X-Proofpoint-GUID: SoNqzVfbBg_CkhuZygV4sA4_uX9zTTpV
X-Proofpoint-ORIG-GUID: SoNqzVfbBg_CkhuZygV4sA4_uX9zTTpV
X-Proofpoint-Spam-Reason: safe

Add handling of the Lenovo-specific and HP-specific EFI variables for
speaker ID.

Future Lenovo and HP models will not give the codec driver access to the
speaker detect GPIO. Instead, the BIOS will read the GPIO and create an
EFI variable with a value indicating the state of the GPIO.

The Lenovo and HP EFI variables are both defined to have only two valid
values. But the variable name, GUID and values are different.

This adds a new exported function cs_amp_get_vendor_spkid().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs-amp-lib.h    |   1 +
 sound/soc/codecs/cs-amp-lib.c | 101 ++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/include/sound/cs-amp-lib.h b/include/sound/cs-amp-lib.h
index 5459c221badf..43a87a39110c 100644
--- a/include/sound/cs-amp-lib.h
+++ b/include/sound/cs-amp-lib.h
@@ -49,6 +49,7 @@ int cs_amp_write_cal_coeffs(struct cs_dsp *dsp,
 			    const struct cirrus_amp_cal_data *data);
 int cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid, int amp_index,
 				    struct cirrus_amp_cal_data *out_data);
+int cs_amp_get_vendor_spkid(struct device *dev);
 
 struct cs_amp_test_hooks {
 	efi_status_t (*get_efi_variable)(efi_char16_t *name,
diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index b1530e7c75e8..9b51d056d863 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -20,6 +20,14 @@
 #define CIRRUS_LOGIC_CALIBRATION_EFI_GUID \
 	EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d, 0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3)
 
+#define LENOVO_SPEAKER_ID_EFI_NAME L"SdwSpeaker"
+#define LENOVO_SPEAKER_ID_EFI_GUID \
+	EFI_GUID(0x48df970e, 0xe27f, 0x460a, 0xb5, 0x86, 0x77, 0x19, 0x80, 0x1d, 0x92, 0x82)
+
+#define HP_SPEAKER_ID_EFI_NAME L"HPSpeakerID"
+#define HP_SPEAKER_ID_EFI_GUID \
+	EFI_GUID(0xc49593a4, 0xd099, 0x419b, 0xa2, 0xc3, 0x67, 0xe9, 0x80, 0xe6, 0x1d, 0x1e)
+
 static int cs_amp_write_cal_coeff(struct cs_dsp *dsp,
 				  const struct cirrus_amp_cal_controls *controls,
 				  const char *ctl_name, u32 val)
@@ -114,6 +122,24 @@ static efi_status_t cs_amp_get_efi_variable(efi_char16_t *name,
 	return EFI_NOT_FOUND;
 }
 
+static int cs_amp_convert_efi_status(efi_status_t status)
+{
+	switch (status) {
+	case EFI_SUCCESS:
+		return 0;
+	case EFI_NOT_FOUND:
+		return -ENOENT;
+	case EFI_BUFFER_TOO_SMALL:
+		return -EFBIG;
+	case EFI_UNSUPPORTED:
+	case EFI_ACCESS_DENIED:
+	case EFI_SECURITY_VIOLATION:
+		return -EACCES;
+	default:
+		return -EIO;
+	}
+}
+
 static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 {
 	struct cirrus_amp_efi_data *efi_data;
@@ -276,6 +302,81 @@ int cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid, int amp_
 }
 EXPORT_SYMBOL_NS_GPL(cs_amp_get_efi_calibration_data, "SND_SOC_CS_AMP_LIB");
 
+struct cs_amp_spkid_efi {
+	efi_char16_t *name;
+	efi_guid_t *guid;
+	u8 values[2];
+};
+
+static int cs_amp_get_efi_byte_spkid(struct device *dev, const struct cs_amp_spkid_efi *info)
+{
+	efi_status_t status;
+	unsigned long size;
+	u8 spkid;
+	int i, ret;
+
+	size = sizeof(spkid);
+	status = cs_amp_get_efi_variable(info->name, info->guid, &size, &spkid);
+	ret = cs_amp_convert_efi_status(status);
+	if (ret < 0)
+		return ret;
+
+	if (size == 0)
+		return -ENOENT;
+
+	for (i = 0; i < ARRAY_SIZE(info->values); i++) {
+		if (info->values[i] == spkid)
+			return i;
+	}
+
+	dev_err(dev, "EFI speaker ID bad value %#x\n", spkid);
+
+	return -EINVAL;
+}
+
+static const struct cs_amp_spkid_efi cs_amp_spkid_byte_types[] = {
+	{
+		.name = LENOVO_SPEAKER_ID_EFI_NAME,
+		.guid = &LENOVO_SPEAKER_ID_EFI_GUID,
+		.values = { 0xd0, 0xd1 },
+	},
+	{
+		.name = HP_SPEAKER_ID_EFI_NAME,
+		.guid = &HP_SPEAKER_ID_EFI_GUID,
+		.values = { 0x30, 0x31 },
+	},
+};
+
+/**
+ * cs_amp_get_vendor_spkid - get a speaker ID from vendor-specific storage
+ * @dev:	pointer to struct device
+ *
+ * Known vendor-specific methods of speaker ID are checked and if one is
+ * found its speaker ID value is returned.
+ *
+ * Return: >=0 is a valid speaker ID. -ENOENT if a vendor-specific method
+ *	   was not found. -EACCES if the vendor-specific storage could not
+ *	   be read. Other error values indicate that the data from the
+ *	   vendor-specific storage was found but could not be understood.
+ */
+int cs_amp_get_vendor_spkid(struct device *dev)
+{
+	int i, ret;
+
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE) &&
+	    !IS_ENABLED(CONFIG_SND_SOC_CS_AMP_LIB_TEST))
+		return -ENOENT;
+
+	for (i = 0; i < ARRAY_SIZE(cs_amp_spkid_byte_types); i++) {
+		ret = cs_amp_get_efi_byte_spkid(dev, &cs_amp_spkid_byte_types[i]);
+		if (ret != -ENOENT)
+			return ret;
+	}
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL_NS_GPL(cs_amp_get_vendor_spkid, "SND_SOC_CS_AMP_LIB");
+
 static const struct cs_amp_test_hooks cs_amp_test_hook_ptrs = {
 	.get_efi_variable = cs_amp_get_efi_variable,
 	.write_cal_coeff = cs_amp_write_cal_coeff,
-- 
2.39.5



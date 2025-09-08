Return-Path: <linux-kernel+bounces-806279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF23B4948C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A26516542C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2548630DD11;
	Mon,  8 Sep 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CTIOEPlt";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Kmwx2290"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A5B1DF26E;
	Mon,  8 Sep 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347132; cv=fail; b=GGWpHtivhofszKA0fyrpBw/QHJJfTeAGSrVVmQi0ozmovABUr1zYLgitlsSrhL17l/9RsJDJzB1NLt6p2EdtLBc/52Et/RevRxiRRRYSobb0Rn7WkzmbfnPKbqyoyekuToqjKzDap/jw1FZU7ripa8DKPVyVZ/4VaQRWuwxx/nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347132; c=relaxed/simple;
	bh=h4asHsCQOd2ufeDF7SvrnC4iax+TSSl8XbpivmHl4CY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdHN4nHVV2AdUkxAMsv0/e5y2p/UcctNw1wW161krHlbjgOV/4aCfYo2uZO17u0KdU/WhSTVRnBjoKyu65Oo2NR7kDvd/VyThmYIgnq1sc1iIO/QEe9R7jU1Vv/zO0sM2sqWIe49FaBsWp0JRGizyKdLrsJ/vbzdeK18xL/v920=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=CTIOEPlt; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Kmwx2290; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5888UNUu2151861;
	Mon, 8 Sep 2025 10:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=UPXyvMD/Dhb+w7dbOEt9OnP0AsfSESzw2yqkmnbfxyA=; b=
	CTIOEPltB9eP5zDomijeWodF8Mb2LFFhs6Yz6xtqNk3tp6ch0+ButCQunB+DlMcl
	rwNzxey3kxN/KLjMSd0r4Z6P5wTWh49DFUpAStZv2+U6tsQNv0HyjnLj2yxuX7WM
	ncGJRPwPC5AkVDiUD31NlEPygAwIL/MU9qvWs6lHTHBVvEwc7eEskp3VO7vJ4yZs
	wfsSJqAOHCgj9m1xKdtRL5i0mfBCs4bBhErhGxVcRvRmPWYry5YG5xqcprchg/ID
	oHT3eB72nXAWFIOb+F7cJPOIGJIRHjjKKtl/ZXB4zrxL1ATm1mbIOT+hkCxTNKUG
	OFVO0toNrugy1eddUAtBtA==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2091.outbound.protection.outlook.com [40.107.101.91])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 491upq8gr7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 10:58:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKTp1ei0ubQOhJZi93S3GlEdKXUMENJMSSAdVCQbkLAqXfq7fv9GAlBeDx6SHlIETcpfYFfpgYd3lvgAk4huiMTY25K6uUKwSBG4ZPyvLlNHErhbXBGmp1rXPZoSwhVOu8fECPGUbl5y/sQvLpQ6dXkSkv9MifYa02lOk8bDDaKGm0k0tKJjyNB9L423Zfl5xMYGIQ1a7IR1V3Mg57HG9adlMmWzE6RhS1rEp3JXuMcg1i9aZoEtUhl+jpAyae24HzGrIO/S1fKs1Kt4wXY1lE08SrLAClkkDTh2TeSWsFjzIgkL1dYRE8QEn76ucugIZYQizF9pMqrN70utyKCrPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPXyvMD/Dhb+w7dbOEt9OnP0AsfSESzw2yqkmnbfxyA=;
 b=QBSSjxnijLlgExW07vWJJFC6PS4HRkDR7dYKDvaK46LQL2BSZNr29jiPWZVIJdzIDlb9UsfKUfiO3kwwB2lPNqI79N4rl3TI3uFBK7pE1kVfBSoL4FwCz681bFzuqDOttUGgSsIFMJYd9o0QhUGBij+HMP5hHdzrUJ+CvO4Jmg2K8rx6dFsfisWBNQ8Zoz1LiVCaDyLpew5XgQzlXGEPiTa/QWlqipbs3PGKzuf9s7Ckk7NMOFkWdvWn81i21oyFPoUB+xOjlAF82Sr3khx9/1VFvk4bhZIqLyqRYXUlyK2LqcFA14oYa2SYRA2rwjG5la+Alm7iT0AOTZEQMgUMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPXyvMD/Dhb+w7dbOEt9OnP0AsfSESzw2yqkmnbfxyA=;
 b=Kmwx2290lNhAsMcrdasiRnDFJo2d6eKE822bNbirCQsJv6ve3aUopiKPW7nOJoe63NljLNe9ocH7y53/+zD2N+EacgP3V8CVvS8H8qPaBTDyPjP9vebQdU70IfYwnPFW5OJBWTaNT5Rs8rlcDHVeYKzx+vMqaSd8kHv1vwLh8kQ=
Received: from CH0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:610:b0::30)
 by SJ0PR19MB4591.namprd19.prod.outlook.com (2603:10b6:a03:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 15:58:44 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::fc) by CH0PR03CA0025.outlook.office365.com
 (2603:10b6:610:b0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:58:44 +0000
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
 Frontend Transport; Mon, 8 Sep 2025 15:58:43 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 8B842406542;
	Mon,  8 Sep 2025 15:58:42 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 775B582025A;
	Mon,  8 Sep 2025 15:58:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 1/6] ASoC: cs-amp-lib: Rename defines for Cirrus Logic EFI
Date: Mon,  8 Sep 2025 16:58:37 +0100
Message-Id: <20250908155842.599459-2-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|SJ0PR19MB4591:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ebc04435-afa8-402e-4fca-08ddeef0967d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CVFL6xyZ1b9kdzoy5A0NdqVev34fcd+qYjFsFlE9gR1s56piRvBYhHZ5F8PY?=
 =?us-ascii?Q?tN83CiMw2VEnEK1RJ71fWC1Td/6L6ex4y2ZNUm4hbrdirxdGYGudoDtHbzbN?=
 =?us-ascii?Q?n1dy9wYuhg6+6e8AETOEB+xtAAMkPBZwxP8F5hD+AES+scvOeqzWs+0qRuLc?=
 =?us-ascii?Q?HSdNYhtseboqbQD6/Rjft6gRhUkPUo5Z5oXpTWZiw43MmoXD6sp1+KG/U+Wy?=
 =?us-ascii?Q?/kE5CQaND9RTRaVWyRmhgGHR3i4jxl1QJnysSvEbWrI3hs2D90/bkocJ/xlG?=
 =?us-ascii?Q?YULrdCLMsGqcAhp4+y4eSiVrF+cQYFoemvLFozZU7BkfO1ylbDSGTF6uu5N4?=
 =?us-ascii?Q?qL7rkY+Yo0CuLUUKkwV/5PIljdcO5Im8G5q1NYOyD1VUhoyhVVIl8ueR8F2d?=
 =?us-ascii?Q?l6eMzxks+BCSn40SmzIFDU7zI3X5EwzIJ4vA6Cq+8SNrTFNG/AwSaf2pqZRt?=
 =?us-ascii?Q?DU9Bd2JT8ZWPFzEXhZsN4jDBCNwYib5eOTysCJJzYhVSwe4K5fKYZiRqPaPi?=
 =?us-ascii?Q?u2E2/W4mHRgsF+MCf1+B893oZjRW7At4ZP102BC5XUtepq7y9JhBNqMdOVFc?=
 =?us-ascii?Q?1/qC+MpA0ZhU1FwKHU0z24M1LKE1MvyRzSDAt9BMKDQXgeBck9LTnSZ+3Zq/?=
 =?us-ascii?Q?WdPW6c0K/InI5MxNjrrlSdo1L5ywO7fD2pL0JEi2Jcayj+RTj2VZFhRb6zfz?=
 =?us-ascii?Q?ojlIUcC+gebeGz2p/9UB6WpYLEd9mUbjeVzjYP0Cl8M3hgONFOp/lwqaWYM1?=
 =?us-ascii?Q?bNGEUw0ZOR6C6iHw1zY2z0N2tx5eo0VSu9d2rDrcvFdl5tLRAr8t9dg+ldfj?=
 =?us-ascii?Q?dryegQOFcXeUw9AvsKL5kx683URHpzmxTVRNJIcT4ZZlkQf3xsRdboYwOQVo?=
 =?us-ascii?Q?hRC/r/HKZoai3flcdADIx8aSb54ueLMA8RGiicc8ikzhOQWY0AaILwWvgvdh?=
 =?us-ascii?Q?YX8mvEIA0VuX1FXBtoX4Ssl5m9TUU9IJahLNzP4NmeQDaB/gcDZ5auuhEQbZ?=
 =?us-ascii?Q?NBPTJo69qDnYgPeHRomnGIc7NtJCXmw1vi34X23LcaBq2iA6+T7WIf8H5pLA?=
 =?us-ascii?Q?1Nyf2BBqMi3nwZcIM2eWdB1tP1FLggi6NsgMwTkmoSePAXuWYlgjSwY/MfsO?=
 =?us-ascii?Q?f1J512UNG8orkd+vveOF98IqXmxaPscG/tB1mxult1fAamlpH1LMeSYd1Smr?=
 =?us-ascii?Q?HaS4e1tnX3fskGmoC04LNDXEK8MfcRcFauNv1fqfxn7MH9b3/RWwOAnzRXF2?=
 =?us-ascii?Q?PWio9ERTi6KBukNepOYjUhlpVE7RPC34U2IGfOayDF+DTATWEL/GoXFCBiSb?=
 =?us-ascii?Q?sm87VAc4Jdg+7qHdie1Pg9WCy8f+yt89OQVJukmKW6X8q2zpvIG+/TJz0HLy?=
 =?us-ascii?Q?BFhVuK/8eDnD3xTd+ZwYarTTWfaaHqezDhyyDtguYN7eEebT52FGXIbPz+h8?=
 =?us-ascii?Q?LlgzshibKNBeUZBbitd7uIesd84ffiUwDt81P5MCvRluiGvWQmlwW6f4UiCS?=
 =?us-ascii?Q?wvZN6VZpwz5ZfmraJPFJeZNDp7ZbTpF3NbCU?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:58:43.7810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc04435-afa8-402e-4fca-08ddeef0967d
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4591
X-Authority-Analysis: v=2.4 cv=DMuP4zNb c=1 sm=1 tr=0 ts=68befd36 cx=c_pps
 a=/fMEJewfnb57F3xAaXcmQg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=uB3EzRcOJay2ftjxBbYA:9
X-Proofpoint-GUID: NNMSdh2j-cl3zVkSGEVjb0GCV4P1Cl_w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1NyBTYWx0ZWRfXzGOa+5Ya4r7F
 N1Q7h11GTm9cviZuImz82drkWIUELg4nSMIuYYxLufeQ1BoO4MXah3HGdY+Mx7GB6EQjPi83KAk
 YCzTFJqnQNVj6uEPf2LDzy3LPB4oP96danjE2cZMLq+ZP9n4tmajolwqKq8s4XsdFaZv8zmgGqt
 nLcJ+jZeFwQubpjF9UMXr29w3y6nP3gKYlF77Aoum/eq8mLrraMyArWXd6eSRcVDyLI9mqV9CP6
 3wPIdUFnXNuEVWNDWSViJQdEbmw2/ZEED0MlW4WNZOyN3eWRwyz/QUVLB4+P/+5In34w3lB3+QP
 nMWCQtSFilq86Si2DRvQSzIJq98fBe7Di3mwHsx5aYwRRPgbfqyCN1n3Sjlvpc=
X-Proofpoint-ORIG-GUID: NNMSdh2j-cl3zVkSGEVjb0GCV4P1Cl_w
X-Proofpoint-Spam-Reason: safe

Rename:

CS_AMP_CAL_NAME => CIRRUS_LOGIC_CALIBRATION_EFI_NAME
CS_AMP_CAL_GUID => CIRRUS_LOGIC_CALIBRATION_EFI_GUID

This is to clarify that these are specific to Cirrus Logic,
especially the GUID. As defined by the UEFI specification the GUID
is a vendor identifier, not an EFI variable identifier.

There has been some misunderstanding of the purpose of these, which
has led to the Cirrus Logic GUID value being copied and used for other
vendor's EFI variables. It is rather strange to have data from another
vendor marked with the vendor GUID for Cirrus Logic.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs-amp-lib.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index 808e67c90f7c..b1530e7c75e8 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -16,11 +16,10 @@
 #include <linux/types.h>
 #include <sound/cs-amp-lib.h>
 
-#define CS_AMP_CAL_GUID \
+#define CIRRUS_LOGIC_CALIBRATION_EFI_NAME L"CirrusSmartAmpCalibrationData"
+#define CIRRUS_LOGIC_CALIBRATION_EFI_GUID \
 	EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d, 0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3)
 
-#define CS_AMP_CAL_NAME	L"CirrusSmartAmpCalibrationData"
-
 static int cs_amp_write_cal_coeff(struct cs_dsp *dsp,
 				  const struct cirrus_amp_cal_controls *controls,
 				  const char *ctl_name, u32 val)
@@ -124,7 +123,9 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 	int ret;
 
 	/* Get real size of UEFI variable */
-	status = cs_amp_get_efi_variable(CS_AMP_CAL_NAME, &CS_AMP_CAL_GUID, &data_size, NULL);
+	status = cs_amp_get_efi_variable(CIRRUS_LOGIC_CALIBRATION_EFI_NAME,
+					 &CIRRUS_LOGIC_CALIBRATION_EFI_GUID,
+					 &data_size, NULL);
 	if (status != EFI_BUFFER_TOO_SMALL)
 		return ERR_PTR(-ENOENT);
 
@@ -138,7 +139,9 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 	if (!data)
 		return ERR_PTR(-ENOMEM);
 
-	status = cs_amp_get_efi_variable(CS_AMP_CAL_NAME, &CS_AMP_CAL_GUID, &data_size, data);
+	status = cs_amp_get_efi_variable(CIRRUS_LOGIC_CALIBRATION_EFI_NAME,
+					 &CIRRUS_LOGIC_CALIBRATION_EFI_GUID,
+					 &data_size, data);
 	if (status != EFI_SUCCESS) {
 		ret = -EINVAL;
 		goto err;
-- 
2.39.5



Return-Path: <linux-kernel+bounces-862674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1758BF5E34
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5135550030D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ABE32D455;
	Tue, 21 Oct 2025 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="MJQ6ihO6";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="iegHYSU2"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F48D32AAD2;
	Tue, 21 Oct 2025 10:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043837; cv=fail; b=uonyTNkT0a9SEZshGFYSanYZAOZUEfFfIVstCvmmZTccgIhimXak/Pk2tFsPIodLKLio+tdh129y0XgYNlXd4cLuljg+tXg2badCOrhIMOuQz+gS36145eutjRc49NjgFv7cHkvYA9s42TNqQ7hWUwaK+hGfu9nzj7n5wnu2ICI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043837; c=relaxed/simple;
	bh=5AXriAOEXg4ph11wWq2D48nBeokCKrLu7FlO4H/a0HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0QyUcIJmigRVKvvZbXuzGDZLvskj5mO21KDO0XauAzb9uf7sH1ps3HVwATt5b4P6rGISTNkNv/wIbD04IC5iqCw0sn0J1tkvdrDbuMfkGZDHyfuWuzThqIS3cUNCKeg2A5ldeLk+Jk1CIN9GldlnYMnwpjcvYV+YXoRJ4mYQYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=MJQ6ihO6; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=iegHYSU2; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59L5824B988201;
	Tue, 21 Oct 2025 05:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=BfXbS79G3ctaThncG4NMQkfeIrMFbOISXRpBpKSZioM=; b=
	MJQ6ihO6pW6fPT3dykcPJslRXs1KxWdaco1FDi9e1kmVeVQUFmxIVW2uGMTQyrhD
	2nYCcvLHqRcQP83W+UBQwMDavDyXFzy5sxxTvFSRuC4n5W/YOqJ/ZPhtlSyyIBmF
	Nrnr8nmDavcwh44ZBKYzM1JRqIlCsge33vwROA7e3z06V1VvX4cSJ4W2GqdzclnX
	+dVVQ94IvcBLAWW7TyI47bMuNbz+KNH/3eQTIomQJBlUD8gPGpBoG2d2wfvDD89q
	/ZySsUVKz0wvKhHZkJQR3aPvSIUp5xRLgXHpgCtfyoqqTaqgCkHvHOGT09GZ2waz
	8W8/bHnqoaRRF7CIUThu0g==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022114.outbound.protection.outlook.com [52.101.53.114])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49wnc4sdqk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 05:50:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+hWc+wRGruywDRorqFNm7nRXfIXXMoc8N0DOb7DewgXxp9+pvow0CBcFCIOUotqSautXRiEIh0siRrofg5B7Jt8mXtc2PfgD8G4HOZ9RlTQMV9PrhD6XLbmNCpCYbHVsxHZOwXF+1Mel5f5RXHWYinxhuMVeXodcGssw1XHpARSBFfjP4KCLoPmkY+YuM49IN9hfweLfEo5xHZkxZQPfPSLvFYUTXgtidCBv0AdCibOlEDl+EpM0l7KH8YmeYs8LyqAntq5sS+yrUOiT/8EU9qatIuRQog81moADjaz4sTlmAdLSlp5vIpHUZyEeKsF1OzMzmynI5dhjuCcfsoq5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfXbS79G3ctaThncG4NMQkfeIrMFbOISXRpBpKSZioM=;
 b=PzeEdsNOxg9Bk5Lb3ZTRj8fOXtIARQitVdoMr1nGrRL1Js3KmKy5qdjxMBWMdk6UMpcwy5BpNZXJrdbY4iVvBN9zXr4+vTY938Pf6QUL2FTipkW290larmfmDWW/WvCDlF9D1nLba6YVPHd0frtGh9Ja+CEN7zZi5EMx/87fAs6HyX+T8ga9TegZAZRX5lfTvaPuN4/iQsL8nnskZCp6CfAoERdGbqr4cXAy5TPU5GwsKkCOY0GMVzPA1ahQimT+Q8zIzKKkn3PkYMwhk1CcryQlPa4YzeQwGNpKWbEyVFpWCu1x43/qaTSMyLgokpxz13nvLbElFZEqy6KydPj8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfXbS79G3ctaThncG4NMQkfeIrMFbOISXRpBpKSZioM=;
 b=iegHYSU2MZE7ptuR8BqnyYQiPoxerpoZ4lzN1TVmSgvnjwjcqWME1mSN2tppmQptdPb5nrFUP7ia6oLvEAlA952Yli0AUTKmTtt6jmLWZMye+hVT7dg4DRjBW7iF3SHiBdmWG8xwgiZBVXvjF2RsEtf2JM8/GGvj8fYWatubXH4=
Received: from BYAPR21CA0026.namprd21.prod.outlook.com (2603:10b6:a03:114::36)
 by PH8PR19MB6715.namprd19.prod.outlook.com (2603:10b6:510:1ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 10:50:28 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::93) by BYAPR21CA0026.outlook.office365.com
 (2603:10b6:a03:114::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.4 via Frontend Transport; Tue,
 21 Oct 2025 10:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Tue, 21 Oct 2025 10:50:26 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id B3BC7406559;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 7C9C6822545;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 06/11] ASoC: cs-amp-lib-test: Add cases for factory calibration helpers
Date: Tue, 21 Oct 2025 11:50:17 +0100
Message-ID: <20251021105022.1013685-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021105022.1013685-1-rf@opensource.cirrus.com>
References: <20251021105022.1013685-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|PH8PR19MB6715:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d4e67546-0660-4ce5-deb3-08de108fa53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0qDK5xl4Rh2Fh2WJTEId2uedSIe+dfj59CP/1maJ9pKE4n1IaeagJkfN6OqX?=
 =?us-ascii?Q?YXR8pVP0q/qTQGwC70F09pBTMAl90Q25aBGr1Z7DlEyB0gGMCdpvxzywQR5l?=
 =?us-ascii?Q?yeMg46t926W1t3QQH6ogqNsEosKss44kIrb6eNWmjD8IlffzsBD5sln19GYV?=
 =?us-ascii?Q?+uCiT9JasvOWE865pBCIQKVogKKFK+cAW5T1qB17+R7Wq90aDJ7wi0NNr3dw?=
 =?us-ascii?Q?ahomHVQLAKAjPj30svWv+JWF9ynZH9zk4pDt8FkSjQNvb79kQBtHl1LrtVtc?=
 =?us-ascii?Q?Vhmp8GDijs+RpIlUO6fO4a0blgPSjp538RgoLd5456kdgIVMAP96MoFCD/7N?=
 =?us-ascii?Q?yQlFlBCR0+gRd3hZtRhpBSmrIRgDODlhpOYmmkT4WCisaBY/elrS23mf74wi?=
 =?us-ascii?Q?eUMyJlQgGY4eDE9wAbulO5bonFnfMHOR2zM6CT2VX5VbnIctkRKMHS/7XsXQ?=
 =?us-ascii?Q?3HaQ9FpQTLQpDiBa7Tot85HLcal1mckQHmVHhH5bsb3D3q8Y6EU4NooWYRlB?=
 =?us-ascii?Q?FKqZZCOSLSj5qOmitW8n+afF8PF7vuacZ9nbTWbnNZkwq99kkR8rQZ1jFw/9?=
 =?us-ascii?Q?pH6LoELldGvJvz8nuOYDi7aEwXbuUkqo36zdo9JSloOsqdB+PleNT/su0dSq?=
 =?us-ascii?Q?QdFHRV26lWX8NsWszsf+uf7EEZ9UtsJM9agJ6aqCqK+wdsm3+gZXLTOmI1j+?=
 =?us-ascii?Q?iB8yF5z42VePGXFsouue3uLOYm1nlRk/YlAGAndfqYxBcb6CaL5KhcKhj9/F?=
 =?us-ascii?Q?BOOF90DwDs7xVSkDY0ZbaPdiK1d8agCd7vvYAOzFyNVO+vXUV4UAxeZl/a/B?=
 =?us-ascii?Q?fRnTOltd4pRa+A/iMTfzNi4jBwMkBwjjiNN23DaBdN6oz1GRuLB7BxUMci/7?=
 =?us-ascii?Q?O0QwZYZaIt6m6TW8vxQc/lSHfEGsm2P+ewc3zA+bMCd8UaPJHCs6x/GW3cGM?=
 =?us-ascii?Q?xyAg9l1B/sE45j77vZN8dn82Qe8RrGdwhUOfkcCTqJ5ilULmZ6o9TQjoyNEm?=
 =?us-ascii?Q?QWOC1t4GAFWNkLz+ZKxGy0I8jNh0NAh99p8mEwbtltJTXK4O7OHcGk+I39Rj?=
 =?us-ascii?Q?CmoewPVlogxtGO3rRCDERScXDJTiRQb4TlOahsF6mcapctT1fyOnCfwniQSx?=
 =?us-ascii?Q?6rooqkEI6Cn1utoI2Gq42hRFiM8QQRdj5nDK/GXEq/2Goch+ZxUcFPnEcDpp?=
 =?us-ascii?Q?260IUesF4uiLad6FsVeLfzJUzMsWYCqMIFpByAORcpACeCzML2/LicGSxPNi?=
 =?us-ascii?Q?+jVTrHTliK7Gss2JH9kIpOCAysqE6/VHDacSxN1awGJihRq06Lxqc1g0R77+?=
 =?us-ascii?Q?kzSZL60SNFmcRs9EcJ8/AeO2w7qOKOELz5qjqeUGXMr+AM5ywfMqyW3R/kOI?=
 =?us-ascii?Q?6/dibI2TTUT2v6x3KxYdUbqnowGlgsWh1EEJd3xrim0dwm6uQtclhH7yvFh7?=
 =?us-ascii?Q?NzNI4oonNvLRyGUxUA9onQBESl3zpKEDCG4c5zFRAgB3y+FaRsNHl0Qu3qJO?=
 =?us-ascii?Q?ShnhChSC8IW46IKkxYjmQ2bS9jK8cP3c8K6kLFD6x291e5peld9S9TvdGw32?=
 =?us-ascii?Q?3opJ4buNqJVNlCzG49o=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 10:50:26.8307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e67546-0660-4ce5-deb3-08de108fa53a
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB6715
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDA4NSBTYWx0ZWRfXwbvx3AxT4A2a
 eyoNtVoM687tUaerPUN+/n1h5H5jfVAiejbnj5xJu0UbGWQ3A76U0s8BLPoqcmOgtYxSCB+HnLo
 iNISxnTad8cSUrfmA5uuHlbEEQJykCJu9/fjkiaxqetgiJhh8+oTYpEl7dsc6NqKDqM9LVMf6vw
 Mq7eCN4f1DWaQmJuGrS9O71985+h8J1ggFVZp1bJu0wn2XUmmoPCkCZkczqr8y2QW6Eqks8dmaV
 enM+7LYJszL3sADd1LAqTdB7qca1Pgs0SiyzFUDU4N1BxBwZVjK02dsvbCdH5jRAU0NsUdACMLt
 wJo01rs6HrUujgTDbEUGNqmXYbu6FoU2FuCLkEYZosc60Z54/N9fkKwiWTpQ9npRJzPvYVtmhZY
 k+DQMjB79G5ZVGtdPTNuahlJnv7Tlw==
X-Proofpoint-GUID: WwNT4A3BCrXJpUFuWBXzP5nO6kH7KYJL
X-Proofpoint-ORIG-GUID: WwNT4A3BCrXJpUFuWBXzP5nO6kH7KYJL
X-Authority-Analysis: v=2.4 cv=bf1mkePB c=1 sm=1 tr=0 ts=68f76577 cx=c_pps
 a=PPij9JC9dsFwf49xmEs+Gw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=w1d2syhTAAAA:8 a=tIIsFs4PSpDOh4qjPvUA:9
X-Proofpoint-Spam-Reason: safe

Add test cases for the cs_amp_read_cal_coeffs() and
cs_amp_write_ambient_temp() functions.

In both cases the test is simply to confirm that the correct data
value(s) get passed back to the caller.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
No changes since V1.

 include/sound/cs-amp-lib.h         |  5 +-
 sound/soc/codecs/cs-amp-lib-test.c | 75 +++++++++++++++++++++++++++++-
 sound/soc/codecs/cs-amp-lib.c      |  1 +
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/include/sound/cs-amp-lib.h b/include/sound/cs-amp-lib.h
index 5b094f8e8a6f..efa744133a35 100644
--- a/include/sound/cs-amp-lib.h
+++ b/include/sound/cs-amp-lib.h
@@ -72,8 +72,11 @@ struct cs_amp_test_hooks {
 	int (*write_cal_coeff)(struct cs_dsp *dsp,
 			       const struct cirrus_amp_cal_controls *controls,
 			       const char *ctl_name, u32 val);
-};
 
+	int (*read_cal_coeff)(struct cs_dsp *dsp,
+			      const struct cirrus_amp_cal_controls *controls,
+			      const char *ctl_name, u32 *val);
+};
 extern const struct cs_amp_test_hooks * const cs_amp_test_hooks;
 
 #endif /* CS_AMP_LIB_H */
diff --git a/sound/soc/codecs/cs-amp-lib-test.c b/sound/soc/codecs/cs-amp-lib-test.c
index 2fde84309338..6878941a8f57 100644
--- a/sound/soc/codecs/cs-amp-lib-test.c
+++ b/sound/soc/codecs/cs-amp-lib-test.c
@@ -701,6 +701,77 @@ static void cs_amp_lib_test_write_cal_data_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, entry->value, data.calStatus);
 }
 
+static int cs_amp_lib_test_read_cal_coeff(struct cs_dsp *dsp,
+					  const struct cirrus_amp_cal_controls *controls,
+					  const char *ctl_name, u32 *val)
+{
+	struct kunit *test = kunit_get_current_test();
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctl_name);
+	KUNIT_EXPECT_PTR_EQ(test, controls, &cs_amp_lib_test_calibration_controls);
+
+	if (strcmp(ctl_name, controls->ambient) == 0)
+		*val = 19;
+	else if (strcmp(ctl_name, controls->calr) == 0)
+		*val = 1077;
+	else if (strcmp(ctl_name, controls->status) == 0)
+		*val = 2;
+	else
+		kunit_fail_current_test("Bad control '%s'\n", ctl_name);
+
+	return 0;
+}
+
+static void cs_amp_lib_test_read_cal_data_test(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct cirrus_amp_cal_data data = { 0 };
+	struct cs_dsp *dsp;
+	int ret;
+
+	dsp = kunit_kzalloc(test, sizeof(*dsp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dsp);
+	dsp->dev = &priv->amp_dev->dev;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->read_cal_coeff,
+				   cs_amp_lib_test_read_cal_coeff);
+
+	ret = cs_amp_read_cal_coeffs(dsp, &cs_amp_lib_test_calibration_controls, &data);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, 19, data.calAmbient);
+	KUNIT_EXPECT_EQ(test, 1077, data.calR);
+	KUNIT_EXPECT_EQ(test, 2, data.calStatus);
+	KUNIT_EXPECT_NE(test, 0, data.calTime[0] | data.calTime[1]);
+}
+
+static void cs_amp_lib_test_write_ambient_test(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct cs_amp_lib_test_ctl_write_entry *entry;
+	struct cs_dsp *dsp;
+	int ret;
+
+	dsp = kunit_kzalloc(test, sizeof(*dsp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dsp);
+	dsp->dev = &priv->amp_dev->dev;
+
+	/* Redirect calls to write firmware controls */
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->write_cal_coeff,
+				   cs_amp_lib_test_write_cal_coeff);
+
+	ret = cs_amp_write_ambient_temp(dsp, &cs_amp_lib_test_calibration_controls, 18);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, list_count_nodes(&priv->ctl_write_list), 1);
+
+	entry = list_first_entry(&priv->ctl_write_list, typeof(*entry), list);
+	KUNIT_EXPECT_STREQ(test, entry->name, cs_amp_lib_test_calibration_controls.ambient);
+	KUNIT_EXPECT_EQ(test, entry->value, 18);
+}
+
 static void cs_amp_lib_test_spkid_lenovo_not_present(struct kunit *test)
 {
 	struct cs_amp_lib_test_priv *priv = test->priv;
@@ -973,8 +1044,10 @@ static struct kunit_case cs_amp_lib_test_cases[] = {
 			 cs_amp_lib_test_get_cal_gen_params),
 	KUNIT_CASE(cs_amp_lib_test_get_efi_cal_empty_entry_test),
 
-	/* Tests for writing calibration data */
+	/* Tests for writing and reading calibration data */
 	KUNIT_CASE(cs_amp_lib_test_write_cal_data_test),
+	KUNIT_CASE(cs_amp_lib_test_read_cal_data_test),
+	KUNIT_CASE(cs_amp_lib_test_write_ambient_test),
 
 	/* Test cases for speaker ID */
 	KUNIT_CASE(cs_amp_lib_test_spkid_lenovo_not_present),
diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index f9d5c4adf3f2..f9f79da3a9ea 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -541,6 +541,7 @@ EXPORT_SYMBOL_NS_GPL(cs_amp_create_debugfs, "SND_SOC_CS_AMP_LIB");
 static const struct cs_amp_test_hooks cs_amp_test_hook_ptrs = {
 	.get_efi_variable = cs_amp_get_efi_variable,
 	.write_cal_coeff = cs_amp_write_cal_coeff,
+	.read_cal_coeff = cs_amp_read_cal_coeff,
 };
 
 const struct cs_amp_test_hooks * const cs_amp_test_hooks =
-- 
2.47.3



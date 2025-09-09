Return-Path: <linux-kernel+bounces-808002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2376DB4AC07
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4885165C0F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8B631CA44;
	Tue,  9 Sep 2025 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="FBIpmeGu";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="UrQeIS34"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D7714884C;
	Tue,  9 Sep 2025 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417450; cv=fail; b=jIyFFGsEWvwFF/lcOChu+v13gXFx1lQzEtkHuQW6gqxZwU2V0xMNgf6L1AbUr8QvmNf1+7pCHv2qMY/riM3uYgv4la5hIY8zNUSlXSY9dwQLQgRCXOkktWc7zQTGLNYDC5gsFNvwnJq5Dx7gyGiEQIKcB15xC4xODSfGD11tG24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417450; c=relaxed/simple;
	bh=h4asHsCQOd2ufeDF7SvrnC4iax+TSSl8XbpivmHl4CY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NomD7Bnvhu3qy4gshNaMH7I258bUmhJEkfsI57D3qTT1ipPnK3fVCKaMum3Uqk4uH67Hmi9Et8mI5Z60tHPl4sVST3osSodtzgxhnX56XqFESMSWXhkboyB0KoA/JrXpwoKmT9YK3oE1ui2z8LnRTjyvav0165iPMJilZi4bbls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=FBIpmeGu; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=UrQeIS34; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 588KSv8w1252531;
	Tue, 9 Sep 2025 06:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=UPXyvMD/Dhb+w7dbOEt9OnP0AsfSESzw2yqkmnbfxyA=; b=
	FBIpmeGux/3F8f/jwAXVTydsa7jRBgHuyPw4cLAoVbu23h6x+43DcdTwKctsTM4i
	htHVRfvCMPSIHtABfrgs/yniB7quiaV31WabekEmG6YnB9FlfZP1Fy7UtZUqMN9P
	Mxenuo91yza4bJ6EK7IgC0cG+QnY23EdhWvc/3ISmUhzBZgzwSa9aAkOnEJ5US45
	bSgQHkdN3A8Yc0v2rhqPD6Zndg4052EI9KJsmS8ABKFeUXEdh/w1wVaUhRALRx2b
	XPSTGOkWENYNeYrwVMMhZJ2PwpG7Zwbf7jqk8eHN4rpCi6gENKOG5gzkZQgGyt/h
	Ob+bsY4I8DVCM8r6ht0iFg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2124.outbound.protection.outlook.com [40.107.237.124])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49227r91wn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:30:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxFiLWPAnqP1uPqcbf8zlLGUahyUWo79LtlhoN1fFuSngRPRb93HlLxFt2Tlu/D8XVS2eVbLkL6KVqrOO6sxYBOj1Vlo5XQjHgPYXwf6h58H2lAODyNaE5bsr/zjLqdjqtUmeuw9ifD0zrRzQR/z9NVMPnHoTqh/U6hc45wAMw05lC5nHADq4wOh8kfExdrhXCWVLHnjP9t4NW2IUtzuJxtHXKfYiZwQ/4X9iTlbp9cI+xztK1twHt77BdUMW0zWu/a7jbse4HGgJDLeon9FJKRSVU+/Z5ZO9n4by/wT9yOA80BUyfOmPOdtvKSkoT74CdDy+TRDGVlz7OcARAL0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPXyvMD/Dhb+w7dbOEt9OnP0AsfSESzw2yqkmnbfxyA=;
 b=CRGtpDqiemAlBzF5z/4O31lP02VuVP81T89p0veFoycz1PPrRCbj2ABrEmZLVnyy4p04RYhdfMWWn4BbUVsYUjRa/W9IGeAZ/B3uoLZs8qVTnIE6tv9srCOE8b/gg7wDQxFKqWy0GMMh5J3ONS47JWFdadG4LFki20VgFSTaOFfSGeHMaVm26xVwcJfFXoQG2RIz3wcRxfQ5YmUnoZFtHuRCADYmSHHgIstVI8DDSZx3+fIWJ9l5zq/CNC6mA3lvfaWSa5c6L6RFQVyaqQ+sEhCfllwe9TFJPSfoRT6hMQwtYuNok164aURwHr+wNyHG+uAJevFwKbwk+qk97UbO5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPXyvMD/Dhb+w7dbOEt9OnP0AsfSESzw2yqkmnbfxyA=;
 b=UrQeIS34PTmPmUHTP8T6kTYulnNPr0qfWArw/V23HwVJO97l1Jd4BHOd82KChHBOcOro4V7Z8ZQAjzXDsdlQ86LyWg+MWwTruZ5Y3vUBTHD4cr5LwPJGnEJ53RvEJ4LyZ8+oB8Y8R8P9HLSuR1OfF6RWhP6u7wSwaA5GYAvNFQo=
Received: from BY5PR17CA0067.namprd17.prod.outlook.com (2603:10b6:a03:167::44)
 by MW4PR19MB6958.namprd19.prod.outlook.com (2603:10b6:303:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:30:42 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:167:cafe::b7) by BY5PR17CA0067.outlook.office365.com
 (2603:10b6:a03:167::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Tue,
 9 Sep 2025 11:30:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Tue, 9 Sep 2025 11:30:42 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 2CF9D406541;
	Tue,  9 Sep 2025 11:30:40 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 1479582025A;
	Tue,  9 Sep 2025 11:30:40 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 1/6] ASoC: cs-amp-lib: Rename defines for Cirrus Logic EFI
Date: Tue,  9 Sep 2025 12:30:34 +0100
Message-Id: <20250909113039.922065-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250909113039.922065-1-rf@opensource.cirrus.com>
References: <20250909113039.922065-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|MW4PR19MB6958:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 14643945-6617-476b-b79c-08ddef944f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AVqN797IgZnmW5U7qAyHlLCk1Ga+WwUt7aWR5Ve51bphjyuTrpLYWtCgiESH?=
 =?us-ascii?Q?dDGUlrsMpOQO5OMn6KuP/gRfSrqjDAWTZgKx6W0G5KwkZMfpepqBrKSY6mwQ?=
 =?us-ascii?Q?vWrDlhZbEI9ngXKJr6jiFUPSLd6aKcV2gFherdVgAPZhTedTTGffxhNIw47n?=
 =?us-ascii?Q?kGVnwRRoWQVFAehs8LRaX+Qw64Fm76pR/XPSMg+9Xxl8KCS3DNC2BfYqC07X?=
 =?us-ascii?Q?bdpivPtPVpqlDaKsY2Jirap/A2zT7B9o6izR+mDvDzIaPowDGGCsKgQwneVS?=
 =?us-ascii?Q?r10wXC0K4UJZODJLH5GXtDkd4gjgETyiAwph6dg7Ub3lXFC3BqrXYErj4fXk?=
 =?us-ascii?Q?Xm5MhjqhpSXqxenp1GErfzBRREQFqYA7pbphNwB/F+fL15Rd+YPE6TQn9DfV?=
 =?us-ascii?Q?mmVybWW//HFs7KET0B7YwXUULHJl4uoRxJOKdn6NuFY/OKJAocCNUNY8JcjO?=
 =?us-ascii?Q?EevOIKXlOEZrmg9IbdWysNWzQO8Lz9yaQCdW31PCoPFSRG+TT41FvuX0MGq4?=
 =?us-ascii?Q?YLVcsBMkAlb4Vdz6ECoE6Bz543FGyKTnM3Lb9zF+OvdayEV6+OnrWhq92Mnb?=
 =?us-ascii?Q?RL+yAu93mGGwwfYXBqG4c7UvRr7sY5BIBhh+y0/FxlCFjO/N6P9qV5uOCkIM?=
 =?us-ascii?Q?/q7M4/Mj1niZ1gguYugNgQyN7VV/m9Z7pFcIlKEaFphArdZFNqQ0dMBq1ykC?=
 =?us-ascii?Q?Y57ZO3POVusqFiO95QGA/ZnyOAqwA0wRIN3hTy+iWxYveF/3MpYajwXnot0g?=
 =?us-ascii?Q?yCYA+eE0Q8mFFVbGOsNyHsbhCMHo8WXR1APpviY/Dda5vNz6bHljguzumeke?=
 =?us-ascii?Q?scIm5N3EgxjaqfWmh9K3BnOR8esWKTg48FC4fWb7xVqJx6S074nj23zdUloU?=
 =?us-ascii?Q?JOlLnNlRDoLjoPKD9S+LZJ181mdEfhSGfDAwJH3iSegDK1GvMtjlPm+Y7aI1?=
 =?us-ascii?Q?0Rdl8bRILh2Hg3+x3gL+R7qkurgA5tprVXn0Y31vJX8n1ry6weUnCAli/1GG?=
 =?us-ascii?Q?USn9YC62NuNPj7GmPEZhrkgrp2HPoJf8SzSCCuN5TcGXotpu3zO8jyZDv1uD?=
 =?us-ascii?Q?c/hD0WPUaKhrvNILjG0+ZIiNYMrbios9j+VGNVRMj3qgP7y2bVDmpX7C+89o?=
 =?us-ascii?Q?hEJwjhaZyg9IDFiwgbn7MOP1zLdD4FsVXOWUSfhZY72vOPF0DIhXKO1CtX09?=
 =?us-ascii?Q?0ry0tUfa0EL8W68dWD2MV1qZ1QMlW4NjLwkxy1kz21g5SsmlJ+vkFA+aECJa?=
 =?us-ascii?Q?tZ2XOxCu/q18o8ELVlbdQDJdxPPSniXnqh3Wu+FVSBi7Pli686nVbv9nnQgQ?=
 =?us-ascii?Q?kapjZmPa72ntQURcJjv314/KazQld9zUtGILTon4I3EpLsI6cc63AGVWRzbH?=
 =?us-ascii?Q?awR8BhPJyJEkyHIZoUQahNLe9Dq5xW6Aru6bMo/2xnJ0o9pqNP1f+J+Hfyfh?=
 =?us-ascii?Q?bM4x04IHDAZqCxtNKiC/ZO0Dbg3YKxDeCkKqdQO6ukPXtkV2GEkezxlFS87i?=
 =?us-ascii?Q?W2P9SykHu145ByZ43UqTG06z24nKUh1AEd08?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:30:42.1212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14643945-6617-476b-b79c-08ddef944f7f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB6958
X-Authority-Analysis: v=2.4 cv=f+FIBPyM c=1 sm=1 tr=0 ts=68c00fe5 cx=c_pps
 a=Bx4JecnaPChsX23rVfvkjQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=uB3EzRcOJay2ftjxBbYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA5MDExNCBTYWx0ZWRfX0JOh0nb+0lg0
 6qYB/h1N/5PEzH4KxAPZCuBs6RnBONNST1dajoVOP/ficNyQ4YEMFESLIqTDNKAu/DATamL6973
 nMW8l9d/jmQXva+itrrBWP9wkQuM4yIt8ADQNZXN5++3nPeEDxTEdsCsuQ6TZuVsrCPmoA1ERHA
 SZ4mx0aeMFYbz5HaqdFertAI6umywsOMzR3R9FEDbYuAaD/VEYQpFGZJz1jyTBmoYQtd+w9LdVy
 KyqS/spyq4UzJ2D+3mcch9jvWhs669ahBOotVPuWpsxBjsPBFEEoqJAfVmU021CZDE3tfydRiEQ
 1TwaDhTpmR6mW7Mbt4zvKh3zEW2y384WWIGLxBBT786TF8V6ghDfXx+7g/Scgg=
X-Proofpoint-GUID: cuNeUkHI6xEpZ5XCf0cCXfoR5xafYykO
X-Proofpoint-ORIG-GUID: cuNeUkHI6xEpZ5XCf0cCXfoR5xafYykO
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



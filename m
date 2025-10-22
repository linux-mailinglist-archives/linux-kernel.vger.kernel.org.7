Return-Path: <linux-kernel+bounces-865121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A8DBFC432
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85A7663B6F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3C734B1B4;
	Wed, 22 Oct 2025 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cCbLM9Y9";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="j29OgYdG"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8B134A3BC;
	Wed, 22 Oct 2025 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140404; cv=fail; b=t+lI5spvoKeWNUGuUfpAiwjLp2KL1SJY4qBFwjf7uvkJXnWdpScUSb07OK0jm8o0QNt8LtyLay8v4vK2NHAkadyIm2pg4aiMgy9mpXCMqrzNYq7uD2i6ZXPqG4zP5y5cDMlpNr47hksJY2PjLbEe4VQBIi0L97vxJRQiugAUypY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140404; c=relaxed/simple;
	bh=RLKAoHd0OG33Htw2Uui439za6oTQT2K3D+ohxWOUrDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hu6h3FaytODnLCeMjtJN8wL0Q25rxOayMZV3z2ezC1cB8hYl+rktvdPKhmK1GawbRWLFHXfZeha4UVb69u0p1E7ir//+FgX1HT8aHyHsuItM9NdHdiOBfEJrP7JkNUQOcx+kEB3l9FQ9XzDfTbXTm0ZgYrHAxcv8sjz8dlVG+ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cCbLM9Y9; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=j29OgYdG; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59M5Nxp11194606;
	Wed, 22 Oct 2025 08:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=caK6d0XZgJgcGAEsBwLhbGIK3Wrw+FYr+71RN8O8bDo=; b=
	cCbLM9Y97lkq2RW8we9W2WxzX2kf/F3P2AmJwtQz3P/2sRZ/PleEU0jGCElWug0j
	jzNmZ6A5OFJqx/9Ht1Qf4Mcy2Y71NA/NlEr/gmHbzn+BzulsFR8SQT4PS4LAymg8
	9lp2EZCMDsCnnV21Ez6Gy8Wqc5diDrLtpPUHf3kbp9bo7yQLJIj02WRTuHtzC/YL
	/baTa39PK5beTh5OHV64no98zaLoz0LaVfBGV4KIbOFzkSFWrDSVLnTKUy6tqN69
	zMmdE47E47b5/g0r69qHKSx+L3eoBE3QLhJ/d5gpZdU4pouhnVxrj9Sx/FkUYWhK
	xGzCQSq4n2Qx6/eGDd6qIA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023111.outbound.protection.outlook.com [40.93.201.111])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49xs380gdg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:39:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n64qExIOsONRuxy/hseVHlNIQhyqdAFNqaDVPcUtwxeDDGCU0ohdAUNRMSD7BC1TOVXNFPBW4s3HW0Wsbu2omkElwV0xqa6WwKJgUsySVFc+Gf32vU4YFTuHNnJ258TfmXlrZl+//lZXygpdOj+pJXLTv9LCQzz7vVf2jMqOvgFXNhSJdXiuI9EXjP+ctISJAOUq6MDPkzfvU3T9nFJKquJ3rULHBS84PGxrYnYw06N738G/peVbNTvTu4gl28QgN6IW5hqPUBcSEt43lGbhA1s4pSMsIFccmd38IdVX557FQovlvry2zXIeNe/rYAI6SPNAI1wcXfHuHAG24Sa40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caK6d0XZgJgcGAEsBwLhbGIK3Wrw+FYr+71RN8O8bDo=;
 b=ZePBzDl6iM5k0OW6ZgpLAOHatsOUYoHwvgotdUf2bwKps2Th1Cey2rF06/0cPhN5XLVEy7v0wlg9uGm1Qpe691hm/ZKv+caBzsId/EHEAxjoQZKvPl7buqn2ODwtJhGMIiQfX95vAFnuFq1hPvop2X2YwEo68Itx4YqEc7kyihvMcO6UMxd2kBD3foIyU2NAzcUQ91pEEA4nXNoyED7WqLixdTjD1LRIyIlvZ4ss2qKiPmXLBBJ5kSCGzLTbLGagfZjAUjO045wt+BUWjE0Y2pzPqJYYL72PM4VczbiLkBL8oXBGLfxP20yk9mDKmaZecJFPQuBs0i36UJSKjeTxBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caK6d0XZgJgcGAEsBwLhbGIK3Wrw+FYr+71RN8O8bDo=;
 b=j29OgYdGXuewX4pC0bPhACN0f8Hqx6OSYtX4aoSpXsTp6SDGyVbLzbILxNDMLbF1dI2/szoZ+7o6X0BWc2tDhj7NaXDT6vfh0L4vbsF0chQot7MAZ6+RcM4uqE6K6Dl/ZyY9STxBNEbl7VLLoizO+1FMO6cUeRsGsLvsw7dXPUo=
Received: from BYAPR05CA0108.namprd05.prod.outlook.com (2603:10b6:a03:e0::49)
 by PH3PPFAB08B9FD3.namprd19.prod.outlook.com (2603:10b6:518:1::c43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 13:39:38 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::6f) by BYAPR05CA0108.outlook.office365.com
 (2603:10b6:a03:e0::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 13:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Wed, 22 Oct 2025 13:39:37 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 2B6AF406561;
	Wed, 22 Oct 2025 13:39:36 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id B82C9820244;
	Wed, 22 Oct 2025 13:39:35 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v5 11/12] ASoC: dt-bindings: sound: cirrus: cs530x: add spi bus properties
Date: Wed, 22 Oct 2025 14:38:52 +0100
Message-ID: <20251022133914.160905-12-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022133914.160905-1-vitalyr@opensource.cirrus.com>
References: <20251022133914.160905-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|PH3PPFAB08B9FD3:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 333ae59f-2b80-4308-a6a2-08de11707211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ec9pZeoBXcTTLmDrr1P7Pqm6ZrNzYw/WbQS+rG/en7041DgWSWd+GRLCTP3O?=
 =?us-ascii?Q?X6HrKQIf4L7AzPPGesyD+09UMObNEV+Oapq8317vippfPjYac8FRVSWflRtj?=
 =?us-ascii?Q?ARxET6NrhwjTuvvJUVVpivOilkjZ620NyLH18EnNrUYqjnNKq0xex7yCUCxd?=
 =?us-ascii?Q?WB06i7HO/iZ7tTzsdF08+zn3gkG54kMavMxDSakIMpEf0ArQ+AMIb7WwJJFr?=
 =?us-ascii?Q?vQUj6fe9XmaK/KJU2ytU73CqnNBFrP1lLQ6vXUHw7P8Okb6wu/c9fdb0rnSm?=
 =?us-ascii?Q?UC3fV63XkF6Cb+pIVh25oOzoSvTaZQUOMSCuFdyUY4KDFBM70TxffS71dDyP?=
 =?us-ascii?Q?teXU0+yLXXJd7DYJVltmwEnclWAopxpF4OE71ya9XpUJSSULinzgHHDR6Lv6?=
 =?us-ascii?Q?28ZmRm2A/9z75bFyP11cyizkVWUWDLBksq1Up/N1vi5lrNt0+WsOasYpmW5S?=
 =?us-ascii?Q?lLZCHlGjsWLRywfYhqwPu5ZbxXeGI5FBnlTnCxCQwAW1ZgDbrQ7p/adohToA?=
 =?us-ascii?Q?Q4+f0y9Hlldo+2YB70cPLTQLv0kGQcLUD8jmz05E1YlPKWXiNd0jdrKbX2Pr?=
 =?us-ascii?Q?C+mOkUCXxoB/+REBsnccjJiAWxPpVZliRUtPHtIBgeUG/tgGdLzaPb8+jsn2?=
 =?us-ascii?Q?NJbVqON1jgvkfLF55PZXsd98WWER5BW7yvTXIjrJT+xT1TAS+huAuwg2ebXS?=
 =?us-ascii?Q?CDDwXy0ptlWqOLKAhxB6LG3vAlCIbYCeyPmG2UezlQGnIdwYGfgiN1X4f/Cp?=
 =?us-ascii?Q?UWRu4eROTFTTkKbCarHGhiA1NeeB2Ik77SF0FJLwH0tb15mIlyB0BIoXI63K?=
 =?us-ascii?Q?KITcGw7KBT4XmCIZ4zKqZjAEM7bILwZW5+E3d4p8oeagpQ8EbwY9E/FMJilV?=
 =?us-ascii?Q?3xf0ySzSJfSDqD2o6+Up/etlLtduyEA0wO+MHUvmmm9wZGn9lcBGtmTYCZaE?=
 =?us-ascii?Q?iz/Np41RmWehl1JdsD3UDU6dPBVnaxeXCLOOc47NA4Bw/tV0g5Q0+ZfzCUdr?=
 =?us-ascii?Q?oF4J8XADZtH/+MxAigFynVwu13mSQBja1I6CCH4dChmxo+tKxYnBAF72eaOk?=
 =?us-ascii?Q?AGx8r+8/3kTsQJQQDqoAR9/USLPUvjQ72snr39b4XcC9DUasrk+be9+IsD8G?=
 =?us-ascii?Q?sHGwNnhbBWRw5b75H7k0rWsZrpvg0upj6BP/dk5mBk6YmTYeU/89NjpCyhMU?=
 =?us-ascii?Q?mGcDmUl9M2J9rbL/7S5eJIYpTGNUzaKlxTnSh8RcHztrFZM+RVWInNnribt1?=
 =?us-ascii?Q?q6duPNvyX/LtSrVmvO1tuVso7KorZw/XyvAo6VosqwfyvVKHL4Djkt80xfHB?=
 =?us-ascii?Q?nc9Y8LzdhnWGZAM2enKmB/CvywxwbT5Exn7hOF8vaSIDSAPQUGvzE0ryE+BL?=
 =?us-ascii?Q?/ugGfQ8KemxhWmPnfraQBgPlhmqqUj0eHuJ2GDl7qrj/pPOeLnaHQpvCjcw6?=
 =?us-ascii?Q?XfUiBHbXztQeVfKrxBbNy6AG549gvwE4raTYTxyi8L/SU/Bc+OnoyEcnoyBk?=
 =?us-ascii?Q?I+kOrdCYZXArx2TcA+QcbKUtprE0tYfTs8ux/E64gvnFJSRadLtd0wnir2Qp?=
 =?us-ascii?Q?GMKvEhx1IByg7BrrcGI=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:39:37.7609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 333ae59f-2b80-4308-a6a2-08de11707211
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAB08B9FD3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDExMiBTYWx0ZWRfXxmHm7COgEkyt
 +BGVSa8YhADUI31uJr4f7APML8MrBV2zDuEyRasTdmQesSi/82Z8O8/elJbL06G30DAd1Dzfhyt
 slw+L7IRfeZClFDZIhmHj/95NBvhogsS5dBLRq8jSNzs9YCCuVj/+hsw73KXsyMkDinSGegRqJ5
 +MOsEI9VHhql1p0H63004rq1cj6k77t5yBR60RrkMpJn2Jqzx1CqZTs742RSzOnWDkgx6qXXYcH
 4EeBBKJg3izpSOxDXNZguAli2IHYPPclQriDiqhs9JwqcUPv5g+en4Qznl281oGKkqWOX1WWNtT
 iJMXDTBkXFMXZRvXXKkvWE2fzGdZWKuEaW2JIlnIsYI05E7BnXoWM9qbRdCVDilhTxueRrEl0e3
 AV+jk0ov23ulNF6vE4eScig8chpvpQ==
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=68f8de9d cx=c_pps
 a=f+i8kFYBc78eCJt0xtd1Rg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=EIw7sTYcH-EARjFZPrAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: DR1jdwrbB6GiZV_BZjXVOc2LjxP5x6NQ
X-Proofpoint-ORIG-GUID: DR1jdwrbB6GiZV_BZjXVOc2LjxP5x6NQ
X-Proofpoint-Spam-Reason: safe

This patch adds property for cs530x SPI control bus
with max frequency 24MHz.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
index 04ed197f91eb..b233bcd18d49 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
@@ -30,6 +30,9 @@ properties:
   reg:
     maxItems: 1
 
+  spi-max-frequency:
+    maximum: 24000000
+
   '#sound-dai-cells':
     const: 1
 
-- 
2.43.0



Return-Path: <linux-kernel+bounces-856675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBA9BE4C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96391356C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954BC3321CD;
	Thu, 16 Oct 2025 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ApeqI8cq";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="FDzJAsLS"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2897D350D72;
	Thu, 16 Oct 2025 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633947; cv=fail; b=qN9v4uuWCkwL0n/C9sczH5/zfaKOoupH/4opaiDTp/CjhwriQRZ4yC60H+hbmXCU5tMrHF3/64GhHOGuIRJM1XxlUtbAtVbwVH5oAcZ7QqaNoJvjUTfxGH6pHpybD/syid10/+PxUr6RVeIqSrKSy2gPttYnrbSO6X+5Lc3LJME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633947; c=relaxed/simple;
	bh=LgCMr6Kh0AgrixyJ2G8VLjDgU8+wpZ3SJEH/UbtQXHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvLFrGCp4aH599AGKT+Op6Y3ZkNr81nlL/kFKVcrzbOZsVRYktn9z+4u5s454rlsKB+zXSAm80b4ZNSb5qcpxi0exwiElNNF7qrPTIWWsZbLtpk7vY2X1+EmUJoY7reM7SaBAfaVl9AiXpD3V0bLqDvAaWoOFuu0oja7x2w6tSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ApeqI8cq; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=FDzJAsLS; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GGUOYl298627;
	Thu, 16 Oct 2025 11:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=9wngttqaC4L4P1iGGBJcGvYx50owhYl9VrkkgkOsGHM=; b=
	ApeqI8cqteo0t4veO2RBK55eXLQpCDfxG/r4TDqKMH1JxycV2GQdRh5QNWGVricK
	Ln8CmDZzx4fkhQdAHFmAwAKEQsHtHuUbcq+Q6Za02jVydGL3CVo1hBBVh9p0YFc9
	VLvXThzEXImJcnppPLlANPiRfuLGoRHM62iWcDh5tCrmWEn08fhdNRziDrG8OrGg
	biVI3I/z08EPEh6V84fu0rTRHmss2hAWVnDfUBzoGrVfwdppghoMbhLUJn4RDlmD
	HtOiSfm5w0YrG7qBk7QkB3gWcIJaRQbQdm39xi6qwGBtkN38/LbTCXT0JZx+G6jH
	I8/i2u6ZeIiuewqUCn/pOQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022131.outbound.protection.outlook.com [52.101.48.131])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhj9h4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:58:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/W6gYx+1vLJeGv8qxYEnHBbzMW/CL+CfwMtltSWXN7YLJBr9MjFeLlyOFz+/3gYEEeCD1DoAKEl8dS+856f0nVyJGAaFty9pIz5YzMWSYcqiXxNj9e7H86lq+0jHiSlkkmg4t5RcW7ZruWdAXRi9z1QIpNjfzP1V37fUQdm5H/XhhGEWvwdEpQQo+lGL56fVfVib53kg5odQipsIy3oqA8U5Qs+B8tsIgsP5zTro8qyBe6k3kJpsHK8HWDLObss5hzoOsW7zd+gdUs4i1dbx9kzi8CfjaYPKqjR1cXX/um1P9P92R9JIiFKv2lE+AB56EOQwHkYuT1ePDF7CYQzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wngttqaC4L4P1iGGBJcGvYx50owhYl9VrkkgkOsGHM=;
 b=q632VH+5d7dWJaLVdEljK5Lb0AgOXJ0/rIWlMbXn1gMfYuL2gGNm8pTRlSBnrKDk5x+jccvtu5iFexlsctw5we23qSW1d47aVdKYliu8WwqoYTMI8QtwefDKWiHX2zQcCATfG6xF3r0FO8wTqzK64KkX1cYcWq8v+JWuj3NUTV/bWRjFh0e23cAlhjDxcum9Z1KJQUKXTwZ90CvKjUqxaYV0c4LsyzIYZnbVngfsarTtYwb9qRHsqcmSpZqttRZfvzu545i0vFQP1epJDc+GvPDFrZYfx3HyLOOohqDyoF3DCUaer3caZ90VVGiZlhuUiKhyBtnVj5mwaCEF70NydQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wngttqaC4L4P1iGGBJcGvYx50owhYl9VrkkgkOsGHM=;
 b=FDzJAsLSkjg/seXgf1pPNzv37Tz8/yh96fkpaRqE3+kDfqQ+vM7rKmyohAR75Db/KLsTLDbVUXmckrLF/O4BDXPYo2rBVGRCxKikYAqXGVz0H7a4fpyO8zHnNHF5mkP51lTOkDH/znGPzrYzzfqd91NQH66mepeuuLcY8YqL1Ck=
Received: from MW4PR03CA0304.namprd03.prod.outlook.com (2603:10b6:303:dd::9)
 by CH0PR19MB7894.namprd19.prod.outlook.com (2603:10b6:610:188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 16:58:51 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::f) by MW4PR03CA0304.outlook.office365.com
 (2603:10b6:303:dd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Thu,
 16 Oct 2025 16:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:58:50 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id F3BEB406555;
	Thu, 16 Oct 2025 16:58:48 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 91B71822540;
	Thu, 16 Oct 2025 16:58:48 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v3 11/11] dt-bindings: sound: cirrus: cs530x: Add additional cs530x family variants
Date: Thu, 16 Oct 2025 17:58:22 +0100
Message-ID: <20251016165835.143832-12-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016165835.143832-1-vitalyr@opensource.cirrus.com>
References: <20251016165835.143832-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|CH0PR19MB7894:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f3d5ec75-2a41-4e33-3ee0-08de0cd5483d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cwl/siQxf9U+ML6yMIFgdzL4yX0N7bGmBFWYVopsN0G1nAdT8HL67XvXUczf?=
 =?us-ascii?Q?vTNMa1dMAlMdEuljpsn/xBIVGyAdHr7du8aBWFzCQF/tvOEG1RzHB9pQjppt?=
 =?us-ascii?Q?7b2+8S5vKbR4xUknsmZ9ywHS6fP6oE6OoYBYM6D1Bdukj1Yb4iIFcisBXpH4?=
 =?us-ascii?Q?0T/0o/qbdqrUan+uXc+uAR+wsj8arn4RmepMU8oisrFM/bjQlIIuiWOmMKYF?=
 =?us-ascii?Q?1Be4XgcUoPqTsT/wWKrb4DUB9icdeWZk65O8VsPh0mnZ0le2I7T8C5JulepU?=
 =?us-ascii?Q?zPRO9XhvlDlW2I3JMC+Ah2pTSd0DFsH70DTyoxlpCfB3o3HeYe2Sen+DLk9m?=
 =?us-ascii?Q?16EV2r+PZ7mfTOXqKr9YSjhpiN0EK9W4D/3DXRpQ2KLZcrCkJUQsc5vCv8YS?=
 =?us-ascii?Q?hQSGTSDajbiU86PKcKl199C4n9b7kwBNJOnrqi0NvgSVhaYEan3ZZmMLJjFH?=
 =?us-ascii?Q?wqahuXE2eGznBi/xnehH92AU4S4xEdbQN4NvxpGQRZ6oSjs0dMfQx7bw0zr0?=
 =?us-ascii?Q?s8sJMli3Zf3i8q/I3hAyIrL/8M85KCuoqZEiCT2FyhHEo19Xb946qi6jvhwO?=
 =?us-ascii?Q?vmQ19mmJw22WTsaNsdSO830iZNXMkvqtTv9ejZCKtTjICHRO9P5KeJZivl+l?=
 =?us-ascii?Q?P/WWUDAdCSQupzUtiZafUAngzAnm2vUoVY0OLxtQxgDzBrBjlB5eexZ9/23z?=
 =?us-ascii?Q?HWbbLpWGq41q87zt0YYjHOpYtGXFkIN0A9VylmJjtzl8/U1QjIxP8axrwZ0m?=
 =?us-ascii?Q?Ltc6yXRIWDaURbUQHKybp87i8mBp0PAe+SDF7PtFetSYYbQtfe3SXJVgldqS?=
 =?us-ascii?Q?3cXjb24yfv16B4+7C+YKK6jheW6WKqfoNacxn9d8R5b4CZoXhdadc6FIZU7o?=
 =?us-ascii?Q?+CDd1qi9iXjRedKLyOGr3KB+iCdSd5S9hL7+Wifdy1QAANZULTlloidBXAhQ?=
 =?us-ascii?Q?pURVHhhesny17JMWQj0dxKv9aNYf4uY2muRGwYuIOt3hoJUao0CSB4QLbp5g?=
 =?us-ascii?Q?AgGVhK5l2qlEtK0BWpBOguBTo8zwHKdT0SSuEEru0Q3yEjnmt6L/hGZD36lX?=
 =?us-ascii?Q?R0zO6ZKggo7sLyjH4wXSEIRTif8AjXhLXMEzzIbDION8kKU7e/DqJ5HHheDT?=
 =?us-ascii?Q?HkHG0SFX/EVA9t0+BZGGDQhu3V1o0D3GWOVjVhWsKMSw/0kK9vbgdv6wo72P?=
 =?us-ascii?Q?50YDA2g92WhEKZYS0V6h2c6F/bLmwh6V9IrCND/1vLaiMQan2cly5UTcF9+N?=
 =?us-ascii?Q?4e3pN3fg6X8DBHoDy/H96MC4IyhgZkPzV2NrC24zLDaBLrGNs4tmRFoFKM1k?=
 =?us-ascii?Q?l13qlsdBbR6rTiGe7oVCvIit3QHu3+RwTyyZ8CXLm2xEO5mozWlVJv6nXms3?=
 =?us-ascii?Q?LrhIhP/M5bND6pXHBoDUKbaz1GqN1vb5HYzivdNGBJM87Pk5yIGlpVn1pPgq?=
 =?us-ascii?Q?Zkh67ih6Zy8I9r3L2+xnBgIu/enm13xdGeOc3m5lzSl5DFqnQDiBbVreJQpM?=
 =?us-ascii?Q?QTqh/2pmiWU/ee74BC57EktwbaDKJrAhGlRPMeEQmG5iSWinGVDVNWF/gG0I?=
 =?us-ascii?Q?nyYY3a8QKHDLmSWWMqI=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:58:50.9373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d5ec75-2a41-4e33-3ee0-08de0cd5483d
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR19MB7894
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMyBTYWx0ZWRfXyUo5LfRxlYBH
 AgdAWcde3AAJkmbGp5icJ+7KAtZzTSjupM/YVeACitFLYooSaXqzLv9Hs/eIU48gjgEBXDw+3pJ
 PTCUi/ale7dg25GNbxYMF0SNO29kUkPL8h9SVWLpunmePzD8nn4HY3hX2Q2jP/RRm6MlfPjhgWb
 SN2D9r6Z4fnbdy5zOjKt/tJFzbQalTdRWKE19rt4CNv0bSCYlTQmhOTUN33HatpYO+krmQ1truI
 A1UQ6ls/d0nFvEMcg0pZTZAdOGC2ReF1Tz89xNd14HUvqxB1MBV+McFwKzDXMmtfXlzP+aVnSv6
 lkQyKgqxb/j92llmZaO1LE8nQX/5kiFI0tXE7HmY3obllaXieeYY4ExHyDBYdDpn2X8AZvjtcY6
 84aW+GxDCGsSUvvr5EqGIZIZ/y9pUw==
X-Proofpoint-ORIG-GUID: VUsGi9QNbcqxgQowP2Z_fxwuKcCs2rTf
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f1244f cx=c_pps
 a=6zwKzwLBI9vfJyHbw/m+Xw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=EIw7sTYcH-EARjFZPrAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: VUsGi9QNbcqxgQowP2Z_fxwuKcCs2rTf
X-Proofpoint-Spam-Reason: safe

This patch adds additional cs530x family variants - DAC and CODEC parts.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
index 9582eb8eb418..90a5cea0632d 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
@@ -22,6 +22,10 @@ properties:
       - cirrus,cs5302
       - cirrus,cs5304
       - cirrus,cs5308
+      - cirrus,cs4282
+      - cirrus,cs4302
+      - cirrus,cs4304
+      - cirrus,cs4308
 
   reg:
     maxItems: 1
-- 
2.43.0



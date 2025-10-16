Return-Path: <linux-kernel+bounces-856644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B07BE4AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA76054557C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ED53570AD;
	Thu, 16 Oct 2025 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="IwJtn9H+";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="rEstz7eb"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4C433CE96;
	Thu, 16 Oct 2025 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633359; cv=fail; b=fz5HthZKGtKN+7wBZI6YjFllzXE38ebII4pwE8Juru1WyLOL2VeFUcodhnCcNOBUTMPmy9QXdI3luFxcSbvXgPEI0cRauUGUoxvuSGwh0vzNrRmSvuOusoA3xsPABuZF6bbLqQCUtSfbPmOfEjmAVqXDQuJ6ukv3Vq9IQmrAb+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633359; c=relaxed/simple;
	bh=LgCMr6Kh0AgrixyJ2G8VLjDgU8+wpZ3SJEH/UbtQXHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZK/IiCBV3LB5YB0wnWbS0BX6Jpr+GpFqtrhhP408DEizIYnSLfa7SHv/stmMZbnJYMPilGSypezbv6k9nP80OqNWdQi5ivEpGWbXEk2SjRPWkx72Vpja3WBO9G3uHHDIjugrbYHuiNBfe1ADeL2xkCLeJKxftKrdEnCvJLLMUP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=IwJtn9H+; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=rEstz7eb; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59FNj9KK298651;
	Thu, 16 Oct 2025 11:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=9wngttqaC4L4P1iGGBJcGvYx50owhYl9VrkkgkOsGHM=; b=
	IwJtn9H+HyJZfW+7Zy9IJj8b+QRV/R1KybpxWECr8MAikPAo2krDlS1wcS8036Vm
	lkjw6Q15ioxfL3hNFmj8kL30FHG/wGJ10CEbzs14Qgq+ZdLpSgSezcZqxbTzXbEN
	3LS39Cf0Tl3VB4Y1fjGnxbhJaAl/LJNc7yTwEA+pMcvoe9CwWwNCOnpLGGp2wViN
	ids7aWg3CRdzp5Y2F4ohcivRNHHzV1arqauBZMLpjOjhs7pXZ5K20EA1xNNYuhAp
	O3ILfnAHst1hlQcWJ8Uu5RXG2P622Kj28mQhK7x5Njj8tz1C6wJ24Clx6Xv2xODf
	Y+VCRHaRgd3mmzteRH4qUQ==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020137.outbound.protection.outlook.com [52.101.85.137])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhj91w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:49:06 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWQ0v19VCgCL/b79g5bUuCNwObLggasRmTCQ/niuJRNqK1nNBXYscmTTmd+7pWzB5KV7+Z7vIhfBZ+EHenesptbvzjWlfTfgWNfLHNDPmt0UsBHV04KGVluOXaJmmH18rcl41KjTL1lW8XfydS7yzSZWjU2bfAhkUrfMl2xR2Fef+kL450Vb70vcaRNELCgP8zKytkfbM1vR441MXyPwIoBsd4iiuvaVvFS/7zMK5bZtDZ8ajbtK85OZdWJCW7kGu4PRBv97O6zX3YyXRA4vPFb+y7rUu5gpvM+h4ktI6PAIo+mljFKF5DH7+DTj9XY377tXqRH5b4KbauTIqcTjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wngttqaC4L4P1iGGBJcGvYx50owhYl9VrkkgkOsGHM=;
 b=I/z7hjazu3XNynN3cjjDDDfjIRpLyQ3dBBQxCXkZMcOIvon3KtmvBaGK81/bHYOc6Su9+66ivKkfKZ+hoipyb4I/9Lap65tRgxoRzDEVJgjD0pbgrbKWv+TVEu2/ZTQhjKTzGp+l6smBzCYYad3yFstqhRdEdebvgetXEKyRfZH+of4XDRiAIhMAdLBpduw24Vik15QVj8vX9Z/PibjJy1IZsmg4IVAYovNnkMLaLxBf7/atp91q8i03DtwOwD1S1D97DV/oXDgLr9ecicCE/1nBha+6lb+JQP5arhP8Zqw6MIuM5t/wCH13uWgXQBBDoS+qquPVuwnSBqMrfk7N9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wngttqaC4L4P1iGGBJcGvYx50owhYl9VrkkgkOsGHM=;
 b=rEstz7ebjlwPZmlkAVi7Mgez4BY5bhkmmSEVkGTPlD86gn9Z8tcvR54Y4Np3FVqntF+sO2Qs0ZQNjUPy0z0Ad7dBZqJKIsfNSh210kTPaL0wqShArdblBY+Vht2UHw0XyC9hVoHWUOg9batkSZ1i5I4I5NwaDnjKzt6AeaKwObE=
Received: from MN2PR06CA0003.namprd06.prod.outlook.com (2603:10b6:208:23d::8)
 by CH9PR19MB9468.namprd19.prod.outlook.com (2603:10b6:610:2e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 16:49:04 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::ed) by MN2PR06CA0003.outlook.office365.com
 (2603:10b6:208:23d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 16:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:49:03 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id D6CD140655D;
	Thu, 16 Oct 2025 16:49:02 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 75A13822541;
	Thu, 16 Oct 2025 16:49:02 +0000 (UTC)
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
Subject: [PATCH v2 11/11] dt-bindings: sound: cirrus: cs530x: Add additional cs530x family variants
Date: Thu, 16 Oct 2025 17:48:29 +0100
Message-ID: <20251016164847.138826-12-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016164847.138826-1-vitalyr@opensource.cirrus.com>
References: <20251016164847.138826-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|CH9PR19MB9468:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c82d3c64-cfd3-455e-e0bc-08de0cd3ea40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|61400799027|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4+WlCEIuYnirWmSUqeldxjeZDyoEj5zdnpgtxEHN9XqXrSRv5F+ffY3qCZFE?=
 =?us-ascii?Q?yoKSRwXSWYuKA0tiqAoJzKiUL8DtKpLzjaejodmErbqm+mNaORLaWpR91sqo?=
 =?us-ascii?Q?1PFkXp04lhNv9JNA7S6pbPP2laI42xSRVuHlahA/wzSqiR+5HPTqxbHXm8Qf?=
 =?us-ascii?Q?pZVMtSdP14yt+7qAw+6UistMkJUKfAqGrVl67JP3JKwwOsNGY0hJ/PROLDci?=
 =?us-ascii?Q?n3RDoNWUGf+xCi8/AX+bEVNAKEpTPeI7rF+7ht6fZlwaDfSKK1B9FcVf10py?=
 =?us-ascii?Q?lA9rcSgO3HCcyQ55oIFYmJZMpS6p/pRNChtWevbqSBJF6Aag/vQEIY4ZOhyE?=
 =?us-ascii?Q?uSFl60OZcypVkidoknXyiDERg2SuIqMTJ4QkC39YTp32mQZrm5XjWOF+s+rn?=
 =?us-ascii?Q?kni4Q/3wBBu2gIrT0FGDJAhJBppplTrfGztA16xrh31llOX+7gcc5jAMVaaV?=
 =?us-ascii?Q?IUBqpG107VxwjqrMf/YvPfrdamEQ07mcAx5M8gTy5XbYK30R8EaD124QxbRV?=
 =?us-ascii?Q?br1t4IuY0PmL/JIx0FOCAJR9L+vzT2/RWgA4nV55mTFSDaBE8bFecgH+VzjB?=
 =?us-ascii?Q?MPKKB2j/rfYoAGq09pjKZuRonTagJUmupIGbmVMb1gWd7UffcckSzZ4tBU3w?=
 =?us-ascii?Q?sN98WMpGd7EqGNgWB0QVtAL+oTwyQR0B2UDKbrJanq1PKxqgybwX/32ycuhr?=
 =?us-ascii?Q?P9gqcVVBLA9jiWgFY7KuydnNpBJbe/n2jiRRtJrszAemneinl0UtJgp0H4H9?=
 =?us-ascii?Q?I0PxG2juge88Pf1erleRvnt2ErQW13yUjqZ45XnOCkpaj2cvJ2EOUyyW4Mts?=
 =?us-ascii?Q?WYTLQup+dmB0WUdFvMgqMojSjkViYVtIE9cgxJlyTdE27IUzvuvVkQdY+8OK?=
 =?us-ascii?Q?ZSRE8Jbrhz57qBy1nyvzMnRn/Iof9PES7bGQ+iR00Ubskw5lc8HfY/AOTFNU?=
 =?us-ascii?Q?M5W/xdAcwxG1cCY3p+bhgvj4DBNorjHfiQfjQj8GVt0BwyePenPwn66m9XjC?=
 =?us-ascii?Q?RBCB9lRBEa+wgjk5eYpvhWUD83fJBsbVO3wHy9NfGJVtmrEDV0rB7AUcalbY?=
 =?us-ascii?Q?wVIzagO49CghbvYqCv2RLHvV6FGfw/dPzmUwwNXFpD1c2NYiPoeBC5o5m561?=
 =?us-ascii?Q?RAo/b9eoiySB6kY8NHBKzc2mwWNL11C6mfqZbvmItjDkeWwrrFoLX+Mfpbze?=
 =?us-ascii?Q?IjHwmZQP2h+N2Yww2UMMy7tiTUMmKqPpBjyqnP46gPWM5poZfLxZ9d0dTTcO?=
 =?us-ascii?Q?saosjbRM+k+7iZUWnanCf7+QkC4HYQpqdF2vAoj8RAfaO34Aio67h4RvDsE3?=
 =?us-ascii?Q?8T45lNwb1vePT0oRrubzt/NFtKRHXC5avUyk4lDC9QfnkpT7aQoGAucsRM4g?=
 =?us-ascii?Q?Cx0DptWkNKyLy4BzadzcEYJQ5ySNKeWXVqwVNWUMEliLYs0FnBkPWU7av8dZ?=
 =?us-ascii?Q?zudsJju+myqoRn0o6+vbrolfJ4QCpIWCDlWiAe7pV5IWi1njcexvojfyfgwL?=
 =?us-ascii?Q?hKFBNXX5HWEa/kZ5FmFtVz48QS/xPec2lANj7Bb8U0R3sal+ZgUm4f4ayPFK?=
 =?us-ascii?Q?+GI2R2U9B07nA0fJd8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(61400799027)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:49:03.8868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c82d3c64-cfd3-455e-e0bc-08de0cd3ea40
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR19MB9468
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMSBTYWx0ZWRfXwOmxBSKaMfTE
 OXLsJDLgbLWUi2MXhI1baGJ9dtDPfeYpJD+v/mwSWn+w14FF7iCyKSZenKTdsT93sq6X7BmgpPi
 qtDwlHs3vG9feVq4eRGmcRIAWkQiTp+7xJ2KHh7PRwnEbP5GP4mw3TTAhOPBHx9ELuggBYTLPPW
 AkQ/Lx4Q5A3l9ySvyOqy5I+Sn2iNfycXMyvM/g45jpYIXM20wjICsPm0Mv0/w40xpnOBQ17YCSl
 FAoXdKs5iXQJZUsozRTSG7Bzwgy31kFYZCDqM5aahLrUOcDHKAduwEqF/4//2gWKEFmboL+o2YL
 D9B67fdlhx3GJU4KawluoplUhovqVaWbXesIzW4stve8cJFw1g8g69gOMuj5WTEpIfcupFF+zlv
 klYDbWL4Si0pMJPXM1Z2wH+hJj64qA==
X-Proofpoint-ORIG-GUID: qedvp0dTpE3z6vVF5xk3V0oSIviatfmC
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f12202 cx=c_pps
 a=1umFaVqrme/hcr+f+MpLMA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=EIw7sTYcH-EARjFZPrAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: qedvp0dTpE3z6vVF5xk3V0oSIviatfmC
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



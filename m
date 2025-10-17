Return-Path: <linux-kernel+bounces-858414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B23FBBEACBC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 135685C353C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC702DF150;
	Fri, 17 Oct 2025 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GoueMrwg";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="wf+WIJkk"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A002DA742;
	Fri, 17 Oct 2025 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717791; cv=fail; b=Yv68sPRn2LvUEYLxwIQPwnLItGvDVLbSsF4J+cMVV9n5FzOrYOWsUmqPhK5RmUYTerQCxNkdagJrbQzsr8s39KO5M6BnNfeojLRQu7qogTzzaIBuMu+4P165WmMRozv5KBcgq6cAA+oA4McNqNzdmUprGMk7u4r7DPuYQC97cDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717791; c=relaxed/simple;
	bh=tbjDSErCWqWGGtzQ6o6tmpuZFxNZF4oqg1qVEfMoRpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjdbDxfPDKcTBq4zDHVonWBIy5YfV9MZz63PoAX2MiGl7vMqDgvr11GuH4GO4yRJ0eCfI2Uc7OdhJ9BOixgYhJZ379Nu1Mb+BeebvHzC2M+7ojIy/CNXwcjISrbTrqcdi9sZ1u9RST31LNXaduloumTDhM733cOIcagByS+paoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GoueMrwg; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=wf+WIJkk; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59H8PGfc4017904;
	Fri, 17 Oct 2025 11:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=KQDWGEdAIlKZJr0fQs7VFAojQO2CE64KX9VFKyXwpVE=; b=
	GoueMrwg63AaRZh56q9B89voAA2ugc6t4WU5hvXaw0P0Lbhin07r6z20q2UQ3h/H
	CqZ3fMtebu0d3qtUm57TJ+ZL+wVEoI+t0bb57+5LaOTiLNYrVmArY5C0KVqB5PdH
	P3lnhHqrQ09RSO4CoBAlIXzlxErh/0JQrq3ikgJ5FX+yYABEPG4nWQtMKu6hNVg6
	EZtUkWzzjkvQOLLLnwNVYK3Ug4pvhTUHq4p5dazRKag4+wUpjzbslgAubsEROSkR
	KXjCUIxfUWdSIurRtHxJQGuwR32tSPkuDF1L9tPLkbnJHe8hDMW0a58JBlbq01gs
	RYOeVCPHV9lBRggzbS8/lg==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022086.outbound.protection.outlook.com [52.101.48.86])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mnhsbj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 11:16:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaVu1dqFVTnZvtxlAsvzJZferJfg4oCSVsB1BreIDQ4xs1qE+/mgVkYHOR3gierNC3qigEA/YwPQ1Gi3zgmw+KYUzgHw15UvEfXG8eFjYHhOtzWy16SEJJGdQnx2jYcAIdjICvkb2/AkAbMSYHrTGUodvuNtiJMiXoRFltBpVVDK8IRfLqvKgDrIXboTKyAFDculhVjuqe10+TOXKMbo4ZYys+F9FTQ1QGpslQx4XikTbx5QEZiLpRWtmbPyMCgmqBCTJmefpp1Lzxev7SO0qm32FQlJpEGXDpzz/YZMYabTjoE/I+v6GuZJhLcS1anBeyqOFsvjVbs9cM7U/5UmvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQDWGEdAIlKZJr0fQs7VFAojQO2CE64KX9VFKyXwpVE=;
 b=d99AbHt/EkK5nPRcO3ggsrkxA3khIoRar6Os31rA6iPvm0y2BafGUHbXsklsbZLxxjV/7MZbT9nmR6Y/CYxQ3soTq5XL7oTBjUqDwuquZJ9Ip8edUNPkbMpj0n1UEfB8SrP5Anfe02CS9uIUaX/ptcOxDOwpMEFt1hlMPIRoYI09Y/e0H1XwcwM0kiEq7zlEOiLwJgBTosI66lova/ulSxF+M2/WBU1F0m4zklX6evIZpxU3bYcuYIQi3/DOzvTY/H85Cqqg9moka8aN5D5YdxljrYPFoe6jZoltwWD1Dyb22ztr5/cvTgBqiFrnyyDKA2H1nHZzrPVoZwNyMLssKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQDWGEdAIlKZJr0fQs7VFAojQO2CE64KX9VFKyXwpVE=;
 b=wf+WIJkk5SmoP9dHHrbbeUccX0Dic+s7Gg6DekoKVfsdUYLmBsh09V3U6655EqRZA4+eWIzd5Z39XVqTL6p/fCid8bYhL/msNKxDozpQjqce37WdclF2BKnaL6LUcRlCjt4tnes31krrWzorxWXohAtiteNImIJNiTbzSs7Y06k=
Received: from CH5P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::26)
 by CY5PR19MB6448.namprd19.prod.outlook.com (2603:10b6:930:3c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 16:15:59 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::a2) by CH5P222CA0011.outlook.office365.com
 (2603:10b6:610:1ee::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 16:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 16:15:58 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E23F440655D;
	Fri, 17 Oct 2025 16:15:55 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 89A11820249;
	Fri, 17 Oct 2025 16:15:55 +0000 (UTC)
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
Subject: [PATCH v4 06/11] ASoC: dt-bindings: sound: cirrus: cs530x: Add cs530x variants
Date: Fri, 17 Oct 2025 17:15:33 +0100
Message-ID: <20251017161543.214235-7-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017161543.214235-1-vitalyr@opensource.cirrus.com>
References: <20251017161543.214235-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|CY5PR19MB6448:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 06662dc7-2503-4b3d-335f-08de0d98750f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q3qfYMZnWAztDy6Xzxqnaru1ST/iUmCrYJ4shyL0QkvMqv2Sj/qCrFhdjIgz?=
 =?us-ascii?Q?MOZBP3h031dYCIWNyUq0YuWXLWrhX06vVUI19Hv3loyV3PghBRDpjMkhjK6m?=
 =?us-ascii?Q?3FLkr9yWScXcyJ7FUzBT6ZYIIbe2A+jut/Oy1YRhBKUVEK6xHyqPStgf402z?=
 =?us-ascii?Q?vV+jzGMijeOdAUvQV9XS9XzFoRPz0idAKZIe0+oy5ElSWADJ0n71vevs5pTM?=
 =?us-ascii?Q?RHCXvg8w8n1/fB82OVGSfri2Hq+PsugHYYBFX7hRam+a8tDUlvRf4QtOwPLA?=
 =?us-ascii?Q?z4iAspp8gJU02tZnoO8kroZ36MAND4Ruxpwq5RwWevNMOlfRqFK6i0qT1opR?=
 =?us-ascii?Q?856rv3BN+rK3COxr229EEqQff3HDRovQjcWgiQm4AI0k1Iwxx75mF39HYWKX?=
 =?us-ascii?Q?uy4QBzcEf6roK2v4EbGS1WqsIjyGIyrMy+P5YN2+1dWhe/ozAgrBuq3g6BPS?=
 =?us-ascii?Q?Jc7IS6SNpLEhUHCd1/hWMwXeDWG9PbMnJClTphfuXXT17Lef1nnZSG8bugUY?=
 =?us-ascii?Q?31x0CAGShU9/8DpIUrfC5TGHmhWwJ/kw3+TQOJLIWocQ2Uo+W9Qa3gQnHcMY?=
 =?us-ascii?Q?axrw3GFo2qXPDfaY2x8JCUfhnxRpUgryVqh/EMjzacd8ENsj5/huTKqyQY8X?=
 =?us-ascii?Q?mXZbdymKbTWQGCl1oFZepdJ31BUBo7oPFerdW8viQ1EGTsvN9tDeD0R1BJIj?=
 =?us-ascii?Q?Q85jH+Au7+4HpQ6/iFcX0bXu07t4yvXxz80+tl3BKDBmBLanxWvhERo6TQGE?=
 =?us-ascii?Q?mgoMuT/fMEMO5HshczEJmRk5p60JYg5ar5M0kOkLLXdpMv0lbPJh98N4mkmt?=
 =?us-ascii?Q?ckDUKYKh4y+J7uiMSWruAaK/XEOodz7Fol+jjWZj0wiAA5adhOetFkxRdMT7?=
 =?us-ascii?Q?tNVZidQoCOqBLyl2xEx7H2BXygaBWCMGXu96CByOCBWw+i9rssHkgPxqvFfg?=
 =?us-ascii?Q?8MEZWfVB2pYFuoRv9ANbgs3B/8ixeJ+Ub7z5+FhRAYdn6LcYh4SDwzpEhLc9?=
 =?us-ascii?Q?30CtFZDI+0BOLzZNGe1GXzQFJDTI6uCMi7iH+Vl/nKGx7b0tN57WEivC/XbO?=
 =?us-ascii?Q?yTskcQffga3O1zFxuNd4uvcofmW4uYucLUaHSXzZkXJRcP6Jhie22y2+27po?=
 =?us-ascii?Q?VDA6Q2BAXX4a34Kn3KC7hcU6m09CYZ77KG/tBJR/bOO8X3AApTUlk+JnyVS0?=
 =?us-ascii?Q?DpmLjNdqQlBMUYnvwyX+Yn3/WcL3eO45HGKdDcChS3f7aKIvZMt5mKE7AKDj?=
 =?us-ascii?Q?2Xc+TovQnZh6DQh2nZkrCewzmkY1rwBsnHEojlUMxVDvKxMu5kD4ql4MpkHv?=
 =?us-ascii?Q?GNeT/iE4QE2l224nGRs2VjmliovFxZpbdjKuFlX7BxXqGJT2mfu1o3NF1Axx?=
 =?us-ascii?Q?DrBuLWZtxgcW07JcKV/KIbgPCczEMM1vnD8nKBp33SQ8dZeAoNVvfF+rT/qy?=
 =?us-ascii?Q?J2NsJRPMDNwZU0cddpvhNgb0GxxuK1HSdDk0TaUX6L32flA5GfZ2NS6hUguR?=
 =?us-ascii?Q?vOEpCyNzhxSJfaUsdVB0nLKoxv365yEkK5OfNoiQs0Ap0pAvbccU7JNDvMif?=
 =?us-ascii?Q?hBrcT4nOx/EVDV3bNJE=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:15:58.0623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06662dc7-2503-4b3d-335f-08de0d98750f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6448
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f26bc3 cx=c_pps
 a=fkVT6ClcRaXWu6jQ4rTLEQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=_i-agLmN6pKht6g0Ao8A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: bCquM3C8dFkM0heYGHoCXv3zXqrSumed
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDEyMCBTYWx0ZWRfX7k8p/1XcojZZ
 XGE3y5A2kf82sepeo0ci4gTujLXW18A++q9qpEOdcnF036sUHEbxfjqzIxh8DOAeYbEl+Zndo6g
 WIxXG9hxgWqYcnm94kWboDa+sVFYqWJBflpzkgkv8e8zKMV2BEgjLQtuODUBe0CLMTDLNQ+wntA
 xfhJh6+ZZRwRq1cjszNwVBrZzLVhCkL95TBV8ghY1nPBLhwf+pkd/w+bJAZmseb8KSjPQnv9rOt
 LEFhMh0WJfgkirmWisppWH6omwvvHaAn9DFGmPfa+41Y9Z/z02bTyg1kE9JrJNn8bmkTwP8a5bd
 Vmofr6CE6TJrItJ19QMIFLUY0Zqi9e7gLP0vT/xErvSvwlpXHAxqSjtlZTtIS1UL5WRxWXoTV/R
 C/mnBGim27q9lJW7KovMK3dy+OZ+dw==
X-Proofpoint-GUID: bCquM3C8dFkM0heYGHoCXv3zXqrSumed
X-Proofpoint-Spam-Reason: safe

This patch adds additional cs530x family variants.

cirrus,cs4282 - high-performance, 32-bit resolution, stereo CODEC
cirrus,cs4302 - high performance stereo DAC, 2 channels
cirrus,cs4304 - high performance stereo DAC, 4 channels
cirrus,cs4308 - high performance stereo DAC, 8 channels

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



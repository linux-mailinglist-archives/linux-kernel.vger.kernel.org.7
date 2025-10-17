Return-Path: <linux-kernel+bounces-858410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4835ABEABC9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0764587EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09AC29D293;
	Fri, 17 Oct 2025 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="KtPy5VMo";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="LfxQ9yiU"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7604D2C325F;
	Fri, 17 Oct 2025 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717784; cv=fail; b=tkUYT0oQRQJ+vyZIP+xQGGsMIvWx/FqWv86hZlgcAREipv7qTfuy5uWzUkl7bUbDiUxZs1tARsFyhuk4roMEeYRlhgQyVB0zH/IcBs30PClFVeDKfP+b6Ak0APDy9ULSkgRNjBpJ4KV0VfVWhbgl4Hrk9PKYAwGIYl6tFe1+ExE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717784; c=relaxed/simple;
	bh=9ka1CNkqu4qof1rW5DIqRZU7SOE78ZPiN/7rOVhtwV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTwpydRkY+gu2ETWFxIFPcR1w0FeephTrAf9kkwNh0PR9mMYg0+gomV6MtJIylOCGJ1bReT1Vv2zmeXOWF2NgQ1+yiS28FLDNTfvVKd3BL64OSxFSj6yRHVqrjBq+I/huDFPy97KvWlLlYPgygIuNVBHIDN8oz0veOY4v3g4ypY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=KtPy5VMo; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=LfxQ9yiU; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59H1p0Y84141154;
	Fri, 17 Oct 2025 11:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=0/mQ75kraEDh1WVg7siN+QNcMFFvqtt0wx0k0TNBytc=; b=
	KtPy5VMoMwzIddOB/qL1dyQChD8FFjkhzypUhtcML/8PGgVDFqJn5yJ/w5Ki1cD1
	1wtLtMhV+3ew8DyNyAzYgu4ZksDZtxIpMYzlo2r6QeOaOIgejXSyEk6tWiDTGKbo
	HN6e3tX6UnkKSHy80oRR9YIuzmByv0DRoduwPkj5R9As6ZVJH26DhQj/GOkTEqp3
	tB2MStTrD0jx7RYC2410PYXOf8ih88nnVS3DFZJKpn0HJx8YHZ1PG+YSIm7JVL4V
	w9Q9aMjK6quRIkffNcm6RDZqLWSJ8W2KpYIZMDM2TGSyZQF+HJvbbM34A+VdTH+N
	EymA6hJsLvuM1FGDtj6bwQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021076.outbound.protection.outlook.com [40.93.194.76])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49ubc98w71-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 11:16:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6yax5kt3WtE76cgvC/jbZKfpbq2tVD9hL+My605rkihLHRdA5hYTsDE6XLLdB55h4LTotR+4tlJoYPyEg4R4VyUpat21QqJ22uzZ6E1hfbcRYl20vpB1Usgz3gPFLzIfjgrcEtYBJAW2dyRp6/5vo01OsdtFhL0HrxewpYZvhKzsWzYYXkrpEg4w6YxBSVbfYofqRtv82rsTyhdH3Bv0OkBFI6hYAN9yRKmc4KXD5xxxfigCVAC9sOTPe1euAKMmUb9EA8Ne+BD9buL5y0lIe9kRegvS1Esqf7Anea5X5AE6G3ybdRFa0UwYw5tu75JA/U/x+I1y4L2pFSqJlUeBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/mQ75kraEDh1WVg7siN+QNcMFFvqtt0wx0k0TNBytc=;
 b=TyBttgeyG+hfN8RPNAqgCtwRo0+3i7DTfkABL3ULFOtR9n/wni/16fFSTUCyNocD62ISNRnZrB11jM8NbTm6cB8FKHmG2XS4odQkra7fF3uF/WUuvHw6PXe+KE8KMkBpkqYk91+sBm1VWsh3e/4NU8HC9HNXsdT8JKCG5bGSGtejaGKW1eNqughQZS4CQSEoH03qyxuXC8YuNF35ER8UtuVoH7J9uPuoBF2NGhmYRezo82Vg0RMC7l1p/Y8zfJrYNERGnGMg1+jASVo8hzdBuATzNBKXGqWTyrAEPfEsLmY+vkUdOTAaeghwCajovEmoF56wKj/6zrWTam6uw7yQvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/mQ75kraEDh1WVg7siN+QNcMFFvqtt0wx0k0TNBytc=;
 b=LfxQ9yiUgHHfClVB3O/lmHT/rnjyVSxRpXjxAIcXck72g7KZVWULKK4Gm+iedFdClOmoYHHL9fHKcP9AMAiFI9+GM7Y74H24Wn/8XvRbJIU70dRkJCUq85mqU+9naKnZajCPU6107lBtGkChI/+EaGXVTzRE2TC07F031o9S+6Q=
Received: from PH2PEPF00003849.namprd17.prod.outlook.com (2603:10b6:518:1::66)
 by PH7PR19MB6505.namprd19.prod.outlook.com (2603:10b6:510:1fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 16:15:57 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2a01:111:f403:f90e::3) by PH2PEPF00003849.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 16:15:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 16:15:55 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id B5FCD406553;
	Fri, 17 Oct 2025 16:15:54 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 5E4A7822540;
	Fri, 17 Oct 2025 16:15:54 +0000 (UTC)
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
Subject: [PATCH v4 03/11] ASoC: cs530x: Sort #include directives and tidy up whitespaces
Date: Fri, 17 Oct 2025 17:15:30 +0100
Message-ID: <20251017161543.214235-4-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|PH7PR19MB6505:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 45f2163a-52c6-4676-6fe8-08de0d9873c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BEeWN1d2vvtvmnQBAU4d0gWRCvpy+NfjCw/uTfqFNp96QvE85RiFfX5w+DXJ?=
 =?us-ascii?Q?vEQwOPLg22AWYsmuPv7Uhnfq2pOhY12bOYvHk/nxaCNZVeMLKUCeaHh0tX+x?=
 =?us-ascii?Q?t93tahE/KXu0i+xzAdbahU6RIc78RTO1+GjpGE+CgMnybnW+MLn+vZlFXhez?=
 =?us-ascii?Q?pd1x64YEPw6WinupKcvBy7LSmjLlVwy9S+TM2g/NsDhA8P8hAzLNFyvH+HSq?=
 =?us-ascii?Q?nVrkur5q0CBqXfXdJbLJMLukihV/WVyREMOHZ46SVDT1BE6GQr3+LopZ3K2g?=
 =?us-ascii?Q?3pemVnCBAFqXG9TSSaNAThvaKDxbF91Lkel6yeeG/AAJIBJUwNSvywZiAwdU?=
 =?us-ascii?Q?m8mq6m1ENsgw0QWrRZ2+XQ/5AflsIZmqSccWb19p93AJzMkYq/9NM8rUcLJk?=
 =?us-ascii?Q?73/FNgtfg5jiJrv3VIeRsic7/Em7eqn/x6GucqLG9phIw9Z0wWdd7tPbODLF?=
 =?us-ascii?Q?FY3XDmMr+hZV9SigFEkE4s8ornse0E/w0tS0y9Rb+ZF61uWxQwibX7cpysDr?=
 =?us-ascii?Q?Y4Mf74Xu0/M84h/dvuF4Y2V7PJy27ivOJg1SV6qroIPYhsgZLL2dTLRWqeeo?=
 =?us-ascii?Q?QD7Ziupe7OelngWin4TiAEW3stuwmWRsSdPbrKdqvufbsvNQubWnUePm2R5q?=
 =?us-ascii?Q?GVE41vuvZqjmeQo124e0n3eDvdxQlARqRz1GGBLXn71MPbbB+7AnDU1yaaLm?=
 =?us-ascii?Q?1iMFRfg7axA2BpcyV/ojf23CkDdzvsOiC4s63fvaPcR+/KlIeHuIpTbZ/Mo5?=
 =?us-ascii?Q?RVMYhkARio6C5v9rBgiYYOo+lShs0rZzT7kd3Cmy7aU4cnldGFaCj9MK6oVA?=
 =?us-ascii?Q?YeLue7f2odA5sUYFV837l1VlxfffSswFMPxb9Xo/IhqtxhKFkhdboExo3xG7?=
 =?us-ascii?Q?NRYHTDSCQA6EO0/KvJ0tSA0YN+wsdqek/r1FIV9CrAQwagI7XdhxNRt6eB5W?=
 =?us-ascii?Q?xRG05eVkcr1eK6aa0ir4k97I6WlBpwaFahZM7zhWPFdJqGawEYpZbuvHyLcQ?=
 =?us-ascii?Q?uGWKFjSzBo4GTgqLF+30kjH2VZMyPkVAV4IzgRUhQ4EVhJ+fjl38xqaZ5UHh?=
 =?us-ascii?Q?aA+AYCFbE/QrTT9O1FFydbWG7ZKZe9tYFC2Z6ocbfxV5lcQjGQ8k0QtCMgjv?=
 =?us-ascii?Q?FXsgIiA0prjybTlwlQ1M2dgSXGK81Cyv9u72XxCwok46bZJoHDzhC5mCJ7Nt?=
 =?us-ascii?Q?HQNrvKXjWaTrTnxGlSJppo55JB7rJqPVbRirPeufDkRmE+zqBIFMIJj+ANJa?=
 =?us-ascii?Q?UYwfNRy9lk4fGPPcxAL0yGpZ814pDW1pznmvkMRGkahg7bmQVHU4rWSPu0DE?=
 =?us-ascii?Q?hXzN8ApJPHc4MzpSD9AxNtunF0azzU4op0IsUU2ZaBZXbLtvNNSAoXXWVH3F?=
 =?us-ascii?Q?NsDphaEuk3klLyEgtjTSYN3H4eB8/Z5Lz1M1M/NQ+O9MSnBVH6Spj/8ylK2c?=
 =?us-ascii?Q?9cZlpuN4I+hoQqIGNQPki1XLjJxv8zLV7prrg5W3K2AetiPQ4HsPFeUMwzBA?=
 =?us-ascii?Q?f1ShC/UP05IgeKGGrmLpSt+hSM7LrtH1b6Jitzx19YwB984chzwG1AsH3nQI?=
 =?us-ascii?Q?p4VNbd9FsiqB/irBLkY=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:15:55.8929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f2163a-52c6-4676-6fe8-08de0d9873c6
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6505
X-Proofpoint-ORIG-GUID: miDzXSwGhTMufMH9j-CdNHLL4q-MzlJ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDEyMCBTYWx0ZWRfX6OifGQs5IAZK
 0pxm5L2/VSA2M2nRyJf/EfYsOm7ze6PO4RyttdzGfJGnhmIMD63LQDn+nE6nS8bO2txOtL10ptm
 tRMgd8m68Mfa2q4KhA3bVOAA0AWB204FWjSupilKvnrAC1yc4BZNTlWi2zYoY7o7Tcbec4ctqZh
 w/5L5yO/qm9rKFBNPfzfOp+AAnKtTdwGxRrHzVD3neN/KSAdXBN61kmd3nj5DjAdiVbwp7L0hXc
 L8+dncLgUYHk/qtV51s1F77atyYYnVpCQayNrtcdYJL/+FIgMxKg8MUWt4L0yj60Gj+b6aBQjn3
 F3Lf3RIw/LC6CKO/m0BdkLVWqfmhkpIHOo8k3d8jD+zLAiukmzGhN5H+15rtZlz6mCAfYJLaLUw
 3ALDfHB46Xb5BwI6L7fX5GOUC3d8oQ==
X-Proofpoint-GUID: miDzXSwGhTMufMH9j-CdNHLL4q-MzlJ6
X-Authority-Analysis: v=2.4 cv=H7bWAuYi c=1 sm=1 tr=0 ts=68f26bc3 cx=c_pps
 a=CWl35G79Ma0v70ZK/2v6Gg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=wFt9MVH1Lw3u3H5ftKQA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x-i2c.c |  2 +-
 sound/soc/codecs/cs530x.c     | 49 ++++++++++++++++-------------------
 2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/cs530x-i2c.c b/sound/soc/codecs/cs530x-i2c.c
index be80dcad3647..d6b7883ba7b9 100644
--- a/sound/soc/codecs/cs530x-i2c.c
+++ b/sound/soc/codecs/cs530x-i2c.c
@@ -48,7 +48,7 @@ static int cs530x_i2c_probe(struct i2c_client *client)
 	cs530x->regmap = devm_regmap_init_i2c(client, &cs530x_regmap);
 	if (IS_ERR(cs530x->regmap))
 		return dev_err_probe(&client->dev, PTR_ERR(cs530x->regmap),
-			      "Failed to allocate register map\n");
+				     "Failed to allocate register map\n");
 
 	cs530x->devtype = (uintptr_t)i2c_get_match_data(client);
 	cs530x->dev = &client->dev;
diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index d016e8298a69..8bbce589b3b4 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -5,17 +5,17 @@
 // Copyright (C) 2024-2025 Cirrus Logic, Inc. and
 //                         Cirrus Logic International Semiconductor Ltd.
 
-#include <sound/core.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
-#include <sound/initval.h>
 #include <linux/module.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
 #include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/tlv.h>
 
@@ -104,7 +104,7 @@ static bool cs530x_writeable_register(struct device *dev, unsigned int reg)
 }
 
 static int cs530x_put_volsw_vu(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
+			       struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
@@ -224,7 +224,7 @@ SOC_SINGLE("ADC8 Invert Switch", CS530X_IN_INV, CS530X_IN8_INV_SHIFT, 1, 0),
 };
 
 static int cs530x_adc_event(struct snd_soc_dapm_widget *w,
-			     struct snd_kcontrol *kcontrol, int event)
+			    struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct cs530x_priv *cs530x = snd_soc_component_get_drvdata(component);
@@ -236,9 +236,9 @@ static int cs530x_adc_event(struct snd_soc_dapm_widget *w,
 		break;
 	case SND_SOC_DAPM_POST_PMU:
 		regmap_clear_bits(regmap, CS530X_IN_VOL_CTRL1_0 +
-				 (w->shift * 2), CS530X_IN_MUTE);
+				  (w->shift * 2), CS530X_IN_MUTE);
 		regmap_clear_bits(regmap, CS530X_IN_VOL_CTRL1_0 +
-				 ((w->shift+1) * 2), CS530X_IN_MUTE);
+				  ((w->shift + 1) * 2), CS530X_IN_MUTE);
 
 		cs530x->adc_pairs_count--;
 		if (!cs530x->adc_pairs_count) {
@@ -249,9 +249,9 @@ static int cs530x_adc_event(struct snd_soc_dapm_widget *w,
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
 		regmap_set_bits(regmap, CS530X_IN_VOL_CTRL1_0 +
-			       (w->shift * 2), CS530X_IN_MUTE);
+				(w->shift * 2), CS530X_IN_MUTE);
 		regmap_set_bits(regmap, CS530X_IN_VOL_CTRL1_0 +
-			       ((w->shift+1) * 2), CS530X_IN_MUTE);
+				((w->shift + 1) * 2), CS530X_IN_MUTE);
 		return regmap_write(regmap, CS530X_IN_VOL_CTRL5,
 				    CS530X_IN_VU);
 	default:
@@ -263,16 +263,12 @@ static int cs530x_adc_event(struct snd_soc_dapm_widget *w,
 
 static const struct snd_kcontrol_new adc12_ctrl =
 	SOC_DAPM_SINGLE_VIRT("Switch", 1);
-
 static const struct snd_kcontrol_new adc34_ctrl =
 	SOC_DAPM_SINGLE_VIRT("Switch", 1);
-
 static const struct snd_kcontrol_new adc56_ctrl =
 	SOC_DAPM_SINGLE_VIRT("Switch", 1);
-
 static const struct snd_kcontrol_new adc78_ctrl =
 	SOC_DAPM_SINGLE_VIRT("Switch", 1);
-
 static const struct snd_kcontrol_new in_hpf_ctrl =
 	SOC_DAPM_SINGLE_VIRT("Switch", 1);
 
@@ -450,7 +446,7 @@ static int cs530x_set_bclk(struct snd_soc_component *component, const int freq)
 }
 
 static int cs530x_set_pll_refclk(struct snd_soc_component *component,
-				  const unsigned int freq)
+				 const unsigned int freq)
 {
 	struct cs530x_priv *priv = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap = priv->regmap;
@@ -492,7 +488,6 @@ static int cs530x_hw_params(struct snd_pcm_substream *substream,
 	int ret = 0, fs = params_rate(params), bclk;
 	unsigned int fs_val;
 
-
 	switch (fs) {
 	case 32000:
 		fs_val = CS530X_FS_32K;
@@ -540,7 +535,7 @@ static int cs530x_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (!regmap_test_bits(regmap, CS530X_CLK_CFG_0,
-			     CS530X_PLL_REFCLK_SRC_MASK)) {
+			      CS530X_PLL_REFCLK_SRC_MASK)) {
 		ret = cs530x_set_pll_refclk(component, bclk);
 		if (ret)
 			return ret;
@@ -614,7 +609,7 @@ static bool cs530x_check_mclk_freq(struct snd_soc_component *component,
 }
 
 static int cs530x_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
-				 unsigned int rx_mask, int slots, int slot_width)
+			       unsigned int rx_mask, int slots, int slot_width)
 {
 	struct snd_soc_component *component = dai->component;
 	struct cs530x_priv *cs530x = snd_soc_component_get_drvdata(component);
@@ -686,8 +681,8 @@ static const struct snd_soc_dai_driver cs530x_dai = {
 };
 
 static int cs530x_set_pll(struct snd_soc_component *component, int pll_id,
-			   int source, unsigned int freq_in,
-			   unsigned int freq_out)
+			  int source, unsigned int freq_in,
+			  unsigned int freq_out)
 {
 	struct cs530x_priv *cs530x = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap = cs530x->regmap;
@@ -743,7 +738,6 @@ static int cs530x_component_probe(struct snd_soc_component *component)
 					       cs530x_in_sum_4ch_controls,
 					       num_widgets);
 		break;
-
 	case CS5308:
 		cs530x_add_12_adc_widgets(component);
 		cs530x_add_34_adc_widgets(component);
@@ -775,7 +769,7 @@ static int cs530x_component_probe(struct snd_soc_component *component)
 }
 
 static int cs530x_set_sysclk(struct snd_soc_component *component, int clk_id,
-				int source, unsigned int freq, int dir)
+			     int source, unsigned int freq, int dir)
 {
 	struct cs530x_priv *cs530x = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap = cs530x->regmap;
@@ -895,8 +889,8 @@ int cs530x_probe(struct cs530x_priv *cs530x)
 	int ret, i;
 
 	cs530x->dev_dai = devm_kmemdup(dev, &cs530x_dai,
-					sizeof(*(cs530x->dev_dai)),
-					GFP_KERNEL);
+				       sizeof(*(cs530x->dev_dai)),
+				       GFP_KERNEL);
 	if (!cs530x->dev_dai)
 		return -ENOMEM;
 
@@ -914,10 +908,10 @@ int cs530x_probe(struct cs530x_priv *cs530x)
 		return dev_err_probe(dev, ret, "Failed to enable supplies");
 
 	cs530x->reset_gpio = devm_gpiod_get_optional(dev, "reset",
-						      GPIOD_OUT_HIGH);
+						     GPIOD_OUT_HIGH);
 	if (IS_ERR(cs530x->reset_gpio)) {
 		ret = dev_err_probe(dev, PTR_ERR(cs530x->reset_gpio),
-			      "Reset gpio not available\n");
+				    "Reset gpio not available\n");
 		goto err_regulator;
 	}
 
@@ -947,7 +941,8 @@ int cs530x_probe(struct cs530x_priv *cs530x)
 	cs530x->dev_dai->capture.channels_max = cs530x->num_adcs;
 
 	ret = devm_snd_soc_register_component(dev,
-			&soc_component_dev_cs530x, cs530x->dev_dai, 1);
+					      &soc_component_dev_cs530x,
+					      cs530x->dev_dai, 1);
 	if (ret) {
 		dev_err_probe(dev, ret, "Can't register cs530x component\n");
 		goto err_reset;
-- 
2.43.0



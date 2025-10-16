Return-Path: <linux-kernel+bounces-856650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B50C1BE4AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464E41A67877
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1082E1730;
	Thu, 16 Oct 2025 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="O63JZwNI";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="zvKmjPKK"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9C350D44;
	Thu, 16 Oct 2025 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633362; cv=fail; b=QXNq6qLmCCBZpU63isdYrlm5I5D1mw3Pk2bvK2e8eAZs9cfpyZjztOGivMZsOPRjka4h/u6G4jBln/BQItaUKhrWVGZO/PMkVO/Qj17LSAyiZ3udDqg0VMmIin8fnkXt7aYO0gancMEh1CIMOIA9sqO5LPYqVUvsGa2NsNgLBpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633362; c=relaxed/simple;
	bh=HS2Uo9naVxxtKpYwUc0L+cG+1ST1OUNnCxXY31GY65w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWt/suhZ7ZkXrFgo8dissSNlymSFDnUPuQl8FoERhUmdI30roHaOBx9RIXpA4Un1mbnsjG7PEfMf/sUORa4nXu/Ibu6f3i0ILDMTvuY0t5RFWTn+Kj1GQhsDZo953svef8B1vtRgl8WxGYU8FaAjwYsPZxy6pKm9Kk2qxLgO/pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=O63JZwNI; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=zvKmjPKK; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GDTFSv4017904;
	Thu, 16 Oct 2025 11:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=P4z/GWhVAMtRz5fD3jQi3LjVqI6tJLg75b+A4g0PhRQ=; b=
	O63JZwNI6agf2OjCiN/2QvmoA2ginWMWwJcq9qb/Rifilpt/FduAtUZv15yf6iDQ
	ub0TqtnvBJy76AUtK5JvMyWpHcFiVJ41tDu1/F0H3JUSRtkfxiyAc10MgP3rE+GW
	V3pEjACjsmmiYzbWHCS70G+Pky9JKjTM7ktNvD0Aln2lUFqKn0Wz8Hn6KRG5oWMi
	1eVr2RU+r0NKTzJcB8T2U1t393RYiQDKKXvCzJ+t5nTKdJ9s41VRIm6hQekA5LnL
	YKuu2IG3Wv83lNZpZX4pe4MtLiw3tK33c18vexmSV06doAtFYDvmG7L9oLsnRTGm
	YugYd1N5+o+1f4yGt/arwg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020098.outbound.protection.outlook.com [52.101.85.98])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mngak6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:49:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzhPLEhQpHSy9oR9eBmvCmcNYKwQgamqbQu3RYQwv5NQNgh0T1SoZFkX3tC8Its9JOygSG+Wh4gjZKgdT6sLyoRoYcDtHyoMlRkzhlocGZyUlVdAHHisjUmSW6Jh+or6kpC3MY58otPSkrl11p/dO51NhxYKVD3oUNUBCnk6m79s5zWT4/oJPJhEL2tMDslH9SYSGzIzRxZJ0nV+qsP9XGtMxdcN/cfYwwaskFF9zTFEG7CofBRm3a66Hf4eHMolMdHup5K7BrWwk6pn7MwlWPUq8524r7EotEXlDIWaosC/zPqeu56MQN3BVxgYYY14TPat54SHxR2/ctqy/oCZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4z/GWhVAMtRz5fD3jQi3LjVqI6tJLg75b+A4g0PhRQ=;
 b=Po1Q+8o4Y4IsyQVqYGnliG879wIx/N9sgQVKmFf7NU/t3TBqvUq6h/YI0wbahizU6DCavDOShurF5IVV9ueXGLK178r0yB0Ts5ndCZ8apWo1SpcET4v+5eUNR4bvS/k3OnJbSit7kK59eUy04YlXWYaLAuw8anVpn+LNRK6AUlBc/ufkiKqYmFoU8Q7Biuza4ljmBSrVI+/OoEaxRgUihQxMceRFa5czLR8PslOZyc7SkYz6mAZRTQa2GzBq7bpe9fNzJhQh3PXCyEoFLgftl3cyfSyxCgmZ6E+QAxprfD8h94a04j89nNjaRQzLRrXCmjWikYOehfFM3jpF2+4/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4z/GWhVAMtRz5fD3jQi3LjVqI6tJLg75b+A4g0PhRQ=;
 b=zvKmjPKKX8uyRNb79ok//TWC8kLk1LoQGHbAlwU4mQhF77BBen9DCpzt9Oq9K/HvC0ZXSviiCu+4wXUg4iQ26Vnh6STuGwBNnRTDu8G9lgyPz8E7Fx8RAidssRs2fiudY1MXCVPSPeH8tjiL7s+ANt1k+RWRHoKkqVr+iVwouek=
Received: from CH5P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::6)
 by DS0PR19MB8342.namprd19.prod.outlook.com (2603:10b6:8:1be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 16:49:05 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::68) by CH5P223CA0019.outlook.office365.com
 (2603:10b6:610:1f3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 16:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:49:02 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 64F4D406556;
	Thu, 16 Oct 2025 16:49:00 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 0D7AB822541;
	Thu, 16 Oct 2025 16:49:00 +0000 (UTC)
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
Subject: [PATCH v2 05/11] ASoC: cs530x: Correct constant naming
Date: Thu, 16 Oct 2025 17:48:23 +0100
Message-ID: <20251016164847.138826-6-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|DS0PR19MB8342:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9771869b-2d38-4eee-4ceb-08de0cd3e943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9UUWSHjAa7E51Bfo0iwT9e9e1o6I5WOPWls4KxD5q1OwpYKTvJTcMfJFe4z1?=
 =?us-ascii?Q?aBJL9eDug72Wy7yUHOdtlgehs2VqhQlVcrEdSXyNJutTuGTF0pn1GfI4Cdiw?=
 =?us-ascii?Q?1qTGQK59LAGshnTySwIbuMHlmYj/Iuy6IvbWI+ouYrq2XGnS1oLzZb4FjBak?=
 =?us-ascii?Q?Dc8pj197OYJI5elb5T1vbf7cwfF3/5TI4fXI1yAeO2422BgHCwtbITTfriKS?=
 =?us-ascii?Q?SnpHzWZg8uflTPPNJ5EJir3rnicgsnvWTCltsgbVenCkr98chx7vHHrJCdgM?=
 =?us-ascii?Q?7Dtx6UJtWtU/AjiZXbnpC4v1+RAQ7FnuW5n8u7NRsUL5C0gtJxcR+Lk7Vbu4?=
 =?us-ascii?Q?DCAAFzX+En3dGsr1YmIrpWFn3GHLT3f4DATFsNiguTAkalxWVm6Rny2eZL5J?=
 =?us-ascii?Q?HwgFJYUadyu46l47+7jVB8GAMw1NJxL6ngDO8L7JJFrF0knBitnXj1Dn/3ix?=
 =?us-ascii?Q?JFAuhh+HD24a0u8p1nZz9VDg+QhApEKkhaTgt6tKHSCiemOQrxBKdSDI42+p?=
 =?us-ascii?Q?jmckgOUYUwhhujoIvcYkj9sJnZ5BzbhipZQ02/xQViA5ug3sq2fVpTfZ0O6h?=
 =?us-ascii?Q?WKYOl0aD4r30jjERmzpYTxmANA3ckB/emUl6rMTtm1c8LV65tQzYiNLs+G81?=
 =?us-ascii?Q?0PQL5cLkys50dbk8FwLlOQWKmDVoAmVO7Sa1SL+NQBcCSXizkvuspE1WqYgr?=
 =?us-ascii?Q?T03qDkk9jMgFsYJ3riLneEvYYnPOG6BB6NUD9RsXgPc5CY0LuUhk5XO6qjcM?=
 =?us-ascii?Q?GCV888KPs25CzLsk7lH4OSNJnu1e+c1II43so7EGgjAdIb7bQPiHw1btQMC/?=
 =?us-ascii?Q?bbf0gEsr2HVDjG8lPOa7gsqRktrnqMwaCbO1FCNkXc9u0pS+c11bfSBH+RV8?=
 =?us-ascii?Q?ksEl5T89BvfBZNh6BJXeHKHj6ycDRQTZrSvQZT/sQCLcd8WqgMJtAXCtD2PA?=
 =?us-ascii?Q?/upRjSpDngoCC1dhVXpIWbGySIKDUSEeQfY/3/ivy7j46pwabnqPiI2EirjY?=
 =?us-ascii?Q?elkQs8c7w7kGeVrhIMpwdKsW3DCMgwuLQjNDK6vsEFbhmjI4WAW4eBBmekSh?=
 =?us-ascii?Q?jLYbmfKXIo/tzImmdJDo1MzeKOjfqh3wZocAQsFnnSFSLOP4VcSjlrMiUiZU?=
 =?us-ascii?Q?us/iS9sMWLMpNIh1KVwbzKxdfrbxp6Iuw+2KNAXwNIf8vL1k+T6L+Ws2XHlm?=
 =?us-ascii?Q?MgmyN4cz2IqCLpvudlxBg0XoLpxIXkXhUdchyEFfwgQns9TtUiR/7/T+0qIa?=
 =?us-ascii?Q?X+iMcWbsH7GcRKKKPNWUuINf30yy8Wl2pQpQY5NiBzd4do3J/rF24PoOpaUS?=
 =?us-ascii?Q?lAw6Y79vxYRUTZbukqUd0dyfH+0zGwHkuxYqsKGQoJMok85Lv3D7Z0UyGJTb?=
 =?us-ascii?Q?t1n9yD5iCvgDubnP32yKyaDOuj2W+Ebj1YK9TKrcYp0Xw4SiE2qYdCHUX/Kc?=
 =?us-ascii?Q?j0RdqQU7tMRHJa38OQ8YGShjGSYrXb+U2ZvyolC8xCfpg06FKHoi56UgHwaV?=
 =?us-ascii?Q?HOLInb2qkJgwus3+BcbYZrrl/D3B+CUlS3SUAOdMnmhpXaBFhKVg/6rXyCpS?=
 =?us-ascii?Q?4VH4QDmtk/5m/bFhtCU=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:49:02.1989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9771869b-2d38-4eee-4ceb-08de0cd3e943
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB8342
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f12209 cx=c_pps
 a=5ZmoExZQM1RqZyAr9AiZEw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=zWlGrJBK1FuhkNR3vBAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: G7LvcshbW5p47hhegdsugTjbfA0DgaSF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMSBTYWx0ZWRfXwoavtfzNFqJj
 CUbnMkRE6vLuo8HDX6tn0iwfKMCmmFjArTNOx9txbiT3ZD3XFMB133SJs+HEyCUW3niYpXXclxw
 j7wDGhMyQF9+VyEoWS+Dbrn8e/Yg69gxbDCMICi5731a6sOEBC1N9VSDqh7lqWV9B0zj5H41rA1
 /mXIVtznK3oLN7tKgwo4TgLkLAMhBVPcq6S6DUAxgwAjzxzWMmS0WX1oTgL49lYtjKCNAzQh0rC
 S+7aXTsLO1hI6viI+h+719M/qVyk7rDpFAtBKGOk6xGf1FGBau61Jtk+FqdjlEBlLIKGpRTxkvB
 rCg1lBaeSXpdv2AcZR1o2Iv9DGX/rDjyRnQ5q4BUOkYs9vOjkcc9d4B9IP38fPVsafevMHWk+nd
 i4RTafiMksHhn2YXStJoVVQYmsgMSA==
X-Proofpoint-GUID: G7LvcshbW5p47hhegdsugTjbfA0DgaSF
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c | 10 +++++-----
 sound/soc/codecs/cs530x.h | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 4add46ef93cb..336ed5f225ea 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -491,23 +491,23 @@ static int cs530x_hw_params(struct snd_pcm_substream *substream,
 		break;
 	case 44100:
 	case 48000:
-		fs_val = CS530X_FS_48K_44P1K;
+		fs_val = CS530X_FS_44P1K_48K;
 		break;
 	case 88200:
 	case 96000:
-		fs_val = CS530X_FS_96K_88P2K;
+		fs_val = CS530X_FS_88P2K_96K;
 		break;
 	case 176400:
 	case 192000:
-		fs_val = CS530X_FS_192K_176P4K;
+		fs_val = CS530X_FS_176P4K_192K;
 		break;
 	case 356800:
 	case 384000:
-		fs_val = CS530X_FS_384K_356P8K;
+		fs_val = CS530X_FS_356P8K_384K;
 		break;
 	case 705600:
 	case 768000:
-		fs_val = CS530X_FS_768K_705P6K;
+		fs_val = CS530X_FS_705P6K_768K;
 		break;
 	default:
 		dev_err(component->dev, "Invalid sample rate %d\n", fs);
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index 165adb88f4a4..cdd54bfa259f 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -69,11 +69,11 @@
 /* CLK_CFG_1 */
 #define CS530X_SAMPLE_RATE_MASK		GENMASK(2, 0)
 #define CS530X_FS_32K			0
-#define CS530X_FS_48K_44P1K		1
-#define CS530X_FS_96K_88P2K		2
-#define CS530X_FS_192K_176P4K		3
-#define CS530X_FS_384K_356P8K		4
-#define CS530X_FS_768K_705P6K		5
+#define CS530X_FS_44P1K_48K		1
+#define CS530X_FS_88P2K_96K		2
+#define CS530X_FS_176P4K_192K		3
+#define CS530X_FS_356P8K_384K		4
+#define CS530X_FS_705P6K_768K		5
 
 /* ASP_CFG */
 #define CS530X_ASP_BCLK_FREQ_MASK	GENMASK(1, 0)
-- 
2.43.0



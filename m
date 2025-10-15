Return-Path: <linux-kernel+bounces-854178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A663BDDC4D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13212188D1BC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D8C31A808;
	Wed, 15 Oct 2025 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="k/H0r/5q";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="ktFhJe72"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD013191CB;
	Wed, 15 Oct 2025 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520431; cv=fail; b=PNsZmIm0PG4yI7m4uwxu3PfTF+VRJhLglcD6956iles+Dd8modg2gvx9a9T1cqE4AyfdKeQtpjL0vXpPTyM1mt0pY8FT9O7kWa1WmLGC7gnNeY3JOR/IQojPzT5CDVKQ3rvvSGqviwYufimVMfzFwdwMLgCnJOlXX8Z/lA+c60M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520431; c=relaxed/simple;
	bh=A3L2vk4WKB+p4w/FXwGI7U8C7Ni86WDWqwTqGUXjc0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfMb5Ilgsw6DkyJgYkkiPbTlstoGYcVHCJi8Yu2w24/0YJDfnfbq0fl2V6q7feWzJ3QgN2MX6VbRbQgf2/qD/HDbDyhk3gh77WyC5bJSQsPWuGLxZa5yXd3SUr8VObi9K5feDk3jLHE8enasp+x5dwGWdj9v4T332Wj/j6CQTC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=k/H0r/5q; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=ktFhJe72; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59EGKkxw1729701;
	Wed, 15 Oct 2025 04:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=j1cYnGJdAgA2qNWusQrtGPcHD6bbmAqBZUR/854B40A=; b=
	k/H0r/5qNZ6iCTvbKQjaN1MlOUsI0NnyjxXn3Hl5AhHsSLnFnW9xf4wdPHhfFT8w
	okg9Yfe+QdoX65WBuxCNIiwPapHbIEgPFv9btnroVlpXzTqRb5CXUrZOw+2d/ZKw
	rR+74Sousqm/PE6UfPLHYRn1yXyOd9zHwA/xeA4hseW2lztbDj+21B7GQXQ99H5l
	oHoIfQ3NbGox1fNt0eUFX5RdgUaiOShM6UKjLDYzWntE8bVImlqBgBaU8vm8BKFR
	DEIfakozfkq4w8and8CN1m1xbuRSE8fway3DZp2ZR9XTUTV9sBYDMPI6LK6LanD1
	7ENePYlDimGmxZoV2+oZ2Q==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023084.outbound.protection.outlook.com [40.93.201.84])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49sdb42fmh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 04:26:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bY5Py5xrX8nV5Inm9D7tBkkw4kIw/Lpo1x6D/kVN7vG2S2aKzhW6HX7n7uvF0dB4bZ3E2wsohIjk6r0zB39TNGrDXTMeswqto7hW7Eu9ogwnPV3tFVespt5UGOPxaM+IWc5Oe7Iu6Cv0YrlqRAihnxhWLkNCZjSVf0pZF8y6tCwtEvPcZVZFitgHUDwz1uCMkB62tAN8h/tjHHziZUOgIEGPfxB1aAVq2JRR4+vU0DV1rSW4DY5804x8rgz/0ui0nu/Wy1W+tedj+ho2O+Nl3c2yHIJn1iADqOdEXNRhpOSAaPYzBCyqN8WrY2TkJu1WKPwy94RJIKF2SZFvb4nyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1cYnGJdAgA2qNWusQrtGPcHD6bbmAqBZUR/854B40A=;
 b=ONbJo1lhs1yPprCu+zs5NwuxMFgNaOpE0akpa5naJ5Olae49xLwjSH4KvCABxkKA2fh0Dd9pV2JQr2f9NWOlYPT37p5fUjyvfykU22whtu2JLWWSDKgaerZqVLufH1hPp4AR6KhVrRehU13QVao7cDBLb1uG2hHcxb1jBpR6w8ho2UvE9cL1aq+qRwadfI7ksQAHiITl0OZ3SCRMZkCicM3AT1abuOOYYBvsrxW1mNopgFg5GgAs3DkyX1zUO8TAsqInFv4a2bjMuf2P7eL/d2r+BuwjfF8uo/3MEF3dJZFGKP2liRrbX0lAN5Rvass3xR6vzEekSjQZQlDK11K8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1cYnGJdAgA2qNWusQrtGPcHD6bbmAqBZUR/854B40A=;
 b=ktFhJe727pLCtYZlKqo7Ba8pZJz+SXHkx6S6Lh0gcXOENMVKYqT0ih2NYCeMH8iDNheRoRaRbf5Ont2d3deW3LnNHGLotlxPJTjbDhgxrtTXOwNSbEwyuPNfqrEHQevdA9w8+GS3FQ+olGYqRbEjd9YkTKxCn4Br6VrUjCHf+Bs=
Received: from BN9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::7)
 by SA1PR19MB4974.namprd19.prod.outlook.com (2603:10b6:806:187::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 09:26:41 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::63) by BN9P223CA0002.outlook.office365.com
 (2603:10b6:408:10b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 09:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Wed, 15 Oct 2025 09:26:40 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 0C16E406547;
	Wed, 15 Oct 2025 09:26:39 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C1EEB820249;
	Wed, 15 Oct 2025 09:26:38 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH 2/8] ASoC: cs530x: Tidy up driver before adding more features
Date: Wed, 15 Oct 2025 10:26:05 +0100
Message-ID: <20251015092619.52952-3-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015092619.52952-1-vitalyr@opensource.cirrus.com>
References: <20251015092619.52952-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SA1PR19MB4974:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1da67531-218f-4304-f292-08de0bccf291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1eW6CPMUBvd4m/PivMmwHj5M0QTXE4/4uC/iZoKXyKEoa8F6UZ/Fo7cliJln?=
 =?us-ascii?Q?r0IjTYoY1Zz/sfhC+8l2lY0K3YqgSPtNWORdhDrPsDFN2AJY9XITQk7qpceE?=
 =?us-ascii?Q?bQSUQ+iswIUth5uGJJSRY1GbxQ05uZGgQHih0g4aN933vakaI0FwYYj8WJRI?=
 =?us-ascii?Q?+OqsT3lpvJ3waocutLNiOfC0JgeO++/7WlZUAW11ebOYKwS9y2BugCt4M1jy?=
 =?us-ascii?Q?RnoBF7zHecTyGQKiDxgEur5pA4dyHdMKA07sdpMW+ioSz15tvPx/0tWTBLdP?=
 =?us-ascii?Q?+z5HOA4eMMBVQWlGDD5DIZTVwlzNFvtXQhOCRcCl+xURpcl79qAvbIjkYCMD?=
 =?us-ascii?Q?tOvzvsTC4I0lHZ/8h7nALFcsP5JgyISl8uk0Ug3iPkHUY2hsg0/bvCBYTyp4?=
 =?us-ascii?Q?UkbqQTvT092Kirs02BqFGjS/IsbkNlrxhbsTeocyuvI6h+IzIje8KCQ2WyYt?=
 =?us-ascii?Q?cMPrTt0dX24KL7tRC3/wp+wpOLphrvSB1njZmyJrr6olQTcHh6sIwxKaw2SV?=
 =?us-ascii?Q?XrS9tjVrOZ2te6m6MrF4PDPBDDTaRNoVs+q1kxbnZ8Ymv6KELpdkLIjrFdl4?=
 =?us-ascii?Q?3/sRoRbFeDlt2GmjSzcKPzd+24IRmN8FqdZCE2r5MAvMjFB49qBtZHdcflwB?=
 =?us-ascii?Q?6pNDZ7YHIa7UklOGTJ2+sYglGdhvU6KV8LqGpOXVJq8pQIwwOjX97tfcSja2?=
 =?us-ascii?Q?RuryJrBKGSeKX18hFIlBgc3hHIThV2/xWQJIQ+3LTSnKQig+Le8NZGhgz3ip?=
 =?us-ascii?Q?vIoyLLOujRs/qogU5en3KYWKuLSdg2RslVWB+SjZFO/CNQ5l21fEaEPlmdFm?=
 =?us-ascii?Q?sc7bvbVK+b5BI6Qff7kSnwu0kqOXo2qjMgFObcDKsC7iZeTh1W9RVrgn1bNe?=
 =?us-ascii?Q?CDhaPwLi9TT1buDZss513qwvgQIR6/NxD8UcgHMZw0WhgaYWncrKFF5NtGEe?=
 =?us-ascii?Q?uGRFmtmiegYondGJmupMzouUGsI+vvc+og1vLUZD32x3khrnsE2+HYgamYl5?=
 =?us-ascii?Q?GTfDFhMEnv7h0J1OT2Me3ltjOLLbV80VNumbf9KZxSnzcrP1U3s04yK+RLMx?=
 =?us-ascii?Q?isrHAdRuBuSWafbsILPNNlxeOgNzhOULuM+V91qemNFVbThAoEF4l/8qLFOt?=
 =?us-ascii?Q?J8JLiK00CGttrOmRCadZAzNUBCd6IpGqIMrQjgcrll9P/j27xtNuaAxxN3br?=
 =?us-ascii?Q?74ZR/yFhYnLd7vxgqU0b295rIhoZatKVr5P56X1l2OtRFU137M17SkgIJQx8?=
 =?us-ascii?Q?uGOQIbd59gB51KUjzvjRaqemGZjHxzY4aWvPf9kkIQSKdDIZ386dBwATp/lk?=
 =?us-ascii?Q?81DzosqrPD1vjpMMzx0/+lfgMjhWIV32dw84xZ7SSNFPYQ0xxxx/DMlg/kTG?=
 =?us-ascii?Q?H00/x+jVf1jO1uxC5N2WkZnrjtBxQJom/Aubt7si5RsObhZstCKM+W+c1UVe?=
 =?us-ascii?Q?E8Ipq6kaxq47R2YRQYi/u9O2z+hCLwshb66xIM6mckiD0LPipnbDaD4zucpu?=
 =?us-ascii?Q?lbECNk8NDJ6+jH4m6JM682gf5WfMxdHuv9inLn2TGppPX9d9VkK06ApGvZ9u?=
 =?us-ascii?Q?gkhn7g+4doThel7iC1k=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:26:40.1959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da67531-218f-4304-f292-08de0bccf291
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB4974
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDA3MSBTYWx0ZWRfX9aUhmD4kk8Zi
 KLeWo8vQwxrRI2I30AAAPCWmAvc4dLtiaKVOsLtjFPK7oGXyT9N2/moJhYOJ4AdTthRxoMyt0Bm
 jaRbljHARXRGmK58/DSdzD9GjY94+ZUZRJkqmczfsvUKpqfUsphot2fKxQYIl3HHaLmJ/lGT6GV
 j6fyIv918tboQvLAL0pKrF+oOXZ2NjSxWJaxTftIknyMq5hjLGmVjR1NsovYl9sVg11JoEIEruc
 NcPlLlcKgRj5jVHfLQYHbacmwTVT06ERYjY00Xvzd8myAYcEyGguSYIbXpPOECwVVlb1l3Dwtnd
 So26AUODpcjYuhy0c3TL3Ru8X5m2VXhdQm5vlqIklJkafpBGPd3EMTRyyR1dNQS3lNNurE/neuQ
 7JDP4MyQsGJ/FGE/AxMbpsxn+JXDwA==
X-Proofpoint-GUID: QNbfrmLIUZxZogcc24Bq5WTn96g6P_MV
X-Authority-Analysis: v=2.4 cv=PPICOPqC c=1 sm=1 tr=0 ts=68ef68d8 cx=c_pps
 a=vrZu8FCDnvlauzLDEj0iEg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=9DK2yyeCD7_C3sgqfoAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: QNbfrmLIUZxZogcc24Bq5WTn96g6P_MV
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

The copyright headers, #include sorting, whitespace, remove unused
structure members, constants and constant naming (Update CLK_CFG_1
definitions to follow similar naming convention to other frequencies)

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x-i2c.c |  6 +--
 sound/soc/codecs/cs530x.c     | 69 +++++++++++++++--------------------
 sound/soc/codecs/cs530x.h     | 41 ++++-----------------
 sound/soc/codecs/cs53l30.c    |  4 +-
 4 files changed, 41 insertions(+), 79 deletions(-)

diff --git a/sound/soc/codecs/cs530x-i2c.c b/sound/soc/codecs/cs530x-i2c.c
index 22b1a4d6b61c..d6b7883ba7b9 100644
--- a/sound/soc/codecs/cs530x-i2c.c
+++ b/sound/soc/codecs/cs530x-i2c.c
@@ -2,8 +2,8 @@
 //
 // CS530x CODEC driver
 //
-// Copyright (C) 2024 Cirrus Logic, Inc. and
-//                    Cirrus Logic International Semiconductor Ltd.
+// Copyright (C) 2024-2025 Cirrus Logic, Inc. and
+//                         Cirrus Logic International Semiconductor Ltd.
 
 #include <linux/device.h>
 #include <linux/module.h>
@@ -48,7 +48,7 @@ static int cs530x_i2c_probe(struct i2c_client *client)
 	cs530x->regmap = devm_regmap_init_i2c(client, &cs530x_regmap);
 	if (IS_ERR(cs530x->regmap))
 		return dev_err_probe(&client->dev, PTR_ERR(cs530x->regmap),
-			      "Failed to allocate register map\n");
+				     "Failed to allocate register map\n");
 
 	cs530x->devtype = (uintptr_t)i2c_get_match_data(client);
 	cs530x->dev = &client->dev;
diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 535387cd7aa3..336ed5f225ea 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -2,28 +2,25 @@
 //
 // CS530x CODEC driver
 //
-// Copyright (C) 2024 Cirrus Logic, Inc. and
-//                    Cirrus Logic International Semiconductor Ltd.
+// Copyright (C) 2024-2025 Cirrus Logic, Inc. and
+//                         Cirrus Logic International Semiconductor Ltd.
 
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
 
 #include "cs530x.h"
 
-#define CS530X_MAX_ADC_CH	8
-#define CS530X_MIN_ADC_CH	2
-
 static const char *cs530x_supply_names[CS530X_NUM_SUPPLIES] = {
 	"vdd-a",
 	"vdd-io",
@@ -104,7 +101,7 @@ static bool cs530x_writeable_register(struct device *dev, unsigned int reg)
 }
 
 static int cs530x_put_volsw_vu(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
+			       struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
@@ -224,7 +221,7 @@ SOC_SINGLE("ADC8 Invert Switch", CS530X_IN_INV, CS530X_IN8_INV_SHIFT, 1, 0),
 };
 
 static int cs530x_adc_event(struct snd_soc_dapm_widget *w,
-			     struct snd_kcontrol *kcontrol, int event)
+			    struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct cs530x_priv *cs530x = snd_soc_component_get_drvdata(component);
@@ -236,9 +233,9 @@ static int cs530x_adc_event(struct snd_soc_dapm_widget *w,
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
@@ -249,9 +246,9 @@ static int cs530x_adc_event(struct snd_soc_dapm_widget *w,
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
@@ -263,16 +260,12 @@ static int cs530x_adc_event(struct snd_soc_dapm_widget *w,
 
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
 
@@ -450,7 +443,7 @@ static int cs530x_set_bclk(struct snd_soc_component *component, const int freq)
 }
 
 static int cs530x_set_pll_refclk(struct snd_soc_component *component,
-				  const unsigned int freq)
+				 const unsigned int freq)
 {
 	struct cs530x_priv *priv = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap = priv->regmap;
@@ -492,37 +485,35 @@ static int cs530x_hw_params(struct snd_pcm_substream *substream,
 	int ret = 0, fs = params_rate(params), bclk;
 	unsigned int fs_val;
 
-
 	switch (fs) {
 	case 32000:
 		fs_val = CS530X_FS_32K;
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
 		return -EINVAL;
 	}
 
-	cs530x->fs = fs;
 	regmap_update_bits(regmap, CS530X_CLK_CFG_1,
 			   CS530X_SAMPLE_RATE_MASK, fs_val);
 
@@ -540,7 +531,7 @@ static int cs530x_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (!regmap_test_bits(regmap, CS530X_CLK_CFG_0,
-			     CS530X_PLL_REFCLK_SRC_MASK)) {
+			      CS530X_PLL_REFCLK_SRC_MASK)) {
 		ret = cs530x_set_pll_refclk(component, bclk);
 		if (ret)
 			return ret;
@@ -614,7 +605,7 @@ static bool cs530x_check_mclk_freq(struct snd_soc_component *component,
 }
 
 static int cs530x_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
-				 unsigned int rx_mask, int slots, int slot_width)
+			       unsigned int rx_mask, int slots, int slot_width)
 {
 	struct snd_soc_component *component = dai->component;
 	struct cs530x_priv *cs530x = snd_soc_component_get_drvdata(component);
@@ -686,8 +677,8 @@ static const struct snd_soc_dai_driver cs530x_dai = {
 };
 
 static int cs530x_set_pll(struct snd_soc_component *component, int pll_id,
-			   int source, unsigned int freq_in,
-			   unsigned int freq_out)
+			  int source, unsigned int freq_in,
+			  unsigned int freq_out)
 {
 	struct cs530x_priv *cs530x = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap = cs530x->regmap;
@@ -743,7 +734,6 @@ static int cs530x_component_probe(struct snd_soc_component *component)
 					       cs530x_in_sum_4ch_controls,
 					       num_widgets);
 		break;
-
 	case CS5308:
 		cs530x_add_12_adc_widgets(component);
 		cs530x_add_34_adc_widgets(component);
@@ -775,7 +765,7 @@ static int cs530x_component_probe(struct snd_soc_component *component)
 }
 
 static int cs530x_set_sysclk(struct snd_soc_component *component, int clk_id,
-				int source, unsigned int freq, int dir)
+			     int source, unsigned int freq, int dir)
 {
 	struct cs530x_priv *cs530x = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap = cs530x->regmap;
@@ -787,8 +777,6 @@ static int cs530x_set_sysclk(struct snd_soc_component *component, int clk_id,
 				freq);
 			return -EINVAL;
 		}
-
-		cs530x->mclk_rate = freq;
 		break;
 	case CS530X_SYSCLK_SRC_PLL:
 		break;
@@ -895,8 +883,8 @@ int cs530x_probe(struct cs530x_priv *cs530x)
 	int ret, i;
 
 	cs530x->dev_dai = devm_kmemdup(dev, &cs530x_dai,
-					sizeof(*(cs530x->dev_dai)),
-					GFP_KERNEL);
+				       sizeof(*(cs530x->dev_dai)),
+				       GFP_KERNEL);
 	if (!cs530x->dev_dai)
 		return -ENOMEM;
 
@@ -914,10 +902,10 @@ int cs530x_probe(struct cs530x_priv *cs530x)
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
 
@@ -947,7 +935,8 @@ int cs530x_probe(struct cs530x_priv *cs530x)
 	cs530x->dev_dai->capture.channels_max = cs530x->num_adcs;
 
 	ret = devm_snd_soc_register_component(dev,
-			&soc_component_dev_cs530x, cs530x->dev_dai, 1);
+					      &soc_component_dev_cs530x,
+					      cs530x->dev_dai, 1);
 	if (ret) {
 		dev_err_probe(dev, ret, "Can't register cs530x component\n");
 		goto err_reset;
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index f473e33eb835..cdd54bfa259f 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -2,7 +2,7 @@
 /*
  * CS530x CODEC driver internal data
  *
- * Copyright (C) 2023-2024 Cirrus Logic, Inc. and
+ * Copyright (C) 2023-2025 Cirrus Logic, Inc. and
  *                         Cirrus Logic International Semiconductor Ltd.
  */
 
@@ -52,10 +52,6 @@
 
 /* Register Fields */
 
-/* REVID */
-#define CS530X_MTLREVID			GENMASK(3, 0)
-#define CS530X_AREVID			GENMASK(7, 4)
-
 /* SW_RESET */
 #define CS530X_SW_RST_SHIFT		8
 #define CS530X_SW_RST_VAL		(0x5A << CS530X_SW_RST_SHIFT)
@@ -73,14 +69,11 @@
 /* CLK_CFG_1 */
 #define CS530X_SAMPLE_RATE_MASK		GENMASK(2, 0)
 #define CS530X_FS_32K			0
-#define CS530X_FS_48K_44P1K		1
-#define CS530X_FS_96K_88P2K		2
-#define CS530X_FS_192K_176P4K		3
-#define CS530X_FS_384K_356P8K		4
-#define CS530X_FS_768K_705P6K		5
-
-/* CHIP_ENABLE */
-#define CS530X_GLOBAL_EN		BIT(0)
+#define CS530X_FS_44P1K_48K		1
+#define CS530X_FS_88P2K_96K		2
+#define CS530X_FS_176P4K_192K		3
+#define CS530X_FS_356P8K_384K		4
+#define CS530X_FS_705P6K_768K		5
 
 /* ASP_CFG */
 #define CS530X_ASP_BCLK_FREQ_MASK	GENMASK(1, 0)
@@ -95,11 +88,10 @@
 #define CS530X_ASP_FMT_MASK		GENMASK(2, 0)
 #define CS530X_ASP_TDM_SLOT_MASK	GENMASK(5, 3)
 #define CS530X_ASP_TDM_SLOT_SHIFT	3
-#define CS530X_ASP_CH_REVERSE		BIT(9)
 #define CS530X_TDM_EN_MASK		BIT(2)
 #define CS530X_ASP_FMT_I2S		0
 #define CS530X_ASP_FMT_LJ		1
-#define CS530X_ASP_FMT_DSP_A		0x6
+#define CS530X_ASP_FMT_DSP_A		6
 
 /* TDM Slots */
 #define CS530X_0_1_TDM_SLOT_MASK	GENMASK(1, 0)
@@ -163,22 +155,6 @@
 /* IN_VOL_CTL5 */
 #define CS530X_IN_VU			BIT(0)
 
-/* PAD_FN */
-#define CS530X_DOUT2_FN			BIT(0)
-#define CS530X_DOUT3_FN			BIT(1)
-#define CS530X_DOUT4_FN			BIT(2)
-#define CS530X_SPI_CS_FN		BIT(3)
-#define CS530X_CONFIG2_FN		BIT(6)
-#define CS530X_CONFIG3_FN		BIT(7)
-#define CS530X_CONFIG4_FN		BIT(8)
-#define CS530X_CONFIG5_FN		BIT(9)
-
-/* PAD_LVL */
-#define CS530X_CONFIG2_LVL		BIT(6)
-#define CS530X_CONFIG3_LVL		BIT(7)
-#define CS530X_CONFIG4_LVL		BIT(8)
-#define CS530X_CONFIG5_LVL		BIT(9)
-
 /* System Clock Source */
 #define CS530X_SYSCLK_SRC_MCLK		0
 #define CS530X_SYSCLK_SRC_PLL		1
@@ -207,11 +183,8 @@ struct cs530x_priv {
 
 	struct regulator_bulk_data supplies[CS530X_NUM_SUPPLIES];
 
-	unsigned int mclk_rate;
-
 	int tdm_width;
 	int tdm_slots;
-	int fs;
 	int adc_pairs_count;
 
 	struct gpio_desc *reset_gpio;
diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index 61bf72681674..191c1cb80118 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -177,7 +177,7 @@ static const char * const input1_sel_text[] = {
 	"DMIC1 Off ADC1 Off",
 };
 
-static unsigned int const input1_sel_values[] = {
+static const unsigned int input1_sel_values[] = {
 	CS53L30_CH_TYPE,
 	CS53L30_ADCxB_PDN | CS53L30_CH_TYPE,
 	CS53L30_ADCxA_PDN | CS53L30_CH_TYPE,
@@ -197,7 +197,7 @@ static const char * const input2_sel_text[] = {
 	"DMIC2 Off ADC2 Off",
 };
 
-static unsigned int const input2_sel_values[] = {
+static const unsigned int input2_sel_values[] = {
 	0x0,
 	CS53L30_ADCxB_PDN,
 	CS53L30_ADCxA_PDN,
-- 
2.43.0



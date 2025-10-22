Return-Path: <linux-kernel+bounces-865124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4DBBFC43E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5EB6641F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488FD34B686;
	Wed, 22 Oct 2025 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fmH7hCcV";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="K/yHtlYa"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6A034A798;
	Wed, 22 Oct 2025 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140407; cv=fail; b=HgLc7U4Urtr0cTi98ahWVdYXCcCTLji9I/tqLfO3yi7wU9WMfEcdT1VcTK3STfM7zdEw8a0828Azw4gOEXbSSP0mEwLVkYvXVas2idoGyj2dJj5vqpjR3UNEV0HnGZS58QReMVwwmncWLHxbIaPEWI7K2WxIEmOGLZ0ab3GIIPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140407; c=relaxed/simple;
	bh=fLMGjP07uSDa9IDmGfGsYYQNWrDGEpmamY80AR4aVwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DlFWT4IsKxrCSPeL0+cEM2aXCWn+2Cee6EOVXtkSekMnLzSDuPeI46+9VoZv2oSRXFruZ1eT6QRlu46gt0poQ6Rk7an+3UHTVXG020IrPN//Jbb0bAjae0wsGTLH2y4wI0UOJ8ncRkbTl1oOGNo6bClz5KqyyINnzyBt6HXTtYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=fmH7hCcV; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=K/yHtlYa; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59M5OXA91195152;
	Wed, 22 Oct 2025 08:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=oKoBQj6tLeJRiIoS491qEZYxNqgPYIEPZXiMXGwAmCk=; b=
	fmH7hCcVUo0pFMs7J3PmkxKBe6Lj4w15SFWkfRjTtq77xVexTn5pyFVxa+YCYgDj
	Jw+MwJsAPRoNkdQjOWjLqVIiTdpyx0tRLw/1WlJibZ+nb4EeOGrEabD3YvsE6DKc
	AwxDutUFz0SMmE7OqD9QsV18wNKSJgPFQLcDf4+7v4eW7hW1IjYREYB8ZNRXQDFK
	8zL6yLMhiiMqgMSGx5//UtaeUk5L0XYo7EIYjWKe6xcBxzGayFuaQKGHEwRKGOiZ
	wwOUE1zJ+Xz5TNtUui0h5PVRREot5jCHyF7MPjzZ5OdvD7MQ2MHMdU0Eds1cxxzb
	F7e4MrJGuI/ODTYFJ3qiXg==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023086.outbound.protection.outlook.com [40.93.201.86])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49xs380gde-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:39:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9ZYSou6R43Cdsw7uOFWqKcIyv4AJrHMpn7lJX5aTdAtoZIuuapaIqvdpq6GlTpYe3U9UPcZeIedYmoyzGmuTwbdpZ81pTnqOCe+fNK2c7FwANbWRGD4YHsieYByyPGfBbJZz9OZnNI9DKoFD39OJinV69FJB7ND0WdbTpVVTjWgcElelgifBCUn6LAb4DP3yuwQqnMhavau0zJrZZqBmjyDUJvhoYQbj7qwdEig29vx0BhwY0yza+YNpatQJMuLoJ9slsE1SrrKQ4wNvoG9CxxJ7TBQoOe+5Nt+bqO2CODlC7j/We7w1vGubGlVNS8dR7dMZFLsAdUJCyKqGhbpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKoBQj6tLeJRiIoS491qEZYxNqgPYIEPZXiMXGwAmCk=;
 b=V8TBULq0ZvDM7rA1zjCURI2l4CqRzAnpZ0zVdRPEbDeRmLE7tf/vR1nlChfJTucMUw25Vs+gGpfCHmsyRypPvCx8dW3+uQCO0dbo9P5+ENAnJ8J29mrt/9aSzQz35LI2rZqQ+TMLdgTcbxGLUfZSkL9sFU9ixUros1y85nNCUWkRccqAkjK2CtnvL5oFZpcaQiFHdwXf1QxaUH1aKPvzStkMZx1LbvPi/B6ePbDfVlNwomjTK+/M567c5ihk379sd18nK4mFTQ+DAcdgjfeFQ3bsLzyjxBWyei4A4xm/3eaa+U9vLHoTXDNw9tAMSPnZ032EM3QtZ0D+krmaBNkNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKoBQj6tLeJRiIoS491qEZYxNqgPYIEPZXiMXGwAmCk=;
 b=K/yHtlYaV7rsDIXs5jlwpTLyOpO6OPaNJtl5Mf/Un4oC9GS0wUswMB9qcvUWLdsljpmoctvd3Xl9yo1P1N7zsMTomhlJytjLFcCL3U4Egps7JgyjJSA4SdHKjFIdHj7KV6I6g0KZfQ8x8wP+yZs7FO9LQ3Iq3v22krunjse0liY=
Received: from SJ0PR03CA0380.namprd03.prod.outlook.com (2603:10b6:a03:3a1::25)
 by CH9PR19MB9276.namprd19.prod.outlook.com (2603:10b6:610:2dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:39:35 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::f4) by SJ0PR03CA0380.outlook.office365.com
 (2603:10b6:a03:3a1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 13:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Wed, 22 Oct 2025 13:39:34 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 4AEA3406555;
	Wed, 22 Oct 2025 13:39:33 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E395B822541;
	Wed, 22 Oct 2025 13:39:32 +0000 (UTC)
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
Subject: [PATCH v5 04/12] ASoC: cs530x: Correct constant naming
Date: Wed, 22 Oct 2025 14:38:45 +0100
Message-ID: <20251022133914.160905-5-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|CH9PR19MB9276:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 229fad34-e3e5-4a4e-3c45-08de1170703c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zlhaeFR3mq8CfKARoqpeN++mqwxQZfjoXRpgJ9r3WQk2q4qPhuvscWQOfgh6?=
 =?us-ascii?Q?49RhDd7OoMybuXR2zYslFat6V6EsVLhrBq5deiphKOwecay+RtPnl8RzQmRW?=
 =?us-ascii?Q?6uXNkDcy2gFk6E0lXAa6uGWfRD5XqYiXzRBAFH4LbEj4qoMjC/JgSqBxTigH?=
 =?us-ascii?Q?q6cqHuarUTQxvNb4pHo6Qe5zVi36ZxUV5pVRQV2q3rY1muZrNWvdCRbQKb1Z?=
 =?us-ascii?Q?xcMDLwChMVgehwFLqavp6jTR0gTgYPeZE4tPLRW7yeXhP7RHKVe2+/ElGya0?=
 =?us-ascii?Q?GR6t6fKf/DpmPyA8IfDzym5HFmEqSrx/5wuhwDMCEt0XsNs+fxdhxMgg1kHT?=
 =?us-ascii?Q?vUsILWdWgxABLi2Si3ejs1SFPmVJFsp+xs7jfjq/YCf49VwrAclcjSNrS3Oo?=
 =?us-ascii?Q?GEyZvFGLXuACY321Em4WfnepsYK54YWIXWUfhAZFaMP1e8jBpdyTWeZ56E6a?=
 =?us-ascii?Q?/uCRDm34kBMXYeWdAByU7FN41BfL3TocqD1pSLvQKdm6nLs5MAkJDtGwMmBr?=
 =?us-ascii?Q?3+VbBDB1PiivZKjuP+wXN1S8eEEHIYyRbziY5ndohOiCqhXCG+68OfqRFoFt?=
 =?us-ascii?Q?vCAySljuQTLcmo96POAVrYKRil/J/tmPoqn0s1UJc6SLbWWF4gVeJI4T1U1h?=
 =?us-ascii?Q?m/6tOlC9ocqE5xKhpocE6NWP4JfZtOiL3xr8uIO8HqM67fAlSWJ5W77viHHm?=
 =?us-ascii?Q?7BbzAOjOC7ND55l/cOKRSgEY5Iuaby9wlhfTxNxtj5IXLA1Da8oa/CNSTWrj?=
 =?us-ascii?Q?TrKgHgMOs15jQ5IPGDSh34CKTlDcSIx9kjLpiDZcAbRgpx6x6rkAzsCFm/wZ?=
 =?us-ascii?Q?R7EqmBnrJ+/6fZ8aKRCkKmmm1G/bS82FVGzlOO4MoMcSim6jP8YzLZ212Qk+?=
 =?us-ascii?Q?3gGrE+GXghoMxsT/zvBNF+jVXhr+utW/ur5wIw78mKZDBGaFbtE/XQVQqu9+?=
 =?us-ascii?Q?JrVE//9Ed0LJsH4gwZ3lyL3hhwKlHs3gfaU+LYn5pxu1bxpiOvDcOhmWb6GU?=
 =?us-ascii?Q?ZGx2xcuM0N0Kc2h7fzQlgmPGXCGvEdJcUuoGWOscSnI6MWg2nWXyZw8drvqp?=
 =?us-ascii?Q?fLoqDsKKSGgmCXyaunp4QeudS92BLyBRBO+/HLiR+68DeAG6ZxJf5R1k1KiI?=
 =?us-ascii?Q?0PLnhCxM2h2HmRPLSOfam9DRAXlA6Flcc0sBCypZqHM1Cta4pjmylU7H0W6K?=
 =?us-ascii?Q?9pzhVRPy6IeoWGai2Llf+Wf2pFqJY1IzmbOOCWm3geSE4U+HRGNqsoupbOWt?=
 =?us-ascii?Q?y4gmS5ElROHbn3PBGstkxDiZ/k/iUpEMu/XmFzw4Fq+KnBsN0J3AQx3ZejVg?=
 =?us-ascii?Q?1zvg5buguEDCLRGOzlc6Z64stmC0rByrhDag9bh/hexESzlNXZpcQSR0zw73?=
 =?us-ascii?Q?GvqrjrrSz3BWRTYxpVZ6UH5gPwEytzkNw44DsGVd5DH5bMW344Yf5cYKt7un?=
 =?us-ascii?Q?diEByetBbrFL81v/gO2brRKR1uzjjDp+jhxq/Cl/77AMYzNR+3ZR+u6sLJZd?=
 =?us-ascii?Q?WqIdBSvakDREDa0uVJDWb503oQt982PGqdfqMv4+v+j7CFjrEtxakbs5FlBY?=
 =?us-ascii?Q?ebb0ijGlMqMbW9kGbIg=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:39:34.6836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 229fad34-e3e5-4a4e-3c45-08de1170703c
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR19MB9276
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDExMiBTYWx0ZWRfX3WA4K5PpHfnY
 6HD6imOE1mN+v7M8ocpIU5inhWS/HqK+3EUfd5DDrUWiQYdDciG4SbZxc4ZHSyYnsG2AzlTyYf7
 mIQPgb3vXx76J3ax4ol7Rd1uRzSgujIGOGTYKZYVPaKynMzVEFKaHIOFYLPny4AKkifQyq/SbL2
 doZa/gEZTC1ess54M7umsB9G5kgBvCYQgNWQc97wd2n+3yuC3wVOkjtlsyhyTpQXmwrtI7gVAou
 TZ5bnmv5OJ+ZfJd1U+GRGtDd//IE7tvR/1ZHnm7zMSw8Fv0dQ43A8aHTnPujpPLVzOkFzl1ktjI
 CXfSDeJN2tAC77AC4YqKmtfTnHaEVvo2TO3nckK8ebbN8Q0LfHsupaBgkdDSsTVgUcg2AUZztJo
 ob2IBIPYq+Ngd95SElYHCFGclGuABA==
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=68f8de9b cx=c_pps
 a=abZUFfWgJRaQ0xfFFz1/lg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=zWlGrJBK1FuhkNR3vBAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: QjSWFTgQG07m6uOtna3nloo0Xqsd9WLL
X-Proofpoint-ORIG-GUID: QjSWFTgQG07m6uOtna3nloo0Xqsd9WLL
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c | 10 +++++-----
 sound/soc/codecs/cs530x.h | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 3de748fa5255..42b9e087f28d 100644
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
index 5b47c1ae2a09..f7640161c77f 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -73,11 +73,11 @@
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
 
 /* CHIP_ENABLE */
 #define CS530X_GLOBAL_EN		BIT(0)
-- 
2.43.0



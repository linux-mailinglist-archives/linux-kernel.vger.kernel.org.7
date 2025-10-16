Return-Path: <linux-kernel+bounces-856667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE6CBE4C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3411886DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D7A34AB0C;
	Thu, 16 Oct 2025 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="icgAhXe8";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="en2JJbfw"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C68341AD5;
	Thu, 16 Oct 2025 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633941; cv=fail; b=OxcwMngiWErSRkxTjPISmPzQI6+MWp/5PIokywNiOYXlXtbkyKShRbh3HUCS4uEXl8m4rdNy9fuXHvXoEWwnmh26/bfgT4BllNlGDpvMjKVcBH2bZpn6Slno/hX7jHW/lVALwQsTNADKKlG45lBKKnhyB5Ao7egiloHZ2K3nz14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633941; c=relaxed/simple;
	bh=EGvR+BiQkn1WhjPN54f7oc+ordmzsUUiXl3IPccQ43Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8iGS6bp7f1v1GDI5CxV6VOE65IDeT7CpcK5LcxF5dblIKjoOYWEnsWm1eHdnVH2gpiLoZzj/fcxb7cHIyt3CTU7ncdfvlG95FL2J/JqYV+MWs84rx+sVixCo35AvW7TvQH4ZWmTunbYVmt3Hm8aRkhbTw66Qj4TXroyyrqpnHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=icgAhXe8; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=en2JJbfw; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59G8fDAS2477160;
	Thu, 16 Oct 2025 11:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=o96B4YQDp5yWxqLUNuwVwxWkfNI1kaZXYyGO4U9jV3g=; b=
	icgAhXe8xaQpKksJdKVqjlBn8ZLh9tKD2OmVnhOPqSh65isdR2esZW/Sv74VPP0M
	6duQaDkNZVrWpY0kI2gaQ47ezwD0gB1CEii1HzgHg+JqHHmzIZLagRMPrYoQhjpf
	lEbJS0vxbrW4sofH/eDiMvvF0yGIuSHHYXWsPs6TvDUKhUF9NV8AidRFC2ubcjRC
	0A0/HHE8q5Yocb/FuKF2SDJ12h/IfkyFEPvyDkQuUrF4GdHrtGtF67ZsyOgXX8HD
	fTMIrIKWeoNCp1TaAsR7qFYK54L1JKtTAFmrfE1JEKE+hsFnoqGTit76XJpcPEwq
	1Hude+zScYm/t4IGECc6wA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020140.outbound.protection.outlook.com [52.101.46.140])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhj9gu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:58:50 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qY/844M00ucknhMDWwUTBMr5gg9Yt7bWDlIvYZSq9PsGbZmjIE8qXXXYUCmhTyuvuJzvCOCrqHeUxdH6HLXB6B9EkRiHp5FOPa5TylGF047I6JmDSyw/027elfKzej4M6i2AWLn+bFL4mkpJwu765kUdsx8tZ3zzqKUoSOOGD/LvmIYgMT9H81CstDnGI0vkRdT/EK8929hrGETT6hLBpQnNLVwntXnlyrriVdLRyovs5Z7k6ekFeLgRcTUyjL/DZcHwgmmCn/3glDObBWmAL/dbObLKY2ZatY9Eh+f/VywAxGvSofgGOOBzOc6r4ptSOIGbiKIlULUKkIgEnlsXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o96B4YQDp5yWxqLUNuwVwxWkfNI1kaZXYyGO4U9jV3g=;
 b=afARlUmuJQDZktntfFQ+85l1dl42hqujq9VPKTqaVqqX7Sg4zTdbGkgwNq6iWvUV6VCDAbwuUI7erYZCr2BBGHF2UfjczaVi3enc8GCXfdBYCRBzEAc+38jIwRiYqRbdp70EkdXreK6MPTI2VgYHTysSrqMYwc3/mtnfRTbOzE3SPuKYrISRIdpJQ8w9tuZZE0dgsun7n9wnDBIJxSCmUs9puowoUup+HbFOyy+5Xs9sf53hukZYg9yTz+gF3bUJVOYwMZG6Ec2RN2hIGfvCZhabaVs8Omzy2o83tByIpHMYcYVA0698d+pB72adbcf5fouWp2d11Bch2xIs8VYs7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o96B4YQDp5yWxqLUNuwVwxWkfNI1kaZXYyGO4U9jV3g=;
 b=en2JJbfw1S/SD6KPe+C+q3iDDzk/2hd4jQFyLnPYBm/SDoIlDbKEQ9kd4txd+kvDSnOwuZzXHY0p1KTcZQJdHHyGw9Huw8h3YFzJi3hgf8HCJZDXD46O3BnlGdYPDaI6kObbCBfFbMYX1XYJ6uODMv8kSFgBuAQfcq8jvM+6e5c=
Received: from BY5PR20CA0022.namprd20.prod.outlook.com (2603:10b6:a03:1f4::35)
 by DS0PR19MB7500.namprd19.prod.outlook.com (2603:10b6:8:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 16:58:48 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::16) by BY5PR20CA0022.outlook.office365.com
 (2603:10b6:a03:1f4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 16:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:58:47 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 178C640654B;
	Thu, 16 Oct 2025 16:58:45 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id B1C5A822540;
	Thu, 16 Oct 2025 16:58:44 +0000 (UTC)
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
        Simon Trimmer <simont@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v3 01/11] ASoC: cs530x: Correct log message with expected variable
Date: Thu, 16 Oct 2025 17:58:12 +0100
Message-ID: <20251016165835.143832-2-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|DS0PR19MB7500:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f21fb8c3-3fd2-42c9-fe24-08de0cd545ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TCUiDckplZw5bBml7/iB2Dc1D4bPyvaN9bHBObekl5+TVVNwiyBO92NsuUYp?=
 =?us-ascii?Q?dOjE5vjcQn+KnxnJy20CyAWXJ//a8raWgKbui49FkJWYysAbmof9gquX9d1T?=
 =?us-ascii?Q?H2hatKJy9NNUAWXwlF56mnr2sE3SoLl55yW03RmkKVPfkaifEp0qy9vqrQn0?=
 =?us-ascii?Q?IvPpAT7XIMAwYhLCTAuwJhY2bdsmKuJHa+yiyg2do9O21UBNpC8LombYdmt0?=
 =?us-ascii?Q?JypMH3FRK5AHW2bkF0DWYZSgtVfwoLxu1utp15aJa/nEFeVGkSOF4yhOSZ3e?=
 =?us-ascii?Q?qbM2IiEyAWKzQTWfnE0mgiXVmLOyk2MTvuJyeG6zQzegDiDWWDz2eD0Z0MRr?=
 =?us-ascii?Q?XqlCV5owNi3b1auOmXwhFCJ0vokAjhnh3oUKT6Y+gabxH1WaxCaDQ8OSALtG?=
 =?us-ascii?Q?H9M4fd0QZohCbkfHSEVJAdnmiaSZVv1TeU6bTcU6MrSzLcyeGicGWEwT2t2z?=
 =?us-ascii?Q?DlF5tQYkqOhrblV/C625GrOLxExI7KQZ67kSHyPIB1MFWCtm9nydG1r9xI9f?=
 =?us-ascii?Q?QpWyGt2Gig4uNwTB7YJHNOGIDC4GwB0GGyl6eL8xfjhirKGQrjS0xsxHDoul?=
 =?us-ascii?Q?g8rfMP0HUrqx+YaGI0pa2pmKGI/jY2RdeVMIhBmGWI1/U+Op/wqPQ851VtS3?=
 =?us-ascii?Q?Idc9MA2bRaWpP67JyiSCh23f6NLnvKNTEFzxi8jyrPAGYSNs2MeVmcyMT9ws?=
 =?us-ascii?Q?OSCgP934A8NkmnPgVYLPExqMUFuPHc3j7C4tqFdMhOJIeByzvOoIvTFDO8dF?=
 =?us-ascii?Q?32mKt+IcO3tBv/apxwgpISAbYvGTu89/g5JVoLQ7HiLUi8ZzpPZAKTP1bzSk?=
 =?us-ascii?Q?XinAbccUUkptCgZC1b39ROfLIhXN5JaUrxAexFAZEIqDVAvk3+jYST1TmTA5?=
 =?us-ascii?Q?T4LsQdhQD13rLEj5tBDPjg6oUAWz3JcR2yeWdbt4yYsH2TBVcCa7jTZN7cbx?=
 =?us-ascii?Q?d9lNgxRDMyNEzgXRozgq/oHC9UH3lRSlJiW0W0VlcssRuqADK5H8gBZYokZl?=
 =?us-ascii?Q?wY8ooZBHLHN3KXvW5O0i+eaNrEmI1WWONiNpAnoaDk56LEcYckz90Hr6Q/hi?=
 =?us-ascii?Q?eUn5sulnE89DC8ySgcKtfawuK3h6hjXZb4XfndGmtGF6ArE64vXtymTjCHg1?=
 =?us-ascii?Q?QMudXU5cIxCRcPrRtv+2JKjAP2fmiLo182944wu2CcEORu19QqWkNXEdoulq?=
 =?us-ascii?Q?zdxqwqd91yj0R7oqqrvDaNJm30gh6c26A6OKLiv9LAyJoXdui2JBaFKsjoXE?=
 =?us-ascii?Q?hCfW5CMTIcgWdgc4BaC0QOJVQFgQBL5b0tKoVvVBcF9SPmmRDsRBkHjfK8bs?=
 =?us-ascii?Q?OZcDJ2Td3L4VoK8dZpLsHgctknHdY8pMxbGaCs4IOvNmimuHUoJFtwXV28fD?=
 =?us-ascii?Q?2NNxzfzb2dLXihRVsgU4JWlzUtpY+rRiMUNS2Njmr6+aTVrQALuarQqH4wrl?=
 =?us-ascii?Q?8zzCKTPIXbNXBiNzO7NtNcsej//Z/3YaNTH7/Fmh48S+GUeE5wO5fiTkBz7r?=
 =?us-ascii?Q?O4eyuoy0wLaJ7edUDO7kYJB0BRZw0n8jQm5OqfsXF3xXdjqZlHDIHF2y6avM?=
 =?us-ascii?Q?Ig9GyZrzZBx17xBL3qU=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:58:47.0563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f21fb8c3-3fd2-42c9-fe24-08de0cd545ec
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7500
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMyBTYWx0ZWRfXzZAAEyn1uEfO
 CGoUxAQN0iEOC5EJvjC/7Nq2i05ImK+np/H25aokF03ldfV3XQpwtD8ma7jQNvthVmBfG+pFEqN
 wjiwTT9tUHHT1jxuKk+S3YY+3Z87+RLUh5T44cMuBrU/KjuA1zRIEsQrqckEcYtS4oN8waqdXj2
 Bafizt9C1VcJ31+bRit5sDL8BaYd/q393gf7/NfsD5ewnaHVVPlVRbmpmhfgFELbzekEeGzoDPv
 0Ksr9uWGTVBQ4RxDyQA0YVgcxMcN9FpVC20fMlCmyFwvoFjslFxKtYH1ugypcTMIxDKckRqC9/Z
 4I/nsn5Vts/FkQcXrvFnUtJzLpQpSWa3WegutOCl5vs+ILRYFw4Yp5anqYhCggQFngrA9cqRcTN
 +0bEaGxLbNIgWI5OwQl5UbzKGrHJ3Q==
X-Proofpoint-ORIG-GUID: 2C-o1zeyaFznwLe41FveSml91gYkD_dB
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f1244a cx=c_pps
 a=5/KMVI1Vldy4iaYcMZAHcw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=Q_cYDw76ORux1IEp9KIA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 2C-o1zeyaFznwLe41FveSml91gYkD_dB
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

The function used one parameter for the switch statement, but logged a
different parameter when it defaulted.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index b9eff240b929..535387cd7aa3 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -793,7 +793,7 @@ static int cs530x_set_sysclk(struct snd_soc_component *component, int clk_id,
 	case CS530X_SYSCLK_SRC_PLL:
 		break;
 	default:
-		dev_err(component->dev, "Invalid clock id %d\n", clk_id);
+		dev_err(component->dev, "Invalid sysclk source: %d\n", source);
 		return -EINVAL;
 	}
 
-- 
2.43.0



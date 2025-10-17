Return-Path: <linux-kernel+bounces-858412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5994BBEAAEC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95D565C0C12
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4F62E090E;
	Fri, 17 Oct 2025 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="g+g+1mWv";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Lsja0FvZ"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6D52D9ECF;
	Fri, 17 Oct 2025 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717789; cv=fail; b=QOnmG7O1xC2oMgmiGrRfmcxt51RX3NXGJb4+xryetFLzZ6sRXi0QOULs2GSa4aq1gyWhkZMa6fo9nkuGwoFF0vF6+HWnqJKdhXcf5aHfZGBToOy6/n946rJqr4YPPKSptYlkRFW7hx7DfLApIawK2YEvavUZoiCzisd7uoP5NDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717789; c=relaxed/simple;
	bh=ThIMJSqoRy+tRj1ekVlf8paXPbiQdKvteSTBc7DnWjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kkkZw7GOok/TtpJwFkE/tJbeFzupwsr3aTopXnhAk8Z1H+isqjXIQBAkZDOAQAPxKqRdSgxw1K5tvppiQXx4xoFRzrdZ0uNMp5yxhc+dfNZunI2vorv2o56sbuFcAkkAuqcs1m8JFkHeGwQ0rQSoqSglczhHJcY829QfdFG/og0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=g+g+1mWv; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Lsja0FvZ; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59H7kLPh4017610;
	Fri, 17 Oct 2025 11:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=mQrBsJ/ApE/uMXZNJiEakG/6Ykphmnad4m4LnRuhi0Y=; b=
	g+g+1mWvyIB/XCe4jD8RFgjEdWK7WgdlxI65doOmPug6AkAgTlX7M24WtKKNUQPw
	nbzWAQULnczdofs81DSRFmTP3FLUW4tnzSPUFZlBs7FAcd0Rd+quT4qsMGzUyhiQ
	U36rqPZ2xOQpB/zsJ/a28NTAKnMMRNsJZsxa2C5fyuPfIt/xBWyqdLLH5kp/B4w4
	uMMj4KYePd44/3gQ/j9DSfnNgeURhTIohLf+3tAKlcW3Wp1HZz+KwX2Eyd+U3oXy
	1VfmK5+UFp0MlfIhy/I9uGJVsg/M9LxEfS6dgTs/x8UUyNzuRNm7r0kkJSdxAOwS
	m6leSeDFlQpq/bcvErLK6A==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022120.outbound.protection.outlook.com [52.101.48.120])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mnhsbu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 11:16:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFCDKAiBeVOgAGGV/5HE9frup+F45PoA6fv2X0MFj/79y0+8f1S0r71dfPGUtgyId5l++zEYZ0N+7mUor5OYilcQfiHAyCGzDvzmdtPKR1UXprsEX/YUKk3Bdae6yyEFUeoMfSk7scLdFtT+bz3DQ8v7WAy2w62CD47yeeYZeJ/z7MXdsw66sn8QBYKQ4b1Fu0JHbiVQsCoAuHqyU1Y1IC/64UjhMNl52pOUJhCMCZnONunn9MVCNAuQPjy+H65dyh/d7DQ2ea2LzjukkLNhiy7GSVwuwtbk67ONHbOrOhwE1BjnJzu7BBMkS2Yd8LEYwX1f1bhW122jbR0kLArVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQrBsJ/ApE/uMXZNJiEakG/6Ykphmnad4m4LnRuhi0Y=;
 b=sfHEqTQh1AWLVcStzcolGS+xZt8dU7qiGIvmxtFxAD3YBgwp/4ddhpjNllN2j68KdAf1ImH4yYaaSUud8Zv/nV4oaK/cb+mv0/VxoOSityUvPlwwcLA2lRApQfeLyFJywWp7RMhqzAbhEFQR8aIyFP2Kx0UMKa9/1tZDt01TtsHhox0BIuYchAVNgq9e38xOU5eE89xhVtMsiNGXiwRKLxa+7/gVMDveS5SN8EpNnzfLt9eSUJbPEB7qTLfrPrfrTp/kIGecTk0DcA6V6rbq9+QuPlZ+SNQ5ZlPzFXnR6+N1SP3iaZNS3upw2Oseh8vXowPyS2cHM8tQwx8WgS0ZCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQrBsJ/ApE/uMXZNJiEakG/6Ykphmnad4m4LnRuhi0Y=;
 b=Lsja0FvZBL9zdRXWa+bRqwC64KqiM+NAMQeVew3wp2+Z+sv9dCZuadhEBryFi1k1pF7fOtD6AIOiSq/icyqUibDz2/Z+RB7fy8uIAq+V+QLf10epplkJLSwk8naZQd4H3GD5SyRaC20DDDweRhudytsDpXOOKaYo6jjpK38i7pI=
Received: from MW4PR04CA0245.namprd04.prod.outlook.com (2603:10b6:303:88::10)
 by DS7PR19MB4520.namprd19.prod.outlook.com (2603:10b6:5:2c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Fri, 17 Oct
 2025 16:16:00 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::ae) by MW4PR04CA0245.outlook.office365.com
 (2603:10b6:303:88::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 16:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 16:15:59 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 8F290406555;
	Fri, 17 Oct 2025 16:15:57 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 309D4820249;
	Fri, 17 Oct 2025 16:15:57 +0000 (UTC)
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
Subject: [PATCH v4 10/11] ASoC: cs530x: Rename i2c related structures
Date: Fri, 17 Oct 2025 17:15:37 +0100
Message-ID: <20251017161543.214235-11-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|DS7PR19MB4520:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aee25d14-4596-49ac-8969-08de0d9875af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F0EYn6AKYAAeAFJWu79Fx4wpOPpuszw4n6Zsg2vK2O4EridVow9WLPc4KWMz?=
 =?us-ascii?Q?jWOnkh+tAYP+5P2tvo5RTCKJ7KUZt+sQciWGcVS2Ad6iU5Zjp8h0Wi5deA88?=
 =?us-ascii?Q?39TDUALlm1U43mF/J7H4+55w7hovrrIJC95Vrz3xNWfn9pRC+chnWkgMKEvp?=
 =?us-ascii?Q?ORUSxaPo6iXCXt6VoUbjkzHlaHP6kv25H9L1GD6CcXlHuOfx2YEZbJbReVxb?=
 =?us-ascii?Q?o2jTq3H4+T3bDkLBm26zFlP529RtEgFxGTIH4XHYiPDVyZmVyV4l7URC8+4l?=
 =?us-ascii?Q?rr5IxI4jQYH8dIiQvJgSPlI6ROwJsT4gTZ3fAmz21o31IXBpRKcNt26xMv2k?=
 =?us-ascii?Q?66tTRiL9mGI9erQuMcz8JQBP/8c1sRf4afDMOAgTOqNtbfjiI7tW9fDocHF5?=
 =?us-ascii?Q?yIE0TO2uafaamWivfp4cmHIKyYKwLnwotQd2+/yX5I7lYA/p+mrlbzE5LfoC?=
 =?us-ascii?Q?1ZoJ2GALp9R3h8gYJO6MgugNlTmpx2l3gFU7C/s03g1kuNr8MnU/pJwC8v/r?=
 =?us-ascii?Q?lOw19mrEgIgtKnw4UE5c5BsIsFUDv1EM76QRaa9QWrvfbfIFy3upvUskoVLw?=
 =?us-ascii?Q?xzpWoHBL+7hGni0ZEXAyjuUs1oW0fyRtJwm1xkst9axIod1btmucWFNT+5GU?=
 =?us-ascii?Q?tVeE/TAJqQua+F3xiEFLkpUkX3P8JR8O1TYhde7wP9Jpkh6pDxiJjO5qcAcB?=
 =?us-ascii?Q?d87oJY+SGUaneE3zupi8JNpnS7YU6OeMmU8+5RqnPTwq/BdM5QJAfDrcoSNd?=
 =?us-ascii?Q?8YtqPBmOi/f9OXs8woYFhsqdKhEqafR0MsedwJ/Bq2BkE3hZSsmsMgplUHfs?=
 =?us-ascii?Q?Xx/EOQp0mb3N/b01udSGlmjJj+jBTzZ0dLmJw1CERzPDJIsex9j2E2F4G6uS?=
 =?us-ascii?Q?FNkPRPABAJyNwYTBhx2dAzEtNoHuTSppknBOPZyEOcojq3gElZ6k3ZN1NK+K?=
 =?us-ascii?Q?UPnKPHM0pvDZvM/MYfkrsvxvuKzXBWKkQQoDZvOAh5CZ8xmE1zBGH80gW22q?=
 =?us-ascii?Q?kR6yPmUx+a6f9qHiWaRvWhFrzlOBtb7tIgX815QC07+3FFYfHczWDM8+v7HP?=
 =?us-ascii?Q?Rbczjtxonh4b3Etl7Cycgp4/Uy0/ynwmiBzeyHPucLHWLj8djEZAK6Hr1WRl?=
 =?us-ascii?Q?OxZYd+l2iqLCpqwDzHhDhIcnVZyb3mP912ZkBY52evGFwc3JQ7fs01k10o8i?=
 =?us-ascii?Q?VL38NMWXbxRe3hGw9po3wzosaakoR5KYTBv+H9Q6gNRSsuzMXeTWbcUU0kmK?=
 =?us-ascii?Q?oSDCnjdgO92YC0Vd2I4Ji8ROO6NI5fLtieYganDRKgKz/ZP54VNVA5R5roup?=
 =?us-ascii?Q?kjOM1HQVxsNN9JIF2XqoDZObCVwdD+wuc7f4/sFJGu6MbdfK2UDtqzEor5aD?=
 =?us-ascii?Q?dnHLIok3RBFkJCLyEXhThK6qkgXc7+VpWx4dDLsBLCaH3cbDiuA5Tvi/0h53?=
 =?us-ascii?Q?cbykdGMv8NKSHXYJA04p8+0mr9aTbBDr6afVux4PtP8ms82LbmsZ3rLQU0V9?=
 =?us-ascii?Q?Wd4A/oIDXdAXuklFqk1q9b5/Ukrd2qcRkRnSybYgmVrzCU1sCjvCTowKAWyD?=
 =?us-ascii?Q?/FHkNe64rD5+nbxCwrQ=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:15:59.0538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aee25d14-4596-49ac-8969-08de0d9875af
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4520
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f26bc7 cx=c_pps
 a=MceEdFpa07MrPAxPau0EtA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=edWlu9fVkWd-uG4zv8wA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: bDvZirRRFdvRvzaomOhC8nBrXUJzjo6P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDEyMCBTYWx0ZWRfX7JfxgnbC7ITL
 ROLA/UAS1MIGNU2WfoEFXrbddvu2IiX1fQfBhFdxezf/xpvS0EccLf7qOgTupAYem7xoCrKo4I7
 GEYqX7W8aGoG9umIEUZJSORnZluNFKtTbavSVsvhkX1ZsdnYG4z7WxUaLF1ra1NzyqltlrzROOL
 cOGFdaU5ZlxLgHwBZ8+aduUjofJ1EyKuQT7x6dA+xJL2XPKWweEgKNXRRnhmiMFBMkWGCstWTh7
 9QujLc1ma3akq7yqLU0R1ZGrd/uyXfi/Wfx2bDBQUoyE9Eb+VM0pu6VNbhX1+4ryS9kHR0wKkKF
 AEjrAiWNgSc71YoMZkYpw1bXRD08Ylzf7xtaCeJx68gcJAcsuDrdG7BcI7S0JU/rdHv+I/BvoxS
 eos06yBjcBDAMGMX5qvzhnXuFR3xsQ==
X-Proofpoint-GUID: bDvZirRRFdvRvzaomOhC8nBrXUJzjo6P
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

In preparation for SPI support these structures should be renamed to
reflect that they are for i2c.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x-i2c.c | 2 +-
 sound/soc/codecs/cs530x.c     | 4 ++--
 sound/soc/codecs/cs530x.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs530x-i2c.c b/sound/soc/codecs/cs530x-i2c.c
index ab410826f777..52b02ceaa7e3 100644
--- a/sound/soc/codecs/cs530x-i2c.c
+++ b/sound/soc/codecs/cs530x-i2c.c
@@ -61,7 +61,7 @@ static int cs530x_i2c_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, cs530x);
 
-	cs530x->regmap = devm_regmap_init_i2c(client, &cs530x_regmap);
+	cs530x->regmap = devm_regmap_init_i2c(client, &cs530x_regmap_i2c);
 	if (IS_ERR(cs530x->regmap))
 		return dev_err_probe(&client->dev, PTR_ERR(cs530x->regmap),
 				     "Failed to allocate register map\n");
diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index f0c3ed931fa8..027d936c0912 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -1128,7 +1128,7 @@ static const struct snd_soc_component_driver soc_component_dev_cs530x = {
 	.endianness		= 1,
 };
 
-const struct regmap_config cs530x_regmap = {
+const struct regmap_config cs530x_regmap_i2c = {
 	.reg_bits = 16,
 	.val_bits = 16,
 
@@ -1140,7 +1140,7 @@ const struct regmap_config cs530x_regmap = {
 	.reg_defaults = cs530x_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(cs530x_reg_defaults),
 };
-EXPORT_SYMBOL_NS_GPL(cs530x_regmap, "SND_SOC_CS530X");
+EXPORT_SYMBOL_NS_GPL(cs530x_regmap_i2c, "SND_SOC_CS530X");
 
 static int cs530x_check_device_id(struct cs530x_priv *cs530x)
 {
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index c48a29cad702..8675a86d7d95 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -220,7 +220,7 @@ struct cs530x_priv {
 	struct gpio_desc *reset_gpio;
 };
 
-extern const struct regmap_config cs530x_regmap;
+extern const struct regmap_config cs530x_regmap_i2c;
 int cs530x_probe(struct cs530x_priv *cs530x);
 
 #endif
-- 
2.43.0



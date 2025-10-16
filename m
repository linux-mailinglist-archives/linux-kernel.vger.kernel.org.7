Return-Path: <linux-kernel+bounces-856673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDC1BE4C67
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 342464FD830
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D144B3321AE;
	Thu, 16 Oct 2025 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Tvm9XaIw";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="SDBEUawK"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A9B34F48E;
	Thu, 16 Oct 2025 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633946; cv=fail; b=XRhpseFggtgrVyV53xOouzPBH7mznx3P4J7Af+8NgeffiA+nJrY/wkQAhisbWjGd1gDKMnqi9fOmeNADEBfK2k5Q1tuCJovTMuiM8mDbPebDb/6FblmdeTm987Ci4x7ZJ/mU9RK7UvlNVyEg9M2u8krlAdwddc1G8KnDfJ0efy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633946; c=relaxed/simple;
	bh=9ka1CNkqu4qof1rW5DIqRZU7SOE78ZPiN/7rOVhtwV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eervv46XHQmdWa1SICMcKU3wPHvtV8jLNsOZkoxCymfBH+1zLeY9xA5IrfS+3K4iR07b70Tf2SVmLvOJOtUqExpZkQdFdXKPb+Rgxpp//Uljhs4flszfcn1RuZOcGCR83NMoYzqpT2Lgjyi58nFX1shWeP6Y55iO4GFOPXoSAwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Tvm9XaIw; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=SDBEUawK; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GDSwAq4017610;
	Thu, 16 Oct 2025 11:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=0/mQ75kraEDh1WVg7siN+QNcMFFvqtt0wx0k0TNBytc=; b=
	Tvm9XaIwdUsPT8C8zD9f+jGXWl8h6+tLoaKNsGn7GpJG+6bAMt8ukDi8vtOoKOb2
	s+Ycx2wyAj1x8D1soeyS+XdOx6OxKB3vAVS3CLQGCMsPRX1q7etJ5aHbfla7rBLQ
	Ji+vsylf6sfgCmftsUPOEaGcDOplex9Ts9OSGHINez/iBC+bRAGt0oqRRLw1HhJb
	wb9bp0ITkpCTqpTn12mJqHbIqa5shieiWcvsw5VkBULjXCJ9CwsFD53wkVCV/wo4
	3T4F1AtiXQtTN2MYwpRve6sIw0X6khIucGFXKctgHO92DzI0DIOqYbYGBQy3C9D8
	jZddTX+eqT08+DSMA68tNQ==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020117.outbound.protection.outlook.com [52.101.85.117])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mngb3g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:58:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6UB4veLHpNJ2IQgJIsFqpgzLbcvx8HwC7F3pku8DMNYM5bK5q81CTayEDBg7VI7OVR3G8WNxxvrq44NKjZbaJYH3Fq6bnpW4LmL4N4xXBl7Z47khST7GMANa35t2DOMAThRufYmln/P8Lu/frLroSw1qVtgMt0ARcoa/z7Ql4/pOJZ3PX+lv1nn689NNIBOdXy/VWURnfg3/CcHLSzC2+Zf+x+lE7MJARGyKYyjMWjcOe7hG/G8IWrxJoAseb/LTZflX563CA2va7Y6zr4JO1g9TH717sAmeCGGPUuXG3/JHbCuAY1nvAx9naatW1dYF3ASlbEQSiQpsZ3wSqGPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/mQ75kraEDh1WVg7siN+QNcMFFvqtt0wx0k0TNBytc=;
 b=YxkP3mX7ZqAXlxDwyxCaG/Eg3ebgnQKqqXdlasyhYYRgwv72wPKJs3nIU1dLgnA8cpEoWySRfWyfsYWClptPRHVIFtZ6/c9x08xs85wXDenSANJ2cy7uWOkeQnRbdCG+3JF/Wg/jnZGACguaMrzIDTgyQheMp4kd9U7qkBqlL4tBj4ABNbLHy/xw7rDdInfK9JMWRuHvLnyZpV6jKEvEDGFrn9BeG5TEN8FiXcApXeHkYxfiNvRvvZNqsMFxy0WXE/0GAncnLWK9S07fRqiclngfsh4LAwHTzxl1gQNF3nHrlYGNJY6C5VQJG2XxUGcgDHZYt5Vlez6jHG1CBtyDnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/mQ75kraEDh1WVg7siN+QNcMFFvqtt0wx0k0TNBytc=;
 b=SDBEUawKUUBIUlwpNgocUWlr8Lz74+jXbj43qAqzNxozA+DzUpfU5Mq3PrlOxUwYsImi9DciehDzWHLJYNQubqrNYpGfVBFv9qJ+XLp/fUVbwyhnEyAQZFPkZZgOmSG+/Z2usGdDZ440SCSmWXpSbD4JHiFDDEp6gPG1ETzKzIA=
Received: from SJ0PR13CA0238.namprd13.prod.outlook.com (2603:10b6:a03:2c1::33)
 by LV3PR19MB8701.namprd19.prod.outlook.com (2603:10b6:408:271::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 16:58:49 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::8c) by SJ0PR13CA0238.outlook.office365.com
 (2603:10b6:a03:2c1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.5 via Frontend Transport; Thu,
 16 Oct 2025 16:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:58:47 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id CD2C3406553;
	Thu, 16 Oct 2025 16:58:45 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 76FE1820244;
	Thu, 16 Oct 2025 16:58:45 +0000 (UTC)
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
Subject: [PATCH v3 03/11] ASoC: cs530x: Sort #include directives and tidy up whitespaces
Date: Thu, 16 Oct 2025 17:58:14 +0100
Message-ID: <20251016165835.143832-4-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|LV3PR19MB8701:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b77b3454-9766-45c8-89ee-08de0cd54600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|61400799027|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lacvCEjptYddvuHn3wMyifPrkNU/U/GVsqE18jX0hwwyPP92YsuQbi7TSA8/?=
 =?us-ascii?Q?hBw0ghqi5UcFEkejxbU9BVxVBxq90Or1Ywv5yoe9sVB0HIjT7eeV55VmdL7P?=
 =?us-ascii?Q?Tu4bCMob2XRZVumIXRQ8h0lG2Ip6oTgSPyKRPHkmnljDBJ58sLgC+XJpuPEH?=
 =?us-ascii?Q?5KN24/RCgfuqiMOO8n0wOJmk4bhJjORHRkh44TcrMP3Jya+8lHFgG0+nXO8V?=
 =?us-ascii?Q?lZJ9klDEuQMxfXDcKZg5jMtAKVZZ9KEtiujK3R6ph3XOEsapFwqy2BpQu8aB?=
 =?us-ascii?Q?Fo29kqb9G76Y0wnOE+0u484zU5MtlQh5mLZ8p5FUoaq0spk4IYrVWyXcg0DB?=
 =?us-ascii?Q?TpwtKWvTubvt/WwSRkHq552PFB2PrcU17OEJpf4rs4EClcZUhq1Dn1rIFw24?=
 =?us-ascii?Q?orJEbsmvW4cHAADaGdxRoQQoA+rYjtq5HlHdYRchKihKxafArjSwLWtB8JGo?=
 =?us-ascii?Q?CS9efybblmkcM8ZpPgROm00aUMHlA/E2PLB78NsMvqGZ+stHXtRXNYTCQ9zc?=
 =?us-ascii?Q?o50qVBIWOC5OSmsD5pKmhT0QKUu3XQqZ3X4pNxo8edn+ZraSK10qL8+dXbtI?=
 =?us-ascii?Q?PiNTGeO6RXBAFzu5IXdw9eSJ06Cr+TZ6H4GJV1o2nIVDqAG/m7I1ZiEcuYbB?=
 =?us-ascii?Q?ollrnJ9WO2jKqYRhsHI3ZNC8EemyiOj26Y2LpzZ5CYVCHB/gWVrpV35V4pJD?=
 =?us-ascii?Q?Z85UJkkAJ14EFIyDWUtVwVg6DBBBiAJJmOII1Qq9Fhg05JkRVlCZBMjXUezm?=
 =?us-ascii?Q?VUBNX719vuvt81HjGg8ltNI4nmy+YvL0JJdNqBp6nQMnlu5JLaiEVE4ntIFb?=
 =?us-ascii?Q?hDg2gwuGCeu0T3D1DZR/Ctt0aIyYOGMX+Ew9WnPtjBZ5fztsPXb/nNk2iKbX?=
 =?us-ascii?Q?sb0zXKiYhheC22SBD52EU7AiCRYN2hZNMzZJpcNtdpzLELux/1ssd8PBZbo4?=
 =?us-ascii?Q?lwFvslZ7kz6PoHLRvWVghqR4G09YRkgWcrvLcDpRF0u/0U1qxJgLJwgiMd6Q?=
 =?us-ascii?Q?GrxjvzrIpzJ7YBRgditpZXPg9RWaX9qjC66u3I9rqH2y+nHXOT91EE8CY7bP?=
 =?us-ascii?Q?a2J98cbeipS3BY+ZmM3f+ilItzaZPy/LNf7KBPtcNhm1u102TD4G/3+5K0iT?=
 =?us-ascii?Q?xCGvhoi2Sglo3Jx2AMigdwAD4Diq4a8vAEHm7R4YPCwdq36yj2SRrGuOXic2?=
 =?us-ascii?Q?H6y7Mbe34y46kwA4HDhcrv/g8r2PPjt2dgYQ08/gUJ3WP0ztIhVxDMbhhkFG?=
 =?us-ascii?Q?pJbcoEIh1rAXqKAisosLFY9mFuPh4vK8PQT540fz7hfYJayDECnp3mWcoRnW?=
 =?us-ascii?Q?hnNEIV+U/kkjbu6pVIwRR7St0xs6VwfvfG/pmRX5+vw5B8y/zHyFDzDQYwFj?=
 =?us-ascii?Q?N+Z5lHhShcFeJkckPn9z/X5Ixx0jzJkCERaZpVSfYyYp3rnNhdRblG8/O2eZ?=
 =?us-ascii?Q?o1+Sn3d4SifWc6HnJf7ujxptfXynUS2nZVPXwNvpzCmZ0hj1rmPe3C6Xr1EH?=
 =?us-ascii?Q?MyMFgfs0zzXx+3XnGYVn05fRaNKlcwaE7RYIxDODMdinWNejYu50UD4HaoFB?=
 =?us-ascii?Q?E70KAFZ0oQUdwvfXbuE=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(61400799027)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:58:47.1833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b77b3454-9766-45c8-89ee-08de0cd54600
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8701
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f1244e cx=c_pps
 a=bH+lGM7ukYmG6LzVfPy9ng==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=w1d2syhTAAAA:8 a=wFt9MVH1Lw3u3H5ftKQA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: mdHlOrHczunrkENsED4JPKbPt2EBbTZN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMyBTYWx0ZWRfX8iDMZmL33psx
 T/FCxkJLUNP4lYHg4qlfxyOFrEU6bFC6JJJ+d8Ct61PvfuikFb7s4DhlamAHLUxOl56pNb2CCRH
 xMkHtQZMGoKXF3QBTzXLcv161+UB2YHdsuSiWtRpvLLYrWkznI7sCRMx+P1sMqZ8trZn+lmBZ4G
 EXz2oCVJ5QCmQGWaXS1+s9FiP7QmAypUk+rTyBjWHOu74kGXtah7Y2PdXhqDWaWo3Jc3yb3v0zM
 EtPA+XXizoubMQ9itraRROj6g3pXm8y5uC1Mt3gAKowxKz2dgrIAWlwA8P1DIdk7iJu1rZgkN5D
 694T3Z9yFFSP+b2qghBIGgIANHbWfUZqT5+6zL3I/YMxHZaLky00VV/XB5SB1xjdUoUw66Ug4XO
 ZSbcH42JU7nQqa4ejjgByt2JbM9u5A==
X-Proofpoint-GUID: mdHlOrHczunrkENsED4JPKbPt2EBbTZN
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



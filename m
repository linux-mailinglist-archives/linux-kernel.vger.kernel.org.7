Return-Path: <linux-kernel+bounces-866565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6049EC0018C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154303A5DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC83305E14;
	Thu, 23 Oct 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Pkhc54Nd";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="gh6ER+yO"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696A13009DD;
	Thu, 23 Oct 2025 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210251; cv=fail; b=R5zEeESwAQF00rnu0NH70DmkqTth2FTN4qT1vT+pz+t/P7NoSRx9Nd5I8pyY88xuuUgVVHdzTAPlVGrJUfK1JeVoknoUVX+U0v2s+QkVqOA+AR496gNMLbwZ9Re+xSpo/EvqREWyxrG/rYqxsAKkmsC/dRrP8/BPK8NoSQavPjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210251; c=relaxed/simple;
	bh=XiWMwURe6+92nuC15j9vY7g90WZpzec8nLgGnXTiRRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HsiSyqpP4vzTLWFvAmycOt5qfH569Sr2t0oDgLIayQNs3D0g/pRTdPkFHFlde3ZZ2P5EdvIG1xtprnRQS6QHbRVA1T+8ruR4olcvpm0NvhfwqUzh+WK/ebaUrQf7/MAGG7ZvYGXfU1O8xAQ7ryV4fPs04AbPX5sYGecrVJJZBLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Pkhc54Nd; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=gh6ER+yO; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59MJkocQ3660629;
	Thu, 23 Oct 2025 04:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=xV3RnwZPX2qjFec9DuBIyVot9Qgpb+TgJq/ti9qaVRc=; b=
	Pkhc54NdaajzTnUDiq5YEV8cgnk0xR5YCSZcczXKWmlZa3YgkL91ObekKZ4o/H8a
	Bms30Aic7d+nsfgyg0/D4Qh4IAq2Zx+B+VaPlHpQSNZk+3ppAKYd+XEbxxEUkmXG
	XNJ7z8dgm1Bncd33YtHIvs1jlFI0Lyqy6y52MKtEadddMXTk3s2VpZRLWPKwclyy
	aUbL3Ct4piXbknalIWAzkYYS5N4Ajb00NFp1CxgPn+KmWWQECOICIUQ8PGZ2+25X
	Gp+uK88EsBOX2t9HHL/hoM+Z6KLuW5IONsCD0XZVT/21hbACClsuxbq9A3mRoody
	uIdQPV0i273+xkRB7X4nDA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022078.outbound.protection.outlook.com [52.101.53.78])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49xqmqsx43-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 04:03:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scWPo9Zjt98nxQz/Yf9J2GPn+imp+5XxoR6hZQl/eqVSbdmv2et7tHvYQe+AesFr2hwansUOrqdD3fpOTHmg0ZzH+bBRk6mIuprtQjEf1e1QD2I3UbHV4taESz+Y5qEDG/Rlr1TNb9oFXp6aXDHajmEJ3XSiOgEf/m756iQd1Xt1lZVmPs4MxsfUGQ8aShhP8bsAfoTdm9bQtUW3aotbV9jYwjz+xT92Z0DeEKsytJmEG6hJsIDxjlxJGN2m5IcpS+7gBB/xfFNxOUJMqSlf/FrTfb8EUoCUSZBOJpngN4B5dvytBXrJuhR13IVAXAvdsFyQnQ2ItMJRT63uzctR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xV3RnwZPX2qjFec9DuBIyVot9Qgpb+TgJq/ti9qaVRc=;
 b=rMrwMd2M6TtHi3804SG8ibD87zPiAdCVK7IQQOaqbYvIApJXR0fRLAAX6QYz9FtWrD0dub4d7F8ktgevbU+Amh6C6V7FJR7vEeLF/npTZFi+e6YZdIHKmbbrHpCZ9MsV0Eoucs2ZDwHEVX+pYgyFhU9GTuHNBzcFTJvGJDmGZYRJ0AgGZ+SFi6blXoJmd4mywHzDcat7UgltKNW/9KLCBugnZusXBZ5UQL1uucjmSg5tb7N9cjqFh8FlVKyIZoI739MP8FPg4VU72ibjBqIbn0G7E4rw0EdJX6fGd4Wb0ONY40D5X1DjBBIo499mWKdV8PPjIKCkOZJIAebLnFA94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV3RnwZPX2qjFec9DuBIyVot9Qgpb+TgJq/ti9qaVRc=;
 b=gh6ER+yO/cTApbUbYxwu4iZ4IaVOOOqHvYjd7ZVYxz5rJ7b+qWD/dPHSH8QHVmMf3/f/ZpJHsrN2rDpFpXEaGSZHInE+P4AQPH1q32PYsbUg6GF0tlff031mB9fkfrNAiGQO8kKJKXOLKoJmow5xU3FhGReiBwwCpzvGUqpgWeI=
Received: from DS7PR03CA0063.namprd03.prod.outlook.com (2603:10b6:5:3bb::8) by
 BY5PR19MB3988.namprd19.prod.outlook.com (2603:10b6:a03:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 23 Oct
 2025 09:03:39 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:3bb:cafe::3f) by DS7PR03CA0063.outlook.office365.com
 (2603:10b6:5:3bb::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 09:03:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Thu, 23 Oct 2025 09:03:38 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 8B0E3406552;
	Thu, 23 Oct 2025 09:03:37 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 31777822541;
	Thu, 23 Oct 2025 09:03:37 +0000 (UTC)
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
Subject: [PATCH v6 02/12] ASoC: cs530x: Sort #include directives and tydy up whitespaces
Date: Thu, 23 Oct 2025 10:03:10 +0100
Message-ID: <20251023090327.58275-3-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023090327.58275-1-vitalyr@opensource.cirrus.com>
References: <20251023090327.58275-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|BY5PR19MB3988:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 32de471c-4e8a-41fd-8d96-08de12130e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|61400799027|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sxPg70Wa+3bQpebrsceoYDcd6v+LqMcbt1VbCFG2XSDEy7csSKSgQKcPx3cT?=
 =?us-ascii?Q?UowmytzlmixiUiEpnYOGy8g3W28woa9vpmHgUSpezA3wu9DVolaAzbj+r9OD?=
 =?us-ascii?Q?k/s1bPO3Fl9yKrToSIvOYZCJrAb05jxZpNfjx1xApWzv+aQJdjx6fRVxSBt5?=
 =?us-ascii?Q?21uie7NxWfj+GqM9UUoVnXGyk/TDJtP0mEr1quHorP4rXWLKYGaXCFSmkebb?=
 =?us-ascii?Q?3Xl+pht1pqWO8l7XmDKU35YqkmUrBo3HU6Pap5+cntAXdfwCi66Ckr6NqLQl?=
 =?us-ascii?Q?kH4xEZbHaKH6rei9T9lT594oUCBDGX2HIAQM6FiQ0LHHPWZ3W7+Zk0h/8h87?=
 =?us-ascii?Q?y2OgNMVfouKT1M5NsUzTZCGIOoHG8Li+v7KdyaK5mY9imSFOz4NVmIw6A0re?=
 =?us-ascii?Q?0CIZbcXE+Ckzpw9YLWainzcQ6QDp87x24ZzQaQPoNoUpmfaJvJYMesM/fA8O?=
 =?us-ascii?Q?H/an1LL1VMAPamJu5Um/JO1uODq76UAr82H9vBH1BNyp0ofWahGuy3RFgfkj?=
 =?us-ascii?Q?Cu6qxhysfmeV8yemx4kv29sJjQerRlgfT1XQW8fjgecSL3VEaExtvz/h8U8i?=
 =?us-ascii?Q?pDoprOShaUS63rx1XozubB5wGBDBQNu4Ts/3D7m0+ga1rqmDfFZQDC7R/+L3?=
 =?us-ascii?Q?PMweswawlCzIIvmKoZdYSWZGIExb583PDVlizI3VI/BRKmsI7vVK2VauIz+z?=
 =?us-ascii?Q?3R0rSXLeZZEQqgsVWFBD39CptBxfDTtk2tkqQBzq5Pax6lFEwtxWn02T4vGO?=
 =?us-ascii?Q?2TF0jzLrBNKOCGdtzFmFXK3kh6ZIHivjhIojzYgr2CEDX83qDHY+UjayjRU/?=
 =?us-ascii?Q?YhC0WnnvMw9fCJ11T3sKphH2Gzv9YklXtssljUJN4PpdBf0qQZy4Dq4dkIkU?=
 =?us-ascii?Q?DXGEFyZits5RnOkK3mPFsdpUBJb4VBqPRMC8pJgKRBIOx12Z91BcVNAcKckS?=
 =?us-ascii?Q?UIK6xgu7AzEhGTRkQdby9pNqfGwh5+yJpVYvR4D2t4cEL0hSUedxhsxD5b5L?=
 =?us-ascii?Q?q/2VPjSXhnHBYMeJkpmSUYwRz5yZ9bX1t4gs/wIvsfR/4iJgjavHbJGqRUOa?=
 =?us-ascii?Q?BrgYWK9o36sab6mJC7SeJeGSVOaChhSgmXvxcuGEpaWmOfE/wvGXOpfq/mvT?=
 =?us-ascii?Q?sLHCmY6Hf0beERyk4cvZ+9H+9ehNLWXhHNwSVoqW0arlIkdKYEbfQWFSS/CJ?=
 =?us-ascii?Q?8ojleUEGwlQ1JDe0ok0Wsfm9yF9rCSLqhATFtO119dmizSJ46qofd2kv7us0?=
 =?us-ascii?Q?GJc0/Sl9pObEFZdJniIYcHLMgkyDqyZmWmtydg44+LmTpXiM5WgI4Jo24eFY?=
 =?us-ascii?Q?JVW7WQ4qFKt/GbwFqBr6etse1Th0g+7jvJR8dzEjn+HlyhAb/Qv1rNtl3bvn?=
 =?us-ascii?Q?pPNT57UeSA1L5D2S8R7I69nxJrPIVqZ3mS/g39RsAWsBBr65kOHA9t9mOq4t?=
 =?us-ascii?Q?BlIIrMWnvvg3I1+3bwXcW8zia4XFmirnyMPSsRivIBe81fwW3ZFV/2XzdiMA?=
 =?us-ascii?Q?nMXNNqO73BuiQy7G/XCW8G3fvVSLqroHq5ABgerk3kdNPOB4LhLynUaq0OPC?=
 =?us-ascii?Q?z2g4MBjQh/XZiOVc0Kw=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(61400799027)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:03:38.6379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32de471c-4e8a-41fd-8d96-08de12130e6f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3988
X-Authority-Analysis: v=2.4 cv=G6gR0tk5 c=1 sm=1 tr=0 ts=68f9ef70 cx=c_pps
 a=exbubrTJ8Zn0/ec8zVjoOQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=wFt9MVH1Lw3u3H5ftKQA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: rBBMc1VqHswjbZJc5ZHhdfn-zfp-MrmA
X-Proofpoint-GUID: rBBMc1VqHswjbZJc5ZHhdfn-zfp-MrmA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDA4MCBTYWx0ZWRfX5rt5I+uKhiiB
 YQEyA/NdIbhYBtkvJkW/2HmXfjetrXQe1bRQpZQ2UGgkTBae8yrVYD1AXZBTxGjcAYXSel9znvO
 q54qpO0Io7Wa9sIyil/DRh5jNxLgyOI+h905n6K2nrLrZhWWCFJQAXdbtK8Za6od7zrKuR1sMLk
 Khu0ekGvdXnaKFox680vaJIFDDbD5lUTAwT6RJG1ODJDQ83vBilCYeBeOL6th4YUNerpX3PXBaK
 VMYVyu0I2vaEazx+d8XvGyC7woIgDX6yOD4Q9x4qsm5h8nE2w8EmLuyWtuyL7O/8YoHXgnsyEp/
 Tj/kabjnBFLJ3//h0+c7rHxyz3MU+elpNucvuAyt4XppeQYIrwsGIF+iGplXUIwonCoWR5zfae3
 O0MEFrUugnJREfOkvUNHc4y9oykB8A==
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
index 88084e7d6447..3a59eeba5e55 100644
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
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
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



Return-Path: <linux-kernel+bounces-777921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9137B2DF30
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0FF169B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434DA26E6E3;
	Wed, 20 Aug 2025 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="kL3b25xu";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="j9kWFOPO"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF55327466A;
	Wed, 20 Aug 2025 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699758; cv=fail; b=RYQJ04LrGXscqDnlcmPKBlgMgBESP6kBf6z8WSysRXtQYrRFHAB0iPL81DFINPOKXBWup+1z8bgZiYKoBqd9toTdGqXWS5OEJng/UcmsmwoODEAXZCq2PAiBJEhGPmMMx9oNaOACWCaIgVYluUn4Z56P++6FmMPhRt6ylu87JmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699758; c=relaxed/simple;
	bh=WfH0o9DuaC7TlVWAV7uDtTUSE3wvSSGchXUQZ8vGlVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jvh9E4x6rQq02DibtG1iZ89XFJm6sp6fJArwSzQTrTWQmFjQAsfszF7xfCXCrp3q64rQiKCU7/Ym7kV9umKljkiN3cjIwRTgY8CAkEa1YaU+LGNxUV7cYaRNpgsKIWx1gh3w83JGx4TUfsfRD1UgwVJjVYF0dJwR27tPp5AXS74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=kL3b25xu; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=j9kWFOPO; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57KEFC6j368906;
	Wed, 20 Aug 2025 09:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=Wu52wBSCp2eTRvYO
	lY4jdPF6+8aG1Pm8lgxR8n25SSs=; b=kL3b25xut+W3ISnwNwg59JWwiPhAfTKp
	bqjyUTVyA1CyMbLFkOYhnd7uXr9IPVdbgKEUd+ZO1a/CqvzuHrgcXd3RVo7jswKU
	k2zZmsBaNRZzzor0JWCB0Ve82yqAMehcBXUkMS0QdQi0AalFDuxPYIKpbL66iIV3
	EBEMnmof50EXe3gGz94OVhSk5hcRV3VIBvUK++mF2B8DCzsCezyBY2cAl6ILjWme
	anMLfsorlOpBi9YoOMEf4LoPvSnbh+GGgmppZXL2ArfVNh+r+aNSIRi+A5hKcjSS
	1oBWHLW97foUPGO72yH7FI2Ikmr1aL+gG9uSw+W7Jrn6KFnASmfvTA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2117.outbound.protection.outlook.com [40.107.243.117])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 48myd99bs3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 09:22:33 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYdyv1AzNEr7Jtbx2x9Tr0vappgQk3cpMWkE4CsuCZf48L6ctx0F4+R6fJRmErhhy/eOeD/Z0Z9JnVzpFbeq/44V8l9vMYsc5mp2lMCuANaqehaTiICZlzIU3/o6KIS3IlrrwWwTJo7kqawMJkXLL/v20pqK485DLZOvdZ6kPptQ6LvYh8VdtW/M/8GF6Gbgthge4/o7+SxtkTfR17/q4cb4a1RQXYyc0OAFsIJzhFv9iGDCLeSBkigfRh5nPxUtDSj25CD5tonksB7RtyoAMEQHUXU07loPhCLUPPqF+CI2Z9PxpHDA5IvWmXbN84F0rMh21plh/v0US+jdxHGh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wu52wBSCp2eTRvYOlY4jdPF6+8aG1Pm8lgxR8n25SSs=;
 b=ZLV/2h+jwvtGxUjexW4GV0rZ4w3otamxoXrGHuT5hmqBm5jzSSpVYzyd9BTbdlxLccVIVvt+U56CXnPMCzQuL0ixzoAkpo9QyMS80YNgEbsC9eMhgZMSASw81VLZoHJlX/ZIoTEafUoEPf5Xq1EVYAP4tl8a0lrsKwzYOtMja16rLaONAq/HRGPJa8mTivVEJ0z3fPNcMYgPfPSwduWSf0qVrsKimRXxGuMO6s+MhaSRV85xfopjfYbDFLlt7vRtnE1veh5r+GlhoXMsaSzOgDY4cSKUThDlh/Y14vee20JEspK6a3ZQBDKJbq69nl5m+2Bs/z0eTQmT5HssLfuKuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wu52wBSCp2eTRvYOlY4jdPF6+8aG1Pm8lgxR8n25SSs=;
 b=j9kWFOPOZ5cKy+y7SUhNh2oWvTuumXe1Pvmfep2k3x0v6QuVCl+XLUGetb/+BnTX5i/Hc+GShGc5C+56U0EPrUxIwD/KGvhkbYeHNaw1jRhCYrJyQdrIaV4ehi2ybi2vcqj4YLe7UvDi/WlvUY2sW/6jPv2nnaZbO3dIhdhrdUo=
Received: from CH2PR17CA0011.namprd17.prod.outlook.com (2603:10b6:610:53::21)
 by SJ4PPFB04496E67.namprd19.prod.outlook.com (2603:10b6:a0f:fc02::a44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 20 Aug
 2025 14:22:30 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::d6) by CH2PR17CA0011.outlook.office365.com
 (2603:10b6:610:53::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 14:22:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Wed, 20 Aug 2025 14:22:28 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 9B192406552;
	Wed, 20 Aug 2025 14:22:27 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 6346882024A;
	Wed, 20 Aug 2025 14:22:27 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 0/3] ASoC: cs35l56: Fixes for CS35L63 for production silicon
Date: Wed, 20 Aug 2025 15:21:59 +0100
Message-ID: <20250820142209.127575-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|SJ4PPFB04496E67:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e8bb3dff-de81-4cc3-1244-08dddff4fe83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hpSlkhrekRhgB85mscpiHrjc0lqt+bcOP+c2XbStST0vYC2I4iB+Cj+L2IZw?=
 =?us-ascii?Q?4hCuZpinseXWczBDLNZ3qxG5gsuF9y9xNgSJyANk0GvL21+cR1BFpqsL893U?=
 =?us-ascii?Q?Izmol++i2zb5JXJGdZ5p8QZzs76dUdicRLhrmBRlmPXzu0GJoPZLt2dkZoyZ?=
 =?us-ascii?Q?plTLq5Tz70i3XMxoMv77qn/DWRQUloHY9NzSAJC6Fm3NPMHJXW9BDimCJ+n3?=
 =?us-ascii?Q?Xc2KFnYFZIRj+IYrphFTVv75aZi0l8fMI0o+uh5WYSWoA5A7hNB/g7xxnRHg?=
 =?us-ascii?Q?hsw6CiyjROZWSmjqQqPpYUc2HZVyV3Qaesb3B212AVBhrAbtlJTXg1kHChbw?=
 =?us-ascii?Q?t+med1oD7CT265KXXB6BA655N+y1fdwAt1Lohw17PYNwHoOjWo454Vf3OzoZ?=
 =?us-ascii?Q?JLoZDgOmQck1cDRUA4dk+SJjaBpRVAH8NqAAgpafRHQv+Jmum/oSG61223NS?=
 =?us-ascii?Q?gAF0Ti73fl42RXQT/gKH6ELtzbXiQq6giCToEa0pti1Z1XBNCkPFbeIjW5jM?=
 =?us-ascii?Q?0O4aLaYtZyqjW9H+x0k7atGP6JguBZj/MeZlkPzM9Numm5BGQEPl052eoAvb?=
 =?us-ascii?Q?Crw6RaZLGx5SAcEPe26R28NZE7aH450V+3XcHbJ7JOinA1ityu+TwxBgzNxx?=
 =?us-ascii?Q?8vZz3ACfMx3a5qnMoalqVac5si0/j2CRyEaLQbPRzLlUbfQGtYWV0nwgWfny?=
 =?us-ascii?Q?xHwYffFfqj3HuA5zjZniYdHbJNiJERN1RtWEISydBhOCinfUZqrhnIMnkvMh?=
 =?us-ascii?Q?WvG+ihIOluOJVdYtR5mZBfmw6g3OhDLZI9b1UIZmfSxws4h1Gyyr/TXsQBI+?=
 =?us-ascii?Q?eluf10mnqc+fjTBqP66j0Cu/KfH2uo93ggLRTXjHzoQsWVSN/AFe9xgpoj2f?=
 =?us-ascii?Q?Gt+eIgE5Uih3WVuCApKrJJNfxD1wOEHkWxDKDzWWZpSekfJNZj+OcV59euPm?=
 =?us-ascii?Q?ab6AmIZHLcoUGi+aGaIEG1/efWvr9ToO7GiOi5IZfKshr3zpN3EK/TuGQOJu?=
 =?us-ascii?Q?1OFpRdo44Xr0CYMKboCjAYb4ZYJB2EVW+kWOh7kTphkaqdjokUSX1Y+HgC2K?=
 =?us-ascii?Q?dq1n86fbI+sKcj17JssSiUSFHOgZDZO17iWkd4MhNl+ONTEaeDPZXrUdfaqK?=
 =?us-ascii?Q?rQkIwkL6Nw9H/s8XrJbu5AFZ9fqHJgAnQbsUgpGQSLIsW6UrkKvWqZtsgW79?=
 =?us-ascii?Q?A073AsekxtQ5o9kVp2aaXlsKw7ShKV8zng88QGPBDfjgd6YWnSSnt0U1fvHb?=
 =?us-ascii?Q?gN58urCgKGbxviedoUqtGxZVyxgkKa7PrVlNpN6iP9pLaCsH+i55C7NZ3Fn3?=
 =?us-ascii?Q?QHLcEvOFIZZegLNbWawwEy3dKXDJ2fjnACCd+9FYur7IiIRNlb/9QdFjfd+o?=
 =?us-ascii?Q?poWRM0AEbMLwhLoPMmWRfd18FTtotokBmJvs4/zgF1ZdkcsqOPe5Js9uqhuc?=
 =?us-ascii?Q?4S/X+tVxjjW+QBclJGK0RAg6eBvsa7/lm+cgpcQy2ZVag4486WGGvpHtL2s5?=
 =?us-ascii?Q?EGRCV7sZBsfkZr9QVY7fI1zRZFv0Ky77Gk/T?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 14:22:28.9185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bb3dff-de81-4cc3-1244-08dddff4fe83
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFB04496E67
X-Proofpoint-ORIG-GUID: JfuKv0bPkIFIIV-4JYm1Aa0H4z4aZi0Z
X-Proofpoint-GUID: JfuKv0bPkIFIIV-4JYm1Aa0H4z4aZi0Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEyNyBTYWx0ZWRfX/k1YbbZFT7dM
 fNLUgBIPYqVUJc+qMLd+yCPEcAMGSIes+8nFCTS1/Ivm7xrev61SrTlDg32Pzzqdu+EQsF1Zgfp
 uLkM49iuOVGJXd6DuevgGJj/BBpHItCcA239L2mOWcqSiST44+mvr5T6hKA3OkIlcN19Hsy4e9+
 ezDjytoWCxlNYSfJmGIrqV0QqV6ViMv/3jXLXqHB0Nee/EtPulDnsO2NxnDmzoSIJscwtVNunxS
 MkNWzImwpuX7ZI+PiguKa8utSp+L4jZcln08PLAz0EfAdy8//OZRW6w8/C+ZaftTpsEUO95RSoI
 2/CUmQTK5+JPVVOIi2nAQ5iYtvd0XRI6evtWbwcGQtI8TE1b47IxxGqQc4eO1XvyVIbMYPDoiIy
 ZqmQmW5a8SutsxzQJbOtTEIaTGrMGQ==
X-Authority-Analysis: v=2.4 cv=WIwmnnsR c=1 sm=1 tr=0 ts=68a5da29 cx=c_pps
 a=q7gyNI8J6sqg6mjPg65B8Q==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=2OwXVqhp2XgA:10 a=RWc_ulEos4gA:10
 a=JnAcZK7urWuLpzDoNKcA:9
X-Proofpoint-Spam-Reason: safe

Production silicon for CS36L63 has some small differences compared to
pre-production silicon. This requires small fixes in driver.
Update firmware addresses, tuning algorithm IDs and remove soundwire
clock workaround as no longer necessary.

No product was ever released using pre-production silicon, therefore
there is no need to keep support for it.

Changes since V1:
- Split V1 patch into 3 separate patches
Changes since V2:
- Update Fixes tag with correct SHA

Richard Fitzgerald (1):
  ASoC: cs35l56: Handle new algorithms IDs for CS35L63

Stefan Binding (2):
  ASoC: cs35l56: Update Firmware Addresses for CS35L63 for production
    silicon
  ASoC: cs35l56: Remove SoundWire Clock Divider workaround for CS35L63

 include/sound/cs35l56.h           |  5 ++-
 sound/soc/codecs/cs35l56-sdw.c    | 69 -------------------------------
 sound/soc/codecs/cs35l56-shared.c | 29 +++++++++++--
 sound/soc/codecs/cs35l56.c        |  2 +-
 sound/soc/codecs/cs35l56.h        |  3 --
 5 files changed, 30 insertions(+), 78 deletions(-)

-- 
2.43.0



Return-Path: <linux-kernel+bounces-854179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F45BBDDC62
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09747501F26
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB7C31B110;
	Wed, 15 Oct 2025 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="IYXuHV9R";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="v08q1y+x"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E231A818;
	Wed, 15 Oct 2025 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520435; cv=fail; b=UofV1UGgKS3w4MRvxxeHTE7DuOAMmPU5AD5FMKnSe2E/0Be7p4R5QunJstFRdMzCGLIt0bISMR3FAdw8IEKUBBaHnbgPqexFnmfzgq9rFNHUBwq7YVMo6d3tk6H8fIivVowB01fwGMwN9Iilnb0dJk3qZV1GWTfCodA/oahxN9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520435; c=relaxed/simple;
	bh=UKQlObgJELlQfVVbxlSVZ9PLi0Z2WZ8CldtX00KHHeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAK5vHXBHxitOCuCpmUETI29wov2ESgdL/RA+qjznd3p72mdt51zR5V1RYD4/yXMps0za6o6H4RCL7xDk9flisPAlUqwf7XIDrOse1xCyIIetoa6FxMRJvC0aYLEbMNLHg1BvidYCd861mNOHH6OaUXcey1rOIY3Ru8TAECAjTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=IYXuHV9R; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=v08q1y+x; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59EGKkxv1729701;
	Wed, 15 Oct 2025 04:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=wgbPnTjY0SmgxL98VREocoWkT6gSQhPZLPnCYhup2tQ=; b=
	IYXuHV9RnvhYmqbDHDwx4hUDNobBoq8xQHA9zOd9SGq+15XhNg/2biyJ2KqM2R20
	KQ84TfcusybFWIa3nKjH9YK/mm7+fbLNi5TofPibh+0xVMeCBfWIAU4DdDOWT3MG
	tWoWs8JKjs6mPAVQcm0qadGhe7sbXQg7ksNIIvqFfQWpz3/zVs8DUVYFCUGoVjnf
	Pg7rVw77J1+p1+0b+sK+Q3AcHl6hrw15Dk9o2rLm/NAZvy5O4q3RaLvbG0I6ozjr
	emPU6Bmdn76Q5Aropr7eC9H8J0rCkwL2YNRH+kXsXbqia23YTALCqwd2afQsQpIu
	XiwJnysgNP+Aez1RFuNX8A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022110.outbound.protection.outlook.com [40.93.195.110])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49sdb42fmf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 04:26:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUSKy0Yq4kBRPvv87eSPgONf/cmLmllL1Tt0AUoL18t/7uC0wQDW42K7yK1UA2zwEY6D1xwbG6xQcTTjCPykJUdzowYu1trmOqSg4nDTeNtsrMRwISAy4y/C4YaXmG5PTqb3JhnOLu8fVgC99A62H6xOk9NLbkKgYH8YY/w11qqwAvQryiXwE6l4eg9MPQyvZxJXolt/TncLIxc9ZQDwOLObNPvVNtS5y3/VDXqYOryV+UKEtXbAqlKps8cp/lSI9MXV+7fpKp2NquubmWFsPKMQcefVuCsSi+xqEJ8LIxfj8spO8+u5ifNK7LLDYmhQQA9x6LvQjowg6zwx2ea0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgbPnTjY0SmgxL98VREocoWkT6gSQhPZLPnCYhup2tQ=;
 b=nkxmVezHSaYRc7blsiC7B7tJn+TjrvmnfDBOwEh2qwh9vpdp39OOeQttgz22Frq66YsToEalq+GZnodB+u0PeetgBsGDSmSoxmFhZTqdLzCGjJMZhyrBmO+6e9i6EZ2Ae9I7y9iC+6cNokLVCZeo5wwZfDQkPIUUjyLgOf6TG9A5qnlmuMaL5ObztwsA/CKdSKrAhGvFpS1deD12FqJVsahigBOB9fGZiBfeKiscViwAWpFaUzmmyGmRWnKMpV2yC4lCV7B1/2AnNJEfr20LnS5KXd4MjGJ6bfLB+ACU7da4y3s2EHn1wS9mSfNKtytQNynurFvAsBSFkdyY+wKzgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgbPnTjY0SmgxL98VREocoWkT6gSQhPZLPnCYhup2tQ=;
 b=v08q1y+xPls0osdyn63YK1M3IEzK8+tTLu1bmzkMy5kdotgeILha1f3su7wCwBaSJBYc9a7Xxo7SkCZwmarAKD4FVh2feRBVEjBKAfAztmz77g0HnCwq1YHsKbjDQf+qplRtBcwpB84CXjgEp4UF305lAXVwaGWks7xQ8X+SGuY=
Received: from BLAPR03CA0072.namprd03.prod.outlook.com (2603:10b6:208:329::17)
 by SJ2PR19MB8180.namprd19.prod.outlook.com (2603:10b6:a03:55f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 09:26:42 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::3b) by BLAPR03CA0072.outlook.office365.com
 (2603:10b6:208:329::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Wed,
 15 Oct 2025 09:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Wed, 15 Oct 2025 09:26:40 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 2973D406555;
	Wed, 15 Oct 2025 09:26:40 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E4507822540;
	Wed, 15 Oct 2025 09:26:39 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH 6/8] ASoC: cs530x: Rename i2c related structures
Date: Wed, 15 Oct 2025 10:26:09 +0100
Message-ID: <20251015092619.52952-7-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|SJ2PR19MB8180:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 07ff9e85-bba5-47a5-3502-08de0bccf305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OUYfzWf0wamSX57L/LxVsa9jppwCrbT4KP0MWiwMy0OGciJ85c9KQPAPXt75?=
 =?us-ascii?Q?OKfzCjifWcEkKIY1CrvrYyynFVvcz+W8Uc+GqnaqG7l5OYha6r7MxMxYUzpZ?=
 =?us-ascii?Q?Yuq7PmLyFxVsNZSi96+F+PPUFjilXfch8EusHUdB3FODWE1v4ak3hnKtLIf6?=
 =?us-ascii?Q?v407ZeSep7CUAgkqFo1l8jUrqQWrAkuXl2Fb4Kxi4vKoumsUVWBILrf6cT0h?=
 =?us-ascii?Q?Dpg0x3w+5npqtonpp3paoHn4Qap9fa2DKZn9E2B30hqiQJbwMTG1bKLRz9PC?=
 =?us-ascii?Q?YgyGMmx5BUMTq1TXJAgyn+Mah7bdp4gwdBp8Cptkrzz4kFxaTbH/DG7s8UDF?=
 =?us-ascii?Q?0q7LBO2cSmhbUpHcN2mw4jhPpUJXot/3cRWJM/+DzDgUZvuK9JZY7SRfPIIO?=
 =?us-ascii?Q?En7DupiF5V2e6i573jNhBR1HAgJyvec4wrGkon76RMXXf6kTsUTXZjae09PT?=
 =?us-ascii?Q?PZUGJYxVlRmxhNONI5yyKd+dEVhq+XX0jF92JF24onX4F6vryNMubzdBiPDn?=
 =?us-ascii?Q?zrauQl3ZdWBYN1alq01TzjULJ0eYfh9IrOacekHXsvOZMM8A9ZgW86JFT2Xz?=
 =?us-ascii?Q?J0/iUIucc65nbcXpnOfrBksS/r0MuN+YzlOlTxrgs7Bp2+P/IC73NEqjHlhI?=
 =?us-ascii?Q?aTBGDdnVux25QsnUby0BqYOHrb9Ybw7IQaMguaEvEu0XMs3bUqNm2P7dXP7Q?=
 =?us-ascii?Q?bSfNy/q/5/yHeSueXHd3WrMuNmuLPXkMvVEUJuB8rE7YBoRXfsTbm8+Z6n0q?=
 =?us-ascii?Q?cKYFHm57cVRXAq5XPE2kb1aSsKzhHkjGdyUoCSJvwcG/2a9TEfrfdJtePKjz?=
 =?us-ascii?Q?UeK06YyVV4iUDa+CeK00FlHonGgfi/q4WImfYSKS2j5NvIPuAAS2lqDZiljb?=
 =?us-ascii?Q?e7t9X0/r60LXHvbcYMdDqAWMtQN9G5jfGK63JdlOBwCsfgrhdKMli4EqZMhk?=
 =?us-ascii?Q?2uB3wfiH0lIAzPFN2f0IfG3tewD5ssqnZPEERF+00bOvrAJHrb1mXeN3J70K?=
 =?us-ascii?Q?xnAl6QDGXsQAVHXE/gc5LMXU6KLaACLVoYmmwXkNGN8gi+T+e/v6Ni8vfzkW?=
 =?us-ascii?Q?IA9xTlEQcz+5PoUDC/V+rrqQ23z5nDkuz+uLfA49/FTOGP+svblFQit+lz2V?=
 =?us-ascii?Q?C7NW5EPXdTOxKbbAlzLWYEpGEtxK3lrrut2onbExUa3E+TgeMytyAdEXM/b0?=
 =?us-ascii?Q?A6B7XRBoXkkvQWoqaQr2cJ6U1kQ+yifeN1pxT3JBRiViR2N0GqapJFH/cxZv?=
 =?us-ascii?Q?c/+NYnvML8j+hiViW5dPMIW/hnnxaCYAjpEOMnzbbDA5r5wJHphMHTdY/mlF?=
 =?us-ascii?Q?1kPL+7n5Rge1wPbuR0BhQZsIHR+y4nUg41ROq9qgbzKl0uZcofqsi2MglzN0?=
 =?us-ascii?Q?oeLFcKmng+WPVdQQj17OvopRrQc9KrudB6b5xYTdDmX+L9wGjr8zQ+kIb8jl?=
 =?us-ascii?Q?iijP3bXWm+2lbVOG2FoOs4hHqBY4p+gwkF61DCG5ziGanNeETeUbkjo8m5HT?=
 =?us-ascii?Q?+sjgXaV1S9TOwn5qTY5dP63Up4HTBgfaazt29Kaiw7bx2kYg14RlE18DbG4j?=
 =?us-ascii?Q?tF5F7JKD6Hg+/YpEF9I=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:26:40.9558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ff9e85-bba5-47a5-3502-08de0bccf305
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR19MB8180
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDA3MSBTYWx0ZWRfXx8tdi7VYa+Ab
 7Br+GK7Y6HvuNdggQp7BQXJWzKbG/YAGxQYzt1702GXB824KDOjIaOfENmt0G+51XduwlwWe1mf
 QZnybZirkJDLb+ZcP5k03vPRI8IRfKykLupqCMPNuMgdVCu3l+iUiJpZaWdzUqiqTi1sxgfb2Sv
 10fa67fJseTVVBihaEtpA1z/Ojwu7j+qTbKYsAkD+WlZSapLEl3ylutb5jdtbNgiTx7yT9GIdry
 ggoZRDbEnguJ/Ko2OP/HGr2QsEfnZzT1XtzUzRZvYdfRvR+m8ZlxTvbLq84RuOQC+4o108nqgiu
 2mAHwXjyI9uQe4E947UNZKfyaHVW4QBxPyw/MrxNyPFwa2WTZLCSXJDOkkHYuHVaKwUsfhrTMT8
 nU0R/ofjTha5UP/obHzKx/3DuzTWSw==
X-Proofpoint-GUID: DuL78G4e0H1yQFHcG7TX9BwU7SuRnYWW
X-Authority-Analysis: v=2.4 cv=PPICOPqC c=1 sm=1 tr=0 ts=68ef68d7 cx=c_pps
 a=Z51Wl0xbhtNzWEVEbRWhig==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=edWlu9fVkWd-uG4zv8wA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: DuL78G4e0H1yQFHcG7TX9BwU7SuRnYWW
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

In preparation for SPI support these structures should be renamed to
reflect that they are for i2c.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
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



Return-Path: <linux-kernel+bounces-854194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30067BDDCC8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B80C3B2506
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E63F319607;
	Wed, 15 Oct 2025 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ImWHjNkY";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="vrQuhckt"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B382D6E44;
	Wed, 15 Oct 2025 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520776; cv=fail; b=CSfLh8YJvtAjTZ/LZoHYyJQ4HRZzRDIkGSx7xpR0EUwR81OmUr9f43Zjg5Llq65ZSrYPu18rbAgOTbv6R3AFNrA5H6gDdrZf62Fs6LOm905unbojPD1mal5is6Zmxyu04vo96O0nEmCHDo2dUdx9bLt1HJrrAKTfvXzzF8amV2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520776; c=relaxed/simple;
	bh=nyWd+F/1LybmE5FHaOI3rdeBR8eyUTXzYUWGSZQn98Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DhYQi42rGpMpbLPNDj9sL5L54g0f94qrc58yYdosr9sIOcJhcn9TyKi1ttLGLkLn3N5LnE2/JE7s5X3qu3eY8pZFPQNcsuo+4D7bMEHTTz7Lm4R8I6O4JJ0LxfNSKfoez1yV7HrBsHQg0FuyViDLTSgrJbPPx9GNMn7NuMbs8y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ImWHjNkY; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=vrQuhckt; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59EGMndE1728776;
	Wed, 15 Oct 2025 04:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=x14LhsM3o6CGRkPiMARZUHbT0ds0f5tsicbq4mgAsB0=; b=
	ImWHjNkY3S27/As6MEXT+8+lcyXr9GDApyd8vfSZbjPWAbOyd/OXj0liiHqL+oLX
	0NzxJh3q50PPff0yeUBMPquUjTYKgta89BSbWPW6A2+IB0cOfID9FmEvM239i22i
	VmVW6/GS3Box/85aDmZTitPBVGEyocq2SCNjPQytREUx5CtWTFfyGZAHffuuhukI
	18HvFX221m8nYPQX2grHrG2qvy5ISbSuM+i8+HNokZn/HWuz+6DW59TyYCXtTdCV
	2R6BXePYWbl/JiTlRrVoKW2YYRW+0X9ch1TH+uhI+WKGaOmgB/uoewCDHrCuWkyB
	kB36FLExSJzabJOHP4/Q7w==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021074.outbound.protection.outlook.com [52.101.62.74])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49sdb42g31-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 04:32:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDC88E3zOKz6Y3XZhUMoU4KduH19QhvkiGBmP5od67xA7I9V8eU37idFXws0OXnOQlXRSFR7N4wW9x3syAduelnwhksuzg/p11jhsH8cM76WkYpLqd7Q2TBoZjHl8c1VMDK+6ZbUQ5OnFXjYsaAI1vQwwDIPs3cwqmyKTfFYNFvhxblrFVYoqte2yVr5RDFYDv3jlGXA89DVGgqz4v4HwDQpOlUVXu7pLebGjuR9/2ps85DSunBuP32cFQ45CZWYIUuokCXTkTg4AeKl8H4Ll8gU8okSrhuEhgwAdY5ZoZSgmcrdI+pWZpflsH/DWSLdnhpnL8PgJBhDcBA6XSvGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x14LhsM3o6CGRkPiMARZUHbT0ds0f5tsicbq4mgAsB0=;
 b=isWKFUUIa24TxWO+Z4GrCSWvdez04NgLQReT+D7ramliDhUtpDTUCPGi25Axhu+AOX4Pkn1Izyai6R0CQtutCTXH4LO3rb+YCHrI8shuVtFNRQHpsumwOYJe2cL8CyzdtNMqoa8Thcua7LdZvScRDTF2qb/e+6JHmlDQr26mpmJZNWQXg9l8gkdcEdV3/UP+b23RjSAdglPtpcfLOayEZinYQEYSTjfjZQ72VJvdVG7UzD6048PTVSjn/sKjPzwN54saAZsbFzSWIAseuWl/4PYI0FUzGfsVdaGVG+CenLrDfVVkBxEsle3Bt3xkyTAj4hyU5kKGxCuNkn9AytERRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x14LhsM3o6CGRkPiMARZUHbT0ds0f5tsicbq4mgAsB0=;
 b=vrQuhckthgZIiyjoA8GNV6IZZU16yf7qcR/UK/VyxBQ/yjiY4PDQWJ3UufECzKLPH51EFKraObxRx3UXZyj30E8tFCLA8bZIC27/IxZXX4Lw+msjNVOaoy5+HxqT1jA50A6pBlrFAFxBVtD24MuERDX7ujsMz+86tASPAZUWlsE=
Received: from SJ0PR13CA0183.namprd13.prod.outlook.com (2603:10b6:a03:2c3::8)
 by CH2PR19MB3800.namprd19.prod.outlook.com (2603:10b6:610:95::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Wed, 15 Oct
 2025 09:26:41 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::d) by SJ0PR13CA0183.outlook.office365.com
 (2603:10b6:a03:2c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 09:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Wed, 15 Oct 2025 09:26:41 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 970A6406552;
	Wed, 15 Oct 2025 09:26:39 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 60938820249;
	Wed, 15 Oct 2025 09:26:39 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH 4/8] ASoC: cs530x: Check the DEVID matches the devtype
Date: Wed, 15 Oct 2025 10:26:07 +0100
Message-ID: <20251015092619.52952-5-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|CH2PR19MB3800:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f88a80c5-c27d-406a-2653-08de0bccf323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9pkLVZInXjXGA3A5NhBA/41Ha7hOqlvjxi9meeZO0iQpD8LS0vpaCqSmjCYE?=
 =?us-ascii?Q?U7kzAVkek2324KBXKpUJBlNOF0Sg1o92H3i3Dlc2u67vQnxGkSiizsy4FzoR?=
 =?us-ascii?Q?ymYAz1rCGYFSZx//MMclsoGY1VI+Nuv6nLSb3LNCg+37hmKVjGDdG3YAHqRa?=
 =?us-ascii?Q?ce3EXIaTI8q84y0zp4sgfT2R4K6OkjBCpMW0LElAf+/5iNf++6rMvTn5O622?=
 =?us-ascii?Q?0xuzOCk5mFNrcXboi0SqaWR9uNLscDLw8Y14U0k3E3urcQ8sDC6wkOgZLUo2?=
 =?us-ascii?Q?ICCicRWBYbnManMDpHV79EVshfGYmrgIdU628kIZzvTyLC0uCMlum9UmbpKg?=
 =?us-ascii?Q?J75twgdTypdURbRAFEXRWHdp0QlPUK0Xw7OFp3FuToXS9SxYFqze5e1xAbYz?=
 =?us-ascii?Q?IqjWo60314DQgJ/zCe21WAkYo/vWhE75yeUCfgdJssoTV/AhVPsBYt4Ycw3B?=
 =?us-ascii?Q?V3g67lVrmFa9T2f2TGmZn6erV9lC2Y0w3FtIVOaTN2NqCaYY1+Ds/9dtLpvk?=
 =?us-ascii?Q?+rOLGC0y4s76GTUD8/qW1axmw4oTxnnoA1mAVtImrVA0jblEL4Oaj1sPxZ/+?=
 =?us-ascii?Q?ogtx2AadSPGHYEHTTIOmR14d6MvFnxv9ZRxw2WZQidRLzzvd+bjMBeBBSW6G?=
 =?us-ascii?Q?zMRZLyTxa6nj4cBK9ll7iptjmxOE9TEowenfg2akH8ituvaWK3uUEOlLVbCU?=
 =?us-ascii?Q?aNQaoZni3TRc/Xrh8Ece3MEsHdtH++iPMHq/cqXf2RPqXglpq2d8jdjaAblT?=
 =?us-ascii?Q?bGF/WYETwcOfCZbhSUfEWjC6T+jmqB9kKGSZLGQ69j+pkEZcoYAD2T30H9lG?=
 =?us-ascii?Q?ZF481/rJiTUAS4l32gD6uWz04pv0PjxLrqM5DvP25KHOUiQF4Wjn1kUu9JLL?=
 =?us-ascii?Q?sbZ23/oeC5qZtNBJDWerAj8PevEPfaQ+jqeIOGkWqj8IJtZfLhxJD1q3TKpw?=
 =?us-ascii?Q?ivOeG7h+EH+b23rrV097PHgwY6Bud5T4gUvo8aqa5G2GtfjhabD0YAsUgjdE?=
 =?us-ascii?Q?Rj1s49ZPugH6mn9QP4qYzSS4VGA+pXGoVTpsPsaDcAXrXpAqfR+KOqS5m93u?=
 =?us-ascii?Q?A6PgumFbpj6ACZYL25i6D0p6uQ5Gs4slh/VhRgnncEXz5Cz55EBAgvI3kGFW?=
 =?us-ascii?Q?TxvZ6sBriWtrTTRaWClojUm2/VLxrjjcLpkAmZj5c86QjIr/MWHZxiTYcDoB?=
 =?us-ascii?Q?ELyvmQ2o7yxhr2ueWhD4zc2wMyr676wkgOZ+PRCpz7VB6tuX5QnQofGyEf2z?=
 =?us-ascii?Q?pJTv4aDv41xk222epLHs88MlfUQNMfJw/dUib0EhzxSCp64TEJ6yrImamkyu?=
 =?us-ascii?Q?gPLXeFSSTuXUbp7KpnFAGQ7JqJGr6H+LxC6jexV1ZniYo9sENtZG3xg5bXqb?=
 =?us-ascii?Q?biIDrJEI67o0aFu35hqSZTzetV5IGb5H8lvDJ0LfZL1mb9N728unIMQOGvr6?=
 =?us-ascii?Q?YsFy0g4VDwWVP2G54rhNenrC5INwHMJ7uUBNP1K51Qx/MBpGOdR0j7IvPCL0?=
 =?us-ascii?Q?YCsaI38bjk0+UoS7+KQny5KyN+K7hZIKwQS9BNNEJjaiS4WMd2JnohlUs9tH?=
 =?us-ascii?Q?dXiSw4aPjZKxb64hNIc=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:26:41.0183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f88a80c5-c27d-406a-2653-08de0bccf323
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3800
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDA3MyBTYWx0ZWRfX5uMTMVAK53Qo
 T1XaiQKjcbpBuZ27wmQj9NHSN4/IMF1lQ0qCVob4Sv971tJ10bVFFclUIPMkqFcy2iqOl9OyEMN
 a7mzBxiyl3nmnOMbmkn1FUXdso5JLcANs4SJVB2on0G/4ciJLxnokF2tf/mjJVpQl6CqpE1pYYP
 nFuWi+0JnK+Imlf1jMS0KkA5YR6l7qhtM3KEuv6wA3KKhgdJ3hUTm+ifB6bF3FNc4562xRT5Hxj
 FQq1TVgFvBTyefr4dUL9Lt1T8ruKtbY8AEgFwKwV+5MpKh/op4NlCvskVqiPNExIyZY3/FaaIfF
 z7VR3cHOP/xHN0+mq781hlEdlbcdPh6vf6ZepOKxNxW95xPRQpyq4HOOP0jiRvFVw4sfgZEWA+L
 LwBZqZs25RXjjFhvVmeSkz5w5qAmfw==
X-Proofpoint-GUID: MunetX0Up1wd5sgipn6mMIXjqgr5UoTn
X-Authority-Analysis: v=2.4 cv=PPICOPqC c=1 sm=1 tr=0 ts=68ef6a3e cx=c_pps
 a=GnodoI7vw6685P6KDJTVEw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=Ueq04TJKjEWbJfMvJoAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: MunetX0Up1wd5sgipn6mMIXjqgr5UoTn
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

If the read device ID is not the expected devtype derived from the
compatible device match then fail the probe as other configuration
details may be incorrect.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c |  6 ++++++
 sound/soc/codecs/cs530x.h | 14 +++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 25dbf401b15d..cdd050c0fa2b 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -1181,6 +1181,12 @@ static int cs530x_check_device_id(struct cs530x_priv *cs530x)
 				     dev_id);
 	}
 
+	if (cs530x->devtype != dev_id) {
+		dev_err(dev, "Read device ID 0x%x is not the expected devtype 0x%x\n",
+			dev_id, cs530x->devtype);
+		return -EINVAL;
+	}
+
 	dev_dbg(dev, "Device ID 0x%x Rev ID 0x%x (%d in %d out)\n", dev_id, rev,
 		cs530x->num_adcs, cs530x->num_dacs);
 
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index c10a6766cc7a..758d9b1eb39d 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -185,13 +185,13 @@
 #define CS530X_NUM_SUPPLIES		2
 
 enum cs530x_type {
-	CS4282,
-	CS4302,
-	CS4304,
-	CS4308,
-	CS5302,
-	CS5304,
-	CS5308,
+	CS4282 = CS530X_2CH_CODEC_DEV_ID,
+	CS4302 = CS530X_2CH_DAC_DEV_ID,
+	CS4304 = CS530X_4CH_DAC_DEV_ID,
+	CS4308 = CS530X_8CH_DAC_DEV_ID,
+	CS5302 = CS530X_2CH_ADC_DEV_ID,
+	CS5304 = CS530X_4CH_ADC_DEV_ID,
+	CS5308 = CS530X_8CH_ADC_DEV_ID,
 };
 
 /* codec private data */
-- 
2.43.0



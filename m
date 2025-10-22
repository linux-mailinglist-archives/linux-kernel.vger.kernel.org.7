Return-Path: <linux-kernel+bounces-865117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82DBBFC4E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099C342183C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FBE34A3CE;
	Wed, 22 Oct 2025 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VeVwqL+M";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="PMMecijJ"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AAE348869;
	Wed, 22 Oct 2025 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140400; cv=fail; b=XOnUztrvfFW+jdxT8qVGDdY3xcvFblm0JP8mWsykFeUU8mMnRk0tKmaBUOqJAq8W/GVBhkpLU4oPDNgqNblSdVifn928F5AAI1etCCWp/JkgYmhIq0cPKFLM81mFVG12qCSulXJYtFaE0I/HGA3BIp14W/ZHvYLMsvI7J3ibpfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140400; c=relaxed/simple;
	bh=HqzjPgYppd/4VmvF6HVg/0Z/VuRQOp4sC3HTFiedTIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQzX+8vA19Q4oWEopy543goZpSntq0cvuQ6fRZ/ImycXxfBtQ5Meh5TnydoSlHcjL1BK82CX019SeHnlzHsu/z7x+lJsgjGjwoe8FDmQXg5nh5giBWMtFt0ufpS+BX/C9TDEIiloMYjKSXmKRKBviYS0vqyuDg0VowgBhQJ+Lrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=VeVwqL+M; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=PMMecijJ; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59M3j1f23660649;
	Wed, 22 Oct 2025 08:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=w+3em5bymghfKXh5VVdFq+SAV6ihUTh5cleSrHFE62c=; b=
	VeVwqL+MutNmIUaDHfU0wibygVAVrL8DwZu5YSBmHt4o2HJK34zWk/FWdqohcWOl
	Q2Xquv6T6K5aPaveLMClYVhm8M8TR1znwZEfkR4yyvRtYD2cuKjlyz3VKTW3dPx7
	ULMrbRPsnoTs4xtw44sxTvzB032WoUBT/pJEhUMyTn+QXIdWhukQSCdjFmoGBZKO
	nK+iwyT1T4LWF9QlH26jKVq80QewS3O7HHWgQyPQxogFn5dTOj6no+8QQIt5oXqw
	0q0SdlFNMy4/KO3fdner82ZziDcKP8y8o0V52pxIXo74uoKxtvCf6MXExf8Z5ZGM
	0KNUWGFcOr8v31jMf/1bCg==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11023129.outbound.protection.outlook.com [40.107.201.129])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49xqmqrjq5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:39:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iddScuUnwfH4mt3VKtMUwSaJoz6fSb4R1/0TIBehIn/P7gqOYeR4X2221foxC1GNV9cdKetp5ha/mivoVN8fOwZ2ZYeqWt29u1zweDypOOaT0iSZA5ij3PCEZobkvRJfNxIZS+0MzqyHsJGIQidNIYfkBm1wzUOduHqFw2n3jCO/dfe2P/Y2JjeYH6HThXtYGLX7Fx7U9/Pe/TZcmz044Y98DBWBsvX5HQykMcIwS2wW0zgBUJlUOj5oXUAk5oyx7syWYrO2aOkA2jwvQ8MxEIUPloMMJl8uL/H7jhZHyj/R8AHkNoFfvZczt4Vm/CFg6fFfH3iaZMvr64uf2ErDrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+3em5bymghfKXh5VVdFq+SAV6ihUTh5cleSrHFE62c=;
 b=veBW9qVzSP4ymiIAiI3BAv5SSC5IvWJGMXU7LqgaSNIGyZi2pCVGcQ7WUjYKTzrhb7XMEVdjKOxN1crRB7G4ktj/8/zuA/MSzTM62WYwCQ6dYtRiQ7aCFcZNaHT/OuXZuhwOCnXTyaUka4bNQfW422JwdZKBl/1uWAyCkGSzFb9j5MhagTTsVxcGIuEi3l0CDlzZtF9Lgke8goblE95TG1StqhWemvSt5XpodQwzN31JXl94QLvCN+gCkib7XvBJLRWJ/OWmdr7Xoh0/HjSkl4d0Eg9O7jpiQSbmYuxlIVJa7vvX6/kWNtrwrJJQ0h5NkgMroGpYlNIbCW6yiG6mkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+3em5bymghfKXh5VVdFq+SAV6ihUTh5cleSrHFE62c=;
 b=PMMecijJ5guHi6WSbll2hM/exF5k+Hdp8cJCvWLuFUfOTRZHiBqDHmtIdBTmlGcD+EH1FyyshRRC78nxfGgj5TwD6OWl9ouAGcR3kTYukcXgzN6SosihsSCKNC3TuuTnvhERxzHSWKtylSzMyE0kk4vVV4sUzk3auBXzTDiSy1A=
Received: from PH7P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::35)
 by LV2PR19MB6031.namprd19.prod.outlook.com (2603:10b6:408:14c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:39:39 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:510:33a:cafe::ac) by PH7P222CA0008.outlook.office365.com
 (2603:10b6:510:33a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 13:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.0
 via Frontend Transport; Wed, 22 Oct 2025 13:39:37 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id B814140654B;
	Wed, 22 Oct 2025 13:39:35 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 52880822540;
	Wed, 22 Oct 2025 13:39:35 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v5 10/12] ASoC: cs530x: Rename i2c related structures
Date: Wed, 22 Oct 2025 14:38:51 +0100
Message-ID: <20251022133914.160905-11-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|LV2PR19MB6031:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 756e72a7-5071-40b0-a27d-08de117071e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l+vHWWS7kTOreDjURVo+hci/WQlclf3H5EDoQesCpIescRQgFjfsz6ylICVc?=
 =?us-ascii?Q?phaiQ7VwE8F97AHLskzpoADQrx6To8MGA673y4YLciTqTWUTOLWiJoBdjdf4?=
 =?us-ascii?Q?RUw4VioBuf5Cb/CHEFiI7/RKOq+2tbKDxOpB1r51AslOxt0zA88fAy2pA1ls?=
 =?us-ascii?Q?uGiNTADtNdHrvQTUbJd5vGShcekogRKc0mgh7/5GJIz40kISEl6zVunn+ee4?=
 =?us-ascii?Q?wzS3cdrvKmdm37NHxBUPn35tOJDitVmjDXcVubhMGmPUdraMumcO2NhLl2eg?=
 =?us-ascii?Q?kaIJp6Dd8Eb5cJKem6wpGe0UlLfV0kIwEhFBMtGc87ZQyu7Giu5SJgcOJg95?=
 =?us-ascii?Q?BTyVkLBT2YDRpHtpm8B8UB6WJVV1XM7em8E+DTe0o6ZggQ6mPmVNU7V7oNsQ?=
 =?us-ascii?Q?EDKdfyyX0a3UleKT3CoVRy1TGLpKGfF1VS1J6yMw25Q3GEZT3stzmjcNIK3b?=
 =?us-ascii?Q?jjNhvidS9+2iMwuZRMMSA2sk4ImC+Dt4bdVtm1yGJAGZYijOVbzd+bIeGaFC?=
 =?us-ascii?Q?RAfa8yfS03y9gxfsEZFSwkBmF7XShFoXU939e6j1EXFx7GU0lGehuE8OmHei?=
 =?us-ascii?Q?8rhrOpEG8vak4X3LnQKVvBcwU5dhFNV5FCB7amOPOM74PAnQmRUjjIII75Cb?=
 =?us-ascii?Q?BFep/5lj3At0gdVYOUE0Hxw7jB8fftxvPFFe0vBNAnFVyNJEOBxnNVmHZ6/W?=
 =?us-ascii?Q?iITRUcYvOSFVj1Z4OJdUEnbOYzdaaBEZAO2i80VgImnjF2yX3ooi6YCTxJp8?=
 =?us-ascii?Q?93t4d4CqYQtkJgorebxhwI3SEuATnngf6oxd49TE2T/rVluXDgsSWxANAHaA?=
 =?us-ascii?Q?KjN2McFAEVJw4IckFhP8dc2B3755CHS9XCYMbEuZ+KdBMLq9TG+ZONgqTm1F?=
 =?us-ascii?Q?ILYfZeBzQuXGsjanmN+EPCd5GWgXOx8tQaZxsDSIN5FdPZb1a9xJxpKJLhZX?=
 =?us-ascii?Q?FJIj/7MLtiA3rWxO2U01W3tT+XBfQpcVoTwmYgz24ccOHbAJznlUab+KrJ+d?=
 =?us-ascii?Q?Ouxh3lJm9EeA/+Zqcd1Im5aw7iTCgJtk87LEAyhxQMnzNynC1Ja1rifSV2XU?=
 =?us-ascii?Q?wPXKFT57rHkSQ4bMhE/e/lpqjoL8FwGK2bQCjwf2S536vo2bUGVSREwTvJPK?=
 =?us-ascii?Q?0d9nDL+nSJ9gXvzNuVGnXAZLER6SsjinoCg/wRUriiYaYkjoq2CdPuUQmzBp?=
 =?us-ascii?Q?ideYRlZ8byqrWY6i6UjxLjCksEiAGGM+y2Mpq4BNhSxS4phX4GpK+s3l31px?=
 =?us-ascii?Q?Ucj/jrzkDZty7lEjCXblEyp98Pna8REXDGaIODsectfeqH/lglni9Z1hzy9W?=
 =?us-ascii?Q?VBkZzhuqr2kzpU15bBRh0FqKYDhGYIq8TLluVjRZdueaDJFaFuWUFJzH++Td?=
 =?us-ascii?Q?216vRVAzQ4Jcb/P0zrht349c+pyDedlK/uzpv1/IV4hhVQ0xh0KFV3r7pQdr?=
 =?us-ascii?Q?cRmYjorMBb+szwKH2zdaaOMQM53lHSkSxq6z3nwL9NNOOL893Bsa70vglYGD?=
 =?us-ascii?Q?jVa1OEdb+noh1/ZcF+p9TdqbgfpZxqqmAl8UKpsohAM0LqW8GPA0/GDeIZtI?=
 =?us-ascii?Q?kw5DzAK6KDNBaFU+Flc=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:39:37.4603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 756e72a7-5071-40b0-a27d-08de117071e2
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB6031
X-Authority-Analysis: v=2.4 cv=G6gR0tk5 c=1 sm=1 tr=0 ts=68f8de9e cx=c_pps
 a=roYWoV4TocsuA6t8t8h9Ow==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=w1d2syhTAAAA:8 a=edWlu9fVkWd-uG4zv8wA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: zPeoQiXz02NCM8Kk0ZklPUzpIrJLxdW4
X-Proofpoint-GUID: zPeoQiXz02NCM8Kk0ZklPUzpIrJLxdW4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDExMiBTYWx0ZWRfX3tRZbzwXaGAU
 ZlL5malsNgxb76G0HZYF6OQNDTfLRNQXzydqWbEqbtDJoVVry9Ve7NvhKvyT9mrvGUZtnHX9aA2
 nNbdrUjwYGMQFH9qMhwBoCWwAXSM7sWnxcj7ukc0g23Ro1QROjVhaJL2DqNNeLVBQIvOJUUhgr1
 pcUeQJaUfTPf8Kxx2hsQjR+7uoXqEBR8jmszKBb4i+skBVQGZSvH/RND8EdwdVA+SFm545g+SvK
 Cxr7qEOuugiSEXodC2zZIjwEmGiMIUxCfJHFOIbKMu7K6eq4aOJqpu+YnjNtCa/4TpzwCLOlPLT
 8rxAANGIuEkPrD+mKVzhbcgOzZCO6XBYxFkqmeICzOGe3yfzU3essVUurAQOjqPpQ6VqjmAPXQj
 sntjyXMpvGZkqcPQis3xLZcNJ5xHEw==
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
index 19fac4a90368..9fcae9b85a45 100644
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
index 2c773c4b6b92..2a7b7d01ecfb 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -246,7 +246,7 @@ struct cs530x_priv {
 	struct gpio_desc *reset_gpio;
 };
 
-extern const struct regmap_config cs530x_regmap;
+extern const struct regmap_config cs530x_regmap_i2c;
 int cs530x_probe(struct cs530x_priv *cs530x);
 
 #endif
-- 
2.43.0



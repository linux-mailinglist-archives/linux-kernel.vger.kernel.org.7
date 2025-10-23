Return-Path: <linux-kernel+bounces-866553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 421F8C0014D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65E61A6101F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2492FB09A;
	Thu, 23 Oct 2025 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="TqqTJb79";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="uaxVsIlg"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCB32EBDE0;
	Thu, 23 Oct 2025 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210239; cv=fail; b=nCapjuby4EEhJYvcbdF9eTB81YqaInR78mXMuLrjW0RK7mC1cHenq4/t9ibEikFs//RPBbcclBkzUL/6bUPrJNTliUgTOLj2em5E7QBzybiIv7qbKL34eaYZTnKCMfOOAoQvPkRR2lFJ5IrtbLvCahs1Vh8QOMcSFOyWh270zlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210239; c=relaxed/simple;
	bh=HqzjPgYppd/4VmvF6HVg/0Z/VuRQOp4sC3HTFiedTIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdem9l2DHLc8NHPMLFoc4DqtzgSCxI00qA2qp6CpfuAd11Z/Lq7NAfdO3xWncgRSZVQjJo6fpOdTAkhCnfT4LyTfhAbc7qMtSokqqqvHBS94i3J/fwsqGpL43ZMDsSKAUIjeSsJnUywdjsNmNorEZ8EuSaszReWetGYO0Cr+vAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=TqqTJb79; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=uaxVsIlg; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59N3xgFk3465752;
	Thu, 23 Oct 2025 04:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=w+3em5bymghfKXh5VVdFq+SAV6ihUTh5cleSrHFE62c=; b=
	TqqTJb79GQyKP0fWN5/npc0+5ksU7tMNSJj/1RC96sC5cu2O/nyPnGuAVltpiRBH
	hjxerF2p9cdQawksaJaWSw+h1r7zeG/sQmEcsuBmskAyN6lxYRKWGvL/tiFHFHZb
	H/ODMIy8O0PFp4mF2z/mJJvK1hVGshG0SFS6Ht30dzqgEe7BWVKv40K2f9ZPfZbz
	DLRfuy5zezfjiFLa47uoi+k3J7hgeK7vL85N8mvZlzIr7RrkhQZX3TTb5GbU7BJj
	ZCkCTGBLtIdQGT5yJflsuWY4i0m6NAyEDqXWww7a7XHmO8bYD2UqWGlkETh8WAQV
	sD+jLvlhQmE2FqJm2U3IZw==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020137.outbound.protection.outlook.com [52.101.46.137])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49xs381v64-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 04:03:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0mFpAZ24zHacmS0ege65FnMpH4EBBoYGE0BWFwlfTGv03glldztcbyewKFK1LMhC/FNgIgrsNtmY9k1QH0kuM3vnnW/USX3WtLOfiCjdaOce7vngewOnEaFT26TaTzrjM3TyMZWAuagPWXTY7FE8rrp4zrdUEjD3UoE97cihRM1SKxkdy2jEQQ7ZAWOVsMLSlrJigdzWonAVjDLbc1Ug/zcJFapisEZLfmmkRbE2XUn9YKrRCAHb4Own70Z4fTflb15HTvG06cEnGdJ98p79NxZsQSb/sSeTr50x4/BLVQWu8h97TNpobBP5e1L70UhzCwZ9EwfRfybt476oqE2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+3em5bymghfKXh5VVdFq+SAV6ihUTh5cleSrHFE62c=;
 b=fCDMY9q90ZD4yCktW4nrFuvWb6ZE056evi6RgkFwjFThNNKEYZblxLEY1YtmG+Npw46TnHFiL50WJLweCYuTKrKvnbcNHF6AB674+OUpUgaJMDIQCyi+q1cyqVmJd+oak3762R5VtNgu+eZh+j89pTXDuG9GhuC74kVRwFNU748lO8jG4362MZy4UEg4z0yinSHhmPGM4eaFaM4+n0Jbnyb0mVTfPdm/mtca34xoNyTuLQVckgZkXGEHly5nF/8Iw7ls6Gv1hl0MKyPlMEMLp0YJPx4b2gnnoeswVb4ALWE41u4MtxKYxe43NX1ditvYaKILI7umfAoywkWS5DwcqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+3em5bymghfKXh5VVdFq+SAV6ihUTh5cleSrHFE62c=;
 b=uaxVsIlgXoRzSsUofLlpmkKjoIvUCYZebeVmw295PFbeR65mqv13WtUW8Lz1wDEwrnLSbXC7cHHUbfOajsmX3qQDxQ6eAGRBJ0CK4fm3apbuSBontHhP0J1b2Uu70Ir9qXPfSgWamvEzdjD8rF2OB2d+pAJMNDidakN1jLCTGd8=
Received: from CH5PR05CA0005.namprd05.prod.outlook.com (2603:10b6:610:1f0::6)
 by CH9PR19MB9273.namprd19.prod.outlook.com (2603:10b6:610:2db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 09:03:43 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::a9) by CH5PR05CA0005.outlook.office365.com
 (2603:10b6:610:1f0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 09:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Thu, 23 Oct 2025 09:03:41 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id DB780406553;
	Thu, 23 Oct 2025 09:03:40 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 7CAAB822541;
	Thu, 23 Oct 2025 09:03:40 +0000 (UTC)
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
Subject: [PATCH v6 10/12] ASoC: cs530x: Rename i2c related structures
Date: Thu, 23 Oct 2025 10:03:18 +0100
Message-ID: <20251023090327.58275-11-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|CH9PR19MB9273:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3abe61c8-63b4-44c2-f895-08de1213106f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6t9d2XkMSLfinN0ciZBAWKIeStuEIEYJ2EyrsgW6jgj5TN5+GX7Ofh2d3/SO?=
 =?us-ascii?Q?528cdlD3HzWFcRnuWWgeFIybIsgzAsh7M+OBXqG6LvNcYoG/M9y+Ql+jkXNL?=
 =?us-ascii?Q?4iwypCmKXIhGoDMaRcL/poro7XBiuGgD6Icp8NlY+DLY1PmwnyLPCzGmbEfw?=
 =?us-ascii?Q?eCPnsRNk+QygkjqQP0zFTOM+Kdc7uu1Q2bDx1Ewlfdiq7LyY5MOsBQHRml8M?=
 =?us-ascii?Q?ROPNAY6bniAwXsI6oy4HIgIampPARRXkUIScKQihbJdd7hOLCDfcqeZcVlLg?=
 =?us-ascii?Q?o4nK9zYWwJH0cV9wgAz5cE8TH0OEOZ1cE5NvPgZCG62nQrspih2YAbBzTuZM?=
 =?us-ascii?Q?3SN1yzPv0HEyE35z+IfoZRvnZ6IpjAvEZipJ4kAOLj1dCoThI1gi7tWXcdrZ?=
 =?us-ascii?Q?ohMxIUh52T3cpBYh3GwZq35or2mG1C3FPErkZdZ8TUvqcBb5SFUS4VgNt+ON?=
 =?us-ascii?Q?iGnTaE54M/DaTgIjSuCv723JFgnuDhNy9S7gSyPz8eujdvX8knv2eQzRaALn?=
 =?us-ascii?Q?bNRNjksOzack+kogd4jpZ2W++Eo5LTWFqHVu+h6rLenQbjZrPpK/Z0qdDm3R?=
 =?us-ascii?Q?R5Yy9OtIprq2b2n6Mo9v1BJFUxJ+je1k9NCbXb0Qw2BpPzszlSNO7A5kqImF?=
 =?us-ascii?Q?Fwny1nmDNzw4XMAWPW/pX9+jcL9cJCM1cwgSjkd5ae2izdyFFWe1Vye9IaAF?=
 =?us-ascii?Q?/0O9yyQPD7I6drWRL2W84XjEfd5gxkGS7xek/vifedp84nMlrT6DzMrRihqa?=
 =?us-ascii?Q?cjKEb5UZ7B3Oidv0OUjScYnhhE5eJ1bp1HaE6G4ECGrlg48b3G9Qs8Beju4k?=
 =?us-ascii?Q?7KZWA76LdsS0KpX/mVT82Xew6OB1BFsEo5OpPaWRHCrf82Z98YABAPc3pd+Q?=
 =?us-ascii?Q?Ei/lMuDtCXSGSP4XwinuYgyhSkOu04xtYh8zMlOFso/S5cege/MEAMAYvQXV?=
 =?us-ascii?Q?6EXQ+L6uWp/4sOfmGWQkhB+H/FSLg+Ls1SjRKHFf/IW33mUHFY5+Z3Iq8uAH?=
 =?us-ascii?Q?LzUSlB0TEwg3I8RJ1ho01lNT2ddSWNnhSflvjdlCkGTqQPxZh2Ynv4XoXLKU?=
 =?us-ascii?Q?kfEQVj3wksfRSYIwKBSDPQ2iPMXIKsiAqUuigodEMyn+YLPKK0fIzVdhtK5I?=
 =?us-ascii?Q?Fx56GWZem6j0LPsHZw1szAAsiBMb+aISf8et21BjEqEDPOlw+fneoUH8thfM?=
 =?us-ascii?Q?P1Q+tlDMU80xDFXmmTUQ/YBzs08e2MdSzElC/BaRmF6zrKhgHFGhwcDSWooX?=
 =?us-ascii?Q?w6d2nPQHwfOZtIw24+iAbEgMJIkt3usQrlHaxeyzdV588A2ZeRz7GaYJpjcU?=
 =?us-ascii?Q?NtWPscxtnoX/Y4cYhVxnEm9JcPZ5oPR2C6XAxCDzOtIf3uXxUsjcgRqfecCv?=
 =?us-ascii?Q?9qvxCFJsfdq/ZfspwZTJx1LOyHrRiBbZIapP0Gvb0puII/JiOtqOdh+hCjkM?=
 =?us-ascii?Q?paFQgHBxRTLhv9rRjA4wHivai5Nz4JnvZeL5v31NTzy0xTW0rRzi5GZ8Pfl9?=
 =?us-ascii?Q?SHkEio3swYD02ijj42xflu2fNSyC5jyh03MQwzwnGyvtjJld/YNQbDCcLD+8?=
 =?us-ascii?Q?RqpOQyEraPl97FHZfyw=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:03:41.9911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abe61c8-63b4-44c2-f895-08de1213106f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR19MB9273
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDA4MCBTYWx0ZWRfXypzJ8aud/fco
 DRsYfIW/2VsCh122pBhbvlpj4mZ93cNSIT5c1QgR7JdmndJKHBkSwq3xckRBM/oTujXcm+2g6jI
 3QEmr41jCimg/gJuw4/ePhRd3kk1UXbk1NOujX9LDRXhipbN+rIk3lBBGCrebYYOGbFan+VzUnq
 11DwhJTvV4sniaKMKKdSTaBP5XBJaESkRmw3WenZ8MuafqVayG59uU3NU1bhJZ7ADfHfrpv5SBl
 h1U3pwx5AKeyIubp3k2U6InqsabSwyONC6AWHoN2oiA2PKNnEwLzen+sJmcWDgqEkd3iWSHTsLr
 vpvGtmpxsqVQBvWIXyvkoiqOZWTd0xjAM1NlsXunCWedn1qImKLjUC1jeceGMOFDpUaf36YyHQp
 GA3cimtgcvKMqIpFgQk8UWHUw2a1MA==
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=68f9ef74 cx=c_pps
 a=wDAJpOYZAHWe0dylTDiVZg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=w1d2syhTAAAA:8 a=edWlu9fVkWd-uG4zv8wA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: qJhkK4gPzxvbmE83fGQyNyv3RONy1Ejl
X-Proofpoint-ORIG-GUID: qJhkK4gPzxvbmE83fGQyNyv3RONy1Ejl
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



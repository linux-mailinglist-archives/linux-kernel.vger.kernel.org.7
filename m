Return-Path: <linux-kernel+bounces-821170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ACDB80A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4906A623483
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711FA3397CA;
	Wed, 17 Sep 2025 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="R0jJ27KD";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="nho7Dsw5"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B733AEB1;
	Wed, 17 Sep 2025 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123462; cv=fail; b=o1MAgMHhdmf8hj+Yesf/yZQndBaOcedjHkZxSLh0MI0BhzPqZAsPMGQVkk+AFyelNbcT/EbX/sWhc9d6tUtrNXIxVnaz0W7xtZREY/EN3tOxAJMAK5IwlSChMLSOTH6hKmyBeBjzDOeu1zh2pbE6ZaGSr+bWsbyKYnjWbrXgce8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123462; c=relaxed/simple;
	bh=3/WKNZUG4rAMQShTNDDwRDvxRYgS2G7yd3vaOhY5YS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uqAJHxKfgNWgY/JsH6ByY//UtQtC367kVv46tg0c58gYxLG+4TXagJ+M0nlub9yjw6VDbOQSU8b0euo9s1T4/lyawjOFb34vkBXasso9YlC3xXR/GMvcBgemks/EwBLifvVwMDmN37QRxOSgUrS9k57W2YitI/48yfBmFt7+W9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=R0jJ27KD; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=nho7Dsw5; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58HB3h3S2718932;
	Wed, 17 Sep 2025 10:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=GtC6c+39d3Wl665w
	lNbmjUt5/GjOHJFFxHF0X3a0ZkE=; b=R0jJ27KD2KyGwQ66IZ+LIKWDXuLWYVzn
	ey4cs002vbDwupPmprOtS0XZsd1a54vmG1hMA+yY5vHJnpvFc1Y84NU6yUIarYuf
	vrpRCMDc+BKzH4GEE5LXVG+CfpJxehlvEacm98i3zEpfb2RF9SvHi3ePol1NZ2D7
	VoQ9oJM701X20IYBNEvdVb6gIkD6CRzTXR/7PKmNOW+D+J8PkQXRSRUQ/wotcu+X
	pn/2cZN7H++wJofyjHw0YpTUOoNGmYpcJHZnVEHkIUOSbcuUGCsGbMh6gfWioccX
	jsvYrIgTcd00KK2mrktd3ayyy6WOrYrBDb5Pcidva5YoFbuquhlTlQ==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2098.outbound.protection.outlook.com [40.107.212.98])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 497fyks975-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 10:37:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVhd/kiZu52zVgpMwHckHIzicaaldNlmkDJlvC/B1YjfBre67cSwMdql9gCEkiQdJN36BWKa9FnR2zs7dwBQRyHUVi52tzbMdTFcI8mnm5LP5T/rnSblTQATMgOIlH1/rO9+Z29fZdd2cD4nJlzStOLoWMqeEChYgezwzygUSoqvyHJqy7bGWl2SS420S8+k6gKeUOoAEfeEnCdU8YnxQ71j3k9MjTfVSvNj8ZOQjmKBW13f+dhyYjPlYcuyguGzJpm0pk96Di4pLnkBZE97oKJP9JLCwvHqUD6SehoP3kgme3wjVf9wP2QSvUPVMWHABq4ISb+hoOqmzUxcT7mtOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtC6c+39d3Wl665wlNbmjUt5/GjOHJFFxHF0X3a0ZkE=;
 b=OtclrlzmZKIChFakOVTDcM6VG6EisP0Ihi5yvniDAnxwYMyhN5aTnUOJkECYWP3Rt/PJox4vGnZ67JmV8L/83AaH/9WSlhNDpZtiqBUGCTqIoslrUaCn3Pbg8eBu6vwlUIfjr8gORjk5IJWoWMB9n6Km2lBsAgHgyvJeaaGdwtAa4Ot05y4wPeOn0s7kV25xhZcN7U0u8kzvMDLhi95cTMRgXncOJGRFrPOl+vSQpY9BKfpcMpzEr73L2bGt86HDm8fByVQ3u9o/Qd/zB1YuBtxflkVMjugH//NuuS49VULpxEIc2aaixc4kFBF1wlQm5bAm8rKZfgfRNS7j63H8WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtC6c+39d3Wl665wlNbmjUt5/GjOHJFFxHF0X3a0ZkE=;
 b=nho7Dsw5e4XJy/ACxpQ3xgFE6qcrDSLSyWD2WezdbI071RYezFLppsU+5tX2bY6Ndbcids7oYxAT5kb6jZSVAW0H00dOzCu8/9q2slvoRtejDwLrea41wyS+RuS87FxjITtRq4wawSxc943r5lSWk187JADFGd/3TJ0qDM3gPsM=
Received: from CH2PR11CA0030.namprd11.prod.outlook.com (2603:10b6:610:54::40)
 by SA3PR19MB8196.namprd19.prod.outlook.com (2603:10b6:806:37d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 15:37:32 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::69) by CH2PR11CA0030.outlook.office365.com
 (2603:10b6:610:54::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 15:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Wed, 17 Sep 2025 15:37:31 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id D006E406543;
	Wed, 17 Sep 2025 15:37:30 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 8FA4D82024A;
	Wed, 17 Sep 2025 15:37:30 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 0/2] Support reading Subsystem ID from Device Tree
Date: Wed, 17 Sep 2025 16:37:10 +0100
Message-ID: <20250917153722.94978-1-sbinding@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SA3PR19MB8196:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f6c8f564-1354-4673-f40b-08ddf6001e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0bNFEVi3qEC75mtxDOcA30s0C87GEr/HVXr5aSD9GxcXWyNNZhG7I6X9j6PG?=
 =?us-ascii?Q?Ix4fcIq0++RHgZ2eR5XJzA1OtlZBWigdNaXh/cvzIpwf5k9MkQG3yt0wJpRd?=
 =?us-ascii?Q?WZ3lAyelDp1uS30h1JkOfRjoenpwAzeskaMwplVPaPq/Io+HuG3Sv9C5qa7l?=
 =?us-ascii?Q?nXqMDtxdUfa2EPfy+rbAYrZS/NQlQFLjJWBo1LJBc1U3QV+anRBMycYqa9/v?=
 =?us-ascii?Q?5nyvFoPIg/1kaggmcVbZUUb0qZ4vc+4rPnNsQiIF+EupscIifzuxEzovDFBi?=
 =?us-ascii?Q?RSRmyaN/aPMt2DDX8m8tcCpSXWAqBfpwzynNONtRrR23CWLqNDf830Ss1QB6?=
 =?us-ascii?Q?F0DwonRvQPnkMU+K5NJBehQiV6y6/7mQmCeEegf5dyDW6Uf+OrvfFLIw5diN?=
 =?us-ascii?Q?WBEfnzNrrG5iUwhUxoRKSwAmrDWUn2LQSHT1udqGqRI23+EQM1s30oGE3KOi?=
 =?us-ascii?Q?3Cacd9TvmRTT0E+Sa0czDOH+QG/BQyAcaaAOCxbOrWDBTnRg0J3x5JHZ2mE4?=
 =?us-ascii?Q?P4n2w0PEJ9eJMHbktL4IBi27Ym9hfNuHV7i+r4/bGj2T+zLcBBTg5XVStg2a?=
 =?us-ascii?Q?EaH6551JBAmeXGyfq+t9xMXDWCEmyUo3N54ztlpuo0nAeh/O+NMRbvrsPNG+?=
 =?us-ascii?Q?i0rk7C8tC7Dlmb3jUckDA0IfoQMBJEdvuiw46tclbIIiwo+tylJLU5/ZfPpt?=
 =?us-ascii?Q?49CQro8QyXY3Hq/2nRdQ4BaBnkC0KUFP2IHpuGaBzY3ULOcsS9cfdSuPoMoY?=
 =?us-ascii?Q?o7vRVdd5VZvUQYbWtdStPjGK89QDzS0ImtBRIApmILUtFn2rJuxrgnei44a0?=
 =?us-ascii?Q?eWVRlr1Pp8J+96rAnvcz50fUEy9uRCA03TVzUf3eLCzX7fiPbjDY3UfINgYf?=
 =?us-ascii?Q?jjMx0GxhIvza88f0Tg7JeiHqif8CH0e2QXcoOy2bVZj5GweQpAzjkWJARohE?=
 =?us-ascii?Q?cA8+6UkI/rzEOttpFo1fK53b/Qitvwt4gVBoSvKe88nj6hdqTA5zcW+ytXO9?=
 =?us-ascii?Q?WZ1y0uZjI4Z44X09p4+GEW7JluLFcXiYPE0DIM408p7HmkmwjP/gg0aU498H?=
 =?us-ascii?Q?HQs1kjuYGpsdINGVB6Ef3bENyViL7tEAD97m+x9w+g3+/JxEDmovdSYKff5U?=
 =?us-ascii?Q?+9lD77qnMj78hKEc01b6t2beWS0+s0V3Lnq/q8qLmo4tJksiSh6sEE0C5sEI?=
 =?us-ascii?Q?XSNBhfLD5DMV5BA+eHWjRWtPGVFI5cmrDymzDomqHRrqx/9Ikyo1Pqjunfjn?=
 =?us-ascii?Q?YXlKrenh5d+xZebAI6KUXVykw5ibXl1FlNLKdfuFHOynnBHaBEnDT6p6jjjb?=
 =?us-ascii?Q?N5pxliXtDQKOD7nlxuYM1yj+X108ULLTvjNj4lgph4U66zmd1421uVDCKN/s?=
 =?us-ascii?Q?j+CcCVYDnVibzKQGXmiFfEW+q8WLRxBPJkqS2Blb0rht7DVfHaVw3Ags+TwC?=
 =?us-ascii?Q?+EHS48VRRCpYXPkeYGhnYsbrkMRElVYHGMplsiRs3j09lL+eZOQV6YrQlt+V?=
 =?us-ascii?Q?7NIUnS0BHc4vtYEobZGwW/v2JOiDqg/Okb6u?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:37:31.8502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c8f564-1354-4673-f40b-08ddf6001e08
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB8196
X-Proofpoint-GUID: BeCIhqa2tNaIc5MqGonRtUmi_8X55L29
X-Proofpoint-ORIG-GUID: BeCIhqa2tNaIc5MqGonRtUmi_8X55L29
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE1MyBTYWx0ZWRfX/uYs5C+YO2bK
 dyM1fG/fPunkS4o6PcG6mOf1qJTA3U/6BlcKHnIZdBozbgAcDAWfFdzxkXSMSUbKC40xw7pdTM7
 YPknVs5Qnp6Sj2iBupPL/aNshXlb5VW1+9wLp5DwY+XfUMoO8Jix5E6JrGrVjWDzZ4GnT00rfUO
 JbaZbm75IxwAmzwW36CJhu1bEYJYnxLd1+ydWhJKQIaGbgrC1XAJrXNFAD3QIm40ywiQoFc450t
 ZkEP2FS+P2SBTy0Neso02NDNBOB/awud39GonGVKfJLF+NzFbjNd6T9Zsjj9+c6THLwAB7Hz649
 Oi6w3J4e3/ko4QqjxkHRlo1JrRpWbqODec2lXdnvOLQblkGVkpeivdqPLaURJc=
X-Authority-Analysis: v=2.4 cv=KvRN2XWN c=1 sm=1 tr=0 ts=68cad5c1 cx=c_pps
 a=dDkcODsWiJS6eqXBzyR3Nw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=4cEVVl_1FvM9a3rzOFQA:9
X-Proofpoint-Spam-Reason: safe

In PC systems using ACPI, the driver is able to read back an SSID from
the _SUB property. This SSID uniquely identifies the system, which
enables the driver to read the correct firmware and tuning for that
system from linux-firmware. Currently there is no way of reading this
property from device tree. Add an equivalent property in device tree
to perform the same role.

Changes since v2:
- Fixed use of PTR_ERR, using PTR_ERR_OR_ZERO instead
- Update commit message of patch 1 to explain why we need SSID property

Changes since v1:
- Fixed device tree property type

Stefan Binding (2):
  ASoC: dt-bindings: cirrus,cs35l41: Document the cirrus,subsystem-id
    property
  ASoC: cs35l41: Fallback to reading Subsystem ID property if not ACPI

 .../bindings/sound/cirrus,cs35l41.yaml        |  6 ++
 sound/soc/codecs/cs35l41.c                    | 77 +++++++++++--------
 2 files changed, 50 insertions(+), 33 deletions(-)

-- 
2.43.0



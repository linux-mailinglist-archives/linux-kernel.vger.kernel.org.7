Return-Path: <linux-kernel+bounces-854231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EB3BDDDEC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06C534F3FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AA631B804;
	Wed, 15 Oct 2025 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="YMrHkj05";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="PPZsvivm"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57F931B122;
	Wed, 15 Oct 2025 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521860; cv=fail; b=QJGxFyZseMlm/mCEaXf3knGB3xA3VMDKrzn+zJRA62nZmhctJ3X0eN/3FZrKloIRb8HeBxtsyhBQHsVK9+tEklH9SK+vJuXk2ZDOqLwXOy2h9PzIzGXTDHlPvjNycFt5ydUbYh/v0sKpB6MZ7cLcg3PaEb0z3AEbrbGD8hS41tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521860; c=relaxed/simple;
	bh=GRV5BjXm8tSPydYuTer2Spsd3uI3i84uXrXAqS1dH3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TLEE6Vk9kvcCDRQFMe1F8SiYkQ+z5u7tz73ZjbQq3OInCgDKyZyhGE4PLsBnliIL5TYKTRB1gn/xcuAONJ4l1/bZGcNr8JBvTwaqOp9p4set1Lkml8kln59dwcZBBSusIaECJRK9BK8sNn57cVLksSYMvTEccKWP98DRmD5z3ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=YMrHkj05; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=PPZsvivm; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59F9okfG1728970;
	Wed, 15 Oct 2025 04:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=eaduFgfuT1Ch4uoz
	IdppTgxQvpmFPg9Vn/cF8OUoh/Q=; b=YMrHkj05/vy7m0SYFbULXKknN3KeduvT
	EzKXD5N+ep46mIiKWW4opvS+9XdSZxMEbxLCqDJKsAesQq11XegOTzEvYNvus+/c
	6T7HD9ULDTaMRKyxcP7FAAnkqtVxtu1xMCBFTC0JBRVAp0R4uXQfbrNSO8vOFRi7
	ZqqFm6+oneHOwSr+5x4XWqoH8E2+cQoL7we5ZuFdKU3eZnhpvVvgv73JC2vKUVGl
	Gt7SOGqZOq/QtKhB7+XAC/aQhAfQcKrCef+zLKrmmizHTgnX0q+1+Io7pGv+LmK7
	DbMP6XlmRlTn1M4393Bjpymu05RnggYs5vZw/YXDKtRWx8duPuWXPQ==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020121.outbound.protection.outlook.com [52.101.85.121])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49sdb42h0j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 04:50:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lj655vsc3F2vOSkgUVHq5wXMxOt1JUQF7HWXGnspdaYsiPbU6YXaj2A0fQzgFx6P6zpRd0ONo66r3g9S/rvuG8EB173FuB2RTnCtVsPSWEAiqgj5AcMik60ELmV18oeVXx+b9WMA3VAyJJzpZX/TJMxzTzA4iqSQ/x00BHrnExIOMQ4MgAq6uvRiCvHxEvAoVUkjW3HBgEXZCCcXSrsdkcpdGDi7H+Plumvy3WS469LcgK9HFdwMQQf8V2tyey21eHOxo1tq/qKj5LNIOEBI7HYmOe6wslFaHm8tnSj0TgNyhQOW+Kx6dXXswwMK/BCys0qDK/75RHBKkhxfkddBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaduFgfuT1Ch4uozIdppTgxQvpmFPg9Vn/cF8OUoh/Q=;
 b=SJty6ahidz9rbqyJ66hC7GVlydmsJvQ1Z02puinzl9m4hbtuF6KMcrKPy1ro1hHzM9nHqyLUQ4HZbDBymw0aMO49ZshsiMD3beoB8b63PkucVnwqP0U88ginqrooR/xKaL+zTntwJGH4aWXdna2+z13niXuszO1woyvIr6oOafqIP9Db+i5hdGDv1vb9/xegmxNk+YzE+ubgMHZ1DS3hJOMbmd8WxDv+JxwY2O5Bz0HksmJXwc+CeT3sI9NsOUBkxHWWXg0VYW5uF68UI866xvNBGTdg+q3/pEsx5o7QqaSO+yUqMRcoy+Odie9qo3mDWkBa9OcXFVIQH/HeQ/2Ibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaduFgfuT1Ch4uozIdppTgxQvpmFPg9Vn/cF8OUoh/Q=;
 b=PPZsvivm06eD4Awg/SFvarOto8yEPQ5PK+2NrtZ/n1MUYM2wvvUMnFDj3T/aTPXwvvZpskiT/qo/feiy+BbDasv2JSe05DX+xfFIVUXRdXA90vistaOktr4zxBgb+qsDEJspeqZiZYHDx2fZKeQLKZ0U4wMegBJ5T9SPMjmU4Pw=
Received: from BY5PR03CA0030.namprd03.prod.outlook.com (2603:10b6:a03:1e0::40)
 by IA1PR19MB7229.namprd19.prod.outlook.com (2603:10b6:208:42e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 09:26:34 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::3d) by BY5PR03CA0030.outlook.office365.com
 (2603:10b6:a03:1e0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 09:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Wed, 15 Oct 2025 09:26:32 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 89D57406547;
	Wed, 15 Oct 2025 09:26:31 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 48C66820249;
	Wed, 15 Oct 2025 09:26:31 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH 0/8] Add support for Cirrus Logic CS530x DAC and CODEC variants.
Date: Wed, 15 Oct 2025 10:26:03 +0100
Message-ID: <20251015092619.52952-1-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|IA1PR19MB7229:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 39ab2213-105a-4035-a653-08de0bccee54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7C905JP/Lcs+j3fegJO49cBDF+FEENB/DUlA6+5fvV8/T1wOsUFL4d6UueHO?=
 =?us-ascii?Q?+D8r2vIVW0bwc4aOSI8Epl+1TAor+78IvWIuC8NlVapTHMdH4OTQzZRHoFLy?=
 =?us-ascii?Q?pTamFi+xjW8JQKRJb6HUoKyW8X/blEw/Vgi61d9Hw/ty1XrA2tWSJSc9Dlls?=
 =?us-ascii?Q?AQoWCsIH8NBRdpWH/ZJj6sDsScFfDeB6BjTfGsgsqz4eOCAY8pbjiiCzrIOk?=
 =?us-ascii?Q?qOQLjr2m4E765Ivlz40JRpplSNrdeYeYAU5YB79YUiu01qIvednQdndB22Uv?=
 =?us-ascii?Q?XuYMTdRjaaE3lOsaV3+mqvqxOi174OZXIFe3U1ieEVUKykftmBnSh2sWVh9R?=
 =?us-ascii?Q?ItrzLCPt2o+Hb5+d1Em6n9JTMjfps3ooMZr6EgIgTNjqZBXXRGm3/eCBgq4X?=
 =?us-ascii?Q?jv/G9jlDrOoc4Squwr1sdteiSvsmVzHKPDEmO6haowuet3I1WXB9vAYznA+z?=
 =?us-ascii?Q?BqEoWq3spvKuyoglmGlncFjvaGGriGl6PWkFFHy09CM8ihyn1up6X3JRCAeU?=
 =?us-ascii?Q?JYehABD5Q28K4KmvIXXweFUo2oAkSqks3ZJR5ql7jR/AtCVfM8YtmP1xXxHF?=
 =?us-ascii?Q?60aL14YnRdXA6iT9OsTOluxSta7h6mjyu/ekzHVcSoLl0Ap4i9LRrduhaMle?=
 =?us-ascii?Q?rIQwR91K4SpJymVUX1b4qHpJH/3D/lB+MadpBW9djE17QtzYKPprNyo6s+BA?=
 =?us-ascii?Q?UL5R2Et/V9qBQwTytH3xJHNTfc0vOeVu8c/V/8hNzc2VT8eEovNKHw7yIWL7?=
 =?us-ascii?Q?JhzCePQVho74gKytRcEV2h1qo7imQnXBKHITAh4PyAV79jP/MnRQ6OT92HPR?=
 =?us-ascii?Q?SuoLIsLAIZlTPtguVsOITTjLR/es9pYVsZSQumVQ7WYOi8yDqGBwTnxdRkla?=
 =?us-ascii?Q?iYcjqlIoA2XlaLxEtteIQC/yUsGAGQP8blARu7R8msxXS8TLYg8dQKgM3zIY?=
 =?us-ascii?Q?9ynfCRvevWdCrJmfHCwcmJacPYDqxTB8zJksAG6TrQlyFBB+vRIS9eY6jp0V?=
 =?us-ascii?Q?q8yQS5Q1XEoF9tiG6tkBvZtBdgFdNg/+TgtsGg320WlP2qmdmVJSnfg+TVv1?=
 =?us-ascii?Q?zf9IpD5XgmK5fh9+kxkQ9A/2/4uFMoBkPv4j+Cs5eaKYpC9B+3UX1kwh2g63?=
 =?us-ascii?Q?T4s0c3HLEm3shXqRA4IcZZmkdaCBr2WuLbba5oYe81I78vw5iGMqAvq5thYB?=
 =?us-ascii?Q?Be1A+9+TL5EtSrmc1OfA1IVwMlEH79xDue5aURtnMfQ+5eyxlZ/YfqKSWXEq?=
 =?us-ascii?Q?jiv5r4Bj4is9cizRTbuE27CcLDUbc8S9MyDrCsp3Yx+EVb9E7QR+IM5jAVCK?=
 =?us-ascii?Q?s2ChEQU+ZylBIRG8xhLutdOcicgzh66SGLzA8De+VMI0OOxyKaYA6CuvwLOU?=
 =?us-ascii?Q?PrFk9SorB8AhFxcHuH4eblLMhUp+6hgzOMWHqAaKgydVs0+rGN4wOQNQvnYc?=
 =?us-ascii?Q?pp+H+BJlBXfEm8b4e89hxommMJO6Sltv1uVHBXC1clIYcuqW+9UnuaP3QLlS?=
 =?us-ascii?Q?DcYjvygAsco5TjsekGD6LLrocWSodmvhgE0/wTdoPZKiyG0uh08YS4bkMUKV?=
 =?us-ascii?Q?PhW1TleLbhbJGjbBZEU=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(61400799027)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:26:32.9548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ab2213-105a-4035-a653-08de0bccee54
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB7229
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDA3NSBTYWx0ZWRfXz5zEgnk8JPdh
 IBoss45x9pZL31AS45kCq/+3YnXPtxM74Eti1+0upMpKwxWcdwqqrO8AIEl06WEL6mQbIqYqpmL
 +in3Xgo2BPdWgsF4AeZsswpSWn+9udt4hm367uRolX3CdHAc0N+qlu2W04wqEdpqNJpyuB3aCk/
 6+c033Pg35CiDK9XHfLCn0FL06T7nfqbyWGQ0G72RI4qQ2/GNSgyryOjrLGt6rgqWEbhL0BUWYZ
 gVf+8xbnyGNnlMDDh98rdM4w9OP1/NoIvyhYtG0JCiga3rNtcFRIPmHUrsV5jTygRNVlEMQpLnC
 wFDiP+VognlUK/Be8ByTgqYAebDl9wTKKwCgE4tn95cGjtVGNS1bVYESlyNMVrR8phjaIjvmwSi
 lR9Ejb5N2zQwm+rjqTY9FR2g0tlAmQ==
X-Proofpoint-GUID: yL58l5vuMld6ej5gGRj8B7JO7eI2sVv_
X-Authority-Analysis: v=2.4 cv=PPICOPqC c=1 sm=1 tr=0 ts=68ef6e79 cx=c_pps
 a=Yi5XoY1Pvk1/bV4Hj+lk7Q==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zHkYD0J2MZFfKBFm4vQA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: yL58l5vuMld6ej5gGRj8B7JO7eI2sVv_
X-Proofpoint-Spam-Reason: safe

This patch series introduces DAC, CODEC, and SPI control bus support
for Cirrus Logic CS530x variants, along with general code cleanup
and resolution of checkpatch.pl warnings.

Simon Trimmer (5):
  ASoC: cs530x: Correct log message with expected variable
  ASoC: cs530x: Tidy up driver before adding more features
  ASoC: cs530x: Add CODEC and DAC support
  ASoC: cs530x: Check the DEVID matches the devtype
  ASoC: cs530x: Rename i2c related structures

Vitaly Rodionov (3):
  ASoC: cs530x: Correct MCLK reference frequency values
  ASoC: cs530x: Add SPI bus support for cs530x parts
  ASoC: cs530x: Add DT compartible strings

 .../bindings/sound/cirrus,cs530x.yaml         |   4 +
 sound/soc/codecs/Kconfig                      |  10 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/cs530x-i2c.c                 |  24 +-
 sound/soc/codecs/cs530x-spi.c                 |  92 ++++
 sound/soc/codecs/cs530x.c                     | 516 +++++++++++++++---
 sound/soc/codecs/cs530x.h                     | 120 ++--
 sound/soc/codecs/cs53l30.c                    |   4 +-
 8 files changed, 636 insertions(+), 136 deletions(-)
 create mode 100644 sound/soc/codecs/cs530x-spi.c

-- 
2.43.0



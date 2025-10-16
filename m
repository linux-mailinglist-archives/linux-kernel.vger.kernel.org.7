Return-Path: <linux-kernel+bounces-856671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D933EBE4C34
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED3419A107A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C93B328B4E;
	Thu, 16 Oct 2025 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="SYnA7Vnk";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="ipocm9SX"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A34D34F471;
	Thu, 16 Oct 2025 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633945; cv=fail; b=ZOokTb+DnSP9FKiUb7B1/4mFQOvbevyYbR0eWqQ5LdbPe9W4FO/i4pwtPaESyLwhkH6zkS1s/Op/xoodYL1PBfHXBkpEryGo1F0FXXWh4RIMnPIrRWqTbZQ1hOfv1swVZ3YStUfiZ0D3h2za6IaeSx97BxXTB4GsZZW6IG5jNCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633945; c=relaxed/simple;
	bh=1ANTmL9Dzr1ltazyDMjuUj7dhUM8504xc568euwrtNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=brivAgn3+LZzv+CoE7FjJIiqnBkjxDWarIXcr695AjlzgMAzOOU9xy9oClcXSIfcTHTECHEzICslwCpLDJGcenh5/0ArPBDLkaDv1R+WNN7Sd2eyZ+yoohfIS1Ip1tYMFp6d7ppp0gcYgIDyLej8cLR6AaxQtExXIZInFchq/T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=SYnA7Vnk; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=ipocm9SX; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GGnUL7298651;
	Thu, 16 Oct 2025 11:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=2KRV0L/C/rKGnc19
	cYi3MCMsMI1VpaGV3CXQo6ZLk+Q=; b=SYnA7Vnk+F7n+UHYRL84BKPWRXy9nFHG
	YuhsOrIbjkVZMTztJGv4qRLWBLupVRJSnMScMHv4D15bd/YUUtKCYjlNodO8O7hk
	EPixXyKyxQxNUzP7rgWu6ZMn9gzuiydUqxlGuCQudndY/+FZf3HaGBT9Rjuzxf8x
	tDjvmJMCGDowbhR9WDySXNn4ZvlKdQWuvwI+vM8rIJWBYOpZiwpqSkwgar+LGrbC
	BP9fkFeKIj1LxXJM7UkpzdpKoYok5VifZQ5osrmv1GVa9p3L6ysTBGTEodNTv3Op
	f94dPtgbDZGG/BoIjuAtpvqXF563kdGnZTu3+dDMkfDVANx7BXQArQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021134.outbound.protection.outlook.com [52.101.62.134])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhj9h2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:58:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFu/QTH4cpl6qtr9jxQxSF9JeJXpDmbvnznuHqtk/dESvJScCmo1Gj01HYF1Kn6io2NJ7CRwOLFiSvaw3+KsWOFjKd1VOowQz9TsoQ2x2shoWEkGhIi34EvytsWzNu1gt9TCdVBinP8PDBHxAG2oh02l7NEzhqLqGOUtgwpm9JZQOncEpD6fEtlHaHoxG+GXfDHZwFdqw0UwZg0hrV681YM2PzjyM3RUR5G5Zde4cJaTQmHoy6Muwvnfq5ZsNxBfn4Gd5mRPMqFkn7F3/A6ZOPyIkJ9RBtG9AmIPx43F2o1M5mMtD1B2Y5sbDyX6QCd1lYsVKQW+sfqb4WL5mnQsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KRV0L/C/rKGnc19cYi3MCMsMI1VpaGV3CXQo6ZLk+Q=;
 b=FKz6gyk2DO1DkWxQllSKCbpgEr+DeFySz0jW5Otoc2gNTiXJCrmAhg+++QrH2SqpcAbbCvHxDfp8+rVzaiGgJUconr5fGNoCp5ZMOirNwG9WK3eXYm1mZdI3QJvwRjwAv1bC/+p1HuYhtNsBrPBywlze8Ub2t4miNwLk6SHIkrR4XpYM3AajXNgbh5e64HP6+5jN6RwQxeY9UZAk9cktUc07V+fqC/N/3SEcmSUW55tleD7e7EzurzAs+miUZ/08jrnu3FcW0fjX0x6Q0u/EwdAg4u4f5IdX8bNtfHF2jzqHHmst8qgvf4/CQXGEbymSAkQr2rjWI6fuj4qTy78iZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KRV0L/C/rKGnc19cYi3MCMsMI1VpaGV3CXQo6ZLk+Q=;
 b=ipocm9SXNDM6dtP50HWKzSB1dQCW+awQVOKA3kPlTUXQxoKhk16rk6buFz3tmuQxs8DcUGgAvSnF4BhYWp+X6uxXaXc9vHL9BuiXfQkObmGrySbv+D9bgXcBdnDE+Gcg7rzt2HYVVKwumakH7Z4N8O8RWDWY5PA9lpxIe4XVGAA=
Received: from MW4PR03CA0320.namprd03.prod.outlook.com (2603:10b6:303:dd::25)
 by CY5PR19MB6518.namprd19.prod.outlook.com (2603:10b6:930:36::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 16:58:48 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::c3) by MW4PR03CA0320.outlook.office365.com
 (2603:10b6:303:dd::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Thu,
 16 Oct 2025 16:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:58:46 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id B33D9406547;
	Thu, 16 Oct 2025 16:58:44 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 51A43820244;
	Thu, 16 Oct 2025 16:58:44 +0000 (UTC)
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
Subject: [PATCH v3 00/11] Add support for Cirrus Logic CS530x DAC and CODEC variants.
Date: Thu, 16 Oct 2025 17:58:11 +0100
Message-ID: <20251016165835.143832-1-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|CY5PR19MB6518:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 564c5e24-056e-486d-a148-08de0cd545ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ANCPNs0QbtWVclNj+rFnUy+VjpknXkvTe9EkJg1gIWgUYb+G6aoqbwOpLLTM?=
 =?us-ascii?Q?JbBFs9lQwP75GZ9Xb+OG/BEl1oIH+UUPT5rUPXcc0CYnqmQ3lsrvyZNvh3XH?=
 =?us-ascii?Q?V/SoPbwQ1bN5uvf4DCfUhGLRYO0acB7QAoNM5wtiw3gth51IyHaSMhWBzZnE?=
 =?us-ascii?Q?xxlJn7jnecpYHCOrtH/NZJM3KQJcjoUafvSAlokvYNYqYjfGjXb+/hBMjW8t?=
 =?us-ascii?Q?gEjErS2+7X8FQHxpkG7Vw3Ztn/2H7mja/7e2duCHRq2hqPyvznq7YFcAQKMT?=
 =?us-ascii?Q?OS4xtlhyxeNlXbn4m9E2sLycXOwgyskW31v3qy6RycvN/hwvcK5PAXWY+lJN?=
 =?us-ascii?Q?lEO+d4QFRQUkseldWLF+wuBxh3KPFJnz+u1Yo2eozGUDH0pG5qoxXxgSiBjS?=
 =?us-ascii?Q?S0p/cyDHGAGCP5B4suF26nJeGcfj5ljZwJTkvFQ8vbBmJO5TY+Sn6LaxfZ5P?=
 =?us-ascii?Q?2lRzXO1xY+X3TV570qvsHzSXn+YLVued1xgzjW+jupeMcp1suZx724LNrDbt?=
 =?us-ascii?Q?9gdwIFlpywD5fgx8ybhJyALQ4bFQ0bGmCXFrONuW57BUaggwCRuK5IiIsDQt?=
 =?us-ascii?Q?C1j8A88/A1Pd2NS8uaxhnrKgLc0CAjBUllNHSLOWh7jAA2uTz0GZAaS8egZP?=
 =?us-ascii?Q?mcZuaiTFI+cwMu4qlpzYbbQ3l2fSIcn0D7bS9SJecLfDu2lsS7dBTplwnFNj?=
 =?us-ascii?Q?oeLv5pnX06ELBkNaS09VNFjnYH7a+RT87wDisOqvcEAmSpb0JWyFSzpZBdKS?=
 =?us-ascii?Q?QXCnVF4vPQyV6S/FeNt3vtqUg/U8V5OLONvD8PIruUs9alDv8nazsKY90lns?=
 =?us-ascii?Q?ceUDnfjLFYf4znplxtfCJQZaKfGz2buBuCzJFjFP1lD7SwxRIWkEVeOzRVQI?=
 =?us-ascii?Q?9242kUwBwvimnVwv+ZQdBVvqWFVohtrUxjSfwQKBBOmoPkcviiG24OUFAfcx?=
 =?us-ascii?Q?VBzSclaHOKzWwLwj+3gDkhQXptRyDJ8eqviPC+UB5jhRDuNvjee6hxTQEvoa?=
 =?us-ascii?Q?rqvNEiZwR6E/qhwgtt5dtoO2uiVAHp8LtDOfLeM+5J7cqamVsZI4NM5Pbwsv?=
 =?us-ascii?Q?BpgA5FrAq7Rj7Y8g3eWEXL6rvbP55SsEzPfPqmrf9WMoePqMqUumXAW1YwBW?=
 =?us-ascii?Q?s7POe5K0zMyHNxWI/8p9j7pZCZ2DE5O9vKnxpllif79WOUmzQ14XCF0IbwwG?=
 =?us-ascii?Q?lKLViCc06lTvia8v2GaJcrk1S81hswOVyWZuaw+QUaBs8Z/c9gz7lDwrx4nj?=
 =?us-ascii?Q?2UiOsKsALGig6DFI6fbj+9lfmqZT+ZR+RfQQv7WBl+Bzwr0jGl56vqo0DB7y?=
 =?us-ascii?Q?pUC6g6TgxBcnE2bWB98/2jlfz8egevDssEmPXmt1Gj/eZ6zchtKR1TSJBBGg?=
 =?us-ascii?Q?Mhy0VjEcrcIz/XXU6VKjKBjv6I86vwsOiLGtw6p4Hv0oj7ycetdz2v9N3+fl?=
 =?us-ascii?Q?p7qcdGpiKkdHsEVGSVO76MmMhtj5ZfCU3Os34b4EdKfJGdXg+QIn31Tzfxs+?=
 =?us-ascii?Q?YCpnMfpAV2DHQdSP6Hr7tCxOpDqf7U4y1b/CgPTX9P8u+6YkLMIof+euvIcL?=
 =?us-ascii?Q?cLqeCnrawHiV0QJoC+0=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:58:46.6404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 564c5e24-056e-486d-a148-08de0cd545ad
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6518
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMyBTYWx0ZWRfXxtvGvkNUkNMF
 DH2QewEgIjMPItsCdLtarE/4ecVvrMVFpGMztqHb/6xXLlZkGri01xl9ouqmvSVsGUm9J34JTvC
 7xFo0gomxzM1H286Z8d0z+YfuTjfEnS0gWBTczq4RvoV0qDkBH6kFq/ReMYq2Ztt9Wun1Lq/Nlb
 1xHFCTyP2uhsy7IWfsz2qZUop7nH9P/Ch7ttdeQzgfkGwS6YxYRnor9cziNt6+bcsWGHAKIs+Ez
 l2Ns4tx6xO3ObiN8ptGi1TdnBDC/uU5pvEPIYzHaVjEEQu+XT6/FWlU/06JYN2L/v614c+NC+fa
 DhAh5pZ357Yf/i86kedJEt5Dq/51SC1SKHslAMJMPlzYnh70kuIdKuegKGHIVsJsbqSZtu/0xdR
 x8/kxUxXZDY8oxTn0JP3R/dmGEpW7w==
X-Proofpoint-ORIG-GUID: 6ANAHVgTpOsch6H4gIaGrnTkuQsnQigX
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f1244e cx=c_pps
 a=/XbX8ElQ4hGN2tIQCGLJ9Q==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=hDw_Ibh-1Z5AH1WijLsA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 6ANAHVgTpOsch6H4gIaGrnTkuQsnQigX
X-Proofpoint-Spam-Reason: safe

This patch series introduces DAC, CODEC, and SPI control bus support
for Cirrus Logic CS530x variants, along with general code cleanup
and resolution of checkpatch.pl warnings.

Simon Trimmer (4):
  ASoC: cs530x: Correct log message with expected variable
  ASoC: cs530x: Add CODEC and DAC support
  ASoC: cs530x: Check the DEVID matches the devtype
  ASoC: cs530x: Rename i2c related structures

Vitaly Rodionov (7):
  ASoC: cs530x: Update the copyright headers
  ASoC: cs530x: Sort #include directives and tidy up whitespaces
  ASoC: cs530x: Remove unused struct members and constants
  ASoC: cs530x: Correct constant naming
  ASoC: cs530x: Correct MCLK reference frequency values
  ASoC: cs530x: Add SPI bus support for cs530x parts
  dt-bindings: sound: cirrus: cs530x: Add additional cs530x family
    variants

 .../bindings/sound/cirrus,cs530x.yaml         |   4 +
 sound/soc/codecs/Kconfig                      |  10 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/cs530x-i2c.c                 |  24 +-
 sound/soc/codecs/cs530x-spi.c                 |  92 ++++
 sound/soc/codecs/cs530x.c                     | 516 +++++++++++++++---
 sound/soc/codecs/cs530x.h                     | 120 ++--
 7 files changed, 634 insertions(+), 134 deletions(-)
 create mode 100644 sound/soc/codecs/cs530x-spi.c

-- 
2.43.0



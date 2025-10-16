Return-Path: <linux-kernel+bounces-856647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A60BE4AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E4BA4FB299
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EA136996E;
	Thu, 16 Oct 2025 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="evKMVWze";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="S81uM4NY"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B9332AAD0;
	Thu, 16 Oct 2025 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633360; cv=fail; b=Q8NKrxellY73njTD0OHETlpkn/C0tH3vXWZzv5nhkJKw144Y9Ebqzu9yuWOge5yZihr2UShRYqdNGAAL02BUg1jVFdyiXQZpW3Z2Uq8kUEeZksgnc57cwRyqIcs68PNYmtQYZoZwY1ckfNlKpM5WeAYMQK8YE+QFmw64Ri5UCWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633360; c=relaxed/simple;
	bh=l3pNCkiyUnZ5x3phrGFoF0xPvY5RlCLV2Ijfy53Y2Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QF+cymyoeMT+RKctBFarKSqd6aZQzM/931C67limo5jYsvEeb1A0y6pktBpsYQ4i4E9ZOaqKrpna+sIKekjjL8S7eWE3ybQUbH7+ngJ5kFxmx1ZJLXvZ1382+FXyxdteV1uuYnhFoW/EixnFA3wa8RDvptIemYp8M9yGElkhBlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=evKMVWze; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=S81uM4NY; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GDTFSr4017904;
	Thu, 16 Oct 2025 11:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=StCWOFfXiWO6C333jKx4E39X0RNxaz7WpvtB3gaR6Ks=; b=
	evKMVWzezENiM7PU1OhQrJ8fL4wYHSeHmsVbTnVLczoermYYDqURoH05IWiNTAr9
	JaW5QGaHZjDfygeWj7wYukXD+dTqezBS+5PreTUsbHquFmn5FweLUQFeDqC4dF8j
	yTF1SfPm543hRBkwERli8ycUi1wFTIbs8Sszgc0UHSw++NuEouAoxHUB+/qKtDyo
	fJiqtv2j8bsJWL1Fd4T/D/yiZ9ECoW3jeYVl5JL8EFC/sYTCdo1tVGLVjrXiZksL
	eF7Pd2Itr/NbgqeZzjTUhWtOVYAsgPHXIGsB25/2RejWbFSfnJ1ZBOAvgUpHs5p/
	iaQsR9fSY9KM/VuxYoEWgA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020129.outbound.protection.outlook.com [52.101.193.129])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mngajy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:49:06 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9TmmPn1hsamvGzAv8UNX1FE07spLxWEJJN/JzWsLgCxPXLPT78TcqGL0UmvhoxYQyEpeWMrQkV3Ee9w9OwwzuMnIT/FsBnCjtd5iBx1nEIYmD88f6kNq+a8EsmA5o4UZ1qWeD9FciWyM14IKE2HgCNg6dlB8ZpuPbijlvTSX0SAZvckOd2BxOwxiqQaTmKdyva89UITY55Xe+d5aqUt4LM9pB/32d7NvXbvZhEWW1+GX3yEdAbexBwYjst8ksDqptnrgAnZaVxgP5u6Vyfl/A/0Qb4TTo0qfHdg1L7WZpFNFrj3KG7cFciql2u7rr5CCICaRZ19W0DCwXOte/6wjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StCWOFfXiWO6C333jKx4E39X0RNxaz7WpvtB3gaR6Ks=;
 b=i9tUMK4Mjh5u8kAmQxtUdi8cr1XYiOQGlsv9XDa3TEqquKx2XqeNXVozMRgJkRc1EoS2gxdtj2JbFREP0K4IbjzD0ORO839CeArdFbE66JqPjluCibDexNJH3I3alw3EkFsr5zvmHXY2fBnJJG8DrXQI1e0fjUSb0EJA2m1lTPbPK7irslqZCJ6jUnF1qPyusllvUYyjY723XuGOjcTXfi+t7gguI9+5nb5a2FGDrkLamdmHmJWGjJUF0w/0d/LIfeMKbLWtGAg5E4X1eX9kFO+irCIW0IEB4aWO7C3kPTiNEc0NiKOoDLl4TScw68jTAyj+/nr+5Xus7cdsqHdGUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StCWOFfXiWO6C333jKx4E39X0RNxaz7WpvtB3gaR6Ks=;
 b=S81uM4NY9R4kPiLzSTMTr8aFRd8Vo/0ynrTKkNlTZ54r98ZWOHXep6j4zrhr+x2bIz0EgJJTvcPh7c6LC/DGUnAL8PGVIpgOlkqMkvHCaP3/Fza7DDGvGffE0bynniepmaGmct9+bn4lbTYaV3vCWbS1RYnoyS/Dql2CTxKk2zE=
Received: from CH2PR18CA0033.namprd18.prod.outlook.com (2603:10b6:610:55::13)
 by LV0PR19MB9286.namprd19.prod.outlook.com (2603:10b6:408:327::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 16:49:04 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::9f) by CH2PR18CA0033.outlook.office365.com
 (2603:10b6:610:55::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 16:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:49:02 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id CAC65406559;
	Thu, 16 Oct 2025 16:49:00 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 6ADD7820249;
	Thu, 16 Oct 2025 16:49:00 +0000 (UTC)
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
        Simon Trimmer <simont@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v2 06/11] ASoC: cs530x: Add CODEC and DAC support
Date: Thu, 16 Oct 2025 17:48:24 +0100
Message-ID: <20251016164847.138826-7-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016164847.138826-1-vitalyr@opensource.cirrus.com>
References: <20251016164847.138826-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|LV0PR19MB9286:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8fa2e99d-88b4-40da-ad99-08de0cd3e942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7jMQBTQiCtpBkO7pjgk9DkR5kWPh7rjZKBqaMPW0YPTqHX5BCrkrtOpSFZkT?=
 =?us-ascii?Q?eOzswlNFOCMTsXIz2fLtKIZGSRrgXHbDgdUmNk3VN7mV+5/gv8h7MZUQnqDA?=
 =?us-ascii?Q?3F11RiYGgJ9mAjyjR4AtpIsT4U98aGUgQGuQc6SZoIV1gmrF/7huaoYgi8Ls?=
 =?us-ascii?Q?ZPdofa/acoyyVfeATA2LNe2o0urLXBQhrkEeWRF+B5+1umA6Uxl9dupeCT7M?=
 =?us-ascii?Q?IFlzfN4eQ/jk95PAXgkdicVJT0Htg/ZuU9x/CVOwRy/GFZtSVIO/13Ytqbps?=
 =?us-ascii?Q?nHdfXbM0+XZxOOj+ZK0Ky1iWYZcbU+4NDHsWEHrRqPledIjX37p+NzcxuBCW?=
 =?us-ascii?Q?UgI4EIdOyFl+gDIeW4JnqK2TeoE6YP5TGS86mC0PUDB2kk1+v/nhtEXKsDF6?=
 =?us-ascii?Q?k6OdnYer5UULyekVkwQDAY5bzwS9dnSP0Xa9fxban/WUF/FbxILlJOk/faLd?=
 =?us-ascii?Q?GPfHEiIiKIAMIGw8Tl1KdxtgN/2gwoIGiEDWDmgivt8obEvcZ6wE/b2vZZsZ?=
 =?us-ascii?Q?qHU7jlwKTaUhTQOmmQfz5ub7D6wI+NvCJf5s0Bjis7fTAGa1NngsgwVX+XOz?=
 =?us-ascii?Q?9t6J6LJsxj0fQwhd5C98eENFDxNLxJdawhBmrhnuxwPxuJ1eRdFK5f/pmrEN?=
 =?us-ascii?Q?pVrLIL2SX4izy4AboRk6oHOFlX1LcUN/oa6x4qWrMbzX1neiiedsSXhOwTf/?=
 =?us-ascii?Q?RF7lfeJMHyAAfKxuXsqlNWsb1PY3KFvoXR1mYwyJ8fv8nvpXJarvWPi5kmzE?=
 =?us-ascii?Q?GSrac16MTNxw1m4ni0aS33u677B0h0Nj6zbXIyicRI7cqjyme/c2nUi9r5ZL?=
 =?us-ascii?Q?Yo6zmDx7Z5eoaUuT/2W084c6dz3DtarbFxMSriEvWZIdWdAQb4q9YPJj89Li?=
 =?us-ascii?Q?ZThAUpAD/qvlcHSiafHol0qyit4nOm0ItC4LzNGHfMXHc080nn5Xl3shGpAT?=
 =?us-ascii?Q?R1vnp8T+RU4p1AsWWk2d4OG7P0la/oTISREHVnl0cDU6D09/pUdglSjBjPSP?=
 =?us-ascii?Q?X2+mPnTod7nwQsO11eqpDiLEdtA/rt/PfeAjIZb+WbGrrVfWDX1Pv2ea3+OD?=
 =?us-ascii?Q?OPfVRKeQsRB+t7U5GSpbdKwXP3TYz4UeTLbEudINbARjB9TSYKN5HACU+1ZU?=
 =?us-ascii?Q?V5nGdc1t6g/pENMnmAVyiku+KkN9eSqJrLGgXi7e0v6Q1NLbhLOUwQt6Jb37?=
 =?us-ascii?Q?sM1B5wVos5rKF+lsjOp1Qp/QZUfKwjhcYS2QIRHlXj1E7salyXNdv1mNruFf?=
 =?us-ascii?Q?2kzyCISfxbGyzpf1seZGPzZpvzNHop6uEzykL1ov1PJgtjseOz9XOCJHP0N0?=
 =?us-ascii?Q?6LKHI+xsoW4kX9KTIRH8sqj6XjuxvcqPpNs1xWjrJxpqhma8fzaVydqK5eHG?=
 =?us-ascii?Q?lFVJJYnpmsDQQy/+QgDXteUqU6eybHQMGNLlfYhanxVVSdT7cCtU6VrcCVP0?=
 =?us-ascii?Q?8ttnXSLJL9AnsdE1GU2QGeNvmj2TYyFjjHFlH5J+huagqkDSjkNu/1WTOXZH?=
 =?us-ascii?Q?BS2EfpOLCJX27DkRYNLMqNL0cQex5CXB8UclkMMREpbMh3yumgjSl8YptIsT?=
 =?us-ascii?Q?aWGLR371M3PC/uthWF4=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:49:02.1904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa2e99d-88b4-40da-ad99-08de0cd3e942
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR19MB9286
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f12202 cx=c_pps
 a=2JLEL+eSUXzWNUMlkDf0GQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=L8ub6Hg6ihGcwRW8v1IA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: LG23FCxTFfc5JEg2wQ1o3xfvJXPIXJ-x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMSBTYWx0ZWRfXyaPysCZ7sr59
 ZGEiuzKBeHAjm4DMuKA7a1GuWqv+wzUMTS/y2h2Ux2M8WB5dYrHL1MPAUAHvkkmNB2MxXEKVPLZ
 Gh441FqAkuhFk4Rf/6nlh1T9v1JAUalZs/kraCyohZmfOHsgEvguCb51cU+Tp8ojPqWeqFDJR/I
 2cBxaZVCBg65WyTNeGktc4xbnOJXXcXUSLcTIIEqZ0f7wN/rmYmyR2SupljpTuOfFpXiGVjm6Wm
 c1aCsRFJ/ntHxWOM88yBo6xUwONAlFf2hms0BkGR81E4WvLWpIbP47vSyQaGsLPjNBgpBtXXlkY
 qMfRf3eIXnaEWb9k3kx3klOguUl7Ml8U4iDEHX9QATjB6hace0HogkGH7q1j3z0C9tg7XFVexfS
 EHROIKIq8iWlBJJQMKJe/yYdGkq4TA==
X-Proofpoint-GUID: LG23FCxTFfc5JEg2wQ1o3xfvJXPIXJ-x
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

- Added DAC register address constants
- Add the new registers to the regmap config
- Renamed constants that are shared between the DACs and ADCs
- Add the device IDs and device names of the CODEC and DACs along with
  their different capabilities
- Add DAPM widgets, ALSA controls and event handling for the DAC
  functionality
- Add Playback DAI support

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x-i2c.c |  16 ++
 sound/soc/codecs/cs530x.c     | 413 +++++++++++++++++++++++++++++++---
 sound/soc/codecs/cs530x.h     |  60 +++--
 3 files changed, 441 insertions(+), 48 deletions(-)

diff --git a/sound/soc/codecs/cs530x-i2c.c b/sound/soc/codecs/cs530x-i2c.c
index d6b7883ba7b9..ab410826f777 100644
--- a/sound/soc/codecs/cs530x-i2c.c
+++ b/sound/soc/codecs/cs530x-i2c.c
@@ -14,6 +14,18 @@
 
 static const struct of_device_id cs530x_of_match[] = {
 	{
+		.compatible = "cirrus,cs4282",
+		.data = (void *)CS4282,
+	}, {
+		.compatible = "cirrus,cs4302",
+		.data = (void *)CS4302,
+	}, {
+		.compatible = "cirrus,cs4304",
+		.data = (void *)CS4304,
+	}, {
+		.compatible = "cirrus,cs4308",
+		.data = (void *)CS4308,
+	}, {
 		.compatible = "cirrus,cs5302",
 		.data = (void *)CS5302,
 	}, {
@@ -28,6 +40,10 @@ static const struct of_device_id cs530x_of_match[] = {
 MODULE_DEVICE_TABLE(of, cs530x_of_match);
 
 static const struct i2c_device_id cs530x_i2c_id[] = {
+	{ "cs4282", CS4282 },
+	{ "cs4302", CS4302 },
+	{ "cs4304", CS4304 },
+	{ "cs4308", CS4308 },
 	{ "cs5302", CS5302 },
 	{ "cs5304", CS5304 },
 	{ "cs5308", CS5308 },
diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 336ed5f225ea..25dbf401b15d 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -45,6 +45,18 @@ static const struct reg_default cs530x_reg_defaults[] = {
 	{ CS530X_IN_VOL_CTRL3_1, 0x8000 },
 	{ CS530X_IN_VOL_CTRL4_0, 0x8000 },
 	{ CS530X_IN_VOL_CTRL4_1, 0x8000 },
+	{ CS530X_OUT_ENABLES, 0 },
+	{ CS530X_OUT_RAMP_SUM, 0x0022 },
+	{ CS530X_OUT_FILTER, 0 },
+	{ CS530X_OUT_INV, 0 },
+	{ CS530X_OUT_VOL_CTRL1_0, 0x8000 },
+	{ CS530X_OUT_VOL_CTRL1_1, 0x8000 },
+	{ CS530X_OUT_VOL_CTRL2_0, 0x8000 },
+	{ CS530X_OUT_VOL_CTRL2_1, 0x8000 },
+	{ CS530X_OUT_VOL_CTRL3_0, 0x8000 },
+	{ CS530X_OUT_VOL_CTRL3_1, 0x8000 },
+	{ CS530X_OUT_VOL_CTRL4_0, 0x8000 },
+	{ CS530X_OUT_VOL_CTRL4_1, 0x8000 },
 	{ CS530X_PAD_FN, 0 },
 	{ CS530X_PAD_LVL, 0 },
 };
@@ -70,6 +82,19 @@ static bool cs530x_read_and_write_regs(unsigned int reg)
 	case CS530X_IN_VOL_CTRL3_1:
 	case CS530X_IN_VOL_CTRL4_0:
 	case CS530X_IN_VOL_CTRL4_1:
+	case CS530X_OUT_ENABLES:
+	case CS530X_OUT_RAMP_SUM:
+	case CS530X_OUT_DEEMPH:
+	case CS530X_OUT_FILTER:
+	case CS530X_OUT_INV:
+	case CS530X_OUT_VOL_CTRL1_0:
+	case CS530X_OUT_VOL_CTRL1_1:
+	case CS530X_OUT_VOL_CTRL2_0:
+	case CS530X_OUT_VOL_CTRL2_1:
+	case CS530X_OUT_VOL_CTRL3_0:
+	case CS530X_OUT_VOL_CTRL3_1:
+	case CS530X_OUT_VOL_CTRL4_0:
+	case CS530X_OUT_VOL_CTRL4_1:
 	case CS530X_PAD_FN:
 	case CS530X_PAD_LVL:
 		return true;
@@ -94,6 +119,7 @@ static bool cs530x_writeable_register(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case CS530X_SW_RESET:
 	case CS530X_IN_VOL_CTRL5:
+	case CS530X_OUT_VOL_CTRL5:
 		return true;
 	default:
 		return cs530x_read_and_write_regs(reg);
@@ -116,7 +142,7 @@ static int cs530x_put_volsw_vu(struct snd_kcontrol *kcontrol,
 		goto volsw_err;
 
 	/* Write IN_VU bit for the volume change to take effect */
-	regmap_write(regmap, CS530X_IN_VOL_CTRL5, CS530X_IN_VU);
+	regmap_write(regmap, CS530X_IN_VOL_CTRL5, CS530X_INOUT_VU);
 
 volsw_err:
 	snd_soc_dapm_mutex_unlock(dapm);
@@ -126,7 +152,7 @@ static int cs530x_put_volsw_vu(struct snd_kcontrol *kcontrol,
 
 static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -1270, 50, 0);
 
-static const char * const cs530x_in_filter_text[] = {
+static const char * const cs530x_inout_filter_text[] = {
 	"Min Phase Slow Roll-off",
 	"Min Phase Fast Roll-off",
 	"Linear Phase Slow Roll-off",
@@ -134,24 +160,36 @@ static const char * const cs530x_in_filter_text[] = {
 };
 
 static SOC_ENUM_SINGLE_DECL(cs530x_in_filter_enum, CS530X_IN_FILTER,
-			    CS530X_IN_FILTER_SHIFT,
-			    cs530x_in_filter_text);
+			    CS530X_INOUT_FILTER_SHIFT,
+			    cs530x_inout_filter_text);
 
-static const char * const cs530x_in_4ch_sum_text[] = {
+static SOC_ENUM_SINGLE_DECL(cs530x_out_filter_enum, CS530X_OUT_FILTER,
+			    CS530X_INOUT_FILTER_SHIFT,
+			    cs530x_inout_filter_text);
+
+static const char * const cs530x_4ch_sum_text[] = {
 	"None",
 	"Groups of 2",
 	"Groups of 4",
 };
 
 static SOC_ENUM_SINGLE_DECL(cs530x_in_sum_ch4_enum, CS530X_IN_RAMP_SUM,
-			    CS530X_IN_SUM_MODE_SHIFT,
-			    cs530x_in_4ch_sum_text);
+			    CS530X_INOUT_SUM_MODE_SHIFT,
+			    cs530x_4ch_sum_text);
 
 static const struct snd_kcontrol_new cs530x_in_sum_4ch_controls[] = {
 SOC_ENUM("IN Sum Select", cs530x_in_sum_ch4_enum),
 };
 
-static const char * const cs530x_in_8ch_sum_text[] = {
+static SOC_ENUM_SINGLE_DECL(cs530x_out_sum_ch4_enum, CS530X_OUT_RAMP_SUM,
+			    CS530X_INOUT_SUM_MODE_SHIFT,
+			    cs530x_4ch_sum_text);
+
+static const struct snd_kcontrol_new cs530x_out_sum_4ch_controls[] = {
+SOC_ENUM("OUT Sum Select", cs530x_out_sum_ch4_enum),
+};
+
+static const char * const cs530x_8ch_sum_text[] = {
 	"None",
 	"Groups of 2",
 	"Groups of 4",
@@ -159,13 +197,20 @@ static const char * const cs530x_in_8ch_sum_text[] = {
 };
 
 static SOC_ENUM_SINGLE_DECL(cs530x_in_sum_ch8_enum, CS530X_IN_RAMP_SUM,
-			    CS530X_IN_SUM_MODE_SHIFT,
-			    cs530x_in_8ch_sum_text);
+			    CS530X_INOUT_SUM_MODE_SHIFT,
+			    cs530x_8ch_sum_text);
 
 static const struct snd_kcontrol_new cs530x_in_sum_8ch_controls[] = {
 SOC_ENUM("IN Sum Select", cs530x_in_sum_ch8_enum),
 };
 
+static SOC_ENUM_SINGLE_DECL(cs530x_out_sum_ch8_enum, CS530X_OUT_RAMP_SUM,
+			    CS530X_INOUT_SUM_MODE_SHIFT,
+			    cs530x_8ch_sum_text);
+
+static const struct snd_kcontrol_new cs530x_out_sum_8ch_controls[] = {
+SOC_ENUM("OUT Sum Select", cs530x_out_sum_ch8_enum),
+};
 
 static const char * const cs530x_vol_ramp_text[] = {
 	"0ms/6dB", "0.5ms/6dB", "1ms/6dB", "2ms/6dB", "4ms/6dB", "8ms/6dB",
@@ -190,8 +235,8 @@ SOC_ENUM("IN DEC Filter Select", cs530x_in_filter_enum),
 SOC_ENUM("Input Ramp Up", cs530x_ramp_inc_enum),
 SOC_ENUM("Input Ramp Down", cs530x_ramp_dec_enum),
 
-SOC_SINGLE("ADC1 Invert Switch", CS530X_IN_INV, CS530X_IN1_INV_SHIFT, 1, 0),
-SOC_SINGLE("ADC2 Invert Switch", CS530X_IN_INV, CS530X_IN2_INV_SHIFT, 1, 0),
+SOC_SINGLE("ADC1 Invert Switch", CS530X_IN_INV, CS530X_INOUT1_INV_SHIFT, 1, 0),
+SOC_SINGLE("ADC2 Invert Switch", CS530X_IN_INV, CS530X_INOUT2_INV_SHIFT, 1, 0),
 };
 
 static const struct snd_kcontrol_new cs530x_in_3_to_4_controls[] = {
@@ -200,8 +245,8 @@ SOC_SINGLE_EXT_TLV("IN3 Volume", CS530X_IN_VOL_CTRL2_0, 0, 255, 1,
 SOC_SINGLE_EXT_TLV("IN4 Volume", CS530X_IN_VOL_CTRL2_1, 0, 255, 1,
 		    snd_soc_get_volsw, cs530x_put_volsw_vu, in_vol_tlv),
 
-SOC_SINGLE("ADC3 Invert Switch", CS530X_IN_INV, CS530X_IN3_INV_SHIFT, 1, 0),
-SOC_SINGLE("ADC4 Invert Switch", CS530X_IN_INV, CS530X_IN4_INV_SHIFT, 1, 0),
+SOC_SINGLE("ADC3 Invert Switch", CS530X_IN_INV, CS530X_INOUT3_INV_SHIFT, 1, 0),
+SOC_SINGLE("ADC4 Invert Switch", CS530X_IN_INV, CS530X_INOUT4_INV_SHIFT, 1, 0),
 };
 
 static const struct snd_kcontrol_new cs530x_in_5_to_8_controls[] = {
@@ -214,10 +259,10 @@ SOC_SINGLE_EXT_TLV("IN7 Volume", CS530X_IN_VOL_CTRL4_0, 0, 255, 1,
 SOC_SINGLE_EXT_TLV("IN8 Volume", CS530X_IN_VOL_CTRL4_1, 0, 255, 1,
 		    snd_soc_get_volsw, cs530x_put_volsw_vu, in_vol_tlv),
 
-SOC_SINGLE("ADC5 Invert Switch", CS530X_IN_INV, CS530X_IN5_INV_SHIFT, 1, 0),
-SOC_SINGLE("ADC6 Invert Switch", CS530X_IN_INV, CS530X_IN6_INV_SHIFT, 1, 0),
-SOC_SINGLE("ADC7 Invert Switch", CS530X_IN_INV, CS530X_IN7_INV_SHIFT, 1, 0),
-SOC_SINGLE("ADC8 Invert Switch", CS530X_IN_INV, CS530X_IN8_INV_SHIFT, 1, 0),
+SOC_SINGLE("ADC5 Invert Switch", CS530X_IN_INV, CS530X_INOUT5_INV_SHIFT, 1, 0),
+SOC_SINGLE("ADC6 Invert Switch", CS530X_IN_INV, CS530X_INOUT6_INV_SHIFT, 1, 0),
+SOC_SINGLE("ADC7 Invert Switch", CS530X_IN_INV, CS530X_INOUT7_INV_SHIFT, 1, 0),
+SOC_SINGLE("ADC8 Invert Switch", CS530X_IN_INV, CS530X_INOUT8_INV_SHIFT, 1, 0),
 };
 
 static int cs530x_adc_event(struct snd_soc_dapm_widget *w,
@@ -233,24 +278,110 @@ static int cs530x_adc_event(struct snd_soc_dapm_widget *w,
 		break;
 	case SND_SOC_DAPM_POST_PMU:
 		regmap_clear_bits(regmap, CS530X_IN_VOL_CTRL1_0 +
-				  (w->shift * 2), CS530X_IN_MUTE);
+				  (w->shift * 2), CS530X_INOUT_MUTE);
 		regmap_clear_bits(regmap, CS530X_IN_VOL_CTRL1_0 +
-				  ((w->shift + 1) * 2), CS530X_IN_MUTE);
+				  ((w->shift + 1) * 2), CS530X_INOUT_MUTE);
 
 		cs530x->adc_pairs_count--;
 		if (!cs530x->adc_pairs_count) {
 			usleep_range(1000, 1100);
 			return regmap_write(regmap, CS530X_IN_VOL_CTRL5,
-					    CS530X_IN_VU);
+					    CS530X_INOUT_VU);
 		}
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
 		regmap_set_bits(regmap, CS530X_IN_VOL_CTRL1_0 +
-				(w->shift * 2), CS530X_IN_MUTE);
+				(w->shift * 2), CS530X_INOUT_MUTE);
 		regmap_set_bits(regmap, CS530X_IN_VOL_CTRL1_0 +
-				((w->shift + 1) * 2), CS530X_IN_MUTE);
+				((w->shift + 1) * 2), CS530X_INOUT_MUTE);
 		return regmap_write(regmap, CS530X_IN_VOL_CTRL5,
-				    CS530X_IN_VU);
+				    CS530X_INOUT_VU);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static SOC_ENUM_SINGLE_DECL(cs530x_ramp_out_inc_enum, CS530X_OUT_RAMP_SUM,
+			    CS530X_RAMP_RATE_INC_SHIFT,
+			    cs530x_vol_ramp_text);
+
+static SOC_ENUM_SINGLE_DECL(cs530x_ramp_out_dec_enum, CS530X_OUT_RAMP_SUM,
+			    CS530X_RAMP_RATE_DEC_SHIFT,
+			    cs530x_vol_ramp_text);
+
+static const struct snd_kcontrol_new cs530x_out_1_to_2_controls[] = {
+SOC_SINGLE_EXT_TLV("OUT1 Volume", CS530X_OUT_VOL_CTRL1_0, 0, 255, 1,
+		    snd_soc_get_volsw, cs530x_put_volsw_vu, in_vol_tlv),
+SOC_SINGLE_EXT_TLV("OUT2 Volume", CS530X_OUT_VOL_CTRL1_1, 0, 255, 1,
+		    snd_soc_get_volsw, cs530x_put_volsw_vu, in_vol_tlv),
+
+SOC_ENUM("OUT DEC Filter Select", cs530x_out_filter_enum),
+SOC_ENUM("Output Ramp Up", cs530x_ramp_out_inc_enum),
+SOC_ENUM("Output Ramp Down", cs530x_ramp_out_dec_enum),
+
+SOC_SINGLE("DAC1 Invert Switch", CS530X_OUT_INV, CS530X_INOUT1_INV_SHIFT, 1, 0),
+SOC_SINGLE("DAC2 Invert Switch", CS530X_OUT_INV, CS530X_INOUT2_INV_SHIFT, 1, 0),
+};
+
+static const struct snd_kcontrol_new cs530x_out_3_to_4_controls[] = {
+SOC_SINGLE_EXT_TLV("OUT3 Volume", CS530X_OUT_VOL_CTRL2_0, 0, 255, 1,
+		    snd_soc_get_volsw, cs530x_put_volsw_vu, in_vol_tlv),
+SOC_SINGLE_EXT_TLV("OUT4 Volume", CS530X_OUT_VOL_CTRL2_1, 0, 255, 1,
+		    snd_soc_get_volsw, cs530x_put_volsw_vu, in_vol_tlv),
+
+SOC_SINGLE("DAC3 Invert Switch", CS530X_OUT_INV, CS530X_INOUT3_INV_SHIFT, 1, 0),
+SOC_SINGLE("DAC4 Invert Switch", CS530X_OUT_INV, CS530X_INOUT4_INV_SHIFT, 1, 0),
+};
+
+static const struct snd_kcontrol_new cs530x_out_5_to_8_controls[] = {
+SOC_SINGLE_EXT_TLV("OUT5 Volume", CS530X_OUT_VOL_CTRL3_0, 0, 255, 1,
+		    snd_soc_get_volsw, cs530x_put_volsw_vu, in_vol_tlv),
+SOC_SINGLE_EXT_TLV("OUT6 Volume", CS530X_OUT_VOL_CTRL3_1, 0, 255, 1,
+		    snd_soc_get_volsw, cs530x_put_volsw_vu, in_vol_tlv),
+SOC_SINGLE_EXT_TLV("OUT7 Volume", CS530X_OUT_VOL_CTRL4_0, 0, 255, 1,
+		    snd_soc_get_volsw, cs530x_put_volsw_vu, in_vol_tlv),
+SOC_SINGLE_EXT_TLV("OUT8 Volume", CS530X_OUT_VOL_CTRL4_1, 0, 255, 1,
+		    snd_soc_get_volsw, cs530x_put_volsw_vu, in_vol_tlv),
+
+SOC_SINGLE("DAC5 Invert Switch", CS530X_OUT_INV, CS530X_INOUT5_INV_SHIFT, 1, 0),
+SOC_SINGLE("DAC6 Invert Switch", CS530X_OUT_INV, CS530X_INOUT6_INV_SHIFT, 1, 0),
+SOC_SINGLE("DAC7 Invert Switch", CS530X_OUT_INV, CS530X_INOUT7_INV_SHIFT, 1, 0),
+SOC_SINGLE("DAC8 Invert Switch", CS530X_OUT_INV, CS530X_INOUT8_INV_SHIFT, 1, 0),
+};
+
+static int cs530x_dac_event(struct snd_soc_dapm_widget *w,
+			    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct cs530x_priv *cs530x = snd_soc_component_get_drvdata(component);
+	struct regmap *regmap = cs530x->regmap;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		cs530x->dac_pairs_count++;
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		regmap_clear_bits(regmap, CS530X_OUT_VOL_CTRL1_0 +
+				 (w->shift * 2), CS530X_INOUT_MUTE);
+		regmap_clear_bits(regmap, CS530X_OUT_VOL_CTRL1_0 +
+				 ((w->shift + 1) * 2), CS530X_INOUT_MUTE);
+
+		cs530x->dac_pairs_count--;
+		if (!cs530x->dac_pairs_count) {
+			usleep_range(1000, 1100);
+			return regmap_write(regmap, CS530X_OUT_VOL_CTRL5,
+					    CS530X_INOUT_VU);
+		}
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		regmap_set_bits(regmap, CS530X_OUT_VOL_CTRL1_0 +
+			       (w->shift * 2), CS530X_INOUT_MUTE);
+		regmap_set_bits(regmap, CS530X_OUT_VOL_CTRL1_0 +
+			       ((w->shift + 1) * 2), CS530X_INOUT_MUTE);
+		return regmap_write(regmap, CS530X_OUT_VOL_CTRL5,
+				    CS530X_INOUT_VU);
 	default:
 		return -EINVAL;
 	}
@@ -266,8 +397,18 @@ static const struct snd_kcontrol_new adc56_ctrl =
 	SOC_DAPM_SINGLE_VIRT("Switch", 1);
 static const struct snd_kcontrol_new adc78_ctrl =
 	SOC_DAPM_SINGLE_VIRT("Switch", 1);
+static const struct snd_kcontrol_new dac12_ctrl =
+	SOC_DAPM_SINGLE_VIRT("Switch", 1);
+static const struct snd_kcontrol_new dac34_ctrl =
+	SOC_DAPM_SINGLE_VIRT("Switch", 1);
+static const struct snd_kcontrol_new dac56_ctrl =
+	SOC_DAPM_SINGLE_VIRT("Switch", 1);
+static const struct snd_kcontrol_new dac78_ctrl =
+	SOC_DAPM_SINGLE_VIRT("Switch", 1);
 static const struct snd_kcontrol_new in_hpf_ctrl =
 	SOC_DAPM_SINGLE_VIRT("Switch", 1);
+static const struct snd_kcontrol_new out_hpf_ctrl =
+	SOC_DAPM_SINGLE_VIRT("Switch", 1);
 
 /* General DAPM widgets for all devices */
 static const struct snd_soc_dapm_widget cs530x_gen_dapm_widgets[] = {
@@ -284,7 +425,7 @@ SND_SOC_DAPM_ADC_E("ADC1", NULL, CS530X_IN_ENABLES, 0, 0,
 		   SND_SOC_DAPM_PRE_PMU),
 SND_SOC_DAPM_ADC("ADC2", NULL, CS530X_IN_ENABLES, 1, 0),
 SND_SOC_DAPM_SWITCH("ADC12 Enable", SND_SOC_NOPM, 0, 0, &adc12_ctrl),
-SND_SOC_DAPM_SWITCH("IN HPF", CS530X_IN_FILTER, CS530X_IN_HPF_EN_SHIFT,
+SND_SOC_DAPM_SWITCH("IN HPF", CS530X_IN_FILTER, CS530X_INOUT_HPF_EN_SHIFT,
 		    0, &in_hpf_ctrl),
 };
 
@@ -408,6 +549,153 @@ static void cs530x_add_34_adc_widgets(struct snd_soc_component *component)
 				ARRAY_SIZE(adc_ch3_4_routes));
 }
 
+/* DAC's Channels 1 and 2 plus generic DAC DAPM events */
+static const struct snd_soc_dapm_widget cs530x_dac_ch12_dapm_widgets[] = {
+SND_SOC_DAPM_OUTPUT("OUT1"),
+SND_SOC_DAPM_OUTPUT("OUT2"),
+SND_SOC_DAPM_DAC_E("DAC1", NULL, CS530X_OUT_ENABLES, 0, 0,
+		   cs530x_dac_event,
+		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU |
+		   SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_DAC("DAC2", NULL, CS530X_OUT_ENABLES, 1, 0),
+SND_SOC_DAPM_SWITCH("DAC12 Enable", SND_SOC_NOPM, 0, 0, &dac12_ctrl),
+SND_SOC_DAPM_SWITCH("OUT HPF", CS530X_OUT_FILTER, CS530X_INOUT_HPF_EN_SHIFT,
+		    0, &out_hpf_ctrl),
+};
+
+/* DAC's Channels 3 and 4 */
+static const struct snd_soc_dapm_widget cs530x_dac_ch34_dapm_widgets[] = {
+SND_SOC_DAPM_OUTPUT("OUT3"),
+SND_SOC_DAPM_OUTPUT("OUT4"),
+SND_SOC_DAPM_DAC_E("DAC3", NULL, CS530X_OUT_ENABLES, 2, 0,
+		   cs530x_dac_event,
+		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU |
+		   SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_DAC("DAC4", NULL, CS530X_OUT_ENABLES, 3, 0),
+SND_SOC_DAPM_SWITCH("DAC34 Enable", SND_SOC_NOPM, 0, 0, &dac34_ctrl),
+};
+
+/* DAC's Channels 5 to 8 */
+static const struct snd_soc_dapm_widget cs530x_dac_ch58_dapm_widgets[] = {
+SND_SOC_DAPM_OUTPUT("OUT5"),
+SND_SOC_DAPM_OUTPUT("OUT6"),
+SND_SOC_DAPM_OUTPUT("OUT7"),
+SND_SOC_DAPM_OUTPUT("OUT8"),
+SND_SOC_DAPM_DAC_E("DAC5", NULL, CS530X_OUT_ENABLES, 4, 0,
+		   cs530x_dac_event,
+		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU |
+		   SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_DAC("DAC6", NULL, CS530X_OUT_ENABLES, 5, 0),
+SND_SOC_DAPM_SWITCH("DAC56 Enable", SND_SOC_NOPM, 0, 0, &dac56_ctrl),
+SND_SOC_DAPM_DAC_E("DAC7", NULL, CS530X_OUT_ENABLES, 6, 0,
+		   cs530x_dac_event,
+		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU |
+		   SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_DAC("DAC8", NULL, CS530X_OUT_ENABLES, 7, 0),
+SND_SOC_DAPM_SWITCH("DAC78 Enable", SND_SOC_NOPM, 0, 0, &dac78_ctrl),
+};
+
+static const struct snd_soc_dapm_route dac_ch1_2_routes[] = {
+	{ "DAC1", NULL, "Global Enable" },
+	{ "DAC2", NULL, "Global Enable" },
+
+	{ "DAC12 Enable", "Switch", "OUT1" },
+	{ "DAC12 Enable", "Switch", "OUT2" },
+	{ "DAC1", NULL, "DAC12 Enable" },
+	{ "DAC2", NULL, "DAC12 Enable" },
+	{ "OUT HPF", "Switch", "DAC1" },
+	{ "OUT HPF", "Switch", "DAC2" },
+
+	{ "OUT HPF", NULL, "AIF Playback" },
+	{ "DAC1", NULL, "AIF Playback" },
+	{ "DAC2", NULL, "AIF Playback" },
+
+	{ "OUT1", NULL, "DAC1" },
+	{ "OUT2", NULL, "DAC2" },
+};
+
+static const struct snd_soc_dapm_route dac_ch3_4_routes[] = {
+	{ "DAC3", NULL, "Global Enable" },
+	{ "DAC4", NULL, "Global Enable" },
+
+	{ "DAC34 Enable", "Switch", "OUT3" },
+	{ "DAC34 Enable", "Switch", "OUT4" },
+	{ "DAC3", NULL, "DAC34 Enable" },
+	{ "DAC4", NULL, "DAC34 Enable" },
+	{ "OUT HPF", "Switch", "DAC3" },
+	{ "OUT HPF", "Switch", "DAC4" },
+
+	{ "DAC3", NULL, "AIF Playback" },
+	{ "DAC4", NULL, "AIF Playback" },
+
+	{ "OUT3", NULL, "DAC3" },
+	{ "OUT4", NULL, "DAC4" },
+};
+
+static const struct snd_soc_dapm_route dac_ch5_8_routes[] = {
+	{ "DAC5", NULL, "Global Enable" },
+	{ "DAC6", NULL, "Global Enable" },
+
+	{ "DAC56 Enable", "Switch", "OUT5" },
+	{ "DAC56 Enable", "Switch", "OUT6" },
+	{ "DAC5", NULL, "DAC56 Enable" },
+	{ "DAC6", NULL, "DAC56 Enable" },
+	{ "OUT HPF", "Switch", "DAC5" },
+	{ "OUT HPF", "Switch", "DAC6" },
+
+	{ "DAC5", NULL, "AIF Playback" },
+	{ "DAC6", NULL, "AIF Playback" },
+
+	{ "OUT5", NULL, "DAC5" },
+	{ "OUT6", NULL, "DAC6" },
+
+	{ "DAC7", NULL, "Global Enable" },
+	{ "DAC8", NULL, "Global Enable" },
+
+	{ "DAC78 Enable", "Switch", "OUT7" },
+	{ "DAC78 Enable", "Switch", "OUT8" },
+	{ "DAC7", NULL, "DAC78 Enable" },
+	{ "DAC8", NULL, "DAC78 Enable" },
+	{ "OUT HPF", "Switch", "DAC7" },
+	{ "OUT HPF", "Switch", "DAC8" },
+
+	{ "DAC7", NULL, "AIF Playback" },
+	{ "DAC8", NULL, "AIF Playback" },
+
+	{ "OUT7", NULL, "DAC7" },
+	{ "OUT8", NULL, "DAC8" },
+};
+
+static void cs530x_add_12_dac_widgets(struct snd_soc_component *component)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+
+	snd_soc_add_component_controls(component,
+				       cs530x_out_1_to_2_controls,
+				       ARRAY_SIZE(cs530x_out_1_to_2_controls));
+
+	snd_soc_dapm_new_controls(dapm, cs530x_dac_ch12_dapm_widgets,
+				  ARRAY_SIZE(cs530x_dac_ch12_dapm_widgets));
+
+	snd_soc_dapm_add_routes(dapm, dac_ch1_2_routes,
+				ARRAY_SIZE(dac_ch1_2_routes));
+}
+
+static void cs530x_add_34_dac_widgets(struct snd_soc_component *component)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+
+	snd_soc_add_component_controls(component,
+				       cs530x_out_3_to_4_controls,
+				       ARRAY_SIZE(cs530x_out_3_to_4_controls));
+
+	snd_soc_dapm_new_controls(dapm, cs530x_dac_ch34_dapm_widgets,
+				  ARRAY_SIZE(cs530x_dac_ch34_dapm_widgets));
+
+	snd_soc_dapm_add_routes(dapm, dac_ch3_4_routes,
+				ARRAY_SIZE(dac_ch3_4_routes));
+}
+
 static int cs530x_set_bclk(struct snd_soc_component *component, const int freq)
 {
 	struct cs530x_priv *cs530x = snd_soc_component_get_drvdata(component);
@@ -666,8 +954,11 @@ static const struct snd_soc_dai_driver cs530x_dai = {
 	.name = "cs530x-dai",
 	.capture = {
 		.stream_name = "AIF Capture",
-		.channels_min = 2,
-		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_KNOT,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.playback = {
+		.stream_name = "AIF Playback",
 		.rates = SNDRV_PCM_RATE_KNOT,
 		.formats = SNDRV_PCM_FMTBIT_S32_LE,
 	},
@@ -722,6 +1013,43 @@ static int cs530x_component_probe(struct snd_soc_component *component)
 				  ARRAY_SIZE(cs530x_gen_dapm_widgets));
 
 	switch (cs530x->devtype) {
+	case CS4282:
+		cs530x_add_12_adc_widgets(component);
+		cs530x_add_12_dac_widgets(component);
+		break;
+	case CS4302:
+		cs530x_add_12_dac_widgets(component);
+		break;
+	case CS4304:
+		cs530x_add_12_dac_widgets(component);
+		cs530x_add_34_dac_widgets(component);
+
+		num_widgets = ARRAY_SIZE(cs530x_out_sum_4ch_controls);
+		snd_soc_add_component_controls(component,
+					       cs530x_out_sum_4ch_controls,
+					       num_widgets);
+		break;
+	case CS4308:
+		cs530x_add_12_dac_widgets(component);
+		cs530x_add_34_dac_widgets(component);
+
+		num_widgets = ARRAY_SIZE(cs530x_out_5_to_8_controls);
+		snd_soc_add_component_controls(component,
+					       cs530x_out_5_to_8_controls,
+					       num_widgets);
+
+		num_widgets = ARRAY_SIZE(cs530x_out_sum_8ch_controls);
+		snd_soc_add_component_controls(component,
+					       cs530x_out_sum_8ch_controls,
+					       num_widgets);
+
+		num_widgets = ARRAY_SIZE(cs530x_dac_ch58_dapm_widgets);
+		snd_soc_dapm_new_controls(dapm, cs530x_dac_ch58_dapm_widgets,
+					  num_widgets);
+
+		snd_soc_dapm_add_routes(dapm, dac_ch5_8_routes,
+					ARRAY_SIZE(dac_ch5_8_routes));
+		break;
 	case CS5302:
 		cs530x_add_12_adc_widgets(component);
 		break;
@@ -825,9 +1153,20 @@ static int cs530x_check_device_id(struct cs530x_priv *cs530x)
 	if (ret)
 		return dev_err_probe(dev, ret, "Can't read REV ID\n");
 
-	dev_dbg(dev, "Device ID 0x%x Rev ID 0x%x\n", dev_id, rev);
-
 	switch (dev_id) {
+	case CS530X_2CH_CODEC_DEV_ID:
+		cs530x->num_dacs = 2;
+		cs530x->num_adcs = 2;
+		break;
+	case CS530X_2CH_DAC_DEV_ID:
+		cs530x->num_dacs = 2;
+		break;
+	case CS530X_4CH_DAC_DEV_ID:
+		cs530x->num_dacs = 4;
+		break;
+	case CS530X_8CH_DAC_DEV_ID:
+		cs530x->num_dacs = 8;
+		break;
 	case CS530X_2CH_ADC_DEV_ID:
 		cs530x->num_adcs = 2;
 		break;
@@ -842,6 +1181,9 @@ static int cs530x_check_device_id(struct cs530x_priv *cs530x)
 				     dev_id);
 	}
 
+	dev_dbg(dev, "Device ID 0x%x Rev ID 0x%x (%d in %d out)\n", dev_id, rev,
+		cs530x->num_adcs, cs530x->num_dacs);
+
 	return 0;
 }
 
@@ -870,6 +1212,9 @@ static int cs530x_parse_device_properties(struct cs530x_priv *cs530x)
 			val |= CS530X_IN12_HIZ;
 
 		return regmap_set_bits(regmap, CS530X_IN_HIZ, val);
+	case 0:
+		/* No ADCs */
+		return 0;
 	default:
 		return dev_err_probe(dev, -EINVAL,
 				     "Invalid number of adcs %d\n",
@@ -932,7 +1277,15 @@ int cs530x_probe(struct cs530x_priv *cs530x)
 	if (ret)
 		goto err_reset;
 
-	cs530x->dev_dai->capture.channels_max = cs530x->num_adcs;
+	if (cs530x->num_adcs) {
+		cs530x->dev_dai->capture.channels_min = 2;
+		cs530x->dev_dai->capture.channels_max = cs530x->num_adcs;
+	}
+
+	if (cs530x->num_dacs) {
+		cs530x->dev_dai->playback.channels_min = 2;
+		cs530x->dev_dai->playback.channels_max = cs530x->num_dacs;
+	}
 
 	ret = devm_snd_soc_register_component(dev,
 					      &soc_component_dev_cs530x,
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index cdd54bfa259f..c10a6766cc7a 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -15,6 +15,10 @@
 #include <linux/regulator/consumer.h>
 
 /* Devices */
+#define CS530X_2CH_CODEC_DEV_ID		 0x4282
+#define CS530X_2CH_DAC_DEV_ID		 0x4302
+#define CS530X_4CH_DAC_DEV_ID		 0x4304
+#define CS530X_8CH_DAC_DEV_ID		 0x4308
 #define CS530X_2CH_ADC_DEV_ID		 0x5302
 #define CS530X_4CH_ADC_DEV_ID		 0x5304
 #define CS530X_8CH_ADC_DEV_ID		 0x5308
@@ -45,6 +49,21 @@
 #define CS530X_IN_VOL_CTRL4_1	        0x000009E
 #define CS530X_IN_VOL_CTRL5		0x00000A0
 
+#define CS530X_OUT_ENABLES		0x00000C0
+#define CS530X_OUT_RAMP_SUM		0x00000C2
+#define CS530X_OUT_DEEMPH		0x00000C4
+#define CS530X_OUT_FILTER		0x00000C6
+#define CS530X_OUT_INV			0x00000CA
+#define CS530X_OUT_VOL_CTRL1_0		0x00000D0
+#define CS530X_OUT_VOL_CTRL1_1		0x00000D2
+#define CS530X_OUT_VOL_CTRL2_0		0x00000D4
+#define CS530X_OUT_VOL_CTRL2_1		0x00000D6
+#define CS530X_OUT_VOL_CTRL3_0		0x00000D8
+#define CS530X_OUT_VOL_CTRL3_1		0x00000DA
+#define CS530X_OUT_VOL_CTRL4_0		0x00000DC
+#define CS530X_OUT_VOL_CTRL4_1		0x00000DE
+#define CS530X_OUT_VOL_CTRL5		0x00000E0
+
 #define CS530X_PAD_FN			0x0003D24
 #define CS530X_PAD_LVL			0x0003D28
 
@@ -124,14 +143,14 @@
 #define CS530X_14_15_TDM_SLOT_MASK	GENMASK(15, 14)
 #define CS530X_14_15_TDM_SLOT_VAL	7
 
-/* IN_RAMP_SUM */
+/* IN_RAMP_SUM and OUT_RAMP_SUM */
 #define CS530X_RAMP_RATE_INC_SHIFT	0
 #define CS530X_RAMP_RATE_DEC_SHIFT	4
-#define CS530X_IN_SUM_MODE_SHIFT	13
+#define CS530X_INOUT_SUM_MODE_SHIFT	13
 
-/* IN_FILTER */
-#define CS530X_IN_FILTER_SHIFT		8
-#define CS530X_IN_HPF_EN_SHIFT		12
+/* IN_FILTER and OUT_FILTER */
+#define CS530X_INOUT_FILTER_SHIFT		8
+#define CS530X_INOUT_HPF_EN_SHIFT		12
 
 /* IN_HIZ */
 #define CS530X_IN12_HIZ			BIT(0)
@@ -139,21 +158,21 @@
 #define CS530X_IN56_HIZ			BIT(2)
 #define CS530X_IN78_HIZ			BIT(3)
 
-/* IN_INV */
-#define CS530X_IN1_INV_SHIFT		0
-#define CS530X_IN2_INV_SHIFT		1
-#define CS530X_IN3_INV_SHIFT		2
-#define CS530X_IN4_INV_SHIFT		3
-#define CS530X_IN5_INV_SHIFT		4
-#define CS530X_IN6_INV_SHIFT		5
-#define CS530X_IN7_INV_SHIFT		6
-#define CS530X_IN8_INV_SHIFT		7
+/* IN_INV and OUT_INV */
+#define CS530X_INOUT1_INV_SHIFT		0
+#define CS530X_INOUT2_INV_SHIFT		1
+#define CS530X_INOUT3_INV_SHIFT		2
+#define CS530X_INOUT4_INV_SHIFT		3
+#define CS530X_INOUT5_INV_SHIFT		4
+#define CS530X_INOUT6_INV_SHIFT		5
+#define CS530X_INOUT7_INV_SHIFT		6
+#define CS530X_INOUT8_INV_SHIFT		7
 
-/* IN_VOL_CTLy_z */
-#define CS530X_IN_MUTE			BIT(15)
+/* IN_VOL_CTLy_z and OUT_VOL_CTLy_z */
+#define CS530X_INOUT_MUTE			BIT(15)
 
-/* IN_VOL_CTL5 */
-#define CS530X_IN_VU			BIT(0)
+/* IN_VOL_CTL5 and OUT_VOL_CTL5 */
+#define CS530X_INOUT_VU			BIT(0)
 
 /* System Clock Source */
 #define CS530X_SYSCLK_SRC_MCLK		0
@@ -166,6 +185,10 @@
 #define CS530X_NUM_SUPPLIES		2
 
 enum cs530x_type {
+	CS4282,
+	CS4302,
+	CS4304,
+	CS4308,
 	CS5302,
 	CS5304,
 	CS5308,
@@ -186,6 +209,7 @@ struct cs530x_priv {
 	int tdm_width;
 	int tdm_slots;
 	int adc_pairs_count;
+	int dac_pairs_count;
 
 	struct gpio_desc *reset_gpio;
 };
-- 
2.43.0



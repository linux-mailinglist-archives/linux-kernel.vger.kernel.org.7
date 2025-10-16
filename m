Return-Path: <linux-kernel+bounces-856640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FBBBE4ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDC734E2396
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE9D342C9F;
	Thu, 16 Oct 2025 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="J20MBENX";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="uYDOUlQ/"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA96530C60B;
	Thu, 16 Oct 2025 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633357; cv=fail; b=LmUd7YpQkfHPnYWHxfGyj9HyisT21itdhr2HSUPXpofxTA83B5CYIoioYkQ54cdgYTw4R97ha2LEUbVMsPgHO8LRZyGC6gY0iK8WuidzLxd7V6QVCDiYxwoqIHZDG3JZRdSER9logycog2XG8NlTHMxoj0k8r7o4VrLAHSC6i6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633357; c=relaxed/simple;
	bh=EGvR+BiQkn1WhjPN54f7oc+ordmzsUUiXl3IPccQ43Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rwmf5xaX3TmweNB15ziw944OARahbYGs7I4h0P+Z0qra2HbmOQ8N5J8ha0EA+yGOv5OO4nbJUNB3jbdz3l2n5nvrRQ/58CjGJtGR/KWt9XGFnhKD6JriV5lUcIeg+8XwoYue2UYn8SQWLbQ8Rzv3TEMTgUhTPRmdw2XZHHSIJH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=J20MBENX; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=uYDOUlQ/; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GDT1op4017700;
	Thu, 16 Oct 2025 11:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=o96B4YQDp5yWxqLUNuwVwxWkfNI1kaZXYyGO4U9jV3g=; b=
	J20MBENXZj469e8mPT7chP4oWr2mWTGjcB4TXPeElbpjpK/CyDfWxm1KyFKOxPrZ
	uHuCYzjk+ET/KxdlDq6yBofT6ox3lIk25OWOsOS3NDbhJfZrj6AvTgSJ9YAYd2fD
	bjmn766191Hm6jlZnyYtJdc8Z2z1635o8zwYE4z/LMKOtnDEPFNzXqMpScJ6o1B5
	7eKmnF2mqP38s9ZmFnKgXZuWMwQyqazHzzNZdF5P2Gstuwd84dzMZnwnau4Jd3l3
	a9GsdaCohIsOjY9F12rGiJEQ2doSLyVod0hEysffhNIMp3Cpb/uBNwwerSbmokFv
	y/FFB6YmYANPKM2e5BIt5w==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020092.outbound.protection.outlook.com [52.101.85.92])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mngaju-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:49:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wh2VjnoM2P6QU1Pspgrlf1vkmArHp2FWyCkRPFQYPzZhEBvxTB8D9HWIvyTW9tXupdaWigapQb29uVV/BQm83H/3Lgw+sGaFi3LgRs6jkWyvjGk5d5rT2L+Fqe2YI69jNXlJsxURk7H1xdmHeRMqNpyyELKF+gqaRBl9um0sShRFs515XbNppe11eCPlRJ+QJersFTBH2ZvxMb0uDRy+LBQCOmU75bnKVO4XGJwclL7nvliqNj8Ss5N7eb8mdjDjhgU3YeyK+qgDVqU0slqUspHMSckit4106I4DF/8ngqxSJp0PpJRNMBeGkcOulF/i/lemw/Q58sFQy9e46Tv+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o96B4YQDp5yWxqLUNuwVwxWkfNI1kaZXYyGO4U9jV3g=;
 b=X6caAKlQtuLwa1vU8vJ3j4XN04BI+RRUkSWTSUWKW8d2Auu5qYscu9OBKwQu7wQNcplmU374wzMTpGtaDJHYFzZslIv9h9MfDMUB9HnPUG/nS1/a2FO6TECUtOls2QKHZagHlIdpH71GAAy/MJaQRpWrlxebaRJwTVzdgNSvHC3xRpJ3jDseWj/CGvpphXK4mPb8rdXoIN1y+jzdrMXGhKefnH6gj+0KfZduEFm35a6y48R8dnlLRffXfYnuYp7bYNF5hnFVGY0c8EV5Iq1jdB2H6U37Bs4VkEbKVxuQVIfUPu3wpMWH5Asbo2ua4RRfRHwNaGQ/SDNkUnF064Y0Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o96B4YQDp5yWxqLUNuwVwxWkfNI1kaZXYyGO4U9jV3g=;
 b=uYDOUlQ/IFmUUgOWBh5+d7MFsxAw89kH4Y7Z2MP39yeVs329AZr1bMALAHjLexY+GGOxKHf5cxGKYMEeeyiYzwHEppcM0qByF9sIbIdHXDWtyMxgBVsg7XEjLkma0HzAHNPaf6ohfwzURzJ+UCvwOhkjLy2jnXT5/y9s6Rsw4mg=
Received: from SJ0PR05CA0087.namprd05.prod.outlook.com (2603:10b6:a03:332::32)
 by SA0PR19MB4521.namprd19.prod.outlook.com (2603:10b6:806:b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Thu, 16 Oct
 2025 16:49:00 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::51) by SJ0PR05CA0087.outlook.office365.com
 (2603:10b6:a03:332::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Thu,
 16 Oct 2025 16:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:49:00 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E1789406547;
	Thu, 16 Oct 2025 16:48:58 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 81B33822540;
	Thu, 16 Oct 2025 16:48:58 +0000 (UTC)
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
Subject: [PATCH v2 01/11] ASoC: cs530x: Correct log message with expected variable
Date: Thu, 16 Oct 2025 17:48:19 +0100
Message-ID: <20251016164847.138826-2-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|SA0PR19MB4521:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 22d4d495-0482-47da-1eda-08de0cd3e82f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?13NpyWsI3N8NtU0zDJ7io6CxHU3sxqPZpIfSbQQl4zMheAzNv1UJ8+qmDlCj?=
 =?us-ascii?Q?KSO6KJTFqO+9UJLwQHs1BLg8mjv55mT3Lw3IiHFTNQsG4p2GPleRRFxh3g0y?=
 =?us-ascii?Q?1GaRxMPboyKnnSz8ZDwMxFTolbJ+sdL55f3Aqho1KS5r4qw6UsbusJzDD4Xh?=
 =?us-ascii?Q?xEfrlaV0MlaVHb9ZhS+Sg4wCayDWUAsaGnfDLZFCIeTno4CUo866G7eT0NLD?=
 =?us-ascii?Q?UY+oAwAlFJUa9WujCEkvYKfGcthxl58HVQfsRdFkRMUm+zx8fqZRxCDvbL1Y?=
 =?us-ascii?Q?a0B8hwB08d/ZUjayZdaJwiDlPwwUK36fG0dHV0qTk8Q/gsjhtXuGPRdBn4/N?=
 =?us-ascii?Q?yGxDL50QAk9zq1ArTfwYIkFoDzK19vJjYJZBKv/Ukyl9Q9NfAOL5Wus2UKA7?=
 =?us-ascii?Q?zg+AcY9PhubKOue3rdshnZeIipAvPoIu+zAHpuzqSTvU0n1baBXxBHba+n1N?=
 =?us-ascii?Q?jKV/irzEblxdRDip++EjA7oI7ulkQKmgzwslrxW7xIfp72FParfKR17bN/61?=
 =?us-ascii?Q?fF4zp6mP0JpdLPAhDj4IIm3oKReC8c8tzG9sB294NyN8g9LScjsSE+Ffh3Y1?=
 =?us-ascii?Q?ss3l+JIm79oTn8MhkSgYfRmyzwKovAWd5GIYDaV6Yr0GbsaiMd7RbrzLAvl2?=
 =?us-ascii?Q?hcF2PmLGe0hkZD8qki2XwHixtayOLVvZIIsMGHSBA/7ZctjxQsI9HoGvwEsg?=
 =?us-ascii?Q?lDJU9Qz/ZJl5Ueir+q0dfi+SnfcLJMv49gw+JBSSuQmwoFp/Pe3qSTS3M6fo?=
 =?us-ascii?Q?OfeEXG21uEQbc3rgMoFbAWmIcAwTB2q2/z2uFyB6/32breV8CSSnlYIhNovI?=
 =?us-ascii?Q?qqANts2EVJvYvHtJqrKS0Fubd/7+YKO4cRx12StB6camN45FT6cSC/SQDYDL?=
 =?us-ascii?Q?YbHO3M5u0GcVO/6nBKCBBYyTo8Nx4Ah2Ard4s/05WCwdivRZu+8dLCfBWIkh?=
 =?us-ascii?Q?/ZRT5f5tsz7kPV9lIV3779Bjs1MPTCa3lovsLhCBweYYc9iIjPS/s9/dkvga?=
 =?us-ascii?Q?CrX05MDa1W+RXETPOvYiupWWBpH5OP4c468mXjGILr9hm6rP58x/jo4x90Mz?=
 =?us-ascii?Q?7vCxfMfKENyyMMhMFWF/3nmdaPM4dqtG6XE1POxFSBAwbt3cy5cIvfnkbDaU?=
 =?us-ascii?Q?G7ADtmWqSJtOyCJK4ejSfXZdnptiCnFS1G14hSYIAtvwJsN3iqH7P/t/jwcp?=
 =?us-ascii?Q?Yf8gBgmppVDvyASZV0p/daNRaxDwQVXBWWzE2wxKVaEWX4DSUCEEKTnEywdC?=
 =?us-ascii?Q?X1LA/EQy5HGiRgjJ1zo3Zmzhw0zMhfUM6vtSwEOmLljZxACaaHKDHLMuyXlC?=
 =?us-ascii?Q?iuJgxr3hoT//L/XmHkr9B9jxwv+sPdXHmPdx53Um3zHfcDTdRrQsabdQUkPu?=
 =?us-ascii?Q?4CwSziY6j8nA0O/skfAp5Ut1ouwgWQHeuEWoKBVC50WhiI09xzQwNmSi5GmD?=
 =?us-ascii?Q?k0g42qEK5tpFa82UrA7s4Uyo3m5CRctI+rVHDchTco4Yqrj6DmhtOCMKKTSR?=
 =?us-ascii?Q?eWq+qV9skbYh4vOk7zSEmQsCYtPkVAd0GqadZgxiYNVdZiOp5ec6J0r0C5n2?=
 =?us-ascii?Q?bt5Xo1xtriBwKOO/6Xk=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(7416014)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:49:00.2811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d4d495-0482-47da-1eda-08de0cd3e82f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4521
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f121ff cx=c_pps
 a=rN54qV+o3v1qfa0lUeS+bg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=Q_cYDw76ORux1IEp9KIA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: X-eVURwn2jjzs4PABckKcwE6j0G3QNak
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMSBTYWx0ZWRfX6T+TMq3ZZWsr
 SCbbPoo9AcmbWrSjIJ82LZf0ndMlrXKhU7/wK6mgHzjLJQx2QJwlSYM/8VIR5JneQ6GnO5VfXG9
 mkKmnZZdLRxF6utaOlJGh6nJ5WQUdYhuAYqGBagjUpbVzpK2NIGOzpORhtuDcNF9bSTnSkzuw3d
 usVq/yOvtG5BlLyY6uLi77M0iadWWWKAYE8QV/ds1rL40tbASqOha+Sb7JFoYPjG5VRTsc7D9No
 Ne33D4N7H19AG6ABoGyKQrF73BDFUZfhb8H86j7i63xGvBaM1QFhyXX5bFjnf+ZO2GSQk4tzPds
 kwEegjf+PLy8GTEJFGLBI89zeEQf429T14/8o2Vd/YTzOX0YUF3QQSV63LsSzFxVfvMA8oQMO9h
 5c0dj+NP54agtwiIK8PRDE6koNda8g==
X-Proofpoint-GUID: X-eVURwn2jjzs4PABckKcwE6j0G3QNak
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

The function used one parameter for the switch statement, but logged a
different parameter when it defaulted.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index b9eff240b929..535387cd7aa3 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -793,7 +793,7 @@ static int cs530x_set_sysclk(struct snd_soc_component *component, int clk_id,
 	case CS530X_SYSCLK_SRC_PLL:
 		break;
 	default:
-		dev_err(component->dev, "Invalid clock id %d\n", clk_id);
+		dev_err(component->dev, "Invalid sysclk source: %d\n", source);
 		return -EINVAL;
 	}
 
-- 
2.43.0



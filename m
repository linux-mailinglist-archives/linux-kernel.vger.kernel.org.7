Return-Path: <linux-kernel+bounces-895473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D79C4E0C5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6696C188BE52
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDEB324719;
	Tue, 11 Nov 2025 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="lDSSHyLj";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="zazy9/H6"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A573AA186;
	Tue, 11 Nov 2025 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866543; cv=fail; b=I+Q3wO61/4aEf68NdJffVVTRG/tu5bDn4inDPfplDW/047pSU4Cpf4Pol3x/MtL5SAuOIEgce6tGkr+5RWIDwwaILDUP66lrLAzTcnV6E71UrQ38w7AVOWp8pIxFBkHZceTxV2afnwmnIU5IMeGG1bxxf8XHZaTd0hCswSQn7v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866543; c=relaxed/simple;
	bh=y7ir+125Q8V5pgDxYz87UoaUFhuoqwpwy+lk99S9NqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HUev9mE0ddaJRkf6opd81GWCW86Ga3n1cyVEg0J/2uc4zCbGB1J81qhLo4OF3lsByoi62a/xr7Do8rUyaxawMJI24lQOPwbrh9x+qO5xvGwdCvw3Z45HJIksKyfDbEFqvJ2E7nfQ2QmxZN4XD/AHFrg43dwEXfb2GUTpLwSRMq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=lDSSHyLj; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=zazy9/H6; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB4W5xa189273;
	Tue, 11 Nov 2025 07:08:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=k0tTxJvGDIOZCbva
	zuAnXoB+EBSzmobH9gvn8lp0mlU=; b=lDSSHyLjyCWaSQSPswXbqExKbv+8QscI
	p2/V3d6Gr1vShAE72WwUY6fMrq7HsMRQvQ0JSdPXoO595ZWR+AAR4+qqAGJXnFp+
	T7q+KKT1axtlS7b0NIO+m9CMxySBX6GGMHbVjUrgVzmorDtKQdrAjtNioZupNZVq
	ZBsToagX2tWCOsYLJiWCDK+5xgDPMtP9/r30L6Mf3vGua8/WDfz1F4Hvg9lhr/9g
	CiKojIoAWwICzf4ka/pFJ4M2aQAPTB25RdKPhji0c7DYc4Ebv0ar45wUA/5XRcFA
	kxCtDhmhx7LC2JDmZQiLl7NUkDLNxBtsoMAVgNnUb1ALeLn4eCe2mA==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022081.outbound.protection.outlook.com [52.101.48.81])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4abfvksfrb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 07:08:56 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+BR+VHZEY9Os25vqVQkxvghzDQu9pl++a1ZqGJIhS853oQzY1GfjaVQjEVEGzYiQglC5PemaVGtM/C6BT1WgF6i1sN/rrqaY82W7WiC2zQZ7KxLbHUpdCDGqQzUB/u7SUG8Fy7nrb4KeFFqNr/D6bS7+e3zcvNcxW5JMTb2sJE+Y6TIyQNcUmtEOf32fq+SD8Z+QxiiCeCKJQj5lMkz/8f9m0Juu7CBG8bhg0xMqRke7g7GoGk7LgaStMaMw6NtLU/eYqVye9zLFY8ewegh8o9heWl0o+PkSL0OQloxypJ0fGM5WO1B/fHIq2uDG08gYo12TP0jFY0EXhzZa3skgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0tTxJvGDIOZCbvazuAnXoB+EBSzmobH9gvn8lp0mlU=;
 b=f83JoSyBZNjICk4Y59FOeHYPrHyBjrLQ3n1eqF/P2BjUqZzuvaXQsOVqOyIBUmwXW2DG7V7boR2ntKe7fd8rcaZrwOwJagKRTYcwhebImmm4Yvjd63IHO31Lgk7zv9hTolvePGRHtPyQw8HMmqCr/OwPl8o9Os38qnh3b6oF9ENMJxk8dTgBP/ghHAh9+ZKSaSnWx6V7jY3/5+2TIJbDmJmprDmkGiy2gL22dpVRORE9SPSo2UbnuAesVOsXGlDCJQJlqTlVPNeFwZEJ7eLD+HqgV6+gPr5MFe2HYM8eh/crovy+wduAyPUK3jzmEc1R8QmRA4jnagZeTZljxd5Zdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0tTxJvGDIOZCbvazuAnXoB+EBSzmobH9gvn8lp0mlU=;
 b=zazy9/H6jAqnv+8DSH3OxhrucM3S+BBbWZWKfmRxjmsdQx6rzysWU4QvsRH76eg3jht9ClE32kxeDGBc6YTZZmzGE4Fs+N/egQRkGEpRGT8K3wWf2oyDT6r0VcKE1NHcDhyHThsvFTlZ+gW+rDYqhOAHEZN3XA5coGptK5cEzo4=
Received: from PH8P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::17)
 by SJ4PPF23FF06C03.namprd19.prod.outlook.com (2603:10b6:a0f:fc02::a10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 13:08:53 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:346:cafe::bf) by PH8P221CA0040.outlook.office365.com
 (2603:10b6:510:346::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 13:08:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Tue, 11 Nov 2025 13:08:52 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 1A061406547;
	Tue, 11 Nov 2025 13:08:51 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id EF690820257;
	Tue, 11 Nov 2025 13:08:50 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 0/2] ASoC: cs35l56: Support for restoring calibration on ChromeOS
Date: Tue, 11 Nov 2025 13:08:48 +0000
Message-ID: <20251111130850.513969-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SJ4PPF23FF06C03:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3a872bbd-dd3c-48be-4e19-08de2123765b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cbC0ObToUT7ovaiEdAWEtrV0tlg+q7YUI9mN70HrpH9hVR0RDQLUvRJRZ5UW?=
 =?us-ascii?Q?FPpUwS+/e0oUTqN1Ay+853VUM9Bs24naAS5CZr7cegsb3J3SMA0guLswwDKy?=
 =?us-ascii?Q?LOe+8sxdDWly2oYyj/6/elSPT1CySiCLVXzM8Ezm7XvyNCR5PYptLB+BLqoE?=
 =?us-ascii?Q?i/f+Dj6BCDr4SIotzDtCwzSsV8LKRVbmDlyYDacaAGytzEAWTviUEWc2rTSm?=
 =?us-ascii?Q?guvjCzlmcshpXkgohmWyhriYAWi6xlTSwt0ZW2XhOXdg2Fk/ZJ2k4GghwPze?=
 =?us-ascii?Q?AeTElTk/vRJLmkRqbeAQydUTXQkygI0ZU0xuToXmwPY8AUpq3hFHlYI4z2Kp?=
 =?us-ascii?Q?r5pqmFTqnOXgcxXstKcgQW9aTDojnQwuAVVIXgRNbPE1+PGwjvQMQ8LDSWZi?=
 =?us-ascii?Q?vaT9pa9UOpglVvjKbH6XXlrlES75jAvvxJwQsaj6DMV1xBW9Gi0BGU1jrDxp?=
 =?us-ascii?Q?Va/IyoMtJjkvuxJSzoxhQ+65EUVCyvTUB0RwHFDHLMeocjbSYKdW+tq/LuL6?=
 =?us-ascii?Q?8eDE6vhTFich44QntQBDDfoIV5CjbkQy7Orlo4lckFX/G0Qq61LgukgbVfIL?=
 =?us-ascii?Q?61ttCV5iUu6DKDrMIkkdYWBbDpyYLiTQhS/R8cLiGbP/kt9cFPpBvaUY2a7K?=
 =?us-ascii?Q?xm9um9f0XqphT2grUbuGORxvwaSWtllZT555YN0nnrthqm+KOkEIG5Jrhs/5?=
 =?us-ascii?Q?6qInqmwsew+repbc3EeEhDY1voOBr4TxwTzwYV6OtG/Xgz0uph2Fd6jtNCER?=
 =?us-ascii?Q?gCJ+BGrHErEnaJr2pEQhf4pCO45m7ze12xTQQgokVz6ZFmkiejhrrELhFbpM?=
 =?us-ascii?Q?uAM0vb/+0UvK2HKC31jOxrsRkmzMiwK9dn4V+HbW+8Q1h+ZIun6yWdsnxKy4?=
 =?us-ascii?Q?eXDxcU5mQGt6g/Y3vbMJC2YzqRHFG4MqZV6c2k4tqL8GOL/aRWOkXE8rPw7H?=
 =?us-ascii?Q?AyK1zMVX6+HfaNJaMiZKF6GmJy9HyunUpcBk2CP0VxMX77COrs+G0WaGgygl?=
 =?us-ascii?Q?Sulf3lnnTN3V9Ru3a4hrFtp5THLR0SCNTH64OvRaGYKdfEhjyP6ptckSuiqd?=
 =?us-ascii?Q?MXVSEe2KFoNnhbyUHvXrnnU6bkApQQb0TLzB3XmwtBo22u91QARMr0xYkjGc?=
 =?us-ascii?Q?7dBgs0osxetAn3iBTcA+niukXUA5x9TYX4O/Gp4oVwPZsUOS59CNVxBhUKHC?=
 =?us-ascii?Q?HbF6PuoARJQQ7eI/PqJppn8QvEq3juzz2bua0PDE4Rf4pqGKr7nWQ0mYjTLz?=
 =?us-ascii?Q?lnWg2KV7jlEz1W3OmVZNuhmM8cfvzHhkkv75bdxS2AKXGoQpCK4qHA5e1/kk?=
 =?us-ascii?Q?xbNzQnbmKiNouYaDaGFs2JO7neC3OPkwZJCHJak5GLx/JqFMkOAWed+wk+KD?=
 =?us-ascii?Q?Cclk5PSwdfqR8zugxgbV6A6T5Roeia/RYesdf6Qwtkp/6bye2ydYlHeViD+m?=
 =?us-ascii?Q?QsCCbbtodmo8iFnbWuO/7+UIFfaPoHSqFysHdcd6r798T9Nur3mdJpJ7bMMW?=
 =?us-ascii?Q?+DZdlqLzrWA+T0aXHiF7I26/6R2/UY6sQUOrKPvb02lchPMJkVbe8+sb0M8S?=
 =?us-ascii?Q?B4cT9rkAQe9jSskHxiQ=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 13:08:52.3351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a872bbd-dd3c-48be-4e19-08de2123765b
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF23FF06C03
X-Proofpoint-GUID: yimjID_dKSzR9DWnkss551ZeozP_kuFW
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=69133568 cx=c_pps
 a=OvjpmfG2phmKxcO1Hl3QmQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=2-4Zkl8uiZLBMnLHTpAA:9 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEwNSBTYWx0ZWRfX5JCdD+gJp4E6
 +F8rjmbx1KrSl4+N8J+ZsCAh3KxmY9Or4gAC8IWcpQ3M78l/DYek4klQWhkkYFHKA9XNqWoHgrn
 a7rmPP4CteKhGq/AoM7KXIERhXEfs8GYkuZcQc2Ucm2SoW61rPMfsgNj3H6qQy3Ir4cqObO9/e9
 UIsvVjga4KsAHs48hCkdZgAdNw79k8wXU/Y61xDraHhU41bjeb6Ctw1VzL7H0XUMG0wOcyghcgV
 ZLZq7h8Ey6xpPTIwopj5w+2kCE2N+aEOZOaMVAwgnfsCHarAoa3/vlQTwU9N1ZC/mN3yHSEYTWx
 uQcmPH4L680dv5jW+VAqXNnB4H/DbvQ4zV2kdGcak3oxdiqHMOo3TAw4ja80nEH8ZSWQGC4/baT
 1V3EP4OP2EX8Hiymucuu00zCXflW7A==
X-Proofpoint-ORIG-GUID: yimjID_dKSzR9DWnkss551ZeozP_kuFW
X-Proofpoint-Spam-Reason: safe

These two patches add ALSA controls to support restoring factory calibration
during OS boot on ChromeOS.

ChromeOS applies calibration during boot using a process that has restricted
access permissions. This process needs ALSA controls for all settings that
it must restore.

Richard Fitzgerald (2):
  ASoC: cs35l56: Add control to read CAL_SET_STATUS
  ASoC: cs35l56: Allow restoring factory calibration through ALSA
    control

 include/sound/cs35l56.h           | 11 ++++
 sound/soc/codecs/Kconfig          | 14 ++++++
 sound/soc/codecs/cs35l56-shared.c | 53 +++++++++++++++++++-
 sound/soc/codecs/cs35l56.c        | 83 +++++++++++++++++++++++++++++++
 4 files changed, 159 insertions(+), 2 deletions(-)

-- 
2.47.3



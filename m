Return-Path: <linux-kernel+bounces-798184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C2EB41A6B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80D33BBD0A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799D42E8DEC;
	Wed,  3 Sep 2025 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="UX+EK02E";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="ANxXmczd"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2684252292;
	Wed,  3 Sep 2025 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892777; cv=fail; b=pkgFkZZvvsVYQEA/+C8LhRlSH+VbPBwK6CCq8kx9yceCUiZuDzq//7+Oxr2IaoW407FKlZH8pdvdd7tVMIx6RN6E8amz+E+5DB+3IIDiFMy2RXVdGDAOjksrBC8Z+clNjyfiZkyw1OKXnMOQbYkY3ViUP2OA6POrLRMv2mcbyHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892777; c=relaxed/simple;
	bh=Z+KdqWHXtXtqNVgpC4GhAwpKd/hEFegvXkRKFdmTa3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEYIzbNgLDFDIHPn/Co+r5pcm115ImfYkrRuwKxIPZNX+2/wp/emHJj2y8O/FrUxPFYeMctXVkp6/FlCiqiVEQWwmg5eAasfP66TcVlrcJNtBXJ2q/u6u8CEwaY+w5bmSjnHqJ6xZ+SEecGhuOHvVnaNHNo6U9jdJqyudpY1Iz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=UX+EK02E; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=ANxXmczd; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 582MFqVt232307;
	Wed, 3 Sep 2025 04:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=psW01e4wDzFTCB9A5z+yLmYM5K3NyfZcEMKebOfYkAo=; b=
	UX+EK02E8/YICLN1kIwElnkEikNihNwZKFsrZtdyCnX0x91WOkETj0JDaVCrd1mM
	2LKMJZtqyVD2goSwmQ+OnsudSmqB5rbJsouA0S6RtpE1+gdqBDCXRPGQFEGZm2s7
	hx/uZTRif1FlJ2FV1tk7fupo9obSvvlmmN6jGqWSBwStZuo4yFlthXSNLWS6ljNt
	76vHuB2qYvbotv24gLmqHCxyqXK29c8r0XYvwOcGK5BW9+9JtRcUfmWwB1a6Mzup
	16kYoWNOigNwuPJxW9K/kE50qzItLhclKdMsM7kKCinBlcefxJAPhoawW3wiDcRY
	UQ8+Rk3xmh+aGW/wgaQ1pQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10hn2233.outbound.protection.outlook.com [52.100.155.233])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 48vensc6d2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 04:46:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yt8Dtoz5JIsSstvC9hmiEUMlN2Z3iVGXieJvHadBhANfuuNrcDk7hXf3IHCsq2kWuohALo+hMOna+ey14U8DYkBiUW7z/6j79iqVY7rBW9h4njg/WzkWGWxiqLVxeCcTgyaoekW/X22pn2T7UEy2T2Zm9mFaklKjMNRqzqz1UAIaG5j6R8+3wJUxpypn1pxqGoxutHMbfAr9oXfrI9bB+P1LKCwLR9wTr8tPcdurWJ54oJ+USSJ3KW1lmR6ocDkaZDtlgtJ6ZXRgojOmRCm5i8MTT5B6JJzCCJLZq+extsdbrBrQbNQI0zI+ghiuE6cwgKUM4v1wLSiPNRi/Kv7amA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psW01e4wDzFTCB9A5z+yLmYM5K3NyfZcEMKebOfYkAo=;
 b=lw3UshU60MjoRjJbAdbw//rqxTBHZjk+yvn4obHZ7MdWHs70X4u1gLQfhnoamt9+9JTmPoiKIIN11ZWddm+TB+nF98iKkCsgUzyUYSkiltEwSMNR8zcMpmwEyUaXSL7UIJmTNBk0OyPJ9lFndYn3D/lLhxYZsoirdtNO85QdNqeJkUsQICWXQQpLIZJ/TVBDkv0qxe5YPITUTc9lq6AVnVbeRhi/E1OYooUARDQjk1zk4QkMwHouHVGHg7bcwUyb0im2QO+pjhN/y8b0u/9BVX3IU3uMrIh0v993B+vU/0FnDISXZ7EvNyz/EoRIsUWAWZOVEUsbd4afj/AVXcizcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psW01e4wDzFTCB9A5z+yLmYM5K3NyfZcEMKebOfYkAo=;
 b=ANxXmczdxK24CSzrIpjPFu7psZvhSRQEfpE0J4Eoh07WAkqZnpeaU3jK6POU5KPKHaagVvEVzKf59uDJpg5TVHXQ73Jc4EeFJD26bQgiTTkqjQlMqFd8E/PyFi0i1Pmr6qD4Jc1ZPHQ9HkMRv6SCk0XmFTtefKuJYttbgJov2lk=
Received: from BN9PR03CA0286.namprd03.prod.outlook.com (2603:10b6:408:f5::21)
 by DM3PPF7901E5E8B.namprd19.prod.outlook.com (2603:10b6:f:fc00::739) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Wed, 3 Sep
 2025 09:45:55 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:f5:cafe::b6) by BN9PR03CA0286.outlook.office365.com
 (2603:10b6:408:f5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Wed,
 3 Sep 2025 09:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.0
 via Frontend Transport; Wed, 3 Sep 2025 09:45:54 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 47A2D40654F;
	Wed,  3 Sep 2025 09:45:53 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 30E7A82025A;
	Wed,  3 Sep 2025 09:45:53 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org, lee@kernel.org
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH 5/6] mfd: cs42l43: Move IRQ enable/disable to encompass force suspend
Date: Wed,  3 Sep 2025 10:45:48 +0100
Message-ID: <20250903094549.271068-6-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250903094549.271068-1-ckeepax@opensource.cirrus.com>
References: <20250903094549.271068-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DM3PPF7901E5E8B:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d8ad9441-618f-4f86-30dc-08ddeacead06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|61400799027|34020700016|36860700013|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5lNu+r9cxFIc+wgeJ0r5flHjr78Fzl66rF5ayJHRiqDPqAynsSxUMUOWig34?=
 =?us-ascii?Q?rCziM/9mjtTlZRKqQz/a252ykdv8vbFlpDkUBJT26dN8a7wPanN7u6YBnrio?=
 =?us-ascii?Q?Gn40jxSMxeIu+Bmti6SjEx82gBBtAPLNRHA/a99dAMPYbuJ6ofUzM0+W1pfg?=
 =?us-ascii?Q?CO0Joaemdjq3gS32DylgrErDMbEVrlIzZMHk9yZtvCEIW1NPnkSXw5qi61if?=
 =?us-ascii?Q?chIii+mVykwIoA1l/l0E7at3L7CeQtDplD6yer4xAaiUnGE6Se+wHsFPgCTL?=
 =?us-ascii?Q?EpjNo1fuLzVN2rs6jnQGPC5V/uajm5Uv1BMh+MqTgR68RyeIiF8UUkf+hF0q?=
 =?us-ascii?Q?81VlhocMRblHUgx6agAPT8kq9rV06iVtcOkJa5sHvQUhU+YkbGE1Qr2kE7zL?=
 =?us-ascii?Q?4lBTfYGaic5R7wxN2mrpX3BRmyqXlQ2xvNpUREBWutv3lhueI5NVladMGDzw?=
 =?us-ascii?Q?iNi3EGJxDi3GBsuWERlK92W1jKSGcytC/qUEANNaqskwub92f/bitBKsErth?=
 =?us-ascii?Q?2YZHfb1jeSVMao8s1UepIMuZSlzrcAfR3ypLFW3VzJML7aeFl7KrjoFymyuG?=
 =?us-ascii?Q?+4h8ng5FQwAtExKeIKUtU6bf88UkjP5VSr6cXD5mrzVXoYX052x1Hnr2UciS?=
 =?us-ascii?Q?+zALi7LRUjsZsyDSZ7PTgZPGWQAjd1nLEl01ZjZYmNEJewxGncvHZ29ZsDlw?=
 =?us-ascii?Q?Ik4a4UG0xaA0uBWPgJpOKuJphVLeq9A+ZtBlBi4r9lxC6rHDEFKJlVhSeBWM?=
 =?us-ascii?Q?dZLVZ1g94LxJg/7Nxbj9NFRFLsOOw0ACy58/6ZwnmGhlmhn/+PDBp2sIYRxp?=
 =?us-ascii?Q?Kvv3m7RaERiCohKJbdmtzBFsqMbIEBSxj0XDxlX3yzVhqkrV/2DNxEKNl0TL?=
 =?us-ascii?Q?7qU+mNKyfWs5bs9GRv2fwFvCe6D/axi0MgAvmpGmrjviAc6y67yHYTV1Zobq?=
 =?us-ascii?Q?eFAty7A9/0OAHD+Xhd1sWGgFzusDBuoBc4bfqGFr/tPb+Mw3rYSME1uuCeRt?=
 =?us-ascii?Q?u3GxKorJ78M/J3mBNFU8MvH64ts1YAMHdbR1DgmRPFxlWb8V08tIOt+sEpQg?=
 =?us-ascii?Q?L7hVNpp72Hcu3oYbYoMErm09tgnt7tyD6PvgLXC6oYM48wNHJyI3eHHYAqwc?=
 =?us-ascii?Q?LtiHsAGDhQz04yvB3uIdS0mtkzVHalIE2iee6xPeDEjLvxNqtsGeKEOlx+ne?=
 =?us-ascii?Q?Qdih7B+jlE/1yqnGxLttQ1lMfIPA6i4QFLH/0/1RIhDvmtjk9QZicu41YImb?=
 =?us-ascii?Q?XRvgZMljQE4JZ0jIrSR+LW0aszgjoh155/vXVomZlPBk7T2mElYZlaEQsjyK?=
 =?us-ascii?Q?BtIAqQjNBEv6Y5EY9cpkeDAcmCG1YU4H40tB2+T1H+tJh/yIspn5ZzkRjqxN?=
 =?us-ascii?Q?iAdFyKb6rE7SD9ppOqycnNGFLCHAQMiDClPTbYd3uEkyAfbE46fBS4tyXULQ?=
 =?us-ascii?Q?+o1tWg0hOT5JGEJDQG+uexrIC0Rh1b8/wy0vX0mLHY57TL1K3gpB98mCkDwQ?=
 =?us-ascii?Q?tkl0Xs8sElGzQ4VMqnSdeTKKN/f2AIbPmkaY?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(61400799027)(34020700016)(36860700013)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:45:54.1309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ad9441-618f-4f86-30dc-08ddeacead06
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF7901E5E8B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDA5NyBTYWx0ZWRfX20wGAVcmn4Mn
 YFY19q2DYrPYGDW529sIoDOe8jblgYWWWbGxcSPgu1M5sdeWRve0kWO8vOIrGUdo7VXEzPAqVpK
 jLr/9Z5rsJA1QxP18uL7TJi0Wy2mxQyIwI/5cvygdHoq99N43ATmPJT5KYmGMogzhmPhfzSj3Qm
 SCqKxq+nmFGP1AU6TLefolqeYXll3HcFLVMmR93LsqMUaBxuWd7EL6dQy6OcM3DKTO98zoL952z
 +X1zCcHPvLEnlvvFpeNCHx2jH+jiKF5KVIpR++Y5hr4pmNyHHVsTlTm/SAyBTe/KxDv1LCvOkr9
 L4bAygVjVbI/rZFHZpaxYPf0aTvsnBjc+sNWWe7K2S0SX1gX1/msIWB8SFnHxk=
X-Authority-Analysis: v=2.4 cv=BY/Y0qt2 c=1 sm=1 tr=0 ts=68b80e58 cx=c_pps
 a=CfqBWRf4+9e7MFo2XvKxkw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=VsvriT7Q5KnHRFWTihsA:9 a=jZz-an6Pvt0H8_Yc_ROU:22
X-Proofpoint-GUID: 8QdrX3IgLAXVmHWdkguTPcAr91_7z44W
X-Proofpoint-ORIG-GUID: 8QdrX3IgLAXVmHWdkguTPcAr91_7z44W
X-Proofpoint-Spam-Reason: safe

As pm_runtime_force_suspend() will force the device state to suspend,
the driver needs to ensure no IRQ handlers are currently running. If not
those handlers may find they are now running on suspended hardware
despite holding a PM runtime reference. disable_irq() will sync any
currently running handlers, so move the IRQ disabling to cover the whole
of the forced suspend state to avoid such race conditions.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/cs42l43.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 07c8f1b8183ee..959298c8232f4 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -1151,6 +1151,8 @@ static int cs42l43_suspend(struct device *dev)
 		return ret;
 	}
 
+	disable_irq(cs42l43->irq);
+
 	ret = pm_runtime_force_suspend(dev);
 	if (ret) {
 		dev_err(cs42l43->dev, "Failed to force suspend: %d\n", ret);
@@ -1164,8 +1166,6 @@ static int cs42l43_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	disable_irq(cs42l43->irq);
-
 	return 0;
 }
 
@@ -1196,14 +1196,14 @@ static int cs42l43_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	enable_irq(cs42l43->irq);
-
 	ret = pm_runtime_force_resume(dev);
 	if (ret) {
 		dev_err(cs42l43->dev, "Failed to force resume: %d\n", ret);
 		return ret;
 	}
 
+	enable_irq(cs42l43->irq);
+
 	return 0;
 }
 
-- 
2.47.2



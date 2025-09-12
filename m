Return-Path: <linux-kernel+bounces-814435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16966B55412
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F5C1D65840
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22FA25E448;
	Fri, 12 Sep 2025 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HNGpzhA9";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="S+/pqMlp"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B1223C8CD;
	Fri, 12 Sep 2025 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692112; cv=fail; b=crV5D/MRqghifZ+YS9hNUuSzBSd2u65DUkq3Ck2QAUbdrV5xaXeqDYpB+SFzvc980fyTX2Cq+knsDzKhKivQ+gIkubfoKnf+YdK9XFs92bITEM6Tfgq7cF0cwXeZq+GL1WBxwTr8jjXyf2C5AhlK0uVHT3J+Rj/6BO8g0YXU/7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692112; c=relaxed/simple;
	bh=Z71A7T/4k+ANYtestCIMmxwBFPXXayN8iWUZfgC9u3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTUETTDvwadYRzkyRlWTfHf5HvnL0QdtgBCOzn1ED6mjfN213faWBCixQpDU9UX2sGpFH1QuBFFNA7YemVRDKmcDvTMsywz9fT9FkrYsa1dSoPFxweDW8ZpGbU95q/iRqo8yinQ7flBkbK7KfbVI9DrBWsxo73boVSq/Pb5elD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HNGpzhA9; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=S+/pqMlp; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58C5wnF13620853;
	Fri, 12 Sep 2025 10:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=FKoDupw6iAZh+442GD4UOmv+03loFRrD7e6ENv+GptU=; b=
	HNGpzhA99bnzWRr2nf5CkFecC9hvUBvm4G1LylFZnm4/IL1zLFQQUmsB3hoHeKha
	Ova5EVhRLHfHkc5N2CMT2R7pefmqjZZ963DNna9Jn5Nj8Pig3C1V7okX7veiJ+As
	05NmnuS9qRIwO6Hc7xkAuiBBeqJp0ZCPpFPhj0P6UmTDs36QEnf3vCyrTuiTaeix
	tiuMSIs0YAwDi1xOyosAwHPuvfDvG4lNtvoJh0+MB28twj8aA+TTrRgbaBRx7Pmt
	52JBfbxa0NmiXAGZdS2+1ApWR4GOIbpIAMtc254QjAmjsU9b2NDeB8TrUEHensIa
	HPRqNL8+qF+Q0wuWey1xqQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2127.outbound.protection.outlook.com [40.107.244.127])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 494due0qxr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 10:48:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZ8VfTSd+EV5Q4d8KSfc5KnYvD16hrseBrpFpsnroyQwzA7L2zUsg6VFZ70IueoXf/ewsj8zatD+dOP5WPEVU/e9kxJC+OGBRiaShXuRGqgKGG6fpXinrOa7jL4sfi+UbkB8DmqXQ+s2wys1AJJajs/l/RBj9yBpHdEngDyz7Y2FcNJgZZUJ5GP+WT5Kiarag4QARoun+OaJmTD1QFrDFLONAEOmA3E4N2ewKlkLhz3CgwHC3nlGV82o/dPt66QULQ9VcGiPxR6ZgEsKTkJrj/nhA+ZvnmrYOQLpn9iXN2t6XydBuTzG18xChwjwnZk6iKHtbE6yvpnH6Yi6vLEH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKoDupw6iAZh+442GD4UOmv+03loFRrD7e6ENv+GptU=;
 b=DLM9XUDVzmvfgniLrUpXm0SwTW0ml7lfVd3RroDKb+QJkmyDkFz21z5Rt6Sdb84vomTvNVUe3H7NVxpjsZuEYkO+q31MF/jx68knz/EP2M19nGA6w1YeIfIM6/aulGEd7R8pgy7ku0QfwWIPPhhYdkgEum/xiK3paiLcZT8GeGgNo8CiFut1jBk6kKDANDUiCVwZMXKFVpriz00t4+HPhOBV+y0+l0feZkVQLeqRet/aBrzImxC2o4BKgp+n7GCFmHF21fgVhCkM11VfJHcn/YZMNMXKWJPzoYtdGTKHP35uWD+FgNX4QFgXSVBDDcgx6pIalPOL1dvooLkYgmh2rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKoDupw6iAZh+442GD4UOmv+03loFRrD7e6ENv+GptU=;
 b=S+/pqMlpLG9R1EGPE09SG0ziW34RYmNH/jojjUwrUSaB1l3RyJt5/QAUek1lytJKq71uxqEJITXdvMoHxXYA84txNwNNEzqWG3oKbN5DAIknlIKna5254RvvrbcMQhcV1wSCqPqOkjvuAOdbZ+3eZuqM6von8HUjEx3H97Jy2Xc=
Received: from SJ0PR13CA0075.namprd13.prod.outlook.com (2603:10b6:a03:2c4::20)
 by SJ1PR19MB8285.namprd19.prod.outlook.com (2603:10b6:a03:488::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 15:48:12 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::6d) by SJ0PR13CA0075.outlook.office365.com
 (2603:10b6:a03:2c4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.7 via Frontend Transport; Fri,
 12 Sep 2025 15:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Fri, 12 Sep 2025 15:48:11 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 06595406545;
	Fri, 12 Sep 2025 15:48:10 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id BD66A82024A;
	Fri, 12 Sep 2025 15:48:09 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 2/2] ASoC: cs35l41: Fallback to reading Subsystem ID property if not ACPI
Date: Fri, 12 Sep 2025 16:47:45 +0100
Message-ID: <20250912154759.279661-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912154759.279661-1-sbinding@opensource.cirrus.com>
References: <20250912154759.279661-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|SJ1PR19MB8285:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ecd33d5f-a47a-490c-4f4b-08ddf213c733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FLyX2kApyG0zRv+u9EPE0t1GsY1qbjqOTkEeF38Um1fIiWpzJ5zDnt8wdJGB?=
 =?us-ascii?Q?+rcc6PIzf9HzvkNbq3wS3nmD6TxphcIMjLL52IsdP9NBC6FNV8F9E5RpFmkc?=
 =?us-ascii?Q?TVbbrBgzN2u4l72MtlC+JJHxCxFxj2zPE2QfZF7Px9mhlBBEt/sVfNlfP010?=
 =?us-ascii?Q?cwC/b4LCE9YmtN0MpIr19+u09/tLM01ha3SXBA1RW5eSo5NSEC8k8AHaG+IP?=
 =?us-ascii?Q?sa4rDcjMq1xIpSaFJeR8V2rV8QIiJgVPIzRNllbVMXqvfKQJV3h/q/deN7S1?=
 =?us-ascii?Q?8JaZtsYkM1E0XIReH4qklYN0liddXx+p3h6GNcHPCg5UO39B9KKm8LVHQnKE?=
 =?us-ascii?Q?yORo2DCN3xoQdahc0GeKK0c/KEkBdHCN66AEnYlZT17KqDmDPdYNfnB1mnNH?=
 =?us-ascii?Q?NHJ/WL9T3xdBV20qJ4hlT2U+gDWHv51kVAXrGDghR4XtPc2FrSdyXjSq9YOG?=
 =?us-ascii?Q?0y25kM9Rxc3gpVtwNbza0jEw+hdQoh/bwS88dQB/YxsGQYN5v5TLVYxsLbcj?=
 =?us-ascii?Q?cPVOjod8Mwgkf9QvMcytVU7ygvAltiWgTpiK/hq0a5uAap57fhwwLHvG8SnD?=
 =?us-ascii?Q?JRiVnWu++7z9MvHxoRRju+pnE1o4IdhLBK5bLUb2VWufbem9Vo0zhrXH/sdL?=
 =?us-ascii?Q?vMudn1yC1W37QdJj4PStiQcSWroCrANmRuPdTJ83c7zTx+t/RGBk8tXVVr0S?=
 =?us-ascii?Q?DorhNjj39PPJNn9hjI6f1BArRbbSEHNlIjOIzG/xEKN3OuSCh0o7iWxUMy8Q?=
 =?us-ascii?Q?gqw7AZCCyRZxYONMfY/j4Rw0QQ25aXfYuRmF8tvh0pWN6kcMPowj0ZUh22f9?=
 =?us-ascii?Q?Smha+mIHGiRdY6YmDNLWdNvXwqY7KjW7fQ8ER4wUOxIessInxk3RidJbEgbV?=
 =?us-ascii?Q?TQcyK6govtiiHyQwZh+lTd5ck2LRt92j6Uv9DoB8YlJp8bBfF01eA/MLHRxl?=
 =?us-ascii?Q?qUeEXILMf6EOiwHOBsJg1f/aLwg1LRVVLBU517kxku3FD7D5a7hK7gPvFZ2d?=
 =?us-ascii?Q?GyYvOQ/aCdM6ri2MZhS41TGZLCrY0UrFHwkjmFBS0qS6baMflWOTUUYS/Uig?=
 =?us-ascii?Q?YLC5uqTUF0LeB9dMcHBd3EJrHfInf2uTBdWr6LgnWJg4VxrBJt8OFVP2XevF?=
 =?us-ascii?Q?l1TEURqy6NnHqU+zcp+9CYh0X362/RFTaxxlB+bqCEqve0sJnKjGJPcjJPis?=
 =?us-ascii?Q?z7GkJDUpquBL3gZcsHQ88o4WpmCE02YYYvDnYm/d8dmSLm4uOaklZSIXeT+w?=
 =?us-ascii?Q?wBAvAsilVMCXYhCAKYKw3+m4iWaFq7OH9IOVIwcJk621U+wiBrlqzqF4uGdc?=
 =?us-ascii?Q?66gMDnTnl6jzHUC6/FOfPNrou4lUV0yqKCCaodLaiq9zLQVOvee+oT/RsG7Y?=
 =?us-ascii?Q?d/mRKWWh2Y8+Cn94Xaz2FkbrCrcGgXCThSenNCf00QWRyR6HYbaBjAMn/0KJ?=
 =?us-ascii?Q?3pKS5mVRzH2gySt2QQ8vL4cmOPRMUIx2p1frUrBpKdZz5nzOHo4awR8GYlTF?=
 =?us-ascii?Q?e1C2e5b+DGMu4f+U6zVOCJjBO41FXn0BGE8k?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 15:48:11.3526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd33d5f-a47a-490c-4f4b-08ddf213c733
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR19MB8285
X-Proofpoint-ORIG-GUID: Y2Mh7km1UAX4nP2DZUEEE1-Mi8cM6_vq
X-Authority-Analysis: v=2.4 cv=F9NXdrhN c=1 sm=1 tr=0 ts=68c440c0 cx=c_pps
 a=yRxw5LEADDr8z8nXSS54fg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=bL0rdlc7CeB77TPmB0MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEyMDE0NyBTYWx0ZWRfX4QjXOQxi2SXx
 rw7mghypLeBEDOPVpBvzF4zlcRNfFMyXbX3QrDNGSjmEPQdbGPtVhkQyag/g9/h2kYZg2BRYbk9
 CIh4e+vA+3fvQJkor2hTEcDjOBVx9CcQ5TIDNhZfrUzCKA48zfNUuBKE6uEa7dZEqUuiMpQ8IIi
 WOw+Qiixdr2Hhc39qpCQX1+Z6CtOZV9zwIdtTQqWffE4DuSXdZ85Q3NyLGkKM3ry58CneMHVfbD
 NP1AL5Vxd8N/3QyRQRVI+k4lbTvhS9yd7QELvYXgVbISkm4SdtfOYRWIKoZqlWloNYJREX+RdiJ
 BOsVO8gOh3CGHqxvof7IUPEf99waZn/gk57HY6yT2jusCDPIgvgpB+AJTrdbcE=
X-Proofpoint-GUID: Y2Mh7km1UAX4nP2DZUEEE1-Mi8cM6_vq
X-Proofpoint-Spam-Reason: safe

If ACPI is not used, then there is currently no way of reading a
Subsystem ID property used for a system name to uniquely identify
the system in order to load the correct firmware and tuning.
Add a new property which can be read from device tree to be able to set
the system name.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41.c | 77 ++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 224d65987a8d..d7e3d89de652 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -7,6 +7,7 @@
 // Author: David Rhodes <david.rhodes@cirrus.com>
 
 #include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -1147,45 +1148,55 @@ static int cs35l41_dsp_init(struct cs35l41_private *cs35l41)
 	return ret;
 }
 
-#ifdef CONFIG_ACPI
-static int cs35l41_acpi_get_name(struct cs35l41_private *cs35l41)
+static int cs35l41_get_system_name(struct cs35l41_private *cs35l41)
 {
 	struct acpi_device *adev = ACPI_COMPANION(cs35l41->dev);
-	acpi_handle handle = acpi_device_handle(adev);
-	const char *hid;
-	const char *sub;
-
-	/* If there is no acpi_device, there is no ACPI for this system, return 0 */
-	if (!adev)
-		return 0;
+	const char *sub = NULL;
+	const char *tmp;
+	int ret = 0;
 
-	sub = acpi_get_subsystem_id(handle);
-	if (IS_ERR(sub)) {
-		/* If no _SUB, fallback to _HID, otherwise fail */
-		if (PTR_ERR(sub) == -ENODATA) {
-			hid = acpi_device_hid(adev);
-			/* If dummy hid, return 0 and fallback to legacy firmware path */
-			if (!strcmp(hid, "device"))
-				return 0;
-			sub = kstrdup(hid, GFP_KERNEL);
-			if (!sub)
-				sub = ERR_PTR(-ENOMEM);
-
-		} else
-			return PTR_ERR(sub);
+	/* If there is no acpi_device, there is no ACPI for this system, skip checking ACPI */
+	if (adev) {
+		acpi_handle handle = acpi_device_handle(adev);
+
+		sub = acpi_get_subsystem_id(handle);
+		ret = PTR_ERR(sub);
+		if (ret) {
+			sub = NULL;
+			/* If no _SUB, fallback to _HID, otherwise fail */
+			if (ret == -ENODATA) {
+				tmp = acpi_device_hid(adev);
+				/* If dummy hid, return 0 and fallback to legacy firmware path */
+				if (!strcmp(tmp, "device")) {
+					ret = 0;
+					goto err;
+				}
+				sub = kstrdup(tmp, GFP_KERNEL);
+				if (!sub) {
+					ret = -ENOMEM;
+					goto err;
+				}
+			}
+		}
+	} else {
+		if (!device_property_read_string(cs35l41->dev, "cirrus,subsystem-id", &tmp)) {
+			sub = kstrdup(tmp, GFP_KERNEL);
+			if (!sub) {
+				ret = -ENOMEM;
+				goto err;
+			}
+		}
 	}
 
-	cs35l41->dsp.system_name = sub;
-	dev_dbg(cs35l41->dev, "Subsystem ID: %s\n", cs35l41->dsp.system_name);
+err:
+	if (sub) {
+		cs35l41->dsp.system_name = sub;
+		dev_info(cs35l41->dev, "Subsystem ID: %s\n", cs35l41->dsp.system_name);
+	} else
+		dev_warn(cs35l41->dev, "Subsystem ID not found\n");
 
-	return 0;
-}
-#else
-static int cs35l41_acpi_get_name(struct cs35l41_private *cs35l41)
-{
-	return 0;
+	return ret;
 }
-#endif /* CONFIG_ACPI */
 
 int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *hw_cfg)
 {
@@ -1317,7 +1328,7 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 		goto err;
 	}
 
-	ret = cs35l41_acpi_get_name(cs35l41);
+	ret = cs35l41_get_system_name(cs35l41);
 	if (ret < 0)
 		goto err;
 
-- 
2.43.0



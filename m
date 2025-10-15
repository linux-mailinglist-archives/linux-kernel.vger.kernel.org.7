Return-Path: <linux-kernel+bounces-854174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 644A9BDDC59
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38305501D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC93319611;
	Wed, 15 Oct 2025 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Q788+6xE";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="0H9p24zh"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D1302CA2;
	Wed, 15 Oct 2025 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520427; cv=fail; b=XY6drcYZO+dTl/JSbQBkXXgdcfnd27PdCp5FLB+6u5Yzu3SHxvKFaNLyZiB0gsExgCIU7beaM/7iYExEXUECsLJ1Go2NVmuM3td/yMZhy5ZhBPudzuAXvU6M77Y7d/4x6z8s1ZbLb/TX5iSWShS0wmdtUz3gXWuGhCzzdQQ3ZwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520427; c=relaxed/simple;
	bh=sETBrTz0WSZK5xJiHJ7TzKvKlN4JMmty0GKZhFX296I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulfpc8WnH5auwi6i+Cf1sKhRe6ZALrwafbfPoygEoA0XwdVNITwM+Onc+JrccsDW1l4zrJTv4hi3vspaJfu8W27aXvssbgd86JZGP47gcS+3xCQQEHPJdrilMtGGW4vP/KN1gU4TasngTUAgs0o3+HeEYvQsr9aeTP0GhMPaRkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Q788+6xE; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=0H9p24zh; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59EGKkxt1729701;
	Wed, 15 Oct 2025 04:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=zfWfBGjVWlMqFZc4lQW5mQqeMDBAChjRNbkhm5HKhXA=; b=
	Q788+6xEfsgtFBSSmvXnFAx9Ao2tHVdoFMWLZNYQqV13geAGahSyfYxUdaLhpvIc
	0cgJp+4NeZLAQzkAHv8cZ51TO75ON9rJH8HqL+kcMtQANgYRXur9IwLH1RG9fELq
	K0J1Js4wIiSJSfwDs/Ee6QHNKYm5uADT8Q6QKVRdONOdIA9NBAs33FodtBQqkskX
	FRmd42Ai1WI3H0q/liODQX94gvJn7GKnW5R7EEqND+gh5fkjrywsDhdmSjJMzpLZ
	gdCprXU6KTZyKc8XgJ/MASyEzyM7rVLIAzN/HtBK/QR2lCPUPPRRBQuTDi8jKUWO
	XywYlpZ4yGA7+vs4iOKkMg==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020096.outbound.protection.outlook.com [52.101.193.96])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49sdb42fm9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 04:26:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYRVQWbJERahnak1jcuGVGJl8whu4A7ag1iQEpq4ctBb34bu5CIz2B5Zog3YnBExuQYH0N7BrKZRI40zI6F58dL1B9+yA20BtJ5VfIIKOY8t+w7tKHZJFobidu8sZvO4W/fBF1fspcz0ZGn15L+Irfyj6n0IXmsB4jIF/y5PK0xj6yLbLxTYV3VY3BA58bPYuKbRFYqhBbvhTima3lEhJv8A4NB2HLKYeHs6Mj2AQyBfVXObiCPvX7eV1BJtLtKp0rv5XsN/dOp5S+XXJRUfAn+G6q970By/9LS9KDhjrJ1zP8hMfnmTe/w944pLSFYGRNJmkF3mHOwhHISTHHaxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfWfBGjVWlMqFZc4lQW5mQqeMDBAChjRNbkhm5HKhXA=;
 b=rbpdced5OwcozAUuyYPyZlOGa9/xRwTMd672I4isEByEW67HntrPw9iINzRytvO9+enmFPczW5mMMetouYwsyglvmq5u/gEG3N5/zkukB6550a821Jv/G8ENv3JhD6BWT/w5qILSz8id6Phra5jv5lbvXg0UW8TRgTMg4LgeapnH92oiK75L32SHTv0WJAk5TIiXnAWtyVvhKGtm3Z7HUTAGe1MgQV4K7MUZ8Rach41oobAJISH8q82VEU04ZxjOTxJ+ItNT/PrqWXormSOznqESY7/azsELDZki65PZsu6SparoFmqS01pe9WGuxQnsurZuirkjpXqKwQH+aFtGbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfWfBGjVWlMqFZc4lQW5mQqeMDBAChjRNbkhm5HKhXA=;
 b=0H9p24zhJKSA18hah+Nw5kvSnnq9LK1G5TTszyMyIBb21NQMTKBHOYrauEY0vCfwHo3N7jELvl8C4XCbBrFjCN40HKVhpzvB+kKqzBWBIy/LqTDMmOteX9G9q/Jxe77BIdnwczKR+atMmz/b3GwPQxy7S2xCz9URGXn5B9eOKoY=
Received: from BYAPR05CA0056.namprd05.prod.outlook.com (2603:10b6:a03:74::33)
 by CH2PR19MB8874.namprd19.prod.outlook.com (2603:10b6:610:284::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 09:26:38 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::a8) by BYAPR05CA0056.outlook.office365.com
 (2603:10b6:a03:74::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Wed,
 15 Oct 2025 09:26:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Wed, 15 Oct 2025 09:26:36 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 976C540654B;
	Wed, 15 Oct 2025 09:26:35 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 5CFE3820249;
	Wed, 15 Oct 2025 09:26:35 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH 1/8] ASoC: cs530x: Correct log message with expected variable
Date: Wed, 15 Oct 2025 10:26:04 +0100
Message-ID: <20251015092619.52952-2-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015092619.52952-1-vitalyr@opensource.cirrus.com>
References: <20251015092619.52952-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|CH2PR19MB8874:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e0b42ba4-278a-4593-f9f6-08de0bccf0b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TfRgH2FiVZhW4NlTVC3iBjF/nAN1Ev98jvpHticaFX5O1bVJoJ/e1LxZVlYJ?=
 =?us-ascii?Q?bLWxS1iEo8igFXprGZCcGHNhlDdPn0HwFdpoPvvo2b0HgofbmGJVWHQEANLf?=
 =?us-ascii?Q?Jt9Bd/uZhJYAJbR563+9lF47UvPg3F/xlOv0vqwn1u72W5WhrnHaRmNYiyL0?=
 =?us-ascii?Q?jIm6FAVW2V6BX23T95OA4jj2SE/NJ1cbV3DJodxgnjFVQ49+AiLhSNrfF1A2?=
 =?us-ascii?Q?tTtktWxYzcj3YEYgl3TPqMunfl7vIYhWLoj18SRZUqAg1fIK68r2J3rHjcLX?=
 =?us-ascii?Q?fgg6hzibLkP1dyCIZ3SY5eXBoIeOY2k+Xn64H02ilsu2hCYp6uz/wUE7+e6g?=
 =?us-ascii?Q?CxyPtVJ16uODRIMYHMdwKqPAwHiNj28KVVIm3Vb6fwReF5SaSiQSWFVYPZtW?=
 =?us-ascii?Q?aNvF1Mu5UzfLJnu9QkctAOz6lVynE9De8Mnj3Guar4R8Q2SzdSX0qySH50aX?=
 =?us-ascii?Q?TnYoRRr3gIALoCwfBvuBJF6tYgqnWe2lUbo8ZJQUDW0OjUMQip2Cu/7ZRzB6?=
 =?us-ascii?Q?3VivZYO+x/fmRtSwii4kNKEnBfQrNkwLQy3cq7X6W/1sDrmfXeNGReod7EHG?=
 =?us-ascii?Q?uOa4Nvlm5zpx6jTNvc4zOxR3DzYoKRyirsHwywhK1t7OCRbtp1uQEH7aqV1p?=
 =?us-ascii?Q?fppZA7gGsI273hgMw7TSbKEqNXFCcLMSBnEvgXt2kBCUH+ELYOP0qrd2KI0t?=
 =?us-ascii?Q?ITMsNHylwgSb76csu6/6Nnv8TV5+3p8e/5gfXxjDuK1cQ0z7L2gdhcUYPUmu?=
 =?us-ascii?Q?lvTacC/eNa1VA2rvWd18/FXa8TuJRrvzJm3GVddRzqCPVPIU3/MSjq0HV7aj?=
 =?us-ascii?Q?gCGKeEh9PRhEBdCqxKxCgBqTNGsR5mBHzgrIqkNGe3jdgmdemOfZycmElr7U?=
 =?us-ascii?Q?ANt0yR89udyj3tbMqO+rKMwrr53hzObxtg2QyAlitKuGhpkgmlVtcIfZZ8Vu?=
 =?us-ascii?Q?iIy9duPfJ8pnzlkbst0j8rx9iHfwb6RmW+JcLnel1Mxfd4Dnef97nA6sKoz1?=
 =?us-ascii?Q?Ac+qZWXkpl379iuuGVay8BxRhKuCgGldEDmyUMNxFpk1VdiPpcVMbf829c7l?=
 =?us-ascii?Q?5wESvE6oFuuNj9uxtm2BXth8C/LKyslsz9uJWlV902dZYbcuR/QHaikYgGma?=
 =?us-ascii?Q?wuAizvZFBvBMMfvja+8oOt2xaYMohn/CjnBssSC5X2/UvwmV2fOOcaDtdZlp?=
 =?us-ascii?Q?5LD0fXRmFbPeJ+gPqw3EJvUXPon2BAmDWHbH4EbUBK1iSTd5Zsm5OBdJR/WJ?=
 =?us-ascii?Q?Bt9hGfmwszSTXRshyBnyk9Wdvu0T0pjGpziRgTMb02yQIE6pO+UmO1oERAG/?=
 =?us-ascii?Q?g4ykFzkjeAPqj8ETqYJH8e2SK6+po/0ztFieLmUyZnXY1eaiPhrYz08A1HOm?=
 =?us-ascii?Q?3XI5MAp4gk2GtnguKuWqy/53K2DIov7pZICQbOW+6mbzzr+U6Fs/+UYDARF0?=
 =?us-ascii?Q?rkys7k8LtT8hNlk4ytT+WMNJADUqs5mAF+rf2kur9z11LEMuvOMzBzWvj70Z?=
 =?us-ascii?Q?jymxHfKY+/EAlHcZv87y27i5WXdjA6KuPMeRqYH58Pc/m/0Lwp6n7AnpeKjJ?=
 =?us-ascii?Q?OGJN1IwZVpVtp7LYSn8=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:26:36.9748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b42ba4-278a-4593-f9f6-08de0bccf0b9
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB8874
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDA3MSBTYWx0ZWRfX6QFovl86W3Dt
 Hz/hB2Dr9wTOPTKB8lu9Ex1Qgg5jbaqZqx0FewN8CuCZw/n3UHARAx5phoKyfDigXxh153gwRyH
 TcJgJh86yzXeOxec7h8oz6AF0ztB/842eicZbVPdmLBvnarP3qdbLheh82F0G5SNTIjFTGs/H0A
 bDdXShVDcxxedMGdIjHnUTvxHMyxmXU83mBIL9q1GwCDaEpN8dvSut3POfMZQNRZ9JiJUCbW05R
 oQO84OW2cK9oa5oGtfkF3RtyjKYMl0SOyqSIbyVSHp+C8CiNpVivuTZ8/p0J2n6OqKBnoULge+i
 hrs9GqgL1TwJAt1NsWcUJXep1oTEJz+GpKPO/Wc337LYd7CXv2ijq+Ka2u9K5I7SfB4DwconJVU
 LanLccdU84e1/AXgbFk6Ku+NRfX75w==
X-Proofpoint-GUID: f0pwrqcULZYkQ5_6d8GVhV527reYTcJ4
X-Authority-Analysis: v=2.4 cv=PPICOPqC c=1 sm=1 tr=0 ts=68ef68d3 cx=c_pps
 a=MqV4IWmEIBS0iwloPC2gHg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=w1d2syhTAAAA:8 a=fA_tj0b3XXiMLJMXCocA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: f0pwrqcULZYkQ5_6d8GVhV527reYTcJ4
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

The function used one parameter for the switch statement, but logged a
different parameter when it defaulted.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
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



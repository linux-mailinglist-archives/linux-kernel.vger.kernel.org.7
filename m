Return-Path: <linux-kernel+bounces-856645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EC4BE4AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33481A66CA7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B6A3570AE;
	Thu, 16 Oct 2025 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="i5JBR7AY";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="K2Reb1gN"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A41C32D452;
	Thu, 16 Oct 2025 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633359; cv=fail; b=S8m74MaOoad5x8AP0nUkfMDYWT+KmeYuhEHgp2/rTjveT/sLqY3Yj6FJdHtD3snLPafYMHLdIANJh/x0bXIC0l/21+u2NFMAkfVSNi/KrNPVOiZaoYfNugh+z3ExlDc1NDFbzJi0e6vFnu9KPnG9Ak1CwDy70bx8Lsuo3kS5EJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633359; c=relaxed/simple;
	bh=a0xbbPhJV6WCvc+c2G2xOHWwlKNuPSAr5JUlCNW5Vz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JbZ/rNmiihtozH/m1yvBzGvX7Z5rphX9PDLKIWMYVB6POx0Q4jckAMvxN4SS34ow3oJULNHiA8diELOtFhe4pwblWqpLl1GU7dTe9RLCJXzL0lEBoXclskFG6TbbT4y+/oZQKoQ8d3uKVgdaCTLutLKMXFPuAsNF1LbMQeCsUxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=i5JBR7AY; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=K2Reb1gN; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59FNj9KJ298651;
	Thu, 16 Oct 2025 11:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=CDoyyxXqya6DChI8Uu/FCa7bZGLzX4UWT0ihRm0yw2o=; b=
	i5JBR7AYbQq8JAOU30jFS5b6zKE5ZDSX0IxkhL6yOrVxQachyQtJF+cUhtgazqoX
	9puVdLaanh4FPNQChDJHrGMs2FlTamCvYBVSSamCbvHxuU2NY2aercQQKStle7U9
	RhWy0K4pG1uA3B+25MAMiPhD24rypR40R3oz1dTilzhnKky4rtQs5HPC21Ke7yLA
	vJMEnklOUR78FnszAKXvfZyqr/z73c9oyMZwypCX+jsUe8iK+jTDODQk3sOKV3R6
	Bq1Wd79JB5eSdPN5w5pmyoeiEd8aIvyPiyqzxNMNBhtuoXsZ89YnmoEffYZZKSsJ
	HEtt8ApSdeeFFAnSKhwaeQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022121.outbound.protection.outlook.com [52.101.48.121])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhj91v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:49:06 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+KBsHJ+4uKjYYwAZMn0dHqNOEMr3Be8QcJ2lKUMOCHceuyn9K+Nx5eZeUV9WO68TOs7Y1wiTU5FnNv9PdJCHp4dKptHfQoDWVi2wNCi35rhK7b61zF+sZ1giBEvk7nOvcEtHOG2vS+Ms5r0uZ6aGQsONnYScxT2wZj63P7VWf8uRXcWsj8My2ORTm1Woqhd/NTvUFvvMyZjGp8QbamZi1CKml14UEblV+TnNmrWuqpxCiJNc0bA+rzC8VfU7cuwHnkfSAmdJHMJx4q/yfSC/GGaLJGT2CoKki13RQ3GYVjKV/hcIravU1ZAroXlnaUUCXfhDWqQITwpoTKelVZp8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDoyyxXqya6DChI8Uu/FCa7bZGLzX4UWT0ihRm0yw2o=;
 b=ZY05FHvEFbx5YAM/+x/5xU/i80Z6bzVvSUwbKATeUI4F+vsllV95bfofboBdmdJuCe011uIIcC+cFWOrp49+/xMvrKr2Zwo83FcuQ+C9GM5pfK7EEgXJZyS0GLSzeQIBVKfR4L9wXCSN/uz1mpNo5xlBfSQV07z4qJZxbZeyvUfT3QS4aaxdyY6KZAImPrRCyF0l6HwIWgyoZEiKz6A9d3S90OnQ2z4z/hOXjbBka3EQYW+nyKq8Iid9B1w0+lLl3cu3xRdGw8kX2XpxdCFAbvu0AOw9YwjAQzOZibsqhtWKkOmCcV5Uo43/LOXKqfUaPtXBVMBJqOQUQ2wvCF7CkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDoyyxXqya6DChI8Uu/FCa7bZGLzX4UWT0ihRm0yw2o=;
 b=K2Reb1gNLmtWCPhTH/EyJVCOjDlj+SaRXOZmhh16x+vJdJULCP7Ejxqh9P4h0Nn61og8pUUcB0sRCfW1oxl74BI5cN3CpwyrwqcjxNA5xSQ+Fk4bhX0UIx1xV5FEtIzrcHoZ0iWa77WCCUfpmcesY8l7OPKnNBrlBSUsyWfDiFY=
Received: from SA1P222CA0103.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::7)
 by SA1PR19MB6720.namprd19.prod.outlook.com (2603:10b6:806:25f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Thu, 16 Oct
 2025 16:49:03 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::72) by SA1P222CA0103.outlook.office365.com
 (2603:10b6:806:3c5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Thu,
 16 Oct 2025 16:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:49:02 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 3CD69406561;
	Thu, 16 Oct 2025 16:49:01 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id D3040820249;
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
Subject: [PATCH v2 07/11] ASoC: cs530x: Check the DEVID matches the devtype
Date: Thu, 16 Oct 2025 17:48:25 +0100
Message-ID: <20251016164847.138826-8-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SA1PR19MB6720:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 721887a2-bfdf-4dc2-63ab-08de0cd3e99a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|61400799027|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?siaiKYTg0MELxPBeKuK/lDLQfNK+6Jy22JNcU9elQNWDZr8dG4NpHtyh4a7D?=
 =?us-ascii?Q?86R3KES/6pmN4tPmU0jZU4mKAqDeEmvCE7RtPnnu0unZ/yFF2rzyK7MG/9cC?=
 =?us-ascii?Q?kwZQq3vP/pwBfssBCHzH5AAKOehlKYLuW0BkWBDMsV3dqtVENZkpwvL5SGKB?=
 =?us-ascii?Q?1kEHOa2oBn4NEJ0aofCiX+6DZ+/uEg45WyTySsHbYkGpXi6H+I6S9IJMCAfv?=
 =?us-ascii?Q?OAKixFfYd+tms4nDKuBmCcm0cRL94rOWZCoW8ferMIZBu5IbEEelmAriG1C/?=
 =?us-ascii?Q?ei0gONssfgdcqL5lYb/WEn3wotAXJ9vGcGzOOpE2BfcYEoiRomfk2t7gFzc5?=
 =?us-ascii?Q?w4R1qNXP79DAKpqnbTQTdLJowjCE4uRjztcCQnSQ6jEuUVMdvy/m5e9MJyal?=
 =?us-ascii?Q?jFQPLTNzZdMXY7s3b6QEr9fWl6mkZYQp3p7uG3rWXrY6vqFHp7FlT3++iib+?=
 =?us-ascii?Q?0STcNTnEuKf/L56aV+pVrZlFK82o0znMs5yEsvgvh8WyMTBF22lFHKJr8h+V?=
 =?us-ascii?Q?Zfj8SQfPwik0QkQGAQFaE/F2cVg8N68mPDRYLq2eUnLUTkNAmvzJzvKapxPR?=
 =?us-ascii?Q?GWi3EICSluEezQbI/zCQz8QK0dItHhUP/k/25K5guWJHQQiPfCTzUvk0lNXa?=
 =?us-ascii?Q?+4ToVE2y7X/JO4PV61jzxp/YoIYQJmLVnfVcd79K6CmtsoTSwqZm9djdpci+?=
 =?us-ascii?Q?B1HIWTn/uSdJqVlpgsGG7LRnyDJH7qehgZAKBU2ziXx9JLKx7PqcKwUq1koZ?=
 =?us-ascii?Q?dU0ozPbHwvyUtAO1RJHUz/GqIvFcM8nj6qmHPn/Ns1OkalKnY6ceVx2bjCiF?=
 =?us-ascii?Q?fn27T/QwOvqqn6C9W06kR4H93nEHKYTSprcDQqPGmNbCfI9+hIM7d25yiIdP?=
 =?us-ascii?Q?eHUMdiA6eq0kYVETdqzlRsXjnYlOD5qdiwNPs/Kdi6PiLd1oXkx+4MV4BAhU?=
 =?us-ascii?Q?rz1+IhWk1U7EC/EIIfh8Vqm7SYVQWgjdaOJ6JUtlnQgzFJz/Ggr88vCTrt5b?=
 =?us-ascii?Q?daUpuh90686u/cXFO8FnlxsU+UQyI3M8BtqVf0IPFcBJnFrSn4CKHDGzJbNU?=
 =?us-ascii?Q?Fli4fJhKTB3cYvT18zVSuvjgR1bzq64XhWa68MjlugJ+zkIj7TjhzlVrnNvP?=
 =?us-ascii?Q?LysAM8m1hitn1qk5pgqP4FEtMN510Z9FOz6kcyGasV85XtTZTngTBYEc5koH?=
 =?us-ascii?Q?Sp7r4H8RDOVGrzIcJ/b20YEKE641M+AE/jfhgvrRFhxoyJg51DRK4oo0QfLE?=
 =?us-ascii?Q?VtpgW1VuGlfIAi83xPfys7l5OFgw1ploD9E5RHgKfyKgegT8a49hZyr/RAmB?=
 =?us-ascii?Q?n2NolmpHUErCyHP41YjD/7aq/36JCPYlaOfY8V48jXdQtoVvlpGg9DU5aBA7?=
 =?us-ascii?Q?tT1O93yzAwKsJpD+03N6bP0uIpGcSKGE5PKveJNn2ef1TqexBioy7jMCl8Pq?=
 =?us-ascii?Q?+wmD4nlhiravzHPfesQ1fyatZq4WtDFsd+p5wxoP6hkf9Zq8Q7aQvK8p8zxF?=
 =?us-ascii?Q?f9/sXDZKiBHueHda5lKAVbQaF9UZpbFZmTk7eepPUKmlqWQK7EuXBjMJPaT/?=
 =?us-ascii?Q?OdNNokZdXfP06xM4AlU=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(61400799027)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:49:02.7213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 721887a2-bfdf-4dc2-63ab-08de0cd3e99a
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB6720
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMSBTYWx0ZWRfXw6XagwL9FEr9
 HgE/mWHo/l5CmcelqMLAo9LhELL3NPGdaenDcDjbEuFBQ3a01ojHvpdgxRLZTt25ZvQfDLYQRDA
 ujfnwYB1ezLGVhdr9d0V5DREO2+DUv11dMJOZFSIredib+N9d0ORmUmpImf/lH9v9z/nNKdTtKG
 K//Poy9AMB0AAcL60s1xawIr4fssJLrcRM2iAN207IzxAoVH9N7qa1E8StMjQKjGLD+Zl6i06nP
 /mqQp7bmasaunvii62xlBG0P4giPYArAwChWIzCkHEXZb0mN4LNpIsqF3UadtnBjrCUMi5/tvO5
 3J2uA/2ehh3PDW2rG4oWSKN29D8btdXZEvpJV2bDfsCBoN9dMWcvZh9wKN9XaPMahE08OiYk+c3
 FvnDqwdqHEguKVVgovAfXJPk48wI7w==
X-Proofpoint-ORIG-GUID: d2eip1_nq6B7JVjJoGLjuVV9X-A0k5nf
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f12202 cx=c_pps
 a=jtibSCz00SxEcFhpBRTXcg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=Ueq04TJKjEWbJfMvJoAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: d2eip1_nq6B7JVjJoGLjuVV9X-A0k5nf
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

If the read device ID is not the expected devtype derived from the
compatible device match then fail the probe as other configuration
details may be incorrect.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c |  6 ++++++
 sound/soc/codecs/cs530x.h | 14 +++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 25dbf401b15d..cdd050c0fa2b 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -1181,6 +1181,12 @@ static int cs530x_check_device_id(struct cs530x_priv *cs530x)
 				     dev_id);
 	}
 
+	if (cs530x->devtype != dev_id) {
+		dev_err(dev, "Read device ID 0x%x is not the expected devtype 0x%x\n",
+			dev_id, cs530x->devtype);
+		return -EINVAL;
+	}
+
 	dev_dbg(dev, "Device ID 0x%x Rev ID 0x%x (%d in %d out)\n", dev_id, rev,
 		cs530x->num_adcs, cs530x->num_dacs);
 
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index c10a6766cc7a..758d9b1eb39d 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -185,13 +185,13 @@
 #define CS530X_NUM_SUPPLIES		2
 
 enum cs530x_type {
-	CS4282,
-	CS4302,
-	CS4304,
-	CS4308,
-	CS5302,
-	CS5304,
-	CS5308,
+	CS4282 = CS530X_2CH_CODEC_DEV_ID,
+	CS4302 = CS530X_2CH_DAC_DEV_ID,
+	CS4304 = CS530X_4CH_DAC_DEV_ID,
+	CS4308 = CS530X_8CH_DAC_DEV_ID,
+	CS5302 = CS530X_2CH_ADC_DEV_ID,
+	CS5304 = CS530X_4CH_ADC_DEV_ID,
+	CS5308 = CS530X_8CH_ADC_DEV_ID,
 };
 
 /* codec private data */
-- 
2.43.0



Return-Path: <linux-kernel+bounces-858416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3F3BEABD5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9525C9617DC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364FE2E03E6;
	Fri, 17 Oct 2025 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PelLnOiO";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Kx2mxYN+"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1E12DAFD8;
	Fri, 17 Oct 2025 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717791; cv=fail; b=WOZ5qmPDLhvRK+iSY4KdF5/nk4sJx7UVV5IGz3UDrz/V/0OLj51NYx1zE/D2m/9PWamUeqiUr3jF48sfASBoJkdUzfCdYw7n8ALPOmVqpbM+MZOBGHsPRfUqaq6+c1rFzUz6omOYlTpUUsHPdpMCJH5QUaKCz4yA9sTc13ST2P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717791; c=relaxed/simple;
	bh=V+mPpeH0+wG87aVEkvBSI3YjgqBRsVwdFkLpKUXR520=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4KaxZGpnvFlxYiGFOIBvl/kXEHJhsQzn/vvkZxw+booyvlhkaWj594rcOB1iMYyVr345PtdIo+exhfx3OvMNtIEXVZoDFcuYWKqlpKr+9rmFBVScsjEuqcH5wXkFZh1L9xwvSCYza3yNF3JiBI/ki4fkESV8sp5GrHJQBxiQxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PelLnOiO; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Kx2mxYN+; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59H8PGfe4017904;
	Fri, 17 Oct 2025 11:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ElpuoXzvXliDRcAMVKqJ8c/WeTNHCYgy1BgcAAlmbiY=; b=
	PelLnOiOzk3ZachUvXG0CL74BiFkANlnvNwJrWGgK7uMM76JvE6yFXqPvX5PVVT3
	JZpzO1+/wOSwZcCGDR7IwSSwXKLgmE6NULk7ClrcP5W+pf9yRE1k3zuNCcAvMHAH
	v3Qd/lRshwY2u8vOeSSqm4LrdJwpounZNNMP5T98NffRnO07Y4M/YssS9SXrtiUS
	CEehtLeJMSpPdyqKERlhzIq7ymrhpuecMeCCgcsqugUE1QZz8JFiFPGEKVPqW4OM
	/BTAVeAmlYWrGigD8jhNxJ45MqJMUGNssmWqKMLTjCYyy6asZHs5YddWxOSB+nF0
	gxpLVkCoA2JOEBxqtes4vg==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022077.outbound.protection.outlook.com [40.107.209.77])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mnhsbp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 11:16:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a60JiFEiXmNHyU6LA3ZNLAWJ47ene99OB7NYZ7cCOR28ta8idZRRAk+Hqc7jDuoUaJkWoCnlfIgJwWALleUpO/dR6Zo+o4M5mWfxMPxUOFRUDRrGM6zIhckGa+mRBF5lS5y7p35nccWZqRMyOTb51bFbOHsSngeeWabS2ICi9ylz6NLB+oUFKdq0Nl7rq/gELJDXqqLIB6o9SXvmbDZ237fDki++D1bEdq/io3P+iizn02F2aZ4yatis98Zf4bKNUv5prC8ltW0CO8tSFtM0EdgvgBRD41nyvb0cmEhs1+eio9l8xE7F8aeDxv96Z8/aaqf1vfopTibNffR3jN3+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElpuoXzvXliDRcAMVKqJ8c/WeTNHCYgy1BgcAAlmbiY=;
 b=g0svArcm/KADOEl33RpCb6cNxH9T+a/t6vrNsCTLlY0q6nVYP/sWB1hNuXZWLpykN3FuAbee4y22FLB0PPrUCNXanJjZCcpnBooNF+ld8c9XYzsKtProVfjyu7Pf23WO+r28pljNjeLPJomvk+h3hYSBMoncLpmY8UiZX1v2H6WBIpTRmuHwyA+4AMlX+qbJhOiXf+HUUQ85esIo/GAyy0P+qKZmg5s0/zl16fHuRwx805RSV+MS74x1MvpIW3eEslLaEM3ZDwCiaB1sGSujb+I4y6NIDMFWjLmbFvxE6Elj3Zhzb/dqP5HV4a4qBIK8dD8oIOehHdDh/Tq8mUIXJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElpuoXzvXliDRcAMVKqJ8c/WeTNHCYgy1BgcAAlmbiY=;
 b=Kx2mxYN+UJj9lF6ATJlI77Zx05/2oYwJ9j5GtAJbQq3+jRm/8g1Q7XqxOB2cppDzJK3XeC6kbzrY2no0mxWOHwZu7nzXKCawADsvZNFSEOMtdcOue1jx+PPhNah2nWRvCESX+K0GY1kBWdeg9JNMJZXSS0P2kMSxN3u1ZzT8MWQ=
Received: from MW4P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::6) by
 MN2PR19MB3904.namprd19.prod.outlook.com (2603:10b6:208:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 16:15:59 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::53) by MW4P223CA0001.outlook.office365.com
 (2603:10b6:303:80::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 16:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 16:15:58 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 288FF40654B;
	Fri, 17 Oct 2025 16:15:57 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C8476820249;
	Fri, 17 Oct 2025 16:15:56 +0000 (UTC)
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
Subject: [PATCH v4 09/11] ASoC: cs530x: Correct MCLK reference frequency values
Date: Fri, 17 Oct 2025 17:15:36 +0100
Message-ID: <20251017161543.214235-10-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017161543.214235-1-vitalyr@opensource.cirrus.com>
References: <20251017161543.214235-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|MN2PR19MB3904:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fff1cf90-64fc-48a7-d084-08de0d987559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aPfbHPxl7U6ZJd9Li9JpAE5l9pFMihDIRUaJFDL6eKup3Pu08qJfnniIIuAo?=
 =?us-ascii?Q?UHuH3b4ToHvDFlMc1MDNY0pOlAPUc7PB9AMaeZTsL9GIK6vx+pF5tsRRAel2?=
 =?us-ascii?Q?Uw/etKTbW2mZvnkSSx/p4P08a14tNlK13/jBcV9Pa4Ihu7SBcwWF2E9dvNV6?=
 =?us-ascii?Q?uYeRDS3uryMVKjJ0QmcyqKlXh+sFBW+9JZHydxjQZaDSFRAGVvj3sJKbvdWQ?=
 =?us-ascii?Q?hHfBHf6KCAnpe69jxRTnWKlj5OyODUxWu4eq+lxepju+JkmmZno0ieS0i53q?=
 =?us-ascii?Q?oA6d+pqKqoqcI/KIxnZzF8zJZWN1EMu4i+m/CXzNMU6+NtUyIf2VW/IKAD40?=
 =?us-ascii?Q?YiBMsUx2QJHb0OzPiTl7sGrRWZhwGcWH+oAwUttGTtDq12Uykq1Xs8WsKlA+?=
 =?us-ascii?Q?XEPdVy2PlXfuyeD6I+WBPEb8/LxFDxSyGr7RsWOWas0PMmREPUtFOZOtmE8E?=
 =?us-ascii?Q?y9ckl46yIiN9NBf3YjzAL0uFIGYggA8tuIf21MbfuKd/ev0OvPlforULDz/f?=
 =?us-ascii?Q?dxzImpNXiCsefMvseDUbGWLppjARjtGwQFfYtd/Cg4kPxkSQfDeYZTTxi9kb?=
 =?us-ascii?Q?PeCn+kDCnSglV6B+byid1xN2RXlC0yA0mtRugYImPTbgKW7LKK4u7b27NfMW?=
 =?us-ascii?Q?ZfntGBLTa8M5L00Zg7UKG1D6nCltlD035aQCNQUTmpATYGmcADP65jwnN+BK?=
 =?us-ascii?Q?2GcLhwBt3RPL/2fxF1Tf7Sym1pq0kqJU39/okmKJ/3JQocghAODy2QoV1fna?=
 =?us-ascii?Q?q0+QN0A+ORsJk9/sogcjumF+yYb4JzEz109ShlirfBSmnYuILxKc8LqvfPVu?=
 =?us-ascii?Q?7L3Xi1n5VYNpgK5VBnQ9Az13tZhpo5O3wUGXPkolm8VPp3eH9SZYJvewneld?=
 =?us-ascii?Q?igBUKyu1get9LNzQ5JiYsud4Yv6LfGMqo+8eVxIU03iUFc7fSWYqxqerDKC6?=
 =?us-ascii?Q?OWT/CR9+qx5enbaTJ3md/Lzh6LcRuVEqdrcvJ0Ljo8U1yaUk7dmFk+wBdsVQ?=
 =?us-ascii?Q?1rTOxkyI3qP9WEWl5iiYFec8+HGglUpj6wchK7I/T1ZZeJhwHiQ/TByVHEOQ?=
 =?us-ascii?Q?+oHUjHfJA2pQ2A9u/iEkgz3So9OxLwoyYhb0WGjZHIfWFQKYrdC2FQKGDcU4?=
 =?us-ascii?Q?xjJJK75tx7vyTaVVjSuXZ1aln8tK9MOWgCRvOGBjeOPtQGft2pXHl9Rx72W9?=
 =?us-ascii?Q?CgDXklS5h/EtjBN97maCIN6/iu0NtkIlZtaLriM10mFxUWLBdPsY83CTccF+?=
 =?us-ascii?Q?jkJmLe5DCjBegAsY+6CYkzEZ0K0hsCWIOjmnvC2mb+bKGGWD2gflnhze5OsQ?=
 =?us-ascii?Q?H4YHMLa29ZbkRDfFXhc0bOxrqp+oKZCmNA1woY3s9se47WDf/zL/QqModIHd?=
 =?us-ascii?Q?Nb3Q8Lt/6t/HH4naL/2IO4CulwWPVBpgEDWqgQzZeaZPb7TH6SH14iMywYSl?=
 =?us-ascii?Q?zZnsz96xvTTx4BOAVNC8pD2HLi7FH6Carqs1zoPCUnCBZ9i56Hgn0C+KNcq+?=
 =?us-ascii?Q?nXomPJZsfbYojclM8qK5sqwmn0zHdXLspaMbCUiaMueavQ4KgtylxnhBAoWo?=
 =?us-ascii?Q?b/K3rFl6WiHiBJ7i5p8=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:15:58.4917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fff1cf90-64fc-48a7-d084-08de0d987559
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3904
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f26bc4 cx=c_pps
 a=X4ZH2kTj14Xf3yjbCCnrEw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=_mdxinBoC9VrpwbbToMA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: AuHiJSZno4JI4zKeaym_NMij9tSu3ngk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDEyMCBTYWx0ZWRfX8UlWFf4Eo9zG
 vsWPpkoPOacxkWkthXuy3T63ebUDWMJT2gVqWxCImAHpepoUqv6OwsiNzDtdJuMfGmlOmS/JWQk
 wcE50V2mPHl0LCTStTwOjEwHFM832JgWvwvjJA+RW0UY4HDIrtbuh5afrvz/utCOFaH99GvL5xK
 C7ti7Qi1sPuNJCH3+9P19ufvJbVbpUMcccfEfzbsQMd1NTWkYfCmqgrJ+fSZBrIj5cry3uTU4nc
 KFIIuIBM8olwsp/0PyVb6YQUhfElXoXOboV6kQdC+tyulDN7Qji/5+kaIRr0vLm1J1nvjp6o0Y4
 JV3drZkCO83QYrY/eTkCVo3Py1zqLQqq7iIokYQpQaXjt5rVmgmOng0PoBh1R0VhDOEx8jAMHh/
 FoO1RX9RQY6zhSLdSbtZT64rElWycw==
X-Proofpoint-GUID: AuHiJSZno4JI4zKeaym_NMij9tSu3ngk
X-Proofpoint-Spam-Reason: safe

The MCLK frequency must be 49.152 MHz (for 48 kHz-related
sample rates) or 45.1584 MHz (for 44.1 kHz-related sample rates).

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c | 9 ++++++---
 sound/soc/codecs/cs530x.h | 6 ++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index cdd050c0fa2b..f0c3ed931fa8 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -1100,9 +1100,12 @@ static int cs530x_set_sysclk(struct snd_soc_component *component, int clk_id,
 
 	switch (source) {
 	case CS530X_SYSCLK_SRC_MCLK:
-		if (freq != 24560000 && freq != 22572000) {
-			dev_err(component->dev, "Invalid MCLK source rate %d\n",
-				freq);
+		switch (freq) {
+		case CS530X_SYSCLK_REF_45_1MHZ:
+		case CS530X_SYSCLK_REF_49_1MHZ:
+			break;
+		default:
+			dev_err(component->dev, "Invalid MCLK source rate %d\n", freq);
 			return -EINVAL;
 		}
 		break;
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index 758d9b1eb39d..c48a29cad702 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -174,6 +174,12 @@
 /* IN_VOL_CTL5 and OUT_VOL_CTL5 */
 #define CS530X_INOUT_VU			BIT(0)
 
+/* MCLK Reference Source Frequency */
+/* 41KHz related */
+#define CS530X_SYSCLK_REF_45_1MHZ	45158400
+/* 48KHz related */
+#define CS530X_SYSCLK_REF_49_1MHZ	49152000
+
 /* System Clock Source */
 #define CS530X_SYSCLK_SRC_MCLK		0
 #define CS530X_SYSCLK_SRC_PLL		1
-- 
2.43.0



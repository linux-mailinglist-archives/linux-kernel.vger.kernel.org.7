Return-Path: <linux-kernel+bounces-878071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C064BC1FB76
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448FF1885C47
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE7C2D63EF;
	Thu, 30 Oct 2025 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="RwcK4K55";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="PHVvgFNd"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CD6285CAD;
	Thu, 30 Oct 2025 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822450; cv=fail; b=F+tQRxPSa2Q6W1EEhqeeK0Atp0b8TR25EwdtqbGZUlLaYmWwnBCvmJs6gdwlVtHphKKNuoPPjKBQv8xL6v+nEdxsveOvYmTGtc1UIRpHf0VQqN0inu4M0YHqJmG4shDFKuVF5JJVgWgTV/IWpvfdrWSv0Ug9oyT/cxM7tjbTwXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822450; c=relaxed/simple;
	bh=ZLlF7BpLByowAE37+tDLp4m01la7ei0+rOwW8nq+0yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCFdwc8zoOaBv2+Ox19e9+YsmUCo5LCEyUo+9K1BfKN7xzQCXQlIVQke+gF/A8cwQGb80riFI/KzXCAQPThRdxit6+JYf2dlGFcQHgSKhkeKboiEr/y+fPTnowroVw6iAxnx4/bhXVHd8BHxDK81W1N5eBIEXViFtKPnunHLPf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=RwcK4K55; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=PHVvgFNd; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U4eTRn3950175;
	Thu, 30 Oct 2025 06:07:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=5yN6Lc1vgYYyHThK5n
	osCX3v5v1oMReYZYoFBx/DCCo=; b=RwcK4K55npjmcswtkOG8HCFTbpzGl0120K
	o8J/WA9mhkHzPViTOB6/h74S/AsESIeEa2+YJqBs17pg+KJT+xu2nbIGlaFWP/rD
	YXmhvES4/Ivb0LEeKQYlx+mX2JiZFKXNYhPErg0q2qr4Gent1tFgP5IQPv3l4BIl
	mdxqvl2cHlt3a+2/SrwzbioOrSbgHjuf1DuGAInETI1pdQhzdkLrkPohSYR5QG8h
	+w0Q/wnBMO/OwLoNpgB0pvw4O2fOp9H7HLpfR7pPAHduQAkJBQl4j1aaGmz0dPuE
	RIgrxFwZ967AFQmp4HlVo0rN4tHdIBn9JXyIfn8UMpAv+4pGFStA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020078.outbound.protection.outlook.com [52.101.56.78])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4a34a6jd8p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 06:07:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPnviOaPvJZPi1nJ+ZznepBzilIwuWYfxk7aKBrznFzeKCFx3liyCeduZ6S6C3vd8FNxOiBCKky744AZd8UWVo/a2bOvDqYbq/IRfUUpotBG+7j8gBzt494IXu5F+yH+bTQ8nNmR8nNYiBTbSqnxzY7+yOvgOaDv4dJgsgrdK01V0FlTZwhETfHCGI6wTWHj2m+/+GFdd06iQiKEAneriuahTWSx/KcpJGdavOhGhVkT7wVb4kymoLMsFEoFs3yBgRYnEPeQQ0s59kQpk3z0+2T5ssDA2Vikb/tEpnEf+hpGr2OAKWGeRubM0XkQi5DdZ/rxheAlQPWZNzp4tDXdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yN6Lc1vgYYyHThK5nosCX3v5v1oMReYZYoFBx/DCCo=;
 b=kM6a2icGlhJsneejkJOSgLrOcGN2HBj85fok3VCgGFDjwNFiAJYasAHSL0gsmXRwr7tXC19w16UH+IwxiB6l1BgcfsukPktobzuKR0y9AYMUCuRiVdVbf0DYFg2Ps9WuPjzzHMCgKKThXcQf3Wid5kpIhJzUbiLLc5EK7QZ50G75Uc+CgWkIWwXF0GTd0dTjbKtHw6llL7UfIvIQXpf+yyB98I4XRcn5f+WjmzQktk8oesUnd9lBSaoTQoho0YtRYrowdXl/EG3vP6w1CCWpkhNGPBNx7LA91+lPX+34OKGpDlRyd4oUJZx0U8738uaPaUCLxbV7fv5le00m3LgRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yN6Lc1vgYYyHThK5nosCX3v5v1oMReYZYoFBx/DCCo=;
 b=PHVvgFNdLSxkdy/3C4MgfMnULyAqOxyAfvZtCgPUuU0nsr9gSD4u8tX/+Esjoc5PEzIgmQv9eltSWfnTQTbOLYh1UpOYw0fRsRUiCwhhOQbt2L18PDQ5IVNl7i9UxWHC+x3Wax06xggn9Oy3Khq46KvxjFIlMRQ/4+auPEo+vAc=
Received: from CH5PR04CA0009.namprd04.prod.outlook.com (2603:10b6:610:1f4::15)
 by BY5PR19MB4052.namprd19.prod.outlook.com (2603:10b6:a03:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 11:07:11 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::f2) by CH5PR04CA0009.outlook.office365.com
 (2603:10b6:610:1f4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 11:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Thu, 30 Oct 2025 11:07:09 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 4E8F0406540;
	Thu, 30 Oct 2025 11:07:08 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 52AC4820257;
	Thu, 30 Oct 2025 11:07:07 +0000 (UTC)
Date: Thu, 30 Oct 2025 11:07:06 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: hariconscious@gmail.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        khalid@kernel.org, shuah@kernel.org, david.hunter.linux@gmail.com,
        kuninori.morimoto.gx@renesas.com, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codec: wm8400: replace printk() calls with dev_*()
 device aware logging
Message-ID: <aQNG2q+0CLFQ50yq@opensource.cirrus.com>
References: <20251025043011.598300-1-hariconscious@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025043011.598300-1-hariconscious@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|BY5PR19MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: c7517100-c2a8-416f-6984-08de17a47884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1PIJ2kI9m12noJFqBrEzMMt5PX1k4Uas27d8DhYVKqf8CIBxh5LxM9CQmyJD?=
 =?us-ascii?Q?mXWge58HxIJ7b8MKrIGyc8u1EsZpyV0k26MoaLLlRUweIXn9yk+WXQR6j7it?=
 =?us-ascii?Q?XTLGo82/NAi60J6jDDsu9a2PG8zITFdN4xqOnxl8mynbj2piFTaFoLAbL5vt?=
 =?us-ascii?Q?zMcgB0SHZVx8e4JI1mugtoCJL+rhXhy9UNU/70bb/SvsfmBZLUXd02tySRyE?=
 =?us-ascii?Q?Qov1HxgGUPy3sux7saMatRbsYUZBMN76pzMOw0A2BBx3bcjrBaNLd13e2V/v?=
 =?us-ascii?Q?sbMDa+CNXsF4zvmXcGlOoSGzhk2s2VGMrui8s8gAezdvv2tRvdrJOBkLOMM8?=
 =?us-ascii?Q?fsnIrMcIDgJuEyUinaN2KZYbUMemQzI2FH/R5Va/Tqg3/YtPAgDdPTMa/uHB?=
 =?us-ascii?Q?aHMojReVCVUt9CZDK8CAqh82xvhLyK3RW6uxI5DIyaPOk5n/b9Fw9ZwTupZL?=
 =?us-ascii?Q?WwKAvq5OrXZVcRFaJZ5E3uAvoLpprcZRl76hJg52ELf7CpatbAyhfTIb/uF+?=
 =?us-ascii?Q?SnI3ksXMBdgsG4he29qQETzx0486cpxa9l+u9749XsYhqvZXNRH3IPT6vk+7?=
 =?us-ascii?Q?CvHNbBQ/TVknMSP/XGURfVrwffViXQPwn9Vd1YM7dfpCg9FQy0noL8aQ1KyI?=
 =?us-ascii?Q?3S1m4GPLtZhHJuHhpoCl28eBkziB6TBoL42yM/Z+v6Qk+jXl54Yj+C5J7qHF?=
 =?us-ascii?Q?i5LpbWHSvSFP6Zj4Tl2NAuh026p3z6VL6vkwoXQC+2yjFEdy4UfpL60Sj8Yx?=
 =?us-ascii?Q?mxVsgISoPVtYjve3QGQhfpn9R6bKFqU4VQcx40xzWlN+Vuu24RP49gH9Lm6R?=
 =?us-ascii?Q?eGROqbhuLgPIGGF+j1PVtCWkOho5/R1gzvyxdSAA36X/bPKaunUMS2cGljyI?=
 =?us-ascii?Q?2abQD1yCkq1qPVsKioLFIHrdAUlRGklgyCfsLXVay0k+TuygJVR2uxhMPmMs?=
 =?us-ascii?Q?r2bvYeM18UpX9iX1zhDkaivWwVp115fVwSww6gqZJIU8KItaiKL7zl2f39Px?=
 =?us-ascii?Q?sKmxguTwjYNtZPSgYb1TQ8OhM3qe2SOo61+XVyEV4vs/3wKh738Wj3iRBH02?=
 =?us-ascii?Q?lvmESvnQlcj4/k4t4LzjXSUdphfNndnkp2OndhJLoi2gsmfsZVSc2p2/55q1?=
 =?us-ascii?Q?hFiiXle1qOT7Wo5Zzk2pgYUAE5h4P3zFUlTA679b6pHebsl7mzskrIEuO2bt?=
 =?us-ascii?Q?QGd1TQqeSLyXdVZBKUBfeaFTrrmM7yh/nsIgpB9znCXVx/7vhCzV8EgAE6KB?=
 =?us-ascii?Q?d9/uHYasIYHWBPEL/ctuYNYfvk6imDn30VEP6j1VurOlbl9Rr33wMtORLU7Q?=
 =?us-ascii?Q?GAhYTB4DeS48aSvZymcp+ociQc3OHYyuuOsOpCT0xBqmvVDI2gdZOW7Wk12I?=
 =?us-ascii?Q?Pbar15k6ShP+ih8VSvqfwBk/HP4T0r7bJ5EQ62W+Eb4Bqy33KTzzfqFoAJ/F?=
 =?us-ascii?Q?9a774CKRcrkyZI1gkCFOn223vjq/RqS+ZskwRwTXr2L5C2mP6fQhexY0LdwH?=
 =?us-ascii?Q?JrXLTq8vC0IYnxsWGNDTlGK0ZgwIr2JPDqf6OgiBzpN2vX20T35iSkEuOxT3?=
 =?us-ascii?Q?SS/QnBGRWmYcDs0nTYQ=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 11:07:09.4744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7517100-c2a8-416f-6984-08de17a47884
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB4052
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA5MCBTYWx0ZWRfX6vn3xp2Ats7Q
 wk82KH4QpPeVylj0aejk69904hqGkNsD62buSQZjJ1mfAlNZtJoMIcDHXTa2gRx4GJ0v5STw9xm
 Db8+niW/ExrnmzBFqyb7y+tkwDwLpiVWIOnLlJOy8zwdhQx9ZLLfaSq7Yr8OpIVzk+NHyxN+/56
 eOPoTLktxeyoiiSbXuRHOYjyuAoqe2Asf/xsvh357K1AnEK7g2rA0eR120XapHxrwDOhGgavbW7
 aPbkAH/Jm2dDUOuklkTDYBk4mej8kYWecjQxyTjCBzDuHJyICimwNxA20aPOCCig4K0iShz2Ra8
 c3J4MICvQUcr6SGAhVZOjxRZwKUc8MbG0v6+xZr6279MFi6qJ22lZASMyNvMfmFhW4gkGnuc3iA
 S/P8WzPnbuQlTQMi/v63Q6zEou1Arw==
X-Authority-Analysis: v=2.4 cv=HLfO14tv c=1 sm=1 tr=0 ts=690346e1 cx=c_pps
 a=+st+RhWFlpwsdOuRE3jNSg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=w1d2syhTAAAA:8
 a=ESGeDLb0nh9CsBy4jXIA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: II5MUFyqimajyU6KRyUpTGveVQ8zZMg3
X-Proofpoint-GUID: II5MUFyqimajyU6KRyUpTGveVQ8zZMg3
X-Proofpoint-Spam-Reason: safe

On Sat, Oct 25, 2025 at 10:00:11AM +0530, hariconscious@gmail.com wrote:
> From: HariKrishna Sagala <hariconscious@gmail.com>
> 
> Replace direct printk() calls with the appropriate dev_*() logging
> APIs.Use dev_err, dev_warn, dev_info, or dev_dbg to reflect the correct
> severity level. Pass the canonical struct device pointer so logs
> include device context and become traceable to specific hardware
> instances.Improve log clarity, make messages filterable by device
> and align the driver with kernel logging conventions to aid
> debugging and maintenance.
> 
> Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles


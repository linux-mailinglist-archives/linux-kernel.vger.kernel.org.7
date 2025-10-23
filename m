Return-Path: <linux-kernel+bounces-867775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2920CC0378B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F34E3A6347
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8CF274B5A;
	Thu, 23 Oct 2025 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="oixYZWoK";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="DCcTl5xD"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B55263899;
	Thu, 23 Oct 2025 20:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761253088; cv=fail; b=AlhtSMPB401G2VTQRVNrju8/wqPWHyM8mtXQQF5dEuuy9Ozu4u24Qi8lfKob6P64+yx1ogLpYXRo9+HlHECky9J+lOlAdt26nm1NjHc0X8ltZWIwmKlgC7etg0fqVee3UqRpoO21LIUDq+810dhZs+nEWbVKWX6sbqDwrNP0lEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761253088; c=relaxed/simple;
	bh=NJDb19EwgCUW5hvjHVb9d8eLoonGsH2gtODJs3KPP20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luWKAjmtmU3TYtpL7i8rIzZUzdGh9jzeODNbbbDgCVOSFnNFoQcRT8o6eWxyvBp+Mbqx3ng/6tw4Bgftklr5cjUDSVcRGs1aANz6z1wAIV2V18pEKAlHCuMVEIWOHM3A/IU7wCLFS5I0vYxxDFuXFOxvtp6X97UeTTvUI/BgHrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=oixYZWoK; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=DCcTl5xD; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59NI9Wb7692616;
	Thu, 23 Oct 2025 15:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=MEU3O/s6y3sQXttvxi
	n3aCrRlVKtKPwWTu81YYvo1Cw=; b=oixYZWoKQ6wENCVVx4U7/2ff2kc+kuiIoL
	517MTP8QjSdz+GqpHQa+0wBjhIgRdkGM0tM/00vyITEfr8Vb1nv5l36LCZuTCeS9
	lRcjlwzvyCUhbBDpPYAEOM7CqJCPm97qlmyYjWfruRn5j/d8mVY/bg2zZtZrNotY
	+ucfwMNylqVLbdc7+RT6fGP+FQWwSP7Vxy7sHXG6czLs55xYCbu9UYJ9gfYTMyPW
	3oenMAIUoZ8bWkok8+6udxsi8O75/tYP0oInmmjbxo+tc6PP/c6zi2qLLT/sDKdY
	uYXpX9FEhT225G5Gc3+Y68JuFQcq+Sn0Th92KuEzCoqKoTbtNHCQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020096.outbound.protection.outlook.com [52.101.201.96])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49xs382ujm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:57:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+x6KnMUB9+lClIRvu7If48p1zldbQauNICGbJf8OhEmjEGxtUoV0hPCbpngUqzNUVWxE6Nq3Ou6KKCXPMw17cncz5fSSRYgV8l1aS+/hOCg4qnXe4A0lIR0ibkvUFjHdaA8IRjSZ595Ma+GKhs5H+jGVVtgnwW0c5eshL4UGS6yXfZSo5vt5KGCDPiFa648AvpwqVsXUJPWiO5e6X2H4f356h7E27DGzI5P4dAu3ReCvF5ahJk68Z9kkhZg+kA2H9VxWg2v+4fws6/2tq2g5hP8w7c9YvditzOm+pRzJI3eHtJdCNeoj+jBdVkhQ/1zx5tvc4nO4eG2zoUvgd5wNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEU3O/s6y3sQXttvxin3aCrRlVKtKPwWTu81YYvo1Cw=;
 b=CS3lC7+2OMHbl0e0LmnxUgTaVD2HHQxfzFvOCNiIlmBdWIuGm7bWM6Rq6EsdJuz6IcIvqyO/TEskwCIMaQJ8uUFnu1kFMwCmuCSkWjNJIOuTIolxZDv/WZwJ7NtaiNlI0YQFq7ATVLgd/J9mjXIqEuiXXcCJZYmSGFOtr+oY1hdev/M3+IUBoPLWMHbQCEXPClSDGXsnjKMHQo0xtEVY6hwQc8fZFyTyJCx0DxZkUJtcQlFZua1CEyUC1pmBkdg9lKIuMjT/ZzQDM1KXMIQ/JyqMBYEGRyExcI/NAMo/uNuaDd8ATUnAaXPTrlmOSyFVJVxlMYJuPhMcE4thKRrr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEU3O/s6y3sQXttvxin3aCrRlVKtKPwWTu81YYvo1Cw=;
 b=DCcTl5xD1Nrl/H03ITjJWb8Mi6mXNQcC3V5Cl1bfw5aWT4lyNbszxWDzWYR6KayF1g14W6Q3FlS4sRKNKxZDIhtgpM74qWb5fsSx2IRoOEVddkclH4UgmEh1m7k21d2H3FqQtog1RsfpNXVSYFBZ94tBTzMVYowsokognPtRRd0=
Received: from CH2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:610:50::37)
 by SA3PR19MB9550.namprd19.prod.outlook.com (2603:10b6:806:496::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 20:57:51 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::5) by CH2PR16CA0027.outlook.office365.com
 (2603:10b6:610:50::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 20:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Thu, 23 Oct 2025 20:57:49 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 55647406547;
	Thu, 23 Oct 2025 20:57:48 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id D965D820244;
	Thu, 23 Oct 2025 20:57:47 +0000 (UTC)
Date: Thu, 23 Oct 2025 21:57:46 +0100
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 05/12] ASoC: dt-bindings: sound: cirrus: cs530x: Add
 cs530x
Message-ID: <aPqWyrYwrQELWLIK@lonswws03.ad.cirrus.com>
References: <20251023090327.58275-1-vitalyr@opensource.cirrus.com>
 <20251023090327.58275-6-vitalyr@opensource.cirrus.com>
 <fa397247-6271-47eb-bea6-ccd83808df74@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa397247-6271-47eb-bea6-ccd83808df74@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SA3PR19MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ddb9f0d-753f-4846-74bb-08de1276d36b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n4SUfbuSiapzSEoCqS2epyn7ciMsja6FOx4PNXgkKnAbq4m2B3XXZJiCdJPU?=
 =?us-ascii?Q?74BBoM025ztdlKqQFFiWsdsvsN49AgPezuBTV8gva4kFi/FTaLltNj0YZupt?=
 =?us-ascii?Q?x0yojSwsya/ysCqKMDetN8sPqFRZ7iVaobTINsKt6YigRsoSdgfhYHn3rruU?=
 =?us-ascii?Q?hpVd7G33Mhcb6M7FkxxEfxTE6h+CFw7T/40Gw+wdn0caa/FY++4lo6sZuH7I?=
 =?us-ascii?Q?+xqUhyU8dsEqvxFpnkCGJud3AstX+B1hSgb73K62pRWGGnZ7PxIH5kagd00F?=
 =?us-ascii?Q?ZB3T6AybkVZDNYMjJPdxnpwfB84NO8Jw2AVny1BfeM0fkmaB3lX6ipTsI8Lu?=
 =?us-ascii?Q?lnQvQCHnTmPQCvmJSnb73EYfSaPWaZcArnhctIytVAOmNI3sjZ52XggzSJKi?=
 =?us-ascii?Q?QsqtiKr2mxGHdKBJYJq8ekqrklksXB+pjFC9i7eZ727dzO4uITpm9lGzcqdl?=
 =?us-ascii?Q?7Sl1nDRKqlAdL7dcc5usdgmDLel5PPsCoNjJCgN/jY8JoDVqkGR1MrU9ji5V?=
 =?us-ascii?Q?31b/0RIbraspVQDN0TZRpWzCGY+yWtF4ECvSQTBqt5rEujdcXrHCS49Jd9Nj?=
 =?us-ascii?Q?wNtPg7xBfcQCeJS2btne/gZFBvotVSkyD3HL6cSEv48dlpGCyaX+2Qk/njfH?=
 =?us-ascii?Q?pqrMDvTMd/PUr7QqgeZffmmq0WTRtgwolKGnB/lrqdSI9d8UGrpmIhh7V5Z0?=
 =?us-ascii?Q?MjRNG2KOP/miBVLAsHQZ487VbdCehxe309P6qkCoc8fzaneS3aHUy3jW848u?=
 =?us-ascii?Q?KLJV1IHMdLs/x/oNUEAjqP8S6DbyB7hFvAWORNNR22XgEbElLSQ47GUuzPqD?=
 =?us-ascii?Q?7B8KG/QUHZ3M7P6dLG56DhcxvKeCJ3oGrgagg/PxevFXKeRy1e/WF9S1GRnj?=
 =?us-ascii?Q?2M+MCVK6UBiOHqFlcNbU1AxuffwxZfSE0tvh0lhbXiBnfUPUMVRegXPj1Eo2?=
 =?us-ascii?Q?/KnownzZa+oIMnGKKdPtLgY/p+imqJ4FetpUI4HX3wps1yr4BFL6FJXA+7mz?=
 =?us-ascii?Q?Lo9cthTLwtCbW1yiqsNZw0Vxfu3MV9UmNjaMB7Z7ckPf5z9IPeFrlAV+1HJY?=
 =?us-ascii?Q?c/mF91LtSs6HDSB/3HyZ5tc5suH9+Qa7NC6IvkDBimYEiap0OsGGAPyBQrrC?=
 =?us-ascii?Q?cNjj6q3FwXZPEwesAr/vWmpVRduJEsRPpBJVg25U+Rhi9yKkTSmDUzFc8sv6?=
 =?us-ascii?Q?oCshCWVFymB7ieOJEnIcLv0G/ayodWni+9t6MxBXF9p1ZsInFO11sJfdb2Q1?=
 =?us-ascii?Q?Dr+pRLcRoJX6xM92CGzXaV5JgKZ4bzJQHJ1mNAcSicvjs1719Isnzrbexo9q?=
 =?us-ascii?Q?Y3uJqpOcyEhlcBElgaumnJmK33J2fYHjwlDA7TUGQd4XhILbJUKZlPwD3ULd?=
 =?us-ascii?Q?BvvbEtqhcP3jz9GtysHBpNdvZxeH7/gJS9APCccAF51tkgemqp/J3+IiZfiJ?=
 =?us-ascii?Q?jCM+/m/K62a/AmKtCjelb45bCV8fhHnstNw9SPmG0fbK+ODtARXYaqdQs5O2?=
 =?us-ascii?Q?BU8/UFUQ9jIEVLVitLoZ+fAJ6DxysErRy/80?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(61400799027)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 20:57:49.3347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddb9f0d-753f-4846-74bb-08de1276d36b
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB9550
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDE5MiBTYWx0ZWRfXx2tvD3RSvWI5
 w6234429XopDTa1fhtxn9BKX0IzKVErhvIoO+s9m/1g3/aJ5Lq0SKC/D6w9A0aFCR30j/KsMgmC
 VXWsXoC9QPZu9ZH51c1Wvnkbjwjpc53kN4uVUuSrNF+R0XkdfgP1VkPjjhw5JcsvRuffV/CMq4A
 FuVxlHBkB6QcYwERMgnV4O+bLjrOwiJw2pM3AAm9GCmr9fz4AghJEkiGMjxD2r+VxfYRvZqZb6m
 6FVJNwxzDdxjX08tv40Zy5RLfHNSHrVnLwT6gO9oJ2JMSyejHk5k038hCWpcXa23mCYs0g313IJ
 Ois9BYzcvr26NcFgbN0ydlgCmrFG7DqbP0p80EVP4e2EARNdh/AhPp1qY/+F4J7yM3aUrKP6+G5
 GCj9w68M8KsSvgiCrPqHp8hS10eJ+w==
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=68fa96d1 cx=c_pps
 a=NPiivNiK8hhPJgysqx5tlQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=iewFU34vEKmaIT3vI-8A:9
 a=CjuIK1q_8ugA:10 a=d3PnA9EDa4IxuAV0gXij:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: DpiTUvmerDOjgVtjkwxp-PbDypTsKfFA
X-Proofpoint-ORIG-GUID: DpiTUvmerDOjgVtjkwxp-PbDypTsKfFA
X-Proofpoint-Spam-Reason: safe

On Thu, Oct 23, 2025 at 08:15:24PM +0200, Krzysztof Kozlowski wrote:
> On 23/10/2025 11:03, Vitaly Rodionov wrote:
> > This patch adds additional cs530x family variants.
> > 
> > cirrus,cs4282 - high-performance, 32-bit resolution, stereo CODEC
> > cirrus,cs4302 - high performance stereo DAC, 2 channels
> > cirrus,cs4304 - high performance stereo DAC, 4 channels
> > cirrus,cs4308 - high performance stereo DAC, 8 channels
> > 
> 
> <form letter>
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new versions
> of patchset, under or above your Signed-off-by tag, unless patch changed
> significantly (e.g. new properties added to the DT bindings). Tag is
> "received", when provided in a message replied to you on the mailing
> list. Tools like b4 can help here. However, there's no need to repost
> patches *only* to add the tags. The upstream maintainer will do that for
> tags received on the version they apply.
> 
> Please read:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
> 
> Best regards,
> Krzysztof

Hi Krzysztof,
Thank you for reminder. Acknowledged.
Best regards,
Vitaly


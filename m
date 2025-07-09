Return-Path: <linux-kernel+bounces-723973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46748AFED18
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB156439C7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBFB2E6D26;
	Wed,  9 Jul 2025 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="oWmLv0yu";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="X89mxQDh"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E069156F4A;
	Wed,  9 Jul 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073602; cv=fail; b=cecwi40nMwUbV6LUDYtENWBaboICeRp2a3jucW4FfaiU7bDXc7sqPk8jXsBaWkcNxqfiT3RaLExv7kBEPO2+S2epIfZGapAISijOjUdbeSeN+v45Pax7U9zh+VoV/H2z2MBfyejqPHQgvVERoP5cd43OA9+I3lD3PsjqgcwG0gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073602; c=relaxed/simple;
	bh=rQfLCXpPNHk6e+Rt1w/+IdcdwuYkMBIKrKsLyPjLLkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5N8DNkJ1ek75qW6Oj76hPCDPAGLhTCsi9lQblp8y1JFxXg7UgLMyXk0GBJboM209js+7c84K2RbAqIuz+K8p6r6UTzXRBh0oeDFMs4OVHXRfcOr1le6qGmIV1ykawu5e0mqB8FZq7i3gPuDxmuMH8EbUt9yNPOMhsdUC8hs18g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=oWmLv0yu; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=X89mxQDh; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5694wp36032092;
	Wed, 9 Jul 2025 10:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=k3be/Z/YjRLI8XY7OV
	hg2ZohQ+nCOZQRjQztndrkFEk=; b=oWmLv0yuFwpnqrn5vPQN2/JZylC+L3NYLg
	JVfrqlxmJDV0Wg8pIFkC9aASXaWym6684HF2xiLnSiddxzQ9+7NZb5Z7F7JUlAFS
	dlX/Y2FcGwQA+ASuMPrlp1e8i4qiUvBEGRCY3QKtwwvkckcoE//eB4C0X7yErQ8X
	wXS5ne5/YxenMlwlcsxRrJQ8/Y1jbGbr61d7YNrXAbKxqD0CVOToeZ2qfI3K3fds
	vZjhjLBGISloSTdux1DVGktI1gYbOXeqyj27AxoQPpAULleoAzbl6NRfEeE5Ka7m
	vq8Gi7YMWmarHDCm+4jpm4I5qgAW20o2rqlLBtkKNMWtx8r8s/6w==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2136.outbound.protection.outlook.com [40.107.237.136])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 47sev6909y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 10:05:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGjwvU71fU3Ny3eGmW1i5SyHCq21vpRH9DByADEHamlyHsdHyI1mc1zOxnRP6KERcYbguxuAmHqqHPRgyEROYMpJMltqNNJQqEeZbgh0DixwESgHSyw8BDEzd/cttp9axYKcqlpb67D3FuD3m9E662Y3WxlOHxnLviOffWk7axFCY84y4p/a2BspHXd/OqIxJC+O9aujKcpiILOrbPTw0WtCSPmvKg3Tbl2/nc9/ry+v84VpAC80MnU+HR8Z7aH0BluiN6WujPDbPr7QKvhiJ+OWAeJGEOY7JaxGMn/o49CToooCMLHZwF8PmwrVAsYnpvFbhrKNL29pip3PpHK4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3be/Z/YjRLI8XY7OVhg2ZohQ+nCOZQRjQztndrkFEk=;
 b=oQBUCFJQLUiumXpABHCucnRsagr7KesUgUdnolIrEhDcnxcrsxteCHaBSy1Gx8E7E/MlXFtqAZN0JMZUlSHK+eD5O6t7HCZb4UNMBhE2gpp8n/osiep4TCvmFN33ogt4A2+imSS8gR7PLnW5DG6TUhj20Cr4QLE1aPNMExlkrsIR8KxY2/6HChn+jTPSTo63yFRvBVeAkEUG19DucuRbU9FX/haPU9j5tYkWTFb8563/j6PAaHbrVMKKsga0/5tXHsejW8UcuuIXbbKehhtjRFvSRj3/MVmwCT2S+o0cGzk7Y68FUPn2LCdNunzRc1toTyekwcHiWm0ZO7YhA/Vikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=arndb.de smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3be/Z/YjRLI8XY7OVhg2ZohQ+nCOZQRjQztndrkFEk=;
 b=X89mxQDha3F3omu3L+2quKFFAq3f/ETWMGxDv5taD47Fvmu6EBmHI5engqrXqRAGgIIykRvolA3zYHieZkvyBY0LDgyoOGXpXxupSaRSReRttGAVXkKqHhVNv03JnojNfb165QgDRJjpf/H2UrLQhWUb461NCZp7QyFFbDjA3yc=
Received: from DM6PR08CA0014.namprd08.prod.outlook.com (2603:10b6:5:80::27) by
 PH7PR19MB5562.namprd19.prod.outlook.com (2603:10b6:510:132::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 15:04:57 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::6) by DM6PR08CA0014.outlook.office365.com
 (2603:10b6:5:80::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Wed,
 9 Jul 2025 15:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Wed, 9 Jul 2025 15:04:56 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id D0F23406545;
	Wed,  9 Jul 2025 15:04:54 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id ADD1382024B;
	Wed,  9 Jul 2025 15:04:54 +0000 (UTC)
Date: Wed, 9 Jul 2025 16:04:53 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuming Fan <shumingf@realtek.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: SDCA: fix HID dependency
Message-ID: <aG6FFXrfOnBlnn1l@opensource.cirrus.com>
References: <20250708184618.3585473-1-arnd@kernel.org>
 <aG5iwy6j3rR0YdPy@opensource.cirrus.com>
 <f0275a4c-9801-4288-91fd-e28aa4bc5b7e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0275a4c-9801-4288-91fd-e28aa4bc5b7e@app.fastmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|PH7PR19MB5562:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad816d5-b237-48ce-0e99-08ddbef9f775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|61400799027|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oY/H+onkBpJZddoZ7CoLuVF1IhrwbsqeekUjN1Y4HzIpHyeRhEqgVgdkgxvS?=
 =?us-ascii?Q?YXeTvnuXEIkP+4E1s1gK1lcypu1DjVQ/HR1a6tYzYIoXvDZGd7iXriT+kbFv?=
 =?us-ascii?Q?E+i2yeUt7s+ks29zwKpCUpoTYUgRWAKOx+LH2sQZyJ1szAsakCB/hvsZxs1M?=
 =?us-ascii?Q?07gjDeMbz0vubJrdTkfiylPReyv/nisihSlfawZ6/9PtEeV4yoZcTEQ16Meg?=
 =?us-ascii?Q?brwrdQYs2zniXhCk00T3mfoBI78ns93YqqhzyHibY/M58rfV2OUllIFT/ZsB?=
 =?us-ascii?Q?2Hsjsznr+oXj4LQCOPEl4xrPmpHth4N4xRtnv7R3aHtvmRw0h+hTbI/nHXw6?=
 =?us-ascii?Q?BnS2hux4/a/xer+0sgUfuaT5wL8EZ6n+rxRnIAAHZj4jutGH/SdYKghmo3sw?=
 =?us-ascii?Q?qjMvo+WzT+l3AWHfjJ8M+Mp7p0NR3wLygoOLstNUThYWoiWR3eAwIsif1eay?=
 =?us-ascii?Q?e0ieaRbRxJpIdKLb0JEmtZRgeVzHU/p9mVAfweNLNxYFGVGY/uRxbqH3G5rp?=
 =?us-ascii?Q?Yp1iK8iXFRxRd9PQ22kb/fK/b9TiC1TzgNM3Vptz9Li3V3YpopWb4nRsAf0g?=
 =?us-ascii?Q?xADBTasq/BuqEUM0EgzGAjr+KXqtcDMm+foWB1t7Fq+LP3nb/3rJQo+9YPBb?=
 =?us-ascii?Q?d7FN3fzJFwtCHKEIeRJzuT8M5TDI9liU+xKqnQ5JTfIcU8Ca26RoQtWoMR/X?=
 =?us-ascii?Q?pJGEjlSmQcVfTU1kylYXL4kguc1Pe1xBE75PfpYSKkqjIZPJLjJISTsEA6wo?=
 =?us-ascii?Q?+yopi2xD7sVMoa8zxZmoMIH45PCp8XoTKW/QgAbsZNESho8h9CLugtEpeobd?=
 =?us-ascii?Q?o8p0eM9f+tpRlM2C/y/GJv9fSIa7LRfsdyq5mHW466gXJDh16H4pPqQW3QNM?=
 =?us-ascii?Q?/F9CMvzyAO9aAkWueyzM3y1LHk8rQYuIdZ5CgArmpfP/+vVpZuVXWnE61a0L?=
 =?us-ascii?Q?vrUPfblL69WFoiAKb5OegRXY6rQQlxTQNj5AWwcNh+US4zTGUhNybyOofAQd?=
 =?us-ascii?Q?RVwFunKLF5XuciZZ/idyAL8FuTlK30RY66AKieWGjkKJRQk/duoWH1Okvo1t?=
 =?us-ascii?Q?pjALMF/RhcBGTqGlJ2p3MWfzstQi58MyjWrYnxHCZmHH5Ec2c9XDB84G68zA?=
 =?us-ascii?Q?Zk8wjZT4yJEc7LUgWaZoiNuYY7eTvQ0i7z2Zo1iJsg7ztZ2R7F7a1VyQVsRW?=
 =?us-ascii?Q?eVOs7XiHjFlr+kuT92wAhWPUDkGgHUBDNzQL5BZxCjYNujaLPMMxEzkfUO9v?=
 =?us-ascii?Q?IZ4Qbd31tNOlGr1Bw5fVQ74BieXfxSB2JNShfUqNEV6gHTWSQeZjyCueLosz?=
 =?us-ascii?Q?MMxUGoUsDu2B01wPn/q00E3x/G4Pyy+VmDvuRWNJnMicFz9xhGMeb4GJ2EAe?=
 =?us-ascii?Q?qfpq3TULHptDDNSWWxLwnW3Myi64OGGL/SbrD33BIYgrB8q4i9JDwy9Xl0mg?=
 =?us-ascii?Q?5ZjlEEHVch+40ncDRAgGXuCz3H7JxJbIOvOcf1yENr8S3swiz17O+CPdbj1H?=
 =?us-ascii?Q?5S/Y7Z4YWkDmbNftIDyHN5bld4fK2mAVc+sb?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(61400799027)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:04:56.1461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad816d5-b237-48ce-0e99-08ddbef9f775
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5562
X-Authority-Analysis: v=2.4 cv=Zb8dNtVA c=1 sm=1 tr=0 ts=686e851e cx=c_pps a=AFyTyTEmTC/hkynMl9fKnw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=N_v6fh2jkLtUMmMQ4N8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDEzNiBTYWx0ZWRfX0uVZeFNsUdLm fldk4NdN7/edb0nJeTWLNo0h5wD9brwBLXuBrLeCBb823mKDQ7kOjBEdkNI6Yx5a/gD7FZL+Hil qXboRaXn65uQSU0JvVyOxI3HlnGWzk15F3wlVPmhd5KV4q5ZZs97IVA2wfPhHsEbbcFyE8doTPt
 rbyDLKCrZVcYcME5aA47MMGbhoD1yOesnChpAHWr0UKIoMDYsVRpcNwTjoU63KRUhLY2Lbh4TUX X5SDexP8COcdnDkomEOoBJlJYuMWwARuhgeQK4D58IxRONreavnqq500Htvq4aKS2UCZqORbO4+ fhNVzeawc7wPKRWW9MfhKt1QBAM1UkErz8d0ZAzovHc2aodozcM82jb/ziTLKkMnII5olrD0F8Z
 VbxkpYkYfW2wetm46MK7s409egcf+hGzZ/dNXiQveILCcm9CtLMH6wYjG83TtoXuFQhIctDl
X-Proofpoint-ORIG-GUID: Qi4jKdXP3_86CGN4pZylex6AuL3f5fT5
X-Proofpoint-GUID: Qi4jKdXP3_86CGN4pZylex6AuL3f5fT5
X-Proofpoint-Spam-Reason: safe

On Wed, Jul 09, 2025 at 03:36:49PM +0200, Arnd Bergmann wrote:
> On Wed, Jul 9, 2025, at 14:38, Charles Keepax wrote:
> > On Tue, Jul 08, 2025 at 08:46:06PM +0200, Arnd Bergmann wrote:
> >>  
> >>  config SND_SOC_SDCA_HID
> >> -	tristate "SDCA HID support"
> >> +	bool "SDCA HID support"
> >>  	depends on SND_SOC_SDCA && HID
> >> +	depends on HID=y || HID=SND_SOC_SDCA
> >
> > Does it perhaps make more sense to add a (HID || !HID) dependency
> > on SND_SOC_SDCA and leave the dependencies here alone? I feel
> > like that lets the Kconfig figure out the right settings for
> > SND_SOC_SDCA automatically, rather than just disappearing the SDCA
> > HID option when HID and SDCA are set incompatibly.
> 
> The problem is that SND_SOC_SDCA is not a user-visible option
> but instead gets selected by SND_SOC_ACPI_INTEL_SDCA_QUIRKS,
> which itself gets selected indirectly.
> 
> It could work, but then the 'depends on HID || !HID' would
> need to be under SND_SST_ATOM_HIFI2_PLATFORM_ACPI and anything
> else that might select SND_SOC_ACPI_INTEL_MATCH,
> SND_SOC_ACPI_INTEL_SDCA_QUIRKS, or SND_SOC_SDCA in the future.

Ah yes I forgot things are selected by the Intel stuff, at least
the double depends on HID can be changed though? ie.

depends on SND_SOC_SDCA
depends on HID=y || HID=SND_SOC_SDCA

Thanks,
Charles


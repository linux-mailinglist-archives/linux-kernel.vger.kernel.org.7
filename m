Return-Path: <linux-kernel+bounces-783982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64680B334F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457D7189AF3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89342225409;
	Mon, 25 Aug 2025 04:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qqRkyAtB"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450681C1ADB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 04:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756095508; cv=fail; b=UMX1IcyRh1Q0cFr9AWRUjDsVug2J5dTs4tB8qYPW1owTkyMCnp43x7M47BPWuzmaLoH1h+7192diDu51hBQCX/vPGGkdF1PBb0im8V/XxBQ/9dwYrNcvm7JMe4gA39lFzwznXp/Y/ZAoJlJXikz3kcqaPCiw1iTmudQGB7R0ZY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756095508; c=relaxed/simple;
	bh=A/nve5JCA0YKekWjBYzF4GtI1VJtxZryUTjZdnqgLy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oPTChTStVh3XTAMCZqJNoP765WugjOLYFY17rApSVGhO93F7w6WhHMl+rrGUOauvGcmlYU27E6cSyUNNMrUYTLR95JC3n2NN84Mi7XplB+pG9G676wiObWki8piM5yyYJHFy3pgDvQ0wKCDsI6iddGe37+8bwuKNptVrkax0Cks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qqRkyAtB; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkVS2znB9rQo5pCuPDqrYX0d6tqHObn7rQvvfrYSGK8s1+IR6eQNODJ5icFDcW4upWbKiiu6fXR40sVHZPMYtreK7EzKyeB65lnCFcpwSK4RzqjuU/3+JL5ss1AYxvRaE0heOJbHhIsIN9SK/GdpfIeYS/NAM0Z1igHFMsPJow9LRJEiZexYVLrrEgeml++3fDRe//NaWiMfnA4CaVeCCsrmpZHpEjYVLABUjG7KG8Xm7G+pKQq4CAQH3dmnXUsROh2Wa7aKkfWcVsZUo+LHc6CEOMhSvpWiMXUG1v8EORhYAL7rFo9E3otCIjnz289pgFrtp2DsA+5xvB984c1zkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAEopVdgEQunxoVE/oDNZlBzlTAG550Dnd4m8lyShrQ=;
 b=BqXF+s4/vEPi6i9D20wRBNfY//J13ocPUUqWD0Yf6mH5WYLEc/qZDpvEOHv88TUDZ68Hi8XewO1ByqCCFkg2aRlfkeEbphuEHengNF7K4PtdAGoCbPOZwNYi2ySAQ2YI6OdI7paEyXS5zABoa14zuyjUKXFVExDk4ZSJUhPRc7PU7JWyGjGrlsthHnrMAvbBbhORxEhmR7DEZJExKxnsoL7CujRby/NLMPHiy/zMWbc4PDw81wU7T6HGSrqCAnqlPbPrp40j9iCWb3SFow9T4rqrtUgHcQnlZtPAJ7yDtkjobot0xGdZ0UcEO7xJOWNhw/Vb5RDGOjtEgpBv7oyKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAEopVdgEQunxoVE/oDNZlBzlTAG550Dnd4m8lyShrQ=;
 b=qqRkyAtBVNa+pP+MfzvpGNOjyJkgRWYA2B14VFjRx/+YHk8ciC86YQ7i5ZgD2pbjz5If92HybGsIpiJnhKwYDRy1zO1Z8+mHiC0sbX85nRJaRMTufFEvQnBtFsHlFcQdWh8uvzDvY45opFTvQbG+BKXxRFnzh0/5LAyNL4uZfIg=
Received: from PH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::17)
 by SJ0PR12MB8168.namprd12.prod.outlook.com (2603:10b6:a03:4e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 04:18:22 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::f8) by PH5P220CA0002.outlook.office365.com
 (2603:10b6:510:34a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 04:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 04:18:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 24 Aug
 2025 23:18:18 -0500
Received: from [172.31.184.125] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 24 Aug 2025 23:18:12 -0500
Message-ID: <b69fd9da-7b98-4df8-9446-2fe6a717f50f@amd.com>
Date: Mon, 25 Aug 2025 09:48:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix NUMA sched domain build errors for GNR-X and
 CWF-X
To: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tim Chen
	<tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Libo
 Chen" <libo.chen@oracle.com>, Abel Wu <wuyun.abel@bytedance.com>, Len Brown
	<len.brown@intel.com>, <linux-kernel@vger.kernel.org>, Chen Yu
	<yu.c.chen@intel.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Zhao
 Liu" <zhao1.liu@intel.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <cover.1755893468.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <cover.1755893468.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|SJ0PR12MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8e6bea-08f5-4e55-c2a9-08dde38e6d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnRBTFRKaU1MSUMyclQ2UGlTbWV3THJESWtmM0l4cDljOE9kVVdXVEJVeFZS?=
 =?utf-8?B?dmxnTUNFdC9ZQnVMQmlJT1Q1TWMvWm5DK2Vyd2RvVFhGRk1ZQkVwQ0JGWHU4?=
 =?utf-8?B?YkEzWUtidlliN2t1UW5IazBRZHRZRlNvcW9POTMvYkVzTTJwNmNrVGM0WlE0?=
 =?utf-8?B?VGx1TUo4cUMxZ3ltYmc4bVp3S3NSalh1WWhkOEdFMXRJb2xaamJIYmZkQjhK?=
 =?utf-8?B?Q2V0MXhQbmNScXlSa2dPV0lTMFlPSmcwYWRPQWttUVJicklqRXM0cEp2TlVr?=
 =?utf-8?B?b0U3WkRGVmE2c3VpYmtBZjcwcHBRRm8rcFNuV1d4R2MzRXhkY0taTHBBQWhV?=
 =?utf-8?B?dDRZY1BiUVZPMWRBVm0vWEt0bDRUQTZxUDVrUkk0RDdMZnZRVHhYVlNNUXk1?=
 =?utf-8?B?bjJOSkJhK3dKSlI0WE16YnloeldiRTNwaXFLNG5PYVh2WmtCRTFBOExMZGVZ?=
 =?utf-8?B?WTMzODg5WGQzbGtYK1NabUtwQ21FczEzRVAvcU1ZaUpXUWwvY0NhWXNBclJx?=
 =?utf-8?B?SnZWK3Z1VDJrd1RNMnhDNlc3Mnp2QXFrU3MyUDB0dXlwbjh0M1RlTGxqbWtZ?=
 =?utf-8?B?VmhCMmVpRGtDVlBzOFlBVVg1WVlUYlVjOGh3NURiTUtUK09jeWpPMVFGWEFZ?=
 =?utf-8?B?NTNySEZTYzZEVFBuTlNkU2l2TnUwWXZZSzI3KzRXV3NQTm1uSTM2Wjk5dmJQ?=
 =?utf-8?B?TDRieVNRMmZlMTdkcnVJdHQzM1J5WE15WjFLVnV3RE0vSGpxMzZzNnJNYld3?=
 =?utf-8?B?a3RYMFVNRS9NcVRzcjM2RitOTGhNRTVYbmovNWQyZ2dITHZ3cnRvdG5MWGM1?=
 =?utf-8?B?Y280dWJqbWFTZktYV0poVW43UTBIQTZYMENWNWNtbGUzMEd4T2p4NDVqeU9V?=
 =?utf-8?B?QmxzaU12TUFUa0hmaEpoVXZVa3VFL2cwbHRibVlrMk9RTm8wQ2tOdUdMeUpB?=
 =?utf-8?B?ZTE4UTgyemtiQlJTYlkvMDF6MHEybE4rbDI5Y0dDWDRkSThvZkFxR3BBNXBP?=
 =?utf-8?B?ZVF6UzNFU2hIY1F1eVVvcFdFclQ1eFJ2OUdRWUViYTdOQm5BMUtXd3V1Ulpy?=
 =?utf-8?B?bE5adFpOSnhTc0oxVVpGRko1ZUtSM2RzU0h4S2JVbkh5ajlKTVJpMDRYZUJu?=
 =?utf-8?B?M1lKYnhzNnl0MHU5MkI0b1BjUndJNHM5SGw3dTZPRlZXamRRTERVd2ZHWGx2?=
 =?utf-8?B?TGsxWE1HSHNiRWpYc0lWUzZuamdpS29oQ2tmNTZoU3Z2UVhoS0dRRFRabkRD?=
 =?utf-8?B?akoyVitpRUtabkZWT3NtbHd2akVXMzZmZUdLOVFXeEhEelIwbXNiUXU3dkcy?=
 =?utf-8?B?dnlmekxHQmozdVlraDY4cjg5cllDTUQ1R0lSV244UzdJN0t4b24vZVRHKzI1?=
 =?utf-8?B?NCtDRmZnL1ZuM2Y3TE9ydWpjY09TWjVKUmpXWlUzMFc5WDdJYXJPcFdtK05R?=
 =?utf-8?B?dXdGaDUxNFF1V1QvdG9BVnp4bnpCc1pJTUxFbHVvbFRLd2lKSGg0OHBWVk0v?=
 =?utf-8?B?SWxlR3V2NmNHdEVHR3pCRHpadXFSVi9xODhTblpTYk1GNG5mdExRRC9mWXMr?=
 =?utf-8?B?a0tjZk1sNkFPZWpCQXVqRS8rTkl4OXIrVDR5OUZjdmtGRzJBSWJPWHRBVjlu?=
 =?utf-8?B?NHZ6YnpsR3Jld0JtN3dNcm9za1BBVnlYUEtHZXhrOUp3UjNuSFpZTENxN2Zw?=
 =?utf-8?B?UVpXSnJwcWkweTJGMmhFZkdmV0VNZGJ4SE1kcGNudHBDS0YyMko2S2dOYmtl?=
 =?utf-8?B?UFRYT3YvWXdSLzFCQjVXS3NJRHYxTjVvbm5ZQWo2YStHYVF2WGZXL0l2VEE1?=
 =?utf-8?B?blI4elpNUWRVenc1RTRQK0Mxek1OeHo3Ujl5SXhUY0xhdkxaeURETG9LdkFX?=
 =?utf-8?B?NUZYRElIRSsxbEdTOURTeStwMFdqZUl3ZXBSVHExdk1rYnkvcHpmUjNSeDZn?=
 =?utf-8?B?bXF5Y0dVdTJrbmRaVHRhL25TNWx3d2h0SmptNThEUW9UU2tORVJKSlN2UHgy?=
 =?utf-8?B?Tk91Vys2K3pkUmZQUGhNQmorYnhDQXVFT2NYV1FZUVdaSnh0OVRRRWlnM1RB?=
 =?utf-8?Q?lwkxuW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:18:21.9653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8e6bea-08f5-4e55-c2a9-08dde38e6d9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8168

Hello Tim,

On 8/23/2025 1:44 AM, Tim Chen wrote:
> While testing Granite Rapids X (GNR-X) and Clearwater Forest X (CWF-X) in
> SNc-3 mode, we encountered sched domain build errors reported in dmesg.
> Asymmetric node distances from local node to to nodes in remote package
> was not expected by the scheduler domain code and also led to excessive
> number of sched domain hierachy levels.
> 
> Fix the missing NUMA domain level set in topology_span_sane() check and
> also simplify the distance to nodes in remote package to retain distance
> symmetry and make the NUMA topology sane for GNR-X and CWF-X.

I did some sanity testing on an EPYC platform  on NPS2/4 and didn't
see any changes to the sched domain layout or the sched_node_distance()
being used when constructing them with the series.

Feel free to include:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek



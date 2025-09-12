Return-Path: <linux-kernel+bounces-813197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633E1B541DA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15E73A5BCD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A42F272802;
	Fri, 12 Sep 2025 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="38LJibTB"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4121C3D544
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757653711; cv=fail; b=E5MCgy7MhqTmHc8nvdsjLj0NdhFO8YptC8banqYAgYgZ1L7yXyWwtBfBK1NK/ALBhMmZuxeqHiIwXJD1E/Y8wBLCIB2IMo+UI5cLTfFQVGWVqkHsGkM1Meb3Gi4dI9ibff8m1Gn/iPl02lPLx2fWy5gbsTs8PY5QKCx4MOiLPF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757653711; c=relaxed/simple;
	bh=GxaK9WsSYBjgdpaH7tHdVHOEgUdjn73Jt5kbIImuDyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aM8a0Or7V5+Q4BSmypaErUfJmdPQZenxbB2K8m7gT9Dx2gMxmnLLXpk4HfpQ2UVqmIIwT9+GCvrk8Opf3NpDJZ69G2wHXGiBcOSYHPLbT1dfAd32eNp2pb+gHBWGKMksEjRVc4F/7ljXtScy4CLwGZexSepJ/5zXZO6aNgyxO3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=38LJibTB; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ylcv1oyMcP38ReU2n4YwiQdPo75S87dzGZh6ooW/4RuT0tGAiqbFdLhbJYysidK5qV+NEx2MIdeZRS4qa0IBs5PgTIn5nMDgPQcEfTHNG30iTTcKO47etrXBfMMj5pbCOzciYC86aCtAxsiYOfej+YjyJ1jh7WdWqizwwmUhejqBYXPc8xslxaRpi9oXmVxaxIm/D3TF9NE1Bh9x5KJHr8WrQZeOJ11fns/ky+SPhUxqlK11iUSbQNlZiepcnu2sDrXR/8wio2fgMDuacqFBdHbfxmu5uEwmW0mtpdXN+7i3Rkodwze5FwB839++WcgGqIBbKgtm0JBpiTFFxOAzKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E52278jcX84LU+ZU+l8aYnS8MzHekD6igrgpqbea2eE=;
 b=QWr+RDzpYjzQ0gpnEdysUSCRCeFeGWVextxML3ExEdFinIx78TbfmCUvn2J7CDkImExQEI+LHDpUgSb7xIzOWmbbpSI5bGWr7ZZArjzUMt8SYqqbTyFmR+gp2VIY/lT3ELMuI3GPMOyv7DaeKdQJsOrajG9y4/RF7rpuQE78mX/qVsmLPY35hca2ujaOxR7gJWK3k8tm5lTsIbISDwKP/lhnS9RErQy565uS4jzbTU9pCRdTbdkwy/aOzelj8jx70WRdCNkrXKy4pOgKh5oEr4ieABPEFXSSZ7xUA3RIpI+F+Ctuf85IaaL/N0pBOizL+9CcElpiWsQP56CqeYXhjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E52278jcX84LU+ZU+l8aYnS8MzHekD6igrgpqbea2eE=;
 b=38LJibTBH6OXhNMlNfsSOrZ7AsGQ16jA6C3S0KhS19dj0bwUaYqDesaG7wHwJw/J1WQYRpbh/smVv5BHxxaYbDkb9VOQ1yDhS6AQIHy/5fiZeXvJJ9S8gnOMDqmCr4pTjN1AMnjyDsyJJA6GMjYFUozYEoyTxJoIIoE4LIcpeII=
Received: from SJ2PR07CA0002.namprd07.prod.outlook.com (2603:10b6:a03:505::25)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 05:08:21 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::29) by SJ2PR07CA0002.outlook.office365.com
 (2603:10b6:a03:505::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 05:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 05:08:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 11 Sep
 2025 22:08:20 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 00:08:19 -0500
Received: from [10.136.41.4] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Sep 2025 22:08:13 -0700
Message-ID: <91ab8136-64f3-45e3-9fec-567aab193353@amd.com>
Date: Fri, 12 Sep 2025 10:38:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] sched: Fix sched domain build error for GNR, CWF
 in SNC-3 mode
To: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tim Chen
	<tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Libo
 Chen" <libo.chen@oracle.com>, Abel Wu <wuyun.abel@bytedance.com>, Len Brown
	<len.brown@intel.com>, <linux-kernel@vger.kernel.org>, Chen Yu
	<yu.c.chen@intel.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Zhao
 Liu" <zhao1.liu@intel.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>
References: <cover.1757614784.git.tim.c.chen@linux.intel.com>
 <208a0a8278a28521e7bbc5114cf9899d31875d15.1757614784.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <208a0a8278a28521e7bbc5114cf9899d31875d15.1757614784.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eaabe31-eced-4b0c-51ff-08ddf1ba6471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|30052699003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmtSRng2eFBqaWQrYzRsNXJMTnQ5ZjFxbCs5QkRkMUdsTkxNUUp2Wm1vN3NI?=
 =?utf-8?B?dHprRGNUa3FxQmcxS0RtOC9yOW0rNStGeTI1MUxrTEtReFpCd0ZJMGR2OUNB?=
 =?utf-8?B?WU9HRmxsWkF5ZHkwT25EM1JpTk10V0VBSXZsTWdtV3ZkYjk3VXZUaVBIc1pP?=
 =?utf-8?B?bjdtSU9tanFqcnVWMm5BNVExVG1wYlRlL1RXeEpSRmQ1L2FHMktrMW1NTGVL?=
 =?utf-8?B?U1VxNXhSWFdVcmVMR0xWb2JtSUFFd0hBR1lQMkVwZkwrQ3dldFlSOElxUGMy?=
 =?utf-8?B?aERjTGM5WVB0ZE5iUzB5STR6aW5NQUdSM3pjVXVROWtVU295TThDK3VsVEQz?=
 =?utf-8?B?RWoyK1FGOVdtakd4K3ZlNEJTcmlsT2Q4N3ZnT1JsbnpsaGxsTU5sRTdzQi83?=
 =?utf-8?B?Y2crSDEvL3Y5K0hFb0oxTmRqZzZMRUpSODlZdVhJR3JHSTBONXNGcTZVbVZZ?=
 =?utf-8?B?S0QzRXFEdUltbzBSd3RHeVZsNjBuNHB1d1dLR1cvSDVIYnF5WDAzRzFPZE5j?=
 =?utf-8?B?bDZMQ255dFdkbUZ0YVVqM0xXU3dCRzlhaWYzRWZ2d1NDdElSaVhqdGsyOGNM?=
 =?utf-8?B?RTJ5QTZOS1V6TTNQRFFGdlZCZEtlTnNXdXFQaVc0cmpKcnM5RXFzOG1pTklR?=
 =?utf-8?B?b2w3WlpBL2tkVVFmbUdXaENJbGtvUnJtRlU3NnZpZ0xxc0lybFpqeXpUWVBS?=
 =?utf-8?B?am9rbjhVT28yQlBwRUFlQjlodjA0eExVS0Nmb2prVlV5SkJSdW9LbTUzdTdI?=
 =?utf-8?B?cDVqT3gvZkZmMWVadG9oZHFaTU9xd3FBVDYwQ3ZXbytqMUhQUHdTVmpEVmZF?=
 =?utf-8?B?dUgrMUs0alVmUDVEeEx4c0k2bjUwejRnN20xaVN5ZFVCTzJFNGhiSFExRnFw?=
 =?utf-8?B?ZSt0citEMW45Y2tldC91L3hLLzVicWk2Mkp2TDJwNHdOeG9HQS85Qm52WCtF?=
 =?utf-8?B?YjRQL2VsVjNFbkZOTlhlM29HdFN3L3BlT1Z1NTdVUkk2R2VYUHUxYnVlUkxr?=
 =?utf-8?B?ZHpGeVhnc0ljbk1ZYk5QTFNUdmJmczllZVpKZTVtQXZiNlZWQkNKckZJZ2VZ?=
 =?utf-8?B?OHBsOGxtODBPd3Fnd21wQ3lObE16bWVYREUzKzdlUUhsZERLdXZSVXVVbFFI?=
 =?utf-8?B?eEQ0T0Rod2pRVDRmSTEyeUVJNlBWUTJ3bmdadVVUWVlldnIwZG1sMHZmRnRw?=
 =?utf-8?B?TWdtcEpnbkxWZmhQZmR4OTgxV0VBSFpXdnpsSGZ2Vk55M2JDWHprdnVuODJY?=
 =?utf-8?B?by9heHE1SEw4bktObHVYa2ExaW9PUHBSWCtTTklMc3EzSXNVZFBsdEJPTkxO?=
 =?utf-8?B?QVVHa3JWZTZZZHBZUUdKODhJUzR4RENCZUFnMlg3bWc5NFI4V0Y5NlBLczBw?=
 =?utf-8?B?a1g1MkhnZU82S0RRT1Y2dFlnUmg5YmJRQkpBTUh0anU0aGw1RkptUi8xb1RT?=
 =?utf-8?B?RVVIUENIdmFENEh4bmpHT3loY2Q2OG5LT1RVUkNFUUJEWmNacHFBaisrMGlJ?=
 =?utf-8?B?c25xRW9FcUxpL0VMOXZZM3RkaWhqNFlaV1BYK1pBVzIzT1FxeW51Wlp2ZTdk?=
 =?utf-8?B?S2RMSmZrdDNxUWg0Zk4wUUY1UFRuYjdZa1pmR2ZwNmZnd01HTlQxUUZLM25R?=
 =?utf-8?B?Rlk2RG1lSzBVYUpQem5ob3I1bFhlM3lyWmE4U29WWWZmaUxzckZHRFJuQkFI?=
 =?utf-8?B?cXcyRUh2eUp2S1JMZTZETTFNcjBWenZGenVSL05lSkRiR0xWQ1FMRnFSYktK?=
 =?utf-8?B?YmF5VGw5Yys2SjdtWkZqcSt5Sm16U2htKzNMb0FMeU9KbU5xYUhtSGh5ZGU0?=
 =?utf-8?B?RFhPRnRNUmZhdGNUWVNSSWxmWlJkZHZGN3VGZTB1bkVBQkpsMk00aXQ1QVhW?=
 =?utf-8?B?QTE3VWdnME9BVk8rL0dTUlMzV2lEaC9pYTR5T04zTlN4SjY1blVoVnkraXJC?=
 =?utf-8?B?RDJVTXVwa1UxZEhxUUV6cHdOUUxkSUQ0K29SUXVjeDhySnoyNGpEQTZBTURM?=
 =?utf-8?B?N1dQTXk1TmtOdVVJcXJmUHcvV0NoeThOMERCRWU0NWdXQmF1QlhyS2dMcTVo?=
 =?utf-8?Q?bD1A5h?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(30052699003)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 05:08:20.6484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eaabe31-eced-4b0c-51ff-08ddf1ba6471
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015

Hello Tim,

On 9/12/2025 12:00 AM, Tim Chen wrote:
> It is possible for Granite Rapids (GNR) and Clearwater Forest
> (CWF) to have up to 3 dies per package. When sub-numa cluster (SNC-3)
> is enabled, each die will become a separate NUMA node in the package
> with different distances between dies within the same package.
> 
> For example, on GNR, we see the following numa distances for a 2 socket
> system with 3 dies per socket:
> 
>     package 1       package2
> 	----------------
> 	|               |
>     ---------       ---------
>     |   0   |       |   3   |
>     ---------       ---------
> 	|               |
>     ---------       ---------
>     |   1   |       |   4   |
>     ---------       ---------
> 	|               |
>     ---------       ---------
>     |   2   |       |   5   |
>     ---------       ---------
> 	|               |
> 	----------------
> 
> node distances:
> node     0    1    2    3    4    5
> 0:   	10   15   17   21   28   26
> 1:   	15   10   15   23   26   23
> 2:   	17   15   10   26   23   21
> 3:   	21   28   26   10   15   17
> 4:   	23   26   23   15   10   15
> 5:   	26   23   21   17   15   10
> 
> The node distances above led to 2 problems:
> 
> 1. Asymmetric routes taken between nodes in different packages led to
> asymmetric scheduler domain perspective depending on which node you
> are on.  Current scheduler code failed to build domains properly with
> asymmetric distances.
> 
> 2. Multiple remote distances to respective tiles on remote package create
> too many levels of domain hierarchies grouping different nodes between
> remote packages.
> 
> For example, the above GNR-X topology lead to NUMA domains below:
> 
> Sched domains from the perspective of a CPU in node 0, where the number
> in bracket represent node number.
> 
> NUMA-level 1    [0,1] [2]
> NUMA-level 2    [0,1,2] [3]
> NUMA-level 3    [0,1,2,3] [5]
> NUMA-level 4    [0,1,2,3,5] [4]
> 
> Sched domains from the perspective of a CPU in node 4
> NUMA-level 1    [4] [3,5]
> NUMA-level 2    [3,4,5] [0,2]
> NUMA-level 3    [0,2,3,4,5] [1]
> 
> Scheduler group peers for load balancing from the perspective of CPU 0
> and 4 are different.  Improper task could be chosen for load balancing
> between groups such as [0,2,3,4,5] [1].  Ideally you should choose nodes
> in 0 or 2 that are in same package as node 1 first.  But instead tasks
> in the remote package node 3, 4, 5 could be chosen with an equal chance
> and could lead to excessive remote package migrations and imbalance of
> load between packages.  We should not group partial remote nodes and
> local nodes together.
> Simplify the remote distances for CWF-X and GNR-X for the purpose of
> sched domains building, which maintains symmetry and leads to a more
> reasonable load balance hierarchy.
> 
> The sched domains from the perspective of a CPU in node 0 NUMA-level 1
> is now
> NUMA-level 1    [0,1] [2]
> NUMA-level 2    [0,1,2] [3,4,5]
> 
> The sched domains from the perspective of a CPU in node 4 NUMA-level 1
> is now
> NUMA-level 1    [4] [3,5]
> NUMA-level 2    [3,4,5] [0,1,2]
> 
> We have the same balancing perspective from node 0 or node 4.  Loads are
> now balanced equally between packages.
> 
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>

Feel free to include:

Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

> ---
>  arch/x86/kernel/smpboot.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 33e166f6ab12..3f894c525e49 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -515,6 +515,34 @@ static void __init build_sched_topology(void)
>  	set_sched_topology(topology);
>  }
>  
> +int arch_sched_node_distance(int from, int to)
> +{
> +	int d = node_distance(from, to);
> +
> +	if (!x86_has_numa_in_package)
> +		return d;
> +
> +	switch (boot_cpu_data.x86_vfm) {
> +	case INTEL_GRANITERAPIDS_X:
> +	case INTEL_ATOM_DARKMONT_X:
> +		if (d < REMOTE_DISTANCE)
> +			return d;
> +
> +		/*
> +		 * Trim finer distance tuning for nodes in remote package
> +		 * for the purpose of building sched domains.  Put NUMA nodes
> +		 * in each remote package in the same sched group.
> +		 * Simplify NUMA domains and avoid extra NUMA levels including
> +		 * different NUMA nodes in remote packages.
> +		 *
> +		 * GNR and CWF don't expect systmes with more than 2 packages
> +		 * and more than 2 hops between packages.
> +		 */
> +		d = sched_avg_remote_numa_distance;
> +	}
> +	return d;
> +}
> +
>  void set_cpu_sibling_map(int cpu)
>  {
>  	bool has_smt = __max_threads_per_core > 1;



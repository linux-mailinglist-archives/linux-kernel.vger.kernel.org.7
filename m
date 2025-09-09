Return-Path: <linux-kernel+bounces-807254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCB3B4A221
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482E41701BB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8063019B0;
	Tue,  9 Sep 2025 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x79Ew/oz"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF65305061
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398999; cv=fail; b=n2lNgRBhxhs5huDlMoLaRwIXePOWLfGif+yZoH5R/cXj61pwoAm5l6CvVVW6XKsnrdCxSh+wRoldqvE8uoksEGjhe3a4wRKyvzvATesbUk7NAbrgrcRbYU3XIfvb8TVQur4Yn0+7Qr4RiYPYO2SNUqkzYYWDX2fdYorsASsElYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398999; c=relaxed/simple;
	bh=pgtgLbgd+D7ISoPezQSy2TFgStZKjTbclp8GI5vtMgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oGk2OFtZn+imZswEtgQd+/JYmxZ+JweCPW9TCu59qc60OH+xpLHkSd4o3nwIMuJQqjNU765kVyRPyf+tlZjsH/W0uG+3ndGhntQ6Ml/AdeYrHNduSlLHSelXUEtqWdKVqWRwgYm4xRV2NAyZ77LnEGViTnRE/v0maBtN5K33+aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x79Ew/oz; arc=fail smtp.client-ip=40.107.95.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkm09iCZ6lmy3S5uROLPv5QdQ79lLbuxaH0l1jl1FpnM5buvkvpjH5wdcANnV29CU40wI5hdAerKsFS1r8RoJoIqbqL12nputa2jmYUX6tUbkAlzGvn7OKTDh/d/LErezopEtQIYSik7w3o8x7aEuwC+9I2a17e1MiVUM9vkb7FqkhW/4l/FX7ycz2X3V8WIQ3YZrLtYSrPSR0zwHwmbnSKUTr8ssFXqaCBuBZz2v+X6ThlICc2pATMMR0qVapkH864ri5NaqWSIvLCoKrpZiASUc/s68HguOWSRkA5/CptPZtMD1gXMXO88Hv75hHxffjhxJbjFmOPfoD42o5o4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3lMG47KzPIHGUa8sdMh1lbAbC7UvlyYsnAruJfU/aE=;
 b=RtnZlU0OkzeSxzd/OJrUJ62NSHCH33vtw8m9TrqpDuiOAIABfrfv1OsXSGuItH10AnjkXyYzBfQECn6sqpm2xrDGOSBd7Ff49plElhGMizscTy9CxVT00qbCSN2udb2vAOdv638JQTVPo0hwsl2eChuti0Rxs1NbYsCQAzIiAB1djBnuLOBrNtga59mqeFSYStizW5vzHvtMd8hWBJ5fSg2CESYh7p3xpt2w6LDk+XYhv6xr3UQvj43xik5zQDBYoTuhn9HT23mZP3AP+PM6zjgKyMC0lYbzSSOgwj25CkR81erVKsksscQ0om9CCteuEwHcmCuezxbinAa4CL3MmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3lMG47KzPIHGUa8sdMh1lbAbC7UvlyYsnAruJfU/aE=;
 b=x79Ew/ozYFBZJW0l5cW1wreOO6IbbX6aAhboL4HHGszDL7HIOwqC4bRy//D7vI0CO/YyzizEf4Th3IwulONAsU0/Rl6EAchOeHMaRbmD6xXJRkihgfJ19yUi2p5T94sCg/hqF/bRWCrJN98aF/GEiUEu9PyyZwLmOBTOJ0zFS7k=
Received: from BYAPR03CA0026.namprd03.prod.outlook.com (2603:10b6:a02:a8::39)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 06:23:09 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a02:a8:cafe::47) by BYAPR03CA0026.outlook.office365.com
 (2603:10b6:a02:a8::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 06:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 06:23:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 23:23:04 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 23:23:04 -0700
Received: from [10.136.43.237] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 8 Sep 2025 23:22:56 -0700
Message-ID: <fd017cc8-0eb0-4961-8f59-575505f27a68@amd.com>
Date: Tue, 9 Sep 2025 11:52:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Propagate load for throttled cfs_rq
To: Aaron Lu <ziqianlu@bytedance.com>, kernel test robot <lkp@intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, <oe-kbuild-all@lists.linux.dev>,
	Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>,
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, <linux-kernel@vger.kernel.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi Zhou
	<zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>, "Florian
 Bezdeka" <florian.bezdeka@siemens.com>, Songtang Liu
	<liusongtang@bytedance.com>, Chen Yu <yu.c.chen@intel.com>, Matteo Martelli
	<matteo.martelli@codethink.co.uk>, Michal <mkoutny@suse.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>
References: <20250908110548.GA35@bytedance>
 <202509091233.f6nP3BVh-lkp@intel.com> <20250909061746.GB35@bytedance>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250909061746.GB35@bytedance>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|BL1PR12MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1abd87-a107-43f5-116a-08ddef6958c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXVJZW8reWdtNUV0VnZmanVORkJhcGpnQ2lYa0YzTk5zR2xodGErNEp1Yk5o?=
 =?utf-8?B?RU1SQjFJd0QxSFhPSFBmMTgzaHIvMzNxc2FUUzhwVXAxZWkwMWxDK3l1ZTNE?=
 =?utf-8?B?SkVkbHJXU0VpbXB3dXdoMC9jK2RZazdFT1BxQUdKRm5vTC9iZjBBdTBCN1Na?=
 =?utf-8?B?WDNkbDdVek9rSWVXWURhVG9TVWpQUmZSRmtabWE2a3lxc04yZk1hQkdSRWY3?=
 =?utf-8?B?MTUyOVkyNWN0eXNNOTYwdGtXNGVEeHcwTnhZY3lvTTdFTmwyN3IxNDlxS2FF?=
 =?utf-8?B?MWpGQkxiTXFoSVB1cGJvYkRITUluRm1nMFlkSFhZMDVnRmRBVG1YQWQzSDJt?=
 =?utf-8?B?dUZ1SEZjV1E3R2Y2YnJjcjg1WWpacDdrOUdTc2txajZ3SDNvMU9EcUlPSHcz?=
 =?utf-8?B?bDI4S2F4UDkyaUxvR0RISk5qeGZjakNQRkNpQk5OL1FlTzV5S3FBM29BK2xX?=
 =?utf-8?B?VGh6by9HSHpJYVFHcyszbE1rbzZvQ1UvK21qeXJ2ZVNHbkN2dm0rR1FhVFE5?=
 =?utf-8?B?bFN0UDRtaE43cHNRZGZiYUd5aXM1a2U0UWZRVlRYZ05FVlRNMC9HbHJEQnBS?=
 =?utf-8?B?VjN0dFgwOWEvVXJOTTVYK2NoOGlYbmhGT1c4NXBBQ2VONWVod0lTQnlsc1lZ?=
 =?utf-8?B?YTE0KzNEU3NxUlJVRzFyajZidThVUEI5R2VWc2w3VG1DNWVxVTUwVmQxTXdl?=
 =?utf-8?B?c2VOQmlZaEpSR0JHYmcySXZyY2NMQjd6elhHWW9lR1lTOXpNVyt3VStpQ29E?=
 =?utf-8?B?dDdHTWwyd0c2VFVrRVBvTGVYYzZKVFc2WEZPV2d0NlNzT2hsSk5SRXFQYmdj?=
 =?utf-8?B?QXdtVGNVSnBtVXlLdTFHN3Z5SExFVktYVnBHK24wcGVPL2hONlc0MWNUcjRy?=
 =?utf-8?B?MjFmNWJlVTB5OVZqb1FtQ3NFWit1Mk84MGZ2dS9INnhTUHlubDJKSUhmdDlV?=
 =?utf-8?B?aW5FSUhsNldCT0FtMzhoMGY5WTh6Q0VFMzlwUk1IanU2SFB6WHdCQTJtU1F5?=
 =?utf-8?B?czhrSTQvYU4reUxvWFVZdzNYeXVxcGtLQTFYakN6bkxONWkxTHVubjg3ak5p?=
 =?utf-8?B?RlJzT3hhSDR0azFha0RDc3FmTDkyMjlrbkRVdXIzZnE0UzFBWkZ0a09HdE44?=
 =?utf-8?B?N2laeUVhTXhTL1lTYUdDQXNNamlrQmpsVG14ZVRPajRLaHZ2aFNPaExKTkI5?=
 =?utf-8?B?TlhybXcvRUdodVptcmJEZFlZRm5XMEQ4ZVJaYkhyWlJHSG5xQitTV2lVVFk1?=
 =?utf-8?B?eVNkdEtYWmp1TmtQUjlib1ZIZWVDWit4OTV2aTFzN25sWEZvYzdNS09Yam5a?=
 =?utf-8?B?c0t2WVAwQjFBNWtCZGxHMmgvbWVmOWY0ZjFTU2ViMEIxOSs4bG5BNmhaL2Y3?=
 =?utf-8?B?TWVvVDZCaXd2TzYzbklsL0RXZUMrbGRHZGFqQ2NXaUVab25NZ0xrYkdXRVZz?=
 =?utf-8?B?RGhaVTV4VkJ0MVdYTkpQT3NvbGlEc1hQeFZFVzZGcytzcEhmSHh3T2Y4amdV?=
 =?utf-8?B?Qm5ib2M5T3pnbmlQMzdTN2w4Q2hsVE9ZZGtWUjNYLzNqcldEaTlLWjI2L3BG?=
 =?utf-8?B?ck12cFk4UktOWm1JVDdHKzl5UGRCQTcxalBHTjdVbUtyMjl5b3psVlZMdlYw?=
 =?utf-8?B?R1QwNzZaQlVKUHdGSmZ1cmRzOWFOcHowbEhwcTlSSnRGQmRTUk5KUUdlbHJ5?=
 =?utf-8?B?ek5YTzVtYVBOREhmRURqWEc5MVJYN0N5L0JXQkwvcFRrVFY5SGVBSWRKQzA2?=
 =?utf-8?B?Z296amg4aXJWK0pTQ1BTeWprUk9LWDlmVDYvczJzY0dydkFNTEJ0bzhVRHph?=
 =?utf-8?B?b2NnUy9RZE8xbmx4T1Nyd1Z1cElkdjVmd24zYmt3NUxrc0RWOGZFRXV6V1Nz?=
 =?utf-8?B?WE1vZUVxVzFzSGxCNUZsZDN5QXM4Tm8rV0lQSURERGlLSW9ZNXN6Ky9iam1z?=
 =?utf-8?B?eEZjbzNUbkdjRDY1dmdsQm54V3JzRGFCQ1Z4NVBCM2FaZEJmVS9mK1RJYnls?=
 =?utf-8?B?RFh2ZU5FTVlTOTQveUVkRG91b01TSTRrTXlxcHlPY2Zwcnp5eXlmMjlmUTBD?=
 =?utf-8?Q?wvFESz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 06:23:09.4862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1abd87-a107-43f5-116a-08ddef6958c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705

Hello Aaron,

On 9/9/2025 11:47 AM, Aaron Lu wrote:
>>>> kernel/sched/fair.c:6747:1: error: expected identifier or '(' before '+' token
>>     6747 | +static inline bool cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
>>          | ^
> 
> Sigh, I remembered I did a build test with !CFS_BANDWIDTH and now I went
> to check that build directory and noticed I didn't have CFS_BANDWIDTH
> disabled...
> 
> Sorry for the trouble, will send an updated patch later.

While at it, another nit.

On 9/8/2025 4:35 PM, Aaron Lu wrote:
> @@ -13151,10 +13161,13 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>  {
>  	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>  
> -	if (cfs_rq_throttled(cfs_rq))
> -		return;
> -
> -	if (!throttled_hierarchy(cfs_rq))
> +	/*
> +	 * If a task gets attached to this cfs_rq and before being queued,
> +	 * it gets migrated to another CPU due to reasons like cpuset change,
> +	 * we need to make sure this cfs_rq stays on leaf cfs_rq list to
> +	 * have that removed load decayed or it can cause faireness problem.
> +	 */
> +	if(!cfs_rq_pelt_clock_throttled(cfs_rq))

          ^ Can you also add a space after the "if" here.

>  		list_add_leaf_cfs_rq(cfs_rq);

-- 
Thanks and Regards,
Prateek



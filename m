Return-Path: <linux-kernel+bounces-813557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AC6B5479C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21443BFA44
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC6027B330;
	Fri, 12 Sep 2025 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cp8WXUsH"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8E527B337
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668999; cv=fail; b=twns5GJVgTaDqj1hG8bbqBk6KJsAPqWQd+ITRElLwEoNL8mt89b6uLyRyqlQ/mAK11AS8n0Q60jt0gogGOew0I15/YE6mMX4Ish5zvNSzK/ZjLtbPL3mgg+XYRFeuCv58ImNHJKypxJumLutRyb3Hujt+CJjeRz5zu1/8WQw6Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668999; c=relaxed/simple;
	bh=GlizhtvKFp1sugbH0CWmbxUNugDKEfovKbutnccGDmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lIQbCslMcmh3KLnCIPJ0uPjMW5rXvn8QTqoR1H8YdcH6D9e75/hTk4XzKVLd8DC74cEa5t8efI+3IIpgJ1O0E5AFWKJQXjZk8zKhaT4Yyao8Bw0ZjaiXm+aGyZkxmWA/3PSgshBJ7RxcykbF2uwT6khCXnmiF2RiOffYZSLsg2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cp8WXUsH; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8MpC2ORfA61/KPrn4zDsZ6nqADWdfhvFpnlaXbyJ/aKQu2pJSOuHfmCnLB6P3dbhcW8KzE51FlCSA08VDuwcfWw/P1+SnIKuh2aAmwN5Qs2zC/lCK6/zOym/irHFWnI/JlS5W7sNWYNmYpkKhI3rDbn2oIUqBLDJxDmCHFYwbNhbnzhb4UbjUimoM47EeWVOD9gvZJ959+tYfPvIuwni1a5lGwVk8kDdubRqykP0Dt+XgdMcSNudlh1D5cdVNjtdVgi3CPs9ClPzE++MDBASFV4SVqBMM6tSmnkZ24vP2g3YqiQHY06c/r4slGVz8C6uXFw9AAuSMEJZZHmGtXd3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fV/MrKuKtKjpdxbw+vraQ1UtL9mzscsqJWRXi0MGHs=;
 b=QMDQUqfv3INzY9FNwbOnY2kn4rk/YTG5f2QV71cjoHuMpCf0p5odkfzxamCFDO2TSOQ38+fJJl+5BxUHiFIsmI+L61YThUjYVW2kbUR4hZqrX14F4JQ2Ua/spUDrnkGsYyMHzFFT313wpjauVjO5ngmrEingzoly0o7jAhoPI7Cfuz5rPpJAJUt8LihCxXxSRaTikCmWFgSaR/3KntkUV/RJwyqv/33YnqwmjCg72mTHDYklMi34Dh8oJdALYtzV+Nw8zvMCDYNMwM5aENL/+QjzPMSiK8YjN639FHX7VRPF7U8+Rpc+jY+YZyIpoMpZFJ+A3z/mxaXML7j/PJQLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fV/MrKuKtKjpdxbw+vraQ1UtL9mzscsqJWRXi0MGHs=;
 b=cp8WXUsHKfR0Tuz4SD+PGBD3AzEVcqX5s9030/oaPdyn4fIi0dvM0SllbNKNo8p+X2/QjzKv6oAflSGsj+Eg1/4v5ax+exl8f/Ll6AfcRJdHARhZoqZoy+1hONUMJFx6Q+/HMVOlVECZJpxjE6VzCJDpcwz+Team3skUFadkZ1c=
Received: from BN9PR03CA0665.namprd03.prod.outlook.com (2603:10b6:408:10e::10)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 12 Sep
 2025 09:23:12 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:10e:cafe::d5) by BN9PR03CA0665.outlook.office365.com
 (2603:10b6:408:10e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Fri,
 12 Sep 2025 09:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 09:23:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 02:23:11 -0700
Received: from [10.136.41.4] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 12 Sep 2025 02:23:06 -0700
Message-ID: <71b7352c-2c27-49d1-8bff-c0500cfa21f1@amd.com>
Date: Fri, 12 Sep 2025 14:53:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] sched: Fix sched domain build error for GNR, CWF
 in SNC-3 mode
To: "Chen, Yu C" <yu.c.chen@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tim Chen
	<tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Libo
 Chen" <libo.chen@oracle.com>, Abel Wu <wuyun.abel@bytedance.com>, Len Brown
	<len.brown@intel.com>, <linux-kernel@vger.kernel.org>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Zhao Liu <zhao1.liu@intel.com>, "Vinicius Costa
 Gomes" <vinicius.gomes@intel.com>, Arjan Van De Ven
	<arjan.van.de.ven@intel.com>
References: <cover.1757614784.git.tim.c.chen@linux.intel.com>
 <208a0a8278a28521e7bbc5114cf9899d31875d15.1757614784.git.tim.c.chen@linux.intel.com>
 <9b45b33c-3bd1-4075-98a3-d8f5cfc08785@intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <9b45b33c-3bd1-4075-98a3-d8f5cfc08785@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 477b4ab6-432d-4f24-20e9-08ddf1ddfef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTl4d1Y2clU1b0hnZXFSaVREa05SUjZ6NisyWlR0aE1Zd0tMaGZvY3YzWllJ?=
 =?utf-8?B?N0lpMVYzUUVsV2MvMjFaVVdzM0d6OERCTGVZMWhlVlk4OWFsMVhoZlhRZGhi?=
 =?utf-8?B?RXkzb3hsb21DdDVnQUhja2JOOHZKYjYrTDJUT0h3MVczVHNmZGN0KzFaWWlv?=
 =?utf-8?B?bHpMWVNVY0tmMWZTTlJtemdkQnFjTkdIYk44WDZIYisxTXpBNVFZL2R1Uy84?=
 =?utf-8?B?SWNwL3lSR0hTUTc2NjJpOW5jWXgwVWtrcGdLY2JwVG8rcHQ0WHM2S2oxdnMw?=
 =?utf-8?B?WUN4Y2g2KzExcnJacnFFa091bnRGRUpUdTd2Rms2Y3h3Y0lFdjh0Mm9QSGhD?=
 =?utf-8?B?MWJuUjc4a1VRbC9xZGRBa0Fyb3d2cVBVREVuNWkrdzR4RDRxNUVVWkhobjh6?=
 =?utf-8?B?ZGdISFVjVzZtREtGMnJTNmpFOTlsL2wwU0JQcEh0VkZyN1M2eXlPUUQydXNy?=
 =?utf-8?B?Z2doc2VxYUVvS1lQVWdLR0lNbmZRZTZGU3R3ZThqNFdWL1BOd2lJS1JscDU5?=
 =?utf-8?B?R0pUSHNXMUdmT05yMXZOU2tlRmtsSm80NExhbFNudEt5aVF5Qi8yWkQ0b3ZF?=
 =?utf-8?B?L1ZzY01KeVl4Z0VlOG9jVlU2VDNLM0ZGU2NIM3RQMWk1c2tqV3FtRmphbDN6?=
 =?utf-8?B?L2ZHNlNUdTNTUjdiWW9TVEVTTjdha0NibUxhM2JDRC9NcFdaRjFWUWgrR1Z2?=
 =?utf-8?B?QU8rSlBYSzFvRkMySis2SnhacmF4Rm0wSlhZMndFNEh0K0xhU2habWtEditq?=
 =?utf-8?B?ZkFPZHdsWWtKaGgvVTNwRnNOdXUrd2RYTzdpejB6MGsvR0p1aS9uMFBEVW9Q?=
 =?utf-8?B?eG5tdmJCN2dZUi9SclJSRkhsLzRkS1dyMWNiNERiY3Fkb0tQVDAwUGdoc3lS?=
 =?utf-8?B?cUt2YytNaVdxaWFVemYwd0ZvR295cUhEUk5NZGIrOEVLK240MHUvdHJWTTdM?=
 =?utf-8?B?TFR0WHF3WFM5UE12ejQ4YmsrYTJwc1d5V0JYMUU4Z05vYUIzUnJmaWM1T1hr?=
 =?utf-8?B?MUx2SEtzNzY0RzBVZkEzMEg4NTRvcVR3RzAvdHZmcElGL29ZaTE3WkJRbUVj?=
 =?utf-8?B?YnlIRHdNUnJ6ajVtMzREOVZGWnBGRk1SeE9hTkVyd2dYS05TK1NmSCsydXVp?=
 =?utf-8?B?YjIxd3RpYUdFS2ZvbW9RMzdBZUZ5ckdhV2pZVGNqTEhDWU5Nais3NnQxNXdE?=
 =?utf-8?B?Q3U0QzF6S0pCOTd1bTd2dkFCb2V0TlNZSEtvOVZBcCtVNkh0cDdjZ1RWLzlj?=
 =?utf-8?B?UVhUcmdyaVova3dKSTJUR2p4d3JFSlBSSDlIZGM4K05VY3FyOVByQVUxQ3dB?=
 =?utf-8?B?RzVxbitZR3I2LzRMMTlnbVhrYTR4ck9hR2pQQjN6b2FKUHZ6R3hMKzRsQUVH?=
 =?utf-8?B?ZkdMNGtNekpDYUxpRzY2a0xXUWc0NmV3Y3pZYm9iK0FnSWJuZU9jcXd4YXFi?=
 =?utf-8?B?THZseUZzUVlEd3NRekZtdHYyTFhXdkZrcndWVFkxQUVEd1M3UkxuYTMxZ0JG?=
 =?utf-8?B?VTJxSGNiOUJia2drOFFGR1c2UjZFWEI2YmdXd1lHRXJzWExkclYzU08vbEV4?=
 =?utf-8?B?cDZzL3FMODd5QUNzNVg4KzAzZUxUNmg4dDFCb3dRUXdQc3YyUG8wbVZXOXV4?=
 =?utf-8?B?ajRDdVVLVzNHWnFpQXIyUk1FaG5xOU8rSldwRlJXSURwK2xhKytWYWNjK2JM?=
 =?utf-8?B?UzNNV3NNSnRQb0piTFMxYUJvRDhVYnZJdWVXZVovaTNGZ1ZQSDJFUktkRjV6?=
 =?utf-8?B?OUU4NlRmd0wxRmZhN0c5aVJlR2pCb2ptOEIrYmQrNXRjZE13Wi91NTVPR0lR?=
 =?utf-8?B?TFJOWHFycE1TdHRxYmhjQjQ4TStPWHVuNS9GNVdyRmRIc3dYSW1rZytodEJp?=
 =?utf-8?B?RC9NRGZSWlp0SmVwNndiNFkrZWZycG5udkFWcEhLb1VWS0Z6ejlxYjgzbW9E?=
 =?utf-8?B?b1NmZEtBRCsvZWU0Sm9rUzFCZWZ0M05oZ04xU1RsaU1mRllGM0JqQUpUU1VK?=
 =?utf-8?B?STYwQlBFRUgvRDhGdDZ4U29UdTUveEZsMXBSeWVvZHhrOUxiYUNhcVVzTHZx?=
 =?utf-8?Q?5+9UgQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 09:23:12.3201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 477b4ab6-432d-4f24-20e9-08ddf1ddfef0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014

On 9/12/2025 11:09 AM, Chen, Yu C wrote:
> sched_avg_remote_numa_distance is defined in topology.c with
> CONFIG_NUMA controlled, should we make arch_sched_node_distance()
> be controlled under CONFIG_NUMA too?

Good catch! Given node_distance() too is behind CONFIG_NUMA, I
think we can put this behind CONFIG_NUMA too (including those
declarations in include/linux/sched/topology.h)

-- 
Thanks and Regards,
Prateek



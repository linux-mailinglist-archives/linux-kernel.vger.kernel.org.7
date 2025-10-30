Return-Path: <linux-kernel+bounces-877568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ADAC1E741
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EE6834B0B4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD4B1AF4D5;
	Thu, 30 Oct 2025 05:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G6ptXBrP"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9999137A3BB
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761803212; cv=fail; b=cao+Y6/cNcJtP//yz0hRkrVPM/gkMqOgW0KLgSvwRMMIi0RwFUK/GnjeiUtlqrzTJlAITg/oo0FT9FNErnqOS5k6WlutfjRNeXpO4z4x4zQDCW7lWe4o9lSjSdGjpWxfaOWhinaVaYsRwC0XYcyHw3PCFMOs5uK6ZmjA6qCYUa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761803212; c=relaxed/simple;
	bh=lDjGahze17VN2exX7vEmOaL3LB55A7cyeLWlZvV56Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O2iKGRbRHN47kRzIr99POcpS3r/nqkn78RaFII9wGbe1mtZiI4wqzSVhTjuMJVS+Gdg7gisRN3KkQEmFnIWbNa9y5YPWKv92MUK8BVwVAIQ6EiDpJ4xDVzNsTWi7LLUy1S7KNywgv7oqFOE1xpp+lHTE+y8z81v3+sW5jBZvwZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G6ptXBrP; arc=fail smtp.client-ip=52.101.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9oS+OVet1jvMZecycm3YxTxI+Fka6CSXkz6d/2ZVGvb4w9sKNhfcKFIh7w02uzAmrw9vF1FhJSP8EQKBVl1Ukrm16Dw8FJ13cGDKZfcgzKl4m6dBZAg0OYGtGtu0VCpCD95Qm8CgR+KGRgzxa8yPot94bwZDPiu7l9klxTZY8vUrJINA3j1zMK8cny5LuRphd6aJ4zXIg1rBmhomUVHPoZtsTNWvq8ncaFzpseeJ6473kqm/HBtfCr32+mbwdpoqPA4Mf8OWcln2DpZ69okdny5Kd0x4fpk26Qs8LYLXuM9d4YU+nmDjSB8CAzDk03zzwewtJ/1vprEwYwRDaOV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKV7Tnwvf2RRRzK5pZ6QKMsoyzu20jaVxWhWZ5OaSDg=;
 b=Q3MyX818SuiJIO7t2K09CRwl3R4U9MDRg0QCKzzGcA/feBlGj4ykKykM9uQSW7r9Oxaa/MGsGgRbAMjGIZ/eemiVSu7lovcoHD6ICnc2o2CSSN8f/bq1vPiPw4B2KIIYL+n0FdQ1VJuOATfc7SNyPd8Zal5hCCTQYBlTD2K898EX2W2j+VctbbjnufB15EaWyaAzXGBsrWanPrIK7yHNxwrxqw7a0+PyN2jpwcBOQqzRbMYCT8hsPoNqHN68E5R15L+Qk62bQeTpI4ol6w5/XjOySXq4kQulHWqa+kKHKCDVsN0AqRSw50sPGnSbEmsRx+gqXKJvQRo3UlbT2pLxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKV7Tnwvf2RRRzK5pZ6QKMsoyzu20jaVxWhWZ5OaSDg=;
 b=G6ptXBrPelyFuA+Bv1HuEnEH9CFhgWsFqOYzbAY/HxnM3+gwoF7w4YJrFsMcgEtHEMWcycunBx8mHdd9EXRvbWli8aFxTSjxDv5fNIEIwEm95H0ZqPwQTo/UhMF5g/89KM7ah77LnywEkZ1Wwo4dn3LaFMKNw+A/KjBMUCQw9l8=
Received: from SJ0PR05CA0157.namprd05.prod.outlook.com (2603:10b6:a03:339::12)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 05:46:43 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:339:cafe::14) by SJ0PR05CA0157.outlook.office365.com
 (2603:10b6:a03:339::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Thu,
 30 Oct 2025 05:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Thu, 30 Oct 2025 05:46:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 22:46:42 -0700
Received: from [10.136.32.170] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 29 Oct 2025 22:46:37 -0700
Message-ID: <0d1f5a59-82b5-494f-b3d3-6332027d0350@amd.com>
Date: Thu, 30 Oct 2025 11:16:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/fair: Prevent cfs_rq from being unthrottled with
 zero runtime_remaining
To: Aaron Lu <ziqianlu@bytedance.com>, Ben Segall <bsegall@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Hao Jia <jiahao.kernel@gmail.com>, Valentin
 Schneider <vschneid@redhat.com>, Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Xi Wang <xii@google.com>
CC: <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi Zhou
	<zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>, Florian
 Bezdeka <florian.bezdeka@siemens.com>, Songtang Liu
	<liusongtang@bytedance.com>, Chen Yu <yu.c.chen@intel.com>, Matteo Martelli
	<matteo.martelli@codethink.co.uk>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
	<mkoutny@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20251030032755.560-1-ziqianlu@bytedance.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20251030032755.560-1-ziqianlu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: b032070a-81ce-4c48-8805-08de1777b488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGl4YzRSN1JJWmtJMTVCWTlRNnpNaVpIOS9SZnk5VXF5TE4zbTc2RHlyU3FG?=
 =?utf-8?B?ZTQ0TXpZd1JNU0VoaU53dFVVVGhDYUxvS09vSHQ3R2RSbGhGNThDWnZ0emVH?=
 =?utf-8?B?ZnNpUFF4OXA3am9ENW9uck1LZE9FN1ZMU2FYVlAzSnNJSWFpZ082UDEvR1o2?=
 =?utf-8?B?bDVNWGhVTllsN2MxR0loSFBwM2dld21MNllJTWNJQXVoT2pnZU5SWXd2NUkx?=
 =?utf-8?B?cWFKWDJHVjZVNzBHL0NqL3pQRDBrWDZDZ1RSbFo3NXRQYTdwanJoWjB0Rk5p?=
 =?utf-8?B?WXdjaWJBTjQ0dkwzL3NialFidmxGKzlTdXpMSTJ5L2Jyc1BQd3JCekErODVO?=
 =?utf-8?B?cXFCYXlVcUNoZXprQU9kaWk1QVBYc0JFYTQ0TUdSTkdKd2xRdllTZlhaSnJv?=
 =?utf-8?B?aktxSmJ2eVBWcVdGT0VTQTcxOXdOemlZWEY4ZmxwRk5PaXdvQWNhbHRmOWtB?=
 =?utf-8?B?cU5USmVldmI0bDh6bFZPS3pvMFJpYkhzdUtqTG1qcTlEM0RNamd1SjhTdTZt?=
 =?utf-8?B?RFVZL2JObndsTGJIaWhNS2o2MDFkMVJYaTNTQ0Z3MzFyRkgxMjBGVXFlOWNy?=
 =?utf-8?B?Q1NLQU9Lc0F1b3lGc1E5NjVOUnNkOFEzU0owTXdiUk1TS2FhQ3dIY2pEVEJp?=
 =?utf-8?B?MXVHWURBQTRRdWVudXhCdXBBcDJuYVo2em1MTS9kUk4rNEJkM1JKb2pqUjF4?=
 =?utf-8?B?NnFhSXREWExCOEdRcG16c3pkcWVOWnNrSm52TVAyQXVhbXlNdE5JMi82T2lk?=
 =?utf-8?B?dytQb25kQm5IR2RYNVFpNzBJRVF4SklpWFg5UHRzdWR6TzBxaytmNDNnS2h1?=
 =?utf-8?B?UnhvQ2duV1NvU2RtQlhiWWE3WjFnYXFFQlhTSEowM2NaUGxVL0RmUElqN0Rq?=
 =?utf-8?B?a1N4eHVhUUg1cWxZUkVSYVhHN1dHbG1yRWcyR1g3S1Y3czdKVWJuZlBSdVRS?=
 =?utf-8?B?ZWdCS3BsK00veCsxalhBeWlzRUxzRUdsVEpENmx4KzZnWWxrQngrSjIvUGZS?=
 =?utf-8?B?akF1RGY1cVVzZGdRVzhYOTBLalZPcFlQRHdwZGwyc25POUNYNm1yMndQd0VZ?=
 =?utf-8?B?RVEwRFJXWm0rYjRHckFYclNKMjVtUDlHOGpPaVNkTUxYeE9KcWlCQjQ2VE1P?=
 =?utf-8?B?eE5kV1RCQUVxK0VncUJLQ3pEOTZEZ0ZBVldpQnl3YXRnZ2praEc1UHgvQi9G?=
 =?utf-8?B?elhpbDVhQXNGU1JDN2VzYjl5cjdhN0E5Wm1MY1Z1THdOaG1OSndUNEhZbjFQ?=
 =?utf-8?B?K3JtWHpuallsRWdzb0JoZVllRm9ZSlVqdHNPdzIrMytQcVY3aGhQakFOTmlP?=
 =?utf-8?B?cEFLWC9uUThKeFdCdUFFUzc5ejY2aS90TU9BTFk2WkxuS0JVZEdiNDErQ2ts?=
 =?utf-8?B?TUxrR2czNkFPRlZxUHBZSVBBK01yb1pLYzZkTDQ0YTZDZkVQai9QNU1IWEFD?=
 =?utf-8?B?S21aTnhPUkp3T2R3QkFvaWJpSmxRbjlmSUwxT1BvM0dIVXNaZUlSVFIzZUZO?=
 =?utf-8?B?WUhjUWdXdVhvNkg3VDdONmx1eWk3SjNZZnJrYUtFYmxYMkl2eDJUOGdpVklM?=
 =?utf-8?B?Y0kxWmhnTmErSllhenpQMXBkeFRJYmZybUNLTFZsc21HOXRPdk12aDBlRWRX?=
 =?utf-8?B?bmtrSVFNdnRNNnZvSjYyNTY3UGdiMUpCR0lOcW52V1FoY2VmZUQ2V2JxazVJ?=
 =?utf-8?B?eDQyRTdDOFU3dHkwQlNVWTBVQW4wRmdwUFRrU0pNbndLZUhNalZ2S0ZPV0gx?=
 =?utf-8?B?Vk9yN3BxUHBDT1JBdWNjenphWDZzemFLRWttQlNaZHl3cWVvYkV4WjNxZWNG?=
 =?utf-8?B?SHhwYWhaWWlDdk9PZGFqWGk1VUdMT0dCVXlDMkFJV1VLOFlaSVNuYWZxT2R4?=
 =?utf-8?B?TndZendjYy9ScFRyUXUrU28zK2RacmlJNGMwcVNCZk9LbC9jVGJ0WnIzSm9Y?=
 =?utf-8?B?TmlHMmJyYWszQWZ4SVIxMnIvdUVualRQbGF3U1BvM3N3S3cyTzZNRzBVbll1?=
 =?utf-8?B?Q2REdmNRUmF6aVJDNGlKSGlkbjVTNzVqbEQ2dlVBMzNxREhTWGJnNFA0bXp6?=
 =?utf-8?B?MkJqbnRocnprc3AyN1I0SWE4MUREa2xNY3d0VUpCRno0anYrblFUS3JiU3hX?=
 =?utf-8?Q?i1/DtP+V2HpLNo2NPr4+qQ9jS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 05:46:42.9246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b032070a-81ce-4c48-8805-08de1777b488
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142

Hello Aaron,

On 10/30/2025 8:57 AM, Aaron Lu wrote:
> I think it's a chaos to trigger throttle on unthrottle path, the status
> of a being unthrottled cfs_rq can be in a mixed state in the end, so fix
> this by granting 1ns to cfs_rq in tg_set_cfs_bandwidth(). This ensures
> cfs_rq_c has a positive runtime_remaining when initialized as unthrottled
> and cannot enter tg_unthrottle_up() with zero runtime_remaining.
> 
> Also, update outdated comments in tg_throttle_down() since
> unthrottle_cfs_rq() is no longer called with zero runtime_remaining.
> While at it, remove a redundant assignment to se in tg_throttle_down().
> 
> Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
> Suggested-by: Benjamin Segall <bsegall@google.com>
> Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>

Have been stress testing this on my system and I haven't seen
any splats yet. Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek



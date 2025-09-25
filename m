Return-Path: <linux-kernel+bounces-831604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 248BCB9D1A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73F917190F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D950F2E1C61;
	Thu, 25 Sep 2025 02:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ge76Vpxl"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A32D8377
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758766313; cv=fail; b=qa7kkzBcjPVnvJDwa41o2JKEr2vbWgdNr3vL+kPYVZ3kVY3O5AorXum0MRpQI4AeocZlji0xdkeJUGaQfoVCC/zggJDSOCX9hJwibg/IMFKYU9sW7OYOI3nPoQfrDmPFNjvnpcSPnGMi2xhuL9tk1ue5bXrWHP7c60Sy4zbWKW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758766313; c=relaxed/simple;
	bh=Kl+NpdwLBoGbtY3VdmtKuwQqPhklZJfw7kZrXcANXC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=evIvOkzTvuu81f9jJtm5UOlSTJXM+GpcwSgEz3GCyrL7zIgnwRPQgiUVk2byX6uswFrd7s7+9SGwdKQxQh6hToQT0N1YMkhIqGvb1wqtciUDUspkX+TKU+5Y62xurbVWCwxJss0Da8QFjIb3itXovyYdVUgJKEX+KEVQFUt6tgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ge76Vpxl; arc=fail smtp.client-ip=52.101.43.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPZq971nOxoMRXpF57+pK4WYGP4DEj6pVUGY61wnHjbfjjpThH0uLRWQCX1odQ/TSmcaqf9wzFMaLq/Pjd/inKbVLkoNcsJc6IHotA2KfsaeLM3EKmnGbgYTAG/f4qsAJqdcsgSmLbrfkROmYUrcAikUmlADJdbzAsiyCU8S8f2LFA8+H4qNmVHdqmvnyKKXfPyFNxuZBpJgue6lswaqSGF6iSmZF4+/+I9vBGVgyiC3zOs/70j0OZMXMzzqQ5HFdDwqRmKe3BM/r3N2Tf9YmSVp4HaIhriNTJAH+sjtQTTSyhwvVHrY8SlAVN3glJA7y7g5NPSs4G4b5I33QRQExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=db71ejyRxrCGz4HwY6/ez+nYGYQjIWNr97Dbwvftq/k=;
 b=SHWWxF0nNqKtnKmCptYWFO1IeaOCyOOinvUjbVRcYMWBXHir7eRovHna8qsZhwOsoT2g1XXVMk8raK+8E6u9wyWFaZDBQ4+5akHpGWHQxVdUmZAWa5tyCEVEK7NSvIWp4TCNaRBcC5KAXvtSHNtxKJ2a9dztY2biIlfS5no3/vzTuh4zgpBa+WKfRZtOxaF3WV7P7+0GrTlr+jNHUjLYVIYRSsWQ2g+SVoOyD1KXJb3f6svnbFBzIp5sj32LEqn9dX8qG8OCp8+RShT24fhYUJ2Tq5XQnI5jznyQ5xqRpWshuT052nZFDN5gxvVde3l7Q7tZjbC498j8IbOZ6kqIpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db71ejyRxrCGz4HwY6/ez+nYGYQjIWNr97Dbwvftq/k=;
 b=Ge76VpxlTUgQKCjjOmRUlL2GAD16TSWXvXMI7VEKhAGb6UocNBrF2NI+YiqJHpDTrpnTjYBaVyEDogv7P4H27ynfm5VO21kk0CzhZys6skEySppHn6g/LhTOb3N2A7XitmilMp85kiaO3aacLvPHr20p9X/uaRi+lJfCPY0KQxU=
Received: from BN8PR12CA0018.namprd12.prod.outlook.com (2603:10b6:408:60::31)
 by DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9; Thu, 25 Sep 2025 02:11:47 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:408:60:cafe::49) by BN8PR12CA0018.outlook.office365.com
 (2603:10b6:408:60::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Thu,
 25 Sep 2025 02:11:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 02:11:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 19:11:46 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 19:11:46 -0700
Received: from [10.136.45.215] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Sep 2025 19:11:42 -0700
Message-ID: <03b4f58b-6b8d-4138-8a18-c41ec179e3b0@amd.com>
Date: Thu, 25 Sep 2025 07:41:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/19] sched/fair: Simplify set_cpu_sd_state_*() with
 guards
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, Anna-Maria Behnsen
	<anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
References: <20250904041516.3046-1-kprateek.nayak@amd.com>
 <20250904041516.3046-2-kprateek.nayak@amd.com>
 <98aa5e37-258e-4efe-8e09-b8cfc5f78f0d@linux.ibm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <98aa5e37-258e-4efe-8e09-b8cfc5f78f0d@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|DS7PR12MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 425bfeca-1329-42bc-c08a-08ddfbd8e14e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2tvL2JZWDByNFhzWk9YWWNSUVBSeHhIMEtQb0pBTHRLNTFJdW5YeWtocE9N?=
 =?utf-8?B?M2lBZk1uRTJnRWJKUkhNckxxMGJCNzM1b05qazAzK1Z0T0dPRWc5WXcvQit1?=
 =?utf-8?B?djhCdEFUUHdtSGFPeWwvNEV3ODNtUEpjK0c1YnNBVjdFMHhsS0w4T3FvNVRI?=
 =?utf-8?B?MGZQbFU1cWo3dmsyVWxBMzlCeFU3WkJiSHlEV1libTdLL1pEbDg5S0c1bUNZ?=
 =?utf-8?B?YWRNc05Gb2dGQkJVdldUWXNBdm85RjhZM3pNcjE4SHBxTTQzeDJnK2t3QUZn?=
 =?utf-8?B?bTZpVDNxaHBTVjFUMmI3LzhNVUl4ckZVRlh5R09UV2MrSllla3pYcUZzV1Vj?=
 =?utf-8?B?dUZPRVRHazZXM2dkZWFSaWpsb05Ha0ZQUFpIR2NpU2NKN0NVTERIS3g2aE5y?=
 =?utf-8?B?ZFJialoxL2pSeEptRzc1NXRyZFNqUklBL1Bid014WlBlaWNtUFBsUWRDU0FS?=
 =?utf-8?B?ZGVGYS8zTGZQWkJYMnpNWnVDOFpDUkQ4SnFEbTBTVExhOFlzc1NOdmo1KzRL?=
 =?utf-8?B?cGsrd2E3MlpIeklUR0FhQzdhMnQyNWt6RXVYUElWTEdmMHdhWDgvVmpKbG9a?=
 =?utf-8?B?Z3hWWUYzdjlwWHdKeGo5bE9oYktQNlh6ODEvK1FzaTI0ZmVuZGFhMnAvVFBs?=
 =?utf-8?B?eWJkZENBQnVHMXJOYTlpZ1VHTE1lUXZaRDl1SnEwT2tZbFZGeWhWbzNGV0F2?=
 =?utf-8?B?S0VhWVpLZkR3YzYxWnB2RFg5bm5INWMrV2RIMmtVQ2k3cTFlRHlramhzT3Vk?=
 =?utf-8?B?dE1XOTgwU2hqdGwveHU5Sm1PSnhFOGV3dkpxZ2QyV2dLdk5PNFBRVExwY1FR?=
 =?utf-8?B?T1F2czBSb2dZSGd5NFBjRDU2VDcyQ2xaLzRFSGJpNkl4QjViMDJ4dGVrTXBs?=
 =?utf-8?B?cVhYVldGdDZ0MEM0b2R5YVUxcmF1T042ditoVm9wS243T0pHV1JqdU1uR0ND?=
 =?utf-8?B?QjlUZWRDN09ReHMxcVFoRmlaOTFUcEtpTWZqc21SNnV4aVJrT1FGNzRBOUph?=
 =?utf-8?B?MFhhbnBUR1pGZmxKdzZHMTdDbEFjNW5PLzJBVldEcUVHTWExTzluT0VoZVFw?=
 =?utf-8?B?SkRlTThOS3BwVmo5SzYvc2daeXo5YWpORW80MjJHeFBBbDlqNVhFVUZHaWZ4?=
 =?utf-8?B?L2h5bDZXV0pMdkpDbTVhYnRDVlJ6UEcrZHphOWFqc2VhSEpDb3ZCamIySDRp?=
 =?utf-8?B?cDk4RGVXZFd4VjAwNCtaNU52bzZjcFRVMmkwN0h5NGZHUTNad2tEQ290WlhK?=
 =?utf-8?B?akJud2pEOEVpcnozRk15WCtST2NBdXQyUytsdDR1SEFkelVQNGkyNzNWR3B0?=
 =?utf-8?B?eGhUZGRKSzA1UUlIbjl2UkFGdHErUUw5Y0hVR0dpVExPRUVjeGZUNXFXNk5v?=
 =?utf-8?B?dC9uejZqSTlVdGtVdjVYclE0U1dGYzhzVUR4VlM4ZHpkeVI2TGliZzhMUWgw?=
 =?utf-8?B?ZHFqQnpzWmVTK3BVR2dwWXBTRmxCaTg5RlN0alJrcGZQa1FNODdEazZpa0xt?=
 =?utf-8?B?Z3QrejBUYWFFWGhwQW9ROFozRUpCWFVBbnhHV3JwZkg2aXBRS0ovRmZVNnhO?=
 =?utf-8?B?bFgzc1QvdlpXVUM0bFRJd0FyZWRVRDdaYXlreVdyQU1DQ0NxbllPSlJoVzU0?=
 =?utf-8?B?d0xyMUlLM3NhZjdFYVZmQmdVc3lxRTY5U0pBR0ovWkpWQVF1eFZTTVpyS21i?=
 =?utf-8?B?bEFFb01BV3NRSXNLdzJQWjFEN05hcFFwTFFZYkMvbk9yN3dRczhvUmRaZHJ5?=
 =?utf-8?B?NmFVOElDY1RLRVc4WDhuc2dPTnBlMkZlRDNFL0R4ZW5xWkgzRUxTWU1oM0ov?=
 =?utf-8?B?UnlRdXZ1T3ZKTnRLOHBTT3E0aURUYm0vUmkyTzRLYmEyQTFFYUlUN1ZJaDhq?=
 =?utf-8?B?N1JnUGVzUTdvRVB4WlltbERPL2wvWkxabng0L1hHaE1QVzIxY0kwZmt0aDRl?=
 =?utf-8?B?OXhhUmNJbEdUZHRoSHNQTURQUm9GWDlZZmt3RFQ5RzRRNDhwNzZWR2Y0RW9y?=
 =?utf-8?B?MmVhR1JmVXVPQzBhQURxeWhvZWtMT1RUdGowNG5QZDVJMmY5TTcyZk5Va1Jl?=
 =?utf-8?Q?6xUaww?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 02:11:46.7592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 425bfeca-1329-42bc-c08a-08ddfbd8e14e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8252

Hello Shrikanth,

Thank you for the review.

On 9/25/2025 1:56 AM, Shrikanth Hegde wrote:
> we have both sd_llc->shared and sd_llc_shared usage spread
> across the code, is it possible to remove sd_llc_shared and use sd_llc->shared
> instead?
> 
> Likely sd_llc is cache hot and access to shared should be fast too.
> In turn this could free up some per cpu area.

Ack! That can be done. Probably the motivation was to avoid an
additional dereference in the scheduler hot-path but apart from
{set,test}_idle_cores(), most other usage is either in the slow-path, or
we readily have access to "sd_llc" already so dereferencing
"sd_llc->shared" shouldn't be any more expensive.

/me goes and looks at usage of {set,test}_idle_cores()

So set_idle_cores(), I would consider, is still in the slow path since
the CPU is going idle and out of all calls to test_idle_cores(), only
numa_idle_core() doesn't access "sd_llc" prior to test_idle_core() but
given it is in a for_each_cpu() loop, I think we can make some
optimizations there to reduce the amount of dereferencing.

> 
> Any thoughts?

I think it makes sense. I can send out a separate series with Patch 1,2
and this cleanup on its own discussion the optimization for the
"nohz.idle_cpus_mask" in a separate series.

-- 
Thanks and Regards,
Prateek



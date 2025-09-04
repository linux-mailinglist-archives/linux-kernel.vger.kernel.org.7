Return-Path: <linux-kernel+bounces-799966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70709B431B8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32CC7565A76
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D5B244685;
	Thu,  4 Sep 2025 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GCSjVrP+"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D439224B03
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 05:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756964684; cv=fail; b=GJ3KH80d9unQOwWysIZJ47W7/lAfZFIsDtcDsWPMd8YQ46D5mnkGg9kXdJ4cdL/i/W0sWSvhJWcBLKUyTK+C2Xl564/LMSIQYsaRyLLd9UTPlzuL52CL/DGFLMJwlMkKEHwvqZFUDbqApsuvWn/VV2rIAZGxe1nXfAGR5h3U9lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756964684; c=relaxed/simple;
	bh=HHWeFtqWQivR8FcPJPFYLkJ0MpoHVwkYccfw7YH8BXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oVqd/ORq0vEzzCBq3n6Db/cg/50TYwScNo/P+SzWqVPbKnqwON2HAuU6bsxxIlXwvHGJ1QRQTZ8R0Y92ggZwcDKvyckH5Nj44vAuqOzDFBqQZ2yVOtN2nWCH17stV95PAMDH2ekRgfLB3Vj2x6HQr87+hIwAGfLLcmG3eTzbLL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GCSjVrP+; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4+ABSX/hlS/Yrs/3XYGzmT6DZpbyFYSQJBAMPUDJRDMR+pOHtJRxuQBhepRKuadkghyz0jQggnglCVZJSi2CLROyb8iCidEMRObxnCva0Iq21qMW10R/Uo6+yRY3juug7TGcHW1FtNGZos/HHZDLbIKmpvVTeyoCX/0K9AJDoZYKJSpMDf+EN+3lmSJYDTBnAI4nd5x3TLzvLe1AAz7p7i1/cXzFm1g0JeAFfuu/4RxdHeqKTex/sjyp3MKCrHra7Gml5fKkYDo0+IETEu/W+WzFT+Amxx9Xzu5CGD5dji9iEOlJ7BRrUyO6msbAzplkxiT/kIRU3WN9RRKAb80Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjJLFiGBq/hL57etn8KwB3aYVuiHEkGsvkFP4TAUh7g=;
 b=kvWtwtkhUKSvK/59A/uwvWPY8ORoM9gMMvLqvZ2LEDeZuRupeYS6Hmp2WWv2Ojj7to4+90iq6JqHxcPZ31NIztd7GSLK6djtya+/FTcCb/uNRanBOJ021JEchbxs5tK3rf8G3Vjb6peJlT5kzdzlHWdeDo55tR8zRlIDcXPj1gzQJa2uXXMNg0Wre3Y6ZYX6krvml5OUpd5V8gaAoIA3KQhNfVPXaVtOCcj72rEOGGcfD3gn7mxMpT0+QcQxoPfu/joCR+EcqeToWFh+NDqM9aFM/AVpMxiaIfvDiXA6avvWb5uwvSfcX0vrBnjPnwMYoxcD7LTrYgu1RLkKumY6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjJLFiGBq/hL57etn8KwB3aYVuiHEkGsvkFP4TAUh7g=;
 b=GCSjVrP+ueZQ2Vr3668BQrkuvTTLmPlSLXYulKwDpPkKqR44y3Rgo0oKOND+VTQvufOJ3mwEIbEzpwSCVb/Q8RviQJk3oPfZhR4mm3XDETJ1xJNAtyA8spp7H7LTuD4xYrRbsez1DRvg6q0CMrskJxyGJo78UqPuiaouk++13Gg=
Received: from BN9PR03CA0238.namprd03.prod.outlook.com (2603:10b6:408:f8::33)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 05:44:40 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::3d) by BN9PR03CA0238.outlook.office365.com
 (2603:10b6:408:f8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Thu,
 4 Sep 2025 05:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 05:44:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 00:44:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 00:44:38 -0500
Received: from [10.85.34.65] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 4 Sep 2025 00:44:32 -0500
Message-ID: <ddd2f979-43d5-43e8-a95c-37a1654189e5@amd.com>
Date: Thu, 4 Sep 2025 11:14:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
To: Peter Zijlstra <peterz@infradead.org>
CC: Aaron Lu <ziqianlu@bytedance.com>, Valentin Schneider
	<vschneid@redhat.com>, Ben Segall <bsegall@google.com>, Chengming Zhou
	<chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>, Ingo Molnar
	<mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Xi Wang
	<xii@google.com>, <linux-kernel@vger.kernel.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi Zhou
	<zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>, "Florian
 Bezdeka" <florian.bezdeka@siemens.com>, Songtang Liu
	<liusongtang@bytedance.com>, Chen Yu <yu.c.chen@intel.com>, Matteo Martelli
	<matteo.martelli@codethink.co.uk>, Michal Koutn?? <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
 <20250829081120.806-4-ziqianlu@bytedance.com>
 <20250903145124.GM4067720@noisy.programming.kicks-ass.net>
 <14be66aa-e088-4267-ac10-d04d600b1294@amd.com>
 <20250903202703.GP4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250903202703.GP4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e814e6-e6c6-4527-d63d-08ddeb7623b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R29yQjhHdFJzblhxNG9ZdEJ6SlplYVFLdHA5aVhYck1XTXJXeWgrSHpxQ1kw?=
 =?utf-8?B?WWFCRjVPSk5FM2ZxUEczSHV5RUhqZllHQUozWDJkSC9FRzNXeHdLNTVzLzVx?=
 =?utf-8?B?UXExK0hBRzhrenpJRlM5UFVrMXlMWmRab0FTWm16aGJCdmRsZ3BwdElRZS9X?=
 =?utf-8?B?SlZIOCs3YWFYR0JPQnhzUmM2ZlVSYU5Lc3hUUVRpcHBmOFZmZGxLNXNPZytN?=
 =?utf-8?B?WWVPNEk2eU9iR1ZwblZOaHREME9lZjYwdXphUVUyL21sanZnOUFnVXhYSEJs?=
 =?utf-8?B?Ukg3OHJtY2xnNkQ3R3ZBaUFSVXBYRHg1ZkY5MUJadFhncTl3Nk1kck9zL0NJ?=
 =?utf-8?B?cDc5T2tSRkpyaXZENWlORGxTWjJDOTB3VHp1OXM1SEhFZ1hNSURUVjdKWW43?=
 =?utf-8?B?UVplV1hYcnVQbENpVVhaenVyZWpud0NXSFN6cmZpRFdSNXExZHM3a254NWk3?=
 =?utf-8?B?Sk9UbG9ZNGZNRmdINzZnS0UrU0l6aGFaZTJrNjN0K2l5cDVkcGpsK05WZWht?=
 =?utf-8?B?V3RVV3l4TUJuOEZBUzNTUW4za1l1M3pqRjNuTGJNWDN5QjVSTlY3OU1YTWFK?=
 =?utf-8?B?ZUpqK1VlMEdjbEF2MFJJYk02NGdNc1dMTS9qWFM0OWc2dTdjZkR5T1BMbytC?=
 =?utf-8?B?Rmh4bFFtZGppQW85eTEvVVdiQ0tRU05WVUNJTzFoOVAvUkdaQjNWTVZUUlI5?=
 =?utf-8?B?bjM1elJQbWEvdmNuVVF1U0xpbHYvN2k1ajRMQkdNVzJSK2ZyempMY0dMU1Ix?=
 =?utf-8?B?OHNyOFlSWlhkVnFVZ3lza3UxM05GMk5pZmVHN0FMVmQ0TmRJTStTSVFWdzBN?=
 =?utf-8?B?Q3pPN1czcTgvOWJMcmdqbzNxUDNhV1k1RFVKY2x1Z2JSL1d1UUlkZXZOVEo3?=
 =?utf-8?B?VFVCYWNYekJjcmdCcFRIdHZ2RWtqZzZkNVllT1pCN2J0cUFrMzhBUitIeHd6?=
 =?utf-8?B?dEhIRHoybE1VSGliYVdTUmhMRTVmWGlPMFRrYWh3ZVQzOS9zNFgwMHhaMG9K?=
 =?utf-8?B?UjRVSXhKNlNOUjcvQVpzWXJqOTJBOHRhbkswRFc0NFQ4aG5NcGtVWmphZlZv?=
 =?utf-8?B?S2dpRzIyeUU0RktWdDRuZzFoVkR1aFFUZEFPTWJFQjVzNzNOZFJaa2FZTm5I?=
 =?utf-8?B?TW1jaElUaVdWRHZ4b0ZmNEpGSUF3eFdDWEdMdDhhaWVZaXpVN3RRRTV6dGVU?=
 =?utf-8?B?dFg5aVliT3lxMnF6Vm1ydi94eVVLSk5kK3NyS1RSY0tmSTM0azFneC9JMk9O?=
 =?utf-8?B?bUlyNldpSSsxMEJRYktXVWdTRlVXMHVSZUhiVzVLZ1JVd2doc2ZPNGNld20y?=
 =?utf-8?B?WWdHT0pDVDZFalFEZEd6aVpxZkptYkg3VmJnNjh2enQrYlN4YXZVckVzQm1V?=
 =?utf-8?B?Z2lUSkZEbGFRRkdvRnFQVnBHNFJVcENmK1l2d25rSU5GSTdRMWkvb0tZMS9I?=
 =?utf-8?B?NXN0cW5CSythdWwwYS9hZkl2MnVHeEZGa0xDZ0dQWnBNcmJkT3B0elpuUmFW?=
 =?utf-8?B?cDR0VzFSbzkwa3ZGMkdCZklaV2VpZ1NkUEhGRzFWbUlkdUxnTjV1WlFkNEtt?=
 =?utf-8?B?M0oyK3FKL0Q5b2Q3eFozZlFkVDd6RTBxQktoTjBuTElZb0k0a0VFOENpWDRW?=
 =?utf-8?B?QytIVGhHNVljS00wcWVlY2lXeFlmTWhadWhpc2dGRFhpTGpKUXgvRG5zdVBq?=
 =?utf-8?B?Mk5rKzFrcWxTNk5VWmRGblNlMExZSEhJZGRWTCtoZ2lubzBlQUorcm5QUitw?=
 =?utf-8?B?amtnTnZXdk1hcHNwc0xqc1ZQZEh3RWc2bUE2YTRPSTZCSnJHbWQzSHIvRldM?=
 =?utf-8?B?ajN3WXdyZXo0VnU3Ym0zaWRHMWhKWE1nbU00eW5pUGkrVno0UzZmZXN2bVpo?=
 =?utf-8?B?WjZxbjEzZ0lrN09tSkpSUHZFWjNHZmxvUStUK3dBUElOblhrM2xKZytSQkZm?=
 =?utf-8?B?Q05JMEthU3hQQkk4a3dONDcvM3luRUZ3emVRbHo2U0pDSTVNcWd1S3ZZS1N0?=
 =?utf-8?B?bjd5ekpOWmR4UU9qcjl2Z3FxRHhTTEF6TWovUWZRVGJSKzBkLzIrSitOZjZR?=
 =?utf-8?Q?DC6sei?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 05:44:39.3930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e814e6-e6c6-4527-d63d-08ddeb7623b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561

On 9/4/2025 1:57 AM, Peter Zijlstra wrote:
> So this is mostly tasks leaving/joining the class/cgroup. And its
> purpose seems to be to remove/add the blocked load component.
> 
> Previously throttle/unthrottle would {de,en}queue the whole subtree from
> PELT, see how {en,de}queue would also stop at throttle.
> 
> But now none of that is done; PELT is fully managed by the tasks
> {de,en}queueing.
> 
> So I'm thinking that when a task joins fair (deboost from RT or
> whatever), we add the blocking load and fully propagate it. If the task
> is subject to throttling, that will then happen 'naturally' and it will
> dequeue itself again.

That seems like the correct thing to do yes. Those throttled_cfs_rq()
checks in propagate_entity_cfs_rq() can be removed then.

-- 
Thanks and Regards,
Prateek



Return-Path: <linux-kernel+bounces-831641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A679BB9D369
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6196F3BF2A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A4F23E325;
	Thu, 25 Sep 2025 02:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jGfAPDf4"
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011032.outbound.protection.outlook.com [52.101.57.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B72123A99E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767871; cv=fail; b=PuO+WlwShXGBYo1qhe0M0Nch4vc0mEvaAV2gxLNlQ2x98pPQkA+IJNBEdiHaa4UPWGKpxq5W4xWno2JZfildfr3HktNTz3M5uv3bECXTtDnIkxTIYK8qZunWaDXC2GjvEyAXKWP8eBNw5NU4MPaFDnsp+7Hw//Q/Y/Z4/poNRG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767871; c=relaxed/simple;
	bh=Uw7kr2gIgkw8Wn0UUPPX7UZgpCmCqBkw8CxSS9G9aqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=syZ/kfzOV7LQWWuUWxJGci1bhS32xNtfCY5buk/2+n2QifSQPW/5oiiW87DVcu80pmQoDF6xPX9BK/BvqJQZ85EcGdxr3lLuBsdoCOI9gu2vct1jmrMxMoUgoQOuUc/lflpfHY+4lmSaQOeT+qqvdOi/8hVacAzEWA4WYqQZSyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jGfAPDf4; arc=fail smtp.client-ip=52.101.57.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iY3kbTnM94Ju4RuK0IkxdC1OY72qpcH37cJWgNIxeJAwMN/zTN3sGTsFNUeKkhGCVIQ+Oh9DhZML3XO3clEhCAFFcYcJp91dDZN2wzgd5+9FwZ7+nYg7tF+OVgt15hukm+zrD8MfI6t4+rVhiz4DnlvUPHkg9Z2eZjPgibRzhlv3gaq5fzItPT/JiytolxyYn5M64XpF8cogOHiitMgv4w/+QckdR0ovdSruOASlT9U7SjAZdSNRSTFALO2bYFvY6XzrLD3VOZ52fnmbil74X8fb4UWZyn16utPhRPfyVqNOa6TsGQZvFtyf6xc8KdsMr3N285HyUJTg+Nqoyw9ipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJLncoJCY79op51Z9ny9va6Zl9m4mg8wzxIilqD8GOg=;
 b=ZV81dg4hBQutFPPXF8Cfgk7XRB5vDVUZp/dwJMtWY7NmqUc3CsLEjTJd33XNWBQI8epWc1WxAKFzY05LOoYAugICg5VTn3CWaIu3BQcopeibTvjuCQQj7ZMQlZaFVLvxLV9aOXKyL0/X8ZaihMaYziks9/fcDfp/SMCbEku2Yo4wWnIFEeYrHZxbjW3bSaCnzCSVV2F4XSDRzBJv8jre3C2Wi9nH4JmTZDsQpojaQSC2Pve730iu1JEYYnTmp3ytFU0z6ujRJdC/GwoqnJLyNVuzi5+v9WQarr0787XEIjXADh3cY5WLquOI4u2DIDWgwnryQQofBzYqtL/is+Ma5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJLncoJCY79op51Z9ny9va6Zl9m4mg8wzxIilqD8GOg=;
 b=jGfAPDf4BI9+KwM3S/Jy/iRTXb5nSGGI6GJdTe+aUAwcIioEv5qh3nspPfwdj/HQkEKyC4+Ho8nOd1yp5P6zgbBdaCWZAy9LoYPniivvRusCu6mJMRL9itPuHVkPK7LSPOyz5L5pWYQC8c4ymLSpxyLKiclon/OpKvNcjUCJdh0=
Received: from SJ0PR13CA0147.namprd13.prod.outlook.com (2603:10b6:a03:2c6::32)
 by SN7PR12MB8060.namprd12.prod.outlook.com (2603:10b6:806:343::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 02:37:43 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::36) by SJ0PR13CA0147.outlook.office365.com
 (2603:10b6:a03:2c6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9 via Frontend Transport; Thu,
 25 Sep 2025 02:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 02:37:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 19:37:41 -0700
Received: from [10.136.45.215] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Sep 2025 19:37:37 -0700
Message-ID: <17f1a1f2-c5dc-40ed-a69e-a3af499a7068@amd.com>
Date: Thu, 25 Sep 2025 08:07:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 18/19] sched/fair: Optimize global "nohz.nr_cpus"
 tracking
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, Anna-Maria Behnsen
	<anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
References: <20250904041516.3046-1-kprateek.nayak@amd.com>
 <20250904041516.3046-19-kprateek.nayak@amd.com>
 <f9546172-95e7-498d-9fca-18ff142f0bbb@linux.ibm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <f9546172-95e7-498d-9fca-18ff142f0bbb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|SN7PR12MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af61161-ac13-4c7e-0f02-08ddfbdc80f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3M5UFdBVTFkaVBXNkczYWVYcU4rbkcvV0VuTlQ2VXRtT2dXN0l2eThRR016?=
 =?utf-8?B?K05jWUNCd3FVUk9Vc1JBbXh6NFpCM3ROejF5TGpwajNQVnlQWTFXN2NFTVc3?=
 =?utf-8?B?ZExqRlJIbEJBM0xLWEg0dExzeCtZOFNPKzEvc3kydlUzQUIzZEtRb1Y4bVZ3?=
 =?utf-8?B?Q0ROTXY0MWx2ZDdzTTN6R2R5K0Fzbmx4TUpNQ2gzaEJ4SkF1bDhWU095U2E1?=
 =?utf-8?B?aW9zbFY0VC9qU0dyOUprTGhNQjVHTHlGSWtselRGWWZXSjFNV0FUZmhxR0pC?=
 =?utf-8?B?SFh1WDN0NWYxZ1ByYmVHMDFuMXJ1b0EyL1BIZnMvWlVMdHJsUHhIME0yODBK?=
 =?utf-8?B?MlZzQ1JiL0ovREZaWm1FTkNvRnVhQ2w1Uy8vZUlXc1F2SXQ4OFZmbm1hQlBF?=
 =?utf-8?B?cXVqbUdaZWxSWFlDYmRkVUg2Ujk0Qmw5QnRZcTNtMURCZnh4N1NwMzd2SlhL?=
 =?utf-8?B?dnBGUUNKeHhPVGFRMVRTZUhobkdyN3doYVdFbFJVVHVKQjl2bXRVWkZkaU1y?=
 =?utf-8?B?cE9kdUhCZUwvZDFvN0xuczRsZXloUzRZVThXY20wNklqQmZ3Sk9HdENreW1M?=
 =?utf-8?B?S3ZTRU5Eek9QLzJPSFNBeSs1M3lnUDF4QmZrNEVMM0lYM1FKMjNEOGpGNjd5?=
 =?utf-8?B?V2xSNTNZUG9jeXVoTlh1VS9RdHZIM1VLVWZSZHVyV0lXMjN1d2dHUURLakY5?=
 =?utf-8?B?T3lMUHg1Slg2Z0FCM2k2QklvOVEzalhXOGl2bG54c3Y2b054NUtPYlY2OWxu?=
 =?utf-8?B?aURheE5CSFkwdDFwUytUaXNxUkpLZ1BvbTdVVkM5VXFLU0NNZTVVcWxoOTVt?=
 =?utf-8?B?YWE3dUdVS21aVmZxQjEwMWtaK05EYTNUU2x3aVZlWndwQlVxU3NKWXZLZUVr?=
 =?utf-8?B?MXRBVzgyWkt0K2tqcXdzajdjVmJFVEVCd0xxTnEyNjZWZE5sS1BEZEhpMmk2?=
 =?utf-8?B?bTA5bldkRkVMWTZUaTdwOVBQRlZUa3NZUHp5Qm5oT3RZeXp4QnhDdkdKemZS?=
 =?utf-8?B?SExWalJ6QkRNSUZYc09KVllBMURoNDlnQmw4M0VjSkgwRllFeEV5Q1BvU2RQ?=
 =?utf-8?B?S0hRTXRsOVJsb3FnZE9vSXpKT1lEcjRERWo1bWtKZm8ySGg1TGpuaWd2bW44?=
 =?utf-8?B?bU5KWFVFeFdaMnZzdFEzWWpmZGVSQVNldDdaNDJmQWJKK0t1TmI5SHM3VmZX?=
 =?utf-8?B?ZmlSaDlLMGlrUVNuS3NRakoxaUxHQ1JJNUFkQUdWOENLNEdNZlhVNVVBejJq?=
 =?utf-8?B?Tm1hbWZ0QkRDWHM0K1FuZjNlWHVlb09FVWZZOGxxeFd2ZFpPZHhQd3htSnNl?=
 =?utf-8?B?NmJZdVB3dE1wbVppRTM2WStCU3RqcTE5M2NQWlE1a3hNYXRieHFjZkVjTEU3?=
 =?utf-8?B?UVZ3NndodmEzTm1DbDhlaGc1SCtLMUZxRGRWcEJhMzVrNW9kQWRNcWNNU2Zq?=
 =?utf-8?B?L1lxUWl5Y3B4UFljWVY2V3JmVTNBUkdIUXRKNnY4Szg3TzBZb1pianc1N1li?=
 =?utf-8?B?eXdFRnRhT1duSWdYV2JydDlxNVdoY3JjdTd6cHAzK25sN1dPdDlES05DUGVa?=
 =?utf-8?B?K1c5ZDNGdENrMWxFQjhvemQ0UWRHYkNJaTdLTk9wN25VSGJZN0FnVXJpVjRW?=
 =?utf-8?B?Vi9KTjd6NmdTejkxMEhQMXBITVE0TFFCOFFFNVoxRWFMSXY2L2oxSi9kUEZO?=
 =?utf-8?B?Q2tnTjNTVGk0TWRaSExxcjFaVHZpUGRyanBldi9ldXFXanpMOTVYSkNIdnV0?=
 =?utf-8?B?cFZ6ZjVOM093dXAxb0djV3EzcnIzUzd1M241bjJ0eTF3RkJabnZsUUtqeCtI?=
 =?utf-8?B?LzJwSlZXVnRVUFN5dHhTQ2QrZVV3VkxSYWlJRGVWVE9WeThFRU1KWDJyb29D?=
 =?utf-8?B?bllkT3RBSkwvRDU2UlBOTUZ6YkYzSEVZUkd2aERNU3lwSVY2Qnpnc3ZaMm03?=
 =?utf-8?B?MC9VRkVVaVNGWlJvTldMc2hGa2pBT3JRME82N2wwaTl6K3VrTzZoYWxtT1FD?=
 =?utf-8?B?QVNNek1VL29lRTM0K2pzd215Um8vMkNKNkN5d1VBUS82dEFXZ0Vvb3BFYnc0?=
 =?utf-8?Q?1K9Q3B?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 02:37:42.9844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af61161-ac13-4c7e-0f02-08ddfbdc80f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8060

Hello Shrikanth,

On 9/25/2025 1:32 AM, Shrikanth Hegde wrote:
> 
> 
> On 9/4/25 9:45 AM, K Prateek Nayak wrote:
>> Optimize "nohz.nr_cpus" by tracking number of "sd_nohz->shared" with
>> non-zero "nr_idle_cpus" count via "nohz.nr_doms" and only updating at
>> the boundary of "sd_nohz->shared->nr_idle_cpus" going from 0 -> 1 and
>> back from 1 -> 0.
>>
>> This also introduces a chance of double accounting when a nohz idle
>> entry or the tick races with hotplug or cpuset as described in
>> __nohz_exit_idle_tracking().
>>
>> __nohz_exit_idle_tracking() called when the sched_domain_shared nodes
>> tracking idle CPUs are freed is used to correct any potential double
>> accounting which can unnecessarily trigger nohz idle balances even when
>> all the CPUs have tick enabled.
>>
> Is it possible to get rid of this nr_cpus or nr_doms altogether?
> 
> The reason being, with current code, one updates the nohz.idle_cpus_mask and
> then inc/dec nr_cpus.
> 
> The only use it to decide to do periodic idle balancing or not.
> If instead, could use cpumask_empty(nohz.idle_cpus_mask) check no?
> It may not be every tick accurate, but that may be ok.
> 
> I haven't gone through your series in detail yet, but similar thing is doable,
> check if the list is empty or not.

Actually, we'll have to iterate over the list of "nohz_shared_list" and
check if any of the "sd_shared->nr_idle_cpus" is non-zero to bail out.

Since sched_balance_trigger() is called at every tick, on every CPU, it can
add considerable overhead but I suppose we can have a similar method as
{test,set}_idle_core()?

  sched_balance_trigger()
    nohz_balancer_kick()
      if (test_nohz_idle_cpus())
        set_nohz_idle_cpus(false)
        smp_mb();
        nr_doms += <iterate to check if nohz idle CPUs exist>
        ...
        if (!nr_doms)
          return;
      ...
      idle_cpus += <do no hz balance and check if nohz idle CPUs still exist>
      if (idle_cpus)
        set_nohz_idle_cpus(true)


In the meantime, if any CPU is going idle with tick disables, they can
do:

  nohz_balance_enter_idle()
    set_nohz_idle_cpus(true)


{test,set}_nohz_idle_cpus() is just a READ_ONCE()/WRITE_ONCE()
respectively on a global system-wide variable.

That way sched_balance_trigger() will only bail out if there are no nohz
idle CPUs are found after last nohz idle balance, and no CPUs have
transitioned to nohz idle since.

Or we go more radical and have a way to trigger nohz balance per LLC!

-- 
Thanks and Regards,
Prateek



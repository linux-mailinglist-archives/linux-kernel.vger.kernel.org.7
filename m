Return-Path: <linux-kernel+bounces-784653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 664FBB33F25
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE931A8212F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399C776026;
	Mon, 25 Aug 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D8qQyMJx"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3EA18B12
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124218; cv=fail; b=XC5rZudckekMly3tjhM9LmZX6AgN7M16oiJSxrAOixJwCYtTSOC5j5qrBqJjLijjkgJXf5hY31glUZofnnS60sX+RAFBV44bLR43cDur6qPS+u2gob5aJvjR81W3WuMGaBJhX1flEVq9Yff4dFf0yFRYa4/axUsh8pNHDxP3N6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124218; c=relaxed/simple;
	bh=zpGkSs3OoDgN4b9ZgdnEtKnxKn1o+YUAr1i7Q0NhV+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UCgASKkdmnAdv/B42/CtUg/M5u1PYA+tUiL7BLQXG+ZrqYER1sQ8irtbkpetza5CIfB/q5n3IN+hBetdxfkycqoS3peKE62PCcn5jsqVZsa/cH1nwfAwtX2cVLddggTvvYUALZn4jzaWa3Th8Vk3P4r4DX2QUNXaQOa7V2F5cjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D8qQyMJx; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7D0nlQr2fTUsz8qrP4a5uGdghHhbkQtXEtsKmepagyCqfH0bH0KH7OlOvzm5lDExBmIT+7zmNxlSTrht+IqExK7J56lWR4pntTw8TvHSnB3+Ew+C8EPVODU57/7Xi2DLuZlOwdZeFnBk8xhkzw2vHiCtBHhKy859xuFQTbp32EOwLhuRCF/S3z01e3EHwbXUrM7+Mrt7TPG/yn8epaozz/jatvLsaSwsD3o822dQCEM+X4qgwaUxgUzFcVswtmECkH8cFwYbd7Grn36UY0dsj0tm/rnSDDoY4bEltzv9pUXNGWMkq0BOC+q6mXhXw87gtvn4T+PctO1LVt2u6b0xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3LppU3S0nFSGdsRSBkARQ7IWYn99Aj7o3nhXVQXYqg=;
 b=CHiD+2OYP2Wb6koiGHhVPYVzD76tOyU642MuZtSjFRuLh4HiSBHYkUSIwaMFjWcY6/MwDQ+GYEbV8JoIrUeFjeXbZQPi5n5CwED0dHnjEbT50wnbjVpmN/ZXGbdTfgZJxtLMf7WokS6t9mHJ0/k0nnkWyfeVGX0EI6fdIKkeYSLGl+UpIQJi86pjhw7lZk0EoWURsfcVFz1IQ3btST/iF/NSbtKfqY7WAMxUIA7cKZ0sjhpM9CHSZvc+EEDmcWG4ADyoNgsFgycj8zbOfovYN/TwUx92SJ5ZUXxQM+u0rRQn+hDQ3bh0p3YWMOYQNU0Wa9VLzgXriR4otTdqV+w2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3LppU3S0nFSGdsRSBkARQ7IWYn99Aj7o3nhXVQXYqg=;
 b=D8qQyMJxcpTumyv/Z6k3RoN7gZlw6//7Xiysd2ujlAoioCKib5OPtHjDmOzWFlG4Lmojwyow09jcUH7+HfxoYNukHxTdE45Ryk5C7NcHOcTRNtvxaQIU+Docw91zAj1NI5YIoTTGgIsFw/1IY7JPqiRSIHIDectHbvlRanOO/hw=
Received: from BN0PR04CA0090.namprd04.prod.outlook.com (2603:10b6:408:ea::35)
 by LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:177::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Mon, 25 Aug
 2025 12:16:53 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:408:ea:cafe::55) by BN0PR04CA0090.outlook.office365.com
 (2603:10b6:408:ea::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 12:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 12:16:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 07:16:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 25 Aug
 2025 05:16:51 -0700
Received: from [172.31.178.191] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 25 Aug 2025 07:16:46 -0500
Message-ID: <5e944719-fef5-4dad-a468-4c57a78dae41@amd.com>
Date: Mon, 25 Aug 2025 17:46:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] sched/fair: Use sched_domain_span() for
 topology_span_sane()
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Valentin Schneider
	<vschneid@redhat.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-kernel@vger.kernel.org>, Steve Wahl <steve.wahl@hpe.com>, "Borislav
 Petkov" <bp@alien8.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, <srikar@linux.vnet.ibm.com>, <hca@linux.ibm.com>
References: <20250715040824.893-1-kprateek.nayak@amd.com>
 <20250825091910.GT3245006@noisy.programming.kicks-ass.net>
 <5940cd15-b207-416a-b4e4-b5953f4cbf47@amd.com>
 <20250825111627.GW3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250825111627.GW3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|LV2PR12MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5f5955-12c5-4809-5ebe-08dde3d1467f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkVkUFYvNFZPS0pOL3phdUNvWGxzUy9oUnM0aG5NTHdBUmdkaEJnSDRoeHN2?=
 =?utf-8?B?Ty85NHpEcFVwbzREOFp2WlhPdHB6Qm1GS2k1bHNlSWkrWUZpQ3ZjbnlVeEUz?=
 =?utf-8?B?dTdVT2ZQY3hTckJKZWJTcXNQdUVlMWRhcW9MNEJaUExFTFpzakhyaFg1WTFa?=
 =?utf-8?B?U3pmdkFRbnpNN3BNTitBVzZ5eUtxeFBrdzIrTTc1eHJUL0l3UUNad1FUTTF3?=
 =?utf-8?B?YUpTQkRzZk83WEVHbEZmckl2RkYvUXVRUktxdTZRQUZsbWFlK3Y1WTB6NnlZ?=
 =?utf-8?B?ZytjMCtwWWdNbXNlZTEzQkUrQzR3cTZtNFZIRCtSS1NSSnBYQ2dkVFJUcEdw?=
 =?utf-8?B?cmxZbS8wUnlSeERzN21PckRPdHpsVStrWDYzMy9HN0xSbE5tRnJ2SVl6UHMz?=
 =?utf-8?B?NlE2a3BHSmRrKzRpYUk0L3RIaHdSZ1ZNRExNK2RnSmtTc2RjMU1LZUwwK1hG?=
 =?utf-8?B?ZWl0dEQ0UmhleUszeXdPYXRQcnZtWWt0dkhNKzVyR0dLc0ttc1BxRDVTN0Rw?=
 =?utf-8?B?ZEtrUmUrNkJQK2l5Yno5NW5FUS9tenM3N0tjckd4M2FUaEx0Mjg1VXBmUDJx?=
 =?utf-8?B?VWV2NjRSSXF4N0V3ZXc0MEZmcDA2a3JzdFVFUEJzZFAyeXNsOFkyVVBFYUoy?=
 =?utf-8?B?K3BpWWV4cFRsWHYyL3NxSEI3NVM3M0lqQ080U1VhVG03Y252djUxZ1NLOGRC?=
 =?utf-8?B?NTBmOFhaS05xV0tPRGhSRnhXS0JXWWlZVitobEtBZVVBemxZTHZIY09QbXUy?=
 =?utf-8?B?TTFHQm1IOVJyUDRhTEwxazZveHdFVnF3RmpBVlRrak9RMXRnNGVpOEViZG1K?=
 =?utf-8?B?OEdXZDcvNlJVN1hlUnNMNWpKU1cwWmhnZVVoWHRkcnBjalpqejhyc2s0Q0Qw?=
 =?utf-8?B?dDZZVjFDWHJGMGs1QUpxM3BkbU12dGVOaXMrQXkya3EwRFJCcE5jbmNHOU5w?=
 =?utf-8?B?MWsrSVNUVHd4aDVnQmxTbllKNy9Bajl4ZHc5MUdWTjYzRHZuZk50eDNHSnJr?=
 =?utf-8?B?NU1HZTZFRmF6aXZLNWMrbU9WRWk5NVdBUnBkRHFUdW1VbkU0eVkvRTNFM25G?=
 =?utf-8?B?TVgwTFN5YlNENDdlNkd0QURtRlR0V0RZTlBrcFQxZXJRNnU1WTBLWk5HZG1m?=
 =?utf-8?B?cGdNbHBEc21QNm9EaHJLTExobU5EeStFRFNKYnBoMFpvRmM3cjRjeWFEYlN5?=
 =?utf-8?B?amt5cjJPVkN3bitBdWNWYXZEaXo3dGtGTnI5eXpqUnFockIvQ2E2Yy9JL3hT?=
 =?utf-8?B?dnVUWGhSNTU4Y05ycm8rejVST3BpTzloa3hyTzBtNXYvanlzZXZ3dCsvcGV3?=
 =?utf-8?B?Z3VrL2Vsdm5TemhzT3c5K2s0MnllVzZ2OEV1VU5tUTdtYnloRTNRb3V1OHpj?=
 =?utf-8?B?aHRLL3d1V21nZjJoTXI3Z0x4ZnRGR0VPd0h4M3RFZ2NHN1UyNFVveHVVZkhu?=
 =?utf-8?B?eVNhMWpMSVM2NW90NWJ6SGZyaUtMejJmeWlWWUwxa2RHU3J5TUNnbGJBenBZ?=
 =?utf-8?B?SVE0ZTZ2YlZ1WTV6WDN5M0IrS25vNDJQUVhsUzZGc1Zzc21ZL05jcVFESXZj?=
 =?utf-8?B?YWFOZWh6RUsxdkRSWXp3bURuNVNVWmZCYkpvQ2llRnBZNEk3U1lXZ1YydzRO?=
 =?utf-8?B?MmtEVExtZkorMjE2T2JLcUZEUVZSUTNGeHpTbll4K1NHbUdHaVM0ZDMyaWpU?=
 =?utf-8?B?OWgwQVVsUWNVcGRDTDJoSmZVR3RycVRQTG9UUFpUcXFCYlpaMVduaGJqR1hT?=
 =?utf-8?B?UWtOakpSSmJRamp6OVhHRk5xK3FhSUowanBVdDVpdVFvVkpoYTljOC9jTmFs?=
 =?utf-8?B?aTEwMmZkOE9jeGNDZk9ZZEw4S2RoVGVndjd1dXpHNG5VdmZOV2FJeWNFKy9H?=
 =?utf-8?B?c04reThQeENiNW52eW1TMkpNWTljaEtLM041eXgzTWtvUTBrVUs5S3p5SEZZ?=
 =?utf-8?B?QmYvenB6LzlCWExvMVpRWk5Fckx2eWsza1l6MTc2d1hiZ05XaitIWUN5SVli?=
 =?utf-8?B?WVhYdWVKVFNQRmh0UVI0Z1FSY2p6dmxnRitBMkJSLzcxOG5zRitiSkQyblpz?=
 =?utf-8?Q?ql+Wdo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 12:16:52.6470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5f5955-12c5-4809-5ebe-08dde3d1467f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752



On 8/25/2025 4:46 PM, Peter Zijlstra wrote:
> On Mon, Aug 25, 2025 at 04:17:52PM +0530, K Prateek Nayak wrote:
> 
>> The above helpers may need guarding behind CONFIG_SCHED_{SMT,CLUSTER,MC}
>> if I'm not mistaken. Possibility for some unification and cleanup with:
>>
> 
>> Thoughts?
> 
> I hate we need __maybe_unused on static inline functions, but yeah, that
> might be nicer.

I couldn't find a better solution unfortunately :(

> 
> Can you fold the lot and stick that nice Changelog on? Then I'll get it
> into sched/core and we can forget all about this stuff.

Okey dokey! Posted the changes as v6 at:
https://lore.kernel.org/lkml/20250825120244.11093-1-kprateek.nayak@amd.com/

-- 
Thanks and Regards,
Prateek



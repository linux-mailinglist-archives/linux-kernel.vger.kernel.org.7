Return-Path: <linux-kernel+bounces-820079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA925B7E1DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED48D320ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 06:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED4B22D4FF;
	Wed, 17 Sep 2025 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V43wAhm8"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE54298987
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758091522; cv=fail; b=tgn5ZvK4gcXctYfCGeW1kJPuGRqyLBTRdFare5BgNMkhr/t/s1/nfVJinebuJ9Ew6OZdJeSvcs/i4NatZ7Ea0Xduzgq1dTZFy+GbV7dHRfSAFzrlBFUyLSjXfI/M03q5YltqynxDfmxkiA7oYkDf55ZwZmrQvu/b0D+69xvRhu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758091522; c=relaxed/simple;
	bh=TQC9SyzgpdUwlCQaAiR1Hzi/liHyxCWo445aw2JeQo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YtzdHJ0T+hF5oR/Af0TPqsDO/CAaUgwAv7IDJ96npJ9bdI4AJgADNkccHBgbweiodhDMwXjw1E87LSPa1sSuh3qHb5U+PrbKdQ2sYBFjy8rZHp871ylBnngFKR+Nb6uVPykPzhDgWwdS1dpRCpdpE1IZwnhtuIHpGTcTdSijuO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V43wAhm8; arc=fail smtp.client-ip=40.93.195.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQGYvvi3eDsO4IiT85zmPaGrfhr1pWiFeYJXpAHXv5Jtfpnud8pq2lJt0HeVCwTfL5JdzfKmK1KgpeGSNy4fEaLa00pSTwiaGX/aN9OYPUJRvuvV3FzWognwrWhybv9y6mPyfiGWzNB403x7Dkc8jdZ31tdTYprw0BcSah48MKQh6VRz9WkoIvarDC1fr59+gRTlS3e+R53HG6P6328jAt41IQBlIwww0YFgn3wZcckelYWeRhNjCHlrufycYs4saw2JCTuMo3z+VapOWscA5Bf9osTcaoPA+fXYnKeRxI31wiVMsw9mvWNa3oiM/hDdrHTUU4NF1WxTw3AsDmd/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xG8gDCexwGqOWeGLbwUfbwNHkzsKFxNB2QQEDFmIznc=;
 b=LyaFD6j7ir8UCPH7Ppy5cmNFes/Yax0sFyx2OnTHYlGaBEWuCXJOMyLSYhH3ug4Z3hs65vglB/hzsIgXqZAjv5g2gTl1pHwaiDOYc78gRv+Y2JQECOmbuvFoaYLN0vLkarl7AafRLDnXRHrXax9cbG8cXorzHIipQsy/EQHID2jHfOnZrKnmw0n1fFCq4pGBvStS1uG8Hp35Zlqchk96H+RwRCuHHnZY1RMrsDupN8K1RekWlxfL10qhJRozfTCbSNLq3tYUzyhoTNHkBmzf5ehjCgt/NkMESMP2rZKLhlrgYju2NE+/OYF4xdgEpkixFXfwQEGPWTQalAKwaBx7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG8gDCexwGqOWeGLbwUfbwNHkzsKFxNB2QQEDFmIznc=;
 b=V43wAhm86YWTLMfgxN0ZyVTG8tnT30aIHzJLxc6+RhZN7wLyyrlmRWNkgS+SphHrU9+5I1dBh85rkkuckwh+L2iw0S/2q9ZDuFbKFKyF1hKGCqUWzCjkr5SQjHvKqpfkmgvBleUpVbErm8ZcBaEcsOJzv7JuC1Zu4n58Q9KGgy8=
Received: from CH5P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::26)
 by DM4PR12MB7504.namprd12.prod.outlook.com (2603:10b6:8:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 06:45:15 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:1f2:cafe::df) by CH5P221CA0019.outlook.office365.com
 (2603:10b6:610:1f2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 06:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.0 via Frontend Transport; Wed, 17 Sep 2025 06:45:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 16 Sep
 2025 23:45:14 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Sep
 2025 01:45:14 -0500
Received: from [10.136.41.20] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 23:45:08 -0700
Message-ID: <04b1ec0a-414a-4f28-9804-4a6d2c95b10f@amd.com>
Date: Wed, 17 Sep 2025 12:15:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] sched: Create architecture specific sched domain
 distances
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
 <1aa0ae94e95c45c8f3353f12e6494907df339632.1757614784.git.tim.c.chen@linux.intel.com>
 <e11163c7-9e23-4556-9a3a-962222978686@amd.com>
 <1bccae2c1830daab13cf892ecb1ae7c05edd98f2.camel@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <1bccae2c1830daab13cf892ecb1ae7c05edd98f2.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DM4PR12MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c3c4c9-9892-4b9c-b40e-08ddf5b5c220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTB4WHhZeER4anc1cVV0Zm90THJReHFZcWtwOURGYS92Sm5EREtTdWJPaW9L?=
 =?utf-8?B?R1BuNDNRRVlaU1VWUVlrTTNwdGQyVWpNSmk4R3Z4a2p1c1pqS3VFbFYwTnRV?=
 =?utf-8?B?Y1BlT3B6YmV1VVMvQWg2dnhGUzJRd2VYNFNmNEJ6OC9rQUQvb3phcXdrUnEy?=
 =?utf-8?B?bVZHVm5DR2NVZTVqbUF2ejZNOXhUZ3h3RTVuR2tKaXVEcG5IcnE5d0l1ZXU3?=
 =?utf-8?B?Q0llNHY3MnZLYXhCa3h4YmEzWjVSS05XeVV6RTFvVVN5RWJ4bDUzbGkwSjc3?=
 =?utf-8?B?Um1IKy9XMzAyd3VSdGdPTEFlTlMrd0U5RldpL21Kc09vd3lobFR4Zm1nbGw3?=
 =?utf-8?B?NXB3WXZnams5VVp4MUNEV0ZMNmFtbEE1NCs4SlZONjBqWHpuYjVrbkJvZVN2?=
 =?utf-8?B?Yzc5NDJLVUZEVldiRXdHelBqWEdaZjBYMkdYN1k0ZWp1WjU5NGs0Vlh0ak41?=
 =?utf-8?B?cEtURzFJSXBOTGpTMGlLc0t3UHF6ZENmSHVWUUl6bmJNenU2eUc0QmJoNElU?=
 =?utf-8?B?dEJUc09FbENjR0hmdU92aXFxQTJzblpNbkwyelJPYU8ra3hhaWZuRXhWZjRY?=
 =?utf-8?B?d1JFNlhhakl6ZTZkNUtQYSt0RG43RGVYZU1EZ1FzOXZuR0RyYWFtOHFmb012?=
 =?utf-8?B?VG5jc01oV1h2bjRBRHk1QVU1SWF5MUpQL050SXdvK2V2SnY2c3RzTFhFOU1I?=
 =?utf-8?B?WXVXUytiaTdxK1FDZ2QxNmM1djc2K1N6aVk4cEFrL2FXZ3pPYWlINTFpeWsr?=
 =?utf-8?B?WjdNQXBCSVB3ZWxwUHk5T2NTREFZVm5KTjlURnliK2k2WXlMU1BoK0s0MUlO?=
 =?utf-8?B?dEZicDJWSzU4N3VZME14R0xNOEdGcU5pc0tqSWFETmRMNEUwS0V5d3Z0TkFT?=
 =?utf-8?B?QUVYQlVSbTVaMDZtY04yMUI5WFhpbHFQbGoyd2U5ak05Y0VPaEV0Yk5IOVVn?=
 =?utf-8?B?QlRGQjR3TXVJcFVWcjRUbmlreUJuY05OdHRnZFVNZFpHb2Y3Q0pDY0dISDYr?=
 =?utf-8?B?Nld1YTZZQlVqWnhoUE5kTmt4NHdxLzd2bStpOFc4R1lIRzlNVkZ4ajZiU1cv?=
 =?utf-8?B?M0ZpcEtIelk5VGR2QmdFYzBKejdmL2NmZDlNTzIxMHJsUWd6eUg1dytrUkxs?=
 =?utf-8?B?UGdCaDliRlptSDNKUEhvSDZZRzNVT2x4aUQ1SVNBYnUvQWF5cjVjZGtwVGEz?=
 =?utf-8?B?M1dNOXErbE1PTVc1R3lKVUdXUktVMGFHYnZXTkM1dHhLNnNGMldqL0NSN0sr?=
 =?utf-8?B?LzdqQlF6QUV1enVnWFUxa0FBd2FKNDRNQ2JWSCtPQzE4U2ZZcEtyaWZjZVQz?=
 =?utf-8?B?MjJUVVpScmp3RHZ1K3NKdU9peVowcUJHdkZQK0Q0aDdpYm9nOEd5U2xHRmNU?=
 =?utf-8?B?alJmZHk5eENkOVRUeHhLTEkxcmtZNEYzZjFETjNReVFGR09PeThrWHJyZG1S?=
 =?utf-8?B?UnE4b2MrNHZOZ290ZjdHaE1iS2xGTUJuTVZGNWJUMXBqbXp4VUlpYnpRVW80?=
 =?utf-8?B?Ym5Ha09lZVZxa1MvckZMZ213YkoyWk54NVNoYVV4bmFMdXg0bzlYWkpRa2hB?=
 =?utf-8?B?YVowZ21VVDRiaDI3NUd3c0diNE50RWYvd3Z0TnJCRXRhZjJsVnJXRUd5RFhQ?=
 =?utf-8?B?ekg1Uk96OEJLeFhaRXpFZDcwaVhNSFpGMHhuRWNVbjFOMndRMWp3bmFuQ2F6?=
 =?utf-8?B?alB0WHBKRERPeXA0bjdNVW9jN1l3cER0RmQ1cGMrZThWTThtckd0N3RXSDZo?=
 =?utf-8?B?Q1BCeFRDaW4vZ3ZGdGdMWDNWSTdZUklxWlZpVFRRYVBKUzBxOTdkN2hBdUoy?=
 =?utf-8?B?U3piTUZKcnlUVjl6U3dEbHpWVWdrK3NoOHB0K2d6Y1lDazY3OVpoVGJBVExE?=
 =?utf-8?B?VG83SDRNcE5xN0xXTTdsVmljWTVsRlg4Skw2Q2pmRk56UlZnZFVmMU5BYUFz?=
 =?utf-8?B?MHVwVmVkb25VN0RZRUJaZkE2TmcyQXFpR3p2aGtHQzlGSlo0bThtWHN3bVNx?=
 =?utf-8?B?NWtJVFBIUnd4NWV5UUM0WEtiTCsrSU9uUXh2UkN1MTdrZitPS1VqZGd6NkhY?=
 =?utf-8?Q?E1z6CB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 06:45:15.0727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c3c4c9-9892-4b9c-b40e-08ddf5b5c220
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7504

Hello Tim,

On 9/15/2025 10:14 PM, Tim Chen wrote:
> On Fri, 2025-09-12 at 08:53 +0530, K Prateek Nayak wrote:
>> Hello Tim,
>>
>> On 9/12/2025 12:00 AM, Tim Chen wrote:
>>> +static int sched_record_numa_dist(int offline_node, int (*n_dist)(int, int),
>>> +		int **dist, int *levels)
>>> +
>> nit. Is the blank line above intentional?
>>
>> Also personally I prefer breaking the two lines above as:
>>
>> static int
>> sched_record_numa_dist(int offline_node, int (*n_dist)(int, int), int **dist, int *levels)
> That would exceed 80 characters.  So we would still need to move some parameters to a different
> line to keep within the limit.

Well build_balance_mask() in the same file follows this pattern and
exceeds 80 characters. Maybe it is alright as long as is under 100
characters :)

-- 
Thanks and Regards,
Prateek



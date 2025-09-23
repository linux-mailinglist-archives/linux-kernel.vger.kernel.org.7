Return-Path: <linux-kernel+bounces-828088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F4B93E96
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D9887B076A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E5426D4E6;
	Tue, 23 Sep 2025 01:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fqKIf3Bh"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B422CCC0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758592301; cv=fail; b=nUcvObHOMcO6RGRtktgV/YHphV2Fkeg0gdf3nZ7dq82SF434gOMijSnr6DOyEovu5PzkWoRs7kat2YAA1l3U1KMfFJZpVz7AviMJSn85hh/rpCXG6hIW/AbEUbVkz49UEUaMc56O785qcmlYU6sctUJ4vY2K+vlA2+NSB6SA8lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758592301; c=relaxed/simple;
	bh=8GQnXV4cadnRruLACEr7KEIfLRuvc+hE2a1VkjZX8K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SY/cwJAM1I19oK0P2YDF76jbwUvhhmeOHNXccQxwk9dHcLoyQsGy0gy8NtXeeUmJVfIXbSeolXU3snn/INs6IArClykApEu0TcybjCoZgRyjjHwT91LRcmXGicCrUGdz2VEDIsSP4ciFYo/7AOmrXako9rq2llwffzcxHVgE0+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fqKIf3Bh; arc=fail smtp.client-ip=52.101.85.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1sqeDIqPg2GX6RJ/ruPXoDVGPgXd1RpKXu5GiMXwxWGgUBD5IZ54iFuyWMDP633QmLslvKV4iB0qgyPxsjxpNLKAO9dV1LfPR8KitOeLaWtsExRc+Dyd39igH6uz5Hkg+cSYEUDOS0Q8ncDdTSLZjbRf3w9/8snV8zwMFvU6ZNIXw8Tq4YPYpUtEDU5CRrz2L18N+fbCueKf+SZLIwrzWyLDbxe80aOXbh0GPqb3ycLNIQgq6iEj0zBC8NF3F+6dEKEgopag+lIAZ3Bgh6yuq+cXjR5h+5eq6JKyDIDC81Os9SwCkQTPpQqkgOVR76KGSYjD5mAjnlJOTeZ2+ik2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hubQ0/LvTYkdRnO4QxYcKAc0kcb9XznS3gC0yMA8qHk=;
 b=VI+MqX/DBFPkXXd8SmgVHiOxwmUZdWRqfndzefINzYbd+zvrbDHw+SxG3ZNmLedbwZHX9tK8SQ8ISRx8+uwhEeS9VnhygIni3iU9B8E7XFvvJOuvi3ojj+GxN96Yy/jy0o6i1wHDGmRS4yf71ClAMHcPQNTuxWkwzV8nEF1WigIIup0KpMmez5bgYs/NbzRuMcB+Ys/9xJF76COz5vDdZzXW0vmDGELsbz+SvnN199Z6IZtVIGmTZ1sUveDIHp5Iv7VWM4mNlXLlniP4O0qPmU1x/vIWKhOtHzauXKHV96LQkY8xxUn+oZa8ft9wZTQsvk3LMeqOZ6W9OGaEpLFtcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=amazon.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hubQ0/LvTYkdRnO4QxYcKAc0kcb9XznS3gC0yMA8qHk=;
 b=fqKIf3Bh3XvDJpUOul7vtxvdz7oHGewb9gLHr3boePN2Q54yFEv9IP+NU2Rv5ppxMHRWdOydC+RNhZ3xo8T6P5/Ipm2JotTHxprzcnjfk9zv6y1gVbu5+S/4hBsFwIZm5f5TRCMh6VMHJpUL9gqsHfGrliNrQVkbO3qW+ice8Fk=
Received: from PH8P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::6)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 01:51:36 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:510:2db:cafe::78) by PH8P223CA0009.outlook.office365.com
 (2603:10b6:510:2db::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 01:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Tue, 23 Sep 2025 01:51:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 22 Sep
 2025 18:51:34 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Sep
 2025 20:51:34 -0500
Received: from [10.136.47.65] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 22 Sep 2025 18:51:30 -0700
Message-ID: <d14c71f4-512c-49f1-a27f-4cd872c14fe6@amd.com>
Date: Tue, 23 Sep 2025 07:21:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] sched/fair: Still look for the idlest cpu with no
 matching cookie
To: Fernand Sieber <sieberf@amazon.com>, <mingo@redhat.com>,
	<peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <dwmw@amazon.co.uk>,
	<jschoenh@amazon.de>, <liuyuxua@amazon.com>
References: <cover.1758543008.git.sieberf@amazon.com>
 <beefbc1474a94868c22b0351dedc0d7398b79c33.1758543008.git.sieberf@amazon.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <beefbc1474a94868c22b0351dedc0d7398b79c33.1758543008.git.sieberf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 2881e15d-4a14-4a6e-9368-08ddfa43bac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cy9MVldZdTE2QSt4Skx0YTl4Tm83YjFXbzRGbTU0UFNocUs1YVBwbTZQYmxB?=
 =?utf-8?B?eGwxMVNiNGJzM1d5dXZpMDQ4ZlJjZzF0d1NqRm1jQjR4Z09mUWI0Nkh2bHBZ?=
 =?utf-8?B?TEhuUWVGNDhLOGNaZHdycmFoN2dJa0lZOVhFclhTaVVSRk1UOERFdFMrR0Nr?=
 =?utf-8?B?MjhvenBZemRnaTczdS92WlJPb3pJdW8xQkFONVV4Wjl5NkQyc2YyeSt1T2I4?=
 =?utf-8?B?aG1ZQ2p6VUxJTVVkaThURmZuV1EvK0NidTRoUGJTdlNlR0QxUERpcGduRGNP?=
 =?utf-8?B?OC9jL1lWL2JKcGRBOWpGRy8rVThPc3NTbmZ4SHpIRU1qakoySjhQVkZzTTlG?=
 =?utf-8?B?OE5jV08vbGQ2NnlTZU5wbGRyWHNSc1BDMHlmZ1FyaUVTemFJY2dpL29Ta1Ja?=
 =?utf-8?B?aExvNStnUG1ZcWs1aTNKeFhKM3RBQ1JpcVprOE1HaWl3eEZzd0FlQUIreGtv?=
 =?utf-8?B?cXd0VlFqR3NydlpsajNzYUg2YlUvZ3hteTg3U2hSYytGRVc5YkMyUE5DR1Nt?=
 =?utf-8?B?ZFBEdFlPZE1LL3pSaE5CQUNBSHZPaFViK1hrZ2h2dGRXZ3lmZ1NZR0czVnd6?=
 =?utf-8?B?QWFYMmh2VzMwUzFhcTdiM2JjMzBaRGk4MS8xdW1rNlZLenRrbDlqNEF6MTYw?=
 =?utf-8?B?WUg5OHRnZE1jbEF6OTNPZitsNTN1dnhOUEFEeEdmWitBZndoZFhxZ3JMTytk?=
 =?utf-8?B?WkhaWTBIYmVxdmFZMU9KY1FRUlFzRSs2UW5PUEVTV1ZPVjNnZXlXeUhMU0pY?=
 =?utf-8?B?R1kzcVVEdFR2V1ppMTVPd0dSdTZXMDh0cjF1dVA5bFBNdG9NaDZqQTIwVmJj?=
 =?utf-8?B?bVloWm1yU0FtcGRHMCt6cE5DWkRaWkFPeHliVE5BcDllQUtscGN5OU44Y05M?=
 =?utf-8?B?U0h0clV1VEhycTRybDBzK1BzRE9WQktxT2MyNGZ3RWNya3gwNWN6VkJEakQ3?=
 =?utf-8?B?NDRBRXc4MUFDa1h2eFlyNHNXV1pWaXRJNmF4ZGQ3ODJmbmRlMUNXK1FvNUl1?=
 =?utf-8?B?U2FyUGlkd2ZvdXJ0TjZySjBwMU9Ta2hSZzJZTU9GUG11RUFZS211ekczcm5P?=
 =?utf-8?B?c0hLVjJIUUlQNGMxbmFMeGN2L0Uwek5tdjFkTWdJR3NkYVM2NVppM3VIMVRx?=
 =?utf-8?B?M3BaTm16NDVROFJUZ0lKRXllMzNEaTg4S0VRY1IrTkxKMWhiVE16L1krY3lT?=
 =?utf-8?B?TFlGVUU5OFNyMGZDQXl3RWZ0QkI2T3ZPOUFJWURlTmt0MDNKVXJDNUdYYmNQ?=
 =?utf-8?B?R1VJZk5mdnBmY2xMVXJPTW5BVFhaUWNHT0lHU2dDUm1ycEdDV1VnTldSOThN?=
 =?utf-8?B?cjBhaTV5YlIzRHR1NXBZNUN0VUVleU1NVTU2MWNDSE8rSGVNcEJZYVF3Nk1s?=
 =?utf-8?B?YWRwRktYZkZEUktrcU5XNzVlSWgzbGtxb0lYQXhjQ2cwSU8wSDB4Z0RBL3lZ?=
 =?utf-8?B?SnBVZVlqcDVJRS9IZHNWWDhMQjdJejFaRjMveTV3L1FRcjZsWUFQYk1QOUx6?=
 =?utf-8?B?ekRzeXhoN0hEZWgwQUU1M3p4cTRlWXI3K1RXS0JOaWppWkVZSE1KQ2V2TzZO?=
 =?utf-8?B?aGkra1NPK2NOYmgxbnh0a3hSaGs5bGpjTTJsU1JZc2pGekNaYmFDN1Z0KzR6?=
 =?utf-8?B?REpURUx4TnJvSWhFNGxPZ2FJQWRqdk43QlBFY243TG5xa1NpTkhmaHpUZHdW?=
 =?utf-8?B?M3pWdEs5akdyR1VRek1BaE45NXFnSmxES2dmWGUzY3pXLzNpcm1zMHBsWkdj?=
 =?utf-8?B?eGZEMkx4VWFkM1cySW94eGJUN0t6NnBjRlNybnJwMnVkVlBWaW9ITWtuQUhy?=
 =?utf-8?B?U2oxZ2tqVXJROUZUNG5ZK0xzb2tTK3ZrYTRyc2xuVDZmY1YwaVQwNXJMWUs5?=
 =?utf-8?B?clBqMkpuQjJ3MmF0ZUM0Sys5UUpDUCt1TWROOWYzcExXNjFtVjNta1MrVmFI?=
 =?utf-8?B?Q0xLOWtuRVBsekJSNUNOeituZk84QUFjaGR0M2ZqM2hVOWw5dERSNjh5NG5h?=
 =?utf-8?B?eVRhQW9iNWx4TlBEZXFhZUdzWldOK0pmdVB5NmpZeFRrZ0dXNzM0Wm5tQkI3?=
 =?utf-8?Q?/1Q7sS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 01:51:35.8468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2881e15d-4a14-4a6e-9368-08ddfa43bac6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825

Hello Fernand,

On 9/22/2025 6:09 PM, Fernand Sieber wrote:
> @@ -7391,6 +7393,17 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
>  	return shallowest_idle_cpu != -1 ? shallowest_idle_cpu : least_loaded_cpu;

Based on the above return in __sched_balance_find_dst_group_cpu(), it
should always return a valid CPU since "least_loaded_cpu" is initialized
to "this_cpu".

>  }
>  
> +/*
> + * sched_balance_find_dst_group_cpu - find the idlest CPU among the CPUs in the group.
> + */
> +static inline int
> +sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
> +{
> +	int cpu = __sched_balance_find_dst_group_cpu(group, p, this_cpu, true);
> +
> +	return cpu >= 0 ? cpu : __sched_balance_find_dst_group_cpu(group, p, this_cpu, false);

So, under what circumstance does "cpu" here turns out to be < 0?
Am I missing something?

> +}
> +
>  static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct task_struct *p,
>  				  int cpu, int prev_cpu, int sd_flag)
>  {

-- 
Thanks and Regards,
Prateek



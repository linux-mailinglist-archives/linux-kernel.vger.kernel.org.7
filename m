Return-Path: <linux-kernel+bounces-870852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E24C0BD85
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82EF63B76C1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6732D6603;
	Mon, 27 Oct 2025 05:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W36g49av"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0232236EE
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761543750; cv=fail; b=XAdvco2S2pciJCgjOf3cGy1+aSjf63O4KX19TZ+E1L2jISEgWVgyyg8PM/WvwjOVyqC3lc5Ha/URhFEPOb1mPXyPTj3Sl/kzErPVTBLDdqKXLHYA7/0d3Cc7ki5aLGSsKKN+gWMljGDa5pqSiGxog585MYEi2obrYI1zdrLAz2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761543750; c=relaxed/simple;
	bh=z/yp5NH98tK8Jn0Kdw7fME2xNffjJ49A4iUwiN8l4Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gqHy3dN2D1njGUgU+tEwTFdr2tmN1fV5MkprRBCpyRK136hVbx2a8CU1m4uqN42zXyHddXLPKMtOJk03dKs3BViWi98Loia2Fu6ISQCOx7H4YeGUtg5nrwncD7NnbtBQIx1Ch3+Yxg3Hn4Rtq0WbMkggtW5Wi32CMq24GQ9HztY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W36g49av; arc=fail smtp.client-ip=52.101.61.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgbjdpPiUuGZq60dZG5yWg0N5ZJXUBmrkUEXQMT3uH2FTIZMfQDtI2s/roJDN6fARxgjyDx9wS4yNf/WxVCL+ts4xe9NaNPwyzKBz6fcRE+06xAfdVoLgvgwqhBGLxwRAlizI2Godt0Pm5acV+VXiZY+R+FNLIhBoogYkSyFZ5UavdLn4jN8ONCrBau0WpUV4Q5HXdWvoVfTFqldEPee5o7S+g0wdkD/Is3b/uRzXL7qE4sRQ370oMHgNQ1rFA4W+vqUt+3TXy4ERgU6J+5g4C5ccNvFbDe9pCiJjMym5omYRKPucE+5D2GXrznkIGSMW8WD5NnFa5Hvk7RBC86zOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aYQ4kAxQVoNFZ6Gy4fK7Vop9xh1uIFTWOl2zBbIPI4=;
 b=iwy1NYzKpZKYH4LOwkdU/uCNqMm2wUHNGRV1DS0TMpAnDL+nyDLYISkD5ZdQwuxP7aJfdGzFIGTNY1rpZXLkxLQOWUlNxrQYQbZg9misNE08kvwXE2jMjlJKCH+kO1hmzZ+SfW9S01VbPB0DQjZCJOnrJS4LjB04YCxIdRsdGjgcGphGtoBLLD3P7UMqrwtCwM4WTO3PWXDuT3AwB4UzgP9pEtJzeyv5FSMrfZxktrJDn1iLV/lGbSVC5/38zw8rYlY+vxWd+ook1aKny9F/Knva85Br32fnC2OyXI5qsnH2JY8g/LV1WZqpl64v6DWpr0jSlU8cgXDud8x9Xjehew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aYQ4kAxQVoNFZ6Gy4fK7Vop9xh1uIFTWOl2zBbIPI4=;
 b=W36g49avoaqBuLSy9zZOICT/aX4TAoysnUtESLD7QJ4VvdmvGB0Fp28AzQgmHY11dqR21Gh+jRKhxSLCpVlDMr2SQqYLKSQkiini6JBqdIIucFA54iIVRPBzse84H+VWD+MN819lSIosP6ATEcxfYqzNahQc9dlDYii8abv6S1U=
Received: from BLAPR03CA0081.namprd03.prod.outlook.com (2603:10b6:208:329::26)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 05:42:22 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::a0) by BLAPR03CA0081.outlook.office365.com
 (2603:10b6:208:329::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Mon,
 27 Oct 2025 05:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 05:42:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 26 Oct
 2025 22:42:15 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 26 Oct
 2025 22:42:14 -0700
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 26 Oct 2025 22:42:08 -0700
Message-ID: <7ff17661-05fe-4137-b7e1-c799fe318c9f@amd.com>
Date: Mon, 27 Oct 2025 11:12:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/19] sched/fair: Introduce a static key to enable cache
 aware only for multi LLCs
To: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>
CC: Chen Yu <yu.c.chen@intel.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>, Yangyu Chen
	<cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao
	<vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Libo Chen <libo.chen@oracle.com>, Adam Li
	<adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ef136e6a6f5a2ef840b1f9571c47411f04705b6a.1760206683.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ef136e6a6f5a2ef840b1f9571c47411f04705b6a.1760206683.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 237d7fc0-1dd2-4b8a-dce2-08de151b991f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|32650700017|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1RXaldvWTJ2L05jbUpXcXpjS096bjJSZGkvcTNVU3liWmxqamdRcVNlcUdN?=
 =?utf-8?B?Zjc0VGs3R2FNRFdXY3Ird3ArNTdkWFk5ZUZERFIrZDNsRlhKQXhRd1dJdVg1?=
 =?utf-8?B?S1dGTDFxVm5jdlFaMzdoSGZ6aEt0S2RXV1dFSG1zQU83akFXQWpRMzRaM0V0?=
 =?utf-8?B?VEFEdkpSUnF2MFBycTNmMHRmMFViaUJNbXBLdXZPWG5JU2N6VDZoa1pIS1lx?=
 =?utf-8?B?OHYyb25sWWVONDNHeE1IeUJhWENEeXFVSnZ3a0QzYitmQ3JadWJaZ0pVL1VW?=
 =?utf-8?B?N2xleFZQUzhhL2tEZGE2QjZQenR4TlUxLzRET1AzSTVqc1JTSVgwaXVPdmFQ?=
 =?utf-8?B?OXJLeU03SVhNaVlwbmM5OE1tWHpYZWM5SmxIbS9MQjVBRHJNWWNJbDBOT2tN?=
 =?utf-8?B?RXk1V1k2cEVNR0JKcDhLNDhFcCtrOXJaZm8zZC9kajIzcDFIYXVpTk1LSENS?=
 =?utf-8?B?eU5iMkxlNFAzdmJ4VGdVN2xPam8yOWJiTmd0ME5QUkUzbWRDcnBVRE9TdjV0?=
 =?utf-8?B?T0lDemdNTjBPb1o3T2NQcTdlUTUvTy9tMnVXUmZLamJGNXIreW1vNVliRHl3?=
 =?utf-8?B?cWlxSlNWZXhRZmJmekFtaHdUa2NzWFUxcWpBWHRwb2pSTXBuTFhaUDBrenRj?=
 =?utf-8?B?ZzdTejMxSVAvVlRwd1ZudUlXcE5aU2dpSDd3TjR6RGxTTWloYXJpZC9lYnhn?=
 =?utf-8?B?UVlKY1Z3eGxWZG1xZUdKTGFQOHMrcW9jSkhNYVN3U1pFVTlEcFRDcUw3aEdX?=
 =?utf-8?B?OU5ZU2tyNms3R2ZJUjlYU1UwNTRTby9hYjAxbytWdnJlbGNEYitRK2NRT1ZR?=
 =?utf-8?B?TmZIRjl0TW1RRURhdkFIQjBKRkZMeUVvVHExZ0gxNXhPRGE0N1JxU0dqZUh4?=
 =?utf-8?B?MUZTNnpndjcxN1B3T2ViY3NJQ203RW9ZUFFMcUNnbm1EOEpmMGJiVjc1ejIx?=
 =?utf-8?B?S2NvRkphOW55WHdEMnlhZllXQkdUWUVoSEJMd2VIangzYmJxM1hhdDd3VS9w?=
 =?utf-8?B?K1pkWmlVQktVWkpvWjRJNFFVTjFYbU5XM0VudWVtL2tZVUpiN1E3ZlRCMzFP?=
 =?utf-8?B?QW45S2RxK2hzUG9oNDRqKy9BMWRDbWh6Tko5OVJOZ2VwSmE5N3dKZ2VCNFJK?=
 =?utf-8?B?eitzOVRJV2ZTQkhVbHpzWDRkSGQvZG92QVcrRXV2TWtHYlJsNGx6cDJ2UnRp?=
 =?utf-8?B?ZU5aUTIyOEZPZG1uUndTR1FzQ251dFhTd1RVSEQyY3FHUXBNb1F3TTEwU3hD?=
 =?utf-8?B?TkdXQmc3d05Qc01IdUtmZUZnYjdEOVBDRXBwQkRCNHRDb2dTTmdpUHpoUHNL?=
 =?utf-8?B?WGxZOFZ6Umh3QXp6OERDMEFKSWdIQ2RnRzRNRU0wcXJMczNxeHZXYTc4OUJn?=
 =?utf-8?B?UmhNYm83M2lMVkp0OVJVeVZWUjNCUHF0MGRsR0kzRjFHVUNTTWordzlYbWgv?=
 =?utf-8?B?cWpYeWVDa1JSeExDTTdabTl6RGpDRWpvT01EWHJRei83QjhSckgxd2VTbGxN?=
 =?utf-8?B?Zy9FYXhnd2lVdE5TOXFrdWdZMUc2R2lqaFNYN3RUZloyd1YrR1RETThtTWEz?=
 =?utf-8?B?VEE2MHdwZnhZNU5pVTRzbHFUdlQxazNQSzRzNTJINEVWaHk2Y29udVM1aVdn?=
 =?utf-8?B?VGVwOW9Sa1BjYVRQQ1ZyL3ZRZnU1em1OL0YyME1MQWFrT1RuWXlqVS9JV2pQ?=
 =?utf-8?B?QTBEQ0lNbmJpWmFFMnVlUUtjdmtnZU1tci80MFRLbUt6cUJUSzhkRWo5ampv?=
 =?utf-8?B?MHUveXdRNjRtWnFoVi9CdTMrM2RKVS9XQ05WTGQ3OC9OOEJOR25EaWpNRE1U?=
 =?utf-8?B?VStXZnR6QzVYRkRNM2N0NlFxaHkwMFpqd0NSajNlVUlnTnErK2o5YVhwMExm?=
 =?utf-8?B?djhGOEZONEdUeGl2VzVRcnVSOFI1bTBoZnAwTGJMSGpUQkJZRmV5eUxkNFRM?=
 =?utf-8?B?MmRPamN3ZVZxeitCY1VEUkJUTmF5Q3BiZ0FpRmhKeHh6N0dwRWprdUlCbVVO?=
 =?utf-8?B?YmJmZlA0d3ljSkYxQlJJU0VmVUZObUpEZGF6N1Y3c1p4MDlON0NWTURTUE1U?=
 =?utf-8?B?ZlQ0SzJyWGxub2MvdUFOTURvSHREYlJoeXQwa0ZMWWNPdDJBTFJLa3AwN3JT?=
 =?utf-8?Q?CsBw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(32650700017)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 05:42:21.0203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 237d7fc0-1dd2-4b8a-dce2-08de151b991f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088

Hello Tim,

On 10/11/2025 11:54 PM, Tim Chen wrote:
> @@ -2530,10 +2531,12 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>  				 * between LLCs and memory channels.
>  				 */
>  				nr_llcs = sd->span_weight / child->span_weight;
> -				if (nr_llcs == 1)
> +				if (nr_llcs == 1) {
>  					imb = sd->span_weight >> 3;
> -				else
> +				} else {
>  					imb = nr_llcs;
> +					has_multi_llcs = true;

One caution: this will not hold if all the CPUs aren't online during boot.
One case I can think of is when the kernel is booted with "maxcpus" cmdline
and CPUs are hotplugged later.

Unfortunately, I don't think we even have the raw topology data from the
arch/ side under such scenario to accurately make a call if the system
contains single or multiple LLC :(

I'm not sure if it is feasible but assuming the task_work() cannot run if
&sched_cache_allowed is false, can the fist instance of the task work for
sched_cache do the necessary setup?

> +				}
>  				imb = max(1U, imb);
>  				sd->imb_numa_nr = imb;
>  
> @@ -2581,6 +2584,13 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>  	if (has_cluster)
>  		static_branch_inc_cpuslocked(&sched_cluster_active);
>  
> +#ifdef CONFIG_SCHED_CACHE
> +	if (has_multi_llcs) {
> +		static_branch_enable_cpuslocked(&sched_cache_allowed);
> +		pr_info("Cache aware load balance enabled.\n");
> +	}
> +#endif
> +
>  	if (rq && sched_debug_verbose)
>  		pr_info("root domain span: %*pbl\n", cpumask_pr_args(cpu_map));
>  

-- 
Thanks and Regards,
Prateek



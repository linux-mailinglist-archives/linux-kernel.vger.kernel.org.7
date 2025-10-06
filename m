Return-Path: <linux-kernel+bounces-842592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8620EBBD177
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 07:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBA73B06C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 05:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3812C24A076;
	Mon,  6 Oct 2025 05:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DB+n1OkI"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011006.outbound.protection.outlook.com [40.93.194.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C8019A288
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759730262; cv=fail; b=RvDUOKmYAVdkF/UgPkOcprJ7mQsgqBvEMEZ2WpHlaqmwI1hFuoJI0+75y6QRXK1Ylza67TO/tBBSOYgOywDUQF8ydyZOD3aeto2IEyzi+vYEV1coS5S2QTWj7kjZ41JVAXj6NqBg9xYGTGZJT7OSvJPvktC6xqUbW3Gc+nj98nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759730262; c=relaxed/simple;
	bh=UIBgXw1Y8vTmgL4059Row8QrXB8yyZL93I6zrRhR2nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n2PmJV5wrbmo1oDyQ/EK0AGSvy+rDfPkXV45mAebowwcWaH1PbrDH+kKvGHZD9WMI1qMhL7wn57CqZYp6dWPg1gOqfalrjwLVQOd3qP32hoT1596D0/tqqEgNqENKiVFhMK4Tq5b0uvkm3raw2Ld0qW7LnwimKEerpPRqUiRGpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DB+n1OkI; arc=fail smtp.client-ip=40.93.194.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOqxGrIqv50VnbDNodNy8C4zJqBWj0fl7VI4FmCOQyuUvtp89gaM3Gz4ikzdP+IwfGKhUfUyO1HizgeWtbjxCGZV2daqFBfw39MrroNcOnY2j959N2bHtS6Vk4HUalklTyET5cqu6QXcu/lC+Rm2UEf/o18ClGhyuDRbaN1jPdihrPG+cS0Lhd4QTlXHxoPA4JbmYLJVHb5XnoEbelAlWZGM+MBGOf5ylrKJm920Qwdc7+6EiDvm4SlaGwBXeS+rX3Bq8L14WmiuHoQsY7G8pzwtw39LZO2kBHUTGEHLWhEUDnrfy3LFjT49tzPd9RVtntlicOFJLacDw3xY+K/O5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hKfbgz95O8NY/xqvZLQn2sJ8K0YBhgbMkaozM7CFQU=;
 b=kb3KDsouB/sYRNuW057ycWlymKXqff0i8Sd6cDsxzoG3yQUelRrwPCwYCcBsvd8ItnLLELAdVyfYzg1syRZUdtD2g4mFg7Zd7AgrqeM79CNpjUgtdzCxrA9YNaYTyB9qjQI+NNRl6qyYN2ZEs/EURbELvPJU3W5zhh2lh40XdgzzF3ggrbyXDf9HVDIEVHNBsn8eMmxXyekwQjzTiTtb2tzKE6dbwgL7k3ATQU3CR5JkyS4i3GBPbiPsLjGUoFnGoEpe9OLnmVJYyue+tG65erNfX3LV1zvY6vY55X9NFJz6fZxoEDGQTf+WClYZ5NRJC3pgV9VKj6o3sGr8vwGz1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hKfbgz95O8NY/xqvZLQn2sJ8K0YBhgbMkaozM7CFQU=;
 b=DB+n1OkIWP9i2gKgwZ/bqQ6DqitYF8t7lbquOIwxjqh95babiNUS1LmrRaX3+QnLh3QKh0xw6D2B7OWhwJme3RSRRnDclIrWJ/nFCWT6dYz4j6ddD5hRfqkIiExWh4JTDl7GEle46IoBWZeIZbSbqIUsUt2Z8rZf2hqc4xZXhhY=
Received: from BYAPR02CA0062.namprd02.prod.outlook.com (2603:10b6:a03:54::39)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Mon, 6 Oct 2025 05:57:32 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::f1) by BYAPR02CA0062.outlook.office365.com
 (2603:10b6:a03:54::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 05:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 05:57:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 5 Oct
 2025 22:57:29 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 5 Oct
 2025 22:57:29 -0700
Received: from [10.252.192.21] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 5 Oct 2025 22:57:22 -0700
Message-ID: <b13fc805-728a-494e-93ea-f2dea351eb00@amd.com>
Date: Mon, 6 Oct 2025 11:27:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 8/8] mm: sched: Move hot page promotion from
 NUMAB=2 to kpromoted
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<dave.hansen@intel.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<mgorman@techsingularity.net>, <mingo@redhat.com>, <peterz@infradead.org>,
	<raghavendra.kt@amd.com>, <riel@surriel.com>, <rientjes@google.com>,
	<sj@kernel.org>, <weixugc@google.com>, <willy@infradead.org>,
	<ying.huang@linux.alibaba.com>, <ziy@nvidia.com>, <dave@stgolabs.net>,
	<nifan.cxl@gmail.com>, <xuezhengchu@huawei.com>, <yiannis@zptcorp.com>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <byungchul@sk.com>,
	<kinseyho@google.com>, <joshua.hahnjy@gmail.com>, <yuanchu@google.com>,
	<balbirs@nvidia.com>, <alok.rathore@samsung.com>
References: <20250910144653.212066-1-bharata@amd.com>
 <20250910144653.212066-9-bharata@amd.com>
 <20251003133818.000017af@huawei.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <20251003133818.000017af@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0d3655-d005-48fa-c7c5-08de049d3cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L090aWZGcStUWG5na1hWZ1VOdStzWlNCcWVPek5yZ2M0QzE2NHQzdmRhTWdY?=
 =?utf-8?B?dXFkdUc1N2JGM3NlMVQxQnQxQmwyOEI4eDZheHo1MUprNWswY3VvTWpnZjVL?=
 =?utf-8?B?V3MyUzZ1MnQ2RUdKZFFSYnJXZ0l1QSs1SHA4VktVZVZDN3k3MGRnUmFJNnlG?=
 =?utf-8?B?SnZhRHlPbVJDNTZYd0xpeDVnc2JGVE9zdjh5bUhzaU8xV3lKUUx3SzJQYXRk?=
 =?utf-8?B?NHhKdzJYZE9yOFhsazc0Y1JoNlAyNGp3R2lpR1FyQUJQS1J2V3VOUGdDVG00?=
 =?utf-8?B?TDNrak9KZzdSejB4YjRMNW94VDJEZHZnR2F2QTlKbTFBeENrK3hTMExIZ3F6?=
 =?utf-8?B?TFg4bWJJNm8yRTVzNGkrV0lMSmpDYWt0Ulk2eGU4ZnNvY2RpUUQrNXBLVTNy?=
 =?utf-8?B?cThGTXY5cXpwdis2K3BIczNpelJrT1R2Sk1qeExvcWpYUUlua3JZcVlZbGJG?=
 =?utf-8?B?UGtoN0Q4RFVGTnRleVdmOTF6U1VxN2RySXRONXpVNUVlWTVkVTJWMVQ1ZFhs?=
 =?utf-8?B?SW9OYlY2TG90M3JVU2JGUHJXdDdaTmZBR0V3aUdSQ0pHdkkxb3JjQ0d3THU2?=
 =?utf-8?B?S0VIdDdiWi9jQTNKRVZERVdNVU5LdC9ZOFhpa1ZaS1VmNzIyU2k4VHIyOFBX?=
 =?utf-8?B?MnZ4LzIzajB0QmdIOGVhODB4QnlSdGkreG14YUFYdE1CRWphRU1wbGt0d2Uy?=
 =?utf-8?B?bTRhWHJzTzd1dklDdVhSU1MxNDJBQmRkOVVJTUY5MnczVU1UaW5qMWJrci9B?=
 =?utf-8?B?V3FkbURwQ2VtVXNuNkp0b0pSRU9oUnVVYnFqUUxzN1BwaUpmUFBxdUltKzhw?=
 =?utf-8?B?KzVEdXJHbDIrVmx1K1VkcE1pMkdhY25xRWxNT2VhOXlWcVlTNmk2Y0ttU3ZR?=
 =?utf-8?B?NkIxU3dKWHo3V243MFUvYUhUR3pFclVuQ3lCTlFHZTVnSWNtenVDT1hxUXJR?=
 =?utf-8?B?eTZiemtHMEx2Z0JndGtQN0dlTEhBc1RoT1ZmOGFXUjNCRlVabVJEVmRuOGpN?=
 =?utf-8?B?M3JidHY4Z0R6b0NyRlZPTnNlc1dnZVc1dXJQUTVYcGlSSmhxK3dxQktsNlhX?=
 =?utf-8?B?YThYRXdFN2xYWGFYRXU3Q1VENWgveVFWOS9TTFFvdXZFTk50WENPY08xOHVL?=
 =?utf-8?B?TWhhK3NmSko3cVR3VkVIbWxJQ2JpNElKeE40akgrZUx0NDNqb1BpRmI4T0hE?=
 =?utf-8?B?WnROYUNER2VMNjRMYWJIVTM2NGxUeEx0UnIvOU5vdkRYQzh5aGhDSkFuT2VC?=
 =?utf-8?B?WGwvYnRZL09wUEQzTFlzMWxlRjRvUGpGYVVvS3ZNY1dZaG5RVi9Td2lhMSt6?=
 =?utf-8?B?NmhQOWRuNGEraXVKMEVaakxuUDJzZkNHTEUybWc2TVRIeVBub0FnMzBHbTRh?=
 =?utf-8?B?MlVVZzNsS0RXbGpGTlZLQU4xaSsxa2k4U2NzOWVxTzZaZkFITEpNeUpDb2Mz?=
 =?utf-8?B?Z1hZZ1VuYUtyOW1vbXlyM0JFOXo2MDl1YWt0VjgwZ2dqSGhZdHBiZG9HQjBE?=
 =?utf-8?B?YjF3cjRqQnlJckNpNk8wMmpGODhqU3pEQW1ybGtaeTNnbWJuaXd4aFVpTWxm?=
 =?utf-8?B?bk5YSGdXYitqeUl2bnVRODUxWFozelYxYUhZUHJldmpNVzdLYVltL2JRS3lF?=
 =?utf-8?B?OUNod25pK1EzdzNaQjdOVWFEM0pjdzAwNXdOZW5xS1BBZnlUckI0bkkxeG1Y?=
 =?utf-8?B?aWpPUWd2dUx6cHNHWXliSVhPd2lpMzZFZkhSN2JkMy9Td1lRekg2c2JKNlZy?=
 =?utf-8?B?ODFpM2NtNEJwY1NQdVkzUXJBR2poUWp2SXpqS1I1dFNDUUVRY0RtSW5oVWpY?=
 =?utf-8?B?dzJLTnEzR29XRlNhZzJ0WnFqbUliTEI0aWFld2N1ZDN5MDVzVTI0YzdZZ3FV?=
 =?utf-8?B?N0pleDc5R3ExL3pDek1xeEdmeVd6eDlRdDFjNDc1K0tlc0I4RmhVUWlFRUdK?=
 =?utf-8?B?dzNRb2pPUDVsVXZOYk9hb3BDb2pRc01MT2E2QngwdnZsTnMxUUtYQkRyOUxU?=
 =?utf-8?B?cmxrM0RjZnBqanlyOUg0WW43YkFtdGJ6M1I1bFZXVE44dVRmL1YxQVRvUkJG?=
 =?utf-8?B?UC9pL3E0NkhtdWl5YlZHa29hUXh5eWR2d1RaV0QrZExoNHlEaWt5aS8wRnhV?=
 =?utf-8?Q?hZL0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 05:57:30.6522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0d3655-d005-48fa-c7c5-08de049d3cb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118


On 03-Oct-25 6:08 PM, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:16:53 +0530
> Bharata B Rao <bharata@amd.com> wrote:
> 
>> Currently hot page promotion (NUMA_BALANCING_MEMORY_TIERING
>> mode of NUMA Balancing) does hot page detection (via hint faults),
>> hot page classification and eventual promotion, all by itself and
>> sits within the scheduler.
>>
>> With the new hot page tracking and promotion mechanism being
>> available, NUMA Balancing can limit itself to detection of
>> hot pages (via hint faults) and off-load rest of the
>> functionality to the common hot page tracking system.
>>
>> pghot_record_access(PGHOT_HINT_FAULT) API is used to feed the
>> hot page info. In addition, the migration rate limiting and
>> dynamic threshold logic are moved to kpromoted so that the same
>> can be used for hot pages reported by other sources too.
>>
>> Signed-off-by: Bharata B Rao <bharata@amd.com>
> 
> Making a direct replacement without any fallback to previous method
> is going to need a lot of data to show there are no important regressions.
> 
> So bold move if that's the intent! 

Firstly I am only moving the existing hot page heuristics that is part of
NUMAB=2 to kpromoted so that the same can be applied to hot pages being
identified by other sources. So the hint fault mechanism that is inherent
to NUMAB=2 still remains.

In fact, kscand effort started as a potential replacement for the existing
hot page promotion mechanism by getting rid of hint faults and moving the
page table scanning out of process context.

In any case, I will start including numbers from the next post.
>>  
>>  static unsigned int sysctl_pghot_freq_window = KPROMOTED_FREQ_WINDOW;
>>  
>> +/* Restrict the NUMA promotion throughput (MB/s) for each target node. */
>> +static unsigned int sysctl_pghot_promote_rate_limit = 65536;
> 
> If the comment correlates with the value, this is 64 GiB/s?  That seems
> unlikely if I guess possible.

IIUC, the existing logic tries to limit promotion rate to 64 GiB/s by
limiting the number of candidate pages that are promoted within the
1s observation interval.

Are you saying that achieving the rate of 64 GiB/s is not possible
or unlikely?

> 
>> +
>>  #ifdef CONFIG_SYSCTL
>>  static const struct ctl_table pghot_sysctls[] = {
>>  	{
>> @@ -44,8 +50,17 @@ static const struct ctl_table pghot_sysctls[] = {
>>  		.proc_handler	= proc_dointvec_minmax,
>>  		.extra1		= SYSCTL_ZERO,
>>  	},
>> +	{
>> +		.procname	= "pghot_promote_rate_limit_MBps",
>> +		.data		= &sysctl_pghot_promote_rate_limit,
>> +		.maxlen		= sizeof(unsigned int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec_minmax,
>> +		.extra1		= SYSCTL_ZERO,
>> +	},
>>  };
>>  #endif
>> +
> Put that in earlier patch to reduce noise here.

This patch moves the hot page heuristics to kpromoted and hence this
related sysctl is also being moved in this patch.

> 
>>  static bool phi_heap_less(const void *lhs, const void *rhs, void *args)
>>  {
>>  	return (*(struct pghot_info **)lhs)->frequency >
>> @@ -94,11 +109,99 @@ static bool phi_heap_insert(struct max_heap *phi_heap, struct pghot_info *phi)
>>  	return true;
>>  }
>>  
>> +/*
>> + * For memory tiering mode, if there are enough free pages (more than
>> + * enough watermark defined here) in fast memory node, to take full
> 
> I'd use enough_wmark   Just because "more than enough" is a common
> English phrase and I at least tripped over that sentence as a result!

Ah I see that, but as you note later, I am currently only doing the
movement.

> 
>> + * advantage of fast memory capacity, all recently accessed slow
>> + * memory pages will be migrated to fast memory node without
>> + * considering hot threshold.
>> + */
>> +static bool pgdat_free_space_enough(struct pglist_data *pgdat)
>> +{
>> +	int z;
>> +	unsigned long enough_wmark;
>> +
>> +	enough_wmark = max(1UL * 1024 * 1024 * 1024 >> PAGE_SHIFT,
>> +			   pgdat->node_present_pages >> 4);
>> +	for (z = pgdat->nr_zones - 1; z >= 0; z--) {
>> +		struct zone *zone = pgdat->node_zones + z;
>> +
>> +		if (!populated_zone(zone))
>> +			continue;
>> +
>> +		if (zone_watermark_ok(zone, 0,
>> +				      promo_wmark_pages(zone) + enough_wmark,
>> +				      ZONE_MOVABLE, 0))
>> +			return true;
>> +	}
>> +	return false;
>> +}
> 
>> +
>> +static void kpromoted_promotion_adjust_threshold(struct pglist_data *pgdat,
> 
> Needs documentation of the algorithm and the reasons for various choices.
> 
> I see it is a code move though so maybe that's a job for another day.

Sure.

Regards,
Bharata.


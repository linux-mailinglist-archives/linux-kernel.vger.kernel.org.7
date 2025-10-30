Return-Path: <linux-kernel+bounces-877515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5491CC1E56D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22443BF330
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551AC2C3277;
	Thu, 30 Oct 2025 04:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EiV1SylB"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA50C24DCF6
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761797995; cv=fail; b=ii9zefozAiuUuU2rRdGqEg723ceiXftvwiADVvUissKgS/0qE3kd0LhW/H8K8BXaOjXbklH58YzyotMWuq1tYOTJcZSUWkTWEcw+7rJ4BrbaE8XcR1/hdYCImostw9pYLvaBlQ+qCLVGR2qn8lhWTslsDXipdLRQSiZtiQb2hBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761797995; c=relaxed/simple;
	bh=ovfoArzf7OO4u63K8mNgk/iu91lqVoTVyDuB6eDNeVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s+qG/e4n8nKTlhVLFC9dc3QYWkoNYwL2JymaOo9MH/c/6DjQp9BGvw8y/SLh9/GfOMq/v49AM2tfplxsQOG7UCqUWAqYBN/znwYKN8ZH3FWhfPqumH4kCt7mWFEOJIjVkAbNf726UzR6E/VfrN+P1Ds82GPN/pz3epH3AaHB02Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EiV1SylB; arc=fail smtp.client-ip=40.107.208.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsfDURLdTL+YGt1aC2vH081ZWQHwjtJBgO/THfqhgXmm3gZB1HmLyS3XVpUdJOqBWAQpiKzdDM/8bC3tkrXMOBIPbl+JBwEw0C53Aprymi6mSTl7thKb9GqhfDpGanFDxZvuMaFHc6xkbU8n8KrdjrREHMWPCoDVJ3t5X7Co37B4z2HhC9Y4vYM6Y72PPHX02Jye3NDfAY9uCNPLSESWWtCm6wTKX/XqMewrEEoEy8ApPG+n25Sj4OugIzrmJk5kbdWY1pC535fEci/HpCpaXDWPQR+fmcavPIEDRS/E8XXPUQ4+Fi9a0QGdg9OSmlg44ravnx7mIgyl2aggmla+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFtwWYS7cKgzCquqKN8bqADoIkOJTj3Rnx2rzEjB+kc=;
 b=ChFUsI3GqOs+EjQz8nK5ehMcqlPDjaqWmX/jPRbR3tannwu+/SEP93rEZCGOkkVu74ZWkWA3wzrXQvj0l2nIjWi9unY2Du2dQWMqlNfOXe32tAzw2MC6Dj0MhhGgjkmMMzDN0/kqhLud2qHhYuzcenCSqOHiPHA5R0oqYYNk5Y2MFAFCzpND9+Nh48AJAh95fUyELPevVqVe0IRUFJsRdLIuMfTpgqJAik2sfYHZDvVDufODoZznE+YM5T7gBwz7ohkREy4lZyms8AYNrp9K7Z4ivP99H9IMNz25gaY8aUQJNM5lnKWLokQqRIHpPhzRX/7UTWZZJ5Jhrqkl3SoJOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFtwWYS7cKgzCquqKN8bqADoIkOJTj3Rnx2rzEjB+kc=;
 b=EiV1SylBHyvfQVta7pChjAJfWW2UNohrooRCRpZ/qLGP9boMYlovmmsXBlPUMdbKvMDoG95j7PSmgAPPzkllfrCVdpa01I+1BOAs8J0updxtJg31XQkYgNgdCXhtSRuf6ROo/oLrcWD+tz50K1ZAhNw3IQ56ahD0fWaFYUolcXc=
Received: from BN9PR03CA0906.namprd03.prod.outlook.com (2603:10b6:408:107::11)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 04:19:50 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::d2) by BN9PR03CA0906.outlook.office365.com
 (2603:10b6:408:107::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Thu,
 30 Oct 2025 04:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 04:19:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 21:19:49 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 21:19:49 -0700
Received: from [10.136.32.170] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 29 Oct 2025 21:19:43 -0700
Message-ID: <53f9a8dc-c215-405b-958b-9cdd326dbfe3@amd.com>
Date: Thu, 30 Oct 2025 09:49:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/19] sched/fair: Respect LLC preference in task
 migration and detach
To: Tim Chen <tim.c.chen@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Madadi Vineeth
 Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>, Yangyu
 Chen <cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, "Vern Hao"
	<vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Ingo
 Molnar" <mingo@redhat.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <d3afcff5622222523c843f5c1b023bfe43f9c67c.1760206683.git.tim.c.chen@linux.intel.com>
 <5cdf379c-b663-424d-8505-d91046e63c20@amd.com>
 <0a81b5be-6edd-4231-859b-0c6d06c61595@intel.com>
 <2c57d76f-fb31-4e1b-a3ce-ca13713e1b86@amd.com>
 <ebe994addb5624089db71df8fee402a664f8800a.camel@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ebe994addb5624089db71df8fee402a664f8800a.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0b51fb-b5c5-4244-1e68-08de176b910e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|32650700017|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXY1WlZYSGc2eTI4dWN2ZHgrL3VveVd6UmZjbkd2cnlYNkNNNkgrbXNIN09B?=
 =?utf-8?B?eVBjckJHUk5TRXk2bVpSYmVTU0RUNlNOZ0dwUmh5R3ZicEVqL2RXYUFNVWwv?=
 =?utf-8?B?cHkwSjlteGJ0MUx3eHQzUWNWNkZnQUl3SURmZ1ZOMnB5cWN2MC9LbGlyQkw3?=
 =?utf-8?B?YjVxUGg3M05YV2hVTzc5UGlNZHlvS3ZVdUZtY3E1VGtDbDRoeTg2R0JNKzBK?=
 =?utf-8?B?dG1JTUwvV2xyNEJOS256bEU0aDVIOElQQzFXSUJGWEh2bXltb0pOdVJ0NXJm?=
 =?utf-8?B?UFdoWHYwMTRGdFBrYW5CV09JSlQ1bUcvT1BidW5RQVkzZmJGY1NEa1ZWUXd6?=
 =?utf-8?B?YzBaeHcxUmFvOFA2T0tZNURCa1hTZjNLaUYweUl2Vlg5Z2p0NjVjLzFJSmRz?=
 =?utf-8?B?V25EdHdURmQvRzBFYlVZSE0zN1pRRWx6ZGt4YXNZL2hCaktkMEF2VUdndTds?=
 =?utf-8?B?RkVPTkdHUW9jWWlnSS9BQWl2U1RhUDc1WGNBcXgxTDBzb2JDN2hwV1lQK05J?=
 =?utf-8?B?dG9NVDIvRTFRSEJ4c0VBTS9McUNtSStCRllYdWtjMTFLQmxlbTQ5Y212V3g4?=
 =?utf-8?B?UnprN2dWNkNUVmdVMWlkSGxZUWFoUjhOYkEzYUVrbWNXaUZ0VG5XL0dBbjNW?=
 =?utf-8?B?anRxOUlMV3dnakFwY2JrYnI5VG9FSTZpNExnNUlzY1duMEdjTzExYUVGQzlP?=
 =?utf-8?B?anpUSDJ5OGpldVF3ZzE1T3hkbDkrRmx2R3hURjNFM0krQm43Q2w1QWVISHhl?=
 =?utf-8?B?SlhGT3RGcXVjZk1XMldMVGwyeHFNSmx0UHlqZFoxZStPWTVqV1Vzc09VbkJh?=
 =?utf-8?B?QktaQllQOSs3WXErb3M0YW85bXlvbFhGa2xZUWRXSkNnTW9Oc2FMWmRTVmh0?=
 =?utf-8?B?Z3dXK1M0NWpPM05SQ1d5RS9ZZ1NnSHZOZU5tRXNvdzZMQThvTTZneHplV1lK?=
 =?utf-8?B?WUUxVjh0YmNvT3orUWQ2RXNpK3FjeEFHSUdGbXN0SlErU05BTS9ibVRtVjRw?=
 =?utf-8?B?cmNjaUU3SEVlNHdIUStRejV2UFNqUTh4Ykx1S2l0UElRdTlxeXdkR1BHZk9G?=
 =?utf-8?B?S1E2aW1OU0E5bE9xV2V3ckxLdGNodDRBZ2tVUHN0QmtYSkoxMUNFM2Q0YnMy?=
 =?utf-8?B?Yk9JQUt5Zzd4RXZzWFRxaE40MDRmb3h4YWFZUnN6Q1J3WXdUYlY0K0NyaXRY?=
 =?utf-8?B?TkV3alpHWWQ0QlBJdmhVTWlmc3hxdjV3bGM3WXNHRnZod0lGbDRjbFI1Vjlz?=
 =?utf-8?B?MW5BMzhBZVN3RFNhWEdHek9JejFYVkg0aGs1NFFsZ3NuVkhzWStVYm5qS0o4?=
 =?utf-8?B?R2dGeFFaMkFyMlp2Rkt4bFJmaC83Mm9qMENaRWpPMVFJdy9zb1FWR1FKNlRM?=
 =?utf-8?B?YWRxRExvRE1vZXFrNG1xTUFtRlVTcHkwNElhdm1wTGIvenhwQnZIMWRuUkJZ?=
 =?utf-8?B?emViQnZudGZpMkdLOHZWM0RtSC8wZXBMNjExNkpiZFVlRzZVa01pZlIxNUxk?=
 =?utf-8?B?ZnNRM3JqREhzdjVRWFVMcUk3ZVNwT3hkWGg5MlpZWEMzOElkbjJzYkpOdkpl?=
 =?utf-8?B?TDBwR3pTcW5HVnc5R2RwUGpmU1BpSTBSMXoyckdYenVBbkRYK0l1b2xYVWVB?=
 =?utf-8?B?djZzVC9YL01zR0p1TVkvNlA5Ri8vUHIvZnZqUDFOUTh5S1ZqOXpoa3dLdXlt?=
 =?utf-8?B?dHJORjYyNURSMnBnZWRBVGlCOEluRUpkOW5qQVFUaVNEaVB5VFpybGNOTnFJ?=
 =?utf-8?B?azZCeFVSSzNvbVlXVUJkendnOFh3QXQrd3N3ZThtQUQ3UHZpSEVlMEhWcnVN?=
 =?utf-8?B?dFg3Tm50a2szWm9VbGFKcjZLVHpRNnplZUVBaDVhcGpkYnJxb2FOQWNiYnBC?=
 =?utf-8?B?aGNFdE9ZRjAwZFo5bXdVV25Gam9QN0lsSnRGUmt6U2s1VDIvSndadUozeW9i?=
 =?utf-8?B?WjQrWFp1SGUrR2pvSWdNZy9SL2xydXRzTGNEM2V1VTUyU29CYS8vcXlHVEFj?=
 =?utf-8?B?aVpPNmt6dHQvRG5JQXFZMGxMcVp2T2lnbGtSWWxlMXFxcVNCNVRxU2tJSWEx?=
 =?utf-8?B?MnhIaW83Nmx3L0g2SnptcS9NalBpVXpLUzRGdEJjYU1lanhGSEpSQWdXTGQv?=
 =?utf-8?Q?oDdQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(32650700017)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 04:19:49.5316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0b51fb-b5c5-4244-1e68-08de176b910e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201

Hello Tim,

On 10/30/2025 2:39 AM, Tim Chen wrote:
>>> I suppose you are suggesting that the threshold for stopping task detachment
>>> should be higher. With the above can_migrate_llc() check, I suppose we have
>>> raised the threshold for stopping "task detachment"?
>>
>> Say the LLC is under heavy load and we only have overloaded groups.
>> can_migrate_llc() would return "mig_unrestricted" since
>> fits_llc_capacity() would return false.
>>
>> Since we are under "migrate_load", sched_balance_find_src_rq() has
>> returned the CPU with the highest load which could very well be the
>> CPU with with a large number of preferred LLC tasks.
>>
>> sched_cache_enabled() is still true and when detach_tasks() reaches
>> one of these preferred llc tasks (which comes at the very end of the
>> tasks list), 
>> we break out even if env->imbalance > 0 leaving
> 
> Yes, but at least one task has been removed to even the load (making forward progress) and
> the remaining tasks all wish to stay in the current LLC and will
> preferred not to be moved. My thought was to not even all the load out
> in one shot and pull more tasks out of their preferred LLC.
> If the imbalance still remain, we'll come to that in the next load balance.

In that case, can we spoof a LBF_ALL_PINNED for the case where we start
hitting preferred task. That way, the main lb loop will goto redo and
try to find another busy CPU to pull tasks from.

> 
> Pulling tasks more slowly when we come to tasks that preferred to stay (if possible)
> would also help to prevent tasks bouncing between LLC.
> 
> Tim
> 

-- 
Thanks and Regards,
Prateek



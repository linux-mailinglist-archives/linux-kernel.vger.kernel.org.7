Return-Path: <linux-kernel+bounces-871176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D53C0C941
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0320B4F9A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F949481B1;
	Mon, 27 Oct 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O1Mi9nHd"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA722E8B7C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555869; cv=fail; b=hlhpd69ElX369oc601b/KDPE6yw4VkAcHvIDmTmXMj8hbW8SUVT5K3sGdJgKeu9Ya4WJBlyUBjqiyKJwVXEpxlr0hcZ/wOeTsd+6xQbANCphEI0BwLIVV9WYR31yLmNzAqtcDLJNCpKIqaW8Xb+xsfHlgzyjs85MAwi9B/UKo/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555869; c=relaxed/simple;
	bh=EAc5RYumif817eIxHsjjxRxqS3CJ416Kiu0zO1HKwKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aOdAB4SMvNGHzD4KQMkrituqFTelZlqcKjnCUcBRNbs0w3O/x4R4FQU4xu6KuNR5gL8tAL3lVxcLhkoiuFj9/jRMdhRq1p65297QsQlkWC/diRPaFq1Q77qV3slCp0u9gI5B1BcWW7jZnKYfZkIxFMN8ra0heceFoeJBErRGXIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O1Mi9nHd; arc=fail smtp.client-ip=52.101.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaVzxSq/m3ZJv+WuyUggb3rZFutwh2NA4ozN8POLf03r+JKM9D9mTHC2xOC+a33vIv6hUjwzu9q5Nqxa/AB3nU6Aj8/5G8fvqryb96EnMvAV4/TCLt5Cd2Fu5Ebwq8ep3xUHrXeMZMthE3S5/IonbBirOJvLkmkPbMQjfUHH4g8cB1LaWGRaT/bZCy7SPrLZC3LKathoeazyXQGxeXc9WHzxneaMNG+V17yWDQaxBOvh6PR1UdMwuKyeqWqqeezpEeWBWRlAeI7pHxxVWSi/UqzMrqhHS4UGSDFvBBef6Spq9RB4yzPsJitv8td2yGLaPRrI2UTzbv4Ju0dbu0vDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJD1yqQhOPxMnH7Tv3866TdVP0JzpxvMqBgDGFFkwRE=;
 b=bpRYK9jgrrCo7Lde9fGL0ULQpXyMF7iHUFDUvPUhV+1PNeYhO+274cJzZgPS3BB/RURyAqmVp7nyCdcOEd2SD51APPgBlAiY/IkNfdxob8Tc/u9bm+1LgyOBDcAqITdJ3h1rsZLcznuaHMvuS6q8X3oZHmuXXyaYu8CioGeaXVSUlfMPiYDgBwem419XxoUUbJ9HA+9dfy4iJru0sLMZZ7Qp1nC02SB+0bwc4mNAqjZskmckSsfhD6v9vw5w+BljlNGmwxjrabiguQKwFTQxVSPEJRGVy/qgXfcDgTfOppcOalilBk77RDhTOv98XT++TfC2ZaMvsVrHo4qa8AcrrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJD1yqQhOPxMnH7Tv3866TdVP0JzpxvMqBgDGFFkwRE=;
 b=O1Mi9nHdyqoKffFfv0kDZUj5ZTD7GDsDz1XvGxxwBtfRV6Yb1Koxo15ouMGLCXTDvwdMz94rrX5/Vaa8QCrJJOU9Ba569+kZfkSYpSyw31jiOLC5ZwgjQT+fggpBRWXJQz+Yw72RZzlUOa2MmoQxDFipL/5VZLXrbKuxoMR99mo=
Received: from MN2PR04CA0027.namprd04.prod.outlook.com (2603:10b6:208:d4::40)
 by CY5PR12MB6622.namprd12.prod.outlook.com (2603:10b6:930:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 09:04:24 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::b0) by MN2PR04CA0027.outlook.office365.com
 (2603:10b6:208:d4::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.17 via Frontend Transport; Mon,
 27 Oct 2025 09:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 27 Oct 2025 09:04:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 27 Oct
 2025 02:04:13 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 27 Oct
 2025 04:04:13 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Oct 2025 02:04:06 -0700
Message-ID: <4bc5ae54-4abb-426d-bcf9-708eeb6b34dd@amd.com>
Date: Mon, 27 Oct 2025 14:34:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] sched/fair: Add migrate_llc_task migration type for
 cache-aware balancing
To: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Madadi Vineeth
 Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>, Yangyu
 Chen <cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, "Vern Hao"
	<vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Chen Yu <yu.c.chen@intel.com>, Libo Chen
	<libo.chen@oracle.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <f22827867d2c245c00063a3fa9f2aeddddaacca1.1760206683.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <f22827867d2c245c00063a3fa9f2aeddddaacca1.1760206683.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|CY5PR12MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: d176eaba-6838-4ac1-f3a3-08de1537d2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|32650700017|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elFRSHZpMFhPNDBTOUoraGN2Nit2NUo4Vnp1TGhjSDB4MnRjM0RzWFVwRTNx?=
 =?utf-8?B?aGgyemJCb2RNWWlyYVhDRUxLOE4ySzh0M0lwT2lQMERJNGNzVFp3Ni9NcGhq?=
 =?utf-8?B?YTN6cHN6OTRDT2ZoMWVoeE1UOWxvZWpITkR4c2lnQStqSno1RVJIQ1VGaGI0?=
 =?utf-8?B?YWt5dmdaTGpSOUpqNW9jNGc3QlJMSGtRMjFSaUhzK3RlQXJHTURWdkRDREdm?=
 =?utf-8?B?ZzBEdFF2K3pwQU16dzdpSUFuZFRFSzVsR3IxUlEza1JVNHpib2hHbkxlSTMr?=
 =?utf-8?B?blVkRHFld0NGeTBaaVY2U240V1NQVlFCZWp2T3A1SjJWRitqemFiN1BqREpH?=
 =?utf-8?B?amtvMUJlTVc2TkMzOXQwUWxLdVNWMDVuQXN2a3dsQmdhNFpsd3V6VFFxN3pE?=
 =?utf-8?B?V0dkai93RUtwTlRiZEJKbXlBVWlMVHRZZU92MDdzeW10dGNQTDNEYkV1bUMv?=
 =?utf-8?B?eUlnUkhLYjdGWGRjcmsyYmhjU0l2U3hhNktYaUJvOEowVHIzb2JCc1FpYXZi?=
 =?utf-8?B?UklGR1F6OUZxT1V3TTBGUFc1bUpDV3I2VXF3OVZzM1JvMGMrSlZLZEd6ZEJU?=
 =?utf-8?B?YWh4S2xVblUxZi94SEFNSFNPVkxaWC9Gb0dlSmVEYXZnSndQN0plWkt4ektp?=
 =?utf-8?B?TVFKUGV1Ulh2dXkraFhGTnNiL3Bud0IrWEhNLzQwNXU2M2JCdUlzUE9rQ253?=
 =?utf-8?B?b1VPVW8rNEIvL1VVMlZUdjlYb1dIOWs1am5DTTlkaTdJM1pEcFM0YkdJSmtI?=
 =?utf-8?B?TkdRR1dDL2JNZWxybjFGd3VUak5HcHM5ZFRmd1NoVGFQMGtOa2xzZU82SUUr?=
 =?utf-8?B?OFh0VzR4TnljdnNiRzRId25IU0ZneGtZU0xScXRBa0NwOFI3M0lKRkFJdWtQ?=
 =?utf-8?B?M2dkNkFJd1ZTRXhvUmd6aXdOREhvcjZJMmJ5VWZRUEVxV1A4ZytIVzcvYXlM?=
 =?utf-8?B?MzlUTXhWTnNia2t5QzlhMXhnMjR5aGFzamZvUWc4Um9McEt3enZpNkFHOTlU?=
 =?utf-8?B?V0dscGlyZ1gvMzlURHdJejIyTkxscWdYbUZiRWZzeG95OHFhU1hsanQ3YnF5?=
 =?utf-8?B?andIdXVnSnZjQ1RENkxBT29IY1FFT01KdGdUK1JmdzNVWWJXbk9ZSHBsTU9C?=
 =?utf-8?B?MDdtSEVXRk5PRmNlTHo1ckdESGxHZFJCeDJnRnNFTW9pOE9sbHBtaS9BR3Yy?=
 =?utf-8?B?VTJkRVBWQmthRXZzbUVtbmFPZzNXZWg4c2lVTjdyenlsakZRR1ZYZythU0Nh?=
 =?utf-8?B?ajBXcVRZa2d5NEZUTThoM0l3bkh0UXBLYmdKQURScWV5ZU0vdG9SellscTBX?=
 =?utf-8?B?VXpuV1AwUFg3bTl1SjkzVkdiVm5WYzFhZFR6QzF6b0JyQ3FlTDJUeXdIUTVN?=
 =?utf-8?B?NUYrU0ZnbyswQS94UlY3VU1LSUlIV1Bld0VlWThWZTZ3U0pqK3JsTWxtNTgz?=
 =?utf-8?B?WWNhZzBXN1lKc281VlppM1g1Um00QXFSeWhvRXhrUGRHcThsRm9FN3hXUkZL?=
 =?utf-8?B?NTQ1cGNUcGM1ckJTSm5iaTlrRUtNR0d6Wk5GZGRhUVFHZTllWURJS0xkM0I4?=
 =?utf-8?B?VW50OHl4Ym01RVY1OVhGek42WGp2bmppL2RQMSswYTVhMlUyY1p0MFFKYlJZ?=
 =?utf-8?B?MDdxTi9BYTNqSWl4ZXZIRXNwQ29HMzdPKzlEWU5GTk9hZFFaSVMzMUJ6Q05a?=
 =?utf-8?B?RDJxT2dmMGpYRUZBNXhqdTZIZjNIR3I5K2lRL2tEbVVoWDdOaHFMdDNWSnpT?=
 =?utf-8?B?ZlFXYXArdDBaWEpteW5ocVozVm5CT2taOUVhTXZVdzZUcXhURFUyV3htYWtx?=
 =?utf-8?B?aXdUMzREM0pJU3BPZmNoSTJKYi9pUmRybHk4T012S0ovL2M3RlJ5ODBaazdC?=
 =?utf-8?B?Sm05S0lveGR4RVV4enVSamg3ZldTMTFZZ25GNG8vZm9IRjJvMmkrMDFLRWt0?=
 =?utf-8?B?NWVaSzRUeU9tdVNEUUM0SHFqZE1jQ01UMTRBNE9ydGFkeW53MHBmajlHWVh4?=
 =?utf-8?B?MUhzWDJBL1Z1eTNyaTRnSkcwTHNwVVU3QU4vVkhzQ0VyWVZjZUZpU2pBUGRK?=
 =?utf-8?B?UHNkOE14Y040OEZTN0t6Zkw3TGJibXVXNU5nUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(32650700017)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 09:04:23.5303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d176eaba-6838-4ac1-f3a3-08de1537d2b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6622

Hello Tim,

On 10/11/2025 11:54 PM, Tim Chen wrote:
> @@ -12149,6 +12167,16 @@ static struct rq *sched_balance_find_src_rq(struct lb_env *env,
>  			}
>  			break;
>  
> +		case migrate_llc_task:
> +#ifdef CONFIG_SCHED_CACHE
> +			dst_llc = llc_idx(env->dst_cpu);
> +			if (!cpus_share_cache(env->dst_cpu, rq->cpu) &&

Busiest group is always a non-local group right? Can cpus_share_cache()
ever happen given we are looking at groups of first !SD_LLC_SHARE
domain for "migrate_llc_task"?

> +			    busiest_pref_llc < rq->nr_pref_llc[dst_llc]) {
> +				busiest_pref_llc = rq->nr_pref_llc[dst_llc];
> +				busiest = rq;
> +			}
> +#endif
> +			break;
>  		case migrate_task:
>  			if (busiest_nr < nr_running) {
>  				busiest_nr = nr_running;

-- 
Thanks and Regards,
Prateek



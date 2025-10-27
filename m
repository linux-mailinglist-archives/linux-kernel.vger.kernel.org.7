Return-Path: <linux-kernel+bounces-871049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B07C0C519
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0E78341A89
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1762E6CD4;
	Mon, 27 Oct 2025 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TWL1KA6b"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5233C2E7BDD
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553995; cv=fail; b=dV0EybdNaW1/dlLeskpD3gM7SoIDDNswArXpQz0YKt4jP9ThmRGPz5Do1plhNPmbWYGRUlFtYJ3fcPwzXvIzD60inqMUhXNoCtASIDRlTI7kxg9IdDd2Q0y986O1+BRHmWFi2obDVs2uvEC9WoVPFcigN/HRUaKZCsfgLPWBJh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553995; c=relaxed/simple;
	bh=sjZMZLcC0hvEeLT9Hrti3IV8qTsrvZV5Rf3dp+3ghQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yv2KHPNj31R+aCwfU7517ZiRgSl3ki6kXSZTu8t8DTLe7E0t2OWSt/XbmzVnwFM61qO5rS3eJ7CcV3p9Yj097s5eQcbwanIyQTcnLk5r+GHIN/KhF4rstJ/HULKZgCxHziZntY0BJSN/rfzBoTgE9ed8hKiH+R/hDYqkWmo8/dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TWL1KA6b; arc=fail smtp.client-ip=52.101.62.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XO9h2tbViTyg72J87L/s+dAQgXpnfBbMpd/Xxr3HrvITXagqNcbpKMIfZDDakuUiuG+7TcEC7g8AZDEtIWgKgaoIjhCkyVtkPDILiEMxwcrUfywzAFIbjA8WLpEoJoJgXt3I+7dIXVr6AMwigXt5ZAg8TrFWv4mXthtUqv3hkGTkrYEXpOs3cQE7i37kAcBICH+vgC6MeHi6fY5WzMpAtkLyHG54QwWLtwrYfDLkfcA6cRfnJife+WULPAMnrza2SwdX5VbsyS8wTW3/p1zoAHT0KymBGz9BX8DDp/WTKd1Jk3VNthZfR0TS/HmEEyVIrq+qkPj+GLOgJfwV49XE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0Ot8LHsSOeHkzWxh2KyR+ReU4jf4sby1XnfOyJGXsQ=;
 b=qpeD2CBV5yjBjKsY94IFpYy77LW4imOsRukry+sx5O3nr/JHR0N9J+XH9zojdQ9atr/UcUApM5m8mThJi2MQV2N3Z3xHz92ZmHkhb1TUO7IX8zPjYC1Wfy3V48sDrtwQK1hAdhpn39QbrPw0kt+bPv2moEFUFafCM/JSbvmjDuEnfkTPdkwPAQ7Mwc9lUFIaln8QSLFXG5VdArDQpsrB8iLnNvJ3KE3q7pNVV9DuI8+d7oFBR82xVvpqYqoOrBhH0RLZEFKBpE+OhFIHXUcvV/+L6L5QYvHzj0WxoQ0WTpU+fhQXzCUeYVNhhM16sKWldgnxNNdj3aNJixIPpifnuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0Ot8LHsSOeHkzWxh2KyR+ReU4jf4sby1XnfOyJGXsQ=;
 b=TWL1KA6bXa9CyvdH6P/645KJu1Ik2ytIIwdNhLwwoJQMK36A54avQcIbCrmLLJ6z4Nm+5fmBG+j19mfx5n61tuD6VWEwgSxhsa7hHBMELUKdhtf2ZCWDsVIDEzpICCqaUGO7u88RDI2xJxBV0F+Sek5soUOdL4wcm9/UiuDSKkI=
Received: from MN0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:52f::12)
 by DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 08:33:10 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::3a) by MN0PR03CA0005.outlook.office365.com
 (2603:10b6:208:52f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.17 via Frontend Transport; Mon,
 27 Oct 2025 08:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 08:33:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Oct
 2025 01:33:09 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Oct
 2025 01:33:09 -0700
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Oct 2025 01:33:03 -0700
Message-ID: <aa850892-b172-449d-ae81-d974bb7f4a96@amd.com>
Date: Mon, 27 Oct 2025 14:03:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/19] sched/fair: Count tasks prefering each LLC in a
 sched group
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
 <00e5f2cb6eadc3738e33858d3c4563a0775ee1c0.1760206683.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <00e5f2cb6eadc3738e33858d3c4563a0775ee1c0.1760206683.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|DS7PR12MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e38e732-9f9c-4b57-f2a4-08de153375f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|32650700017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjhBcEs3Z25LbUJUSldOV2xObTZxaG4xNEwrYkR2eTZyZ1A4K0JOa1NMZ2pT?=
 =?utf-8?B?ditiQnF1d0R1WFA2Zk8zMDRFeG93c2tXV3lDalp6QWVia0MwZnRETUt2OEUx?=
 =?utf-8?B?dm9BbytZalRPN2R2dmpncHh0QmkvVXVxNTRFc3liQjVyVGhScENGY2NYWkNI?=
 =?utf-8?B?aVRBUTdudDUyeWFYMGdnSjVjOHg5ejNQMzQ2OGw1ekU1M0lOMEsweE9zZnpU?=
 =?utf-8?B?eGhEeEpYMzAyODdmK3hGNzdiTy9ZTXJKS3ZOcnVnM1o2SEp1V0dYelhRVk9W?=
 =?utf-8?B?VzR3YlJtb0RvdlJEOWFYdmt6eVhIaytjOGRXL2N1eXVENkU3YmVGUUpkbG01?=
 =?utf-8?B?VGJ1WE5leU9Cb0FScm5LTlVFMGpFOGl6a2E3eUw3UHc0ZjZMV2k2K3BkaTIz?=
 =?utf-8?B?b1NBT0xSY1l5Mm5XQTJlaVN5T0hXYWhFMWJWUy9oL0hvdGFUSFNreVJtQksv?=
 =?utf-8?B?ekp4cmxNdWFIOEp1NW51c3ZpUDVVRHI3TjVDYVJZN1JwUFVMbDBvdWMyZWN6?=
 =?utf-8?B?amtveEc4Yi9WV1pXZEY2czczUkhtTW1WR0g3ajk5a1NoZkpacWhVc2pETS9R?=
 =?utf-8?B?SlhQRkNzM3ZmRUhpNHNhRDUrU1FaZ2U1bGJEQUdvdzdhRXgrV1dHdksydWVP?=
 =?utf-8?B?WFgxbnd4RmR2S005M0xxbTZGZGdHVm9EY2dYZzFrQ1NsbXJSaXBIZFo1N3d2?=
 =?utf-8?B?aVc5TGQ2UkpDamcwYUc2ZTJZWC9PRkdsUUxEOWVCb1ViQ3hiVVJ5OGNOZHor?=
 =?utf-8?B?Z2FFdU9DRkMrK0U2SEFMeXBpWWVkQ0JoWnNMeFQzdVBsZUxWZU5BbW1SYlF2?=
 =?utf-8?B?QWd6NFZqTVZRUmpNN3ZkWnZVYTc3a2J5V3Y4ckZldzdDVjNxSE1NTE81WGFI?=
 =?utf-8?B?Qk51VmIyemtQNHV3WDFyWlR3L1ZsRXV5SmJNcUhnZzlkQXVtZDllWUh0N2JO?=
 =?utf-8?B?NTFYdXp3UE9yRDVyQzFKKytaYU83WDc5RmdLOGNXYWx6WVpEV29KdnVmMVZx?=
 =?utf-8?B?ejcrSmN1Y1pENkMwSGJ0dFZkRXZ1VlRFYnovbmh3V2lYVVdST2NUUGpPQno4?=
 =?utf-8?B?WHErUlIzTUVtSGpHaEFSQWtIUEpxcUtpaVpsV3BhcGtXQjJVdW10VENGZkxq?=
 =?utf-8?B?M21oTjFwbWdvQm9WRzVpZEIwVXFUVHNOeldqVUVhZU96M0tNWldZSDlFM0Mz?=
 =?utf-8?B?QnhZWDN1LzF1dXlaajVrc2pTc1pJS1BzVWVLeU9qeHEwaURHeGozMFhWMzRS?=
 =?utf-8?B?N28xT1VEbmZFamgrWEwzMXFjalQ3b2dMMlJkRm0zZkhQSHd4TUlid3VFVG9F?=
 =?utf-8?B?RklmNFVEeFI5YnhDa2NNM0oydlJleEkrZjk0Z0pkalJHTXZNUktGSXZRNzI3?=
 =?utf-8?B?SmtsS2VSRUFnNFQvV29PbjJ2VUNUU2pmYmtIYnIrTTB1UVE3WFFkQldKMHhx?=
 =?utf-8?B?UWFBMnNsdG02SjF0NWlQZitBZ2drNFB5L1M5VUg4cm9rQTF5V2hNUHMzT1Zk?=
 =?utf-8?B?cHF1aDZGT1pPc0JEaDFnUWJOanJXR3JqanNJeXpETEZMZk5KUVFkdmw4QWc0?=
 =?utf-8?B?QlUyVFRuL01vc3hkS05XbFdqaFdVN2t2cUFRK3dSa1phN0RVNnBOQmM3dmhn?=
 =?utf-8?B?enc2U2xqb1BPQUR3alhWN1dmUGsvVWRKTm82Zzh4c1ZnRkRTSUZiTjUwOGF4?=
 =?utf-8?B?TDRMMFhNQVNSZTdPdlp1bUdPcitYZEhRQ0E3WkpsOTBKdUlHRytpdS9NcThp?=
 =?utf-8?B?V0hrbzZJRlE4MkhhKzBpL0tGck1VVzdoVFo4VEN4b3FTRWM2UHJyd0ZmVGpq?=
 =?utf-8?B?d1M4b04vanNTYU1iQ3VXRzFkNXNQV3cvL0dRbGZ3V0U4UjViN1FVakFQbGgy?=
 =?utf-8?B?VkpRRktvNTBNYSs2eHRwOW1oOUZ4U2poR0lHTWpHdEx1UVd6WTI2b3RaUFlB?=
 =?utf-8?B?K0tjZUtGV1hUd3BOMFpIYy9CamhKbjdmVXVKb1FsWTUwaWVFbmY3TlhQc3Vq?=
 =?utf-8?B?eHpSRmoxNFk2dnZDbE9ZdzZ1eis0RHdiOTBkbkpnUFNYMU03VVZPSUtzTHB1?=
 =?utf-8?B?VXNYS0hxbXUvUE9DTGJXV3hXeWU5SjJ6bHV2Wm04TTFPeVoyaHhVNHhpOStz?=
 =?utf-8?Q?7sk4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(32650700017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:33:09.9282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e38e732-9f9c-4b57-f2a4-08de153375f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8420

Hello Tim,

On 10/11/2025 11:54 PM, Tim Chen wrote:
> +#ifdef CONFIG_SCHED_CACHE
> +		if (sched_cache_enabled()) {
> +			int j;
> +
> +			for (j = 0; j < max_llcs; ++j)
> +				sgs->nr_pref_llc[j] += rq->nr_pref_llc[j];
> +		}
> +#endif

If I'm not mistaken, we only compare
"sds->nr_pref_llc[llc_idx(env->dst_cpu)]"
and the destination LLC is always fixes. Do we need to aggregate the
data for all the LLCs? Is a single "nr_pref_llc_dest" enough?

>  		/*
>  		 * No need to call idle_cpu() if nr_running is not 0
>  		 */

-- 
Thanks and Regards,
Prateek



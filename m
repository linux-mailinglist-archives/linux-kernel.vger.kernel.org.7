Return-Path: <linux-kernel+bounces-870909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE62C0BF67
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3D4F4EF5C8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC532DC79B;
	Mon, 27 Oct 2025 06:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jtQKa3jo"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88C824E4A8
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761546590; cv=fail; b=H+6XxPCAJek3N+n59blKW8Kt6g2HrzYN3gRgJLsEK9ORcoiT+tf+e8+bWentpWULtQH+M8cGei8XymP8ceiWeWNu7bNwA0z0te7Q3BN24EZGOJT3av6nMIYiHl/XOJcdAezBERSzarVpXN+u8/Q8ajlBNcEsfu1GeJ6p9jHh8qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761546590; c=relaxed/simple;
	bh=Wd2rfRreSgBxZk4JNIto5HILL4dl6Eq4PIOy6o1zBmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mOpZkpcCBukF2u/4UhmRbQ16CT2JX0AgeCapq2Ve+MHu25Zh5HtzdL7HfKaQdgY8rJ2RORUALi0/pdCnrpi2eTy40fat+B/vm9NPatVZoSEWdefP1Mw5JMFWu4z/WlX5TW2OhM11j2jPZpmGQRe8BxP0lO5Dx70GE6uWMzyW8ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jtQKa3jo; arc=fail smtp.client-ip=52.101.61.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0JOUfwMqNlX7gWJNaKJeJm3fOzwWqC9U9BmpEQQuYY3l6qZvssFPzVloibegK/7pPd4S1J8m+aQmnvLVb0CPKkfiv6NgPUQczQT/bgPrg3p/R/1FVEQax/s2cs60e1EvE44wSous+/P5fA56Hon86jz8KOC3hSoWsy5aORdUdIbbW7clzYSgO+dVjrUqR+pM8w2djE0Ri/RS4RK5xU8xljdeQ4MS/QmNBT/4SB/5KNEvV9HpCBsrAbEf2MUm0d8j9IbN7SSifCr3VktPVutmY9ruCThDSFoO6RjxtlAthcTdKWfcHI4uE/M5TdJbEZSbMKUcan9nssr6z2c9S42yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kk0wGn8oJbD9yJcCn6FvT6+XuxChl71vAtEYSp/wOUQ=;
 b=XnsbYJP90uOsNc3h1NQYv8RmBd6mag0NLS4BXVPam8VvpZsUXUpTHlNQsrli/eBBhnxPWcBvvnhcuUVh0/zWDpLuBa7WE58dFDFmmcYEZjJ6Sp92cdEZfrha4p5qSo2AQA9C9PkgMEjQNmAss/mLQfzjIw8YgNAUkZOTSNz4O97ncazkP7EByaIw/YYbAK5g+ooumggMaPaUIahYKSxH3lfAACvBJFZnr8iCvLO/gaDnY+fdu3zAYYx96NnrlvkBFvMLraETTobWOPDjLKE/8LugoUQBAzXOze3OXW1Y0rgFBW4jgthXizFVVxLlNIKIc/bqPBKoURXJOhH9FlalCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kk0wGn8oJbD9yJcCn6FvT6+XuxChl71vAtEYSp/wOUQ=;
 b=jtQKa3joI1t7Fc0bv1uLiLBNE0m7MQZf3x+I9A5QwJOiXFSy5RTmxMqwhyLjo6VClDb1+NCt1jAN14SLMztPGWtXJCe1Asox7j5Sx58MDWX6q36LEPvDIJWvhqk6GolIIRockiD3YjNuY7a/6OPg1tjvjrPZTFFHhE2at+cDpM0=
Received: from MW4PR03CA0196.namprd03.prod.outlook.com (2603:10b6:303:b8::21)
 by CH2PR12MB9496.namprd12.prod.outlook.com (2603:10b6:610:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 06:29:42 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:303:b8:cafe::2a) by MW4PR03CA0196.outlook.office365.com
 (2603:10b6:303:b8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.15 via Frontend Transport; Mon,
 27 Oct 2025 06:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 06:29:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 26 Oct
 2025 23:29:12 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 27 Oct
 2025 01:29:11 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 26 Oct 2025 23:29:05 -0700
Message-ID: <576e63aa-3b39-4d05-87d3-e894ab57dcd1@amd.com>
Date: Mon, 27 Oct 2025 11:59:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/19] sched/fair: Prioritize tasks preferring destination
 LLC during balancing
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
 <ca1946de63ad9f0ae99e079a74d70c55879cc0b6.1760206683.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ca1946de63ad9f0ae99e079a74d70c55879cc0b6.1760206683.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|CH2PR12MB9496:EE_
X-MS-Office365-Filtering-Correlation-Id: c11bef17-ab90-4a4b-2585-08de15223625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|32650700017|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXU5RE9DdWpVOXhnUU1SUENXR0k0T0lpSG1FV1E0S0xUVzZxbHRSNVdUMnFT?=
 =?utf-8?B?SXlYb0xXTnJYM3BpcUNZUUUvcVcrNVUvSWFKeHN4VzdLYWVlaDIxeGVxckZF?=
 =?utf-8?B?akp0RXo4ZWNhQ09GVEZuK2p4dkx1V3R5UlVBVUVDa0YxUEpBc1V5SWUyOTJW?=
 =?utf-8?B?ZlJGOENiYWNQdGIrRVhCMEdjV1Q0QjJsQWYyM2pTU0VocVRyeExOTGlnb3pU?=
 =?utf-8?B?aEVpN2VncWx1TGJ1dFNucWp4bW0vaCtJcFl5NkluV0E2Y3ZuOXVoVFI0bWxx?=
 =?utf-8?B?MUMwNXpVQ0JmeGNWaktqd2F0MEtpVGh6M0dBK3phSnhEV2pBK2dLYm4vNkhF?=
 =?utf-8?B?WEUzMGhtZXhPelhlZmx6Zlo4ZW5YLzdtM1dQS3UyU3cvYkJhbXVWS1FvN3Rx?=
 =?utf-8?B?UG1ZZ21Dbk9mdU9GMVFFTEdQa2FrckVoMTc3RXpBRWJhcFI2RHJzcnBnSHBN?=
 =?utf-8?B?a216OTh1M1Y3czlySmZGNzU4ZkxEVWJhd0crNE9QeFZ1bklTY3JyM25EM0ZU?=
 =?utf-8?B?cE1pTkFSa1Zob3lySHlWVmZ0WG82RENtREVkTFZmMXVNeFVLckp0am5oR2JI?=
 =?utf-8?B?MkFjcllyU3UrZGdzTGNreEg3UUFQTTRZRjVvSC8vcjdMWFJnUnNOWXQzOWwy?=
 =?utf-8?B?V09KZVgyTjI5K1lBMFhkSDJrbFVMWkF3U29LMVh2d3VwV2tKdHE0UzEwUXBm?=
 =?utf-8?B?Z3FXTWVuaFhZTGlmSjVjN3d3ZWUvZ21wd1VISXVNbVFYamlDYmlzL3hKVTZT?=
 =?utf-8?B?NkZGNExFUUxSR0hnMm9SdnNaVkRZT2JxZllRNUxicHlSSGowY1NZNHV0dFFo?=
 =?utf-8?B?RDFPemRaajFlc3FYcFBXM05FS0Q1dThsc2J1dThwbDVwaTJNQi9LMkVTWkg4?=
 =?utf-8?B?RUwvaHdKVThZemlUREtMRDlUbWFrdDVMNnpVNjNkdUxVRE5INVQxa01Lajl5?=
 =?utf-8?B?UW9rL01HQ3V4LzhEWWY2bGlFTUNnemRrV3ArOHBkOGZsZ3k3QUJUbWtBTVJP?=
 =?utf-8?B?RmNGblNrMXc0TDdSMUdKRWVLY0lyVW9lbm9pd1ExV1dkRnN0V3gxV1R3K0lz?=
 =?utf-8?B?YUJMWEtHZjVJeEZrUDl6Ri9HZFhkdmcxR0RhUFgwTnQ4SlpQU0MxR1hwM3I3?=
 =?utf-8?B?cUdCd082YkwyVHNXOEtBM2s0aDhMQU9zOGF3Y2pVSkxPbmRKVWVVY05NdFNR?=
 =?utf-8?B?M2pNVlZvbWVUYXhwUGlpcXUwVFIrNWUva2dmSzBXYWFzekZNZlZBNUlqb052?=
 =?utf-8?B?cHFSOGVxdTIwYUJrcUtxSlBWU0xDdjdLMDVNNE50V1EzdUxaaVZJblNlRzNv?=
 =?utf-8?B?cWV1WXR6OVNONk9LV0FJQ0hyS1JoZFpxd0J0UVJ2N0NTNWVLcVExYnB3UlMw?=
 =?utf-8?B?MWlRRHdPejVsUjJVMGhiUjdhQ1dPcHdSekNkSDhSVk9kU1VEVHpubTVWWGxW?=
 =?utf-8?B?Z0VpTjNTVUZqZDNvWGhtZXBWc2tBQ29yUm5TYy9JRWtsdG1jQnQ4QUJid21J?=
 =?utf-8?B?djRqRnFHMWhXajRWNGRRdUsrMnEzL3g0NEtHemZhRHdGVUpTTmdJYW92NDNU?=
 =?utf-8?B?RHB3eFh4TnI3SmdzTVNKVVNkRVJYaGdxalhIa1JpK2ZJQi9nYVFKVEVLM2cv?=
 =?utf-8?B?RllTOTVLdExpT2paOW8zMVkrZ1Y3QUpaaVVyczl3TW1uRG5xRDBsZUZUbWVs?=
 =?utf-8?B?c1cxZHVBdTBjY3pqaWxrODliOFNMdlpoWldFcjFYUlJoTVZIYm1ETVY4RzRF?=
 =?utf-8?B?dkExaHdtdCtXS3JxUUZaaWZKUHJFVCs0Y3NMdGpCWHY2b3gzMEJnS21WRFAy?=
 =?utf-8?B?UmlMZTFmblh1Y2tUMkd4aVYyeUhvNWVJR0JETnFSbTBSdHViY3o4RXM5YW5x?=
 =?utf-8?B?RTF0MVMyV2ZyVHRFa0NnU3I4Mm92NUc5MkJFU3VCZjlZSlFxY2QrZ3ZhNWtY?=
 =?utf-8?B?ZFJmY1BoV3JjMzlvZm5LRmtQeFJnQnFRMC9xZVc0YVFUSzVPTFNLYkpmSXMy?=
 =?utf-8?B?Y0FwQkNZMHBIL0ZITmYxY2NGT2VNYlJQWUxJd0lMVGp5dFdkS05PblRZSXB6?=
 =?utf-8?B?d3FuQzA4NHFwbWJUeDVoL1FLUkpJRW1VazhCcjV1MmNTRDJkTHNVdlI0ZlNl?=
 =?utf-8?Q?HQ8M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(32650700017)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 06:29:41.3980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c11bef17-ab90-4a4b-2585-08de15223625
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9496

Hello Tim,

On 10/11/2025 11:54 PM, Tim Chen wrote:
> +/*
> + * Do LLC balance on sched group that contains LLC, and have tasks preferring
> + * to run on LLC in idle dst_cpu.
> + */
> +static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
> +			       struct sched_group *group)
> +{
> +	struct sched_domain *child = env->sd->child;
> +	int llc;
> +
> +	if (!sched_cache_enabled())
> +		return false;
> +
> +	if (env->sd->flags & SD_SHARE_LLC)
> +		return false;
> +
> +	/* only care about task migration among LLCs */
> +	if (child && !(child->flags & SD_SHARE_LLC))

nit. You can just check group->flags here.

> +		return false;
> +
> +	llc = llc_idx(env->dst_cpu);
> +	if (sgs->nr_pref_llc[llc] > 0 &&
> +	    can_migrate_llc(env->src_cpu, env->dst_cpu, 0, true) == mig_llc)
> +		return true;
> +
> +	return false;
> +}
>  #else
>  static inline void record_sg_llc_stats(struct lb_env *env, struct sg_lb_stats *sgs,
>  				       struct sched_group *group)
>  {
>  }
> +
> +static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
> +			       struct sched_group *group)
> +{
> +	return false;
> +}
>  #endif
>  
>  /**
> @@ -10954,6 +10988,11 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
>  
>  	record_sg_llc_stats(env, sgs, group);

Okay, I see the intention of recording this based on group stats.
Sorry for the noise on Patch 2.

> +
> +	/* Check for tasks in this group can be moved to their preferred LLC */
> +	if (!local_group && llc_balance(env, sgs, group))
> +		sgs->group_llc_balance = 1;
> +
>  	/* Computing avg_load makes sense only when group is overloaded */
>  	if (sgs->group_type == group_overloaded)
>  		sgs->avg_load = (sgs->group_load * SCHED_CAPACITY_SCALE) /

-- 
Thanks and Regards,
Prateek



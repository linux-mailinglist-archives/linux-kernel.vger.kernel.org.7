Return-Path: <linux-kernel+bounces-877537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA734C1E615
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8F0402FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EC5324B3E;
	Thu, 30 Oct 2025 04:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VfMQHKRm"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013057.outbound.protection.outlook.com [40.107.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700242F39B1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761799879; cv=fail; b=L2IOdfriNw4/1srvonTuQ4kM/+DBrlQ9HrMsseRVK7dsExYNO0JFXBw2GtvIlCV4t23BxLfm6nIv9dIs+3Va0FgQXrEAJy3FUp1TLtcp+EagY131SNMLMn60YP2IZLKxWLKIawDMsTiPWJJKKIEpi/XM9ZiTFwWGT+NcL12QLxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761799879; c=relaxed/simple;
	bh=YgaqHbryVch79AuZZmTqJefnkePBw/gOMsKLOI+qcps=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CzmMKqEJE6Xnv3XxBiB4AUtXJZa64f09aLbRfGrpgekIHbttQijAHXu8rFZACLnE/bncSG47UMxKKXG7cAbaJAbLC9gcm8PZlBWBjlJKsokQBSY9lJujPrOts86m/0jhpp/WuRJOUqjjP0LNqBaQSOBOAAM2zJYFVmsb5TLkWVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VfMQHKRm; arc=fail smtp.client-ip=40.107.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2SpUFvxOTRaxuTXg7uhwH5agskQBKh26EJGSPpD5nar4O7qnaBrfJHFYRMRoi1L4Xda8oU7gJnxGVxP6MGVekoBkncW3lm1NDRN1CsHHpHWIL8tUvTTmHE2Nz/uzHJjo5Mr0caTA86KIhVwpG5N2EgHcSVs6FR68AKhhaqRGBN3nKa6OJh+9l034pcc6y7ut4y0NRYbyxuq11iWvKN5UUOtWtEVdxoAGilMKB3Wr77zSqQTvAikKhPI6B3tJaAiKE6iXEKKUDy2buVa7JGWs4wlM5rSfL+mLk/9jb9sM/7/ZZeYPOihTOMxwzrc30RkdQzATy10Ds+lo64xvWo+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSalK4J4lizrNO2Rzk0VC7T8RyK27EhF9iwWM5uT0Ns=;
 b=FAeu95ZaQrOuHIAOY/WVP4qzBC93o6kE7WW/YdIPs+l31C1sqFcjlgFukSIb97lewz0quaDMf5Qf6eDMkOWDkpSiReuzzBLCpZu2fyhAQjsEcLzptXD7/gewdPxWS4fsl9uaAqdAirz2sqWY8rq+QbPQSexnVF6nKzG2SjmenfN2c/Rf5ecLgRMR58S1BA0HTXkk5FuVFkejZ3Q6mtrp5zxGf4pG0zjRSVBeb/tysjEIf0ySWPo0JUz/0520iD+mLAIIdum+ZbbhlVESlqfNdLscVva6F1BZzw7xYJeOTs8tn/X9kqnHSRmiDgPLZSShIF2p1hIJPMvRvhreATRTVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSalK4J4lizrNO2Rzk0VC7T8RyK27EhF9iwWM5uT0Ns=;
 b=VfMQHKRm0NdOAcTtCuTL2KywRNvpYmrwl4rAnNIPfYCJgfHRoRXVR02D0MJ+awkt7ZWd0S5s+OcVozbz9H86FuMLtYHTN9JsX5F6GAKX9O/BpUzrF7/JqVMTQ0M6mv0MxwKNs0M1Awno+bKJxXwG1CrW0uEGsNUd3gKOpym5QQM=
Received: from DS7PR06CA0007.namprd06.prod.outlook.com (2603:10b6:8:2a::25) by
 CYYPR12MB8961.namprd12.prod.outlook.com (2603:10b6:930:bf::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.13; Thu, 30 Oct 2025 04:51:14 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::a0) by DS7PR06CA0007.outlook.office365.com
 (2603:10b6:8:2a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 04:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 04:51:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 29 Oct
 2025 21:51:13 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Oct
 2025 23:51:13 -0500
Received: from [10.136.32.170] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 29 Oct 2025 21:51:07 -0700
Message-ID: <84c4aa9d-9094-4b12-8912-63a338a43351@amd.com>
Date: Thu, 30 Oct 2025 10:21:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 2/9] sched: Fix modifying donor->blocked on without
 proper locking
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
CC: Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider
	<vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman
	<mgorman@suse.de>, Will Deacon <will@kernel.org>, Waiman Long
	<longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan
	<xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, "Daniel
 Lezcano" <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	<kernel-team@android.com>
References: <20251030001857.681432-1-jstultz@google.com>
 <20251030001857.681432-3-jstultz@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20251030001857.681432-3-jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|CYYPR12MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a289ff8-5df6-45ed-1924-08de176ff419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3hkS1FNbDRZMjJiaTBsRW5pUFNUY1k1R09iY2NCR21wakFRSlQwM3FwZHNK?=
 =?utf-8?B?Z2htY09uOUg0RVMra2hoUE5CZFF6MUZLNmtUVHJyd0hjRmkvTjRpbkpQWHow?=
 =?utf-8?B?TzEzSHNnMlpseEt6OFJKKzIvQjRUT0RvUkNIL1hMMWtPWWxPVmNYbkxJbVd5?=
 =?utf-8?B?UWV0YWxYOG5tdkRKR1I0VHZJTWpWL1BjM1Y5RExDSWpTMzk0N3NsQzhJVmEr?=
 =?utf-8?B?QkhnSjMvOWJUYi9KQlpYVG9nbmtIeG15RmdCenVzRVZTZ242eEtuT2dCUTFi?=
 =?utf-8?B?T0VzRHJDVm5pR21mcjd0WEZPR1RhemFqbmlMdXBpR214eXptdVpnSDdKeEY5?=
 =?utf-8?B?dzFmYXAvRnFJYldxcVFaM0I0VlJnOENvMzU3ejBhT2MzL0d2SnF6Z2F4cnVK?=
 =?utf-8?B?dkt0L2haV3hTUTJZcXVCVytBM0lacWN6bnpiV1k3a1FmeGNqSkhsdGgwaDlO?=
 =?utf-8?B?NVRlZlJZZnNVRnpYSFBuQVo2bCthTk1wK21CYjFnRnQwTTJTSUF5MUxCQnl4?=
 =?utf-8?B?Y3luOHJmeWIvWGxyc0J0WGlidWIreWlzSVZ3Yms5Wmp3Znk3dkF1MnB4aG9y?=
 =?utf-8?B?M1N2c3QzUkJtclZNaDJHT2F0U05oR1FEbkFNdFl3b3UxZlE0U3AvbjF4MExr?=
 =?utf-8?B?aGNydDQ2V1V4dlNGd2hpOXBhbHpJejFkWkd0bGc2S1RVRlUzQzZ4U0ZlSnJn?=
 =?utf-8?B?TVRNc1AvNU9kcDZnd21TdUQ3MzZJUkFkVjloVFd3dmJxKzRrMVY0RXJRRE1P?=
 =?utf-8?B?SzhwUWxPaElQWkhrRS9xUnQ4VkU2OHdaQWg4TnlmdUIzay9tTHhESzNWTTNa?=
 =?utf-8?B?L2piV3pQUU1JeDQvWC9aMlFjMDc1dWw1WFZXVm0vbTltOFRhUm9ZNEVjUGsx?=
 =?utf-8?B?MVNRQmtIaFlJVEFGMkxpajVObDcvdGlHRVZqT2lNenZlR2ZoUDR0VVdyTTJr?=
 =?utf-8?B?VEhhTGYwM2ltYW9QNnQ4NnpaM1I3bXdvM2RMUmJSUVl2ZjFnSU9lQ1EzSExx?=
 =?utf-8?B?ZHpyQUQwUXhTMUh4QWFoTTNBWURUaW1yMEUrdkhzVk1DZWVwVk5TN1ZqNCto?=
 =?utf-8?B?N0EwL29IM0JWb1lCcFlLdVNpbUNNZWltdGNFUW1ZV3U2K0t6THpCQlRjd1JN?=
 =?utf-8?B?ZU1Ub2RPTXZMaXhjYzdsOTdQb0tJSVEycnlpbmFLeC9LVElMKzR1S2FwSEkx?=
 =?utf-8?B?dEJiN2hUcTZlOEU2UkVLRGRQYU5CbFZXaDVQVFp4MGpjY2I0d1lyN1YzWUJx?=
 =?utf-8?B?MGQ0RnhtNXhOZ1ZyRGxETWRZQnZwdUtTQVljUkdnU3pLd0FuTzZFOVFoTks4?=
 =?utf-8?B?OGwxdEdJaDQvV1hob3lTZE42YzlTWFA4TldSdmRlcXIvMXpxZHU0YWpSV1Br?=
 =?utf-8?B?MEpZQzFGYUQwLzIxVjlCVjdpZi9lUitWakI0UTJqSnVlOHJuQW1BR0dMdVVu?=
 =?utf-8?B?RE9LNVJQR04zaUI2R2lIcVJnNUhBaVNpRDBXYjhOVXFDbmZjdjRrWjduMXhL?=
 =?utf-8?B?NnJRcWoxeWR5NHZoNEZVRklIeDZaOXpPQU9ZSzlKUXQ0NG1rYTY4ckw5dlBn?=
 =?utf-8?B?azcxcy92MERubmZNenNMcS80SVFjLzFBTFZSNlZqOVgwT054R0xkWFdyYVcy?=
 =?utf-8?B?MnVpUWJXVmJVOUVHa09KZ2RtalRUYkQveHNZYjF2L0ZPUnpnMW1ySGV5alht?=
 =?utf-8?B?eHRQMk11TWs0S0pxaHJHK3hRaSs1cDhOQXd1MFBsRjBraDRyeCtpdGsrTFlC?=
 =?utf-8?B?TWRlNFgwcHVXNVZXZndIZ1RmRzJxQWVRcXVLSmE5eGdnb2VMcDAzWlVNTUJG?=
 =?utf-8?B?WC9yRHR5QjZuMHJlRjYyNlMzNUQxcVZYY3MrWVpITlAzWXVlOU13aC9kUW1m?=
 =?utf-8?B?NExWR2EwT3Qzd1h0VkE1Uy8raUlld2o5YkFTdzlBbDVVeVg0b3NoRFhKbjE4?=
 =?utf-8?B?Q2x6T1A2S2U1SFpFRjZCZ0k2WXYxWVBBNUFjNUJ6c0pQRkdabmgrbjdsVHNs?=
 =?utf-8?B?Tk9OdFltK2V5Q0hzd1IrUU1BazRCMHJwY1hQTUVOR0Z2SUdkUG5oTjFqdWxk?=
 =?utf-8?B?K29VOWU3a1BaL1ZZd3JyTFRaNHY2ZlpDSmcyaytoQmRHckZpNFR3ODBYaGM0?=
 =?utf-8?Q?sIAs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 04:51:13.6808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a289ff8-5df6-45ed-1924-08de176ff419
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8961

Hello John,

On 10/30/2025 5:48 AM, John Stultz wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 517b26c515bc5..0533a14ce5935 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6591,7 +6591,7 @@ static struct task_struct *proxy_deactivate(struct rq *rq, struct task_struct *d
>  		 * as unblocked, as we aren't doing proxy-migrations
>  		 * yet (more logic will be needed then).
>  		 */
> -		donor->blocked_on = NULL;
> +		clear_task_blocked_on(donor, NULL);

nit. You can probably switch this to use __clear_task_blocked_on() in
the previous patch and then to the clear_task_blocked_on() variant here.
It makes it more clear that proxy_deactivate() is now out of the
"donor->blocked_lock" critical section.

Either way, no strong feelings.

>  	}
>  	return NULL;
>  }
> @@ -6619,6 +6619,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
>  	int this_cpu = cpu_of(rq);
>  	struct task_struct *p;
>  	struct mutex *mutex;
> +	enum { FOUND, DEACTIVATE_DONOR } action = FOUND;

nit. If you move that declaration to the top, you can preserve the nice
reverse xmas arrangement ;)

Apart from those couple of nits, feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek




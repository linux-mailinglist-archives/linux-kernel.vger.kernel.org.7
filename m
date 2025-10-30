Return-Path: <linux-kernel+bounces-877742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A70A5C1EE91
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8FD4189FD59
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD7232BF49;
	Thu, 30 Oct 2025 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tm7gXBze"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011003.outbound.protection.outlook.com [40.93.194.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E575030C358
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811736; cv=fail; b=i7M8LtMmeS0G5s8nhLHASosTZWmZn3vF2AeFZax8oulVapR3fYl6zxSyeoD63nEcsmwcfSvBUIoImVwYIXOEDoTug54j3Qx9MVIQQMZxiErr6LfIgt30Ol/4W2xiJJyfZUm0iR6u845XaTFeTbwGhFg/C+musesCVyAF6N4w/8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811736; c=relaxed/simple;
	bh=KAbcqwS1TLNPwX2aeYxbIdy4QLr0CT5FarX982AfuVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MyY23AXB4Qqdyn25FmYu6+ukuQacgZCkZKL4U+7JWDZNUnf32CI1OSpR68t51KYKgX2w1N7O+ygdcLOMwvJrCKVAv4HHndbL9aj+/Cdr/5L8PqpVOMdGxC7ShpLfUO2b8djzAigzFqk5CjPy0bYoKxV5y4m/cIN2aitPwCc4Yy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tm7gXBze; arc=fail smtp.client-ip=40.93.194.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euJ319zyaOqaAbKDwhKlOzoE8R2ADgHjvMExpTNsSLIHiZlhfeKPBq954AMnBImS22Hp/b8oVvdmEaBP2ohM6//DqTVe3fj6XGj1F2kge9ZNvueZ1peiso3PoAEEhzY1DcF17aBsurItLp9PJUSF7Tnz0ieoeFOvhEXN4jQ7uXboV1KQUSsj5kgviPJiNkusY4QeuLXuWSLMBmywctjbWZLIhOI9CrEnk7tGHNe3dHN33lcfWjSdhLOf0/Km3o9uKT9ms/wQgCaLHQhft3wCeXD2MjAUK8kex4owLQKBzzUCGUp/iLMFtXB57p885r+WKKD6e8tRSRyez+cXcWJsMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaWcIFVbsMYQBbPHDCXmLa136deEoJaAXk56wICjuKc=;
 b=Sda2HUPLPJPrjHPX9nBicioIJ6XPFZr70o+pXsm7QPcnuWvYNtM0wqC1/4rS3NXxCz52Rut2GOM8TznNLTyAdP3HiMN+elelrB5Utxc6ZUxW908+FvPMTNluMSsXjV1qJ6+/+E8Oom25iDsMySWOaBHzIbyx/8YzGPGr1D7VQjuOnSta+sTJveA3dSpfZD7uXxs6nnvT+MDpJM8PYcncgv8mYMfWj1tNBARtTGKWE91WCJA90zuLQhU6l7yjs0pSLILIGmS/strn8d3asr9RHc0e8U4lGyeR4hTR+ZBVEWdETr2K5BsWIVnhYbaWyq29KSRNQfsi5Rt0Bh9YZFxVXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaWcIFVbsMYQBbPHDCXmLa136deEoJaAXk56wICjuKc=;
 b=Tm7gXBzevucT9t2anqQtNKm11u1AuDxCZinx6plAcJqOjm5tsALuKXJN8oZfBel9PGEYjox0o3zurNRq0UnIwQK44H9NqfZGifCbQK9Afo3lE+wj2smOmQV4Wa3h04PBrX77Xbin1QczctkNrFlrX3SalmvnQHi5R0gvmgqiCAI=
Received: from SJ0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:33a::13)
 by IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 08:08:51 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::1f) by SJ0PR03CA0008.outlook.office365.com
 (2603:10b6:a03:33a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.20 via Frontend Transport; Thu,
 30 Oct 2025 08:08:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 08:08:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 30 Oct
 2025 01:08:30 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Oct
 2025 03:08:30 -0500
Received: from [10.136.32.170] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Oct 2025 01:08:24 -0700
Message-ID: <90e556a4-59d3-4be4-b4a8-5e7ef4b523d1@amd.com>
Date: Thu, 30 Oct 2025 13:38:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 5/9] sched: Add logic to zap balance callbacks if we
 pick again
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
 <20251030001857.681432-6-jstultz@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20251030001857.681432-6-jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: d810d6ef-78fa-4dd2-7f06-08de178b8f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUZEZDE5WUUzWHZEek1wZmQ2T0FpQjN3TnplSGJ5M1BrV1JLYmYwZUI3ZE9X?=
 =?utf-8?B?cHV4MXZNVWkrWUJvT2FIc1M1QkdpTkdPcEphS0xPeDdpRVdhaXFISTVlRHJ1?=
 =?utf-8?B?SGYyeGNpbjRHOW5rM3VjZWU3K29HaHlFMWpPd25tbmlmUmpwc1U2c2FURldy?=
 =?utf-8?B?UnJIemc1aVhYVGpKYU14ZUNMMmoyczgyM1QyZXc4ZVpadHRYaXE1cmRqN2JF?=
 =?utf-8?B?K2NRdEFIR3haMXBYOE03RHZ4U1NmRWpSZk9SdktxdnFXeDNHSEVOWDdaM2Rx?=
 =?utf-8?B?WDUxWE9LUVV2d3dVblJNUEFxWDRnM0dJRWRpdkI3TTMrVGFHUTVabUVFNkZl?=
 =?utf-8?B?WkkwVzYzd3JrRnoxa3ZkVjBycDV5Sm5URXlzMnZIYXBwbHd1SU5qdFJxUjVr?=
 =?utf-8?B?Q3RYdFF4SFhrendlUnFrZ1lrRjFWeURBWEpVdC9Gcnhnakc5T005UXRGSEFL?=
 =?utf-8?B?ajQ4MDVpNEdXTXdQblhzT3pjSG9JeG1SV0t0RjgyVUgwNUtabVFzTERYOG1T?=
 =?utf-8?B?TEJQWVp5eXVJV1NkM09IT2VVSXJqRjZTd1UvbjI1eUQ1TnpSQnNSSElDWnBR?=
 =?utf-8?B?RUI3RHBjMU9vRmF1LzlBUWdsQWpRNGZlWGs1Ky9jcE80TUJRMTNTdWdSTWw5?=
 =?utf-8?B?QURHcjlhNER6VkQ2SmM0OFpsR0xySy9nVkwvS3ducTFsMHBGbktLbEpTeFZl?=
 =?utf-8?B?RlBseGZkL1dST2lFczEySndjamJQTkV2SWc0Wk1MQjQ2UUgwcW8rTlhqbnVR?=
 =?utf-8?B?bmRmd3RMSGhzWmdPNk5zM3RaVEhxQk0xaEh3K2lQbDFuMGxiR2p0dTJLT3Vm?=
 =?utf-8?B?REJxei9ZMWhQTlBRSFZlVjl6R21LUUNOcEZYd2M5N255RTdSSXNZRkE3VExT?=
 =?utf-8?B?SmpOSEZiNlZuTGFKVFp0czdPRW1leXZxTjdOWTVNVCt4SHdkVVo0Wmg2OVR3?=
 =?utf-8?B?Y2t1TE1iMnQvS2NyRFpIeGZQZ2ZHSG9lSTYyeGEybmFlOXNuU0E4a1MveC83?=
 =?utf-8?B?eHUva3NMUHk2UVdhaGl2VUNrM0xXaGswbFpydGIydjVmK3JwNHU3NWJWeURO?=
 =?utf-8?B?ZXVRR29uWUc3cU1kUzIzQmdOUTlsMHJsTC82OFFhdHJnVVh0dC9PNXV1bHVJ?=
 =?utf-8?B?YnU3TlkwbE83Wmh2cFRpRzF4MHFnd1QrcWhicllYZHpkS043SUdXZ2V0aXhN?=
 =?utf-8?B?cndYQjF2WTVuemNZNWRGZEJESlVtSzMya1VoNWtHeXlpMW1OTzRCbzhPajI3?=
 =?utf-8?B?RnZpT3BtLytjTkdBUmtBQitrUVVDM0Z3K2sxanRYUW9YVU1TV05pd2lRTHVW?=
 =?utf-8?B?U0NnQkZQYkhtQkpPMStwWnhkVUpVQ2tvMCtYMW80Kzl3NGlMSCtjdzA0Visv?=
 =?utf-8?B?Ulhyd0liZGpkRE9sNm1hMFY3bHlMa3hIWkhKcTNod3UrdXNjYkxOS1R1RzdV?=
 =?utf-8?B?dVRhTEU1dlpVMXZDbUJERUxOYWd5cGNBYVFBRXNkN3FRRWtYNzMwbnBGbHJQ?=
 =?utf-8?B?V3J2cnp1cUVIMTB5ZDhuOUVDZ0VFc2t4UW5QNDh6K1J4cWZQSjhSZHZrNWxH?=
 =?utf-8?B?dFNxdDV5T01ZYTgzTCttNFg4N2ZVNVIvSEVNaXZmZGxxbUpmZG95V1Uwc2E5?=
 =?utf-8?B?ankzNGhIemVEYzhQZmVHMFRTdmZJZmtHVEkzV0NWejhqUEJnQlQ4Mm1aaWRC?=
 =?utf-8?B?am4yQlByQVZtSDFZNVY2ZFY0ZS9iVk5ETk1PdFpScDdaOXMyc2djalFwVS9Q?=
 =?utf-8?B?SlJHMjBtaXBZeHljWU5OOTUwV1JkekNCRzVweEF1bzN1RGRJVXJYbkVWMnNs?=
 =?utf-8?B?Vjd5Mi9QcEcxaXUwbk1WVTZaTXhXTFJNNTZQUFI4R1ErMEJLSUd0TEI4eWlW?=
 =?utf-8?B?Z2hnVXZQcjM3b0dUSHU0Y1FKTEFwb1UydllmdUJiYUl3c2xjVGJTc3BDbHR5?=
 =?utf-8?B?bEtpbVNZNW82WmhCVDNOaFF3bG91cUNpNG84R2U2c0tmbG1yR3BHZmJ5emd4?=
 =?utf-8?B?dmwwdGpqUWtaaHRCZFlvSlc0Znd6UXlCSXZoTmtKK0tuRjVWNGNYTU1EZmJm?=
 =?utf-8?B?UFpmYnplTC9TWWhXQkR1QS9wdjhzWWFMUGxYQlExYUZGUWFLTzBEdGJsMGZC?=
 =?utf-8?Q?7KHc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 08:08:50.6379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d810d6ef-78fa-4dd2-7f06-08de178b8f7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011

Hello John,

On 10/30/2025 5:48 AM, John Stultz wrote:
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +/*
> + * Only called from __schedule context
> + *
> + * There are some cases where we are going to re-do the action
> + * that added the balance callbacks. We may not be in a state
> + * where we can run them, so just zap them so they can be
> + * properly re-added on the next time around. This is similar
> + * handling to running the callbacks, except we just don't call
> + * them.
> + */
> +static void zap_balance_callbacks(struct rq *rq)
> +{
> +	struct balance_callback *next, *head;
> +	bool found = false;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	head = rq->balance_callback;
> +	while (head) {
> +		if (head == &balance_push_callback)
> +			found = true;
> +		next = head->next;
> +		head->next = NULL;
> +		head = next;
> +	}
> +	rq->balance_callback = found ? &balance_push_callback : NULL;
> +}

There is nothing proxy-exec specific in this function. Do we need to
keep it behind CONFIG_SCHED_PROXY_EXEC?

I believe compiler will optimize out the dead code and having
zap_balance_callbacks() unconditionally shouldn't have make any
difference to the size of generated binary for
!CONFIG_SCHED_PROXY_EXEC case.

Apart from that nit. feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

> +#else
> +static inline void zap_balance_callbacks(struct rq *rq) {}
> +#endif
> +
>  static void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
>  {
>  	void (*func)(struct rq *rq);
> @@ -6901,10 +6933,15 @@ static void __sched notrace __schedule(int sched_mode)
>  	rq_set_donor(rq, next);
>  	if (unlikely(task_is_blocked(next))) {
>  		next = find_proxy_task(rq, next, &rf);
> -		if (!next)
> +		if (!next) {
> +			/* zap the balance_callbacks before picking again */
> +			zap_balance_callbacks(rq);
>  			goto pick_again;
> -		if (next == rq->idle)
> +		}
> +		if (next == rq->idle) {
> +			zap_balance_callbacks(rq);

Also I would have preferred to have that zap_balance_callbacks() in
proxy_resched_idle() but this is okay too.

-- 
Thanks and Regards,
Prateek

>  			goto keep_resched;
> +		}
>  	}
>  picked:
>  	clear_tsk_need_resched(prev);




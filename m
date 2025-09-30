Return-Path: <linux-kernel+bounces-837365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B094CBAC245
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146401924836
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634C82F4A06;
	Tue, 30 Sep 2025 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lezU/BG/"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011052.outbound.protection.outlook.com [40.93.194.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AA12BD034
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222710; cv=fail; b=jbnuE259qedmuBBe/mob7vfzr3zWyC2K5iZPidN0jy6HsuLcIuDiHFiRaYmflashxWymb9W/k7oRmxhh0UgKlReBigUgtv2YOTP/+cRSQ4WTeEF8+T08ayHI4eLk+0NSraA5LsFIKZBBbKaE7hyBY1tVnIpaHnjO1ntfMyyXYgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222710; c=relaxed/simple;
	bh=nXM4QSe5W73st6ijAy++AWIbAtfxRBpt1R8OQ/+zMaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bYb3gvgKJ6GKLb6lK/vixr0rG/dU93324/kYaPulbaz6ArPBhYypCwN0Zti+TPNFkv5F6OB7lU1v8TY78yXWmI223wIoN2t4tKWHBtJETfJ2R4uwt1lLiP0yMsu7quniIbRd7k6iWIN/yRZ3lrsgq/wc2STnpBacjTCkXwVGcNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lezU/BG/; arc=fail smtp.client-ip=40.93.194.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVZXXYMuQiq2mX6kqUl41FqSuNdBzrEDl9P8cGqr5f0HWdA0jmLSonkIepUHnCuq6Z6LG2DpO8bhPPadhdrKqQKH9BLITwaLC5SrecXGWody5/YYXtggIIAAF3Wc2ktcZ9VSa370MY8Pb796XPX2GdpB/77zO+7xV91ndJyproSUUvqLFd4dQ0pu7t/H514mSRdlpc9hUZBunB7vFP4vbEZ3JY7kpRX5doN+GfRsscxVL4NrwIB2q6gheXJyyKEoo5V793MW8myejJ+XmILFDxFvSNiSqpP/2Ne/6u6QDrUlAlTZMY/HXXyIpA/1O5Razgu2Mi49VSBFlHiRgn3GYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jc71GtAau20ErpurWBz8O9Q5k9f33lf99nm/KdgVhng=;
 b=sR6gevDdWYqSpZvhEEEMY3VTrdgIzfnhmceustndy3Dg9m8TudK6ekk2f39feHMVpCoUzQRB253PFvksUI9zSszo6P1CqTiQm3KccVmE7Af8qATKMh48ddILYMcZeU7CiLT21dvgn2hJuMjgbFpBjKtWde4fasThJNHSJ7oQHarM9avupsJ4VtE2Yk1TlZBPy1oULMguPZK+hoWsuCHwp5TGteACsLOt5Dah+9OrMoYdiSFs2fdaGN9gKNEaFVSnJPSn93otzVEDsBj0fAXsYS+ndySad3RVzPsz0cU+0RDVXphFNFfBLvNUc77bd1dmkonI+rBWIMXsmeRl/hdVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jc71GtAau20ErpurWBz8O9Q5k9f33lf99nm/KdgVhng=;
 b=lezU/BG/+rNLyD4kwT4VSDx8VK+Ys3L1jVL6n9yKVxK7BEkVzMdaQ2ddkp9OFuJ8S2ETL1vByMRwmYJqlJBD/oZKx9AYkkPdiw8OzmkHyzy01AGqnp8EFIbo74ZTAJrtgFB54KiBunZqC8WTpaES5MntASb1pdf1dcy3L7POuN0=
Received: from SJ0PR03CA0093.namprd03.prod.outlook.com (2603:10b6:a03:333::8)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 08:58:24 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::d1) by SJ0PR03CA0093.outlook.office365.com
 (2603:10b6:a03:333::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Tue,
 30 Sep 2025 08:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 08:58:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 30 Sep
 2025 01:58:22 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Sep
 2025 03:58:22 -0500
Received: from [10.136.33.166] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 30 Sep 2025 01:58:16 -0700
Message-ID: <658734b1-b02b-4e04-8479-ed17eb42c1f2@amd.com>
Date: Tue, 30 Sep 2025 14:28:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Prevent cfs_rq from being unthrottled with
 zero runtime_remaining
To: Aaron Lu <ziqianlu@bytedance.com>
CC: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Chengming Zhou
	<chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>, Ingo Molnar
	<mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Xi Wang
	<xii@google.com>, <linux-kernel@vger.kernel.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi Zhou
	<zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>, "Florian
 Bezdeka" <florian.bezdeka@siemens.com>, Songtang Liu
	<liusongtang@bytedance.com>, Chen Yu <yu.c.chen@intel.com>, Matteo Martelli
	<matteo.martelli@codethink.co.uk>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
	<mkoutny@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250929074645.416-1-ziqianlu@bytedance.com>
 <7c93d622-49fe-4e99-8142-aed69d48aa8a@amd.com>
 <20250930075602.GA510@bytedance>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250930075602.GA510@bytedance>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: a215df29-3e23-47ef-c7c6-08ddffff8343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnlCZXJXL0ROMVRrVEtUMDRWMkt6N2x6b3dndFhUcWx1OTI0Q2xXL3RXeWpO?=
 =?utf-8?B?WkZjRFBqR0dwU3pXUTJuVDkybkliekVyZWFTTVRqUGIzaWlhZENMcFUrN3pC?=
 =?utf-8?B?WDFPZ2x0VFdqZEZjdGh6RWliTko0NlFjNHJoRFNzdFdvbXVRQjJVS3FkZVVm?=
 =?utf-8?B?d2JOQmZGVHJ6UE1PeHRqNjBta0ltVlZNY0w3SnZ6MHpiWElHbDVlSkY4UE45?=
 =?utf-8?B?U1FUY3J4OENBUFJhcm5qYmlVeUhUZU0rTVhYcUFJZUhNS3NDazdNMXZaUzY2?=
 =?utf-8?B?UHVQM3U4RDJaMmYyM0JqTVVrek9iaHgyeGZGSWYxbkRIUTFPeGhoaEsrUXNp?=
 =?utf-8?B?K2JWQ2FneWM2NnJJOUFIUzJmanhjU08rUjNZOFZTK1E3K3Rla2h3VVBJTzB5?=
 =?utf-8?B?OTlSWFovMWpOSlFEZmQ4T0dDVFZKdUl3aE5td2dIVU11RTdPQTZJZG02NS9D?=
 =?utf-8?B?WnJidmZmc1pxTW5qSFhHUXJ6VVhZcGVnQ0tORHIxV1ZnWjQ1cnFUbjZUNFBP?=
 =?utf-8?B?WHFOWEhOWnJxYmV5eWZ6TkVPZytEdmJrbmxQK2hFZ0RrRlR5UjM2NjJDN1FN?=
 =?utf-8?B?VjRYMlFVY3hqNGZ2L29QM0lKZlZ1MkZjY29sM1Z3OGtPREl2MThwSVV0MWtS?=
 =?utf-8?B?OVYxVEpITSttQlp0OFZwVDZ5QXFJQzJycjY5TEg4SXN3WnFLUEhlRFpDdENZ?=
 =?utf-8?B?MWtaUUd0Qk9vem03a0NVQXdaZTBGYm9aU1hESXFVWnU0NHM4UGNSd3FoeHhJ?=
 =?utf-8?B?ZHZIK25hZ3BQajFTc0lsbSsyVGpFZlBkUitXNUlDS1lTbWhES3V2dG95MTZK?=
 =?utf-8?B?Y0x5bW1XeVVDTy91OGxUdzVBbUNhMjFPNGZjK3RTVDM5SzY1MzZrNTUzWUR5?=
 =?utf-8?B?TXdRV2xNZGx4MXluSlRnNnh0a1ZoT2lGajl1S2dkdjRnd3FNVXMydGljZEFh?=
 =?utf-8?B?UjVMeTRZN1NiVHNENHo5bTQxM3lNWTB3cGhTUUF4cUlhcHVhZFJpVkREZ3Jm?=
 =?utf-8?B?TVNwQ3hBMGs3SXpabVBXTElqa2xaSGZmWjc4NmZlT1RyNjhRQ3d6aXBDUUhz?=
 =?utf-8?B?N3BsM0NZS1RLZkNWTnZ0RWl1ZmhrU2lwNXhlQVVMWWNIdEpxb1pleE9ZSUg1?=
 =?utf-8?B?KzZkeGF0WWdETlJQRXRjKzY1cjJzVnprZXN0aHJ3dFBmNW5CVFo4STQzeVN6?=
 =?utf-8?B?Y1lFUUhUMVBBNXhHUVk2aEl0eHhKUllIbFVqWUYwTldvQzVUS3NaR3NWRzRw?=
 =?utf-8?B?K045dE1VWXNnSVF2ZXNmM2QrditqbEpnL3JTUVdiR2duSFdUZno5M1Y1dTY4?=
 =?utf-8?B?NlUyN0E0alNGd3NrazU2N0pGdVhMN1o2Z1ZrSGtsbDAwd0czWHFTM1lqbTRk?=
 =?utf-8?B?bEZkV0d3SGk1R2VURDdSdVRVNFc4K29XV0JScjZLZUYwaXdaekpQSHZMVjBa?=
 =?utf-8?B?WElTWmZKUll3RkVRVnBheHB2YjJ0WElrd0dOMU1yeTVUSFBaWCtxWFRyeW1Q?=
 =?utf-8?B?dGUwMTE4RERHaXhVSmRvLzZkbVMwYWVWc04vYTZ1bG1kckRUVjRvUkt0aFhS?=
 =?utf-8?B?OE5xTFdmVDZUVVR1QVdtbkdEYitpSEduRm44clYyaWQzcFJ0VXJJRW9rdGRR?=
 =?utf-8?B?bS85bGRsTi9rTmVIQndMVjV4UUR0ZzhEcVEvSWpPRXprUHhabFNnV2JHaXg0?=
 =?utf-8?B?eENOcHA2a2xRdzNNS2RYV2tIZkNLS1AwcDA5NzdNem5vVC80YXMxR3Rvc3dS?=
 =?utf-8?B?dmY1KzNaaTFuWXM4aStBeHhQYTgwVDNmN1NJUk9RbVJCd1lZWW5Yc3AyZWVu?=
 =?utf-8?B?Z3V1SEJ6YUhrTzFaeVRONFVjaG4rd0dkWmxIS2Jtc2Uwc3c2ZmFOSm13Mldu?=
 =?utf-8?B?REs0OCtxMDNyYW1obnFJWjhLWEpXSHZNWEY1d0Nhb09XaW9PU01NWkRkYm5J?=
 =?utf-8?B?cityOU9JZlE0dTE0UkFFeTdZNDRrbGVJMlBsK082ZjM3amJJVzNRdFVnUVFK?=
 =?utf-8?B?VVJaUCtuUjVvYW9BOUtVMTRDOUo4Nk1LRjV2SElmZ1RTb3hKSUhxaU5uV2NR?=
 =?utf-8?B?QUpkUnFTMkVYT3RqUytsUDdIVmxCaEF1a0J1NFRNRTY4WlYvSzR3TkVxKzdF?=
 =?utf-8?Q?5hUc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 08:58:23.9109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a215df29-3e23-47ef-c7c6-08ddffff8343
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282

Hello Aaron,

On 9/30/2025 1:26 PM, Aaron Lu wrote:
> On Mon, Sep 29, 2025 at 03:04:03PM +0530, K Prateek Nayak wrote:
> ... ...
>> Can we instead do a check_enqueue_throttle() in enqueue_throttled_task()
>> if we find cfs_rq->throttled_limbo_list to be empty?
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 18a30ae35441..fd2d4dad9c27 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5872,6 +5872,8 @@ static bool enqueue_throttled_task(struct task_struct *p)
>>  	 */
>>  	if (throttled_hierarchy(cfs_rq) &&
>>  	    !task_current_donor(rq_of(cfs_rq), p)) {
>                 /*
>                  * Make sure to throttle this cfs_rq or it can be unthrottled
>                  * with no runtime_remaining and gets throttled again on its
>                  * unthrottle path.
>                  */
>> +		if (list_empty(&cfs_rq->throttled_limbo_list))
>> +			check_enqueue_throttle(cfs_rq);
> 
> BTW, do you think a comment is needed? Something like the above, not
> sure if it's too redundant though, feel free to let me know your
> thoughts, thanks.

Now that I'm looking at it again, I think we should actually do a:

    for_each_entity(se)
        check_enqueue_throttle(cfs_rq_of(se));

The reason being, we can have:

    root -> A (throttled) -> B -> C

Consider B has runtime_remaining = 0, and subsequently a throttled task
is queued onto C. Ideally, we should start the B/W timer for B at that
point but we bail out after queuing it on C. Thoughts?

Since we only catch up to the 0 runtime_remaining point, it should be
fine.

The comment can perhaps be something like:

	/*
	 * If this is the first enqueue on throttled hierarchy,
	 * ensure bandwidth is available when the hierarchy is
	 * unthrottled. check_enqueue_throttle() will ensure
	 * either some bandwidth is available, or will throttle
	 * the cfs_rq and queue the bandwidth timer.
	 */

> 
>>  		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
>>  		return true;
>>  	}
>> ---

-- 
Thanks and Regards,
Prateek



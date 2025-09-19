Return-Path: <linux-kernel+bounces-823950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCF4B87CCA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC56581081
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25A923C4E9;
	Fri, 19 Sep 2025 03:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t1Syt1eY"
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011014.outbound.protection.outlook.com [52.101.57.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4000C34BA2B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758252484; cv=fail; b=a4KMHNetQhnSgSA1JQdbv78xaw9t4H8pQ/u0quWfTLsm3StX0gEUdftLLHnD5JbwW+NhmZfx96IXjJCKOiAHolI4ntxJQ/S2Cf/dgVPsCS4BTk6zonaxKaliBD3/4OhoejSrihawuiTuJuIHleam3gV/6vPllllMiGl0LynHQdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758252484; c=relaxed/simple;
	bh=a2XPxvQ77y3PqIdrcaQsUj0KFOVQh0GfH7CpbmcUWRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GBPZTKr/XY15mIxcmflEaGG9KxocDjk5Ysvg2R2zu5WX3Ofc9cZcYI76zv/QcmY3hLWD98FCKIknwfDIWRviS8DJFrguN0n34U7MAJAJPdXXmFJGRqVw4k5xzIV3FTm6/THJP0CnE+u4hYQAXYCZb0pqX9JvOA/qfrnBtgmo0kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t1Syt1eY; arc=fail smtp.client-ip=52.101.57.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMDnHdC46gC351Ek+kJarbtj0Y9DNLRwQnJaPne3x9Ut3+02RMtsl8/0MsjjYEpPSY5dEvjhtFozLh9LOnb6BpuaJSJHNQyumyfx+pR0/mN4n1ZcW9YNFp5w5YbluzhmPlJ9vmGCNtXQqB2Wj1V+7jNyLtHCY187YioOjBeo5vq+J9nsa6aU+ZIRhTQCfjfcME8NwtE0eOxC6M0bQR4YDveURi5x4pm+UmR4I4XU8ugvcDB5a8Rq+0LL/KMMf9N/NZVHAj2ma1wc98dwV8mT1uKgxhAEDqBrQEccYMMbReESq58MNAWcRON7C20A0GyWuLw6OhfqYZh17qQpls8zpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buNV8W18lN60wQ1q9CFxNPNtuWwwXN0l4wmZFFAT1Dk=;
 b=VJApjZDa/K223r/nfEvsNBRNqDDlqqjbuWgV8LY5SGk4Tk709tyZtfUZQyt46wB4ccr4veP3wDA+L7j5l1DYRxiwMqnaFRNn7OAtbLG3MpdSoDvlAe18D9NJ5EMBWtzpayPyYJ/0YHZUeH5wohpBgNGNN+76zG8cnhTR5tKYBvTGbW4Z/mOdAhR4MGnXhcgJM3Ux+rGqgWJYtq1n4IPwl12oY3s8d1xJIZYu/3m6oM5NBo8afiRhxPtQxfDfmQVQ8gsR00uAJYnGMoSGzrEo3N7JrnR+oIxgA8xoHsB487bUxit3GHbv/g/Ojy+iR6HSTLcLByUKkA0vowcFi1pwOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buNV8W18lN60wQ1q9CFxNPNtuWwwXN0l4wmZFFAT1Dk=;
 b=t1Syt1eY6hlfZueGLJcQ5zwm+cHpHyt6Gf1kCvK5f6isOwvHaU1URy7FQRbhD21q9CoPo94B6/JMmrv3/fTPOwJQ0OURhrxJOZTpwX6Y59VeK83IsXw1dam4peHOoKvkez66SjmJ1IGXb3j+hwFgTlmtoXX64U/S1JqtZAbjN7I=
Received: from MN0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:208:52d::7)
 by LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 03:27:56 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::1b) by MN0PR04CA0011.outlook.office365.com
 (2603:10b6:208:52d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.16 via Frontend Transport; Fri,
 19 Sep 2025 03:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 03:27:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 20:27:56 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 20:27:56 -0700
Received: from [10.136.41.20] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 18 Sep 2025 20:27:49 -0700
Message-ID: <d70e7e50-d5c3-4689-b91f-9dce0f1a0424@amd.com>
Date: Fri, 19 Sep 2025 08:57:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v21 2/6] sched/locking: Add blocked_on_state to
 provide necessary tri-state for proxy return-migration
To: John Stultz <jstultz@google.com>
CC: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes
	<joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
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
References: <20250904002201.971268-1-jstultz@google.com>
 <20250904002201.971268-3-jstultz@google.com>
 <337322ea-6efe-4814-a813-e55d4c80fda7@amd.com>
 <CANDhNCpmQLF_03t3PMEtjBU_tpL10FJ_iL=x3zMG+Bs0PEFESw@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANDhNCpmQLF_03t3PMEtjBU_tpL10FJ_iL=x3zMG+Bs0PEFESw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|LV3PR12MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: 495c46e3-8f3f-4c06-c992-08ddf72c86b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|30052699003|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEFGbmp0bkVQZDBLS3JxUnpHeGIreTVSVlFlcjVyMmdIRkttQWxkY0Zna3hk?=
 =?utf-8?B?M0R1ZHFuT3Q2SFh3dkJIMmN6dWhMS3R2ZzB6NnBOSXg3WEIvSmdaVkdoTEs0?=
 =?utf-8?B?c1orZWZYWStHSVhmSU9pWGdvMm1WTy92MHF3SzMxSisxVDRxdDJlVWg1N2Zu?=
 =?utf-8?B?Ulo4N0NJNTBaeHBTTVZUNTdXb0hCcGMzNXNvc3FUc1VBQTY3cFNLUTlCTHBS?=
 =?utf-8?B?a0prak9sMS9ocVF5dDFhMEEyNmsxV1ArSlE1SU9kV1Nkdkg3aTQxNmNuRUxN?=
 =?utf-8?B?VERIY29oMlBGTnFvWlZsTkVpbUJpREQ4MWI1Z2RnSVh3cFprK2c0Y0pqV291?=
 =?utf-8?B?VUpmNmVzem1RSDZTTFg5TjRTZ0E1NjNmZzdRRlo4M0haM3U1Yk5KWG1vbXVY?=
 =?utf-8?B?WXVVUDJpSERSNldLeXpJQk5RMSszSjkyQmpsZkNpTjkzZmlOVy9vVDRmK3lD?=
 =?utf-8?B?Ui9MYzJLd0ovVFR3bDF4aEFxSnhhbkhUaXFSS0VxVFNBNTNvd04zMWVvUWRa?=
 =?utf-8?B?UGkxdVZPQ3VjQ3NMRXJVdW91ajVQbGRjUi9QMGQ2aGZxS1BBZ2hnMlpDeFZX?=
 =?utf-8?B?MUpiaThvTE5Yd2ZqMWcxUVYrWnFLalNIckZDMXB5Z21GeUV6bDg0b3BVL1J5?=
 =?utf-8?B?T0xZdjhnYTk4OVZEOCtiZjZEdzd4VUR3elV1R3gra2FKQ2l4SStMb3NIdXJW?=
 =?utf-8?B?UWdNOCtnaE9xSG1LbjZYMFMzMCtubUUrdVlsSU9odVNFQWxTRGlvTUVXZzZO?=
 =?utf-8?B?MVZweWFuckhtVUNEVCtQTkV5RDZoZ1JRLzFuTGg3SjhqUWpESy9Cc0ViNzRJ?=
 =?utf-8?B?S08vVFlSZ1FERTNJZFNWMEszYXFUTzg0elcrV0NET3BKL0t6RVRxY1dzOTEx?=
 =?utf-8?B?TDV4Y1BnNzg2S29ESDlXZUpUNnR6TzU3SXZOejBJQmVqYy9ETG1DcU5RaThO?=
 =?utf-8?B?NnlvYmxNTDZ3eCsvNEdFQ3RwQytQZnVwdE1tUWk2VVU1Y3A5NWpUbnhpNzQy?=
 =?utf-8?B?SUhnenh0YlJSb0Npbk9DcStQUVIwZjN2clAwTWk0VGpFVjBaTWRTNmlPdHp1?=
 =?utf-8?B?WkdJUkhITlEvZFljRmd4dVpXNmZsUUZFcjFvK01Bakg3WDMzakpsSHdHN0t4?=
 =?utf-8?B?QitQNXFsS3ZJMjVuYjZBbEw3V0ZUYWJ1NzI4RHU0anBrWGI3a1Z6aG1ld1cw?=
 =?utf-8?B?Q1YwVEtmZmkwNFVVL1A1Rm4rS1lpS0JrN3VJNXl4SU1pOXphVHNjS0JmSjJz?=
 =?utf-8?B?eldya1djcndTOFY1TFFHSlF1dEplNDZlNGl1WnpsQzR1RzM4WEpXVk51QmQ2?=
 =?utf-8?B?bzg1ZE54NnVlUEo3ZEYxRDZIcGJiMktHNUhWZlRvTDNPYm56OUMyTGxqTTg5?=
 =?utf-8?B?NjkwQXRwcDZHTGJuaHpqeldPbjRVUmFEbTU3YVR4dEZaUmZxNHF5cGNwbDVU?=
 =?utf-8?B?TC83V25WRUVtQWVKTk1ZYjlwaWEwdlNSZ2htM2llWW4vakduMnlOS1Fzbi9O?=
 =?utf-8?B?RTcySlAwd3ZGV0JnTXExcmQvM1Z3YVovTmdIdTN3NUZHN1dRQmVZeHpmdmQr?=
 =?utf-8?B?Z1h6Qk9XQ2cxclJ4MGlCVGU1cTc0WDVCUVdsamk4c1R1OVEwUFdJdzgwbDRW?=
 =?utf-8?B?Ry9vV2Y5WlhpbHgyd0tjL0pMWmVMT1JTNDMyNVBrWHBjcUYyV2wrSXVKdzIy?=
 =?utf-8?B?QTc2TDExWjJMRFRQU2pmV1hkK1NLTWhJUDgxS0Y3clhzUFd4Ky91Q2l2SVlo?=
 =?utf-8?B?S3J3cEd4d0JXQldhbjU1VUk2VVBNYVdlekh6cUE2NVduWXJXa1Fsb3FRS3k2?=
 =?utf-8?B?djdDSG4yTmJ0c2o4Z3NIS2tlcjNWbmMwbUNnYjE5WVlvY2hxZ1pWdHd2RHFX?=
 =?utf-8?B?REVRL2p3R0djYzFNQ1hNNkZ2OEgzQkxvY29rV2cxWXI2QzBzWGM5N3kxbGhL?=
 =?utf-8?B?b1ZHVS9TdnVQZDNQMUhuSVFiNzVxcWZNdWFaZGNCdUU4UENvdHVzNG96MW41?=
 =?utf-8?B?UnZaNDZNV2QzY0VucVIyMWNMRHNyRHVWSTY4SXgwdStpQmRZVHhmSW1pVG90?=
 =?utf-8?Q?/4pU9M?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(30052699003)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 03:27:56.6998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 495c46e3-8f3f-4c06-c992-08ddf72c86b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439

Hello John,

On 9/19/2025 4:27 AM, John Stultz wrote:
>> Of the three {set,clear}_task_blcoked_on() usage:
>>
>>     $ grep -r "\(set\|clear\)_task_blocked_on" include/
>>     kernel/locking/mutex.c: __set_task_blocked_on(current, lock);
>>     kernel/locking/mutex.c: __clear_task_blocked_on(current, lock);
>>     kernel/locking/mutex.c: clear_task_blocked_on(current, lock);
>>
>> two can be converted directly and perhaps clear_task_blocked_on() can be
>> renamed as clear_task_blocked_on_set_runnable()?
>>
>> This is just me rambling on so feel free to ignore. I probably have to
>> train my mind enough to see __clear_task_blocked_on() not only clears
>> "blocked_on" but also sets task to runnable :)
> 
> Yeah, the case where we don't already hold the lock and want to do
> both gets more complex in that case.
> 
> Hrm. Maybe just the way the functions are organized in the header make
> it seem like we're managing two separate bits of state, where really
> they are ordered.
> I'll try to re-arrange that introducing the
> set_task_blocked_on/clear_task_blocked_on first, then the transition
> set_blocked_on_<state>() helpers after?
> Maybe that and  some comments will make that clearer?

Again that was me rambling. Even a small comment above
clear_task_blocked_on() would also be sufficient if the whole rework
turns out to be more extensive. 

> 
>>> @@ -6749,6 +6776,15 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
>>>
>>>       WARN_ON_ONCE(owner && !owner->on_rq);
>>>       return owner;
>>> +
>>> +     /*
>>> +      * NOTE: This logic is down here, because we need to call
>>> +      * the functions with the mutex wait_lock and task
>>> +      * blocked_lock released, so we have to get out of the
>>> +      * guard() scope.
>>> +      */
>>
>> I didn't know that was possible! Neat. Since cleanup.h has a note
>> reading:
>>
>>     ... the expectation is that usage of "goto" and cleanup helpers is
>>     never mixed in the same function.
>>
>> are there any concerns w.r.t. compiler versions etc. or am I just being
>> paranoid?
> 
> Hrrrrmmmm.  I hadn't seen that detail. :/   I guess I was just lucky
> it worked with my toolchain.

I have been too. Maybe it is okay to use a goto if folks know what
they are doing ¯\_(ツ)_/¯

Another idea is to have:

    bool deactivate_donor = false;

    for (p = donor; task_is_blocked(p); p = owner) {
        guard(raw_spinlock)(...);
        ...
        if (<condition> {
            deactivate_donor = true;
            break;
        }
        ...
    }
    if (deactivate_donor)
        return proxy_deactivate(rq, donor);

Can that work?

> 
> Oof. That may require reworking all this logic back to explicit
> lock/unlock calls, away from the guard() usage.
> 
> Let me think on if there's a better way.
> 
> Thanks so much again for pointing this out!
> -john

-- 
Thanks and Regards,
Prateek



Return-Path: <linux-kernel+bounces-877463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 785E6C1E2B2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5A0188A3A1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF9B32C93B;
	Thu, 30 Oct 2025 02:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="07btWpbi"
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC112F3C2C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761793006; cv=none; b=dPECrfUzWq82mbanpZOWeC3R1Qf7MNsk2YRkJbLXuGMERzWxogG6Ye61ulUGDBe19BFnyYP2bB/nvUfkUFGyTvK4z71rf+Z1BJ2Ic4QSBQf2MgrmlZT/3EPWpNpJpsADNlZDjNmKsz54ShUOlhpGSK4VPYe/qLoi5XNbQhdJbPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761793006; c=relaxed/simple;
	bh=quWH6eCcrNC5UfTsSZ1/it88qcWGG9o4SZYqIH746zs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aARIZ7Btx8DQ/LWMkRfzZ1vAz2EKZmrgsy5wSZawwcvmoc7rf2krJMxYog8R9715QznjCAhCrS75Jse42aeTzMSHJurgCJ+1c4ijowSkaMpsC+blKSfYwfM6ssgaWGcVXxI+tpHq90f5Sv9lOWfGRbHlan7MzjhgY0uoUQEwe/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=07btWpbi; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0hQRTMFxdEmNDfeGmLa4tp3RC8FcGsqNeLnBB5VEq1c=;
	b=07btWpbiNwohyHweI9wu3LKC7j9YqX14x1hnrhD1+fM4hQbECyJblJChg2G+DUQNOyPl1NO3a
	+DhOrhcz9tOc0Af9ZY00AzcrDkVyplF1moRr/Up7Q8V067Tm13Y46+fC4fJqzhQd2YwVuikRMv3
	FRrgWfU7FV8AfF/YLPrIiao=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cxpd00sztzcZyk;
	Thu, 30 Oct 2025 10:55:16 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 5014F1400CA;
	Thu, 30 Oct 2025 10:56:41 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Oct 2025 10:56:41 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Oct 2025 10:56:40 +0800
Subject: Re: [PATCH v2 1/1] mm/ksm: recover from memory failure on KSM page by
 migrating to healthy duplicate
To: Long long Xia <xialonglong2025@163.com>
CC: <markus.elfring@web.de>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <wangkefeng.wang@huawei.com>,
	<qiuxu.zhuo@intel.com>, <xu.xin16@zte.com.cn>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Longlong Xia
	<xialonglong@kylinos.cn>, <david@redhat.com>, <lance.yang@linux.dev>
References: <20251016101813.484565-1-xialonglong2025@163.com>
 <20251016101813.484565-2-xialonglong2025@163.com>
 <af769443-e855-81d0-a44a-d5890f5d1d2f@huawei.com>
 <7c069611-21e1-40df-bdb1-a3144c54507e@163.com>
 <db70f612-bbb1-0f9a-3dd6-884b1d64ab61@huawei.com>
 <394cb428-c37b-44c7-8367-4f76514a6322@163.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <64953691-ce0e-71d9-1ab3-7f8cefd6ace4@huawei.com>
Date: Thu, 30 Oct 2025 10:56:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <394cb428-c37b-44c7-8367-4f76514a6322@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/10/29 15:12, Long long Xia wrote:
> Thanks for the reply.
> 
> 
> 在 2025/10/29 14:40, Miaohe Lin 写道:
>> On 2025/10/28 15:54, Long long Xia wrote:
>>> Thanks for the reply.
>>>
>>> 在 2025/10/23 19:54, Miaohe Lin 写道:
>>>> On 2025/10/16 18:18, Longlong Xia wrote:
>>>>> From: Longlong Xia <xialonglong@kylinos.cn>
>>>>>
>>>>> When a hardware memory error occurs on a KSM page, the current
>>>>> behavior is to kill all processes mapping that page. This can
>>>>> be overly aggressive when KSM has multiple duplicate pages in
>>>>> a chain where other duplicates are still healthy.
>>>>>
>>>>> This patch introduces a recovery mechanism that attempts to
>>>>> migrate mappings from the failing KSM page to a newly
>>>>> allocated KSM page or another healthy duplicate already
>>>>> present in the same chain, before falling back to the
>>>>> process-killing procedure.
>>>>>
>>>>> The recovery process works as follows:
>>>>> 1. Identify if the failing KSM page belongs to a stable node chain.
>>>>> 2. Locate a healthy duplicate KSM page within the same chain.
>>>>> 3. For each process mapping the failing page:
>>>>>      a. Attempt to allocate a new KSM page copy from healthy duplicate
>>>>>         KSM page. If successful, migrate the mapping to this new KSM page.
>>>>>      b. If allocation fails, migrate the mapping to the existing healthy
>>>>>         duplicate KSM page.
>>>>> 4. If all migrations succeed, remove the failing KSM page from the chain.
>>>>> 5. Only if recovery fails (e.g., no healthy duplicate found or migration
>>>>>      error) does the kernel fall back to killing the affected processes.
>>>>>
>>>>> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
>>>> Thanks for your patch. Some comments below.
>>>>
>>>>> ---
>>>>>    mm/ksm.c | 246 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>    1 file changed, 246 insertions(+)
>>>>>
>>>>> diff --git a/mm/ksm.c b/mm/ksm.c
>>>>> index 160787bb121c..9099bad1ab35 100644
>>>>> --- a/mm/ksm.c
>>>>> +++ b/mm/ksm.c
>>>>> @@ -3084,6 +3084,246 @@ void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc)
>>>>>    }
>>>>>      #ifdef CONFIG_MEMORY_FAILURE
>>>>> +static struct ksm_stable_node *find_chain_head(struct ksm_stable_node *dup_node)
>>>>> +{
>>>>> +    struct ksm_stable_node *stable_node, *dup;
>>>>> +    struct rb_node *node;
>>>>> +    int nid;
>>>>> +
>>>>> +    if (!is_stable_node_dup(dup_node))
>>>>> +        return NULL;
>>>>> +
>>>>> +    for (nid = 0; nid < ksm_nr_node_ids; nid++) {
>>>>> +        node = rb_first(root_stable_tree + nid);
>>>>> +        for (; node; node = rb_next(node)) {
>>>>> +            stable_node = rb_entry(node,
>>>>> +                    struct ksm_stable_node,
>>>>> +                    node);
>>>>> +
>>>>> +            if (!is_stable_node_chain(stable_node))
>>>>> +                continue;
>>>>> +
>>>>> +            hlist_for_each_entry(dup, &stable_node->hlist,
>>>>> +                    hlist_dup) {
>>>>> +                if (dup == dup_node)
>>>>> +                    return stable_node;
>>>>> +            }
> may I add cond_resched(); here ？
>>>>> +        }
>>>>> +    }
>>>> Would above multiple loops take a long time in some corner cases?
>>> Thanks for the concern.
>>>
>>> I do some simple test。
>>>
>>> Test 1: 10 Virtual Machines (Real-world Scenario)
>>> Environment: 10 VMs (256MB each) with KSM enabled
>>>
>>> KSM State:
>>> pages_sharing: 262,802 (≈1GB)
>>> pages_shared: 17,374 （≈68MB）
>>> pages_unshared = 124,057 (≈485MB)
>>> total ≈1.5GB
>>> chain_count = 9, not_chain_count = 17152
>>> Red-black tree nodes to traverse:
>>> 17,161 (9 chains + 17,152 non-chains)
>>>
>>> Performance:
>>> find_chain: 898 μs (0.9 ms)
>>> collect_procs_ksm: 4,409 μs (4.4 ms)
>>> Total memory failure handling: 6,135 μs (6.1 ms)
>>>
>>>
>>> Test 2: 10GB Single Process (Extreme Case)
>>> Environment: Single process with 10GB memory,
>>> 1,310,720 page pairs (each pair identical, different from others)
>>>
>>> KSM State:
>>> pages_sharing: 1,311,740 （≈5GB)
>>> pages_shared: 1,310,724 （≈5GB)
>>> pages_unshared = 0
>>> total ≈10GB
>>> Red-black tree nodes to traverse:
>>> 1,310,721 (1 chain + 1,310,720 non-chains)
>>>
>>> Performance:
>>> find_chain: 28,822 μs (28.8 ms)
>>> collect_procs_ksm: 45,944 μs (45.9 ms)
>>> Total memory failure handling: 46,594 μs (46.6 ms)
>> Thanks for your test.
>>
>>> Summary:
>>> The find_chain function shows approximately linear scaling with the number of red-black tree nodes.
>>> With a 76x increase in nodes (17,161 → 1,310,721), latency increased by 32x (898 μs → 28,822 μs).
>>> representing 62% of total memory failure handling time (46.6ms).
>>> However, since memory failures are rare events, this latency may be acceptable
>>> as it does not impact normal system performance and only affects error recovery paths.
>>>
>> IMHO, the execution time of a kernel function must not be too long without any scheduling points.
>> Otherwise it may affect the normal scheduling of the system and leads to something like performance
>> fluctuation. Or am I miss something?
>>
>> Thanks.
>> .
> 
> I will add cond_resched()in the loop of red-black tree to allow scheduling in find_chain(), may be it is enough?

It looks work to me.

Thanks.
.


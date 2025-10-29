Return-Path: <linux-kernel+bounces-875324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E71C18B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C271CC0245
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747182E975A;
	Wed, 29 Oct 2025 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XGOPVyJ+"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D211A221FBB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722675; cv=none; b=GvACFYbiB6piVcxDZLT08lnRjnW7hlKycKdUXekBRklswBZlAaCI+J3xkIm4yI3Wg65GO/Y80NCJzL3nSOD2Ke78uwRlUZmrEUyHRb/f692asZiEN+zQud1oIAc59ukOy85LtWOiKzf98D+tN8Z5vEkp8m9HCd9j8WLkevPXX2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722675; c=relaxed/simple;
	bh=ja7tX5bo9QGoOCMXr+MM4boa1fjKFVLZPulid/HgpR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvV9XEFv1ajFWf0ePeZbpuon7ZgpCAPrO6D3VONEF74VdWCshOixfjPVFyX60jIxruMqhl750wnDhDzEQcJC3VKi7SgcnrbHJCfVNf7sNP6HzLqWdlJ8H1N/pPUJRZMAJQltMzQ4RB9fZFGJcsnqxYxNHt/5bHfaq0gzabVPFQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XGOPVyJ+; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=ylyZdhTdDFBEfzFVzWFW5oVHoSQafpEzmCbLwEsvc80=;
	b=XGOPVyJ+6hI3WFdjUEo1vmSyGCLYDUOC3RwZvBiB99Y26hBP8mv4Jrl7UCAg4T
	xb77PF5twHA/DYl54XCrj5+LkzMsncjlE8yBkxrM7ql/7K/FfvD8XmrQ9mpUZXNU
	Ok6wwAFOWGo0/ZDYdtpWdq1Fgc66HF/I+9WrWjdmRMnwM=
Received: from [IPV6:240e:46c:1010:504f:3180:9bac:32c0:30b] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAndmltvgFplf2dAA--.107S2;
	Wed, 29 Oct 2025 15:13:05 +0800 (CST)
Message-ID: <394cb428-c37b-44c7-8367-4f76514a6322@163.com>
Date: Wed, 29 Oct 2025 15:12:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/ksm: recover from memory failure on KSM page by
 migrating to healthy duplicate
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: markus.elfring@web.de, nao.horiguchi@gmail.com,
 akpm@linux-foundation.org, wangkefeng.wang@huawei.com, qiuxu.zhuo@intel.com,
 xu.xin16@zte.com.cn, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Longlong Xia <xialonglong@kylinos.cn>, david@redhat.com, lance.yang@linux.dev
References: <20251016101813.484565-1-xialonglong2025@163.com>
 <20251016101813.484565-2-xialonglong2025@163.com>
 <af769443-e855-81d0-a44a-d5890f5d1d2f@huawei.com>
 <7c069611-21e1-40df-bdb1-a3144c54507e@163.com>
 <db70f612-bbb1-0f9a-3dd6-884b1d64ab61@huawei.com>
From: Long long Xia <xialonglong2025@163.com>
In-Reply-To: <db70f612-bbb1-0f9a-3dd6-884b1d64ab61@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAndmltvgFplf2dAA--.107S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw47Gw4kZF1rXrWfCw43GFg_yoW7JFW7pF
	y8Aa43Kr4rXFyfGr1Sqw4jyrySv3yktr4UXrWakw1xA3Z0yr97tr4Fgw1YgFy8ur4rGw4Y
	qF4Ygry3GrsYqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jxl1kUUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbBgAH1+GkBtkvUbQAAsg

Thanks for the reply.


在 2025/10/29 14:40, Miaohe Lin 写道:
> On 2025/10/28 15:54, Long long Xia wrote:
>> Thanks for the reply.
>>
>> 在 2025/10/23 19:54, Miaohe Lin 写道:
>>> On 2025/10/16 18:18, Longlong Xia wrote:
>>>> From: Longlong Xia <xialonglong@kylinos.cn>
>>>>
>>>> When a hardware memory error occurs on a KSM page, the current
>>>> behavior is to kill all processes mapping that page. This can
>>>> be overly aggressive when KSM has multiple duplicate pages in
>>>> a chain where other duplicates are still healthy.
>>>>
>>>> This patch introduces a recovery mechanism that attempts to
>>>> migrate mappings from the failing KSM page to a newly
>>>> allocated KSM page or another healthy duplicate already
>>>> present in the same chain, before falling back to the
>>>> process-killing procedure.
>>>>
>>>> The recovery process works as follows:
>>>> 1. Identify if the failing KSM page belongs to a stable node chain.
>>>> 2. Locate a healthy duplicate KSM page within the same chain.
>>>> 3. For each process mapping the failing page:
>>>>      a. Attempt to allocate a new KSM page copy from healthy duplicate
>>>>         KSM page. If successful, migrate the mapping to this new KSM page.
>>>>      b. If allocation fails, migrate the mapping to the existing healthy
>>>>         duplicate KSM page.
>>>> 4. If all migrations succeed, remove the failing KSM page from the chain.
>>>> 5. Only if recovery fails (e.g., no healthy duplicate found or migration
>>>>      error) does the kernel fall back to killing the affected processes.
>>>>
>>>> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
>>> Thanks for your patch. Some comments below.
>>>
>>>> ---
>>>>    mm/ksm.c | 246 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 246 insertions(+)
>>>>
>>>> diff --git a/mm/ksm.c b/mm/ksm.c
>>>> index 160787bb121c..9099bad1ab35 100644
>>>> --- a/mm/ksm.c
>>>> +++ b/mm/ksm.c
>>>> @@ -3084,6 +3084,246 @@ void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc)
>>>>    }
>>>>      #ifdef CONFIG_MEMORY_FAILURE
>>>> +static struct ksm_stable_node *find_chain_head(struct ksm_stable_node *dup_node)
>>>> +{
>>>> +    struct ksm_stable_node *stable_node, *dup;
>>>> +    struct rb_node *node;
>>>> +    int nid;
>>>> +
>>>> +    if (!is_stable_node_dup(dup_node))
>>>> +        return NULL;
>>>> +
>>>> +    for (nid = 0; nid < ksm_nr_node_ids; nid++) {
>>>> +        node = rb_first(root_stable_tree + nid);
>>>> +        for (; node; node = rb_next(node)) {
>>>> +            stable_node = rb_entry(node,
>>>> +                    struct ksm_stable_node,
>>>> +                    node);
>>>> +
>>>> +            if (!is_stable_node_chain(stable_node))
>>>> +                continue;
>>>> +
>>>> +            hlist_for_each_entry(dup, &stable_node->hlist,
>>>> +                    hlist_dup) {
>>>> +                if (dup == dup_node)
>>>> +                    return stable_node;
>>>> +            }
may I add cond_resched(); here ？
>>>> +        }
>>>> +    }
>>> Would above multiple loops take a long time in some corner cases?
>> Thanks for the concern.
>>
>> I do some simple test。
>>
>> Test 1: 10 Virtual Machines (Real-world Scenario)
>> Environment: 10 VMs (256MB each) with KSM enabled
>>
>> KSM State:
>> pages_sharing: 262,802 (≈1GB)
>> pages_shared: 17,374 （≈68MB）
>> pages_unshared = 124,057 (≈485MB)
>> total ≈1.5GB
>> chain_count = 9, not_chain_count = 17152
>> Red-black tree nodes to traverse:
>> 17,161 (9 chains + 17,152 non-chains)
>>
>> Performance:
>> find_chain: 898 μs (0.9 ms)
>> collect_procs_ksm: 4,409 μs (4.4 ms)
>> Total memory failure handling: 6,135 μs (6.1 ms)
>>
>>
>> Test 2: 10GB Single Process (Extreme Case)
>> Environment: Single process with 10GB memory,
>> 1,310,720 page pairs (each pair identical, different from others)
>>
>> KSM State:
>> pages_sharing: 1,311,740 （≈5GB)
>> pages_shared: 1,310,724 （≈5GB)
>> pages_unshared = 0
>> total ≈10GB
>> Red-black tree nodes to traverse:
>> 1,310,721 (1 chain + 1,310,720 non-chains)
>>
>> Performance:
>> find_chain: 28,822 μs (28.8 ms)
>> collect_procs_ksm: 45,944 μs (45.9 ms)
>> Total memory failure handling: 46,594 μs (46.6 ms)
> Thanks for your test.
>
>> Summary:
>> The find_chain function shows approximately linear scaling with the number of red-black tree nodes.
>> With a 76x increase in nodes (17,161 → 1,310,721), latency increased by 32x (898 μs → 28,822 μs).
>> representing 62% of total memory failure handling time (46.6ms).
>> However, since memory failures are rare events, this latency may be acceptable
>> as it does not impact normal system performance and only affects error recovery paths.
>>
> IMHO, the execution time of a kernel function must not be too long without any scheduling points.
> Otherwise it may affect the normal scheduling of the system and leads to something like performance
> fluctuation. Or am I miss something?
>
> Thanks.
> .

I will add cond_resched()in the loop of red-black tree to allow 
scheduling in find_chain(), may be it is enough?

Best regards,
Longlong Xia



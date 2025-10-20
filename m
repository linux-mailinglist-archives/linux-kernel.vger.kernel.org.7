Return-Path: <linux-kernel+bounces-860389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9A3BF005E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 258E3343C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991152EC09E;
	Mon, 20 Oct 2025 08:48:05 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413282EA753
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950085; cv=none; b=hiwytdIxL5yHlyYEbIgFP8xnisGrP1VFkGWV7v8avsBqf4IBS7cXiZMJesTsGSY+Pxck5s8b2Uxoc18DoHRpUa3+jOXrdsbj4gtvNvowlZNIMtISzBt8cL2fIj0F1RWKLwFaZtzq7+KI06abqS2ZBSzzVVdpTjdv6Zgi69xJrvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950085; c=relaxed/simple;
	bh=iEWGXhpIxfdSoqIYEw2v0vshCuQiHWO1KEg6aGbk+a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6qEp4xk4vX5g1GRs7FTgpJkyq6aaytAix2Ki4ZRCY/MKULA6pOqUwfoo/HW718a5yy8nQQ87QYOuQgrjf22n0nIMjWvnc6LtbIeA2TyNQMQNVHQr+v1ELWN2/QAbXo61p7x+uCTaaEY8JItHfC/gTpGcmZMmR0XTdX7zng+ToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cqpvk00gJzKHMPc;
	Mon, 20 Oct 2025 16:47:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B25F71A0DCF;
	Mon, 20 Oct 2025 16:47:58 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgDnLeI+9_VoBEDkAw--.1377S2;
	Mon, 20 Oct 2025 16:47:58 +0800 (CST)
Message-ID: <f8fade06-bd24-4a73-9fcb-2530c1aac30a@huaweicloud.com>
Date: Mon, 20 Oct 2025 16:47:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 13/16] cpuset: use partition_disable for
 compute_partition_effective_cpumask
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-14-chenridong@huaweicloud.com>
 <21d14cb8-3c8f-45cd-abdd-961271d537da@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <21d14cb8-3c8f-45cd-abdd-961271d537da@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDnLeI+9_VoBEDkAw--.1377S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4rGFy8uFW5Zr4DAw1xuFg_yoWrGryxpF
	1kJrW7JrWUJw1rC34UJF1UXryUGr1DJ3WDtr18XF18JF17Ar1qqF1jv34vgr1UJrW8Jr1U
	JF1jqr17ZF47ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUotCzDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/10/20 11:02, Waiman Long wrote:
> 
> On 9/28/25 3:13 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Replace the partition invalidation logic in the
>> compute_partition_effective_cpumask() with a call to partition_disable().
>>
>> This centralizes partition state management and ensures consistent
>> handling of partition disable operations throughout the cpuset subsystem.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 28 +++++++---------------------
>>   1 file changed, 7 insertions(+), 21 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 6625b803ba02..20288dbd6ccf 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -170,15 +170,6 @@ static inline bool cs_is_member(const struct cpuset *cs)
>>       return cs->partition_root_state == PRS_MEMBER;
>>   }
>>   -/*
>> - * Callers should hold callback_lock to modify partition_root_state.
>> - */
>> -static inline void make_partition_invalid(struct cpuset *cs)
>> -{
>> -    if (cs->partition_root_state > 0)
>> -        cs->partition_root_state = -cs->partition_root_state;
>> -}
>> -
>>   /*
>>    * Send notification event of whenever partition_root_state changes.
>>    */
>> @@ -2073,6 +2064,7 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
>>       struct cgroup_subsys_state *css;
>>       struct cpuset *child;
>>       bool populated = partition_is_populated(cs, NULL);
>> +    enum prs_errcode prs_err;
>>         /*
>>        * Check child partition roots to see if they should be
>> @@ -2095,26 +2087,20 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
>>            * partition root.
>>            */
>>           WARN_ON_ONCE(is_remote_partition(child));
>> -        child->prs_err = 0;
>> +        prs_err = 0;
>>           if (!cpumask_subset(child->effective_xcpus,
>>                       cs->effective_xcpus))
>> -            child->prs_err = PERR_INVCPUS;
>> +            prs_err = PERR_INVCPUS;
>>           else if (populated &&
>>                cpumask_subset(new_ecpus, child->effective_xcpus))
>> -            child->prs_err = PERR_NOCPUS;
>> -
>> -        if (child->prs_err) {
>> -            int old_prs = child->partition_root_state;
>> +            prs_err = PERR_NOCPUS;
>>   +        if (prs_err) {
>>               /*
>>                * Invalidate child partition
>>                */
>> -            spin_lock_irq(&callback_lock);
>> -            make_partition_invalid(child);
>> -            cs->nr_subparts--;
>> -            child->nr_subparts = 0;
>> -            spin_unlock_irq(&callback_lock);
>> -            notify_partition_change(child, old_prs);
>> +            partition_disable(child, parent_cs(child),
> 
> The parent of child should just be cs. You don't need to use parent_cs() to get it.
> 
> Cheers,
> Longman
> 

Thank you, Longman,

Will update.

> 
>> +                      -child->partition_root_state, prs_err);
>>               continue;
>>           }
>>           cpumask_andnot(new_ecpus, new_ecpus,

-- 
Best regards,
Ridong



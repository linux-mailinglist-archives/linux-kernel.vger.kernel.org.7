Return-Path: <linux-kernel+bounces-860361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28767BEFF61
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE14D3E428C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A942ED16B;
	Mon, 20 Oct 2025 08:28:39 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779CE2ED848
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948918; cv=none; b=a9OHTdCmKvp5duQixCYly7ud3Mb0qK4S9eqgG5/z8M3b1sQd/dO0SH26InUU/tWv37AlPfsKnRRuM01in6PoYCqNU7zS5MHyQkobRhp+XlfqabJ607cThuxOIJGl5UUrf9EAMmAznceP8q0VXGmFxPfiSR4bqzRx65EaR9Kb2R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948918; c=relaxed/simple;
	bh=QxcyCwvffHXkzC0jSxusXhvZJ1W3ffdHvYgmvX7Nzqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGIs9PFGVxRPtDgpTiVHKHBpX2NeEt7Gz6Yb2ZPDk6h93Kl6IaevzjZa2aKv0Xutq2nrNhyLhg1fVknyndoFcFG8d4Uvq3pFBs3RIBwZ221VcU2eSOLQGcgOC4eNVlYTG0EqYgqyJNV/unJhHJ19l0JXBQpHvtwocjS0fZi9kWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cqpTG6m8VzKHMLM;
	Mon, 20 Oct 2025 16:27:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A06E11A0A26;
	Mon, 20 Oct 2025 16:28:31 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgA37kKu8vVoKNXwAw--.54772S2;
	Mon, 20 Oct 2025 16:28:31 +0800 (CST)
Message-ID: <2dc224c9-bd96-46a7-b71a-39abac847176@huaweicloud.com>
Date: Mon, 20 Oct 2025 16:28:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 08/16] cpuset: introduce
 local_partition_invalidate()
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-9-chenridong@huaweicloud.com>
 <a820463b-a715-4cea-917c-98175a35f970@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <a820463b-a715-4cea-917c-98175a35f970@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA37kKu8vVoKNXwAw--.54772S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw15WF4Dtr18XrW5WFWDtwb_yoW3uF4xpr
	ykJrW7JrWUJr1rC347JFs7JryrJw1DJ3WDtr18XF1rJr17Jw1qqF1jq34vgr1UJr4kJr1U
	ZF1UXrsrZF17ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/10/20 10:48, Waiman Long wrote:
> On 9/28/25 3:12 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Build on the partition_disable() infrastructure introduced in the previous
>> patch to handle local partition invalidation.
>>
>> The local_partition_invalidate() function factors out the local partition
>> invalidation logic from update_parent_effective_cpumask(), which delegates
>> to partition_disable() to complete the invalidation process.
>>
>> Additionally, correct the transition logic in cpuset_hotplug_update_tasks()
>> when determining whether to transition an invalid partition root, the check
>> should be based on non-empty user_cpus rather than non-empty
>> effective_xcpus. This correction addresses the scenario where
>> exclusive_cpus is not set but cpus_allowed is configured - in this case,
>> effective_xcpus may be empty even though the partition should be considered
>> for re-enablement. The user_cpus-based check ensures proper partition state
>> transitions under these conditions.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 66 +++++++++++++++++++++++++++---------------
>>   1 file changed, 42 insertions(+), 24 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 87ba43e93540..e460d03286ba 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1911,6 +1911,39 @@ static void local_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
>>       }
>>   }
>>   +/**
>> + * local_partition_invalidate - Invalidate a local partition
>> + * @cs: Target cpuset (local partition root) to invalidate
>> + * @tmp: Temporary masks
>> + */
>> +static void local_partition_invalidate(struct cpuset *cs, struct tmpmasks *tmp)
>> +{
>> +    struct cpumask *xcpus = user_xcpus(cs);
>> +    struct cpuset *parent = parent_cs(cs);
>> +    int new_prs = cs->partition_root_state;
>> +    bool cpumask_updated = false;
>> +
>> +    lockdep_assert_held(&cpuset_mutex);
>> +    WARN_ON_ONCE(is_remote_partition(cs));    /* For local partition only */
>> +
>> +    if (is_partition_invalid(cs))
>> +        return;
> You should change the check to if (!is_partition_valid(cs)). You can avoid the case that
> partition_disable() is called with a member.
> 

Thank you for the suggestion.

I kept the current check to align with the logic from update_parent_effective_cpumask() and to keep
the changes easier to review.

In patch 12, I've unified local_partition_invalidate and the original local_partition_disable into a
single local_partition_disable function, which now uses the if (!is_partition_valid(cs)) check. This
also brings it in line with the existing remote_partition_disable().

Since the local_partition_invalidate is removed in the subsequent patches, I believe it's a minor issue.

>> +    /*
>> +     * Make the current partition invalid.
>> +     */
>> +    if (is_partition_valid(parent))
>> +        cpumask_updated = cpumask_and(tmp->addmask,
>> +                          xcpus, parent->effective_xcpus);
>> +    if (cs->partition_root_state > 0)
>> +        new_prs = -cs->partition_root_state;
>> +
>> +    partition_disable(cs, parent, new_prs, cs->prs_err);
>> +    if (cpumask_updated) {
>> +        cpuset_update_tasks_cpumask(parent, tmp->addmask);
>> +        update_sibling_cpumasks(parent, cs, tmp);
>> +    }
>> +}
>> +
>>   /**
>>    * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
>>    * @cs:      The cpuset that requests change in partition root state
>> @@ -1972,23 +2005,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>>       adding = deleting = false;
>>       old_prs = new_prs = cs->partition_root_state;
>>   -    if (cmd == partcmd_invalidate) {
>> -        if (is_partition_invalid(cs))
>> -            return 0;
>> -
>> -        /*
>> -         * Make the current partition invalid.
>> -         */
>> -        if (is_partition_valid(parent))
>> -            adding = cpumask_and(tmp->addmask,
>> -                         xcpus, parent->effective_xcpus);
>> -        if (old_prs > 0) {
>> -            new_prs = -old_prs;
>> -            subparts_delta--;
>> -        }
>> -        goto write_error;
>> -    }
>> -
>>       /*
>>        * The parent must be a partition root.
>>        * The new cpumask, if present, or the current cpus_allowed must
>> @@ -2552,7 +2568,7 @@ static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset
>> *trialc
>>               if (is_partition_valid(cp) &&
>>                   cpumask_intersects(xcpus, cp->effective_xcpus)) {
>>                   rcu_read_unlock();
>> -                update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, tmp);
>> +                local_partition_invalidate(cp, tmp);
>>                   rcu_read_lock();
>>               }
>>           }
>> @@ -2592,8 +2608,7 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
>>                          trialcs->effective_xcpus, tmp);
>>       } else {
>>           if (trialcs->prs_err)
>> -            update_parent_effective_cpumask(cs, partcmd_invalidate,
>> -                            NULL, tmp);
>> +            local_partition_invalidate(cs, tmp);
>>           else
>>               update_parent_effective_cpumask(cs, partcmd_update,
>>                               trialcs->effective_xcpus, tmp);
>> @@ -4037,18 +4052,21 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks
>> *tmp)
>>        *    partitions.
>>        */
>>       if (is_local_partition(cs) && (!is_partition_valid(parent) ||
>> -                tasks_nocpu_error(parent, cs, &new_cpus)))
>> +                tasks_nocpu_error(parent, cs, &new_cpus))) {
>>           partcmd = partcmd_invalidate;
>> +        local_partition_invalidate(cs, tmp);
>> +    }
>>       /*
>>        * On the other hand, an invalid partition root may be transitioned
>> -     * back to a regular one with a non-empty effective xcpus.
>> +     * back to a regular one with a non-empty user xcpus.
>>        */
>>       else if (is_partition_valid(parent) && is_partition_invalid(cs) &&
>> -         !cpumask_empty(cs->effective_xcpus))
>> +         !cpumask_empty(user_xcpus(cs))) {
> 
> I believe the effective_xcpus is not cleared currently when a partition is invalidated. Anyway, this
> change is also OK especially if effective_xcpus will be cleared in a later patch.
> 
> Cheers,
> Longman
> 
>>           partcmd = partcmd_update;
>> +        update_parent_effective_cpumask(cs, partcmd, NULL, tmp);
>> +    }
>>         if (partcmd >= 0) {
>> -        update_parent_effective_cpumask(cs, partcmd, NULL, tmp);
>>           if ((partcmd == partcmd_invalidate) || is_partition_valid(cs)) {
>>               compute_partition_effective_cpumask(cs, &new_cpus);
>>               cpuset_force_rebuild();

-- 
Best regards,
Ridong



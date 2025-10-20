Return-Path: <linux-kernel+bounces-860280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E17BEFBC9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7E33B6A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044CA2E2EEE;
	Mon, 20 Oct 2025 07:48:47 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D612DF133
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946526; cv=none; b=dcnn0rRjisMVqP/8JR5xQc68NhakgmDqHFEr/ZQc8GEZA0JYZ31zMWxeqRSgEPd+C8Dob9JknKpx2fx5Oi4lyYAh8SgwXlWoIDs3vqmPyTyyazyOhJpFbTJ/pO7po9zZUx1YYeWF2IS2brQLRZgnK+Xn5BY9GOivB2avNfBMgeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946526; c=relaxed/simple;
	bh=yUk3lhUt1sY7o4U0LgDMsfxKrxc/YMRb9KlIccU7EbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+RYCMRwQGGqCdPP1/uWEj49gO4ACqV1hf6D1uxO7iyjG2ALvZ39yItG611Pt1voc7TaZpaNThtVEDyewsrzAbyN8T0txcB7ebz7Iz/GP685gQHeXLWtRamijHcw+ejR3r2RKV9DsBA7iHvJ9DtyHg5oS2BFQiaIyW9U/ELNAmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cqnb959qhzYQtpW;
	Mon, 20 Oct 2025 15:47:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 62CE21A17ED;
	Mon, 20 Oct 2025 15:48:40 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgDniEFX6fVoDI30Aw--.58966S2;
	Mon, 20 Oct 2025 15:48:40 +0800 (CST)
Message-ID: <fa7fa2e5-c602-4318-90e1-89c742c6cc1a@huaweicloud.com>
Date: Mon, 20 Oct 2025 15:48:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 03/16] cpuset: factor out partition_enable()
 function
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-4-chenridong@huaweicloud.com>
 <9168ffab-b0a8-4024-a1f4-966b9f95c953@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <9168ffab-b0a8-4024-a1f4-966b9f95c953@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDniEFX6fVoDI30Aw--.58966S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4rAr1UtFW5ur43Xr1rCrg_yoWrCw1UpF
	95JFW5tayUKryfC3srXF4xC34fKrs7J3WUtwn7X3W8Xr17Aw1vgFyj9390g3WUXrWkGry5
	ZF1DWrs7uF17AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/10/20 10:39, Waiman Long wrote:
> On 9/28/25 3:12 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Extract the core partition enablement logic into a dedicated
>> partition_enable() function. This refactoring centralizes updates to key
>> cpuset data structures including remote_sibling, effective_xcpus,
>> partition_root_state, and prs_err.
>>
>> The function handles the complete partition enablement workflow:
>> - Adding exclusive CPUs via partition_xcpus_add()
>> - Managing remote sibling relationships
>> - Synchronizing effective exclusive CPUs mask
>> - Updating partition state and error status
>> - Triggering required scheduler domain rebuilds
>>
>> This creates a coherent interface for partition operations and establishes
>> a foundation for future local partition support while maintaining existing
>> remote partition behavior.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 55 +++++++++++++++++++++++++++++++++---------
>>   1 file changed, 44 insertions(+), 11 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 0787904321a9..43ce62f4959c 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1515,6 +1515,49 @@ static inline bool is_local_partition(struct cpuset *cs)
>>       return is_partition_valid(cs) && !is_remote_partition(cs);
>>   }
>>   +static void partition_state_update(struct cpuset *cs, int new_prs,
>> +                      enum prs_errcode prs_err)
>> +{
>> +    lockdep_assert_held(&callback_lock);
>> +
>> +    cs->partition_root_state = new_prs;
>> +    WRITE_ONCE(cs->prs_err, prs_err);
>> +    if (!is_partition_valid(cs))
>> +        reset_partition_data(cs);
>> +}
>> +
>> +/**
>> + * partition_enable - Transitions a cpuset to a partition root
>> + * @cs: The cpuset to enable partition for
>> + * @parent: Parent cpuset of @cs, NULL for remote parent
>> + * @new_prs: New partition root state to set
>> + * @new_excpus: New exclusive CPUs mask for the partition
>> + *
>> + * Transitions a cpuset to a partition root, only for v2.
>> + */
>> +static void partition_enable(struct cpuset *cs, struct cpuset *parent,
>> +                 int new_prs, struct cpumask *new_excpus)
>> +{
>> +    bool isolcpus_updated;
>> +
>> +    lockdep_assert_held(&cpuset_mutex);
>> +    WARN_ON_ONCE(new_prs <= 0);
>> +    WARN_ON_ONCE(!cpuset_v2());
>> +
>> +    if (cs->partition_root_state == new_prs)
>> +        return;
>> +
>> +    spin_lock_irq(&callback_lock);
>> +    /* enable partition should only add exclusive cpus */
>> +    isolcpus_updated = partition_xcpus_add(new_prs, parent, new_excpus);
>> +    list_add(&cs->remote_sibling, &remote_children);
>> +    cpumask_copy(cs->effective_xcpus, new_excpus);
>> +    partition_state_update(cs, new_prs, PERR_NONE);
>> +    spin_unlock_irq(&callback_lock);
>> +    update_unbound_workqueue_cpumask(isolcpus_updated);
>> +    cpuset_force_rebuild();
>> +}
>> +
> partition_enable() is supposed to be a common helper used for the creation of both local and remote
> partitions. The one in this patch does work for remote partition but not for local partition. I
> would prefer to make it good for both cases when you introduce it instead adding code in patch 6 to
> make it work for local partition later in the series. It will make it easier to review instead of
> jumping back and forth to make sure that it will do the right thing.
> 
> Cheers,
> Longman
> 

Thank you, Longman.

My original intention was to keep the changes easier to review. Patches 3–5 are meant to be pure
refactoring moves of code from the remote partition logic, without altering any behavior.

Would it be clearer to proceed in the following stages:

1. Introduce partition_enable(), partition_disable(), and partition_update() with their complete
logic first.
2. Replace the corresponding logic in remote partitions with these new helpers.
3. Then, replace the logic in local partitions with the same helpers.

-- 
Best regards,
Ridong



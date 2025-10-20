Return-Path: <linux-kernel+bounces-860303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB3FBEFCAE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85C7E347FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB612D876A;
	Mon, 20 Oct 2025 08:06:24 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63CB2DEA94
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947583; cv=none; b=kpggE4x40P8oPw+4ONTKAg27m9zPlO3zPDPtZS3LlM6qlPB3b1lfI5+NeE93yqlBhZsoxEhMwxXPeQ0k7bmAFZ9OfQvzCinArkZ8Fr+UVpFqt5yqi0hqKOI6/yGBgYDG2/t/3YMM9T7wa9AZrI2/EhfWozYiZEQVezrLh8wy6S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947583; c=relaxed/simple;
	bh=mTyBepi9R4tFdZgFaonYYBYV/glIteocSDz5RGAmKZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsCOPulEqMbmR+Z7nZ9PnJVyiYF8XEAV8iATrVu4pI7pijtICRni6lYVUuInxt9O4ZxLaD12Y2h7tvYzhj2ht+znHEo49Omh9gRAGeDIYInqynHbC1v9wKxh7zHmvXqobIQml6SIXVPvvqZAyebjjlOUItvpBkHzsEGHDZ6GlV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cqnzW1cJDzYQtLc;
	Mon, 20 Oct 2025 16:05:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id DB7BA1A06DF;
	Mon, 20 Oct 2025 16:06:17 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgAnyUF57fVoYvD1Aw--.34222S2;
	Mon, 20 Oct 2025 16:06:17 +0800 (CST)
Message-ID: <63411cc0-5879-4e9c-a7ba-3e8fac362629@huaweicloud.com>
Date: Mon, 20 Oct 2025 16:06:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 06/16] cpuset: introduce
 local_partition_enable()
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-7-chenridong@huaweicloud.com>
 <85e776e6-110e-4c04-88b7-93059db8f74c@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <85e776e6-110e-4c04-88b7-93059db8f74c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnyUF57fVoYvD1Aw--.34222S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45tFWfAr1ftFWrWr1UAwb_yoW5AFW8pF
	1kGFWrtFWYgryrC3srXF4kArWrKrs7J3WDtwn3Xa4rXr17Aw1vgF1j93s0gF1UXrWkGFyU
	ZF1jqrsrZF17ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbiF4tUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/10/20 10:44, Waiman Long wrote:
> On 9/28/25 3:12 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The partition_enable() function introduced in the previous patch can be
>> reused to enable local partitions.
>>
>> First, partition_enable() was enhanced to support local partition enabling
>> by properly handling parent's nr_subparts counter and adding notification
>> operations.
>>
>> Then, the local_partition_enable() function is introduced, which factors
>> out the local partition enablement logic from
>> update_parent_effective_cpumask(). After passing local partition validation
>> checks, it delegates to partition_enable() to complete the partition setup.
>>
>> This refactoring creates a clear separation between local and remote
>> partition operations while maintaining code reuse through the shared
>> partition_enable() infrastructure.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 111 +++++++++++++++++++++++++++--------------
>>   1 file changed, 74 insertions(+), 37 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 0e2f95daf459..154992cdfe9a 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1539,6 +1539,7 @@ static void partition_enable(struct cpuset *cs, struct cpuset *parent,
>>                    int new_prs, struct cpumask *new_excpus)
>>   {
>>       bool isolcpus_updated;
>> +    int old_prs;
>>         lockdep_assert_held(&cpuset_mutex);
>>       WARN_ON_ONCE(new_prs <= 0);
>> @@ -1547,15 +1548,21 @@ static void partition_enable(struct cpuset *cs, struct cpuset *parent,
>>       if (cs->partition_root_state == new_prs)
>>           return;
>>   +    old_prs = cs->partition_root_state;
>>       spin_lock_irq(&callback_lock);
>>       /* enable partition should only add exclusive cpus */
>>       isolcpus_updated = partition_xcpus_add(new_prs, parent, new_excpus);
>> -    list_add(&cs->remote_sibling, &remote_children);
>> +    /* enable remote partition */
>> +    if (!parent)
>> +        list_add(&cs->remote_sibling, &remote_children);
>> +    else if (!is_partition_valid(cs))
>> +        parent->nr_subparts += 1;
>>       cpumask_copy(cs->effective_xcpus, new_excpus);
>>       partition_state_update(cs, new_prs, PERR_NONE);
>>       spin_unlock_irq(&callback_lock);
>>       update_unbound_workqueue_cpumask(isolcpus_updated);
>>       cpuset_force_rebuild();
>> +    notify_partition_change(cs, old_prs);
>>   }
> 
> As commented in an earlier patch, the partition_enable() chnage should be moved there.
> 
> Cheers,
> Longman

Thank you, will update.

-- 
Best regards,
Ridong



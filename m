Return-Path: <linux-kernel+bounces-860304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D73DBEFCB4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59353BD427
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCF42E093C;
	Mon, 20 Oct 2025 08:06:47 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C6A23C513
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947605; cv=none; b=sEfRccU8sXdXb5eFQTQwTHVFGC/ULeqNioBKS+PxbVni7KR75llDmtiHSoKdDeGhjTaZD6N8LHRd9GZTCQfgnOAy9PJRkodF0MKPxtG8Wpk8Q47S5jqV1yn0ahOlkT5QuyUu3qVjSwxRJgGCUFVQ7EG1KZwnh5oLxVu7P0zm438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947605; c=relaxed/simple;
	bh=humS5mB7INRpQLT/Vp5XMKHwgL7Zyqzi+uAp+7NFO88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMbTGhZWq7OgHFnZFIoqjtVJm/QRaBoMZphAfG1B8dr7YiKC3eRKEY2KCCqtAgHqT5ctcqpFGYueLLi6Y3H5IC4Yhy7tl8egsG9GGT/ATmUk1av5qrZMYVFkBWPX8/00wytQzUa8DzX8Ii3OzOxoDyosfwqkp05/hIRYbgusnMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cqnzx15GpzYQthl;
	Mon, 20 Oct 2025 16:05:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C864F1A0EFB;
	Mon, 20 Oct 2025 16:06:39 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgCn7eGP7fVoJgbhAw--.60061S2;
	Mon, 20 Oct 2025 16:06:39 +0800 (CST)
Message-ID: <45f0970a-b266-4286-bff5-d1c35a878a34@huaweicloud.com>
Date: Mon, 20 Oct 2025 16:06:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 07/16] cpuset: introduce
 local_partition_disable()
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-8-chenridong@huaweicloud.com>
 <d719fdbc-515e-4386-b4d8-1d5fc0f7edf1@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <d719fdbc-515e-4386-b4d8-1d5fc0f7edf1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCn7eGP7fVoJgbhAw--.60061S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45tFW7tF4DZFyDtF48Xrb_yoW5Cr1xpF
	1kJrWrtayUWFn3u347JF4kArWrGr4kJa4Utr1xXa4rJr17Jw1vqFyjv3sYgF1UJrWkJryU
	ZF1qgr47uF1xArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1aZX5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/10/20 10:46, Waiman Long wrote:
> On 9/28/25 3:12 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The partition_disable() function introduced earlier can be extended to
>> handle local partition disablement.
>>
>> First, partition_disable() was enhanced to support local partitions by
>> properly managing the parent's nr_subparts counter and integrating
>> notification operations.
>>
>> Then, local_partition_disable() is introduced, which extracts the local
>> partition disable logic from update_parent_effective_cpumask(). It calls
>> partition_disable() to complete the disablement process.
>>
>> This refactoring establishes a clear separation between local and remote
>> partition operations while promoting code reuse through the shared
>> partition_disable() infrastructure.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 60 ++++++++++++++++++++++++++++++------------
>>   1 file changed, 43 insertions(+), 17 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 154992cdfe9a..87ba43e93540 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1576,13 +1576,20 @@ static void partition_disable(struct cpuset *cs, struct cpuset *parent,
>>                       int new_prs, enum prs_errcode prs_err)
>>   {
>>       bool isolcpus_updated;
>> +    int old_prs;
>>         lockdep_assert_held(&cpuset_mutex);
>>       WARN_ON_ONCE(new_prs > 0);
>>       WARN_ON_ONCE(!cpuset_v2());
>>   +    old_prs = cs->partition_root_state;
>>       spin_lock_irq(&callback_lock);
>>       list_del_init(&cs->remote_sibling);
>> +    if (parent && is_partition_valid(parent) &&
>> +        is_partition_valid(cs)) {
>> +        parent->nr_subparts -= 1;
>> +        WARN_ON_ONCE(parent->nr_subparts < 0);
>> +    }
>>       /* disable a partition should only delete exclusive cpus */
>>       isolcpus_updated = partition_xcpus_del(cs->partition_root_state,
>>                           parent, cs->effective_xcpus);
>> @@ -1592,6 +1599,9 @@ static void partition_disable(struct cpuset *cs, struct cpuset *parent,
>>       spin_unlock_irq(&callback_lock);
>>       update_unbound_workqueue_cpumask(isolcpus_updated);
>>       cpuset_force_rebuild();
>> +    /* Clear exclusive flag; no errors are expected */
>> +    update_partition_exclusive_flag(cs, new_prs);
>> +    notify_partition_change(cs, old_prs);
>>   }
>>   
> 
> Similarly, change to partition_disable() should be done previously in patch 4 ("cpuset: factor out
> partition_disable() function") for completeness.
> 
> Cheers,
> Longman
> 

Thank you, will update.

-- 
Best regards,
Ridong



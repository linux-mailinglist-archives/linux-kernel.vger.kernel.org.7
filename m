Return-Path: <linux-kernel+bounces-860301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B34BEFCA5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D3F3B3158
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE182DF3D1;
	Mon, 20 Oct 2025 08:05:23 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74BB3A8F7
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947522; cv=none; b=LhqRWYMqJiwY2G/OwC7jNwJkjJZePAyj+dpRXiFDZLhztCVMDiN6QSURtumEoWtI70gxQGXNJqZAfbvWgeOtkVj4y2iNKFUxr3mlydGy34FgLnZ5Fegllf6xmdlNo7NcZHZ6CSdT2LOiNjKEsEoWTnL+8L6ZRmJaxqK9IIRy6QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947522; c=relaxed/simple;
	bh=D23ZRsiNRxdzRrAFB8FTjHwMsIVNrkpE8xwdMUNK6Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oapIrbjSLCqNyrt/ajneB+uBJXg6BelGJ0ufvydx2Zq/8y8HKh2mTpCdvVYb6Ep28vzCLGpyRHLAgFAYXfm/le+y3zmK58PlBk7pooS2f6ttAcRLd16TPuqsuFSEZ3guZJJwHu7vLWhTotzQteKT3rTJh4sZmo0AwxHRoyn8LVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cqnyL4dM6zYQtF4;
	Mon, 20 Oct 2025 16:04:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4F59C1A0E9B;
	Mon, 20 Oct 2025 16:05:17 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgCnSEE87fVo4tv1Aw--.59558S2;
	Mon, 20 Oct 2025 16:05:17 +0800 (CST)
Message-ID: <155a2703-e43e-41f7-bb91-2936f89c29e2@huaweicloud.com>
Date: Mon, 20 Oct 2025 16:05:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 05/16] cpuset: factor out partition_update()
 function
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-6-chenridong@huaweicloud.com>
 <6122ac29-3984-4364-ab37-4987b65b5450@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <6122ac29-3984-4364-ab37-4987b65b5450@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnSEE87fVo4tv1Aw--.59558S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4rWw4DGF47ZF13WF18Grg_yoW5KFWrpF
	95JFWfJayUKr1fu3sxtFs7C3yfKws7t3Wjyrn7Xa48JF9Ivw1v93Wjvas0gFy5XrWkGrWU
	ZF4qgrsFv3W7AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/10/20 10:43, Waiman Long wrote:
> On 9/28/25 3:12 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Extract the core partition update logic into a dedicated partition_update()
>> function. This refactoring centralizes updates to key cpuset data
>> structures including remote_sibling, effective_xcpus, partition_root_state,
>> and prs_err.
>>
>> The function handles the complete partition update workflow:
>> - Adding and removing exclusive CPUs via partition_xcpus_add()/del()
>> - Managing remote sibling relationships
>> - Synchronizing effective exclusive CPUs mask
>> - Updating partition state and error status
>> - Triggering required system updates and workqueue synchronization
>>
>> This creates a coherent interface for partition operations and establishes
>> a foundation for enhanced partition management while maintaining existing
>> remote partition behavior.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 71 ++++++++++++++++++++++++++++--------------
>>   1 file changed, 47 insertions(+), 24 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 1944410ae872..0e2f95daf459 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1587,6 +1587,49 @@ static void partition_disable(struct cpuset *cs, struct cpuset *parent,
>>       cpuset_force_rebuild();
>>   }
>>   +/**
>> + * partition_update - Update an existing partition configuration
>> + * @cs: The cpuset to update
>> + * @prs: Partition root state (must be positive)
>> + * @xcpus: New exclusive CPUs mask for the partition (NULL to keep current)
>> + * @excpus: New effective exclusive CPUs mask
>> + * @tmp: Temporary masks
>> + *
>> + * Updates partition-related fields. The tmp->addmask is the CPU mask that
>> + * will be added to the subpartitions_cpus and removed from parent's
>> + * effective_cpus, and the tmp->delmask vice versa.
>> + */
>> +static void partition_update(struct cpuset *cs, int prs, struct cpumask *xcpus,
>> +                  struct cpumask *excpus, struct tmpmasks *tmp)
>> +{
>> +    bool isolcpus_updated;
>> +    bool excl_updated;
>> +    struct cpuset *parent;
>> +
>> +    lockdep_assert_held(&cpuset_mutex);
>> +    WARN_ON_ONCE(!cpuset_v2());
>> +    WARN_ON_ONCE(prs <= 0);
>> +
>> +    parent = is_remote_partition(cs) ? NULL : parent_cs(cs);
>> +    excl_updated = !cpumask_empty(tmp->addmask) ||
>> +            !cpumask_empty(tmp->delmask);
>> +
>> +    spin_lock_irq(&callback_lock);
>> +    isolcpus_updated = partition_xcpus_add(prs, parent, tmp->addmask);
>> +    isolcpus_updated |= partition_xcpus_del(prs, parent, tmp->delmask);
> 
> The current partition_xcpus_add/del() functions assume the given cpumas is non-empty. In the new
> partition_update() helper, you can pass an empty cpumask to them. This will cause useless work to be
> done. Also isolcpus_update may not be correct because of that causing unneeded work to be done in
> the workqueue code.
> 
> -Longman

Thank you, Longman.

I think we can add a check for empty cpumask inputs in partition_xcpus_add() and
partition_xcpus_del() to avoid unnecessary operations.

To clarify, do you mean that passing an empty cpumask to these functions might lead to incorrect
isolcpus_updated value? or are you referring to other potential logic issues?

-- 
Best regards,
Ridong



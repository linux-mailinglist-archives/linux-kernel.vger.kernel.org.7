Return-Path: <linux-kernel+bounces-860431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE4FBF01DF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B0304F1135
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC352ED165;
	Mon, 20 Oct 2025 09:13:17 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1F32E266A
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951597; cv=none; b=E+SGWKnwNAhokcCoTyshhZKLVShq9q+rWhJ7uBg1l9vRqFDjuYdZ/ULryCd9ZAs+WG0QqSbO3cNmoPIvI/CauBYvqVfLloloiHRJupNZA60qAoAgKR+JRQh7vSMqQX9MTnYbe6jqpYZ6fCLYKH3UsrkUAvouCoqFJzI3MLHLeNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951597; c=relaxed/simple;
	bh=56oWEVBzatiA1wt4cCaOJBZkP0gZKhWyAOnOBJWTfI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ks0Q8IzEmRSSrDsezKdGH15W/VesR9KITXq5ehn8ZDeL0Xsr5q0pXMcQMuGQa9ZF/6Xqtk6cAEvjRCKMoifMXpcgdIU1Myn/tnB62Utl2hnMbuLQVA9v/zI1lYhJx0PHOurSH13stNNJlhlfaVDVcTPEbEZjMqiJetFR2DBFaVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cqqSm74pwzKHMQ0;
	Mon, 20 Oct 2025 17:12:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B944E1A1A4E;
	Mon, 20 Oct 2025 17:13:09 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgAny0Mk_fVoDjb7Aw--.16020S2;
	Mon, 20 Oct 2025 17:13:09 +0800 (CST)
Message-ID: <3d9dceab-82c8-4811-9be2-7571d09a9e76@huaweicloud.com>
Date: Mon, 20 Oct 2025 17:13:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 14/16] cpuset: fix isolcpus stay in root when
 isolated partition changes to root
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-15-chenridong@huaweicloud.com>
 <a07b794c-d133-4d23-b0b0-cb9e0dc42d2b@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <a07b794c-d133-4d23-b0b0-cb9e0dc42d2b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAny0Mk_fVoDjb7Aw--.16020S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr48GrW7Aw48WryxCFWDXFb_yoW3Cr13pF
	95KFWUJrWYkw1rC34UJF4kZryrJw4DJ3WDtrn8XFyrXF47AF10vFyjg390gr1UXrWkGr1U
	ZF1jqrsrZF17AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8YYLPUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/10/20 11:06, Waiman Long wrote:
> On 9/28/25 3:13 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> A bug was detected with the following steps:
>>
>>    # cd /sys/fs/cgroup/
>>    # mkdir test
>>    # echo 9 > test/cpuset.cpus
>>    # echo isolated > test/cpuset.cpus.partition
>>    # cat test/cpuset.cpus.partition
>>    isolated
>>    # cat test/cpuset.cpus
>>    9
>>    # echo root > test/cpuset.cpus.partition
>>    # cat test/cpuset.cpus
>>    9
>>    # cat test/cpuset.cpus.partition
>>    root
>>
>> CPU 9 was initially placed in an isolated partition. When the partition
>> type is changed from isolated to root, CPU 9 remains in what becomes a
>> valid root partition. This violates the rule that isolcpus can only be
>> assigned to isolated partitions.
> 
> I am a bit confused at the beginning about this as it does not clearly state that CPU 9 was listed
> in the "isolcpus" boot command line parameter, but I believe this is what you mean here. Yes, there
> is a restriction that a boot time isolcpus CPU cannot be put into a non-isolated partition, though
> that will likely to be relaxed in the near future.
> 

Yep, the CPU 9 was listed in the "isolcpus" boot command line parameter.

> Anyway, it is a real corner case. I also don't believe commit f28e22441f35 is the one that
> introduced this issue as the restriction was added later on via commit 4a74e418881f ("cgroup/cpuset:
> Check partition conflict with housekeeping setup").
> 
> As you have added a Fixes tag, it should be moved to the front of the series as it is likely to be
> backported to stable. Putting it near the end of a series with a lot of changes in between will make
> it harder to backport to the stable kernels.
> 

Maybe I should find some way to fix this issue first.

>> Fix the issue by re-enabling partition validation, which performs
>> comprehensive partition error checking. In the scenario described above,
>> this change causes the operation to fail with housekeeping conflicts,
>> preventing the invalid configuration.
> From the code diff below, I don't know how you re-enable partition validation.
> 

When a valid local partition has its type changed (e.g., from "isolated" to "root"), the
remote_partition_enable function is not invoked again. Consequently, the critical check for whether
the partition can be enabled is skipped during this process.

  echo isolated > test/cpuset.cpus.partition
  echo root > test/cpuset.cpus.partition

>>
>> Additionally, when enable a local partition, the warning for tmp->addmask
>> not being a subset of parent's effective CPUs was removed. This warning was
>> triggered during local partition re-enablement because the CPUs were
>> already added to exclusive_cpus during the previous enable operation. The
>> subset check is not applicable in this re-enablement scenario.
> 
> That should be in the new code that you introduce in this series. So it either be integrated into
> one of your earlier patches or be separated out as a separate patch without the Fixes tag as it is
> not applicable for the stable releases.
> 
> Cheers,
> Longman
> 

Okay, I will try to integrate it into earlier patches.

>>
>> Fixes: f28e22441f35 ("cgroup/cpuset: Add a new isolated cpus.partition type")
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 35 +++++++++--------------------------
>>   1 file changed, 9 insertions(+), 26 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 20288dbd6ccf..2aaa688c596f 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1873,6 +1873,7 @@ static int local_partition_enable(struct cpuset *cs,
>>   {
>>       struct cpuset *parent = parent_cs(cs);
>>       enum prs_errcode part_error;
>> +    bool cpumask_updated = false;
>>         lockdep_assert_held(&cpuset_mutex);
>>       WARN_ON_ONCE(is_remote_partition(cs));    /* For local partition only */
>> @@ -1899,22 +1900,14 @@ static int local_partition_enable(struct cpuset *cs,
>>       if (part_error)
>>           return part_error;
>>   -    /*
>> -     * This function will only be called when all the preliminary
>> -     * checks have passed. At this point, the following condition
>> -     * should hold.
>> -     *
>> -     * (cs->effective_xcpus & cpu_active_mask) ⊆ parent->effective_cpus
>> -     *
>> -     * Warn if it is not the case.
>> -     * addmask is used as temporary variable.
>> -     */
>> -    cpumask_and(tmp->addmask, tmp->new_cpus, cpu_active_mask);
>> -    WARN_ON_ONCE(!cpumask_subset(tmp->addmask, parent->effective_cpus));
>> +    cpumask_updated = cpumask_andnot(tmp->addmask, tmp->new_cpus,
>> +                     parent->effective_cpus);
>>       partition_enable(cs, parent, new_prs, tmp->new_cpus);
>>   -    cpuset_update_tasks_cpumask(parent, tmp->addmask);
>> -    update_sibling_cpumasks(parent, cs, tmp);
>> +    if (cpumask_updated) {
>> +        cpuset_update_tasks_cpumask(parent, tmp->addmask);
>> +        update_sibling_cpumasks(parent, cs, tmp);
>> +    }
>>       return 0;
>>   }
>>   @@ -2902,7 +2895,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>>       int err = PERR_NONE, old_prs = cs->partition_root_state;
>>       struct cpuset *parent = parent_cs(cs);
>>       struct tmpmasks tmpmask;
>> -    bool isolcpus_updated = false;
>>         if (old_prs == new_prs)
>>           return 0;
>> @@ -2920,7 +2912,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>>       if (err)
>>           goto out;
>>   -    if (!old_prs) {
>> +    if (new_prs > 0) {
>>           /*
>>            * cpus_allowed and exclusive_cpus cannot be both empty.
>>            */
>> @@ -2950,12 +2942,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>>               err = local_partition_enable(cs, new_prs, &tmpmask);
>>           else
>>               err = remote_partition_enable(cs, new_prs, &tmpmask);
>> -    } else if (old_prs && new_prs) {
>> -        /*
>> -         * A change in load balance state only, no change in cpumasks.
>> -         * Need to update isolated_cpus.
>> -         */
>> -        isolcpus_updated = true;
>>       } else {
>>           /*
>>            * Switching back to member is always allowed even if it
>> @@ -2985,16 +2971,13 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>>       WRITE_ONCE(cs->prs_err, err);
>>       if (!is_partition_valid(cs))
>>           reset_partition_data(cs);
>> -    else if (isolcpus_updated)
>> -        isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
>>       spin_unlock_irq(&callback_lock);
>> -    update_unbound_workqueue_cpumask(isolcpus_updated);
>>         /* Force update if switching back to member & update effective_xcpus */
>>       update_cpumasks_hier(cs, &tmpmask, !new_prs);
>>         /* A newly created partition must have effective_xcpus set */
>> -    WARN_ON_ONCE(!old_prs && (new_prs > 0)
>> +    WARN_ON_ONCE(!old_prs && (cs->partition_root_state > 0)
>>                     && cpumask_empty(cs->effective_xcpus));
>>         /* Update sched domains and load balance flag */

-- 
Best regards,
Ridong



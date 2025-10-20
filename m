Return-Path: <linux-kernel+bounces-860382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A162ABF001B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD303B82D8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C524D2EC0A0;
	Mon, 20 Oct 2025 08:44:44 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA752DCF7C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949884; cv=none; b=BX2puptH7HNlCQw87I6Cu5W1CB542epZNZszvkSG54NO/0SxAB6yXD/r5DbhLnJpg7fapJztSali5QkdhzORq/426+2vssUcRUq8s4adWkQT55XAabfSxB/icWwTcto0H2AwRJrYFIormpUp3AfQFismVazd72WrdR9fSsV+GjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949884; c=relaxed/simple;
	bh=aYr05q1o0cdDOrP+MKajyhMt96ooJZe8riiKiTtZo7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlqRPJJywf5mMvxon14S6RCIPB/KTBL+hVNvu4VQ3hlJFDceChqXkcNvkFFiGk6u5Zd0lBbjWeW+mpg3TgnJIEGJiHtKhkrLmyGriSiwZ8ZUQTq2A0VXjapeKFbMqJbxT/MhFCRnizgIzijjmXZcZqB/auOhpdH4PgnWydFta0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cqpqm3LTKzYQtqN;
	Mon, 20 Oct 2025 16:43:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 311801A12E6;
	Mon, 20 Oct 2025 16:44:39 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgB36Ux19vVoEFXsAw--.5397S2;
	Mon, 20 Oct 2025 16:44:39 +0800 (CST)
Message-ID: <08d14514-3419-4aa8-9b20-cd95a45706e2@huaweicloud.com>
Date: Mon, 20 Oct 2025 16:44:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 11/16] cpuset: simplify partition update logic
 for hotplug tasks
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-12-chenridong@huaweicloud.com>
 <b436725e-215f-467f-9123-1853f65c3946@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <b436725e-215f-467f-9123-1853f65c3946@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgB36Ux19vVoEFXsAw--.5397S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45Kr17Jw43Ar1rAw48tFb_yoW5ZryDpr
	95GFW7tayjgr10k3sFqF97A34UGan7J3WUtwnIq3WrJr12vw1v9F1jq3sY9FW5XrWkGF17
	ZFn0qr4xZF18Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/10/20 11:00, Waiman Long wrote:
> 
> On 9/28/25 3:13 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Simplify the partition update logic in cpuset_hotplug_update_tasks() by
>> calling the unified local_partition_update() interface.
>>
>> For local partitions, the previous patch introduced local_partition_update
>> which handles both validation state transitions:
>> - Invalidates local partitions that fail validation checks
>> - Transitions invalid partitions to valid state when no errors are detected
>>
>> This eliminates the need for separate transition logic
>> in cpuset_hotplug_update_tasks(), which can now simply call
>> local_partition_update() to handle all local partition changes.
>>
>> This patch simplifies the logic by always proceeding to update_tasks for
>> remote partitions, regardless of whether they were disabled or not. Since
>> the original code didn't perform any meaningful operations for non-disabled
>> remote partitions, this change should not affect functionality.
>>
>> The partition_cmd mechanism can now be safely removed as it is no longer
> 
> It is partition_cmd enum type.
> 

Thank you,

Will update.

>> referenced by any code paths after the partition update logic
>> simplification.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 67 ++++++++++++++++--------------------------
>>   1 file changed, 26 insertions(+), 41 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 9e98df542715..a1896a199c8b 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1211,17 +1211,6 @@ static void compute_effective_cpumask(struct cpumask *new_cpus,
>>       cpumask_and(new_cpus, cs->cpus_allowed, parent->effective_cpus);
>>   }
>>   -/*
>> - * Commands for update_parent_effective_cpumask
>> - */
>> -enum partition_cmd {
>> -    partcmd_enable,        /* Enable partition root      */
>> -    partcmd_enablei,    /* Enable isolated partition root */
>> -    partcmd_disable,    /* Disable partition root      */
>> -    partcmd_update,        /* Update parent's effective_cpus */
>> -    partcmd_invalidate,    /* Make partition invalid      */
>> -};
>> -
>>   static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
>>                       struct tmpmasks *tmp);
>>   @@ -2062,6 +2051,9 @@ static int __local_partition_update(struct cpuset *cs, struct cpumask *xcpus,
>>           update_partition_sd_lb(cs, old_prs);
>>           return part_error;
>>       }
>> +    /* Nothing changes, return PERR_NONE */
>> +    if (new_prs == old_prs && cpumask_equal(excpus, cs->effective_xcpus))
>> +        return PERR_NONE;
> I believe you already have this check added when you introduce __local_partition_update() in patch
> 9. It is a duplicate.
> 
> Cheers,
> Longman

Thank you,

Will update.

-- 
Best regards,
Ridong



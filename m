Return-Path: <linux-kernel+bounces-860248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC042BEFAD0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75C8E4EDD78
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EA82C08CE;
	Mon, 20 Oct 2025 07:30:16 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651EC221FC4
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760945415; cv=none; b=GnCfMlHPwg2anJq6n/BfK7jB9skFEfh7F/sppOAfRVt6wz8akHEdjSxse+Ka6h/05tnf4P32IzkobYYg+yp7kquGAdkQ4cvAU4b61QzobvdLkeXTx9Cc7vNaGvXdV3pWpOiUt5rKXYWmNENssfeNGJm1BJ2E83C0M8AZFFMd/Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760945415; c=relaxed/simple;
	bh=/1W54VJAqHz65nkWyg7aBIlmny5l0FVI3XrOIdb2Qgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YB1DqnF4VJUKVYOhDT60bOn7R2zQlKXsbUN44pARBOmVOrIlWxX6EXzz8g7VUuydjr2IhhW3FdB+rxKMzl8n/2A4Ka0ZFzOH6SrDqi3a7h52H7rD18szSLne8ohusn9Ksk5RULluX7sfIhr7u/cYyJilo6q/OtArIw5kQyy7nfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cqn9w6C7czKHMLR;
	Mon, 20 Oct 2025 15:29:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 801341A083E;
	Mon, 20 Oct 2025 15:30:09 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgBn+98A5fVoKTDeAw--.483S2;
	Mon, 20 Oct 2025 15:30:09 +0800 (CST)
Message-ID: <7fdd05cd-4923-4a3f-89e9-d5f5099500ae@huaweicloud.com>
Date: Mon, 20 Oct 2025 15:30:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 01/16] cpuset: use update_partition_sd_lb in
 update_cpumasks_hier
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-2-chenridong@huaweicloud.com>
 <c40f7e09-3262-4de3-86e6-31a4a6a5338f@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <c40f7e09-3262-4de3-86e6-31a4a6a5338f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBn+98A5fVoKTDeAw--.483S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45ur4DCrWfur1DXFWUJwb_yoW5ZryrpF
	1kGFWUJFWYyw18Cw1UX3W8JryrJa1kX3WDtw13tF18Jr12yF12gF1UW3sagr4UJr4kGr18
	Ar1UXr42vF15ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/10/20 10:37, Waiman Long wrote:
> On 9/28/25 3:12 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> For cgroup v2, when a cpuset is not a valid partition root, it inherits
>> the CS_SCHED_LOAD_BALANCE flag from its parent. The existing logic in
>> update_cpumasks_hier() manually handled this inheritance condition.
>>
>> This patch replaces the inline implementation with a call to the dedicated
>> update_partition_sd_lb() helper function, which already encapsulates the
>> same logic. The helper function comprehensively handles both the load
>> balance flag update and the necessary scheduling domain rebuild decision.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 16 +++-------------
>>   1 file changed, 3 insertions(+), 13 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 52468d2c178a..052f9e0c7a65 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1257,6 +1257,8 @@ static void update_partition_sd_lb(struct cpuset *cs, int old_prs)
>>       bool rebuild_domains = (new_prs > 0) || (old_prs > 0);
>>       bool new_lb;
>>   +    if (!cpuset_v2())
>> +        return;
>>       /*
>>        * If cs is not a valid partition root, the load balance state
>>        * will follow its parent.
>> @@ -2276,19 +2278,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>>               !cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
>>             cpuset_update_tasks_cpumask(cp, cp->effective_cpus);
>> -
>> -        /*
>> -         * On default hierarchy, inherit the CS_SCHED_LOAD_BALANCE
>> -         * from parent if current cpuset isn't a valid partition root
>> -         * and their load balance states differ.
>> -         */
>> -        if (cpuset_v2() && !is_partition_valid(cp) &&
>> -            (is_sched_load_balance(parent) != is_sched_load_balance(cp))) {
>> -            if (is_sched_load_balance(parent))
>> -                set_bit(CS_SCHED_LOAD_BALANCE, &cp->flags);
>> -            else
>> -                clear_bit(CS_SCHED_LOAD_BALANCE, &cp->flags);
>> -        }
>> +        update_partition_sd_lb(cp, old_prs);
>>             /*
>>            * On legacy hierarchy, if the effective cpumask of any non-
> Calling update_partition_sd_lb() directly from update_cpumasks_hier() may incorrectly force
> rebuidling sched domain when it is not really necessary.
> 
> Cheers,
> Longman

Thank you Longman,

You are correct. Besides the change for the CS_SCHED_LOAD_BALANCE flag, which can lead to rebuilding
the sched domain, the condition of new_prs or old_prs being greater than 0 may also trigger a domain
rebuild, which is unnecessary. I will drop this patch in next version.

-- 
Best regards,
Ridong



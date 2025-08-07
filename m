Return-Path: <linux-kernel+bounces-759165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98443B1D972
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E3717C8F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B9325DAE7;
	Thu,  7 Aug 2025 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QwSs7cDe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722FF1EB5B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574902; cv=none; b=p6z3B2grsyfyOTR5zKews2s1Vy8anSLjDcWxKq1DBzTKtHWv5lY7RpipO3WJx9+393BKhatFcskGtNEf1GGgqkP+Ol/IcsIzfcCzXQO0t+dvHLeLm6zNwNXB2iYrksoN5NA/iQ0BLHPmqQVa9cfy9GuLJo4kryPQ6ddYVZhhvfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574902; c=relaxed/simple;
	bh=UU8/KLeMTZ3w3Iejl4Ec88LM3lsV+Um+Hl9MdDeZPjg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n42ZwViDm+FLe5vo1kgFNC6EipvGlqDY2BF/DuzU2dnYH6QQ006Za7gA7MbA0WX3yfXWwbnERGjAuDNb+ToNCToYJ4rMVp2dUqBdBhgSnE3yM6c9ZkKOQuFd6JDCrtLPBA0XprbDf8gU16hLJ+COZpGjsV8YVff8O8BBiQF0Oos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QwSs7cDe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754574899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5kXOrDwud7Md4kmVdYmDM5WejfgJDxWgdDUd88NMt5g=;
	b=QwSs7cDerEKaxiDtK47SDSSyl3pJ1JysBKZKiruZ73l9Dkh6gErI0S6KECWFRoNTKpsBN9
	QiniNaHk7kSEvym2vKpv326+19MUnvbTxpS2x+Z6h5EVqt+TfZtLmEG9LvlH/0RwwGo973
	qR3mb1uCvHjXZxAzcReRntMvnYNM09c=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-wVrt40ufPqWG20i6q_bzyA-1; Thu, 07 Aug 2025 09:54:58 -0400
X-MC-Unique: wVrt40ufPqWG20i6q_bzyA-1
X-Mimecast-MFC-AGG-ID: wVrt40ufPqWG20i6q_bzyA_1754574898
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e81a449767aso1426792276.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754574898; x=1755179698;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kXOrDwud7Md4kmVdYmDM5WejfgJDxWgdDUd88NMt5g=;
        b=Ia61QFfUTzoFTxiK+AgxP08W6NSOhOPHV+33/3x3kdKG3BuIBKmv7Hb1/+seDcdEn9
         cuMy7/EykB7KUVeSdGhukA09EcusH9VYwRmQEX0npOH07ebXfkt1C0e9b+NK+wJiB2VO
         Z7n/piWbrJQunxH5VFbtIIwdwRf1RPc32cBo5JA044p5hILfPqa1jLcaa4lUAkx+GZXx
         DbLw3O9C+T8dSFFk3DJbzjFIQpneGVWuWHGnlwtUMDWTBBqmh+4pYZY+5BOXtONAIO4v
         QD+TdLwMtjcG//83Xzqq4JsdStgfz7Xh655omA2hR+2JHT4Sbc1LIWw8EkhvMYHZwy4A
         0nAg==
X-Forwarded-Encrypted: i=1; AJvYcCWZbdiX0azrYhY4hn7EQ3meNuOf4ElgT+1sW+X5VMWC7kZ4kj/tcwMcygyEaET7mtcZs71p0+HpkmE4HvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydpbu7GXrRbKYVhEQkdphw4MQzAK5tm/uHy6jQwlJHuJNnTLcU
	vXI45pQ99pmXawWiDyfP63dyz71/PcNzikCjBA6gXgJRS2g8uOsWa8mk9YnvW6ZGH9qlCGAIgJm
	OjP9i/wYu2Pd6rtexhbxVnDtftqEbdCYidkwJvupAm1MtlYT8UioeZWRjr6U+oRWyJw==
X-Gm-Gg: ASbGncv8UsU1hUu/pZJzlIKmP2WHHhRjL1K/qHFp3jUpbQdnAH3e4CTr1hfoNJIF4ti
	U1NMzBPz2zyBkL9mdYsUeER2uWh4JwrLQB8ioXkJpMm10IOHzK7zQ2M5+YzbRsfV0JGJqUdNHpt
	ZxNxWw0rftV1+7tSXijKvss1h8+2rRAsh17+iGhentPXzbu1XZHVDu2/bCRWf8GKGjqRZMGRcdu
	maP4ys19sttW9fzr7Fj8iRJwnII3usMnnldIdvpzup0QphiUlvvVkdhepml3pgzMuDKyEBPy+q8
	FhFCRdhNVby97LganM3KwyrG4ubnlA2AVNLrGbgJB8iiysVGBmIweGFHljH4guii7RJf0aY0hS9
	z6X634mtOrQ==
X-Received: by 2002:a05:6902:1883:b0:e90:493b:e26f with SMTP id 3f1490d57ef6-e90493be49amr1979276.11.1754574897540;
        Thu, 07 Aug 2025 06:54:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhRLkUfURwG4WxqUpYTdWhMDZBK3/LXfHl0BbaQSACa+y2FwwxgrzOaoIU2pQxVH9TQQVp6A==
X-Received: by 2002:a05:6902:1883:b0:e90:493b:e26f with SMTP id 3f1490d57ef6-e90493be49amr1950276.11.1754574897036;
        Thu, 07 Aug 2025 06:54:57 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd3860a9csm6495969276.28.2025.08.07.06.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 06:54:55 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2870d179-a2db-44ee-9183-11efe446ebd9@redhat.com>
Date: Thu, 7 Aug 2025 09:54:54 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cgroup/cpuset.c: Fix a partition error with CPU
 hotplug
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20250806172430.1155133-1-longman@redhat.com>
 <20250806172430.1155133-3-longman@redhat.com>
 <38800495-464f-4bbf-b605-9a6b8d2b4c11@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <38800495-464f-4bbf-b605-9a6b8d2b4c11@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/25 10:44 PM, Chen Ridong wrote:
>
> On 2025/8/7 1:24, Waiman Long wrote:
>> It was found during testing that an invalid leaf partition with an
>> empty effective exclusive CPU list can become a valid empty partition
>> with no CPU afer an offline/online operation of an unrelated CPU. An
>> empty partition root is allowed in the special case that it has no
>> task in its cgroup and has distributed out all its CPUs to its child
>> partitions. That is certainly not the case here.
>>
>> The problem is in the cpumask_subsets() test in the hotplug case
>> (update with no new mask) of update_parent_effective_cpumask() as it
>> also returns true if the effective exclusive CPU list is empty. Fix that
>> by addding the cpumask_empty() test to root out this exception case.
>> Also add the cpumask_empty() test in cpuset_hotplug_update_tasks()
>> to avoid calling update_parent_effective_cpumask() for this special case.
>>
>> Fixes: 0c7f293efc87 ("cgroup/cpuset: Add cpuset.cpus.exclusive.effective for v2")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index bf149246e001..d993e058a663 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1843,7 +1843,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>>   			if (is_partition_valid(cs))
>>   				adding = cpumask_and(tmp->addmask,
>>   						xcpus, parent->effective_xcpus);
>> -		} else if (is_partition_invalid(cs) &&
>> +		} else if (is_partition_invalid(cs) && !cpumask_empty(xcpus) &&
>>   			   cpumask_subset(xcpus, parent->effective_xcpus)) {
>>   			struct cgroup_subsys_state *css;
>>   			struct cpuset *child;
> This path looks good to me.
>
> However, I found the update_parent_effective_cpumask function a bit difficult to follow due to its
> complexity.
>
> To improve readability, could we refactor the partcmd_enable, partcmd_disable, partcmd_update and
> partcmd_invalidate logic into separate, well-defined function blocks?  I'd be happy to take
> ownership of this refactoring work if you agree with the approach.

I agree that the code can be a bit hard to read. You are more than 
welcome to improve the readability of the code if you have time.

Cheers,
Longman



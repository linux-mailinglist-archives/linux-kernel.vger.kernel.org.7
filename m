Return-Path: <linux-kernel+bounces-736978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E01B0A608
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761271C807EE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71442AF14;
	Fri, 18 Jul 2025 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UA+azf+L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594231C36
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848322; cv=none; b=vB0BVRP7kCOoo3jRpq6TLsfM5jZbkc5mK6eQKYYL4W2Ix+yIkk4fuC2ysMSGIbfJu5kQBsSC4DRVLqeOwRT0/BJf2gDOqKtpvxFSKjQ5vk8AqcHmTw8ag7RLAP1dQhhAtppm4cM/K06eUh2fZwZS+Vy+XrRGeXOEdlmHQ1VFY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848322; c=relaxed/simple;
	bh=/HDiIMliCtLNl3z2Bo9OK9anjcaoueDP+L8Oe97p+wk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bxd7FyDaniT6mOCo7QTlN3e0DBBE7P1JgXxBrYry5AjENS07zcvVB+OKcdfkVZUtw4ekS//5/5tIF9bvSyCpBOnwYgL+WzwjNMnK9ki5fY/KGBAaSBBWhkYTbZHgJ7bYwX1mOCanfk3+vSOr8tRGw6POYvgtMaFfn6Gk1Y68VnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UA+azf+L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752848319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TsytLQJcaKqStTtlNqZ83QBux0JcP282gxaqMBrT3E4=;
	b=UA+azf+LgiyyVTEJS1MKlSR8mUuLihiPpLpYmTrFYPGuBgsGireFI1+KGNaFjB6TLmRbR9
	hX39S6I833AEJlV8ymmNkOhBdE0PM+18iBIYXIOkhUibLkV7crUP98lERkTTQNhAKaZGmd
	QkBjvLKGycxJ7yr/25VfoL0D4eaF/MU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-VReryGseOKGY_H6E-pG2TQ-1; Fri, 18 Jul 2025 10:18:38 -0400
X-MC-Unique: VReryGseOKGY_H6E-pG2TQ-1
X-Mimecast-MFC-AGG-ID: VReryGseOKGY_H6E-pG2TQ_1752848317
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b34fa832869so2424863a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752848317; x=1753453117;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsytLQJcaKqStTtlNqZ83QBux0JcP282gxaqMBrT3E4=;
        b=F6jLiYrcGrNVW50YPeVX2NfPKbNz3KXfv5G1SctsMKjucU1zlJUMxr5xy3KOYVMJ3F
         VIFVy9OAhdSOLcVsS9TJ9dzxhCSgayuCVwxC0Mqk9muxYcfjhu1Fc8Uh4QAHWE9rxkfz
         el0CPwbDU+579coA7fzqjbyzfvDtXayVlF/yXe031dAeClEpGyrON1wIcSLiFxq+cVHh
         kk6ex8kR25WttKySIQRMNTX5eFDwKZ9kAitB0eoJ6N9VdrO9RnSSYJDwit3dgbRELec/
         uT1eoxwg0sORehO6DHpmA6n6qk6WPFONRMFHvAVTFEOxy7F4cYp613pWGhBykFhhTrYU
         bMew==
X-Gm-Message-State: AOJu0YyICRA4SbXqUvVRWUVNd0w9i7F8605PMOKvLXEV3XTYuk2VgdsL
	4Ltf0fMiH0MLQjlqnTwbcZRlTdku6K4pTVlvu29WSfa57IwkbzJaDWJPyeooT7ki5VUEZC/Sydv
	1PdgPE4wf0PwJLUluuWbuRQOF/Jd4/U69QWFYrgwBfNE8Bnn4U/mZhu4oDg/YapsRsQ==
X-Gm-Gg: ASbGncsbUjiLz16wNAlxjvMZq7X3pEHr5FjBEoYXm26b7Dxr03bb+ZF9xzFQeod7DGD
	c9yMVtY2oNkQ5gxpgTjvA7mQmXSdjG+spTl+XASzEbV8j9hBBNm2fS7pBh62du6NEjW0kG6GN+I
	z6R6lxklZ1ocI44HG1RF4k2aB2S4efTAgAFJoWnRAeSFQ8E5X9bLt6uhGpwQ3vy0MOehH7VhPCW
	2+OL4VecImikQKmFZzb8Baa6D2C147Dojz6SJvhp+fdQqEBDvMiKw+aW7UurQw3rcPD7viopXcq
	dK/T0O2i6Vcqon2W4qQCTriI1o7DN8O81/hZUW+WQSreoGm5lcl2C15jOw9JD/O1uPtA0voqOeY
	YsolcVYEOzA==
X-Received: by 2002:a17:903:f90:b0:23e:24d2:6e46 with SMTP id d9443c01a7336-23e2f6c6aa0mr107267305ad.7.1752848316948;
        Fri, 18 Jul 2025 07:18:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgJXo3Ori6iK5y2C4lk98DEkbJptwCJ4VpQy0rRUYTnCJzR3LlRZOLTKRIOjjII/Kn2Ms2VA==
X-Received: by 2002:a17:903:f90:b0:23e:24d2:6e46 with SMTP id d9443c01a7336-23e2f6c6aa0mr107266675ad.7.1752848316322;
        Fri, 18 Jul 2025 07:18:36 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4afesm13978015ad.110.2025.07.18.07.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 07:18:35 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <209dd5d0-81bd-49d2-9b96-9839d2e399a5@redhat.com>
Date: Fri, 18 Jul 2025 10:18:32 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/core: Mask out offline CPUs when user_cpus_ptr is
 used
To: Chen Ridong <chenridong@huaweicloud.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
References: <20250715155810.514141-1-longman@redhat.com>
 <faab5c42-ec95-443c-b748-b3e7e359c934@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <faab5c42-ec95-443c-b748-b3e7e359c934@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/25 10:42 PM, Chen Ridong wrote:
>
> On 2025/7/15 23:58, Waiman Long wrote:
>> Chen Ridong reported that cpuset could report a kernel warning for a task
>> due to set_cpus_allowed_ptr() returning failure in the corner case that:
>>
>> 1) the task used sched_setaffinity(2) to set its CPU affinity mask to
>>     be the same as the cpuset.cpus of its cpuset,
>> 2) all the CPUs assigned to that cpuset were taken offline, and
>> 3) cpuset v1 is in use and the task had to be migrated to the top cpuset.
>>
>> Due to the fact that CPU affinity of the tasks in the top cpuset are
>> not updated when a CPU hotplug online/offline event happens, offline
>> CPUs are included in CPU affinity of those tasks. It is possible
>> that further masking with user_cpus_ptr set by sched_setaffinity(2)
>> in __set_cpus_allowed_ptr() will leave only offline CPUs in the new
>> mask causing the subsequent call to __set_cpus_allowed_ptr_locked()
>> to return failure with an empty CPU affinity.
>>
>> Fix this failure by masking out offline CPUs when user_cpus_ptr masking
>> has to be done and fall back to ignoring user_cpus_ptr if the resulting
>> cpumask is empty.
>>
>> Reported-by: Chen Ridong <chenridong@huaweicloud.com>
>> Closes: https://lore.kernel.org/lkml/20250714032311.3570157-1-chenridong@huaweicloud.com/
>> Fixes: da019032819a ("sched: Enforce user requested affinity")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/sched/core.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 81c6df746df1..4cf25dd8827f 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3172,10 +3172,15 @@ int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx)
>>   	/*
>>   	 * Masking should be skipped if SCA_USER or any of the SCA_MIGRATE_*
>>   	 * flags are set.
>> +	 *
>> +	 * Even though the given new_mask must have at least one online CPU,
>> +	 * masking with user_cpus_ptr may strip out all online CPUs causing
>> +	 * failure. So offline CPUs have to be masked out too.
>>   	 */
>>   	if (p->user_cpus_ptr &&
>>   	    !(ctx->flags & (SCA_USER | SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) &&
>> -	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr))
>> +	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr) &&
>> +	    cpumask_and(rq->scratch_mask, rq->scratch_mask, cpu_active_mask))
>>   		ctx->new_mask = rq->scratch_mask;
>>   
>>   	return __set_cpus_allowed_ptr_locked(p, ctx, rq, &rf);
> Hi, Waiman,
> Would the following modification make more sense?
>
>    	if (p->user_cpus_ptr &&
>    	    !(ctx->flags & (SCA_USER | SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) &&
>   -	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr))
>   +	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr) &&
>   +	    cpumask_intersects(rq->scratch_mask, cpu_active_mask))
>    		ctx->new_mask = rq->scratch_mask;
>
> This can preserve user intent as much as possible.

I realized that I should have used cpumask_intersects() instead after 
sending out this patch. It looks like you have come to the same 
conclusion. I will send out a v2 to update that.

Thanks,
Longman



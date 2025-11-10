Return-Path: <linux-kernel+bounces-894149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AADC495C3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 568A04E7F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF1F2F5339;
	Mon, 10 Nov 2025 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmuyUEr1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mP4igTrO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5C2DEA75
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808855; cv=none; b=I29eLJVxqNFPGRiDAIYrj6lexQrIpRK+uGxSagq0rwK0mU65Oi2K0AxQiu1Gp+OYB9U5ZX/hixWT7YfSyLDd1Jg7hVph1Cd9WQH6He/xkue3xA0Mz/BOGNkIxnS0NohgOluF0YvI94mIDW5HzNLZDoQ9vWi1bLxkrIaJF3w2oWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808855; c=relaxed/simple;
	bh=HYLpaDIFFmRbErNHuMjaxj7xtRgkMf46+BSt9pdawFA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cZLz1q403W77mhcM45MfEgGT+GXojgQrZc1bftbcerL/TXzQhQ6YMNsSRNHXy4i89sW6iRhM4bnMVyop5JYKZEHIewdvpgPnPmPpK8ZI7eow6qWm0q+cvEA6Re4Dhj/9O/zyLb6Jj/Pxpg3GmS2ksuitN4BgfHp4s3mcoLs32SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TmuyUEr1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mP4igTrO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762808852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDmlWWnJ9LNZOiPKn3DFUPRfDwFb+URHb1lJC8JwKx0=;
	b=TmuyUEr12sp3GRKKmJMOW8B7PRLWhXbHbsIkT76DcyuY38YtTs7k0fo0G+CJs3gPY/QA1Q
	B0jdUbMlytj1Na3bhXa52r5jCUkLxoAisUTkp5N7F9tTDWpXwGF6WasTtiWCDMv/NHCG5f
	qq4BNr0mIH7aEo1Vl6EucNwb5/7Ht4E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-0CW1e_YoNYeAMHppy6lsng-1; Mon, 10 Nov 2025 16:07:31 -0500
X-MC-Unique: 0CW1e_YoNYeAMHppy6lsng-1
X-Mimecast-MFC-AGG-ID: 0CW1e_YoNYeAMHppy6lsng_1762808850
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b2359efeb3so47587285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762808850; x=1763413650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yDmlWWnJ9LNZOiPKn3DFUPRfDwFb+URHb1lJC8JwKx0=;
        b=mP4igTrO3GQkcn6lazM7ul3diTSUSsueWU7NiacvMN2Jm+N5BmLO7K9MRiz6XkBkZB
         r4kWLn9tc+HBXTLzTNq1LSstubeaWAlm9YOscoD/rxQbGAEoY+si4qxlFsJ7BcdWAOfB
         CfNwDFus5NI6Be4HMi8w3uMzWvbl2mRrYayYhW+H775ivn/0BWUhdh5L4C+RURFytGI8
         ah+wT7lrz5OiE31aORGOjNNcdNO5Vj2eIw7o0lTPkx7itasuV/WahZ3++U1e4nG7p744
         Tl8M0+jSBGuV2j5pkmRpVBN/oyf0DA6QYNOuExtyY1jM09ACwURG90YK6KKT12yRL3zs
         nhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762808850; x=1763413650;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDmlWWnJ9LNZOiPKn3DFUPRfDwFb+URHb1lJC8JwKx0=;
        b=hU1JCnswZWaPLP9jI77bPQI/F8lvjOyElab4o3j+2I0H/LNmth8NZ7T/D9fhCdVeGQ
         xpvzVMw65JeiaoyuOtZl/yXT0WC0f1EfLRUlXZ4frzt+nUcAzPch1tjteyei9jJGkLAX
         1GBCWu6VQyb6nAbGPWkJ32UkcBMFh2S4pb+gl+k8FWn5ZOfpXV8+jD1qBcCkre6mo5sD
         mXn9vDfigPdohAWpyte2IhgAccshyc5OCAGXDsw3KJINTLz+N6/KKjGQv3AdPoFdXCmp
         An0W9xCUo156C1VR9wbqEd4A7IrJqnhyzamRtDM+jqstIZGlHzLiKDfRS8ziDUnBOBOK
         I9Kg==
X-Gm-Message-State: AOJu0YyaHEAn7vv/IpH93tr+1fZkjaHGOBO7SXAL3YbRGNMY3HrM9ezp
	qYMNSHyoIuM6667CeALFsxuuuCVF/tGft3u/Y9XiYavXSWO+2OLDQml/Ar4tRZjA/DY1oS9b6qs
	V72IituizCCoMJnIhJnnx58/2rnQhbFPII+/ThQWUP77cYKVXMgMcV8Dm9Hcpo6FzUw==
X-Gm-Gg: ASbGnctxjT1ILuB4Yiq5PIMNA1vcG9OCSWu/lEBtJHHOOpdaTyFOmlO9+Axgg8bHenG
	l/Xnwa4DpA1AK1DxdOZ0bK4McAj+r6rI9CBZhSsbG5BGdLxhNEMEXu2IDMIXOoprD+fhyXbzCSM
	dA72b/hvSEk/Xr1I8S+4ywX4NASZ5UVsr2ebj0KCGdJ8wy8a6hgI1Ai+S+8Q9K4lOJaX9Pjn4nY
	8wrXLV3FMl+2s1EvPHcUN9y4gKFZd4xgB3ic3hhyWfQX02XcTU9UQR1QJkPsEQJ332e/0pKej6r
	heS76PI0naZ+pdeUFPhi/ACPB6zyGGm+4uMVuEhDLz68Na9hhvjr3ZHp4OGYG8QMRNIttbXUNDO
	RlyOVfB8U9dRk/RFJn16c2fbDADBvid+Hite7o5R2+PvyjQ==
X-Received: by 2002:a05:620a:29c6:b0:828:faae:b444 with SMTP id af79cd13be357-8b2889f82d7mr127219585a.20.1762808850489;
        Mon, 10 Nov 2025 13:07:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiGdBBnRPxD9uTF5lLasoa45ck94U1rvaavT8cQcpaGKicPjD/8O6YY1FWFwE0DxZXBn0wSg==
X-Received: by 2002:a05:620a:29c6:b0:828:faae:b444 with SMTP id af79cd13be357-8b2889f82d7mr127215085a.20.1762808850076;
        Mon, 10 Nov 2025 13:07:30 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235826d4fsm1074022485a.50.2025.11.10.13.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 13:07:29 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5e0bb3f1-2efc-4302-aff0-80d5999c7700@redhat.com>
Date: Mon, 10 Nov 2025 16:07:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5] sched/deadline: Walk up cpuset hierarchy to decide root
 domain when hot-unplug
To: Juri Lelli <juri.lelli@redhat.com>, Pingfan Liu <piliu@redhat.com>
Cc: linux-kernel@vger.kernel.org, Chen Ridong <chenridong@huaweicloud.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20251110014706.8118-1-piliu@redhat.com>
 <aRHJHxfEI-tnotRe@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <aRHJHxfEI-tnotRe@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/25 6:14 AM, Juri Lelli wrote:
> Hi,
>
> Looks like this has two issues.
>
> On 10/11/25 09:47, Pingfan Liu wrote:
>
> ...
>
>> +/*
>> + * This function always returns a non-empty bitmap in @cpus. This is because
>> + * if a root domain has reserved bandwidth for DL tasks, the DL bandwidth
>> + * check will prevent CPU hotplug from deactivating all CPUs in that domain.
>> + */
>> +static void dl_get_task_effective_cpus(struct task_struct *p, struct cpumask *cpus)
>> +{
>> +	const struct cpumask *hk_msk;
>> +
>> +	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
>> +	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
>> +		if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
>> +			/*
>> +			 * CPUs isolated by isolcpu="domain" always belong to
>> +			 * def_root_domain.
>> +			 */
>> +			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
>> +			return;
>> +		}
>> +	}
>> +
>> +	/*
>> +	 * If a root domain holds a DL task, it must have active CPUs. So
>> +	 * active CPUs can always be found by walking up the task's cpuset
>> +	 * hierarchy up to the partition root.
>> +	 */
>> +	cpuset_cpus_allowed(p, cpus);
> Grabs callbak_lock spin_lock (sleepable on RT) under pi_lock
> raw_spin_lock.
I have been thinking about changing callback_lock to a raw_spinlock_t, 
but need to find a good use case for this change. So it is a solvable 
problem.
>> +}
>> +
>> +/* The caller should hold cpuset_mutex */
There is an upstream patch series that will add a helper function to 
check if cpuset_mutex has been held. So this comment should be replaced 
by a call to that helper function once it is available in the linux 
mainline.
>>   void dl_add_task_root_domain(struct task_struct *p)
>>   {
>>   	struct rq_flags rf;
>>   	struct rq *rq;
>>   	struct dl_bw *dl_b;
>> +	unsigned int cpu;
>> +	struct cpumask msk;
> Potentially huge mask allocated on the stack.

Yes, we should use cpumask_var_t and call alloc_cpumask_var() before 
acquiring lock.

Cheers,
Longman

>
>>   	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
>>   	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
>> @@ -2891,16 +2923,22 @@ void dl_add_task_root_domain(struct task_struct *p)
>>   		return;
>>   	}
>>   
>> -	rq = __task_rq_lock(p, &rf);
>> -
>> +	/*
>> +	 * Get an active rq, whose rq->rd traces the correct root
>> +	 * domain.
>> +	 * And the caller should hold cpuset_mutex, which gurantees
>> +	 * the cpu remaining in the cpuset until rq->rd is fetched.
>> +	 */
>> +	dl_get_task_effective_cpus(p, &msk);
>> +	cpu = cpumask_first_and(cpu_active_mask, &msk);
>> +	BUG_ON(cpu >= nr_cpu_ids);
>> +	rq = cpu_rq(cpu);
>>   	dl_b = &rq->rd->dl_bw;
>> -	raw_spin_lock(&dl_b->lock);
>>   
>> +	raw_spin_lock(&dl_b->lock);
>>   	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
>> -
>>   	raw_spin_unlock(&dl_b->lock);
>> -
>> -	task_rq_unlock(rq, p, &rf);
>> +	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
> Thanks,
> Juri
>



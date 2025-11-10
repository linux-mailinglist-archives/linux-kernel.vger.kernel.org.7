Return-Path: <linux-kernel+bounces-894219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D2BC497F0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5903D1888AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF2D2F549C;
	Mon, 10 Nov 2025 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzJGKVat";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7LA0ueK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69907285CB4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762812982; cv=none; b=I7UxpXYua46hv452e1PIm5ORYEM7SxMqSLu3mX0SWPBOXDBcL6n2W9U7B2rXB5ERJ/9uTNBaawKrD11kzx+EuFyQJFqcaYb87mvILnMLLajGi+W4kslLneGgL5Y7ueyKcQzj54vHDrbgWmgZMU5QB5oyXWuhFXj+2575bMP6BtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762812982; c=relaxed/simple;
	bh=73ueMr3Pr96Ipfgbfr1DzJtn1K1avfkmy6mQN1KumAg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qpldKTGpu1vUjpm80jHdKlzNXF31pYMLGFNWH2Zup8G9VDqVzJi3enIBSGQDduvYbXQN51vBoRzc6YgzGFb4poYbuAdMVyiTBnuf44CNSsWCG9uVWqpwndsx9wlgqbAIqkqz9sjBoRQW1isq15pn5rfyLpoEDnVCaKCzeRESiyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KzJGKVat; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d7LA0ueK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762812979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McuuBQVyR0vl9LwWyFVAj98fKa0KbUhb567SrQgA7Sg=;
	b=KzJGKVatKfH6ojc+uIMDq6k1skYaFmUNZzpNxAW+Vgn4iaNfYq9jjgquVUaY+5evaI6if8
	DGQttpkB6K3ycCIrLYZoN5FAnD60yvOzuR7n54CQD0Jw3U8/7E1Zz//9qCCvWcaEumA8BW
	SKhFDT1U9tNelJ2TJTpKkT1PxmWfaV8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-1-a5MBauMNCz-Kf2UqTFXA-1; Mon, 10 Nov 2025 17:16:18 -0500
X-MC-Unique: 1-a5MBauMNCz-Kf2UqTFXA-1
X-Mimecast-MFC-AGG-ID: 1-a5MBauMNCz-Kf2UqTFXA_1762812977
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-44daa038f50so4063643b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762812977; x=1763417777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=McuuBQVyR0vl9LwWyFVAj98fKa0KbUhb567SrQgA7Sg=;
        b=d7LA0ueKCbpfErFOlAgwDtclBgRmUqdLVt5TqIje5yeY1RQDF5xMe2iDzJEYAVlB3O
         ln3RAIvNgMtkxzM6WE6ghxTIqiz0hBu9/qLdL6ZUTh4DildaPRqZrY9mwqYmXE0DYfeK
         kuggHC5t9hUSm+K5BYnbBycKrciZg9aFDXABQpWQpv0+6DwoUwiaxfTU29RwMfAx7hZG
         hIwfcFggdUTXYSKOiykdjOZ3GftxDIM3dF+sLBNWlRpCY69O+jTBmOtjOY38PLq7CEOx
         bCeF96DhAiQs0e619/3/SpPqrmfkbwP2isG/W7s6rqDH9nxM2JaZFo8AVcLgeHq/Cf9D
         dOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762812977; x=1763417777;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=McuuBQVyR0vl9LwWyFVAj98fKa0KbUhb567SrQgA7Sg=;
        b=O1S9AbeEh4LXVTVJC9GzO3007C04ItKSBgn6o3Xkgib4BskjWpGYFDmg3Oq4mVW2WF
         KVvdaKPau8aADOgaeQPw0WZ6Rwr5mOGrckB7iPRVBcz2OTouurJRJnItcIiCauamtO70
         a/PGdTNeQY6Gk7PQWT+U51/ByI8K806IGUhfgfgEkt5y1EFRjWaYbvTx0P/p/BzUEO/r
         4JqvSRnFzT5v7jDFLzzPwzHpuxu0Pu6n8YaZC7JYEkWy6hPABNJYYFv1k6jADsoWMII/
         fwgACrdAVi2lNvqgi2c0nNwfNYfW8Ypt/VURtSJ32tosms98R4MgabxgXmsRgZBkANCy
         KuNg==
X-Gm-Message-State: AOJu0YywfjilxEQ95Nhlu+AuSQlwIqifCl0bA+VaZqlMzr1YpaLFO38k
	8d4CK0A9B1Oa10vCowdP2qGgqlpBzINd7A1E+xNwSErwtGTR9vNQY3Obq7SWZSaDYKAHISr+H5V
	I3efa5UP6RVpOx/eh+SuWimh4QuvzILOUfBX1MDnbDuTKM6lcGpaxq3uW+sQ+/N+c5ENou2MHMQ
	==
X-Gm-Gg: ASbGncuYoTcRuTgHcIZjGXwHqqiJccsKpHSGN1+J7wqGihz9yIkFLGIgNdh7GmgYe5C
	p6DnduGJjsOAsVZ1h581h8CwNDLI6LB/hsxBJPtHzwOiVVp6YHC460UFuC9nh/a+zfjWAuMEDs3
	E0sgGV+T2l0YsLBP0CmoRytlhlydRYCGBZQSKrqL2RV0cG3cXRWxnoQVo44i8TUZakgWjBKaIIF
	UeR1SHAjk1Kk2pzhCI3IUE1Nuwzc8nIUzgavj/YMc/y/fA6n/pTk3W4lxJaKuZ94SOSH+fCg8ZT
	K1/CmuM2w2A/oTdXkmDNHNNznGCXYxlJW3eFg+GVRzgn/9wZJPlODQxpPZhXWHa6HiQXlzY8Mq5
	4rtq45fggv1L0z74+iybdN+pRrv61NJ4b6LXT4phOkItnLg==
X-Received: by 2002:a05:6808:1889:b0:450:4628:e3ce with SMTP id 5614622812f47-4504628f033mr3487569b6e.15.1762812977057;
        Mon, 10 Nov 2025 14:16:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvxltUBPkDinXjT1uuMSFLLNGXfzZBB2k/tbk8+MIS3PKM+ctmVXcXFZP9/gmTshh1tnvL8A==
X-Received: by 2002:a05:620a:1065:b0:8ad:3bc8:3cdf with SMTP id af79cd13be357-8b257f0515emr1014004285a.29.1762812538644;
        Mon, 10 Nov 2025 14:08:58 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b23580c7f9sm1087396385a.44.2025.11.10.14.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 14:08:58 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d42cd14d-46da-41b4-b580-f112baf0dfdb@redhat.com>
Date: Mon, 10 Nov 2025 17:08:56 -0500
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
 <5e0bb3f1-2efc-4302-aff0-80d5999c7700@redhat.com>
Content-Language: en-US
In-Reply-To: <5e0bb3f1-2efc-4302-aff0-80d5999c7700@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/10/25 4:07 PM, Waiman Long wrote:
> On 11/10/25 6:14 AM, Juri Lelli wrote:
>> Hi,
>>
>> Looks like this has two issues.
>>
>> On 10/11/25 09:47, Pingfan Liu wrote:
>>
>> ...
>>
>>> +/*
>>> + * This function always returns a non-empty bitmap in @cpus. This 
>>> is because
>>> + * if a root domain has reserved bandwidth for DL tasks, the DL 
>>> bandwidth
>>> + * check will prevent CPU hotplug from deactivating all CPUs in 
>>> that domain.
>>> + */
>>> +static void dl_get_task_effective_cpus(struct task_struct *p, 
>>> struct cpumask *cpus)
>>> +{
>>> +    const struct cpumask *hk_msk;
>>> +
>>> +    hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
>>> +    if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
>>> +        if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
>>> +            /*
>>> +             * CPUs isolated by isolcpu="domain" always belong to
>>> +             * def_root_domain.
>>> +             */
>>> +            cpumask_andnot(cpus, cpu_active_mask, hk_msk);
>>> +            return;
>>> +        }
>>> +    }
>>> +
>>> +    /*
>>> +     * If a root domain holds a DL task, it must have active CPUs. So
>>> +     * active CPUs can always be found by walking up the task's cpuset
>>> +     * hierarchy up to the partition root.
>>> +     */
>>> +    cpuset_cpus_allowed(p, cpus);
>> Grabs callbak_lock spin_lock (sleepable on RT) under pi_lock
>> raw_spin_lock.
> I have been thinking about changing callback_lock to a raw_spinlock_t, 
> but need to find a good use case for this change. So it is a solvable 
> problem. 

Actually, we don't need to acquire the callback_lock if cpuset_mutex is 
held. So another possibility is to create a cpuset_cpus_allowed() 
variant that doesn't acquire the callback_mutex but assert that 
cpuset_mutex is held.

Cheers,
Longman



Return-Path: <linux-kernel+bounces-777218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24769B2D6F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9D83B2433
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38002D949B;
	Wed, 20 Aug 2025 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csS1OKvD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DE22D6E73
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679428; cv=none; b=Cj+q6AT0ImZ6WuJJt/W7CykhdHEvyl+xt+m0nUJmlym9+mmOUooiSbOfjRb4LEaAVJoLoRM1swFOul1PAcaCnePqbUtnwulVWwsCv4lAa3FCCbYwm7bVFLhm3N7llDtzbuBx0tXYBuJzxB1idKUqBmWFVajMTn0mU5I7PJqLd7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679428; c=relaxed/simple;
	bh=G1h8efYazpeQ8uAE6JYn8rZ/ip62/Dzz0UAYoe4kl3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WIMPvvVCd5pxfGnxjhsNeW3JM0k27Cz1JJSgkRMeFFOOl3LpyQapiaz447chCFrx1B0n88h3BnOhAeI10PFTykl+CfkvK4O3KLJ1KnIyJ0K8l2wSSj+14scYsHBZJZOBesVtpVZn893Y+Mr0QnBi7+IE+R6R8taZ0UQZIlt7T54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=csS1OKvD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755679425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NkjQJxuaLz1Ic3cd/+1JftzXHv9RBnWzcArcLhUMO/o=;
	b=csS1OKvDcUOEZlbedKQYiYkQaQ8UE9WWQTGjj9C70HhhRxMRFBFLvUFDYG/1GpD7E+YFXa
	Mt9unaMuK5hdLY/kVgILXx/M9TsE+FM9tvjgKC4GnppQHHK7RVPmW4NeMS+cTDCvysV/XS
	TRpLiAWZbOII0I6+0FYEzBxohdG/MUs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-63eSMpjYM9mhJsVeixqgfA-1; Wed, 20 Aug 2025 04:43:43 -0400
X-MC-Unique: 63eSMpjYM9mhJsVeixqgfA-1
X-Mimecast-MFC-AGG-ID: 63eSMpjYM9mhJsVeixqgfA_1755679423
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e87031ae4dso681615585a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755679423; x=1756284223;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NkjQJxuaLz1Ic3cd/+1JftzXHv9RBnWzcArcLhUMO/o=;
        b=eks2+Q21OoKdqUtpuThfwR9T+GxDahDk9Fx9BN9aooRLqEp7OGgJzl0AcjM2S468kk
         ScqxMVTu024hOxOPBg2oKAZoymLBvchpw/WnnkMY7VO3gt1j1BSgg6rj70xUBrBJiXtE
         VAGx81K//JmK2YIaxfYRKZfL7iy9i36K3/O6uNKkskGWIPEeNBjgR34+CAICwj1r162X
         yKGeGNRDQcLGiEZQhrL4/ebzCf9ZBhUqYTo6yQ1UBT9eJL1MwVjOr01B2k/iKmSht6Gq
         p4912fvjeAOAmje3GqB72ufOWwmJmZAf0CFSpX8vwIWWA4L9vHwlZUboeUM6Q2EDloYR
         Pt6w==
X-Forwarded-Encrypted: i=1; AJvYcCU5r7ZYUdHv+hxt7sMhiIMBwtfwb5XJquqwrJGH3B5TpNGvR1Gb1YUJQPObzwJQY+sHG+XNw2Q3K4YDmlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH7KtioZGInfM3+82tl8ZWoBu3vdxwax5dWme5LH+WajKSIPd2
	wt4hILiB6SVyNt97wLv9NCpFUIGuKQyGGlSpJq/oi7i7jqFgGMpOwUO4PSYbua1IhoeTCXl5kVy
	G7MNqGnLIJ6BTYsLNIpWX2/yD7l0zdfAeozyzSp37sT8qXXvGTGMQ18oV0BU8ou73Mw==
X-Gm-Gg: ASbGncvFQF54ISBTeKeFH1bgSDpSIuu0om4rpbVD+2P3xLTZyUPnuig/TTNVYLxR7+7
	adVUtksDQSpDNNcENnnZXbt0ltEIKih/gJNs9wZrS3QeRb5uEJ+bjM7t2C+aX5ya+vORVzunJlK
	DTZ7Iag/Y30sazKpOwHp1bhLkVKkCy8h/we0FDqF26ilL2SO6Tn4dExFyx6x9KaGO9gd+ol2t4L
	Wk5hELPUZjZbnyl7LEt4VYiozhu5WSK151ZP/Z3hHiRXBRapjUgdHatAXUJTwIyIeVqLfJWTssp
	qdYIe7qb6JfJcm7cUUZkoyXmx7jX7DRTe8GHsJfHW2E21ej9sCvwRqVarNXwtLQmnUDQsmcyDbQ
	raRbgFtXx5egjD0TBfUxfjuGM
X-Received: by 2002:a05:620a:4103:b0:7e8:1853:a40f with SMTP id af79cd13be357-7e9fcb9ab96mr221992985a.58.1755679423098;
        Wed, 20 Aug 2025 01:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcoibAu0ez0AiJEUPxp6IDr+/DFJY4gh7kJ5dH42mKPNrIBGsLREMZKf1PQxsGhsziHZAIkQ==
X-Received: by 2002:a05:620a:4103:b0:7e8:1853:a40f with SMTP id af79cd13be357-7e9fcb9ab96mr221990585a.58.1755679422684;
        Wed, 20 Aug 2025 01:43:42 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba902f4edsm83427236d6.14.2025.08.20.01.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:43:41 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, cl@linux.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for
 ILB CPU
In-Reply-To: <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com>
References: <20250819025720.14794-1-adamli@os.amperecomputing.com>
 <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com>
Date: Wed, 20 Aug 2025 10:43:38 +0200
Message-ID: <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 20/08/25 11:35, Adam Li wrote:
> On 8/19/2025 10:00 PM, Valentin Schneider wrote:
>>
>> I'm not understanding why, in the scenarios outlined above, more NOHZ idle
>> balancing is a good thing.
>>
>> Considering only housekeeping CPUs, they're all covered by wakeup, periodic
>> and idle balancing (on top of NOHZ idle balancing when relevant). So if
>> find_new_ilb() never finds a NOHZ-idle CPU, then that means your HK CPUs
>> are either always busy or never stopping the tick when going idle, IOW they
>> always have some work to do within a jiffy boundary.
>> > Am I missing something?
>>
>
> I agree with your description about the housekeeping CPUs. In the worst case,
> the system only has one housekeeping CPU and this housekeeping CPU is so busy
> that:
> 1) This housekeeping CPU is unlikely idle;
> 2) and this housekeeping CPU is unlikely in 'nohz.idle_cpus_mask' because tick
> is not stopped.
> Therefore find_new_ilb() may very likely return -1. *No* CPU can be selected
> to do NOHZ idle load balancing.
>
> This patch tries to fix the imbalance of NOHZ idle CPUs (CPUs in nohz.idle_cpus_mask).
> Here is more background:
>
> When running llama on arm64 server, some CPUs *keep* idle while others
> are 100% busy. All CPUs are in 'nohz_full=' cpu list, and CONFIG_NO_HZ_FULL
> is set.
>

I assume you mean all but one CPU is in 'nohz_full=' since you need at
least one housekeeping CPU. But in that case this becomes a slightly
different problem, since no CPU in 'nohz_full' will be in

  housekeeping_cpumask(HK_TYPE_KERNEL_NOISE)

> The problem is caused by two issues:
> 1) Some idle CPUs cannot be added to 'nohz.idle_cpus_mask',
> this bug is fixed by another patch:
> https://lore.kernel.org/all/20250815065115.289337-2-adamli@os.amperecomputing.com/
>
> 2) Even if the idle CPUs are in 'nohz.idle_cpus_mask', *no* CPU can be selected to
> do NOHZ idle load balancing because conditions in find_new_ilb() is too strict.
> This patch tries to solve this issue.
>
> Hope this information helps.
>

I hadn't seen that patch; that cclist is quite small, you'll want to add
the scheduler people to our next submission.

So IIUC:
- Pretty much all your CPUs are NOHZ_FULL
- When they go idle they remain so for a while despite work being available

My first question would be: is NOHZ_FULL really right for your workload?
It's mainly designed to be used with always-running userspace tasks,
generally affined to a CPU by the system administrator.
Here AIUI you're relying on the scheduler load balancing to distribute work
to the NOHZ_FULL CPUs, so you're going to be penalized a lot by the
NOHZ_FULL context switch overheads. What's the point? Wouldn't you have
less overhead with just NOHZ_IDLE?

As for the actual balancing, yeah if you have idle NOHZ_FULL CPUs they
won't do the periodic balance; the residual 1Hz remote tick doesn't do that
either. But they should still do the newidle balance to pull work before
going tickless idle, and wakeup balance should help as well, albeit that
also depends on your topology.

Could you share your system topology and your actual nohz_full cmdline?

> Thanks,
> -adam
>
>



Return-Path: <linux-kernel+bounces-777605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1C6B2DB9F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD7A1C20754
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3658F2E5402;
	Wed, 20 Aug 2025 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJrtKILM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC751E51F1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690429; cv=none; b=VgKMV0jwvBbRFc/ThvFCBZ02/Gd7gWNpOrjetjnxAD5J5amoRwbglQyaUH8egNEQrDZLM06cd7KskKhoF/4SrjlQrdbGwMbyzWm4G1vGywKq0Ps+Ud+LstK/T1yXgJN0Bg1t1Nm2vrXy4/P04aCz0HTWMdv8Hd/K0CRWv3I+HsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690429; c=relaxed/simple;
	bh=SXb2dxIY98FzH23JrE5Xq5s77LvtW+Hcp2+gyj2F6Z4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uRpcoTkErADOZXdhHGTAGUzyWZFbawUK1Gp6VTkGsyvQ2Nx/TJmbJZKRSE7YS2aauVn9uWQJF54DJLZXsE6zGdMykL/RCAYUzN3wD7rPlhp2RYJ5AXlzoiVKUT+umqkrnXNr87AZrsWUPaExkDN3nAi6hpip2fQgTPjj3wkfKUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJrtKILM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755690425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OoPxwTsXBEbSnEgA9frRZsmF7p28dq9me5DsfnFcIsg=;
	b=IJrtKILMmEsrelvlXWSUjCT2aRUO2XuU6YhoSVFAAKMg+wZhb7G1Vme9UW3fXRuf2/UkBw
	XwsS2ZSNFPmQwu8tIdSsb+jEpXcL+XJ3e+bV/BFianqVG0r2d48mzam++SJGR14v58Jvl/
	uabXNDU/5UxhXBZckYYhHrCLUua9fIw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-J8pw6pr2OTCGQAjnGraNIw-1; Wed, 20 Aug 2025 07:47:04 -0400
X-MC-Unique: J8pw6pr2OTCGQAjnGraNIw-1
X-Mimecast-MFC-AGG-ID: J8pw6pr2OTCGQAjnGraNIw_1755690423
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0ccb6cso33420155e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690422; x=1756295222;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OoPxwTsXBEbSnEgA9frRZsmF7p28dq9me5DsfnFcIsg=;
        b=AvKx1fxq13mWK9IvZBdnCxp+JrIs92r/kOcH7Veurvxqv9/99DqRKPqvNuzWhpLKOh
         QGV3otQTjrfI5LIItaHeZxIwmZoAKqFl2nR9bIwW5gPY3QRG+BWInY1ZohL1Ee8OzpUc
         omXR39Kl4HkbxMm+q1AMHDgbgQUxwceLc+v+kggXa6lzT7zlBUJk9nZuU5iM2+Zl28BV
         2i0bYxBdHSGpurpjdA07uFn49NuRqXtXH/AyPpC2PX9VNoWMp7rGZzRvshy/Tpb8LcWj
         yZcPrG50Ooq3xkUDKKdLKiyNqz07NTq0u6t5pYE6DH53W/HPGCW4w1aDdjjLiLdTq5nt
         FHOg==
X-Forwarded-Encrypted: i=1; AJvYcCX8fyrtAv6IyxwDyf8q7a6/io0q0obpDLIY+z1RW3V9NzOPahHea0SsNGJHHHWR9ebw4cx8STTA7VwKWlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwunT6jgAI9Q8dRGw77L6jOlxjyqouXBISxouIOhezyvCtDDdc1
	B9L3ZuX8x1ZmUaPgIt1tH2PqRSWqf2Cz9TqGnqY6eCbQS1FWge31J60SzYB/NHgyCAMQdmF7sBt
	b1nDMdc9kYt4KidIo6EFB8j+Xp2oL0JXgS4yM3+cRfWGfGilRT8s8s0zQbGh4wZ+PPAfvqxGdVw
	==
X-Gm-Gg: ASbGnctJJKPU8RYQv3ms3HpuCPSBM5pfmWhygjaoE2aUFU2MFQnYrQ9LpBCBbC4J8um
	SMY+Mf8K+h25azRaMJw4pjmWv6Tmqs66UNi/XvkOWzzn5tvzkkpAfs9Qd70WLweKG4njhCPtvfw
	bt/FEDDbxktm77t91sZzFiThug7D1U6MwLDvbLcBNSh05+QIfz0BvZVubo2QIo7rSw+dpmVbTFW
	B9ptRFtwRAaxmvzIIXgTOH11RJimuFPrD+YoxjyiFFhd4GdeiNTuMrrCaj1+twh+AeTDPIA4BMv
	IP4+NO+LTD/c1UrHZJhcMAZ8iolatA6u0Khj/nNWBwpB2l+KO2qK6Q1N2kAMUwGSpoDYZWCtDoc
	E/bR761aylqoEs78db8qrX1cF
X-Received: by 2002:a05:600c:4f4b:b0:45b:43cc:e559 with SMTP id 5b1f17b1804b1-45b47a1a0e8mr18207415e9.36.1755690422289;
        Wed, 20 Aug 2025 04:47:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjzzMYK+kEyoj6K1A3QmbDYJzlk/G3tL5Zl7byq/0Ymw3Ic5lIG7/4nT/AuaGrjoKVkzbi9Q==
X-Received: by 2002:a05:600c:4f4b:b0:45b:43cc:e559 with SMTP id 5b1f17b1804b1-45b47a1a0e8mr18207055e9.36.1755690421726;
        Wed, 20 Aug 2025 04:47:01 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074879864sm7593173f8f.13.2025.08.20.04.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:47:00 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, cl@linux.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for
 ILB CPU
In-Reply-To: <d421a5ba-95cb-42fb-a376-1e04c9d6a1ac@os.amperecomputing.com>
References: <20250819025720.14794-1-adamli@os.amperecomputing.com>
 <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com>
 <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <d421a5ba-95cb-42fb-a376-1e04c9d6a1ac@os.amperecomputing.com>
Date: Wed, 20 Aug 2025 13:46:59 +0200
Message-ID: <xhsmhldnegqq4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 20/08/25 19:05, Adam Li wrote:
> On 8/20/2025 4:43 PM, Valentin Schneider wrote:
>> On 20/08/25 11:35, Adam Li wrote:
>>> I agree with your description about the housekeeping CPUs. In the worst case,
>>> the system only has one housekeeping CPU and this housekeeping CPU is so busy
>>> that:
>>> 1) This housekeeping CPU is unlikely idle;
>>> 2) and this housekeeping CPU is unlikely in 'nohz.idle_cpus_mask' because tick
>>> is not stopped.
>>> Therefore find_new_ilb() may very likely return -1. *No* CPU can be selected
>>> to do NOHZ idle load balancing.
>>>
>>> This patch tries to fix the imbalance of NOHZ idle CPUs (CPUs in nohz.idle_cpus_mask).
>>> Here is more background:
>>>
>>> When running llama on arm64 server, some CPUs *keep* idle while others
>>> are 100% busy. All CPUs are in 'nohz_full=' cpu list, and CONFIG_NO_HZ_FULL
>>> is set.
>>>
>>
>> I assume you mean all but one CPU is in 'nohz_full=' since you need at
>> least one housekeeping CPU. But in that case this becomes a slightly
>> different problem, since no CPU in 'nohz_full' will be in
>>
>>   housekeeping_cpumask(HK_TYPE_KERNEL_NOISE)
>>
>
> I ran llama workload on a system with 192 CPUs. I set "nohz_full=0-191" so all CPUs
> are in 'nohz_full' list. In this case, kernel uses the boot CPU for housekeeping:
>
> Kernel message: "Housekeeping: must include one present CPU, using boot CPU:0"
>
> find_new_ilb() looks for qualified CPU from housekeeping CPUs. The searching
> is likely to fail if there is only one housekeeping CPU.
>

Right

>>> The problem is caused by two issues:
>>> 1) Some idle CPUs cannot be added to 'nohz.idle_cpus_mask',
>>> this bug is fixed by another patch:
>>> https://lore.kernel.org/all/20250815065115.289337-2-adamli@os.amperecomputing.com/
>>>
>>> 2) Even if the idle CPUs are in 'nohz.idle_cpus_mask', *no* CPU can be selected to
>>> do NOHZ idle load balancing because conditions in find_new_ilb() is too strict.
>>> This patch tries to solve this issue.
>>>
>>> Hope this information helps.
>>>
>>
>> I hadn't seen that patch; that cclist is quite small, you'll want to add
>> the scheduler people to our next submission.
>>
>
> Sure. The first patch involves both 'tick' and 'scheduler' subsystem. I can resend
> the first patch to broader reviewers if you don't mind.
>

I'd say resend the whole series with the right folks cc'd.

>> So IIUC:
>> - Pretty much all your CPUs are NOHZ_FULL
>> - When they go idle they remain so for a while despite work being available
>>
>
> Exactly.
>
>> My first question would be: is NOHZ_FULL really right for your workload?
>> It's mainly designed to be used with always-running userspace tasks,
>> generally affined to a CPU by the system administrator.
>> Here AIUI you're relying on the scheduler load balancing to distribute work
>> to the NOHZ_FULL CPUs, so you're going to be penalized a lot by the
>> NOHZ_FULL context switch overheads. What's the point? Wouldn't you have
>> less overhead with just NOHZ_IDLE?
>>
>
> I ran the llama workload to do 'Large Language Model' reference.
> The workload creates 'always-running userspace' threads doing math computing.
> There is *few* sleep, wakeup and context switch. IIUC NOHZ_IDLE cannot help
> always-running task?
>

Right, NOHZ_IDLE is really about power savings while a CPU is idle (and
IIRC it helps some virtualization cases).

> 'nohz_full' option is supposed to benefit performance by reducing kernel
> noise I think. Could you please give more detail on
> 'NOHZ_FULL context switch overhead'?
>

The doc briefly touches on that:

  https://docs.kernel.org/timers/no_hz.html#omit-scheduling-clock-ticks-for-cpus-with-only-one-runnable-task

The longer story is have a look at kernel/context_tracking.c; every
transition into and out of the kernel to and from user or idle requires
additional atomic operations and synchronization.

It would be worth for you to quantify how much these processes
sleep/context switch, it could be that keep the tick enabled incurs a lower
throughput penalty than the NO_HZ_FULL overheads.

>> As for the actual balancing, yeah if you have idle NOHZ_FULL CPUs they
>> won't do the periodic balance; the residual 1Hz remote tick doesn't do that
>> either. But they should still do the newidle balance to pull work before
>> going tickless idle, and wakeup balance should help as well, albeit that
>> also depends on your topology.
>>
>
> I think the newidle balance and wakeup balance do not help in this case
> because the workload has few sleep and wakeup.
>

Right. So other than the NO_HZ_FULL vs NO_HZ_IDLE considerations above, you
could manually affine the threads of the workload. Depending on how much
control you have over how many threads it spawn, you could either pin on
thread per CPU, or just spawn the workload into a cpuset covering the
NO_HZ_FULL CPUs.

Having the scheduler do the balancing is bit of a precarious
situation. Your single housekeeping CPU is pretty much going to be always
running things, does it make sense to have it run the NOHZ idle balance
when there are available idle NOHZ_FULL CPUs? And in the same sense, does
it make sense to disturb an idle NOHZ_FULL CPU to get it to spread load on
other NOHZ_FULL CPUs? Admins that manually affine their threads will
probably say no.

9b019acb72e4 ("sched/nohz: Run NOHZ idle load balancer on HK_FLAG_MISC CPUs")
also mentions SMT being an issue.

>> Could you share your system topology and your actual nohz_full cmdline?
>>
>
> The system has 192 CPUs. I set "nohz_full=0-191".
>
> Thanks,
> -adam



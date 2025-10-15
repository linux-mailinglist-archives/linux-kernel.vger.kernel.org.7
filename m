Return-Path: <linux-kernel+bounces-854267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5B1BDDF38
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135B23BFF69
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BD431B819;
	Wed, 15 Oct 2025 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kilgz7P3"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831D93081D8
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523680; cv=none; b=fqfOFDSwAH0K8rQIxKXfSuvKjC1He/Bp0JBpuDn/om0/GDwAI6uubv17FC1t5H0Al6vrJffjz4o9iL2N95tt7oj7QDEDF8hajUxTIBsnIkyr9hJVa4rwMHoD2ADmBcgXhfVmajCTlRQfwApNPRVU/9L+FGFMZypSHrRT5a07Oq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523680; c=relaxed/simple;
	bh=VB1/uYMWlHJ1MD2zcabtCEDPPFe4lIGicG+PfcqgShM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOiJ7YoVp3qr07oH4MRD51/Mg+coZo90U48jkq8ZFC8VdQIFR9IzO2Oj531n/ITlsrGh7l8aOtnsBB4RnB1rJ8mbId33SEbZN6YyAbDOZjhPtafCibX3s9FJtVk4+4M0D1eOPE2xL/388yztA5mFSYUYUK3msemQVI0b5ths9iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kilgz7P3; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7833765433cso8460590b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760523679; x=1761128479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EzLaG6kKmqBAoy7gHW5prcQ/KiJFcitDxZf6UvRpBs=;
        b=Kilgz7P3KDSdVacTHUSOAzZNXU6cFXh9wmD/8/iElq6k7qcl/6P+Wx1PnDJwKQ7hCB
         6PKQ5eF0gZNkRbbUy3wyqu+zh1SdezWdBkI2IO5cApHh5rWKNLFxHgxVa+lDLImaLvD3
         rXOeW8UUgHotqcS6dDyGXyNIk3zJekUemuF/MaTjEs2y0WUYmDy/oyIRw7DGSFI8ii/s
         hDBapVnCMgIWDC7jtB+//5Yb7kaYMfV3h3kfRZr4Lsy2Gno1yOQSQuWwdj+eTXLVuBiJ
         AthAfSq714Z23bYJ3qI5XCjOkE6Ecnjw1Xzy9p8TGK6WiF40ymijEYWLTljatdfZ2qJU
         JiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760523679; x=1761128479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+EzLaG6kKmqBAoy7gHW5prcQ/KiJFcitDxZf6UvRpBs=;
        b=bOhifMk2tjfgjbafUxPW66U6MylMyuGj3xt/uXIWjVBlysabsEeLY5HmiRd+e8FZn+
         jDJBJaxfA9s6e1lsW0hYk2/h467nb4ZfiPUDy98yvK2pRNJTiab2ahNzTfPx97q9UiBI
         LMyRRUSARxDNskT9qYg4omxeVoUrQyqFeZvD+wWzzrpZIOl08QaYYxWuwBvRFmAzncdV
         08h88FrmclfnHOJgcrNIrgjvREZbuKRgbBz8mn0lkApM37OjLNSdEUqDDJbcxYLVGH79
         NFfJDdbtzaVzmqsLMwQmtnptG//UBQXLuP6i1b2iCMHTukGTYSc0MUL0BdkNjUc3Eg3A
         nfxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIjn70bCAhKzPF75AiUqOOSpil2ud3PNdw477Y+IM3WMsrg+sAC316wf5WLhibC1vfJmrHQs+Ly3h/P6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0PgmK5IQYyyjJtd2sjrpnFldD+17k/ai/zXCm9Ck8rM0/c6F+
	Lh2AGevJLxIqojSJ37mdhJGDILf9ea1txNit7E1X495taqkqItCK61Ee
X-Gm-Gg: ASbGncvwZlU2Yy8+2Q/T7xvM/+PC73DneV+Zwd9V8lTd6lvPX9u+hK7cTceJKtpj7JL
	v7ktF9Sp1kWglBwW2itjmglaSBTyhGndBwGUA+w3W0IVLTr0yEBxqcphw6z4eg7QV7nwUYCaupE
	FWaYn0/umbNFl3d4nzb7XC4BFh3kDZJCGXwhSOHY8p6rMvwcoDA1BDN6p3eyPKpMZXX/U+Q67nx
	02jfms4YcjTTbUHRMygCdk0Kx0a5Hljq3CJF4XunkZAqziRDtAh/H2K0jGJtFNsRvoqo2mOk55Z
	kK5wXcqpYyOwhL1fRIzgPjAv9u8h5JrBpkh4YGBbEC5hPtN05LUY6riQujhHg3JZLu9xhwVL0yY
	6xEvnmFqze2E3wPQrvNE2voZaQhD41xCMR82Ydj2YIxIQYKnJzEJtsituBkx0G2QxU9RWqXJk
X-Google-Smtp-Source: AGHT+IFktwvKquQcM+adzYgmIwc1bPXtnhV3FfpndSqbTedrk76Sg96uqLrw+HPhPRoTn94lfCUfzQ==
X-Received: by 2002:a05:6a00:8d5:b0:793:1b79:ee61 with SMTP id d2e1a72fcca58-79387434292mr30443366b3a.22.1760523678748;
        Wed, 15 Oct 2025 03:21:18 -0700 (PDT)
Received: from [10.125.192.72] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b733355sm18083711b3a.26.2025.10.15.03.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 03:21:18 -0700 (PDT)
Message-ID: <6bcc899c-a2a5-7b77-dcff-436d2a7cc688@gmail.com>
Date: Wed, 15 Oct 2025 18:21:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] sched/fair: Prevent cfs_rq from being unthrottled with
 zero runtime_remaining
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Valentin Schneider <vschneid@redhat.com>, Ben Segall
 <bsegall@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Chengming Zhou <chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Xi Wang <xii@google.com>,
 linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
 Chuyi Zhou <zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Songtang Liu <liusongtang@bytedance.com>, Chen Yu <yu.c.chen@intel.com>,
 Matteo Martelli <matteo.martelli@codethink.co.uk>,
 =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250929074645.416-1-ziqianlu@bytedance.com>
 <c4a1bcea-fb00-6f3f-6bf6-d876393190e4@gmail.com>
 <20251014090728.GA41@bytedance>
 <84382429-02c1-12d5-bdf4-23e880246cf3@gmail.com>
 <20251014115018.GC41@bytedance>
 <ded8b9bf-c9bb-8a41-541d-1bef354e4296@gmail.com>
 <20251015025154.GA35@bytedance>
 <4902f7d4-c6ee-bc29-dd7f-282d19d0b3b2@gmail.com>
 <20251015084045.GB35@bytedance>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <20251015084045.GB35@bytedance>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Aaron,

On 2025/10/15 16:40, Aaron Lu wrote:
> On Wed, Oct 15, 2025 at 02:31:27PM +0800, Hao Jia wrote:
>> On 2025/10/15 10:51, Aaron Lu wrote:
>>> On Wed, Oct 15, 2025 at 09:43:20AM +0800, Hao Jia wrote:
>>> ... ...
>>>> Yes, I've already hit the cfs_rq->runtime_remaining < 0 condition in
>>>> tg_unthrottle_up().
>>>>
>>>> This morning, after applying your patch, I still get the same issue.
>>>> However, As before, because cfs_rq->curr isn't NULL,
>>>> check_enqueue_throttle() returns prematurely, preventing the triggering of
>>>> throttle_cfs_rq().
>>>>
>>>>
>>>> Some information to share with you.
>>>
>>> Can you also share your cgroup setup and related quota setting etc. and
>>> how to trigger it? Thanks.
>>
>> I ran some internal workloads on my test machine with different quota
>> settings, and added 10 sched messaging branchmark cgroups, setting their
>> cpu.max to 1000 100000.
>>
>> perf bench sched messaging -g 10 -t -l 50000 &
>>
>> I'm not sure if the issue can be reproduced without these internal
>> workloads.
> 
> Thanks for the report, I think I understand your concern now.
> 
> I managed to trigger a condition in tg_unthrottle_up() for a cfs_rq that
> has runtime_enabled but with a negative runtime_remaining, the setup is
> as before:
> 
>            root
>          /      \
>          A*     ...
>       /  |  \   ...
>          B
>         /  \
>        C*
> 
> where both A and C have quota settings.
> 
> 1 Initially, both cfs_rq_a and cfs_rq_c are in unthrottled state with a
>    positive runtime_remaining.
> 2 At some time, cfs_rq_a is throttled. cfs_rq_c is now in a throttled
>    hierarchy, but it's not throttled and has a positive runtime_remaining.
> 3 Some time later, task @p gets enqueued to cfs_rq_c and starts execution
>    in kernel mode, consumed all cfs_rq_c's runtime_remaining.
>    account_cfs_rq_runtime() properly accounted, but resched_curr() doesn't
>    cause schedule() -> check_cfs_rq_runtime() -> throttle_cfs_rq() to
>    happen immediately, because task @p is still executing in kernel mode
>    (CONFIG_PREEMPT_VOLUNTARY).
> 4 Some time later, cfs_rq_a is unthrottled.
>    tg_unthrottle_up() noticed cfs_rq_c has a negative runtime_remaining.
> 
> In this situation, check_enqueue_throttle() will not do anything though
> because cfs_rq_c->curr is set, throttle will not happen immediately so
> it won't cause throttle to happen on unthrottle path.
> 
> Hao Jia,
> 
> Do I understand you correctly that you can only hit the newly added
> debug warn in tg_unthrottle_up():
> WARN_ON_ONCE(cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0);
> but not throttle triggered on unthrottle path?
> 

yes. but I'm not sure if there are other corner cases where 
cfs_rq->runtime_remaining <= 0 and cfs_rq->curr is NULL.

> BTW, I think your change has the advantage of being straightforward and
> easy to reason about. My concern is, it's not efficient to enqueue tasks
> to a cfs_rq that has no runtime left, not sure how big a deal that is
> though.

Yes, but that's what we're doing now. The case described above involves 
enqueue a task where cfs_rq->runtime_remaining <= 0.

I previously tried adding a runtime_remaining check for each level of 
task p's cfs_rq in unthrottle_cfs_rq()/tg_unthrottle_up(), but this made 
the code strange and complicated.

Thanks,
Hao





> 
> Thanks.


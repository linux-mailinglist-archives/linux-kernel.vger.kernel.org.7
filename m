Return-Path: <linux-kernel+bounces-856069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D57EBE2FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77D1403976
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4CD26CE25;
	Thu, 16 Oct 2025 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMz3nCBP"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08821B9F5
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612686; cv=none; b=bcEevW/4iAROP8OSM7hZi7AMZ2tUGUzDXNO1VQq74ZLAotgNGa2ZkjaFBjCKdt6jDmYeLhADiN4JjlcMxIEfWBuLYf/sUacUrC9g3HbgYZJpk4loJ6jU6QeZyR+D2sHzu6oT+lhwbJctJykvmozKE64NLmITUivljqp8A0Q9IYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612686; c=relaxed/simple;
	bh=9hayRmepem52JfccF0DW53/B0uXtOSA8s6cl1krBerY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVQqheMednCGcXgnD/bSUdbdG7JuDE1gw3L7r9OYjGGgHXXMA3XEThSXLB39o4gR00ZYx6wtNtt60hwU/z2lue08g8xCCvAhdkJh2gKIht8pRkdgBqkfybWbGUYE+SfHpTgEjKvwWZW38NKjnuQzF66zml+IzbTP+n3JrgR4bcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMz3nCBP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a16bd4d875so493928b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 04:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760612684; x=1761217484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScR4DC0NO8+m9va9icGS3Kc5++4qegzNWEJ9tYvaHts=;
        b=PMz3nCBPO9DDEf4hVYl0Dt+4JtscV9Eb5/tLsXR0mnp4y6nVKub4U9ABPMqMaCqp0G
         jA8IMMHwwRmt6nYZ5sg6vnCZV4/fzN58DGXWZWh+axQXZ1dRQrp0SwTtT41xcsSUW6ax
         qPw30mZOhneb73dzCDrvTm0vhSFjSYFBv3frZZlc6CJnvgINL4ASxiTwIlqglGOytA6l
         W/mosNQj9NMTUCp3NDkfBPZ9PzbfiJnK6eNaxPX0au2xT9jG+nbIyFa0DcOlsMDV4/5a
         UUt0A/Gvff8fZJVWn8MNJ3gnhQxRaeuDELk5CI5nJ/hXibZzqdJFPPF4qExdOpjoD+Ze
         evxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760612684; x=1761217484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ScR4DC0NO8+m9va9icGS3Kc5++4qegzNWEJ9tYvaHts=;
        b=sUbcVIkgROiuzEtLK+EanP4av4VhTjz3iRR5iwx7KN+ku9ilYOcsWRiduSZ96XrPrw
         6pTKqGOoxyaG42BAy6lEdL5/pR+MCHFSruKIg8MPyx17TQw/hOCCdeiD/l14FXMzmc/l
         jNMekqxmxbj5Oux7JsySwcvXVZBbyDKqAXKunf5uLWFuXTCBVbEkdrnZNcYuHv70xuDW
         eGqpNzR61pcbKBsTsQcmvtBlSJtb7zQhXubPMvGemOm8wd94Bd6t7vxtFPyE+MsOOlpe
         0JN9ntKduUTCK6CIIFxzWl7nU0+Qx7uruO8+EfqHRD8FfjSZO2+kYKBFEfBaMSJ2aKdD
         Az0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8s4zfMYWmmz0wd1BhMPdMcHvxMUq8C66deTby6eDi7tr2vu+cvNL9qfHWOh1Y0acjl1FCxDkFQHk2gsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpW0mTh79fUSM8jE4txBnzwwHnyel5cwliV153O//1BLe0LsnH
	VOWF66aWJlOHrglG98uOqehbQ+y2wJm6PA/QJbCCPmrDa61RHjdKNrrY
X-Gm-Gg: ASbGncvlCMFep0Eym1mqURds84JdYCZZHKEu4HPsARw/2GkGFfZ+aqQ6pX1XEgRF8CY
	vqU0c7Bw62BDknSaiBlBXtLLELYLRCvoGB9zO/K6DW9RUcUV0V88GVdYD9ocC+8LmqbXY/zF8Ib
	LO8CEmBFeJbfpAVO3Kj3Cw8xCbD+6d5uz/9NMXoxI//Rnp0w0OnYOP095ietat6pe1/5RzJFraY
	BU9Unll9QmrMvinYXTZ/wjZvbclw2EcC/SWcIPXNwE8b6I6hbj6nUjSH8wndhi/liVcmll2KMpx
	X2VIaPDEDqvRNqwe/pmucq6c1ZDvDYFJqCNDR4C1mnTsA2RXlLjPubqQFiGhphjvzDcXXtqG2ea
	uljjI2ZFxrNiuq9mVg95KzXsXQkD3Ok1RbJQJ++isZUB+3mfGyGdJSsYnLqzUn4sauXPG2lGq5V
	RzJrW8WDIgIvl+oTjFUZPrOB9TL+8pxL8=
X-Google-Smtp-Source: AGHT+IGS+X5m9+fvSkEpsv4cp/NpAbfO5emQMPVMBElDyrOOxZF5QfHV6v2anIk+5OmFXvVo5GDzPA==
X-Received: by 2002:a05:6a00:2447:b0:774:615b:c8ad with SMTP id d2e1a72fcca58-79385ce1228mr34074979b3a.9.1760612684419;
        Thu, 16 Oct 2025 04:04:44 -0700 (PDT)
Received: from [10.125.192.72] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d993853sm21815581b3a.74.2025.10.16.04.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 04:04:43 -0700 (PDT)
Message-ID: <eaedc19e-8647-ab3b-c09b-a8602d193011@gmail.com>
Date: Thu, 16 Oct 2025 19:04:30 +0800
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
References: <20251014090728.GA41@bytedance>
 <84382429-02c1-12d5-bdf4-23e880246cf3@gmail.com>
 <20251014115018.GC41@bytedance>
 <ded8b9bf-c9bb-8a41-541d-1bef354e4296@gmail.com>
 <20251015025154.GA35@bytedance>
 <4902f7d4-c6ee-bc29-dd7f-282d19d0b3b2@gmail.com>
 <20251015084045.GB35@bytedance>
 <6bcc899c-a2a5-7b77-dcff-436d2a7cc688@gmail.com>
 <20251016065438.GA32@bytedance>
 <ff16098b-00ff-80ee-5130-f1327b0af17d@gmail.com>
 <20251016092300.GB32@bytedance>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <20251016092300.GB32@bytedance>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/10/16 17:23, Aaron Lu wrote:
> On Thu, Oct 16, 2025 at 03:49:15PM +0800, Hao Jia wrote:
>>
>> Hi Aaron,
>>
>> On 2025/10/16 14:54, Aaron Lu wrote:
>>> On Wed, Oct 15, 2025 at 06:21:01PM +0800, Hao Jia wrote:
>>>> On 2025/10/15 16:40, Aaron Lu wrote:
>>> ... ...
>>>>> Hao Jia,
>>>>>
>>>>> Do I understand you correctly that you can only hit the newly added
>>>>> debug warn in tg_unthrottle_up():
>>>>> WARN_ON_ONCE(cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0);
>>>>> but not throttle triggered on unthrottle path?
>>>>>
>>>>
>>>> yes. but I'm not sure if there are other corner cases where
>>>> cfs_rq->runtime_remaining <= 0 and cfs_rq->curr is NULL.
>>>>
>>>
>>> Right, I'm not aware of any but might be possible.
>>>
>>>>> BTW, I think your change has the advantage of being straightforward and
>>>>> easy to reason about. My concern is, it's not efficient to enqueue tasks
>>>>> to a cfs_rq that has no runtime left, not sure how big a deal that is
>>>>> though.
>>>>
>>>> Yes, but that's what we're doing now. The case described above involves
>>>> enqueue a task where cfs_rq->runtime_remaining <= 0.
>>>>
>>>> I previously tried adding a runtime_remaining check for each level of task
>>>> p's cfs_rq in unthrottle_cfs_rq()/tg_unthrottle_up(), but this made the code
>>>> strange and complicated.
>>>
>>> Agree that adding a runtime_remaining check for each level in
>>> unthrottle_cfs_rq() looks too complex.
>>>
>>> So I think you approach is fine, feel free to submit a formal patch.
>>> With your change, theoretically we do not need to do those
>>> runtime_remaining check in unthrottle_cfs_rq() but keeping that check
>>> could save us some unnecessary enqueues, so I'll leave it to you to
>>> decide if you want to keep it or not. If you want to keep it, please
>>> also change its comments because the current comments will be stale
>>> then.
>>>
>>
>> Thank you for your suggestion. I'll send a formal patch later.
>>
>> I'm also happy for you to submit a patch for the next version. This warning
>> needs to be fixed, regardless of the method.
> 
> With your change, task enqueue in unthrottle path will not call
> check_enqueue_path(), thus the warn on non-empty limbo list in
> tg_throttle_down() should not happen, so I suppose we do not need
> this patch anymore, no?

Yes, I mean maybe the maintainer thinks your patch is more suitable.

> 
>>
>> However, I've discovered a minor bug in your current patch.
>>
>> In kernel/sched/core.c tg_set_cfs_bandwidth()
>>
>> ...
>> if (cfs_rq->runtime_enabled && !cfs_rq->throttled) {
>>      update_rq_clock(rq);   <----
>>      throttle_cfs_rq(cfs_rq);
>> }
>> ...
>>
>> Call update_rq_clock() to avoid the warning about using an outdated rq_clock
>> in tg_throttle_down()->rq_clock_pelt().
> 
> With the above said, this shouldn't matter anymore but just out of
> curiosity: did you notice this by inspecting the code or actually
> hitting the warning about using an outdated rq clock?
> 
> Per my understanding, most likely: __assign_cfs_rq_runtime() in
> throttle_cfs_rq(cfs_rq) will grant 1ns runtime to cfs_rq so it won't
> reach tg_throttle_down(). The comment I added above that if condition
> is kind of misleading though.


I did encounter this once.

perhaps in the following corner case:

If cfs_b->quota is set low (and quota is set at each level), and there 
are a large number of CPUs.

After tg_set_cfs_bandwidth()->__refill_cfs_bandwidth_runtime(), we 
release cfs_b->lock. cfs_b->runtime might be consumed by cfs_rq on other 
CPUs.

Then, on one online CPU, we can't get 1ns runtime via 
__assign_cfs_rq_runtime(). Current limiting is triggered on this CPU, 
and tg_throttle_down()->rq_clock_pelt() is called.


           ------------[ cut here ]------------
WARNING: kernel/sched/sched.h:1681 at tg_throttle_down+0x106/0x110, 
CPU#4:          CPU: 4 UID: 0 PID: 7840 Comm: test_cgroup.sh Kdump: 
loaded Not tainted 6.17.0+ #94 PREEMPT(voluntary)

           Call Trace:
            <TASK>
            walk_tg_tree_from+0x39/0xd0
            ? __pfx_tg_throttle_down+0x10/0x10
            throttle_cfs_rq+0xea/0x210
            tg_set_bandwidth+0x31f/0x4d0
            cpu_max_write+0xc3/0x130
            cgroup_file_write+0x92/0x1a0
            ? __check_object_size+0x27a/0x300
            kernfs_fop_write_iter+0x15f/0x1f0
            vfs_write+0x31b/0x430
            ksys_write+0x6d/0xf0
            __x64_sys_write+0x1d/0x30
            x64_sys_call+0x1900/0x2760
            do_syscall_64+0x83/0x8c0
            ? ksys_dup3+0x9d/0x120
            ? filp_flush+0x96/0xb0
            ? __x64_sys_close+0x42/0x90
            ? x64_sys_call+0x1c48/0x2760
            ? do_syscall_64+0xbc/0x8c0
            ? do_syscall_64+0xbc/0x8c0
            ? x64_sys_call+0x2404/0x2760
            ? do_syscall_64+0xbc/0x8c0
            ? do_sys_openat2+0x8e/0xd0
            ? __x64_sys_openat+0x58/0xa0
            ? x64_sys_call+0x101f/0x2760
            ? do_syscall_64+0xbc/0x8c0
            ? count_memcg_events+0xf1/0x1e0
            ? get_close_on_exec+0x3b/0x50
            ? do_fcntl+0x27a/0x7d0
            ? handle_mm_fault+0x1d2/0x2b0
            ? __x64_sys_fcntl+0x9d/0x130
            ? x64_sys_call+0x2404/0x2760
            ? do_syscall_64+0xbc/0x8c0
            ? exc_page_fault+0x97/0x1b0
            entry_SYSCALL_64_after_hwframe+0x76/0x7e

Thanks,
Hao


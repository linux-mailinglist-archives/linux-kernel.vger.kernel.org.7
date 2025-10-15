Return-Path: <linux-kernel+bounces-853579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2434DBDC065
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677A21926B08
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433912F7478;
	Wed, 15 Oct 2025 01:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxDgd7zF"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DAD2FB0B4
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492909; cv=none; b=Nf2J/U9sFldRp2Jgxdx2atto9+7UmQVNglUeTxmY9A6wqv/f/6Z3tkUXYVQ/xyv4uja6r73Z2ADASovTfoYq3Bq4OyuzKi5yvEVgd9mf7vlbn1VC4rfNPtzIQopvkrdJKF3G65auNr0gGuCiw2eH294O5j+BuvK92tBYdY4pf6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492909; c=relaxed/simple;
	bh=kJVcoM51Xs5o56sBfPz7Fu912maErwvHg4XmxFSxX0k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FsO0SmbhzHzUKOdEaTT7j5ez5DUMFHHzDtaxPVpxfJHkQ/3T5zPGfk1z5ol9GUy9IlamSLtep4jmquP/Kc5KZF+icSZkAWbp5qWJFnQqtTmJju7CLd4dufYZ1fvuJ5KJEITqpao0344uEkeNL2v2H6kMwN0loXXEeg3p2bpn9q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxDgd7zF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781997d195aso4317184b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760492907; x=1761097707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEbRVvzAgM4lK8fA9xNfxcqTWgfjR6GvtKjgf4fgk/U=;
        b=UxDgd7zFzNWj9YDQ7+sy6p27NBpv+ZYDZydllKhXQefIHq3T0pyd/2fp0Ikff0S1GV
         A4D23fpLQfCbr/GRCyrQE2/aHASJ8VaZOyqY9N8jcQ3/tQIS4djljacnncNBWsSgf2Nn
         rhxabgnOIw57yr039AP7V+ecqjKW3hckceZTbsofOBQlTYtnkL8SH9gdwu+j+1Jx+MY6
         6NF9n409PTPGYykQArKnVNmAKZA9Mo0wx9aYN3/3flXQg6fnHgqjlAlcVJNR7JPAH+g8
         DkIqVlSwloqWpq1+lEdh+s6VwhzuqsBHNqommOJPmy3qfaa7oh81IpTRX0avrGewXlw3
         xvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760492907; x=1761097707;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mEbRVvzAgM4lK8fA9xNfxcqTWgfjR6GvtKjgf4fgk/U=;
        b=r2HingUVmRHEp4fLFZN8adDfzW/eSSBt30wYgcHE86VXURnMvTRZWjg3CL9k4Fvym5
         s6+zB2hoCW4KIksjSIazlkUXi7uwb/TnJGMZ3nr3OkgxCWkUCuBro54metkU6YRKWqXL
         2bxfhFhfK/ehtHGPnWM0GQ0PpiyLto0w494YStahlL7kMFpr+TgbCymIMaeUgTGvl19v
         453a0hLmqDFGMAZGIjETDx+ehqiNwKkga2gi89zTazw6xWTFANswR5lyym91nsVYDxM8
         L8FW3zp3HatsPb3dtjsxfLf5r7OPUDaWr+0YyMAsNJvu1f86sw27AVte1JWsEGsICeHx
         a2TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvHwp2JzBDCDeEwOkPc5K866lM7dyc0eSdr6GibQ6WzJDiy4eOW02I7UV6IouFS8V0m75ud80BdxGHaVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuRq2tT0++wv8ztpeej9ov3dhaTrcfAb7uMvgoA5yRXTblfbWd
	PvWkcapl1lVHx1IzYhlG/yh6RpURkIx2UUlEP1poVxD8nptwow6JbNGx
X-Gm-Gg: ASbGncsFMWF/+VpT/IUi9X9UjqreSazx8ypWwbsHCwdYiR7FD8So94jQEvKIAdNOpkp
	c+baegNZlQHb1EhV+ios29yk0KbdFBZuFNDSV6PAP72PYkQrWy4bZsH4Lw4SPXz1P182jt+yF/6
	CdLxhqFJvI+mm25nk3XUSaEU1+MRTJBhGTC+T+/IVBzJ73QRWKA7nW/GRQ8yNw2kza111HxvQcL
	VbYe0IrbXw7YQKpCURdt02GfiOPWUkul5Uwh2V9bhcEoo/FLVYVzy1QEqsFtVMTTaQQ7lCxfrUH
	WYMq0q8x8wGIhVYpKHuVNQPPJ6nNLtmAuvntxcYddjZ4J4j2M8k9tsZ5T5fQAJ5Ijpjwx+zmEKz
	m0vSHZvFFRBYIkeQMOmgSroTBfBxRNPmDQ6TNMeH7to7WrmtPAuxqMmfVRGllkwq4JDmAXawW76
	w/Hpdz2k4=
X-Google-Smtp-Source: AGHT+IEXeoWkKPw92jn9y8ngnhFfie7nBv04+ExGxoGsOEv+mQbahlmWVnkIBWVp9eFvTRC14AvfxA==
X-Received: by 2002:a05:6a20:1585:b0:2f2:f7d6:4803 with SMTP id adf61e73a8af0-32da815425emr37918047637.16.1760492906598;
        Tue, 14 Oct 2025 18:48:26 -0700 (PDT)
Received: from [10.125.192.72] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b67d313e7f9sm5152594a12.12.2025.10.14.18.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 18:48:26 -0700 (PDT)
Message-ID: <81b3e01f-1e58-aabc-a41a-76b5af46f32c@gmail.com>
Date: Wed, 15 Oct 2025 09:48:15 +0800
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
From: Hao Jia <jiahao.kernel@gmail.com>
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
In-Reply-To: <ded8b9bf-c9bb-8a41-541d-1bef354e4296@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/10/15 09:43, Hao Jia wrote:
> 
> 
> On 2025/10/14 19:50, Aaron Lu wrote:
>> On Tue, Oct 14, 2025 at 07:01:15PM +0800, Hao Jia wrote:
>>>
>>> Hello Aaron,
>>>
>>> Thank you for your reply.
>>>
>>> On 2025/10/14 17:11, Aaron Lu wrote:
>>>> Hi Hao,
>>>>
>>>> On Tue, Oct 14, 2025 at 03:43:10PM +0800, Hao Jia wrote:
>>>>>
>>>>> Hello Aaron,
>>>>>
>>>>> On 2025/9/29 15:46, Aaron Lu wrote:
>>>>>> When a cfs_rq is to be throttled, its limbo list should be empty and
>>>>>> that's why there is a warn in tg_throttle_down() for non empty
>>>>>> cfs_rq->throttled_limbo_list.
>>>>>>
>>>>>> When running a test with the following hierarchy:
>>>>>>
>>>>>>              root
>>>>>>            /      \
>>>>>>            A*     ...
>>>>>>         /  |  \   ...
>>>>>>            B
>>>>>>           /  \
>>>>>>          C*
>>>>>>
>>>>>> where both A and C have quota settings, that warn on non empty 
>>>>>> limbo list
>>>>>> is triggered for a cfs_rq of C, let's call it cfs_rq_c(and ignore 
>>>>>> the cpu
>>>>>> part of the cfs_rq for the sake of simpler representation).
>>>>>>
>>>>>
>>>>> I encountered a similar warning a while ago and fixed it. I have a 
>>>>> question
>>>>> I'd like to ask. tg_unthrottle_up(cfs_rq_C) calls 
>>>>> enqueue_task_fair(p) to
>>>>> enqueue a task, which requires that the runtime_remaining of task 
>>>>> p's entire
>>>>> task_group hierarchy be greater than 0.
>>>>>
>>>>> In addition to the case you fixed above,
>>>>> When bandwidth is running normally, Is it possible that there's a 
>>>>> corner
>>>>> case where cfs_A->runtime_remaining > 0, but 
>>>>> cfs_B->runtime_remaining < 0
>>>>> could trigger a similar warning?
>>>>
>>>> Do you mean B also has quota set and cfs_B's runtime_remaining < 0?
>>>> In this case, B should be throttled and C is a descendent of B so 
>>>> should
>>>> also be throttled, i.e. C can't be unthrottled when B is in throttled
>>>> state. Do I understand you correctly?
>>>>
>>> Yes, both A and B have quota set.
>>>
>>> Is there a possible corner case?
>>> Asynchronous unthrottling causes other running entities to completely
>>> consume cfs_B->runtime_remaining (cfs_B->runtime_remaining < 0) but not
>>> completely consume cfs_A->runtime_remaining (cfs_A->runtime_remaining 
>>> > 0)
>>> when we call unthrottle_cfs_rq(cfs_rq_A) .
>>


By the way, I also noticed that in unthrottle_cfs_rq(cfs_rq_A), we don't 
update cfs_rq_A->runtime_remaining when checking 
cfs_rq_A->runtime_remaining.
But I'm not sure if I need to submit a patch to update it and then check 
runtime_remaining.

Thanks,
Hao


>> Let me try to understand the situation here: in your described setup,
>> all three task groups(A, B, C) have quota set?
>>
>>>
>>> When we unthrottle_cfs_rq(cfs_rq_A), cfs_A->runtime_remaining > 0, 
>>> but if
>>> cfs_B->runtime_remaining < 0 at this time,
>>
>> Hmm... if cfs_B->runtime_remaining < 0, why it's not throttled?
>>
>>> therefore, when 
>>> enqueue_task_fair(p)->check_enqueue_throttle(cfs_rq_B)->throttle_cfs_rq(cfs_rq_B),
>>
>> I assume p is a task of group B?
>> So when A is unthrottled, since p is a throttled task of group B and B
>> is still throttled, enqueue_task_fair(p) should not happen.
>>
>>> an warnning may be triggered.
>>>
>>> My core question is:
>>> When we call unthrottle_cfs_rq(cfs_rq_A), we only check
>>> cfs_rq_A->runtime_remaining. However,
>>> enqueue_task_fair(p)->enqueue_entity(C->B->A)->check_enqueue_throttle() does
>>
>> According to this info, I assume p is a task of group C here. If
>> unthrottle A would cause enqueuing p, that means: either group C and B
>> do not have quota set or group C and B are in unthrottled state.
>>
>>> require that the runtime_remaining of each task_group level of task p is
>>> greater than 0.
>>
>> If group C and B are in unthrottled state, their runtime_remaining
>> should be > 0.
>>
>>>
>>> Can we guarantee this?
>>
>> To guarantee this, a warn like below could be used. Can you try in your
>> setup if you can hit it? Thanks.
> 
> Yes, I've already hit the cfs_rq->runtime_remaining < 0 condition in 
> tg_unthrottle_up().
> 
> This morning, after applying your patch, I still get the same issue. 
> However, As before, because cfs_rq->curr isn't NULL, 
> check_enqueue_throttle() returns prematurely, preventing the triggering 
> of throttle_cfs_rq().
> 
> 
> 
> Some information to share with you.
> 
> <...>-13123   [023] dN.1.    69.245648: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -5487 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57c80ad300 cfs_rq->nr_queued 0
>   sched-messaging-4299    [020] dNh2.   108.475966: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -1073 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57d2ef7400 cfs_rq->nr_queued 2
>   sched-messaging-3514    [009] dNh2.   109.640727: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -11345 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57c8ad5a00 cfs_rq->nr_queued 4
>             <...>-13872   [005] dNh2.   117.155177: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -15195 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57c8ad7e00 cfs_rq->nr_queued 5
>             <...>-9861    [005] dNh2.   139.307579: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -41639 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57f4f38400 cfs_rq->nr_queued 20
>             <...>-9861    [005] dNh2.   139.307598: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -41639 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57c8ad7e00 cfs_rq->nr_queued 7
>   sched-messaging-11165   [013] dNh2.   158.640827: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -32575 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e585693a400 cfs_rq->nr_queued 5
>   sched-messaging-15337   [002] dNh2.   178.400559: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -29005 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57ff4f6000 cfs_rq->nr_queued 7
>   sched-messaging-8740    [010] dNh2.   178.842565: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -34448 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57f4f4c800 cfs_rq->nr_queued 141
>   sched-messaging-8740    [010] dNh2.   178.842583: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -34448 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57c8ad4e00 cfs_rq->nr_queued 4
>             <...>-6101    [000] dNh1.   179.185475: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -14179 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57ea202000 cfs_rq->nr_queued 116
>   sched-messaging-6101    [000] dNh1.   179.185489: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -14179 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57c7078400 cfs_rq->nr_queued 6
>             <...>-7812    [002] dNh2.   184.228104: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -21154 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57f597c200 cfs_rq->nr_queued 75
>             <...>-7812    [002] dNh2.   184.228128: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -21154 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57c7079600 cfs_rq->nr_queued 7
>             <...>-4589    [006] dNh2.   185.872173: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -25309 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e584debc800 cfs_rq->nr_queued 173
>             <...>-4589    [006] dNh2.   185.872192: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -25309 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57c8ad7800 cfs_rq->nr_queued 7
>   sched-messaging-5155    [008] dNh2.   188.689689: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -14108 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57ea20e800 cfs_rq->nr_queued 150
>   sched-messaging-5155    [008] dNh2.   188.689704: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -14108 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57c8ad7600 cfs_rq->nr_queued 7
>   sched-messaging-15265   [002] dNh2.   190.920442: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -25129 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57ff4f6000 cfs_rq->nr_queued 6
>             <...>-10191   [007] dNh1.   191.851170: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -27077 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57c8ad7200 cfs_rq->nr_queued 4
>   sched-messaging-5963    [008] dNh2.   193.298329: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -41126 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57e9d31400 cfs_rq->nr_queued 156
>   sched-messaging-5963    [008] dNh2.   193.298345: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -41126 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57c8ad7600 cfs_rq->nr_queued 6
>             <...>-4877    [021] dNh2.   198.988637: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -19362 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57ea2bf400 cfs_rq->nr_queued 86
>             <...>-4877    [021] dNh2.   198.988657: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -19362 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57c47e9e00 cfs_rq->nr_queued 6
>             <...>-7344    [015] dNh2.   208.086556: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -31964 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e5856938a00 cfs_rq->nr_queued 4
>             <...>-8384    [020] dNh2.   209.858709: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -28618 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57f32ede00 cfs_rq->nr_queued 133
>             <...>-8384    [020] dNh2.   209.858736: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -28618 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57d2ef7400 cfs_rq->nr_queued 7
>   sched-messaging-7803    [000] dNh2.   210.380559: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -18845 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57c7078400 cfs_rq->nr_queued 8
>   sched-messaging-4388    [020] dNh2.   211.688504: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -22815 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57e7f0c600 cfs_rq->nr_queued 128
>   sched-messaging-4388    [020] dNh2.   211.688533: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -22815 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57d2ef7400 cfs_rq->nr_queued 7
>             <...>-15470   [014] dNh1.   223.440099: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -41950 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57ff79ee00 cfs_rq->nr_queued 7
>   sched-messaging-14343   [011] dNh2.   226.159614: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -24303 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57f46d3a00 cfs_rq->nr_queued 2
>             <...>-14543   [018] dNh1.   229.854321: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -23239 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e580acae000 cfs_rq->nr_queued 6
>             <...>-9075    [010] dNh1.   231.397245: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -38148 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57f4abb400 cfs_rq->nr_queued 108
>             <...>-9075    [010] dNh1.   231.397267: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -38148 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57c8ad4e00 cfs_rq->nr_queued 5
>             <...>-7271    [004] dNh2.   233.612978: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -24292 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57f418be00 cfs_rq->nr_queued 99
>             <...>-7271    [004] dNh2.   233.612995: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -24292 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57c8ad4400 cfs_rq->nr_queued 6
>             <...>-15191   [002] dNh1.   234.231866: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -28451 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57ff4f6000 cfs_rq->nr_queued 6
>             <...>-15181   [003] dNh2.   237.086491: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -20183 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57ff4f7600 cfs_rq->nr_queued 4
>   sched-messaging-6091    [013] dNh2.   243.412722: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -27394 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57ea209e00 cfs_rq->nr_queued 4
>   sched-messaging-6091    [013] dNh2.   243.412742: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -27394 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e585693a400 cfs_rq->nr_queued 1
>             <...>-6291    [010] dNh2.   245.166679: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -34474 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e57efee7600 cfs_rq->nr_queued 108
>             <...>-4648    [017] dNh2.   246.414518: tg_unthrottle_up: 
> cfs_rq->runtime_remaining -19404 cfs_rq->throttled 0 cfs_rq->curr 
> ffff8e5856939600 cfs_rq->nr_queued 3
> 
> 
> 
> [Wed Oct 15 09:26:41 2025] ------------[ cut here ]------------
> [Wed Oct 15 09:26:41 2025] WARNING: kernel/sched/fair.c:5897 at 
> tg_unthrottle_up+0x2a6/0x340, CPU#23: sh/13123
> [Wed Oct 15 09:26:41 2025] Modules linked in: xt_CHECKSUM xt_MASQUERADE 
> xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat x_tables 
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 cfg80211 
> nf_tables nfnetlink bridge stp llc cmac algif_hash algif_skcipher af_alg 
> snd_hda_codec_intelhdmi bnep snd_hda_codec_alc269 
> snd_hda_scodec_component snd_hda_codec_realtek_lib snd_hda_codec_generic 
> binfmt_misc intel_uncore_frequency intel_uncore_frequency_common i915 
> snd_hda_intel snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl 
> snd_sof_intel_hda_generic soundwire_intel soundwire_generic_allocation 
> snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common snd_soc_hdac_hda 
> snd_sof_intel_hda_mlink snd_sof_intel_hda snd_hda_codec_hdmi 
> snd_hda_ext_core soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp 
> snd_hda_codec snd_hda_core snd_sof snd_sof_utils x86_pkg_temp_thermal 
> snd_intel_dspcfg intel_powerclamp snd_intel_sdw_acpi coretemp 
> snd_soc_acpi_intel_match kvm_intel snd_soc_acpi_intel_sdca_quirks 
> snd_soc_acpi snd_hwdep soundwire_bus
> [Wed Oct 15 09:26:41 2025]  snd_soc_sdca snd_soc_core kvm snd_compress 
> ac97_bus snd_pcm_dmaengine snd_pcm snd_seq_midi snd_seq_midi_event 
> snd_rawmidi nls_iso8859_1 btusb snd_seq drm_buddy 
> processor_thermal_device_pci btmtk ttm processor_thermal_device btrtl 
> processor_thermal_wt_hint snd_seq_device btbcm irqbypass 
> platform_temperature_control mei_hdcp ghash_clmulni_intel 
> processor_thermal_soc_slider snd_timer btintel aesni_intel 
> platform_profile processor_thermal_rfim drm_display_helper snd mei_me 
> intel_rapl_msr rapl processor_thermal_rapl soundcore bluetooth 
> intel_rapl_common intel_cstate cec think_lmi joydev mei input_leds crc8 
> processor_thermal_wt_req firmware_attributes_class rc_core 8250_dw 
> wmi_bmof processor_thermal_power_floor processor_thermal_mbox 
> i2c_algo_bit int340x_thermal_zone int3400_thermal acpi_thermal_rel 
> acpi_tad acpi_pad mac_hid sch_fq_codel msr parport_pc ppdev lp parport 
> efi_pstore autofs4 btrfs blake2b_generic raid10 raid456 
> async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq 
> raid1 raid0
> [Wed Oct 15 09:26:41 2025]  spi_pxa2xx_platform hid_generic dw_dmac 
> dw_dmac_core usbhid spi_pxa2xx_core nvme r8169 i2c_i801 hid nvme_core 
> ahci i2c_mux realtek intel_lpss_pci i2c_smbus libahci intel_lpss idma64 
> video wmi
> [Wed Oct 15 09:26:41 2025] CPU: 23 UID: 0 PID: 13123 Comm: sh Kdump: 
> loaded Not tainted 6.17.0+ #120 PREEMPT(voluntary)
> [Wed Oct 15 09:26:41 2025] Hardware name: LENOVO 12JJA02KCD/3339, BIOS 
> M4ZKT39A 11/22/2023
> [Wed Oct 15 09:26:41 2025] RIP: 0010:tg_unthrottle_up+0x2a6/0x340
> [Wed Oct 15 09:26:41 2025] Code: 48 8d 3d 00 00 00 00 e8 28 03 15 00 45 
> 8b 85 64 01 00 00 45 85 c0 0f 84 b9 fd ff ff 49 83 bd 68 01 00 00 00 0f 
> 8f ab fd ff ff <0f> 0b e9 a4 fd ff ff 48 8b 88 f0 0a 00 00 e9 7c ff ff 
> ff 48 8b b1
> [Wed Oct 15 09:26:41 2025] RSP: 0018:ffffd18529b8fae0 EFLAGS: 00010082
> [Wed Oct 15 09:26:41 2025] RAX: 0000000000000006 RBX: ffff8e5f1fa72600 
> RCX: 0000000000000000
> [Wed Oct 15 09:26:41 2025] RDX: 0000000000000000 RSI: 0000000000000000 
> RDI: 0000000000000000
> [Wed Oct 15 09:26:41 2025] RBP: ffffd18529b8faf8 R08: 0000000000000001 
> R09: 0000000000000000
> [Wed Oct 15 09:26:41 2025] R10: 0000000000000000 R11: 0000000000000000 
> R12: ffff8e57ca398c80
> [Wed Oct 15 09:26:41 2025] R13: ffff8e57d1cc7a00 R14: 0000000000000000 
> R15: ffff8e5f1fa72600
> [Wed Oct 15 09:26:41 2025] FS:  00007fba99989740(0000) 
> GS:ffff8e5f9826b000(0000) knlGS:0000000000000000
> [Wed Oct 15 09:26:41 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 
> 0000000080050033
> [Wed Oct 15 09:26:41 2025] CR2: 0000559e6f0ceda8 CR3: 000000014cee9002 
> CR4: 0000000000f72ef0
> [Wed Oct 15 09:26:41 2025] PKRU: 55555554
> [Wed Oct 15 09:26:41 2025] Call Trace:
> [Wed Oct 15 09:26:41 2025]  <TASK>
> [Wed Oct 15 09:26:41 2025]  ? __pfx_tg_unthrottle_up+0x10/0x10
> [Wed Oct 15 09:26:41 2025]  walk_tg_tree_from+0x66/0xd0
> [Wed Oct 15 09:26:41 2025]  ? __pfx_tg_nop+0x10/0x10
> [Wed Oct 15 09:26:41 2025]  unthrottle_cfs_rq+0xe4/0x280
> [Wed Oct 15 09:26:41 2025]  tg_set_bandwidth+0x351/0x4d0
> [Wed Oct 15 09:26:41 2025]  cpu_max_write+0xc3/0x130
> [Wed Oct 15 09:26:41 2025]  cgroup_file_write+0x92/0x1a0
> [Wed Oct 15 09:26:41 2025]  ? __check_object_size+0x27a/0x300
> [Wed Oct 15 09:26:41 2025]  kernfs_fop_write_iter+0x15f/0x1f0
> [Wed Oct 15 09:26:41 2025]  vfs_write+0x31b/0x430
> [Wed Oct 15 09:26:41 2025]  ksys_write+0x6d/0xf0
> [Wed Oct 15 09:26:41 2025]  __x64_sys_write+0x1d/0x30
> [Wed Oct 15 09:26:41 2025]  x64_sys_call+0x1900/0x2760
> [Wed Oct 15 09:26:41 2025]  do_syscall_64+0x83/0x8c0
> [Wed Oct 15 09:26:41 2025]  ? __rseq_handle_notify_resume+0xaf/0x4e0
> [Wed Oct 15 09:26:41 2025]  ? __do_sys_vfork+0x4f/0x70
> [Wed Oct 15 09:26:41 2025]  ? __set_task_blocked+0x29/0x80
> [Wed Oct 15 09:26:41 2025]  ? sigprocmask+0xb5/0xe0
> [Wed Oct 15 09:26:41 2025]  ? __x64_sys_rt_sigprocmask+0x93/0xe0
> [Wed Oct 15 09:26:41 2025]  ? x64_sys_call+0x1cc0/0x2760
> [Wed Oct 15 09:26:41 2025]  ? do_syscall_64+0xbc/0x8c0
> [Wed Oct 15 09:26:41 2025]  ? irqentry_exit+0x47/0x60
> [Wed Oct 15 09:26:41 2025]  ? exc_page_fault+0x97/0x1b0
> [Wed Oct 15 09:26:41 2025]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [Wed Oct 15 09:26:41 2025] RIP: 0033:0x7fba997148f7
> [Wed Oct 15 09:26:41 2025] Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff 
> ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 
> 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 
> 48 89 74 24
> [Wed Oct 15 09:26:41 2025] RSP: 002b:00007fffa912ef68 EFLAGS: 00000246 
> ORIG_RAX: 0000000000000001
> [Wed Oct 15 09:26:41 2025] RAX: ffffffffffffffda RBX: 000000000000000b 
> RCX: 00007fba997148f7
> [Wed Oct 15 09:26:41 2025] RDX: 000000000000000b RSI: 0000559e6f0ccda0 
> RDI: 0000000000000001
> [Wed Oct 15 09:26:41 2025] RBP: 0000559e6f0ccda0 R08: 0000559e6f0cccd7 
> R09: 0000000000000000
> [Wed Oct 15 09:26:41 2025] R10: 0000559e6f0cccd6 R11: 0000000000000246 
> R12: 0000000000000001
> [Wed Oct 15 09:26:41 2025] R13: 000000000000000b R14: 0000000000000000 
> R15: 0000000000000000
> [Wed Oct 15 09:26:41 2025]  </TASK>
> [Wed Oct 15 09:26:41 2025] ---[ end trace 0000000000000000 ]---
> 
> 
> 
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 3ef11783369d7..c347aa28c411a 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5908,6 +5908,8 @@ static int tg_unthrottle_up(struct task_group 
>> *tg, void *data)
>>           cfs_rq->throttled_clock_self_time += delta;
>>       }
>> +    WARN_ON_ONCE(cfs_rq->runtime_enabled && cfs_rq->runtime_remaining 
>> <= 0);
>> +
>>       /* Re-enqueue the tasks that have been throttled at this level. */
>>       list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list, 
>> throttle_node) {
>>           list_del_init(&p->throttle_node);


Return-Path: <linux-kernel+bounces-852401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391ABBD8DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC63F424B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114E92FBE1C;
	Tue, 14 Oct 2025 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ4xf6B8"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB221AC44D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439697; cv=none; b=r6t08f46lcKgcx4BPzi2s70pQeDBuWvGmATUgLaYVOGtdLZhvuhyVmHzle5LEHdLgl9Sk9SImrvJYObPKKaUotU2pGmMf1KreDsiTHx/LVxqdKpT5eizBOMkqwZupncSd++RhSAoxNnVSry1jfit55+/RgVOI2sI+jxd4atbVos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439697; c=relaxed/simple;
	bh=D9zsGMe+7ZZ+1ULYUF6/R2dS04iLGWRg5viQumh0DE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCIOi8jK+bd/hjs0pDuubR315edxQHnVQA+qinnQZusl5MfB3mZGmH980mnek0OWi+QXfhoD2Ly9EyrR45pQ2O5pOY+q25dpfaMGt1eNr3yikTHkf3WNrWbR+HgVWDNFegulSBM1TPO8oAGCblNwUE/2W8d59nq7X+Xb2zOndfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJ4xf6B8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781206cce18so5360328b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760439695; x=1761044495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wd0YLKzrYxVlDdEwf/NekAk6cL0B5GHdsgKO2hGYOZc=;
        b=KJ4xf6B8yxo0VvR3kg1sXf/u+yuOp31slv0Az0tR7ye5LYqvZWn2KKgr+rV9QSNVPM
         HQ0uC5YvRc2YBW0+wMpGBbySXk4Vr9K6aZsYNFrZfznsRU3o48pJrBieBwYdOdo82WgP
         x9ZZpI2MK359WNIp7vZP7jRAqWx7F4Nf6LsdE/9GivHBR4y4MhE4CmGzIQum9Crt2ILr
         aBrE3s/DYiV0Qdl6WwJ2nwnB1A5bemrR3VqJYPnYDCHFDvtpweYaSwAiGx6Wwjm6XhHK
         LCV8mnvNoY/ElewDFm+5Jw6Vhm7thw1o3oCPNouyTZk3pFiUKjSY0xebpD5XlnkV09Ve
         y0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760439695; x=1761044495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wd0YLKzrYxVlDdEwf/NekAk6cL0B5GHdsgKO2hGYOZc=;
        b=KLB8Y9kzjqUH7PlrW7Ek+gO0/iuMJyeLTcXk2MkakEB+PWlovOUmPgQb15GLR0Dns+
         Xs24AnKwn7JlOellw5dgovf/B8W2Q0JcP6g86SaMCxy7xlZI3BChW7Slmwg6TJAzkgXj
         f9LauxBDt1J5I2IXazOUG7SX1UWGlHjpLYHve3VuLhMKmLW1kXcDeY+qBB7BrXbstMKV
         b7A2k3AzFS1S0Wm6/HPAUQv28u1EB1Q3u4lNgtVtDnFuh4+wGMPOvwIEE12oDNxZq9nB
         U1ZbPofPJagkl5TOR5eRj+TBnL7/XO0KHz3sXOgbvwQ+28TUUsJw4fz74d0fJSMlgy5W
         IveA==
X-Forwarded-Encrypted: i=1; AJvYcCXjtAZQPlFDHTQD0PsqB0VCvfHz0b5BDnS+AQsFJGCO1SnmUmVlS4AjcIDnXhY9lOsXneirSr6m13qWpkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2M6Um4O4gI3xMTiVfdmhEQqKfhrIGXA6SdaQo1S8Oy/KZFYzJ
	+nLAR6pafADRxqbLlmWYIT3TkRIMWV4h41BbPE/znyQzXC/3zuY4A0iK
X-Gm-Gg: ASbGncvNbyCK2/A8SEVRmprZAKNvgzbCqHiwjAMj9gn8MKzjN5Gu95USEbh8ATgxnZJ
	GtpD2HNXGWiO9t/vRtmreeO8SYFPwsLhdqEwG+K8WoN/SrEac60326zpVozddA5Iwz4l/66CCgM
	ZG4mIEvgIrgGpsm1DCCbxdnAn5t+xoWekZSOnXwd2XRUREqKsofD9ttmmE7GU5O+kY8OfJXiZJ1
	I+4pBtPXEO4ffubDU1NtflJAiZAGegBuEtAntZcBFdNHU5iILPvXxnSRDr1P0qzvFZ0kIc/2Ovd
	m96bxBLECIW6DvYVx2UfN4Nwv642oZWmj2UaXMFzxzC290MEhCpFunj5XUFDCMPRuSdfVO/H/cF
	LPGWu/1ezfpKNLcRJ4b5wHtCNsfvEjeGyGCHb0SdN7DQxzFSS5k4Uyx6ANoIYIHHVE2sVGgYN
X-Google-Smtp-Source: AGHT+IFT2RJlu9n5nJ14O2awXYHzG/b7P/0vMZRwfw1izahGTh5UHdT5ETZs+Qu+ku704EgqWpsTLQ==
X-Received: by 2002:a05:6a00:2406:b0:772:490f:e31e with SMTP id d2e1a72fcca58-79396e69d5dmr30536664b3a.3.1760439694852;
        Tue, 14 Oct 2025 04:01:34 -0700 (PDT)
Received: from [10.125.192.72] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d096527sm14644037b3a.44.2025.10.14.04.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 04:01:34 -0700 (PDT)
Message-ID: <84382429-02c1-12d5-bdf4-23e880246cf3@gmail.com>
Date: Tue, 14 Oct 2025 19:01:15 +0800
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
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <20251014090728.GA41@bytedance>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hello Aaron,

Thank you for your reply.

On 2025/10/14 17:11, Aaron Lu wrote:
> Hi Hao,
> 
> On Tue, Oct 14, 2025 at 03:43:10PM +0800, Hao Jia wrote:
>>
>> Hello Aaron,
>>
>> On 2025/9/29 15:46, Aaron Lu wrote:
>>> When a cfs_rq is to be throttled, its limbo list should be empty and
>>> that's why there is a warn in tg_throttle_down() for non empty
>>> cfs_rq->throttled_limbo_list.
>>>
>>> When running a test with the following hierarchy:
>>>
>>>             root
>>>           /      \
>>>           A*     ...
>>>        /  |  \   ...
>>>           B
>>>          /  \
>>>         C*
>>>
>>> where both A and C have quota settings, that warn on non empty limbo list
>>> is triggered for a cfs_rq of C, let's call it cfs_rq_c(and ignore the cpu
>>> part of the cfs_rq for the sake of simpler representation).
>>>
>>
>> I encountered a similar warning a while ago and fixed it. I have a question
>> I'd like to ask. tg_unthrottle_up(cfs_rq_C) calls enqueue_task_fair(p) to
>> enqueue a task, which requires that the runtime_remaining of task p's entire
>> task_group hierarchy be greater than 0.
>>
>> In addition to the case you fixed above,
>> When bandwidth is running normally, Is it possible that there's a corner
>> case where cfs_A->runtime_remaining > 0, but cfs_B->runtime_remaining < 0
>> could trigger a similar warning?
> 
> Do you mean B also has quota set and cfs_B's runtime_remaining < 0?
> In this case, B should be throttled and C is a descendent of B so should
> also be throttled, i.e. C can't be unthrottled when B is in throttled
> state. Do I understand you correctly?
>
Yes, both A and B have quota set.

Is there a possible corner case?
Asynchronous unthrottling causes other running entities to completely 
consume cfs_B->runtime_remaining (cfs_B->runtime_remaining < 0) but not 
completely consume cfs_A->runtime_remaining (cfs_A->runtime_remaining > 
0) when we call unthrottle_cfs_rq(cfs_rq_A) .

When we unthrottle_cfs_rq(cfs_rq_A), cfs_A->runtime_remaining > 0, but 
if cfs_B->runtime_remaining < 0 at this time,
therefore, when 
enqueue_task_fair(p)->check_enqueue_throttle(cfs_rq_B)->throttle_cfs_rq(cfs_rq_B), 
an warnning may be triggered.

My core question is:
When we call unthrottle_cfs_rq(cfs_rq_A), we only check 
cfs_rq_A->runtime_remaining. However, 
enqueue_task_fair(p)->enqueue_entity(C->B->A)->check_enqueue_throttle() 
does require that the runtime_remaining of each task_group level of task 
p is greater than 0.

Can we guarantee this?

Thanks,
Hao

>>
>> So, I previously tried to fix this issue using the following code, adding
>> the ENQUEUE_THROTTLE flag to ensure that tasks enqueued in
>> tg_unthrottle_up() aren't throttled.
>>
> 
> Yeah I think this can also fix the warning.
> I'm not sure if it is a good idea though, because on unthrottle, the
> expectation is, this cfs_rq should have runtime_remaining > 0 and if
> it's not the case, I think it is better to know why.
> 
> Thanks.


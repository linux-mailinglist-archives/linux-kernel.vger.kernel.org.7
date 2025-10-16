Return-Path: <linux-kernel+bounces-855705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D0BBE2063
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B65233529C6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA0D2475CB;
	Thu, 16 Oct 2025 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH/uWHr2"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA7C1C28E
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600974; cv=none; b=ZNFQqY0VKb8uRu1U37kD7sdrKuicvV8DDKvnMvjtrbDtftrAlh6IHiT3NVE6OofxVSSoWq1npnELOHBq/WfG72Xb1+1Wb06KUVcirJkteO1oNiEN8Bdn5ZUWNQeF3zNLOjl3hLZKy+L865Xym38rNBV2bP8N9XRlUAkGTNgx+cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600974; c=relaxed/simple;
	bh=wEPKnK+M4gvm8Iy3++P3j7bSaSdp1iheMKWVcHm7Ct4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HN7nMjkISlPrY3+OMMxp8/1FU74/2uTuJA6EIaOCtblJ2+RYtmfCUZl1TnuoN5fdR48HJHCPWdYFJ+A0JjqlF6Sj3O+VjMadgGVLq82S1bw1hMbya+DryDTzDAbent2PnFTq3MENbiwBk76ubk2cHjd7GBXc2Xao+LshQaw8vlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YH/uWHr2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f5d497692so630496b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760600972; x=1761205772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuI5K+CQH1/adG9F7GlO3QvQTMmwQ/cJbkEQVyqXOZU=;
        b=YH/uWHr2fcgPruE/trVMgcQhlkLOFKTTIe3nOSBzCV6umHxFFyTdSo1L9gv+Kbi7Kr
         R76cdBufMUgjrKEQaKtnm7zaGbkhPsP+B/UyCKcP+rGOPn6tJRiySeb2A+JvceSbTtVW
         qrPi/jRVek3rkE3zU8iYTRnmK50got56EdxyiJd4UiEMhiNHtf+aD2Hzd3PTfRl4leF0
         n/KjmOAHdFOoVNMd5mnCvN3qC8IU5wqh06u4AhmLiNPdVroaXu1/OF5I+KZ/Bb+p08hK
         Q19LeO2jbhr4l28A2m7v5DKHZeQ5CMLg8NGGA9Zr6Xo8M3D3bBBEmBTC8V8TUiIngXtp
         KBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760600972; x=1761205772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GuI5K+CQH1/adG9F7GlO3QvQTMmwQ/cJbkEQVyqXOZU=;
        b=j0LJ6eO5sZ67/k1zMXtpUUX6guJrSFmSZVtvsESLJnTvRRXqVgetbw0SGe3kwdbH4b
         AqODvhIPHrUgtkLeqMAebWnrEjhzS15MHVN9NnnKwcvGGY3N1YZpkBlTO464riGOXiJe
         QZNKu3yC36KdlwG7d1Cz3wQgJ1jbbS0um7XaLEL0EkOd6a8jEpN/YDa1flhvyWDeY2XQ
         33QjEFVgwqEri5PFM4/9orI2fPcZucfxynyVgWOII1OFGgoY/ma9yTO/mii35V6Qeo9i
         D1cmyHwKekOshUOpJ76PMe60s+Lm/nyWIYGBOEMWI8MnAKv3M8nXKFhjNzWMmEvFR/lq
         s0bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsE5VTtEiZbpl1RvHIxLOkidyxVcJWDKO0B1tHLU8nYQfczeAmBgYBvO4r0+hnUXRqVm3tvYD5FolcMKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl11XZimPN4bL/tHrR5JoTbNnEOPqeJd6+Kp1TS+wP1yTwod6L
	B657zLLkZjBxZAieK5nRIrCTDZ3myGViBvUlvqqLL+r/fehE+chUyAJt
X-Gm-Gg: ASbGncuq/IoVEUqDWLECAZ6IdTdDq9c6hKrVMSHIJsBU3yal+fRb02n6xIgQJHmfrXY
	YKfiXORTSZizY7abjxnndUB8UVhKiyLU7gsICDmD7KxNG42+5Q997udWW6B2Zq0IleCfqkuomkE
	8+V3dB95VBDSp+wIMf7oAsi6FUaAbQ5e3dYLPDy5XKxJZTDXHiyGwqipt6eEV52uv7s7TSw1jGn
	aIdtz3D7c6mnTq16LiCWqfPk389yRgFvArc3drimFw9+xlaWQ7LFYrCR1O/OzKeNy5ednBuRPbV
	QwK95yhveyfiwpDP3H9xUJVrdCPq5h6j/SxuALqzUEj1nSjiWfKLIliKHXyrV6Q1GldLIzaPkoC
	/M8jgIuABRMoqV8m9szMQYB3HwCzI6I9vrSMtCI90bvgVZPZY+54qQy+URkmfDRnEpyAAnjsNFH
	/+i+ufB+9FshM8tYMAlpXi7VDBObLuj+Q=
X-Google-Smtp-Source: AGHT+IFkzRwqICq1ZD2+J8bdCnwoumuBn8mVsuVfa5hMnyW8bmfMJyjMgpljSLlxdoJI9iHPLnKGMQ==
X-Received: by 2002:a05:6a00:1385:b0:781:9f2:efb1 with SMTP id d2e1a72fcca58-79387146b38mr42428618b3a.15.1760600972298;
        Thu, 16 Oct 2025 00:49:32 -0700 (PDT)
Received: from [10.125.192.72] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e134fsm21199656b3a.58.2025.10.16.00.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 00:49:31 -0700 (PDT)
Message-ID: <ff16098b-00ff-80ee-5130-f1327b0af17d@gmail.com>
Date: Thu, 16 Oct 2025 15:49:15 +0800
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
 <6bcc899c-a2a5-7b77-dcff-436d2a7cc688@gmail.com>
 <20251016065438.GA32@bytedance>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <20251016065438.GA32@bytedance>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Aaron,

On 2025/10/16 14:54, Aaron Lu wrote:
> On Wed, Oct 15, 2025 at 06:21:01PM +0800, Hao Jia wrote:
>> On 2025/10/15 16:40, Aaron Lu wrote:
> ... ...
>>> Hao Jia,
>>>
>>> Do I understand you correctly that you can only hit the newly added
>>> debug warn in tg_unthrottle_up():
>>> WARN_ON_ONCE(cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0);
>>> but not throttle triggered on unthrottle path?
>>>
>>
>> yes. but I'm not sure if there are other corner cases where
>> cfs_rq->runtime_remaining <= 0 and cfs_rq->curr is NULL.
>>
> 
> Right, I'm not aware of any but might be possible.
> 
>>> BTW, I think your change has the advantage of being straightforward and
>>> easy to reason about. My concern is, it's not efficient to enqueue tasks
>>> to a cfs_rq that has no runtime left, not sure how big a deal that is
>>> though.
>>
>> Yes, but that's what we're doing now. The case described above involves
>> enqueue a task where cfs_rq->runtime_remaining <= 0.
>>
>> I previously tried adding a runtime_remaining check for each level of task
>> p's cfs_rq in unthrottle_cfs_rq()/tg_unthrottle_up(), but this made the code
>> strange and complicated.
> 
> Agree that adding a runtime_remaining check for each level in
> unthrottle_cfs_rq() looks too complex.
> 
> So I think you approach is fine, feel free to submit a formal patch.
> With your change, theoretically we do not need to do those
> runtime_remaining check in unthrottle_cfs_rq() but keeping that check
> could save us some unnecessary enqueues, so I'll leave it to you to
> decide if you want to keep it or not. If you want to keep it, please
> also change its comments because the current comments will be stale
> then.
> 

Thank you for your suggestion. I'll send a formal patch later.

I'm also happy for you to submit a patch for the next version. This 
warning needs to be fixed, regardless of the method.

However, I've discovered a minor bug in your current patch.

In kernel/sched/core.c tg_set_cfs_bandwidth()

...
if (cfs_rq->runtime_enabled && !cfs_rq->throttled) {
     update_rq_clock(rq);   <----
     throttle_cfs_rq(cfs_rq);
}
...

Call update_rq_clock() to avoid the warning about using an outdated 
rq_clock in tg_throttle_down()->rq_clock_pelt().

Thanks,
Hao


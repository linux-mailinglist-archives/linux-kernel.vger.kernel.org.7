Return-Path: <linux-kernel+bounces-878857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C51C219BA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573AC400EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1ED374AAB;
	Thu, 30 Oct 2025 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IggGn+wC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08536E378
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847077; cv=none; b=pranmNGKmjoPvK6hWp65Jpk9Qfy/3lwtIXJsCtnV0m9H73QcfoWM/qa8npk5FPwi6vaXNN2SPpalaVg90n88+NR7+k7HUwO1awmOKQ4HpH/k7SDHiQhO06+bLTZ+PrsSVV8Okk0R1NTZyOwm+vke5bycqOY2+2gD4ehEXM5zZQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847077; c=relaxed/simple;
	bh=ZrpGNcINLNewfYrSNQU4O/e4F6eGTfF0vPwG5ft+p74=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cVvwIRmWBBEYNon2YHITsKt3PPhmtS3U3Ne2QsvSlfmYRBKahPscubRvz8+hqMHs6r05ob6srRD4Rvwnrx2NzWUiW/4eiRdEv7CqBe18kL5nPTxb3XccuGK7wa5fv91o4k52jbwD34cBu73rwNH5ge+F56+D5fqalTZ6P4wM/Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IggGn+wC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761847074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X34TMqPMw7zQw/mZ608eFrtlEnMJVdGRvLk/v0Gs/qY=;
	b=IggGn+wCSHETiHE/jRDejsZ/Q1qk0m9ntRffeC787Ok3PEuGS44t0uH+StwO0wLdfzE9OH
	ALnARBmEcVjQlDV/wBKOFyy43onGo9H0Rt2tD2kj8tu1/5m/yyunBh1gN6vDRtv+8RnSO/
	qPfz7TOLSQu/GPsevuiFwnWkcV8uB/0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-si0RE4DvPtW-SXOFua5P2g-1; Thu, 30 Oct 2025 13:57:52 -0400
X-MC-Unique: si0RE4DvPtW-SXOFua5P2g-1
X-Mimecast-MFC-AGG-ID: si0RE4DvPtW-SXOFua5P2g_1761847072
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-89e83837fadso352675785a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847072; x=1762451872;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X34TMqPMw7zQw/mZ608eFrtlEnMJVdGRvLk/v0Gs/qY=;
        b=tUSG7ebuev62ENCo40zcrgr0/rkoaRo5lioSXnDVakyjgr845GFfnSG8/uyETB4x73
         KuaB6jFlY5Cs0k8k+anIOmj1kqV9zZbApYri/Sc3X2nmRe1ppwA0Zl0wP/bqJlS6qk+6
         MA1v2xK04/dUQ4L0mBdUN6mhzrc9Nb0tNENF/9qrdFHNF1XPCnXbAY48prjJGCi1q1H0
         jUjNjV4NED9Tf8CStrLg50TB/3uMTm2uncBN9MGAt0HiREotPR3X6ANUVY/pvDdxhA9T
         KRBetardlrjMrM6pT4mKhsmPSRbq+0GnLCYkHabwScsfXCX4nJLW+eM7eQpqKBLZPjbk
         DIVw==
X-Forwarded-Encrypted: i=1; AJvYcCX894OzV/6XTxDpeoU0j5+ipd1sUdpkVwwV+P81ZyqfjMYmKlDgB7d+8hwCYbm+SBbl3kgzfNZdYeqK0H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqN+ue1USX3tARTROSBM3F7ZFnepXziB9LwcKhkRtjPcMqo559
	evVxcSJtw1QJEdxVvDWyzSSVDk1tI0XvmPKbevTv3mgpm6OTI1DXb0UIeuJou/pWmX41BkhxUj8
	bPB15RasD6KbtMhxQYJMV4P/gGNCU5R/5m5f2gMbZUCEiw2gWUdUAMHfskeAOGjzzkg==
X-Gm-Gg: ASbGncvX0s1FsNgAIBG+rEnEHMP1pt14CtRaA5b1K7ftmKrEuKQ1suxiOR0pRJ0k2uG
	XqaN/i48UFqcjfglktM/P8MJHEXiHQXsPHw/4R5xdKvkHZ3aF2L6FryK/1h7jwq2XevmGPo6GXc
	wPDjccPI/xrP/5FDLQybUyt3nS6GbOGKZhKjlFTwlcTrPNTpLLVTo6GIYrAAY5+n744YYffIubo
	ztJeccYKRKBsuLJorp3aVLvgHtqgIemONstuo46pmtQJNyxBPqOT937swW+Jwxz6ffMP/U+cyay
	puMvw1nq4XK7H9uWiGEJmLHiP7xWRn8hIHsY/btfknj0+X8YnTUJShRTPJO0gsO+N+/Tb2lzbZa
	wrhznzAFx3LsmEuVEcnaJZQ+ubHXF/5AIFO9LzhIcfHLjcQ==
X-Received: by 2002:a05:620a:3f97:b0:89e:e012:80e with SMTP id af79cd13be357-8ab9afd1283mr33314185a.44.1761847072046;
        Thu, 30 Oct 2025 10:57:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwgK1iNnUpBV9JQBGa+eDVokI7IoTiGJLXVCUJzaKnmdCh3t8+VTRUX1beIy6hEgmXOeKWlg==
X-Received: by 2002:a05:620a:3f97:b0:89e:e012:80e with SMTP id af79cd13be357-8ab9afd1283mr33312585a.44.1761847071592;
        Thu, 30 Oct 2025 10:57:51 -0700 (PDT)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f243142b5sm1314878685a.8.2025.10.30.10.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 10:57:50 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4421ec3d-e4df-4645-9b68-261080bd4760@redhat.com>
Date: Thu, 30 Oct 2025 13:57:50 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v13 0/9] timers: Exclude isolated cpus from timer
 migration
To: Frederic Weisbecker <frederic@kernel.org>, Waiman Long <llong@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>
References: <20251020112802.102451-1-gmonaco@redhat.com>
 <3c1e6b45-79b8-463a-8c41-565d9ed8f76d@redhat.com>
 <aQNySRvImq2yaUef@localhost.localdomain>
 <5457560d-f48a-4a99-8756-51b1017a6aab@redhat.com>
 <3ac28b2bf33086a77333791df39b779d55c31df0.camel@redhat.com>
 <84511fa7-3a28-425c-b0fd-8d971a5f7eb1@redhat.com>
 <aQOcC1GaUlLWsUPv@localhost.localdomain>
Content-Language: en-US
In-Reply-To: <aQOcC1GaUlLWsUPv@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/30/25 1:10 PM, Frederic Weisbecker wrote:
> Le Thu, Oct 30, 2025 at 12:37:08PM -0400, Waiman Long a écrit :
>> On 10/30/25 12:09 PM, Gabriele Monaco wrote:
>>> On Thu, 2025-10-30 at 11:37 -0400, Waiman Long wrote:
>>>> On 10/30/25 10:12 AM, Frederic Weisbecker wrote:
>>>>> Hi Waiman,
>>>>>
>>>>> Le Wed, Oct 29, 2025 at 10:56:06PM -0400, Waiman Long a écrit :
>>>>>> On 10/20/25 7:27 AM, Gabriele Monaco wrote:
>>>>>>> The timer migration mechanism allows active CPUs to pull timers from
>>>>>>> idle ones to improve the overall idle time. This is however undesired
>>>>>>> when CPU intensive workloads run on isolated cores, as the algorithm
>>>>>>> would move the timers from housekeeping to isolated cores, negatively
>>>>>>> affecting the isolation.
>>>>>>>
>>>>>>> Exclude isolated cores from the timer migration algorithm, extend the
>>>>>>> concept of unavailable cores, currently used for offline ones, to
>>>>>>> isolated ones:
>>>>>>> * A core is unavailable if isolated or offline;
>>>>>>> * A core is available if non isolated and online;
>>>>>>>
>>>>>>> A core is considered unavailable as isolated if it belongs to:
>>>>>>> * the isolcpus (domain) list
>>>>>>> * an isolated cpuset
>>>>>>> Except if it is:
>>>>>>> * in the nohz_full list (already idle for the hierarchy)
>>>>>>> * the nohz timekeeper core (must be available to handle global timers)
>>>>>>>
>>>>>>> CPUs are added to the hierarchy during late boot, excluding isolated
>>>>>>> ones, the hierarchy is also adapted when the cpuset isolation changes.
>>>>>>>
>>>>>>> Due to how the timer migration algorithm works, any CPU part of the
>>>>>>> hierarchy can have their global timers pulled by remote CPUs and have to
>>>>>>> pull remote timers, only skipping pulling remote timers would break the
>>>>>>> logic.
>>>>>>> For this reason, prevent isolated CPUs from pulling remote global
>>>>>>> timers, but also the other way around: any global timer started on an
>>>>>>> isolated CPU will run there. This does not break the concept of
>>>>>>> isolation (global timers don't come from outside the CPU) and, if
>>>>>>> considered inappropriate, can usually be mitigated with other isolation
>>>>>>> techniques (e.g. IRQ pinning).
>>>>>>>
>>>>>>> This effect was noticed on a 128 cores machine running oslat on the
>>>>>>> isolated cores (1-31,33-63,65-95,97-127). The tool monopolises CPUs,
>>>>>>> and the CPU with lowest count in a timer migration hierarchy (here 1
>>>>>>> and 65) appears as always active and continuously pulls global timers,
>>>>>>> from the housekeeping CPUs. This ends up moving driver work (e.g.
>>>>>>> delayed work) to isolated CPUs and causes latency spikes:
>>>>>>>
>>>>>>> before the change:
>>>>>>>
>>>>>>>     # oslat -c 1-31,33-63,65-95,97-127 -D 62s
>>>>>>>     ...
>>>>>>>      Maximum:     1203 10 3 4 ... 5 (us)
>>>>>>>
>>>>>>> after the change:
>>>>>>>
>>>>>>>     # oslat -c 1-31,33-63,65-95,97-127 -D 62s
>>>>>>>     ...
>>>>>>>      Maximum:      10 4 3 4 3 ... 5 (us)
>>>>>>>
>>>>>>> The same behaviour was observed on a machine with as few as 20 cores /
>>>>>>> 40 threads with isocpus set to: 1-9,11-39 with rtla-osnoise-top.
>>>>>>>
>>>>>>> The first 5 patches are preparatory work to change the concept of
>>>>>>> online/offline to available/unavailable, keep track of those in a
>>>>>>> separate cpumask cleanup the setting/clearing functions and change a
>>>>>>> function name in cpuset code.
>>>>>>>
>>>>>>> Patch 6 and 7 adapt isolation and cpuset to prevent domain isolated and
>>>>>>> nohz_full from covering all CPUs not leaving any housekeeping one. This
>>>>>>> can lead to problems with the changes introduced in this series because
>>>>>>> no CPU would remain to handle global timers.
>>>>>>>
>>>>>>> Patch 9 extends the unavailable status to domain isolated CPUs, which
>>>>>>> is the main contribution of the series.
>>>>>>>
>>>>>>> This series is equivalent to v13 but rebased on v6.18-rc2.
>>>>>> Thomas,
>>>>>>
>>>>>> This patch series have undergone multiple round of reviews. Do you think
>>>>>> it
>>>>>> is good enough to be merged into tip?
>>>>>>
>>>>>> It does contain some cpuset code, but most of the changes are in the timer
>>>>>> code. So I think it is better to go through the tip tree. It does have
>>>>>> some
>>>>>> minor conflicts with the current for-6.19 branch of the cgroup tree, but
>>>>>> it
>>>>>> can be easily resolved during merge.
>>>>>>
>>>>>> What do you think?
>>>>> Just wait a little, I realize I made a buggy suggestion to Gabriele and
>>>>> a detail needs to be fixed.
>>>>>
>>>>> My bad...
>>>> OK, I thought you were OK with the timer changes. I guess Gabriele will have
>>>> to send out a new version to address your finding.
>>> Sure, I'm going to have a look at this next week and send a V14.
>> I am going to extract out your 2 cpuset patches and send them to the cgroup
>> mailing list separately. So you don't need to include them in your next
>> version.
> I'm not sure this will help if you apply those to an external tree if the
> plan is to apply the whole to the timer tree. Or we'll create a dependency
> issue...

These 2 cpuset patches are actually independent of the timer related 
changes. The purpose of these two patches are to prevent the cpuset code 
from adding isolated CPUs in such a way that all the nohz_full HK CPUs 
become domain-isolated. This is a corner case that normal users won't 
try to do. The patches are just an insurance policy to ensure that users 
can't do that. This is complementary to the sched/isolation patch that 
limits what CPUs can be put to the isolcpus and nohz_full boot 
parameters. All these patches are independent of the timer related 
changes, though you can say that the solution will only be complete if 
all the pieces are in place.

There are another set of pending cpuset patches from Chen Ridong that 
does some restructuring of the cpuset code that will likely have some 
conflicts with these 2 patches. So I would like to settle the cpuset 
changes to avoid future conflicts.

Cheers,
Longman



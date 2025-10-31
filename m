Return-Path: <linux-kernel+bounces-880590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821E9C262FD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D85A466C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC792EDD6D;
	Fri, 31 Oct 2025 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVLpAAE+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8780E27781D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927260; cv=none; b=Bl78KPn8ECZe6VgUOcqOXMS71OjZ9JMV8VsIpXJmcMcPcjA7NAXzNB6eGf0chwer1Sc3njm6+O7QuHxC0D3kwN0itLok4JkRuSHf2CdDG6LSzbLHmflUMMDD0RhEmtyD5V7xptRBoIkf/y+MYbkCFTdujIkEdeqMFDW4jS7flqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927260; c=relaxed/simple;
	bh=Z/mcN7RTIxqUtNosA9bkzsvB8Z7iQSFBsl8W6VMcR2w=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RX1BfFdJP3vfGW7bIdwKL6hrGzQ8f10CJxocQtFSNCPIqk6nLt/ZFxLz4gbcy4/2JFD7jA3OuoiMz6wpS5Zs7zoL4znCw8wIzqc5K311ezai7P0tWNgIww+xsE7NDLb1Ri3Pi4b5O5qsN7C4FEVsWoAEK88UPrt5KC0dr2Z5SVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVLpAAE+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761927256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cu+ByqV+oVl4OgQu35qgRYhVgQ2bEDUKNYllplEOC9g=;
	b=BVLpAAE+Xplxbkx+PSFHd35jmw10Phgh1cmtxiodoivVIYjxeUMxrkqFcSxqtizeID3VGp
	XDthmEiRtgJPxrA6YhyPOi7CBiVtORD7t+SyoS0q6rjqgeKGOK2K+djh0Z+AwylhcarZeA
	F/znARY6OHDZPb26b7uWs13d5HgKTXk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-atBzwJyBORiocStKBQ4_cg-1; Fri, 31 Oct 2025 12:14:14 -0400
X-MC-Unique: atBzwJyBORiocStKBQ4_cg-1
X-Mimecast-MFC-AGG-ID: atBzwJyBORiocStKBQ4_cg_1761927254
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-891d8184bebso436138685a.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761927254; x=1762532054;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cu+ByqV+oVl4OgQu35qgRYhVgQ2bEDUKNYllplEOC9g=;
        b=u1leNM6HIdL8yuWL3NMZXp9ZOUlbciw7XbCJYgTi8n4VacrPLqQgThm4XVpXaSd8Mt
         7Rw5LkZ87wtz4rzdoW2YQ8cfjg70SwCVAPNkJsuLIPlne2UDe3Ge6eBX+EUc7D3oyIk5
         JPCML21jz/yKky4Ska2yB5KopsIt1IugpFafCHBt2GRNVPP6kLv1n23xOGDvg/bdhgzv
         7bYaZahyG9foMo1jmQwBrfT0mLjz52UqGfEssQ569KqhRQVInM9ldl3rX5dmrqWt/kwq
         9dUjK7MAbDStb1JL5DOKYJiokNYu9tzx8pCi8KBQZ7wgJadc4C72Jec2Eo5VvOswtm23
         Z4wA==
X-Forwarded-Encrypted: i=1; AJvYcCXaT339MuX4K0H8aGxCOokSnx5rhm/f1Vs1AyS+OTQDvAXIIlraute9qa18TUEqpqnq2Inkx9TBdiHVOHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM77ytBE1Cc5RGZxuVUcXEnQwBB0GJ8Nm7CtJsDu725PREjWiU
	Ywr7tqqJSOYbHx2Ilg/5bNeCQTlU+r1biPUXwZx5zHgawEP0txhs+8Jf+3o1WY3zOeoVwQre5NY
	qUhFUKmQCJoXIDO/zjiD3Ev89fBr+5KPATWsjvZMHjprbw1kyYRyL83OlQYXGq2epZQ==
X-Gm-Gg: ASbGnculp68SWrOhra0tgz+tv+ggKVDE9phfnZpFESoiZQl4wMe2moEYEumd9IX0Iob
	uwrwkvI/o2sIT0IdaaBZSqvLKt95b0oMc5FKDAUs7vNrLrC8IAUxupoCnZUK+bLbCc8C672MAqL
	dicVoHujHo0WIV+8JBqVZKYQJ9mRzmFLxw7JwNcT9g+Sgnqr/76CR09RxnRkjuozB8z4OlMFNvF
	SOjmcjRWA5a6On+SGL+Z79SGzIy6XaFV51lOfKAFf7IxJIxjqPEdnGa5V5CO7QcZwnLZ/V1JIoy
	IzYRCYoVEqBPtcgc8yZxYdYb4WzVaSoc4DJ7J1Fpa4/RrgwtfeIwzW7kKSrONu03ABADUucokCO
	DurqXxk+tXRuUQFF70bTn97GXEmyVLi/G0v/mOFKfnRm0Hw==
X-Received: by 2002:a05:620a:4725:b0:82f:10ac:450b with SMTP id af79cd13be357-8ab9b5993b4mr386380585a.65.1761927253982;
        Fri, 31 Oct 2025 09:14:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLhx3MVOwjCfGNlil/kpBqHzbYv0GEtnJwzJgGekVve8e2vp0rHyeGMov4oizmGzF1E0ktrQ==
X-Received: by 2002:a05:620a:4725:b0:82f:10ac:450b with SMTP id af79cd13be357-8ab9b5993b4mr386374585a.65.1761927253430;
        Fri, 31 Oct 2025 09:14:13 -0700 (PDT)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ac03d6398bsm132140785a.59.2025.10.31.09.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 09:14:12 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <60b676cd-eeb4-4463-8ce6-fec89e6fbaae@redhat.com>
Date: Fri, 31 Oct 2025 12:14:11 -0400
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
 <4421ec3d-e4df-4645-9b68-261080bd4760@redhat.com>
 <aQS-M_6_97ZLk0yH@localhost.localdomain>
Content-Language: en-US
In-Reply-To: <aQS-M_6_97ZLk0yH@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/31/25 9:48 AM, Frederic Weisbecker wrote:
> Le Thu, Oct 30, 2025 at 01:57:50PM -0400, Waiman Long a écrit :
>> On 10/30/25 1:10 PM, Frederic Weisbecker wrote:
>>> Le Thu, Oct 30, 2025 at 12:37:08PM -0400, Waiman Long a écrit :
>>>> On 10/30/25 12:09 PM, Gabriele Monaco wrote:
>>>>> On Thu, 2025-10-30 at 11:37 -0400, Waiman Long wrote:
>>>>>> On 10/30/25 10:12 AM, Frederic Weisbecker wrote:
>>>>>>> Hi Waiman,
>>>>>>>
>>>>>>> Le Wed, Oct 29, 2025 at 10:56:06PM -0400, Waiman Long a écrit :
>>>>>>>> On 10/20/25 7:27 AM, Gabriele Monaco wrote:
>>>>>>>>> The timer migration mechanism allows active CPUs to pull timers from
>>>>>>>>> idle ones to improve the overall idle time. This is however undesired
>>>>>>>>> when CPU intensive workloads run on isolated cores, as the algorithm
>>>>>>>>> would move the timers from housekeeping to isolated cores, negatively
>>>>>>>>> affecting the isolation.
>>>>>>>>>
>>>>>>>>> Exclude isolated cores from the timer migration algorithm, extend the
>>>>>>>>> concept of unavailable cores, currently used for offline ones, to
>>>>>>>>> isolated ones:
>>>>>>>>> * A core is unavailable if isolated or offline;
>>>>>>>>> * A core is available if non isolated and online;
>>>>>>>>>
>>>>>>>>> A core is considered unavailable as isolated if it belongs to:
>>>>>>>>> * the isolcpus (domain) list
>>>>>>>>> * an isolated cpuset
>>>>>>>>> Except if it is:
>>>>>>>>> * in the nohz_full list (already idle for the hierarchy)
>>>>>>>>> * the nohz timekeeper core (must be available to handle global timers)
>>>>>>>>>
>>>>>>>>> CPUs are added to the hierarchy during late boot, excluding isolated
>>>>>>>>> ones, the hierarchy is also adapted when the cpuset isolation changes.
>>>>>>>>>
>>>>>>>>> Due to how the timer migration algorithm works, any CPU part of the
>>>>>>>>> hierarchy can have their global timers pulled by remote CPUs and have to
>>>>>>>>> pull remote timers, only skipping pulling remote timers would break the
>>>>>>>>> logic.
>>>>>>>>> For this reason, prevent isolated CPUs from pulling remote global
>>>>>>>>> timers, but also the other way around: any global timer started on an
>>>>>>>>> isolated CPU will run there. This does not break the concept of
>>>>>>>>> isolation (global timers don't come from outside the CPU) and, if
>>>>>>>>> considered inappropriate, can usually be mitigated with other isolation
>>>>>>>>> techniques (e.g. IRQ pinning).
>>>>>>>>>
>>>>>>>>> This effect was noticed on a 128 cores machine running oslat on the
>>>>>>>>> isolated cores (1-31,33-63,65-95,97-127). The tool monopolises CPUs,
>>>>>>>>> and the CPU with lowest count in a timer migration hierarchy (here 1
>>>>>>>>> and 65) appears as always active and continuously pulls global timers,
>>>>>>>>> from the housekeeping CPUs. This ends up moving driver work (e.g.
>>>>>>>>> delayed work) to isolated CPUs and causes latency spikes:
>>>>>>>>>
>>>>>>>>> before the change:
>>>>>>>>>
>>>>>>>>>      # oslat -c 1-31,33-63,65-95,97-127 -D 62s
>>>>>>>>>      ...
>>>>>>>>>       Maximum:     1203 10 3 4 ... 5 (us)
>>>>>>>>>
>>>>>>>>> after the change:
>>>>>>>>>
>>>>>>>>>      # oslat -c 1-31,33-63,65-95,97-127 -D 62s
>>>>>>>>>      ...
>>>>>>>>>       Maximum:      10 4 3 4 3 ... 5 (us)
>>>>>>>>>
>>>>>>>>> The same behaviour was observed on a machine with as few as 20 cores /
>>>>>>>>> 40 threads with isocpus set to: 1-9,11-39 with rtla-osnoise-top.
>>>>>>>>>
>>>>>>>>> The first 5 patches are preparatory work to change the concept of
>>>>>>>>> online/offline to available/unavailable, keep track of those in a
>>>>>>>>> separate cpumask cleanup the setting/clearing functions and change a
>>>>>>>>> function name in cpuset code.
>>>>>>>>>
>>>>>>>>> Patch 6 and 7 adapt isolation and cpuset to prevent domain isolated and
>>>>>>>>> nohz_full from covering all CPUs not leaving any housekeeping one. This
>>>>>>>>> can lead to problems with the changes introduced in this series because
>>>>>>>>> no CPU would remain to handle global timers.
>>>>>>>>>
>>>>>>>>> Patch 9 extends the unavailable status to domain isolated CPUs, which
>>>>>>>>> is the main contribution of the series.
>>>>>>>>>
>>>>>>>>> This series is equivalent to v13 but rebased on v6.18-rc2.
>>>>>>>> Thomas,
>>>>>>>>
>>>>>>>> This patch series have undergone multiple round of reviews. Do you think
>>>>>>>> it
>>>>>>>> is good enough to be merged into tip?
>>>>>>>>
>>>>>>>> It does contain some cpuset code, but most of the changes are in the timer
>>>>>>>> code. So I think it is better to go through the tip tree. It does have
>>>>>>>> some
>>>>>>>> minor conflicts with the current for-6.19 branch of the cgroup tree, but
>>>>>>>> it
>>>>>>>> can be easily resolved during merge.
>>>>>>>>
>>>>>>>> What do you think?
>>>>>>> Just wait a little, I realize I made a buggy suggestion to Gabriele and
>>>>>>> a detail needs to be fixed.
>>>>>>>
>>>>>>> My bad...
>>>>>> OK, I thought you were OK with the timer changes. I guess Gabriele will have
>>>>>> to send out a new version to address your finding.
>>>>> Sure, I'm going to have a look at this next week and send a V14.
>>>> I am going to extract out your 2 cpuset patches and send them to the cgroup
>>>> mailing list separately. So you don't need to include them in your next
>>>> version.
>>> I'm not sure this will help if you apply those to an external tree if the
>>> plan is to apply the whole to the timer tree. Or we'll create a dependency
>>> issue...
>> These 2 cpuset patches are actually independent of the timer related
>> changes. The purpose of these two patches are to prevent the cpuset code
>> from adding isolated CPUs in such a way that all the nohz_full HK CPUs
>> become domain-isolated. This is a corner case that normal users won't try to
>> do. The patches are just an insurance policy to ensure that users can't do
>> that. This is complementary to the sched/isolation patch that limits what
>> CPUs can be put to the isolcpus and nohz_full boot parameters. All these
>> patches are independent of the timer related changes, though you can say
>> that the solution will only be complete if all the pieces are in place.
> Right but there will be a conflict if the timer patches don't have
> the rename of update_unbound_workqueue_cpumask().
Yes, I missed the fact that patch 9 does have a cpuset.c hunk. Yes, it 
will have a dependency on the prior cpuset patches.
>> There are another set of pending cpuset patches from Chen Ridong that does
>> some restructuring of the cpuset code that will likely have some conflicts
>> with these 2 patches. So I would like to settle the cpuset changes to avoid
>> future conflicts.
> Ok so it looks like there will be conflicts eventually during the merge
> window. In that case it makes sense to take Gabriel cpuset patches but
> he'll need to rebase the rest on top of the timer tree.

It depends on whether the patch set can be merged in time into tip for 
the next v6.19 merge windows.

Cheers,
Longman

>
> Thanks.
>
>> Cheers,
>> Longman
>>



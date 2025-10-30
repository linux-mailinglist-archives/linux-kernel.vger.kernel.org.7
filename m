Return-Path: <linux-kernel+bounces-878682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6787C21424
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC2B406A07
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8018426A088;
	Thu, 30 Oct 2025 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUMG4/yG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134F023909F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842240; cv=none; b=UXCYa8L0PQtOMKukEco1GZvMPSISzzMmZD9vMPp9bEqq91cC/1l/aosD9nYeXXRxf80fa+bGG5eRnYQ6vtJXIdap/FpA2TkK4dJbhOHUZsNZf0Y7MhCLab8eNyFegsIjQbJMISF2KRDd/y/9l2qLH7HPC+nrC+na8wkqKbGSl94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842240; c=relaxed/simple;
	bh=A7McFPE29pW4W6rjpsHNBXII6sZTL3nNwjEJaU0IvN4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lDuVSWMktAtgmnyw35epRETCCbJ7+fTDfrTb8iq94dub7MizgmcK9kullLRPXTdPIvq9ofYOK1IN9yfDFIv7QkYVyMcdGpvuQ08vgXyZdXnmu267hQAYy2LkMU1ob/061R+qD/d/scKvFYVc4fuBabMeSm04xoyiFaUqfgp3RCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUMG4/yG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761842238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ns/1sVH2j5EycVKL4s3M8Qxn7PdgQRj87o5yUsrvb4=;
	b=UUMG4/yGy2zVqQCfLMQiAFZsRNN0YxnleG3BMca9//jwn0qlzTr7dPBYdxqIKayGw3R/9b
	9xyx9mrCL77v0LiAlwsobVMYwfUqpCDuVMtbAOC68DS1BYAJWicY+Qu5QgTH+SB8bIdA49
	gmQ7V8OjNCSUStmYRe9MDb2gkGwZOuk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-Z-lv511mOU-PioojlhqfcA-1; Thu, 30 Oct 2025 12:37:11 -0400
X-MC-Unique: Z-lv511mOU-PioojlhqfcA-1
X-Mimecast-MFC-AGG-ID: Z-lv511mOU-PioojlhqfcA_1761842231
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4eba120950fso27184191cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842231; x=1762447031;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ns/1sVH2j5EycVKL4s3M8Qxn7PdgQRj87o5yUsrvb4=;
        b=QCm9FJNAiktJIIKEWLBwRLkXHMkMaRfqIVM24mf44+CwQYkitld8hX2ohNL1SA0eM0
         pGFFy5FdVG67M6f00tBjLgAruqhkDE3azK3nxcin3kc9Z3+uptxuqfjEKNNzNcWKnQIQ
         dR7xb5tyn3I+ohWSnvOISV4OeQoB1J56Mt41chK82WNYnJ97j91At5ELtQwnmjY2PMOo
         yIuZtx5JYIt7pAGWkHdKTUvYmvuGwS2ql20l71nbX6sWOw/NrwyKI0KVLbF1EyL9LvOJ
         xCryQm9NaHQXaGiBe/LCdgNE3gh5RkTU5aPBf2Edvu1tocDsUD2Ymd583VCHf05D5gFP
         lUaA==
X-Forwarded-Encrypted: i=1; AJvYcCWBKJ6x2HQq01KR4TGYxiYT+oEA0QChCefZJNORvDet5yQwzqDVHRNueE7gJ64I0IZGGEoods0ZHE0onHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/WAKDSGdpKUXfaBmEXHlGQjTmGBM4i2+rGM8CaRRGEoViiIPc
	SRoeecZ8ATQJ9TSbUqIDDNFB/zyMX+rDODZoLluk/94ENTbae5SLH2dE9eaqy1U9+SRiTvRwEkn
	mi9YFnNHtOuTVvNTXCp1X1Zk3BUruDyrXq1F36Qjwn/8ddUb5WfHulZwyadvvXDa1bg==
X-Gm-Gg: ASbGncuccbkbLzuUM2dj07H7XqCK5ZtJCwj9sa6wUPHhPnVEQCcAHX3zWCfWYiRfmRE
	5eSxOWaD3CF6mWN3cb/8Nl0kT/X/SLsfnUgMXzOswGd1DFdc4yD2Qvr5kedMkmOCxbFSg0dGzsV
	Em7UImAlv/d0yCHEuMV3BPddiEaCF88fuJ0jxaGDVuJ8SAYvf61TAaoq811miuJkR8qlx7kTIOc
	o4XvhCK5I/ZfRM3rpa45BbUuJMy4ZHgaznKSfn1XYlPaz0clkZF47rTIRxJVNrFEnD3ka/W5ErH
	oPwJTn7vH9Yoq1hKA472uJJ9qyOHEm87AWKAfDfbGeik5smexJ3p894sib9qr757NQ18N9Gmed5
	vl3ac6zE8pFu3XsqVdQ86F3seR9hevFCRAQDSkLdhv3W8sA==
X-Received: by 2002:ac8:5782:0:b0:4ec:f403:3017 with SMTP id d75a77b69052e-4ed30df3378mr3178691cf.30.1761842231014;
        Thu, 30 Oct 2025 09:37:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGED+k0Ky8yKMIh/EgtgzO/9bN2iOaI4F8PKBkblqBaHdQMkG0bnvoT35CXyJ/jVz+/8io4A==
X-Received: by 2002:ac8:5782:0:b0:4ec:f403:3017 with SMTP id d75a77b69052e-4ed30df3378mr3178311cf.30.1761842230520;
        Thu, 30 Oct 2025 09:37:10 -0700 (PDT)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba37d72ecsm118682401cf.9.2025.10.30.09.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 09:37:09 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <84511fa7-3a28-425c-b0fd-8d971a5f7eb1@redhat.com>
Date: Thu, 30 Oct 2025 12:37:08 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v13 0/9] timers: Exclude isolated cpus from timer
 migration
To: Gabriele Monaco <gmonaco@redhat.com>, Waiman Long <llong@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>
References: <20251020112802.102451-1-gmonaco@redhat.com>
 <3c1e6b45-79b8-463a-8c41-565d9ed8f76d@redhat.com>
 <aQNySRvImq2yaUef@localhost.localdomain>
 <5457560d-f48a-4a99-8756-51b1017a6aab@redhat.com>
 <3ac28b2bf33086a77333791df39b779d55c31df0.camel@redhat.com>
Content-Language: en-US
In-Reply-To: <3ac28b2bf33086a77333791df39b779d55c31df0.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/30/25 12:09 PM, Gabriele Monaco wrote:
>
> On Thu, 2025-10-30 at 11:37 -0400, Waiman Long wrote:
>>   
>> On 10/30/25 10:12 AM, Frederic Weisbecker wrote:
>>   
>>   
>>>   
>>> Hi Waiman,
>>>
>>> Le Wed, Oct 29, 2025 at 10:56:06PM -0400, Waiman Long a écrit :
>>>   
>>>>   
>>>> On 10/20/25 7:27 AM, Gabriele Monaco wrote:
>>>>   
>>>>>   
>>>>> The timer migration mechanism allows active CPUs to pull timers from
>>>>> idle ones to improve the overall idle time. This is however undesired
>>>>> when CPU intensive workloads run on isolated cores, as the algorithm
>>>>> would move the timers from housekeeping to isolated cores, negatively
>>>>> affecting the isolation.
>>>>>
>>>>> Exclude isolated cores from the timer migration algorithm, extend the
>>>>> concept of unavailable cores, currently used for offline ones, to
>>>>> isolated ones:
>>>>> * A core is unavailable if isolated or offline;
>>>>> * A core is available if non isolated and online;
>>>>>
>>>>> A core is considered unavailable as isolated if it belongs to:
>>>>> * the isolcpus (domain) list
>>>>> * an isolated cpuset
>>>>> Except if it is:
>>>>> * in the nohz_full list (already idle for the hierarchy)
>>>>> * the nohz timekeeper core (must be available to handle global timers)
>>>>>
>>>>> CPUs are added to the hierarchy during late boot, excluding isolated
>>>>> ones, the hierarchy is also adapted when the cpuset isolation changes.
>>>>>
>>>>> Due to how the timer migration algorithm works, any CPU part of the
>>>>> hierarchy can have their global timers pulled by remote CPUs and have to
>>>>> pull remote timers, only skipping pulling remote timers would break the
>>>>> logic.
>>>>> For this reason, prevent isolated CPUs from pulling remote global
>>>>> timers, but also the other way around: any global timer started on an
>>>>> isolated CPU will run there. This does not break the concept of
>>>>> isolation (global timers don't come from outside the CPU) and, if
>>>>> considered inappropriate, can usually be mitigated with other isolation
>>>>> techniques (e.g. IRQ pinning).
>>>>>
>>>>> This effect was noticed on a 128 cores machine running oslat on the
>>>>> isolated cores (1-31,33-63,65-95,97-127). The tool monopolises CPUs,
>>>>> and the CPU with lowest count in a timer migration hierarchy (here 1
>>>>> and 65) appears as always active and continuously pulls global timers,
>>>>> from the housekeeping CPUs. This ends up moving driver work (e.g.
>>>>> delayed work) to isolated CPUs and causes latency spikes:
>>>>>
>>>>> before the change:
>>>>>
>>>>>    # oslat -c 1-31,33-63,65-95,97-127 -D 62s
>>>>>    ...
>>>>>     Maximum:     1203 10 3 4 ... 5 (us)
>>>>>
>>>>> after the change:
>>>>>
>>>>>    # oslat -c 1-31,33-63,65-95,97-127 -D 62s
>>>>>    ...
>>>>>     Maximum:      10 4 3 4 3 ... 5 (us)
>>>>>
>>>>> The same behaviour was observed on a machine with as few as 20 cores /
>>>>> 40 threads with isocpus set to: 1-9,11-39 with rtla-osnoise-top.
>>>>>
>>>>> The first 5 patches are preparatory work to change the concept of
>>>>> online/offline to available/unavailable, keep track of those in a
>>>>> separate cpumask cleanup the setting/clearing functions and change a
>>>>> function name in cpuset code.
>>>>>
>>>>> Patch 6 and 7 adapt isolation and cpuset to prevent domain isolated and
>>>>> nohz_full from covering all CPUs not leaving any housekeeping one. This
>>>>> can lead to problems with the changes introduced in this series because
>>>>> no CPU would remain to handle global timers.
>>>>>
>>>>> Patch 9 extends the unavailable status to domain isolated CPUs, which
>>>>> is the main contribution of the series.
>>>>>
>>>>> This series is equivalent to v13 but rebased on v6.18-rc2.
>>>>>   
>>>>   
>>>> Thomas,
>>>>
>>>> This patch series have undergone multiple round of reviews. Do you think
>>>> it
>>>> is good enough to be merged into tip?
>>>>
>>>> It does contain some cpuset code, but most of the changes are in the timer
>>>> code. So I think it is better to go through the tip tree. It does have
>>>> some
>>>> minor conflicts with the current for-6.19 branch of the cgroup tree, but
>>>> it
>>>> can be easily resolved during merge.
>>>>
>>>> What do you think?
>>>>   
>>>   
>>> Just wait a little, I realize I made a buggy suggestion to Gabriele and
>>> a detail needs to be fixed.
>>>
>>> My bad...
>>>   
>>   
>> OK, I thought you were OK with the timer changes. I guess Gabriele will have
>> to send out a new version to address your finding.
> Sure, I'm going to have a look at this next week and send a V14.

I am going to extract out your 2 cpuset patches and send them to the 
cgroup mailing list separately. So you don't need to include them in 
your next version.

Cheers,
Longman



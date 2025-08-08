Return-Path: <linux-kernel+bounces-760567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 667D0B1ED02
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7496816D9C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EED2874E6;
	Fri,  8 Aug 2025 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIAZ/H/R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D647286D6B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754670453; cv=none; b=o/LVoN4v/QmVqfn3qavVMLvGEAUdNJPSo5QBJkhVV7FWAw/CVDo9IUcApv6ev50ZSJLVUMi+R9P2ke/qB+bB85mysFpA5buOh5h8NicSz494Xra2sYA2jR2PelM0ewb7KQ+x5Ym+OiVVwJz+dxkPxiKyOZfKtIOCOP6iaOh6+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754670453; c=relaxed/simple;
	bh=35xdwsaBTJ1Y4skh6luh1NYwYaL7lznfoO0s3HYedOc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P/zkm/bfTyEhQi75GgC756keHHQYJIZjqZ0g9YDynLYxY/7CDyKIbWPQskovm06GYe007obA9QN+sxJ2VrHN096PZ8MGFyn4bt9kYEU/LXo4iEtr9ITEZPMdFPx+SIMnI1hZ3L4Druj8NU0jx9ms/5NGn3GkXL7sNzzMZ6KzrpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OIAZ/H/R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754670450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2n2d3+1CIGjf3VybsTqnnNSZHlfvXlp65LE1VoA9y8=;
	b=OIAZ/H/RaQVi+Y6G80gpoybJ0ofquEXvC4S9grr2An8fGJ5V1rxQ/0GXre1hzUgCVuT5Oz
	aRxOzmNjmxHhwPHZbAPrQOFZFhemp6BLxbk+6xQwI5EACygqUR0kpiU2DF+VrwGgEF9kMu
	a9kYLd2289eoUbS8ZkKRpE173Yx0r0Q=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-uwJ2gDBMNke3reluzhLRXA-1; Fri, 08 Aug 2025 12:27:29 -0400
X-MC-Unique: uwJ2gDBMNke3reluzhLRXA-1
X-Mimecast-MFC-AGG-ID: uwJ2gDBMNke3reluzhLRXA_1754670449
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-71b58de76caso32041727b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 09:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754670449; x=1755275249;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2n2d3+1CIGjf3VybsTqnnNSZHlfvXlp65LE1VoA9y8=;
        b=st+vhHoU/9auz8rvK0VOTNXkBhxI/ls4odgE7RuiFH3KrudA8gttabHE0w+4jXV8xo
         3pWTWd9g1ecEvrrHpWtvxTUWwHRJMvaSjrGmDDiPPVfyQ0moX47WoW8c3t1u5kN0CL5Z
         JFIl4I5BlaaMMr6zpCegZp1gLxUS1AgP7PHb889k30RLJR9+9KLhREjDI9uNTKlABYOU
         xVcpGsBkJY5SLXbwJnIZ4V6Sw6X/k9VDd/dcucESlUb282Mkp6FeXryNIl6dxoMKRFiB
         mo9rWc9+v/kZqgD2PIDrF9D2Ay03/aM4ilJpZrnO4cmf1cugs6fwyCCkLItIWMwSZkWs
         AhCw==
X-Forwarded-Encrypted: i=1; AJvYcCUjS0kj53gSfOM5bvXEdCTRECoI+2ODMSmA4A+xTKr/Y9V7Sd4uGsURSN8PkBb3v9SSnjjWb0wLFdKCLCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Fr5KmN7bAS6sjMFZGgtJc+tpHYjNf1wR4BbO8kGkNFl/TrQa
	1EezIUI0XSHY3BXLoSh8e2QQW5ZrnmxvSH3uwBdOPRX5N+dwGCi75JT4Gwj0f7VhwjTn9PYJOPS
	f7D8kuZ1x8XaWQ/WghvJxHn5MR6k2AuGEB5qS6RjRUBay8I1Quaz16fxjmHd9zlaRPfMCS1vSSQ
	==
X-Gm-Gg: ASbGnctRJbaY09sam8tuPxdIOr4l9ybm3NzgII7eZPcoiQoNk85vW5PeJAj0n4+KfpV
	DNQ2oOhtT6YRZTRmZEA6e0e5DjA+iYEYDhduBAB4Eb0+LbXsmGtKLrQH3drKghoKBaMaw/EGquc
	JZgF7h+iYbWewQ0eHdcSCCFnkx3xRfuLbcRXcRKR7i4u/oBR+fqYrP4BnX1vcv5tABUjjcVraMN
	w35xnVJqngxjDQOAe2hztwObxe7IFYyOvUAKKaFg6Y8JCmbHINfzFOQsCyW0MjKs6vBJ4kJpTGa
	FRo4KA8xqnx68l1HNFr3rUcyJa9O2fqiotlBqMjjSUhJm0rQfP7adcyd5+ilwSbf78hFlk9bQxy
	oIPuPm5NvvQ==
X-Received: by 2002:a05:690c:368d:b0:71b:fa69:1a82 with SMTP id 00721157ae682-71bfa692661mr24301277b3.33.1754670448729;
        Fri, 08 Aug 2025 09:27:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlW/SK2xqpPPbu5o35295axqLAQOkQhIqoyd+MS4mQP3LIL8+WZc9zZEAAqzqpjzlffRpZ3w==
X-Received: by 2002:a05:690c:368d:b0:71b:fa69:1a82 with SMTP id 00721157ae682-71bfa692661mr24300697b3.33.1754670448271;
        Fri, 08 Aug 2025 09:27:28 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71c058d6bf3sm398587b3.22.2025.08.08.09.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 09:27:27 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <43af3cb0-3a8d-4ed4-9007-992475ba2844@redhat.com>
Date: Fri, 8 Aug 2025 12:27:25 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/18] cgroup/cpuset: Enable runtime modification of
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Ingo Molnar
 <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Phil Auld <pauld@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>, Gabriele Monaco
 <gmonaco@redhat.com>, Cestmir Kalina <ckalina@redhat.com>
References: <20250808151053.19777-1-longman@redhat.com>
 <aJYcsXEiFmCmDAjz@localhost.localdomain>
Content-Language: en-US
In-Reply-To: <aJYcsXEiFmCmDAjz@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/8/25 11:50 AM, Frederic Weisbecker wrote:
> Le Fri, Aug 08, 2025 at 11:10:44AM -0400, Waiman Long a écrit :
>> The "nohz_full" and "rcu_nocbs" boot command parameters can be used to
>> remove a lot of kernel overhead on a specific set of isolated CPUs which
>> can be used to run some latency/bandwidth sensitive workloads with as
>> little kernel disturbance/noise as possible. The problem with this mode
>> of operation is the fact that it is a static configuration which cannot
>> be changed after boot to adjust for changes in application loading.
>>
>> There is always a desire to enable runtime modification of the number
>> of isolated CPUs that can be dedicated to this type of demanding
>> workloads. This patchset is an attempt to do just that with an amount of
>> CPU isolation close to what can be done with the nohz_full and rcu_nocbs
>> boot kernel parameters.
>>
>> This patch series provides the ability to change the set of housekeeping
>> CPUs at run time via the cpuset isolated partition functionality.
>> Currently, the cpuset isolated partition is able to disable scheduler
>> load balancing and the CPU affinity of the unbound workqueue to avoid the
>> isolated CPUs. This patch series will extend that with other kernel noises
>> associated with the nohz_full boot command line parameter which has the
>> following sub-categories:
>>    - tick
>>    - timer
>>    - RCU
>>    - MISC
>>    - WQ
>>    - kthread
> Thanks for working on that, I'm about to leave for 2 weeks vacation so I
> won't have the time to check this until I'm back.
>
> However this series is highly conflicting with mine (cpuset/isolation: Honour
> kthreads preferred affinity). Your patchset even redoes things I'm doing
> (housekeeping cpumask update, RCU synchronization, HK_TYPE_DOMAIN to include
> cpusets, etc...)
>
> I have a v2 that is almost ready to post.
>
> Wouldn't it be better to wait for it and its infrastructure changes before
> proceeding with nohz_full?

Sure. I am just posting this RFC patch series to show my current idea 
that I have. I will wait for your v2 and integrate on top.

Looking forward to your upcoming v2 patch.

Cheers,
Longman



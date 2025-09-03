Return-Path: <linux-kernel+bounces-798248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F5AB41B2F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1041D174261
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC50B2E8B6C;
	Wed,  3 Sep 2025 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Hl2C5Hct"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C80535957
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894112; cv=none; b=QvvngAWpTUTHDM//atcZGEeGE3XXmoHckMYAiyB/CUzHBoXJp4WodzrY1/V8xe3QBAYLOq3s6u+mqcDPhnE5xCTlNy1i5VxAcPA9AMnkfRsXELnqm5TkQOU40qFZvawqUq19H4CkwA6p5Yk9TcvR08QMchPR4/to8Tvg+MpoDXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894112; c=relaxed/simple;
	bh=qJtX9JrzHUfYr86Q6dN6NST8Wdm1ij9B+wmXyqKJpBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=in/L0+Rq2HedsKq03Y5wZ+PgywuGKrhHBKsaelrzw5Ea/sp4ERB7XoFlqo2tg/Oyqmp0anr8EO85D5BqIL5+eU0RPkkCq0jaTRPiaP0lgVIxTdvVXPYOlJFHkOSMR6+lUSWHyzkuAwzC5eGFI6aoitV1DSWVKcKABhajZBlsfns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Hl2C5Hct; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f6f434c96so4154566e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1756894108; x=1757498908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LgxSLuacOSiAliVBo9T6UoRFjla5an5sZrNTYabGCaM=;
        b=Hl2C5HctOlxi2vtdHe7nvLpyUSA7Yqw2DLgKMvCIEJf/B+rG8o18JXomC/pKJ5aYnq
         WL2QoxnKduqom3mG1M7jdFxEsP8xwZ4BYEkrcDdUccmZ3yKCxZoUoa6v3SuqMlWjjMp7
         teiVtRQirfK7+oWc6cEqwDj+f4Lob8Wg9KMavaFPcsEWMpcJUf3/NXaP82QauGFxVKxh
         bCcl/Jw9t3k6qtiLOTaODHE80So6qMa2vk9z1AXhvkyYvxoLhB+c0UOmgZPWqGQtqvJT
         iU9Ft82l6MM5nhVSeba99PKqafHwmThqxJhdOt1X5VKV5b9VpzETj5G6oSgNkVaUyaMM
         RyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756894108; x=1757498908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgxSLuacOSiAliVBo9T6UoRFjla5an5sZrNTYabGCaM=;
        b=K7ces/4YBzsN9wqj31MpMoJzgFgKQ36zrAolawO0gIZqXP6OO+TCZgBkI5HbdH6IBF
         mX6Oz7hhAkgcPIpObFO0B3JvJTC5GsuK3BfimVfCumw9tiE4e3tj5FwOSOKq7bmqDqtY
         gMT7SmY8S3FbzXb80U6eid89/syRGowrY0BD7S9kfUiK/t+OurSGEAamOOn+xkMD7JRw
         fm7UcRA4UxSQQJY2+/EKNinzg+FoqJ1iKU9DaqjY8QFDNI7kVaJ9UlDEodZYo1gRT9TZ
         tDaTye/EauDR7cs7TbbVnyY/6gykoxCxjYzNjYKokWFNTMOmmZDKrGsDEqLGrcKkOe9j
         Y+IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSiSdupRW+/lGDG6/mhLL1QOFbqZ5iQl3Ai6lSeIkOmb7sdQ9TTJxMbT50AgVIQw/0XAHq4e5m21sx9tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIttflGld0W69e55cN0VV6NqaMk2s5dpxB6uukqVffbRCPJG2O
	1N8amGtJVu6tOhfjKrEF/+lySGxQW7ae9NhJTyXRnpL6p3sM2F83zwa/3mXc0OdXFIk=
X-Gm-Gg: ASbGncstE3TAWQFt46VJHmPYyNgJx5PfScpUPE07MyWSV+0bAK5FBmRxgXNXowbh9UC
	0OMfCI8gOcXGxKnNJvgxMZdMv86rtuWRw3ULVLEqM5DkgA6qDjColRuHtquX1EV/wGYjOwslN8L
	jTGQy4IYZnyYjJNfjcGI5/GHdpXg6UZq/q2YDsQgUsX8v93yBlJ0TmmGPr6HnEb698rY7ceauYr
	g5i3b4Ebz5vFGtLOTN19CV+VT7Ijpp4iXzwoPleicU6pkz4ocvFxT2V+DjBBBzIwOYEsVSsgIfc
	S/pDA9URiuhh6N7OgW2Cdcf3fXtkNd0bbxsD6fsPHUkaLWkE0simZ8Ddlef31prXh8kGueYyQ6z
	trRHqFV+FrJwnzjcbb44bfnLA65R34qLIxWrpwaMck9tefY/CLqqdxilaNJKcQD0YVjI=
X-Google-Smtp-Source: AGHT+IHXf+8BRUc9VKztwBDE44uJbCq8HfDYm4XkzCGHzVKe8cY4jFi8CRi3pEVvkXEvbG51NW6TZg==
X-Received: by 2002:a05:6512:689:b0:55f:54a8:9ec with SMTP id 2adb3069b0e04-55f709b6857mr4930716e87.52.1756894106967;
        Wed, 03 Sep 2025 03:08:26 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad1351bsm411401e87.121.2025.09.03.03.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 03:08:26 -0700 (PDT)
Message-ID: <c1964582-a96a-4b46-afb7-0cdfa8208ef6@blackwall.org>
Date: Wed, 3 Sep 2025 13:08:24 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] net: bridge: reduce multicast checks in fast path
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>
References: <20250829085724.24230-1-linus.luessing@c0d3.blue>
 <20250829084747.55c6386f@kernel.org>
 <bfb11627-64d5-42a0-911e-8be99e222396@blackwall.org>
 <aLdQhJoViBzxcWYE@sellars>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <aLdQhJoViBzxcWYE@sellars>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/2/25 23:16, Linus Lüssing wrote:
> Hi Nik, thanks for the suggestions and review again!
> 
> 
> On Fri, Aug 29, 2025 at 07:23:24PM +0300, Nikolay Aleksandrov wrote:
>>
>> a few notes for v2:
>> - please use READ/WRTE_ONCE() for variables that are used without locking
> 
> Just to understand the issue, otherwise the data path would assume
> an old inactive or active state for a prolonged time after toggling?
> Or what would happen?
>
> 

It's more about marking these as used without locking so KCSAN won't flag them and also
to clearly show people that intent.

>> - please make locking symmetric, I saw that br_multicast_open() expects the lock to be already held, while
>>    __br_multicast_stop() takes it itself
> 
> I think that's what I tried before submitting. Initially wanted
> to have the locking inside, but then it would deadlock on
> br_multicast_toggle()->br_multicast_open()->... as this is the one
> place where br_multicast_open() is called with the multicast spinlock
> already held.
> 
> On the other hand, moving the spinlock out of / around
> __br_multicast_stop() would lead to a sleeping-while-atomic bug
> when calling timer_delete_sync() in there. And if I were to change
> these to a timer_delete() I guess there is no way to do the sync
> part after unlocking? There is no equivalent to something like the
> flush_workqueue() / drain_workqueue() for workqueues, but for
> simple timers instead, right?
> 
> I would also love to go for the first approach, taking the
> spinlock inside of __br_multicast_open(). But not quite sure how
> to best and safely change br_multicast_toggle() then.
> 
> 

Well, this is not an easy one to solve, would require more thought and
changes to get the proper locking, but it certainly shouldn't be left
asymmetric - having one take the lock, and expecting that it's already taken
for the other, that is definitely unacceptable. Please spend more time on this
and think about how it can be changed. Right now I don't have the time to dig
in and make a proper proposal, but I'm happy to review and discuss proposed
solutions.

>> - is the mcast lock really necessary, would atomic ops do for this tracking?
> 
> Hm, not sure. We'd be checking multiple variables before toggling
> the new brmctx->ip{4,6}_active. As the checked variables can
> change from multiple contexts couldn't the following happen then?
> 
> 
> Start: ip*_active = false, snooping_enabled = false,
>         vlan_snooping_enabled = true, vlan{id:42}->snooping_enabled = false
> 
> Thread A)                     Thread B)
> --------------------------------------------------------------------------
>                                br_multicast_toggle(br, 1, ...)
> 			      -> loads vlan{id:42}->snooping_enabled: false
> --------------------------------------------------------------------------
> br_multicast_toggle_one_vlan(vlan{id:42}, true)
> -> vlan->priv_flags: set per-vlan-mc-snooping to true
> -> br_multicast_update_active()
>     checks snooping_enabled: false
>     -> keeping vlan's ip*_active at false
> --------------------------------------------------------------------------
>                                -> sets snooping_enabled: true
>                                -> br_multicast_update_active()
> 			         -> checks vlan{id:42}->snooping_enabled:
> 				    false (from earlier load above)
>                                   -> keeping vlan's ip*_active at false
> 
> Result: vlan's ip*_active is still false even though it should be
> true now?
> 
> .o(Or were netlink and sysfs handlers somehow ensured to never run in
> parallel?)
> 

They are, netlink and sysfs are supposed to take the same locks so they
cannot run in parallel changing options.

> 
> I'm not that versed with atomic's and explicit memory barriers,
> could that prevent something like that even if multiple variables
> are involved? Only used lockless atomic_t's for atomic_inc()/_dec() so far.
> And otherwise used explicit locking.
> 
> 
> 
>> - can you provide the full view somewhere, how would this tracking be used? I fear
>>    there might still be races.
> 
> My original switchdev integration plan so far was roughly still the same
> as in the previous pull-request:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20250522195952.29265-5-linus.luessing@c0d3.blue/
> 
> And using it in rtl83xx in OpenWrt like this:
> https://github.com/openwrt/openwrt/pull/18780/commits/708bbc4b73bc90cd13839c613e6634aa5faeeace#diff-b5c9a9cc66e207d77fea5d063dca2cce20cf4ae3a28fc0a5d5eebd47a024d5c3
> 
> But haven't updated these yet onto this PR, will do that later.

Thanks.


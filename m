Return-Path: <linux-kernel+bounces-761395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97718B1F98B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 12:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E2C18961BC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C36C24166C;
	Sun, 10 Aug 2025 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="YR1t31UB"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7F0235050
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754820125; cv=none; b=VoxIliyrHUsvC1jw/Dz2JF/W0IPiTyA3EwdGZkBqCxa3nCwA3NP8O9/bsJnRQaUSNwU9nGNCksSkuG1mumQtJ8L12ETZmTU4ONgpG/FdGZ3qR2vxMDG69HpyuaegblAHz4GtgGHZKE/pVA29hKZG7StaszUpQoMK492sa30q44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754820125; c=relaxed/simple;
	bh=c+1voJX8nBTMXW7lHnEAaCoAcQeeIif48lxv9PXoIaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bUADuvb+ScMEjbpHoVxFeDysomlPUOh6Nelgo+eIMsZZkrB1TpPSCL/eNTxf3g8UlFMQbD6tZ59dbk8sHw2YvNOUGrhkq4VdpVJlRraestJbjgVyvQqs2xCxOsS2sYaDaMf3nb8/68O6g5CAYXBY0NrgEjEsC/cDJyQk0D51XJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=YR1t31UB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61553a028dfso4516159a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1754820122; x=1755424922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEACopjYN2rowolAJUg1HQBNRhGtzySlAvGBmpEECrQ=;
        b=YR1t31UBxMhrM6kldBW5IUe4CFE6Z/oHyklWSXRtcstzFm9V+Hfofu7oWP4wtNqwZ1
         +vB4zbmVMp3YfbSjrGPUHSkf2XY8Zhsq+ktLsD+m5OWwNp3sLxDasE9KOS69PVqvFG2i
         rKtKeONOqJ6R5I1QXFeo8/bbi9MQ4cGWji5yqipssT4Xvx7/qy5moqI9h1av9sYEjwHA
         LoZRcSk78apw31zbnINz9DpteYV6Qj5IW3u5q1yr3TYouvPQazObWm9Dsdi1Hm/VhvcU
         V/EAGz+Cb5WQcpHJSVLgliV3+RwDzHKYXD3Yi+LWLOel9YdO8FtOpv/NCH41zzJkUces
         A7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754820122; x=1755424922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEACopjYN2rowolAJUg1HQBNRhGtzySlAvGBmpEECrQ=;
        b=e7P7VGI0sHa+0YOElMUn09d0asXd647Hv9AIddFKjxa9k1lYVMb2aeMnTBifoPZRtL
         8hjABlgDD86c2qhPRDBZDl1eNasipT4hM455g90swsifcZrV6VE7HYaq0hbw2usGGK8K
         RYw90EXfKW5gFFF2nhgHPotuUAbKqjFdpoNHcTyRmYtKvwYM/PXMpl8eZo7xz3EZlhSt
         1Gf1CSEcg4pgIc+406s6RtH50UrP7EiyAjXLoU6bjMcA/G4awLS95COj2OPadWHv9fEA
         NM0m6Ehk2al3P3OWgnJbjIR4KtS7Opdgl45hAW9AureG3YlmgaIBDwrmdHMUqqEVTYb4
         976Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDpVU6URPUanXEzPcJra4Oat53NUk12iSVPjrbzmpmbsAOkceiepaJNZbp972AtGxcjNbl8J7u3pWf5Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvuAO/MTpOwDNdckAIayXFKX4voLaDza0c8IWIjzP7cP9j18MT
	LOyKJFbfbfX7VmJqF3yhhP3PWXuj/B50UtKfuxjbJEiFUthiXqky//ae6aL0Kv7yDT0=
X-Gm-Gg: ASbGncvrYoEiKZG1HyzBi7xX6DhJH5gPgtlpB4zfZFaxxV36noy2teFJxL/flO7hkoP
	kvkhAmjNKCvoPXF6BqADBig3Dkvf2rk28zzvZ5xzDKgj/CCe/bunj2yphn4yyEDUsGMs3/ZYV8J
	xzscb4E014Td66Lx68nFLqSw+rCpt9HTtETXN7JQoW/JxJorgOOzbRg1Ap/vc2coScsy4Cm9ttd
	aHrWXJoBDt17vF1uLAhpNYnTBHzx1x+/duOQWmjay6/WTbZ+qT+7sLgJJy/737AwSMf/iwEOvTg
	yj6cv2zsJ2oMJ6KAhN612jgVEECxu5ozT01GAito5Pr8e/kFFD5W8tc7kA0sH6GmK6vJnjsNrK5
	HGb1dsmuo2jUPGskty9O21c5CchyF64l0rsyFdJI=
X-Google-Smtp-Source: AGHT+IFjQw4/ABrZ1wm/2SgchSsETKN0VmoU5eWa/kI/D/ym3eHJeWFT7gThY+fTJdN/SzLQKHZXzg==
X-Received: by 2002:a17:907:3e13:b0:af9:3341:8dd with SMTP id a640c23a62f3a-af9c64f23d6mr919973666b.31.1754820121569;
        Sun, 10 Aug 2025 03:02:01 -0700 (PDT)
Received: from [100.115.92.205] ([109.160.72.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a23fb8bsm1795655966b.123.2025.08.10.03.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 03:02:00 -0700 (PDT)
Message-ID: <d5d95e23-8b1e-4b18-bf15-b627d4193684@blackwall.org>
Date: Sun, 10 Aug 2025 13:02:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: fix soft lockup in
 br_multicast_query_expired()
To: Wang Liang <wangliang74@huawei.com>, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com
References: <20250806094941.1285944-1-wangliang74@huawei.com>
 <9071898b-ad70-45f1-a671-89448ea168df@blackwall.org>
 <1b374635-2444-453f-a7bd-7e732184998e@huawei.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <1b374635-2444-453f-a7bd-7e732184998e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/25 13:36, Wang Liang wrote:
> 
> 在 2025/8/6 18:08, Nikolay Aleksandrov 写道:
>> On 8/6/25 12:49, Wang Liang wrote:
>>> When set multicast_query_interval to a large value, the local variable
>>> 'time' in br_multicast_send_query() may overflow. If the time is smaller
>>> than jiffies, the timer will expire immediately, and then call mod_timer()
>>> again, which creates a loop and may trigger the following soft lockup
>>> issue:
>>>
>>>    watchdog: BUG: soft lockup - CPU#1 stuck for 221s! [rb_consumer:66]
>>>    CPU: 1 UID: 0 PID: 66 Comm: rb_consumer Not tainted 6.16.0+ #259 PREEMPT(none)
>>>    Call Trace:
>>>     <IRQ>
>>>     __netdev_alloc_skb+0x2e/0x3a0
>>>     br_ip6_multicast_alloc_query+0x212/0x1b70
>>>     __br_multicast_send_query+0x376/0xac0
>>>     br_multicast_send_query+0x299/0x510
>>>     br_multicast_query_expired.constprop.0+0x16d/0x1b0
>>>     call_timer_fn+0x3b/0x2a0
>>>     __run_timers+0x619/0x950
>>>     run_timer_softirq+0x11c/0x220
>>>     handle_softirqs+0x18e/0x560
>>>     __irq_exit_rcu+0x158/0x1a0
>>>     sysvec_apic_timer_interrupt+0x76/0x90
>>>     </IRQ>
>>>
>>> This issue can be reproduced with:
>>>    ip link add br0 type bridge
>>>    echo 1 > /sys/class/net/br0/bridge/multicast_querier
>>>    echo 0xffffffffffffffff >
>>>        /sys/class/net/br0/bridge/multicast_query_interval
>>>    ip link set dev br0 up
>>>
>>> Fix this by comparing expire time with jiffies, to avoid the timer loop.
>>>
>>> Fixes: 7e4df51eb35d ("bridge: netlink: add support for igmp's intervals")
>>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>>> ---
>>>   net/bridge/br_multicast.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
>>> index 1377f31b719c..631ae3b4c45d 100644
>>> --- a/net/bridge/br_multicast.c
>>> +++ b/net/bridge/br_multicast.c
>>> @@ -1892,7 +1892,8 @@ static void br_multicast_send_query(struct net_bridge_mcast *brmctx,
>>>       time += own_query->startup_sent < brmctx->multicast_startup_query_count ?
>>>           brmctx->multicast_startup_query_interval :
>>>           brmctx->multicast_query_interval;
>>> -    mod_timer(&own_query->timer, time);
>>> +    if (time_is_after_jiffies(time))
>>> +        mod_timer(&own_query->timer, time);
>>>   }
>>>   static void
>> This is the wrong way to fix it, it is a configuration issue, so we could either
>> cap the value at something that noone uses, e.g. 24 hours, or we could make sure time
>> is at least 1s (that is BR_MULTICAST_QUERY_INTVL_MIN).
>>
>> The simple fix would be to do a min(time, BR_MULTICAST_QUERY_INTVL_MIN), but I'd go
>> for something similar to:
>>   commit 99b40610956a
>>   Author: Nikolay Aleksandrov <razor@blackwall.org>
>>   Date:   Mon Dec 27 19:21:15 2021 +0200
>>
>>       net: bridge: mcast: add and enforce query interval minimum
>>
>> for the maximum to avoid the overflow altogether. By the way multicast_startup_query_interval
>> would also cause the same issue, so you'd have to cap it.
>>
>> Cheers,
>>   Nik
> 
> 
> Thanks very much for your suggestions!
> 
> Similar to the commit 99b40610956a("net: bridge: mcast: add and enforce
> query interval minimum"), it is indeed a better choice to add query
> interval maximum:
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 1377f31b719c..8ce145938b02 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -4818,6 +4818,14 @@ void br_multicast_set_query_intvl(struct net_bridge_mcast *brmctx,
>                  intvl_jiffies = BR_MULTICAST_QUERY_INTVL_MIN;
>          }
> 
> +       if (intvl_jiffies > BR_MULTICAST_QUERY_INTVL_MAX) {
> +               br_info(brmctx->br,
> +                       "trying to set multicast query interval above maximum, setting to %lu (%ums)\n",
> + jiffies_to_clock_t(BR_MULTICAST_QUERY_INTVL_MAX),
> + jiffies_to_msecs(BR_MULTICAST_QUERY_INTVL_MAX));
> +               intvl_jiffies = BR_MULTICAST_QUERY_INTVL_MAX;
> +       }
> +
>          brmctx->multicast_query_interval = intvl_jiffies;
>   }
> 
> @@ -4834,6 +4842,14 @@ void br_multicast_set_startup_query_intvl(struct net_bridge_mcast *brmctx,
>                  intvl_jiffies = BR_MULTICAST_STARTUP_QUERY_INTVL_MIN;
>          }
> 
> +       if (intvl_jiffies > BR_MULTICAST_STARTUP_QUERY_INTVL_MAX) {
> +               br_info(brmctx->br,
> +                       "trying to set multicast startup query interval above maximum, setting to %lu (%ums)\n",
> + jiffies_to_clock_t(BR_MULTICAST_STARTUP_QUERY_INTVL_MAX),
> + jiffies_to_msecs(BR_MULTICAST_STARTUP_QUERY_INTVL_MAX));
> +               intvl_jiffies = BR_MULTICAST_STARTUP_QUERY_INTVL_MAX;
> +       }
> +
>          brmctx->multicast_startup_query_interval = intvl_jiffies;
>   }
> 
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index b159aae594c0..8de0904b9627 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -31,6 +31,8 @@
>   #define BR_MULTICAST_DEFAULT_HASH_MAX 4096
>   #define BR_MULTICAST_QUERY_INTVL_MIN msecs_to_jiffies(1000)
>   #define BR_MULTICAST_STARTUP_QUERY_INTVL_MIN BR_MULTICAST_QUERY_INTVL_MIN
> +#define BR_MULTICAST_QUERY_INTVL_MAX msecs_to_jiffies(86400000) /* 24 hours */
> +#define BR_MULTICAST_STARTUP_QUERY_INTVL_MAX BR_MULTICAST_QUERY_INTVL_MAX
> 
>   #define BR_HWDOM_MAX BITS_PER_LONG
> 
> Set the interval maximum to 24 hours, it is big enough.
> Please check it. If the above code is ok, I will send a v2 patch then.
> 
> ------
> Best regards
> Wang Liang
> 

yeah, that is what I suggested, looks good to me

Cheers,
  Nik



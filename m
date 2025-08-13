Return-Path: <linux-kernel+bounces-766166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CDEB24327
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715AA2A041B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B0F2E92AA;
	Wed, 13 Aug 2025 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="iWkAv5aM"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B2D2E716C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071354; cv=none; b=h2MRq4qPQzNGoAjNcJMurG6xJ7y/QZIS03LGOC0KmydS0BcVP4MAH53Ta188lHWXbxJntXZpIDqBEcKduSRsmBhLk0zW6YHLXEAIlhuFpxXSIIf1IBfSzg+8AvtFQrs//CmezejF8lDhNmDsvbznzOeUVlbCkuKsK23EEngkr8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071354; c=relaxed/simple;
	bh=21w+BvTt/gazVeuYwusahNoigrMUfHAFjc79A1kbxK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkVF/xZgjPaGRk30KGkYS7tiTAZ5swB0WtARxRniB7JrBzaQQkLTOqOLR9XYPoG8iB1BJL2M2XOQy8ydWy4/ByIN0CISDKuh8N0iYeRUiN7KsRenFKfNc8YSGwSeQhm9CE1UGTO/XUWVjE2z8mTyggPwQ25UcJexAgseN14I89M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=iWkAv5aM; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af925cbd73aso1147181466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1755071351; x=1755676151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lmFIylOVee1piWInjTQ1RjbJBz9Hanh5j6QyOwGDpxo=;
        b=iWkAv5aM+uvQ5f0dR4pPLU0sifiO+EMNGVjxlDMVl1E2uJRmDauXI6/N9M8gPQJwc7
         1X97sudgXpiEbcBqZHdUT3UWQbmstJhe+eMZN91n2H51Nx3eTNBzNRANBTxjkQOV0K3y
         IfqHE06x/2XZxHQW6JVgjdV2mP4S6VjKFP3Ck5tQMemCWxTNUdQUrU9eTnWtG7cI/uqV
         2i8wJwpkiXe8Tc7wH+B2s0Z9slbJOqvxVuRLr+ciAUHRnVevuan5QJJsn+oP8+byp9iA
         96jwh2WV5p6yD9mRkR546ZGy2ECcmhxOjpu04UMpQuiy3MrP2/xcjzWb4ktLjxyMRaSJ
         3j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755071351; x=1755676151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmFIylOVee1piWInjTQ1RjbJBz9Hanh5j6QyOwGDpxo=;
        b=Ca52X4edi3CY5NsUmm0ctvx9ouVBzdMyRbXEAH5zMGu63bKrlVcsc0wpork5YJI8K2
         PfPYmuFFJOpnNp1DJzg7Ur5rpq9L3QxHrpWuPjsXF0N0clczjTmPbZ2UiiARGQ9klH98
         dc7UQJZUtza5TzwhhNvIXC8AUJ92SoU0F6lpnM0tfeo/WYcvVwzt63SepdVY7hSMODX1
         /dyQf+TPycoGPOatheuclIIViiz/PPoZ/paH83DhiBRY/ZIDtpBQ/a3ADU7FIEmRrJNJ
         uduxU3klH6/KVFRArJ//D6Xw3BNG+nQWOOPHD67yknCq1/5VYnUC0oaUo50P1mK238lY
         V/Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUaBWPwjpKOK7DIEPrdurypoLGnTFYxL6Cadnf55JbhPmhCoBOFYTH0XITBEba8HQDUz0l87PzvMakew6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz2X6ncGAPGjfSTF5eukyWkBESnC/DSEGaOfvNjsXphrZIjymG
	q6HiCIRHkJcCXCqG0FMEr2rN3zg9hAZKsRAth+npJuKl3hXI9xVZ8Vre7unUqe6Za/I=
X-Gm-Gg: ASbGncunhbDa8WmL7UV4NjoCVtcwtYyW0ww15blNHqTwSUjCoGhraQxRg0d/MLdwgf0
	+eCsonbt5ZN13FAJ5tzZZD6wMymq7s2K7olNvm0lTPHxf42eYmbZw4PX3Qy14uCFRWoadPBAf6i
	R8d0kXvye752cixBmTYaUBT9KpgnZobaPY7LojOHvbftnS/rkVGKYVfzl9PG8GtwKpwJXnC/NZB
	Xue8GPts3n+daoaqQ3OG2ztDps/BbLo7z88SOt7ArxA0UyzmaR+yZw1HUu+CZOdKohwd+r1jlD0
	FFK4t5lXVe1WG579lEk9rzLBwEnkULUM76TyQVzQUryT9sgNw5o/b5B6GqGsAv8Es9Zt+H5DUOe
	SuqmAUomUyZsK9rxpfMY3KMUdWoO4
X-Google-Smtp-Source: AGHT+IG7OQqQwH/e7BKLXt05IU5ZlDG7VA0XSSPKWCJkPKoysN9P3lttRT8vmaNa2qYFupqFnd6GGw==
X-Received: by 2002:a17:907:9408:b0:ae3:5e2a:493 with SMTP id a640c23a62f3a-afca4ea46c4mr196943466b.49.1755071351065;
        Wed, 13 Aug 2025 00:49:11 -0700 (PDT)
Received: from [100.115.92.205] ([109.160.72.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a23fd00sm2334857566b.122.2025.08.13.00.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 00:49:10 -0700 (PDT)
Message-ID: <7641f60d-2d34-4e2c-a467-07cfaba970a9@blackwall.org>
Date: Wed, 13 Aug 2025 10:49:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: bridge: fix soft lockup in
 br_multicast_query_expired()
To: Wang Liang <wangliang74@huawei.com>, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com
References: <20250813021054.1643649-1-wangliang74@huawei.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250813021054.1643649-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 05:10, Wang Liang wrote:
> When set multicast_query_interval to a large value, the local variable
> 'time' in br_multicast_send_query() may overflow. If the time is smaller
> than jiffies, the timer will expire immediately, and then call mod_timer()
> again, which creates a loop and may trigger the following soft lockup
> issue.
> 
>    watchdog: BUG: soft lockup - CPU#1 stuck for 221s! [rb_consumer:66]
>    CPU: 1 UID: 0 PID: 66 Comm: rb_consumer Not tainted 6.16.0+ #259 PREEMPT(none)
>    Call Trace:
>     <IRQ>
>     __netdev_alloc_skb+0x2e/0x3a0
>     br_ip6_multicast_alloc_query+0x212/0x1b70
>     __br_multicast_send_query+0x376/0xac0
>     br_multicast_send_query+0x299/0x510
>     br_multicast_query_expired.constprop.0+0x16d/0x1b0
>     call_timer_fn+0x3b/0x2a0
>     __run_timers+0x619/0x950
>     run_timer_softirq+0x11c/0x220
>     handle_softirqs+0x18e/0x560
>     __irq_exit_rcu+0x158/0x1a0
>     sysvec_apic_timer_interrupt+0x76/0x90
>     </IRQ>
> 
> This issue can be reproduced with:
>    ip link add br0 type bridge
>    echo 1 > /sys/class/net/br0/bridge/multicast_querier
>    echo 0xffffffffffffffff >
>    	/sys/class/net/br0/bridge/multicast_query_interval
>    ip link set dev br0 up
> 
> The multicast_startup_query_interval can also cause this issue. Similar to
> the commit 99b40610956a ("net: bridge: mcast: add and enforce query
> interval minimum"), add check for the query interval maximum to fix this
> issue.
> 
> Link: https://lore.kernel.org/netdev/20250806094941.1285944-1-wangliang74@huawei.com/
> Link: https://lore.kernel.org/netdev/20250812091818.542238-1-wangliang74@huawei.com/
> Fixes: d902eee43f19 ("bridge: Add multicast count/interval sysfs entries")
> Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>   net/bridge/br_multicast.c | 16 ++++++++++++++++
>   net/bridge/br_private.h   |  2 ++
>   2 files changed, 18 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



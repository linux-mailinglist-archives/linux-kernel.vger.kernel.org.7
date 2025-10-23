Return-Path: <linux-kernel+bounces-866866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5748CC00E13
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2651B3A321F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A36330E856;
	Thu, 23 Oct 2025 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Voj3jP3m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F3530E821
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219866; cv=none; b=rBLTVjcKxImMfqWZ2lxdm6XqJK7eZVZkr2E9WwJ21cdmPjsyk9XAcpBwq9eZIgxeyC8Y4Gz983iOPja+NepBhBX4fztylnX8kyKsqkU8dFSwtJMR4eYOrPRtYFNpD32dk7GRl4WykXmOpfyKkghjf8sR63U44xQutCb5KdJ0X5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219866; c=relaxed/simple;
	bh=V515WjHuILLU+8tNTBNpbWGXfmgFWkUZc4kfGyLRu5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brPMWiEFcBOA6MEdYx2TrwuAAgmmORNT7w84tR2QXhuaYPJNWVlq/JjOBr9hq+OfFgzXZEgfjmNIfxkJ85bTUNSghPJAVCsXX0LvNqX9EX7tzW2qp4rGF2W9AYRhhsNTOvg6BKWQ8HbGqieZeaDq8mZr0Ix6b+ZkvxvEBL44O9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Voj3jP3m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761219863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rXC9I/gqGLzvMaY95b2W891cPW1ryM6oOh9smYbOgEI=;
	b=Voj3jP3maUzYi0+sGAMoka03eG+fFpSHmbfs17f7+JRQo4HAMeAKbFFOCciVjnPTxcHFqz
	3wZN+KGnhS2nTIgJGh59c7mmcUTq2R+n7IuBEt9l0D7hqb+96lW18PU8Kp2GbqjbKhgan6
	isY/RLDxHANYTo/ZggxOshKfYR0utcs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-gUKW7PEzN_SkVH4d6wEX9A-1; Thu, 23 Oct 2025 07:44:22 -0400
X-MC-Unique: gUKW7PEzN_SkVH4d6wEX9A-1
X-Mimecast-MFC-AGG-ID: gUKW7PEzN_SkVH4d6wEX9A_1761219861
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47105bfcf15so3531775e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219861; x=1761824661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXC9I/gqGLzvMaY95b2W891cPW1ryM6oOh9smYbOgEI=;
        b=YNHdr3fZMGwfwQu1frb4J/PhlyBJdXCGTp46zKLIm+ip1JqawKLhnBy5yWXUlkBeYE
         yDQO6lS2dxrtK/zEbrjrk4GZVh9pJ+J1u8bHq7hYNBdKE7MqffidxpxVx/2vytJe/X0Q
         cz79TRkoqOp5JgUcdVg91DKUFi2+0Z5Swv10/d7eRSStS1/oZi3ciTQHog1T7DKO8l4c
         JS86fkdlSuWee2cu9xmAtsFG4uN7D8FLyFUJpNKowgXfYqkXIvKXjnjogefnvnTAH+D8
         2F677Yb3EK40V3B8rwHxNMa9FshhiLNP7b/fXJ8ag2Sqtl17aQhVakxDEmdjuKayfKp2
         Mg2A==
X-Forwarded-Encrypted: i=1; AJvYcCVA4tnOOiKimU3ixJotvC1l1e7YzMN0EjxjtR6ixP3uzlggkO1PlR6c8Tlvsay8VdZNI9/Q9My1hAidXAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8/t0yGR1nZF4ImsR2Snplyd3oy7yPkey8qg+nMJFu910R0b1u
	eNBH+hG47db+6grJ3A6A3WvPPVLkNjIvwiCS4jpKZKV6sdG0Vr1hS1BRiPxRf0UUSLiAtPcC0TE
	K0MfhvhG4IttiBHzeblRwmPRqMjgBeAEn86/3qRK5/23jQ+ESICM1MDNweQ+bOFDqqA==
X-Gm-Gg: ASbGnctGdBXk7Xst7LmFAHiZLXcQJ1cOAI/7MIwx6qkLY36n3SVpZsbnmqrr645zPbr
	PKuFd3ehwY64L74IWnl7+G8ApswLTAOhcPKMv6lsPGEjHYkxNjH2Bjvy4M7h2Zye9CUJ+3sSPzR
	WUiKiHLTZFYjJt8t0+CM35uvHcaweN24AhYzShlYhvMseGcQ6KN8Goq9WtIuKTfsWL10d81QNi2
	alox0+oh8vq8+N4+S6MGA5lfET5pw4lxgWN800eLbnfLTN/tiHMEaqaNcklBeoAM968kKTh2aQN
	L8VfdxJ1I3I1tE7zoGLubRCFX22bWhoi6rn1iPi0M9lGzdUiBfYMkvHloZUusdtzZta4ErMUVcX
	gCTbWpK0WM2he16u43FUNiSm5nv80XC7ZWCNSvXXwFBqCuWk=
X-Received: by 2002:a05:600c:540c:b0:471:12be:743 with SMTP id 5b1f17b1804b1-471178a3f93mr178692175e9.15.1761219861212;
        Thu, 23 Oct 2025 04:44:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9ZhN8mEzvDl19eAfb5+piHJIx0UNn6iM8BVw8iQ/eotSJnTtbF+oUAQOCAOFM12uWUwrycg==
X-Received: by 2002:a05:600c:540c:b0:471:12be:743 with SMTP id 5b1f17b1804b1-471178a3f93mr178691905e9.15.1761219860831;
        Thu, 23 Oct 2025 04:44:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897e75a0sm3525020f8f.5.2025.10.23.04.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:44:20 -0700 (PDT)
Message-ID: <7232849d-cf15-47e1-9ffb-ed0216358be8@redhat.com>
Date: Thu, 23 Oct 2025 13:44:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] netrom: Prevent race conditions between neighbor
 operations
To: Lizhi Xu <lizhi.xu@windriver.com>, dan.carpenter@linaro.org
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 syzbot+2860e75836a08b172755@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <aPcp_xemzpDuw-MW@stanley.mountain>
 <20251021083505.3049794-1-lizhi.xu@windriver.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251021083505.3049794-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/25 10:35 AM, Lizhi Xu wrote:
> The root cause of the problem is that multiple different tasks initiate
> SIOCADDRT & NETROM_NODE commands to add new routes, there is no lock
> between them to protect the same nr_neigh.
> 
> Task0 can add the nr_neigh.refcount value of 1 on Task1 to routes[2].
> When Task2 executes nr_neigh_put(nr_node->routes[2].neighbour), it will
> release the neighbour because its refcount value is 1.
> 
> In this case, the following situation causes a UAF on Task2:
> 
> Task0					Task1						Task2
> =====					=====						=====
> nr_add_node()
> nr_neigh_get_dev()			nr_add_node()
> 					nr_node_lock()
> 					nr_node->routes[2].neighbour->count--
> 					nr_neigh_put(nr_node->routes[2].neighbour);
> 					nr_remove_neigh(nr_node->routes[2].neighbour)
> 					nr_node_unlock()
> nr_node_lock()
> nr_node->routes[2].neighbour = nr_neigh
> nr_neigh_hold(nr_neigh);								nr_add_node()
> 											nr_neigh_put()
> 											if (nr_node->routes[2].neighbour->count
> Description of the UAF triggering process:
> First, Task 0 executes nr_neigh_get_dev() to set neighbor refcount to 3.
> Then, Task 1 puts the same neighbor from its routes[2] and executes
> nr_remove_neigh() because the count is 0. After these two operations,
> the neighbor's refcount becomes 1. Then, Task 0 acquires the nr node
> lock and writes it to its routes[2].neighbour.
> Finally, Task 2 executes nr_neigh_put(nr_node->routes[2].neighbour) to
> release the neighbor. The subsequent execution of the neighbor->count
> check triggers a UAF.
> 
> The solution to the problem is to use a lock to synchronize each add a
> route to node, but for rigor, I'll add locks to related ioctl and route
> frame operations to maintain synchronization.

I think that adding another locking mechanism on top of an already
complex and not well understood locking and reference infra is not the
right direction.

Why reordering the statements as:

	if (nr_node->routes[2].neighbour->count == 0 &&
!nr_node->routes[2].neighbour->locked)
		nr_remove_neigh(nr_node->routes[2].neighbour);
	nr_neigh_put(nr_node->routes[2].neighbour);

is not enough?

> syzbot reported:
> BUG: KASAN: slab-use-after-free in nr_add_node+0x25db/0x2c00 net/netrom/nr_route.c:248
> Read of size 4 at addr ffff888051e6e9b0 by task syz.1.2539/8741
> 
> Call Trace:
>  <TASK>
>  nr_add_node+0x25db/0x2c00 net/netrom/nr_route.c:248
> 
> Reported-by: syzbot+2860e75836a08b172755@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2860e75836a08b172755
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>



> ---
> V1 -> V2: update comments for cause uaf
> V2 -> V3: sync neighbor operations in ioctl and route frame, update comments
> 
>  net/netrom/nr_route.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
> index b94cb2ffbaf8..debe3e925338 100644
> --- a/net/netrom/nr_route.c
> +++ b/net/netrom/nr_route.c
> @@ -40,6 +40,7 @@ static HLIST_HEAD(nr_node_list);
>  static DEFINE_SPINLOCK(nr_node_list_lock);
>  static HLIST_HEAD(nr_neigh_list);
>  static DEFINE_SPINLOCK(nr_neigh_list_lock);
> +static DEFINE_MUTEX(neighbor_lock);
>  
>  static struct nr_node *nr_node_get(ax25_address *callsign)
>  {
> @@ -633,6 +634,8 @@ int nr_rt_ioctl(unsigned int cmd, void __user *arg)
>  	ax25_digi digi;
>  	int ret;
>  
> +	guard(mutex)(&neighbor_lock);

See:

https://elixir.bootlin.com/linux/v6.18-rc1/source/Documentation/process/maintainer-netdev.rst#L395

/P



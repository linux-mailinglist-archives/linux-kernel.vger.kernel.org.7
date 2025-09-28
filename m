Return-Path: <linux-kernel+bounces-835487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC88DBA7461
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 17:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050221899705
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 15:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1CD1F7575;
	Sun, 28 Sep 2025 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IcdDLQz4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A9E33EC
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759074931; cv=none; b=n0djxU5Af7yMSkt5FA9c/GsMhjqbrnqVqpu2AGX/1RRSxX3bFOBZFt7E+FC4nqAqW55IyF167l8pxpDJ3WNh6BlFIAwKWsN4MDV7gSpsl6vyDw28UNJty/2PpSKDcqXbDO1UIWe0Edr19rplMZEzcrQeMSeTMlzb2LRdyq+OLwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759074931; c=relaxed/simple;
	bh=InH0Q4bfuhew+O7ID1IBmJb8i9UrhYvgr4K57hAcb4Q=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=IcL8ZYLb0TGihbcJtxk8BQ1eYVjSshPFDgrgqKG8U/puEq7bBoEjzkJ1C2XsIOhQl3vuKqzdlO2lScBeiLJv7PwGYyYAUhaX1lOy3uMxPOzvTEaYwMKGaAEgXd1iUHJeBzIN5AHsijw2oFabfb8CdJRcsn81oiyGSlsvVt2rMnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IcdDLQz4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759074927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Td8rThlLtHr0yP281nhMogF7Dq+OgSAtIoq5hy+Tw4o=;
	b=IcdDLQz4Of/aNvaxxda82YVKU+eBzANrQgiymIT4qsBo44gv5bRBKpo81CLWE0sv0JQaru
	OrWT97AZru98p1yCNgp7j30JKdrIHS44FdCwj37R6TdBKpMYlkWznKbx8/e1j5+GmBmhOD
	OY2TYR9pbt7YUf028kDzboY/F2QdiWY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-ixcY06MKN-y4BEhZ3BSsMA-1; Sun, 28 Sep 2025 11:55:26 -0400
X-MC-Unique: ixcY06MKN-y4BEhZ3BSsMA-1
X-Mimecast-MFC-AGG-ID: ixcY06MKN-y4BEhZ3BSsMA_1759074926
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-79390b83c48so70251646d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759074924; x=1759679724;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Td8rThlLtHr0yP281nhMogF7Dq+OgSAtIoq5hy+Tw4o=;
        b=YfUEYLnTSfXsyR8Uc/aNBz+qRLglV9c1FBQ6E9VF1PJdti+mai9ECnEllUbfvDK3RB
         ddpSCBbqzA888TqRjRgX0+ghQJ+V/mtNCpDVdYz5bnUPKlY32TE+5pW0hfkDSYaH5els
         MY1GGY60sREUxu/2FuURDzMq611sRu17t3YpbQinQ4lsWXphjrqCZQlsi+BZp5ISfyn/
         SQUoiEKH++e4VnZjtGbli0y8Qos/RK4ajrh3qWLLqOIMnD79IqSraGpjXU0hHglqrQXj
         9xYTg9i3nKLpl0KJbeVvpsKqWSKSgJW0QOVES9ZF2sbYd1XtvlvCJ1Z3WtK9tasHNMqh
         7E8A==
X-Forwarded-Encrypted: i=1; AJvYcCUZCIdyrAYDfqsa0tPUtE9KGS+Xj85tVkMd0e/5tL5o25VY71qj0zen1FbnY9ssBptfkuAtme3O/nljyf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZBmRqKqDi6ktTBA1eMWG4CfSP8YNxB4KaAPxE/MiZTg3i0ens
	LD/6/eWX6i653/RC23BeVljh7Jg0d5B2V+joC7occJDfFTOXMDz4/lAH+Fkpbo1FFo5IUnDMAY2
	QohQTWvtwtw/XEMVC+yBywIF13AyGPvclamRp5Q6Xu68bRS8E6rEMCL9mi8OfldzjYQ==
X-Gm-Gg: ASbGncvv+s8pJZt7quKTEle0szNkLXHJBvotxdx3coPNYO3Z4Zbpdnqw7fi5clk3k3+
	s3avC3MhbJZXvK7AayCI6EngeTS5alr0p7GD2g9vNmTasQ03pHBpRkCBMoG0NWAJSOWK34CPgxp
	4sneZ6MVW0qlKrez7lFCpjFQ1VIMGi83TVTAcWn2Zp73xAzXrFY0rVJEYjUlRY69Z3B7EKiItS5
	kBs5t90QRgNCsTH+Zj/hnaYzuNi5684aUQPACJNSnecQ0XGjcl91lkiOcWok+26kLVShkFEm9NW
	O7WBOG+EzmFlz1gukk0cmao3N4O8Qm5Vfmi6wz92aHPFon8JiTOCJ9pzl57gcRz0x8ByjD/apZP
	uuqANCUr7ayM=
X-Received: by 2002:a05:6214:27ef:b0:767:1821:d46c with SMTP id 6a1803df08f44-7fc41f570ccmr188714766d6.50.1759074924200;
        Sun, 28 Sep 2025 08:55:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2bl5YrzdGnBAoZxzd+7Dk9geZ60La7VLlCxGNXD05HJZhfOsYrSH325yo0LyFKUkEd7gdtw==
X-Received: by 2002:a05:6214:27ef:b0:767:1821:d46c with SMTP id 6a1803df08f44-7fc41f570ccmr188714586d6.50.1759074923800;
        Sun, 28 Sep 2025 08:55:23 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8016701923csm56190366d6.36.2025.09.28.08.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 08:55:23 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f6b88959-aed3-423f-a12d-46bb679820e1@redhat.com>
Date: Sun, 28 Sep 2025 11:55:22 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/mutex: add MUTEX_WARN_ON to warn invalid mutex
To: buckzhang1212@yeah.net, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20250927080018.13909-1-buckzhang1212@yeah.net>
Content-Language: en-US
In-Reply-To: <20250927080018.13909-1-buckzhang1212@yeah.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/25 4:00 AM, buckzhang1212@yeah.net wrote:
> From: "buck.zhang" <buckzhang1212@yeah.net>
>
> Here is a kernel exception about mutex and I can recreate it stably.
> First we define a struct contains a mutex.
> Then allocate this struct by kmalloc without calling mutex_init.
> Finally when multiple tasks call mutex_lock together,kernel will panic.
> This lock is used normally when only one task is using  at a time.
> the exception reason is that lock->wait_list is an invalid kernel list.
> I want to add more warnings when enable CONFIG_DEBUG_MUTEXES
> kernel crash log:
> Unable to handle kernel NULL pointer dereference at virtual address 0000000
> pc: __mutex_add_waiter+0x68/0x160
> lr: __mutex_add_waiter+0x128/0x160
> sp: ffffffc0866f3ac0
> x29: ffffffc0866f3ad0 x28: ffffff8095148000 x27: 0000000000000000
> .............
> x2: ffffffc0866f3b18 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
> __mutex_add_waiter+0x68/0x160
> __mutex_lock+0x48c/0x119c
> __mutex_lock_slowpath+0x1c/0x2c
> mutex_lock+0x48/0x144
> Test case:
> struct chip_mutex {
> 	struct mutex tmutex;
> };
> static void work_handler1(struct chip_mutex *cmutex)
> {
>          mutex_lock(&(cmutex->tmutex));
> }
> static void work_handler2(struct chip_mutex *cmutex)
> {
>           mutex_lock(&(cmutex->tmutex));
> }
> static void chip_tmutex(void)
> {
> 	struct chip_mutex *cmutex;
> 	cmutex = kzalloc(sizeof(struct chip_mutex),GFP_KERNEL);
> 	work_handler1(cmutex);
> 	------
> 	work_handler2(cmutex);
> }
>
> Signed-off-by: buck.zhang <buckzhang1212@yeah.net>
> ---
>   kernel/locking/mutex.c |  2 ++
>   kernel/locking/mutex.h | 11 +++++++++++
>   2 files changed, 13 insertions(+)
>
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index de7d6702c..318d98f2f 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -574,6 +574,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   
>   	might_sleep();
>   
> +	/* In case the mutex is uninitiated, add more warning */
> +	MUTEX_WARN_ON(mutex_waitlist_invalid(&lock->wait_list));
>   	MUTEX_WARN_ON(lock->magic != lock);

By enabling CONFIG_DEBUG_MUTEXES, the lock->magic check should have 
uncovered the case of mutex_lock() call without mutex initialization. 
The extra wait_list check is likely not necessary.

Cheers,
Longman



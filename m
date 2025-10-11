Return-Path: <linux-kernel+bounces-848969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79626BCEEC3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5040C4E5BC3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD7D1A23B6;
	Sat, 11 Oct 2025 03:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNO+9SRa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF535EEBA
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 03:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760152557; cv=none; b=lMdXa4YdpB1tYpeGdtRwEloUFLOhTxxnCmdFbLEgqqbgS3ZrdjJ0daE6k5+TTkg/W/iYqMCA/CMfkzlvTIvKHvH/lPZyCfOEDfGEJH0AbC987duRgOsB43D6qkI8NNFeup6cxniyF8dUNiiKsblk6VMHL9A7Fcg4BD+Leo30wk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760152557; c=relaxed/simple;
	bh=VltC57Gde5qAIn2NU4Q3JkB0XcKrvTZOf2y13S4azFk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=rAXYmifcRIZ3qto5knrhtRrvGDbrZLIOR8GodRleIU/bgZNSMWUXZtItVVoKRbnqLI3jz807FxPW26sSMrq8ytVY1J/Iu9dVJOx07ONBQeRxXD8jMNhh93tRO7VXisqoNIxbsd7Hf00a1dNYw0hS7uSlWyFNGiUdaMV/hQSs2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNO+9SRa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760152554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4AvGiKFA0bVTZZHvhual94xdey1ZUybJX8sXGT6X+Y=;
	b=hNO+9SRaqvVp1DOVJP/tJ7qgYF6owdU3gMxyT4QYxxoy2ycRy0C+tRiTAfrunszXH28jp8
	mST/XeMGhGaxMNVsZm5JoustepnCLJWDq4c48rnt45vzRvCmZ14gMN5SwLnfZ6BeB2VlPD
	35oJuQ54vHJnCr8PnVFuD4lSxVt9XRs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-Hy_YL_mxNQ-VLqIj7VxHRQ-1; Fri, 10 Oct 2025 23:15:53 -0400
X-MC-Unique: Hy_YL_mxNQ-VLqIj7VxHRQ-1
X-Mimecast-MFC-AGG-ID: Hy_YL_mxNQ-VLqIj7VxHRQ_1760152553
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-870d82c566fso1315969085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 20:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760152553; x=1760757353;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4AvGiKFA0bVTZZHvhual94xdey1ZUybJX8sXGT6X+Y=;
        b=enx0Z62wHWtj2MUtGwA/WQyjrgFS9UZdo+gDTHOBaM2NvcjbU7x/zUG5tWyv7FcRNf
         0wBngadu+NeJhhiZSzUGQkp1Q4mT9V/FAK7kIV72fckh7XLeUYS7Ng2wG5550an7RiOO
         ZBH5nS+12P6HaExDA5k5CfKMzqWluTGVNww++fUYxV5oNKRgxspwDeO6G30NV9DVSleU
         FUmldPyFyM9Pclp9LcV1I17cbi6g4+cq7tkiO/ta8rKeuW3K5lVI8H6YRVcuffnTXrU0
         k6dPkRuGk5ZhXD41wDFt8U8wrmJtRwrhIZJHXXw//E3xLmWxexqr5VSQ+tnc/YkDj7mI
         EzBg==
X-Forwarded-Encrypted: i=1; AJvYcCVqce+FPB6eKPlLbwZt+wG2ZoKcI+QSWjWcXlVmuToi85ZhcuKnCbz8acqe5ZBhPipUkGpsbIVlRCsnT0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7c0hoHFeP1Z/TE1d02DqIZLNUYc8M2l2rT0y27M/1MdjFcMXs
	p87nvhqC2aP6w0Mr13i6r9hsm7ZJQEvyDNqehCCwr+iS+HG8A05yMLU0pPN8jEWS/579h2IfEMQ
	gmXVzm120l6R8TY+fuwVBwLeQvcE6vLtK/MZc7fKFQDYjvNnblNYni0csi/B1akMkQQ==
X-Gm-Gg: ASbGncubVaIKGXL3CjlgJfOU9IlzMJZaRkSz4FSgTvQUuRBXeq0UUSvlJREowWvFj8L
	uOKCzwLhFWwObgkSmsHiKVeELYIp5uyqSNfQzU9FMIKkAL7tk3zVTmAgXzZjJCAnNBIwSioIX+u
	uzgzq6Mqr+7MQIwt50zFNW0bljnK7LFU9Jxf/IexFNK0TPyISLamOo7lPTXpANPfRdlkPf0dUDi
	s+qrQCsUdWxbvcsWkv74Tr5Sk2IaexEumSiwxPtI3uQQYJVOhcnpPwS5GcOcnZXL6NznYiiuv7/
	/eU7TJbshpYKu2U5X5a5DwBi5O6XAizjToF+dvwqPX+cC0YyfXDI2hLGXVL5O8kO5GvYtX0WRnD
	rCP7cE9VjMTE=
X-Received: by 2002:a05:620a:f15:b0:855:9556:8ec8 with SMTP id af79cd13be357-8820cacfefemr2495047885a.26.1760152552652;
        Fri, 10 Oct 2025 20:15:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs6ylqVIka6Yk+F42bCkJM2uAyzElx04EzQlyRYGYQWnsPeeGiR9iDwMxc/XVt6Vy9OJyphA==
X-Received: by 2002:a05:620a:f15:b0:855:9556:8ec8 with SMTP id af79cd13be357-8820cacfefemr2495045585a.26.1760152552224;
        Fri, 10 Oct 2025 20:15:52 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a1ca2a6fsm524653185a.34.2025.10.10.20.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 20:15:51 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4482c890-f082-4946-b6ab-a7b57b02db22@redhat.com>
Date: Fri, 10 Oct 2025 23:15:50 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lock: Add doc comments for spin_lock_irq()
To: Daroc Alden <daroc@lwn.net>, corbet@lwn.net,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 "open list:LOCKING PRIMITIVES" <linux-kernel@vger.kernel.org>
References: <20251010215403.743811-1-daroc@lwn.net>
Content-Language: en-US
In-Reply-To: <20251010215403.743811-1-daroc@lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/10/25 5:53 PM, Daroc Alden wrote:
> The commonly used spin_lock_irq(), spin_lock_irqsave(),
> spin_unlock_irq(), and spin_unlock_irqrestore() functions do not
> currently have any documentation; this commit adds kerneldoc comments
> to these four functions describing when their behavior and when they are
> appropriate to use.
>
> Signed-off-by: Daroc Alden <daroc@lwn.net>

This patch looks fine. Just wonder why just 
spin_lock_irq()/spin_lock_irqsave() and not spin_lock()/spin_lock_bh() 
as these functions also don't have kerneldoc comments. Also 
spin_lock_irqsave() is a macro and not actually a function, maybe we 
should mention that in the comment.

Cheers,
Longman

> ---
>   include/linux/spinlock.h | 53 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
>
> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> index d3561c4a080e..35bd55605319 100644
> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h
> @@ -371,11 +371,47 @@ do {									\
>   	raw_spin_lock_nest_lock(spinlock_check(lock), nest_lock);	\
>   } while (0)
>   
> +/**
> + * spin_lock_irq() - Lock a spinlock while disabling interrupts.
> + * @lock: The spinlock that will be locked.
> + *
> + * When a spinlock is shared by code running in interrupt context and process
> + * context, it is important to ensure that interrupts are disabled while the
> + * lock is held. Otherwise, an interrupt handler might attempt to take the lock
> + * while it is already held, leading to a deadlock.
> + *
> + * This function unconditionally disables interrupts on the local CPU, and then
> + * locks the provided spinlock. It is suitable for use in contexts where
> + * interrupts are known to be enabled — because the corresponding unlock
> + * function, spin_unlock_irq(), unconditionally enables interrupts.
> + *
> + * When code can be called with interrupts either enabled or disabled, prefer
> + * spin_lock_irqsave(), which preserves the current state so that it can be
> + * restored when the spinlock is released.
> + */
>   static __always_inline void spin_lock_irq(spinlock_t *lock)
>   {
>   	raw_spin_lock_irq(&lock->rlock);
>   }
>   
> +/**
> + * spin_lock_irqsave() - Lock a lock, disable interrupts, and save current state.
> + * @lock: The spinlock that will be locked.
> + * @flags: An unsigned long to store the current interrupt state.
> + *
> + * When a spinlock is shared by code running in interrupt context and process
> + * context, it is important to ensure that interrupts are disabled while the
> + * lock is held. Otherwise, an interrupt handler might attempt to take the lock
> + * while it is already held, leading to a deadlock.
> + *
> + * This function disables interrupts on the local CPU if they are enabled, and
> + * then locks the provided spinlock. The previous state of interrupts (enabled
> + * or disabled) is saved in the @flags argument so that it can be restored by
> + * the corresponding call to spin_unlock_irqrestore().
> + *
> + * When code will only be run with interrupts enabled, using spin_lock_irq() can
> + * avoid the need to create a local variable to save the state.
> + */
>   #define spin_lock_irqsave(lock, flags)				\
>   do {								\
>   	raw_spin_lock_irqsave(spinlock_check(lock), flags);	\
> @@ -396,11 +432,28 @@ static __always_inline void spin_unlock_bh(spinlock_t *lock)
>   	raw_spin_unlock_bh(&lock->rlock);
>   }
>   
> +/**
> + * spin_unlock_irq() - Unlock a spinlock and enable interrupts.
> + * @lock: The spinlock that will be unlocked.
> + *
> + * This function unlocks the provided lock, and then unconditionally enables
> + * interrupts on the current CPU. It should typically correspond to a previous
> + * call to spin_lock_irq().
> + */
>   static __always_inline void spin_unlock_irq(spinlock_t *lock)
>   {
>   	raw_spin_unlock_irq(&lock->rlock);
>   }
>   
> +/**
> + * spin_unlock_irqrestore() - Unlock a spinlock and restore interrupt state.
> + * @lock: The spinlock that will be unlocked.
> + * @flags: The previously saved interrupt state to restore.
> + *
> + * This function unlocks the provided lock, and then restores interrupts to
> + * whichever state (enabled or disabled) is indicated by @flags. @flags should
> + * come from a previous call to spin_lock_irqsave().
> + */
>   static __always_inline void spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
>   {
>   	raw_spin_unlock_irqrestore(&lock->rlock, flags);



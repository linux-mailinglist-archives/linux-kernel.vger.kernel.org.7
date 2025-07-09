Return-Path: <linux-kernel+bounces-724278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E56EBAFF0BB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F531BC188B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F4A236A7C;
	Wed,  9 Jul 2025 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BychyYrA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2978C1CD1E4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752085152; cv=none; b=scxDOQe5XuQ0KaWbGdZ3UETIkY88eOOclfQTjGLs9CrI44HWr+xE3RL0nXs0nSH0xQiGw0rpAaZmPtM1f7cezpAmo0I9fsYqenZJOiDRghlm5VLYcV0JtnMP1mGeqaYMrqszXVdmVSVqaBhV/UQjz8dVk8y6PMj/4NK2BQV+2zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752085152; c=relaxed/simple;
	bh=00Dqm0qYe8KLT3rIiWw5Oa9GFRBea3AiQ6HU7g8zxXc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sibdegt7WJ34+I+8DyFJlnBXn+ORE2zwGmtNVXD0MOX/M5kBzcEwnIuCuA3tIdtZrgz80R1vnuaBV0pNYmjhaA2KtyaezgXxoTIu4i4knFlYx6bSzVdB4HzYoQloPMoXRjhUDkdaJyR6vrCoJLsy1HniPmaxGFuKT+dRhOlYJBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BychyYrA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752085149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xwCqMLQS932hkFS/nCjiScWN/hX1XNNxPl82aoDufjs=;
	b=BychyYrArEbULUcHlFPcBfmIH74qcXfMZqBIoeqZCrRmihe+M+/jn8X3zd6fzrXImWnGH1
	4p6ht3UbyWn1lRK93mxDpNhGVGw9/bPnnWOrv55U5c+e2jsmfSUZdRL3XgyRHBlevytSpQ
	4VBdEhJkpVFB+6n23Svfi/f19zCBn/4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-W88UmLMvNgmNcZwQma2Gvw-1; Wed, 09 Jul 2025 14:19:08 -0400
X-MC-Unique: W88UmLMvNgmNcZwQma2Gvw-1
X-Mimecast-MFC-AGG-ID: W88UmLMvNgmNcZwQma2Gvw_1752085148
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb50d92061so3235386d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 11:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752085148; x=1752689948;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwCqMLQS932hkFS/nCjiScWN/hX1XNNxPl82aoDufjs=;
        b=sCTinWdl1E76R5doCzpqjANKhXEpeP9e8CajXjm0drLdaleMwB5Kxd0Q4Y68vzJseS
         p22QUiwN1Thiyhb8tzAHj0h+B+MAdPTeiwxA7FtRb0W0k4wnemNxE7GxFrjZpBccbc/a
         GnrnMLHSX1n0Sdy0cBrSiYhiscRVovsjRanM4lXkkA/94xId03dAyVR1NOc3klj0/e1Z
         z8dxMhbpMWml0sdBWKLMwXeb6Y8CfCibwzyAvoO0nb57zV2/CRgiO9Gka/OiFrk7ly1P
         KXwMNF8dAK5dfuAyU97TygxClBErF+xaqQGX5Z1WTUtBZ6nhLAorkAYZHQD82OZm/Fqq
         +KBw==
X-Gm-Message-State: AOJu0YwHFv8Sc93rulByL0dDd/0hBVqsvtM0kmwC2Aag7NaKlE/7EwVh
	BfhXIMlHRBr4RRMkRBiDCWNPiZzy10mvvg1WUF4Oxe+4LkCIaIgeclw9GPsWCqB6hMREfnfroQO
	q1wDsqWGg4mT30PUDWamd3VtkfHUpL49hmT+J/KLGSwEjpALJVQ4grullwxVf4XkOZA==
X-Gm-Gg: ASbGncvA24EWD9VpRcotk3I7+l+XNurgV4GlAWhlmnuCZIpNAQjyxto27urjZqGvybf
	x5+ReimYD0aI4dY59AyZnu1bdGvgccy6mFY6zeDMzp2cNgkdv5ABc+YVzlYr7ujjzVY1ryilFoh
	8Q2eVYDhnIkFAFx/7E/98q3p4IC7lNjoj3Oe2q9MY4MgWYzyu//dlsR52IzZzBDdF1jV8vaRzFD
	oHEJ7pp7uSY90BgHkZR9WeAbGbsAvXqxr23ibU+3YtQmdCTeuM9YKzt5OH/U9jLZTLPQOvNi23C
	zT75Kv2TTUazY3dYKwKgtu1gISCNSoI92/uRq852IA0Kb4JaX09p6WQUKNBSBAZFK8Yq
X-Received: by 2002:a05:6214:4905:b0:6fd:377a:a77f with SMTP id 6a1803df08f44-70494fe0ea2mr13999476d6.20.1752085148099;
        Wed, 09 Jul 2025 11:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKrdppJoSUzCaDBDIMgrcluVjFCflnGH5fCcZp/OiXQ84I6FQx6b9/VI6v78hBTohfWKrRKg==
X-Received: by 2002:a05:6214:4905:b0:6fd:377a:a77f with SMTP id 6a1803df08f44-70494fe0ea2mr13999066d6.20.1752085147564;
        Wed, 09 Jul 2025 11:19:07 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4cccdb4sm95352126d6.46.2025.07.09.11.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 11:19:07 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4fcb119f-9a5d-417b-aeaa-977a3a794b4c@redhat.com>
Date: Wed, 9 Jul 2025 14:19:06 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/mutex: Disable preemption in
 __mutex_unlock_slowpath()
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>
References: <20250709180550.147205-1-longman@redhat.com>
Content-Language: en-US
In-Reply-To: <20250709180550.147205-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/25 2:05 PM, Waiman Long wrote:
> Jann reported a possible UAF scenario where a task in the mutex_unlock()
> path had released the mutex and was about to acquire the wait_lock
> to check out the waiters. In the interim, another task could come in,
> acquire and release the mutex and then free the memory object holding
> the mutex after that.
>
> Thread A                      Thread B
> ========                      ========
>                                eventpoll_release_file
>                                  mutex_lock
>                                    [success on trylock fastpath]
>                                  __ep_remove
>                                    ep_refcount_dec_and_test
>                                      [drop refcount from 2 to 1]
>
> ep_eventpoll_release
>    ep_clear_and_put
>      mutex_lock
>        __mutex_lock_slowpath
>          __mutex_lock
>            __mutex_lock_common
>              __mutex_add_waiter
>                [enqueue waiter]
>                [set MUTEX_FLAG_WAITERS]
>
>                                  mutex_unlock
>                                    __mutex_unlock_slowpath
>                                      atomic_long_try_cmpxchg_release
>                                        [reads MUTEX_FLAG_WAITERS]
>                                        [drops lock ownership]
>
>              __mutex_trylock
>                [success]
>              __mutex_remove_waiter
>      ep_refcount_dec_and_test
>        [drop refcount from 1 to 0]
>      mutex_unlock
>      ep_free
>        kfree(ep)
>
>                                      raw_spin_lock_irqsave(&lock->wait_lock)
>                                        *** UAF WRITE ***
>
> This race condition is possible especially if a preemption happens right
> after releasing the lock but before acquiring the wait_lock. Rwsem's
> __up_write() and __up_read() helpers have already disabled
> preemption to minimize this vulnernable time period, do the same for
> __mutex_unlock_slowpath() to minimize the chance of this race condition.
>
> Also add a note in Documentation/locking/mutex-design.rst to suggest
> that callers can use rcu_free() to delay the actual memory free to
> eliminate this UAF scenario.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   Documentation/locking/mutex-design.rst | 6 ++++--
>   kernel/locking/mutex.c                 | 6 ++++++
>   2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/locking/mutex-design.rst b/Documentation/locking/mutex-design.rst
> index 7c30b4aa5e28..51a3a28ca830 100644
> --- a/Documentation/locking/mutex-design.rst
> +++ b/Documentation/locking/mutex-design.rst
> @@ -117,8 +117,10 @@ the structure anymore.
>   
>   The mutex user must ensure that the mutex is not destroyed while a
>   release operation is still in progress - in other words, callers of
> -mutex_unlock() must ensure that the mutex stays alive until mutex_unlock()
> -has returned.
> +mutex_unlock() must ensure that the mutex stays alive until
> +mutex_unlock() has returned. One possible way to do that is to use
> +kfree_rcu() or its variants to delay the actual freeing the memory
> +object containing the mutex.
>   
>   Interfaces
>   ----------
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index a39ecccbd106..d33f36d305fb 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -912,9 +912,15 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>   	 * Release the lock before (potentially) taking the spinlock such that
>   	 * other contenders can get on with things ASAP.
>   	 *
> +	 * Preemption is disabled to minimize the time gap between releasing
> +	 * the lock and acquiring the wait_lock. Callers may consider using
> +	 * kfree_rcu() if the memory holding the mutex may be freed after
> +	 * another mutex_unlock() call to ensure that UAF will not happen.
> +	 *
>   	 * Except when HANDOFF, in that case we must not clear the owner field,
>   	 * but instead set it to the top waiter.
>   	 */
> +	guard(preempt)();
>   	owner = atomic_long_read(&lock->owner);
>   	for (;;) {
>   		MUTEX_WARN_ON(__owner_task(owner) != current);

Note that Linus' patch should fix this particular eventpoll UAF race 
condition, but there may be other code paths where similar situations 
can happen.

Cheers,
Longman



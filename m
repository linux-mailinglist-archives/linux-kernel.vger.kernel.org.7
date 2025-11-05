Return-Path: <linux-kernel+bounces-886913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EBFC36B84
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7854685AA4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CDA314B74;
	Wed,  5 Nov 2025 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIRBKrb/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="re8sGyTY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923462153D4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359765; cv=none; b=rLRwop5CCPUuF0j2gtOT1G2g4l0qCWRBB/CqQqGyleB0zJXBao52vcfqHuqIcc3rqbfRfEedF4uqHl8IadkUQCIzzsuoskTAmIFHgWOCPhXonbo0D9KjxDCmX8+TczQPU+ZYogZtl40n0r4FPqDH56+QlZ8PHyMHGoE7C2aB1OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359765; c=relaxed/simple;
	bh=wRfgzHY3jKJhA9qDrJYSxArm7Xlq47gPmyucQKGAwrg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rGk/NKOzKI3KrWY/y/F4LmiJJyDzC83WW6GXLueoHWKljD2fdhPeh7vl7/FjcrWrwv1HSxLIORRgFcpLeNegKOYWHU2Tzm2o0pmqfQR8It9b+I1bms4WzJO7dnO4kSkWCF36MXHjXDu/jA8PIiGvZqTLor+dXprpMSbhHHMP0jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIRBKrb/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=re8sGyTY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762359762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQvE91Vr47H44c3xdHgvqme0h6bZhy7LNdfE0z3FGCo=;
	b=dIRBKrb/pIrxVbWTkU1WE6bcZaucg7Kjg/IGLHLxYw4UXgm2XPNb/R0kVj0XrTsPHshweq
	943xS2nOJ/KBAtOWrVy+bq+OyHmHbA+vARya+nEH2vKFl7MUdBQtVIFEbo+aZScetocujD
	jNMhH2n/7UXR1iBjy03AnY0UVngR7Ss=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-eXwq_ofyOLiW9xTi5er6vA-1; Wed, 05 Nov 2025 11:22:39 -0500
X-MC-Unique: eXwq_ofyOLiW9xTi5er6vA-1
X-Mimecast-MFC-AGG-ID: eXwq_ofyOLiW9xTi5er6vA_1762359759
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8804b991a54so1901196d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762359759; x=1762964559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eQvE91Vr47H44c3xdHgvqme0h6bZhy7LNdfE0z3FGCo=;
        b=re8sGyTYiTQPhMIqIUyFYxwj0lRK039+B3tMdOfmBdUVWBM/niLnHmk1EjcD3b5DU+
         PoX5yojcctpCj0r/YmqYmqjYqGJiFVKFR5a3kWLhlPxBrIxcF7lgyuNg2FXZzDjmsFAx
         +zFLkmMDsKq8DzrwZzDIrBlj2i60MmCKlCqnSY6TKSBcluDtiuXsD7nvf7orieL+1Kco
         ya53adVODhNRDWdLaIZ37HlQ+3kGe3DfSwcwbfkATU0m01qgpKpaEvVZ2iSpivk1J6F5
         5a5jA41g2h4TNXQGeJzp06YEKitpDetap036B6hgsbAF/fOGeC/aBVfrLgHLVxBk9soN
         zWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762359759; x=1762964559;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQvE91Vr47H44c3xdHgvqme0h6bZhy7LNdfE0z3FGCo=;
        b=KiJhE9l8oeoUyDz37HwtNLmdnh7OyA4Y/HiyEbjzQdcAKEvP4tXOWVq7WkgAfQnRWY
         WxXFDDCnjVDOV/k5RW+YpRJ4DOh6NFeErpdR2MaBOK5lMqLG0wUFtkRcP4QE6dKNBuoI
         6QGeojwTP6L1kYvM371Xg8dTN9Tqk5ocYJLsKIevyokCplTAlDdld8ES95QQakVAaS+8
         zwKgfmmm5NGzVWKvD6zgZrZQVwUfv3ps7EleCXbdOI67WU+ouwxBHkJMMIEwZ4wDuBdU
         5wz+m2N3ykH2vw6x0C4K/8MNB6F891XxouDnkLu008LojX7EVXmkrtKJT2BpIAkLtcrp
         TZUA==
X-Forwarded-Encrypted: i=1; AJvYcCUoKoq3Vie97OsvbCs9T4quEfNZs9LT9iWeqqDWqJVb8i9dNiPtMG8/QFTYohfwDhYmi+8HvkEX+KNaMmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVAi5Eg76vVabLKDrYmz6Owj3Y+2B4K8OcSzR+LxJiMhpzwdu4
	Z7NcOQ1H0WiDlmcI7la3cnJrxfHTur06ijl4YezrhnpLomlC2zWThfjZCwDkcapbtGLv2QIYTM2
	UlTzQKrKzjWPruETqN8/RNMN0qxoY871cO7xOcgabAsRm+Al1rQ1Nrw9YuiZpqsVvKw==
X-Gm-Gg: ASbGncsLhWLxzNavRPv5LVAMWasK6C0N4r1tZqijNaGf+0VZe+tPv5Q5pTVmnkNCbe1
	ryRH0zHVcSXeI9dznUZU4pYiVpVEaHOYC9i/47H3mV32ru2ArFDx5nnIz9SVJi8XKol6j497xaM
	Ef54eBUfmrMtqRmkDA8yBboGB6Pbl/JKURxay9NzJhJ+JPyKJQxJnNqgvjLZ8CYtynHoS031ltX
	khOsM4khvbxIVcSGY9IE2hzHcuTROTXz6IrCudn3Jqk0u89mP6Dy3jSaR0xJANHVqAIAP3YXIyX
	FLl5+AnExtPabGH43uHleTscT9ZO/Swo8RvZIHjqAhAQz/nJVqDan3HA9G49c9he8nrAU+GqYFu
	6hNCjaMk7Oh4eTWBkeVvNFcTEb88E6T25bKItmQJeEHxWAQ==
X-Received: by 2002:a05:6214:250a:b0:880:5025:98d7 with SMTP id 6a1803df08f44-8807115b974mr59009186d6.40.1762359759332;
        Wed, 05 Nov 2025 08:22:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOygilOJOaSC5ooO0TY1ZTpW85+cendQ4VMlJly9P1KQzUjmtEMWYotcBxc1mbwkDtkV/6fQ==
X-Received: by 2002:a05:6214:250a:b0:880:5025:98d7 with SMTP id 6a1803df08f44-8807115b974mr59008596d6.40.1762359758754;
        Wed, 05 Nov 2025 08:22:38 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8807a28000fsm10058636d6.47.2025.11.05.08.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:22:38 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8e56c3d7-28b7-4931-95d1-8e311a16544b@redhat.com>
Date: Wed, 5 Nov 2025 11:22:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] locking/mutex: Redo __mutex_init()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Waiman Long <llong@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Will Deacon <will@kernel.org>
References: <20251104140023.jV9j77ld@linutronix.de>
 <4207482b-fc63-4db7-ab98-36b31a600173@redhat.com>
 <20251105075729.SJ4cL1rz@linutronix.de>
 <10899bd0-09ca-4fcf-8142-3d5cd6e4fedf@redhat.com>
 <20251105142350.Tfeevs2N@linutronix.de>
Content-Language: en-US
In-Reply-To: <20251105142350.Tfeevs2N@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/5/25 9:23 AM, Sebastian Andrzej Siewior wrote:
> mutex_init() invokes __mutex_init() providing the name of the lock and
> a pointer to a the lock class. With LOCKDEP enabled this information is
> useful but without LOCKDEP it not used at all. Passing the pointer
> information of the lock class might be considered negligible but the
> name of the lock is passed as well and the string is stored. This
> information is wasting storage.
>
> Split __mutex_init() into a _genereic() variant doing the initialisation
> of the lock and a _lockdep() version which does _genereic() plus the
> lockdep bits. Restrict the lockdep version to lockdep enabled builds
> allowing the compiler to remove the unused parameter.
>
> This results in the following size reduction:
>
>        text     data       bss        dec  filename
> | 30237599  8161430   1176624   39575653  vmlinux.defconfig
> | 30233269  8149142   1176560   39558971  vmlinux.defconfig.patched
>     -4.2KiB   -12KiB
>
> | 32455099  8471098  12934684   53860881  vmlinux.defconfig.lockdep
> | 32455100  8471098  12934684   53860882  vmlinux.defconfig.patched.lockdep
>
> | 27152407  7191822   2068040   36412269  vmlinux.defconfig.preempt_rt
> | 27145937  7183630   2067976   36397543  vmlinux.defconfig.patched.preempt_rt
>     -6.3KiB    -8KiB
>
> | 29382020  7505742  13784608   50672370  vmlinux.defconfig.preempt_rt.lockdep
> | 29376229  7505742  13784544   50666515  vmlinux.defconfig.patched.preempt_rt.lockdep
>     -5.6KiB
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1…v2:
>    - s/_init_ld/_init_lockep/
>    - s/_init_plain/_init_generic/
>
>   include/linux/mutex.h        | 45 ++++++++++++++++++++++++++++--------
>   kernel/locking/mutex.c       | 22 +++++++++++++-----
>   kernel/locking/rtmutex_api.c | 19 +++++++++++----
>   3 files changed, 66 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index 847b81ca64368..bf535f0118bb8 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -86,8 +86,23 @@ do {									\
>   #define DEFINE_MUTEX(mutexname) \
>   	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
>   
> -extern void __mutex_init(struct mutex *lock, const char *name,
> -			 struct lock_class_key *key);
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +void mutex_init_lockep(struct mutex *lock, const char *name, struct lock_class_key *key);
> +
> +static inline void __mutex_init(struct mutex *lock, const char *name,
> +				struct lock_class_key *key)
> +{
> +	mutex_init_lockep(lock, name, key);
> +}
> +#else
> +extern void mutex_init_generic(struct mutex *lock);
> +
> +static inline void __mutex_init(struct mutex *lock, const char *name,
> +				struct lock_class_key *key)
> +{
> +	mutex_init_generic(lock);
> +}
> +#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
>   
>   /**
>    * mutex_is_locked - is the mutex locked
> @@ -111,17 +126,27 @@ extern bool mutex_is_locked(struct mutex *lock);
>   #define DEFINE_MUTEX(mutexname)						\
>   	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
>   
> -extern void __mutex_rt_init(struct mutex *lock, const char *name,
> -			    struct lock_class_key *key);
> -
>   #define mutex_is_locked(l)	rt_mutex_base_is_locked(&(l)->rtmutex)
>   
> -#define __mutex_init(mutex, name, key)			\
> -do {							\
> -	rt_mutex_base_init(&(mutex)->rtmutex);		\
> -	__mutex_rt_init((mutex), name, key);		\
> -} while (0)
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +extern void mutex_rt_init_lockdep(struct mutex *mutex, const char *name,
> +			     struct lock_class_key *key);
>   
> +static inline void __mutex_init(struct mutex *lock, const char *name,
> +				struct lock_class_key *key)
> +{
> +	mutex_rt_init_lockdep(lock, name, key);
> +}
> +
> +#else
> +extern void mutex_rt_init_generic(struct mutex *mutex);
> +
> +static inline void __mutex_init(struct mutex *lock, const char *name,
> +				struct lock_class_key *key)
> +{
> +	mutex_rt_init_generic(lock);
> +}
> +#endif /* !CONFIG_LOCKDEP */
>   #endif /* CONFIG_PREEMPT_RT */
>   
>   #ifdef CONFIG_DEBUG_MUTEXES
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index de7d6702cd96c..f3bb352a368d9 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -43,8 +43,7 @@
>   # define MUTEX_WARN_ON(cond)
>   #endif
>   
> -void
> -__mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
> +static void __mutex_init_generic(struct mutex *lock)
>   {
>   	atomic_long_set(&lock->owner, 0);
>   	raw_spin_lock_init(&lock->wait_lock);
> @@ -52,10 +51,7 @@ __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
>   #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
>   	osq_lock_init(&lock->osq);
>   #endif
> -
> -	debug_mutex_init(lock, name, key);
>   }
> -EXPORT_SYMBOL(__mutex_init);
>   
>   static inline struct task_struct *__owner_task(unsigned long owner)
>   {
> @@ -142,6 +138,11 @@ static inline bool __mutex_trylock(struct mutex *lock)
>    * There is nothing that would stop spreading the lockdep annotations outwards
>    * except more code.
>    */
> +void mutex_init_generic(struct mutex *lock)
> +{
> +	__mutex_init_generic(lock);
> +}
> +EXPORT_SYMBOL(mutex_init_generic);
>   
>   /*
>    * Optimistic trylock that only works in the uncontended case. Make sure to
> @@ -166,7 +167,16 @@ static __always_inline bool __mutex_unlock_fast(struct mutex *lock)
>   
>   	return atomic_long_try_cmpxchg_release(&lock->owner, &curr, 0UL);
>   }
> -#endif
> +
> +#else /* !CONFIG_DEBUG_LOCK_ALLOC */
> +
> +void mutex_init_lockep(struct mutex *lock, const char *name, struct lock_class_key *key)
> +{
> +	__mutex_init_generic(lock);
> +	debug_mutex_init(lock, name, key);
> +}
> +EXPORT_SYMBOL(mutex_init_lockep);
> +#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
>   
>   static inline void __mutex_set_flag(struct mutex *lock, unsigned long flag)
>   {
> diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
> index bafd5af98eaec..59dbd29cb219b 100644
> --- a/kernel/locking/rtmutex_api.c
> +++ b/kernel/locking/rtmutex_api.c
> @@ -515,13 +515,11 @@ void rt_mutex_debug_task_free(struct task_struct *task)
>   
>   #ifdef CONFIG_PREEMPT_RT
>   /* Mutexes */
> -void __mutex_rt_init(struct mutex *mutex, const char *name,
> -		     struct lock_class_key *key)
> +static void __mutex_rt_init_generic(struct mutex *mutex)
>   {
> +	rt_mutex_base_init(&mutex->rtmutex);
>   	debug_check_no_locks_freed((void *)mutex, sizeof(*mutex));
> -	lockdep_init_map_wait(&mutex->dep_map, name, key, 0, LD_WAIT_SLEEP);
>   }
> -EXPORT_SYMBOL(__mutex_rt_init);
>   
>   static __always_inline int __mutex_lock_common(struct mutex *lock,
>   					       unsigned int state,
> @@ -542,6 +540,13 @@ static __always_inline int __mutex_lock_common(struct mutex *lock,
>   }
>   
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
> +void mutex_rt_init_lockdep(struct mutex *mutex, const char *name, struct lock_class_key *key)
> +{
> +	__mutex_rt_init_generic(mutex);
> +	lockdep_init_map_wait(&mutex->dep_map, name, key, 0, LD_WAIT_SLEEP);
> +}
> +EXPORT_SYMBOL(mutex_rt_init_lockdep);
> +
>   void __sched mutex_lock_nested(struct mutex *lock, unsigned int subclass)
>   {
>   	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, subclass, NULL, _RET_IP_);
> @@ -598,6 +603,12 @@ int __sched _mutex_trylock_nest_lock(struct mutex *lock,
>   EXPORT_SYMBOL_GPL(_mutex_trylock_nest_lock);
>   #else /* CONFIG_DEBUG_LOCK_ALLOC */
>   
> +void mutex_rt_init_generic(struct mutex *mutex)
> +{
> +	__mutex_rt_init_generic(mutex);
> +}
> +EXPORT_SYMBOL(mutex_rt_init_generic);
> +
>   void __sched mutex_lock(struct mutex *lock)
>   {
>   	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0, NULL, _RET_IP_);
Reviewed-by: Waiman Long <longman@redhat.com>



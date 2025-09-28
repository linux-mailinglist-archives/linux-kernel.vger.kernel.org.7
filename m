Return-Path: <linux-kernel+bounces-835483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 132ADBA7443
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 17:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C4A1897938
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11C621FF26;
	Sun, 28 Sep 2025 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MB1g0xo5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3C33EC
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759073640; cv=none; b=cD3lFxH+D0wa3wC0rHdUn0j+UrH1HLakmPBT8O/yyI2Qm+V+3UxVQzEUqEG0Nu4jegw4cnZct2RkPW82zgDUE2gi1ffbArYPWg0ueTGqxxRun5imySa0QWslMqTqPnfz82q7CYs1yf3xD7yqAgEDtyL72uBaP/dGWYvgcKyUUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759073640; c=relaxed/simple;
	bh=6fsQx/x0ozZNvP+Zulqe3d25aQBr0JRGoixqG4wXT8Y=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=Vdmlt8z82Uq2tDMHpNzDaCtphEdqR9t9+B697XSu3fbX0FClhe9k+ADthiC/GC1Vd37qTNBadkQdtydnfksRogy6k5aIReh4J1cBd6+oC8uc01FdUbrFGep6tpJ0C8/UgvnYWsJaJaTqOtwkimxh3x88nKU7nQRQ3bv5uqhTC1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MB1g0xo5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759073637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tL/Fk3H8V/wS97MtjVuXU3QD/wzzV6jASraULhcGUhg=;
	b=MB1g0xo5EOU+8MbwgZ01su7RR4SlHkOOlcDpCcVi7zjzU+N7QOkte7HFXy6Xq3uyagqqgl
	KP7F71np+xoXGC9csgoXxO89s8Ykhseg50AwXEOiooCgrsRAUaCNMaljaFLYx15oLQRAhC
	2OXO7tdvsq1M4DbR43i3smmXexLW15U=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-SLT5v1ZJPO6t6DrIRqcqoA-1; Sun, 28 Sep 2025 11:33:55 -0400
X-MC-Unique: SLT5v1ZJPO6t6DrIRqcqoA-1
X-Mimecast-MFC-AGG-ID: SLT5v1ZJPO6t6DrIRqcqoA_1759073635
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8589058c6d1so450576385a.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759073635; x=1759678435;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tL/Fk3H8V/wS97MtjVuXU3QD/wzzV6jASraULhcGUhg=;
        b=AC+qNpwxiU63C/o9SkJisz/mV9qV9pSMaPAkuHCh2idpdzP2KogziGQsDhFk5urxgZ
         wCeSIwuf3NvALzwub4KAuJSK9Kb56dCwZc6xajT+8sDnIS/sYwFp7Bdjap6uXFEV5ZRx
         KICSU4GJCK6puPjPzm1umG7bnKNrvXT406geFkbmUovSLJjHFWXZOQ5pnU8oZOZAmsxj
         9NAvlfpqpM/u2HpM8MeNc2PpL+Tgr7/gcJBx0HhJuETQwKq79hSlngbX+qCkJ/7Sg8NF
         IyNBd9i1tOR7GjZPrKnausZwwaZ9SpmHYnUZjkv0hG+ET/w0S/brHS/b1gYDpH60xarc
         Z72g==
X-Forwarded-Encrypted: i=1; AJvYcCX3uzYmM0M2mchOEyWe14drd9B1PRWGG5H+IOc/mP9YrtrMS5EkSYd8CS3qdpJrxAra69PDuZsCl6YEMak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9WRJfYl7XluzdIFEtcMlUr0rZ4Q6kXdfV1IDx197gvGWDS1YJ
	f+COSTR+c5ipE6NQv8IGXZoNSGDJlBklGgdtTNwYHP8RUhzjM2gZX5P52QcW1rkSimshC20mRpu
	hsFChN/MrUTil203QxQAGorFcXBjgxIjONs4UDl5fnec+rJxcvGmWZ95Hgg6ORL987g==
X-Gm-Gg: ASbGncutq+2PXi64rbJpuJsjDYzPZZyFrqZecZ8AGRfDnWEiz8rVmhC7wXNs1v+VKw4
	nU6HqahGeb6e6j6Os/FPnheiJ8cUDRI2f5pDiZz4zEtg5OJ/BlN4z1AahajNUSZ42jIr+OEs7cm
	SNBsUDx0pIKaE7GHiO0sGkbRrSGJ3rkoOEKvob4CYPj/ZlMhh1Y9QV4oOj282w6ETbAuLSgqVQ4
	5fbUEAYdn/cIe3SJHfBXGdUbaowZ86HjpM1pLSq5D4mNhQkKnueqorptZiwrYk+eL+MKqOTkSY7
	f7aPBOfqANeGgoZGNrHtLOKBkqsbeRULcXiwNPS+T+SXsBh30B4SNjhv21GcJ3iVacvxMLQGHWa
	+9+wrZxQzHvo=
X-Received: by 2002:a05:620a:29cf:b0:83b:9629:8c69 with SMTP id af79cd13be357-85ae7cd5eedmr1524458985a.62.1759073634665;
        Sun, 28 Sep 2025 08:33:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBtJMNErbB7Wf5hHbUDmzd2D2wPHtM/gYMs++QhstQoo680VGxFh5aU9Zd4EV26qg33fljRQ==
X-Received: by 2002:a05:620a:29cf:b0:83b:9629:8c69 with SMTP id af79cd13be357-85ae7cd5eedmr1524453885a.62.1759073633872;
        Sun, 28 Sep 2025 08:33:53 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db119f05a0sm57427281cf.43.2025.09.28.08.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 08:33:53 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <efd4d562-c89d-4344-b36b-d542a7862515@redhat.com>
Date: Sun, 28 Sep 2025 11:33:52 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] locking/rwsem: add DEBUG_RWSEMS_WARN_ON to warn
 invalid rwsem
To: buckzhang1212@yeah.net, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20250927064756.13544-1-buckzhang1212@yeah.net>
Content-Language: en-US
In-Reply-To: <20250927064756.13544-1-buckzhang1212@yeah.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/27/25 2:47 AM, buckzhang1212@yeah.net wrote:
> From: "buck.zhang" <buckzhang1212@yeah.net>
>
> Here is a kernel exception about rwsem and I can recreate it stably.
> First We define a struct contains a rwsem.
> Then allocate this struct by kmalloc without calling init_rwsem.
> Finally when multiple tasks call use rwsem together,kernel will panic.
> This lock is used normally when only one task is using  at a time.
> the exception reason is that sem->wait_list is an invalid kernel list.
> I want to add more warnings when enable CONFIG_DEBUG_RWSEMS
> kernel crash log:
> Unable to handle kernel NULL pointer dereference at virtual address 0000000
> pc: rwsem_down_write_slowpath+0x428/0xccc
> lr: rwsem_down_write_slowpath+0x844/0xccc
> sp: ffffffc0870abb00
> x29: ffffffc0870abb60 x28: 0000000000000000 x27: ffffffffffffff05
> ........
> x2: ffffff809d57d830 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
> rwsem_down_write_slowpath+0x428/0xccc
> down_write+0xa8/0x108
> Test case:
> struct chip_rwsema {
> 	struct rwsema sem;
> };
> static void work_handler1(struct chip_rwsema *csem)
> {
> 	down_write(&(csem->sem));
> }
> static void work_handler2(struct chip_rwsema *csem)
> {
> 	down_write(&(csem->sem));
> }
> static void chip_tsem(void)
> {
> 	struct chip_rwsema *csem;
> 	csem = kzalloc(sizeof(struct chip_rwsema),GFP_KERNEL);
> 	work_handler1(csem);
> 	......
> 	work_handler2(csem);
> }
>
> Signed-off-by: buck.zhang <buckzhang1212@yeah.net>
> ---
>   kernel/locking/rwsem.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 24df4d98f..bfc038573 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -75,7 +75,17 @@
>   		list_empty(&(sem)->wait_list) ? "" : "not "))	\
>   			debug_locks_off();			\
>   	} while (0)
> +
> +/*
> + * list_invalid - check whether sem->waitlist is invalid
> + * @head: the list to test.
> + */
> +static inline int rwsem_waitlist_invalid(const struct list_head *head)
> +{
> +	return (unsigned long) READ_ONCE(head->next) < PAGE_OFFSET;
> +}
>   #else
> +# define rwsem_waitlist_invalid(sem)
>   # define DEBUG_RWSEMS_WARN_ON(c, sem)
>   #endif
>   
> @@ -1034,6 +1044,9 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>   	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
>   	waiter.handoff_set = false;
>   
> +	/* In case the rwsem is uninitiated, add more warning */
> +	DEBUG_RWSEMS_WARN_ON(rwsem_waitlist_invalid(&sem->wait_list), sem);
> +
>   	raw_spin_lock_irq(&sem->wait_lock);
>   	if (list_empty(&sem->wait_list)) {
>   		/*
> @@ -1128,6 +1141,9 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>   	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
>   	waiter.handoff_set = false;
>   
> +	/* In case the rwsem is uninitiated, add more warning */
> +	DEBUG_RWSEMS_WARN_ON(rwsem_waitlist_invalid(&sem->wait_list), sem);
> +
>   	raw_spin_lock_irq(&sem->wait_lock);
>   	rwsem_add_waiter(sem, &waiter);
>   

I suppose you are trying to detect call to down_read()/down_write() 
before the rwsem has been properly initialized. The current way to 
detect that is to check for sem->magic. Unfortunately, this check may 
not be run for down_read()/down_write() depending on the whether 
CONFIG_LOCK_STAT is set or not. Does the below patch work for you for 
your test case?

Cheers,
Longman

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 24df4d98f7d2..7e06a6bbdd53 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1256,6 +1256,7 @@ static __always_inline int 
__down_read_common(struct rw_semaphore *sem, int stat
         int ret = 0;
         long count;

+       DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
         preempt_disable();
         if (!rwsem_read_trylock(sem, &count)) {
                 if (IS_ERR(rwsem_down_read_slowpath(sem, count, state))) {
@@ -1312,6 +1313,7 @@ static __always_inline int 
__down_write_common(struct rw_semaphore *sem, int sta
  {
         int ret = 0;

+       DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
         preempt_disable();
         if (unlikely(!rwsem_write_trylock(sem))) {
                 if (IS_ERR(rwsem_down_write_slowpath(sem, state)))




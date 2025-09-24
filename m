Return-Path: <linux-kernel+bounces-829878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04127B981B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99BA62A0667
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7117E221577;
	Wed, 24 Sep 2025 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1MU0p6H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD67DB665
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758683431; cv=none; b=E8ZisYTtuhlXiwOhahDWouvJsIoOnplASaawdnuXkRgdW0ySy06W6UMcoMga8aZpKrRN1m6vGPs5RpC7hc/OvdIQmDJb5CVYKtd5NZa9cDNcjXNcN9YDAPcuzN6NeSDxiVjocJiDHptZ2GYuzkJHSM7Mt56jUeMJ3L8wj8NIlmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758683431; c=relaxed/simple;
	bh=p+hAlfWLOo8lrVCig+GYlsVpauV6dDxSNvfvnIzo890=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=dVkgC1euJ/Ox/WaxK6qucpo04aO4teNrNkCkCgV9qJLBFswGHrI/WILxKMw3YZ1ziv6pgwz6kpG9+EKMj/f+CBYuypNuKCforbxygMXYXTz1csFQv7HllI135BVtV+7mM7Wq+jlT/qFAZ03mQoa5QZl2yE4ryGTYtOoSzkz8wt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B1MU0p6H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758683428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkvMMMNr8whS9KWGb21eo2kTG2AVjzPyop3Rbc2zRug=;
	b=B1MU0p6HtMydS7Goj6Y3rMJY6sDnOup9Zt1JRzNu8cFCdwRnZ7ZORhrInz0GLctcc9V3kV
	+Dm5u2d35I4pH90u1OzvsH401PW7lSZaZ+W0Q5IzD/gmQm4vJwZu5em3yqfU16oNXnctUX
	5NMbMV8VD2Q1QmFBv/XFjfSDDp623Ho=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-NRxoTIvMNz6VxfmQ9tPgNw-1; Tue, 23 Sep 2025 23:10:27 -0400
X-MC-Unique: NRxoTIvMNz6VxfmQ9tPgNw-1
X-Mimecast-MFC-AGG-ID: NRxoTIvMNz6VxfmQ9tPgNw_1758683427
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-79e48b76f68so115831316d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758683424; x=1759288224;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkvMMMNr8whS9KWGb21eo2kTG2AVjzPyop3Rbc2zRug=;
        b=qe23wNp08XsJNO7p/AfMqkMsHLtpt+2FbxqrN1yfqTAe1YJB5LHtixoryC6Y9sU/Vp
         uYn7+2OqfohOPcNZyk/ji8F84BjUM4jlBTAwP5VohVTJwBEyOa+hq9y8qBHenZfS94bJ
         MT1xfK5ym7jbJBfKn0xw2qPF6wecDHABwbxEAUKgq/WYzK6Yuai3PE1MarhVSoHHFj/N
         FoE+ZN7tPt6FRxQ/KlPB6brbD+yzR2nBiCa8Bl7eGUBJkdzhRuM7ciXA07pV72ggGHec
         jkrYcrv/CcLvHdrSRFfdw42MGDcEB7H+ES8hbObYWcBxi6S8xX4WJuJKTumeq8Fsqyi4
         FSbA==
X-Forwarded-Encrypted: i=1; AJvYcCXC2kDetgaNOAvrAKMloNOqmgM7FEoAxZcKCr+cLVAXZUHC1JPak7oPJhR9eGI19aw1HQKCDhV5iIdDRJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUgnzFnBMx1/sEzeQukrpjTI3ul+BLxIBb0iJIZPTNLrJgul4A
	NbX3hSTYfDLBTUlYUPEoEPzWFoWHbGpqS+U3fvBxr4xHvWcDq1HnOWyALOl/Q2vn9kVcXY3A12i
	AdRp+FphMLJnC0pgiqAt+bkA2uT3NidZxxMX25nJcLqLYeG4MYkrd8cwS/AkUAxPG6w==
X-Gm-Gg: ASbGncudGMZZkhAroGXKs0wHlpro0ByUqVA21uLDQPQ2rTWLHPAyDaqRq4/sAYLcHbs
	MWybDrf2kZFLBtEiytg4SJh3ZSXFCU1Msq24SMD+ib7nOxmMnG3DhJ6Dz+ZqX0sfmMDw6YTuCo1
	z9PBfYpygIZqeg8LAJRd9Avm0AX/QuYSg7rpH7JAuoVS/KsQ7tmCFFJnPjZslPiU2SVQ2ypo/ni
	362NN8GPLd4gtK3di8MD9qGdUmU7nKLSZjHnDEDNTgM04ppSwlkaoatPFjQo1qv1MWRHTU3ealg
	eiOzWaAEYaGmN7eKvSsatYycl816r0pabJ8KsSvCBjuHL4h5fTjBglHBEq7rueQY9T5p6Sbz/fM
	E5d7cSh/w6yw=
X-Received: by 2002:a05:6214:20c1:b0:70d:fa79:baf0 with SMTP id 6a1803df08f44-7e7131d7020mr59697146d6.38.1758683424384;
        Tue, 23 Sep 2025 20:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLx9MwpCuNHuqA9U34H+EA7/n5lCOMihDnRBo1m3E6DXMRuUMWw3nLKQP4DFoBN1zvCBLgdw==
X-Received: by 2002:a05:6214:20c1:b0:70d:fa79:baf0 with SMTP id 6a1803df08f44-7e7131d7020mr59696966d6.38.1758683423944;
        Tue, 23 Sep 2025 20:10:23 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793472c3946sm100462706d6.28.2025.09.23.20.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 20:10:23 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <dbba6b72-d270-4b7e-bb21-39ac8a46864a@redhat.com>
Date: Tue, 23 Sep 2025 23:10:22 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/mutex:add MUTEX_CHCEK_INIT to detect
 uninitialized mutex lock
To: buckzhang1212@yeah.net, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20250924022500.2577-1-buckzhang1212@yeah.net>
Content-Language: en-US
In-Reply-To: <20250924022500.2577-1-buckzhang1212@yeah.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/25 10:25 PM, buckzhang1212@yeah.net wrote:
> From: "buck.zhang" <buckzhang1212@yeah.net>
>
> Here is a kernel exception about mutex and I can recreate it stably.
> First we define a custome struct that includes a mutex lock.
> Then allocate this struct by kmalloc without calling mutex_init.
> Finally when multiple tasks call mutex_lock together,kernel will panic.
> But Kernel is good  if only one task call this mutex at the same time.
> the exception reason is that lock->wait_list is an invalid kernel list.
> kernel crash log:
> Unable to handle kernel NULL pointer dereference at virtual address 0000000
> pc: __mutex_add_waiter+0x68/0x160
> lr: __mutex_add_waiter+0x128/0x160
> sp: ffffffc0866f3ac0
> x29: ffffffc0866f3ad0 x28: ffffff8095148000 x27: 0000000000000000
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
A mutex must be properly initialized before it can be used. The kernel 
panic you listed above is expected and the panic itself indicates that 
the code is wrong.
> ---
>   kernel/locking/mutex.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index de7d6702c..8fbe858c8 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -42,6 +42,16 @@
>   #else
>   # define MUTEX_WARN_ON(cond)
>   #endif
> +#define MUTEX_CHCEK_INIT(lock)  mutex_check_waitlist(lock)
> +static void mutex_check_waitlist(struct mutex *lock)
> +{
> +	struct list_head *list = &lock->wait_list;
> +
> +	if ((unsigned long)list->next < PAGE_OFFSET) {
> +		pr_err("BUG: mutex lock is uninitialized，wait_list is Error\n");
> +		MUTEX_WARN_ON("mutex lock is uninitialized");
> +	}
> +}
>   
>   void
>   __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
> @@ -269,6 +279,7 @@ static void __sched __mutex_lock_slowpath(struct mutex *lock);
>   void __sched mutex_lock(struct mutex *lock)
>   {
>   	might_sleep();
> +	MUTEX_CHCEK_INIT(lock);
>   
>   	if (!__mutex_trylock_fast(lock))
>   		__mutex_lock_slowpath(lock);

This check has provided no additional value and it slows down the 
locking fast path.

NACK

> @@ -991,6 +1002,7 @@ __mutex_lock_interruptible_slowpath(struct mutex *lock);
>   int __sched mutex_lock_interruptible(struct mutex *lock)
>   {
>   	might_sleep();
> +	MUTEX_CHCEK_INIT(lock);
>   
>   	if (__mutex_trylock_fast(lock))
>   		return 0;
> @@ -1015,6 +1027,7 @@ EXPORT_SYMBOL(mutex_lock_interruptible);
>   int __sched mutex_lock_killable(struct mutex *lock)
>   {
>   	might_sleep();
> +	MUTEX_CHCEK_INIT(lock);
>   
>   	if (__mutex_trylock_fast(lock))
>   		return 0;



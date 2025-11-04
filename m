Return-Path: <linux-kernel+bounces-885112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E038C32047
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E8C3A9BA8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C521E330B2E;
	Tue,  4 Nov 2025 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLQv0YVE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r16FTvdk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1230F32AADA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273294; cv=none; b=fQnvYoubaa1VQdUrv+UkTS/mDU/T2ZFEFuAQRPigpmyz6E+GV4xKhmK/0fSkC4Q/LeYCCjDLfpzrXzMRvoimfViHymSjXUFzNwr8kTR6syebByI4vOO6cepmhGPEq6CmcCJtV/5dOXtOemCkgYyfAMLfPNY6y8EszFrrc6r7qOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273294; c=relaxed/simple;
	bh=KbDdLDw3QZNT3IrGzeRanwlv/OMae93AAQBEC+oWQy0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ebffHAlTcs3pD+g2UZmhzyE2W5ZoUNlgRjOlVLnv2m/5I/bqa9z9CdTNwRuycFozd9HS/TiUDgUU9uDyciHeTWbLp2sJFwFAq3/RV0Txuev+3EY+d1sRzqeXmVO3Qxg6bxvSZIAAqRJPqMH63/UuAqlLElsyw0XqlkkuPlY478o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OLQv0YVE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r16FTvdk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762273292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvvV5goeLc5t0aUc+7Ljeq+fzuyKYoZJOV9qCoFzm1Y=;
	b=OLQv0YVERcw2+mh49XDxke+31Qfa5fiSvt7z5sGhIs61+qz88KK06QX+IQeyfL6TMEA5QQ
	ilpA0zNxQwbXqSOx44vAlHbk1RDSzL0Tu3S4h/P6ZQQ5mz8E+7k/EGKqi0Seq5Cr6BPblf
	JeKkq9bgrVS1dRLiCebqxyfBbClAZJ8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-yHg7PRoAPY6wQQ0L53gLlQ-1; Tue, 04 Nov 2025 11:21:29 -0500
X-MC-Unique: yHg7PRoAPY6wQQ0L53gLlQ-1
X-Mimecast-MFC-AGG-ID: yHg7PRoAPY6wQQ0L53gLlQ_1762273289
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8803b5dc9b8so176102846d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762273289; x=1762878089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IvvV5goeLc5t0aUc+7Ljeq+fzuyKYoZJOV9qCoFzm1Y=;
        b=r16FTvdkcZcL68P9j234AUXVw3rbTcokRrnj3M2K/t8/rMOLaYpQewjRFjornkFAMs
         R08fZ4SHDyedl1312qY5eUIIfriaYDeF+zS255Q2tEMjqfAfKTQcv3LkSYswxcbe8jdT
         yc/Wsrl+xN6ssOpzXAP+R8C8g9TimGDHUgMJuJyj9Lw9kGolQM3DeeZcRfV6Y2yE9mlr
         X1ytzPUzWoDDvawycivNWWntZNXzsrYr/0VMUuj+VnqmgyXl8iS2PXs4Qpa2eewGCLFI
         bstlzkZlhf+pQx4oct9ji6z5BauFf1WbWgyMRrMXm64QRj7SZ/XbAiUPszLwuacg43K+
         F06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762273289; x=1762878089;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvvV5goeLc5t0aUc+7Ljeq+fzuyKYoZJOV9qCoFzm1Y=;
        b=tsBWzT2GUhfaUkwDJa4jASon6pq9At6EadXs8HdqrMKq8slhcpST2s12c1JGxMDeE/
         3gl1PC17hfemL9VdB3SFbrn8/htqgoqYtR5JJIvRhzCZfpAJ5bGtLBcr8LwWuEPWoMxr
         ITPJrZ6AVDQKuIFZR91Gb4Dx2N1F661ePY1Zu/HhHJ+ASmBe7FY4UZLzQDplj7hyi1XH
         feJblNjECrTza/OQsN3S1uuWfPH9eA//m4CxuYtgqGQ7kLA05AjJB0r8H5WxVJQ+HLJ7
         izMUDJZScDjl3tdIrJ28BaQBcQkRerb+Ye5awDaQtWgUsNYDTEa4nAm5vS8XubepIYv0
         esJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWamnIrE15rDfkQ8N5CRewnUwKyRidxYWbz+tcDnphUaetXkYZMFy/UAqDMG5pEZfM+VV3VOizEZgmQugs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi654Dlu1T70+2THuPFfsWXHcFg9DXCc7pHg4g7ltBqg7hwqx2
	br1jWRc/8q+Vq8v+Ij+Lh/SlON+r4a89/TOgi+lL/iHv2cGSllhxH4Gq/yD4YmaFpR7FRntnKcg
	lw/zmqIdPJEnFd94TBumeV6np6KZsOl2BFvmTpzDlazcfcB8xbAT1M9FoBKUPzy758Q==
X-Gm-Gg: ASbGncud1/+Uv5LVGjDSVy+SetDtLCsWErDxK5g4Noyqn/0eL/LMKwn7CXyNqTSLtn6
	V8ofD167hkDvkZ1HjCoPY2t65P0GjPD2soABLxT0GqrnYc/7VfHWSRO4m0ymVna+yWyXCKHRglz
	OqC+dMkVomUeoMkGYi4g0V7/jtOash2U/GgMSI+fUca14DI1qb/huDAI8SHiA2MHVPd43IRdgBw
	t318dVLjqnY+lZ0wk+4Oo7dDX1Bi1sebBG4mov6BJCTJxr9fkAqGq6DDVbXPzQuYfrx6dOnsWQk
	NGFVZJ02mX89NP4Slnol0KOXilsa+yQk5ZYd/bzUzSI0du8+JCGfYPtxVqNW5ACqvr65DiSF3TP
	ZoDYcPKZ8kg010QABZS0Z9k9UC8elqTzcqFxtn5MQniyfNw==
X-Received: by 2002:a05:6214:b65:b0:880:55e4:dde with SMTP id 6a1803df08f44-880711f6740mr2442706d6.63.1762273289422;
        Tue, 04 Nov 2025 08:21:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbCamAY2SZuoMpO6KHiloNu0ROOhc6h9PGPtn8wYlw/5WOYWCpXZH1XAyrMvBE9zJJ2aPFyQ==
X-Received: by 2002:a05:6214:b65:b0:880:55e4:dde with SMTP id 6a1803df08f44-880711f6740mr2442366d6.63.1762273289069;
        Tue, 04 Nov 2025 08:21:29 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88060e88d7esm24138536d6.43.2025.11.04.08.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 08:21:28 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4207482b-fc63-4db7-ab98-36b31a600173@redhat.com>
Date: Tue, 4 Nov 2025 11:21:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/mutex: Redo __mutex_init()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
References: <20251104140023.jV9j77ld@linutronix.de>
Content-Language: en-US
In-Reply-To: <20251104140023.jV9j77ld@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 9:00 AM, Sebastian Andrzej Siewior wrote:
> mutex_init() invokes __mutex_init() providing the name of the lock and
> a pointer to a the lock class. With LOCKDEP enabled this information is
> useful but without LOCKDEP it not used at all. Passing the pointer
> information of the lock class might be considered negligible but the
> name of the lock is passed as well and the string is stored. This
> information is wasting storage.
>
> Split __mutex_init() into a _plain() variant doing the initialisation of
> the lock and a _ld() version which does _plain() plus the lockdep bits.
> Restrict the lockdep version to lockdep enabled builds allowing the
> compiler to remove the unused parameter.
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
>   include/linux/mutex.h        | 45 ++++++++++++++++++++++++++++--------
>   kernel/locking/mutex.c       | 22 +++++++++++++-----
>   kernel/locking/rtmutex_api.c | 19 +++++++++++----
>   3 files changed, 66 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index 847b81ca64368..e731ef82aa0a0 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -86,8 +86,23 @@ do {									\
>   #define DEFINE_MUTEX(mutexname) \
>   	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
>   
> -extern void __mutex_init(struct mutex *lock, const char *name,
> -			 struct lock_class_key *key);
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +void mutex_init_ld(struct mutex *lock, const char *name, struct lock_class_key *key);
> +
> +static inline void __mutex_init(struct mutex *lock, const char *name,
> +				struct lock_class_key *key)
> +{
> +	mutex_init_ld(lock, name, key);
> +}
> +#else
> +extern void mutex_init_plain(struct mutex *lock);
> +
> +static inline void __mutex_init(struct mutex *lock, const char *name,
> +				struct lock_class_key *key)
> +{
> +	mutex_init_plain(lock);
> +}
> +#endif /* !CONFIG_DEBUG_LOCK_ALLOC */

I think it is a good idea to eliminate useless strings in non-lockdep 
kernel. However, the function names are kind of awkward to me. First of 
all, it is hard to associate "ld" with lockdep as ld is also the name of 
the GNU linker. I would prefer to fully spell out as "lockdep". The 
"_plain" suffix also looks odd to me. How about using the original 
__mutex_init for the plain version and __mutex_init_lockdep as the 
lockdep version which calls __mutex_init and use similar naming scheme 
for the RT versions. What do you think?

Cheers,
Longman



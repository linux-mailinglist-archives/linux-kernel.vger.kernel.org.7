Return-Path: <linux-kernel+bounces-876455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5623FC1B7B5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C55BB34308C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C3D2DA757;
	Wed, 29 Oct 2025 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpT4dfx3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ECB2D3221
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749773; cv=none; b=KUxGOOV27OGfA6GV4RegPB/O3sS+k5rRvTJDVg+BO2jg4Ow0DQOtIoVb8sXcwWSLhALT4613klp1gQdj/eRspbYoK3AN8L1cmhOSS4jXudOQXNc8HaF7jQpIG6JstN90PMrlQC+nJs9BEd9eNbq6MrusPmJuWeAgodIYJjRawD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749773; c=relaxed/simple;
	bh=40HyCRyh666c0BmB5+mDhy257j1PiJ2F/4oIUZkMO0s=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IcpWJ2y3u+WzkF5p1VJDFnhB0N7bVn1cv+lj+cQZJVtH1vc2ur90wWv1IZGdfObha+rrfioJp9+skVHJ7QPwY10xTMFvn6BjuavF9eWTjJOJQ2PxBvbjxZ1OwSDxha8mWda3XyeqN4WH9vcpjnCT2zpuYqg4b7UEo3yoMa/pGZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpT4dfx3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761749768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfG9dxBp0yCCb7vc5jDncKACjmXmKt9EY17LP7/Zv64=;
	b=OpT4dfx3RSRUu4yvEwJAjPuQW6+eAYioC0yR/u/JM+6QHlYNeRx7NSwJZwU4LVefB5GgzA
	ZrcM9NQaNGVNshS2ZtC+AtugNtQ2FEDQVO3JPubnZsm4EIuQ5owSOOlvnj4hpWdovWD+3T
	PZz8mtkPof6GaaJ66RngV2b8x6VxtF4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-oXB8M7NxO0211WxJP9ILeQ-1; Wed, 29 Oct 2025 10:56:06 -0400
X-MC-Unique: oXB8M7NxO0211WxJP9ILeQ-1
X-Mimecast-MFC-AGG-ID: oXB8M7NxO0211WxJP9ILeQ_1761749766
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ecfa212e61so33041971cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749766; x=1762354566;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfG9dxBp0yCCb7vc5jDncKACjmXmKt9EY17LP7/Zv64=;
        b=SqTGlmYvnApf1Ok/WldPoL0naKwRn/9+J55CMC10vnULSwN10yCckuIlWd1Q3pZv03
         Mqa/mSJG/2A71mzMnKsjSm02p9SSkbrQS6dmVUQqVjuqt5EDeZ6EPG/4Kb14vBZv8jur
         dWhuv/BXKDy2dS+aiFsbPko05t4M7qgWjFnAXcpEh9/ez1tfUXONykORLxssC74ZlvQl
         m0+vSuRGOQ7BU/0NG7e3+wXWTLOMgQhYxVkasBOioqH+dmtnEF94vt5UItNE2hVMr0zF
         M6sw+H1TDsfnK7fUw2vt2nf7/AZN25t6EXQrlNVZcXECW1YxgMip8t6EOLN+gKHVsE4M
         CVAw==
X-Forwarded-Encrypted: i=1; AJvYcCUmdo7h485UQ1fYDy29VU9iXRIVgkyJkBw5AFchrefcczURcDstEOeupe6zUHdSRPkUaKtAVb7YY6EaOO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytsq8PdzRa+eYoGGvxVXkLksHMZhA2An2VZaY0UV8VwKMpFnGV
	O3wxyDEASdOBdHu6LdZALd3FlHKuI6JSsKGr+RUVcSbmsSyICzfqg2mGWTgmC1P4W/RR78kV9z7
	UATFRYBQsBurDK/maP969eO6rO1Bi0LqGSBokZVJ7cFh8zivzfn3iQeRI+JQa+HW0ctXvzPxoZA
	==
X-Gm-Gg: ASbGncvKfO5gWgyS2aPph44lZaUDRRH/KLtrrGQFPBpgFTBJLeuZlAbaWhKrNLT/QXn
	g6uPv7k7JYb5Nzoi6heeLPxyRthSG7PZcluT8SOpTJyf4yrO4xwFpklg8t0cUxkGh8++YwdmBCQ
	Dd4UWvzsy50K6GTG2t72nzTcl5rYxTaiE/NaCFxL9mxEO2rHr1ICLcue7+RwGr+xHVpddeJvXad
	+hhVbTMMuJcSRMEiDkiCAcZeCw/bD3x/oQIkBNr7I5dCbym+r1pAKPlQhI5FtB5OLOEf7SJdwk1
	TXEJfjD8t57SzL0caeHwYceCfNQOUeKCZW6amFDA5tkKEWK3rw++Q2KpAIZqVmdx4KIynHiS813
	PixW3GnAokDEEpH3qw4AfSGTy1pYdDVS7JW6AHNfp1cfx/Q==
X-Received: by 2002:a05:622a:180f:b0:4ec:f88c:c48 with SMTP id d75a77b69052e-4ed15a69d42mr34603171cf.21.1761749765981;
        Wed, 29 Oct 2025 07:56:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiO5Ztb2gYTt4RFnk2B2GVdMeYBTbVK1H+Rh/U7pUX6fqAcwAx7GGS2i6PqlI/sQkg58SZFQ==
X-Received: by 2002:a05:622a:180f:b0:4ec:f88c:c48 with SMTP id d75a77b69052e-4ed15a69d42mr34602811cf.21.1761749765463;
        Wed, 29 Oct 2025 07:56:05 -0700 (PDT)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba37db640sm94560381cf.13.2025.10.29.07.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:56:04 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4252417f-014a-4054-a61f-918a6a8f8e86@redhat.com>
Date: Wed, 29 Oct 2025 10:56:03 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 1/2] sched/isolation: Split out the housekeeping part
To: Pingfan Liu <piliu@redhat.com>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>
References: <20251028034357.11055-1-piliu@redhat.com>
Content-Language: en-US
In-Reply-To: <20251028034357.11055-1-piliu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 11:43 PM, Pingfan Liu wrote:
> A later patch will introduce a function in cpuset.h that refers to
> definitions in isolation.h. This would cause a circular header file
> inclusion issue.  To break the cycle, move the definitions into a
> dedicated file called 'housekeeping.h'."
>
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Pierre Gondois <pierre.gondois@arm.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> To: linux-kernel@vger.kernel.org
> ---
>   include/linux/sched/housekeeping.h | 67 ++++++++++++++++++++++++++++++
>   include/linux/sched/isolation.h    | 65 +----------------------------
>   2 files changed, 68 insertions(+), 64 deletions(-)
>   create mode 100644 include/linux/sched/housekeeping.h

I would like not to introduce a new header file if possible. The 
circular dependency is due to the fact that cpu_is_isolated() is now 
calling cpuset_cpu_is_isolated() to get the list of CPUs in isolated 
partitions. However, Frederic has a patch series that is going to remove 
cpuset_cpu_is_isolated() and so the "linux/cpuset.h" include in 
isolation.h can be removed as well.

Cheers,
Longman

>
> diff --git a/include/linux/sched/housekeeping.h b/include/linux/sched/housekeeping.h
> new file mode 100644
> index 0000000000000..99cfc8821a814
> --- /dev/null
> +++ b/include/linux/sched/housekeeping.h
> @@ -0,0 +1,67 @@
> +#ifndef _LINUX_SCHED_HOUSEKEEPING_H
> +#define _LINUX_SCHED_HOUSEKEEPING_H
> +
> +enum hk_type {
> +	HK_TYPE_DOMAIN,
> +	HK_TYPE_MANAGED_IRQ,
> +	HK_TYPE_KERNEL_NOISE,
> +	HK_TYPE_MAX,
> +
> +	/*
> +	 * The following housekeeping types are only set by the nohz_full
> +	 * boot commandline option. So they can share the same value.
> +	 */
> +	HK_TYPE_TICK    = HK_TYPE_KERNEL_NOISE,
> +	HK_TYPE_TIMER   = HK_TYPE_KERNEL_NOISE,
> +	HK_TYPE_RCU     = HK_TYPE_KERNEL_NOISE,
> +	HK_TYPE_MISC    = HK_TYPE_KERNEL_NOISE,
> +	HK_TYPE_WQ      = HK_TYPE_KERNEL_NOISE,
> +	HK_TYPE_KTHREAD = HK_TYPE_KERNEL_NOISE
> +};
> +
> +#ifdef CONFIG_CPU_ISOLATION
> +DECLARE_STATIC_KEY_FALSE(housekeeping_overridden);
> +extern int housekeeping_any_cpu(enum hk_type type);
> +extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
> +extern bool housekeeping_enabled(enum hk_type type);
> +extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
> +extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
> +extern void __init housekeeping_init(void);
> +
> +#else
> +
> +static inline int housekeeping_any_cpu(enum hk_type type)
> +{
> +	return smp_processor_id();
> +}
> +
> +static inline const struct cpumask *housekeeping_cpumask(enum hk_type type)
> +{
> +	return cpu_possible_mask;
> +}
> +
> +static inline bool housekeeping_enabled(enum hk_type type)
> +{
> +	return false;
> +}
> +
> +static inline void housekeeping_affine(struct task_struct *t,
> +				       enum hk_type type) { }
> +
> +static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
> +{
> +	return true;
> +}
> +
> +static inline void housekeeping_init(void) { }
> +#endif /* CONFIG_CPU_ISOLATION */
> +
> +static inline bool housekeeping_cpu(int cpu, enum hk_type type)
> +{
> +#ifdef CONFIG_CPU_ISOLATION
> +	if (static_branch_unlikely(&housekeeping_overridden))
> +		return housekeeping_test_cpu(cpu, type);
> +#endif
> +	return true;
> +}
> +#endif
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index d8501f4709b58..e07b2c439365d 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -5,70 +5,7 @@
>   #include <linux/cpuset.h>
>   #include <linux/init.h>
>   #include <linux/tick.h>
> -
> -enum hk_type {
> -	HK_TYPE_DOMAIN,
> -	HK_TYPE_MANAGED_IRQ,
> -	HK_TYPE_KERNEL_NOISE,
> -	HK_TYPE_MAX,
> -
> -	/*
> -	 * The following housekeeping types are only set by the nohz_full
> -	 * boot commandline option. So they can share the same value.
> -	 */
> -	HK_TYPE_TICK    = HK_TYPE_KERNEL_NOISE,
> -	HK_TYPE_TIMER   = HK_TYPE_KERNEL_NOISE,
> -	HK_TYPE_RCU     = HK_TYPE_KERNEL_NOISE,
> -	HK_TYPE_MISC    = HK_TYPE_KERNEL_NOISE,
> -	HK_TYPE_WQ      = HK_TYPE_KERNEL_NOISE,
> -	HK_TYPE_KTHREAD = HK_TYPE_KERNEL_NOISE
> -};
> -
> -#ifdef CONFIG_CPU_ISOLATION
> -DECLARE_STATIC_KEY_FALSE(housekeeping_overridden);
> -extern int housekeeping_any_cpu(enum hk_type type);
> -extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
> -extern bool housekeeping_enabled(enum hk_type type);
> -extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
> -extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
> -extern void __init housekeeping_init(void);
> -
> -#else
> -
> -static inline int housekeeping_any_cpu(enum hk_type type)
> -{
> -	return smp_processor_id();
> -}
> -
> -static inline const struct cpumask *housekeeping_cpumask(enum hk_type type)
> -{
> -	return cpu_possible_mask;
> -}
> -
> -static inline bool housekeeping_enabled(enum hk_type type)
> -{
> -	return false;
> -}
> -
> -static inline void housekeeping_affine(struct task_struct *t,
> -				       enum hk_type type) { }
> -
> -static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
> -{
> -	return true;
> -}
> -
> -static inline void housekeeping_init(void) { }
> -#endif /* CONFIG_CPU_ISOLATION */
> -
> -static inline bool housekeeping_cpu(int cpu, enum hk_type type)
> -{
> -#ifdef CONFIG_CPU_ISOLATION
> -	if (static_branch_unlikely(&housekeeping_overridden))
> -		return housekeeping_test_cpu(cpu, type);
> -#endif
> -	return true;
> -}
> +#include <linux/sched/housekeeping.h>
>   
>   static inline bool cpu_is_isolated(int cpu)
>   {



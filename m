Return-Path: <linux-kernel+bounces-867375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2826FC02707
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5231AA05D7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C618A2D29C7;
	Thu, 23 Oct 2025 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiXrrjh1"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3222222B4
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236753; cv=none; b=DtuNPeu/ZSmocl48j2t1HTeiNqYiEE2SRLQVFfVdpXcToJhchrzf32pOzTx0Q+ppImOrPcF1yc6wNRe4kVJ0nt2GCxmFae2ga2I+iPPRcjMQOXOENEQ2cGukBPkpl6uPI/6mOlCfrgFykWJkSqVJW3SdySefQGl6PGzpvfHjhU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236753; c=relaxed/simple;
	bh=lr7ZpEfUTblHv2cs0jdXC1lYYkcUYLNrFIEnYLxBmw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFc32TW87mQc2ulvPmhNadtowfTbo7b+i6mPU7RBqZzsMv3QUuHsNtClsFG59f/TZeig/herCBCGnUqTLgBAPV2+/KTYizCPW/EsDOxkvxYBdXjavE4xRitlfaIkfpi7qG8wCEWsJyauV4RfZoJkL8e9uSOvhjZnGSXiRko9nZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiXrrjh1; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7ea50f94045so22964926d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761236750; x=1761841550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FwWq3klYnM7mVmzkADxrDU7jnRpb8xn47Rgf/EnvKqQ=;
        b=JiXrrjh1oYyPz7+DI85ivkDeWj3eIpNfTHjpVH0rErNJVSEq2En1ilYiC+pFCZ/fbp
         UIVtvyqkAU4n5HFuggpItY0zIgRYH9pGwFWTSY3hFsV1nNGuNJCvnDXch9wrzEuS7rNT
         pVbdu5LpGw3CwVyz/eZOVDJvTIJuso9ke+CEZbbYhE6kuOz6NEeQaUjQEXzbMe981XXe
         FliNSctTFDg3R8MhcQNpsv93k1WmTi2O7RAbUh0zvbwADR0w5z1HEf9rpzjyMnNPVTro
         phmbjRpaYCc3B5EeUbRbUteE2Wo+vsTxnyE90L2h57HQv5F4ZEq1QjGvMbWubrBnbViR
         BzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761236750; x=1761841550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwWq3klYnM7mVmzkADxrDU7jnRpb8xn47Rgf/EnvKqQ=;
        b=tdX3DDwVsvugiEF/g7GP8Kbq04xjZJSmjviDn+klw824QJt/R6dVDMSzgXRwh4c/Sg
         gT73nMnu9MRZytNJtIjeqakubtEAanzOoPwWN0qx8q1tkVvE+6gn9shhpyzEHf+ijDQW
         H9lUJZhEpndkDTGlOuceTaQvs3MWLNnP2uVg7IxNi27h8ousz3Vdwczjf0XwhQS+efKP
         6340wY3K5ubAub1LTNxoN5efVVULzOtxX40AOHXGVF46FhhXZesI+mRLnXz9R/b9DGIq
         nPOOjFGQEqoR2zJTlJBs55rLxHdyYkvgmBV6YwJTSXVSWSYFds0b4dFEoLz2d4wW+363
         ulNQ==
X-Gm-Message-State: AOJu0YybmjgXFpMGVwNBrHrMm0aEslbHhevbTCyWkA99VeHU++OsDfCf
	snKi8a7Q05uO8gXCW0N/LvbI5PrVl18yb0QZeGCSYhKNwg+DmtYJCJ1y
X-Gm-Gg: ASbGnct2k7jsPuHYhO8GC6/qE2cbVTzZ88Zp4CrQ8L1Tr8hWT8TVhVI3SsH1kWVSM8K
	AbHOSZB+4JG5H6gJWIv9UVT1wOKLZb10BrmEi1CfP+EA9zuAAiofXEzmhKkC/zn4P6RYhUhtb9S
	JzcsIhRYFAgj1brvTwNqXCJ/+LwISNuVKMXR58zFvo53ooS9FahUbINjm0SFK4FkfzRMQihpASF
	Mmcfcd01bLMikX+yGGd01ogKR3dhY6qhDt9lJKGQ+Gg2V3bxebHzZXe80Ww9JSrVmPqrra3dPOf
	9m44ZDFbhVOSJjT6A9IqvJWO8BBKKBydsI7yeCBHffx9hM/yg9N+25QEaR7Hqydn9LwiJmxrp2/
	FEjUtpBSSoIjc8gkYTRtEc8jxfdgjkrtW/YuUuuBCVslWfimeoChqwMyyZxCsFlW12SWizsP8vB
	FdJSpE8cU=
X-Google-Smtp-Source: AGHT+IFg69drPBMSEy8Z6jAHB2VINR3EOFfZdbsVuiw9/IfHr9uzdH3eP13eRf51bd0kzLp09W6TsA==
X-Received: by 2002:a05:6214:e8e:b0:87a:97f:de8c with SMTP id 6a1803df08f44-87df6760e0dmr95414096d6.28.1761236750247;
        Thu, 23 Oct 2025 09:25:50 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f9e7fc743sm18265046d6.52.2025.10.23.09.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 09:25:49 -0700 (PDT)
Date: Thu, 23 Oct 2025 12:25:48 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Florian Weimer <fweimer@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>
Subject: Re: [patch V2 09/20] cpumask: Cache num_possible_cpus()
Message-ID: <aPpXDLxcRq-TZMxL@yury>
References: <20251022104005.907410538@linutronix.de>
 <20251022110555.967170782@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022110555.967170782@linutronix.de>

On Wed, Oct 22, 2025 at 02:55:30PM +0200, Thomas Gleixner wrote:
> Reevaluating num_possible_cpus() over and over does not make sense. That
> becomes a constant after init as cpu_possible_mask is marked ro_after_init.
> 
> Cache the value during initialization and provide that for consumption.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yury Norov <yury.norov@gmail.com>
> ---
> V2: New patch
> ---
>  include/linux/cpumask.h |   10 ++++++++--
>  kernel/cpu.c            |   15 +++++++++++++++
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -126,6 +126,7 @@ extern struct cpumask __cpu_dying_mask;
>  #define cpu_dying_mask    ((const struct cpumask *)&__cpu_dying_mask)
>  
>  extern atomic_t __num_online_cpus;
> +extern unsigned int __num_possible_cpus;
>  
>  extern cpumask_t cpus_booted_once_mask;
>  
> @@ -1152,13 +1153,13 @@ void init_cpu_possible(const struct cpum
>  #define __assign_cpu(cpu, mask, val)	\
>  	__assign_bit(cpumask_check(cpu), cpumask_bits(mask), (val))
>  
> -#define set_cpu_possible(cpu, possible)	assign_cpu((cpu), &__cpu_possible_mask, (possible))
>  #define set_cpu_enabled(cpu, enabled)	assign_cpu((cpu), &__cpu_enabled_mask, (enabled))
>  #define set_cpu_present(cpu, present)	assign_cpu((cpu), &__cpu_present_mask, (present))
>  #define set_cpu_active(cpu, active)	assign_cpu((cpu), &__cpu_active_mask, (active))
>  #define set_cpu_dying(cpu, dying)	assign_cpu((cpu), &__cpu_dying_mask, (dying))
>  
>  void set_cpu_online(unsigned int cpu, bool online);
> +void set_cpu_possible(unsigned int cpu, bool possible);
>  
>  /**
>   * to_cpumask - convert a NR_CPUS bitmap to a struct cpumask *
> @@ -1211,7 +1212,12 @@ static __always_inline unsigned int num_
>  {
>  	return raw_atomic_read(&__num_online_cpus);
>  }
> -#define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
> +
> +static __always_inline unsigned int num_possible_cpus(void)
> +{
> +	return __num_possible_cpus;
> +}
> +
>  #define num_enabled_cpus()	cpumask_weight(cpu_enabled_mask)
>  #define num_present_cpus()	cpumask_weight(cpu_present_mask)
>  #define num_active_cpus()	cpumask_weight(cpu_active_mask)
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -3108,6 +3108,9 @@ EXPORT_SYMBOL(__cpu_dying_mask);
>  atomic_t __num_online_cpus __read_mostly;
>  EXPORT_SYMBOL(__num_online_cpus);
>  
> +unsigned int __num_possible_cpus __ro_after_init = NR_CPUS;
> +EXPORT_SYMBOL(__num_possible_cpus);
> +
>  void init_cpu_present(const struct cpumask *src)
>  {
>  	cpumask_copy(&__cpu_present_mask, src);
> @@ -3116,6 +3119,7 @@ void init_cpu_present(const struct cpuma
>  void init_cpu_possible(const struct cpumask *src)
>  {
>  	cpumask_copy(&__cpu_possible_mask, src);
> +	__num_possible_cpus = cpumask_weight(&__cpu_possible_mask);
>  }
>  
>  void set_cpu_online(unsigned int cpu, bool online)
> @@ -3139,6 +3143,17 @@ void set_cpu_online(unsigned int cpu, bo
>  	}
>  }
>  
> +void set_cpu_possible(unsigned int cpu, bool possible)
> +{
> +	if (possible) {
> +		if (!cpumask_test_and_set_cpu(cpu, &__cpu_possible_mask))
> +			__num_possible_cpus++;
> +	} else {
> +		if (cpumask_test_and_clear_cpu(cpu, &__cpu_possible_mask))
> +			__num_possible_cpus--;
> +	}
> +}

You can save a couple conditionals:

        if (possible)
                __num_possible_cpus += !cpumask_test_and_set_cpu(cpu, &__cpu_possible_mask));
        else
                __num_possible_cpus -= cpumask_test_and_clear_cpu(cpu, &__cpu_possible_mask));

Otherwise,

Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>


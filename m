Return-Path: <linux-kernel+bounces-867397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC55C027CA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCC1B4EB037
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B24C2C0287;
	Thu, 23 Oct 2025 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hixjkNFB"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE823817D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761238025; cv=none; b=AOnr3nJphLREIxVNqEq8Z+m46EByqVm15nlDC+jvaq4XMdR5o+XeOOc8o/8+omnQrcE2elUtvjrYqwUF2Xst6w7ahKf4BxhCtr+JaNwUEoK9FndhEkHkK/I9f5F8x2cR7WnSpUeiMRPipeH0INrLEh4l3Vj2CZws9mSb8BnK2e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761238025; c=relaxed/simple;
	bh=d+fWGVZerBKqiHmq6aPb8oqZdSPSg18m8++I0TfqOO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJsQP5AJJYZSGTdsjpr0SaDrLXc9mSlb7ggd858uTdwOfpCc4RHPS7saUp/pJOUosfj6zIwpAbej9ud2ElxeHSZoKh0fNPx57Tg8qs5XhSEjL8a6clWn7Jne3UgP4eRYnDBq0v5P+htbsPjfjsTpSNsspvt7tWnnvqZM8igMtOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hixjkNFB; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4e8850b09eeso10581811cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761238023; x=1761842823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d6wyt15VoOstgAKGLZqI+0Q23WMD7jCcPaWVJp4Nt74=;
        b=hixjkNFBCO30C3Y8uYX+61A/2H0FjOZz4WBFHQ+AYIXUyTyrX9P4yiq580OmVTe2wE
         ssjt0lgHnd336XnIOCwntdYECxu/iOnY4BVSFbOko+XM4MJ9Uk/rPy8Hrhj/XxV94AT4
         Uf0nxp82dWYIgRfZlJeI2WRs/Q3q+gYSNCNAC4rPUyZExcQtEMlkf7atELlS227N8QV0
         hAFsywIr6ya9b9pNx8Wn/YfeOCpY5KSbaATj6LEjk0HXuw2Im9eRFMX5YC//Y13IXJbY
         YBm+ljqJ5IChMFXfYi4oHwj+ETYxgjxiqR6H7bYAi1mEwjvY3pfM5iZ38Q7zRAOhQTtS
         Cy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761238023; x=1761842823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6wyt15VoOstgAKGLZqI+0Q23WMD7jCcPaWVJp4Nt74=;
        b=wc6XF5EyTJd+3+Ck5uRJ6nHRTVV5puj6R+pBbpPnvHEgPhhmsWq9b2xEd1roynh3k5
         aQRT+ExZT2Y/CE4mioFGfVMEtw10YXhJUT8NFemkTx6IkE74Oezvbisvh0CgymM/TiDz
         pEHXLh3/n3NP1lIYjbvJ84YIjIelFOmZxhhDxJ4ZAy6AhOt1V3qNmKqLLJwqBwXHyfZ5
         9WHzDtRFVuPGStCncTpw1L5CZT0lgiSoA9fDsfVxbuXPCduR2Wf8IGHgd3yhKqNN4kKQ
         yvt2PzShdfkPCtqXB4w1rNoT9tdMly+pPk+KU77ts8Dk4G8jwwotIVJ3mylAKbhAgTbK
         3d4Q==
X-Gm-Message-State: AOJu0Yx9ma97+mHucFH7UStmoa8WpHVOz+0aDrB0JNx4AmPTWIQ/XBBl
	ra6D5DblwZAxs3AdWWvm4hDAOqiH6H3+/tHlKQ2y5gos4bqPrdoddsIe
X-Gm-Gg: ASbGncvxPws1l/bmWhpljtYMVMaA38P5VvkMfBBVdcw+BhKXtWN0QsSFVZI5gHr/mwG
	XqbyXNfqIqHdu7WUI0Z0otn7mhFoiVMACrwGChJQEpa2Ct0iSoA1ZMLys9gA6yXOHtG5DfsLyd9
	2af46ShpdFj8ktIsAb3SQh1A7JGDM/opuEmVOw+vtQbUg1PnRdX3YA7+m0dEtWx4VemecJHyRWO
	IHuwLb7iIUwK4YhPPxlBfJVz4uTQtajRy0zFB2dBcrmEOGUl5S4IYLwkRnUVU93qKfLdFKUUUqU
	7m/j6O5vLpAJDtn8t8TPoe8UVKWG+Z86Qinz9Ut3DIllH9wW0x5ZGhZycrrfKqnFar6VR0nUCfL
	8TMGc5Y4Y6jRn2poVCzsojMcVBUX5h/VkRLl926oFcm380BLsatpw1OSTifOhYnv3FZBaJEryiJ
	kCgHlwsvMKQxHn8MTztw==
X-Google-Smtp-Source: AGHT+IFWA7d6/Y24hc8wt+sTmJxRpmR3YB3WF3LRIp9Ly9eCfmiGz46KHesbdoGaRTN0V1BEWgPbAQ==
X-Received: by 2002:ac8:4249:0:b0:4e8:a464:1083 with SMTP id d75a77b69052e-4e8a46411a5mr202064901cf.54.1761238022710;
        Thu, 23 Oct 2025 09:47:02 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c0dbccb8fsm193101985a.11.2025.10.23.09.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 09:47:02 -0700 (PDT)
Date: Thu, 23 Oct 2025 12:46:50 -0400
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
Subject: Re: [patch V2 10/20] sched/mmcid: Convert mm CID mask to a bitmap
Message-ID: <aPpb-lAkNACezbkh@yury>
References: <20251022104005.907410538@linutronix.de>
 <20251022110556.029862568@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022110556.029862568@linutronix.de>

On Wed, Oct 22, 2025 at 02:55:32PM +0200, Thomas Gleixner wrote:
> This is truly a bitmap and just conveniently uses a cpumask because the
> maximum size of the bitmap is nr_cpu_ids.
> 
> But that prevents to do searches for a zero bit in a limited range, which
> is helpful to provide an efficient mechanism to consolidate the CID space
> when the number of users decreases.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

> ---
>  include/linux/mm_types.h |    6 +++---
>  kernel/sched/core.c      |    2 +-
>  kernel/sched/sched.h     |    6 +++---
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1342,13 +1342,13 @@ static inline cpumask_t *mm_cpus_allowed
>  }
>  
>  /* Accessor for struct mm_struct's cidmask. */
> -static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
> +static inline unsigned long *mm_cidmask(struct mm_struct *mm)
>  {
>  	unsigned long cid_bitmap = (unsigned long)mm_cpus_allowed(mm);
>  
>  	/* Skip mm_cpus_allowed */
>  	cid_bitmap += cpumask_size();
> -	return (struct cpumask *)cid_bitmap;
> +	return (unsigned long *)cid_bitmap;
>  }
>  
>  static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
> @@ -1363,7 +1363,7 @@ static inline void mm_init_cid(struct mm
>  	mm->mm_cid.nr_cpus_allowed = p->nr_cpus_allowed;
>  	raw_spin_lock_init(&mm->mm_cid.lock);
>  	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
> -	cpumask_clear(mm_cidmask(mm));
> +	bitmap_zero(mm_cidmask(mm), cpumask_size());
>  }
>  
>  static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *p)
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10399,7 +10399,7 @@ void sched_mm_cid_exit_signals(struct ta
>  	guard(preempt)();
>  	t->mm_cid.active = 0;
>  	if (t->mm_cid.cid != MM_CID_UNSET) {
> -		cpumask_clear_cpu(t->mm_cid.cid, mm_cidmask(mm));
> +		clear_bit(t->mm_cid.cid, mm_cidmask(mm));
>  		t->mm_cid.cid = MM_CID_UNSET;
>  	}
>  }
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3558,7 +3558,7 @@ static inline bool __mm_cid_get(struct t
>  
>  	if (cid >= max_cids)
>  		return false;
> -	if (cpumask_test_and_set_cpu(cid, mm_cidmask(mm)))
> +	if (test_and_set_bit(cid, mm_cidmask(mm)))
>  		return false;
>  	t->mm_cid.cid = t->mm_cid.last_cid = cid;
>  	__this_cpu_write(mm->mm_cid.pcpu->cid, cid);
> @@ -3581,7 +3581,7 @@ static inline bool mm_cid_get(struct tas
>  		return true;
>  
>  	/* Try the first zero bit in the cidmask. */
> -	return __mm_cid_get(t, cpumask_first_zero(mm_cidmask(mm)), max_cids);
> +	return __mm_cid_get(t, find_first_zero_bit(mm_cidmask(mm), num_possible_cpus()), max_cids);
>  }
>  
>  static inline void mm_cid_select(struct task_struct *t)
> @@ -3602,7 +3602,7 @@ static inline void switch_mm_cid(struct
>  {
>  	if (prev->mm_cid.active) {
>  		if (prev->mm_cid.cid != MM_CID_UNSET)
> -			cpumask_clear_cpu(prev->mm_cid.cid, mm_cidmask(prev->mm));
> +			clear_bit(prev->mm_cid.cid, mm_cidmask(prev->mm));
>  		prev->mm_cid.cid = MM_CID_UNSET;
>  	}
>  


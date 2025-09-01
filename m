Return-Path: <linux-kernel+bounces-794194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4E0B3DE36
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBEC17CA7D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B1430DD3F;
	Mon,  1 Sep 2025 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="FnCWXuRi"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFD130DD19
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718453; cv=none; b=Fr4iLYkkVvJGDg+c4/TJ7dFuDpDLRB2LFz9Gt5469jpXY8dQ1j4GurdTqBvazJce8c4q/lI/O0ZJ1uOEEFMUMbbKp8JvWELDN0ONwxF/lt80s7pijplD2eBH5UXX5NKQByArV7FtpmoISsB8slQfTKNOy28bBkGhV1qaOEvaBD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718453; c=relaxed/simple;
	bh=TryJhQeYelQVDUoEX86WA6u3OY04cJHr9Ch8Ivyhgs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nu9N1fuRRPvgHoyn/h55zMs1qr9dwfFEkl1AfcI6L/g+ynXkk9/BnhaYWGKTSwIKd1VsvaFLtlh4QiYi/vhLqTfar3cEq90QPk6TaHocLRUKwrzyQ+dXzsrcLk1GE0FghnIqv09uI11b9ZO31w4FchNwpA1EWMtW3fpH3hxhtvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=FnCWXuRi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b7d485204so31833785e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1756718450; x=1757323250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/i2gIUiAfrzVhbMVW7hgRdlp0nqG5Gm3oFBzPVSe5+Q=;
        b=FnCWXuRikFDNmRAfzVsBsSlSj6jaiyVrCqJzw0Bm+JccPChcvrJMjpxDMQ1XgwhOPY
         5sk/uGWqsZ2CbrKWG1xEHibSMPB/WGnu6/JAhtPi/iPOFjbZiQgizxdFDFaxCwyZczzx
         hbeIlTGx0E/NICBW4bjsG+/Z19kKw4+gzDRbKFstciEBU0U3G2E/r45anXQrdaBbru56
         mak8MjoOQi0kcHmgqbS1QVrwysErlBHIfcbE3pCFy/6msoCBrcOvz1mwD3synOKPc/L0
         aDHpQxF7/LJJgGhti2/wBu+7mOrMFshSnFwuKRbeu25l/zvEL2y+xTzfGsndklxlsrCk
         W3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718450; x=1757323250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/i2gIUiAfrzVhbMVW7hgRdlp0nqG5Gm3oFBzPVSe5+Q=;
        b=hOcpTSevGAuLcdU3CULz27gauiq3qpsPN8kTzUk0hTIF4B1m5XxuwRDoi8wZdBa9xV
         geZ27K547UWul1nxLNzcW2LUIGuA8Bh6fyEzUnZZi1ynyDmCj9u0m7L3LLdp9TM0JH31
         6JNzqkswVIQDNNMIT5VUj/m2q4AlhyYC2SEIBc/hNMhS+jSnvNSczpYmkFV1P3KuTGON
         KvNQj0+goY+g+R86JqMO6ErTGjKXa4NjtXkHVODD5eYeHs5zULSPVcAJ009K8NnvvMhG
         UYsgPcLA3OMrMZf3oE2IVM2d2fm58PnWHcvd1wTCRNN3PvCvbIsmqocipXzdAy4YWQMc
         HQwg==
X-Forwarded-Encrypted: i=1; AJvYcCWAaQ3GtuxD0f9m85FoLLZyAx3Bru+q8N2bg1DZgbR2oqRZTa9R4gonUaY4ge/tp9Ehnl3ElnJIr78X4tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPf4XK34Nhv/z2eAfSU1+fEpxLg2OV5bu3fmGsSU8yy+fVVXVg
	EdOymSNuS46TC21cHRE86/QWwkmk/s8ApXEbMs3hPC4BkdT3wXc7fwfV+DyeH5w95/Q=
X-Gm-Gg: ASbGncsJ5U245vuCP9g19nALeY3MhCpYbHnZVOmecYQa3jzCK9b5v/Pm2ZFuLsNs4Q2
	+VoHhEwcZ9UV1rq6S1M/rRMNvkkkwfPus1xLuJ4GHHPatvfrnVgQmdEMtFfwDeIga6hSjcyU7hN
	7fgY1+xLh5wUvGKCi9B24cP3dv41jSokT2UvQy98pFE6RmpFaVtp/qARpNXTFDtcjRRrLVQEnii
	VR6FHCMJ1MTd0Rc2OKUWxVVy2ngWvKhIr4PLABsONGWbGlEl32qDNXjAd2BAvsaVVimNMXlohH/
	6uDRswyXEtd15NNiWzeUHRasm/+Ol2zofSl36C4/+1QYsbhb8M4kaNBoIdZ0esangGJuXA3jJ0x
	4ECqC0/LgOP2zkBg53F861MbK9LS013b+ILTwkOSIzhnul/5mbEokT/Nh
X-Google-Smtp-Source: AGHT+IEH7k+cTl4AENULt4iJEeeg1UjQsogXwQIwX4M0gFMtTFyb8n5rmxYFOvzuieQyQ8wYdo+xZw==
X-Received: by 2002:a05:600c:a47:b0:450:cabd:b4a9 with SMTP id 5b1f17b1804b1-45b8557ca38mr50081145e9.29.1756718449534;
        Mon, 01 Sep 2025 02:20:49 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d15f7b012csm11224695f8f.63.2025.09.01.02.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:20:49 -0700 (PDT)
Message-ID: <abb776bc-5b13-4db7-9421-59259119b859@ursulin.net>
Date: Mon, 1 Sep 2025 10:20:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/sched: limit sched score update to jobs change
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250822134348.6819-1-pierre-eric.pelloux-prayer@amd.com>
 <20250822134348.6819-2-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250822134348.6819-2-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



+ Tomeu and Oded

On 22/08/2025 14:43, Pierre-Eric Pelloux-Prayer wrote:
> Currently, the scheduler score is incremented when a job is pushed to an
> entity and when an entity is attached to the scheduler.
> 
> This leads to some bad scheduling decision where the score value is
> largely made of idle entities.
> 
> For instance, a scenario with 2 schedulers and where 10 entities submit
> a single job, then do nothing, each scheduler will probably end up with
> a score of 5.
> Now, 5 userspace apps exit, so their entities will be dropped. In
> the worst case, these apps' entities where all attached to the same
> scheduler and we end up with score=5 (the 5 remaining entities) and
> score=0, despite the 2 schedulers being idle.
> When new entities show up, they will all select the second scheduler
> based on its low score value, instead of alternating between the 2.
> 
> Some amdgpu rings depended on this feature, but the previous commit
> implemented the same thing in amdgpu directly so it can be safely
> removed from drm/sched.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 5a550fd76bf0..e6d232a8ec58 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -206,7 +206,6 @@ void drm_sched_rq_add_entity(struct drm_sched_rq *rq,
>   	if (!list_empty(&entity->list))
>   		return;
>   
> -	atomic_inc(rq->sched->score);
>   	list_add_tail(&entity->list, &rq->entities);
>   }
>   
> @@ -228,7 +227,6 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
>   
>   	spin_lock(&rq->lock);
>   
> -	atomic_dec(rq->sched->score);
>   	list_del_init(&entity->list);
>   
>   	if (rq->current_entity == entity)

LGTM.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Only detail is, I did a revisit of the scheduler users and it looks like 
the new rocket driver is the only one other than amdgpu which passes a 
list of more than one scheduler to drm_sched_entity_init. I don't 
*think* it would be affected though. It would still pick the least 
loaded (based on active jobs) scheduler at job submit time. Unless there 
is some hidden behaviour in that driver where it would be important to 
consider number of entities too. Anyway, it would be good for rocket 
driver to double-check and ack.

Regards,

Tvrtko



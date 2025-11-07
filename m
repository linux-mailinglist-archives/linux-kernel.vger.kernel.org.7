Return-Path: <linux-kernel+bounces-890647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E4EC408FA
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 274F834BF44
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB382367BA;
	Fri,  7 Nov 2025 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="PcSP1zNi"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C5A1F03D2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762528694; cv=none; b=fC938H5tS7xjUubWZMM+AOAzugSN7UYb8iClW5xrBTJ+sYnQkZ8clhGQgXjKi2a4TFhLzngmNiPUYKYBiku0kDsdUJwRCq6YiQfnDAX6nnCJ9DTzfTwtYZXKDayi8YHGcHQSwIUGn5dTEzT905yz0v1UjPxKbVjeB+mlMEUCvpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762528694; c=relaxed/simple;
	bh=0ysQMU23AHHGh/shB0aT3HiVcLw0t9yG0upRYI2PiGQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TpBYqsF8k9iAySgsJEWkM7rnEutHbuj3jtT8okm6fGsg5xghpjE31HcBcm8IsHSEiwtCtwOv0JQ8cF/Uobb/sRDRgo+VY8DjoQO5azS/eCYK8npLDKWUa/WkReV+0iqAbAkaib+7zevNO+SDxErE2lbkn086mE3PrFAxatE3Rjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=PcSP1zNi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47117f92e32so7231445e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1762528691; x=1763133491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d9dTI72UNi4STgQlM1dTHrD8kffrsq2tlv/hqqGXE+g=;
        b=PcSP1zNim1kPU5ipSlge/1awDvY9aRkCAOJjFP5zOgLOt8ZR2rJorxCQElEiXanDQN
         M+7x49F3KpaTAHi26Aqfvi8NLrJPsYQkXdxlulV4SPGCfudcCtAhoqBdQQoKVg9ByjHY
         68BuZVU3S/PX46lAP/cifrMBF7sHWPvXLKVDBPXj2RBMMX8yWPcqv1fhRhOJpOHyVNW8
         yZg6ioAvvW52EuiL1qtR0SlbnL72a6hrkiQi3lbxiu5mjKGxmF20pSY40r5lr3Gmhq/t
         0vZ/LU77h6TOdmpaSDnav57ENN2MSaCcxvqUZ6vcadJKmuFVzJbt6nNcJnE7yvQbeUc8
         /nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762528691; x=1763133491;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9dTI72UNi4STgQlM1dTHrD8kffrsq2tlv/hqqGXE+g=;
        b=DQ+HzFFOcpmiu3opOPCSMY5n2iCuX0dSrmuRpvJtvKHJ7Yf/ZotYjcU2bu8ajYsNmn
         DUEriABUa/3L3FhQBBDvIeqntqQQYDWGbXuRM8HxHSowJIvtDLbSu0GcA45p6Ly+V+4h
         zj9xdj/yirDiF7V90SNh+506fhGGaeo5uPEfZ2vBZt6fKU+twUCw43oc7b6FwWZWSWk/
         qI08zmykZ1IBMz1NCZfmwF9/lOd2DGiA43HzYs7ETuL0vsN23xLbk4gG5o7s4M518EW2
         oYX4/3ZxD9aC1VnZdqjZpgi8qpaXJUqNb8D920NbZglgf6ynHWGtE1kdX0gtvyQir9iF
         K1IA==
X-Forwarded-Encrypted: i=1; AJvYcCV13MTxPEJC4b/PXR0ucu6O69mdNvCvz1Hn4BOboU6ITn3tvS8ZgGap4UGHV24s/5yuxS34ZLVquqNw+jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNXJDrp0XkKaF0gQfKaBtGcHTB33w7fpYcD4zzq/zCIWCCkNtG
	SzS4zTINMlu/NE+B+1IqZVtMVaHcXCDXP37UcARkqWpDAqflyxV1I1OV52NRysdyB+g=
X-Gm-Gg: ASbGncu8I0qdb6Vn997WIuRLmPeKLEwknCOV7ddbVDgCbyJGkZcqfFPJSn2Lv6tzNI0
	aNM2m8As890neh/Q/zsYn0O5Gp3vg1Jg+BfI/TsA7YqKZ/Uh1CADNS//JGIEIFY4fe+suOeeYqH
	WfS9jCrI6JM2xNx7LDNfmtNR1UXcYETlQ7itZNK4IHMR0pZfLAlkmh2MrhnGJEt4lD/ipgaFIhZ
	/FAbe5xoXtcIbenI+fVUdVtrQbGVwVqRa2zwlCtZLrDZ59ryoGZUQFQdz7gdYJUnq8eZq/lzuJH
	/QejhyiuGSqqM7nyDekPo4l6rrDKUfD/Q7QgKNa3VgATv+34+5oHLJW+sI8aFguY6HbwJJzBLOq
	IY2BeDp9eHGePmiABNmKrqqngZks/amTy3Fusj84v2YN7GGyvQpxYtGM2nGOhkITR7bG4X76q37
	c1BWpvPTdVeHjskYfK
X-Google-Smtp-Source: AGHT+IG4EIX5fyema2IYjt2l3Vyqv0iu4sditV/Gh2C/YUsbpK5YmKbRpuXDfxNtaO5SVbSj16Xs3w==
X-Received: by 2002:a05:600c:3114:b0:471:9da:5232 with SMTP id 5b1f17b1804b1-4776bcbbb2dmr30521885e9.15.1762528689958;
        Fri, 07 Nov 2025 07:18:09 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcd521fsm66664195e9.6.2025.11.07.07.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 07:18:09 -0800 (PST)
Message-ID: <f39d38c8-8a07-4a63-a09f-3319b5ebb5f6@ursulin.net>
Date: Fri, 7 Nov 2025 15:18:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Don't crash kernel on wrong params
From: Tvrtko Ursulin <tursulin@ursulin.net>
To: Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251107125508.235449-2-phasta@kernel.org>
 <c4a10ad7-22c0-412c-a456-d2dd0f049ac9@ursulin.net>
Content-Language: en-GB
In-Reply-To: <c4a10ad7-22c0-412c-a456-d2dd0f049ac9@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 07/11/2025 14:42, Tvrtko Ursulin wrote:
> 
> On 07/11/2025 12:55, Philipp Stanner wrote:
>> drm_sched_job_arm() just panics the kernel with BUG_ON() in case of an
>> entity being NULL. While drm_sched_job_arm() crashing or not effectively
>> arming jobs is certainly a huge issue that needs to be noticed,
>> completely shooting down the kernel reduces the probability of reaching
>> and debugging a system to 0.
>>
>> Moreover, the checkpatch script by now strongly discourages all new uses
>> of BUG_ON() for this reason.
>>
>> Replace the BUG_ON() in drm_sched_job_arm() with a WARN_ON().
>>
>> Signed-off-by: Philipp Stanner <phasta@kernel.org>
>> ---
>>   drivers/gpu/drm/scheduler/sched_main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/ 
>> scheduler/sched_main.c
>> index 1d4f1b822e7b..3bf4ae0ca4bc 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -857,7 +857,7 @@ void drm_sched_job_arm(struct drm_sched_job *job)
>>       struct drm_gpu_scheduler *sched;
>>       struct drm_sched_entity *entity = job->entity;
>> -    BUG_ON(!entity);
>> +    WARN_ON(!entity);
>>       drm_sched_entity_select_rq(entity);
> 
> void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
> {
>      struct dma_fence *fence;
>      struct drm_gpu_scheduler *sched;
>      struct drm_sched_rq *rq;
> 
>      /* single possible engine and already selected */
>      if (!entity->sched_list)
> 
> Still the same end result.
> 
> I believe best practice is to simply not have BUG_ON's followed by null 

Sorry I meant WARN_ONs. If we think there is scope for bad things to 
happen after letting the execution proceed then I would add an early 
return to the WARN_ON (_ONCE?). That probably means to push job as well.

Regards,

Tvrtko

> pointer dereferences since they add no value. Ie. it should just be 
> removed and not replaced.
> 
> Regards,
> 
> Tvrtko
> 
> Regards,
> 
> Tvrtko
> 
>>       sched = entity->rq->sched;
> 



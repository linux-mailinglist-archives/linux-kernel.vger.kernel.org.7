Return-Path: <linux-kernel+bounces-896899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C1BC5173A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C031888452
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688E22FDC36;
	Wed, 12 Nov 2025 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="N3AmSTTA"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267CE280025
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940823; cv=none; b=l1ch33Ox4KYd/Jj4e1san9vk+jf+vlySmRkzjJP0FA7K3DWUqRxMvE+Im7CZixChY3pDvswz7ofA17br4KXHR9YG47qQMqEAxp/a8nJIBPPPKTyqhLfKyPYL+u5eN72jG6DXHtd7M2a5MpFsOSqpvFXsEvNfvx4EAi9Iy5W/MPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940823; c=relaxed/simple;
	bh=P39/eJ2a7f5kUNYNzFuQlOYl9DtM6wBUqGzvlaX6QlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HboBwx5oVybQCRppl82rKGWXxLXfdJxVxIzU70KHlJL2KSsXfoAQB7dYemyPWyI8QBRluhWxaohTAePsG7sa9hZ+EAxCtvzOu2qZDP0BgBMdPRVmNOLjNkkoIkd1BegZ0KlP/Asu0P2p2/t0acXavyn0VghRBn3cWSDF6rcCpSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=N3AmSTTA; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3720e58eso525132f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1762940820; x=1763545620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zH4o3q1L44X/0peS5m4xN21r8Fva++k7ZzB8YahQa/0=;
        b=N3AmSTTA/JzynFch2WA5C2RiNmjyA19W9SgXH8aHazyO705ekHwgWAWctIYbT/hqNT
         cBAQAUYu+HkGPIJmEYx8fnq4BPMEa0bDPXgYmzp1wKjn+UEZ4JuMt+NeMDUr0pcUzwnT
         ctJpZ2zDrvH0WpmU4jbDdL15k7MR6/lITqqRrCbCxb+SU14PIfwKGrHS582acKpS1+F6
         6WjPJ5JYRWe2aTiMlhtyFfnmkVsvK2Y++9J6S/av5B1IvyBwpH3F+uWu5FPV8DslQyCv
         OAVo+qqGqrGaCot7T+vCAXAKAniDcInARAAumEwf841i9CL5SEeaUi1FZySf7vgEjVe5
         /VwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940820; x=1763545620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zH4o3q1L44X/0peS5m4xN21r8Fva++k7ZzB8YahQa/0=;
        b=DKZDcSFcj9urmhvAXK37HQa3PDqaebL4ELJygAyjO9jUx4QPYHYhC1GxjwuryKQDf3
         BAyNX9ww3rdNc7ojVfIy2Mni0M4Yl00ZJX1ntxsIl163l1m0sNYYMjKildFJd2P6O6DG
         r6z/21M7ZJUr0ndWxN4OwUV0k8hTZFyV5GALLVkbiD32EATbPq9KPG1PTukb9o1slGEr
         nrTR1wF4ePQ/Aty80bEQzj3w5C1f6pE1SNZmvi8w/mj31pSc0dPR/tSsqwXkqcglXFKz
         GjyPRBwOz7a8R7avG0jIYfAUlDhtJ8dIC0s1yWM5OPDoaJtpDBE3YCzGWASNBeLaPSDz
         PjdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdJSmCxTVeiaVLA6la0dZFJai5lkiBQVBTJAIfEgP22j1+fc7tTGMWqliJmbwARsVTYNxmtNE9qGi1g2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyakKejHToz4AZdZtElAqEk9P6KYAw01G3f/xztxscU0gHteahJ
	/ks8CbgCoMx7uA/3T+dnwaLsEHZWkDJBP0Z0D7Wo+q1xBueqGHBHaseNpDwDFJCn/m4=
X-Gm-Gg: ASbGnctbNO0c09MeESzjBKGqbKOqkRD9PsV54fWrGm1ZANlsMglytJQcVQE+/dQZsVF
	tzzz5RDJK9+Kb7NbyHJ96mWTLDZB/5jS4LptZ+0YoYawv1hkPU1C3gTJFdIjD135QKq57pElpH9
	LiSkDNWt7QDXB2SLD9vYdyYUdcCzysbSqnT3CUYlDe8CnPGiXHpadRzx4oqUvX6XqqBNZpmvaZi
	lw7B43nqkyL1VGTTFDw6Rh8LFm2l9kPYdVBwrmV09JjvVULxaK3pjeasP3GyBIxAAoFgVEJOoVG
	trdVnwDHla//1/VlKxtoTxsR6AgExPCDWZPK/dNKwSmWYZKxU8Z0Rmm8AV125YS1H26uGIAlehz
	6T5sLw+R/T/syvl+S/MFx7OwuQ42vM3fQSIADoJImhBh7JnOQc4Mpw8TCm+ONozf4umQFCYqL61
	OhHWm8uRgjEMBgohNHflpLrQ==
X-Google-Smtp-Source: AGHT+IHpBCwExuuhQRu+JrqnaJ14VJBUuNzDyQ7kpmml24vqKQH0DF8Jy1NpPafZMFNAmZMwbTbYfw==
X-Received: by 2002:a05:6000:4008:b0:42b:394a:9e0 with SMTP id ffacd0b85a97d-42b4bdb2becmr2036730f8f.32.1762940820435;
        Wed, 12 Nov 2025 01:47:00 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac6794f6esm37288938f8f.41.2025.11.12.01.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:47:00 -0800 (PST)
Message-ID: <1e71b41d-38ba-425a-a370-1bb92a772014@ursulin.net>
Date: Wed, 12 Nov 2025 09:46:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/sched: Don't crash kernel on wrong params
To: Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251112091851.104443-3-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251112091851.104443-3-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/11/2025 09:18, Philipp Stanner wrote:
> drm_sched_job_arm() just panics the kernel with BUG_ON() in case of an
> entity being NULL. If the entity is NULL, subsequent accesses will crash
> the particular CPU anyways with a NULL pointer exception backtrace.
> 
> Remove the BUG_ON().
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> Changes in v2:
>    - Drop BUG_ON() instead of replacing it. (Tvrtko)

The option of removing the BUG_ON was conditional on brainstorming a bit 
whether we think the null pointer dereference is the worst that can 
happen or not.

Other option was "WARN_ON_ONCE() return" in arm and push.

Problem being, if we allow it to continue, are we opening up the 
possibly to mess up the kernel in a worse way.

For example push job writes to the entity. Okay offsets are low so is 
the zero page always safe to write? I don't know but sounds scary. From 
that point of view BUG_ON or WARN_ON_ONCE with exit are safer options.

Regards,

Tvrtko

> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 1d4f1b822e7b..05eb50d4cf08 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -857,7 +857,6 @@ void drm_sched_job_arm(struct drm_sched_job *job)
>   	struct drm_gpu_scheduler *sched;
>   	struct drm_sched_entity *entity = job->entity;
>   
> -	BUG_ON(!entity);
>   	drm_sched_entity_select_rq(entity);
>   	sched = entity->rq->sched;
>   



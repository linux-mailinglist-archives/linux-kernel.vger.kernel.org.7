Return-Path: <linux-kernel+bounces-890584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE63C40695
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 280DE4E5370
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6C0261588;
	Fri,  7 Nov 2025 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="XCk/uYpM"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096AA2C21EA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526546; cv=none; b=kZp+NmF4ChLTqTHiseywfP2K7f1+zkvvy8oK/n/poK7SAcY6jAmfu3/hTzkpCB3fF+/akJ+EUj0yrxB7dhuA7sHO8+RDgB+Q4gFo/HXqNeZxeUV3CC4kRufaO1FjC34NTrt4E4xNO5+a9F3jvKZDTau5hEpqNqWk6EYcoOsbrM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526546; c=relaxed/simple;
	bh=YhkEMFPyXkL0KtUMLEtWSj3UnsHN3o6spA2WdOO4V/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLOppLO4YLiXpCl94bKe5JlB3fjkpYpnWB9tj1B7XglL9lM+vJZdsBI+J3T47s33nTo43Rm5W4oAcG5esQhEOQ8xS/1at7o3/hCTL9FNjZYlABKMZmL3SBZT3YL6xWPYGX8PV8J4llodJnUQ4gmsDvFF0m/gXX2Fz66HoFtYSA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=XCk/uYpM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4711b95226dso8309085e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1762526543; x=1763131343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7prOgZ8tel5yXZ1o8muDswYilsSv/7VLhnLi/dbDFKk=;
        b=XCk/uYpMcoEZGdJ64vDPs0T2xE74YKsOpqP7Q1YYBdQo5qr6nmCnCka0L3oV90ga2W
         k4JNjyMn84XMSnBi5dcoyytiCH3wcb5YddOjnP+IvkjIjaStHa91FMTHz0E050LNk/lQ
         bPm/rCONgh2BXLmgXG3x4+p3Xnlt+a/uQoIIKX/qMF5FV/tf8jtH90QdW0A4xd4j+VFj
         a/U2b7C0gCZfcmn/doM+E9Cv6mTIO+T3eB8G/vAjpOy4wa0At7xHBfhnIoNDG2e9wB6a
         nAy5CFh8QCrkNFb2QGpAYHk9Lo26wxPE4fvmG/N33lXXSW1/OOuZv3Z7zp+HF+YNyGNP
         ffRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762526543; x=1763131343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7prOgZ8tel5yXZ1o8muDswYilsSv/7VLhnLi/dbDFKk=;
        b=fWsPq2FA8OI15e5f9Re/dSjfzrS6+wXNu9Xvsk6skgyXLt5rWMch30EXIGkaGIE/Je
         jtrJ1cYeS8XvfMzSSL3hpzRz3vrTPW0Vsq8kaL1Yt3M29AWHgWntQ+zH/IJYGsVE7iMw
         2LcZPRiNAl4H/V45qnHXKc5fc2WYKaZYaQA2nV8tpz+VJ5VPHGvkh+4nvaZLX1rZ4lNx
         k/OihPEgadYsqveQQUSMtXd6nqN+X1NvlcJBoI/ZMD3bjPJB3OzfeMbxDuwNYfZnWov4
         QhtKqO8Zkz92PAEcSMI+mfWYwCXMVSWYiaisbZ+LBXypsnkNvzZ5lujbqxoPzn5Il850
         W5Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWr8FOnIb+Z8FU/TE5L7vLhaxy7aQTZVTMMxDaVXn93wTmujFnhARDptmAr/Wy1YSOmBmcAgZUOAU/xTnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVwWJNObEELtN9VMtqHJmPkNGjqpBFjBvLOQL2RGSz0MBfb4Ys
	E9V/m3nd+/IFOJfCcoIF6EXk5meMA0Ejn6OLfY0A6OA6i0XxlJvdoHwoA5/nGfDK+KM=
X-Gm-Gg: ASbGnctwQ8TovvLfvHDSdKlMwTAYc8DQ/Plf2CmBDOooRQPrPKR9dB1K5h5IVsYck+Y
	AsBzyN7pZvdqQfjqpPhvHQGpL4/yfgMCpq+VZCBHmQzvbgXAKvwWmPuWQfoOQVGfvBQM1/rDiyX
	ome+pu1aLiuhSTAFXsTE7FNcrkRtecqABJxxVYAHthbJsw7QJ/o2ykVRAJOL5dk5B+id2ZhNdSp
	riJFX+GYe51FyNvFOWwpkfvYZXTUN3paQh3UqtPy8SBv4hTjq5MDsTrHHgUh3Djk4etLaKR+47u
	YhY8Mnr9YxX9d49q72tKdVh0ySrMh6+gdYF4nZ6Zq+1KxO5aPIosmyU+F4fi9nQVG6a5Ot2XYtv
	LmrVGV+reEk6W1aLUShzj0aTiBQo2o7zbsBgfxbyiwjSVkC1Ovf27gKZu8JjUI5WRNVwBfmVltj
	cyd0XkebCfN9/PdSQTZiyjvXOjD/1z3XvI0asutQ==
X-Google-Smtp-Source: AGHT+IFkEE4UDmmRrIx59Og0BV5rIttUH98hXp8gThHGY47mG53iV90+MszFRauDaM04dctxkf46hw==
X-Received: by 2002:a05:600c:3105:b0:477:63db:c718 with SMTP id 5b1f17b1804b1-4776bc93508mr24815935e9.16.1762526543053;
        Fri, 07 Nov 2025 06:42:23 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bd087b1sm61344375e9.16.2025.11.07.06.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 06:42:22 -0800 (PST)
Message-ID: <c4a10ad7-22c0-412c-a456-d2dd0f049ac9@ursulin.net>
Date: Fri, 7 Nov 2025 14:42:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Don't crash kernel on wrong params
To: Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251107125508.235449-2-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251107125508.235449-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 07/11/2025 12:55, Philipp Stanner wrote:
> drm_sched_job_arm() just panics the kernel with BUG_ON() in case of an
> entity being NULL. While drm_sched_job_arm() crashing or not effectively
> arming jobs is certainly a huge issue that needs to be noticed,
> completely shooting down the kernel reduces the probability of reaching
> and debugging a system to 0.
> 
> Moreover, the checkpatch script by now strongly discourages all new uses
> of BUG_ON() for this reason.
> 
> Replace the BUG_ON() in drm_sched_job_arm() with a WARN_ON().
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 1d4f1b822e7b..3bf4ae0ca4bc 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -857,7 +857,7 @@ void drm_sched_job_arm(struct drm_sched_job *job)
>   	struct drm_gpu_scheduler *sched;
>   	struct drm_sched_entity *entity = job->entity;
>   
> -	BUG_ON(!entity);
> +	WARN_ON(!entity);
>   	drm_sched_entity_select_rq(entity);

void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
{
	struct dma_fence *fence;
	struct drm_gpu_scheduler *sched;
	struct drm_sched_rq *rq;

	/* single possible engine and already selected */
	if (!entity->sched_list)

Still the same end result.

I believe best practice is to simply not have BUG_ON's followed by null 
pointer dereferences since they add no value. Ie. it should just be 
removed and not replaced.

Regards,

Tvrtko

Regards,

Tvrtko

>   	sched = entity->rq->sched;
>   



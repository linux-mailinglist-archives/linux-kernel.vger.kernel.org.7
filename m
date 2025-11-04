Return-Path: <linux-kernel+bounces-885058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60762C31E1E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C5684EB27D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875902F6189;
	Tue,  4 Nov 2025 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b="tPXgAH7H";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="+l629BC5"
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843832417D1;
	Tue,  4 Nov 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.152.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270523; cv=none; b=RxFMfGRpRtZ/Ko2x6C93eoXVrH22uGxBis8sKVFOhoifUdmw0/fbkIXApQU0q2lC18s8LPinOR+SihxCNZM+pUQle5mQlHFe4UWhpHMEyRP8FkkbrEXlhcaciWhk7KclBgzWur5L653WoWlN7NUHH401miLfzph9Auvw4h4f1xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270523; c=relaxed/simple;
	bh=VQsdaI96kfBk6dZzM4JUwEi6gVbv4OgzS7VMxgEzTnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRFmZu/IrTnhBG8S2CIzWOf0LpZAmyCHjYBlDB9B1N+YIboFks74kH3UQL91RWG5HWTBKQbTLM/4qxcqhl4NDWC3rrqRMntcjCb4G5JSqmgd+yAlIFfAXSu3yCThE4Jd1Y57kppCeBbI0m5yWezJo8mIIH5w636jXdEapa+QM4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damsy.net; spf=pass smtp.mailfrom=damsy.net; dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b=tPXgAH7H; dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b=+l629BC5; arc=none smtp.client-ip=51.159.152.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damsy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damsy.net
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1762270497; bh=MbNx/MvAK/wGX2ybmVhbP3Y
	QZm+xkrHKZTepIIrvPhI=; b=tPXgAH7HNNI50D7uTR0Y+o/NL4RgLmMbqPqz+BLAstEqr6k1KQ
	IPBckrUHffBfMaGmixzHaiGvAjhq5yV6XRZVG3bOTN24MaPqqIa1NUid5t8RXMi5LjpySwBKZbS
	AxqKzUzLc8gnKJ2s64SEjFgNYJ7ytsgLm//GIFrbXTfjx+QX9PXMDXvnJGIqrYp3qQ4cemkhSPf
	GtA6c0yzAYVahGTqYS436fz1TR3XbbNwdpXnavhV9Ae07ioPMUmg7EnrebIG+Vlzw5T8Jba1E89
	ebuJ+RcjpgPCuDbehsBDIs+1zPH3I9N9JkvbYw1UcRe9J6VBdLAQ7IE2o2qmCjf2D7g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1762270497; bh=MbNx/MvAK/wGX2ybmVhbP3Y
	QZm+xkrHKZTepIIrvPhI=; b=+l629BC53Z8vWYkMXn+7VropGO4HiPqhEsh33T6MdDHO8DYUDb
	0sQ/yuVwsGErbqcRXkVg7ZQ9tMkYqvvib4Aw==;
Message-ID: <87f1343f-9baa-4b73-a570-6cc6707c4198@damsy.net>
Date: Tue, 4 Nov 2025 16:34:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/sched: Fix deadlock in
 drm_sched_entity_kill_jobs_cb
To: phasta@kernel.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20251104095358.15092-1-pierre-eric.pelloux-prayer@amd.com>
 <628cdf3a0c5b783c09fe2a40aca4a4a48c614e66.camel@mailbox.org>
 <c1da66b4-3b71-4d83-8e8e-56151030b691@damsy.net>
 <85e573fa81913b4afe274f27142f526062f184f4.camel@mailbox.org>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <85e573fa81913b4afe274f27142f526062f184f4.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/11/2025 à 16:30, Philipp Stanner a écrit :
> On Tue, 2025-11-04 at 16:24 +0100, Pierre-Eric Pelloux-Prayer wrote:
>>
>>
>> Le 04/11/2025 à 13:43, Philipp Stanner a écrit :
>>
>>>
>>> Some things I have unfortunately overlooked below.
>>>
>>>>
>>>> Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and fini")
>>>
>>> We should +Cc stable. It's a deadlock after all.
>>
>> OK.
>>
>>>
>>>> Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/13908
>>>> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/scheduler/sched_entity.c | 34 +++++++++++++-----------
>>>>    1 file changed, 19 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>>>> index c8e949f4a568..fe174a4857be 100644
>>>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>>>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>>>> @@ -173,26 +173,15 @@ int drm_sched_entity_error(struct drm_sched_entity *entity)
>>>>    }
>>>>    EXPORT_SYMBOL(drm_sched_entity_error);
>>>>    
>>>> +static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
>>>> +					  struct dma_fence_cb *cb);
>>>
>>> It's far better to move the function up instead. Can you do that?
>>
>> Since drm_sched_entity_kill_jobs_cb uses drm_sched_entity_kill_jobs and vice
>> versa, I'll have to forward declare one of the 2 functions anyway.
> 
> Ah, right.
> OK then.
> 
> I can push this and +Cc stable in the commit message if you want.
> 

Would be great, thanks!

Pierre-Eric



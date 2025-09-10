Return-Path: <linux-kernel+bounces-810580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 884BEB51CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB63564D06
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EBE32F76C;
	Wed, 10 Sep 2025 15:56:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DC932ED4C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519810; cv=none; b=RpbOpnYTA9jfvFZnS0FjOmqkFN6H3WQsYaDsKGKkYWUnnEkYRPdiONvUyGMjyn53vWaGKzHKEpCOo6QcrLI61AEzljl2TxWzI6Cn+IwOiA+OZpEC6R1Bs3LwsyaSRkzaTKUUH894TY5IgT6bB64VpqZJo8MYkxmfQwheeDU+Ozs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519810; c=relaxed/simple;
	bh=qm9Si9celcAuY66dwGfGzGsQfV8JFQy1l2SFv/E41VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LR7meXKHzXTJ1mQC5T9SJdl2cd3vpNPtUJudgbkyaTMttwM2IvNuF32jw4BcDfkZZrnt7o4v7CIVnKh1xPN06vF6WwwQxS1U1QvlD+EwCKCdrYOwoNfNCSq7fXT7ualvay6WxwWEAEeDoKZDFci8jo56za7IjMCSGYtUewlov2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E1AA16F2;
	Wed, 10 Sep 2025 08:56:39 -0700 (PDT)
Received: from [10.1.25.55] (e122027.cambridge.arm.com [10.1.25.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 744343F63F;
	Wed, 10 Sep 2025 08:56:45 -0700 (PDT)
Message-ID: <bba00626-f9aa-4525-8568-2616adac7563@arm.com>
Date: Wed, 10 Sep 2025 16:56:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/panfrost: Introduce JM contexts for manging
 job resources
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com, Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250904001054.147465-1-adrian.larumbe@collabora.com>
 <20250904001054.147465-3-adrian.larumbe@collabora.com>
 <99a903b8-4b51-408d-b620-4166a11e3ad1@arm.com>
 <20250910175213.542fdb4b@fedora>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250910175213.542fdb4b@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/09/2025 16:52, Boris Brezillon wrote:
> On Wed, 10 Sep 2025 16:42:32 +0100
> Steven Price <steven.price@arm.com> wrote:
> 
>>> +int panfrost_jm_ctx_create(struct drm_file *file,
>>> +			   struct drm_panfrost_jm_ctx_create *args)
>>> +{
>>> +	struct panfrost_file_priv *priv = file->driver_priv;
>>> +	struct panfrost_device *pfdev = priv->pfdev;
>>> +	enum drm_sched_priority sched_prio;
>>> +	struct panfrost_jm_ctx *jm_ctx;
>>> +
>>> +	int ret;
>>> +
>>> +	jm_ctx = kzalloc(sizeof(*jm_ctx), GFP_KERNEL);
>>> +	if (!jm_ctx)
>>> +		return -ENOMEM;
>>> +
>>> +	kref_init(&jm_ctx->refcnt);
>>> +
>>> +	/* Same priority for all JS within a single context */
>>> +	jm_ctx->config = JS_CONFIG_THREAD_PRI(args->priority);
>>> +
>>> +	ret = jm_ctx_prio_to_drm_sched_prio(file, args->priority, &sched_prio);
>>> +	if (ret)
>>> +		goto err_put_jm_ctx;
>>> +
>>> +	for (u32 i = 0; i < NUM_JOB_SLOTS - 1; i++) {
>>> +		struct drm_gpu_scheduler *sched = &pfdev->js->queue[i].sched;
>>> +		struct panfrost_js_ctx *js_ctx = &jm_ctx->slots[i];
>>> +
>>> +		ret = drm_sched_entity_init(&js_ctx->sched_entity, sched_prio,
>>> +					    &sched, 1, NULL);
>>> +		if (ret)
>>> +			goto err_put_jm_ctx;
>>> +
>>> +		js_ctx->enabled = true;
>>> +	}
>>> +
>>> +	ret = xa_alloc(&priv->jm_ctxs, &args->handle, jm_ctx,
>>> +		       XA_LIMIT(0, MAX_JM_CTX_PER_FILE), GFP_KERNEL);
>>> +	if (ret)
>>> +		goto err_put_jm_ctx;  
>>
>> On error here we just jump down and call panfrost_jm_ctx_put() which
>> will free jm_ctx but won't destroy any of the drm_sched_entities. There
>> seems to be something a bit off with the lifetime management here.
>>
>> Should panfrost_jm_ctx_release() be responsible for tearing down the
>> context, and panfrost_jm_ctx_destroy() be nothing more than dropping the
>> reference?
> 
> The idea was to kill/cancel any pending jobs as soon as userspace
> releases the context, like we were doing previously when the FD was
> closed. If we defer this ctx teardown to the release() function, we're
> basically waiting for all jobs to complete, which:
> 
> 1. doesn't encourage userspace to have proper control over the contexts
>    lifetime
> 2. might use GPU/mem resources to execute jobs no one cares about
>    anymore

Ah, good point - yes killing the jobs in panfrost_jm_ctx_destroy() makes
sense. But we still need to ensure the clean-up happens in the other
paths ;)

So panfrost_jm_ctx_destroy() should keep the killing jobs part, butthe
drm scheduler entity cleanup should be moved.

Thanks,
Steve



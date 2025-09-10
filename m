Return-Path: <linux-kernel+bounces-810570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D47EB51C8A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B041C86363
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAE4212FA0;
	Wed, 10 Sep 2025 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D75hVEwW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6093E32A817
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519556; cv=none; b=VvXPdMEBxRE8/sExV0oEE7w5KHoQ4RkN7gzSfW29WoVYWQzIgZShqQa55/7IRmnZ7jwIg4V0z1MvVuAS/k/EmNuM04F5uIgeVEkfq9vTfxmEfqVyy6SMKUTnIxMvBJ6i3IeXK/OJpF1RTdvdNxxFg5inFa2odv3nysuuehlWC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519556; c=relaxed/simple;
	bh=fWH8Nf4h9/OJX4+QIGjJv9ZWY9S5RuEQyk9/GAp4N0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gn2VBAGHeQMWCprxNz26nJnZS++vk5MzE9SgkoYXBlEfAdfPxXQ7RYcNrm8HeWnln/293vh9ZvHsSKPAjqxHUqa7UC/BvLEinNsPoOWzbxlvePF4FvSqBtzVYHq3I4QxiuoBxMpPoNLdw6L5V7wPrwMaBwW9ziXHzeU5HHjJHOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D75hVEwW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757519552;
	bh=fWH8Nf4h9/OJX4+QIGjJv9ZWY9S5RuEQyk9/GAp4N0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D75hVEwWNjjaQWUDh9nwfqU7y6DgSxtAg8MTNYv+vYBXuGchnV0VP1VFqZWWfj5m+
	 BtmbQe4OQPUiulpOZljvRD2hCwlVGSx+C07HLVY9JR6ePKbKDcxdwy4XplHYkIGH4p
	 +kQQ69ICnWHc6x47bSh5/+38YZBNoSRtIGMNIzyMKVoGZ05Q4bnHMQW57TeErmEmVh
	 hnbo5A+Q7V1QZyQofOMloHvitObzGDTCVKfHZIikzhILdMtQH2O3359oXzWFN+3Oew
	 dMm3ShandhEd4Ky1fNZY8+WGKVGlWLZNsoagbih7qui8g+OdCoItLSF2U6Pq0P1R5S
	 540uNiD73kelw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E132517E0100;
	Wed, 10 Sep 2025 17:52:31 +0200 (CEST)
Date: Wed, 10 Sep 2025 17:52:13 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com, Rob Herring <robh@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v2 2/4] drm/panfrost: Introduce JM contexts for manging
 job resources
Message-ID: <20250910175213.542fdb4b@fedora>
In-Reply-To: <99a903b8-4b51-408d-b620-4166a11e3ad1@arm.com>
References: <20250904001054.147465-1-adrian.larumbe@collabora.com>
	<20250904001054.147465-3-adrian.larumbe@collabora.com>
	<99a903b8-4b51-408d-b620-4166a11e3ad1@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 16:42:32 +0100
Steven Price <steven.price@arm.com> wrote:

> > +int panfrost_jm_ctx_create(struct drm_file *file,
> > +			   struct drm_panfrost_jm_ctx_create *args)
> > +{
> > +	struct panfrost_file_priv *priv = file->driver_priv;
> > +	struct panfrost_device *pfdev = priv->pfdev;
> > +	enum drm_sched_priority sched_prio;
> > +	struct panfrost_jm_ctx *jm_ctx;
> > +
> > +	int ret;
> > +
> > +	jm_ctx = kzalloc(sizeof(*jm_ctx), GFP_KERNEL);
> > +	if (!jm_ctx)
> > +		return -ENOMEM;
> > +
> > +	kref_init(&jm_ctx->refcnt);
> > +
> > +	/* Same priority for all JS within a single context */
> > +	jm_ctx->config = JS_CONFIG_THREAD_PRI(args->priority);
> > +
> > +	ret = jm_ctx_prio_to_drm_sched_prio(file, args->priority, &sched_prio);
> > +	if (ret)
> > +		goto err_put_jm_ctx;
> > +
> > +	for (u32 i = 0; i < NUM_JOB_SLOTS - 1; i++) {
> > +		struct drm_gpu_scheduler *sched = &pfdev->js->queue[i].sched;
> > +		struct panfrost_js_ctx *js_ctx = &jm_ctx->slots[i];
> > +
> > +		ret = drm_sched_entity_init(&js_ctx->sched_entity, sched_prio,
> > +					    &sched, 1, NULL);
> > +		if (ret)
> > +			goto err_put_jm_ctx;
> > +
> > +		js_ctx->enabled = true;
> > +	}
> > +
> > +	ret = xa_alloc(&priv->jm_ctxs, &args->handle, jm_ctx,
> > +		       XA_LIMIT(0, MAX_JM_CTX_PER_FILE), GFP_KERNEL);
> > +	if (ret)
> > +		goto err_put_jm_ctx;  
> 
> On error here we just jump down and call panfrost_jm_ctx_put() which
> will free jm_ctx but won't destroy any of the drm_sched_entities. There
> seems to be something a bit off with the lifetime management here.
> 
> Should panfrost_jm_ctx_release() be responsible for tearing down the
> context, and panfrost_jm_ctx_destroy() be nothing more than dropping the
> reference?

The idea was to kill/cancel any pending jobs as soon as userspace
releases the context, like we were doing previously when the FD was
closed. If we defer this ctx teardown to the release() function, we're
basically waiting for all jobs to complete, which:

1. doesn't encourage userspace to have proper control over the contexts
   lifetime
2. might use GPU/mem resources to execute jobs no one cares about
   anymore


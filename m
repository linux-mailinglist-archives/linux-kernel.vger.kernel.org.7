Return-Path: <linux-kernel+bounces-810716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C1DB51E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274DC4856C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2E42797A9;
	Wed, 10 Sep 2025 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nhQ5QB2E"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A74275B13
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523076; cv=none; b=S5cma9RuqyhJwOxrCQK3bcflXs/bV7eY+Q/ZiO4nfR+TsKHkxjwv4RXryY0EON0I7KbHEtaO9Qc+ZhT4FqcLYvVqVO83XyhIj400E7CoCDYvHuCD3HGdC1MemtCprj+IapGZRRBVyFb7ZHAu4Wcvr1XGiHRxWQu1KgeQRQgcYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523076; c=relaxed/simple;
	bh=AQuSnTFtiBcvQbpVYtLScSW7IJnGMvcaBBvvEK2376A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u71wiWKYtL/5EVzfCEh1MTcIcVXg1iX9VlilF7Mxz9938FB0dxMgNSqry06YAc7wDipkv1e7TKGNTmN2UF4kXvKu9+E/BkcKktmcHyQ0vbus2OHXqvcghkOpdgx36MyHI1zE11o8mRnR7pq7uWLnkTy4F55y3LrhDl9T0cPgt3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nhQ5QB2E; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757523072;
	bh=AQuSnTFtiBcvQbpVYtLScSW7IJnGMvcaBBvvEK2376A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nhQ5QB2EbDea4quQEQnw9ezw+162iHQ61nDjsNVmCZN+Puo1emnOspIPBQLBui5E3
	 2C00144onpbW48ISVzppJZ5dANhlwZuczecrW6XVBIzlO9jPpSiseSdHKemidVYiDA
	 RvgL2yiNnW0+3vvBlXQxU/HuqL/kUe6wdfm7LBja0PBPl5HigNh7uPDMv0FsYtXubB
	 g8gRhlYesvknQrBDtIkndp4dImMKs4a3OL2zscFb1plh598ndGhwiDVBQuKNJIBbPX
	 DNMSalfbNKgr9ca8CzoF0XIHwdMvsZ54CnF9UzbL6t9Ic0XviJYSiDi3f6v94N/Gru
	 uKnIRCjYIeOuw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DF16917E0202;
	Wed, 10 Sep 2025 18:51:11 +0200 (CEST)
Date: Wed, 10 Sep 2025 18:50:58 +0200
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
Message-ID: <20250910185058.5239ada4@fedora>
In-Reply-To: <bba00626-f9aa-4525-8568-2616adac7563@arm.com>
References: <20250904001054.147465-1-adrian.larumbe@collabora.com>
	<20250904001054.147465-3-adrian.larumbe@collabora.com>
	<99a903b8-4b51-408d-b620-4166a11e3ad1@arm.com>
	<20250910175213.542fdb4b@fedora>
	<bba00626-f9aa-4525-8568-2616adac7563@arm.com>
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

On Wed, 10 Sep 2025 16:56:43 +0100
Steven Price <steven.price@arm.com> wrote:

> On 10/09/2025 16:52, Boris Brezillon wrote:
> > On Wed, 10 Sep 2025 16:42:32 +0100
> > Steven Price <steven.price@arm.com> wrote:
> >   
> >>> +int panfrost_jm_ctx_create(struct drm_file *file,
> >>> +			   struct drm_panfrost_jm_ctx_create *args)
> >>> +{
> >>> +	struct panfrost_file_priv *priv = file->driver_priv;
> >>> +	struct panfrost_device *pfdev = priv->pfdev;
> >>> +	enum drm_sched_priority sched_prio;
> >>> +	struct panfrost_jm_ctx *jm_ctx;
> >>> +
> >>> +	int ret;
> >>> +
> >>> +	jm_ctx = kzalloc(sizeof(*jm_ctx), GFP_KERNEL);
> >>> +	if (!jm_ctx)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	kref_init(&jm_ctx->refcnt);
> >>> +
> >>> +	/* Same priority for all JS within a single context */
> >>> +	jm_ctx->config = JS_CONFIG_THREAD_PRI(args->priority);
> >>> +
> >>> +	ret = jm_ctx_prio_to_drm_sched_prio(file, args->priority, &sched_prio);
> >>> +	if (ret)
> >>> +		goto err_put_jm_ctx;
> >>> +
> >>> +	for (u32 i = 0; i < NUM_JOB_SLOTS - 1; i++) {
> >>> +		struct drm_gpu_scheduler *sched = &pfdev->js->queue[i].sched;
> >>> +		struct panfrost_js_ctx *js_ctx = &jm_ctx->slots[i];
> >>> +
> >>> +		ret = drm_sched_entity_init(&js_ctx->sched_entity, sched_prio,
> >>> +					    &sched, 1, NULL);
> >>> +		if (ret)
> >>> +			goto err_put_jm_ctx;
> >>> +
> >>> +		js_ctx->enabled = true;
> >>> +	}
> >>> +
> >>> +	ret = xa_alloc(&priv->jm_ctxs, &args->handle, jm_ctx,
> >>> +		       XA_LIMIT(0, MAX_JM_CTX_PER_FILE), GFP_KERNEL);
> >>> +	if (ret)
> >>> +		goto err_put_jm_ctx;    
> >>
> >> On error here we just jump down and call panfrost_jm_ctx_put() which
> >> will free jm_ctx but won't destroy any of the drm_sched_entities. There
> >> seems to be something a bit off with the lifetime management here.
> >>
> >> Should panfrost_jm_ctx_release() be responsible for tearing down the
> >> context, and panfrost_jm_ctx_destroy() be nothing more than dropping the
> >> reference?  
> > 
> > The idea was to kill/cancel any pending jobs as soon as userspace
> > releases the context, like we were doing previously when the FD was
> > closed. If we defer this ctx teardown to the release() function, we're
> > basically waiting for all jobs to complete, which:
> > 
> > 1. doesn't encourage userspace to have proper control over the contexts
> >    lifetime
> > 2. might use GPU/mem resources to execute jobs no one cares about
> >    anymore  
> 
> Ah, good point - yes killing the jobs in panfrost_jm_ctx_destroy() makes
> sense. But we still need to ensure the clean-up happens in the other
> paths ;)
> 
> So panfrost_jm_ctx_destroy() should keep the killing jobs part, butthe
> drm scheduler entity cleanup should be moved.

The thing is, we need to call drm_sched_entity_fini() if we want all
pending jobs that were not queued to the HW yet to be cancelled
(_fini() calls _flush() + _kill()). This has to happen before we cancel
the jobs at the JM level, otherwise drm_sched might pass us new jobs
while we're trying to get rid of the currently running ones. Once we've
done that, there's basically nothing left to defer, except the kfree().


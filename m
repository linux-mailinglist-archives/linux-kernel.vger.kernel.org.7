Return-Path: <linux-kernel+bounces-838828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF86DBB03B1
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356171C4496
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFDE2E1EFF;
	Wed,  1 Oct 2025 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jgOfs8kT"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA72E1EE0
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759319153; cv=none; b=b0l5Qdp4BGMDxWX2LrqJlxKCd4bnN2IKZrKynQLEmvzJphyk2OJG+qnnsC9bicdLDz532zG19gK3a2BjtTWyr8vsxhNgFghDX+UNitTzzZD94E204KgtQWjhyN14fcXhEIX6j+YbGA+TNs7aU09P26VygB7GWrLcK5axHBz7tPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759319153; c=relaxed/simple;
	bh=IW/TjE+6F4KXE3ZnE6nFsWMzV7JK07LvsZD+VuiRmuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnDuY17zYHRqZUFz2EkZmXh9MWgOhKHn27nt1q39hpAN9kSOA//GZz+M5Nc2jQjmMtUFlY3e/tkEuSUdlGKJtt4JvqPUKGIktAnz+E7ohw7xadZF+bajf2p7WSLHnz8vm9w6gzPdCKWnQrpAPrNM5Y4t8LeNRH91P1F7BiIIduo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jgOfs8kT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso4995365f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759319149; x=1759923949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VviCcFP3Jcgv6/FMyDDvQbhSqrw1FId3gqaJAc0zZRY=;
        b=jgOfs8kTgXQRY6LdnHd8MHlJ+dBrmePqdMrdf3H5m85jWEyNcaFdJ7TZQlJ2zurF+d
         vESTZ+QjFTAVURI7cCSjlxEhTkCe/3aHpvLgy/7hG3BrN+UKdDZIfHxAL8KsnPyGh79P
         DcM3O3k1woBkkYRXguLlk6PcBowwfOC1sb6eLiJlqQD1xSgMipgUQjPcykrOvKEzW2ak
         gO05U/+1IAKz9dpL5qoOD1t3PCpY4/5T+5Wf+EDuC8c9zHD+BHrlgQ1103v9sg0KCn2/
         vpgve4vsrBpyker+exx70O9l+D1Y9Km7h2lh6yz2uhgBF101ID0Me7Pz80Iz4U2GDy3s
         d1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759319149; x=1759923949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VviCcFP3Jcgv6/FMyDDvQbhSqrw1FId3gqaJAc0zZRY=;
        b=FdCNCgS+Gp5qTAV5Bryp+M2rki79JmvHQH5kZ8Jqc0rSuUsyX9WsKjOndCIQcq1na3
         JJvBZTS4BJhz3QLZqkCKNs+X0seOMe55P+ZoDcZf2NWAoD7pIgLIZTC3Gc2g2giPrL42
         pnlstFZdykePfpuprg5BGxFXd9RME4UJ8VfmRPuzsS8xdmfGIrbjq2O7Ck7Shx77S+sV
         THNkbNHjWzF+8+OOEQsMFCEDUJ7mccdsguFGV/XRwiwxjObgDJMdubxbXtDTs297F5rb
         pl4E9lO9gYoenbeNgSkgcMjwI5b2qHdjzAVg7R44/hjhFrm2WvX19z/rSqCcUOa9amYB
         qWnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIDHzQ194rDi6ZTiI/qwDTxmPrBMQcQ3SG3Z2nuKam0TFlZD70FqKsatiEtyuMCT1CJRkMFpFMsaa0DlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMu5JzgbS0RpNyse1s3zd0BgJJDFNtYzjCI9EW1BKR8z53pn2G
	HLUzCTY6OOXkrSEkOO7lGaf7h6sZi99YyYSWED90tnrDxQQzjP89kJhvmXWnLl2SuRefR2S+lzC
	Vy9q717/ppsd8423da785mjnWJQqdwLAIBLzCUhBB
X-Gm-Gg: ASbGncu79qXDhLczJ2YWBTDNVhpOtivtzOfJu2OnxLcP+iwRBrOTw6M79BjOGQ4HyP+
	MPCHb1PbweUS0C7nYD0+/CZHXpb2dLp1eiA+B3M60OdcGoLLY68fkNEq27a1tQSUjR9ak8CD3CN
	IQgsU4Sb+uJOdVbfosg0++rNvyWBNf2T7SjHQYjPUYbXU+F9iGde99xbFMLFK5cOENFsjXFKbe1
	gRERxW+oJShKtUebYXLsaDJsbyE5lHzNDa3ApAiORJbL6crV7Od8N4n3O3V6/0pc0bV
X-Google-Smtp-Source: AGHT+IH2YWNMKHFi6t5kKvcv1ZOzoaYRa805PT2+7dBFyjV52rsAx9pBNC4BGfFbOqvAMUG1FgAm/Wijr9S7daE4QzA=
X-Received: by 2002:a05:6000:186e:b0:3e9:b208:f2d2 with SMTP id
 ffacd0b85a97d-42557a15a22mr2477227f8f.50.1759319149319; Wed, 01 Oct 2025
 04:45:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001-vmbo-defer-v3-0-a3fe6b6ae185@google.com>
 <20251001-vmbo-defer-v3-1-a3fe6b6ae185@google.com> <20251001132739.41575fa5@fedora>
In-Reply-To: <20251001132739.41575fa5@fedora>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 1 Oct 2025 13:45:36 +0200
X-Gm-Features: AS18NWBngU-2nkqnXugLMYJ5aD04zIT_sFpqKVAk2neDLCbOKa2QWYVXO5xOGRA
Message-ID: <CAH5fLghp+4dx6-JAfbSWDLz7WOdwtnLeuxdGhmVPax+HKbTv3w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/gpuvm: add deferred vm_bo cleanup
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Price <steven.price@arm.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 1:27=E2=80=AFPM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Wed, 01 Oct 2025 10:41:36 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > When using GPUVM in immediate mode, it is necessary to call
> > drm_gpuvm_unlink() from the fence signalling critical path. However,
> > unlink may call drm_gpuvm_bo_put(), which causes some challenges:
> >
> > 1. drm_gpuvm_bo_put() often requires you to take resv locks, which you
> >    can't do from the fence signalling critical path.
> > 2. drm_gpuvm_bo_put() calls drm_gem_object_put(), which is often going
> >    to be unsafe to call from the fence signalling critical path.
> >
> > To solve these issues, add a deferred version of drm_gpuvm_unlink() tha=
t
> > adds the vm_bo to a deferred cleanup list, and then clean it up later.
> >
> > The new methods take the GEMs GPUVA lock internally rather than letting
> > the caller do it because it also needs to perform an operation after
> > releasing the mutex again. This is to prevent freeing the GEM while
> > holding the mutex (more info as comments in the patch). This means that
> > the new methods can only be used with DRM_GPUVM_IMMEDIATE_MODE.
> >
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>

> > +/*
> > + * Must be called with GEM mutex held. After releasing GEM mutex,
> > + * drm_gpuvm_bo_defer_free_unlocked() must be called.
> > + */
> > +static void
> > +drm_gpuvm_bo_defer_free_locked(struct kref *kref)
> > +{
> > +     struct drm_gpuvm_bo *vm_bo =3D container_of(kref, struct drm_gpuv=
m_bo,
> > +                                               kref);
> > +     struct drm_gpuvm *gpuvm =3D vm_bo->vm;
> > +
> > +     if (!drm_gpuvm_resv_protected(gpuvm)) {
> > +             drm_gpuvm_bo_list_del(vm_bo, extobj, true);
> > +             drm_gpuvm_bo_list_del(vm_bo, evict, true);
> > +     }
> > +
> > +     list_del(&vm_bo->list.entry.gem);
> > +}
> > +
> > +/*
> > + * GEM mutex must not be held. Called after drm_gpuvm_bo_defer_free_lo=
cked().
> > + */
> > +static void
> > +drm_gpuvm_bo_defer_free_unlocked(struct drm_gpuvm_bo *vm_bo)
> > +{
> > +     struct drm_gpuvm *gpuvm =3D vm_bo->vm;
> > +
> > +     llist_add(&vm_bo->list.entry.bo_defer, &gpuvm->bo_defer);
>
> Could we simply move this line to drm_gpuvm_bo_defer_free_locked()?
> I might be missing something, but I don't really see a reason to
> have it exposed as a separate operation.

No, if drm_gpuvm_bo_deferred_cleanup() is called in parallel (e.g.
from a workqueue as we discussed), then this can lead to kfreeing the
GEM while we hold the mutex. We must not add the vm_bo until it's safe
to kfree the GEM. See the comment on
drm_gpuvm_bo_defer_free_unlocked() below.

> > +}
> > +
> > +static void
> > +drm_gpuvm_bo_defer_free(struct kref *kref)
> > +{
> > +     struct drm_gpuvm_bo *vm_bo =3D container_of(kref, struct drm_gpuv=
m_bo,
> > +                                               kref);
> > +
> > +     mutex_lock(&vm_bo->obj->gpuva.lock);
> > +     drm_gpuvm_bo_defer_free_locked(kref);
> > +     mutex_unlock(&vm_bo->obj->gpuva.lock);
> > +
> > +     /*
> > +      * It's important that the GEM stays alive for the duration in wh=
ich we
> > +      * hold the mutex, but the instant we add the vm_bo to bo_defer,
> > +      * another thread might call drm_gpuvm_bo_deferred_cleanup() and =
put
> > +      * the GEM. Therefore, to avoid kfreeing a mutex we are holding, =
we add
> > +      * the vm_bo to bo_defer *after* releasing the GEM's mutex.
> > +      */
> > +     drm_gpuvm_bo_defer_free_unlocked(vm_bo);
> > +}

Alice


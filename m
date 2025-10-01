Return-Path: <linux-kernel+bounces-839073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD7DBB0C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71210162B4F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864C12641F9;
	Wed,  1 Oct 2025 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vz0NbeZJ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206721EDA3C
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329771; cv=none; b=koEMm1rqwJfQKcHBQ+1vOpeOGfGIMUEfYJvck60sfZJ8vBwT/6S33eJ2ON/yBBnAtB/KZK4cpwW7wvN8sHnXOy7zXUpG/vTby4Hk0gu2X7GBvm7w4qmA5d/eOU6sjgEGinvWws7FxFJL0P3krkKCg0nwvWVf/sNJLwYNOergWWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329771; c=relaxed/simple;
	bh=1zVY2VH32mAkasz4T4IEt9vNHSUIwS0Xq5zbeN2PUWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUkQuEeObmZMz1mEUXLsYOvB8412Y1jP2gWd3BDVR56dfwzspBKFuUiP979R1e6laKRU8gn1Ienw03kwTVxf7D29f+8ZdX0sXrixcUs8t4jGAW29JqjZ/rN5ksrbyf2i1AGXQyCke0SkrPt9lwjLYIXbVUfQ6qCSNzTQhyaMKYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vz0NbeZJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so50392895e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759329768; x=1759934568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ih1xYhPTI2Pg6at0k0iyDd7I8Muei6z7nZ9FDydSlKQ=;
        b=vz0NbeZJJ9gkdVYnvjDCXgOUGoHi2BD0K63B1Pi7GEpPg2uJ2SurYcbRokncJyK3gQ
         /Kf9GUiN/UrUUlTQJv65L9SfYAtvxQ03epxLUkN3ZONptLsSpP2klckBx/f6gorlw5rg
         wCY4ZNGYi0vbCoRn7FeUQNm8gMSER9SnU8DqSKtGI2L+kjG+32eC3WhyLsulpDgozKT6
         vVpYBuQ7q5Vlnl9LOtLhp7Oej8Ml6z+amlul/zkE0GZtMNo+sFjc7JDxeYatgregj96e
         8eoacXqS7tBudLBLKgCCL9WE0pf7AujAtoziuIcAoyWAKqHuA66zpb/QsO9yKadLdDvu
         J1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329768; x=1759934568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ih1xYhPTI2Pg6at0k0iyDd7I8Muei6z7nZ9FDydSlKQ=;
        b=GkQI4DrwlUvbkP1NnFvW7lfGqIjmbX+IV7gUMD3DoIKw01tLHHDG0Twn/AkolqRUjg
         wiTWPBp1SadsfU2U44Ze6uP17yRC+ZIHl6V7ZG9lwhFQBAk+Rs9a0lwsCwJsWcQ9RB/O
         z8FUs5JbzAm/9d3a3bttvuDzOcfYXx4ZGMjBbv/SLYWbJ7Dz0s1uctTmxMYMa/Rz0EzO
         /cak6BcJCX1uVEa7SWwynHN01nAr+XBZBuMcOG3VEnxt5O7vTjy1qeVJs10bIiBAoIFc
         cKvKy+/nK4QRZz6YMk8BUS78ZOtWiczEdyPdm0G9mXn7s4MQXKnLF3skLp4KpViPqgr8
         o08w==
X-Forwarded-Encrypted: i=1; AJvYcCU5AZUGIAbJmIhD+VClWSsf3smmR8UgWpaeJ0WPfNbswqJ0D2TT8vARgzxZlYJeIgNen7lOZ1H6Nt5TmkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDwXF310DOHRUL0aOWig8eklTSLjii/ggqsDsR94/xbqq+n2qg
	VfxD5yg+0PXRPfqIAfT2IkceD0/Ah878AIsGi6bvWIGBFjAIJOiJQaF+Us+aPQq9LB0x1caTH5x
	A4ttwYNck/aV7RY4hyXa8E7tcw53RkOm9+KPfLycj
X-Gm-Gg: ASbGnct/YffXtEVzmmrhBBjMp7OmkE+aoLPhpQeG4wF+H2/OXT9ShU8aag49WpJNFzR
	51hsyjDjOW4bxEJS1qm0cmZbAmGuNxnsQIiriNYr3jrjQ3SyH9kecV1MlE8pkHKEy03C3G0k9aG
	OSX1TKpNSPaqfgrqR94yZDKYH7lns5j3LfFTr5sJRVPiueVwAMQP2IDA9Ghl4tXtDKQs26SVg6b
	tdyrMNOdSftBKWgf4f618josbq0SMcmgE+T/KZk8HgOmuVVbICLjQ9o70Bz/GcuDPgM
X-Google-Smtp-Source: AGHT+IFUatLRxEXoWcw45KNVyfTjY6RcLlKmngKD+BI81xp+UKlY7uKof8qt5rhJEU/RR1lFFD2b41VrMEa9vHmBj9o=
X-Received: by 2002:a05:600c:8b47:b0:45b:6b57:5308 with SMTP id
 5b1f17b1804b1-46e6126a7d4mr31044865e9.7.1759329768313; Wed, 01 Oct 2025
 07:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001-vmbo-defer-v3-0-a3fe6b6ae185@google.com>
 <20251001-vmbo-defer-v3-1-a3fe6b6ae185@google.com> <DD71GUKZKFPR.2OVPQ9KOI89YG@kernel.org>
In-Reply-To: <DD71GUKZKFPR.2OVPQ9KOI89YG@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 1 Oct 2025 16:42:35 +0200
X-Gm-Features: AS18NWCjBqGngM1fu15A6vZD0jZY9gu397gehPk2hk9lVzatXAXUNzz0NaO8hPs
Message-ID: <CAH5fLghM_fmaHn561_e7StHAwdV=8gPxAwUToDxPQiBY8E+aVA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/gpuvm: add deferred vm_bo cleanup
To: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 4:01=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Wed Oct 1, 2025 at 12:41 PM CEST, Alice Ryhl wrote:
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
>
> So, you're splitting drm_gpuvm_bo_defer_free() into two functions, one do=
ing the
> work that is required to be called with the gpuva lock held and one that =
does
> the work that does not require a lock, which makes perfect sense.
>
> However, the naming chosen for the two functions, i.e.
> drm_gpuvm_bo_defer_free_unlocked() and drm_gpuvm_bo_defer_free_locked() i=
s
> confusing:
>
> What you mean semantically mean is "do part 1 with lock held" and "do par=
t 2
> without lock held", but the the chosen names suggest that both functions =
are
> identical, with the only difference that one takes the lock internally an=
d the
> other one requires the caller to take the lock.
>
> It's probably better to name them after what they do and not what they're=
 part
> of. If you prefer the latter, that's fine with me too, but please choose =
a name
> that makes this circumstance obvious.

Fair point. Do you have naming suggestions? Otherwise I can name them
drm_gpuvm_bo_defer_free_part1() and drm_gpuvm_bo_defer_free_part2().
:)

Alice


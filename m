Return-Path: <linux-kernel+bounces-803541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5AFB46226
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D8717FBD2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7994426B764;
	Fri,  5 Sep 2025 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8PTKlzC"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E1526F2B4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096297; cv=none; b=VdjrHo4NwMAIrXOPh55d2sIBxEGBm5CAu88TKNkS6HZ8mjTVGHXCuiVjjSoJ6BZ0NX+uH7cYN8FvxRCZpm9nu1w+WmTPiBbanSIH/Uu8coBsg8yHDROuTXTrtv2JT+74KQKN/W9rkOKKkA40cPqlg2EKlmu8U+95lv1BGm1i3/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096297; c=relaxed/simple;
	bh=kfh9Tls71Sbv6ikFPTwH56l633KM95jBXY4vKsbQjnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/Uh1Nh2wIIC3wPrjTy/wULXoDGX3rDwBF32dYsVqIKAUuPY2yjFbyk/i1gwqLg2pQkJLv9LCHk09LtIX1Xp9lBXeyWfTZYaZ6jel8hiv0XITmoiznGYtA3rYzOLkhLDFnf31+Eku9Nd1ZxGIs21GW5hjEUaa/WIJwCxP5B1uRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W8PTKlzC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e4b5aee522so442365f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 11:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757096294; x=1757701094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKjPZ6JkdfP71MZhHGFNz5JoCmbYAum19kr8H2dtmZc=;
        b=W8PTKlzChHgOivPJmKRIiQPJC560Aa16ygx1EcYxD31cDVGCRcaRtBNrMENHi4q4pC
         nM9+o0iIFNaRcsw8Yu0sXnzhBktPBL0neU/ynJXsE0apjc0jDjanzKB0lpMkGs91Ru/c
         El3NW/pfk3Xp4cMrtZSKWWBlTrVLUSrvROoAw9eJBWs5trEt/LZQqQxO+3UsmbrfYLsp
         L+gTXslrGmkDwaFTzvSt7gNpKopf04d1ViHmbCUhmiqm4IgU+Us8eD7KL/A+YE70jrJ2
         9TUC+Hd5BiR1FBsGhF4rc2Qs3okIisRPZQxruAcCj2oxUFJ+ldJ0fLtVxh8jJTxPnFmA
         G/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757096294; x=1757701094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKjPZ6JkdfP71MZhHGFNz5JoCmbYAum19kr8H2dtmZc=;
        b=LfpLcyt+A1Y7DfeRFsQuXDBQCK9wPMVxFx4HbG/YdVJfm0IugYuZeMo5qjY+Wxc1+5
         0m6c3lQhFfV1uJ7JQFcSlkjfcRVqGsMHQ25/qNjHTbv2syVfiJgrZjUtJ3PKgNDkGjKj
         wSqPOAIR4pHnptYIzFRVqMYBTTEzQFA5KxXX2yZt4XmeEJ6+3ZS3Odf3bwp69De/Yght
         HUmCULl7KcqMBLDqQVrbWr8kCv2E2DbdesIWIzffOMoJiSuu5N5EHoaOVN3nk6RIrJxP
         bfjEFUIdjOQWH5f4xwD7+Rwc/+Pw2LnhvLZhOeZa6m5hrJbydEurL2P3Sa3M35/FK7ln
         SOWw==
X-Forwarded-Encrypted: i=1; AJvYcCWOOq69FZPidHWjRgL8Nha7q08TyU/DXiz2nL/ybPy5wEJZrGasBn9xS5XJEMWfyrdLLCvknfZlNj3zcYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyotGe9eX33DROrZDuAgPdmG8/DVcbcOXMLxBMwUJM9TTIbrAsE
	wdGDWPAbdM5KAJXvtTufkX91P5T4XC3UXsKwm779w1J47M6o2pAxkQi3Bf6Cd84V5Udi5DqRtGp
	xTIvg8Il9H3PQlUdkrWYwFSqzyVbOOFEl+qmD8ZOj
X-Gm-Gg: ASbGnctY7fNKHmIaileDuXFfzYx2So0ztxoNpde0ghx7pSFjd5tjV6QR1JnWvS0G3J8
	fJIAx9ql0NPC5R1vOOrHgOo35AzfgMTUPm7okWzjEIg6pTREtNML65IJq9jxqdfxRkIpwY0HSZO
	oMDxabEeHbmDfyt9Wkifh4u2Y4Th3cc53wNsxIb6kzGolOXuKYYksuzm9K6dqh2tNAb/MHyyG30
	pvw/n8EQUG41hnCE2HbnyPHlqenOKkBHrr3YjuGOLpBDVo=
X-Google-Smtp-Source: AGHT+IGlP6GVE/F3IvfvuFg3uqTuhZ7o1EtABAfnyD/mfTCM2CfW3Q+roVGtifPt0cXvnI1cRztA8nHmMv3mEeiacoo=
X-Received: by 2002:a5d:64e3:0:b0:3e0:c28a:abbb with SMTP id
 ffacd0b85a97d-3e0c28aaf62mr6872387f8f.13.1757096293550; Fri, 05 Sep 2025
 11:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905-vmbo-defer-v1-0-7ae1a382b674@google.com>
 <20250905-vmbo-defer-v1-1-7ae1a382b674@google.com> <20250905152505.005a610d@fedora>
In-Reply-To: <20250905152505.005a610d@fedora>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 5 Sep 2025 20:18:01 +0200
X-Gm-Features: Ac12FXzdSoY4H14Jq3bYOy1msq82Tum3a_ciUTVq2KqVGeVzVChh5DdTZhsb_aI
Message-ID: <CAH5fLghgqv0mNYf8r-rdeBaCGxYsdkBouqgo_ohx3DYHwpcZRQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/gpuvm: add deferred vm_bo cleanup
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

On Fri, Sep 5, 2025 at 3:25=E2=80=AFPM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Fri, 05 Sep 2025 12:11:28 +0000
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
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  drivers/gpu/drm/drm_gpuvm.c | 167 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  include/drm/drm_gpuvm.h     |  26 +++++++
> >  2 files changed, 193 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> > index 78a1a4f095095e9379bdf604d583f6c8b9863ccb..849b6c08f83dcba832eda37=
2bd3ce62b540e144b 100644
> > --- a/drivers/gpu/drm/drm_gpuvm.c
> > +++ b/drivers/gpu/drm/drm_gpuvm.c
> > @@ -876,6 +876,25 @@ __drm_gpuvm_bo_list_add(struct drm_gpuvm *gpuvm, s=
pinlock_t *lock,
> >       cond_spin_unlock(lock, !!lock);
> >  }
> >
> > +/**
> > + * drm_gpuvm_bo_is_dead() - check whether this vm_bo is scheduled for =
cleanup
> > + * @vm_bo: the &drm_gpuvm_bo
> > + *
> > + * When a vm_bo is scheduled for cleanup using the bo_defer list, it i=
s not
> > + * immediately removed from the evict and extobj lists.
>
> Maybe mention that it can't be, because those lists are protected with
> the resv lock and we can't take this lock when we're in immediate mode?

Ok.

> > Therefore, anyone
> > + * iterating these lists should skip entries that are being destroyed.
> > + *
> > + * Checking the refcount without incrementing it is okay as long as th=
e lock
> > + * protecting the evict/extobj list is held for as long as you are usi=
ng the
> > + * vm_bo, because even if the refcount hits zero while you are using i=
t, freeing
> > + * the vm_bo requires taking the list's lock.
> > + */
> > +static bool
> > +drm_gpuvm_bo_is_dead(struct drm_gpuvm_bo *vm_bo)
> > +{
> > +     return !kref_read(&vm_bo->kref);
>
> I'm not too sure I like the idea of [ab]using vm_bo::kref to defer the
> vm_bo release. I get why it's done like that, but I'm wondering why we
> don't defer the release of drm_gpuva objects instead (which is really
> what's being released in va_unlink()). I can imagine drivers wanting to
> attach resources to the gpuva that can't be released in the
> dma-signalling path in the future, and if we're doing that at the gpuva
> level, we also get rid of this kref dance, since the va will hold a
> vm_bo ref until it's destroyed.
>
> Any particular reason you went for vm_bo destruction deferral instead
> of gpuva?

All of the things that were unsafe to release in the signalling path
were tied to the vm_bo, so that is why I went for vm_bo cleanup.
Another advantage is that it lets us use the same deferred logic for
the vm_bo_put() call that drops the refcount from vm_bo_obtain().

Of course if gpuvas might have resources that need deferred cleanup,
that might change the situation somewhat.


> > +}
> > +
> >  /**
> >   * drm_gpuvm_bo_list_add() - insert a vm_bo into the given list
> >   * @__vm_bo: the &drm_gpuvm_bo
> > @@ -1081,6 +1100,9 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const cha=
r *name,
> >       INIT_LIST_HEAD(&gpuvm->evict.list);
> >       spin_lock_init(&gpuvm->evict.lock);
> >
> > +     INIT_LIST_HEAD(&gpuvm->bo_defer.list);
> > +     spin_lock_init(&gpuvm->bo_defer.lock);
> > +
> >       kref_init(&gpuvm->kref);
> >
> >       gpuvm->name =3D name ? name : "unknown";
> > @@ -1122,6 +1144,8 @@ drm_gpuvm_fini(struct drm_gpuvm *gpuvm)
> >                "Extobj list should be empty.\n");
> >       drm_WARN(gpuvm->drm, !list_empty(&gpuvm->evict.list),
> >                "Evict list should be empty.\n");
> > +     drm_WARN(gpuvm->drm, !list_empty(&gpuvm->bo_defer.list),
> > +              "VM BO cleanup list should be empty.\n");
> >
> >       drm_gem_object_put(gpuvm->r_obj);
> >  }
> > @@ -1217,6 +1241,9 @@ drm_gpuvm_prepare_objects_locked(struct drm_gpuvm=
 *gpuvm,
> >
> >       drm_gpuvm_resv_assert_held(gpuvm);
> >       list_for_each_entry(vm_bo, &gpuvm->extobj.list, list.entry.extobj=
) {
> > +             if (drm_gpuvm_bo_is_dead(vm_bo))
> > +                     continue;
> > +
> >               ret =3D exec_prepare_obj(exec, vm_bo->obj, num_fences);
> >               if (ret)
> >                       break;
> > @@ -1460,6 +1487,9 @@ drm_gpuvm_validate_locked(struct drm_gpuvm *gpuvm=
, struct drm_exec *exec)
> >
> >       list_for_each_entry_safe(vm_bo, next, &gpuvm->evict.list,
> >                                list.entry.evict) {
> > +             if (drm_gpuvm_bo_is_dead(vm_bo))
> > +                     continue;
> > +
> >               ret =3D ops->vm_bo_validate(vm_bo, exec);
> >               if (ret)
> >                       break;
> > @@ -1560,6 +1590,7 @@ drm_gpuvm_bo_create(struct drm_gpuvm *gpuvm,
> >
> >       INIT_LIST_HEAD(&vm_bo->list.entry.extobj);
> >       INIT_LIST_HEAD(&vm_bo->list.entry.evict);
> > +     INIT_LIST_HEAD(&vm_bo->list.entry.bo_defer);
> >
> >       return vm_bo;
> >  }
> > @@ -1621,6 +1652,106 @@ drm_gpuvm_bo_put(struct drm_gpuvm_bo *vm_bo)
> >  }
> >  EXPORT_SYMBOL_GPL(drm_gpuvm_bo_put);
> >
> > +static void
> > +drm_gpuvm_bo_defer_locked(struct kref *kref)
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
> > +     mutex_unlock(&vm_bo->obj->gpuva.lock);
>
> I got tricked by this implicit unlock, and the conditional unlocks it
> creates in drm_gpuva_unlink_defer(). Honestly, I'd rather see this
> unlocked moved to drm_gpuva_unlink_defer() and a conditional unlock
> added to drm_gpuvm_bo_put_deferred(), because it's easier to reason
> about when the lock/unlock calls are in the same function
> (kref_put_mutex() being the equivalent of a conditional lock).

Ok. I followed the docs of kref_put_mutex() that say to unlock it from
the function.

Alice


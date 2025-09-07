Return-Path: <linux-kernel+bounces-804631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91972B47ABD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 13:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E937A5DFE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD82225F98B;
	Sun,  7 Sep 2025 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IDO0I+Oa"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A758BEC
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757243724; cv=none; b=sVckqwdWNEx013MUnseuGiOaEGflusbpalrGNYc3C/9+B+/VwdEx9jkcWE3bKsuY+ouNSCyIoMAaA5tAup9S9Vg7CGcI1uUM2Y1S/BD71vgQGZ3Ofg79n8+BYWfmhL4CbpMGMfm10GwvDDODMmL/olPhf7boakkn3nhL3Pp0keo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757243724; c=relaxed/simple;
	bh=MKYUopQS7eKHksfsQosxZG+bhhpOJOJJX5o+HxyaNY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MLApyzr5xsJ+g8xki6aj2ionCxplk/tWM8JmeRkNhsHlt+zXmSbh1rISRx8COpMJjR34XYvUhXZiNBdOF/mdd2t5IS69xTcdoTaCzo/v5rbOHhif7O5NN4yb8LI9hLpf8K6cmziu4Plp/zkdMSLc9z0MNNGRbBwdrDdDQi9d/bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IDO0I+Oa; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3e50783dda8so806578f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 04:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757243721; x=1757848521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYE7Mdh99/9rzNVteX8mWuWywSt6JxH5pN7ISK0g0K0=;
        b=IDO0I+OaK7Yur7haaH7eANJE5lZd5YDWNjWjQBckNw3Qofzxa2RCCinYX0i4fWZ6eR
         WHUybZlPbLeMAC+TrY7pKOBwHNe8rtfSCioEy72KJWeDH3ItytbgfxFMVokZsXaD6CxY
         y6JMJWvLjQHZeQDb9Njx0S5F0kW7p2+ukSMICtNWRZOFOp/iRHpAL0dLetY5E3nhvW6U
         rFjtWRTLPhIVqjZD3Kw7op75f5Ewy2ea4BMFkMbGSp8y3kpL4unbjPJBC4DYvjp4lkJO
         A6/Bvur1ameNccd2xVGeMi8m1yJOIYPENlZ7fQJPwL19bZC6wzox1UZD2+4VJojMQTvd
         vElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757243721; x=1757848521;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qYE7Mdh99/9rzNVteX8mWuWywSt6JxH5pN7ISK0g0K0=;
        b=M0Rf+zkObRzElQ1RU0E0+kdEN5pzCz1LklH+g5U4y4EwTq0iJW8IHwJw6rNE8k5j+j
         CpVlezBAvyu5CWDkM+IlcIcFBSpVP+0XOq5vdZhCjTYfH4EOsYMOJ3BKyM1GDdS4J1aa
         lvNSnY/7/x39N1nP4CSr8xTRaSF5P0OA+Qcn/Cc3HlHSndv1iWJub9lWFhK9G4TEhvmS
         ZQu3HYzZn+fjofk9g1qFYH/WyNqlnwFYl/AeMtcpl0EIMJk7lHZOJDcdvNATzjZTCiHq
         54ISeN51lfH/3yxEb60z3NajmPTWknPuc9nlkj+OckPU9t2vdhE/JHbaL/yTpQyYvipu
         vWyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6Mwu6US1Yk5kNs8dR11MnotZ3yoNWDLUada196ftCu6OgyyGFhZyETYeqbCaJWUeoTIHyo4Dooe0XApc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn0FyxXGX0YGFUob8xghpV/SVkrKJTLAtDokalUKXn1ACCrVVp
	4c5KXHPVtiiBDWHOUpr7P0OGJsRmU+B3oOXQAG94LItCF/PshTqleSpY1xGDcrwIvhpADXXKC4p
	LXeIoY5QmsWaLNL6lOg==
X-Google-Smtp-Source: AGHT+IHuEDNEPXu7Dy3DfM2a1VFFRo/E10YKm/lyBx1r925AHGa8w+aVHbPsl0A4UzCnXWHx+qBEECQh0lFq/dc=
X-Received: from wmc24.prod.google.com ([2002:a05:600c:6018:b0:45b:79d1:abcb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f92:0:b0:3d7:2284:b20 with SMTP id ffacd0b85a97d-3e641e3cd77mr2638780f8f.3.1757243721320;
 Sun, 07 Sep 2025 04:15:21 -0700 (PDT)
Date: Sun, 7 Sep 2025 11:15:20 +0000
In-Reply-To: <DCL8DQV23FIZ.KJ74UQ9YOFZV@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905-vmbo-defer-v1-0-7ae1a382b674@google.com>
 <20250905-vmbo-defer-v1-1-7ae1a382b674@google.com> <20250905152505.005a610d@fedora>
 <CAH5fLghgqv0mNYf8r-rdeBaCGxYsdkBouqgo_ohx3DYHwpcZRQ@mail.gmail.com> <DCL8DQV23FIZ.KJ74UQ9YOFZV@kernel.org>
Message-ID: <aL1pSFB9iBsfHFM_@google.com>
Subject: Re: [PATCH 1/2] drm/gpuvm: add deferred vm_bo cleanup
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Matthew Brost <matthew.brost@intel.com>, 
	"Thomas =?utf-8?Q?Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Price <steven.price@arm.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 06, 2025 at 12:47:36AM +0200, Danilo Krummrich wrote:
> On Fri Sep 5, 2025 at 8:18 PM CEST, Alice Ryhl wrote:
> > On Fri, Sep 5, 2025 at 3:25=E2=80=AFPM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:
> >> On Fri, 05 Sep 2025 12:11:28 +0000
> >> Alice Ryhl <aliceryhl@google.com> wrote:
> >> > +static bool
> >> > +drm_gpuvm_bo_is_dead(struct drm_gpuvm_bo *vm_bo)
> >> > +{
> >> > +     return !kref_read(&vm_bo->kref);
> >>
> >> I'm not too sure I like the idea of [ab]using vm_bo::kref to defer the
> >> vm_bo release. I get why it's done like that, but I'm wondering why we
> >> don't defer the release of drm_gpuva objects instead (which is really
> >> what's being released in va_unlink()). I can imagine drivers wanting t=
o
> >> attach resources to the gpuva that can't be released in the
> >> dma-signalling path in the future, and if we're doing that at the gpuv=
a
> >> level, we also get rid of this kref dance, since the va will hold a
> >> vm_bo ref until it's destroyed.
> >>
> >> Any particular reason you went for vm_bo destruction deferral instead
> >> of gpuva?
> >
> > All of the things that were unsafe to release in the signalling path
> > were tied to the vm_bo, so that is why I went for vm_bo cleanup.
> > Another advantage is that it lets us use the same deferred logic for
> > the vm_bo_put() call that drops the refcount from vm_bo_obtain().
> >
> > Of course if gpuvas might have resources that need deferred cleanup,
> > that might change the situation somewhat.
>=20
> I think we want to track PT(E) allocations, or rather reference counts of=
 page
> table structures carried by the drm_gpuva, but we don't need to release t=
hem on
> drm_gpuva_unlink(), which is where we drop the reference count of the vm_=
bo.
>=20
> Deferring drm_gpuva_unlink() isn't really an option I think, the GEMs lis=
t of
> VM_BOs and the VM_BOs list of VAs is usually used in ttm_device_funcs::mo=
ve to
> map or unmap all VAs associated with a GEM object.
>=20
> I think PT(E) reference counts etc. should be rather released when the dr=
m_gpuva
> is freed, i.e. page table allocations can be bound to the lifetime of a
> drm_gpuva. Given that, I think that eventually we'll need a cleanup list =
for
> those as well, since once they're removed from the VM tree (in the fence
> signalling critical path), we loose access otherwise.

Hmm. Another more conceptual issue with deferring gpuva is that
"immediate mode" is defined as having the GPUVM match the GPU's actual
address space at all times, which deferred gpuva cleanup would go
against.

Deferring vm_bo cleanup doesn't have this issue because even though the
vm_bo isn't kfreed immediately, all GPUVM apis still treat it as-if it
isn't there anymore.

> >> > +static void
> >> > +drm_gpuvm_bo_defer_locked(struct kref *kref)
> >> > +{
> >> > +     struct drm_gpuvm_bo *vm_bo =3D container_of(kref, struct drm_g=
puvm_bo,
> >> > +                                               kref);
> >> > +     struct drm_gpuvm *gpuvm =3D vm_bo->vm;
> >> > +
> >> > +     if (!drm_gpuvm_resv_protected(gpuvm)) {
> >> > +             drm_gpuvm_bo_list_del(vm_bo, extobj, true);
> >> > +             drm_gpuvm_bo_list_del(vm_bo, evict, true);
> >> > +     }
> >> > +
> >> > +     list_del(&vm_bo->list.entry.gem);
> >> > +     mutex_unlock(&vm_bo->obj->gpuva.lock);
> >>
> >> I got tricked by this implicit unlock, and the conditional unlocks it
> >> creates in drm_gpuva_unlink_defer(). Honestly, I'd rather see this
> >> unlocked moved to drm_gpuva_unlink_defer() and a conditional unlock
> >> added to drm_gpuvm_bo_put_deferred(), because it's easier to reason
> >> about when the lock/unlock calls are in the same function
> >> (kref_put_mutex() being the equivalent of a conditional lock).
> >
> > Ok. I followed the docs of kref_put_mutex() that say to unlock it from
> > the function.
>=20
> Yes, please keep it the way it is, I don't want to deviate from what is
> documented and everyone else does. Besides that, I also think it's a litt=
le
> less error prone.

I gave it a try:

bool
drm_gpuvm_bo_put_deferred(struct drm_gpuvm_bo *vm_bo)
{
	drm_WARN_ON(vm_bo->vm->drm, !drm_gpuvm_immediate_mode(vm_bo->vm));

	if (!vm_bo)
		return false;

	if (kref_put_mutex(&vm_bo->kref, drm_gpuvm_bo_defer_locked,
			   &vm_bo->obj->gpuva.lock)) {
		/*
		 * It's important that the GEM stays alive for the duration in which
		 * drm_gpuvm_bo_defer_locked() holds the mutex, but the instant we add
		 * the vm_bo to bo_defer, another thread might call
		 * drm_gpuvm_bo_deferred_cleanup() and put the GEM. For this reason, we
		 * add the vm_bo to bo_defer *after* releasing the GEM's mutex.
		 */
		mutex_unlock(&vm_bo->obj->gpuva.lock);
		drm_gpuvm_bo_list_add(vm_bo, bo_defer, true);
		return true;
	}

	return false;
}

void
drm_gpuva_unlink_defer(struct drm_gpuva *va)
{
	struct drm_gem_object *obj =3D va->gem.obj;
	struct drm_gpuvm_bo *vm_bo =3D va->vm_bo;
	bool should_defer_bo;

	if (unlikely(!obj))
		return;

	drm_WARN_ON(vm_bo->vm->drm, !drm_gpuvm_immediate_mode(vm_bo->vm));

	mutex_lock(&obj->gpuva.lock);
	list_del_init(&va->gem.entry);

	/*
	 * This is drm_gpuvm_bo_put_deferred() slightly modified since we
	 * already hold the mutex. It's important that we add the vm_bo to
	 * bo_defer after releasing the mutex for the same reason as in
	 * drm_gpuvm_bo_put_deferred().
	 */
	should_defer_bo =3D kref_put(&vm_bo->kref, drm_gpuvm_bo_defer_locked);
	mutex_unlock(&obj->gpuva.lock);
	if (should_defer_bo)
		drm_gpuvm_bo_list_add(vm_bo, bo_defer, true);

	va->vm_bo =3D NULL;
}

I do think it looks relatively nice like this, particularly
drm_gpuva_unlink_defer(). But that's also the one not using
kref_put_mutex().

Alice


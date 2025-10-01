Return-Path: <linux-kernel+bounces-838906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED50BB0668
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8161896314
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7381E5B9A;
	Wed,  1 Oct 2025 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gylZn7Ye"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A314D2B7;
	Wed,  1 Oct 2025 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323718; cv=none; b=SCLvKiXctwg0gRq3O+CZ9l8OHq3/x3Ovli5gITEPQc0onZ2kUE9tGU2jGmQEAOcPno4K5DBODDw13xvWohVpyfRfbjdN60lVa9XMkJpHFACIP4rxz6KMUrcUv5Aok6/igefR3DLVdql6oyumTbvqjH++ZUXmFD7BJyj1TmeWUF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323718; c=relaxed/simple;
	bh=SCwfPCc+X/dIs3sNNe3bBeU6jswRKbKJLcFLB+wxXVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ou5h44SO/x9HSZKTzGsCgUPtsGkGG/lOvNGDNQS0jiG1BgiYicDu58QvqgNQFrGdxlzImrTM+O2np1AxRgEfs4T1/2hIM9Zsj1Xcy9ZXKXOL1xODsETK97luC8A7CWxTA1WKs95MAWrY+y1qM55zy4bx2u3KlgarR5WdPGh6GLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gylZn7Ye; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759323714;
	bh=SCwfPCc+X/dIs3sNNe3bBeU6jswRKbKJLcFLB+wxXVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gylZn7YeqyMUqbZTZAFkbWqI82in5YZjhe2qVfNZdoGSlvgPYxN588IPboG1u63e1
	 O0gLuc3j6XuOvQ8PbpZ1Q47SoaakjS7uF9dFLBxhEMy8o0jtwRkVfS6uQfk8/DQleV
	 sei+JHaFU87SXFSxFRLJWpbvei7dylDAiOxI3Pw7c413GzFs8FDPUkmDeO7cMvgpCB
	 syG/gK9KbupCb0DgvaGwuHenSc9KdAQn6pRHvBoRPsqQ7IgeGnX3Mp2i7v/4wUYC1x
	 M2dXn/rqLKOVERhoA6WJXYqnX+YHUBsEpqSysKiTDxoQcgNbDwO7EEyZZ6H8ZDyRKd
	 E7t27z4sBVRQg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6D27917E00AC;
	Wed,  1 Oct 2025 15:01:53 +0200 (CEST)
Date: Wed, 1 Oct 2025 15:01:43 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Steven Price <steven.price@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, Liviu Dudau
 <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/2] drm/gpuvm: add deferred vm_bo cleanup
Message-ID: <20251001150143.410f94ad@fedora>
In-Reply-To: <CAH5fLghu01gTnLe1Z0Z-7354QF_YMRfe5w2VG7NKTwkj+eESkA@mail.gmail.com>
References: <20251001-vmbo-defer-v3-0-a3fe6b6ae185@google.com>
	<20251001-vmbo-defer-v3-1-a3fe6b6ae185@google.com>
	<20251001132739.41575fa5@fedora>
	<CAH5fLghp+4dx6-JAfbSWDLz7WOdwtnLeuxdGhmVPax+HKbTv3w@mail.gmail.com>
	<20251001140418.57fb21f1@fedora>
	<20251001141310.0817a6c7@fedora>
	<CAH5fLghu01gTnLe1Z0Z-7354QF_YMRfe5w2VG7NKTwkj+eESkA@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Oct 2025 14:22:06 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

> On Wed, Oct 1, 2025 at 2:13=E2=80=AFPM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > On Wed, 1 Oct 2025 14:04:18 +0200
> > Boris Brezillon <boris.brezillon@collabora.com> wrote:
> > =20
> > > On Wed, 1 Oct 2025 13:45:36 +0200
> > > Alice Ryhl <aliceryhl@google.com> wrote:
> > > =20
> > > > On Wed, Oct 1, 2025 at 1:27=E2=80=AFPM Boris Brezillon
> > > > <boris.brezillon@collabora.com> wrote: =20
> > > > >
> > > > > On Wed, 01 Oct 2025 10:41:36 +0000
> > > > > Alice Ryhl <aliceryhl@google.com> wrote:
> > > > > =20
> > > > > > When using GPUVM in immediate mode, it is necessary to call
> > > > > > drm_gpuvm_unlink() from the fence signalling critical path. How=
ever,
> > > > > > unlink may call drm_gpuvm_bo_put(), which causes some challenge=
s:
> > > > > >
> > > > > > 1. drm_gpuvm_bo_put() often requires you to take resv locks, wh=
ich you
> > > > > >    can't do from the fence signalling critical path.
> > > > > > 2. drm_gpuvm_bo_put() calls drm_gem_object_put(), which is ofte=
n going
> > > > > >    to be unsafe to call from the fence signalling critical path.
> > > > > >
> > > > > > To solve these issues, add a deferred version of drm_gpuvm_unli=
nk() that
> > > > > > adds the vm_bo to a deferred cleanup list, and then clean it up=
 later.
> > > > > >
> > > > > > The new methods take the GEMs GPUVA lock internally rather than=
 letting
> > > > > > the caller do it because it also needs to perform an operation =
after
> > > > > > releasing the mutex again. This is to prevent freeing the GEM w=
hile
> > > > > > holding the mutex (more info as comments in the patch). This me=
ans that
> > > > > > the new methods can only be used with DRM_GPUVM_IMMEDIATE_MODE.
> > > > > >
> > > > > > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > > > > Signed-off-by: Alice Ryhl <aliceryhl@google.com> =20
> > > > =20
> > > > > > +/*
> > > > > > + * Must be called with GEM mutex held. After releasing GEM mut=
ex,
> > > > > > + * drm_gpuvm_bo_defer_free_unlocked() must be called.
> > > > > > + */
> > > > > > +static void
> > > > > > +drm_gpuvm_bo_defer_free_locked(struct kref *kref)
> > > > > > +{
> > > > > > +     struct drm_gpuvm_bo *vm_bo =3D container_of(kref, struct =
drm_gpuvm_bo,
> > > > > > +                                               kref);
> > > > > > +     struct drm_gpuvm *gpuvm =3D vm_bo->vm;
> > > > > > +
> > > > > > +     if (!drm_gpuvm_resv_protected(gpuvm)) {
> > > > > > +             drm_gpuvm_bo_list_del(vm_bo, extobj, true);
> > > > > > +             drm_gpuvm_bo_list_del(vm_bo, evict, true);
> > > > > > +     }
> > > > > > +
> > > > > > +     list_del(&vm_bo->list.entry.gem);
> > > > > > +}
> > > > > > +
> > > > > > +/*
> > > > > > + * GEM mutex must not be held. Called after drm_gpuvm_bo_defer=
_free_locked().
> > > > > > + */
> > > > > > +static void
> > > > > > +drm_gpuvm_bo_defer_free_unlocked(struct drm_gpuvm_bo *vm_bo)
> > > > > > +{
> > > > > > +     struct drm_gpuvm *gpuvm =3D vm_bo->vm;
> > > > > > +
> > > > > > +     llist_add(&vm_bo->list.entry.bo_defer, &gpuvm->bo_defer);=
 =20
> > > > >
> > > > > Could we simply move this line to drm_gpuvm_bo_defer_free_locked(=
)?
> > > > > I might be missing something, but I don't really see a reason to
> > > > > have it exposed as a separate operation. =20
> > > >
> > > > No, if drm_gpuvm_bo_deferred_cleanup() is called in parallel (e.g.
> > > > from a workqueue as we discussed), then this can lead to kfreeing t=
he
> > > > GEM while we hold the mutex. We must not add the vm_bo until it's s=
afe
> > > > to kfree the GEM. See the comment on
> > > > drm_gpuvm_bo_defer_free_unlocked() below. =20
> > >
> > > Uh, right, I forgot that the lock was embedded in the BO, which we're
> > > releasing a ref on in the cleanup path. =20
> >
> > Would be good to document the race in the comment saying that
> > gpuva.lock shouldn't be held though. =20
>=20
> I can move the comment in drm_gpuvm_bo_defer_free() to the function comme=
nt.

That, or you refer to the function where it's documented in the comment.


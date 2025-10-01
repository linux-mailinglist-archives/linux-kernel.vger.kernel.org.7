Return-Path: <linux-kernel+bounces-838859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DB6BB04A2
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F5A3B4957
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347392E92D0;
	Wed,  1 Oct 2025 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UmEzoVyU"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DE3537E9;
	Wed,  1 Oct 2025 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320799; cv=none; b=qAtfkwtLGyGTTu0LU+0f8xDpLpkFZV2Jb8Y4PntZy//C5mB2sbn6NKq6JOpE/In+ei1T/3V6LxnJdV6dp1sR/IJOuGUFQbYrpO0AvJ6v6igVD5ZJKlvl9JBOnIMQX3DWNdlmMpz2y5P+pZVdogSmlBDSAcJ5Akmuw5uLcQRXZK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320799; c=relaxed/simple;
	bh=7hEM/r1j5wBKoJc3aCyzvjA7qiAo7dj9HLa2165QQYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=so2gPYPC1YeulvkhULcmTp/potgGCdrodDrja/q2lHW56xk19/zfrJt7mHqyOq4YMMRPT5NIFcCecL9s0DG5y8vz0TIqyJLjA8p3zJ4gLvG65sAP8NlUiejhXJgSqJC5EleoVvor5lOGdkrEorI/KBvoy/aGLpnDOZ0C3uhVwQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UmEzoVyU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759320795;
	bh=7hEM/r1j5wBKoJc3aCyzvjA7qiAo7dj9HLa2165QQYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UmEzoVyU1SYHFm4kPxnXNQ81MvLM2PCaLisskdj7X7VCt+tk0nEM2pZH3KJF95WRE
	 6KsrQXHYhmsVYWY7fLCel9K7QAwGnF0WPSqoPuYbsqQ3yl4Tgk5XZ+rEZb9wYYBU8D
	 Gc9XNN4vXd14mZtEPoCA9fObvRR/QNXhc11Yz9lCVgqhhsCy4z/+cHtPPWTw7p2uex
	 fxw0n7K8w9O9kKAoyQu3cPqcfXVKw+3cFvlZgCvWhda+emoZ0zWo0jF4gTjbjlbx3f
	 KFzmZJ8zCBQtBDrQm16zconwlzsTtxRR5StXEXFkoKRcesEg4yN8uFw+Fod3WUxkeU
	 JbQKTbQKjo0Fg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2238217E131B;
	Wed,  1 Oct 2025 14:13:15 +0200 (CEST)
Date: Wed, 1 Oct 2025 14:13:10 +0200
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
Message-ID: <20251001141310.0817a6c7@fedora>
In-Reply-To: <20251001140418.57fb21f1@fedora>
References: <20251001-vmbo-defer-v3-0-a3fe6b6ae185@google.com>
	<20251001-vmbo-defer-v3-1-a3fe6b6ae185@google.com>
	<20251001132739.41575fa5@fedora>
	<CAH5fLghp+4dx6-JAfbSWDLz7WOdwtnLeuxdGhmVPax+HKbTv3w@mail.gmail.com>
	<20251001140418.57fb21f1@fedora>
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

On Wed, 1 Oct 2025 14:04:18 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Wed, 1 Oct 2025 13:45:36 +0200
> Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> > On Wed, Oct 1, 2025 at 1:27=E2=80=AFPM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote: =20
> > >
> > > On Wed, 01 Oct 2025 10:41:36 +0000
> > > Alice Ryhl <aliceryhl@google.com> wrote:
> > >   =20
> > > > When using GPUVM in immediate mode, it is necessary to call
> > > > drm_gpuvm_unlink() from the fence signalling critical path. However,
> > > > unlink may call drm_gpuvm_bo_put(), which causes some challenges:
> > > >
> > > > 1. drm_gpuvm_bo_put() often requires you to take resv locks, which =
you
> > > >    can't do from the fence signalling critical path.
> > > > 2. drm_gpuvm_bo_put() calls drm_gem_object_put(), which is often go=
ing
> > > >    to be unsafe to call from the fence signalling critical path.
> > > >
> > > > To solve these issues, add a deferred version of drm_gpuvm_unlink()=
 that
> > > > adds the vm_bo to a deferred cleanup list, and then clean it up lat=
er.
> > > >
> > > > The new methods take the GEMs GPUVA lock internally rather than let=
ting
> > > > the caller do it because it also needs to perform an operation after
> > > > releasing the mutex again. This is to prevent freeing the GEM while
> > > > holding the mutex (more info as comments in the patch). This means =
that
> > > > the new methods can only be used with DRM_GPUVM_IMMEDIATE_MODE.
> > > >
> > > > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>   =20
> >  =20
> > > > +/*
> > > > + * Must be called with GEM mutex held. After releasing GEM mutex,
> > > > + * drm_gpuvm_bo_defer_free_unlocked() must be called.
> > > > + */
> > > > +static void
> > > > +drm_gpuvm_bo_defer_free_locked(struct kref *kref)
> > > > +{
> > > > +     struct drm_gpuvm_bo *vm_bo =3D container_of(kref, struct drm_=
gpuvm_bo,
> > > > +                                               kref);
> > > > +     struct drm_gpuvm *gpuvm =3D vm_bo->vm;
> > > > +
> > > > +     if (!drm_gpuvm_resv_protected(gpuvm)) {
> > > > +             drm_gpuvm_bo_list_del(vm_bo, extobj, true);
> > > > +             drm_gpuvm_bo_list_del(vm_bo, evict, true);
> > > > +     }
> > > > +
> > > > +     list_del(&vm_bo->list.entry.gem);
> > > > +}
> > > > +
> > > > +/*
> > > > + * GEM mutex must not be held. Called after drm_gpuvm_bo_defer_fre=
e_locked().
> > > > + */
> > > > +static void
> > > > +drm_gpuvm_bo_defer_free_unlocked(struct drm_gpuvm_bo *vm_bo)
> > > > +{
> > > > +     struct drm_gpuvm *gpuvm =3D vm_bo->vm;
> > > > +
> > > > +     llist_add(&vm_bo->list.entry.bo_defer, &gpuvm->bo_defer);   =
=20
> > >
> > > Could we simply move this line to drm_gpuvm_bo_defer_free_locked()?
> > > I might be missing something, but I don't really see a reason to
> > > have it exposed as a separate operation.   =20
> >=20
> > No, if drm_gpuvm_bo_deferred_cleanup() is called in parallel (e.g.
> > from a workqueue as we discussed), then this can lead to kfreeing the
> > GEM while we hold the mutex. We must not add the vm_bo until it's safe
> > to kfree the GEM. See the comment on
> > drm_gpuvm_bo_defer_free_unlocked() below. =20
>=20
> Uh, right, I forgot that the lock was embedded in the BO, which we're
> releasing a ref on in the cleanup path.

Would be good to document the race in the comment saying that
gpuva.lock shouldn't be held though.





Return-Path: <linux-kernel+bounces-838849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82700BB0451
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177911940502
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A10E2E8E0D;
	Wed,  1 Oct 2025 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YXbd2z3I"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87D52C08A2;
	Wed,  1 Oct 2025 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320267; cv=none; b=ed5zDbiV5/yF3ImxwiLmrjz6XD9bhpBmCdxL4GnXiCLCc80On76boFL7T0/jZBiNbNjrh7PuTENeGDPGhPabin+lZNgZdLUgw3Le7FhMaBfn/3+Qt+1VUHJXwBXf2OetrpS0PaaESRT6A1tDIrRvLdv1OeSNp4KevusmdvzkAZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320267; c=relaxed/simple;
	bh=kFPc/gkLARdoFaW/nkDrbHCfs7G6pU14yCZscWLvdUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhlpqJ18Xzx+pNll2SgYuWkTAXheufCU9tEh5nf+iW0RIs1vhi2cszBcGECOuxWicID+6V/zu38H8KuTCggrQ9PsUD0dny+7hut6dNiEl/uQKjs4AiAH+ZJP7/4xVJcj6tl19MJECfTMXimBRMwrObzFRRyczu3D6dkewkoCMck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YXbd2z3I; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759320263;
	bh=kFPc/gkLARdoFaW/nkDrbHCfs7G6pU14yCZscWLvdUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YXbd2z3ILri3jxxkd+DTOYB7dE/KdzzpnPQE9Rwr3iflUL8z37zBFPxTptDeTTHT5
	 dUJBD+ltk9EOt+nxobr0iZOgUkGr0tpCV2XB4ZPWY1ZPsoK/c2jCaaC7YnFBGLY7pQ
	 v8bWN/m3xS4oaIp4zpBmCtI8BdA5g/aGxuoQX0coYTNdMJrIlgKFfJB/ai6lENv1Oj
	 i7CwBqbFDLbjJBFLqEcaDKyWex6w6HYRVSxcjjG2f5QCDYNgj5+HalftahH9ohV316
	 CQobvNv13NKk+PGeyCJttTreNVN+KmCgYawfCO34ytd5uxqys+DT2hvh6qr/P+5meI
	 x813tqB2vkzlA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 43EAD17E00AC;
	Wed,  1 Oct 2025 14:04:23 +0200 (CEST)
Date: Wed, 1 Oct 2025 14:04:18 +0200
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
Message-ID: <20251001140418.57fb21f1@fedora>
In-Reply-To: <CAH5fLghp+4dx6-JAfbSWDLz7WOdwtnLeuxdGhmVPax+HKbTv3w@mail.gmail.com>
References: <20251001-vmbo-defer-v3-0-a3fe6b6ae185@google.com>
	<20251001-vmbo-defer-v3-1-a3fe6b6ae185@google.com>
	<20251001132739.41575fa5@fedora>
	<CAH5fLghp+4dx6-JAfbSWDLz7WOdwtnLeuxdGhmVPax+HKbTv3w@mail.gmail.com>
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

On Wed, 1 Oct 2025 13:45:36 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

> On Wed, Oct 1, 2025 at 1:27=E2=80=AFPM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > On Wed, 01 Oct 2025 10:41:36 +0000
> > Alice Ryhl <aliceryhl@google.com> wrote:
> > =20
> > > When using GPUVM in immediate mode, it is necessary to call
> > > drm_gpuvm_unlink() from the fence signalling critical path. However,
> > > unlink may call drm_gpuvm_bo_put(), which causes some challenges:
> > >
> > > 1. drm_gpuvm_bo_put() often requires you to take resv locks, which you
> > >    can't do from the fence signalling critical path.
> > > 2. drm_gpuvm_bo_put() calls drm_gem_object_put(), which is often going
> > >    to be unsafe to call from the fence signalling critical path.
> > >
> > > To solve these issues, add a deferred version of drm_gpuvm_unlink() t=
hat
> > > adds the vm_bo to a deferred cleanup list, and then clean it up later.
> > >
> > > The new methods take the GEMs GPUVA lock internally rather than letti=
ng
> > > the caller do it because it also needs to perform an operation after
> > > releasing the mutex again. This is to prevent freeing the GEM while
> > > holding the mutex (more info as comments in the patch). This means th=
at
> > > the new methods can only be used with DRM_GPUVM_IMMEDIATE_MODE.
> > >
> > > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com> =20
>=20
> > > +/*
> > > + * Must be called with GEM mutex held. After releasing GEM mutex,
> > > + * drm_gpuvm_bo_defer_free_unlocked() must be called.
> > > + */
> > > +static void
> > > +drm_gpuvm_bo_defer_free_locked(struct kref *kref)
> > > +{
> > > +     struct drm_gpuvm_bo *vm_bo =3D container_of(kref, struct drm_gp=
uvm_bo,
> > > +                                               kref);
> > > +     struct drm_gpuvm *gpuvm =3D vm_bo->vm;
> > > +
> > > +     if (!drm_gpuvm_resv_protected(gpuvm)) {
> > > +             drm_gpuvm_bo_list_del(vm_bo, extobj, true);
> > > +             drm_gpuvm_bo_list_del(vm_bo, evict, true);
> > > +     }
> > > +
> > > +     list_del(&vm_bo->list.entry.gem);
> > > +}
> > > +
> > > +/*
> > > + * GEM mutex must not be held. Called after drm_gpuvm_bo_defer_free_=
locked().
> > > + */
> > > +static void
> > > +drm_gpuvm_bo_defer_free_unlocked(struct drm_gpuvm_bo *vm_bo)
> > > +{
> > > +     struct drm_gpuvm *gpuvm =3D vm_bo->vm;
> > > +
> > > +     llist_add(&vm_bo->list.entry.bo_defer, &gpuvm->bo_defer); =20
> >
> > Could we simply move this line to drm_gpuvm_bo_defer_free_locked()?
> > I might be missing something, but I don't really see a reason to
> > have it exposed as a separate operation. =20
>=20
> No, if drm_gpuvm_bo_deferred_cleanup() is called in parallel (e.g.
> from a workqueue as we discussed), then this can lead to kfreeing the
> GEM while we hold the mutex. We must not add the vm_bo until it's safe
> to kfree the GEM. See the comment on
> drm_gpuvm_bo_defer_free_unlocked() below.

Uh, right, I forgot that the lock was embedded in the BO, which we're
releasing a ref on in the cleanup path.


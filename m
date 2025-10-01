Return-Path: <linux-kernel+bounces-839190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3800BB0FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB9357A2039
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7842B2773C2;
	Wed,  1 Oct 2025 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="acDYKDlk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9777262D14;
	Wed,  1 Oct 2025 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331634; cv=none; b=rU8Kjp5yX+nYPgIybalEcE/+N9tB8sFolaEEwWBn0W4JCalWOY3h7ctGMPpBiQDA1SrPiL3Gu5ddUMGgA+Pz7no4I9cE5zJS1zR6z8dI4ay8koK7Vbh0kvkOsR4Uvcrs5es1fNoHEsTKJO3B/rnc2lLHdqheaSVPM5rzf4a00uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331634; c=relaxed/simple;
	bh=f2pt9BkEMx3ptqqD1vPp/R/QxVaCY72d5ngPAgE3eBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4hHCnfRjObScMbPTLc/LyYvz1TRAEUKODbzQ3uMOTNSMBxPbXxJYBhG6n6ShyH7CnUxn45W0xPae9BmGszN458o9JU2T4E+r5nWjWXt+uqwONut+6haorhfa4cYMOhiZMkagW4EbGffHyjV723stDuPrTVyzlWd4UEZxGIEBNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=acDYKDlk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759331630;
	bh=f2pt9BkEMx3ptqqD1vPp/R/QxVaCY72d5ngPAgE3eBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=acDYKDlkavcHRTzLkn/2F3viCrcT5C3gxkQI8w6NbKYUivdOE+k8p4mKn+Z+AnPyj
	 NZOps7NkQFBOgDLf+67YMDBwOhpfcP/tkj6X1JDyW90qYMicj8agdrAA283txmP86O
	 7hk9H382WT75Mw2r18rEAQPe+G9jN8AHEdJjylgf3BKL+xZZD9ZAIPE7HsMx2iAZ3B
	 LKTLXqNhsOVzDe9XnPJRMQqrPrZEnQDvDbMPGeSEmB0GrA+Q9C21teczc0K+xqsPW0
	 IsqvmCBHKHwUiqmoSA3fLKR9kqFaAdsegCnuZ+31vx8+GpH53idtntYsk83i0f+mHc
	 Xts20/pO9ymWA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 47DF217E0AC3;
	Wed,  1 Oct 2025 17:13:50 +0200 (CEST)
Date: Wed, 1 Oct 2025 17:13:46 +0200
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
Message-ID: <20251001171346.482142eb@fedora>
In-Reply-To: <CAH5fLghM_fmaHn561_e7StHAwdV=8gPxAwUToDxPQiBY8E+aVA@mail.gmail.com>
References: <20251001-vmbo-defer-v3-0-a3fe6b6ae185@google.com>
	<20251001-vmbo-defer-v3-1-a3fe6b6ae185@google.com>
	<DD71GUKZKFPR.2OVPQ9KOI89YG@kernel.org>
	<CAH5fLghM_fmaHn561_e7StHAwdV=8gPxAwUToDxPQiBY8E+aVA@mail.gmail.com>
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

On Wed, 1 Oct 2025 16:42:35 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

> On Wed, Oct 1, 2025 at 4:01=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
> >
> > On Wed Oct 1, 2025 at 12:41 PM CEST, Alice Ryhl wrote: =20
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
> > > +     llist_add(&vm_bo->list.entry.bo_defer, &gpuvm->bo_defer);
> > > +}
> > > +
> > > +static void
> > > +drm_gpuvm_bo_defer_free(struct kref *kref)
> > > +{
> > > +     struct drm_gpuvm_bo *vm_bo =3D container_of(kref, struct drm_gp=
uvm_bo,
> > > +                                               kref);
> > > +
> > > +     mutex_lock(&vm_bo->obj->gpuva.lock);
> > > +     drm_gpuvm_bo_defer_free_locked(kref);
> > > +     mutex_unlock(&vm_bo->obj->gpuva.lock);
> > > +
> > > +     /*
> > > +      * It's important that the GEM stays alive for the duration in =
which we
> > > +      * hold the mutex, but the instant we add the vm_bo to bo_defer,
> > > +      * another thread might call drm_gpuvm_bo_deferred_cleanup() an=
d put
> > > +      * the GEM. Therefore, to avoid kfreeing a mutex we are holding=
, we add
> > > +      * the vm_bo to bo_defer *after* releasing the GEM's mutex.
> > > +      */
> > > +     drm_gpuvm_bo_defer_free_unlocked(vm_bo);
> > > +} =20
> >
> > So, you're splitting drm_gpuvm_bo_defer_free() into two functions, one =
doing the
> > work that is required to be called with the gpuva lock held and one tha=
t does
> > the work that does not require a lock, which makes perfect sense.
> >
> > However, the naming chosen for the two functions, i.e.
> > drm_gpuvm_bo_defer_free_unlocked() and drm_gpuvm_bo_defer_free_locked()=
 is
> > confusing:
> >
> > What you mean semantically mean is "do part 1 with lock held" and "do p=
art 2
> > without lock held", but the the chosen names suggest that both function=
s are
> > identical, with the only difference that one takes the lock internally =
and the
> > other one requires the caller to take the lock.
> >
> > It's probably better to name them after what they do and not what they'=
re part
> > of. If you prefer the latter, that's fine with me too, but please choos=
e a name
> > that makes this circumstance obvious. =20
>=20
> Fair point. Do you have naming suggestions? Otherwise I can name them
> drm_gpuvm_bo_defer_free_part1() and drm_gpuvm_bo_defer_free_part2().
> :)

drm_gpuvm_bo_free_deferral_extract_locked() and
drm_gpuvm_bo_free_deferral_enqueue()? Definitely not short names though.


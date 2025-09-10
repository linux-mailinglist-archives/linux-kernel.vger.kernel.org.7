Return-Path: <linux-kernel+bounces-809478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5124B50E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96963A85C4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A063081BA;
	Wed, 10 Sep 2025 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sfA9CzK1"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FDD306488
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486390; cv=none; b=ib+QfLg6wZV4X+MjTurJ2HU6UZaQiaokj7+lfLvwzqzORBfctw2ZdMcivbc50FJLjRwGfGmFWFUjQrgnn4R+dPn4ZVZHptzF/9bkHqbTiCFn2+BeqzsEL00IKQqr8wdx++YxDGkhyapPA10HDq1lsbLQd5p9DquDe3jFJOKsblY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486390; c=relaxed/simple;
	bh=rfQe+ePDp4Zo0AgaP4d2M/YN/CS2BDKY5Aq9m9aG2wI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SZ55NFgF2vauht9RhP39MYVMSUcNiAxBoILX96canuIZOyGPfcUmhJbcIRo6l5nPPJq/AdHUreeW1kz10gbjsXl11pVGrny+5weporbQrx0UYlUGgsBuOrIsAZ57Twm8d4kkYFzC609+l0gJA4Pxe2/7Smajru9h2z5PZhZpmJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sfA9CzK1; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b04a8ae1409so334981266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 23:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757486387; x=1758091187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ZgO5jwANFMehJfMoLYUsZTxd5NY3ndlOci6BOUflzQ=;
        b=sfA9CzK13Vexf+5Y5pM3KwocHcTeSTzAoISTLeF2IRgev8EvfJ/Y+XOsZMmwq80ma/
         t7gHyDuaWeeVXSDmViqqjkfjYkMFkxJ2NSxMBAq9ALlqRQkGDV6mbYibUYZEoDZCdikw
         ixM0gc1hIizGNhaC9uw2PAwAfwKLlcNpV8vSY2Xl0v+25YBraocT2/Zb+mbeiMrLsojj
         hH5HANPsWyYf4CX/P3r+pMKCQbPbAw+u/I6810PyENH5LZs6nWGItNAdYGpIhTLfgUpQ
         cCC/iS/Mj1IQCWA6FjsNsj+O9v4B6JX6lwnkSDG/o8naR4oyB99VjwqcW/2npXMYxX1S
         frfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757486387; x=1758091187;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0ZgO5jwANFMehJfMoLYUsZTxd5NY3ndlOci6BOUflzQ=;
        b=wb+VwDbDHty1U3V0150xq7Nbx/AHqq/uiy2C6PkVgYF+qeCzvuBAcUbBoRjGsOqjbQ
         CldFV8Z4Hc/sTv+k7AIoFZIBn0Z/tO4oi5VSaiY4PAUGhbDPTCGElje+TcfOHaFXQT6c
         DywonSQ92Ggo7eVDeOypot0RTWjBkCeMWT0DWwhU0w8Od6i+Yke7XOBN3wyNlkdveTs8
         BvHXPjm0TMqhHN3aXGPdBdhMrnNEQfLmUfGNjTQZvm4Ljgh/XiF+658sLBihia/hwt94
         NnZUFNgnAlV4Qjca7t7i3vEQM4DWDOoNykB8RUHd/u/SXMNB5kGln+WDqPFsMRsiaSjf
         qvxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5nx0SmLPK8qEE+mr3a+mqem41mZ0qk2s9op7ilxIV1xl6hbpqbllCBfn6KHO7EiKPLTcX9N7T+6U4h3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCd6zkJnD05QZT0wV2msC7OTuUOlhU7XsNNRmAPRf2u/3+S9Gn
	olb5siWwMWCZ1aXxvV5kc3DLmpM6NjUy8OgtwjJvFKCTQnSEHAHR4E1X2rAzMRpljZ6BLk4yoHM
	OCvd61OBfuX4Sz+vuqw==
X-Google-Smtp-Source: AGHT+IF290sfWDJWyXR0CbzZnHAG1Yyq7SWKBAx8oPF32kqB1mi5kcbwO1hzeAGXP44801EWVIisUmt4Rpwov5g=
X-Received: from edh22.prod.google.com ([2002:a05:6402:5056:b0:62b:f094:4936])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f2a:b0:b04:9d90:a7e6 with SMTP id a640c23a62f3a-b04b1741ac2mr1432308366b.55.1757486387560;
 Tue, 09 Sep 2025 23:39:47 -0700 (PDT)
Date: Wed, 10 Sep 2025 06:39:46 +0000
In-Reply-To: <c7a7aac3e82fde7a20970e6a65d200ab79804b0f.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909-vmbo-defer-v2-0-9835d7349089@google.com>
 <20250909-vmbo-defer-v2-1-9835d7349089@google.com> <c7a7aac3e82fde7a20970e6a65d200ab79804b0f.camel@linux.intel.com>
Message-ID: <aMEdMg_3ljC27i1-@google.com>
Subject: Re: [PATCH v2 1/2] drm/gpuvm: add deferred vm_bo cleanup
From: Alice Ryhl <aliceryhl@google.com>
To: "Thomas =?utf-8?Q?Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 04:20:32PM +0200, Thomas Hellstr=C3=B6m wrote:
> On Tue, 2025-09-09 at 13:36 +0000, Alice Ryhl wrote:
> > When using GPUVM in immediate mode, it is necessary to call
> > drm_gpuvm_unlink() from the fence signalling critical path. However,
> > unlink may call drm_gpuvm_bo_put(), which causes some challenges:
> >=20
> > 1. drm_gpuvm_bo_put() often requires you to take resv locks, which
> > you
> > =C2=A0=C2=A0 can't do from the fence signalling critical path.
> > 2. drm_gpuvm_bo_put() calls drm_gem_object_put(), which is often
> > going
> > =C2=A0=C2=A0 to be unsafe to call from the fence signalling critical pa=
th.
> >=20
> > To solve these issues, add a deferred version of drm_gpuvm_unlink()
> > that
> > adds the vm_bo to a deferred cleanup list, and then clean it up
> > later.
> >=20
> > The new methods take the GEMs GPUVA lock internally rather than
> > letting
> > the caller do it because it also needs to perform an operation after
> > releasing the mutex again. This is to prevent freeing the GEM while
> > holding the mutex (more info as comments in the patch). This means
> > that
> > the new methods can only be used with DRM_GPUVM_IMMEDIATE_MODE.
> >=20
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > =C2=A0drivers/gpu/drm/drm_gpuvm.c | 174
> > ++++++++++++++++++++++++++++++++++++++++++++
> > =C2=A0include/drm/drm_gpuvm.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 26 ++++++=
+
> > =C2=A02 files changed, 200 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/drm_gpuvm.c
> > b/drivers/gpu/drm/drm_gpuvm.c
> > index
> > 78a1a4f095095e9379bdf604d583f6c8b9863ccb..5aa8b3813019705f70101950af2
> > d8fe4e648e9d0 100644
> > --- a/drivers/gpu/drm/drm_gpuvm.c
> > +++ b/drivers/gpu/drm/drm_gpuvm.c
> > @@ -876,6 +876,27 @@ __drm_gpuvm_bo_list_add(struct drm_gpuvm *gpuvm,
> > spinlock_t *lock,
> > =C2=A0	cond_spin_unlock(lock, !!lock);
> > =C2=A0}
> > =C2=A0
> > +/**
> > + * drm_gpuvm_bo_is_dead() - check whether this vm_bo is scheduled
>=20
> NIT: Is zombie a better name than dead?

I could see that name make sense.

> > =C2=A0/**
> > =C2=A0 * drm_gpuvm_bo_list_add() - insert a vm_bo into the given list
> > =C2=A0 * @__vm_bo: the &drm_gpuvm_bo
> > @@ -1081,6 +1102,9 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const
> > char *name,
> > =C2=A0	INIT_LIST_HEAD(&gpuvm->evict.list);
> > =C2=A0	spin_lock_init(&gpuvm->evict.lock);
> > =C2=A0
> > +	INIT_LIST_HEAD(&gpuvm->bo_defer.list);
> > +	spin_lock_init(&gpuvm->bo_defer.lock);
> > +
>=20
> This list appears to exactly follow the pattern a lockless list was
> designed for. Saves some space in the vm_bo and gets rid of the
> excessive locking. <include/linux/llist.h>

Good point.

Alice


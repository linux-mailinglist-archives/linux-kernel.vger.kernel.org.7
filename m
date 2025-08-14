Return-Path: <linux-kernel+bounces-769124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 526AEB26A55
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F2D74E18EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF9A207A08;
	Thu, 14 Aug 2025 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEidgXlg"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825C01C6FFA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183727; cv=none; b=fVj7bLdFAO+Y8qZh8f5DMoA7nG8TAV+WI2IRpH3JgiEL/kRVQIFOO9g59fDZ//fbb7g5R7Cy+7d2064NDEXSOfOz8joxrHFm847MpVIHHsATvxy6KrF5wcQsMSZ1keDurp8KykQbEwtquceryhFNhZEpNLyqGL7qbgms3eWe2IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183727; c=relaxed/simple;
	bh=sRGkru1ksZ6WDTzg3Ve0idBIKxkLHmMlpYpJMKFFVx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yy8M36qzSVJfo9GeO6WCBOHbARd7p79oI7o3AHx1fQKjKVocvSoEzDDIgvHZAQun4B8reNTGPP3m90cykNgj/O5T8kCdaAhKkdg9GBXiGLxvJQiNhRvDwymzMiGcryU6K1daJ3o8Obe19cWWw8CoVfnX0iRvDg6mUWH8kSCH/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gEidgXlg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9e4193083so897845f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755183724; x=1755788524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcuRZv2dxfNNVAgPVxq0ce4wCvWQ90BLeB/gbg8f4Hw=;
        b=gEidgXlgFbue2puKCpwj95OpqpC9vn6eI0X6sl+Mwuc4tEHrrM7fa5KbhppaHRtxpy
         BlmeXAyW6YmgGTbV6mn+M6f1Rj49oemxBjekjI0a0Mbpd5EH61qi1cFNkxOT9O7xjFco
         ty1Gb9RH0xzpBqxx4Y9t0wJcjjljpEDkviniGXCw+zBWDqszRuaR5WpKDZImat6hN2J6
         By+2MO1dFFg9GfPphe7aq48/Nj1506uSSpbyMu+RzdfOQ9WZXMESanb/o6ZiticZKNAm
         282ixqWME7I2IGkU5odPsLRLHjsAN6y7265Ru0LlMXsmGuEvR9W/sPb27z6Z8h37718H
         LiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183724; x=1755788524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcuRZv2dxfNNVAgPVxq0ce4wCvWQ90BLeB/gbg8f4Hw=;
        b=dJIA1HLPv6K9oGqvhLOCOqclRaNars25l/WsDIRECZyN0qx+1RibSJitRn3EbhsTal
         I0PQxMk8M1o+VBZHo6sXo2miqG+fXhZjKJbsJchTWEh4dkZHbIM7e/5KTHdBSH2sBAzx
         1prtrhaJg8hCybW5FRhV4Q5s5grTMk/Uce7kkTcpVWisq5IoH2nlmFu+xE4ZeJZNcW1U
         4wGoU6EwP3kLPdTTpOOp0mO6tQAT0+ygLbbj4EUIHxIWojtGMQKdADmZFvIvNam//aIX
         amZp/8oyP1FBB97H7EMubGsWCqvDPtmUimh1pkRePLh5uSn7OXbPaIry5+JqTMonHADs
         vaQg==
X-Forwarded-Encrypted: i=1; AJvYcCU7iXeFG490jYV5PTIy7GyRzo8hWknag7D3eOCuRgtifWkQOuZGIbNyxBc1M+v4U2UnVSKZVvzR97ns6gU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc2nl0fRb6ZxDrt68PB67Jifpw/ic++0ZnzpkVN/Dxyy2aurpj
	cHRskg98ZwUuxjriWVUaM9taC8WXDfu0Yam+8HUC8orszupHwzcbdel3SaFKGLUWwa8G4YQFTie
	Dq706ZhtLvoqpwhTZuw0Nn4bjTbdae6ZNyGDIT5qw
X-Gm-Gg: ASbGncsfdVfuY9TjutLMJxhwdtKYmT8hE6z9bQX0N2eIofPcHU0uvysOzxAhwHmWHcC
	ysVFqgb/zSw1HaWpE5QQXRCQdn/vaPNbPFdBZ7BLN8cMFXc149m26gX5ybzNMGlpXArpjsBR4/E
	uxVguF9YUqh4tk4WjRVITPjWb/+K+cdeHPEql6FmLYMJTrB9aGBtKFbpVXQHCyzrJLSMElOsW3j
	ekaKBf0B8KVDKiFVDTYo9hI6w==
X-Google-Smtp-Source: AGHT+IE7EXoosHtxV7R65IJYN3Plv7OfZd1tC3+cfWluvO9mZ6grkYNTfqzMOOGzvX51YBZIfQCmGDddptSMYzWYiIo=
X-Received: by 2002:a05:6000:2c0f:b0:3ab:27f9:e51 with SMTP id
 ffacd0b85a97d-3b9edf2dee3mr2863105f8f.31.1755183723260; Thu, 14 Aug 2025
 08:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-gpuva-mutex-in-gem-v1-0-e202cbfe6d77@google.com>
 <20250814-gpuva-mutex-in-gem-v1-1-e202cbfe6d77@google.com> <DC28NIMIPF5I.2P17OZFA06GXL@kernel.org>
In-Reply-To: <DC28NIMIPF5I.2P17OZFA06GXL@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 14 Aug 2025 17:01:50 +0200
X-Gm-Features: Ac12FXzjZb-o6IiSoOWAEBNWjMzAt4oFDe3uthj89CFgBZYwNtbe7anUeIl0O0E
Message-ID: <CAH5fLgiYqQA-jcz=S_u8EjHkpr65m6nU9DHRkRWs3js8v3Uadg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm_gem: add mutex to drm_gem_object.gpuva
To: Danilo Krummrich <dakr@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 4:59=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Thu Aug 14, 2025 at 3:53 PM CEST, Alice Ryhl wrote:
> > There are two main ways that GPUVM might be used:
> >
> > * staged mode, where VM_BIND ioctls update the GPUVM immediately so tha=
t
> >   the GPUVM reflects the state of the VM *including* staged changes tha=
t
> >   are not yet applied to the GPU's virtual address space.
> > * immediate mode, where the GPUVM state is updated during run_job(),
> >   i.e., in the DMA fence signalling critical path, to ensure that the
> >   GPUVM and the GPU's virtual address space has the same state at all
> >   times.
> >
> > Currently, only Panthor uses GPUVM in immediate mode, but the Rust
> > drivers Tyr and Nova will also use GPUVM in immediate mode, so it is
> > worth to support both staged and immediate mode well in GPUVM. To use
> > immediate mode, the GEMs gpuva list must be modified during the fence
> > signalling path, which means that it must be protected by a lock that i=
s
> > fence signalling safe.
> >
> > For this reason, a mutex is added to struct drm_gem_object that is
> > intended to achieve this purpose. Adding it directly in the GEM object
> > both makes it easier to use GPUVM in immediate mode, but also makes it
> > possible to take the gpuva lock from core drm code.
> >
> > As a follow-up, another change that should probably be made to support
> > immediate mode is a mechanism to postpone cleanup of vm_bo objects, as
> > dropping a vm_bo object in the fence signalling path is problematic for
> > two reasons:
> >
> > * When using DRM_GPUVM_RESV_PROTECTED, you cannot remove the vm_bo from
> >   the extobj/evicted lists during the fence signalling path.
> > * Dropping a vm_bo could lead to the GEM object getting destroyed.
> >   The requirement that GEM object cleanup is fence signalling safe is
> >   dubious and likely to be violated in practice.
> >
> > Panthor already has its own custom implementation of postponing vm_bo
> > cleanup.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  drivers/gpu/drm/drm_gem.c | 2 ++
> >  include/drm/drm_gem.h     | 4 +++-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > index 6a44351e58b7741c358406c8a576b6660b5ca904..24c109ab3fadd5af2e5d9de=
3fe330b105217a9ce 100644
> > --- a/drivers/gpu/drm/drm_gem.c
> > +++ b/drivers/gpu/drm/drm_gem.c
> > @@ -187,6 +187,7 @@ void drm_gem_private_object_init(struct drm_device =
*dev,
> >       kref_init(&obj->refcount);
> >       obj->handle_count =3D 0;
> >       obj->size =3D size;
> > +     mutex_init(&obj->gpuva.lock);
> >       dma_resv_init(&obj->_resv);
> >       if (!obj->resv)
> >               obj->resv =3D &obj->_resv;
> > @@ -1057,6 +1058,7 @@ drm_gem_object_free(struct kref *kref)
> >       if (WARN_ON(!obj->funcs->free))
> >               return;
> >
> > +     mutex_destroy(&obj->gpuva.lock);
> >       obj->funcs->free(obj);
>
> I really can't think of a valid case where we need to access this mutex f=
rom the
> GEM's free() callback, yet it probably doesn't hurt to mention it in the
> documentation of struct drm_gem_object_funcs.

I had wanted to move it below free(), but we can't do that since
free() also performs the kfree() call.

> >  }
> >  EXPORT_SYMBOL(drm_gem_object_free);
> > diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> > index d3a7b43e2c637b164eba5af7cc2fc8ef09d4f0a4..5934d8dc267a65aaf62d2d0=
25869221cd110b325 100644
> > --- a/include/drm/drm_gem.h
> > +++ b/include/drm/drm_gem.h
> > @@ -403,11 +403,13 @@ struct drm_gem_object {
> >        * Provides the list of GPU VAs attached to this GEM object.
> >        *
> >        * Drivers should lock list accesses with the GEMs &dma_resv lock
> > -      * (&drm_gem_object.resv) or a custom lock if one is provided.
> > +      * (&drm_gem_object.resv) or a custom lock if one is provided. Th=
e
> > +      * mutex inside this struct may be used as the custom lock.
> >        */
> >       struct {
> >               struct list_head list;
> >
> > +             struct mutex lock;
> >  #ifdef CONFIG_LOCKDEP
> >               struct lockdep_map *lock_dep_map;
> >  #endif
>
> We should remove this and the corresponding functions (i.e.
> drm_gem_gpuva_set_lock(), drm_gem_gpuva_assert_lock_held()) in a subseque=
nt
> patch and let GPUVM assert for this mutex directly rather than for the
> lockdep_map.

Agreed.

Alice


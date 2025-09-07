Return-Path: <linux-kernel+bounces-804646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B40B47B08
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 13:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2153A5078
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28AB264A60;
	Sun,  7 Sep 2025 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ax/MJz58"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750B41E5215
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757245186; cv=none; b=Hv0gbGk/V+DQMq31qfNny26UhwNMnBMMKtsKTSyntY0aIFvlaCS1oYF8hcl0cIY0qPj/GwyVHbiDRHYVf/LWEshP/ykoupTu83pI3z8tGaEwjxkV/lyB8MtwQ2vweFEzxwtNGkSgWSNribq1i8ZqcxGDjD1mnuYpIGqsRvEy390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757245186; c=relaxed/simple;
	bh=S3RWK01MgwhoESmldbnD23H0uI3OPDF9ufSHLa89zK4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iCWmKkzxDHKABduX9fvreLBaWdAwvqm5CyIIgqYVG17VSEJweXD+h/XM6Cj1eSoyjJCAAM/V6VWQLdR+gBquvkG425GIKvn10QEE9akL/8XkrrVFIVp8Fp1vbumimA+Zt7Ks7Z3lP6ZTqmjqGKviUoxII6KcKz47CKAIp4WBWMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ax/MJz58; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45dd66e1971so20667535e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 04:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757245183; x=1757849983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76k1w/hZUONsc9kXw+6H44ujJP9uLKMcBhBot9MBRw0=;
        b=ax/MJz58wNlpTCd69VxwWVtInqnN7pfKAZoy0HgwdzKimlpFf/5YJmX4MT+nk7sNbV
         XKIZtF6D8k86aGj4gPo8NxUcufp03nd7Npf9qr+kAiF3tNqIaKBdDwF78GeTDX2ZUPNX
         SFP84as727/Zy0SEuQkg/W21u/pdqqIPX2Wf4Hk5tXKwOf+pxfSp5GK0S3gLpMHZY3N3
         zZcVRfxgEyn7aoQCbXmGQZIZUiXbCxauTRzOuxJnA4GGV8dpkX/Uwpn5grJegvTsSYi7
         94rRIjRxz66gwR2c+hKzGIIaXe58yn68xeAenOtIutHo+iNvB2LL0a2ffxvrpHDqK53e
         JnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757245183; x=1757849983;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=76k1w/hZUONsc9kXw+6H44ujJP9uLKMcBhBot9MBRw0=;
        b=Terp+jzSly/tZSaFlmdNfk2KKfDvItXiCsfckKaWXCXmPIJ48qHrIgSszmlUOPlqYM
         TGE72XP9VzAoKIAmYB0IEMkh1HB2uNMbgMB3WLKT3p+FHJFLLSvVSvj1tyatUil7CdbT
         nNrzKDKXgAMcK7yRtub7/nMd6ZaKwRQsG2wqoBTk3HvR0xaZB1TocnXCoQLOjK9sCX7l
         Lmxj8IF0LBqzE5hhCTqKy/BlTgfKtvEO+2k3XyOO9Zh73p82RE3GTx7949YqrVbo3jGF
         vU0AAd+EU6PG+PxHkiysC6P7TI8qwzOD+11cb5boH+LUziHC5hcYyuc4ZvR8Z5kZm+R/
         /HZA==
X-Forwarded-Encrypted: i=1; AJvYcCXPxUldedx2K64Eqqjfa9NR/TSoDYa/fgudp/SdqHqHeypr4Z7YTnyjjcjunJ2rgeydTYOQokdlyIZMXKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhzbi5jAele2xzUR06Kz/lx4x5YKjQsE0X681aJlxQJRrLSh5x
	N5P7Qtb7R6j8Kmse1XLeJinLCQAcb1mPSxl5uKPSXTA2FBJwu7Ens8PuJvtCQCBfo/MKsWT2O7w
	jNMIuxWgypfWNzOCd/w==
X-Google-Smtp-Source: AGHT+IHoVcPYbe0iUJKGBmK7yYOxv27qbhfcAB9Hc59veTuVIOgoY0qC6MoiuHeagEO6EoOqKdzaexiDWmVsuiQ=
X-Received: from wmbes11.prod.google.com ([2002:a05:600c:810b:b0:459:7c15:15b9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e8c:b0:45c:b6fa:352e with SMTP id 5b1f17b1804b1-45dddecf506mr42361025e9.18.1757245182810;
 Sun, 07 Sep 2025 04:39:42 -0700 (PDT)
Date: Sun, 7 Sep 2025 11:39:41 +0000
In-Reply-To: <DCMJ6K06T63T.2UBTM1RL4YJ0A@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905-vmbo-defer-v1-0-7ae1a382b674@google.com>
 <20250905-vmbo-defer-v1-1-7ae1a382b674@google.com> <20250905152505.005a610d@fedora>
 <CAH5fLghgqv0mNYf8r-rdeBaCGxYsdkBouqgo_ohx3DYHwpcZRQ@mail.gmail.com>
 <DCL8DQV23FIZ.KJ74UQ9YOFZV@kernel.org> <aL1pSFB9iBsfHFM_@google.com> <DCMJ6K06T63T.2UBTM1RL4YJ0A@kernel.org>
Message-ID: <aL1u_YxOkuj1kIq6@google.com>
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

On Sun, Sep 07, 2025 at 01:28:05PM +0200, Danilo Krummrich wrote:
> On Sun Sep 7, 2025 at 1:15 PM CEST, Alice Ryhl wrote:
> > On Sat, Sep 06, 2025 at 12:47:36AM +0200, Danilo Krummrich wrote:
> >> On Fri Sep 5, 2025 at 8:18 PM CEST, Alice Ryhl wrote:
> >> > On Fri, Sep 5, 2025 at 3:25=E2=80=AFPM Boris Brezillon
> >> > <boris.brezillon@collabora.com> wrote:
> >> >> On Fri, 05 Sep 2025 12:11:28 +0000
> >> >> Alice Ryhl <aliceryhl@google.com> wrote:
> >> >> > +static bool
> >> >> > +drm_gpuvm_bo_is_dead(struct drm_gpuvm_bo *vm_bo)
> >> >> > +{
> >> >> > +     return !kref_read(&vm_bo->kref);
> >> >>
> >> >> I'm not too sure I like the idea of [ab]using vm_bo::kref to defer =
the
> >> >> vm_bo release. I get why it's done like that, but I'm wondering why=
 we
> >> >> don't defer the release of drm_gpuva objects instead (which is real=
ly
> >> >> what's being released in va_unlink()). I can imagine drivers wantin=
g to
> >> >> attach resources to the gpuva that can't be released in the
> >> >> dma-signalling path in the future, and if we're doing that at the g=
puva
> >> >> level, we also get rid of this kref dance, since the va will hold a
> >> >> vm_bo ref until it's destroyed.
> >> >>
> >> >> Any particular reason you went for vm_bo destruction deferral inste=
ad
> >> >> of gpuva?
> >> >
> >> > All of the things that were unsafe to release in the signalling path
> >> > were tied to the vm_bo, so that is why I went for vm_bo cleanup.
> >> > Another advantage is that it lets us use the same deferred logic for
> >> > the vm_bo_put() call that drops the refcount from vm_bo_obtain().
> >> >
> >> > Of course if gpuvas might have resources that need deferred cleanup,
> >> > that might change the situation somewhat.
> >>=20
> >> I think we want to track PT(E) allocations, or rather reference counts=
 of page
> >> table structures carried by the drm_gpuva, but we don't need to releas=
e them on
> >> drm_gpuva_unlink(), which is where we drop the reference count of the =
vm_bo.
> >>=20
> >> Deferring drm_gpuva_unlink() isn't really an option I think, the GEMs =
list of
> >> VM_BOs and the VM_BOs list of VAs is usually used in ttm_device_funcs:=
:move to
> >> map or unmap all VAs associated with a GEM object.
> >>=20
> >> I think PT(E) reference counts etc. should be rather released when the=
 drm_gpuva
> >> is freed, i.e. page table allocations can be bound to the lifetime of =
a
> >> drm_gpuva. Given that, I think that eventually we'll need a cleanup li=
st for
> >> those as well, since once they're removed from the VM tree (in the fen=
ce
> >> signalling critical path), we loose access otherwise.
> >
> > Hmm. Another more conceptual issue with deferring gpuva is that
> > "immediate mode" is defined as having the GPUVM match the GPU's actual
> > address space at all times, which deferred gpuva cleanup would go
> > against.
>=20
> Depends on what "deferred gpuva cleanup" means.
>=20
> What needs to happen in the run_job() is drm_gpuva_unlink() and
> drm_gpuva_unmap(). Freeing the drm_gpuva, inluding releasing the assoicia=
ted
> driver specific resources, can be deferred.

Yeah I guess we could have unlink remove the gpuva, but then allow the
end-user to attach the gpuva to a list of gpuvas to kfree deferred. That
way, the drm_gpuva_unlink() is not deferred but any resources it has can
be.

Of course, this approach also makes deferred gpuva cleanup somewhat
orthogonal to this patch.

One annoying part is that we don't have an gpuvm ops operation for
freeing gpuva, and if we add one for this, it would *only* be used in
this case as most drivers explicitly kfree gpuvas, which could be
confusing for end-users.

Alice


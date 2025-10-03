Return-Path: <linux-kernel+bounces-840898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F034EBB5AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 02:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9B894E82A5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 00:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3C23BBF2;
	Fri,  3 Oct 2025 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2wByUPO"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C11175BF
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 00:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759451504; cv=none; b=Jf05B61/Kz9jE4LtcMQCEdvfwbW2fTRB6EdQMFFywAIfAl/OrpREglUdsXjbxWLLytpLTfqrhgKUakPFqKP4U0UDfPs5hh4BMWv+i/VkjyG4GpICEHdT17QvYzuOIc/xDKVCotM+hPCHrIDTbOS7GH9sdJkZ3H+hpXcRi7dxPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759451504; c=relaxed/simple;
	bh=dMj5WRQV/om9Nj61vhT+zYSNzeMigXFUlTwcU8SQkmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yj3ekOv4tkvLpFG82shXyqnSExxf6ejuWloPNiHLurzZ2mkCHWYbs3FjV3+5ABhvHUn9RPaOPK3eLtvKQtMe76gFEifOL9GHyogYfUagbBgeSciqVVQRbdQ3SS4rEoP9asEc3ShP6hJxrkO+G/Fk6ogyclqezC7N9fst5Lq5GLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2wByUPO; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d6083cc69so18789267b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 17:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759451498; x=1760056298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4U5pnCPEOjyEvJTXMjyeqBkkPLwp0u6MFGFXx4Pna3U=;
        b=C2wByUPOEjG7SP4az4ZS1sipfN/CeV4+LbpkRAaX5r/TdttwFX08mZt5oOvb5Ot/pw
         c8aqn1QIidYk/e5McbFdZxD9JPg1SFJZFgsedu7K2EPDL7/3cCfDFeaPgaOLPh1AoNC3
         6mts2x682vQgJWZ9aQTfpL97XCl3lAfBChQpyIoKhBkxalC6lJ+4dx9efOgFYYczjYQI
         xNHWYWyiGhTl1l/1Otg2D7f7qS4osq3TyNuEyeL94FBWNtT16xNnBTCDJSYuwgDroF+f
         R7iIIBQ8cNdhjBeJzZ8mWmhNwWTZ5ljzy3OTi2JXTJM8ZMIZ70YiH24LXm2xjQhvBsby
         VjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759451498; x=1760056298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4U5pnCPEOjyEvJTXMjyeqBkkPLwp0u6MFGFXx4Pna3U=;
        b=UTxl6vk6qNSrcyIzvwfGZ47gIddEGSW0LEV2+epxb9bvawfJofZ1W8so445f3cPnvc
         FypK6M+9b03hhhRqcvSz9rQ4A/0mnOQmy6aN2NbPlzCYwSPCW0anMqLlJS/cIqVZ2LMO
         gnNcmr7t75ZW46e7HYb6bfuJ+CywK/L1g36y/35f89bdev20VkogRCWbSVgnKlkEGZ2b
         MrEe+GkVDxoAvuWpMUM4sdTNFpnL0ONRlsQWNuJTSpwF6Un+726Nyn+Qxrgzy/GUgqzi
         eAvWK1q6rvV6+MIjUsrlttZnDoQuipS0GmDXUiCv68hsiyLFtrFkUv6lZS1XqGPSJUHO
         fnzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKmgAx4zLoOOvp5jf6cwOWEvbnZdWU5YIdk9v/xR02wYBOx2VYWK8UbOCOXzxTNnlS5OLTl75nGUJ9K/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKa8lBu+d7jsoR/wDCBJkMGuYVCv5glblLQte6czLqJUYK1jVg
	Gy26WEcppiH7fFvEZckmQBBwBgnABWlrY91o4q1ebOob78Jd07x1iT/d5JiZWl+1ZkTOgcky0CH
	/iI1vSeqU9PC1tjS1OpaP3bJxHde98vw=
X-Gm-Gg: ASbGnctFls01bY2BGskDb1li+RkdQg1RjFLdrY6AogaJGQosljQzMbNl08NiAGZSZ4D
	0+g1lmHSqsZvuhDNgOcul0WytyXa9Jt+IGU9nhFrE3jgvxGhTFbLohOPc8TeTiEZUAiLDC5TZSa
	g7KIGAQ3MJoO6M2sNlPbXVm6nzIJuGhlEp2a7R2ATuQlsGsiGHUQcoZqPMFg2MDaOjqGJT1l6w2
	gSi5JQDwxchozCrz1HH+naPC/z9IFHm3XlGXAKrutNnecdJsdcRgrekdWnCu6OREHKl3+iFiwnS
	J40ZQvf/1EODNZrjgSWQ
X-Google-Smtp-Source: AGHT+IHSk85RSXIwuchkQqF0A/BvXRnC9Gw/LAQoBVBK/mn507GK9IZBmwwY+wHxNq7PYiIbBOsMUewMXpSTJIlxPWM=
X-Received: by 2002:a05:690e:159a:20b0:629:e2b6:1302 with SMTP id
 956f58d0204a3-63b9a07171emr1133628d50.17.1759451498517; Thu, 02 Oct 2025
 17:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916210823.4033529-1-olvaffe@gmail.com> <20250916210823.4033529-6-olvaffe@gmail.com>
 <ca22f80c-c233-4030-81d1-f425b8c1fb83@arm.com>
In-Reply-To: <ca22f80c-c233-4030-81d1-f425b8c1fb83@arm.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 2 Oct 2025 17:31:27 -0700
X-Gm-Features: AS18NWAjq-5mQlMvXdR4W6e9qPj0GEnhhIeXGsj7lk4Tej78VBVZlV1t3dCSgZk
Message-ID: <CAPaKu7RKDwpSqJ6u8mjcc4G0Z-T7G1LxFw2rXQtxgSW=1_-jkw@mail.gmail.com>
Subject: Re: [PATCH 05/10] drm/panthor: rename and document mmu_hw_do_operation_locked
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 3:41=E2=80=AFAM Steven Price <steven.price@arm.com> =
wrote:
>
> On 16/09/2025 22:08, Chia-I Wu wrote:
> > Rename mmu_hw_do_operation_locked to mmu_hw_flush_caches.
>
> This is confusing, you've renamed the _locked variant and left the
> wrapper mmu_hw_do_operation() with the old name.
The commit message says "rename and document", and I try to stay true
to it. I could certainly squash some of the commits to make this
series less confusing.

>
> I agree "do operation" isn't a great name, although "flush caches"
> sounds to me like it's a function which does the whole cache flush dance
> in one go, but it's still the same "one part of a cache flush operation"
> code.
It gets the name from being a wrapper for panthor_gpu_flush_caches.
Which part of "cache flush operation" is missing?

>
> Thanks,
> Steve
>
> >
> > Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_mmu.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pa=
nthor/panthor_mmu.c
> > index 727339d80d37e..7d1645a24129d 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > @@ -622,8 +622,20 @@ static void mmu_hw_cmd_unlock(struct panthor_devic=
e *ptdev, u32 as_nr)
> >       write_cmd(ptdev, as_nr, AS_COMMAND_UNLOCK);
> >  }
> >
> > -static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, in=
t as_nr,
> > -                                   u64 iova, u64 size, u32 op)
> > +/**
> > + * mmu_hw_cmd_flush_caches() - Flush and invalidate L2/MMU/LSC caches
> > + * @ptdev: Device.
> > + * @as_nr: AS to issue command to.
> > + * @iova: Start of the region.
> > + * @size: Size of the region.
> > + * @op: AS_COMMAND_FLUSH_*
> > + *
> > + * Issue LOCK/GPU_FLUSH_CACHES/UNLOCK commands in order to flush and
> > + * invalidate L2/MMU/LSC caches for a region.
> > + *
> > + * Return: 0 on success, a negative error code otherwise.
> > + */
> > +static int mmu_hw_flush_caches(struct panthor_device *ptdev, int as_nr=
, u64 iova, u64 size, u32 op)
> >  {
> >       const u32 l2_flush_op =3D CACHE_CLEAN | CACHE_INV;
> >       u32 lsc_flush_op;
> > @@ -680,7 +692,7 @@ static int mmu_hw_do_operation(struct panthor_vm *v=
m,
> >       int ret;
> >
> >       mutex_lock(&ptdev->mmu->as.slots_lock);
> > -     ret =3D mmu_hw_do_operation_locked(ptdev, vm->as.id, iova, size, =
op);
> > +     ret =3D mmu_hw_flush_caches(ptdev, vm->as.id, iova, size, op);
> >       mutex_unlock(&ptdev->mmu->as.slots_lock);
> >
> >       return ret;
> > @@ -691,7 +703,7 @@ static int panthor_mmu_as_enable(struct panthor_dev=
ice *ptdev, u32 as_nr,
> >  {
> >       int ret;
> >
> > -     ret =3D mmu_hw_do_operation_locked(ptdev, as_nr, 0, ~0ULL, AS_COM=
MAND_FLUSH_MEM);
> > +     ret =3D mmu_hw_flush_caches(ptdev, as_nr, 0, ~0ULL, AS_COMMAND_FL=
USH_MEM);
> >       if (ret)
> >               return ret;
> >
> > @@ -702,7 +714,7 @@ static int panthor_mmu_as_disable(struct panthor_de=
vice *ptdev, u32 as_nr)
> >  {
> >       int ret;
> >
> > -     ret =3D mmu_hw_do_operation_locked(ptdev, as_nr, 0, ~0ULL, AS_COM=
MAND_FLUSH_MEM);
> > +     ret =3D mmu_hw_flush_caches(ptdev, as_nr, 0, ~0ULL, AS_COMMAND_FL=
USH_MEM);
> >       if (ret)
> >               return ret;
> >
>


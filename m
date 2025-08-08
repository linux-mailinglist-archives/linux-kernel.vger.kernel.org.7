Return-Path: <linux-kernel+bounces-760495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FC4B1EBDD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1D744E4B8A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E79283FE6;
	Fri,  8 Aug 2025 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnPuy2PS"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9CD283144
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666905; cv=none; b=ZrskrpH567lwbrsyWLines+hZp3RrhC3gM8RzDIDgsui7NJSFPkWpA0Qy4EOsVVgWvoj/oZarMX/p3SEFzYxUZsPgFATXHxaYf6SvFO/nVJsnvkLG0S67dE2X0JDKYxpVcoohzm1XE19p26tFs474VIH2BZnbIuib6o1W5JdB84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666905; c=relaxed/simple;
	bh=7RTYirjLHv3G4zGf3WA9CYSYk0uHhcsi7vLPH3ckMZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/oCDE3hxfsLtVkcVtfuR/JQjd1X8aUckM6/jU1Tg6jz+GHnwoVUIzQaP425OC8HtFiLJEcfbPEjvqJbNaZ0580qYDB4Q1OJOsvQfOv9rpPAGgrbJq+YfULo4Z8BidRWcxOUyO7vrl0OtmIHoSJd7gOjQvVvTyI6mHYM5ii4iiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnPuy2PS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2420c9e3457so3236645ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 08:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754666904; x=1755271704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaFrKONgoeL4lo44H8m0yP1sT0L2wqE/7af3cuPE8mM=;
        b=jnPuy2PStKP5cgd63BKmqW9y6uJIAgM4D4usKJEerZJ+GjBA27md4Pf8TMAYEpGOiX
         o+H2aAjn4UesIUmxHyqa3EZlAywrK22vHdm1W2/uZKJ/PhylEzmL8Yx3iobyNS7daKjE
         VNVY0gTSITiCVvbgconUGISmLVlI/SJypWFG3M/6LSmfM5uGQeds/ENEvM/QjZracboc
         AlniTbLu9UFs+i0TztUKZI1WffAJKGJazCrSsCvL+CFevJPxppJ5/5xcNJvkdoYvDOjG
         8qRXtixT2z+bAOuaIYFWLrTnhNOl+U7zht4FMxgmby9HsflnBgK7xLq1RHsv/8ITSIAX
         NrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754666904; x=1755271704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaFrKONgoeL4lo44H8m0yP1sT0L2wqE/7af3cuPE8mM=;
        b=EpaEwpXBrSCE0sExy3rna61qerITeVZRQnRwTJIetk8FxzwXF1wGGH0P68sn6nyV3U
         OlKxUjeDR/Fz3qa/XXVP3fTajj2j92prSgD5LSrFD7M4JYyCasJXGCAn+x7ztFKCIE5O
         SspewoNZWNWhOfKTF9L++4ajYMKlMSIz1JUkrBoPA/J4TijbkfvYJAK8k7kdr09TwxKY
         WUPgB155e4f1q6nHcVnGGZ99ebt5xNvfYil6hEz66f6ErHHjS9AwZdUEDLp8grXox9TJ
         b+dYWoMbR8+mAhiaV2jBVrsHFGaitGR96S81MZcV7Rq5+LDQ2v2+AHnFRomWw5o0Z9o5
         IoXA==
X-Forwarded-Encrypted: i=1; AJvYcCWORjYHs8tl+NUYCA2soIiy33KeQF9h7R/8826g1vilWmPEl63VSw4zqXEIwGtFbSEyhZ3Sn9iDqHxLPZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTuXsfBHgAjmmwWUm09r40YYgszvWF7W9+hyGtGAOTJuiiCrRJ
	U1XUmuUKkKuAIrQ+sf5c4UQ1EJxnxOVESOUscV8Naa4qWKubGESQ1+3N5hWpuGG0C7zFGB8kJjP
	IB7Jv93e2sPFkRqnpeCxP2EPngcLuHMTmPw==
X-Gm-Gg: ASbGncv80MQux429KmmWQ56Srzyk7Q3PrJd9RJOdodV5UMG10GKZTmskzV23Lyzf6CM
	y44lWN9v3SQLnpViSR3dv6FiPIq900k3VGOK4vZlosY49mWb9jBAuCZxK7tSU0O/to9sxa1Ipf8
	TovONe5gax1u5/QG0UZhSYaOowxWiRVdqMgGAStRLSsClIK+hueWXu3HIqVHg97D0cTAHT7jZJI
	WZltKw=
X-Google-Smtp-Source: AGHT+IFzRj3NfvXhNRMeD3rfS4OdzgKDkzQX8MeXfQwdZ7fG5fJW/ZicXqdjPbYU0XmStRk+Dm+B6kak+q+dt9nZcq4=
X-Received: by 2002:a17:903:18c:b0:240:3e41:57a3 with SMTP id
 d9443c01a7336-242c19a673fmr25580745ad.0.1754666903728; Fri, 08 Aug 2025
 08:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806-amdgpu_typo-v1-1-b5a3cb84ce26@uniontech.com> <6e5b5c47-a97c-4757-ac0d-361c91fd5819@amd.com>
In-Reply-To: <6e5b5c47-a97c-4757-ac0d-361c91fd5819@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Aug 2025 11:28:12 -0400
X-Gm-Features: Ac12FXzCfzGrH3JJl3Jc7p_DPcZK5W4BmsxzZKT8lvCDvMABrJkVyay7b_pzNV4
Message-ID: <CADnq5_MXNfXfjKZo6VRXk8xBr=TRbQzHGq2-7HyHuBcCtF+KPA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix incorrect comment format
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: cryolitia@uniontech.com, Alex Deucher <alexander.deucher@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	wangyuli@uniontech.com, zhanjun@uniontech.com, guanwentao@uniontech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Wed, Aug 6, 2025 at 8:38=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 06.08.25 05:34, Cryolitia PukNgae via B4 Relay wrote:
> > From: Cryolitia PukNgae <cryolitia@uniontech.com>
> >
> > Comments should not have a leading plus sign.
>
> Good catch, potentially a left over from a merge conflict or similar.
>
> >
> > Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/a=
md/amdgpu/nbio_v7_4.c
> > index d5002ff931d841994ca2c70cdf5b989f5b3c59d6..860bc5cb03c81b5346743b5=
fb46a7dcbe5a201a4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> > @@ -151,9 +151,9 @@ static void nbio_v7_4_sdma_doorbell_range(struct am=
dgpu_device *adev, int instan
> >                *   BIF_SDMA0_DOORBELL_RANGE:  0x3bc0
> >                *   BIF_SDMA1_DOORBELL_RANGE:  0x3bc4
> >                *   BIF_SDMA2_DOORBELL_RANGE:  0x3bd8
> > -+             *   BIF_SDMA4_DOORBELL_RANGE:
> > -+             *     ARCTURUS:  0x3be0
> > -+             *     ALDEBARAN: 0x3be4
> > +              *   BIF_SDMA4_DOORBELL_RANGE:
> > +              *     ARCTURUS:  0x3be0
> > +              *     ALDEBARAN: 0x3be4
> >                */
> >               if (adev->asic_type =3D=3D CHIP_ALDEBARAN && instance =3D=
=3D 4)
> >                       reg =3D instance + 0x4 + 0x1 +
> >
> > ---
> > base-commit: 6bcdbd62bd56e6d7383f9e06d9d148935b3c9b73
> > change-id: 20250806-amdgpu_typo-80869b122c36
> >
> > Best regards,
>


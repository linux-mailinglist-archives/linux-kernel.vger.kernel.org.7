Return-Path: <linux-kernel+bounces-722860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC59CAFDFF9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348C74A7494
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBA826B2DB;
	Wed,  9 Jul 2025 06:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctWY8bFv"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C857B1B4153
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 06:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752042854; cv=none; b=aHVxslF+HImzOv8w432F/GmGMLQr84oo3TzdAqnSdWqjAzqZpiM0fxQOBMXs6zKoTJEC2HaHVDJKys8+gKMD2DCc6VtZV4ELKI9jAw07ERpImzSHE9OAxYkVeRGkHMWjupiD3kIpxlyi+OXNjoNUSURD3DuGAeSo00ZvlYdU8Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752042854; c=relaxed/simple;
	bh=DMmKdH2LlUyDyDEWJ3r3ROcYn+v5xI+1H76HITCAuGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKGiEJ98ofWOp8n+CO4Ox8hu26e+d+O9V5LIh9mson+chgwpldl0QvkMO645D5aBism6YN6HfFoGunly+iUcP7Fq/+Tj/nWiBP9uFxXnSFDzLEcJ69YJTd6ZuEnxFIPwcpY71UM+ocgPnoSypgpwlABxLMKTZHXDvUjeQfhG8U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctWY8bFv; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-52b2290e290so3643971e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 23:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752042852; x=1752647652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9aod6BXjQrO5vyW4mRKpBJMwKOe6N1K/J0C4KFxzP4=;
        b=ctWY8bFvn+Sjc+mOUaltlHnFJ8Jorro1jYk+bdxszHkZyeuA4F7Ya7xicmYLNQ1g4F
         uQIjcD0gJ+0UuMRxnQVNxqGCR+TLcZMqNeKqv1YEsalPqsTScGWoIeou2tIsNagJ0Xeh
         iLtQ9f4LqURmpeJ9wN5k8Y9VgGbSNARyy/3oLHYzKueEv6uNtpoMEa6Ia6O0Llme5xQF
         hVio1a6FxMElBM7U78XAoaB/010V+qJurj7RkPNT0bLIpM0TRb+tONEw77gmtfKzxAAw
         S3hndnHJVtpTXMdTfYkIp0jTfFAuZ+A4Ib7wAiZAdYCj587C/V0h6bqQJTrvEEwQtGID
         dF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752042852; x=1752647652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9aod6BXjQrO5vyW4mRKpBJMwKOe6N1K/J0C4KFxzP4=;
        b=eG1oR/uvz46nA2jHv2GaP0WxihIye/yVqf17nDAsRWfoG7Q+hgqySSY6R+Xt7nX207
         SafUYpCwrgVO59sU/XzKivH4HxSU9Uxy4gPARuaHLAuvAYLWstPqgzP6njBTuis9Vd9D
         I1qpvZ0PKiYV1Kxow5lp+ssqjzoVHoWRheCn0AKurLLewDyUbKdj+apykOky4aKQDcpi
         e6EX/yFB6QhXsQih7MS/PtbREHIJDIgo00oHk6vQ1pENBQBwD8fwvCP3wrO/V6KdA0Zg
         Hihw75E9EaQUHCLJO1UJrQf89b+buU7e8uA87so9yfa4NxRQxoyZIKTq5+lr8bXERCoc
         MkaA==
X-Forwarded-Encrypted: i=1; AJvYcCWUzL2YjyUiQvXuIY644XpIACswdE+eq1Z3z4Rp7t/BrbwbE+rTr4cFNRDCiXldxWD5ExvfJB7D2ry4LgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxabL36+yU5Et3cYbZLzr5xX1bu8Ks67xhsAb7AEjXMDj501ZeU
	UYJt10iIo/5qmvh/bqy2Qp7hlWhIw7sTt0jfV7rzEty2UOWCLUubdpKSbuJzg8zg+vWpPxyoZrw
	f02q0m1FLLiE94DVixCj5jL5x2pn6jnM=
X-Gm-Gg: ASbGncskrhy9lOA5nZwcLiajH1d+afb0FtDAhViASmFdcJFzcEBE12PmzaARsvLJmJz
	7+EC0WJw68H6DouFt3dZFRLJN5Qu53HrLXnkdvgKRX0YZBTxtPh7SLFxo+m4rQzY8qk1i4AHz4q
	cE3VmWPD0WByLgTn/m0Q+4H3cUHuQNbFUdbEVsWwpySQ==
X-Google-Smtp-Source: AGHT+IGzn/x16pDQ53vI1j1ojRFLBVig/bMF+fcC23ilzSsODhT507fDhgyOaAudI+CHcvleaZ8z6iN2Q55SLHQEmyU=
X-Received: by 2002:a05:6122:80aa:b0:531:20dc:924 with SMTP id
 71dfb90a1353d-535d7443235mr586641e0c.11.1752042851298; Tue, 08 Jul 2025
 23:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2b83380bf64a424b9cb902a20a244c3e106c4bb8.1751702072.git.rabenda.cn@gmail.com>
 <56e7ec54-9820-4e02-be97-2a9e1dedd117@amd.com>
In-Reply-To: <56e7ec54-9820-4e02-be97-2a9e1dedd117@amd.com>
From: Han Gao <rabenda.cn@gmail.com>
Date: Wed, 9 Jul 2025 14:34:00 +0800
X-Gm-Features: Ac12FXxapUUsFofuo853oFqC-peo6coLRLtZLPkqC5w7REiJr3Q5hyQm71Fknlc
Message-ID: <CAAT7Ki-pg+E83xMCmES+VMWFthGuLMTzKdSbDak0OEMR6kfL0w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: enable kfd on LoongArch systems
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 6:12=E2=80=AFAM Felix Kuehling <felix.kuehling@amd.c=
om> wrote:
>
> On 2025-07-05 04:05, Han Gao wrote:
> > KFD has been confirmed that can run on LoongArch systems.
> > It's necessary to support CONFIG_HSA_AMD on LoongArch.
> >
> > Signed-off-by: Han Gao <rabenda.cn@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/a=
mdkfd/Kconfig
> > index 62e88e5362e9..b2387d529bf0 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/Kconfig
> > +++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
> > @@ -5,7 +5,7 @@
> >
> >   config HSA_AMD
> >       bool "HSA kernel driver for AMD GPU devices"
> > -     depends on DRM_AMDGPU && (X86_64 || ARM64 || PPC64 || (RISCV && 6=
4BIT))
> > +     depends on DRM_AMDGPU && (X86_64 || ARM64 || PPC64 || (RISCV && 6=
4BIT) || LOONGARCH)
>
> Is LOONGARCH always 64-bit? If not, please make this (LOONGARCH && 64BIT)=
.
Got it, will submit v2 later.
>
> Other than that, I have no objections to applying this patch.
>
> Regards,
>    Felix
>
>
> >       select HMM_MIRROR
> >       select MMU_NOTIFIER
> >       select DRM_AMDGPU_USERPTR


Return-Path: <linux-kernel+bounces-822828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48213B84C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D354B54567F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28125308F22;
	Thu, 18 Sep 2025 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDvHmuzm"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E57E215077
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201144; cv=none; b=VaR4Q32Msmw/DbgF4ik5mkzhJzMRq1W3lSsAmxzZ8/crAKXRCacKodmsT2hLAbD4WZunBceYdX6BObVMgMHLaYgjUCzCHO+GdisgWln0Harrrfr0mhStc21ej8Qb+NHN/HIntuhSUD962uShS/vdXzzRfQYIhPqOPdQ44HjlAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201144; c=relaxed/simple;
	bh=ZLxT69O2gSyWg52xQm3YXSUFli9jeiD60m+YcwAVNlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTMcPfqta5vqNkqji2ucKsrhz+07UOq+rT+7F24rV7TCAOmc3I7s9P3a573omKHB4OvkdM6+RsJsqU8nbVlPLTWk7uW1GRvUKtGOjx8SBTtJeCRN5r3AbB2OfXYM8XlGw1fFnjupBiltIWnUENiwdPVgKTZTTQWfWISnjbLkVao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDvHmuzm; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-267dbd4e189so1939785ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758201142; x=1758805942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ow/FekpgA7UhV9Mvh36laSeW60WQ/h2Ti7HkmGFnCsM=;
        b=dDvHmuzmmePHl+XNe66WuGEMLQDlzES7k6uW/6JNVhqpEkzaoTKkgURwMFO+dCtPDF
         EtLnD8UkvHm83MY3LsD/KhpPcfhf2Z3GPqqwYsXiNfZzwzQEssDavn6+1dQyE58McNDG
         jLRJ4HU/okKdgR6OuMEI+vWsA5Q1i9cusUoxe+PEZuZvp+N2vERX9EN9QQOg2kijzryk
         x3rdPY+ZP82ApEnPIqfwUwcEhrCJfvsPDoiBpe/gY+LvZRjrfNJwcafH/2YeRl/PmHbG
         jOZkChvC4Yik5rT/jFrDFtG3DRWQAMNTQvn9sfqFa6aUUribzMJxu6K07sBAg1T8j73b
         YXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758201142; x=1758805942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ow/FekpgA7UhV9Mvh36laSeW60WQ/h2Ti7HkmGFnCsM=;
        b=r951dHkrgSP+YGfjK5JEcR37H26qSW8DGGLc2Xrqu8l9pMhU3OE/esqMdDzkS3rskx
         7yFk2Zqg+Cew7jV+0wuTBeIu/fFX+oKrlt4rV08tnG6Uwd7R8cMbLBth3lGmoLTCdQJ8
         kPjNgG1TZn17lGdfQbwgcU1R3QnoLk7deXqXD2pkzYR4TM1BgpWZdwHO6uxR0hWQBWMT
         dC0DC+5aO73u0ZPAASmtKzeXK4cqN0TPpmSkVWJlxAqOPKSjoBfL1OTxgwfCwDxFhMD3
         UmRDd7M9IM3a2Unj/y0Hy9nUymbX9knWLAZpK1wPuDn1eurJkOFswGn3bGkczKW6bTbX
         sfJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA0vgSaxapnwWJfS86R5SP/+jZOHeyAaBKZwoJY9n3B/XrD+UyP+Oo1mF0WokJ1Nq54CfG0fEV4wJju9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwUe8Q37R0FFA6MFvXUWjRW1GG2m2kMPzWk7aWSBPsDM79foCo
	bmwBsNNLZXn3ATRDWZC0nzELbhkeo5isNpHEGN4sLCE5T4KFnN6kRhlRuw7axJ1TwxptljKc9jF
	pyYxnlhmiBk5lXjLmJX0u+7ojOXSzzQc=
X-Gm-Gg: ASbGnctcCTc6gRfZ1FSLXtJnljpUDySdAEW1a+mRwi11ksN4M5jIVfEPvHNcAUOR99p
	UcMks5E4O3zK6E8j8Y4RyPT7O3cBMfqBiScIvnv5M+eczPGOLp1ax8nArPFtZogJ5AAUQy9ONE3
	SfxA1+ysDWCQoFwcdGlFbD2ibi+jJAOfIsneUDl8dHEqUvLF9gyNOVRZzNR2XAJkDrQHCMgp8ss
	g+uf6tI4/bqwKYAeQGqqmYvqt0=
X-Google-Smtp-Source: AGHT+IGPGpvPJnDMA+MU6VEF8DQ0xnGm1dy+iqzuJdF1p3969ZuqYgSVs9i3T569keWH/YmK9RWABocwx0S6kTCDWjQ=
X-Received: by 2002:a17:902:ce81:b0:269:9ae5:26cf with SMTP id
 d9443c01a7336-2699ae52d42mr9215285ad.4.1758201142273; Thu, 18 Sep 2025
 06:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918105705.3480495-1-lgs201920130244@gmail.com>
In-Reply-To: <20250918105705.3480495-1-lgs201920130244@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Sep 2025 09:12:10 -0400
X-Gm-Features: AS18NWBryzMXeisWyksAUCkLKladPwFh28QPE6dGbAFuIaGpcNhnEsksRdkuC1w
Message-ID: <CADnq5_NQMQNpa7=MW4LXHvnKWTc4+QSEoA0zsNqpdfEV5Ho0SA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/atom: Check kcalloc() for WS buffer in amdgpu_atom_execute_table_locked()
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Al Viro <viro@zeniv.linux.org.uk>, 
	Kees Cook <kees@kernel.org>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 8:44=E2=80=AFAM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> kcalloc() may fail. When WS is non-zero and allocation fails, ectx.ws
> remains NULL while ectx.ws_size is set, leading to a potential NULL
> pointer dereference in atom_get_src_int() when accessing WS entries.
>
> Return -ENOMEM on allocation failure to avoid the NULL dereference.
>
> Fixes: 6396bb221514 ("treewide: kzalloc() -> kcalloc()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/atom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index 82a02f831951..bed3083f317b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -1247,9 +1247,9 @@ static int amdgpu_atom_execute_table_locked(struct =
atom_context *ctx, int index,
>         if (ws) {
>                 ectx.ws =3D kcalloc(4, ws, GFP_KERNEL);
>                 if (!ectx.ws) {
> -               ret =3D -ENOMEM;
> -               goto free;
> -        }
> +                       ret =3D -ENOMEM;
> +                       goto free;
> +               }

What branch is this patch against?  This doesn't apply as is.  I've
fixed this up manually and applied it.

Thanks,

Alex

>                 ectx.ws_size =3D ws;
>         } else {
>                 ectx.ws =3D NULL;
> --
> 2.43.0
>


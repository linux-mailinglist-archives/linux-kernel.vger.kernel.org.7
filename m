Return-Path: <linux-kernel+bounces-765268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F073B22DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71063506392
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1042F2FA0EB;
	Tue, 12 Aug 2025 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaYl0haz"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9C12F90FA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016235; cv=none; b=ufqwCNy1b3yLZCB3ewRDKNc+VJRuYX6tExNmkFIO4X+njj5errA0zNAInw6gqflY5FM1PRCI/uWbMrvkJv2uj8UFhG/zLDP8Mls6STv5vvm+T3GKOtm6eqs8IfqTfxQFjtjWhkoQQ+QySXUzCwGtKacLgkALnIZqrYmxuxjWuF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016235; c=relaxed/simple;
	bh=3j8xKXkujeUjf5e9rY7vG7l6sIwASGILa12VI5a38Lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0gMi9dAn5QS0l8g4IhagKhG9YDlpzPyuH5Ati6s6eldi/OlS5wBVpFWeXZrQBM0AsDkgV3zDtagsEsJct64iuD6lSLQu0nH3e2UCFPl//lOCm4HI0EPYMY7Q3KaL3vMy41uJEWsHeAp7Gm4QgbUlVC34evoXb62mINLTLTXzLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaYl0haz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-242abc28161so8790755ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755016231; x=1755621031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8T/1xH98koL02eKJOzZQVca6m36I5E4mnDKNc4f/Gc0=;
        b=WaYl0hazsfiPdI4TeR3+6OYNvBLmpPNUPuiwX5es6rrq/5aHvCxPiNDJ94Dkum/zsR
         HxR+pX7lP937FF3U7bEh2qyuqNRzicpnV//CL7lwoS3BBlOhw2Mki9j0809BA3UgEcV6
         d8k5nvpzKEYW/Bm3swh6OldqP5/bi9iWeku5w/DMTVdmIUu4paxb01OB7hZqJOM62War
         qnh3Rw0KqV05yPhKLZhpIyynfpFcwo1x5UkKthg4VMlp0Nbjs6hRk2rzVbGkvUP8aNed
         nE0QAoDjFlRagXC+Ctzbf8WPfNg1FkhgOtErWHn9+8Y4Q0qOSZ8VasqGKACTDVdvUKFs
         Ni9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755016231; x=1755621031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8T/1xH98koL02eKJOzZQVca6m36I5E4mnDKNc4f/Gc0=;
        b=pMMnLq6uRrABXnSyuLmx9iOKhXwNO1CjrTqrpXJ+IA2ca8Ckh33i174XO8SZAA+QqU
         gpXhs0ZPCXO10AojVJqbBrqrg3kMs5xkl5dZsAE0RkPqmQbaWM2JQK0LGyj3FC9HCQ6Y
         jIuifE14YWI3cnK2FAx5Lw9r6yp9yUOSbkvKtuDxuW39tz0PoBQ0apHT34JcihVl+VDi
         v3mFdtGLT8BklY7QBWAYShTbHYC6cCOLFto8EsS5d/Ulr+ucPvJzGumcDT68j5SnHCfP
         WyWOY2WurIHHv9jlrHIo5y7VTNtTJ2tHWUYUStamLUieiEPYypPODhy4WlQEfTVwD4TY
         Sfow==
X-Forwarded-Encrypted: i=1; AJvYcCXWMmPXYakZlnZleHcgXU2/7PZAI8rTstuEhvugKPXj5XMR1SGIH6ck4a+wWUBitFPMhJREO6nE1AaSHw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHpLrxpFpr4QGAiAvPPmwjG6JRV2kpYzj8sNRMqIGr/w1psF1h
	umK5PYM2833cE3a9eC351mc1S9hai0CVTQM0Y5d3RwtTLi3uiLiGLGc+wRw9zYlAvVZ5K4RoAXu
	mS77RLTdL+D00nVyOvXAPKOY3mJz9sVQ=
X-Gm-Gg: ASbGnctGLJuI/G53UTWqa+aoRa6ZngberArDXxrC8NdKqDKmt9P2ZIE167x/0IP5DHq
	QEe2jseIHPn/cMptUgc9Hvx3cSLnHp8mvKvPZSOtvNc3gy+XA+91Swrh87NII1X8XjNBiGsj8OF
	k5Hft7iw1dcOlsRl+48ZiRrPr1cWc/ipxDLpRsaV10cEid4F9TqYokjp5GL9rtx1mXGaVMBtgOd
	SiSsjs=
X-Google-Smtp-Source: AGHT+IF6LenLB7j3sb0DjrhGCwQFdll3J05cq7yX/orGvMVj4rpQ84UCdUaSMteeycXpCZf2PJiFy6FVwOGq6PrKN7s=
X-Received: by 2002:a17:903:2281:b0:240:711f:2068 with SMTP id
 d9443c01a7336-24306d87e8cmr13447905ad.7.1755016231149; Tue, 12 Aug 2025
 09:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812031603.463355-1-zhao.xichao@vivo.com> <0811e8e8-5990-4880-a2cc-f9bd6b3ec4bd@amd.com>
In-Reply-To: <0811e8e8-5990-4880-a2cc-f9bd6b3ec4bd@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Aug 2025 12:30:19 -0400
X-Gm-Features: Ac12FXwysyVxVP_3MLSXv30V9nQuvTxCQ2luc4NpmdCvnL8zlEQC9gaSc1twh5g
Message-ID: <CADnq5_ON4rM2LRAw88iyBCTVJ+nB61-EZy2vxLVc48oxk=Gbew@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: replace min/max nesting with clamp()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Xichao Zhao <zhao.xichao@vivo.com>, alexander.deucher@amd.com, airlied@gmail.com, 
	simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Tue, Aug 12, 2025 at 2:49=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 12.08.25 05:16, Xichao Zhao wrote:
> > The clamp() macro explicitly expresses the intent of constraining
> > a value within bounds.Therefore, replacing min(max(a, b), c) and
> > max(min(a,b),c) with clamp(val, lo, hi) can improve code readability.
> >
> > Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >  drivers/gpu/drm/radeon/radeon_display.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/=
radeon/radeon_display.c
> > index b4bf5dfeea2d..d66c1a30df95 100644
> > --- a/drivers/gpu/drm/radeon/radeon_display.c
> > +++ b/drivers/gpu/drm/radeon/radeon_display.c
> > @@ -926,10 +926,10 @@ static void avivo_get_fb_ref_div(unsigned nom, un=
signed den, unsigned post_div,
> >                                unsigned *fb_div, unsigned *ref_div)
> >  {
> >       /* limit reference * post divider to a maximum */
> > -     ref_div_max =3D max(min(100 / post_div, ref_div_max), 1u);
> > +     ref_div_max =3D clamp(100 / post_div, 1u, ref_div_max);
> >
> >       /* get matching reference and feedback divider */
> > -     *ref_div =3D min(max(den/post_div, 1u), ref_div_max);
> > +     *ref_div =3D clamp(den / post_div, 1u, ref_div_max);
> >       *fb_div =3D DIV_ROUND_CLOSEST(nom * *ref_div * post_div, den);
> >
> >       /* limit fb divider to its maximum */
>


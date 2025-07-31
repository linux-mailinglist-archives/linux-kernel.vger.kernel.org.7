Return-Path: <linux-kernel+bounces-752631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 914D9B17861
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCCD91C23EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61306267F53;
	Thu, 31 Jul 2025 21:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjHSYwVl"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C343C38;
	Thu, 31 Jul 2025 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753998221; cv=none; b=PMvfG7rU6Jvadalvx18Muc1gc4yBIcfpdlb1VNZKBsaaJxv8ElhCeVix2JUesnOkoV4WJE/Q7rRQcBU3nFT15oP3rJgQe8z+SiK3x5ZsSyn7JOUrdq8GJBYKBvhLkJ0Hx29jGRGQjD0slAedE6elLPCjC2wPlPeWN1WXxszQX2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753998221; c=relaxed/simple;
	bh=WgyFwq8wPQfOS2gYZg3qreYEkQfmXIGbIkQtMqzdcG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amfMGRjHr2vvNKEZE2uXk/3Gm5hByWkUumS2g2OhC/OTiQ9Y35ErnCDOTswNezPcMk6H2aAaY4D+CE9RreVCLBo9GdYNHrfqxPIHFwtz2f8YjdwWbiCZSTAlp4nLw1wrvJJuTkhahxg8+Uqx3BtbZ8KTwIKLs0ksFmPDVtHW24Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjHSYwVl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45634205adaso1073175e9.2;
        Thu, 31 Jul 2025 14:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753998215; x=1754603015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVuwC8UGnhHwVB50C+DPCf7wPw8Gtqu+iJNVt6eueag=;
        b=gjHSYwVlOSyO6IXq+xDLhyTOMyQcBCsXDAQgYk/62ERnqp8yWzhRySgFQIvHAAV4YL
         SqpLvAKguOe3Ty2XFlWmeixWPI8C/XSGG/ueKj8IjOGCa9g3FdqrHMPcj4X9nQP8/UBD
         y2gqi3QCb21rKDHol2+iwmhaycTXhg0gHJ4f++7sjAGvNM8A1JrjNwftcTPlo2RHMLzq
         apbqA0A5rCKaMLPH89GKt98/tQjO02Elic2L8boMeVaS2RRYb2QK9VbQOFNUe0OZDyti
         R5yv3xW9HynYkp2iW6TkJhrbzKHUbtxbl38+fEDTaDWa3y0raTUZeVwF7EN1kBr25Kkj
         P4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753998215; x=1754603015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVuwC8UGnhHwVB50C+DPCf7wPw8Gtqu+iJNVt6eueag=;
        b=OQrCSC8j6QOvWYrbEnY85b+T8L32wrGBbMxkAjJFuAMRM1u4Rq+GMLSyyTbEMszLTt
         r9gpFR0BGj0uM1pe+th0J14ZOX+Q+t3WM6y3iBXdI7iKamADmyHIzwg8Qjt2xENVpCOM
         xPGsbEShAlEmcCQA9QT2cX9iIzRb810KgQ6/WoVnvDUkzLOn1SgcArMmAyBOTtd5EQFC
         LcRHR1vXcu+K3nNpQv90W4o0fWlqJxcIneiox6VSKCmHIyLOI8Jk4DTbqpj0jBsWt46a
         cXFFzjtaE+dQaT0Zm1s97IU6ZyYgqopqb+vBpiGRqDmiJEtV/u4dukvRw0eHnVnLwIR5
         0iag==
X-Forwarded-Encrypted: i=1; AJvYcCUabhZyEoAGs9yJ5YaPTkl3DwyiecZT1bYBqLG4FSvrQY3VGfWYqLErU4cVcoJLRgKAlXqOp+ymNvUP@vger.kernel.org, AJvYcCUfm3r8wg2ngqutjGSJeeaSJTSE4uGv6Vkj/13aRjylgV5Usd71w9/dNk6ZzyNIS+GacyKgRwCvu4G0QkE8@vger.kernel.org
X-Gm-Message-State: AOJu0YxBHFOW3u/2ActC6Cl22rO3MvGMyAEdYF+Bb+YQ4rn5Q+BH9QZB
	MA76P1IVvyPWMIT4be4ceZUM41dBydZXWTea/y6OtJKdM3I1mWyWya3QCRM4kww5ztQV52s7sig
	nwEdW5cBhmFh889BV8qH814bx9JyRQQ==
X-Gm-Gg: ASbGncvL15rp2dD85dXW23irmwIwGIdKx19CrEGy4gzRd4tjGyzEReogy9+56ilmM+M
	dCDvjpCTw/WyEmg/9ZgNbodJKsZMfLGBgNnRUUulsl7UE2ppMKfJna/Z0cr0HzMsVrtJIkiy2Ca
	75cFloZQcumDLxgPLzVPCS6gMob31WTENeHuqouDJ1iywGj8j6LXXgAEzUQTmjCNPb3yzaKa7cI
	JC/Itg=
X-Google-Smtp-Source: AGHT+IHpB6Hl4ZebtAfNcyc2eS73Ko83njTG1t6gr49Z9kbw/LLnTogLy3mZ7uIf6yNx3otUoSfmmusKFErOVSMXlfQ=
X-Received: by 2002:a05:600c:8b65:b0:441:b698:3431 with SMTP id
 5b1f17b1804b1-45892bcfaf9mr70317255e9.28.1753998214809; Thu, 31 Jul 2025
 14:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727165846.38186-1-alex.vinarskis@gmail.com>
 <20250727165846.38186-4-alex.vinarskis@gmail.com> <CAD=FV=Xd_xL=PYvVNqQWFZGmqN+Q=SvvaBTfbv9k+fDb8QwUtQ@mail.gmail.com>
 <CAMcHhXp47zmpoNYLCVRWWBk4HcYepgWX=3kWWzW8c8+a=2kE6A@mail.gmail.com> <CAD=FV=XT-BBRDBHVh2KBpJydSje7_eUF19OMu9e3CcRvDf7ung@mail.gmail.com>
In-Reply-To: <CAD=FV=XT-BBRDBHVh2KBpJydSje7_eUF19OMu9e3CcRvDf7ung@mail.gmail.com>
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Date: Thu, 31 Jul 2025 23:43:23 +0200
X-Gm-Features: Ac12FXza9SHOkn8kXzmnifFDDxgM-t8FELZFnQEfBU0CoG5aGwgQRlmAo1iH0MM
Message-ID: <CAMcHhXrStcuc-ORy7_zhjwDv=r_bUONb812VGGp_5DYatNWhaw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drm/panel-edp: Add BOE NV140WUM-N64
To: Doug Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Jul 2025 at 23:44, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Jul 30, 2025 at 1:38=E2=80=AFPM Aleksandrs Vinarskis
> <alex.vinarskis@gmail.com> wrote:
> >
> > On Tue, 29 Jul 2025 at 17:50, Doug Anderson <dianders@chromium.org> wro=
te:
> > >
> > > Hi,
> > >
> > > On Sun, Jul 27, 2025 at 9:58=E2=80=AFAM Aleksandrs Vinarskis
> > > <alex.vinarskis@gmail.com> wrote:
> > > >
> > > > Timings taken from NV140WUM-N41. It is found in some arm64 laptops,
> > > > eg. Asus Zenbook A14 UX3407QA.
> > > >
> > > > The raw edid of the panel is:
> > > > 00 ff ff ff ff ff ff 00 09 e5 f6 0c 00 00 00 00
> > > > 10 22 01 04 a5 1e 13 78 07 8e 95 a6 52 4c 9d 26
> > > > 0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> > > > 01 01 01 01 01 01 5d 30 80 a0 70 b0 28 40 30 20
> > > > 36 00 2e bc 10 00 00 1a 00 00 00 fd 00 28 3c 4a
> > > > 4a 0f 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
> > > > 4c 33 30 20 20 20 20 20 20 20 20 ff 00 00 00 fc
> > > > 00 4e 56 31 34 30 57 55 4d 2d 4e 36 34 0a 01 f8
> > > >
> > > > 70 20 79 02 00 21 00 1d c8 0b 5d 07 80 07 b0 04
> > > > 88 66 ea 51 cc 74 9d 66 52 0f 02 35 54 40 5e 40
> > > > 5e 00 44 12 78 22 00 14 7f 5c 02 85 7f 07 9f 00
> > > > 2f 00 1f 00 af 04 27 00 02 00 05 00 2b 00 0c 27
> > > > 00 28 3b 00 00 27 00 28 2f 00 00 2e 00 06 00 44
> > > > 40 5e 40 5e 81 00 1e 72 1a 00 00 03 71 28 3c 00
> > > > 00 60 ff 60 ff 3c 00 00 00 00 e3 05 04 00 e6 06
> > > > 01 01 60 60 ff 00 00 00 00 00 00 00 00 00 de 90
> > > >
> > > > Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/panel/panel-edp.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/pa=
nel/panel-edp.c
> > > > index 9a56e208cbdd..b334926e96ed 100644
> > > > --- a/drivers/gpu/drm/panel/panel-edp.c
> > > > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > > > @@ -1947,6 +1947,7 @@ static const struct edp_panel_entry edp_panel=
s[] =3D {
> > > >         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c20, &delay_200_500_e80, =
"NT140FHM-N47"),
> > > >         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c93, &delay_200_500_e200,=
 "Unknown"),
> > > >         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200,=
 "NT116WHM-N44"),
> > > > +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cf6, &delay_200_500_e50_p=
2e80, "NV140WUM-N64"),
> > >
> > > Since this is a "guess" timing without any datasheet, I'd be more
> > > comfortable picking the most conservative of the "cousin" timings. Ca=
n
> > > you re-send with "delay_200_500_e200" instead?
> >
> > Sure.
> >
> > Do I understand correctly that more conservative delay_200_500_e200
> > will for sure not make it worse, since its more conservative? In that
> > case can re-spin right away. Otherwise I would prefer to re-test it
> > first, may take a few days as I do not own the hardware so need to
> > propagate the change and get some feedback.
>
> Is anything really for sure? No. :-)
>
> ...but it's _highly_ likely to not make it worse. Presumably you
> tested without ${SUBJECT} patch and things worked OK aside from the
> big warning splat in your logs about using the conservative timings.
> Those conservative timings basically give you:
>
> desc->delay.enable =3D 200;
>
> ...so you probably already tested with an enable timing of 200 and
> using 200 here will give you the same conservative number for
> "enable", will avoid some other conservative timings, and will avoid
> the warning splat.

Indeed, this is mostly to get rid of the warning, and it worked
perfectly fine without adjusted timings.
Thanks for the explanation! Will re-spin shortly.

Alex

>
> ...and the "p2e80" doesn't do anything useful when enable is 200.
>
>
> -Doug


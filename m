Return-Path: <linux-kernel+bounces-899497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E74C57F22
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A8044E786A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C2C2877D9;
	Thu, 13 Nov 2025 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leFv014X"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1666279903
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043815; cv=none; b=lP132KpvMeAG2WvqDm2DzG2An5C/NH98G9X4wF19CS9ttgS/8h+/MkFwnimjHpy5RbaFkqU+2mcg4EUwKpTx/dZB76QNXZPvTjGuwDke8AoKyM299dTQ9EUVJMm88AzGW96tlKT/YSnMczpW2p0w6CPPmqsPP+dBAi9rfdNoTFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043815; c=relaxed/simple;
	bh=1xDaZZ12RWrvILQeCfvEvMlF5aAKmx3wzOHHHzIXws8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4loYb9dyQ2gvv9S2bJgiaxr25hmXakPhtJ2jJFV7FncXR84RoFBDUpQOY4gsPYFH4uHaZbRa+pFOS6JQ+rZ/5bMwrO2B/wfGTcrCCTi5bfIejSxZ+5gNVwGcQ96wt9xWtZzqU4SdQsL3RU2P6OqPb7XAT7ArKsI9D0+kcjEY1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leFv014X; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-935356590ddso248023241.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763043813; x=1763648613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQkkqmO1JTEqvi4TMO0ZQ/b1FHhR2XjnwcEZpp95XA4=;
        b=leFv014Xz8X7hvIW9l6BTAAI/K2Zu59d6I6FgGqmeuUX60BH3QR9Og6tlwsWTBymJV
         CNopyV7OMDbHMy6KBpouxOBpLVRv4ah5wcQiLjg0r45vTUXPsdII3CQsNL1uj0o3KY2f
         koPkNooKwNvD4bobDox8nAry6YiH6HYhq0qgtFBGZVvrDK/0baLUyAIntp/RoGZVVGZh
         dZS1ombzxRqsnUqN5YNER1Z/CIe1k1FywqA/y5BTrWbg9NtoDW9qnD2ogM7rOr+Zp7ZH
         B6GARUqiaxmfZvy8uCXT16u0W7S9MTkcfbZmmMC1MIs1bR0HhZ8DKHQPX9ky80V0/BXi
         R73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763043813; x=1763648613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AQkkqmO1JTEqvi4TMO0ZQ/b1FHhR2XjnwcEZpp95XA4=;
        b=wecZCfmywixgnRxQ2xYiipzAdD0yBKID3nNPYZBq7q+/ZjmnLCx1Rpbuapq1qgFEHx
         6LQVMXtlgIULqz53atdjQhu7w+QMDe6GM+Z6x+jyUpgJqcIwGB3RhyY/UqU/swQ6XU0I
         exKEiJmfK6RQREKOeg9n/jw20tJpwCNQKCIovbPIFr9G7BkKl/g9NOhOcLcoVgARqMBR
         k5AU8fwyjWnb99UrEXpDtxFmu50IvwK8YwXvmQZLDiRA6Row4VTgyixuv/VNutZxg2tm
         3lImxN9Aabevkf8fKHeAC43iP4pEhm7daIlBaA9nL56xvdlV5+EYCr2s15yOD8/BSTXo
         NF0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUG0jGuiSODo3TUV7zLyIlZu4vzHFHe8Lj3Ae4U+habUnbaPdMaiefONhbjmWNHdBYqZk9+75ZLUUlDTY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE2em95iaBc+43ZbMQ6Vgbp+x29KUYIqYjwgGWWNgquIekaNXg
	jV6ckdu98stKaUzIF+Zlsa20JrJzEpXYVgtFK4gJwj1PqrDRJDKJ1DOuln4CTxch1MdytK/YJAU
	3fwEun0dp/Mso8SHk0Ff3m6f7AgNONr8=
X-Gm-Gg: ASbGnctc5/PxTol6goC2PViNMXnpj4dEmVn+MgxZc8oSdeblBdlbBFmsK9jkyyeK8GP
	Vbt5JwYyY07AgIsJsP6YPR2F3VWJxRy88GpBrF+W8Gq2mp9WVXpJY4A550ZRS9vzpsJ90HZwJo0
	sD0vFXSyHKCrKt1FMFSIax1KeuTGV6Tgklr2kwVoPVlmY6oegr4OuzD2fRpXbGol3fa6X0DG9B6
	3kvj0q4l5ci4ZLugfSyriEW/ZFlPTIPIp8cGpUItBmDy+Qs3rVKUqAVa1yuO8Ib0YJ0UQ==
X-Google-Smtp-Source: AGHT+IEdl9tzzz4LmeLbbScFz7vEKneZAAwSpFKwNSObLKjtaLI1BVG/9M8fwcPigkX8YTSZH2mEkOKn47z8CXxwMZQ=
X-Received: by 2002:a67:e043:0:b0:5df:ac57:b0ea with SMTP id
 ada2fe7eead31-5dfac57b3ddmr1090766137.10.1763043812409; Thu, 13 Nov 2025
 06:23:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250929042917epcas2p4c8f375cc2355b3a48141cdddb04a01c4@epcas2p4.samsung.com>
 <20250929043110.3631025-1-hy_fifty.lee@samsung.com> <20250929043110.3631025-2-hy_fifty.lee@samsung.com>
 <CAAQKjZM3qgQO=FaAuc4d1aUT1fCT6Vfo0X7Y7B=NwRNM=B34wA@mail.gmail.com> <000001dc537e$42b8bc20$c82a3460$@samsung.com>
In-Reply-To: <000001dc537e$42b8bc20$c82a3460$@samsung.com>
From: Inki Dae <daeinki@gmail.com>
Date: Thu, 13 Nov 2025 23:22:55 +0900
X-Gm-Features: AWmQ_bkMCoxlUNto3uZx9EZFH13ZH-AWorJ3ocnpvF6QI-HTLttLH3Rd-wpAotw
Message-ID: <CAAQKjZMAPtisBhgcZE1QVoUsG8n=4PGzNB9rdVtjxaVnGc0YOA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/exynos: plane: Disable fully off-screen planes
 instead of zero-sized update
To: hy_fifty.lee@samsung.com
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hoyoung,

2025=EB=85=84 11=EC=9B=94 12=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 11:44,=
 <hy_fifty.lee@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> > -----Original Message-----
> > From: Inki Dae <daeinki@gmail.com>
> > Sent: Monday, November 10, 2025 11:24 AM
> > To: Hoyoung Lee <hy_fifty.lee@samsung.com>
> > Cc: Seung-Woo Kim <sw0312.kim@samsung.com>; Kyungmin Park
> > <kyungmin.park@samsung.com>; David Airlie <airlied@gmail.com>; Simona
> > Vetter <simona@ffwll.ch>; Krzysztof Kozlowski <krzk@kernel.org>; Alim
> > Akhtar <alim.akhtar@samsung.com>; dri-devel@lists.freedesktop.org; linu=
x-
> > arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linu=
x-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH 1/3] drm/exynos: plane: Disable fully off-screen
> > planes instead of zero-sized update
> >
> > Thanks for contribution,
> >
> > 2025=EB=85=84 9=EC=9B=94 29=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 1:2=
9, Hoyoung Lee <hy_fifty.lee@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91
> > =EC=84=B1:
> > >
> > > Some configurations require additional actions when all windows are
> > > disabled to keep DECON operating correctly. Programming a zero-sized
> > > window in ->atomic_update() leaves the plane logically enabled and ca=
n
> > > bypass those disable semantics.
> > >
> > > Treat a fully off-screen plane as not visible and take the explicit
> > > disable path.
> > >
> > > Implementation details:
> > > - exynos_plane_mode_set(): if computed actual_w/actual_h is zero, mar=
k
> > >   state->visible =3D false and return early.
> > > - exynos_plane_atomic_check(): if !visible, skip further checks and
> > >   return 0.
> > > - exynos_plane_atomic_update(): if !visible, call ->disable_plane();
> > >   otherwise call ->update_plane().
> > >
> > > No functional change for visible planes; off-screen planes are now
> > > cleanly disabled, ensuring the disable hooks run consistently.
> > >
> > > Signed-off-by: Hoyoung Lee <hy_fifty.lee@samsung.com>
> > > ---
> > >  drivers/gpu/drm/exynos/exynos_drm_plane.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c
> > > b/drivers/gpu/drm/exynos/exynos_drm_plane.c
> > > index 7c3aa77186d3..842974154d79 100644
> > > --- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
> > > +++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
> > > @@ -91,6 +91,11 @@ static void exynos_plane_mode_set(struct
> > exynos_drm_plane_state *exynos_state)
> > >         actual_w =3D exynos_plane_get_size(crtc_x, crtc_w, mode->hdis=
play);
> > >         actual_h =3D exynos_plane_get_size(crtc_y, crtc_h,
> > > mode->vdisplay);
> > >
> > > +       if (!actual_w || !actual_h) {
> > > +               state->visible =3D false;
> >
> > The state->visible field in the DRM atomic framework is set to true onl=
y
> > when the following conditions are met:
> > - Both state->crtc and state->fb are present (having only one of them
> > results in an error).
> > - src_w/src_h and crtc_w/crtc_h are non-zero.
> > - The source rectangle does not exceed the framebuffer bounds (e.g., sr=
c_x
> > + src_w <=3D fb->width).
> > - Rotation and clipping checks pass successfully.
> >
> > However, this patch modifies the state->visible value within vendor-
> > specific code. Doing so can be problematic because it overrides a field
> > that is managed by the DRM atomic framework. Even if it currently works=
,
> > it may lead to unexpected behavior in the future.
> >
> > For example, if the DRM atomic framework sets visible =3D true after
> > validating the above conditions and begins processing certain logic, bu=
t
> > the vendor driver later changes it to false, the framework may still
> > assume the variable remains true, resulting in inconsistent states.
> >
> > Turning off a plane when it doesn=E2=80=99t need to be displayed is a g=
ood idea I
> > think. You might consider contributing this behavior upstream so it can=
 be
> > properly handled within the DRM atomic framework itself.
> >
> > Thanks,
> > Inki Dae
> >
> > > +               return;
> > > +       }
> > > +
> > >         if (crtc_x < 0) {
> > >                 if (actual_w)
> > >                         src_x +=3D ((-crtc_x) * exynos_state->h_ratio=
)
> > > >> 16; @@ -244,6 +249,9 @@ static int exynos_plane_atomic_check(struc=
t
> > drm_plane *plane,
> > >         /* translate state into exynos_state */
> > >         exynos_plane_mode_set(exynos_state);
> > >
> > > +       if (!new_plane_state->visible)
> > > +               return 0;
> > > +
> > >         ret =3D exynos_drm_plane_check_format(exynos_plane->config,
> > exynos_state);
> > >         if (ret)
> > >                 return ret;
> > > @@ -263,8 +271,10 @@ static void exynos_plane_atomic_update(struct
> > drm_plane *plane,
> > >         if (!new_state->crtc)
> > >                 return;
> > >
> > > -       if (exynos_crtc->ops->update_plane)
> > > +       if (new_state->visible && exynos_crtc->ops->update_plane)
> > >                 exynos_crtc->ops->update_plane(exynos_crtc,
> > > exynos_plane);
> > > +       else if (exynos_crtc->ops->disable_plane)
> > > +               exynos_crtc->ops->disable_plane(exynos_crtc,
> > > + exynos_plane);
> > >  }
> > >
> > >  static void exynos_plane_atomic_disable(struct drm_plane *plane,
> > > --
> > > 2.34.1
> > >
> > >
>
> Hi Inki,
> Thanks for the review.
>
> I agree that mutating state->visible value in vendor code is risky.
> Rather than touching the DRM atomic framework or that field, how about we=
 add a driver-private flag in Exynos(e.g. exynos_drm_plane_state->visible) =
and use that instead?
> If this approach sounds reasonable to you, I=E2=80=99ll spin a v2 along t=
hese lines.
>

For now, it is fine to add a driver-private flag and apply the change
only to Exynos. However, I believe this feature can also be generally
applied to other SoCs whose display controllers support multiple
hardware overlays, not just Exynos. Therefore, it would be ideal if
this could eventually be integrated into the DRM atomic framework so
that other SoCs may also take advantage of it in the future.

Thanks,
Inki Dae

> BRs,
> Hoyoung Lee
>
>
>


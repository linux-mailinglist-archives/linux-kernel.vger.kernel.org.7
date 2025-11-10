Return-Path: <linux-kernel+bounces-892287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B534C44C52
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF7764E6382
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790CC22D7B5;
	Mon, 10 Nov 2025 02:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/Xhksbz"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E2A1DE8BF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762741503; cv=none; b=Uzp3Sf4CzS406Y/kaACap4RkmfoEe8EKV/xnwaoifJAbcBOnj1KlG9Vh3dPQkFn1e5O9iPMB9P1gaFSVkxvAeoG5El5L6RsMTFtF7WnJ4+4W0ezF6C8NVOkcpK0Kl79GIhtMnlYhQoC3E30q/JfABl8t1PDvushpqz+eAYuGnSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762741503; c=relaxed/simple;
	bh=zMmWG4XTZZReZm7Z4Ca/2dbr/V0sWN6r2sMwECjTims=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7S0HzUInscL+06CSOijt9ReZSkykckyNq3sWV/bMibQn4zUrFt128Y3mOx6vjVmYiFDw6l3gBj+aZapSg74cZN+HMvG1xmBn7yf6W0nRioNbofk78Rh9l2FTy3d0yzSW67yb490W1Vu50IIPajwgPT3w2xlBIvMWELX6mzjem8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/Xhksbz; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-55960aa131dso697078e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 18:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762741501; x=1763346301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQYjb15LQkUsCJVby49O7R+AcuVLuxsTRLE2IcB39qA=;
        b=M/XhksbzQXf8ypeeUTl4LQxB3ErXz1inESIfPKgLDtnrw/3h2uenZzO6MP2vw38JyC
         qo9721Erm6dJqr4xPWeUKrgMfZCmjuWiTf8I85nqOiq+6JtMcg1QguQ9TxRWIzxvqccR
         7H/fI6+57kjh1BpwNeEtId02pg8jg3k1vyU3NxdOQZA72VOouh4Yk9BmGAxSNQ3Uhw+W
         1Hfwd8ZLHQOb6GgO6WjerrR2h6XRcc9cWcrkJTGKf1pp+X7AjQZLXEvubHUjNbbz0JkA
         8YhW5R0IBHz3+Uzi7L+fshYZrkDu098kpBmv7T4IlogI+D/IG8jqcqv49HJjchd2zwf1
         7wKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762741501; x=1763346301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RQYjb15LQkUsCJVby49O7R+AcuVLuxsTRLE2IcB39qA=;
        b=odMLJvs4HiW0Ev33m6INcTKE22ERTMjgeb06ETihyOgJ6rSRuIYgEM6jEeJnRkefxB
         SyiZ7kojDKPZz8NeLLUwllS50G/RxnEopE3zBvSKcJHcCT7dBOKdil/dHmq3sRzgiP8K
         K2QkZQYuo1H38v5i9TYP8iIjYPCFWE9B6VMxnrRuIMHRcj3EUvmbPx51zZDWnzCkH58k
         iyuzyV+CrKUK8wtxQTSpLZM5U7W0Uk103qJNaqfYMfCTDWk8J1pwbF1VeGnMfrrmlPX8
         3qPwApmJGF/v93AApyN6Yk9oN3LsrhKRWHszPxKzYy+5tEEbuvlJZoBl0VLG3YCCedTX
         GZZA==
X-Forwarded-Encrypted: i=1; AJvYcCWQLh7hzLULeUmsVF26Gc40VBemRnq7XgrCqzvP0MoFB3W6jpiYVxPt45150+62YRlo9lXm0HtA/tgdF+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJXun0MWuQuBumYp9X+aDVUNiKLFcPBW9dfluvMImpzWYeXcM2
	59eAImw8t8r2qVFLzk30XrGgBJ9d3L38ocw8haoH3GKE8GS+yCH+r/swKubbMgK42PVQcoUpVVv
	7QL5yD4nYWPimWIRkXbmsSPoMz81M5Ec=
X-Gm-Gg: ASbGncs2F1uNpseEbd0+1tlAlVA+UFQzyLfbGpbzjq7jt8TT2ONznDcKuYTbehkKuil
	a8cWBGtqz2LcztFxFqSIDiJYE8N5foK9/7roGZWBQZOHnmPIMxE3eQS/T3hx0g4QSAMznDfmy2n
	cMEFavkLkN1b851lN4Q/AOn6TdHq0V2pPf+dUXVlb/jmamIc5Q/lzOt7fWU660/CbJWN5Yj3hTv
	wvhevRFrtXtc9kBa+9GTKlsr20p7C/GRwJFJU1+SGtYIA8NOEHZXnOGlQoQhZkaR6zXAA==
X-Google-Smtp-Source: AGHT+IF2EMlurBzuMt0qOjdQBCv2IFE0TWGHtCo4RfIbED7bE2bHbiRvxWtYQJUkcmfpI0qEQHMqGsLRQb6EJAlUMEM=
X-Received: by 2002:a05:6102:2ac7:b0:5db:fb4c:3a8f with SMTP id
 ada2fe7eead31-5ddc485e4edmr2017252137.39.1762741501079; Sun, 09 Nov 2025
 18:25:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250929042917epcas2p4c8f375cc2355b3a48141cdddb04a01c4@epcas2p4.samsung.com>
 <20250929043110.3631025-1-hy_fifty.lee@samsung.com> <20250929043110.3631025-2-hy_fifty.lee@samsung.com>
In-Reply-To: <20250929043110.3631025-2-hy_fifty.lee@samsung.com>
From: Inki Dae <daeinki@gmail.com>
Date: Mon, 10 Nov 2025 11:24:23 +0900
X-Gm-Features: AWmQ_bnpaBAd4D4AdmA6qBIjSKlXa89V9KyU_fLfaAFw_TI3ApflT_I8g0W-s48
Message-ID: <CAAQKjZM3qgQO=FaAuc4d1aUT1fCT6Vfo0X7Y7B=NwRNM=B34wA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/exynos: plane: Disable fully off-screen planes
 instead of zero-sized update
To: Hoyoung Lee <hy_fifty.lee@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for contribution,

2025=EB=85=84 9=EC=9B=94 29=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 1:29, H=
oyoung Lee <hy_fifty.lee@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Some configurations require additional actions when all windows are
> disabled to keep DECON operating correctly. Programming a zero-sized wind=
ow
> in ->atomic_update() leaves the plane logically enabled and can bypass
> those disable semantics.
>
> Treat a fully off-screen plane as not visible and take the explicit disab=
le
> path.
>
> Implementation details:
> - exynos_plane_mode_set(): if computed actual_w/actual_h is zero, mark
>   state->visible =3D false and return early.
> - exynos_plane_atomic_check(): if !visible, skip further checks and
>   return 0.
> - exynos_plane_atomic_update(): if !visible, call ->disable_plane();
>   otherwise call ->update_plane().
>
> No functional change for visible planes; off-screen planes are now cleanl=
y
> disabled, ensuring the disable hooks run consistently.
>
> Signed-off-by: Hoyoung Lee <hy_fifty.lee@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_plane.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/=
exynos/exynos_drm_plane.c
> index 7c3aa77186d3..842974154d79 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
> @@ -91,6 +91,11 @@ static void exynos_plane_mode_set(struct exynos_drm_pl=
ane_state *exynos_state)
>         actual_w =3D exynos_plane_get_size(crtc_x, crtc_w, mode->hdisplay=
);
>         actual_h =3D exynos_plane_get_size(crtc_y, crtc_h, mode->vdisplay=
);
>
> +       if (!actual_w || !actual_h) {
> +               state->visible =3D false;

The state->visible field in the DRM atomic framework is set to true
only when the following conditions are met:
- Both state->crtc and state->fb are present (having only one of them
results in an error).
- src_w/src_h and crtc_w/crtc_h are non-zero.
- The source rectangle does not exceed the framebuffer bounds (e.g.,
src_x + src_w <=3D fb->width).
- Rotation and clipping checks pass successfully.

However, this patch modifies the state->visible value within
vendor-specific code. Doing so can be problematic because it overrides
a field that is managed by the DRM atomic framework. Even if it
currently works, it may lead to unexpected behavior in the future.

For example, if the DRM atomic framework sets visible =3D true after
validating the above conditions and begins processing certain logic,
but the vendor driver later changes it to false, the framework may
still assume the variable remains true, resulting in inconsistent
states.

Turning off a plane when it doesn=E2=80=99t need to be displayed is a good
idea I think. You might consider contributing this behavior upstream
so it can be properly handled within the DRM atomic framework itself.

Thanks,
Inki Dae

> +               return;
> +       }
> +
>         if (crtc_x < 0) {
>                 if (actual_w)
>                         src_x +=3D ((-crtc_x) * exynos_state->h_ratio) >>=
 16;
> @@ -244,6 +249,9 @@ static int exynos_plane_atomic_check(struct drm_plane=
 *plane,
>         /* translate state into exynos_state */
>         exynos_plane_mode_set(exynos_state);
>
> +       if (!new_plane_state->visible)
> +               return 0;
> +
>         ret =3D exynos_drm_plane_check_format(exynos_plane->config, exyno=
s_state);
>         if (ret)
>                 return ret;
> @@ -263,8 +271,10 @@ static void exynos_plane_atomic_update(struct drm_pl=
ane *plane,
>         if (!new_state->crtc)
>                 return;
>
> -       if (exynos_crtc->ops->update_plane)
> +       if (new_state->visible && exynos_crtc->ops->update_plane)
>                 exynos_crtc->ops->update_plane(exynos_crtc, exynos_plane)=
;
> +       else if (exynos_crtc->ops->disable_plane)
> +               exynos_crtc->ops->disable_plane(exynos_crtc, exynos_plane=
);
>  }
>
>  static void exynos_plane_atomic_disable(struct drm_plane *plane,
> --
> 2.34.1
>
>


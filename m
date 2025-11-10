Return-Path: <linux-kernel+bounces-892448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A76D6C451E3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA0E188F1B0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421A021B905;
	Mon, 10 Nov 2025 06:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0Wbm6VK"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38E634D38B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757126; cv=none; b=IhBrDMcWHyJ39a/maCQ0qcwCV/B7895tSDiMkktQOxaqI9355mSjYkT1VUV9bep9nDE35XdB5c9gmTYJ70+CL3aT3DMdgbdE1VqnqjLEKJeTljfzLzTLBJBp0gyuSCGycLbIVuXZwhqDeyj2uS6ObURGZG7F7BSiuQHryPANyOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757126; c=relaxed/simple;
	bh=SWhRAqoJWYfwuU+QfxmwEFfoLW7aWiiZJRRnU+Smsew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7TGg1o6meOFgQLFxYlfuXW/dKTBhj0IX9oWNTmVWrbB0cCch3Lgosa6lCy82RJKy28r28BRnGp+XP7AeaGrimV4e46EmxDtTC5sbkqdQ8DTh7VhSshNfnk4vOMMWei3ubLl9QyM74I/uEQ3YGxl0ucI0xlNF8eQBCmNysEZfIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0Wbm6VK; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-89018e9f902so1294525241.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 22:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762757123; x=1763361923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJ7LYF5rARcfLsBpxePOybR+1y8/o3ZLz4XlyN978+M=;
        b=A0Wbm6VKGDvlrEppg4WgZXHlE32wq8ku+dNXBIfbvQfOx7q4rRtyU+YBYkOZbPcBbd
         35FOJW+jsSQSnB3j6vpjWVgSmV4aYw03TGWBE+eg2IfuqwKXtSlQRvrDEKA0ougXQU27
         1WYbR+4PuDXyigo8/ijGnaOBKObVZ24vWOz0G9AbKfgWlm4ahTBzszscNjQOKiFm098g
         1vJFFRaUFQXpofFu47koadjAs96R3xXx7LzFd1Gi9bw8t57cGOC8cf/YHnpuyAefaWDt
         EyiUKyh48pS62FtzZeYsNumOU5limhlfItCn7G9lSDhzyWxL0/SLA12eALkk3Zq3raTS
         cG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762757123; x=1763361923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TJ7LYF5rARcfLsBpxePOybR+1y8/o3ZLz4XlyN978+M=;
        b=bJaOIGT4czeZQdwJXZZNAguipOQCSZdPJi2c0R7Zuu0tPMRj2N45/r5uWfKzEq7L3y
         v9IfXC8LImxIl45GEjSFwFycmqaSvnV/PJJcXhWHXvL+Qts94qlIFGZv9IMRxTBC/+vs
         IcP2sO8R8pbJY+tPHSCf4xKNyeKrtPyRygEp+ZBXCyPswPER1csJ4qucIXtCF6DpaXGG
         EOZ3QF4B4aeYmw9pB/JBDHuAnrq59d6vFQFLBGbQrk7LquiA/tjXUZXZOpweor6FheZB
         nIxPe9rDsKqHtI9oMc4NaR6gWSF0KPT5YlbsSTX/a8MfRmpgmgoo8DJUuwf6YWrZlVro
         En3g==
X-Forwarded-Encrypted: i=1; AJvYcCX1kH+bVj6WiuEXPRyOBqfPHd4qZpqOPOq0Tsey7FnBCliAP7Gj6Ak+eLYOvglXudoBjWewQRU0nFx+gF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGZBGLBVvsIGD+RWIVkWfdJy/H/Gmz10cCR5rLVm0l3APxGKsh
	CI+CblD3Qu/UdJ3QLM4xJHnMYEKeyhbaciddfKCcC3ukXELoiwvxYrq3dTHnZ987Z9MwOVGBMlU
	MCBFW/pI5ahZXjkTDB04ZB0GmDxLNSd0=
X-Gm-Gg: ASbGncsY56GzU1qSjsbPO6zXOR9/iOpUoG5QtFrK0rRa+Krn9Yf9nPE+tFgeUaIIftr
	/8gHkOi/TOUAKD4ozrxuMNtoKdrPeKAjmUe7jB2vq28Jo5FHgtu3Jnh6kVJiFPC6YYeVGgSR8ih
	h/OpHzkigt5uM7INyQROTQmH+sJ3D8jstmUTbMh2192DLF3trhgSCpVTqHo/IRZy9yFlcv4Tft1
	HdCAoOESm9AM7OSe/sZcqmO7Vl+mCXWRUf6+VzAULBKco20Hl0OADSX54n4gZkRvbqWKg==
X-Google-Smtp-Source: AGHT+IF+gs9QIahGISXKJRHjGuXprvZlDgmBa+ZvpM71d+5sssU4cyVVLoFXELWcuPET2oDoTXg/lkyadapsy4GEvcw=
X-Received: by 2002:a05:6102:c51:b0:5dd:a69a:b935 with SMTP id
 ada2fe7eead31-5ddc468ea63mr2373148137.16.1762757123612; Sun, 09 Nov 2025
 22:45:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250929042917epcas2p43d95408c9c43ff49ff6674136d7c64d3@epcas2p4.samsung.com>
 <20250929043110.3631025-1-hy_fifty.lee@samsung.com> <20250929043110.3631025-4-hy_fifty.lee@samsung.com>
In-Reply-To: <20250929043110.3631025-4-hy_fifty.lee@samsung.com>
From: Inki Dae <daeinki@gmail.com>
Date: Mon, 10 Nov 2025 15:44:46 +0900
X-Gm-Features: AWmQ_bnm9xQ99kNtPGcygx_UKQxpZ_ctsO76xXZQ0SPcCmu0BnofZ2Xoq2-JZF4
Message-ID: <CAAQKjZMDe-nXN14qQQTHR9HMwqCcbTospjMg_P98G0e=XAO5NQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/exynos: Move mode_config setup from fb.c to drv.c
To: Hoyoung Lee <hy_fifty.lee@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025=EB=85=84 9=EC=9B=94 29=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 1:29, H=
oyoung Lee <hy_fifty.lee@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Relocate exynos_drm_mode_config_init() and the mode_config funcs/helpers
> from exynos_drm_fb.c to exynos_drm_drv.c, and invoke
> drm_mode_config_init() from inside exynos_drm_mode_config_init().
>
> Rationale: resolve the historical fb.c placement, align with common DRM
> layering (mode_config is device-wide policy that belongs in the core
> driver), and make initialization order explicit before creating KMS
> objects and binding components.
>
> No functional change intended.

This patch looks fine to me.
However, since the second patch should be applied first, please repost
them as v2.

Thanks,
Inki Dae

>
> Signed-off-by: Hoyoung Lee <hy_fifty.lee@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_drv.c | 47 ++++++++++++++++++++++---
>  drivers/gpu/drm/exynos/exynos_drm_fb.c  | 34 ++----------------
>  drivers/gpu/drm/exynos/exynos_drm_fb.h  |  7 ++--
>  3 files changed, 49 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_drv.c
> index 1aea71778ab1..6362cd417a4e 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> @@ -233,6 +233,43 @@ static struct component_match *exynos_drm_match_add(=
struct device *dev)
>         return match ?: ERR_PTR(-ENODEV);
>  }
>
> +static struct drm_mode_config_helper_funcs exynos_drm_mode_config_helper=
s =3D {
> +       .atomic_commit_tail =3D drm_atomic_helper_commit_tail_rpm,
> +};
> +
> +static const struct drm_mode_config_funcs exynos_drm_mode_config_funcs =
=3D {
> +       .fb_create =3D exynos_user_fb_create,
> +       .atomic_check =3D drm_atomic_helper_check,
> +       .atomic_commit =3D drm_atomic_helper_commit,
> +};
> +
> +static int exynos_drm_mode_config_init(struct drm_device *dev)
> +{
> +       int ret;
> +
> +       ret =3D drmm_mode_config_init(dev);
> +       if (ret)
> +               return ret;
> +
> +       dev->mode_config.min_width =3D 0;
> +       dev->mode_config.min_height =3D 0;
> +
> +       /*
> +        * set max width and height as default value(4096x4096).
> +        * this value would be used to check framebuffer size limitation
> +        * at drm_mode_addfb().
> +        */
> +       dev->mode_config.max_width =3D 4096;
> +       dev->mode_config.max_height =3D 4096;
> +
> +       dev->mode_config.funcs =3D &exynos_drm_mode_config_funcs;
> +       dev->mode_config.helper_private =3D &exynos_drm_mode_config_helpe=
rs;
> +
> +       dev->mode_config.normalize_zpos =3D true;
> +
> +       return 0;
> +}
> +
>  static int exynos_drm_bind(struct device *dev)
>  {
>         struct exynos_drm_private *private;
> @@ -257,9 +294,9 @@ static int exynos_drm_bind(struct device *dev)
>         dev_set_drvdata(dev, drm);
>         drm->dev_private =3D (void *)private;
>
> -       drmm_mode_config_init(drm);
> -
> -       exynos_drm_mode_config_init(drm);
> +       ret =3D exynos_drm_mode_config_init(drm);
> +       if (ret)
> +               goto err_free_private;
>
>         /* setup possible_clones. */
>         clone_mask =3D 0;
> @@ -272,7 +309,7 @@ static int exynos_drm_bind(struct device *dev)
>         /* Try to bind all sub drivers. */
>         ret =3D component_bind_all(drm->dev, drm);
>         if (ret)
> -               goto err_mode_config_cleanup;
> +               goto err_free_private;
>
>         ret =3D drm_vblank_init(drm, drm->mode_config.num_crtc);
>         if (ret)
> @@ -296,7 +333,7 @@ static int exynos_drm_bind(struct device *dev)
>         drm_kms_helper_poll_fini(drm);
>  err_unbind_all:
>         component_unbind_all(drm->dev, drm);
> -err_mode_config_cleanup:
> +err_free_private:
>         exynos_drm_cleanup_dma(drm);
>         kfree(private);
>         dev_set_drvdata(dev, NULL);
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exy=
nos/exynos_drm_fb.c
> index ddd73e7f26a3..c118a079d308 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
> @@ -8,8 +8,7 @@
>   *     Seung-Woo Kim <sw0312.kim@samsung.com>
>   */
>
> -#include <drm/drm_atomic.h>
> -#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_modeset_helper.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_fourcc.h>
> @@ -93,7 +92,7 @@ exynos_drm_framebuffer_init(struct drm_device *dev,
>         return ERR_PTR(ret);
>  }
>
> -static struct drm_framebuffer *
> +struct drm_framebuffer *
>  exynos_user_fb_create(struct drm_device *dev, struct drm_file *file_priv=
,
>                       const struct drm_format_info *info,
>                       const struct drm_mode_fb_cmd2 *mode_cmd)
> @@ -150,32 +149,3 @@ dma_addr_t exynos_drm_fb_dma_addr(struct drm_framebu=
ffer *fb, int index)
>         exynos_gem =3D to_exynos_gem(fb->obj[index]);
>         return exynos_gem->dma_addr + fb->offsets[index];
>  }
> -
> -static struct drm_mode_config_helper_funcs exynos_drm_mode_config_helper=
s =3D {
> -       .atomic_commit_tail =3D drm_atomic_helper_commit_tail_rpm,
> -};
> -
> -static const struct drm_mode_config_funcs exynos_drm_mode_config_funcs =
=3D {
> -       .fb_create =3D exynos_user_fb_create,
> -       .atomic_check =3D drm_atomic_helper_check,
> -       .atomic_commit =3D drm_atomic_helper_commit,
> -};
> -
> -void exynos_drm_mode_config_init(struct drm_device *dev)
> -{
> -       dev->mode_config.min_width =3D 0;
> -       dev->mode_config.min_height =3D 0;
> -
> -       /*
> -        * set max width and height as default value(4096x4096).
> -        * this value would be used to check framebuffer size limitation
> -        * at drm_mode_addfb().
> -        */
> -       dev->mode_config.max_width =3D 4096;
> -       dev->mode_config.max_height =3D 4096;
> -
> -       dev->mode_config.funcs =3D &exynos_drm_mode_config_funcs;
> -       dev->mode_config.helper_private =3D &exynos_drm_mode_config_helpe=
rs;
> -
> -       dev->mode_config.normalize_zpos =3D true;
> -}
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.h b/drivers/gpu/drm/exy=
nos/exynos_drm_fb.h
> index fdc6cb40cc9c..0c79ce5d4a8d 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fb.h
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fb.h
> @@ -19,8 +19,11 @@ exynos_drm_framebuffer_init(struct drm_device *dev,
>                             struct exynos_drm_gem **exynos_gem,
>                             int count);
>
> -dma_addr_t exynos_drm_fb_dma_addr(struct drm_framebuffer *fb, int index)=
;
> +struct drm_framebuffer *
> +exynos_user_fb_create(struct drm_device *dev, struct drm_file *file_priv=
,
> +                     const struct drm_format_info *info,
> +                     const struct drm_mode_fb_cmd2 *mode_cmd);
>
> -void exynos_drm_mode_config_init(struct drm_device *dev);
> +dma_addr_t exynos_drm_fb_dma_addr(struct drm_framebuffer *fb, int index)=
;
>
>  #endif
> --
> 2.34.1
>
>


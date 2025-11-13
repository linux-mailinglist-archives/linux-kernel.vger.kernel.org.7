Return-Path: <linux-kernel+bounces-899452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210B5C57D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123D2421B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E452264C7;
	Thu, 13 Nov 2025 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lueb2x5A"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669BF1A8F97
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041766; cv=none; b=JvnvdNWfBgItc5praz5GgVNC+dqFMfhPyUHpaTSydJWz4seQCJus+q1a9HU4WkeiLbox8Vi92QG3snjzoMMuj3Jk8J2mptoCME8E0lz9HMzqxja5/3XywpKNtRl00yCe3UtvPojAOR76zEJC5wElpG5nvC1ALs1UYtO+XBcOnmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041766; c=relaxed/simple;
	bh=0jK092ajl+oaJQ9uC46gN+r757sV8Z34wMKfEyiwtZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCHxcp/UcYjLZJoA0o2EmcB1fRrjxKYNyzUcWbo+F+0Wbm7dNrztVJtBiVlX+zUU7URYeL19jcR3o9IcH2CkwWz4R1iKi8dP0B7+vxSopbzBU9p7fQe8LFwrc2We+v251MHm92VnlgMm6l6Mg0NSbt/xiMmSeYAQMHP3wOKO3yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lueb2x5A; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bc2c9a771b5so79321a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763041764; x=1763646564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLKGPNzt1bjDg/D6dxAyKgass6iN27pyUqXiA1Nrl84=;
        b=lueb2x5AbzitMZ9DrXVqBxKg0sVUisvCF0dJH1KPp2EJ+3mpe4UBccKHrYOLA478x3
         z4j9JcaACxihnB4bri6MrAJTZ4O0YBZgBh09imDZsuzO27xcmcOrl/fUM8Rt4th8XCzS
         JsRjdeMC91khHGBg6Q4hfAYSlJ3Y+cXa7njFHBL/mVWk3psTZKHRHzToqqobOSAytfPQ
         ceDt8AKif6R08IPmHL2s/4dXQ5lLFgSuu3otcj5GX1D6//VN5NxkoOpFR7xWlPy+XYWh
         XC+HY6mRacy5Ngwku439xQf71v/YYMsGWy04qyCIk9u7pGrTYv5lzVyWxb4nDWxrWr0U
         ACKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763041764; x=1763646564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aLKGPNzt1bjDg/D6dxAyKgass6iN27pyUqXiA1Nrl84=;
        b=S0mYM42eUZekLevykGHs3LWt2Gy9fK/HqlLjW45hUS1NhFlB3bZElDZ0ywMcdI0GRb
         /Knm7SLl2f21t+1BO3rQIvOe9RBKf8uY8+Xq6m86JbqIisgc/xzSMnYSiI7no8i5m7KD
         FUsBsD6eUhcFkQoAuyVBqGFXF4rQL/EY3GfK/wVEaXyw5Ve9NyFiU5f51CyiOayEp7CN
         PLVjOPtmpPxpJA3NN8dPoi71glCEm5HCGkKzfbXu6secTnjpUlgzlBhbz/UdFGGwZr4w
         FDa9ALsP+WweKf0p5H6OUvv6cyAWT0czzNhtoko3OhnP7RzuelIOFLcJLwIqKDDyxZCF
         WofQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAm6QPKL0Fh3r3SofzzDl4eq6MsSOUQhpkL4E/UDoQycd70QCqOvcCvgyliZkc55Q+2D6lA42HRLFC7kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpNatA6n31bnE5C1ycMZK4x2eIr5wJCxYql+s1Tdp6GytPgx6c
	D65dET0WIg9FvAyqInh19WbID220xyMnMYVCK1I887UGEcau+cvNIo5htMkZI1543NLoO6xQi0k
	uZKg1cBh/4r0VKSlTg5DRlovp9DMJlOSuZA==
X-Gm-Gg: ASbGnctkVGKwfI2v+H3Ax7Ec/+4PLlzwBjWUJg73hNrv+gqDtcjfZm44tXzFSOh5oJF
	6fFVpUsSelo8DwPsCRx1IizKT/8GXhCFg8zrDmw2X2DxX0zPf0J3IIvMyNIoSA2z++Qb2/01KzH
	c9dRO0Nen4m22RuZcI/EDFEKFKZkTcxAH+30VNY06eEKdzqYivXlp5GDDbwVfUN5Lq2V4JKgpaw
	dQneQMbVRjURk48qDnht9zauWJzwYtopaBTLBTJw7pRmCg1GdK9+T5sSeKA
X-Google-Smtp-Source: AGHT+IFEF+G/nGjr+gpgGHcDd0cvg5S8s9i9f8BE1cswaPgSfctEy6nLDMcoZwwQ3XOo9a+zxxN/E/WrFouXaRVnntA=
X-Received: by 2002:a17:903:41d0:b0:297:fe6a:d27b with SMTP id
 d9443c01a7336-2985b9e0643mr18605775ad.8.1763041763519; Thu, 13 Nov 2025
 05:49:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112222646.495189-1-mario.limonciello@amd.com>
In-Reply-To: <20251112222646.495189-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Nov 2025 08:49:10 -0500
X-Gm-Features: AWmQ_bm_vBkJZw1dIRsXw0s70Qo3lc5tHxhjF75P0p5XflHPTxzsoR7DqKWNjLQ
Message-ID: <CADnq5_M5qryDL0thczE1YKBEQc2JToAkh_zr=TphB6YwPwYfgQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Move adaptive backlight modulation property to
 drm core
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, 
	Simona Vetter <simona.vetter@ffwll.ch>, Harry Wentland <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 5:27=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The adaptive backlight modulation property is supported on AMD hardware b=
ut
> compositors should be aware of it in standard DRM property documentation.
>
> Move the helper to create the property and documentation into DRM.
>
> Suggested-by: Simona Vetter <simona.vetter@ffwll.ch>
> Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 69 +++------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.h |  7 ---
>  drivers/gpu/drm/drm_connector.c             | 63 +++++++++++++++++++
>  include/drm/drm_connector.h                 |  8 +++
>  4 files changed, 80 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.c
> index f8b35c487b6c..3d840bef77bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -1363,67 +1363,9 @@ static const struct drm_prop_enum_list amdgpu_dith=
er_enum_list[] =3D {
>         { AMDGPU_FMT_DITHER_ENABLE, "on" },
>  };
>
> -/**
> - * DOC: property for adaptive backlight modulation
> - *
> - * The 'adaptive backlight modulation' property is used for the composit=
or to
> - * directly control the adaptive backlight modulation power savings feat=
ure
> - * that is part of DCN hardware.
> - *
> - * The property will be attached specifically to eDP panels that support=
 it.
> - *
> - * The property is by default set to 'sysfs' to allow the sysfs file 'pa=
nel_power_savings'
> - * to be able to control it.
> - * If set to 'off' the compositor will ensure it stays off.
> - * The other values 'min', 'bias min', 'bias max', and 'max' will contro=
l the
> - * intensity of the power savings.
> - *
> - * Modifying this value can have implications on color accuracy, so trea=
d
> - * carefully.
> - */
> -static int amdgpu_display_setup_abm_prop(struct amdgpu_device *adev)
> -{
> -       const struct drm_prop_enum_list props[] =3D {
> -               { ABM_SYSFS_CONTROL, "sysfs" },
> -               { ABM_LEVEL_OFF, "off" },
> -               { ABM_LEVEL_MIN, "min" },
> -               { ABM_LEVEL_BIAS_MIN, "bias min" },
> -               { ABM_LEVEL_BIAS_MAX, "bias max" },
> -               { ABM_LEVEL_MAX, "max" },
> -       };
> -       struct drm_property *prop;
> -       int i;
> -
> -       if (!adev->dc_enabled)
> -               return 0;
> -
> -       prop =3D drm_property_create(adev_to_drm(adev), DRM_MODE_PROP_ENU=
M,
> -                               "adaptive backlight modulation",
> -                               6);
> -       if (!prop)
> -               return -ENOMEM;
> -
> -       for (i =3D 0; i < ARRAY_SIZE(props); i++) {
> -               int ret;
> -
> -               ret =3D drm_property_add_enum(prop, props[i].type,
> -                                               props[i].name);
> -
> -               if (ret) {
> -                       drm_property_destroy(adev_to_drm(adev), prop);
> -
> -                       return ret;
> -               }
> -       }
> -
> -       adev->mode_info.abm_level_property =3D prop;
> -
> -       return 0;
> -}
> -
>  int amdgpu_display_modeset_create_props(struct amdgpu_device *adev)
>  {
> -       int sz;
> +       int ret, sz;
>
>         adev->mode_info.coherent_mode_property =3D
>                 drm_property_create_range(adev_to_drm(adev), 0, "coherent=
", 0, 1);
> @@ -1467,7 +1409,14 @@ int amdgpu_display_modeset_create_props(struct amd=
gpu_device *adev)
>                                          "dither",
>                                          amdgpu_dither_enum_list, sz);
>
> -       return amdgpu_display_setup_abm_prop(adev);
> +       adev->mode_info.abm_level_property =3D drm_create_abm_property(ad=
ev_to_drm(adev));
> +       if (IS_ERR(adev->mode_info.abm_level_property)) {
> +               ret =3D PTR_ERR(adev->mode_info.abm_level_property);
> +               adev->mode_info.abm_level_property =3D NULL;
> +               return ret;
> +       }
> +
> +       return 0;
>  }
>
>  void amdgpu_display_update_priority(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.h
> index 2b1536a16752..dfa0d642ac16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> @@ -54,11 +54,4 @@ int amdgpu_display_resume_helper(struct amdgpu_device =
*adev);
>  int amdgpu_display_get_scanout_buffer(struct drm_plane *plane,
>                                       struct drm_scanout_buffer *sb);
>
> -#define ABM_SYSFS_CONTROL      -1
> -#define ABM_LEVEL_OFF          0
> -#define ABM_LEVEL_MIN          1
> -#define ABM_LEVEL_BIAS_MIN     2
> -#define ABM_LEVEL_BIAS_MAX     3
> -#define ABM_LEVEL_MAX          4
> -
>  #endif
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 272d6254ea47..376169dac247 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -2603,6 +2603,69 @@ static int drm_mode_create_colorspace_property(str=
uct drm_connector *connector,
>         return 0;
>  }
>
> +/**
> + * DOC: integrated panel properties
> + *
> + * adaptive backlight modulation:
> + *     Adaptive backlight modulation (ABM) is a power savings feature th=
at
> + *     dynamically adjusts the backlight brightness based on the content
> + *     displayed on the screen. By reducing the backlight brightness for
> + *     darker images and increasing it for brighter images, ABM helps to
> + *     conserve energy and extend battery life on devices with integrate=
d
> + *     displays.  This feature is part of AMD DCN hardware.
> + *
> + *     sysfs
> + *             The ABM property is exposed to userspace via sysfs interf=
ace
> + *             located at 'amdgpu/panel_power_savings' under the DRM dev=
ice.
> + *     off
> + *             Adaptive backlight modulation is disabled.
> + *     min
> + *             Adaptive backlight modulation is enabled at minimum inten=
sity.
> + *     bias min
> + *             Adaptive backlight modulation is enabled at a more intens=
e
> + *             level than 'min'.
> + *     bias max
> + *             Adaptive backlight modulation is enabled at a more intens=
e
> + *             level than 'bias min'.
> + *     max
> + *             Adaptive backlight modulation is enabled at maximum inten=
sity.
> + */
> +struct drm_property *drm_create_abm_property(struct drm_device *dev)
> +{
> +       const struct drm_prop_enum_list props[] =3D {
> +               { ABM_SYSFS_CONTROL, "sysfs" },
> +               { ABM_LEVEL_OFF, "off" },
> +               { ABM_LEVEL_MIN, "min" },
> +               { ABM_LEVEL_BIAS_MIN, "bias min" },
> +               { ABM_LEVEL_BIAS_MAX, "bias max" },
> +               { ABM_LEVEL_MAX, "max" },
> +       };
> +       struct drm_property *prop;
> +       int i;
> +
> +       prop =3D drm_property_create(dev, DRM_MODE_PROP_ENUM,
> +                               "adaptive backlight modulation",
> +                               6);
> +       if (!prop)
> +               return ERR_PTR(-ENOMEM);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(props); i++) {
> +               int ret;
> +
> +               ret =3D drm_property_add_enum(prop, props[i].type,
> +                                               props[i].name);
> +
> +               if (ret) {
> +                       drm_property_destroy(dev, prop);
> +
> +                       return ERR_PTR(ret);
> +               }
> +       }
> +
> +       return prop;
> +}
> +EXPORT_SYMBOL(drm_create_abm_property);
> +
>  /**
>   * drm_mode_create_hdmi_colorspace_property - create hdmi colorspace pro=
perty
>   * @connector: connector to create the Colorspace property on.
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 8f34f4b8183d..644c0d49500f 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -2454,6 +2454,7 @@ int drm_connector_attach_hdr_output_metadata_proper=
ty(struct drm_connector *conn
>  bool drm_connector_atomic_hdr_metadata_equal(struct drm_connector_state =
*old_state,
>                                              struct drm_connector_state *=
new_state);
>  int drm_mode_create_aspect_ratio_property(struct drm_device *dev);
> +struct drm_property *drm_create_abm_property(struct drm_device *dev);
>  int drm_mode_create_hdmi_colorspace_property(struct drm_connector *conne=
ctor,
>                                              u32 supported_colorspaces);
>  int drm_mode_create_dp_colorspace_property(struct drm_connector *connect=
or,
> @@ -2563,4 +2564,11 @@ const char *drm_get_colorspace_name(enum drm_color=
space colorspace);
>         drm_for_each_encoder_mask(encoder, (connector)->dev, \
>                                   (connector)->possible_encoders)
>
> +#define ABM_SYSFS_CONTROL      -1
> +#define ABM_LEVEL_OFF          0
> +#define ABM_LEVEL_MIN          1
> +#define ABM_LEVEL_BIAS_MIN     2
> +#define ABM_LEVEL_BIAS_MAX     3
> +#define ABM_LEVEL_MAX          4
> +
>  #endif
> --
> 2.51.2
>


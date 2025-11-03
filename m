Return-Path: <linux-kernel+bounces-883698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9E6C2E23B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80987189691F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C532D0639;
	Mon,  3 Nov 2025 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1/ahZpB"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763727FD49
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204944; cv=none; b=nYi4UzLQoYPdd9ZVwS0JyQOdpY+1ufnhhi/IzMihM/IzwyRW86+7trNPsOtvM6VKKUb2mWwEqEeHBA538GExycZclumaveBxuGrqlSFnyucQGc4hvIALOYQ9LkZICL/sV67GlOdyktjxiLoiQoPTY2oT3yI7UIuubTJ+4jmQfjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204944; c=relaxed/simple;
	bh=luftFZkqy8XsLwWuXKgrza1yZ3N5omE/6fu+k0bWHUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbMtI6MJnGGCMsAB550RZ8uOixHHVjYWhBiIkLf/IvMVxgoCx7/0Jw1iR2kV/8ck4muBwZj9y8RBxKdW4e6/Rud1RjYB/Jln2bNBQ6me73jsLE9NZrIny97h94yvbwLgky+J6RGHroXQZ1bAjSSR/8wjVbz/bTZEhW7FLVAEePM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1/ahZpB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7aacc98b904so214698b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 13:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762204942; x=1762809742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rE58hiRTUlrMIT0NpYlRD5TeFsqNiDpC2v9wB4IFQxM=;
        b=P1/ahZpBF0TkluXnjl5or6gIK2b+PPOaiyoCPXNXtFNeTRtgijHCMv1cAj7KO/YL1j
         NnT/f5SWvc6o4+ACeOxbnrUKJE+QQfaGR9giNy7CN9caAthjVG30b3newMWaWm3lKlca
         r6k52xfr/NZ9KGZir6BSu8cP4swuge9ooDfoOfm4jSF79j7Hesd0Y8D4uqgAdFB6tZR/
         8hy6FKxG/X5V7UEAKhaZKwVsJIGAm94m/ivJoRydMz1ZV0TdddKOJDZYxF1htHz0L88X
         q8447NckzhjpPhuBXuo35+hDlIht/jRnlZCVTatqlXMZwef4rT/0UJqokC9YDDA8kCfo
         LLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762204942; x=1762809742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rE58hiRTUlrMIT0NpYlRD5TeFsqNiDpC2v9wB4IFQxM=;
        b=rR61/qgWlQr7WqgohWgqmcRhLpA7RJSRMG0zgxYBgzAIkuvcM+wT0HAF+nTCwkXa4b
         aMXLmHeFXjJduBVITtN48pUIkEmoouwNOLofQvGZhbANfNfm+64XqVvQ37IO11M/gz1U
         N4NDWoLhCh5TK/JRSdneKcOTeMjZM3Knt1eh9JuR78I9Bt4U2jBmCBNEkA4ByeGn92ms
         nhzNrf6zkWQ9O2D7kmCkFfDHIVBirvV3osuxURaTgfYPZYqSqWs+F5xAdo/1ZVeJCBpg
         Hdk9QvyE7UsOh0EAlOYB3EinHvpsOSH2XRYKIk5E2iWvFr22WCgh+3sRzWe4TPgof2Wu
         Qfvg==
X-Forwarded-Encrypted: i=1; AJvYcCXHUBU+Ha0aAsdM6nIhg+xOZS0Y7ucjUHNYRB5gKyV6kuOM207PN4c8wK09X5d+XxwErmDtqGHfVQMAcCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxceBKG2hK7cXjxxrxp8acaffcSWNv2YILhwSM7IqdWE1QpiBop
	2GuNn20aepl7KVVOUETMgQihzTSEGFDarOUAHeVxVcLsb+ZQdY5UmkJhkDsLo9llB6BDQqA8qyw
	I7cSiaW+3KvZrXRCkBPtrC8mywkOYfB4=
X-Gm-Gg: ASbGnctbTo4MYCavk/V5X6aLcbwfzZrDDgNeLywT/bdTEubdo8fCKuy74PONT62iORQ
	P4qTiZgmij/tzd8+e0CSHLBVf1oIPr8UhqRO+VzvKzX+Y4MmtW0V2+GySm9xmopGGo2xxLwz8QH
	C/JswmgvIAiI33E6m/ksPaK7qFOe6TDY272UPfQGg+OJEfW9raLmuC34iBMU29GRCiXWo4Uobgk
	jbWC2b1lBzJgrKkQKlLchyf1yA8SahI2cZWO7QvHi6REt2v6cftAffRB2e7
X-Google-Smtp-Source: AGHT+IF+pa7nAIZJIzPewlRle8Ustg8pMZwlv03Og8EB/KzMFu1aqoYGB9P15oduASqkSOuCDnhkCrkbBG7VOwG5Py0=
X-Received: by 2002:a17:902:c40a:b0:25a:4437:dbb7 with SMTP id
 d9443c01a7336-2951a3bbbe7mr109882355ad.4.1762204941993; Mon, 03 Nov 2025
 13:22:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-vram-carveout-tuning-for-upstream-v1-0-17e2a72639c5@amd.com>
 <20251103-vram-carveout-tuning-for-upstream-v1-2-17e2a72639c5@amd.com>
In-Reply-To: <20251103-vram-carveout-tuning-for-upstream-v1-2-17e2a72639c5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Nov 2025 16:22:09 -0500
X-Gm-Features: AWmQ_bmeOchvSm4HGcyqJCHq618GmRuqKM6n2IV2ncTp0L5vtC9OpsiExT2E_x0
Message-ID: <CADnq5_PS7pfseo84hVPfBevJqrfBxHEAct0w35xVjNg0cjREqg@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/amdgpu: add helper to read UMA carveout info
To: "Yo-Jung Leo Lin (AMD)" <Leo.Lin@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, anson.tsao@amd.com, superm1@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 2:54=E2=80=AFAM Yo-Jung Leo Lin (AMD) <Leo.Lin@amd.c=
om> wrote:
>
> Currently, the available UMA allocation configs in the integrated system
> information table have not been parsed. Add a helper function to retrieve
> and store these configs.
>
> Co-developed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Yo-Jung Leo Lin (AMD) <Leo.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c     | 32 ++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 75 ++++++++++++++++++=
++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/atom.h                |  4 ++
>  4 files changed, 107 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_atombios.c
> index 763f2b8dcf13..58cc3bc9d42d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -28,6 +28,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_atombios.h"
>  #include "amdgpu_atomfirmware.h"
> +#include "atomfirmware.h"
>  #include "amdgpu_i2c.h"
>  #include "amdgpu_display.h"
>
> @@ -1877,6 +1878,10 @@ void amdgpu_atombios_fini(struct amdgpu_device *ad=
ev)
>         if (adev->mode_info.atom_context) {
>                 kfree(adev->mode_info.atom_context->scratch);
>                 kfree(adev->mode_info.atom_context->iio);
> +               kfree(adev->mode_info.atom_context->uma_carveout_options)=
;
> +               adev->mode_info.atom_context->uma_carveout_options =3D NU=
LL;
> +               adev->mode_info.atom_context->uma_carveout_nr =3D 0;
> +               adev->mode_info.atom_context->uma_carveout_index =3D 0;
>         }
>         kfree(adev->mode_info.atom_context);
>         adev->mode_info.atom_context =3D NULL;
> @@ -1891,16 +1896,19 @@ void amdgpu_atombios_fini(struct amdgpu_device *a=
dev)
>   *
>   * Initializes the driver info and register access callbacks for the
>   * ATOM interpreter (r4xx+).
> - * Returns 0 on sucess, -ENOMEM on failure.
> + * Returns 0 on success, -ENOMEM on memory allocation error, or -EINVAL =
on ATOM ROM parsing error
>   * Called at driver startup.
>   */
>  int amdgpu_atombios_init(struct amdgpu_device *adev)
>  {
>         struct card_info *atom_card_info =3D
>             kzalloc(sizeof(struct card_info), GFP_KERNEL);
> +       int rc;
>
> -       if (!atom_card_info)
> -               return -ENOMEM;
> +       if (!atom_card_info) {
> +               rc =3D -ENOMEM;
> +               goto out_card_info;
> +       }
>
>         adev->mode_info.atom_card_info =3D atom_card_info;
>         atom_card_info->dev =3D adev_to_drm(adev);
> @@ -1913,8 +1921,16 @@ int amdgpu_atombios_init(struct amdgpu_device *ade=
v)
>
>         adev->mode_info.atom_context =3D amdgpu_atom_parse(atom_card_info=
, adev->bios);
>         if (!adev->mode_info.atom_context) {
> -               amdgpu_atombios_fini(adev);
> -               return -ENOMEM;
> +               rc =3D -ENOMEM;
> +               goto out_atom_ctx;
> +       }
> +
> +       rc =3D amdgpu_atomfirmware_get_uma_carveout_info(adev);
> +
> +       if (rc) {
> +               drm_dbg(adev_to_drm(adev), "Failed to get UMA carveout in=
fo: %d\n", rc);
> +               if (rc !=3D -ENODEV)
> +                       goto out_uma_info;
>         }
>
>         mutex_init(&adev->mode_info.atom_context->mutex);
> @@ -1930,6 +1946,12 @@ int amdgpu_atombios_init(struct amdgpu_device *ade=
v)
>         }
>
>         return 0;
> +
> +out_uma_info:
> +out_atom_ctx:
> +       amdgpu_atombios_fini(adev);
> +out_card_info:
> +       return rc;
>  }
>
>  int amdgpu_atombios_get_data_table(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 636385c80f64..698416e84f1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -21,12 +21,14 @@
>   *
>   */
>
> +#include "linux/slab.h"
>  #include <drm/amdgpu_drm.h>
>  #include "amdgpu.h"
>  #include "atomfirmware.h"
>  #include "amdgpu_atomfirmware.h"
>  #include "atom.h"
>  #include "atombios.h"
> +#include "atomfirmware.h"
>  #include "soc15_hw_ip.h"
>
>  union firmware_info {
> @@ -296,6 +298,79 @@ static int convert_atom_mem_type_to_vram_type(struct=
 amdgpu_device *adev,
>         return vram_type;
>  }
>
> +static int __amdgpu_atomfirmware_get_uma_carveout_info_v2_3(struct amdgp=
u_device *adev,
> +                                                           union igp_inf=
o *igp_info)
> +{
> +       struct atom_context *ctx =3D adev->mode_info.atom_context;
> +       struct uma_carveout_option *opts;
> +
> +       opts =3D kzalloc(sizeof(igp_info->v23.UMASizeControlOption), GFP_=
KERNEL);
> +
> +       if (!opts)
> +               goto out_mem;
> +
> +       memcpy(opts, igp_info->v23.UMASizeControlOption,
> +               sizeof(igp_info->v23.UMASizeControlOption));
> +
> +       ctx->uma_carveout_index =3D igp_info->v23.UMACarveoutIndex;
> +       ctx->uma_carveout_nr =3D igp_info->v23.UMACarveoutIndexMax;
> +       ctx->uma_carveout_options =3D opts;
> +
> +       return 0;
> +
> +out_mem:
> +       return -ENOMEM;
> +}
> +
> +static int __amdgpu_atomfirmware_get_uma_carveout_info(struct amdgpu_dev=
ice *adev,
> +                                                      u8 frev, u8 crev,
> +                                                      union igp_info *ig=
p_info)
> +{
> +       switch (frev) {
> +       case 2:
> +               switch (crev) {
> +               case 3:
> +                       return __amdgpu_atomfirmware_get_uma_carveout_inf=
o_v2_3(adev, igp_info);
> +               break;
> +               default:
> +                       break;
> +               }
> +               break;
> +       default:
> +               break;
> +       }
> +       return -ENODEV;
> +}

I think this function can be moved into
amdgpu_atomfirmware_get_uma_carveout_info().

> +
> +int amdgpu_atomfirmware_get_uma_carveout_info(struct amdgpu_device *adev=
)
> +{
> +       struct amdgpu_mode_info *mode_info =3D &adev->mode_info;
> +       union igp_info *igp_info;
> +       u16 data_offset, size;
> +       u8 frev, crev;
> +       int index;
> +
> +       if (!(adev->flags & AMD_IS_APU))
> +               return -ENODEV;
> +
> +       if (!amdgpu_acpi_is_set_uma_allocation_size_supported())
> +               return -ENODEV;
> +
> +       index =3D get_index_into_master_table(atom_master_list_of_data_ta=
bles_v2_1,
> +                                           integratedsysteminfo);
> +
> +       if (!amdgpu_atom_parse_data_header(mode_info->atom_context,
> +                                         index, &size,
> +                                         &frev, &crev, &data_offset)) {
> +               return -EINVAL;
> +       }
> +
> +       igp_info =3D (union igp_info *)
> +                       (mode_info->atom_context->bios + data_offset);
> +
> +       return __amdgpu_atomfirmware_get_uma_carveout_info(adev, frev, cr=
ev, igp_info);
> +}
> +
>  int
>  amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>                                   int *vram_width, int *vram_type,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> index 649b5530d8ae..fb3f34a36569 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> @@ -32,6 +32,7 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgp=
u_device *adev);
>  int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev);
>  int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>         int *vram_width, int *vram_type, int *vram_vendor);
> +int amdgpu_atomfirmware_get_uma_carveout_info(struct amdgpu_device *adev=
);
>  int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev);
>  int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev);
>  bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdg=
pu/atom.h
> index 825ff28731f5..f07c612f0386 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.h
> @@ -153,6 +153,10 @@ struct atom_context {
>         uint8_t vbios_ver_str[STRLEN_NORMAL];
>         uint8_t date[STRLEN_NORMAL];
>         uint8_t build_num[STRLEN_NORMAL];
> +
> +       uint8_t uma_carveout_index;
> +       uint8_t uma_carveout_nr;
> +       struct uma_carveout_option *uma_carveout_options;

I don't think these really belong in the atom context.  They don't
really have anything to do with atombios.  I think it makes more sense
to do this in amdgpu_acpi_init() if atcs supports uma resizing.  If
the atcs support is present, then call the atomfirmware function to
parse the atom table and if all of that is ok, then register the sysfs
interface.

Alex


>  };
>
>  extern int amdgpu_atom_debug;
>
> --
> 2.43.0
>


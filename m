Return-Path: <linux-kernel+bounces-743565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66667B1004A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34CB71CC5F49
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2FB2046A9;
	Thu, 24 Jul 2025 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGQI6vAR"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2D31F37D4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753336620; cv=none; b=hOQFp7464yJMFOMnHCKFB3yqM0ZbBsLHO+83awGVfPc1mvgTFQpZxRYLGpIdH1ZRS0N0/ED/zZ3nmTNr2qFk82olOH31wWx9Wu+h2+k7LTOtr1NQHGSgf0cem8jautD6zX5ruwakSI8w9J3fEiQmHjg1tTiMH8+TilJR8I1HIHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753336620; c=relaxed/simple;
	bh=mjZELVawPi/Xr5b0vI6fi5+DWKr0gpgeRjcew+hf7uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0ol21PXaetRFJBX0VjuysuaXEzMUrwnd8A45FqFmOkhfRQPV6rAOrC6BgHykiPWFJ13m4yhDdlsD59kAfptW9glMMETMhPh3ojK9Jkn4MVf5C5Th8uB4sl3g/yIFhaoKdhqFQcdJHtb9bZj8JDWygnj6BTF2qv2sv/sD3wP/sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGQI6vAR; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e3c6b88dbso4936487b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753336617; x=1753941417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUUmH3r0IppoSe6UIs4TMAPkQKjDXvL6AQC/64B+fQA=;
        b=ZGQI6vARM7HrqxN5bbyNPNhteMZKHN1W1x7PVNW3/JdKyjmGqqAWPBTQjchk8aPOnN
         q7/8x/bXaAXbPQGIc0f4R1yVx5GcQbj2egp+KkgJn/eexZvU7xKVeel9tl46kavY2SDL
         7CgXQgHCEaCrZtQNVREW2s3zlHG4R3zNHi3zDTtRnyF4B/39gPyoFaytUDwZxs7ws53K
         0ZWeV4tAg8lg/ELwvl5YSNOcGr7CShYlpe5UFIzSeNbpg5kquau7gDEVy4yLa8Pt9B/X
         WEcmDR5vOR2j2Gey3iuZ2pO38ctJ2fvtpi6U8k/UDTUf+7JNYhgZNpgOnWPy3vWYDU8C
         yzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753336617; x=1753941417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUUmH3r0IppoSe6UIs4TMAPkQKjDXvL6AQC/64B+fQA=;
        b=bxJT2LxVKnZn1KNsZNnaGzgOr2felQqWpFjPk4uOKOptcZKtfd7w+x4qR5fZtgA2xw
         HCDXB5HJOG/gHlkLbmNbBsF95plA4wvvrG9sRk9NDNkMMzLeKXO/nZswaNh5BgHBQkc1
         BC0tSnGvPMQ+qdj/epCT4LoQZbUuiSsUEpAF/Lm7BA5S9bL7cKDRx7twk/1d0KFj6CIQ
         bKWNUZkR4J27lC6gdpZQ5lHaEk0PdAW2of446+rFT1B7mY3t+YRxSUXxCxVfFvK6+Rhu
         WUE2tJcjIP7xD5jdrz5SNcPDXCIv0BIiUAW8cDHPIgPwcVbWN668WIFpJ+L/OVbUoOia
         DnJA==
X-Forwarded-Encrypted: i=1; AJvYcCX/cMSz3tR8MrhJHmh72kx1SBGzpVoELvGdNgKzjKpu+Sy9gu+pT1fLseM4isCbB8k5aCTCOqcTGBBwVBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl+F8j8o0sFM48/9j3eqhiHbTTWQZpQjRgnUUA+W/Km+H5oB1e
	SlfpqzUexm1ZqS7XAYBT+9faYdJK23xC+JM6IJkiV9avzLSArCGeQTdsDVt+BjqYcSdTVS6zO7w
	MbITenGmB3Qd9MZf1Ig9Y6O9rEojSjhdOI29Hso0dGw==
X-Gm-Gg: ASbGnct4gAsNwsrgfM163xNiiubqAAEmpxV5qBnWURNHLLfYMIQS5Q4oh+rNZcUmzvb
	BBUBhS3GHz4PK/k4zVCiFXABKXK6qno9O79pifAYyM1BjZE/9WbieMvfjilI0QnzkDZqbkCpqum
	1Vw5tGyE9X+TZklP5IKSZ+5E2a/Y/QoIs6+sfHW1NZRVRJtzYYHzFMZ2TyZaJlALROE54KmiLM0
	CuRg9FsUQ==
X-Google-Smtp-Source: AGHT+IExzAwMs1D0O08I2NO5mk0zHf1nq1Spna9+UCqbNjnniNoSoovHWHDbyyMgphrVdcQ9QAGOP6S3k9twQ77Q5Mk=
X-Received: by 2002:a05:690c:6a13:b0:714:349:5829 with SMTP id
 00721157ae682-719b41459femr63999837b3.5.1753336617220; Wed, 23 Jul 2025
 22:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721213528.2885035-1-karunika.choo@arm.com> <20250721213528.2885035-7-karunika.choo@arm.com>
In-Reply-To: <20250721213528.2885035-7-karunika.choo@arm.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Wed, 23 Jul 2025 22:56:46 -0700
X-Gm-Features: Ac12FXwUMItf8agrwM8xQOJEpaaME3UWShHH7ZJpeqhh3bW_xOpFUmP05ifOtJY
Message-ID: <CAPaKu7QV=XivzwzHGwaPMXQ9yr-zkuAwF9+MmuVPzTNDBwS+xw@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] drm/panthor: Add support for Mali-Gx20 and
 Mali-Gx25 GPUs
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 3:53=E2=80=AFPM Karunika Choo <karunika.choo@arm.co=
m> wrote:
>
> This patch adds firmware binary and GPU model naming support for
> Mali-Gx20 and Mali-Gx25 GPUs.
>
> The GPU_COHERENCY_FEATURES macros are slightly reworked as the
> assumption that FEATURE =3D BIT(PROTOCOL) no longer holds with the
> introduction of the SHAREABLE_CACHE_SUPPORT, which is BIT(5) on the
> GPU_COHERENCY_PROTOCOL register. As such, the feature bits are now
> individually defined. Further changes were also made to enable
> SHAREABLE_CACHE_SUPPORT if coherency is enabled and the feature is
> supported.
>
> This patch also fixes a minor bug that incorrectly writes ACE instead of
> ACE_LITE to GPU_COHERENCY_PROTOCOL if coherency is enabled.
>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.c |  2 +-
>  drivers/gpu/drm/panthor/panthor_fw.c     |  2 ++
>  drivers/gpu/drm/panthor/panthor_gpu.c    | 14 ++++++++++++--
>  drivers/gpu/drm/panthor/panthor_hw.c     | 18 ++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_regs.h   |  5 ++++-
>  5 files changed, 37 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> index 81df49880bd8..f547aa4159ec 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -34,7 +34,7 @@ static int panthor_gpu_coherency_init(struct panthor_de=
vice *ptdev)
>          * ACE protocol has never been supported for command stream front=
end GPUs.
>          */
>         if ((gpu_read(ptdev, GPU_COHERENCY_FEATURES) &
> -                     GPU_COHERENCY_PROT_BIT(ACE_LITE)))
> +            GPU_COHERENCY_FEATURE_ACE_LITE))
Replace gpu_read by ptdev->gpu_info.coherency_features.
>                 return 0;
>
>         drm_err(&ptdev->base, "Coherency not supported by the device");
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index fa6e0b48a0b2..9bf06e55eaee 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1405,3 +1405,5 @@ MODULE_FIRMWARE("arm/mali/arch10.8/mali_csffw.bin")=
;
>  MODULE_FIRMWARE("arm/mali/arch10.10/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch10.12/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch11.8/mali_csffw.bin");
> +MODULE_FIRMWARE("arm/mali/arch12.8/mali_csffw.bin");
> +MODULE_FIRMWARE("arm/mali/arch13.8/mali_csffw.bin");
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/pant=
hor/panthor_gpu.c
> index 5e2c3173ae27..df2419706fe0 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -45,8 +45,18 @@ struct panthor_gpu {
>
>  static void panthor_gpu_coherency_set(struct panthor_device *ptdev)
>  {
> -       gpu_write(ptdev, GPU_COHERENCY_PROTOCOL,
> -               ptdev->coherent ? GPU_COHERENCY_PROT_BIT(ACE_LITE) : GPU_=
COHERENCY_NONE);
> +       u32 coherency_protocol =3D GPU_COHERENCY_NONE;
> +
> +       if (ptdev->coherent) {
> +               coherency_protocol =3D GPU_COHERENCY_ACE_LITE;
> +
> +               if ((gpu_read(ptdev, GPU_COHERENCY_FEATURES) &
> +                    GPU_COHERENCY_FEATURE_SHAREABLE_CACHE_SUPPORT))
Replace gpu_read by ptdev->gpu_info.coherency_features.
> +                       coherency_protocol |=3D
> +                               GPU_COHERENCY_SHAREABLE_CACHE_SUPPORT;
> +       }
> +
> +       gpu_write(ptdev, GPU_COHERENCY_PROTOCOL, coherency_protocol);
>  }
>
>  static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 st=
atus)
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panth=
or/panthor_hw.c
> index a7583342d797..3fcb69a6f959 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -35,6 +35,24 @@ static char *get_gpu_model_name(struct panthor_device =
*ptdev)
>                 fallthrough;
>         case GPU_PROD_ID_MAKE(11, 3):
>                 return "Mali-G615";
> +       case GPU_PROD_ID_MAKE(12, 0):
> +               if (shader_core_count >=3D 10 && ray_intersection)
> +                       return "Mali-G720-Immortalis";
> +               else if (shader_core_count >=3D 6)
> +                       return "Mali-G720";
> +
> +               fallthrough;
> +       case GPU_PROD_ID_MAKE(12, 1):
> +               return "Mali-G620";
> +       case GPU_PROD_ID_MAKE(13, 0):
> +               if (shader_core_count >=3D 10 && ray_intersection)
> +                       return "Mali-G925-Immortalis";
> +               else if (shader_core_count >=3D 6)
> +                       return "Mali-G725";
> +
> +               fallthrough;
> +       case GPU_PROD_ID_MAKE(13, 1):
> +               return "Mali-G625";
>         }
>
>         return "(Unknown Mali GPU)";
> diff --git a/drivers/gpu/drm/panthor/panthor_regs.h b/drivers/gpu/drm/pan=
thor/panthor_regs.h
> index 8bee76d01bf8..1beb365c0fec 100644
> --- a/drivers/gpu/drm/panthor/panthor_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_regs.h
> @@ -111,12 +111,15 @@
>  #define GPU_REVID                                      0x280
>
>  #define GPU_COHERENCY_FEATURES                         0x300
> -#define GPU_COHERENCY_PROT_BIT(name)                   BIT(GPU_COHERENCY=
_  ## name)
> +#define   GPU_COHERENCY_FEATURE_ACE_LITE               BIT(0)
> +#define   GPU_COHERENCY_FEATURE_ACE                    BIT(1)
> +#define   GPU_COHERENCY_FEATURE_SHAREABLE_CACHE_SUPPORT        BIT(5)
>
>  #define GPU_COHERENCY_PROTOCOL                         0x304
>  #define   GPU_COHERENCY_ACE_LITE                       0
>  #define   GPU_COHERENCY_ACE                            1
>  #define   GPU_COHERENCY_NONE                           31
> +#define   GPU_COHERENCY_SHAREABLE_CACHE_SUPPORT                BIT(5)
>
>  #define MCU_CONTROL                                    0x700
>  #define MCU_CONTROL_ENABLE                             1
> --
> 2.49.0
>


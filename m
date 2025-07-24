Return-Path: <linux-kernel+bounces-743550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A365B10001
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796C7967DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765311F541E;
	Thu, 24 Jul 2025 05:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsAuyQ/s"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9E333E1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753335614; cv=none; b=XoES2L90wjH5Z5MO92gtPku11eDtclCCIemvKrgI61RmI0hxdfBHY1/TkEEmFz8w9PqhJ1FmQG8Njj1AQ/V21luzuJT1IGjHhg90afGPwpYEXRU/6C27uCsCYd0nJBfFyQBcn8Cny2OcfbRpeon/Z/4hBGRq4lAURHEmrCmPDJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753335614; c=relaxed/simple;
	bh=FFn64jDEbUhAjasv2jBdKdTsk+ykG0VF6XIdfJSixP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LoVChgV0GJPiNJXC76j3nCjvf10CbrQMOA4H4TXSTEy291CM/esWvAS5gg+Pi3jPw6fA0AdeGcopq7TOj12i4YhKrtHIXIJCEl915C9djJs+RS+giEL9X3G/I0vDEfEnuNjjZpLGOihffe+b4bs/9Iqw7LsEVGbIBv3zjFNw9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsAuyQ/s; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-719c4aa9b19so6749547b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753335612; x=1753940412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdTXK8XCjL3hM90JWsv5Qt5Gibia8/wJ7klymDs9MWQ=;
        b=EsAuyQ/sOlrl2iOc1F+VXnGHPCZqlHmTSe62U1IqJKRqzSkAM7XrZ+Pz7cIcWC5fbK
         utD7enBrdO1Tr9904pXsAUDW1YNH6cQeRvmZNZ20uUI2mJYFaw/6r9raz0A6wGKd8XoM
         WEj2mxjdNRZIdLIHFJtYiBqntzdEszzNEfjz1eALbd49vX7QagRmVXbYH1WDyyaMU5Ck
         lKAtWPo3cI1HhQ3Elt+Bj4Ntw5GQc/Q3cjzuE/YKajf0ewd5zllIPd1efQBhzIfxDonh
         1IPsjm29+rUR6sFkZXJ1gWap9Mpqww9vXPWUaKMT+ulOBDrN5PP3s0wvS5aEhm1SvlXG
         fNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753335612; x=1753940412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdTXK8XCjL3hM90JWsv5Qt5Gibia8/wJ7klymDs9MWQ=;
        b=KEc7b0h8TTfCGROVwXs/FtXF/IEjJX3hWt7wL+4t3XwFbVHDeTsLuUKFTUvIqUTN7j
         kRWIOF3PErg+fVmIrdiEL0RnPS5xPaM/g0tm70ysTDmwf1wUdwUyVSfgCMZZWgv6Vhbw
         1dH0a1jOF6HS4gLy42J7Vuz4iBDFE6WmrGFjUZsMk4Dl9olXpTDxHYnTf61989hcuicK
         jRLQSc5X9P1Qv2YPMPdVNcKielYOSmO5xsDIN6/Qvi/Y8R65Mxw+oV7TW+g/Qw74UjUf
         kUVq4GDG6INTZHF5j8xBPMMSYg9vPQ5tw4sHLdgGRZcCVvfv2dqlBH6zP2ePfWO7kd8c
         4iwg==
X-Forwarded-Encrypted: i=1; AJvYcCWUbeUeTyD9nni6s01RnbvjlXXjAQLu8hrtDA6QlOmgboGkReKAPEREXfwRaEPOwCbyiGm0dMEVOY2vzD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSoefbs/P3VaXfWmdmLIszEmGr83gJm2NZpk5J30T7lJago6mv
	sW1ixT6VKed+UxxKHVNQrPgoP3+GP8BStnGzxrGzrOU/gqjnnPDDi1itZqTUgnpkBJW4cc3e1cx
	4bqZA3tn0bZBxb9AKCBHVe/oBCUxMuCg=
X-Gm-Gg: ASbGncsSzctwXdUbtdDcsJC6Fa1fSHmCGwDZOaVPGex8rzpmEDPhqqqovaZyc3Vyfj5
	12/KBGPpDEBndtPzoPJXgwWFS07V7NMSXOjOUIKgGcKWeH7+3aM3iZc20hgCWkg4VLRRXHMSjcD
	fZwJlfNPJZSrQHoAsJ39gjmP8z5yhFM//63QdMKwwGNQOWbZtivz1D+YdzoSFLF/elVIZycP4L5
	TSXC3FUTQ==
X-Google-Smtp-Source: AGHT+IGepFQOPMOyNUYUGUVX/Mvk8Emg1Y0NQjdN9hD4Jkz0yjdWaSsJW0rXb7wff23nsaMPJsSVN/LdK9A0Pe+A6F4=
X-Received: by 2002:a05:690c:260a:b0:70d:ed5d:b4b4 with SMTP id
 00721157ae682-719b4236d72mr78125137b3.24.1753335612137; Wed, 23 Jul 2025
 22:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721213528.2885035-1-karunika.choo@arm.com> <20250721213528.2885035-5-karunika.choo@arm.com>
In-Reply-To: <20250721213528.2885035-5-karunika.choo@arm.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Wed, 23 Jul 2025 22:40:01 -0700
X-Gm-Features: Ac12FXx1F7rhsKQbBc59RnMIjbM7gzgzPyp5Do0qyLTNTnGSdWkbyvf-ZDMAEf8
Message-ID: <CAPaKu7S3=8UASg70E9LQcGiqKq319asOwv7pAhBEMAQgwh608Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] drm/panthor: Add support for Mali-Gx15 family of GPUs
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 3:13=E2=80=AFPM Karunika Choo <karunika.choo@arm.co=
m> wrote:
>
> Mali-Gx15 introduces a new GPU_FEATURES register that provides
> information about GPU-wide supported features. The register value will
> be passed on to userspace via gpu_info.
>
> Additionally, Mali-Gx15 presents an 'Immortalis' naming variant
> depending on the shader core count and presence of Ray Intersection
> feature support.
>
> This patch adds:
> - support for correctly identifying the model names for Mali-Gx15 GPUs.
> - arch 11.8 FW binary support
>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_fw.c   |  1 +
>  drivers/gpu/drm/panthor/panthor_hw.c   | 15 +++++++++++++++
>  drivers/gpu/drm/panthor/panthor_regs.h |  3 +++
>  include/uapi/drm/panthor_drm.h         |  3 +++
>  4 files changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index b7b454d16f12..fa6e0b48a0b2 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1404,3 +1404,4 @@ int panthor_fw_init(struct panthor_device *ptdev)
>  MODULE_FIRMWARE("arm/mali/arch10.8/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch10.10/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch10.12/mali_csffw.bin");
> +MODULE_FIRMWARE("arm/mali/arch11.8/mali_csffw.bin");
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panth=
or/panthor_hw.c
> index 7f138974d43b..a7583342d797 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -13,6 +13,9 @@ static char *get_gpu_model_name(struct panthor_device *=
ptdev)
>         const u32 gpu_id =3D ptdev->gpu_info.gpu_id;
>         const u32 product_id =3D GPU_PROD_ID_MAKE(GPU_ARCH_MAJOR(gpu_id),
>                                                 GPU_PROD_MAJOR(gpu_id));
> +       const bool ray_intersection =3D !!(ptdev->gpu_info.gpu_features &
> +                                        GPU_FEATURES_RAY_INTERSECTION);
> +       const u8 shader_core_count =3D hweight64(ptdev->gpu_info.shader_p=
resent);
>
>         switch (product_id) {
>         case GPU_PROD_ID_MAKE(10, 2):
> @@ -23,6 +26,15 @@ static char *get_gpu_model_name(struct panthor_device =
*ptdev)
>                 return "Mali-G510";
>         case GPU_PROD_ID_MAKE(10, 4):
>                 return "Mali-G310";
> +       case GPU_PROD_ID_MAKE(11, 2):
> +               if (shader_core_count > 10 && ray_intersection)
> +                       return "Mali-G715-Immortalis";
> +               else if (shader_core_count >=3D 7)
> +                       return "Mali-G715";
> +
> +               fallthrough;
> +       case GPU_PROD_ID_MAKE(11, 3):
> +               return "Mali-G615";
>         }
>
>         return "(Unknown Mali GPU)";
> @@ -53,6 +65,9 @@ static void panthor_gpu_info_init(struct panthor_device=
 *ptdev)
>         ptdev->gpu_info.shader_present =3D gpu_read64(ptdev, GPU_SHADER_P=
RESENT);
>         ptdev->gpu_info.tiler_present =3D gpu_read64(ptdev, GPU_TILER_PRE=
SENT);
>         ptdev->gpu_info.l2_present =3D gpu_read64(ptdev, GPU_L2_PRESENT);
> +
> +       /* Introduced in arch 11.x */
> +       ptdev->gpu_info.gpu_features =3D gpu_read64(ptdev, GPU_FEATURES);
Is this guaranteed to be 0 prior to v11?

>  }
>
>  static void panthor_hw_info_init(struct panthor_device *ptdev)
> diff --git a/drivers/gpu/drm/panthor/panthor_regs.h b/drivers/gpu/drm/pan=
thor/panthor_regs.h
> index 48bbfd40138c..8bee76d01bf8 100644
> --- a/drivers/gpu/drm/panthor/panthor_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_regs.h
> @@ -70,6 +70,9 @@
>  #define GPU_PWR_OVERRIDE0                              0x54
>  #define GPU_PWR_OVERRIDE1                              0x58
>
> +#define GPU_FEATURES                                   0x60
> +#define   GPU_FEATURES_RAY_INTERSECTION                        BIT(2)
> +
>  #define GPU_TIMESTAMP_OFFSET                           0x88
>  #define GPU_CYCLE_COUNT                                        0x90
>  #define GPU_TIMESTAMP                                  0x98
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_dr=
m.h
> index e1f43deb7eca..467d365ed7ba 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -327,6 +327,9 @@ struct drm_panthor_gpu_info {
>
>         /** @pad: MBZ. */
>         __u32 pad;
> +
> +       /** @gpu_features: Bitmask describing supported GPU-wide features=
 */
> +       __u64 gpu_features;
>  };
>
>  /**
> --
> 2.49.0
>


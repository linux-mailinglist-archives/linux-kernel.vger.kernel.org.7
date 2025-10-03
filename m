Return-Path: <linux-kernel+bounces-841638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA75BB7E02
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE51B4EEA93
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4392DE6F3;
	Fri,  3 Oct 2025 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPeMRcCx"
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DA22DA777
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515541; cv=none; b=OknxptDRZ0kk6UhA6HWFiXBsDZ1AMtLLFyatH2cpGq5+aM5R7tqLuMZHpPzuTvm5U6zlMEas5J1uE8sOyiitKq7Q5eyaNuZAlY8Tmm9LROV/93ozSleLSolIHXadhdi58j6g98f7uWK82oGr6RKB8nhkD/39IuhUft4FUGqRSUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515541; c=relaxed/simple;
	bh=++WRUe2aDvANfhEeao915TQLwk/Lfp0RbLMHA3rIrF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+zSqdKwMGODFD7RzEsGDUTfdBSQ+TTMlkfPO+e1xZP0LoVPDLmiexlwJtSG9/aUDcjqBXEhUxC6284xEIPP4S1CWnWyFUOAsH6FpELj5wsiyGd5PomLngeAHmsqZfAITFFpKcV5gn1jldMH2XQuyUT4N078cDYTwXryDrf2dBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPeMRcCx; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-635401a8f5aso2776670d50.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 11:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759515537; x=1760120337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUQoE2+YrP4Piuppn11V4n/Ge5n4X6vhqEU1SyrhiLY=;
        b=QPeMRcCxAsaE4KxHd6n5jJZ4nt+2xjdX8Iv8uKJ2BNIU3kmD8FrxjdUMqHFI3tsLNv
         Llk7CasHt0s84rTncHVZVALtGJlK9gv6a9sb1xjSMPXPd/LWCbAGMNymQHTg8q8WOB4n
         4kJOfoIoL/WcFH+fxnsje1j2Y6VSn5KpTw4zHc7Yn686PPvJdr0SVbWqfRaY9ajU9jwR
         CTDTsVo3IsCEwBCG2sfCn2G+pkdRMrmbPvi6msRVQO7nNVHQMpz8iIOaTu8nG28K/vLj
         r9W2Pu9NdhAz0iw/q57IAPTWakSu4DtBP4lBmxHYe2ex1kShOCA5brWqufxhHlLkpFZx
         oR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759515537; x=1760120337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUQoE2+YrP4Piuppn11V4n/Ge5n4X6vhqEU1SyrhiLY=;
        b=pUpmv/Kqms3DyX8LgWUMpRzbvmYtAjTOxpGHnNQxXF1grLwPOcgDXgU3BpKEpwvwNR
         nhn4Bv3n5+hpDmvfpkRalQxaXyasafM61s8rRDnGPrp82kKhpO52SynQulpBRd+rdg+/
         rnG5Dgj2xtk2JGI89tuqckwTgGuAHs/oxYIwS3LygqLpN5SfHKFAOyLS6N8T6xmb/cLx
         JUOnbNqczJ72VvbAeTKgkVz9fa2M9nJOgBV5HjjDpcW+V38h04AZuCaoHoSW4DgW/Oac
         9KFKIi0f36KJXtFXV5hPz5i0eUVopdTQQn44yk74PRW+xCI1OnpGGVuov1jV5dV6rkb3
         IIQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpsk+7PPPKuT0r9CyhgIZovLH7f2KD/oAWsT6etcNa/JHO6Tq/QcUaKiTJc6ijFxQCOs6lz99zEruD6as=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJTA1bKnjRXrIRE71a1VqveVtEc5PteQoxL+cyqc4iXbaqtiIm
	RRiKma5rgTy3hU3i+i2D3k0Mc2q9DO9HghrReJT3qRIQK/gmTk4eZQetQds2iE6sxej6DSujRqA
	+c5z9BHxTMDeiZ7nhDQDHtkAOsTUK0qY=
X-Gm-Gg: ASbGncuLSuOqmkrZMwoK8U5aiaqH7i3qmnV5xNcfgQqnymu47ADk6usqHf73JfP/0RU
	vbhM4CxXlAAiQbvvODBsh1Lq1CR4yVQlPd8PFUc/lpaxEwOq3v1PJqRxWbKaGDLEP0oK6MtPw2q
	qe/JmLqhlW7ePwCqGAu400pVOIqmNpy4YUEW59C6KfLaRApb/J7NNu1T/5Y+ROiEybfpGnjl+lh
	nEgrEtFNcSTPnPqr6+5ATZBXQr92lJPVpyCPKHz1rIV1P7PaO/5DVlkEEVholAK8nQ/6rN+YQSf
	4sNIgyRReNZG0siF8wof6w==
X-Google-Smtp-Source: AGHT+IGtLMvtFx4RxHoNIBh2x4X8Ab6Ix6GqGCbCEA5mUc1tZP075IB+GlQMmeZfD4IGoIK1kUGSajZNab9Clue8LXg=
X-Received: by 2002:a53:c043:0:20b0:636:1ee5:7745 with SMTP id
 956f58d0204a3-63b99f36944mr3824334d50.0.1759515537310; Fri, 03 Oct 2025
 11:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929-mt8196-gpufreq-v5-0-3056e5ecf765@collabora.com> <20250929-mt8196-gpufreq-v5-5-3056e5ecf765@collabora.com>
In-Reply-To: <20250929-mt8196-gpufreq-v5-5-3056e5ecf765@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 3 Oct 2025 11:18:45 -0700
X-Gm-Features: AS18NWDjAm-QC4ccunNsvz_U1UXKS_05wvPJ1N_78dxhAoW5d44NTw2whZ6ltCU
Message-ID: <CAPaKu7S6_0G4rbRP_nCF0Aw9uy1K8ABqi2z8isvpHcVWkWjJaQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] drm/panthor: call into devfreq for current frequency
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 12:48=E2=80=AFAM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> As it stands, panthor keeps a cached current frequency value for when it
> wants to retrieve it. This doesn't work well for when things might
> switch frequency without panthor's knowledge.
>
> Instead, implement the get_cur_freq operation, and expose it through a
> helper function to the rest of panthor.
>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_devfreq.c | 33 +++++++++++++++++++++++++=
++----
>  drivers/gpu/drm/panthor/panthor_devfreq.h |  2 ++
>  drivers/gpu/drm/panthor/panthor_device.h  |  3 ---
>  drivers/gpu/drm/panthor/panthor_drv.c     |  4 +++-
>  4 files changed, 34 insertions(+), 8 deletions(-)
>
[...]
> +
> +unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev)
> +{
> +       struct panthor_devfreq *pdevfreq =3D ptdev->devfreq;
> +       unsigned long freq =3D 0;
> +       int ret;
> +
> +       if (!pdevfreq || !pdevfreq->devfreq)
> +               return 0;
> +
> +       if (pdevfreq->devfreq->profile->get_cur_freq) {
This and the other two NULL checks above seem unnecessary. But let's
follow other functions and check for pdevfreq->devfreq only.

With that, Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> +               ret =3D pdevfreq->devfreq->profile->get_cur_freq(ptdev->b=
ase.dev,
> +                                                              &freq);
> +               if (ret)
> +                       return 0;
> +       }
> +
> +       return freq;
> +}
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.h b/drivers/gpu/drm/=
panthor/panthor_devfreq.h
> index b7631de695f7d79456478c87e8af5dc47673cd1d..f8e29e02f66cb3281ed4bb4c7=
5cda9bd4df82b92 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.h
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.h
> @@ -18,4 +18,6 @@ void panthor_devfreq_suspend(struct panthor_device *ptd=
ev);
>  void panthor_devfreq_record_busy(struct panthor_device *ptdev);
>  void panthor_devfreq_record_idle(struct panthor_device *ptdev);
>
> +unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev);
> +
>  #endif /* __PANTHOR_DEVFREQ_H__ */
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/p=
anthor/panthor_device.h
> index 9f0649ecfc4fc697a21a8b2fc4dd89c8ecf298df..f32c1868bf6d782d99df9dbd0=
babcea049c917e0 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -214,9 +214,6 @@ struct panthor_device {
>         /** @profile_mask: User-set profiling flags for job accounting. *=
/
>         u32 profile_mask;
>
> -       /** @current_frequency: Device clock frequency at present. Set by=
 DVFS*/
> -       unsigned long current_frequency;
> -
>         /** @fast_rate: Maximum device clock frequency. Set by DVFS */
>         unsigned long fast_rate;
>
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/pant=
hor/panthor_drv.c
> index ea4a37b566a8b215f2b7a09c333a696f1dcdb58f..4d59d94c353c3ca76f4b98a41=
1c8f8284efafd08 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -25,6 +25,7 @@
>  #include <drm/gpu_scheduler.h>
>  #include <drm/panthor_drm.h>
>
> +#include "panthor_devfreq.h"
>  #include "panthor_device.h"
>  #include "panthor_fw.h"
>  #include "panthor_gem.h"
> @@ -1519,7 +1520,8 @@ static void panthor_gpu_show_fdinfo(struct panthor_=
device *ptdev,
>                 drm_printf(p, "drm-cycles-panthor:\t%llu\n", pfile->stats=
.cycles);
>
>         drm_printf(p, "drm-maxfreq-panthor:\t%lu Hz\n", ptdev->fast_rate)=
;
> -       drm_printf(p, "drm-curfreq-panthor:\t%lu Hz\n", ptdev->current_fr=
equency);
> +       drm_printf(p, "drm-curfreq-panthor:\t%lu Hz\n",
> +                  panthor_devfreq_get_freq(ptdev));
>  }
>
>  static void panthor_show_internal_memory_stats(struct drm_printer *p, st=
ruct drm_file *file)
>
> --
> 2.51.0
>


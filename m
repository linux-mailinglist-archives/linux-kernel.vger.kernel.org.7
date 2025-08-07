Return-Path: <linux-kernel+bounces-759102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FFFB1D878
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400A0723844
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE17E2571A1;
	Thu,  7 Aug 2025 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiFV+I1a"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA9713790B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754571704; cv=none; b=Mc0nKHSu8Bib45wdDU3OCb9iEDz2pJItFEDLIsEBw5H3V1WSyzLUPuReLDTpur3kIxO0c5bF1A7cpHZBryWryjOmsmJlthpZx6tZN/KXNt1u+mRgWfsIMD6AMsprMW8ycAjB79pI/GNY/AYB8rlBAqcCCSBKFGY5SJWBfixQ+CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754571704; c=relaxed/simple;
	bh=/mVyMlm4L1f+hvM5DAWxlDZpQus/JU76gET0OrTV/5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L95GAXnqOPrvrtmJJ8CmHROIFmVKb6mPknEvp+Pvk3PTkc53Pfj0dLtQclxVW9HE466yHCIRKW3CN/Yi5diaWsklPsjVU59tm071p/gHJGU4v+6XHS5uhq6216XsyCZCwRTKB2yCog1jM2eUyZwJSOI3XPOK2vM2jQfuL0v/KfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiFV+I1a; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2420c9e3445so1440105ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754571702; x=1755176502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csit/92fkpbpiZ6AKL4lpm9dy77IvCLE9nFZVONA38c=;
        b=BiFV+I1ab8aiPoe6640cX0qCotsKq4cSAi07SWJmNwOqtdWrW89/6OK0M+DHo+M7QT
         0goNP78p3/bvOaTCI1BObdJgQUIFdT57Bq/0RKFX8nA78P/XfOtYWt6sb8KBOfeyeD3/
         JASdBSOjwWPmhd4ZZpOZIZIy7ioMuYtYpWWHRcQyyAPCtLikPj80RvYMFyK4kwsKykOf
         MJukkSgy+ofgyW+xqJaCwPd+QeR7DyuJcwVv0dPNxIZIHN1K044Ni4T7ULRW+xM4p5aP
         YjFDWEDrquUsCFjIn3kBvRQfx3Io7ZzlrrfFRepohSYDdP/c3guVuR4NK12jtKYmwQm6
         prDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754571702; x=1755176502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csit/92fkpbpiZ6AKL4lpm9dy77IvCLE9nFZVONA38c=;
        b=hV+nc7GOJ2j9icaK+1/0IhHqXmHonbw3yIQbEC0yjVsqlF7yG4PcNh8Qx9ZOcnE4Za
         X1BQL8JrYDNuoK1urbJKEm3egdqH7pvxoQb79Bi4dZWt5FFga5o2nfDgMLgaxu8vxF0n
         yS2261fjTClgfa0DtqpjPvocEX53pPKy9gbHfHmlyD8HJu/3dEyfsYdU0Pn5Xl2GUQkh
         w93ToKdK7RvUiC45q0sU7bpFZWDm8Ec8tPYxCiz5Q9VYyzE/ERDs6s5Hs42KCMGvv10z
         FwikNppFfGKbTFs6ZrhRNTPVKxmd8E+KSI+29/E2FYaDfXp0OS1uLUaekFyOhUZ1IInS
         u2Gw==
X-Forwarded-Encrypted: i=1; AJvYcCV7COD80KX2C5naLBUAwe4FLNfUAFJezhPrfBZ7+2rUkWD6kkFkI5MU387PkMTX/zQ7c1LZ1aKwGcnVWK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlRjMe0aM9Ty1eO2swBkdGZ8KmQmVFdTaC0u/pmMapV7+RYmhD
	rn7uc5rkqw+c+rn6tJApcxnI62eAp2kbBukY5Bd2yCccxkChs15Mulco6xHbiO3hACqovtmlYr7
	rnAA2YHpMn6imCwPgG3qWLsQ5+ihfnjc=
X-Gm-Gg: ASbGncupAmyJvIZQ2zl1cIKBdKwhQlzRMnJRKZira2kZvQ8OH0KBS2WEdHmhPnFrl9l
	hcavgMRCb9TsbOAVytNuYKe73iUPxywjxYQgkBJhczostiaHhKzrDsmwcE448mOhyY3SWKoRIGh
	v+KNvqt1uN1CfHp2LqaNuuUirihUIVXnMvmCitIXg/75a2KtkguXQK+1tXG24wHcbL0QoxeYbs5
	bHuvKo=
X-Google-Smtp-Source: AGHT+IFTun8YI94ci/htHjX014sLvLSf/LonYrs5Z2b9fGtFLhJvbnYFieTgtNA2IiUvjT3cJXScNPm71K7j1e/5FUw=
X-Received: by 2002:a17:902:ea0e:b0:240:764e:afab with SMTP id
 d9443c01a7336-2429f4c6eafmr53528225ad.6.1754571701352; Thu, 07 Aug 2025
 06:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807094719.56145-1-oushixiong1025@163.com>
In-Reply-To: <20250807094719.56145-1-oushixiong1025@163.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Aug 2025 09:01:29 -0400
X-Gm-Features: Ac12FXyRTfguGuFdTmafc0zCGvXHu-uSSEEJTDTQOrDFi2VatI0j0G8E3SWv1N4
Message-ID: <CADnq5_PSiQOqTF1VuJNOtSS1M8K5Ycp09PijaDn2eVUiWiCqwg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: skip disabling audio when device is unplugged
To: oushixiong1025@163.com
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sunil Khatri <sunil.khatri@amd.com>, 
	Alexandre Demers <alexandre.f.demers@gmail.com>, Boyuan Zhang <boyuan.zhang@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 5:53=E2=80=AFAM <oushixiong1025@163.com> wrote:
>
> From: Shixiong Ou <oushixiong@kylinos.cn>
>
> When Stopping lightdm and removing amdgpu driver are executed, the follow=
ing
> error is triggered probably:

There's already a patch to fix this here:
https://gitlab.freedesktop.org/drm/amd/-/issues/4481

Alex

>
> Unable to handle kernel paging request at virtual address 0000000000005e0=
0
> .....
> [ 2] [T10084] Call trace:
> [ 2] [T10084]  amdgpu_device_wreg.part.0+0x58/0x110 [amdgpu]
> [ 2] [T10084]  amdgpu_device_wreg+0x20/0x38 [amdgpu]
> [ 2] [T10084]  dce_v6_0_audio_endpt_wreg+0x64/0xd8 [amdgpu]
> [ 2] [T10084]  dce_v6_0_sw_fini+0xa0/0x118 [amdgpu]
> [ 2] [T10084]  amdgpu_device_ip_fini.isra.0+0xdc/0x1e8 [amdgpu]
> [ 2] [T10084]  amdgpu_device_fini_sw+0x2c/0x220 [amdgpu]
> [ 2] [T10084]  amdgpu_driver_release_kms+0x20/0x40 [amdgpu]
> [ 2] [T10084]  devm_drm_dev_init_release+0x8c/0xc0 [drm]
> [ 2] [T10084]  devm_action_release+0x18/0x28
> [ 2] [T10084]  release_nodes+0x5c/0xc8
> [ 2] [T10084]  devres_release_all+0xa0/0x130
> [ 2] [T10084]  device_unbind_cleanup+0x1c/0x70
> [ 2] [T10084]  device_release_driver_internal+0x1e4/0x228
> [ 2] [T10084]  driver_detach+0x90/0x100
> [ 2] [T10084]  bus_remove_driver+0x74/0x100
> [ 2] [T10084]  driver_unregister+0x34/0x68
> [ 2] [T10084]  pci_unregister_driver+0x24/0x108
> [ 2] [T10084]  amdgpu_exit+0x1c/0x3270 [amdgpu]
> [ 2] [T10084]  __do_sys_delete_module.constprop.0+0x1d0/0x330
> [ 2] [T10084]  __arm64_sys_delete_module+0x18/0x28
> [ 2] [T10084]  invoke_syscall+0x4c/0x120
> [ 2] [T10084]  el0_svc_common.constprop.0+0xc4/0xf0
> [ 2] [T10084]  do_el0_svc+0x24/0x38
> [ 2] [T10084]  el0_svc+0x24/0x88
> [ 2] [T10084]  el0t_64_sync_handler+0x134/0x150
> [ 2] [T10084]  el0t_64_sync+0x14c/0x150
> [ 2] [T10084] Code: f9401bf7 f9453e60 8b150000 d50332bf (b9000016)
> [ 2] [T10084] ---[ end trace 0000000000000000 ]---
>
> The adev->rmmio has been unmmaped in amdgpu_device_fini_hw().
>
> So skip disabling audio when device is unplugged.
>
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index 276c025c4c03..48b29990da7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -23,6 +23,7 @@
>
>  #include <linux/pci.h>
>
> +#include <drm/drm_drv.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_modeset_helper.h>
> @@ -1459,8 +1460,10 @@ static void dce_v6_0_audio_fini(struct amdgpu_devi=
ce *adev)
>         if (!adev->mode_info.audio.enabled)
>                 return;
>
> -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> -               dce_v6_0_audio_enable(adev, &adev->mode_info.audio.pin[i]=
, false);
> +       if (!drm_dev_is_unplugged(adev_to_drm(adev))) {
> +               for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> +                       dce_v6_0_audio_enable(adev, &adev->mode_info.audi=
o.pin[i], false);
> +       }
>
>         adev->mode_info.audio.enabled =3D false;
>  }
> --
> 2.25.1
>


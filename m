Return-Path: <linux-kernel+bounces-869164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B27AC07291
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 860004F156E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEE9333457;
	Fri, 24 Oct 2025 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMP+AKp+"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15FB2C21FE
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322102; cv=none; b=qxb5MJ65iBcvbP3mXRc3XXW8Cjc28ClNEocodVpHNNjnRFYKVyVcmAU2D7T/EXVgcNEFp2iBF0ib2W9R8VmaV8xcKNzkB14oC6nC4I1AyYd23MbCKfWcQuW0jDsYneJnknoI5rAhAw+ZAtsUNjnU9G78B9zLN/YjYpTpcHRrWm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322102; c=relaxed/simple;
	bh=aE3TWL1zDslKvuTiEIn6bKu/7HhTT7K3xlcolMUfc5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGjXw/vxTbqI61EcLt7jXWGjjeGAmSwal+NLu6+yPbU3pQuiqh/JImKG2l+xBnI3MslHFq8lmtUXEGw9upOOQbtoIk6rGD5XgpY2hh8cIdKQlkWeyHbauVKOlzqpNQO6Cs6JVWueVjfl/E3+NBsnuflwnRZKnvG3aEkQjXB+E7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMP+AKp+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33fc9550f68so260097a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761322100; x=1761926900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTQVK2aQT1vIN8ZpKJaaMrUDsELoEiIRjPfw0a3iVhI=;
        b=TMP+AKp+BA6f9quM/AGDMKn3vev0/r/1bBwgCBW8+ZuVliJ2zVODLZanTw+Dp2KdqB
         FxiO75dhmdLdoDoeC/2/z996U+qqWGdROtCNOvvJux7EHxaoZYIc3r0ERmrwz2CZrzev
         W2X32qmQpWahA8ANPmoObqgZEjk8Mtz4G3MHyVSymAT/MYbiXLWEMN+JmUp/vA5Uka5a
         hSvooD9UX3XPuGjv7RcqXMm8gUpcz/6EpSLIc59ZGWTOa7Rj/+1b7NDG1L3ZqlpubZWX
         pka4BpeY8GprlrCR2Hs4mYwAV+nYPfsxJwFV2ddwF10O93Ssa6dcmu4pToWsf4whkftL
         ekBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322100; x=1761926900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTQVK2aQT1vIN8ZpKJaaMrUDsELoEiIRjPfw0a3iVhI=;
        b=FGdCLeBxamzc7Mn3tSttiFA0fLwIr8TAQ/YuodseiPMRNXPWtnHUnH+3Kra6ES5AUv
         wpDWACwZ18INXeH5iY8pntd0JyYAO5faeot2GVZHCMXlDbfjgDPUTj+A3LAJER8TJK4q
         XRgvbY9FYKaxfqgorT9F+6kMWhb2fpYRDOB40GHAhezP6+7tRnWvg6zMvYkA4b99ZAa3
         AQD4iimbKCR9onhbpHkUNLL8MOVL6BsKSpADKlw/C4WQyZ6Hu7CKx4KTbNeogg6HfWIW
         psGuAw7fh3mk3sN1EzYJ2+MrxU8f1E81e/bGiskyyFGb+CjVZ8EYLAPSREydo+fr76E3
         h6/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoS6/06X6/3ztuGru0oOkoo3h3n1Ii2fuL09O/sWSoC/HZ4snGDSCZAFrOvJciFIKzOqpeQum1b+7wz70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Yzqgd7OBExxfLyQF/s8g0faeXKbzJAsRKRAZaPJVN1lF0yOq
	NiQRtNEdg6vHFPmBJNr29o3811cSinoAxf5MHrRIcMUQyVCRuu7huKOcwXFTn/fnILVrVsZ+S6e
	Fg81BoAmKzfTJhw0KoaPjSFcpkWmk9Q0=
X-Gm-Gg: ASbGncty6bZDhHHVdbhCJ45L9zaWL+NcZfrVEyTddp7YKPi3EcLEvlnw6I4ynSDKwi6
	T6HGgCWYT1GREbPv7RUyx9jPsqOREbU07i/3jQPgKXCglo44DHB+9fyewobTgKt6+/X/jt0QTks
	d1y9xkc8L/FhPgPgl9uJm+6oV6UvuRr/VZVAlg6hGLMHHoo+WnBsUSg6YF6wkEMe9uXo1tm0tto
	sEfaB8ESrGO/ZpaGwM0xRIyoO96AyYPzP0NJ4Thv0LZEW81IArmzOnENGAx
X-Google-Smtp-Source: AGHT+IHuKMHIzacDRQR5C0tlCqOGlXp+2mvpP1Rw2CFVttYDd7vViELLYU2FSf1zGiwr/4mecZiOM5Dzi7juFV5w05o=
X-Received: by 2002:a17:902:f787:b0:290:aaff:344e with SMTP id
 d9443c01a7336-292d3e447f2mr106851415ad.2.1761322099740; Fri, 24 Oct 2025
 09:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024152152.3981721-1-lkml@antheas.dev> <20251024152152.3981721-4-lkml@antheas.dev>
 <61da9864-b7c8-43f1-b437-36756077b545@amd.com>
In-Reply-To: <61da9864-b7c8-43f1-b437-36756077b545@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Oct 2025 12:08:07 -0400
X-Gm-Features: AS18NWDSc8rqEfOFx3bZ8_HjDIswouVHQNkmMydC8_vInVKkCJow-kZH_kpVpvU
Message-ID: <CADnq5_NPwwtrjYaELVvrC+D5vb4_iosCnghud8i9+NO0zC+_qA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drm/amdgpu: only send the SMU RLC notification on S3
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Antheas Kapenekakis <lkml@antheas.dev>, Alex Deucher <alexander.deucher@amd.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:54=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 10/24/2025 10:21 AM, Antheas Kapenekakis wrote:
> > From: Alex Deucher <alexander.deucher@amd.com>
> >
> > For S0ix, the RLC is not powered down. Rework the Van Gogh logic to
> > skip powering it down and skip part of post-init.
> >
> > Fixes: 8c4e9105b2a8 ("drm/amdgpu: optimize RLC powerdown notification o=
n Vangogh")
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Tested-by: Antheas Kapenekakis <lkml@antheas.dev>
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 8 +++++---
> >   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 6 ++++++
> >   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 +++
> >   3 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 3d032c4e2dce..220b12d59795 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -5243,9 +5243,11 @@ int amdgpu_device_suspend(struct drm_device *dev=
, bool notify_clients)
> >       if (amdgpu_sriov_vf(adev))
> >               amdgpu_virt_release_full_gpu(adev, false);
> >
> > -     r =3D amdgpu_dpm_notify_rlc_state(adev, false);
> > -     if (r)
> > -             return r;
> > +     if (!adev->in_s0ix) {
> > +             r =3D amdgpu_dpm_notify_rlc_state(adev, false);
> > +             if (r)
> > +                     return r;
> > +     }
>
> Just FYI this is going to clash with my unwind failed suspend series [1].
>
> This is fine, just whichever "lands" first the other will need to rework
> a little bit and I wanted to mention it.
>
> Link:
> https://lore.kernel.org/amd-gfx/20251023165243.317153-2-mario.limonciello=
@amd.com/
> [1]
>
> This does have me wondering though why amdgpu_dpm_notify_rlc_state() is
> even in amdgpu_device_suspend()?  This is only used on Van Gogh.
> Should we be pushing this deeper into amdgpu_device_ip_suspend_phase2()?
>
> Or should we maybe overhaul this to move the RLC notification into a
> .set_mp1_state callback instead so it's more similar to all the other ASI=
Cs?
>

TBH, I don't think this is even required at all here.  The rlc is
stopped in smu_disable_dpms() and we already notify the SMU at that
point.  Notifying it again here seems superfluous.  Would need to test
that removing this one doesn't cause an issue with S3.

> >
> >       return 0;
> >   }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/dr=
m/amd/pm/swsmu/amdgpu_smu.c
> > index fb8086859857..244b8c364d45 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -2040,6 +2040,12 @@ static int smu_disable_dpms(struct smu_context *=
smu)
> >           smu->is_apu && (amdgpu_in_reset(adev) || adev->in_s0ix))
> >               return 0;
> >
> > +     /* vangogh s0ix */
> > +     if ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 5=
, 0) ||
> > +          amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 5=
, 2)) &&
> > +         adev->in_s0ix)
> > +             return 0;
> > +
>
> How about for GPU reset, does PMFW handle this too?

I'm not 100% sure.  We need to check with the PMFW team.  I think
vangogh works the same as gfx11 and newer APUs since the s0i3
implementation was more aligned with those chips than RMB.  These
special code paths were added specifically for S3 enablement since the
behavior is different relative to S0ix.

Alex

>
> >       /*
> >        * For gpu reset, runpm and hibernation through BACO,
> >        * BACO feature has to be kept enabled.
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > index 2c9869feba61..0708d0f0938b 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > @@ -2217,6 +2217,9 @@ static int vangogh_post_smu_init(struct smu_conte=
xt *smu)
> >       uint32_t total_cu =3D adev->gfx.config.max_cu_per_sh *
> >               adev->gfx.config.max_sh_per_se * adev->gfx.config.max_sha=
der_engines;
> >
> > +     if (adev->in_s0ix)
> > +             return 0;
> > +
> >       /* allow message will be sent after enable message on Vangogh*/
> >       if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &=
&
> >                       (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
>


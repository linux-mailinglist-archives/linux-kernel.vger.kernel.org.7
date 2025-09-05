Return-Path: <linux-kernel+bounces-803055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E34B459FB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2A5188D068
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADED521A94F;
	Fri,  5 Sep 2025 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqONnOoI"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F342B2D7;
	Fri,  5 Sep 2025 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080933; cv=none; b=PfMdGyKBtsVLlyAhqGBStuiOcVAyE4IQ4/XLt5+dWUmCmMaRFLXzu6d/pfcUEo6fw6ET81pBPkqJzfJ4Ai2+BWZlJ8Zbq8Kgg9JjWvViLOUHoxv4SvoYlEIXTbQkTAlVJqWAUi/+0UPEZhTHMjfrybbPppEY2Wx8kepeVVywk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080933; c=relaxed/simple;
	bh=rdLO+iSC9YCqe675tWrXmT/Mj9ER/EzhNzwbwpiMWYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JapJSqxnRP1HWZdkKtniFyFyigMCU7dA1QJIdcczGG5NjWScI7gOVPzDxsqPG/kCcI7zo64kUh2M5FKL0Sdz0dkH9GnT9bBQFOKmOR2rbhzp2Pkm6grVSIhbezMsJZJPj3lMLMuKZDFbGVCZCIH/tEQ1QYtMtrfULcpbLb03neg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqONnOoI; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7725d367d44so248243b3a.0;
        Fri, 05 Sep 2025 07:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757080931; x=1757685731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmzENMw6YNHe2IJ7FAYcIAfnTl3HXJqQlHsorHVRbJc=;
        b=TqONnOoISU+CcKnRRsPbRbxpUzHIH7BwxKLO8eBZXu8PfjHFTMoonhQp0Gc4vkP+kG
         iOY/b4aPuJqu168CCmQRfnKnCnuQm6EG2XBCpuuN/x4RvYF8XvWBrcZj5soC44UUJoIj
         5BHp3vVwONLfr8PSw4mY1inxQOOCrVS/+iQEC7/A47xfyaEOYFVbzFqBHlv83Sqg3NC9
         gHVdQVX5IBqdnZhFAiddT2LJo9/eaX18kfcS9dTNX2tR7c2Qo1YH4egTyiOfxSUfUwoJ
         NXfYvUwHgviwLTg/qSHX4dt9W+NBtO/vOIQY7/p+V24njkxscoSeV9Y+BOKmdFJniIqh
         SlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757080931; x=1757685731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmzENMw6YNHe2IJ7FAYcIAfnTl3HXJqQlHsorHVRbJc=;
        b=H2tGsWvtdS9y1Tox+0co9Bij/OAFuP/pBl/YLNqcYBm/4AH06xsM2q+kWLNMig4kM6
         hhLMq9GzuaqXLzBCcIhQO9t3QMXz3nJ92laYriI6ZLjII3XJlix6Lu3BWT1m92G2ZHOF
         2Z1aBiCK3ovRPRU9h/oIYsydorxXuzlQUISra1uIdGObA0gdyfWew2LVLulIiAmRsQMy
         hNPMzVOZ/rq91c6zYZWAKUCTeypgHQANVoEI5y4sNOL+v1vrWkeXt0k8angb+B2Exx7e
         N58eweldfXvFNHziZAs5MoFP2YY1ChL88dh7IDdM9Fqq1EcSwsCoBiM6Z9bwcgxvOfY1
         QpzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkl1kgatfi6TOYW1MQqcIDDrbb29hhuJ/xueHzgy1sNAl9NFiCRFzviN0ZzGZrRffKxIPeenzle5Bcj4VeVMI=@vger.kernel.org, AJvYcCWe9gJt1qQgSY6bTtXQQdPFDu3GaHGAWzNLtIj0kj1jaBJk/XNjUdreQjpjA1wLdWv/3zuRNwLv0G985v/T@vger.kernel.org
X-Gm-Message-State: AOJu0YxzC/tMZzNdsfUUp5YF1Y+2p1lpi2sCFVdSAG8JtOD89YHI648l
	lRMIq61M3ixHcnS02Gsk4FDz4HFSLCCf80Id3QOvAj711X/3v+tNOYdm8CDJfGUR/r3QL3kO5ec
	a8JCjnaLfD/TSJ5zpvtAX4x32CZpVFUA=
X-Gm-Gg: ASbGncu71AX/rZVajhXyNR+PHEEuzy7KHyFLZ4loyO/EHR8zeBNsk/EFiwjBv/9cwwp
	q+VbXvHPND5ISWSUk1EPoshEcs8giHjiKw8YNfbQHqOZLGzNNhDAR9BJxo7TfY5j5rmwK329WEi
	RP0RkqX73IaAjXNazoPhemWhmjhIXhEZD5WdNRMReMg+RHpP90TKm2AwvRSwX/CqyGaerC/tbVD
	PM+dZnKjbdwPERTNQ==
X-Google-Smtp-Source: AGHT+IF9rkgtoSMCl0jYFSHVZuyZeCWt9XZMNT1MGcboLMsN9CKxcNZU79FEyRdNtyL0WU9L2+FyKsOgYQInTvQ6ias=
X-Received: by 2002:a17:902:dac8:b0:24f:8286:9e5a with SMTP id
 d9443c01a7336-24f8286a133mr5036715ad.6.1757080930194; Fri, 05 Sep 2025
 07:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aLnhaU9cLeAdim7J@stanley.mountain> <SA1PR12MB814473BD381D10C842F30422EF03A@SA1PR12MB8144.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB814473BD381D10C842F30422EF03A@SA1PR12MB8144.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Sep 2025 10:01:58 -0400
X-Gm-Features: Ac12FXx-WGJ-F0--XB5dXIw5UpADiQRdi1GA0k5IIwFmngy8mfiqzoc0IpdRJ0c
Message-ID: <CADnq5_PZgPKjARKaKrxtKOUhuk8KBOOba75SxnFJD_76W8yDKw@mail.gmail.com>
Subject: Re: [PATCH next] drm/amdgpu: Fix error codes if copy_to_user() fails
To: "Francis, David" <David.Francis@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Arvind Yadav <Arvind.Yadav@amd.com>, 
	"Sharma, Shashank" <Shashank.Sharma@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Fri, Sep 5, 2025 at 8:59=E2=80=AFAM Francis, David <David.Francis@amd.co=
m> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Whoops. Yep, story checks out.
>
> This is
> Reviewed-By: David Francis <David.Francis@amd.com>
> ________________________________
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Thursday, September 4, 2025 2:58 PM
> To: Francis, David <David.Francis@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona Vetter <s=
imona@ffwll.ch>; Arvind Yadav <Arvind.Yadav@amd.com>; Sharma, Shashank <Sha=
shank.Sharma@amd.com>; Thomas Zimmermann <tzimmermann@suse.de>; amd-gfx@lis=
ts.freedesktop.org <amd-gfx@lists.freedesktop.org>; dri-devel@lists.freedes=
ktop.org <dri-devel@lists.freedesktop.org>; linux-kernel@vger.kernel.org <l=
inux-kernel@vger.kernel.org>; kernel-janitors@vger.kernel.org <kernel-janit=
ors@vger.kernel.org>
> Subject: [PATCH next] drm/amdgpu: Fix error codes if copy_to_user() fails
>
> The copy_to_user() function returns the number of bytes that it wasn't
> able to copy, but we should return -EFAULT to the user.
>
> Fixes: 4d82724f7f2b ("drm/amdgpu: Add mapping info option for GEM_OP ioct=
l")
> Fixes: f9db1fc52ceb ("drm/amdgpu: Add ioctl to get all gem handles for a =
process")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 63eb75a579ce..2b58bc805374 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1067,7 +1067,8 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, voi=
d *data,
>                  drm_exec_fini(&exec);
>
>                  if (num_mappings > 0 && num_mappings <=3D args->num_entr=
ies)
> -                       r =3D copy_to_user(u64_to_user_ptr(args->value), =
vm_entries, num_mappings * sizeof(*vm_entries));
> +                       if (copy_to_user(u64_to_user_ptr(args->value), vm=
_entries, num_mappings * sizeof(*vm_entries)))
> +                               r =3D -EFAULT;
>
>                  args->num_entries =3D num_mappings;
>
> @@ -1159,7 +1160,8 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device=
 *dev, void *data,
>          args->num_entries =3D bo_index;
>
>          if (!ret)
> -               ret =3D copy_to_user(u64_to_user_ptr(args->entries), bo_e=
ntries, num_bos * sizeof(*bo_entries));
> +               if (copy_to_user(u64_to_user_ptr(args->entries), bo_entri=
es, num_bos * sizeof(*bo_entries)))
> +                       ret =3D -EFAULT;
>
>          kvfree(bo_entries);
>
> --
> 2.47.2
>


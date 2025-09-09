Return-Path: <linux-kernel+bounces-808567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B67B501BE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F89B7BE57F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A237C352FC2;
	Tue,  9 Sep 2025 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEvZXBfT"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890F734F48C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432130; cv=none; b=In6ZrhlHVFDsX/OgLI26MbbEjBnMuVqTOewr4U+bOVg6AVHXaKoSYXEUj8xbEgaI5TrJ5fOuGQ0FfQuctc99DGLQGDnJBXjc6fF6A7hSJlTp81PXZ3oCWBClo8pcwZKIr3CQbeZIAXJwTbG40H8VRpRXXsxe91hm1PTnxQEs0lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432130; c=relaxed/simple;
	bh=Fq/a1hYveqfilX2beABwo3Isccg1iO0R9DMPHxOXsz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kf37uiYd59+bS7Xsv2VyCUxKGLNAhrwbSBIWnsuj44qvHoQ/KcCFfzKNuHBI3fSvODXxxovRqmSkbvNZHdQCZk8FSlKJTwDcaVAHhq7w8a8WhlBOQwCDNLMbAUN1q3KIobo13Zdz91C67zfm1IrsbvH1a53DDDwDWVSKPOyB7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEvZXBfT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24b1331cb98so9245535ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757432128; x=1758036928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8GWkB9syykE4BVjFSTAYOdo22xPuq6rOAVZtxlTsOY=;
        b=UEvZXBfT7EuAhMEW8p8PPbHC4KyqCBz4/287ad7eKxz13gxfhD9xzsh61kT2Lh/Ph/
         4dVMo7fSId6XIIqducS80jdaCT/UzstFXL3SfU5mh9ff5rJNBvB4es13DfNbFT/nLEqE
         40GO6Dg4/DwViOn/dpuE5BA5Xtvp0PowMpPkJxd8uh1GXTQxHmaKHHSKH4EAO2NW1lUt
         dWVG7osd+Cg67ZdUNsqB7l7Y4ZiyWNlB3cZZ3JdLBJ7EMq6lnmjJaeTX+Q0UyJXJYSBn
         tQTRi+p7hyR+U9ci6eccmpmRTdSjLLaXmh56aOaaIaw/m2HgJvUhmLjiXubVSKlVZulk
         3U8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757432128; x=1758036928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8GWkB9syykE4BVjFSTAYOdo22xPuq6rOAVZtxlTsOY=;
        b=fPfhGICTZsYA4abpD1ZHPSLxv2cL+QPjRH6Vhl452ToEUNX8EOZrv/XbNm+1C4es9+
         YSzC8l3UXoA28D/yuCA/X24a730IrTrR0ijl0EknVJlXgML0dLattOpXqKnsSqoxvqWm
         8qtJIePVpNT5R+ZLuSR6imkuYnGaZzM139IdPYAVlcAijnzvv2tFr090T6+TW7Vu4qUU
         Rc5a3dxNvJk4cCCpxEvWumAJrnnTpKskUGA5JcIhJlc15uZE/Aiu8JxLYDAWVoyf3dl1
         xCnIPYE0StVsk8eY75YsSHPNiZ/HmUGUpuDoDRUOpQbTGiR3SnsiovlNqgATJy4H25ws
         KDcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAQcXP14IOnP5dCb5/6XhO2kcPdXaxZxJJhG+i9mM/gaSD/6fKP69BPgBIHHjzy0IrCdjSM6X7Ul4j8rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhIALgxE2v1xwsqDCftz/h7KHmXbFDMK7CdZKNV0KwihoNGSXe
	ReVM51n6PMxcgICeepbkdEYZKQO0YiuuNGTgX9h3h0qAvj3DSKxPGNjqgfqhnWTLEfbjV540+SU
	IZEBIHQcgrFlAbH5wS+rF0U3Ne8ZrZHR+Mw==
X-Gm-Gg: ASbGnctCLkJjLAdPV6GqXsGWEGGdW0/CNifjNwkJ5SMPFxlXMAXmNtFSWtimGPZhP3Y
	MPbTKzf3TWFihI2m3PjtA2XR0MgjIzfPpGoZ5vrvVuoA27UuFWEHLERVkMshy/29I3m6pcqOUUN
	RjEyka9BHDA8O3+jDDa55dkyCkCGABAiKQO2IlVNBSf191M7I4Evj+hNKNrlG+4waIsHehAMVSO
	kAnqVg=
X-Google-Smtp-Source: AGHT+IENnQgx9GOpffswO6V15fGtrHaA0nF3KXNRPZySzd62PQEvFKMKh8Wvce7O5KirXBk04iY+MZAgHeWms3DCyOs=
X-Received: by 2002:a17:902:cec3:b0:24c:7bc8:a51c with SMTP id
 d9443c01a7336-25172e31d9cmr94477925ad.9.1757432127744; Tue, 09 Sep 2025
 08:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909151146.760450-2-thorsten.blum@linux.dev>
In-Reply-To: <20250909151146.760450-2-thorsten.blum@linux.dev>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Sep 2025 11:35:16 -0400
X-Gm-Features: Ac12FXzaPUWMuCN-x-hshy0CTAfSQd8c0YMhaAvVwkLYzaetb5wApp6nywvJXYE
Message-ID: <CADnq5_MFDZdJg3XFFw9+tWB=_LP47PwE3HXgPK=sryOx+_0wGQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Replace kmalloc + copy_from_user with memdup_user
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Tue, Sep 9, 2025 at 11:29=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Replace kmalloc() followed by copy_from_user() with memdup_user() to
> improve and simplify kfd_criu_restore_queue().
>
> No functional changes intended.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  .../amd/amdkfd/kfd_process_queue_manager.c    | 22 +++++--------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 7fbb5c274ccc..70c17a12cadf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -1004,13 +1004,9 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>         if (*priv_data_offset + sizeof(*q_data) > max_priv_data_size)
>                 return -EINVAL;
>
> -       q_data =3D kmalloc(sizeof(*q_data), GFP_KERNEL);
> -       if (!q_data)
> -               return -ENOMEM;
> -
> -       ret =3D copy_from_user(q_data, user_priv_ptr + *priv_data_offset,=
 sizeof(*q_data));
> -       if (ret) {
> -               ret =3D -EFAULT;
> +       q_data =3D memdup_user(user_priv_ptr + *priv_data_offset, sizeof(=
*q_data));
> +       if (IS_ERR(q_data)) {
> +               ret =3D PTR_ERR(q_data);
>                 goto exit;
>         }
>
> @@ -1022,15 +1018,9 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>                 goto exit;
>         }
>
> -       q_extra_data =3D kmalloc(q_extra_data_size, GFP_KERNEL);
> -       if (!q_extra_data) {
> -               ret =3D -ENOMEM;
> -               goto exit;
> -       }
> -
> -       ret =3D copy_from_user(q_extra_data, user_priv_ptr + *priv_data_o=
ffset, q_extra_data_size);
> -       if (ret) {
> -               ret =3D -EFAULT;
> +       q_extra_data =3D memdup_user(user_priv_ptr + *priv_data_offset, q=
_extra_data_size);
> +       if (IS_ERR(q_extra_data)) {
> +               ret =3D PTR_ERR(q_extra_data);
>                 goto exit;
>         }
>
> --
> 2.51.0
>


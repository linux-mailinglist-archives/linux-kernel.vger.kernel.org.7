Return-Path: <linux-kernel+bounces-734203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13437B07E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7F11C279E9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BAB28F51B;
	Wed, 16 Jul 2025 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmgxYvT4"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0410D274B2E;
	Wed, 16 Jul 2025 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695203; cv=none; b=neJwai/YAqcBqOvdt2b1FeTOw0i/6rH7MHMDMjaaH8fF4Wc6EoeZKL0kLsQx4we6frmOiLXmGqrwERX5S8tBZcmLuO5A8BVNsvFoF3qOaHfVXAdswtLXpQf9QbwdbKm12SKi1Bm8raJ5IjOLi2aISZC7eHZ6YJRiFt4GiPzquaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695203; c=relaxed/simple;
	bh=yrZeZxZaL1oSZl0Ltht0EUolD+c2BK/hG/RGIeVPhWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBc80NT6tPrSkyfZJcaihT5FQ96Rk/z2zTfFsWgtCA+vlSInqSG314u7jwzmD1pUq1VWcgO6rjglmatReGJu7oMycoh14TzrB90uXaP8q7AJs6NZ/pjmtmfgU3hSBkyt+dCX4nOs4rKmd/mWE6OSjqJgE8aMz+xxzHj03XnPZts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmgxYvT4; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-31384c8ba66so55229a91.1;
        Wed, 16 Jul 2025 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752695201; x=1753300001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dERiphi8SN2qWU4cz5FSID1siLlWpDs3Gm8IHGd1cj4=;
        b=XmgxYvT4sEQQeGG0R1qQrkZTwGiO129mU2wQOSNmPdjDWcejr+Q7grd96JGEFpyNw5
         GpdnHuq9gu4cn2rmBHbnwm4rpKuyYkfFwsmw/TzewRZgWpTEku+0YxWVuEkumWGA13FU
         CehexDkOozoowcJ4yLYHhxVkLcwivGNFiTSX564tzhp1IRQqqpDCSN0T2X86XAsrAl0w
         AheRIKPpxP339Af8GKtYy9Mdq3TI9oBh9vBJ7IsGkiPXa8wKlAtIbknfkUundlXX+1bH
         3gSQtoXhV4z30u3/ZfFHPG37lKHKKBCzVFuGN6cNRXb6zH2Zsz4e1xjfWOLuLFzd9+aX
         pgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752695201; x=1753300001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dERiphi8SN2qWU4cz5FSID1siLlWpDs3Gm8IHGd1cj4=;
        b=lhcSu9p+9YeO14OInsDnQaxLKg2pIagmWDfUjpnAkrbotku2QQ3/APXkhW3hJ8Ka3O
         M91PrESnZ7z8vHPUL4Hc65XR7ky8Ay5Uot317tghZj35bY0mR9FLzdNqj4393inXT6Iy
         imu1nAlevoDZjFlIRaAmYiDbCtMbv3v4cQ8i74i0UXKXTBVZ2Cb10+KHrbfkvSOHZh8k
         GrFwzxzthAc3qLRav6xHzjbxL4xp5yOTqFRgDO4yhZ+TBbWlE0JnhU6ReVon+JTRrWT7
         DOBtV8aCrSoLDB6NwTZ4gR5+X9lURbLLAhwprbi+i1k9Zz4z/Xza4c09ClQAT+Dd+tkk
         o+FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg6yBQEbK8BUH49iMmi+MCYAjnFSdMLegqTI6fnMz9XmRxIXD2uyWq86CWknxlIE2q11zjl8jquld0ivomO24=@vger.kernel.org, AJvYcCWvkjLtgNcECTex/InWKUD9dyqLg+pbsnCcAfe+Y4Et9Wy+esN7M/DC2561UP2NSfyfO7fIlHin6GISV6k4@vger.kernel.org
X-Gm-Message-State: AOJu0YzWJn7udRbUSaeInSXqvx4WERq5SWeC0b3hqjHBvuzNWfnUCjoq
	fLVvxkhEZ1WC9/mTqrBYI7M1/M5pQWf7Hr/vZNgsndQhsbRDxi348vLmQva4HM/xC8Us/wnDvBz
	BLC9VQTSQleFhcQgDsfofDiprvPYyXj0=
X-Gm-Gg: ASbGncvwNVZyAn1IMd1R3Y9KbeE9mi96GOCfpTAZSnwbyjuuTqy0n49h9wcvQlRC8Zz
	maWBv20HwFlyTjbvfBcb/sLKVrlKox08+q259p11tpjHSxb/f4TW+10LQr2edifF9wB8f06kk5a
	Wg43ahIBjBsnBeUDQP908B7ymVswdJgqICWsUBCb4qTkf7yQdk+6c3MNwFKUL+QYfXT7fa3CAJB
	kx06KXa
X-Google-Smtp-Source: AGHT+IG514k5VRiW+obbt6A+oNLgvRU+VAxB/IFQYU8x0hq4HIBflZqiyffcLx81uxBEMk6EHCx34UB1XvYWKTTziSE=
X-Received: by 2002:a17:90b:4f8f:b0:30a:80bc:ad4 with SMTP id
 98e67ed59e1d1-31c9e5fd68dmr2197726a91.0.1752695201128; Wed, 16 Jul 2025
 12:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <366557fa7ca8173fd78c58336986ca56953369b9.1752087753.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <366557fa7ca8173fd78c58336986ca56953369b9.1752087753.git.christophe.jaillet@wanadoo.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Jul 2025 15:46:26 -0400
X-Gm-Features: Ac12FXwIJeC3bTU_gBoJ6CtWloLxs-4aqxpxghGcmsfmdyFd7wbRIjGU8uyr99E
Message-ID: <CADnq5_PZ-F=Ut=z05pqTJNs30as2hez-hq2kMariJS3E5N2AXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix missing unlocking in an error path in amdgpu_userq_create()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sunil Khatri <sunil.khatri@amd.com>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 3:28=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If kasprintf() fails, some mutex still need to be released to avoid locki=
ng
> issue, as already done in all other error handling path.
>
> Fixes: c03ea34cbf88 ("drm/amdgpu: add support of debugfs for mqd informat=
ion")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
and pushed out to drm-misc-next.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 513bbc543f40..bce97318965c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -520,8 +520,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm=
_amdgpu_userq *args)
>         }
>
>         queue_name =3D kasprintf(GFP_KERNEL, "queue-%d", qid);
> -       if (!queue_name)
> -               return -ENOMEM;
> +       if (!queue_name) {
> +               r =3D -ENOMEM;
> +               goto unlock;
> +       }
>
>         /* Queue dentry per client to hold MQD information   */
>         queue->debugfs_queue =3D debugfs_create_dir(queue_name, filp->deb=
ugfs_client);
> --
> 2.50.0
>


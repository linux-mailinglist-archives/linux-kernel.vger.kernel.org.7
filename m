Return-Path: <linux-kernel+bounces-773951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 634D6B2ACCC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A6518A4AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3237F2580F3;
	Mon, 18 Aug 2025 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEV5614p"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3040F2580DE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530980; cv=none; b=IslzCspnmoFDB3NmEaqYSZ2sBWG2nnMkq/Sl/2Go1RUgwATPHNXsgR5sa9G9e0WR0hxF5NNSZpOUfQmr5V4CDh6fkp4IyegyyQazSZVbgvVpc5cTapX66kRCFqB0/gp/i5ktjVt2aB9xgpP5f9Sskl65KObTm7XVtiMUT5+sCv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530980; c=relaxed/simple;
	bh=CSxLdD0tl8V+IiOeGkqCSxNKT0TEeg3KGooMp0Qrew4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AovIHoSmBDv1LpWok2dyC2FQzrTnquBwodZN8lblcLOy/u+v9bwOlxH0SPO0oOBJftYAC0Wl5xoAdPtW/d87YJHZmmF6iwJv7dBac7B6U47V0wgNQ3nPiP3NUTVLp44WqTApjtW5C+flLOEn/3Vkvb7MzMu8cpYaDInQvBN4HpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEV5614p; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24457f3d233so7354315ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755530977; x=1756135777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzCbuq+Gbh0OgQBARAQDKXgtinude1MKLs0f7Ap5Gnc=;
        b=iEV5614pIcsdIh7CGgzdMOOhLFUH+n+/u8qdP3+NI6UOGu9NxR6is2pjIfyttXJdE7
         MV9l2gNAN5W4VHgplIaghipbSuxl4AWDY06Y+OFZQaSq9S8XCGkdX/6p9q7fCH+AQhal
         Z4pHzymjDOQ4CNWcwAi482uFtEc7A5gnfq3nQvowVgAIXHdIeFXEwtlo7KHUbdYihKB8
         6eWicQyshOzB2EoiCQn5SzqVIM+mv4MNAXgT6QOGrMPa8XrbdKjmNNbtE1XAFRYU8wah
         8rq3id5SOuthwJZoCtlzfmWWi6kfUg37sGF/5XVZFSONrf8fqYK2xjLa9mzaITCCWc0r
         T8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530977; x=1756135777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RzCbuq+Gbh0OgQBARAQDKXgtinude1MKLs0f7Ap5Gnc=;
        b=ivMtsOZETleetQos4spodoOyO98yjHVLo9W5D6Ox7+6AlBvQJaCO1bzS670iBTsqXo
         Kl8cP5XtmX7coWC1vlYYIjhSVyxJv1N4FMEncXy9VXVsWgA9j9NYT9envZLyzg4KWLl7
         twraqKbtvwAn0+D6Vic93EB1RSS/zPGaQk1cFqs7RIp4o0iBLt4pwYR0QeuduK9vUPG6
         2pqNQSJxOI6SSQB6uB3TxRvXniUSKRYEV1N2IjJ30M6N3Cn2UjBrIEYFaPwfT29olvec
         3U5rEVB03q076Ogh8S5Rch0yw2RcXLR0o5eUxZXvUPbdQB8g+bSMpZ+L7WXKQ69MF5Jr
         FQHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1QeaW6yJwnGnFXW/8m+t9wKhMFkPdfjlQ8NBGFIFeVwYjJzjE1WvfUkLddzER4c6TjYUjVKC4geORhrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDqOaQG6zbC87+WCYk3xgrJfQiiOGE5gWvzS2yU4dimW6iqoAy
	Yw3GDzG3tFozihjVVqkLtpcl0KZFi6EUwF1jV+yiikFxcAHg+qIMCMoYLYoDBo7NiMUWoHiG5hL
	SfWFyvNNqOYvqJEPrgTmyKxug8c/vFjwjwQ==
X-Gm-Gg: ASbGncsIWyeXxePV05zIZuVoKp8cB+rFYvWFN4L3U4Zyy6l7pQtq3iioBMFAipWgSUn
	ePeRGyh+lN32J9hLV+ehpi+ESn8ahYluwK64v7hLrIlpPXPIYwKlD3MC5NPEEEQCxJP91RkCuGq
	8PfunPt7w4XbUjikQE+LMa60f17LkSmPHoxn3Xn4aacOVxHzfdUnzhwHdkYFOlFPh7pRqvK95+U
	bYHZOo=
X-Google-Smtp-Source: AGHT+IFQtuz+CyAMPVEijdts/DpltVK9bMgNuHrnfzEDbJ+REcuaOIIo4N6FA6Q0HHjOTejO5nv+CckyUkZgCWChz8k=
X-Received: by 2002:a17:902:d488:b0:234:f1b5:6e9b with SMTP id
 d9443c01a7336-2446d6d4c76mr89751465ad.1.1755530977058; Mon, 18 Aug 2025
 08:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816143752.397973-1-rongqianfeng@vivo.com> <20250816143752.397973-3-rongqianfeng@vivo.com>
In-Reply-To: <20250816143752.397973-3-rongqianfeng@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Aug 2025 11:29:24 -0400
X-Gm-Features: Ac12FXweR1HbddeALxYgvHcLz-QIOO5fQfMo7oiCGzMfyooW5pNwpZFpeEJq-r4
Message-ID: <CADnq5_Ph-PuhMcr7BE4Jik_y-m0bx_tSe3Hw8xBTRMeehDD-zg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/radeon: Use vmalloc_array and vcalloc to simplify code
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Sat, Aug 16, 2025 at 10:54=E2=80=AFAM Qianfeng Rong <rongqianfeng@vivo.c=
om> wrote:
>
> Use vcalloc() and vmalloc_array() to simplify the functions
> radeon_gart_init().
>
> vmalloc_array() is also optimized better, resulting in less instructions
> being used.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/gpu/drm/radeon/radeon_gart.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gart.c b/drivers/gpu/drm/radeo=
n/radeon_gart.c
> index 4bb242437ff6..acd89a20f272 100644
> --- a/drivers/gpu/drm/radeon/radeon_gart.c
> +++ b/drivers/gpu/drm/radeon/radeon_gart.c
> @@ -346,14 +346,14 @@ int radeon_gart_init(struct radeon_device *rdev)
>         DRM_INFO("GART: num cpu pages %u, num gpu pages %u\n",
>                  rdev->gart.num_cpu_pages, rdev->gart.num_gpu_pages);
>         /* Allocate pages table */
> -       rdev->gart.pages =3D vzalloc(array_size(sizeof(void *),
> -                                  rdev->gart.num_cpu_pages));
> +       rdev->gart.pages =3D vcalloc(rdev->gart.num_cpu_pages,
> +                                  sizeof(void *));
>         if (rdev->gart.pages =3D=3D NULL) {
>                 radeon_gart_fini(rdev);
>                 return -ENOMEM;
>         }
> -       rdev->gart.pages_entry =3D vmalloc(array_size(sizeof(uint64_t),
> -                                                   rdev->gart.num_gpu_pa=
ges));
> +       rdev->gart.pages_entry =3D vmalloc_array(rdev->gart.num_gpu_pages=
,
> +                                              sizeof(uint64_t));
>         if (rdev->gart.pages_entry =3D=3D NULL) {
>                 radeon_gart_fini(rdev);
>                 return -ENOMEM;
> --
> 2.34.1
>


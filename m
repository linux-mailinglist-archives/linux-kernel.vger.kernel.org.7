Return-Path: <linux-kernel+bounces-796784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 526CAB40717
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A1B4E4B17
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70A6312802;
	Tue,  2 Sep 2025 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvH57UaM"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7485305076;
	Tue,  2 Sep 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823799; cv=none; b=XCbXx5dsQvgwTc/BXgZpPYFvK9ZPDcOYgHLHIZZPHCPK4ZJaPK/AB+987e1hs7mXR/QcAvdWOpHT/vwwU6gwTyPvtlzE6Hq22TANvLfh1uVKM1wrAEKkXpTn3v4gKOrVwNkEGtKHqbCuVURz+L5kU1alDEdQuYZ2I5lrVeK6Gek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823799; c=relaxed/simple;
	bh=jD+Jbc/drQAFtPbNLdYeXeEHaA8xlBaFfxTVmtlfSOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTp0fohaVTykbr0xxvH4NwPRaSS5rTnvY2li/rWFBhgdeSvkWNIQMAuARPxM0JosJvv+ohZNmQXzPJjA5XC8yiFqhBwZpbjzl2+wELSuEq3rNhgXfuWlnDAUY8B19na0GVaOj39p88oA0VHFEIwTH33AaqKYONUf/XW2ibbKf9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvH57UaM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24896af0650so12148585ad.3;
        Tue, 02 Sep 2025 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756823797; x=1757428597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+5DHZ7f7XX3p5WOn0gScG+XhwvVRktJH4l0d+5E2fo=;
        b=VvH57UaMoLYJIV0rGKlV7+y0qncjTR9DAuyUHPAEnseOPU3opnQ+wvxULQXg33u9OG
         Mg9X0jZaV1maxsoIwFPVR4G4jY4syIZCOpUDF8IKjj9PlPvMxGKOx98+MGaAtD0KdB4V
         QQPLdGJ3KQv8maCdaPWuxUs7hjIpQn6c5Se1IFlOzyyaIMjAduYCqTzRzq71coey5crJ
         YcQvPGFk2+6Qh1T0tWyZrEBL1Wthz5NmLvAh1bZAEaM3xYngygC8UZJ2D/cduZ39BR9f
         l5rRHKOY+ahr9kpfotr7/xHF521GMgKUgf9DWbdgKpMilOsT+rpxixeHFsYFyE4Sj2wI
         Fm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823797; x=1757428597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+5DHZ7f7XX3p5WOn0gScG+XhwvVRktJH4l0d+5E2fo=;
        b=TW7GWMklSkeIzslQBseqywOyEK4yRm7o25b7DcK5Ytse4gkDSRbFkxOpw3ifsMN0FG
         JY6ZUFQWAWqOC/bDNXj+fCd1ktyf2SJWRyr4DQBjwKj8KlK0ReCQ1YhVsZINEKE1JORW
         77pQukIP10HxiUQ220CSDIHM3tzlzn/E/7G1zJKSZqYK99XbF1vwG8NMLW1s/0hqFeNT
         imyKUGugF/Dovxz3Nl7XhsswOvXjxgMOvOxmRgDGpCCckmRes7/aQKKkPlmvFzoh1/Uy
         iQcNH02fxL9TqAjlprRb4UBroD0GPsGVKh002+gAnT8+HJ6dYJgLPTUi2cZBzi8F+VsB
         y7DA==
X-Forwarded-Encrypted: i=1; AJvYcCVNTXEaFqvW7GFS6ujsIjfpBtwq5hLvLuvlT9jDUgDTwu94qBa2r2MyIdMFMMZkiV0EFJMlW9B8hF/x8B8nLXU=@vger.kernel.org, AJvYcCVpGyE03TSoTfIS5RPQ9s8KWvuQ2ohTHQmtF8KigyI69lMexKurRhnWQA/p/6bLG8u4ckg3QGu9kn7yVRyq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqm4woQZY6UjBYkqQU+4KEi/X9JN5lIB6bc5xFwMKXyMhH+ZH5
	LPMl2gwirvaBiFdQSG0qCBEaa9irocgFVi3KR3VDiSdIiIYsK/M9ueH9aKIfomrfm4CjWDy3BgD
	aczvHhY4Ho35R1SMWAtY0l6UxjWatkPk=
X-Gm-Gg: ASbGncu+s1tIugOLBKccaynkyb4rtHsiWORewXinpROYGr9VNVReohdD9hj5/NPVt3d
	6kI9HAMlm+5bcTd890MVoVAVeiw3oN1Uq0MwCJuMML1ib2v54pLK1Vx3jjktb0wxl55ckmBXYUP
	PiC4v+F2fOmlrBjom3J3oZ7qclg6y4cCiOElIsc2gF6FcZeK+cHDJQbFvYLgbYW8r4myaGmuKwC
	xyHyvs/JqX6CqmKqA==
X-Google-Smtp-Source: AGHT+IFPgkzTBd9tes9+PQfhWEfLEzvwITrvoWHVUGH24ktFOBmrAuVaI+bG/AXvzWzRgDvtiJy30HX8bF8lYdTXaJ0=
X-Received: by 2002:a17:902:d2cb:b0:240:280a:5443 with SMTP id
 d9443c01a7336-2491e5df37cmr109441175ad.3.1756823797052; Tue, 02 Sep 2025
 07:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902124050.2628822-1-colin.i.king@gmail.com>
In-Reply-To: <20250902124050.2628822-1-colin.i.king@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Sep 2025 10:36:24 -0400
X-Gm-Features: Ac12FXwZ7nacaEnLaE5ZJsACt3QtxMTwkwjMKrrERijGQCZdxbCuaPPlAFt-TOk
Message-ID: <CADnq5_Pbv+QHmFEeqV7HT1NY2zFnHAiZ4feb+=HSxoV5Rd=bSA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/amdgpu: Fix missing error return on kzalloc failure
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Hawking Zhang <Hawking.Zhang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, 
	Sunil Khatri <sunil.khatri@amd.com>, John Clements <john.clements@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Tue, Sep 2, 2025 at 8:49=E2=80=AFAM Colin Ian King <colin.i.king@gmail.c=
om> wrote:
>
> Currently the kzalloc failure check just sets reports the failure
> and sets the variable ret to -ENOMEM, which is not checked later
> for this specific error. Fix this by just returning -ENOMEM rather
> than setting ret.
>
> Fixes: 4fb930715468 ("drm/amd/amdgpu: remove redundant host to psp cmd bu=
f allocations")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 1d6e1d5de8fa..3696f48c233b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -448,7 +448,7 @@ static int psp_sw_init(struct amdgpu_ip_block *ip_blo=
ck)
>         psp->cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL)=
;
>         if (!psp->cmd) {
>                 dev_err(adev->dev, "Failed to allocate memory to command =
buffer!\n");
> -               ret =3D -ENOMEM;
> +               return -ENOMEM;
>         }
>
>         adev->psp.xgmi_context.supports_extended_data =3D
> --
> 2.51.0
>


Return-Path: <linux-kernel+bounces-767701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9D1B257E4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05F21BC2075
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE022FE058;
	Wed, 13 Aug 2025 23:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYHv8VTK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F5B2F60DD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755129253; cv=none; b=pYVDclFsYqDheKa7WUUI5eQgz1o7Yy0mkg9gRxaBF/JvgZZXnhRcRri9gEYnSaYR4kvpn/TuuSSrzdhq7txQRD+tz3C4SF6ahSfVKpK5/ftmlRN8jLqcUmGywgmxJn5mrIeDO+4SaREdOJDE4Vj+mHEsmZhgO0R+tfiNZGDzqR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755129253; c=relaxed/simple;
	bh=u7JygzuN8O8D9Rm9/+E7Tyu1Q+aQCD/m/GsaOd0yKUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXFYI/5PTyuw640zIQvFQVqDWKVX5tA9cnwK03NcxPdheqRBjSuptLCjnUuwzNLaeClelKHEkcf+TGMz6ChWh5z2eqGATd7YeEE4jdECHzi8tXSHo94OR3eEddPBLYccDUnUsKfqo8aN40xcwwsrkEdSzH6t8ZZKyC++EGBsYes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYHv8VTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E124C4CEF8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755129253;
	bh=u7JygzuN8O8D9Rm9/+E7Tyu1Q+aQCD/m/GsaOd0yKUg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CYHv8VTKo8CuWcLGz1WzmMaS+9tWfXuo2af2jk1sNinHWzn50hjztoI/wVCkpJOms
	 v2kzASz5wx30tEpRfQcLWG67YoeIvb2kYiCQKH6gepHIGPY942pjL8zJ6UDqwMxgiv
	 kq3rveto+ELOK69LN4b/9gdFM5II3uzU1SdvTRVlm5+lfiawM4XRUBGWEhMjwMzvu4
	 Nn1FxUr/KKrhWGohZ0bJu0K4b+VA8WePkrYHQbd/npPiIbbA+9mw35ONsUDV9NFIJS
	 BrA4lLKDoyvzC0DZfECDNxO9o6mZ1dumc34y4BjXHtAT6LsGyrWn2sSB6+Jjab1kTL
	 YkHjkoxnKHBpA==
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b47156b3b79so354593a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:54:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2fj2rop3J9QzSeDSDCrcnRGKND9r8CGxJgdn8f2zbS7VMFnOOl/Qv6eJ42NxjPGJXDpV0GrkLnXLbRfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCQXqAv0V774i7TL0ExFwc9xvw5r1SNoqHH6oGCnTKB2PiUNc8
	ZGzcqSSYGM3Kx3HRmt/zdjvBTR2TfJ62asCFiCmCdXjpHFtxM/1IiH2fm21fsAp2qJ6lC9deTyB
	y1sQUF8Ce8d1nWkEPllDjLXETira05A==
X-Google-Smtp-Source: AGHT+IGUT/OTIlNyxqe+nQr1qgyFIqgi0Olr7Sv6oTs4ZZrhXaxRN4cOyFxc2NIPsjn1MOi8/uF1Gmy97sX5D5owImA=
X-Received: by 2002:a17:903:2b0b:b0:23f:b00a:d4c with SMTP id
 d9443c01a7336-2445c152e0cmr2701635ad.2.1755129252780; Wed, 13 Aug 2025
 16:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728025036.24953-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20250728025036.24953-1-jason-jh.lin@mediatek.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 14 Aug 2025 07:55:21 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-7wQd_m0G4+gvpH2O5HoWZQKViwZH_x9vqMiyZ9VT8Xg@mail.gmail.com>
X-Gm-Features: Ac12FXyMVcTmpTQFQCgTgXBiMkbJFCMScrI8wGKO9rqUMaeAJeCiroFGQigsTVY
Message-ID: <CAAOTY_-7wQd_m0G4+gvpH2O5HoWZQKViwZH_x9vqMiyZ9VT8Xg@mail.gmail.com>
Subject: Re: [RESEND PATCH] drm/mediatek: Add error handling for old state
 CRTC in atomic_disable
To: Jason-JH Lin <jason-jh.lin@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, David Airlie <airlied@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Daniel Vetter <daniel@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Nancy Lin <nancy.lin@mediatek.com>, 
	Singo Chang <singo.chang@mediatek.com>, Paul-PL Chen <paul-pl.chen@mediatek.com>, 
	Yongqiang Niu <yongqiang.niu@mediatek.com>, Zhenxing Qin <zhenxing.qin@mediatek.com>, 
	Xiandong Wang <xiandong.wang@mediatek.com>, Sirius Wang <sirius.wang@mediatek.com>, 
	Xavier Chang <xavier.chang@mediatek.com>, Jarried Lin <jarried.lin@mediatek.com>, 
	Fei Shao <fshao@chromium.org>, Chen-yu Tsai <wenst@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jason:

Jason-JH Lin <jason-jh.lin@mediatek.com> =E6=96=BC 2025=E5=B9=B47=E6=9C=882=
8=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8810:50=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Introduce error handling to address an issue where, after a hotplug
> event, the cursor continues to update. This situation can lead to a
> kernel panic due to accessing the NULL `old_state->crtc`.
>
> E,g.
> Unable to handle kernel NULL pointer dereference at virtual address
> Call trace:
>  mtk_crtc_plane_disable+0x24/0x140
>  mtk_plane_atomic_update+0x8c/0xa8
>  drm_atomic_helper_commit_planes+0x114/0x2c8
>  drm_atomic_helper_commit_tail_rpm+0x4c/0x158
>  commit_tail+0xa0/0x168
>  drm_atomic_helper_commit+0x110/0x120
>  drm_atomic_commit+0x8c/0xe0
>  drm_atomic_helper_update_plane+0xd4/0x128
>  __setplane_atomic+0xcc/0x110
>  drm_mode_cursor_common+0x250/0x440
>  drm_mode_cursor_ioctl+0x44/0x70
>  drm_ioctl+0x264/0x5d8
>  __arm64_sys_ioctl+0xd8/0x510
>  invoke_syscall+0x6c/0xe0
>  do_el0_svc+0x68/0xe8
>  el0_svc+0x34/0x60
>  el0t_64_sync_handler+0x1c/0xf8
>  el0t_64_sync+0x180/0x188
>
> Adding NULL pointer checks to ensure stability by preventing operations
> on an invalid CRTC state.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: d208261e9f7c ("drm/mediatek: Add wait_event_timeout when disabling=
 plane")
> Signed-off-by: Jason-JH Lin <jason-jh.lin@mediatek.com>
> ---
> RESEND change:
> - Update author and Signed-off-by name.
> ---
>  drivers/gpu/drm/mediatek/mtk_plane.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_plane.c b/drivers/gpu/drm/media=
tek/mtk_plane.c
> index cbc4f37da8ba..02349bd44001 100644
> --- a/drivers/gpu/drm/mediatek/mtk_plane.c
> +++ b/drivers/gpu/drm/mediatek/mtk_plane.c
> @@ -292,7 +292,8 @@ static void mtk_plane_atomic_disable(struct drm_plane=
 *plane,
>         wmb(); /* Make sure the above parameter is set before update */
>         mtk_plane_state->pending.dirty =3D true;
>
> -       mtk_crtc_plane_disable(old_state->crtc, plane);
> +       if (old_state && old_state->crtc)
> +               mtk_crtc_plane_disable(old_state->crtc, plane);
>  }
>
>  static void mtk_plane_atomic_update(struct drm_plane *plane,
> --
> 2.43.0
>


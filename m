Return-Path: <linux-kernel+bounces-767702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1373B257E5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D130E2A61CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408092FE058;
	Wed, 13 Aug 2025 23:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlZ8Ccbb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06CB27462
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755129282; cv=none; b=cDXGpbELvQR7jMosOBA2aH3DTDkOdKzU3G2Ggsx/HtK7RXhAuRKFfiVTU34xJqbaYZIOulztB9nuCQGbbDANLftBKcvyWXXFVA02bXmomSpr4qGrpQvQNMOTgUjDhwoE80YT/OEtE5TPSrS13juo032WC+g6Wn0sqVmgiyRgLeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755129282; c=relaxed/simple;
	bh=u7JygzuN8O8D9Rm9/+E7Tyu1Q+aQCD/m/GsaOd0yKUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=toZg6uL5NEsVSqGLqfUoHwK37rCLyr0gk8haQep93nVG/VSLcH66sGY59D2WnYqu25edx9KN0lrz/rC6LOshwBllkGIyOZhDGg5fHvlSC7taAqA9Ku4xvjkz8jt10hKXLDn+NH3HoQI0szCb5pmszI0oC5TV4/ETniwZcZpzisE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlZ8Ccbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27144C4CEF8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755129282;
	bh=u7JygzuN8O8D9Rm9/+E7Tyu1Q+aQCD/m/GsaOd0yKUg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rlZ8Ccbb6VUoUGfu/EFix+UrZ9kX80W7WiW0o1I/r1cafDGGM52C+f2DxHF/L3Z9k
	 i+Ib01Kl9v5B+akHUontZbZ1at+tTC93SZGc9R8M6ESV+gUZ8k25/n05d2DY5QTupP
	 xuP+u9Gd5fd/ccUvqZUE9Ac5thM89XPoIREFaHN0LCCI4hYo9zg7RcSVYkUsbOmIkJ
	 2fkjebPMVYRVhYQhq52C6/gPC5fPjEHwKhC4hG1XTXDZ1JGsHoAMzfIzde7C4uKZPB
	 r8ZnU2Tr+O4wYcAwz2A7Qkx4jnOLiDTMA1EeJnGcu1TCvo45HOdfx08+o+FBvKyu8x
	 XT0GJD9E6/JRg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6188b6f7f15so524750a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:54:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVL2Zr85/bhfJjqHn5xPd/+UAYpihjWT9qeAfJMwHxmifBd8F7X2KAoGMD+xrLrXBSCpLj5PppG8iEMJt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx19kZlsJzoW3LRLXS3qxjoVs3Q5xb2Tfw3eD8ac+vW65zGXqO+
	w9zBaUGWnkrhyeYZY1eqssvD27izfHaaD7j6oPae0AixP0aRI36uW1FsKTjIokgVMvrE1wwL+tO
	Byt05/D826xTfBQI99ebXch7uZH2+JA==
X-Google-Smtp-Source: AGHT+IHm7/NHMvFJOaYv1HmU01izKx3/cE5F9xQuEpkBuNLuBLekf5TgPhxAshBp58S3bzeaHhOG3dAFIaXjCX26dM0=
X-Received: by 2002:a05:6402:a0d2:b0:618:6a0:69be with SMTP id
 4fb4d7f45d1cf-6188ba072bamr807292a12.25.1755129280432; Wed, 13 Aug 2025
 16:54:40 -0700 (PDT)
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
X-Gm-Features: Ac12FXzBCmzgimD0vx3iwG8xjWCCWq9Wg_h9jQK1PZ8gDSIT0nXra8B7oMcHVZ8
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


Return-Path: <linux-kernel+bounces-769023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E89B26937
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210E71CE2118
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC6E321446;
	Thu, 14 Aug 2025 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3H2CCDt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E00132143F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180681; cv=none; b=j/Sc7m7WBmSP+bxhtvmyzjW7NC8DVLz6xFruhhHSY9Fu9R6tfo78TFePM7HOZXxWmMKZqJEoTvRZxGWoHE/59Kf0HWPhlel5Ojs8+2B0meMiZ8wi4qBsCAVdnkTeNys6lqz/eU4L2wkYQiaKVvw7iYnh3uhxYgYFJkxzKDwa9Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180681; c=relaxed/simple;
	bh=EtreIo4RmDvEX0MIutMMZJFN4Qc14MzIRQ/PqGEOA/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbQ8LRoEonpPodwEMJisvuJCR1O+VM4qMN11AZfxLltSMaX9JXzl6B5DnQk+KQH7tRaya4liQdTHbCIo3DyArmZVVIuQejGIlcbCSe4u+a8/VgnWk5vxl4LHjmkyOdk31R3dfPRCslY2zuGkK75gys+jTs2FCRrrWPUvf6GzLSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3H2CCDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DE0C4CEF9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755180681;
	bh=EtreIo4RmDvEX0MIutMMZJFN4Qc14MzIRQ/PqGEOA/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U3H2CCDtkpLaPL+zNGYLLGYIklZKJL1dXQcCoCHkKwS8EkjwiM6yL8dyT/fOTQPqV
	 3IKHctSv9MmKxK6SqTNHv2pDze74oOtJILIAdSYaCGTC8ZjHECM9KTIXAtbY4dSxxQ
	 ihTBAwSeQdeXZgsPT5p3eSoV7GNYvmobSrayrgUlVQz+dX/jPFJndlB+Op/4j0thNh
	 U0OzxwUIDcKYogrEQmaNyvyfhL66ORNB3mo555QgtZYQd0aMUI0kICDj+k+5VnH5Rk
	 r4aBmq+i6Ii57oNKhTgSZsoqm7YHreWD7yrb53U23z/VBkb5kejrIcWkHEk4CUhBN3
	 SNGp7To7iBL1Q==
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-244581caca6so7092885ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:11:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdR2cKs/m9U7mR0Q094vDfkTv6i29CQZbQfF4/o7DbDOJBwoNJxZoSYQivOV5cJkc7uzecL2ZFrr9vAHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhYj8PHJED4QmbdtspKBdizFDq9xINLO/nkuOgZi3R+ryvmajm
	Te0gQK79/lW6CCGK9e+PG3hPvVI0uvREKqwAjJnnuBNtwQvW77TobQ8kdTZHy3UtpYLd/YXlInb
	p+W6eu+DD5cLItQJ+aHyyeQdQMziTFA==
X-Google-Smtp-Source: AGHT+IEv9bl0mTCA5QeP2B9Sxyl/+418cvcY/Da5c3dtb2moz6zUZWAO3T1U7DLbuoeYmCLdV4cIQSoAiWVpGPO+VXs=
X-Received: by 2002:a17:902:d2c1:b0:240:a430:91d with SMTP id
 d9443c01a7336-244584ed485mr48360715ad.10.1755180680384; Thu, 14 Aug 2025
 07:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-mediatek-drm-fix-dsi-panel-init-v1-1-7af4adb9fdeb@collabora.com>
In-Reply-To: <20250701-mediatek-drm-fix-dsi-panel-init-v1-1-7af4adb9fdeb@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 14 Aug 2025 22:12:28 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9u2R3k5BORM2pwJnE9XOVfFBE_5gDfs8-PD9fBgTtmgQ@mail.gmail.com>
X-Gm-Features: Ac12FXz7hoERrgUkkr3SijSA29p_W0qoePN2uF4iKzdoy_Nb5WblBq2K-Bi3CRU
Message-ID: <CAAOTY_9u2R3k5BORM2pwJnE9XOVfFBE_5gDfs8-PD9fBgTtmgQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: dsi: Fix DSI host and panel bridge
 pre-enable order
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Aradhya Bhatia <a-bhatia1@ti.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Dmitry Baryshkov <lumag@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Louis:

Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com> =E6=96=BC 2025=E5=B9=
=B47=E6=9C=881=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:31=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Since commit c9b1150a68d9 ("drm/atomic-helper: Re-order bridge chain
> pre-enable and post-disable"), the bridge pre_enable callbacks are now
> called before crtc enable, and the bridge post_disable callbacks after
> the crtc disable.
> In the mediatek-drm driver, this change leads to transfer errors on
> mtk_dsi_host_transfer callback processing during the panel bridge
> pre-enable sequence because the DSI host bridge pre_enable and CRTC
> enable sequences, that are enabling the required clocks and PHY using
> mtk_dsi_poweron function, are called after.
>
> So, in order to fix this call order issue, request the DSI host bridge
> be pre-enabled before panel bridge by setting pre_enable_prev_first
> flag on DSI device bridge in the mtk_dsi_host_attach function.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: c9b1150a68d9 ("drm/atomic-helper: Re-order bridge chain pre-enable=
 and post-disable")
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
> This patch fixes an issue that can be observed on boards such as
> MediatekGenio 1200-EVK or 350-EVK with a kernel based on linux-next
> (tag: next-20250635) since commit c9b1150a68d9 ("drm/atomic-helper:
> Re-order bridge chain pre-enable and post-disable").
> In boot logs, there are multiples errors such as IRQ timeouts and
> panel init errors, leading the DSI panel not being enabled:
>
> Example on Genio 1200-EVK:
> ```
> [drm] Wait DSI IRQ(0x00000002) Timeout
> panel-himax-hx8279 1c008000.dsi.0: sending generic data b0 05 failed:
>   -62
> [drm] Wait DSI IRQ(0x00000008) Timeout
> [drm:mtk_dsi_host_transfer [mediatek_drm]] *ERROR* failed to switch cmd
>  mode
> panel-himax-hx8279 1c008000.dsi.0: sending DCS SET_DISPLAY_ON failed:
>   -62
> ```
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index d7726091819c4762698b41060b3d4d8d27940238..0e2bcd5f67b767d92f2697a5b=
8183f67ee178a38 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1002,6 +1002,12 @@ static int mtk_dsi_host_attach(struct mipi_dsi_hos=
t *host,
>                         return PTR_ERR(dsi->next_bridge);
>         }
>
> +       /*
> +        * set flag to request the DSI host bridge be pre-enabled before =
device bridge
> +        * in the chain, so the DSI host is ready when the device bridge =
is pre-enabled
> +        */
> +       dsi->next_bridge->pre_enable_prev_first =3D true;
> +
>         drm_bridge_add(&dsi->bridge);
>
>         ret =3D component_add(host->dev, &mtk_dsi_component_ops);
>
> ---
> base-commit: c6a68d8f7b81a6ce8962885408cc2d0c1f8b9470
> change-id: 20250630-mediatek-drm-fix-dsi-panel-init-1a4b534c40a6
>
> Best regards,
> --
> Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
>


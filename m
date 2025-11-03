Return-Path: <linux-kernel+bounces-883408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21065C2D5CA
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0184188A1B1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD103191C0;
	Mon,  3 Nov 2025 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Moy1kA+m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52192314B82
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189520; cv=none; b=GGBWXm6xhnz8tPmIzIrJSM7jI7uKYGUBHwIuHzzPVBEE87politEAntW/6A8jipIvkWuaOmSn0CO+6WJstR3k7fm4TBBN2Xqqn9atWtFDmYSmj49f75a6i9WW3F0Y5ln201XIwn+fp6i+NxhckxkXWy7YS/M8+UdzdDAc7j/QPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189520; c=relaxed/simple;
	bh=fzn2uWklE5tGYSA7UDjLpALgXVTdhEXtVy9R7XntaPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNG2mbiGy+M81HA0u6l0xc4q0GiSEasfFvhp/4Dqh736uYnbS4kBe12eP+G3AJ/ZiWP41hxFAdRT2lLBtpIeT4S9HYlGZ3iV3J+hD24hLzk83SR9EQ+7hUdBBT2R1LJjvaQP5DeBrIsPPcm0YdVq078Wp0Zxc4PuqVnnB/QntKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Moy1kA+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A19C16AAE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762189519;
	bh=fzn2uWklE5tGYSA7UDjLpALgXVTdhEXtVy9R7XntaPQ=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Moy1kA+m4ZkdW/LzH1xyE/9+86gsPTHKrOH8jRBFBqZRN3YQfRNdfPbf0gwAF8PFr
	 ldywhFyZ+il75QEUGBHD5qy0Q5P6iAjprxkIiisaa3agzK7IuOieEVGkNvx72lbSBJ
	 9zcti1IB/wDWdbmbxtAubd3NWcHjRkseF6WYC31lob/vcjnlM9ifUZksvgKUkj/frI
	 h3HtmdNluGkRe+kb9Ya19jrgYUoY7rF7I2bg3Tmx1j6CCjPlufmJbIHM7EYc6pYxhQ
	 fA2gjmgvNFtHugs3kFAb0CG4r8Ow09gZxMlBJGKReGx9aBApEUUdP9oxjlC1dYmWKc
	 GJ2FyqarjRWDQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-375eff817a3so49054031fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:05:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBN9LeUrUXmCUAMkoE08ChfIga7/uPXdfs/OpY07el401khxqjml5c3aEiyA9/kgbJbVziHhNvLVizBS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXkZp7MoNUafWuqXI3wFnu4wWx76RZqzywhtAGpDOIAEfl0m6t
	xDKY41DQ42k0pZT8G8eeIevf9NZTX6paNMwaukFcDPCvJcjgVXC/6LzonXqiMr1XAPfRrsvBnUe
	OK0zlJHEqVMFuheBNlbiayqdSwQHWQb8=
X-Google-Smtp-Source: AGHT+IFFecWvcK1jARo7+vH1i0fdkgcM3ym8hNovbJFPh3GHwmoUFl+ITibWVEcnlLM/g4nfPOjXXktiS+ImC6As/Vk=
X-Received: by 2002:a05:651c:211a:b0:36e:4481:9e89 with SMTP id
 38308e7fff4ca-37a18d91342mr40664941fa.11.1762189518224; Mon, 03 Nov 2025
 09:05:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-25-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-25-jernej.skrabec@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Nov 2025 01:05:05 +0800
X-Gmail-Original-Message-ID: <CAGb2v67o69htsbDDn7XY=dhVFcGvaz2CUApdPkcrZHX-rL1Xzg@mail.gmail.com>
X-Gm-Features: AWmQ_bn7ssL-pDpY0rKLqDen2nEYYfFMIRhfqe36gObds6juuxJVT53N-TRZXDY
Message-ID: <CAGb2v67o69htsbDDn7XY=dhVFcGvaz2CUApdPkcrZHX-rL1Xzg@mail.gmail.com>
Subject: Re: [PATCH 24/30] drm/sun4i: mixer: Convert heuristics to quirk
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:24=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> Determination if FCC unit can be used for VI layer alpha depends on
> number of VI channels. This info won't be available anymore in future
> to VI layer driver because of DE33 way of allocating planes from same
> pool to different mixers.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c    |  9 +++++++++
>  drivers/gpu/drm/sun4i/sun8i_mixer.h    |  3 +++
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 12 +++++++-----
>  3 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
> index 267a6f75feb2..78bbfbe62833 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -707,6 +707,7 @@ static const struct sun8i_mixer_cfg sun8i_a83t_mixer0=
_cfg =3D {
>         .de_type        =3D SUN8I_MIXER_DE2,
>         .scaler_mask    =3D 0xf,
>         .scanline_yuv   =3D 2048,
> +       .de2_fcc_alpha  =3D 1,
>         .ui_num         =3D 3,
>         .vi_num         =3D 1,
>  };
> @@ -716,6 +717,7 @@ static const struct sun8i_mixer_cfg sun8i_a83t_mixer1=
_cfg =3D {
>         .de_type        =3D SUN8I_MIXER_DE2,
>         .scaler_mask    =3D 0x3,
>         .scanline_yuv   =3D 2048,
> +       .de2_fcc_alpha  =3D 1,
>         .ui_num         =3D 1,
>         .vi_num         =3D 1,
>  };
> @@ -726,6 +728,7 @@ static const struct sun8i_mixer_cfg sun8i_h3_mixer0_c=
fg =3D {
>         .mod_rate       =3D 432000000,
>         .scaler_mask    =3D 0xf,
>         .scanline_yuv   =3D 2048,
> +       .de2_fcc_alpha  =3D 1,
>         .ui_num         =3D 3,
>         .vi_num         =3D 1,
>  };
> @@ -736,6 +739,7 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer0_=
cfg =3D {
>         .mod_rate       =3D 297000000,
>         .scaler_mask    =3D 0xf,
>         .scanline_yuv   =3D 2048,
> +       .de2_fcc_alpha  =3D 1,
>         .ui_num         =3D 3,
>         .vi_num         =3D 1,
>  };
> @@ -746,6 +750,7 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer1_=
cfg =3D {
>         .mod_rate       =3D 297000000,
>         .scaler_mask    =3D 0x3,
>         .scanline_yuv   =3D 2048,
> +       .de2_fcc_alpha  =3D 1,
>         .ui_num         =3D 1,
>         .vi_num         =3D 1,
>  };
> @@ -766,6 +771,7 @@ static const struct sun8i_mixer_cfg sun20i_d1_mixer0_=
cfg =3D {
>         .mod_rate       =3D 297000000,
>         .scaler_mask    =3D 0x3,
>         .scanline_yuv   =3D 2048,
> +       .de2_fcc_alpha  =3D 1,
>         .ui_num         =3D 1,
>         .vi_num         =3D 1,
>  };
> @@ -776,6 +782,7 @@ static const struct sun8i_mixer_cfg sun20i_d1_mixer1_=
cfg =3D {
>         .mod_rate       =3D 297000000,
>         .scaler_mask    =3D 0x1,
>         .scanline_yuv   =3D 1024,
> +       .de2_fcc_alpha  =3D 1,
>         .ui_num         =3D 0,
>         .vi_num         =3D 1,
>  };
> @@ -786,6 +793,7 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer0=
_cfg =3D {
>         .mod_rate       =3D 297000000,
>         .scaler_mask    =3D 0xf,
>         .scanline_yuv   =3D 4096,
> +       .de2_fcc_alpha  =3D 1,
>         .ui_num         =3D 3,
>         .vi_num         =3D 1,
>  };
> @@ -796,6 +804,7 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer1=
_cfg =3D {
>         .mod_rate       =3D 297000000,
>         .scaler_mask    =3D 0x3,
>         .scanline_yuv   =3D 2048,
> +       .de2_fcc_alpha  =3D 1,
>         .ui_num         =3D 1,
>         .vi_num         =3D 1,
>  };
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/=
sun8i_mixer.h
> index d14188cdfab3..def07afd37e1 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> @@ -176,6 +176,8 @@ enum sun8i_mixer_type {
>   *     a functional block.
>   * @de_type: sun8i_mixer_type enum representing the display engine gener=
ation.
>   * @scaline_yuv: size of a scanline for VI scaler for YUV formats.
> + * @de2_fcc_alpha: use FCC for missing DE2 VI alpha capability
> + *     Most DE2 cores has FCC. If number of VI planes is one, enable thi=
s.
>   * @map: channel map for DE variants processing YUV separately (DE33)
>   */
>  struct sun8i_mixer_cfg {
> @@ -186,6 +188,7 @@ struct sun8i_mixer_cfg {
>         unsigned long   mod_rate;
>         unsigned int    de_type;
>         unsigned int    scanline_yuv;
> +       unsigned int    de2_fcc_alpha : 1;
>         unsigned int    map[6];
>  };
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
> index 44e699910b70..8eb3f167e664 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -48,14 +48,16 @@ static void sun8i_vi_layer_update_attributes(struct s=
un8i_layer *layer,
>                 val |=3D (state->alpha =3D=3D DRM_BLEND_ALPHA_OPAQUE) ?
>                         SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_PIXEL =
:
>                         SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_COMBIN=
ED;
> -       } else if (mixer->cfg->vi_num =3D=3D 1) {
> +       }
> +
> +       regmap_write(layer->regs,
> +                    SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, layer->overl=
ay), val);
> +
> +       if (mixer->cfg->de2_fcc_alpha) {
>                 regmap_write(layer->regs,
>                              SUN8I_MIXER_FCC_GLOBAL_ALPHA_REG,
>                              SUN8I_MIXER_FCC_GLOBAL_ALPHA(state->alpha >>=
 8));
>         }
> -
> -       regmap_write(layer->regs,
> -                    SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, layer->overl=
ay), val);

Should probably mention why the order is reversed here, and why it is OK.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>


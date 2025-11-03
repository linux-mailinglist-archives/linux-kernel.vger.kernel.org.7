Return-Path: <linux-kernel+bounces-883423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F38C2D69E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB5218819FA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085CC3195EC;
	Mon,  3 Nov 2025 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlqXc6fd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CEA319605
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189883; cv=none; b=ICjgn8hyFuKXyfTAmG2yiomPbV5j/EtZ/ock7wUHBxB4iWioAYL2zcfbYaeqHwZg6xaz0cHS+GjQpSJG3OBo4NTwTAkbhnU38/vkSG6Ue4dFJ+29Cz5eCc0uDVWa9kX9gRQcTmM3UW9ezeLLszbWnRYQuGtW9JT7GAOku3F4CE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189883; c=relaxed/simple;
	bh=Sv9FQL3Mzv+xYf8NoCGm6lqnm9197fwnn5s+c0L/OC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7/JzIOGmNaDteK0VLf00y9Q8MSkQBa0AxJAGHkWOQZNSd+dnZYr5VtIcLT6OI56/3oyltY3yzP14VCw/UCzjOe3SPt/Xpr5bEkjRUW6apIHW94pni57+NKKYA+4+pfqtRzCy3vULbfDOpu65jcbOHOQl1mwG/63RdO3cekqK1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlqXc6fd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7704C4AF0E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762189882;
	bh=Sv9FQL3Mzv+xYf8NoCGm6lqnm9197fwnn5s+c0L/OC4=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=SlqXc6fdFdwZKkA3NGn+gW1fT8efWP2Pq9Eay/W3Z/vvEZfuiMhms2HFuhmciuSLQ
	 1Kh7RRyWB29Umachh4f15d/U7AQqP3zYHMeYH5OC3ZppNDS1UKTAdPsHgevXW/WW55
	 ve9P/zKD57n3O8qju8FiYDzLkoTNe2h4N+7x0a2rVJjuzTYWH53qtGyPu87G5HYLDv
	 eCmzAwVZo6J+LklFDGA4aj3LdeXYHdHp3670uap8kl2GfnATtEfPe4pICSzf4/kbdD
	 thKd8mjau7IIw+u35stL/MSUdmOQNyQ03rET2COozaTLSqLRDjZQlLrDM1E0HNe3q2
	 pDtzVyQqo3pug==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-378d50e1c77so39071271fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:11:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWbVYJ7FJgXcbmyEnPDO7+na47UPScmtg2Pn3U63ZI3e0X+ASJH041Rak/DILQJg29702dmocbVQFDqi/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YySKrhebf/pZDw1mWKLF6HPHzLAcjQ9Kf1R9AlZwoy6tn3e2IFZ
	pMc4aldzi45RcoIRC1XJJHLcNu+OApvw5zbYt2gJR9x2z6j/edm3Mfmmqqn9vzF8XFQL4pwSqx3
	8pU7AMGf+aYlhNWTySJ+kI52XuIs0Igw=
X-Google-Smtp-Source: AGHT+IGj3r9zUjzPzn9IEygYQzEgz7ukM/+Lp4b6fW21ZV+0fJdeLDp4noFAI8Yrq2hHKB7s/nRse2db5Ak/8EyGv8Q=
X-Received: by 2002:a2e:9205:0:b0:337:e29c:b0d2 with SMTP id
 38308e7fff4ca-37a18de1e52mr34298411fa.41.1762189881006; Mon, 03 Nov 2025
 09:11:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-27-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-27-jernej.skrabec@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Nov 2025 01:11:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v65RecyHZVUN--oSmtzPDpmUHALd3Pqf79a1fKP9yxD8cA@mail.gmail.com>
X-Gm-Features: AWmQ_bkNL0jahcEQaqn8bSZ19J8F-ktWPPiEchcfhtJA1Ye9Nhc1HXJ4hMb0Q_M
Message-ID: <CAGb2v65RecyHZVUN--oSmtzPDpmUHALd3Pqf79a1fKP9yxD8cA@mail.gmail.com>
Subject: Re: [PATCH 26/30] drm/sun4i: mixer: Add quirk for number of VI scalers
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
> On DE2 and DE3, UI scalers are located right after VI scalers. So in
> order to calculate proper UI scaler base address, number of VI scalers
> must be known. In practice, it is same as number of VI channels, but it
> doesn't need to be.
>
> Let's make a quirk for this number. Code for configuring channels and
> associated functions won't have access to vi_num quirk anymore after
> rework for independent planes.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c     | 11 +++++++++++
>  drivers/gpu/drm/sun4i/sun8i_mixer.h     |  2 ++
>  drivers/gpu/drm/sun4i/sun8i_ui_scaler.c | 10 +++++-----
>  3 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
> index 78bbfbe62833..f9131396f22f 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -708,6 +708,7 @@ static const struct sun8i_mixer_cfg sun8i_a83t_mixer0=
_cfg =3D {
>         .scaler_mask    =3D 0xf,
>         .scanline_yuv   =3D 2048,
>         .de2_fcc_alpha  =3D 1,
> +       .vi_scaler_num  =3D 1,
>         .ui_num         =3D 3,
>         .vi_num         =3D 1,
>  };
> @@ -718,6 +719,7 @@ static const struct sun8i_mixer_cfg sun8i_a83t_mixer1=
_cfg =3D {
>         .scaler_mask    =3D 0x3,
>         .scanline_yuv   =3D 2048,
>         .de2_fcc_alpha  =3D 1,
> +       .vi_scaler_num  =3D 1,
>         .ui_num         =3D 1,
>         .vi_num         =3D 1,
>  };
> @@ -729,6 +731,7 @@ static const struct sun8i_mixer_cfg sun8i_h3_mixer0_c=
fg =3D {
>         .scaler_mask    =3D 0xf,
>         .scanline_yuv   =3D 2048,
>         .de2_fcc_alpha  =3D 1,
> +       .vi_scaler_num  =3D 1,
>         .ui_num         =3D 3,
>         .vi_num         =3D 1,
>  };
> @@ -740,6 +743,7 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer0_=
cfg =3D {
>         .scaler_mask    =3D 0xf,
>         .scanline_yuv   =3D 2048,
>         .de2_fcc_alpha  =3D 1,
> +       .vi_scaler_num  =3D 1,
>         .ui_num         =3D 3,
>         .vi_num         =3D 1,
>  };
> @@ -751,6 +755,7 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer1_=
cfg =3D {
>         .scaler_mask    =3D 0x3,
>         .scanline_yuv   =3D 2048,
>         .de2_fcc_alpha  =3D 1,
> +       .vi_scaler_num  =3D 1,
>         .ui_num         =3D 1,
>         .vi_num         =3D 1,
>  };
> @@ -761,6 +766,7 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_c=
fg =3D {
>         .ui_num =3D 1,
>         .scaler_mask =3D 0x3,
>         .scanline_yuv =3D 2048,
> +       .vi_scaler_num  =3D 2,
>         .ccsc =3D CCSC_MIXER0_LAYOUT,
>         .mod_rate =3D 150000000,
>  };
> @@ -772,6 +778,7 @@ static const struct sun8i_mixer_cfg sun20i_d1_mixer0_=
cfg =3D {
>         .scaler_mask    =3D 0x3,
>         .scanline_yuv   =3D 2048,
>         .de2_fcc_alpha  =3D 1,
> +       .vi_scaler_num  =3D 1,
>         .ui_num         =3D 1,
>         .vi_num         =3D 1,
>  };
> @@ -783,6 +790,7 @@ static const struct sun8i_mixer_cfg sun20i_d1_mixer1_=
cfg =3D {
>         .scaler_mask    =3D 0x1,
>         .scanline_yuv   =3D 1024,
>         .de2_fcc_alpha  =3D 1,
> +       .vi_scaler_num  =3D 1,
>         .ui_num         =3D 0,
>         .vi_num         =3D 1,
>  };
> @@ -794,6 +802,7 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer0=
_cfg =3D {
>         .scaler_mask    =3D 0xf,
>         .scanline_yuv   =3D 4096,
>         .de2_fcc_alpha  =3D 1,
> +       .vi_scaler_num  =3D 1,
>         .ui_num         =3D 3,
>         .vi_num         =3D 1,
>  };
> @@ -805,6 +814,7 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer1=
_cfg =3D {
>         .scaler_mask    =3D 0x3,
>         .scanline_yuv   =3D 2048,
>         .de2_fcc_alpha  =3D 1,
> +       .vi_scaler_num  =3D 1,
>         .ui_num         =3D 1,
>         .vi_num         =3D 1,
>  };
> @@ -814,6 +824,7 @@ static const struct sun8i_mixer_cfg sun50i_h6_mixer0_=
cfg =3D {
>         .mod_rate       =3D 600000000,
>         .scaler_mask    =3D 0xf,
>         .scanline_yuv   =3D 4096,
> +       .vi_scaler_num  =3D 1,
>         .ui_num         =3D 3,
>         .vi_num         =3D 1,
>  };
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/=
sun8i_mixer.h
> index def07afd37e1..40b800022237 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> @@ -178,6 +178,7 @@ enum sun8i_mixer_type {
>   * @scaline_yuv: size of a scanline for VI scaler for YUV formats.
>   * @de2_fcc_alpha: use FCC for missing DE2 VI alpha capability
>   *     Most DE2 cores has FCC. If number of VI planes is one, enable thi=
s.
> + * @vi_scaler_num: Number of VI scalers. Used on DE2 and DE3.
>   * @map: channel map for DE variants processing YUV separately (DE33)
>   */
>  struct sun8i_mixer_cfg {
> @@ -189,6 +190,7 @@ struct sun8i_mixer_cfg {
>         unsigned int    de_type;
>         unsigned int    scanline_yuv;
>         unsigned int    de2_fcc_alpha : 1;
> +       unsigned int    vi_scaler_num;

This could be a smaller type. Please do a sweep of the struct after the
refactoring is done and see if any of the types could be shrunk.

And just a nitpick, but I would probably insert it above scaler_mask.


Reviewed-by: Chen-Yu Tsai <wens@kernel.org>


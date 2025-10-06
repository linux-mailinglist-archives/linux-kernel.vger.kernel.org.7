Return-Path: <linux-kernel+bounces-843274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ECBBBECFE
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D377A3B3213
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5993B241690;
	Mon,  6 Oct 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzPIeINn"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B2423DEB6
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771697; cv=none; b=O3zQjoXgWuyEaWe0oPQtgK/rwj9ebl7//JXMA+dFz9SBSSCVca++UqgcYLVx71nksJ2fJukyTtoI2rMQMkOM3FejLvnWlzktKQRiCgjixHfXltr/93LN50Cp45uNwvTfCXlqQRXjOyogxdG+/GOObLpFx+sBHPw2HaybNt+BqwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771697; c=relaxed/simple;
	bh=dqRS7NGZEYneyaOUWtXUMmCzC3muiFRmt6ZMbxvFC3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dC7aOBbkiW9yg9VR8vqRn/AI+rt4+vQKsCSidh2D9kiPkozdh5mtpeFNr+D1GA8w6VLF1+sYpXfQ08QyaMx1S38xYlL5xJduXXbKdxzK1ffqofVRc8LstKMV1ghEXsQtt3OHfn6sLm4eF+FlF2vP3qLv87yL2vFHp9eJa5OhzFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzPIeINn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea21430so316963b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759771695; x=1760376495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GDKfnwebfg6cavOTCKB56yDBm/Zhzbdw0iMvsXnYag=;
        b=ZzPIeINnzoaGz45K0B+dof/WWWiwCVTGvLzypH9p8cHNjk4tfr38QEY56gMf0wCpQS
         FqMQXfd/evgNEo6y6WKeD9OgfLWmHQhXxqpUG5r1/dZWoqQfk77hT3s+ERZz1ylMDWPm
         P/wbQ0DPtVED2XX/roWUtxqYGnyrbQMUiGK4NYOUIMUZyh4hyRmGpL8tR7bsXRVsCHSh
         qepY7rGhRPCj5BWGfiQu4q9DEFhVJx4zDhwvbmNUHnvPlYYkylAGRkYxoh5W3syeztm5
         8L80GYkar8d7nIZzeK1SfZ17JoYfug+VWc2m4z+SuvFM7v4NjjUZ/hQw/BgvsfHASky0
         i64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759771695; x=1760376495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GDKfnwebfg6cavOTCKB56yDBm/Zhzbdw0iMvsXnYag=;
        b=fvfTTXRVKhokTm9LUUCn8IqSfgTzWMOI3UR1jdpHn8bqehfed+N7kU5+tkBMjffmpZ
         MdTvsN9x7TfiVNQAsLEviWcjKvIZMvXyPbeClTDHY2uTzmuGxkbU8In9Wqec8/nP3PJN
         yohkWq9rRVjMJ6Th49qzR9e7PNcBE4WBqQnEdu9LYdskFvcpBw7lXTDElhr2IdPzIo4O
         iI+ZlWAHFPXg4MGOnqirOzwI0QSi1/lDcESTh6H1iFaRrVd+4aB8cJ6Fzr5myqRENbQr
         g1lPWrwpvgoZuG2C0+iH2qCrIdhoZ2jhfvAId2B49H1Nb01dJ4h0idfR5VzKyQaUc1f3
         /G9Q==
X-Gm-Message-State: AOJu0YwNcgFbUseA5zGpLfhzhNwzqw6m8vLvfxq/YnGBvJeCbwbnTWXd
	wsu8PIuEv45dOo7XaR0gyU994bYPIjQtFY0+90ypAx3l8u8E2YM0E0STy+qpADdDJ8zx4cWi7o6
	i0gqT12eUwiK4fNtlj/VuO7zXY4rHx/Y=
X-Gm-Gg: ASbGncsZTyb8ZwH0ot/6bu3K2GTZRJMYA0ZNiJoxGXP/lquCw0DR1NQ66JzvuumH1zW
	6Eam/Qbv0CZ8zfRV2DUNY8Du/DVEfyslQxL68r32bagJBgOkAWdxdwnzT0DCxKrNGysjA4eFlnB
	ZJvcG3XsmY6qUe3pwKo59Fzw4+/njkmV/4ZnEI7uNWOsCrJLKLKVDMoL02+EWnKIBq1LMT4tEYZ
	p5xik5UVwRjAW2G1u42wkfbcqKmPmM=
X-Google-Smtp-Source: AGHT+IGvPeQrk5YFtH2khflLvQDg/9vgHofkKMZDxex/a1mvimIKIjHK1zrwCIBICFwSDWRCp0BHVAyUVlLdtQ8SYl4=
X-Received: by 2002:a17:90b:1b0d:b0:32b:aed4:aa1a with SMTP id
 98e67ed59e1d1-339c27a2515mr7922326a91.4.1759771694946; Mon, 06 Oct 2025
 10:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002210044.1726731-2-ardb+git@google.com>
In-Reply-To: <20251002210044.1726731-2-ardb+git@google.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Oct 2025 13:28:03 -0400
X-Gm-Features: AS18NWD7-N8KS167TRBLTuJkfaeYqaGjNM9efec5tOE9vCI2VuPTAvMNzqdKU9w
Message-ID: <CADnq5_NUJDfctoHf7-vTcM9ACV6fKnKxXDbYYuaGBmgzU9=a-g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix unsafe uses of kernel mode FPU
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, 
	broonie@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Austin Zheng <austin.zheng@amd.com>, 
	Jun Lei <jun.lei@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Thu, Oct 2, 2025 at 5:11=E2=80=AFPM Ard Biesheuvel <ardb+git@google.com>=
 wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The point of isolating code that uses kernel mode FPU in separate
> compilation units is to ensure that even implicit uses of, e.g., SIMD
> registers for spilling occur only in a context where this is permitted,
> i.e., from inside a kernel_fpu_begin/end block.
>
> This is important on arm64, which uses -mgeneral-regs-only to build all
> kernel code, with the exception of such compilation units where FP or
> SIMD registers are expected to be used. Given that the compiler may
> invent uses of FP/SIMD anywhere in such a unit, none of its code may be
> accessible from outside a kernel_fpu_begin/end block.
>
> This means that all callers into such compilation units must use the
> DC_FP start/end macros, which must not occur there themselves. For
> robustness, all functions with external linkage that reside there should
> call dc_assert_fp_enabled() to assert that the FPU context was set up
> correctly.
>
> Fix this for the DCN35, DCN351 and DCN36 implementations.
>
> Cc: Austin Zheng <austin.zheng@amd.com>
> Cc: Jun Lei <jun.lei@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <siqueira@igalia.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c    |  4 ++++
>  .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c    |  6 ++++--
>  .../drm/amd/display/dc/dml/dcn351/dcn351_fpu.c  |  4 ++--
>  .../display/dc/resource/dcn35/dcn35_resource.c  | 16 +++++++++++++++-
>  .../dc/resource/dcn351/dcn351_resource.c        | 17 ++++++++++++++++-
>  .../display/dc/resource/dcn36/dcn36_resource.c  | 16 +++++++++++++++-
>  6 files changed, 56 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
> index 17a21bcbde17..1a28061bb9ff 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
> @@ -808,6 +808,8 @@ void dcn316_update_bw_bounding_box(struct dc *dc, str=
uct clk_bw_params *bw_param
>
>  int dcn_get_max_non_odm_pix_rate_100hz(struct _vcs_dpi_soc_bounding_box_=
st *soc)
>  {
> +       dc_assert_fp_enabled();
> +
>         return soc->clock_limits[0].dispclk_mhz * 10000.0 / (1.0 + soc->d=
cn_downspread_percent / 100.0);
>  }
>
> @@ -815,6 +817,8 @@ int dcn_get_approx_det_segs_required_for_pstate(
>                 struct _vcs_dpi_soc_bounding_box_st *soc,
>                 int pix_clk_100hz, int bpp, int seg_size_kb)
>  {
> +       dc_assert_fp_enabled();
> +
>         /* Roughly calculate required crb to hide latency. In practice th=
ere is slightly
>          * more buffer available for latency hiding
>          */
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
> index 5d73efa2f0c9..15a1d77dfe36 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
> @@ -445,6 +445,8 @@ int dcn35_populate_dml_pipes_from_context_fpu(struct =
dc *dc,
>         bool upscaled =3D false;
>         const unsigned int max_allowed_vblank_nom =3D 1023;
>
> +       dc_assert_fp_enabled();
> +
>         dcn31_populate_dml_pipes_from_context(dc, context, pipes,
>                                               validate_mode);
>
> @@ -498,9 +500,7 @@ int dcn35_populate_dml_pipes_from_context_fpu(struct =
dc *dc,
>
>                 pipes[pipe_cnt].pipe.src.unbounded_req_mode =3D false;
>
> -               DC_FP_START();
>                 dcn31_zero_pipe_dcc_fraction(pipes, pipe_cnt);
> -               DC_FP_END();
>
>                 pipes[pipe_cnt].pipe.dest.vfront_porch =3D timing->v_fron=
t_porch;
>                 pipes[pipe_cnt].pipe.src.dcc_rate =3D 3;
> @@ -581,6 +581,8 @@ void dcn35_decide_zstate_support(struct dc *dc, struc=
t dc_state *context)
>         unsigned int i, plane_count =3D 0;
>         DC_LOGGER_INIT(dc->ctx->logger);
>
> +       dc_assert_fp_enabled();
> +
>         for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
>                 if (context->res_ctx.pipe_ctx[i].plane_state)
>                         plane_count++;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c b/dri=
vers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
> index 6f516af82956..e5cfe73f640a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
> @@ -478,6 +478,8 @@ int dcn351_populate_dml_pipes_from_context_fpu(struct=
 dc *dc,
>         bool upscaled =3D false;
>         const unsigned int max_allowed_vblank_nom =3D 1023;
>
> +       dc_assert_fp_enabled();
> +
>         dcn31_populate_dml_pipes_from_context(dc, context, pipes,
>                                               validate_mode);
>
> @@ -531,9 +533,7 @@ int dcn351_populate_dml_pipes_from_context_fpu(struct=
 dc *dc,
>
>                 pipes[pipe_cnt].pipe.src.unbounded_req_mode =3D false;
>
> -               DC_FP_START();
>                 dcn31_zero_pipe_dcc_fraction(pipes, pipe_cnt);
> -               DC_FP_END();
>
>                 pipes[pipe_cnt].pipe.dest.vfront_porch =3D timing->v_fron=
t_porch;
>                 pipes[pipe_cnt].pipe.src.dcc_rate =3D 3;
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> index 8475c6eec547..32678b66c410 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> @@ -1760,6 +1760,20 @@ enum dc_status dcn35_patch_unknown_plane_state(str=
uct dc_plane_state *plane_stat
>  }
>
>
> +static int populate_dml_pipes_from_context_fpu(struct dc *dc,
> +                                              struct dc_state *context,
> +                                              display_e2e_pipe_params_st=
 *pipes,
> +                                              enum dc_validate_mode vali=
date_mode)
> +{
> +       int ret;
> +
> +       DC_FP_START();
> +       ret =3D dcn35_populate_dml_pipes_from_context_fpu(dc, context, pi=
pes, validate_mode);
> +       DC_FP_END();
> +
> +       return ret;
> +}
> +
>  static struct resource_funcs dcn35_res_pool_funcs =3D {
>         .destroy =3D dcn35_destroy_resource_pool,
>         .link_enc_create =3D dcn35_link_encoder_create,
> @@ -1770,7 +1784,7 @@ static struct resource_funcs dcn35_res_pool_funcs =
=3D {
>         .validate_bandwidth =3D dcn35_validate_bandwidth,
>         .calculate_wm_and_dlg =3D NULL,
>         .update_soc_for_wm_a =3D dcn31_update_soc_for_wm_a,
> -       .populate_dml_pipes =3D dcn35_populate_dml_pipes_from_context_fpu=
,
> +       .populate_dml_pipes =3D populate_dml_pipes_from_context_fpu,
>         .acquire_free_pipe_as_secondary_dpp_pipe =3D dcn20_acquire_free_p=
ipe_for_layer,
>         .release_pipe =3D dcn20_release_pipe,
>         .add_stream_to_ctx =3D dcn30_add_stream_to_ctx,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> index 0971c0f74186..677cee27589c 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> @@ -1732,6 +1732,21 @@ static enum dc_status dcn351_validate_bandwidth(st=
ruct dc *dc,
>         return out ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
>  }
>
> +static int populate_dml_pipes_from_context_fpu(struct dc *dc,
> +                                              struct dc_state *context,
> +                                              display_e2e_pipe_params_st=
 *pipes,
> +                                              enum dc_validate_mode vali=
date_mode)
> +{
> +       int ret;
> +
> +       DC_FP_START();
> +       ret =3D dcn351_populate_dml_pipes_from_context_fpu(dc, context, p=
ipes, validate_mode);
> +       DC_FP_END();
> +
> +       return ret;
> +
> +}
> +
>  static struct resource_funcs dcn351_res_pool_funcs =3D {
>         .destroy =3D dcn351_destroy_resource_pool,
>         .link_enc_create =3D dcn35_link_encoder_create,
> @@ -1742,7 +1757,7 @@ static struct resource_funcs dcn351_res_pool_funcs =
=3D {
>         .validate_bandwidth =3D dcn351_validate_bandwidth,
>         .calculate_wm_and_dlg =3D NULL,
>         .update_soc_for_wm_a =3D dcn31_update_soc_for_wm_a,
> -       .populate_dml_pipes =3D dcn351_populate_dml_pipes_from_context_fp=
u,
> +       .populate_dml_pipes =3D populate_dml_pipes_from_context_fpu,
>         .acquire_free_pipe_as_secondary_dpp_pipe =3D dcn20_acquire_free_p=
ipe_for_layer,
>         .release_pipe =3D dcn20_release_pipe,
>         .add_stream_to_ctx =3D dcn30_add_stream_to_ctx,
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
> index 8bae7fcedc22..d81540515e5c 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
> @@ -1734,6 +1734,20 @@ static enum dc_status dcn35_validate_bandwidth(str=
uct dc *dc,
>  }
>
>
> +static int populate_dml_pipes_from_context_fpu(struct dc *dc,
> +                                              struct dc_state *context,
> +                                              display_e2e_pipe_params_st=
 *pipes,
> +                                              enum dc_validate_mode vali=
date_mode)
> +{
> +       int ret;
> +
> +       DC_FP_START();
> +       ret =3D dcn35_populate_dml_pipes_from_context_fpu(dc, context, pi=
pes, validate_mode);
> +       DC_FP_END();
> +
> +       return ret;
> +}
> +
>  static struct resource_funcs dcn36_res_pool_funcs =3D {
>         .destroy =3D dcn36_destroy_resource_pool,
>         .link_enc_create =3D dcn35_link_encoder_create,
> @@ -1744,7 +1758,7 @@ static struct resource_funcs dcn36_res_pool_funcs =
=3D {
>         .validate_bandwidth =3D dcn35_validate_bandwidth,
>         .calculate_wm_and_dlg =3D NULL,
>         .update_soc_for_wm_a =3D dcn31_update_soc_for_wm_a,
> -       .populate_dml_pipes =3D dcn35_populate_dml_pipes_from_context_fpu=
,
> +       .populate_dml_pipes =3D populate_dml_pipes_from_context_fpu,
>         .acquire_free_pipe_as_secondary_dpp_pipe =3D dcn20_acquire_free_p=
ipe_for_layer,
>         .release_pipe =3D dcn20_release_pipe,
>         .add_stream_to_ctx =3D dcn30_add_stream_to_ctx,
> --
> 2.51.0.618.g983fd99d29-goog
>


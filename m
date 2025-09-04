Return-Path: <linux-kernel+bounces-800955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183FDB43E2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A0797B3D67
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE75307AE4;
	Thu,  4 Sep 2025 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nb8yguAo"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B31B2222AC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994931; cv=none; b=jd+U0qTFIGq2QRdO4nXvYwe43Tu5eyeFb8SeAlcP0n6BbWE9iG+wW3o1Ufw0oTrzE/ESSve+t53XR9qt9qMgA8wx4VoSDjmRSThfnglrju60UIrGoFtVCk7k6RjhfTZoMBjCpmU+ylFZPbJP045XMNA2wc5Q6IVsP//tTnCCw/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994931; c=relaxed/simple;
	bh=y5QQYUlxfbDcypXt7QlRIQ6i+tyHUJc8/60f+8H4gUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sc40GoDtoIXUPJWA7Rj9+9M3Zrqa4b+ou9xk7l22C7aDPTFVAzs5vaONyPTrIEKOdvPb9BLmxf17fybqNbR3nc8lACTedoAQdVBoy7Tw+M9jhHyz24kEwm/+uUaJyl7H44Q/jSSWrSmGPVcnNSkdUMo3p5lt85t6Q5+ZAKsFsWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nb8yguAo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24aacdf40a2so2459655ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756994929; x=1757599729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azFlwDkWnsyIWz8YrYKLv9XaEIMDwp5bFnZG7i2CQ34=;
        b=Nb8yguAokh+UlBKDTON/kg05TykxhuMGEQ9zr1Cnc9E6wMiU1u6XOKVh7PwmsllE0O
         AdrfMXQauodVJsIqK/J0fIrfrKbGYIkx08cakJ76pmLgzTYIAjZLTCOFiGMi5esitIf4
         QZGpTeBBJH2VERhn1w2Aw+9wtukljuYE7g9mFMSFOepbWWpQ5Jkev/HkEb+d2LsR7+Sa
         CSRfVGKR+ZCSIZfnn1+F5CgqmAC2TJipHfOoLI3y20lJ6PbY2jOb1SBgUZxkyccnYkvW
         Bd6RnUVX/kNcs422Ijp7P2RsRM945fB5P4G4Fi13fv5D/LgLYUDiJrImyj1Cx/JJJEp8
         Sqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756994929; x=1757599729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azFlwDkWnsyIWz8YrYKLv9XaEIMDwp5bFnZG7i2CQ34=;
        b=i95BUlaiIi0rZC2uXtXjQWLP/5xHW80l55MyC/BIIpqe838UCf/69iZXMv3cMEYbJa
         OS8hq/xl4KVJdnYOMIUZxmoGg6exbQ761Bx06pr1JlzbaANVofiFLpYXLDGR3GG4Bm3F
         DsAlTTVpM1N7EQbqW7nzz3g28iS7lCH3Jv5KPlEu8wBMm0CqOnyNowahGiBWJnuyYMm1
         IvcVeZDEURQhknFgM4gTSoTiZZbqHa8R0NNlOeeEiYY3hOy9ru+3eLxzdgQPr6qnK2ld
         meSF1LW/qMSRc3RlHULTsmjZN+Jt+y584Vs0i0J0/n5H3Rt5orlJpToP+OmOnwRL9HW9
         9BFg==
X-Forwarded-Encrypted: i=1; AJvYcCX2o9uc2Tl2CsMCl5ttYvrr7Z/KE9g807gp/hGwc0fYR6WEbGVBBIxZ8BwLembkY0NAKiJGUa5FQPUaq90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZFj58jc34gOt+wXU4JX8Vo/JWR4n7/l0uUuUDZ3oXjSGqJhTI
	IpBlnIaVgAWXAg9yOp2bYB9ARPrCCAcWnUS4KAu74VBCac55dzv2dsMQEKa+uC/D0oBbpQDAm+q
	A7tkdRSUdIUqLbQkuwcGo4QL4zHe7Etw=
X-Gm-Gg: ASbGncsb4dJs1MgNbv6gWkScwPTrnhfKTWQkqY/e5Jv5fucguwRx0gnc5zBODfyeq6G
	xCPGNeUSpAIgKMEjPqNPQp3w2aGJA500JsN3SlAQKVyetpmX7n9+tJJHGP5v3nIA3bHpzcB2pRl
	Oa+YVkQ8IaBTiHK3eEJMxuu9MztMr6p0qF0dkVv91yOngT/4j9QL143arUf4L8MgJor48Ei4x7V
	O9pX3k2z8XAKiZMvg==
X-Google-Smtp-Source: AGHT+IG3A/oOmllI9EeSAoQsDWP86EMFhEip9TdgHPyQgVBUC/O5Oz/hIMn4C9xwYI7HW8rOZ/1Xf242F/uEPbRnKTM=
X-Received: by 2002:a17:902:d487:b0:24c:cfcd:7356 with SMTP id
 d9443c01a7336-24ccfcd76demr13277595ad.0.1756994929228; Thu, 04 Sep 2025
 07:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904071024.248230-1-liaoyuanhong@vivo.com>
In-Reply-To: <20250904071024.248230-1-liaoyuanhong@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Sep 2025 10:08:37 -0400
X-Gm-Features: Ac12FXxQ8C2ZxyIz6syHsc08W9fVB9NOOH0MS70w1XTsfUvvyR61j_e0zHNv8lc
Message-ID: <CADnq5_N0Hy=wdmJyCYuL9LWjzH=zoGtusz0iEO_jLHaH-pnQsQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove redundant ternary operators
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Austin Zheng <austin.zheng@amd.com>, 
	Jun Lei <jun.lei@amd.com>, Peichen Huang <PeiChen.Huang@amd.com>, 
	Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, 
	Roman Li <roman.li@amd.com>, po-tchen <robin.chen@amd.com>, Anthony Koo <anthony.koo@amd.com>, 
	Harold Sun <Harold.Sun@amd.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dillon Varone <dillon.varone@amd.com>, Weiguang Li <wei-guang.li@amd.com>, 
	Charlene Liu <Charlene.Liu@amd.com>, 
	"open list:AMD DISPLAY CORE" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Thu, Sep 4, 2025 at 3:29=E2=80=AFAM Liao Yuanhong <liaoyuanhong@vivo.com=
> wrote:
>
> For ternary operators in the form of "a ? true : false" or
> "a ? false : true", if 'a' itself returns a boolean result, the ternary
> operator can be omitted. Remove redundant ternary operators to clean up t=
he
> code.
>
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c | 2 +-
>  .../drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c   | 2 +-
>  drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c            | 2 +-
>  drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c      | 3 +--
>  drivers/gpu/drm/amd/display/modules/freesync/freesync.c       | 4 ++--
>  5 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.=
c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
> index e0558a78b11c..1c1228116487 100644
> --- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
> @@ -812,7 +812,7 @@ bool dcn10_link_encoder_validate_output_with_stream(
>                                         enc10, &stream->timing);
>         break;
>         case SIGNAL_TYPE_EDP:
> -               is_valid =3D (stream->timing.pixel_encoding =3D=3D PIXEL_=
ENCODING_RGB) ? true : false;
> +               is_valid =3D stream->timing.pixel_encoding =3D=3D PIXEL_E=
NCODING_RGB;
>         break;
>         case SIGNAL_TYPE_VIRTUAL:
>                 is_valid =3D true;
> diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_en=
coder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder=
.c
> index 6ab2a218b769..6f30b6cc3c76 100644
> --- a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
> @@ -397,7 +397,7 @@ static bool enc35_is_fifo_enabled(struct stream_encod=
er *enc)
>         uint32_t reset_val;
>
>         REG_GET(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, &reset_val);
> -       return (reset_val =3D=3D 0) ? false : true;
> +       return reset_val !=3D 0;
>  }
>  void enc35_disable_fifo(struct stream_encoder *enc)
>  {
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers=
/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
> index 0318260370ed..9deb03a18ccc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
> @@ -535,7 +535,7 @@ static bool dml2_validate_only(struct dc_state *conte=
xt, enum dc_validate_mode v
>         if (result)
>                 result =3D does_configuration_meet_sw_policies(dml2, &dml=
2->v20.scratch.cur_display_config, &dml2->v20.scratch.mode_support_info);
>
> -       return (result =3D=3D 1) ? true : false;
> +       return result =3D=3D 1;
>  }
>
>  static void dml2_apply_debug_options(const struct dc *dc, struct dml2_co=
ntext *dml2)
> diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/d=
rivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> index b68bcc9fca0a..892907991f91 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> @@ -138,8 +138,7 @@ void setup_dio_stream_attribute(struct pipe_ctx *pipe=
_ctx)
>                 stream_encoder->funcs->dvi_set_stream_attribute(
>                                 stream_encoder,
>                                 &stream->timing,
> -                               (stream->signal =3D=3D SIGNAL_TYPE_DVI_DU=
AL_LINK) ?
> -                                               true : false);
> +                               stream->signal =3D=3D SIGNAL_TYPE_DVI_DUA=
L_LINK);
>         else if (dc_is_lvds_signal(stream->signal))
>                 stream_encoder->funcs->lvds_set_stream_attribute(
>                                 stream_encoder,
> diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/dr=
ivers/gpu/drm/amd/display/modules/freesync/freesync.c
> index 71efd2770c99..ce421bcddcb0 100644
> --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> @@ -226,8 +226,8 @@ static void update_v_total_for_static_ramp(
>         unsigned int target_duration_in_us =3D
>                         calc_duration_in_us_from_refresh_in_uhz(
>                                 in_out_vrr->fixed.target_refresh_in_uhz);
> -       bool ramp_direction_is_up =3D (current_duration_in_us >
> -                               target_duration_in_us) ? true : false;
> +       bool ramp_direction_is_up =3D current_duration_in_us >
> +                               target_duration_in_us;
>
>         /* Calculate ratio between new and current frame duration with 3 =
digit */
>         unsigned int frame_duration_ratio =3D div64_u64(1000000,
> --
> 2.34.1
>


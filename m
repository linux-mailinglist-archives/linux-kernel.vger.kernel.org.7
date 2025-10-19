Return-Path: <linux-kernel+bounces-859592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4F6BEE0AA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7D3B4E3C55
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAC12253F2;
	Sun, 19 Oct 2025 08:25:31 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165831643B
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760862330; cv=none; b=D0j+iRNTssHlWG9ha20KB6cIu44AjvWXL5NO0S1J1XteUCz9X9M7B1Rv6CZQqNwTAX8XgWH4Q3PNAcCW0bgLUMcMqVKT/zxogF9F8XqytKta06hRb/6rG9uA5o0kTemM2+m2hBd/Y5JRTWRF/YtQSWUiCvU950kjJ3rxrLqKg/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760862330; c=relaxed/simple;
	bh=4h8fA0nb54zpgXZYa5aTVEhQBGP+EvE0aipi3YnSi/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOHxbmwsFfVuoihzBP4FWYSNBXlKeyKZGsMRRwLQhrPRXPH0K/5JNek2zwUeRK2jh4EqbzL1dBy5cEus8fHulsS1GDIomJSGEvmtUHXyM7x0wwjTZUknX/8ymQigy9gqOzdVbgAUQlx9Swwwc/m/65rGAgGnpOPJGQoUufmbPdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57e03279bfeso3826113e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 01:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760862324; x=1761467124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VW3mkeflKClv9lw164K4YGIw8SIsux7V05xBSu2+GpY=;
        b=aAo/pHnETZgKOom09/usEsffTQGHmHWJwrVDlBcoK76cLsa8ScXuXv4gsPmoo6pOoG
         qRoCFV4A14vrTv04cnXKP9F5CVe5OUl65j5QqJbU0ugREYWPOMiOw9kV6/7k5peOAH/J
         s8R3reCsJNgqtlpQuXPud2vivCY5fhE6iR5w2suhO8X2bTcSNANT7/kURbHkRlSW2hlr
         dWTggM/mlV5Dhs5ejJMdR0cXGB0nzSEG+BdtDTGWZYPz/I5gori8FEN2dak1BHhXfEx4
         XWOOFWETzDYlKXueLTHpaIv83EHK4xoFfdv4MpVV6ovVJRJtVdIIXBnuhrsu7tzkotDo
         iiqw==
X-Forwarded-Encrypted: i=1; AJvYcCXlg5RGL1bLh2nQW5j/lpXxZypcEvsATNzBmArJpuWOjfCMmApjVPAvXblf+qIxxtAW+yktuHvaLMqkhWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxywZMVQiQrTFacMqWdyBLoZOmldbltH6BUtMpk4R2o/6khIRHz
	9bmH7ayqpjdtUOYiFoX9cKku/XmIl633aOQcx0dWpK7O5m+q9heCCY0Ap1CXc9bn
X-Gm-Gg: ASbGncvP5gsZiicQsA/85fg4iyiAQVKEeTk2lrsCgzKd+BPH/uEY1H2g/KoLNGtys1U
	oHy498TbTmz13+g4Vqz9/MbhKWSYX8G4C1bR1GMfjBbZIJNMOWUeDoIDIkJN+zmTv1Ah5I+hWQW
	LEsZnO5Snpe+SxMXh/TP0PCrv0vt0ZyR1rULOTl5Ivw1n9jELbCfjSy+RLR4jWG4OMip7gpuMPG
	AtwheNVi1LD1FfPoe8hkuYeBIOrhc1CGhwIBW0Bi1WGYo4UeLuAMOcnG6DZn1KUxYlc4w2oB8el
	1K9qlEtSZcVu6dFAPNPHdWgOhyqFUhwwW01hzELuW0vBRsICveQbBXW7es/rZnB06GduH08c5oY
	o0KgXt8Xb5tPw+s3Zz9ME/XZLmLFZVOHZitSPLjBGVGp83Ocd8P0Nno6FQIan8XtVKJDCldwBp8
	moLWobDUumztZQQU4ZQh0delGfrN4axbkY+1LDCTDVWbY=
X-Google-Smtp-Source: AGHT+IGngHSafcb/UvITddvHqMRg/NJ6z8FmGT5flOvRp94GDSbAummNeWCSYuo3lqYBKh6tbSBkWA==
X-Received: by 2002:a05:6512:ea8:b0:579:bb21:a47b with SMTP id 2adb3069b0e04-591d841a879mr2765600e87.28.1760862323711;
        Sun, 19 Oct 2025 01:25:23 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deec0b98sm1386615e87.40.2025.10.19.01.25.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 01:25:23 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-371e4858f74so40333591fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 01:25:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxRdRjjW7HNU7HA5myRlQ/fW3ReFg9BwhSmP3lIMyyKREhUn4BtwvMasNmZ4M1I3F0MNmca1V0BRVncbk=@vger.kernel.org
X-Received: by 2002:a05:651c:25da:10b0:376:41f5:a6ca with SMTP id
 38308e7fff4ca-37781f4148fmr32251171fa.0.1760862322639; Sun, 19 Oct 2025
 01:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-6-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-6-jernej.skrabec@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 19 Oct 2025 16:25:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v66XAFkKaM8Gi=0fZknvrit0WmXA0G_kBYmye5APnhxOOQ@mail.gmail.com>
X-Gm-Features: AS18NWC1T4rH1wgxWICMNRFWZoKmEq_TA059og5Su5dyIUywI4YDjh2R7R0IKKc
Message-ID: <CAGb2v66XAFkKaM8Gi=0fZknvrit0WmXA0G_kBYmye5APnhxOOQ@mail.gmail.com>
Subject: Re: [PATCH 05/30] drm/sun4i: vi_layer: Move check from update to
 check callback
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:23=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> DRM requires that all check are done in atomic_check callback. Move
> one check from atomic_commit to atomic_update callback.

Same comment as the previous patch.

> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
> index bd6c7915bbc4..c80bdece5ffc 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -217,16 +217,11 @@ static int sun8i_vi_layer_update_formats(struct sun=
8i_mixer *mixer, int channel,
>         struct drm_plane_state *state =3D plane->state;
>         u32 val, ch_base, csc_mode, hw_fmt;
>         const struct drm_format_info *fmt;
> -       int ret;
>
>         ch_base =3D sun8i_channel_base(mixer, channel);
>
>         fmt =3D state->fb->format;
> -       ret =3D sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
> -       if (ret) {
> -               DRM_DEBUG_DRIVER("Invalid format\n");
> -               return ret;
> -       }
> +       sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
>
>         val =3D hw_fmt << SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSET;
>         regmap_update_bits(mixer->engine.regs,
> @@ -322,7 +317,9 @@ static int sun8i_vi_layer_atomic_check(struct drm_pla=
ne *plane,
>         struct sun8i_layer *layer =3D plane_to_sun8i_layer(plane);
>         struct drm_crtc *crtc =3D new_plane_state->crtc;
>         struct drm_crtc_state *crtc_state;
> -       int min_scale, max_scale;
> +       const struct drm_format_info *fmt;
> +       int min_scale, max_scale, ret;
> +       u32 hw_fmt;
>
>         if (!crtc)
>                 return 0;
> @@ -332,6 +329,13 @@ static int sun8i_vi_layer_atomic_check(struct drm_pl=
ane *plane,
>         if (WARN_ON(!crtc_state))
>                 return -EINVAL;
>
> +       fmt =3D new_plane_state->fb->format;
> +       ret =3D sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
> +       if (ret) {
> +               DRM_DEBUG_DRIVER("Invalid plane format\n");
> +               return ret;
> +       }
> +
>         min_scale =3D DRM_PLANE_NO_SCALING;
>         max_scale =3D DRM_PLANE_NO_SCALING;
>
> --
> 2.51.0
>
>


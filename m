Return-Path: <linux-kernel+bounces-773969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F04B2ACFF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489B518A59F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C5123D7D3;
	Mon, 18 Aug 2025 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtPsWEIX"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6DC2765EB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531579; cv=none; b=tQkYMKn6oGsJb2e+BEkyOG6p5ZDE0gf36Kzy9I4VQEtY51e9Wc9rQ4nO5MimLi0mlke8e0tEPpF1WYfxCAZoAQFaBF9zLBsDZgMhbDCVs7U0cq6P7P2eiIUA30RmKDYkTbAJOV00koRnWFw/p0rN2cTx8mBHl/TugxUXX9gUd2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531579; c=relaxed/simple;
	bh=yP9gVZGTEEwNyCB+9wqg7OQOZOtS1ZAoqVKOaXojnE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lwso/SbYzidiqsBRNGt5Y5W+odMw4cJGtAfSufkvJy5vF4wRQ/lLTFANqxGajxTquGBWaNrpJ/beBdpLnmrcH+1fxToFDPVxwTO9d4FfYvosOA07wQJu8cLRtQ3GowmQ9+eilplW+aIAlODAFGVPUZ1KiYMZvX1esNEfb49C7aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtPsWEIX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2445806ca1aso6978655ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755531577; x=1756136377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfnjYmDvi00kKX9ijywUbzGRAHiyS/deinjfiKUZLgs=;
        b=DtPsWEIXWGOCSgZSOPrNo8Jgl2UXq1zijZr5DJZyLiHTeeERaeZNa62LsXHBHg0x91
         Qc0CkeC3f6s6GJ+YRF5eNawsiTQy0W62Lyi86/pSaxjKGxS9OnRTcobNfppa+cUWkUSb
         XUX95xR5dxhAQnTRD6SLOMr8Z4NyY+SRkPh5Chi0N401Yu0I4ZBONtyt/mpR+rWGLEMY
         ot8gNcUmjbendXddS++zVkdFKE+MzS68ebo/C8SzGQax1PYGPDKTQRgQbxtCzyw8OW8d
         XL++ROXdt4gsjhutf3cjrse4qJHvR5FymZKz7bnf15wQQmyHA6Vl8TOd9arbBzXnsqWV
         yI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755531577; x=1756136377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfnjYmDvi00kKX9ijywUbzGRAHiyS/deinjfiKUZLgs=;
        b=aeTHdFlQgl2dDyiKwnVqZVDxrrZVTQSH2CfpUvIgSntuoTdwdPrEm0CUUGzOAy5HTy
         Sm2ytxKLrtzE2yvVoRYZwa5fOZTc4DgGboZOKLwxeWRXt3od0qyT0r1QHNxobMUUxWjm
         q3ZyVN8bD8rF8XUbAmrs0uMyP+KvflPv3wAYdhEd61qBwi9t8iPvPxSMY0AhQ0wIdZYr
         9dPLouD8GyTJ3n7hwnuSefLF+D5zMnil1n0BCc8oP3w5vnvWWjopphw9YRkwRhgDulo7
         XCXg41cLK3O7yMXxsaPK7Iqa5VGGKxXMTYu+XxQ7vULi45U2m+NKo8S666kd17qfhSi2
         t4zg==
X-Forwarded-Encrypted: i=1; AJvYcCW9r7xwR0hnJFYlz/agTAy/gj4YoVWmwHqW3QaYINBb87uOlZ+hh5sZqpSXV0OAp71UHq+5OTaXOUg/CDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwddJ3QXh8oXqwA3Utxt42C6jDVPT2NGcJQ2WXfticgW3z+Yuir
	jYqnjVFdyhyGwGEfjaOzD237K8h4cHoDJzWEG78LrQ6BhoHCfNB4i8l57gOYb+TNFL9UmyCaguk
	qH6VklzbypDpspABmJk8CZJb2QuSWwe4=
X-Gm-Gg: ASbGncvN5rw7rAv9XbT16R1pN6LrIsBWq7Uo+7dhdyQM2FvHpSn0SHNz8ej3uQsZ1Ns
	ZnGVwDS4RgntEVR42wVNkYhq6uShtOoPUzGAgrBZIZCNTI5QE3eWaI0I1hLcCjMjcoDmCsGQIQf
	44xZLMMGhdZ74hlh4NQ0vpkn0PkfAwSAmoJwwiVnDF2UxPw1fD3NwZEcNlNMCCnwTOI4lST+Kzr
	C7EkcbqaCM2dJoMyw==
X-Google-Smtp-Source: AGHT+IGlBBr60eEbVg+cyrKDQeXKdn03ukayzCoYut2ij9XXvWFExe6ybSIht++TyMeCrw7fNNqpAsNO0VXJEYzuY60=
X-Received: by 2002:a17:902:f541:b0:240:9ab5:4cae with SMTP id
 d9443c01a7336-2446d5d6193mr75967755ad.1.1755531576879; Mon, 18 Aug 2025
 08:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_E5B1CAABB0320691EB730CDB19E55EA85E05@qq.com>
In-Reply-To: <tencent_E5B1CAABB0320691EB730CDB19E55EA85E05@qq.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Aug 2025 11:39:23 -0400
X-Gm-Features: Ac12FXwUP180FjaCeVT5J4NoIEAVhWgK5DTtLaA6rivx92DVvZ_oACTVYjptjCA
Message-ID: <CADnq5_NbWeLRvXGtb5sSKOwN+do=hbPo5iWiwB9Y9Q-vPV9YEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fixed an issue where audio did not turn off
 properly after unplugging HDMI
To: 2564278112@qq.com
Cc: alex.williamson@redhat.com, christian.koenig@amd.com, airlied@gmail.com, 
	simona@ffwll.ch, sunil.khatri@amd.com, alexandre.f.demers@gmail.com, 
	boyuan.zhang@amd.com, jiangwang@kylinos.cn, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 11:23=E2=80=AFAM <2564278112@qq.com> wrote:
>
> From: Wang Jiang <jiangwang@kylinos.cn>
>
> In commit 3c021931023a ("drm/amdgpu: replace drm_detect_hdmi_monitor() wi=
th drm_display_info.is_hdmi")',
> the method for determining connector types has been modified.
> After the modification, when disconnecting the monitor, the information f=
rom the previous connection cannot be retrieved,
> because display_info.is_hdmi has been reset, resulting in the connector t=
ype returned as dvi.
> On AMD Oland and other cards, the audio driver determines whether to turn=
 off audio based on connector type
> However, when the monitor is disconnected, the information from the previ=
ous connection cannot be obtained, resulting in the inability to turn off t=
he audio.
> I don't understand why this is being done, I think the right thing to do =
is to decide whether or not to enable audio based on whether the connector =
has audio.
> This commit modifies the code to retrieve audio information from the conn=
ected EDID.
> Now, the decision to turn audio on/off is based on the audio information =
in the EDID.
>
> Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 21 ++++++++++++++++-----

This only fixes up DCE6.  I would suggest one of the following to fix this:
1. Revert the changes from 3c021931023a in atombios_encoders.c
or
2. Add amdgpu_connector->is_hdmi and set it when
connector->display_info.is_hdmi is valid and use that rather than
connector->display_info.is_hdmi.

Alex

>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index 276c025c4c03..c56b2027d53e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -3253,17 +3253,22 @@ static void dce_v6_0_encoder_mode_set(struct drm_=
encoder *encoder,
>                           struct drm_display_mode *adjusted_mode)
>  {
>         struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encod=
er);
> -       int em =3D amdgpu_atombios_encoder_get_encoder_mode(encoder);
> -
> +       struct drm_connector *connector;
> +       struct amdgpu_connector *amdgpu_connector =3D NULL;
>         amdgpu_encoder->pixel_clock =3D adjusted_mode->clock;
>
>         /* need to call this here rather than in prepare() since we need =
some crtc info */
>         amdgpu_atombios_encoder_dpms(encoder, DRM_MODE_DPMS_OFF);
> +       connector =3D amdgpu_get_connector_for_encoder_init(encoder);
> +       amdgpu_connector =3D to_amdgpu_connector(connector);
> +       if (!amdgpu_connector) {
> +               DRM_ERROR("Couldn't find encoder's connector\n");
> +       }
>
>         /* set scaler clears this on some chips */
>         dce_v6_0_set_interleave(encoder->crtc, mode);
>
> -       if (em =3D=3D ATOM_ENCODER_MODE_HDMI || ENCODER_MODE_IS_DP(em)) {
> +       if (drm_detect_monitor_audio(amdgpu_connector_edid(connector))) {
>                 dce_v6_0_afmt_enable(encoder, true);
>                 dce_v6_0_afmt_setmode(encoder, adjusted_mode);
>         }
> @@ -3322,12 +3327,18 @@ static void dce_v6_0_encoder_disable(struct drm_e=
ncoder *encoder)
>  {
>         struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encod=
er);
>         struct amdgpu_encoder_atom_dig *dig;
> -       int em =3D amdgpu_atombios_encoder_get_encoder_mode(encoder);
> +       struct drm_connector *connector;
> +       struct amdgpu_connector *amdgpu_connector =3D NULL;
>
>         amdgpu_atombios_encoder_dpms(encoder, DRM_MODE_DPMS_OFF);
> +       connector =3D amdgpu_get_connector_for_encoder_init(encoder);
> +       amdgpu_connector =3D to_amdgpu_connector(connector);
> +       if (!amdgpu_connector) {
> +               DRM_ERROR("Couldn't find encoder's connector\n");
> +       }
>
>         if (amdgpu_atombios_encoder_is_digital(encoder)) {
> -               if (em =3D=3D ATOM_ENCODER_MODE_HDMI || ENCODER_MODE_IS_D=
P(em))
> +               if (drm_detect_monitor_audio(amdgpu_connector_edid(connec=
tor)))
>                         dce_v6_0_afmt_enable(encoder, false);
>                 dig =3D amdgpu_encoder->enc_priv;
>                 dig->dig_encoder =3D -1;
> --
> 2.25.1
>


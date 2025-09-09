Return-Path: <linux-kernel+bounces-806959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCB4B49E15
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BBB3AFB7B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5354A1F12F8;
	Tue,  9 Sep 2025 00:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1mlSOC1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3542D023
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 00:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378195; cv=none; b=raT+lUJzWXOuYHo2gnp8Ps71GVVgOfRHffww1b0Vm8UCkF8WKx6DBy9hN78uoL8hwZTFkBfAHb1koDNwK/JXupP1rlRa7Og3bqLcU18+0mBEJhCp+VSKkEpwc07PjKTfKQ0z5yQXzf3LGC09gGDn4XG6pLCVPlM3mEdpfRmkOk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378195; c=relaxed/simple;
	bh=Uok9CjbesSYK3ohcsag5t7XUC+DHX/La43yUddfR6ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxag5s8cc5QyBjAJgOjOjNmqvr7b7MGb6JCRVJ3wzz1iKpWTMLhnQGJL544ePN9Z87MggyFL3rOvFW34BosgSoOM4dz0lQAIzDFWAbcFM6hHncFguRMli0Ts1wbB+dfocGk3XnxCffj+c/xQNsUOLvMZFVZ4LR3ixrPMfpwn+xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1mlSOC1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBD4C4CEF8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 00:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757378195;
	bh=Uok9CjbesSYK3ohcsag5t7XUC+DHX/La43yUddfR6ZU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R1mlSOC1zIqUJ/ypd4bdckQG/BsCEdFAyG8e7B8p9xzQrUbYt5RmxXEUizpf3GGZJ
	 YyuFGdEfASVRL9u6PyXTl0YOr5RVldJoLcqgh03wERTOhcRVdYPUP7zt3W7XO2fsqX
	 PwGP3x0ZO0eJb8HCptkU+B4ilpHfKV1ytt//q3cOKyIGfznEodU6hx1xGqxa39jzvh
	 7xBsCKEgaA7pDaXbJV4jkQvYKYnQwLmB1UhkgqrLqTzxmGsVVG/wuqnlHpsYFdUpZx
	 btKFz5670ky3/4K1vJyoikkvhch3dU9WRAm2cz1hdScAPPDCo2oxJJjFOg0qPMCXha
	 ubEOofevbMkEg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0418f6fc27so831688366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 17:36:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWpGeWuzRStXmChYEzwLgsXArd6UnjAyLXjHOY1zk8bce4GR6fpw0OOjleFZK+Wp2P5KQpwR6xn7UHUSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5RvIBaOP/m5qdxLjYJ5S/M3ZOrrKbcPegB2Kw3kSpdZ8PeCUw
	P+vqpm0ahxi6jycg+b0/M5Z25voMK6YOh+onv6/0Y0NTGmgRvdFXMWbI8vbFW+vI0kgpIGfuZNo
	gIx+b/EYhr4kjNbeBPgSMqcy+Y18/4QA=
X-Google-Smtp-Source: AGHT+IF9MNT9kUYVDyI7G7dOeR2X5rkbSvsOCALtswIel9/537ksCvevAUIPUYflHXcqGv3z+TpTCjUeGlaoZ55Ocsc=
X-Received: by 2002:a17:907:7202:b0:afe:23e9:2b4d with SMTP id
 a640c23a62f3a-b04b16f07camr906872966b.43.1757378193778; Mon, 08 Sep 2025
 17:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825085211.34396-1-xry111@xry111.site>
In-Reply-To: <20250825085211.34396-1-xry111@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 9 Sep 2025 08:36:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4fUyeXN19i1zgtmiPcDFTK2YhTKKFxq88+m+7kiN7wBQ@mail.gmail.com>
X-Gm-Features: Ac12FXx2eWqMWWcgoL0rNhOz0pSpfln-psGlimWc6rSDPf-voN-aHE-6M820Ido
Message-ID: <CAAhV-H4fUyeXN19i1zgtmiPcDFTK2YhTKKFxq88+m+7kiN7wBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display/dml2: Guard dml21_map_dc_state_into_dml_display_cfg
 with DC_FP_START
To: Xi Ruoyao <xry111@xry111.site>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	amd-gfx@lists.freedesktop.org, WANG Xuerui <kernel@xen0n.name>, 
	Mingcong Bai <jeffbai@aosc.io>, dri-devel@lists.freedesktop.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Asiacn <710187964@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 4:54=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> dml21_map_dc_state_into_dml_display_cfg calls (the call is usually
> inlined by the compiler) populate_dml21_surface_config_from_plane_state
> and populate_dml21_plane_config_from_plane_state which may use FPU.  In
> a x86-64 build:
>
>     $ objdump --disassemble=3Ddml21_map_dc_state_into_dml_display_cfg \
>     > drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.=
o |
>     > grep %xmm -c
>     63
>
> Thus it needs to be guarded with DC_FP_START.  But we must note that the
> current code quality of the in-kernel FPU use in AMD dml2 is very much
> problematic: we are actually calling DC_FP_START in dml21_wrapper.c
> here, and this translation unit is built with CC_FLAGS_FPU.  Strictly
> speaking this does not make any sense: with CC_FLAGS_FPU the compiler is
> allowed to generate FPU uses anywhere in the translated code, perhaps
> out of the DC_FP_START guard.  This problematic pattern also occurs in
> at least dml2_wrapper.c, dcn35_fpu.c, and dcn351_fpu.c.  Thus we really
> need a careful audit and refactor for the in-kernel FPU uses, and this
> patch is simply whacking a mole.  However per the reporter, whacking
> this mole is enough to make a 9060XT "just work."
>
> Reported-by: Asiacn <710187964@qq.com>
> Link: https://github.com/loongson-community/discussions/issues/102
> Tested-by: Asiacn <710187964@qq.com>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

> ---
>  drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/=
drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
> index 03de3cf06ae5..059ede6ff256 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
> @@ -224,7 +224,9 @@ static bool dml21_mode_check_and_programming(const st=
ruct dc *in_dc, struct dc_s
>         dml_ctx->config.svp_pstate.callbacks.release_phantom_streams_and_=
planes(in_dc, context);
>
>         /* Populate stream, plane mappings and other fields in display co=
nfig. */
> +       DC_FP_START();
>         result =3D dml21_map_dc_state_into_dml_display_cfg(in_dc, context=
, dml_ctx);
> +       DC_FP_END();
>         if (!result)
>                 return false;
>
> @@ -279,7 +281,9 @@ static bool dml21_check_mode_support(const struct dc =
*in_dc, struct dc_state *co
>         dml_ctx->config.svp_pstate.callbacks.release_phantom_streams_and_=
planes(in_dc, context);
>
>         mode_support->dml2_instance =3D dml_init->dml2_instance;
> +       DC_FP_START();
>         dml21_map_dc_state_into_dml_display_cfg(in_dc, context, dml_ctx);
> +       DC_FP_END();
>         dml_ctx->v21.mode_programming.dml2_instance->scratch.build_mode_p=
rogramming_locals.mode_programming_params.programming =3D dml_ctx->v21.mode=
_programming.programming;
>         DC_FP_START();
>         is_supported =3D dml2_check_mode_supported(mode_support);
> --
> 2.51.0
>
>


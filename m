Return-Path: <linux-kernel+bounces-737131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31406B0A822
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20ADA43DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D193A2E612C;
	Fri, 18 Jul 2025 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V/inHCX3"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60372E6118
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855041; cv=none; b=TMBM7Z/1vOCUdtILmcxRh/kxKkfgc+qvd9TmzLCRBg+yMckr+2T2OzrayQWxjmW41OirY+3mBQBRcGSyM63rWDL5SJsEn3qx6KcqWWFqlA13bpuRihiR7UHq67tz+Ks4Q8YyQespBpHLGuxzWObS1z98nZ3WG8GCJQbWaK+kJ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855041; c=relaxed/simple;
	bh=kGsCAEDUAs7PcvVTlXcxhCu1WLo8mCBe+P9DDCN74Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUeEXjZZpDOMbTqfqBy9JxSW5LomDU04hgAUL4S0nDIuHkfXCxGCyJP3E/Dk+zwOxz5VDkdCDifJTyYF6zIDKoQ79BXSc3VX7Mvtku2qs1k3BIMCLx2ytfb2Wj9zNLO/dI0WHY9S3fVykakCdzk03UnWr6bVYRl4Jdhv/NkLE+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V/inHCX3; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso2291226a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752855037; x=1753459837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjMu1e4Z2kPIqjvwczTBgX85r3dXx3nHkHeoGheSPn8=;
        b=V/inHCX3APCdWYF1YslcgMsP0byjRRmdwhYhSFXW50RMsu0ESLOORagK11mYJa3m0I
         dOwwnmwowbkHkDe7hadTjRzEGYJIdXSnHddkfWPgxIcAj+cdOUoAI94XCcfozCJwvTxY
         vqpFurimyF7OJpoifYv31OdwTEdcnO37jFDWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752855037; x=1753459837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjMu1e4Z2kPIqjvwczTBgX85r3dXx3nHkHeoGheSPn8=;
        b=k3pi8jnt5/LMB+lM95x0JCyyvb7MN5qkdOUAsWuk9u+Les+uB9nZIXuCcAQyNDobGi
         Ygjq202Uv2UkJZa/YiXe5YDOTWvwtCbeQEwResiGFGi6H7NnaDMvMtQROpfWhNLouxV3
         T0hOg2m0wtniEaQIVCNV/y4fWM9Zt3yK8JPAEkgDnz6c6nKyYLta8EHP7PClIM1aQEcP
         rjF6SN2FmGdQHI6R4eg8tvx7jp1bormOEXO58gm0NEN6oNaVOTxz8P9gBlLt/7aSXabx
         NoCVR9WneLyavnvLe+glAJNhC+cqCwqBjvz1bmW9dSQCPnhoZ541zIyAE7JaQAeq1Uyo
         vflg==
X-Forwarded-Encrypted: i=1; AJvYcCXskHw5bKUuckm5H8RG5A5mv16JRb2rQXll7GamnJucanqcMQTfbnW8vp5JTd/Ayydrf1OplF4z47tdkeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTo/0n91O+tOe8fk8nT1s0zmO8OBUjKUdlT4bDY/U6mBJdt+ij
	IBNlZV8ZJ9mCP7fzz7BsEhuf+kNTZiyW4/gwYwRWTRgvI3d+w7vrYDcd5bOGEC0QWQ==
X-Gm-Gg: ASbGncva1ylJfT54wUt2xi++shKWRHPvqxIjl/EVGIvuzTHy4R/SAcHpDqg8eZJzgOa
	1YdOHg263m91Vi/fQS3j4IHcn9b4BQlWhqmR7V7cNJioQkadORpHsvlAmLvtzyMZwyWUAiBOAXD
	APaUIaBYI3hvLhSclFXPBZQ8DjrfTSPna1UkZGAbnRzMCW7NQ6cEKhadrTRB8WS3i2eKaJB1p6V
	XqOs+w7c5b+oXQoIo/9ssQr6KVg0q9wUKhUkfnmWidLUCZOCVp/9WPB1jyo/0PdehkFaPomI9Hc
	ILV0imn9U9L5e1FIIOfdwHXIoNih1qhFVwr3Z1YHSpyukq+lHXyDxVj+l8l7++l7IfWX35I7vou
	oaOUWi8fzcxxmsRrrSbNFrjU=
X-Google-Smtp-Source: AGHT+IH/dw7Lcr+Rjr0uiOQxBOtXl2afKn2zpTSd9k1UpqmQ2oec4cthggIv3UovU8rFFjEJrL0f3w==
X-Received: by 2002:a05:6a21:2d4a:b0:215:efe1:a680 with SMTP id adf61e73a8af0-2381143ed4emr16815901637.16.1752855035267;
        Fri, 18 Jul 2025 09:10:35 -0700 (PDT)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com. [209.85.215.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ffbfe8esm1419882a12.74.2025.07.18.09.10.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 09:10:34 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso2291134a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:10:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX39jp8gBmp9fwsc/XkUDukEaU2XE2MNX44CmRPNFCwCQQ7OKxxWkBjswDXXdJSqIaL/F0/oM1iu/go1Xg=@vger.kernel.org
X-Received: by 2002:a17:90b:2b4c:b0:311:eb85:96ea with SMTP id
 98e67ed59e1d1-31c9f3c5719mr16511405a91.9.1752855033213; Fri, 18 Jul 2025
 09:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717164053.284969-1-me@brighamcampbell.com> <20250717164053.284969-2-me@brighamcampbell.com>
In-Reply-To: <20250717164053.284969-2-me@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 18 Jul 2025 09:10:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WYBFrm-J55BTEJ7s=Jk4EFuMVAkahVZfdzW6V8mxE7Tg@mail.gmail.com>
X-Gm-Features: Ac12FXz_prqGT_YDn81ubqDHwEClWFafCp94o67Bin1GS3o7VQCq9ZD3Qej-Cnw
Message-ID: <CAD=FV=WYBFrm-J55BTEJ7s=Jk4EFuMVAkahVZfdzW6V8mxE7Tg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] drm: Create mipi_dsi_dual macro
To: Brigham Campbell <me@brighamcampbell.com>
Cc: tejasvipin76@gmail.com, diogo.ivo@tecnico.ulisboa.pt, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 17, 2025 at 9:41=E2=80=AFAM Brigham Campbell <me@brighamcampbel=
l.com> wrote:
>
> Create mipi_dsi_dual macro for panels which are driven by two parallel
> serial interfaces. This allows for the reduction of code duplication in
> drivers for these panels.
>
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>  include/drm/drm_mipi_dsi.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 369b0d8830c3..03199c966ea5 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -431,6 +431,30 @@ void mipi_dsi_dcs_set_tear_off_multi(struct mipi_dsi=
_multi_context *ctx);
>                 mipi_dsi_dcs_write_buffer_multi(ctx, d, ARRAY_SIZE(d)); \
>         } while (0)
>
> +/**
> + * mipi_dsi_dual - send the same MIPI DSI command to two interfaces
> + *
> + * This macro will send the specified MIPI DSI command twice, once per e=
ach of
> + * the two interfaces supplied. This is useful for reducing duplication =
of code
> + * in panel drivers which use two parallel serial interfaces.
> + *
> + * @_func: MIPI DSI function or macro to pass context and arguments into
> + * @_dsi1: First DSI interface to act as recipient of the MIPI DSI comma=
nd
> + * @_dsi2: Second DSI interface to act as recipient of the MIPI DSI comm=
and
> + * @_ctx: Context for multiple DSI transactions
> + * @...: Arguments to pass to MIPI DSI function or macro
> + */
> +#define mipi_dsi_dual(_func, _dsi1, _dsi2, _ctx, ...)           \
> +       _mipi_dsi_dual(_func, _dsi1, _dsi2, _ctx, ##__VA_ARGS__)
> +
> +#define _mipi_dsi_dual(_func, _dsi1, _dsi2, _ctx, ...) \
> +       do {                                           \
> +               (_ctx)->dsi =3D (_dsi1);                 \
> +               _func((_ctx), ##__VA_ARGS__);          \

nit: shouldn't func be in parenthesis for safety? It's unlikely to
really matter, but just in case it's somehow a calculated value that
would make it safe from an order-of-operations point of view.


> +               (_ctx)->dsi =3D (_dsi2);                 \
> +               _func((_ctx), ##__VA_ARGS__);          \
> +       } while (0)

Can you explain why you need the extra level of indirection here (in
other words, why do you need to define _mipi_dsi_dual() and then use
it in mipi_dsi_dual())? I don't see it buying anything, but maybe it's
performing some magic trick I'm not aware of?

Reading this with a fresh set of eyes, I also realize that this macro
is probably vulnerable to issues where arguments have side effects
since we have to repeat them. I don't think there's a way around this
and I think the macro is still worthwhile, but something to go into
with open eyes. Possibly worth noting in the macro description? We
could probably at least eliminate the need to reference "_ctx" more
than once by assigning it to a local variable. I think referencing
"_func" and "__VA_ARGS__" more than once is unavoidable...

Maybe this is what you were trying to solve with the extra level of
indirection, but (at least with my knowledge of the C preprocessor), I
don't think it does.


-Doug


Return-Path: <linux-kernel+bounces-739630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9061B0C8CD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73232189145C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FCC2E06EA;
	Mon, 21 Jul 2025 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b7Z0e0aO"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B7F19F121
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115450; cv=none; b=GNpMbQBBW1Med2qxPmkODYAup6BqMjXlp/8cjxZPFz+XfE6XtxbeJfkwlJxhvB1hj0xXHHY2GYHOebAL65CnbFIJWQnH0zMNCaPjpx6nZK34ztm8chFLLaxPO/vU3I3LvtIQq8kmUtxI60fiGgt3Q55oJRWdkd31i1OMEs1V114=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115450; c=relaxed/simple;
	bh=LcK4LIDhkpmNmzFtUfX5BsXG1e79f98fn51x8mcpMnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hoa0lK52ebq74Bz65N+qxkRfwO3XOPA3Gu+XBs4legL8nxECFFJZOQtYi39LNvdsBwju8JZQJDed/nIFTdEfwqsbC3GvnhLbYQhL9kpbTkZenLTdvXrUOjHyr7hTKKAbtlNiV1iLT+U20JdUuhCQF6XNDrU3EMA/ou/kIwR0zvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b7Z0e0aO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235f9ea8d08so37257545ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753115446; x=1753720246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1OthpiQLo0yn+Ex+1T1Nl8yMpcQVCC1Su5Bulvu4QQ=;
        b=b7Z0e0aOONvXPaHGb8wxS+7LuUABesDFBUtJZSQEvqOxAVcaki8X0ceb/Man28jyMH
         1QPt/G2zNcRSDTYHBbiMsQ37qTK7sTgYuuCUvUvOXF6+bnLAc2JSeMz0XBhMEgAMz2C7
         01QBrGjWMyPwOMFaexouqkXN+/K8q8Fu1Jfmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753115446; x=1753720246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1OthpiQLo0yn+Ex+1T1Nl8yMpcQVCC1Su5Bulvu4QQ=;
        b=eKc3XiDLb+v3TnvHmIa4WKUqyRwrNZwdcpxS+9aelUhbUdcYKimJfQF00jXi5iWx54
         RE2RGFUon4pPFQSvTmRYXY6t/eC3dxeaqDmVyRNSkO8oi/JT23r0zuSbhnS33ecme9mL
         Z9I6uhCJ3yABCuVQuS7cB4aBmpJhhlPGaRILwoYHf4P3zmo7LmFB17bbKWfri1pcV+2S
         diXhqpZqNKSdRfo98mP9GQh7riAQOALpq7XTN8UswpRsd/uk654X4KgDLMDCLoPs8Qgf
         3TqlnOJLRUR8RCTNP4cTRCWSkPUJ/RDERqoNtenAkdtoBFI05S3JSSg9DexTmWXWCxN0
         aYrw==
X-Forwarded-Encrypted: i=1; AJvYcCXFv8xcW98Pb662U4tdil06l4PhKH9SpZ78hwJdsn+jMTh1/SS9yaemw0IcRVn8TfPxnVHFiIIp9PYn9yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOBk2GraUXNaFZSDmeWJjKApQkVV48TSvudL/YJD2mQJ+nVaFw
	atNjjd9tLaG2L+BioHGX/50fS0FP3vUNERY/wEuSXITW5WLIfc9ggLu7hvqSNIvLVH8e1ICn7Ha
	oDag=
X-Gm-Gg: ASbGncsdgT7bywnazhSFcuDcR+BxIaEz1LYTek3ale494rwoTG4X8JmuEKsEbDZ7+vO
	9YFKAE3ybbV/TMTyuO/xDxWeqTrq9mpDu4hPDWlmVLlFeek4V3qqYRwO6w0pH8G2dawXyHdJM0N
	+0O/w8a3S88dNKFWQ8MDlZwQvE6JHA/TLQ7CjUN1CUKHubjNtV3py2YI3/8d/5Z6sRylIW0KzBm
	EyDyDxi44BEeZxxsdVWbRUoRnzVDS0KX6J7pnM48sm6yg5CyZFoTJWFruqTarCjtdNMV9qv86Zi
	i5Qi1QRQCevuRVENOKKxjsgv+yja/fsv7DzmN/nrHRhAAjrl3J3w2DRNRP8gYcA8P0BTRiut2yw
	xTMDAhCcfI4GEOdOCvbFnOkzwc0DqyvbIMClrZkpOn0I0CtLG74wsuGSPNA5pV5X14g==
X-Google-Smtp-Source: AGHT+IFt2Z0pP/xDiQtApG++/khG71I7GVnL9qaPLpj6oXK6sypgitdTuq7VBH4bd+oryqkmJeNUGA==
X-Received: by 2002:a17:902:db06:b0:234:9066:c857 with SMTP id d9443c01a7336-23e24ee8840mr275868305ad.21.1753115445755;
        Mon, 21 Jul 2025 09:30:45 -0700 (PDT)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com. [209.85.214.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6cfb7dsm60202275ad.140.2025.07.21.09.30.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 09:30:44 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23694cec0feso42147815ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:30:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXXgcojTlZP/xdNbZfyYlKLfkhfZTNuYUfPqL37qoxOHb0S1DgWft1vUI929niup/e7VeZU+k63ogcd0nE=@vger.kernel.org
X-Received: by 2002:a17:903:3bcc:b0:235:f298:cbbe with SMTP id
 d9443c01a7336-23e24edc278mr357296245ad.12.1753115443448; Mon, 21 Jul 2025
 09:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719082639.307545-1-me@brighamcampbell.com> <20250719082639.307545-2-me@brighamcampbell.com>
In-Reply-To: <20250719082639.307545-2-me@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 21 Jul 2025 09:30:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xzno3ReSyp9w+DC+nLoy1AXmcwd+j1=_XRxFi_k+bmng@mail.gmail.com>
X-Gm-Features: Ac12FXy9MlSRxUz0cgfvqURcfFQN33HCDR1ifsxTc8_3lTfiq4MM633TTSdKa88
Message-ID: <CAD=FV=Xzno3ReSyp9w+DC+nLoy1AXmcwd+j1=_XRxFi_k+bmng@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] drm: Create mipi_dsi_dual* macros
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

On Sat, Jul 19, 2025 at 1:27=E2=80=AFAM Brigham Campbell <me@brighamcampbel=
l.com> wrote:
>
> @@ -827,6 +827,30 @@ void mipi_dsi_generic_write_multi(struct mipi_dsi_mu=
lti_context *ctx,
>  }
>  EXPORT_SYMBOL(mipi_dsi_generic_write_multi);
>
> +/**
> + * mipi_dsi_dual_generic_write_multi() - mipi_dsi_generic_write_multi() =
for
> + * two dsi channels, one after the other
> + * @dsi1: First dsi channel to write buffer to
> + * @dsi2: Second dsi channel to write buffer to
> + * @ctx: Context for multiple DSI transactions
> + * @payload: Buffer containing the payload
> + * @size: Size of payload buffer
> + *
> + * A wrapper around mipi_dsi_generic_write_multi() that allows the user =
to
> + * conveniently write to two dsi channels, one after the other.
> + */
> +void mpi_dsi_dual_generic_write_multi(struct mipi_dsi_device *dsi1,

BUG: above should be "mipi", not "mpi"


> +                                     struct mipi_dsi_device *dsi2,
> +                                     struct mipi_dsi_multi_context *ctx,
> +                                     const void *payload, size_t size)
> +{
> +       ctx->dsi =3D dsi1;
> +       mipi_dsi_generic_write_multi(ctx, data, len);

BUG: "data" and "len" are not valid local variables...


> @@ -431,6 +439,87 @@ void mipi_dsi_dcs_set_tear_off_multi(struct mipi_dsi=
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
> + * WARNING: This macro reuses the _func argument and the optional traili=
ng
> + * arguments twice each, which may cause unintended side effects. For ex=
ample,
> + * adding the postfix increment ++ operator to one of the arguments to b=
e
> + * passed to _func will cause the variable to be incremented twice inste=
ad of
> + * once and the variable will be its original value + 1 when sent to _ds=
i2.

It could be worth also pointing people to
mipi_dsi_dual_generic_write_seq_multi() and
mipi_dsi_dual_dcs_write_seq_multi() below?


> + *
> + * @_func: MIPI DSI function or macro to pass context and arguments into

nit: remove "or macro".


> + * @_dsi1: First DSI interface to act as recipient of the MIPI DSI comma=
nd
> + * @_dsi2: Second DSI interface to act as recipient of the MIPI DSI comm=
and
> + * @_ctx: Context for multiple DSI transactions
> + * @...: Arguments to pass to MIPI DSI function or macro
> + */
> +#define mipi_dsi_dual(_func, _dsi1, _dsi2, _ctx, ...)           \
> +       do {                                                     \
> +               struct mipi_dsi_multi_context *_ctxcpy =3D (_ctx); \
> +               (_ctxcpy)->dsi =3D (_dsi1);                        \

nit: now that "_ctxcpy" is a local variable you no longer need the
extra parenthesis around it.


> +               (_func)((_ctxcpy), ##__VA_ARGS__);               \
> +               (_ctxcpy)->dsi =3D (_dsi2);                        \
> +               (_func)((_ctxcpy), ##__VA_ARGS__);               \
> +       } while (0)
> +
> +/**
> + * mipi_dsi_dual_generic_write_seq_multi - transmit data using a generic=
 write
> + * packet to two dsi interfaces, one after the other
> + *
> + * This macro will send the specified generic packet twice, once per eac=
h of
> + * the two interfaces supplied. This is useful for reducing duplication =
of code
> + * in panel drivers which use two parallel serial interfaces.
> + *
> + * Note that if an error occurs while transmitting the packet to the fir=
st DSI
> + * interface, the packet will not be sent to the second DSI interface.
> + *
> + * This macro will print errors for you and error handling is optimized =
for
> + * callers that call this multiple times in a row.
> + *
> + * @_dsi1: First DSI interface to act as recipient of packet
> + * @_dsi2: Second DSI interface to act as recipient of packet
> + * @_ctx: Context for multiple DSI transactions
> + * @_seq: buffer containing the payload
> + */
> +#define mipi_dsi_dual_generic_write_seq_multi(_dsi1, _dsi2, _ctx, _seq..=
.)     \
> +       do {                                                             =
       \
> +               static const u8 d[] =3D { _seq };                        =
         \
> +               mipi_dsi_dual_generic_write_multi(_dsi1, _dsi2, _ctx, d, =
       \
> +                                                        ARRAY_SIZE(d)); =
       \

nit: the indentation of ARRAY_SIZE() is slightly off.


> +       } while (0)
> +
> +/**
> + * mipi_dsi_dual_dcs_write_seq_multi - transmit a DCS command with paylo=
ad to
> + * two dsi interfaces, one after the other
> + *
> + * This macro will send the specified DCS command with payload twice, on=
ce per
> + * each of the two interfaces supplied. This is useful for reducing dupl=
ication
> + * of code in panel drivers which use two parallel serial interfaces.
> + *
> + * Note that if an error occurs while transmitting the payload to the fi=
rst DSI
> + * interface, the payload will not be sent to the second DSI interface.
> + *
> + * This macro will print errors for you and error handling is optimized =
for
> + * callers that call this multiple times in a row.
> + *
> + * @_dsi1: First DSI interface to act as recipient of packet
> + * @_dsi2: Second DSI interface to act as recipient of packet
> + * @_ctx: Context for multiple DSI transactions
> + * @_cmd: Command
> + * @_seq: buffer containing the payload
> + */
> +#define mipi_dsi_dual_dcs_write_seq_multi(_dsi1, _dsi2, _ctx, _cmd, _seq=
)   \

BUG: doesn't "_seq" need to be "_seq..." ?

BUG: You need to remove the definition of this macro from
`panel-novatek-nt36523.c` or else it won't compile anymore since the
name of your macro is the exact same as theirs and they include this
header file. It would be OK w/ me if you squashed that into the same
patch since otherwise rejiggering things would just be churn...

I guess we also chose different argument orders than they did (that's
probably my fault, sorry!). They had the "ctx" still first and this
patch consistently has "dsi1" and "dsi2" first. I don't think it
really matters, but we should be consistent which means either
adjusting your patch or theirs. It's probably worth confirming that
the novatek driver at least compiles before you submit v6.


-Doug


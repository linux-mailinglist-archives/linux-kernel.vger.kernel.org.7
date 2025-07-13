Return-Path: <linux-kernel+bounces-728896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE24B02E92
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 05:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5195C17B179
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 03:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFF13C465;
	Sun, 13 Jul 2025 03:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEV6u9QW"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFB633DF
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 03:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752376519; cv=none; b=PrJeeglZHg8gnfzW64L1e5TFawjZfm6/YNv3ToPQQSpd2on1nBFi4SWA06nqp+cH4pU2sB1Go3YxUISpMx2gi+5C9BVDKtc9ky2CAZnFtbC+3FqFYuTmX9ZLckipmvQyf49JRBcOFPokUMESZFoEojuN6P2ybGnCxFFgYw6WSVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752376519; c=relaxed/simple;
	bh=qpnwvY4XlsQqnZ7M8Leq6CfBAYSGALCYaC0z3hOR9ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=lu76CAkRH6wkHArDMd+1mk+wxgoneNd/KvXfMYXeaHgyVs77E6tAlItxHh+8a/Sz3h9yVjClWLYhGEc0S/Egp82HppypPXh7+0NQHkOCX1E5w1eBfOjSWYBjW6gSKeRCIZdbeQo9LfYyXCxeH1ByJ4JMWKvRKlRehz3hsur7Ckk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEV6u9QW; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e898de36cfbso2675053276.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 20:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752376517; x=1752981317; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1l/K+IqHggnZgD2FOM2eEb6+GapEal3UYsodL2qel0=;
        b=EEV6u9QWRC/N3Spwd+c61Bzb2tqK7ki0wY6ERpAvqbUiVi0ZgjpClkEh+NVUNSR4u3
         wmUAa4lwXqXYv/LKWzvCx0xFAluVvnDEqfrCz7SXQ0VOduSOu1uZeLdjZ6tE+0nMq1Tl
         EwZdDdhy6vj0GBrXGThlvGSzIM07y/mmtX4+TGMFYFUjTWSSozqqHgwvcD6L4YIZjvYi
         7R58accMsvbRW3sbzaP7Vp6HnpCG6/o5i3wLNj35xu6JyoD+GZLzJ5LTZLxgs6Y4damK
         ET2A7CG0FhB/PDyqaMl1qk5XKdeapYB5F4lUNixazjbd8cE8fDNQFemTTtIb70sODz1N
         tsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752376517; x=1752981317;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1l/K+IqHggnZgD2FOM2eEb6+GapEal3UYsodL2qel0=;
        b=nmIzvakMWUtS1nv1+GWdJA1oO35h/YfDm7Sv4dIxeK5iDCScUymRdOKg/565fEzszc
         R7NJq+2dqkebTwbXMTLcG2bpl2dp/zqPvXHFEN4yZt+a3DQY7v4NrmTPQNdjDMmEiJfy
         YAKlQb2M4jp5ZuwYo8BV9sAUdiWgIZLJjDewVEiIwvLlLAH84QqYlq3SiODjRFjoOfJg
         zurqb3P6VPTfLfEVOqx2Xla3DkvfLsEYYhcIrVjU6iVmf6vWMuzssVNwRkudnWxh98q1
         rWerlu0D6u4U8eC34rs3CV9khDeBESiK3Ed663Xr8SHC0OFg1DGGQQnCDB0FXAAgEsBS
         uoBA==
X-Forwarded-Encrypted: i=1; AJvYcCU2T+hqzr4lfDtck0LZrT5lsCu+ePFoqI6xVq9Yczx/Y+HTa0g0c/MoixK5CDsuMVssPGk8ImropxZT0TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzErsrL1gwxxkCmEPybPIDFW09f+U0P6T6CINrNzPMzkpVKk8yt
	3vZOH/FVmHvhbR5YVhXetkwRNvtCrYtTja/79S1XS6DTXKIUJNlkxZD9ZyzEBiTd+QXXmTO+eeU
	pQmp3wJPGaXmikVSZ05wFMxt8QEYMthI=
X-Gm-Gg: ASbGncvzpFGqFsFv0MUee+ba2884Uj83qfB4mPwAvxetabXI13hIFReLPLHsk2miT/P
	v9iPc/JvUFit9tq+J92BWNUUAwGn2QoByH5P2iSfP+kPaltgMsCjIy0gSI4+fJQw55PjQb2lQFY
	0ZTaviWXro9PdceLoVEDoNnoV7pCF5IJxVOzFVyHBqatpfDVXhZqkrBStXiwF+/mRIG6qbasZ52
	PUDBu+HVVgfm9YmtsV60Ne1fSNBH74pjT506es=
X-Google-Smtp-Source: AGHT+IEGjUqaSB3UsgVl0/htAQhEKYX4HGo1vBA1pPGsrhp5eOwfpsBu4htmrwq7mUdGWj4IbgeV34xTm+uP2H4eXao=
X-Received: by 2002:a05:690c:a99:b0:70f:8883:eb1a with SMTP id
 00721157ae682-717d78af82amr146281137b3.6.1752376517287; Sat, 12 Jul 2025
 20:15:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610235825.3113075-1-olvaffe@gmail.com>
In-Reply-To: <20250610235825.3113075-1-olvaffe@gmail.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Sat, 12 Jul 2025 20:15:06 -0700
X-Gm-Features: Ac12FXxfcXlhxfzALMNhQnVRlmtPZ9HqTMZpm9-bPHhDJOMV7PioUFmwOsCuW3Y
Message-ID: <CAPaKu7Q4=fFGeXw27JqptmELX-XisMZG_M6jiRngyZihVooWxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: it6505: select REGMAP_I2C
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Can anyone help review this?  It is a trivial build fix.

On Tue, Jun 10, 2025 at 4:58=E2=80=AFPM Chia-I Wu <olvaffe@gmail.com> wrote=
:
>
> Fix
>
>   aarch64-linux-gnu-ld: drivers/gpu/drm/bridge/ite-it6505.o: in function =
`it6505_i2c_probe':
>   ite-it6505.c:(.text+0x754): undefined reference to `__devm_regmap_init_=
i2c'
>
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index b9e0ca85226a6..a6d6e62071a0e 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -122,6 +122,7 @@ config DRM_ITE_IT6505
>         select EXTCON
>         select CRYPTO
>         select CRYPTO_HASH
> +       select REGMAP_I2C
>         help
>           ITE IT6505 DisplayPort bridge chip driver.
>
> --
> 2.50.0.rc0.642.g800a2b2222-goog
>


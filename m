Return-Path: <linux-kernel+bounces-837037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B996EBAB233
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66367177441
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63166226D17;
	Tue, 30 Sep 2025 03:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W+yRXQVa"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4299417BB21
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759202079; cv=none; b=usTjAQdNvLox1qrBGM/W0wWjvD5sc8Zmpu9srZxA3y/ru3ZsvDJHcaf3lDgjNRyNVO6fuRslrYCp5+CRYZSedZIX66aAsj5fxTQIZqeekcFkI9VWCzG4QXMnvdLTawZDb+1NK+tkfV126cFlk6gUWHA5AH4AX8c2hiDk4MEEaWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759202079; c=relaxed/simple;
	bh=1rGZa6T+nKU9H+9k5FkFiJZWT4Z/x2RL52Cr/CliJfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUodN3NmVSfbLL2tpyfLVESwyzjvhrUYfiMrQ8eTMuxDUM6jw3cCai0FkQ9CeeuislaYDXUDi55DMrFZS97sOTRF1f00lsuCRE6D7AQdU2cIoydK5fIVOwq520K81V9H0hFUxAeHQw350AljTKfR5txVeNNruQFI0o/hDi0KpSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W+yRXQVa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-267f0fe72a1so42139745ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759202072; x=1759806872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psH8ce2EGDVOVWJJv98yedDgFcZ/vr9lSF0MkEmVn80=;
        b=W+yRXQVaDkhKQ5BuT6lwnqRoUPGt4O6Lo4xKPkJ1rZNhqUN1+Ri27HkQV3ljwfzM4B
         a+wKxBK8d0ITarxYz3gjluYwYJjeyEtBPKcHsGldtZ7+GVo3Q0/IQc0j8mOrdWWne3an
         Hme8g4YBqG6NOoBAekco1aqbMl6QghORhpyvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759202072; x=1759806872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psH8ce2EGDVOVWJJv98yedDgFcZ/vr9lSF0MkEmVn80=;
        b=gdA2jQ9QYOQYBdveg4AjS7wgi0ToCKMHYtvCW82zS2439tZzJQ7S+xJy0t7LZpfDz4
         dGdB0Lg5sbeS2+hrxGhZz5O5LoPtcpaSEWrmTseXkNRxin/TbARUKCNrgGgbwjO29/9Q
         64QEEuDr3cPs7JrttBNFssRsWzrdcoQLa9cb8wHqqdKmVsC6O1k4/SrwlWBX0860kqmg
         V7GaR1f0xtox4Y98/A+sqjMwrri7lSN7QySnnM63PUZIuNOqP6A+2jlgElWmGewzy3Fg
         6ZLWFQDPJh4Xx8ioABBhr29ryrRcHOYVsda8w9t5VLiailx+lIg1kQ7Amebgfn1U/lge
         ikkw==
X-Forwarded-Encrypted: i=1; AJvYcCUZANGukbxe+pVJDuj9WGsMZDN6GOsmJPQ9JE2cHRRVk85l6XGiNiEq+eU2NFjy+GjKG7dnH/srSnU8kPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIiqB4Z4rl8/UUmk83YjnS+C9EI6rqFD0TLu2sLRJWUIQam6E+
	okqD+GMHoyKbT/ApjY27SIbRVeayHRviCHjcPPl2BhmyWtM2OXtfGQEHcRHH/JfQ2xrisUGYTiC
	EpDk=
X-Gm-Gg: ASbGncspQPQVWUrYVvR6y3ROFlPO8DvK9XLBEVbAWOuBYpCOMac1YAGfBtla7rJlHln
	GuvwUDICG1L0stx+CN5EGj3odYX/b0+sgQ8o4k2wos2nSbh81k62KK5nzgXPmr9OnDnbL56ALa/
	BT/z6Xr0cJMPIPo7Rf18ybJIMaai1oqF8MOmNACXbmaK49SKe4Vh8V8F48mlTgG+2u5eeIyDPCB
	Fd3vo+pwClY/GIH1jw26/CJc7G8YdW4aVgChRQvVcX7fOJ9fHw082Mzc7WOC5iKtf960I6g3Wq2
	kO9cyDuRVpmByRZfFA0qjwpMIhMIq5v0RvYQpEtOdPGLysR/aPMTQBrWyOqma7/q3WwaYko0tg0
	W1/lvkFRF9YnwUP4gEmuIs7gv7dR5mRKc9Bx/B0HIiEShLGcFYNyoEzcL/tqIPrHizIPbtf6vkX
	1I9s2n/qoKALksyk6thteqHBqh
X-Google-Smtp-Source: AGHT+IFCeBktQ7Ua5TPG8fulEURIMTYS+Mosv2WeqghQG/haXaKXkuob8fE0Ik2B7fZF3WcPIt5nbQ==
X-Received: by 2002:a17:902:f68e:b0:246:4077:4563 with SMTP id d9443c01a7336-27ed4a2d5c5mr219476385ad.34.1759202071674;
        Mon, 29 Sep 2025 20:14:31 -0700 (PDT)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com. [209.85.215.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3383870ab17sm2825213a91.11.2025.09.29.20.14.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 20:14:29 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b57f08e88bcso3040094a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:14:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6DKaU0NTg9DmK4E/qX/w50XToqS9R1wlT0tqM8Mwq4QnIJxHEA3hVkuy/k47/BCMgx/kAVRUPB2+0t1w=@vger.kernel.org
X-Received: by 2002:a17:903:1209:b0:27c:56af:88ea with SMTP id
 d9443c01a7336-27ed4a60a90mr164034935ad.60.1759202068865; Mon, 29 Sep 2025
 20:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929142455.24883-1-clamor95@gmail.com> <20250929142455.24883-3-clamor95@gmail.com>
In-Reply-To: <20250929142455.24883-3-clamor95@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 29 Sep 2025 20:14:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WH5rsQR0vnsdZqfA-K-4AWSyOOfbe3g1H7pYCG0AigZw@mail.gmail.com>
X-Gm-Features: AS18NWAj5Q6YXwI8UEKn83gnNL36khKZ6enBt8j4y4L77Jpu4EeJviWpKmgJt1I
Message-ID: <CAD=FV=WH5rsQR0vnsdZqfA-K-4AWSyOOfbe3g1H7pYCG0AigZw@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] gpu/drm: panel: add support for LG LD070WX3-SL01
 MIPI DSI panel
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 29, 2025 at 7:25=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:
>
> +static int lg_ld070wx3_prepare(struct drm_panel *panel)
> +{
> +       struct lg_ld070wx3 *priv =3D to_lg_ld070wx3(panel);
> +       struct mipi_dsi_multi_context ctx =3D { .dsi =3D priv->dsi };
> +       struct device *dev =3D panel->dev;
> +       int ret;
> +
> +       ret =3D regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->s=
upplies);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to enable power supplies: %d\n", ret=
);
> +               return ret;
> +       }
> +
> +       /*
> +        * According to spec delay between enabling supply is 0,
> +        * for regulators to reach required voltage ~5ms needed.
> +        * MIPI interface signal for setup requires additional
> +        * 110ms which in total results in 115ms.
> +        */
> +       mdelay(115);
> +
> +       mipi_dsi_dcs_soft_reset_multi(&ctx);
> +       mipi_dsi_msleep(&ctx, 20);
> +
> +       /* Differential input impedance selection */
> +       mipi_dsi_dcs_write_seq_multi(&ctx, 0xae, 0x0b);
> +
> +       /* Enter test mode 1 and 2*/
> +       mipi_dsi_dcs_write_seq_multi(&ctx, 0xee, 0xea);
> +       mipi_dsi_dcs_write_seq_multi(&ctx, 0xef, 0x5f);
> +
> +       /* Increased MIPI CLK driving ability */
> +       mipi_dsi_dcs_write_seq_multi(&ctx, 0xf2, 0x68);
> +
> +       /* Exit test mode 1 and 2 */
> +       mipi_dsi_dcs_write_seq_multi(&ctx, 0xee, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&ctx, 0xef, 0x00);
> +
> +       return 0;

Shouldn't this return the accumulated error?


> +static int lg_ld070wx3_unprepare(struct drm_panel *panel)
> +{
> +       struct lg_ld070wx3 *priv =3D to_lg_ld070wx3(panel);
> +       struct mipi_dsi_multi_context ctx =3D { .dsi =3D priv->dsi };
> +
> +       mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
> +

Maybe add some comment about ignoring the accumulated error in the
context and still doing the sleeps?


> +       msleep(50);
> +
> +       regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies=
);
> +
> +       /* power supply must be off for at least 1s after panel disable *=
/
> +       msleep(1000);

Presumably it would be better to keep track of the time you turned it
off and then make sure you don't turn it on again before that time?
Otherwise you've got a pretty wasteful delay here.


> +static int lg_ld070wx3_probe(struct mipi_dsi_device *dsi)
> +{
> +       struct device *dev =3D &dsi->dev;
> +       struct lg_ld070wx3 *priv;
> +       int ret;
> +
> +       priv =3D devm_drm_panel_alloc(dev, struct lg_ld070wx3, panel,
> +                                   &lg_ld070wx3_panel_funcs,
> +                                   DRM_MODE_CONNECTOR_DSI);
> +       if (IS_ERR(priv))
> +               return PTR_ERR(priv);
> +
> +       priv->supplies[0].supply =3D "vcc";
> +       priv->supplies[1].supply =3D "vdd";
> +
> +       ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(priv->supplies), =
priv->supplies);
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "failed to get regulators\=
n");

Better to use devm_regulator_bulk_get_const() so you don't need to
manually init the supplies?


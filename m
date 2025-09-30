Return-Path: <linux-kernel+bounces-837821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566A6BAD41F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098881940D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0996B3043DA;
	Tue, 30 Sep 2025 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxClFIkO"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87569226CF7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243683; cv=none; b=n7//OiGqBO5lAFTyoTYyJbOPuZIeTxEoANETQZCLbojaAMZ3dGxsYbf6Clvez1TIC7i4FIH8GYHuatWA2vWxGxIzh6KynfLgg9gO3a45ROyOhtUF7YkJDVBv1Ax+Yt3YjJ1vBj1nOE2kYusmmUmppBL80dCrSClgrroG2JxpWyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243683; c=relaxed/simple;
	bh=/sU89QwPUahqC2xEJ5I3Jkyw0Va84QDHH8CcqKX6H9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0BkfzMnqpJt4yCsVZfc1Fvyp6O4l0Z1SfzGLKBgtmmRHLLYEBEcojH3ajU/O/otndIxoPHDROX/j+pePYXZK4PdQLtsS0XBjhyAVFQnetOcmcTa50mkN3PioKjlF4qjLCVprb6+v0ubOMoDtWm4L/UymCivPD1LIDxzweCEKCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxClFIkO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e542196c7so12503155e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759243680; x=1759848480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uWMswBnAUaMNeL0bXv/Vzh36u4kcyphWPqYjGwjiu8=;
        b=RxClFIkOTZXV7KwOKDZEswc8JqHlSHY5NS66a834y4fdb3UWTGBft/jWXlc8dh/L6w
         2o2uxEyPLPjuNdIBKISntIB4aQ6oBVZg0KMiwedZu71Yd3lKNdcHBuixypqFU8frrYZu
         cx/i56F+ASq2oph+zHPxQ4TCrqoaVYtWcMiBPM2vGguzIT1AZPnYcaKDi/CdCJWed8Ap
         DmAM+ETo3DAy6nKpQuVcfQ5zUvSuwMx1beXXoGcvUbQeIbTOc660/4kzSNO/t2sWaw5i
         LJBGy80hsAr1PaJn/NL5PlISEWlEpoKuJTTm4j8I5zTl5znbU8yUQ1JNveui0cNPS0Z/
         EBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759243680; x=1759848480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uWMswBnAUaMNeL0bXv/Vzh36u4kcyphWPqYjGwjiu8=;
        b=nOSUBdVBfXj142VMprOmIboqkP7ZI/6EtQgDcJ6oFiUCUssdGZ7M30xUPFGc6Xvjhy
         g1QnZgAJgFd+8WgPzS4w0nIQi6Ft/t5pcNYI+hT2Murv4f6KQ78swbNaliUNBf+bCr0U
         wjM1IXOZjo97OzmN+s65UDEIbJZVEhhOfJWjhUG43YQHpTzIh8OqooU7IqnjJdkhONuG
         KjV9I5Pk/cPUY340sE3GI0zub91I93AOcoLlz3Kn5MBHtYKXoXCodA7X64bdyXi+jhJA
         aF9iFwMj8C668mjLGK0Q+pw8dru/1dj+aGyxDOnTyy6N8GFDwuWjdZ0WH4ruhA6zo5g/
         5uiA==
X-Forwarded-Encrypted: i=1; AJvYcCUAs5V84wo1zUMmIHGIIzBDLQ6uDQLFfalP2qk/oRgBiKT6MMC27p4Mn+vCaQDT5ZXnFc1cYPabJfxSjGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI7p+g0A+t9BZkdMLLj6e0IKy4cQYLS0wFLxUCk3Tpv795B4KH
	5FqpMV/GWWwaWxd8/gf2dSwhjVJfQhrZRTMDJlZ4U/1pLZv+g3xgNzyQnrVr6Qexlny6ylWmSoE
	/PTGuP/66xnH0WJ3ypgMYmz2UPACHpbQ=
X-Gm-Gg: ASbGncsFqPHgRZto/YZ9beynu/gRsjWXuQUdkJ3enm4k2nn7Qqgr+c6SE+hCPa5DJbb
	FDgew5dd58VPAsV/6f6WmlreawbugmP054Fvf9Y38sJrZDNQsaGX94oZlG+0Tvl3bdgxPuj9YL7
	eCIsYEu2blMAjj4ZTSCRb+FBN7qNn04sJUnGOk/cUt6U6ykVhYSOjmaGDbMpL9N+fduweMHqmqI
	I8wqe17FOKKc++iu6QoA+UruilCr1ih
X-Google-Smtp-Source: AGHT+IHws2FT4ntqw2aBfyYphiayJTViDr0NCOtRLHShrE7HH9AkcKRZ2uE4KegclrFt6GzjPLHB7HCfhOLqLk8uwho=
X-Received: by 2002:a05:6000:40dd:b0:401:8707:8a4b with SMTP id
 ffacd0b85a97d-4240fde589fmr4347238f8f.13.1759243679506; Tue, 30 Sep 2025
 07:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929142455.24883-1-clamor95@gmail.com> <20250929142455.24883-3-clamor95@gmail.com>
 <CAD=FV=WH5rsQR0vnsdZqfA-K-4AWSyOOfbe3g1H7pYCG0AigZw@mail.gmail.com>
 <CAPVz0n2Prw0ZoQhrodobmSpAu7XV6aX=NV=2ee0RwL3H5hWARg@mail.gmail.com> <CAD=FV=XD=L=otnj+YsQ1qEtrO_+wBD-ZYpDNmickcD1tb+6OoA@mail.gmail.com>
In-Reply-To: <CAD=FV=XD=L=otnj+YsQ1qEtrO_+wBD-ZYpDNmickcD1tb+6OoA@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 30 Sep 2025 17:47:47 +0300
X-Gm-Features: AS18NWDDLFPY7QuoEvdlKlGc5VsyjEg3iP3wTpt3AoBP5LXpgO2i_gfVf-6QDQM
Message-ID: <CAPVz0n1y86mKKvViG9dVN4gkqkbsjcZrFraTtKQ+Tvf4DBJCVw@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] gpu/drm: panel: add support for LG LD070WX3-SL01
 MIPI DSI panel
To: Doug Anderson <dianders@chromium.org>
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

=D0=B2=D1=82, 30 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 17:34 Doug=
 Anderson <dianders@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi,
>
> On Mon, Sep 29, 2025 at 10:13=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail=
.com> wrote:
> >
> > > > +static int lg_ld070wx3_unprepare(struct drm_panel *panel)
> > > > +{
> > > > +       struct lg_ld070wx3 *priv =3D to_lg_ld070wx3(panel);
> > > > +       struct mipi_dsi_multi_context ctx =3D { .dsi =3D priv->dsi =
};
> > > > +
> > > > +       mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
> > > > +
> > >
> > > Maybe add some comment about ignoring the accumulated error in the
> > > context and still doing the sleeps?
> > >
> >
> > Isn't that obvious? Regardless of what command returns power supply
> > should be turned off, preferably with a set amount of delays (delays
> > are taken from datasheet) to avoid leaving panel in uncertain state
> > with power on.
>
> I won't insist, though IMO any time an error return is purposely
> ignored a comment about why can be justified.
>
>
> > > > +       msleep(50);
> > > > +
> > > > +       regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->su=
pplies);
> > > > +
> > > > +       /* power supply must be off for at least 1s after panel dis=
able */
> > > > +       msleep(1000);
> > >
> > > Presumably it would be better to keep track of the time you turned it
> > > off and then make sure you don't turn it on again before that time?
> > > Otherwise you've got a pretty wasteful delay here.
> > >
> >
> > And how do you propose to implement that? Should I use mutex?
> > Datasheet is clear regarding this, after supply is turned off there
> > MUST be AT LEAST 1 second of delay before supplies can be turned back
> > on.
>
> You don't really need a mutex since the DRM core will make sure that
> prepare and unprepare can't be called at the same time. panel-edp
> implements this. See `unprepared_time` I believe.
>
> NOTE: if you want to get really deep into this, it's actually a bit of
> a complicated topic and I would also encourage you to add an

Please spare me of this, I have enough stuff to work with and have no
capacity to delve into depth of drm any deeper. In case this panel had
a reset I would not care about regulators too much, but it already
gave me too much pain and caused partially reversible damage to itself
that I am not willing to risk.

> "off-on-delay-us" to the regulator in your device tree (which only
> works on some regulators but really should be universal). This is
> important because:
>
> 1. The regulator could be shared by other consumers and they could
> cause violations of this.
>
> 2. The regulator could potentially be in either state when Linux starts.
>
> 3. The regulator framework could adjust the state of the regulator at
> regulator probe time.
>
> The "off-on-delay-us" handles at least some more of those cases,
> though I seem to remember that at least a few of them still have rough
> edges...

regulator may be not fixes and not handled fully by framework, I am
not wiling to risk.

>
>
> > > > +static int lg_ld070wx3_probe(struct mipi_dsi_device *dsi)
> > > > +{
> > > > +       struct device *dev =3D &dsi->dev;
> > > > +       struct lg_ld070wx3 *priv;
> > > > +       int ret;
> > > > +
> > > > +       priv =3D devm_drm_panel_alloc(dev, struct lg_ld070wx3, pane=
l,
> > > > +                                   &lg_ld070wx3_panel_funcs,
> > > > +                                   DRM_MODE_CONNECTOR_DSI);
> > > > +       if (IS_ERR(priv))
> > > > +               return PTR_ERR(priv);
> > > > +
> > > > +       priv->supplies[0].supply =3D "vcc";
> > > > +       priv->supplies[1].supply =3D "vdd";
> > > > +
> > > > +       ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(priv->suppl=
ies), priv->supplies);
> > > > +       if (ret < 0)
> > > > +               return dev_err_probe(dev, ret, "failed to get regul=
ators\n");
> > >
> > > Better to use devm_regulator_bulk_get_const() so you don't need to
> > > manually init the supplies?
> >
> > So you propose to init supplies in the probe? Are you aware that
> > between probe and panel prepare may be 8-10 seconds, sometimes even
> > more. Having power supplies enabled without panel configuration may
> > result in permanent panel damage during that time especially since
> > panel has no hardware reset mechanism.
>
> Maybe look more closely at devm_regulator_bulk_get_const(). Really it
> should just save you the lines of code:
>
>   priv->supplies[0].supply =3D "vcc";
>   priv->supplies[1].supply =3D "vdd";
>
> ...and it lets you put those names in a "static const" table in your
> driver. All the timings of when regulators are initted should be the
> same.
>

Here it is my bad, devm_regulator_bulk_get_const indeed should be
preferred. I thought you meant devm_regulator_bulk_get_enable which is
not the case.

> -Doug


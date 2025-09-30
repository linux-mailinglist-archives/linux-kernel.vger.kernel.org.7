Return-Path: <linux-kernel+bounces-837783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490A3BAD2D5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE8A164BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331C2302CD6;
	Tue, 30 Sep 2025 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UppWFxpx"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21201804A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242566; cv=none; b=XwjOhSQv1l/DF9Bxq0BKdHVFfJ1OL5wTwQCn0TGR3zhsidoQ8+JJ7UvukEbjFzWyKsgH3cZs7aIN6QSds49FXJS0qZr2I5aKXDDFyKfBK+FcMq/M2esj/c4P6EZIUnX+Xpfk5Riaan2dmPPotIiY+qsjI5qtWcule7m65O9Ytc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242566; c=relaxed/simple;
	bh=rmwyO9zRp4kD2rqR5LNaTJTRO8hwzlF7oOof50A1D1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puGPMllnor/Q3uY5Gh6zRsZ8p2HRJR3FsGxhr1s6eqBRE9odwgWfRDN1eDnAd0vJnRU3abpk0xyewEJV/98OP9iHw13fcZRdjmTLxfI7/A8ikzX6AONf130fVPwUpDTskS2yRErv9mIynuvxm2j21D0FG5DaFiByMQetI2VIFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UppWFxpx; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b57bf560703so4512134a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759242563; x=1759847363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XL/Mc8iUtyo5W2s1qkd1yXvd0NCSK6cLxiT3Omi/7eQ=;
        b=UppWFxpxKs4LfCeszXbB5M7clvG4X1xf3IPUeI5NaIvmYEqQucfUvurDbzX/pWMOLw
         RPK0iWJwSuNJpGzRTIIm2CZ2xJkrnjcjFRLYWx/i6SFjhrI09BPmYtA0AEXKPQVv3I4k
         iEsc3sCVBGN37QCAJBAHEnQrSyISGJtUW3bus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759242563; x=1759847363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XL/Mc8iUtyo5W2s1qkd1yXvd0NCSK6cLxiT3Omi/7eQ=;
        b=lLYy6wmg+R6irpzbssKz0mvTUtFsvalLXWSO6C8eZ/jR7G29TeZupRh/z4MP8YU7XO
         IH2Ud6ndFlp4rCnEbwTFQTVXMWPmK1UFgX0jUKvusdxkbm4sn70+srzV2Cr+0ghzMZIl
         IhvVDq36f8Uk12JEfOe3QXnDm+v7Tf2+BiarWWWdNzGjDx6wXtTGEtLZCUCPa0pv8kvX
         icPch2dICnEyqI15wB9lU5jpvD1CEf0lR1zLiCItCwK/ZQDZaqo4FeIqpC55zszBv+Np
         3iV1phRkM72SSSq7voCbAjsHjUILqW/51Lyb2z1RXsSrCD1CN85L1PhHkjgOHx9BgWMf
         Gfww==
X-Forwarded-Encrypted: i=1; AJvYcCWoyy2nl7IHWzP4XA0fpx/ReX4+R9NDlyguTcQ3YRtNVjJ7UYV6epXfvtJ13308QfQXc//DBUBOQNGWdq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzS8G2g1MEXHcXz3BA5hSvmgD4wWGv3c+RAnM8Fzd5GZ9gvrKv
	g0GCR4A+ijjUCC41PkTdsLwrV7PZd9tMPaw7kSX4scTxTaKzo22nVSR1EVLjhyK0/gJ5goSVDDv
	kgWs=
X-Gm-Gg: ASbGnctiV7ZkprCTUAKvX/U+BMeroPPJR+fgg9AI3xw8adGhDXiNx2rICVIl8ovvNHc
	ZpFt17ItopJvipoC1SQIEOJ028x9yDJi9npNDpKQYJtQBVSgFuj+xq5D78u+ldIic41eGPN0JSG
	h4WbgAJJhUuY+jBwNR89oDvuUiFDCANUeW79iNmuCgRp7nVp69GkNENTRDSIGWuuynTU3vvu8GH
	0LInl5eVUNCSKvOYgJLpBxnJeFZP39ep4XE8UFsjHlcJIlxhQx3KpQyxEVkIMB2CjnCOJfNzXh9
	Q6hjsZ1DFLL21ex5HldCud25inBHkhbsBwCwPl9KzQDN3l991rPn6ZIji1sQvGViqyZVW0n/ANt
	jbQiTXFmu78553llp8NBXXlNQ726GsMOm3PfKFtytYaRnfmJc4GetKDrjLwxiR9UmhHbYe30eWb
	ODEA5Qme+ZMmDXbDxlM+UOHosf
X-Google-Smtp-Source: AGHT+IHwK3mu/KLQPszQuTDarsIa5AEFdHOW5wAHHThNYXYYQkCO+i7bHskIT5MF1IUbeH899W8w0Q==
X-Received: by 2002:a17:90b:3143:b0:32b:be68:bb30 with SMTP id 98e67ed59e1d1-3342a30d009mr22656215a91.37.1759242562656;
        Tue, 30 Sep 2025 07:29:22 -0700 (PDT)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com. [209.85.214.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bcd9afbsm20654694a91.0.2025.09.30.07.29.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 07:29:21 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-28a5b8b12a1so23006405ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:29:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4qplgLH2ce3AP4wrTXJzPBPq6r0IrJfQDvhE8bLrZIJBBq9qZg4Z/POm3WSWrWKuXkBjpTCCkEHd/fH4=@vger.kernel.org
X-Received: by 2002:a17:902:7088:b0:24c:965a:f97e with SMTP id
 d9443c01a7336-27ed4a29dacmr180245305ad.2.1759242560525; Tue, 30 Sep 2025
 07:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929142455.24883-1-clamor95@gmail.com> <20250929142455.24883-3-clamor95@gmail.com>
 <CAD=FV=WH5rsQR0vnsdZqfA-K-4AWSyOOfbe3g1H7pYCG0AigZw@mail.gmail.com> <CAPVz0n2Prw0ZoQhrodobmSpAu7XV6aX=NV=2ee0RwL3H5hWARg@mail.gmail.com>
In-Reply-To: <CAPVz0n2Prw0ZoQhrodobmSpAu7XV6aX=NV=2ee0RwL3H5hWARg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 30 Sep 2025 07:29:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XD=L=otnj+YsQ1qEtrO_+wBD-ZYpDNmickcD1tb+6OoA@mail.gmail.com>
X-Gm-Features: AS18NWBKEeqzCuUPltq0hFLhhfC7TR2NA7onkkxdD9X53tjrGMLTsb8gFsFvIps
Message-ID: <CAD=FV=XD=L=otnj+YsQ1qEtrO_+wBD-ZYpDNmickcD1tb+6OoA@mail.gmail.com>
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

On Mon, Sep 29, 2025 at 10:13=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.c=
om> wrote:
>
> > > +static int lg_ld070wx3_unprepare(struct drm_panel *panel)
> > > +{
> > > +       struct lg_ld070wx3 *priv =3D to_lg_ld070wx3(panel);
> > > +       struct mipi_dsi_multi_context ctx =3D { .dsi =3D priv->dsi };
> > > +
> > > +       mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
> > > +
> >
> > Maybe add some comment about ignoring the accumulated error in the
> > context and still doing the sleeps?
> >
>
> Isn't that obvious? Regardless of what command returns power supply
> should be turned off, preferably with a set amount of delays (delays
> are taken from datasheet) to avoid leaving panel in uncertain state
> with power on.

I won't insist, though IMO any time an error return is purposely
ignored a comment about why can be justified.


> > > +       msleep(50);
> > > +
> > > +       regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supp=
lies);
> > > +
> > > +       /* power supply must be off for at least 1s after panel disab=
le */
> > > +       msleep(1000);
> >
> > Presumably it would be better to keep track of the time you turned it
> > off and then make sure you don't turn it on again before that time?
> > Otherwise you've got a pretty wasteful delay here.
> >
>
> And how do you propose to implement that? Should I use mutex?
> Datasheet is clear regarding this, after supply is turned off there
> MUST be AT LEAST 1 second of delay before supplies can be turned back
> on.

You don't really need a mutex since the DRM core will make sure that
prepare and unprepare can't be called at the same time. panel-edp
implements this. See `unprepared_time` I believe.

NOTE: if you want to get really deep into this, it's actually a bit of
a complicated topic and I would also encourage you to add an
"off-on-delay-us" to the regulator in your device tree (which only
works on some regulators but really should be universal). This is
important because:

1. The regulator could be shared by other consumers and they could
cause violations of this.

2. The regulator could potentially be in either state when Linux starts.

3. The regulator framework could adjust the state of the regulator at
regulator probe time.

The "off-on-delay-us" handles at least some more of those cases,
though I seem to remember that at least a few of them still have rough
edges...


> > > +static int lg_ld070wx3_probe(struct mipi_dsi_device *dsi)
> > > +{
> > > +       struct device *dev =3D &dsi->dev;
> > > +       struct lg_ld070wx3 *priv;
> > > +       int ret;
> > > +
> > > +       priv =3D devm_drm_panel_alloc(dev, struct lg_ld070wx3, panel,
> > > +                                   &lg_ld070wx3_panel_funcs,
> > > +                                   DRM_MODE_CONNECTOR_DSI);
> > > +       if (IS_ERR(priv))
> > > +               return PTR_ERR(priv);
> > > +
> > > +       priv->supplies[0].supply =3D "vcc";
> > > +       priv->supplies[1].supply =3D "vdd";
> > > +
> > > +       ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(priv->supplie=
s), priv->supplies);
> > > +       if (ret < 0)
> > > +               return dev_err_probe(dev, ret, "failed to get regulat=
ors\n");
> >
> > Better to use devm_regulator_bulk_get_const() so you don't need to
> > manually init the supplies?
>
> So you propose to init supplies in the probe? Are you aware that
> between probe and panel prepare may be 8-10 seconds, sometimes even
> more. Having power supplies enabled without panel configuration may
> result in permanent panel damage during that time especially since
> panel has no hardware reset mechanism.

Maybe look more closely at devm_regulator_bulk_get_const(). Really it
should just save you the lines of code:

  priv->supplies[0].supply =3D "vcc";
  priv->supplies[1].supply =3D "vdd";

...and it lets you put those names in a "static const" table in your
driver. All the timings of when regulators are initted should be the
same.

-Doug


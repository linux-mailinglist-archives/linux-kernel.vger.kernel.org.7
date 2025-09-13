Return-Path: <linux-kernel+bounces-815383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E821B56393
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 00:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE35B7A58FD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 22:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3BB2BE642;
	Sat, 13 Sep 2025 22:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAY7+glq"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2DC2BE651
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757801958; cv=none; b=e2nnyn7puiuoOOLSE72b8Hgh7hHWHdqIMN6SnM/LsJKxUk6v+x75vEW7XxHnlVOETAnOvbhlkWvSO2fw8IUKkGNhLZb5L1kgOZGb7oLrS8uu2NrIu6SjnJx0Jx8e/Y+pCJtdBF+yTle8lpz/aSLPIVmDvVQjPPu5o4NFDxXlQAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757801958; c=relaxed/simple;
	bh=mK3bqz1lh5DOq/GSlY+/z3Eg/cIrTFA1sxSnKbvqraM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ky6FRwYj1c2qf79FLpNjmf+kTnK2hwDxdFmHynR+qpyrJShqk4a2jjCj2+8YjZakF0J7h581kU7ALJxQQZCvIFpNLD/lGH1xfBkK7x28TkWLOa45e3poWepB0la2LLD8/n0SaRWPlvOW94XNrntetnwigdMEjAevvDwY/sIYUm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAY7+glq; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-620724883e6so5925617a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 15:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757801955; x=1758406755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RLnhj7G25qdMaXLVsgM9B42gj/5BiTnSzsDycCl5L4=;
        b=fAY7+glqyaYff9QQ0YkrfVFWYDVc5+Zb8nBYce6ZmlqpFNdLyIb6295po72X9eNbeE
         9kyIELvPZeqAT7ZU4CIjW1Xk608mkHZOywS+aGwPeAoxYaQHQUZAQh7GecGHJctHeTkM
         vtiRTNBWT4hM009Rm90ucZ2eriZdvB7vb4bIhVCYtxipu9ayx19nIu6AvphvlGZWchza
         pMAlgNvdu9sqDWj/7isNJ8BkPyP9q0K/k1D8WSHmnqJg3xtno/IkrOubbhjfVKESV881
         DmW5mhZnhaYF2vh1h643W6YCS4Dd2XijmelDVFljKeXnMiDYgXfwInI++z0M6BadlrT/
         qQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757801955; x=1758406755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RLnhj7G25qdMaXLVsgM9B42gj/5BiTnSzsDycCl5L4=;
        b=tMBokG6wrxmnO4dss4wDK4LMo7ceL7hkkYnuk7NFZ4I05eO3YYBUvaVLI0chn2B2CV
         WGmA/vWAFIXB1FZezbCq/jNeghIsxd7FyMxjuAtZHpU9btpbs99LtNRObMvj2OoYZbkx
         VQ3EJv82+3wo+teWJiH6Fbrlu7sZFpLluSdVJZF3ky2YTZvHnUdDblR/XbqBM/ifJCsG
         zeNTLoQB/5PX9leDkTgL+Mjw7l7A8E+ff6OwPfsv78yL3fbtaRoKHqMATt34sDW1gJMY
         aHllWOvGXIbtJEL2HrocZ8KEotQrTYP1oj370CgTWGyi+TRUOW/wEH1qGBkxDU1634Rp
         Ts4g==
X-Forwarded-Encrypted: i=1; AJvYcCWl8McL0sh88p5ucppr6qQKvhZxKWOxD0WxPZThf5pvcgiRfaLZN/RcrW2dZDWA0T4A5mdRihRSvzOGx1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+EYF8/dK4YB21cfoVqpEu1h53HTRO/fdLMMj3cd69GP5m8hfr
	8WsI1UY6u4dyd5rbRJyYm7MXTOS0eIp33jrcpCRX72BUqSuuZh5ejw2G0apiw8KP0UnaYPW1hYW
	qQX+ygpcyvUzKDnxGqWsIIBecasK3kqw=
X-Gm-Gg: ASbGnctNspBIfOlAQls4yAohU/xYPHMHyMF/ElPTdd8f+p71K/XVf00zyaBCEyWQID4
	ZvdNmX1dCtsE8F8bIu4eVpltoB0LYgzgeq9uGZHcdbGW5VIvQepX/gnvzmdTAEl1dDVfNxBd0fP
	vGRO10kRchykljm7oLu7BWR2+gQywaRCK7OKu4QK4c/QhX3I98zA2J7cJ2WqryFCV4syraFqi8D
	aDi4Ct+RnRGngiMQmeutKRhg9aWpw==
X-Google-Smtp-Source: AGHT+IE2lHR/3KJu91xQakdhwEaZeik3htU2ix/ewwP0SUcum9tVrS+wa98xrUE+9bFew3+1MR0f1wUqlsooW32ETBU=
X-Received: by 2002:a05:6402:24c9:b0:629:1c5:808d with SMTP id
 4fb4d7f45d1cf-62ed80fd472mr6273515a12.3.1757801954530; Sat, 13 Sep 2025
 15:19:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813224000.130292-1-eslam.medhat1993@gmail.com> <2e4334ac-ebd2-4686-8d5c-6d7a637a6d57@microchip.com>
In-Reply-To: <2e4334ac-ebd2-4686-8d5c-6d7a637a6d57@microchip.com>
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
Date: Sun, 14 Sep 2025 01:19:02 +0300
X-Gm-Features: AS18NWAOu4BgbruQRdwVxLiqDLLs8nLi7Y1Q4QEyTGk0jZvNFbgORyQvtcpoX80
Message-ID: <CAFRctSHGG-7tx0o5-hi2pZbsw-9jGV1FZrFquOOnFAB=i+O8Gw@mail.gmail.com>
Subject: Re: [PATCH v4] drm: atmel-hlcdc: replace dev_* print functions with
 drm_* variants
To: Manikandan.M@microchip.com, Dharma Balasubiramani <Dharma.B@microchip.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Nicolas Ferre <Nicolas.Ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	open list <linux-kernel@vger.kernel.org>
Cc: Eslam Khafagy <eslam.medhat1993@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Manikandan,
This patch has been reviewed for a while now. but i didn't get an
update if it's been pulled yet or not .

kindly can you kindly update if it's been pulled or not ?
thanks in advance.


On Mon, Aug 18, 2025 at 12:16=E2=80=AFPM <Manikandan.M@microchip.com> wrote=
:
>
> On 14/08/25 4:09 am, Eslam Khafagy wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >
> > Update the Atmel HLCDC code to use DRM print macros drm_*() instead of
> > dev_warn() and dev_err(). This change ensures consistency with DRM
> > subsystem logging conventions [1].
> >
> > [1]
> > Link: https://docs.kernel.org/gpu/todo.html#convert-logging-to-drm-func=
tions-with-drm-device-parameter
> >
> > Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
>
> Reviewed-by: Manikandan Muralidharan <manikandan.m@microchip.com>
>
> > ---
> >   .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 21 ++++++++++--------=
-
> >   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  | 14 ++++++-------
> >   .../gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c  |  3 ++-
> >   .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   |  6 +++---
> >   4 files changed, 23 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/g=
pu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> > index 0f7ffb3ced20..e0efc7309b1b 100644
> > --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> > +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> > @@ -20,6 +20,7 @@
> >   #include <drm/drm_atomic_helper.h>
> >   #include <drm/drm_crtc.h>
> >   #include <drm/drm_modeset_helper_vtables.h>
> > +#include <drm/drm_print.h>
> >   #include <drm/drm_probe_helper.h>
> >   #include <drm/drm_vblank.h>
> >
> > @@ -215,32 +216,32 @@ static void atmel_hlcdc_crtc_atomic_disable(struc=
t drm_crtc *c,
> >                  if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, s=
tatus,
> >                                               !(status & ATMEL_XLCDC_CM=
),
> >                                               10, 1000))
> > -                       dev_warn(dev->dev, "Atmel LCDC status register =
CMSTS timeout\n");
> > +                       drm_warn(dev, "Atmel LCDC status register CMSTS=
 timeout\n");
> >
> >                  regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_XLCDC_SD);
> >                  if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, s=
tatus,
> >                                               status & ATMEL_XLCDC_SD,
> >                                               10, 1000))
> > -                       dev_warn(dev->dev, "Atmel LCDC status register =
SDSTS timeout\n");
> > +                       drm_warn(dev, "Atmel LCDC status register SDSTS=
 timeout\n");
> >          }
> >
> >          regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_DISP);
> >          if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
> >                                       !(status & ATMEL_HLCDC_DISP),
> >                                      10, 1000))
> > -               dev_warn(dev->dev, "Atmel LCDC status register DISPSTS =
timeout\n");
> > +               drm_warn(dev, "Atmel LCDC status register DISPSTS timeo=
ut\n");
> >
> >          regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_SYNC);
> >          if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
> >                                       !(status & ATMEL_HLCDC_SYNC),
> >                                      10, 1000))
> > -               dev_warn(dev->dev, "Atmel LCDC status register LCDSTS t=
imeout\n");
> > +               drm_warn(dev, "Atmel LCDC status register LCDSTS timeou=
t\n");
> >
> >          regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_PIXEL_CLK);
> >          if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
> >                                       !(status & ATMEL_HLCDC_PIXEL_CLK)=
,
> >                                      10, 1000))
> > -               dev_warn(dev->dev, "Atmel LCDC status register CLKSTS t=
imeout\n");
> > +               drm_warn(dev, "Atmel LCDC status register CLKSTS timeou=
t\n");
> >
> >          clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
> >          pinctrl_pm_select_sleep_state(dev->dev);
> > @@ -269,32 +270,32 @@ static void atmel_hlcdc_crtc_atomic_enable(struct=
 drm_crtc *c,
> >          if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
> >                                       status & ATMEL_HLCDC_PIXEL_CLK,
> >                                       10, 1000))
> > -               dev_warn(dev->dev, "Atmel LCDC status register CLKSTS t=
imeout\n");
> > +               drm_warn(dev, "Atmel LCDC status register CLKSTS timeou=
t\n");
> >
> >          regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_SYNC);
> >          if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
> >                                       status & ATMEL_HLCDC_SYNC,
> >                                       10, 1000))
> > -               dev_warn(dev->dev, "Atmel LCDC status register LCDSTS t=
imeout\n");
> > +               drm_warn(dev, "Atmel LCDC status register LCDSTS timeou=
t\n");
> >
> >          regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_DISP);
> >          if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
> >                                       status & ATMEL_HLCDC_DISP,
> >                                       10, 1000))
> > -               dev_warn(dev->dev, "Atmel LCDC status register DISPSTS =
timeout\n");
> > +               drm_warn(dev, "Atmel LCDC status register DISPSTS timeo=
ut\n");
> >
> >          if (crtc->dc->desc->is_xlcdc) {
> >                  regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_XLCDC_CM);
> >                  if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, s=
tatus,
> >                                               status & ATMEL_XLCDC_CM,
> >                                               10, 1000))
> > -                       dev_warn(dev->dev, "Atmel LCDC status register =
CMSTS timeout\n");
> > +                       drm_warn(dev, "Atmel LCDC status register CMSTS=
 timeout\n");
> >
> >                  regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_XLCDC_SD);
> >                  if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, s=
tatus,
> >                                               !(status & ATMEL_XLCDC_SD=
),
> >                                               10, 1000))
> > -                       dev_warn(dev->dev, "Atmel LCDC status register =
SDSTS timeout\n");
> > +                       drm_warn(dev, "Atmel LCDC status register SDSTS=
 timeout\n");
> >          }
> >
> >          pm_runtime_put_sync(dev->dev);
> > diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu=
/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> > index fa8ad94e431a..acb017a2486b 100644
> > --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> > +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> > @@ -724,19 +724,19 @@ static int atmel_hlcdc_dc_modeset_init(struct drm=
_device *dev)
> >
> >          ret =3D atmel_hlcdc_create_outputs(dev);
> >          if (ret) {
> > -               dev_err(dev->dev, "failed to create HLCDC outputs: %d\n=
", ret);
> > +               drm_err(dev, "failed to create HLCDC outputs: %d\n", re=
t);
> >                  return ret;
> >          }
> >
> >          ret =3D atmel_hlcdc_create_planes(dev);
> >          if (ret) {
> > -               dev_err(dev->dev, "failed to create planes: %d\n", ret)=
;
> > +               drm_err(dev, "failed to create planes: %d\n", ret);
> >                  return ret;
> >          }
> >
> >          ret =3D atmel_hlcdc_crtc_create(dev);
> >          if (ret) {
> > -               dev_err(dev->dev, "failed to create crtc\n");
> > +               drm_err(dev, "failed to create crtc\n");
> >                  return ret;
> >          }
> >
> > @@ -778,7 +778,7 @@ static int atmel_hlcdc_dc_load(struct drm_device *d=
ev)
> >
> >          ret =3D clk_prepare_enable(dc->hlcdc->periph_clk);
> >          if (ret) {
> > -               dev_err(dev->dev, "failed to enable periph_clk\n");
> > +               drm_err(dev, "failed to enable periph_clk\n");
> >                  return ret;
> >          }
> >
> > @@ -786,13 +786,13 @@ static int atmel_hlcdc_dc_load(struct drm_device =
*dev)
> >
> >          ret =3D drm_vblank_init(dev, 1);
> >          if (ret < 0) {
> > -               dev_err(dev->dev, "failed to initialize vblank\n");
> > +               drm_err(dev, "failed to initialize vblank\n");
> >                  goto err_periph_clk_disable;
> >          }
> >
> >          ret =3D atmel_hlcdc_dc_modeset_init(dev);
> >          if (ret < 0) {
> > -               dev_err(dev->dev, "failed to initialize mode setting\n"=
);
> > +               drm_err(dev, "failed to initialize mode setting\n");
> >                  goto err_periph_clk_disable;
> >          }
> >
> > @@ -802,7 +802,7 @@ static int atmel_hlcdc_dc_load(struct drm_device *d=
ev)
> >          ret =3D atmel_hlcdc_dc_irq_install(dev, dc->hlcdc->irq);
> >          pm_runtime_put_sync(dev->dev);
> >          if (ret < 0) {
> > -               dev_err(dev->dev, "failed to install IRQ handler\n");
> > +               drm_err(dev, "failed to install IRQ handler\n");
> >                  goto err_periph_clk_disable;
> >          }
> >
> > diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers=
/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> > index 50fee6a93964..0b8a86afb096 100644
> > --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> > +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> > @@ -15,6 +15,7 @@
> >   #include <drm/drm_bridge.h>
> >   #include <drm/drm_encoder.h>
> >   #include <drm/drm_of.h>
> > +#include <drm/drm_print.h>
> >   #include <drm/drm_simple_kms_helper.h>
> >
> >   #include "atmel_hlcdc_dc.h"
> > @@ -92,7 +93,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_dev=
ice *dev, int endpoint)
> >          output->bus_fmt =3D atmel_hlcdc_of_bus_fmt(ep);
> >          of_node_put(ep);
> >          if (output->bus_fmt < 0) {
> > -               dev_err(dev->dev, "endpoint %d: invalid bus width\n", e=
ndpoint);
> > +               drm_err(dev, "endpoint %d: invalid bus width\n", endpoi=
nt);
> >                  return -EINVAL;
> >          }
> >
> > diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/=
gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> > index 4a7ba0918eca..817284509b57 100644
> > --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> > +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> > @@ -1034,7 +1034,7 @@ static void atmel_hlcdc_irq_dbg(struct atmel_hlcd=
c_plane *plane,
> >          if (isr &
> >              (ATMEL_HLCDC_LAYER_OVR_IRQ(0) | ATMEL_HLCDC_LAYER_OVR_IRQ(=
1) |
> >               ATMEL_HLCDC_LAYER_OVR_IRQ(2)))
> > -               dev_dbg(plane->base.dev->dev, "overrun on plane %s\n",
> > +               drm_dbg(plane->base.dev, "overrun on plane %s\n",
> >                          desc->name);
> >   }
> >
> > @@ -1051,7 +1051,7 @@ static void atmel_xlcdc_irq_dbg(struct atmel_hlcd=
c_plane *plane,
> >          if (isr &
> >              (ATMEL_XLCDC_LAYER_OVR_IRQ(0) | ATMEL_XLCDC_LAYER_OVR_IRQ(=
1) |
> >               ATMEL_XLCDC_LAYER_OVR_IRQ(2)))
> > -               dev_dbg(plane->base.dev->dev, "overrun on plane %s\n",
> > +               drm_dbg(plane->base.dev, "overrun on plane %s\n",
> >                          desc->name);
> >   }
> >
> > @@ -1140,7 +1140,7 @@ static void atmel_hlcdc_plane_reset(struct drm_pl=
ane *p)
> >          if (state) {
> >                  if (atmel_hlcdc_plane_alloc_dscrs(p, state)) {
> >                          kfree(state);
> > -                       dev_err(p->dev->dev,
> > +                       drm_err(p->dev,
> >                                  "Failed to allocate initial plane stat=
e\n");
> >                          return;
> >                  }
> > --
> > 2.43.0
> >
>
> --
> Thanks and Regards,
> Manikandan M.
>


--=20

Eslam Medhat Khafagy

https://www.linkedin.com/in/eslam-khafagy-a8a68159/


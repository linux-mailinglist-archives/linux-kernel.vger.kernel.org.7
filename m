Return-Path: <linux-kernel+bounces-851006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E28BD5392
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3DC056451A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A4E30ACF1;
	Mon, 13 Oct 2025 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FxofGVqJ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB8309DC5
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372271; cv=none; b=a/aGFCZxsgsMfmqBwZ3rVbCv8KaUBZhvGGb6OiVuzJg61sZfdAja9LGhm9DP896Q6BWWK7BIoJdlDTiVu3qq2p/QrBUYjfwuWFXjEO/2EEUFj3I/1PAuDfcQcaOkjPr0bgke1nn815u6y2acsVW0Ya2QOl+pKpGe+ujmnrrjx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372271; c=relaxed/simple;
	bh=cAB0kIpqj20tM7yHpaFoe3xcfA2AB5cxFaYcvZmpAuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXD8AZzGoL1ixE7yRoA9U6xfrLTc86W2P2fzKhpCGGDGLh1t5j6V7iN3Abx+9VX2fc7oTWCWkXgxbVOKVUi/eyzJQayaYkCsgkUDl/LDZsKn3W5frMta1B75BrzNCxdaYxh+y9L8K9UK5f3s5J6RF6/QD3bNskb3kgHrQs6zeBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FxofGVqJ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b40f11a1027so787995266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760372268; x=1760977068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LK0kBaNkf30iNo8Y7sNwo/F78yA794Ns47GaxpHfRwE=;
        b=FxofGVqJMHWx8mLcuV68TJGAq2HI2frGt4SejjODVNWyYLjAzC2f5esAu5on3WHtsl
         qaEt0HLgHzNDqnAjcwKfsaXvmzLm7vajqZDYdgLWxTP4nUQbRMASkzVbylCvlrBDMK43
         Vret2UyRsdt4Wth2SSEfuDM9ynHBul64YqN/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760372268; x=1760977068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LK0kBaNkf30iNo8Y7sNwo/F78yA794Ns47GaxpHfRwE=;
        b=jbNM3fV/U6FW5AXHEcV+zfPzvUNQRk3Kt1Q/URcAGaPs26aRtI1uZY9JoMw96bmvJd
         8Uj1j/J/KUbPSi/b6UNdPyD+U8Pq/MdVeeuqap/xYKcQnGvEI7JUbkRGePkJQw3Yi3zi
         17f/bKS2q3AJpVZiZ3H7Yuk6b6o4uaZTTW97ueUSbbcFFgE1zMpzHhbNhLtQURgOsRyH
         UaZMpNNGOJEL7UKl6Xl6DFZpNlOBYuB/DPXfFLrA0arSxYUNjKWSc1qUPlbFyVWFRY0U
         5lumhpLXSKCM/mZMTJBVMc2gK7t0qdpHmCKtRJ4N1A4sBqIdhosLTFbYm/iVnP9+YpQ5
         fQsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKD4jsXhUy8lqSavPCa5A1i8yMKBVCut4V5CDrDxUYNrQ5HCQn95GJ+7FKHOQv7uEsgiIIcXZiEYlHt9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvOm6s2hYonuwV7ed9j1za1QYH0NURFjMhLpevhg63AqEi3bzY
	YqNpZGDjI0bJrJ7YGixhgDbQx8ffAv7VRXr/FygJWtVbrwl8dU/O//u+h1iy4Tibrri0jQwcp4I
	EZBifR+8R
X-Gm-Gg: ASbGncs99iN9kI0yLnFFBUYv3VpmmiWaL6xUL2TuUP0z+ZaBX44XsoithrORurPLlR1
	2SFj98VaFlVGUiMIOVt5JMZFobukXl/gklRwfviKABzk4V4N76/YkNh3TSv07Za8dhzdkkJxT6a
	xXy//HsEqSO+/qcaJjqK5FW6Id6foJiGylA6nhg6zwiSUtrJkoSwKB82wN+PhOy4lKC1zx5c2Im
	2ZiOHNGMEMcoShvOdXw0/aKrNaZ9SUCK3ofd/EOFR1mkPH1e2mAdvDegjHFH3SK3YAOdU23Y23b
	wfW1aahvVx9bWy5X/28ZlG0MejFybRoVfqK7GRbSePKd9CBJMRlbUXsnqiZabC3xOMIgx7UZzso
	29dbBwxmWpQHF7EpIaZ0WKKTk9jHSLlpfZGR+K1KNJ0OoZwa9rmAJSB7TsJ1jqtW9X3gtreSWsy
	WeHfGpaPzmcXaSJg==
X-Google-Smtp-Source: AGHT+IElUkAbOAlh9aXdpj9uB1qVq3GCB4uhmJ/qFnYxxCfvKZJLjvMbOtINxusUs69nOybaS9oeFg==
X-Received: by 2002:a17:906:7313:b0:b30:b2e4:af3f with SMTP id a640c23a62f3a-b50aa89ea2amr2177003466b.14.1760372267551;
        Mon, 13 Oct 2025 09:17:47 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d65d6d74sm958033966b.29.2025.10.13.09.17.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 09:17:47 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63163a6556bso8740111a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:17:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVS+p2EczLm6urUotrNUJfCwQNXMabiLLRK46sImBoWUL2NDbuWR0chsNKvtM5ateXOqoKUh5orwTLl1lo=@vger.kernel.org
X-Received: by 2002:a05:6512:1095:b0:58b:75:8fbc with SMTP id
 2adb3069b0e04-5906dd8ef00mr6030162e87.50.1760370658194; Mon, 13 Oct 2025
 08:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-ptr_err-v1-0-2c5efbd82952@chromium.org>
 <20251013-ptr_err-v1-1-2c5efbd82952@chromium.org> <aO0cXYeGLwwDABP6@lizhi-Precision-Tower-5810>
In-Reply-To: <aO0cXYeGLwwDABP6@lizhi-Precision-Tower-5810>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 13 Oct 2025 17:50:44 +0200
X-Gmail-Original-Message-ID: <CANiDSCtxnR-ydCquhH1=g-XwZ9DN=eeJNxRBOGiqufS_DMYzUg@mail.gmail.com>
X-Gm-Features: AS18NWAjEedfD0tRDHHy9p2HIYCpNxcTQpn_Xf2f0oNW4TLvTJ881tcLSkxWDmQ
Message-ID: <CANiDSCtxnR-ydCquhH1=g-XwZ9DN=eeJNxRBOGiqufS_DMYzUg@mail.gmail.com>
Subject: Re: [PATCH 01/32] Input: cyttsp5 - Use %pe format specifier
To: Frank Li <Frank.li@nxp.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Leon Luo <leonl@leopardimaging.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, Jacopo Mondi <jacopo+renesas@jmondi.org>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	Julien Massot <julien.massot@collabora.com>, Jacopo Mondi <jacopo@jmondi.org>, 
	Daniel Scally <djrscally@gmail.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
	Sylvain Petinot <sylvain.petinot@foss.st.com>, Yong Zhi <yong.zhi@intel.com>, 
	Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, 
	Tiffany Lin <tiffany.lin@mediatek.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
	Yunfei Dong <yunfei.dong@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Rui Miguel Silva <rmfrfs@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Martin Kepplinger <martink@posteo.de>, Purism Kernel Team <kernel@puri.sm>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Dafna Hirschfeld <dafna@fastmail.com>, 
	Heiko Stuebner <heiko@sntech.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, imx@lists.linux.dev, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Frank

On Mon, 13 Oct 2025 at 17:36, Frank Li <Frank.li@nxp.com> wrote:
>
> On Mon, Oct 13, 2025 at 02:14:41PM +0000, Ricardo Ribalda wrote:
> > The %pe format specifier is designed to print error pointers. It prints
> > a symbolic error name (eg. -EINVAL) and it makes the code simpler by
> > omitting PTR_ERR()
> >
> > This patch fixes this cocci report:
> > ./cyttsp5.c:927:3-10: WARNING: Consider using %pe to print PTR_ERR()
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/input/touchscreen/cyttsp5.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Suppose it will go though input subsystem intead of media.
> Need post seperated at difference thread?

Indeed, it belongs to input. if there is a v2 I will move it to a
different thread.

Thanks!

>
> Frank
>
> >
> > diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
> > index 071b7c9bf566eb0b58e302a941ec085be1eb5683..47f4271395a69b8350f9be7266b57fe11d442ee3 100644
> > --- a/drivers/input/touchscreen/cyttsp5.c
> > +++ b/drivers/input/touchscreen/cyttsp5.c
> > @@ -923,8 +923,8 @@ static int cyttsp5_i2c_probe(struct i2c_client *client)
> >
> >       regmap = devm_regmap_init_i2c(client, &config);
> >       if (IS_ERR(regmap)) {
> > -             dev_err(&client->dev, "regmap allocation failed: %ld\n",
> > -                     PTR_ERR(regmap));
> > +             dev_err(&client->dev, "regmap allocation failed: %pe\n",
> > +                     regmap);
> >               return PTR_ERR(regmap);
> >       }
> >
> >
> > --
> > 2.51.0.760.g7b8bcc2412-goog
> >



-- 
Ricardo Ribalda


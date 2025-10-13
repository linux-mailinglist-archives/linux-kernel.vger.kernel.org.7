Return-Path: <linux-kernel+bounces-850987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2A2BD54BE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DB82582011
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF67730CD99;
	Mon, 13 Oct 2025 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YHOkGjzN"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9C830C60F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371360; cv=none; b=iZhs3PYbx2CRsCWd/TgHsMxz75V5qfkomTqjsw0TU9imV/3Ochz7oq5W3BcUSE/DP96SESZQ1JY6+plrAuaYAHaVh4JjHQMu2boyVvShmfJnl5H7PCibo4jZd/U8IIilhldv6gRysHWjupkSagS9omenNfbXtYf0ADSVjdHKmBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371360; c=relaxed/simple;
	bh=7pmScWeJxb/SA9LfgnIE+RSHfO7kt+ZDsVcv07zsRtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGBHed8ozmrd7Db8J0K9gaO1NVjXmtihdZEoMCmvR5rr+tF6fUKop1KWKBw3mwspUFA0K56mjDAwCX2UF33kCZabV3cgSGUCOw3MwXPrjS+RxhPadXoo27KvDEXE79GLuz7i+uuSQIqS7wFkDtQOta5ssTm9nroUh0e2Jl3e8yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YHOkGjzN; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-637dbabdb32so8619799a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760371356; x=1760976156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=85zW8eAa0UUuhYK13qFSD0pz0Cqd0sUrz3cG+0d4BSc=;
        b=YHOkGjzNU5nc+JsYjD4Or/MrD80ORcFAaxexfOSgtznsAonSQ99cLZ8lB5rl2PHg6r
         9lNQwVf/fXBi5n+V2RnPcoroguhewuaJ4cF9fbboAIMODo68RwMYhqq6wATr2ASTkMiI
         LTlE4R8F3ZUicWOiOWLDGJJjBOqKPOxFNCmOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760371356; x=1760976156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85zW8eAa0UUuhYK13qFSD0pz0Cqd0sUrz3cG+0d4BSc=;
        b=LYTmT830v6NundgJYVIhniupKUyhhKIg+lOl+B+8XpocuVRahwqejRWJzYsQINF/Uh
         6M3wmasx/ijXo7dQhcpg1LUm2GnE01KU4tHJdnICGQAXzTYpKGvDAWWwXN15dkyF8Il6
         3MyXfjvIjCdmoxgmZn6iZjDR0773jHms0kjeHcVXKQos+QNQtTz5l4ZTrDs7frlxm+rU
         uM5A2frQ4Cpx/XaZPHk8YwV6cJaQpCEhewvYRyyMlKaaiuQoINn3EEbKu0VYQLHXqrCV
         LUv364TD0CGZEOVAgKNMG2yqhgDTynZx7v3H5pCU1G5lmr7wEMulksmZr67V7sbflGA3
         1axg==
X-Forwarded-Encrypted: i=1; AJvYcCWewDtnorbLRG1znxjE9Fx9tNZs+mfOWlTS5ZIvfM4bdStoKz/ogs35xdio8VmsTf23cTA+YzK6lMRLFWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlrFgwuadayVXLCnl8NqYi6rmUyZkq9dTzP6ddq4b7u6I5gbus
	4KuGiYopwjeiQ9kT1hYFn6ss2GDk4XPHHz1PW4SMYHKIOQXuYHFwwxV+mlZZqBkg0IJG+m9zbMh
	emj7/CpAv
X-Gm-Gg: ASbGnculN02OKPDF3OGTaNxpqe/hp2lz2v1qisXpi4W2hvUYOsbUODHoXAshyBNoqRH
	GB1bqN9zdP5ZnMa3IZRrk02ygnw9ZnGPZebLsNRpG1jQ2VqlalgGhnKHfW8KfrSK7qubJiVHzR5
	2/rc+f3KXfvkIS+KTipprKtsaArcH6hxNmcSeW09o+ALBOIK8SsmkPQWdjQiSZ9n9D6I4LRM3QE
	G6YYy1822OfaOEMXRlkknh0XNK1zvtrAe1NR1GlEbC2TVlAfPqxhRJ2PZ6d65s56Z08HsGvC5GU
	Y7efKbljLXVdoU51RAZTfuV2sIR04L3esVg2tqGRBLz0zenc5ThGHHqcKjGmfmnDyz+J4amsH8N
	dZR23/7YCbTU6RWlRBN6JV5mce+MgvFF/ykCzAg7nZNPK1geIJGEoPjwwvJUVIoB8gD9iQVLdtj
	S/5MkYpN11sYthAA==
X-Google-Smtp-Source: AGHT+IHlFZuZI8vvgNUC+C61sfTbpFZB6kdxMEpW4TWPnPN2bc4kQYn48MgsCtzRCRT93nOTWpQ0tg==
X-Received: by 2002:a05:6402:3510:b0:634:c4b5:5d7 with SMTP id 4fb4d7f45d1cf-639d5c6fadamr20346843a12.34.1760371356286;
        Mon, 13 Oct 2025 09:02:36 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f860sm9031941a12.15.2025.10.13.09.02.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 09:02:36 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7ae31caso943759066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:02:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkHBD07SiXhSTPhYqjd5d363fJk1GH0tdvNg0PTZ7OHOHwnSHZ79rn+iXQY3SVZ5ZYjp6nQs+zx1E1qlQ=@vger.kernel.org
X-Received: by 2002:ac2:4c50:0:b0:55f:4ac2:a58c with SMTP id
 2adb3069b0e04-5906dc0ff30mr6173104e87.22.1760370964286; Mon, 13 Oct 2025
 08:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-ptr_err-v1-0-2c5efbd82952@chromium.org>
 <20251013-ptr_err-v1-10-2c5efbd82952@chromium.org> <176036780330.559803.287308146210017676@ping.linuxembedded.co.uk>
In-Reply-To: <176036780330.559803.287308146210017676@ping.linuxembedded.co.uk>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 13 Oct 2025 17:55:51 +0200
X-Gmail-Original-Message-ID: <CANiDSCsuPkdz0=U2b_mNh4TWTNztAd9qEwJaiMRdGy1sf3UEbA@mail.gmail.com>
X-Gm-Features: AS18NWCmgLaH0rMvCIhheSPVtWPGKkpbEBd_aB_kzUyM4RaB_yHSiy8sRs-muw0
Message-ID: <CANiDSCsuPkdz0=U2b_mNh4TWTNztAd9qEwJaiMRdGy1sf3UEbA@mail.gmail.com>
Subject: Re: [PATCH 10/32] media: i2c: imx335: Use %pe format specifier
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>, Bingbu Cao <bingbu.cao@intel.com>, 
	Dafna Hirschfeld <dafna@fastmail.com>, Daniel Scally <djrscally@gmail.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Jacopo Mondi <jacopo+renesas@jmondi.org>, 
	Jacopo Mondi <jacopo@jmondi.org>, Julien Massot <julien.massot@collabora.com>, 
	=?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>, 
	Krzysztof Kozlowski <krzk@kernel.org>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Leon Luo <leonl@leopardimaging.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Purism Kernel Team <kernel@puri.sm>, 
	Rui Miguel Silva <rmfrfs@gmail.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Sylvain Petinot <sylvain.petinot@foss.st.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Tianshu Qiu <tian.shu.qiu@intel.com>, Tiffany Lin <tiffany.lin@mediatek.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, Yong Zhi <yong.zhi@intel.com>, 
	Yunfei Dong <yunfei.dong@mediatek.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Kieran

On Mon, 13 Oct 2025 at 17:03, Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> Quoting Ricardo Ribalda (2025-10-13 15:14:50)
> > The %pe format specifier is designed to print error pointers. It prints
> > a symbolic error name (eg. -EINVAL) and it makes the code simpler by
> > omitting PTR_ERR().
> >
> > This patch fixes this cocci report:
> > ./i2c/imx335.c:1013:3-10: WARNING: Consider using %pe to print PTR_ERR()
>
> Ohhh nice. Is this new ? First I've come across it.

It is actually from 2019:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=57f5677e535ba24b8926a7125be2ef8d7f09323c

I just learned about it because there is a new check in coccinelle :).

It is pretty cool, but you need to be careful to check IS_ERR(ptr)
before doing the printk, otherwise %pe will print the pointer value.

Regards!

>
>
>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/i2c/imx335.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> > index c043df2f15fb25b3a56422092f99a1fd9a508fa9..71ed9a0d84a252ee362621c4d38001508fb86d28 100644
> > --- a/drivers/media/i2c/imx335.c
> > +++ b/drivers/media/i2c/imx335.c
> > @@ -1009,8 +1009,8 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
> >         imx335->reset_gpio = devm_gpiod_get_optional(imx335->dev, "reset",
> >                                                      GPIOD_OUT_HIGH);
> >         if (IS_ERR(imx335->reset_gpio)) {
> > -               dev_err(imx335->dev, "failed to get reset gpio %ld\n",
> > -                       PTR_ERR(imx335->reset_gpio));
> > +               dev_err(imx335->dev, "failed to get reset gpio %pe\n",
> > +                       imx335->reset_gpio);
>
> Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>
> >                 return PTR_ERR(imx335->reset_gpio);
> >         }
> >
> >
> > --
> > 2.51.0.760.g7b8bcc2412-goog
> >



-- 
Ricardo Ribalda


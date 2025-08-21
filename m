Return-Path: <linux-kernel+bounces-779362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C660B2F31E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C8516AF39
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0509B2BD5B3;
	Thu, 21 Aug 2025 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UiO2jxF+"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F26211290
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766895; cv=none; b=HdYeagDD9DHONZopwDyxPofQKjHe/Bm7NL9xy4sTvOmHbLy0+PnFOVit5urHzLYvL77N3bygqCMV4v9cLkC1YEsGHFJpJY+P1gO4TFEUTUbb4x3ew6NqZjTrLB2FLSjFGR7NAKPCSArQdvrTzpqAWKOGMdxprH/UkeS/vbtYiUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766895; c=relaxed/simple;
	bh=43VjtKOxxXNDPkLZNHUOkeHBaoI742+CHnEyUgUavCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dy8ozAmhTOHRJ2++G47CcVvFjPG416JVSjYVnTexu3II2sLjh6KJUC6YPEkUXDgAD5X25mhJvCPI+3H8HFGytBlfS+Q5lDKHlJkDfrXlKS11J4keR2kqL4U0tLq9Rhw+EE8tiEQWKWMUBPPA1XRURHf3QckCFOsmigdSc4ki1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UiO2jxF+; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-333f8ef379dso6539081fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755766890; x=1756371690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJiLgdHWROqB12Hg/2IJvH+nEqITMBBgtAb49NceKgg=;
        b=UiO2jxF+LbCzHY+5WTBmwVPShuq7ZTgAcdHHfEYkHAYrJgfYRs5gVTMf0Cupze0ifi
         8VLBTtku54o5T4fC+TuZwIc/EbZ8acrrxhP3LOaXviAdG+7IVcIKodKp8F2wEZbyDR0a
         VtfMVRUfmA7o0ZTiEhOpD4PtZsk2aQGwjYRocJaFt2saXiQgcpZi/8UHpnNQ5ZdQDi+A
         79DPAGePHtr+4S04Tc6rjW28/uJgdOEYRoPQfrEzXvwe2eDUzi7Pa2XArn1r+8CrX40L
         dJF44ZQl8dURTZoOjp5gMwmxUR1tGZUp0+nE06g/i3BYQ91TyhYMHJwyPCsp/bQimdDS
         sgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755766890; x=1756371690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJiLgdHWROqB12Hg/2IJvH+nEqITMBBgtAb49NceKgg=;
        b=TT7h5A1UIOGKTCkNioYz6IA/mIDiv43LUL+E59GKVQkPmNMO4srwCFyS7Dpn5/Wdwu
         Y9PP5+4g2DOKTilfF6dGNUsfLRIsPu7sc/dY8XVWZAmRVE55eXM2bTGgducyCJ6X/y4Q
         UUbMOMnBdqcbWvXDUSa2ChCcPhQNNchuD3RI72cuKD/RofLX+tPMyBlCJ0BdTpgbs816
         fZkRmNPuqCElHEuNamK7GHtUKHa1VfRgMQc49XjdH+nPRqZXwzvTLcjbZ+AXO9gvWgvW
         gcEPdgFZARsCH9SfWQkaEI/0a/IfTR/DgkGuX6VKaHPaKmijSF6JUDGgJqAib4f4p2F0
         msOA==
X-Forwarded-Encrypted: i=1; AJvYcCWmtihgXbBoNQkGS6MnIETCAEOrjzUTZrHA8sLZ0ZeGquSJRXjLXYl/byNipQd3r+wycZfeJWe5f4tk8OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD9uBu2DqFvkjPePqmulHXrV5/26zo6HTHSY/oZ9Ch1xOPLvze
	f77eBvhTPwksgNUP7kMGgUmU6l3XGwkQJLSjq4hsrkYYnYR+8rqHpFXakWKEv8eagiGF05X5Ipw
	P6ICde9o0dPjv48qRxwhubxi3qujH73nv9ZuNQ3M10w==
X-Gm-Gg: ASbGncvKZPUGHvu3A5cpO9aO0yG0ByiaonwZigAiGTX7ncgBq7o0w0MdCL8+XG5Jtw/
	BYiYe1vlJ4uk+F6H/AuHOP3LqsUQgSmHPS2q2qbQnbgQtov7ifu8eGmiToxFnU67lHfWjtLKuo1
	5CvHXP5zIb56U40hOrG8MMQqyNxMxf4R7GXRrRekQtKimjckI8eBY0gYhpzAKUhYWuAFoochEcX
	WA2sEU=
X-Google-Smtp-Source: AGHT+IFbJnnVhn06jfVroEMIzVme3igeJ9POu+bHevjfLshjHAvocCiAi05+NyAeJQCwMuLXL3VFXUrBLqRgHDUA23A=
X-Received: by 2002:a05:651c:23c8:20b0:333:b9db:f998 with SMTP id
 38308e7fff4ca-33549e41ff2mr4529661fa.1.1755766889647; Thu, 21 Aug 2025
 02:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818204420.794554-1-shenwei.wang@nxp.com> <20250818204420.794554-4-shenwei.wang@nxp.com>
In-Reply-To: <20250818204420.794554-4-shenwei.wang@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Aug 2025 11:01:17 +0200
X-Gm-Features: Ac12FXzKbO7sUD26Sno_8xmcOgjEihVR1BbLvXDJUasi5_vpoZ4AnY5gKSX69DE
Message-ID: <CACRpkdZq25n4gZSesV8z8zrBs6kqU1a8=vwVkPBwM+hFb9JKwg@mail.gmail.com>
Subject: Re: [PATCH 3/4] gpio: imx-rpmsg: add imx-rpmsg GPIO driver
To: Shenwei Wang <shenwei.wang@nxp.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shenwei,

thanks for your patch!

On Mon, Aug 18, 2025 at 10:45=E2=80=AFPM Shenwei Wang <shenwei.wang@nxp.com=
> wrote:

> On i.MX SoCs, the system may include two processors:
>         - An MCU running an RTOS
>         - An MPU running Linux
>
> These processors communicate via the RPMSG protocol.
> The driver implements the standard GPIO interface, allowing
> the Linux side to control GPIO controllers which reside in
> the remote processor via RPMSG protocol.
>
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>

Since this is a first RPMSG GPIO driver, I'd like if Bj=C3=B6rn and/or
Mathieu have a look at it so I'm sure it is RPMSG-proper!

> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index a437fe652dbc..2ce4e9b5225e 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -402,6 +402,17 @@ config GPIO_ICH
>
>           If unsure, say N.
>
> +config GPIO_IMX_RPMSG
> +       tristate "NXP i.MX SoC RPMSG GPIO support"
> +       depends on IMX_REMOTEPROC && RPMSG && GPIOLIB
> +       default IMX_REMOTEPROC
> +       help
> +         Say yes here to support the RPMSG GPIO functions on i.MX SoC ba=
sed
> +         platform.  Currently supported devices: i.MX7ULP, i.MX8ULP, i.M=
X8x,
> +         and i.MX9x.
> +
> +         If unsure, say N.

This is sorted under memory-mapped GPIO, but it isn't.

Create a new submenu:

menu "RPMSG GPIO drivers"
        depends on RPMSG

And put it here as the first such driver.

No need to have a dependency on RPMSG in the GPIO_IMX_RPMSG
Kconfig entry after this.

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/bitops.h>

bitops.h or just bits.h? Check which one you actually use.

> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/imx_rpmsg.h>
> +#include <linux/init.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_qos.h>

Are you really using pm_qos?

> +#include <linux/rpmsg.h>
> +#include <linux/virtio.h>
> +#include <linux/workqueue.h>

(...)

> +struct imx_rpmsg_gpio_port {
> +       struct gpio_chip gc;
> +       struct irq_chip chip;

This irqchip doesn't look very immutable.

Look at other patches rewriting irqchips to be immutable
and break this out to a static const struct irq_chip with
IRQCHIP_IMMUTABLE set instead.

> +static int imx_rpmsg_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> +{
> +       struct imx_rpmsg_gpio_port *port =3D gpiochip_get_data(gc);
> +       struct gpio_rpmsg_data *msg =3D NULL;
> +       int ret;
> +
> +       mutex_lock(&port->info.lock);

Please use guards for all the mutexes:

#include <linux/cleanup.h>

guard(mutex)(&port->info.lock);

and it will be released as you exit the function.

> +static int imx_rpmsg_gpio_direction_input(struct gpio_chip *gc,
> +                                         unsigned int gpio)
> +{
> +       struct imx_rpmsg_gpio_port *port =3D gpiochip_get_data(gc);
> +       struct gpio_rpmsg_data *msg =3D NULL;
> +       int ret;
> +
> +       mutex_lock(&port->info.lock);

Dito for all these instances.
(Saves you a bunch of lines!)

> +static void imx_rpmsg_irq_bus_lock(struct irq_data *d)
> +{
> +       struct imx_rpmsg_gpio_port *port =3D irq_data_get_irq_chip_data(d=
);
> +
> +       mutex_lock(&port->info.lock);
> +}

Here you need to keep the classic mutex_lock() though,
because of the irqchip locking abstraction helper.

> +static struct irq_chip imx_rpmsg_irq_chip =3D {

const

> +       .irq_mask =3D imx_rpmsg_mask_irq,
> +       .irq_unmask =3D imx_rpmsg_unmask_irq,
> +       .irq_set_wake =3D imx_rpmsg_irq_set_wake,
> +       .irq_set_type =3D imx_rpmsg_irq_set_type,
> +       .irq_shutdown =3D imx_rpmsg_irq_shutdown,
> +       .irq_bus_lock =3D imx_rpmsg_irq_bus_lock,
> +       .irq_bus_sync_unlock =3D imx_rpmsg_irq_bus_sync_unlock,

        .flags =3D IRQCHIP_IMMUTABLE,

probably also:

         GPIOCHIP_IRQ_RESOURCE_HELPERS,

?

I think you want to properly mark GPIO lines as used for
IRQs!

> +static int imx_rpmsg_gpio_to_irq(struct gpio_chip *gc, unsigned int gpio=
)
> +{
> +       struct imx_rpmsg_gpio_port *port =3D gpiochip_get_data(gc);
> +       int irq;
> +
> +       irq =3D irq_find_mapping(port->domain, gpio);
> +       if (irq > 0) {
> +               irq_set_chip_data(irq, port);
> +               irq_set_chip_and_handler(irq, &port->chip, handle_level_i=
rq);
> +       }
> +
> +       return irq;
> +}

Ugh we try to to use custom to_irq() if we can...

Do you have to?

Can't you use
select GPIOLIB_IRQCHIP
and be inspired by other chips using the irqchip
helper library?

We almost always use that these days.

> +       /* create an irq domain */
> +       port->chip =3D imx_rpmsg_irq_chip;
> +       port->chip.name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-gp=
io%d",
> +                                        pltdata->rproc_name, port->idx);
> +       port->dev =3D &pdev->dev;
> +
> +       irq_base =3D devm_irq_alloc_descs(&pdev->dev, -1, 0, IMX_RPMSG_GP=
IO_PER_PORT,
> +                                  numa_node_id());
> +       if (irq_base < 0) {
> +               dev_err(&pdev->dev, "Failed to alloc irq_descs\n");
> +               return irq_base;
> +       }
> +
> +       port->domain =3D irq_domain_create_legacy(of_node_to_fwnode(np),
> +                                               IMX_RPMSG_GPIO_PER_PORT,
> +                                               irq_base, 0,
> +                                               &irq_domain_simple_ops, p=
ort);
> +       if (!port->domain) {
> +               dev_err(&pdev->dev, "Failed to allocate IRQ domain\n");
> +               return -EINVAL;
> +       }

This also looks unnecessarily custom.

Try to use GPIOLIB_IRQCHIP.


> +static struct platform_driver imx_rpmsg_gpio_driver =3D {
> +       .driver =3D {
> +               .name =3D "gpio-imx-rpmsg",
> +               .of_match_table =3D imx_rpmsg_gpio_dt_ids,
> +       },
> +       .probe =3D imx_rpmsg_gpio_probe,
> +};
> +
> +static int __init gpio_imx_rpmsg_init(void)
> +{
> +       return platform_driver_register(&imx_rpmsg_gpio_driver);
> +}
> +
> +device_initcall(gpio_imx_rpmsg_init);

No please just do:

module_platform_driver(imx_rpmsg_gpio_driver);

Fix up  these things to begin with and then we can
look at details!

Yours,
Linus Walleij


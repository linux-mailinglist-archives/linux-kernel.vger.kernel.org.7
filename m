Return-Path: <linux-kernel+bounces-826345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F041B8E430
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A98B17799F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4538F2417C3;
	Sun, 21 Sep 2025 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4vhVMpR"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916F626980F
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 19:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758483008; cv=none; b=JhjMLQRy9KDqxyYPR+Xy8gmXPgf2HQUAz1rFXUseVObK0+wCODpW74qUvUAK/m+5xmj4XqBMatI+MBuyBxJBFcaX8VGXIl1ATankRCvkk/hohBxV0x6d0W8Cv/DDx7+eGIMElSzkm43JOrDQXMvoMabRoPKKLZNhvtpvJGA4c0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758483008; c=relaxed/simple;
	bh=xL0xteRgZwLL/d+XkaOCM9yVPSOOPMdShcGQmRctNw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXZaRCbgGsw3GJyQsP5qwm05qY/kJBtfiEWqo/On4UTvdagrcPvJZEKYau2bYY3GSoviZh7w4ZGUNuSXpJGNBIQhq829gELalreFIjDBop5l6xCchzJz2ho9pLThiR2ujbCbXyLzCfOOoVdwoyIIRaqBOMuIhywRugO1Hqx/ZyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4vhVMpR; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0787fa12e2so526398966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 12:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758483005; x=1759087805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UMcFVuFgFi7YsZ6vb6UWI1/YDjWPIeekCziENthjkU=;
        b=Q4vhVMpRC+sAaxVYfuc0LPPZvWYhQ0YTMPL5BdOBsLYyYeqnaeccMvSmKk8BNhiT+n
         Va2OyiJwcrRu4I1a5SLdvakpbPEn6T6DEwe8P85QLk//yMA3jf1/upGToa//JTA+bvgh
         McRFWE/N9meOG7O4b5BjfUCMrWNQhAgGDyBuUmZ4UgZVzPV6ga/T+dzVLASlEHEDlE+Z
         ZY7Fa7JWBKV8KGloSxZ0qiEAHLobrtF0xSceJWGs7e2uo73wfyKMawfTMyA2UnQyRmrK
         B3gyjP6w/CgkIDZ38Il0plwudjzN+T28F6Io0MGF1VsqNLEQdHd3ougpYAXAkSGX0xLo
         4fHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758483005; x=1759087805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UMcFVuFgFi7YsZ6vb6UWI1/YDjWPIeekCziENthjkU=;
        b=OdUF9LS0EPV2jTplLx+javbymfrNPu1XuN2BwwuMKytGgHpz/BGAajDs5xSPh+iXAF
         +QmCClp/9pAwNG6nswDBq7qajaAUVastp7HqnJNWX0Hx1kDUcqh8MUJ1oriB7ESVsR/0
         oASaL+Qg0Tc6gVmmBQsJl+Xh4dUpVKvgCV727Oss9t5XVvfi4wgAG4BoqyaC0Q7OcZPk
         8/Hk6T91/6ctsIt+0dVnXnS6jlu1RMMShtPHSloFeHXIjLf0gQkvRU9/sAcNhovQFALT
         4OkRIyEStxRgAJf0U2zJM6wvWbFuERgEHNg72zdplIBCIzXeA3XikDxwYhcEvS12Xg+8
         BlIw==
X-Forwarded-Encrypted: i=1; AJvYcCUP/jgjf6KklJOQsXF5RYF9g7FUM1Vw6NR1ya5j15yE5SIjD8kL0Ban5YEF5mCJBJT808+VayrmvDoHslY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwTJLaz6FwO+t5e46HFd6qabW78BtxDDAMsCutXqFn2XThmY8/
	Zt1nNLK62OxYppR1NwXByACAeq0lAqNRrboPAD02RdW3RVSoecY2XlAFBmH4Qp5lKGg6MtNk4Zh
	zlXdpqUeWRKVQ8FQGg7t1xrVB9kAIYsw+lx2IadU=
X-Gm-Gg: ASbGncvthomghb0u7LBt3I3UiwMqkS7HmBJ/O2DlxbIV/Wdef09Y121AYCDqPnad8hG
	qX7SsXAlTMM0GDEOictsD3IWn/535HRMU9Gsr4mW9pDprkJv2mG2KqvD0fsnJgSSHmfwlCrKWcB
	AdnWgvN19D0d6XZ33xGdTz/6CgIQdfzO2CK1KYGsd8HTeJ0CMX9nd/7CQ78aNWTBCDLMjTdZpmu
	xqx1sE=
X-Google-Smtp-Source: AGHT+IFRbSoEZ4hXrHbKY7rIQkedlBzCq7GAq/7nUM86aUC+QIgIG0f0jGEzVYrCAsMezOI4D1Ia5clt3pGh8SLFEpY=
X-Received: by 2002:a17:907:97d4:b0:b07:b782:51cc with SMTP id
 a640c23a62f3a-b24f66e5a01mr948675266b.64.1758483004871; Sun, 21 Sep 2025
 12:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921133327.123726-1-apokusinski01@gmail.com> <20250921133327.123726-3-apokusinski01@gmail.com>
In-Reply-To: <20250921133327.123726-3-apokusinski01@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 21 Sep 2025 22:29:28 +0300
X-Gm-Features: AS18NWCSPjyBPsDVoWwYybZi87WIvw4V2TP9e6hcpgy3ZV6wzxpTNjeA8qyui4M
Message-ID: <CAHp75Vd8Bwk8HVc3DhG4L=SgbSh3aFTQ2VRn7Tri8YhJrqaXgw@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: mpl3115: add support for DRDY interrupt
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux@roeck-us.net, rodrigo.gobbi.7@gmail.com, 
	naresh.solanki@9elements.com, michal.simek@amd.com, grantpeltier93@gmail.com, 
	farouk.bouabid@cherry.de, marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 4:34=E2=80=AFPM Antoni Pokusinski
<apokusinski01@gmail.com> wrote:
>
> MPL3115 sensor features a "data ready" interrupt which indicates the
> presence of new measurements.

...

>  #include <linux/module.h>

>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger.h>
>  #include <linux/delay.h>

> +#include <linux/property.h>

This is like delay.h is misplaced. What we do here, we group generic
ones followed by subsystem (IIO) related ones, and this seems wrong in
this driver.

Can you rather move delay.h to be the first, and add property.h after
i2c.h followed by a blank line, so in the result it will be like

delay.h
i2c.h
module.h
property.h
...blank.line...
iio/*.h

...

> +#define MPL3115_CTRL_INT_SRC_DRDY BIT(7)
> +
> +#define MPL3115_PT_DATA_EVENT_ALL (BIT(2) | BIT(1) | BIT(0))

Not sure I understand this definition in the following aspects:
1) why is this disrupting the _CTRL_ definitions?
2) why is this using BIT(x) and not respective definitions?
3) why can't you use GENMASK() if you just select all bits in a
certain bitfield?


>  #define MPL3115_CTRL_RESET BIT(2) /* software reset */
>  #define MPL3115_CTRL_OST BIT(1) /* initiate measurement */
>  #define MPL3115_CTRL_ACTIVE BIT(0) /* continuous measurement */
>  #define MPL3115_CTRL_OS_258MS (BIT(5) | BIT(4)) /* 64x oversampling */

...

>         mutex_lock(&data->lock);
> -       ret =3D mpl3115_request(data);
> -       if (ret < 0) {
> -               mutex_unlock(&data->lock);
> -               goto done;
> +       if (!(data->ctrl_reg1 & MPL3115_CTRL_ACTIVE)) {
> +               ret =3D mpl3115_request(data);
> +               if (ret < 0) {

> +                       mutex_unlock(&data->lock);

Instead, I suggest adding a prerequisite that moves the driver to use
cleanup.h, in particular scoped_guard(). This will reduce a churn
here,

> +                       goto done;
> +               }
>         }

...

> +static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool stat=
e)
> +{
> +       struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
> +       struct mpl3115_data *data =3D iio_priv(indio_dev);
> +       int ret;
> +       u8 ctrl_reg1 =3D data->ctrl_reg1;
> +
> +       if (state)
> +               ctrl_reg1 |=3D MPL3115_CTRL_ACTIVE;
> +       else
> +               ctrl_reg1 &=3D ~MPL3115_CTRL_ACTIVE;

> +       guard(mutex)(&data->lock);

Oh, and you already use this! Definitely, it misses the prerequisite patch.

> +       ret =3D i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1=
,
> +                                       ctrl_reg1);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG4=
,
> +                                       state ? MPL3115_CTRL_INT_EN_DRDY =
: 0);
> +       if (ret < 0)
> +               goto reg1_cleanup;
> +
> +       data->ctrl_reg1 =3D ctrl_reg1;
> +
> +       return 0;
> +
> +reg1_cleanup:
> +       i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> +                                 data->ctrl_reg1);
> +       return ret;
> +}

...

> +static int mpl3115_trigger_probe(struct mpl3115_data *data,
> +                                struct iio_dev *indio_dev)
> +{
> +       struct fwnode_handle *fwnode;
> +       int ret, irq, irq_type;
> +       bool act_high, is_int2 =3D false;

> +       fwnode =3D dev_fwnode(&data->client->dev);
> +       if (!fwnode)
> +               return -ENODEV;


Why is this fatal? Also, do we have a board file for users of this right no=
w?

> +       irq =3D fwnode_irq_get_byname(fwnode, "INT1");
> +       if (irq < 0) {
> +               irq =3D fwnode_irq_get_byname(fwnode, "INT2");
> +               if (irq < 0)
> +                       return 0;
> +
> +               is_int2 =3D true;
> +       }
> +
> +       irq_type =3D irq_get_trigger_type(irq);
> +       switch (irq_type) {
> +       case IRQF_TRIGGER_RISING:
> +               act_high =3D true;
> +               break;
> +       case IRQF_TRIGGER_FALLING:
> +               act_high =3D false;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       ret =3D i2c_smbus_write_byte_data(data->client, MPL3115_PT_DATA_C=
FG,
> +                                       MPL3115_PT_DATA_EVENT_ALL);
> +       if (ret < 0)
> +               return ret;

> +       if (!is_int2) {
> +               ret =3D i2c_smbus_write_byte_data(data->client,
> +                                               MPL3115_CTRL_REG5,
> +                                               MPL3115_CTRL_INT_CFG_DRDY=
);
> +               if (ret)
> +                       return ret;
> +       }
> +       if (act_high) {
> +               ret =3D i2c_smbus_write_byte_data(data->client,
> +                                               MPL3115_CTRL_REG3,
> +                                               is_int2 ? MPL3115_CTRL_IP=
OL2 :
> +                                                         MPL3115_CTRL_IP=
OL1);
> +               if (ret)
> +                       return ret;
> +       }

This if (!is_int2) and ternary with the same argument is kinda hard to
read, can we refactor it somehow?

For example, if these two booleans are represented by a common enum, we can=
 do

switch (cfg_flags) {
case INT2_ACTIVE_HIGH:
    _write_byte_data(REG3);
    break;
case INT2_ACTIVE_LOW:
    break;
case INT1_ACTIVE_HIGH:
   _write_byte_data(REG5);
   _write_byte_data(REG3);
  break;
case INT1_ACTIVE_LOW:
   _write_byte_data(REG5);
   break;
default:
    return -EINVAL;
}

Yes, it's more verbose, but I find this better to read and understand.

Note, you may drop the switch case for IRQ with this approach as you
can use a few bits together (separate bits for raising and falling to
make the default case working here).

> +       data->drdy_trig =3D devm_iio_trigger_alloc(&data->client->dev,
> +                                                "%s-dev%d",
> +                                                indio_dev->name,
> +                                                iio_device_id(indio_dev)=
);
> +       if (!data->drdy_trig)
> +               return -ENOMEM;
> +
> +       data->drdy_trig->ops =3D &mpl3115_trigger_ops;
> +       iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
> +       ret =3D iio_trigger_register(data->drdy_trig);
> +       if (ret)
> +               return ret;
> +
> +       indio_dev->trig =3D iio_trigger_get(data->drdy_trig);
> +
> +       return devm_request_threaded_irq(&data->client->dev, irq,
> +                                        NULL,
> +                                        mpl3115_interrupt_handler,
> +                                        IRQF_ONESHOT,
> +                                        "mpl3115_irq",
> +                                        indio_dev);
> +}

--=20
With Best Regards,
Andy Shevchenko


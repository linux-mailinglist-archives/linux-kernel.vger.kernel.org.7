Return-Path: <linux-kernel+bounces-808564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2538B50194
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D8E1C21FC1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D009B35AAAC;
	Tue,  9 Sep 2025 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz8BdRAt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A2935A291;
	Tue,  9 Sep 2025 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432095; cv=none; b=sZCvZoSWxSk4jrtktO1jiR1+KFc29dxgGM00dXr0paFE/6M5oRQH+/G1AHaciFpgnvSR3alrdrKX8extI+iKdG7ySYdI1T+K+RlmPeV2f2h4YDt3O0nTfMLcAfFdpHToY6Bceh8YOf350NNBPiikk6Yo/A9zdOxgtSFev6QBEv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432095; c=relaxed/simple;
	bh=K1I993cf+2W+lGzymZomWMALoxnoYaZDs4m1jNjhS2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PR1dYFcrfPIkHXaiBCPvfjLJiA8aQiF6Yw53qaYtX5sMnQm1gQTgQpFW8NO8KdJA31sfrdE8zkaTQDZvtHc+hMwO1lBvUA0fUlSlgt2TcueE4hRyElB1rlLiIlpdW2HdvqjUOX5ptGyY7CKaaPgkihJ9HQYHpOhumKmkxAjRwrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz8BdRAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7DFC4CEFC;
	Tue,  9 Sep 2025 15:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757432094;
	bh=K1I993cf+2W+lGzymZomWMALoxnoYaZDs4m1jNjhS2s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Sz8BdRAtJZWE0JLp+gKyi/jw4AoLuKnpKaUs5nQycbGLYxCGX3uvilJsRpV/jr3DF
	 /41O52jjJ+yHxBjR53AWt+PEEOKMH5CK+o1tHszjNsSdyj8GcgjLtArxWxxnUlebno
	 aFTIb+903d913rXrPK7yslACgJtMdZ8D3AZAKzCoS1iPN21zEdDSxVGCrO81VvPjt+
	 jzmTFqtKK7WNhcucvuQkOXEM8tAjLcTKix0FnWz78DJzKHf4USzgOaTqQdJ1HfKNpJ
	 fS3jHRRFrzMpgCXRfk3CANSszmmy5JwpJbJFGETKTL4Zpge3PELvyWcRRwWaBT1QCa
	 xv4ctyJNLWCug==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6219b29ed57so396907eaf.1;
        Tue, 09 Sep 2025 08:34:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW67vzmLXsfVRhm/GviYExwm9b9lCZtE3OxK0B4Y80os6kvAnZYstFCCzjqpy+ofRizOBForOjJHhsU@vger.kernel.org, AJvYcCW9w4SX6gGgYOIMZNpvHOmFDXRll4+XRqbX0s6JVSOfJIW4KxwFnEZyooR1xrj2x6177wLkCHJtX0jB+1hW@vger.kernel.org
X-Gm-Message-State: AOJu0YxoKPjos4hsPpZU6E+bcjsDvvkDTHNxabA2MlecI5GwPRe4urfe
	NFl+0PVSYohjbOPIIyL/96R84FvrTYwIbSKxVZcNEp21rLCKr3JOsJb9XKtDJy9SrGngHLEehRC
	T6Zjs8VlTI2CN4hJ9qOJD4yWb8NYecXk=
X-Google-Smtp-Source: AGHT+IGfCKL13MnW13lf2qUXjRi4j6cNzCCKWClaGKqkgM4p9Qf3D6EQWhqmV+YlLut2j6FKExL/iN1WgMm2ibLQw6M=
X-Received: by 2002:a05:6820:28c1:b0:621:7f8e:c895 with SMTP id
 006d021491bc7-6217f8ecbc5mr3757521eaf.1.1757432094019; Tue, 09 Sep 2025
 08:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908053335.36685-1-xu.yang_2@nxp.com> <20250908053335.36685-3-xu.yang_2@nxp.com>
In-Reply-To: <20250908053335.36685-3-xu.yang_2@nxp.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Wed, 10 Sep 2025 00:34:17 +0900
X-Gmail-Original-Message-ID: <CAGTfZH3VhDLyWD4brdyAHPLNv=UnCjpFA0SrUV8BEoArGYdm4Q@mail.gmail.com>
X-Gm-Features: Ac12FXxOTZYuNATQ_RRCWVhc81_b-_Jzbi-mUqWIxvHB_SCe34DOhwMszb4F8mg
Message-ID: <CAGTfZH3VhDLyWD4brdyAHPLNv=UnCjpFA0SrUV8BEoArGYdm4Q@mail.gmail.com>
Subject: Re: [RESEND v4 3/4] extcon: ptn5150: Add Type-C orientation switch support
To: Xu Yang <xu.yang_2@nxp.com>
Cc: krzk@kernel.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, 
	robh@kernel.org, conor+dt@kernel.org, gregkh@linuxfoundation.org, 
	swboyd@chromium.org, heikki.krogerus@linux.intel.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	jun.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Applied it. Thanks.

On Mon, Sep 8, 2025 at 2:34=E2=80=AFPM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> PTN5150 is able to detect CC polarity. The field[1:0] of CC status
> register (04H) will keep the result.
>
>   00: Cable Not Attached
>   01: CC1 is connected (normal orientation)
>   10: CC2 is connected (reversed orientation)
>   11: Reserved
>
> Add orientation switch support to correctly set orientation of
> multiplexer according to CC status.
>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
>
> ---
> Changes in v4:
>  - add Rb tag
> Changes in v3:
>  - no changes
> Changes in v2:
>  - move "enum typec_orientation orient" ahead
>  - improve commit message
> ---
>  drivers/extcon/Kconfig          |  1 +
>  drivers/extcon/extcon-ptn5150.c | 40 +++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index a6f6d467aacf..fd4ec5dda0b7 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -145,6 +145,7 @@ config EXTCON_PTN5150
>         tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
>         depends on I2C && (GPIOLIB || COMPILE_TEST)
>         depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
> +       depends on TYPEC || !TYPEC
>         select REGMAP_I2C
>         help
>           Say Y here to enable support for USB peripheral and USB host
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5=
150.c
> index 78ad86c4a3be..768428d306ce 100644
> --- a/drivers/extcon/extcon-ptn5150.c
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -18,6 +18,7 @@
>  #include <linux/extcon-provider.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/usb/role.h>
> +#include <linux/usb/typec_mux.h>
>
>  /* PTN5150 registers */
>  #define PTN5150_REG_DEVICE_ID                  0x01
> @@ -38,7 +39,11 @@
>  #define PTN5150_REG_DEVICE_ID_VERSION          GENMASK(7, 3)
>  #define PTN5150_REG_DEVICE_ID_VENDOR           GENMASK(2, 0)
>
> +#define PTN5150_POLARITY_CC1                   0x1
> +#define PTN5150_POLARITY_CC2                   0x2
> +
>  #define PTN5150_REG_CC_PORT_ATTACHMENT         GENMASK(4, 2)
> +#define PTN5150_REG_CC_POLARITY                        GENMASK(1, 0)
>  #define PTN5150_REG_CC_VBUS_DETECTION          BIT(7)
>  #define PTN5150_REG_INT_CABLE_ATTACH_MASK      BIT(0)
>  #define PTN5150_REG_INT_CABLE_DETACH_MASK      BIT(1)
> @@ -53,6 +58,7 @@ struct ptn5150_info {
>         int irq;
>         struct work_struct irq_work;
>         struct mutex mutex;
> +       struct typec_switch *orient_sw;
>         struct usb_role_switch *role_sw;
>  };
>
> @@ -71,6 +77,7 @@ static const struct regmap_config ptn5150_regmap_config=
 =3D {
>
>  static void ptn5150_check_state(struct ptn5150_info *info)
>  {
> +       enum typec_orientation orient =3D TYPEC_ORIENTATION_NONE;
>         unsigned int port_status, reg_data, vbus;
>         enum usb_role usb_role =3D USB_ROLE_NONE;
>         int ret;
> @@ -81,6 +88,23 @@ static void ptn5150_check_state(struct ptn5150_info *i=
nfo)
>                 return;
>         }
>
> +       orient =3D FIELD_GET(PTN5150_REG_CC_POLARITY, reg_data);
> +       switch (orient) {
> +       case PTN5150_POLARITY_CC1:
> +               orient =3D TYPEC_ORIENTATION_NORMAL;
> +               break;
> +       case PTN5150_POLARITY_CC2:
> +               orient =3D TYPEC_ORIENTATION_REVERSE;
> +               break;
> +       default:
> +               orient =3D TYPEC_ORIENTATION_NONE;
> +               break;
> +       }
> +
> +       ret =3D typec_switch_set(info->orient_sw, orient);
> +       if (ret)
> +               dev_err(info->dev, "failed to set orientation: %d\n", ret=
);
> +
>         port_status =3D FIELD_GET(PTN5150_REG_CC_PORT_ATTACHMENT, reg_dat=
a);
>
>         switch (port_status) {
> @@ -152,6 +176,12 @@ static void ptn5150_irq_work(struct work_struct *wor=
k)
>                                 dev_err(info->dev,
>                                         "failed to set none role: %d\n",
>                                         ret);
> +
> +                       ret =3D typec_switch_set(info->orient_sw,
> +                                              TYPEC_ORIENTATION_NONE);
> +                       if (ret)
> +                               dev_err(info->dev,
> +                                       "failed to set orientation: %d\n"=
, ret);
>                 }
>         }
>
> @@ -219,12 +249,14 @@ static void ptn5150_work_sync_and_put(void *data)
>
>         cancel_work_sync(&info->irq_work);
>         usb_role_switch_put(info->role_sw);
> +       typec_switch_put(info->orient_sw);
>  }
>
>  static int ptn5150_i2c_probe(struct i2c_client *i2c)
>  {
>         struct device *dev =3D &i2c->dev;
>         struct device_node *np =3D i2c->dev.of_node;
> +       struct fwnode_handle *connector;
>         struct ptn5150_info *info;
>         int ret;
>
> @@ -311,6 +343,14 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
>         if (ret)
>                 return -EINVAL;
>
> +       connector =3D device_get_named_child_node(dev, "connector");
> +       if (connector) {
> +               info->orient_sw =3D fwnode_typec_switch_get(connector);
> +               if (IS_ERR(info->orient_sw))
> +                       return dev_err_probe(info->dev, PTR_ERR(info->ori=
ent_sw),
> +                                       "failed to get orientation switch=
\n");
> +       }
> +
>         info->role_sw =3D usb_role_switch_get(info->dev);
>         if (IS_ERR(info->role_sw))
>                 return dev_err_probe(info->dev, PTR_ERR(info->role_sw),
> --
> 2.34.1
>
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics


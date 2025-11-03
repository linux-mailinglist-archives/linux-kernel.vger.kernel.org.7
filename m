Return-Path: <linux-kernel+bounces-883281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E15AC2CED6
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16EC34F4F12
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8EF3112BD;
	Mon,  3 Nov 2025 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WweFo7rn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA2E2FD68D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184995; cv=none; b=JYz4dEClEAB4QITkNWFT3fFvAUgs4t3uJws2FhrhN9b/CLc23iAIrJXnqjAr5L8in0KNxaJmhykPYX/ALwZwNplptxiq/dUL/RJ0INRWDMS89ipiogei8T/lJjahwuVuBYTxTdZxFlCxEbPYKQbFXQvy8Rei8MGavg1Jco5mS4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184995; c=relaxed/simple;
	bh=jrwdNT+LY0VHe6iI5zDHxVqEonsYtVyK2koZttL2cPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOMlA8Yy0TRXmzmqp0gMUKcaRFuYzAMTsNCaSLVHJnFJp9RF8ADD/s94vy0JN6cAwVbVT5vhj4Et8+WUUnwz8ouzhp4CH6USwPptSKZI/+3CD/s9GmZqWjqeqqQug3s7XmECZVzaJrjAoXLK3W8SybMrzrkUiU9hynTekP96DwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WweFo7rn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DA6C19421
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762184995;
	bh=jrwdNT+LY0VHe6iI5zDHxVqEonsYtVyK2koZttL2cPs=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=WweFo7rnLFScfPhczynJUg6tSMjDI//AmpeKwJm5kBsq9Gv//CpwEggAPBj/IhVF4
	 GwcKOZaeEFkbWuKKxsP3N8rCaK1Ac7tMHdsyYyk2WrOFTXJ37GHbExSdjAVn65NsYz
	 bbUagJhgNLxWxZbcahQglRUrO4U/EOT/AAtqhkAqRVjCZE70WIyP/UOEG0C+5/hv7S
	 cQb5w0OWg74w42h6doDbbyf/YsU/d9RsytBKTpL0ivjVNbthgaf6YalsFyNigWl1nW
	 nAgBiZ7pzknrcu3c9QENO3g/vkTnD8vRChygsHUHqBq25GpvGWlstUjNQtRMdjUugY
	 IlsbTDQBIIQHA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-591c9934e0cso7460819e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:49:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVs8ROGhlpYxhXe6MzXz51elw8efD57wDUX0KikPOvNO8oDMz0peFO0jhYVSPUYpCRFl8rqYoIeVmq0fwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPVFHKqZwS8AEXjpTf3Zj0hye0D0qSBEfmfz1V8bogjXLS5KkD
	9lW7U6w3ESlx3CSQM9Zjx3Y90DdSLqFwjwXHqqi5REqQC7PL4ndB8R52ZYrvDLd6cw/n5YlrlQc
	pjFQmpaFDUrEdTZqL4l0jfgiuumHYXqo=
X-Google-Smtp-Source: AGHT+IEAlEP8a1Qcbfb2QOw+fCrmp8/Z2a9ybjNNNkwqDevRO7tSwL/+tk9kUJlAWz/1PviISckStUdyJsqDu2c3pZM=
X-Received: by 2002:a2e:be8c:0:b0:37a:3350:82bb with SMTP id
 38308e7fff4ca-37a335086eemr16624571fa.19.1762184993722; Mon, 03 Nov 2025
 07:49:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021112013.2710903-1-andre.przywara@arm.com> <20251021112013.2710903-3-andre.przywara@arm.com>
In-Reply-To: <20251021112013.2710903-3-andre.przywara@arm.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 3 Nov 2025 23:49:37 +0800
X-Gmail-Original-Message-ID: <CAGb2v64H9_7sPuDDkOKhNQu3uV0NMYzDm2UVFtdKDpp=Dcu=TA@mail.gmail.com>
X-Gm-Features: AWmQ_bkqbGVKpuDpKUuBWWvi371_DHB4EaMe_pBLEMKWO7XhGeTSl6gM2Wl91yU
Message-ID: <CAGb2v64H9_7sPuDDkOKhNQu3uV0NMYzDm2UVFtdKDpp=Dcu=TA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mfd: axp20x: Add support for AXP318W PMIC
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yixun Lan <dlan@gentoo.org>, devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 7:20=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> The AXP318W is a PMIC chip produced by X-Powers, it can be connected to
> an I2C bus.
>
> It has a large number of regulators: 9(!) DCDC buck converters, and 28
> LDOs, also some ADCs, interrupts, and a power key.
>
> Describe the regmap and the MFD bits, along with the registers exposed
> via I2C only. This covers the regulator, interrupts and power key
> devices for now.
> Advertise the device using the new compatible string.
>
> We use just "318" for the internal identifiers, for easier typing and
> less churn, but use "318W" for anything externally visible. If something
> else other than the "AXP318W" shows up, that's an easy change then.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/mfd/axp20x-i2c.c   |  2 +
>  drivers/mfd/axp20x.c       | 84 +++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/axp20x.h | 86 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 172 insertions(+)
>
> diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
> index 5c93136f977e7..4e4ebfc78525c 100644
> --- a/drivers/mfd/axp20x-i2c.c
> +++ b/drivers/mfd/axp20x-i2c.c
> @@ -65,6 +65,7 @@ static const struct of_device_id axp20x_i2c_of_match[] =
=3D {
>         { .compatible =3D "x-powers,axp221", .data =3D (void *)AXP221_ID =
},
>         { .compatible =3D "x-powers,axp223", .data =3D (void *)AXP223_ID =
},
>         { .compatible =3D "x-powers,axp313a", .data =3D (void *)AXP313A_I=
D },
> +       { .compatible =3D "x-powers,axp318w", .data =3D (void *)AXP318_ID=
 },
>         { .compatible =3D "x-powers,axp323", .data =3D (void *)AXP323_ID =
},
>         { .compatible =3D "x-powers,axp717", .data =3D (void *)AXP717_ID =
},
>         { .compatible =3D "x-powers,axp803", .data =3D (void *)AXP803_ID =
},
> @@ -83,6 +84,7 @@ static const struct i2c_device_id axp20x_i2c_id[] =3D {
>         { "axp221" },
>         { "axp223" },
>         { "axp313a" },
> +       { "axp318w" },
>         { "axp717" },
>         { "axp803" },
>         { "axp806" },
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index c5f0ebae327f5..be9c59e3de071 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -42,6 +42,7 @@ static const char * const axp20x_model_names[] =3D {
>         [AXP223_ID] =3D "AXP223",
>         [AXP288_ID] =3D "AXP288",
>         [AXP313A_ID] =3D "AXP313a",
> +       [AXP318_ID] =3D "AXP318W",
>         [AXP323_ID] =3D "AXP323",
>         [AXP717_ID] =3D "AXP717",
>         [AXP803_ID] =3D "AXP803",
> @@ -218,6 +219,31 @@ static const struct regmap_access_table axp313a_vola=
tile_table =3D {
>         .n_yes_ranges =3D ARRAY_SIZE(axp313a_volatile_ranges),
>  };
>
> +static const struct regmap_range axp318_writeable_ranges[] =3D {
> +       regmap_reg_range(AXP318_DCDC_OUTPUT_CONTROL1, AXP318_IRQ_STATE4),
> +       regmap_reg_range(AXP318_SHUTDOWN_CTRL, AXP318_TEMP_ADC_H_EN),
> +       regmap_reg_range(AXP318_DIE_TEMP_ADC_H_EN, AXP318_DIE_TEMP_ADC_H_=
EN),
> +       regmap_reg_range(AXP318_GPADC_H_EN, AXP318_GPADC_H_EN),
> +       regmap_reg_range(AXP318_GPIO_CTRL, AXP318_WDOG_CTRL),
> +};
> +
> +static const struct regmap_range axp318_volatile_ranges[] =3D {
> +       regmap_reg_range(AXP318_IRQ_EN1, AXP318_IRQ_STATE4),
> +       regmap_reg_range(AXP318_POWER_REASON, AXP318_SHUTDOWN_REASON),
> +       regmap_reg_range(AXP318_TEMP_ADC_H_EN, AXP318_GPADC_L),
> +       regmap_reg_range(AXP318_GPIO_INPUT, AXP318_GPIO_INPUT),
> +};
> +
> +static const struct regmap_access_table axp318_writeable_table =3D {
> +       .yes_ranges =3D axp318_writeable_ranges,
> +       .n_yes_ranges =3D ARRAY_SIZE(axp318_writeable_ranges),
> +};

I'd probably add a .no_ranges for both readable and writeable tables
for the various holes in the register range:

  - 0x00 ~ 0x03
  - 0x08 ~ 0x0f
  - 0x1c
  - 0x44 ~ 0x47
  - 0x4c ~ 0x4f
  - 0x58 ~ 0x5c
  - 0x5e ~ 0x5f
  - 0x61 ~ 0x64
  - 0x6b ~ 0x6f

> +
> +static const struct regmap_access_table axp318_volatile_table =3D {
> +       .yes_ranges =3D axp318_volatile_ranges,
> +       .n_yes_ranges =3D ARRAY_SIZE(axp318_volatile_ranges),
> +};
> +
>  static const struct regmap_range axp717_writeable_ranges[] =3D {
>         regmap_reg_range(AXP717_PMU_FAULT, AXP717_MODULE_EN_CONTROL_1),
>         regmap_reg_range(AXP717_MIN_SYS_V_CONTROL, AXP717_BOOST_CONTROL),
> @@ -365,6 +391,11 @@ static const struct resource axp313a_pek_resources[]=
 =3D {
>         DEFINE_RES_IRQ_NAMED(AXP313A_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
>  };
>
> +static const struct resource axp318_pek_resources[] =3D {
> +       DEFINE_RES_IRQ_NAMED(AXP318_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
> +       DEFINE_RES_IRQ_NAMED(AXP318_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
> +};
> +
>  static const struct resource axp717_pek_resources[] =3D {
>         DEFINE_RES_IRQ_NAMED(AXP717_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
>         DEFINE_RES_IRQ_NAMED(AXP717_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
> @@ -444,6 +475,15 @@ static const struct regmap_config axp313a_regmap_con=
fig =3D {
>         .cache_type =3D REGCACHE_MAPLE,
>  };
>
> +static const struct regmap_config axp318_regmap_config =3D {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 8,
> +       .wr_table =3D &axp318_writeable_table,
> +       .volatile_table =3D &axp318_volatile_table,
> +       .max_register =3D AXP318_WDOG_CTRL,
> +       .cache_type =3D REGCACHE_MAPLE,
> +};
> +
>  static const struct regmap_config axp323_regmap_config =3D {
>         .reg_bits =3D 8,
>         .val_bits =3D 8,
> @@ -660,6 +700,28 @@ static const struct regmap_irq axp313a_regmap_irqs[]=
 =3D {
>         INIT_REGMAP_IRQ(AXP313A, DIE_TEMP_HIGH,         0, 0),
>  };
>
> +static const struct regmap_irq axp318_regmap_irqs[] =3D {
> +       INIT_REGMAP_IRQ(AXP318, DCDC8_V_LOW,            0, 7),
> +       INIT_REGMAP_IRQ(AXP318, DCDC7_V_LOW,            0, 6),
> +       INIT_REGMAP_IRQ(AXP318, DCDC6_V_LOW,            0, 5),
> +       INIT_REGMAP_IRQ(AXP318, DCDC5_V_LOW,            0, 4),
> +       INIT_REGMAP_IRQ(AXP318, DCDC4_V_LOW,            0, 3),
> +       INIT_REGMAP_IRQ(AXP318, DCDC3_V_LOW,            0, 2),
> +       INIT_REGMAP_IRQ(AXP318, DCDC2_V_LOW,            0, 1),
> +       INIT_REGMAP_IRQ(AXP318, DCDC1_V_LOW,            0, 0),
> +       INIT_REGMAP_IRQ(AXP318, PEK_RIS_EDGE,           1, 6),
> +       INIT_REGMAP_IRQ(AXP318, PEK_FAL_EDGE,           1, 5),
> +       INIT_REGMAP_IRQ(AXP318, PEK_LONG,               1, 4),
> +       INIT_REGMAP_IRQ(AXP318, PEK_SHORT,              1, 3),

The datasheet I have (0.1 draft in Chinese) says bit 3 is long press
and bit 4 is short press.


> +       INIT_REGMAP_IRQ(AXP318, DIE_TEMP_HIGH_LV2,      1, 2),
> +       INIT_REGMAP_IRQ(AXP318, DIE_TEMP_HIGH_LV1,      1, 1),
> +       INIT_REGMAP_IRQ(AXP318, DCDC9_V_LOW,            1, 0),
> +       INIT_REGMAP_IRQ(AXP318, GPIO3_INPUT,            2, 6),
> +       INIT_REGMAP_IRQ(AXP318, GPIO2_INPUT,            2, 5),
> +       INIT_REGMAP_IRQ(AXP318, GPIO1_INPUT,            2, 4),
> +       INIT_REGMAP_IRQ(AXP318, WDOG_EXPIRE,            3, 0),
> +};
> +
>  static const struct regmap_irq axp717_regmap_irqs[] =3D {
>         INIT_REGMAP_IRQ(AXP717, SOC_DROP_LVL2,          0, 7),
>         INIT_REGMAP_IRQ(AXP717, SOC_DROP_LVL1,          0, 6),
> @@ -881,6 +943,17 @@ static const struct regmap_irq_chip axp313a_regmap_i=
rq_chip =3D {
>         .num_regs               =3D 1,
>  };
>
> +static const struct regmap_irq_chip axp318_regmap_irq_chip =3D {
> +       .name                   =3D "axp318w_irq_chip",
> +       .status_base            =3D AXP318_IRQ_STATE1,
> +       .ack_base               =3D AXP318_IRQ_STATE1,
> +       .unmask_base            =3D AXP318_IRQ_EN1,
> +       .init_ack_masked        =3D true,
> +       .irqs                   =3D axp318_regmap_irqs,
> +       .num_irqs               =3D ARRAY_SIZE(axp318_regmap_irqs),
> +       .num_regs               =3D 4,
> +};
> +
>  static const struct regmap_irq_chip axp717_regmap_irq_chip =3D {
>         .name                   =3D "axp717_irq_chip",
>         .status_base            =3D AXP717_IRQ0_STATE,
> @@ -1058,6 +1131,11 @@ static struct mfd_cell axp313a_cells[] =3D {
>         MFD_CELL_RES("axp313a-pek", axp313a_pek_resources),
>  };
>
> +static struct mfd_cell axp318_cells[] =3D {
> +       MFD_CELL_BASIC("axp20x-regulator", NULL, NULL, 0, 1),
> +       MFD_CELL_RES("axp318w-pek", axp318_pek_resources),
> +};
> +
>  static struct mfd_cell axp717_cells[] =3D {
>         MFD_CELL_NAME("axp20x-regulator"),
>         MFD_CELL_RES("axp20x-pek", axp717_pek_resources),
> @@ -1310,6 +1388,12 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
>                 axp20x->regmap_cfg =3D &axp313a_regmap_config;
>                 axp20x->regmap_irq_chip =3D &axp313a_regmap_irq_chip;
>                 break;
> +       case AXP318_ID:
> +               axp20x->nr_cells =3D ARRAY_SIZE(axp318_cells);
> +               axp20x->cells =3D axp318_cells;
> +               axp20x->regmap_cfg =3D &axp318_regmap_config;
> +               axp20x->regmap_irq_chip =3D &axp318_regmap_irq_chip;
> +               break;
>         case AXP323_ID:
>                 axp20x->nr_cells =3D ARRAY_SIZE(axp313a_cells);
>                 axp20x->cells =3D axp313a_cells;
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 3c5aecf1d4b5b..a871789f6cfa9 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -19,6 +19,7 @@ enum axp20x_variants {
>         AXP223_ID,
>         AXP288_ID,
>         AXP313A_ID,
> +       AXP318_ID,
>         AXP323_ID,
>         AXP717_ID,
>         AXP803_ID,
> @@ -116,6 +117,69 @@ enum axp20x_variants {
>  #define AXP313A_IRQ_STATE              0x21
>  #define AXP323_DCDC_MODE_CTRL2         0x22
>

registers 0x04 ~ 0x07 are data registers. Shall we use them for NVMEM?

> +#define AXP318_DCDC_OUTPUT_CONTROL1    0x10
> +#define AXP318_DCDC_OUTPUT_CONTROL2    0x11
> +#define AXP318_DCDC1_CONTROL           0x12
> +#define AXP318_DCDC2_CONTROL           0x13
> +#define AXP318_DCDC3_CONTROL           0x14
> +#define AXP318_DCDC4_CONTROL           0x15
> +#define AXP318_DCDC5_CONTROL           0x16
> +#define AXP318_DCDC6_CONTROL           0x17
> +#define AXP318_DCDC7_CONTROL           0x18
> +#define AXP318_DCDC8_CONTROL           0x19
> +#define AXP318_DCDC9_CONTROL           0x1a

0x1b and 0x1d control DCDC modes. Or are you leaving out registers that
aren't used?

> +#define AXP318_LDO_OUTPUT_CONTROL1     0x20
> +#define AXP318_LDO_OUTPUT_CONTROL2     0x21
> +#define AXP318_LDO_OUTPUT_CONTROL3     0x22
> +#define AXP318_LDO_OUTPUT_CONTROL4     0x23
> +#define AXP318_ALDO1_CONTROL           0x24
> +#define AXP318_ALDO2_CONTROL           0x25
> +#define AXP318_ALDO3_CONTROL           0x26
> +#define AXP318_ALDO4_CONTROL           0x27
> +#define AXP318_ALDO5_CONTROL           0x28
> +#define AXP318_ALDO6_CONTROL           0x29
> +#define AXP318_BLDO1_CONTROL           0x2a
> +#define AXP318_BLDO2_CONTROL           0x2b
> +#define AXP318_BLDO3_CONTROL           0x2c
> +#define AXP318_BLDO4_CONTROL           0x2d
> +#define AXP318_BLDO5_CONTROL           0x2e
> +#define AXP318_CLDO1_CONTROL           0x2f
> +#define AXP318_CLDO2_CONTROL           0x30
> +#define AXP318_CLDO3_CONTROL           0x31
> +#define AXP318_CLDO4_CONTROL           0x32
> +#define AXP318_CLDO5_CONTROL           0x33
> +#define AXP318_DLDO1_CONTROL           0x34
> +#define AXP318_DLDO2_CONTROL           0x35
> +#define AXP318_DLDO3_CONTROL           0x36
> +#define AXP318_DLDO4_CONTROL           0x37
> +#define AXP318_DLDO5_CONTROL           0x38
> +#define AXP318_DLDO6_CONTROL           0x39
> +#define AXP318_ELDO1_CONTROL           0x3a
> +#define AXP318_ELDO2_CONTROL           0x3b
> +#define AXP318_ELDO3_CONTROL           0x3c
> +#define AXP318_ELDO4_CONTROL           0x3d
> +#define AXP318_ELDO5_CONTROL           0x3e
> +#define AXP318_ELDO6_CONTROL           0x3f
> +#define AXP318_IRQ_EN1                 0x40
> +#define AXP318_IRQ_EN2                 0x41
> +#define AXP318_IRQ_EN3                 0x42
> +#define AXP318_IRQ_EN4                 0x43
> +#define AXP318_IRQ_STATE1              0x48
> +#define AXP318_IRQ_STATE2              0x49
> +#define AXP318_IRQ_STATE3              0x4a
> +#define AXP318_IRQ_STATE4              0x4b
> +#define AXP318_POWER_REASON            0x50
> +#define AXP318_SHUTDOWN_REASON         0x51
> +#define AXP318_SHUTDOWN_CTRL           0x52
> +#define AXP318_TEMP_ADC_H_EN           0x65
> +#define AXP318_TEMP_ADC_L              0x66
> +#define AXP318_DIE_TEMP_ADC_H_EN       0x67
> +#define AXP318_GPADC_H_EN              0x69
> +#define AXP318_GPADC_L                 0x6a
> +#define AXP318_GPIO_CTRL               0x70
> +#define AXP318_GPIO_INPUT              0x71
> +#define AXP318_WDOG_CTRL               0x77
> +
>  #define AXP717_ON_INDICATE             0x00
>  #define AXP717_PMU_STATUS_2            0x01
>  #define AXP717_BC_DETECT               0x05
> @@ -816,6 +880,28 @@ enum axp313a_irqs {
>         AXP313A_IRQ_PEK_RIS_EDGE,
>  };
>
> +enum axp318_irqs {
> +       AXP318_IRQ_DCDC1_V_LOW,
> +       AXP318_IRQ_DCDC2_V_LOW,
> +       AXP318_IRQ_DCDC3_V_LOW,
> +       AXP318_IRQ_DCDC4_V_LOW,
> +       AXP318_IRQ_DCDC5_V_LOW,
> +       AXP318_IRQ_DCDC6_V_LOW,
> +       AXP318_IRQ_DCDC7_V_LOW,
> +       AXP318_IRQ_DCDC8_V_LOW,
> +       AXP318_IRQ_DCDC9_V_LOW,
> +       AXP318_IRQ_DIE_TEMP_HIGH_LV1,
> +       AXP318_IRQ_DIE_TEMP_HIGH_LV2,

> +       AXP318_IRQ_PEK_SHORT,
> +       AXP318_IRQ_PEK_LONG,

The datasheet I have (0.1 draft in Chinese) says long press comes before
short press.

> +       AXP318_IRQ_PEK_FAL_EDGE,
> +       AXP318_IRQ_PEK_RIS_EDGE,
> +       AXP318_IRQ_GPIO1_INPUT =3D 20,

AFAICT the interrupt numbers don't have to align with the bit offsets,
even though we've been doing it for past models.

ChenYu

> +       AXP318_IRQ_GPIO2_INPUT,
> +       AXP318_IRQ_GPIO3_INPUT,
> +       AXP318_IRQ_WDOG_EXPIRE =3D 24,
> +};
> +
>  enum axp717_irqs {
>         AXP717_IRQ_VBUS_FAULT,
>         AXP717_IRQ_VBUS_OVER_V,
> --
> 2.25.1
>


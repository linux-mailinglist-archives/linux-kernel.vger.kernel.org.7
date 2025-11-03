Return-Path: <linux-kernel+bounces-883348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13419C2D20A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D49854E2694
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DF8315D2D;
	Mon,  3 Nov 2025 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utaKonUx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA294314B7F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187318; cv=none; b=Rats9yqbti4wXi9M77whQtbxGwzzCioy8YXLwC7FI8+9sX3ZpeIbMJ1GMHVYGe4+onyeXb0eKSdXzDkrabcFjdCqiDtWKpYuNN+fqtivF6YQALxsqfe9cxQMAegepzUbhDIUYJzipZ+LQd7pFUwreDKj8C9wqo2fJFYD6Ahf6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187318; c=relaxed/simple;
	bh=kDQK0tWCaUtfY/gG/35h4LlsYBz6zej1PGAS1i3xiWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnXSfnrrDNIriWWZPKP2+XSV63al8JxDTZreLlPzmslX1MNX42PHfP/R57p3jW/NWuZ85uqVz45DwvrrkjsPwUu9GaaQzTypLMgaNqq6TkbT6XwHOP3WRSQPzAJRrRtmWh647PH+VkQgH96JzgHgsFtt4im7L9gRnqALJEWRHsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utaKonUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94293C116C6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762187317;
	bh=kDQK0tWCaUtfY/gG/35h4LlsYBz6zej1PGAS1i3xiWo=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=utaKonUxy/85t1kOpEY0ubm+fmvIXgKGDwwaAXdF2j5c7g2Rvn3Fe6P1PJrNLg0Ph
	 BCkNh6LZC5eGCsRdh+5J47Ge8WRAVJJ3Yl4geurR3jygwGygrQBDY/t4YzXunj6y8h
	 tgCnOf3T3QESGFbCFZTqDH4+XwSYdMp+oAkA4QUybwrsX5KlvpeuJmpycLlmhmfLU5
	 ZyAqhH/dGJf8nCj6KDfbxJ/9vGd+Nop7OTLzC8nH+hLW3P6VYRTFzNQRiiitWZttCE
	 AfolvP2eO3QxqJQ3eiRYTPI71LIZmgaIT090MtX+c0JLSUTVeY4MkSPXnb1BP2tCt1
	 /3lGJF15i+3yg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-378e8d10494so48292281fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:28:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+Pf3vu0c9U2z1XNygK8TR9HfiDHIORdx0jvj0wtcQFflMAL0cO7+t2DmJov3ZVqi5XiWV2RWcIoyQklw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Yf6jqPq44Fuf22h2zGNM1NLxjwbeWU82DE1qWsQUji7yXkzV
	ZLhGCcnMU3CqcyR6vV9GPQBd0NsKcL35NHXwtRZCKdaIYiQ2X+JV6kF0yaUsSfugl1zqyrGoagH
	adDClwuDRZ+NGSNOGlL1Ak+nsZ+89gTs=
X-Google-Smtp-Source: AGHT+IEJw3ZDPZnMpT7G5gC3dsRUQ0QBWfYVrDtBIFys4f9z3gARwYMbMmV/c59TFAss1io4XgNidT6RU3Za8tDoZwE=
X-Received: by 2002:a05:651c:198d:b0:37a:29b5:e62c with SMTP id
 38308e7fff4ca-37a29b5ea04mr22389251fa.5.1762187315858; Mon, 03 Nov 2025
 08:28:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021112013.2710903-1-andre.przywara@arm.com>
 <20251021112013.2710903-4-andre.przywara@arm.com> <20251022001420-GYA1522542@gentoo.org>
In-Reply-To: <20251022001420-GYA1522542@gentoo.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Nov 2025 00:28:22 +0800
X-Gmail-Original-Message-ID: <CAGb2v66_KdBqcN95mUNRfc99XQpCtzFS95ZbQHf+23fz=KS3Fw@mail.gmail.com>
X-Gm-Features: AWmQ_blX9ENYCANsCL_UZyz3OhgNWAwqItq2RjR0rojS-yYywilcuTafker68VU
Message-ID: <CAGb2v66_KdBqcN95mUNRfc99XQpCtzFS95ZbQHf+23fz=KS3Fw@mail.gmail.com>
Subject: Re: [PATCH 3/3] regulator: axp20x: add support for the AXP318W
To: Yixun Lan <dlan@gentoo.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Lee Jones <lee@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 8:14=E2=80=AFAM Yixun Lan <dlan@gentoo.org> wrote:
>
> Hi Andre,
>
> On 12:20 Tue 21 Oct     , Andre Przywara wrote:
> > The X-Powers AXP318W is a typical PMIC from X-Powers, featuring nine
> > DC/DC converters and 28 LDOs, on the regulator side.
> >
> > Describe the chip's voltage settings and switch registers, how the
> > voltages are encoded, and connect this to the MFD device via its
> > regulator ID.
> > We use just "318" for the internal identifiers, for easier typing and
> > less churn. If something else other than the "AXP318W" shows up, that's
> > an easy change, externally visible strings carry the additional letter
> > already.
> >
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  drivers/regulator/axp20x-regulator.c | 170 ++++++++++++++++++++++++++-
> >  include/linux/mfd/axp20x.h           |  43 +++++++
> >  2 files changed, 211 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/a=
xp20x-regulator.c
> > index da891415efc0b..1576bf4178f8f 100644
> > --- a/drivers/regulator/axp20x-regulator.c
> > +++ b/drivers/regulator/axp20x-regulator.c
> > @@ -138,6 +138,15 @@
> >  #define AXP313A_DCDC_V_OUT_MASK              GENMASK(6, 0)
> >  #define AXP313A_LDO_V_OUT_MASK               GENMASK(4, 0)
> >
> > +#define AXP318_DCDC1_V_OUT_MASK              GENMASK(4, 0)
> > +#define AXP318_DCDC2_V_OUT_MASK              GENMASK(6, 0)
> > +#define AXP318_LDO_V_OUT_MASK                GENMASK(4, 0)
> > +#define AXP318_ELDO_V_OUT_MASK               GENMASK(5, 0)
> > +#define AXP318_DCDC2_NUM_VOLTAGES    88
> > +#define AXP318_DCDC6_NUM_VOLTAGES    128
> > +#define AXP318_DCDC7_NUM_VOLTAGES    103
> > +#define AXP318_DCDC8_NUM_VOLTAGES    119
> > +
> >  #define AXP717_DCDC1_NUM_VOLTAGES    88
> >  #define AXP717_DCDC2_NUM_VOLTAGES    107
> >  #define AXP717_DCDC3_NUM_VOLTAGES    103
> > @@ -765,6 +774,155 @@ static const struct regulator_desc axp313a_regula=
tors[] =3D {
> >       AXP_DESC_FIXED(AXP313A, RTC_LDO, "rtc-ldo", "vin1", 1800),
> >  };
> >
> > +static const struct linear_range axp318_dcdc2_ranges[] =3D {
> > +     REGULATOR_LINEAR_RANGE(500000,   0, 70, 10000),
> > +     REGULATOR_LINEAR_RANGE(1220000, 71, 87, 20000),
> > +};
> > +
> ..
> > +static const struct linear_range axp318_dcdc6_ranges[] =3D {
> > +     REGULATOR_LINEAR_RANGE(500000,    0,  70,  10000),
> > +     REGULATOR_LINEAR_RANGE(1220000,  71,  87,  20000),
> > +     REGULATOR_LINEAR_RANGE(1800000,  88, 118,  20000),
> > +     REGULATOR_LINEAR_RANGE(2440000, 119, 127,  40000),
> > +};
> > +
> > +static const struct linear_range axp318_dcdc7_ranges[] =3D {
> > +     REGULATOR_LINEAR_RANGE(500000,   0,  70, 10000),
> > +     REGULATOR_LINEAR_RANGE(1220000, 71, 102, 20000),
> > +};
> > +
> > +static const struct linear_range axp318_dcdc8_ranges[] =3D {
> > +     REGULATOR_LINEAR_RANGE(500000,    0,  70,  10000),
> > +     REGULATOR_LINEAR_RANGE(1220000,  71, 102,  20000),
> > +     REGULATOR_LINEAR_RANGE(1900000, 103, 118, 100000),
> > +};
>
> In the AXP318W datasheet, it says:
> section 7.1 DCDC/LCO desgin
>  8. DCDC6/7/8/9 only able to tune at two voltage ranges which are
>  <1.54v and >1.54v, the tuning voltage should not step cross 1.54v
>  (I translate the original doc into english)
>
> so, with this restricition, should we split the range into two?
> one is dcdc6_lo_range, another dcdc6_hi_range
>
> or what do you think?

I understand it like this:

DCDC2~9 support DVM or dynamic voltage scaling management. Not sure
what the actual thing is, but it at least it provides controlled
ramp rate. So the change of the voltage while the regulator is on
shall not cross the 1.54v boundary; however it is fine to set any
voltage when the regulator is off.

Maybe without DVM the voltage would just jump over and even potentially
overshoot. We would need an oscilloscope to check the actual behavior
though.

So perhaps it would be better to enable DVM by default for all capable
ones, and model in the ramp delay as well? Andre?

As for not crossing 1.54v, I think you can just wrap the current
.set_voltage helper with a check that fails when the regulator is
on and it is crossing?

> > +
> > +static const struct regulator_desc axp318_regulators[] =3D {
> > +     AXP_DESC(AXP318, DCDC1, "dcdc1", "vin19", 1000, 3400, 100,
> > +              AXP318_DCDC1_CONTROL, AXP318_DCDC1_V_OUT_MASK,
> > +              AXP318_DCDC_OUTPUT_CONTROL1, BIT(0)),
> > +     AXP_DESC_RANGES(AXP318, DCDC2, "dcdc2", "vin23",
> > +                     axp318_dcdc2_ranges, AXP318_DCDC2_NUM_VOLTAGES,
> > +                     AXP318_DCDC2_CONTROL, AXP318_DCDC2_V_OUT_MASK,
> > +                     AXP318_DCDC_OUTPUT_CONTROL1, BIT(1)),
> > +     AXP_DESC_RANGES(AXP318, DCDC3, "dcdc3", "vin23",
> > +                     axp318_dcdc2_ranges, AXP318_DCDC2_NUM_VOLTAGES,
> > +                     AXP318_DCDC3_CONTROL, AXP318_DCDC2_V_OUT_MASK,
> > +                     AXP318_DCDC_OUTPUT_CONTROL1, BIT(2)),
> > +     AXP_DESC_RANGES(AXP318, DCDC4, "dcdc4", "vin45",
> > +                     axp318_dcdc2_ranges, AXP318_DCDC2_NUM_VOLTAGES,
> > +                     AXP318_DCDC4_CONTROL, AXP318_DCDC2_V_OUT_MASK,
> > +                     AXP318_DCDC_OUTPUT_CONTROL1, BIT(3)),
> > +     AXP_DESC_RANGES(AXP318, DCDC5, "dcdc5", "vin45",
> > +                     axp318_dcdc2_ranges, AXP318_DCDC2_NUM_VOLTAGES,
> > +                     AXP318_DCDC5_CONTROL, AXP318_DCDC2_V_OUT_MASK,
> > +                     AXP318_DCDC_OUTPUT_CONTROL1, BIT(4)),
> > +     AXP_DESC_RANGES(AXP318, DCDC6, "dcdc6", "vin678",
> > +                     axp318_dcdc6_ranges, AXP318_DCDC6_NUM_VOLTAGES,
> > +                     AXP318_DCDC6_CONTROL, AXP318_DCDC2_V_OUT_MASK,
> > +                     AXP318_DCDC_OUTPUT_CONTROL1, BIT(5)),
> > +     AXP_DESC_RANGES(AXP318, DCDC7, "dcdc7", "vin678",
> > +                     axp318_dcdc7_ranges, AXP318_DCDC7_NUM_VOLTAGES,
> > +                     AXP318_DCDC7_CONTROL, AXP318_DCDC2_V_OUT_MASK,
> > +                     AXP318_DCDC_OUTPUT_CONTROL1, BIT(6)),
> > +     AXP_DESC_RANGES(AXP318, DCDC8, "dcdc8", "vin678",
> > +                     axp318_dcdc8_ranges, AXP318_DCDC8_NUM_VOLTAGES,
> > +                     AXP318_DCDC8_CONTROL, AXP318_DCDC2_V_OUT_MASK,
> > +                     AXP318_DCDC_OUTPUT_CONTROL1, BIT(7)),
> > +     AXP_DESC_RANGES(AXP318, DCDC9, "dcdc9", "vin19",
> > +                     axp318_dcdc8_ranges, AXP318_DCDC8_NUM_VOLTAGES,
> > +                     AXP318_DCDC9_CONTROL, AXP318_DCDC2_V_OUT_MASK,
> > +                     AXP318_DCDC_OUTPUT_CONTROL2, BIT(0)),
> > +     AXP_DESC_SW(AXP318, SWOUT1, "swout1", NULL,
> > +                 AXP318_DCDC_OUTPUT_CONTROL2, BIT(3)),
> > +     AXP_DESC_SW(AXP318, SWOUT2, "swout2", NULL,
> > +                 AXP318_DCDC_OUTPUT_CONTROL2, BIT(4)),
> > +     AXP_DESC(AXP318, ALDO1, "aldo1", "aldo156in", 500, 3400, 100,
> > +              AXP318_ALDO1_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL1, BIT(0)),
> > +     AXP_DESC(AXP318, ALDO2, "aldo2", "aldo234in", 500, 3400, 100,
> > +              AXP318_ALDO2_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL1, BIT(1)),
> > +     AXP_DESC(AXP318, ALDO3, "aldo3", "aldo234in", 500, 3400, 100,
> > +              AXP318_ALDO3_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL1, BIT(2)),
> > +     AXP_DESC(AXP318, ALDO4, "aldo4", "aldo234in", 500, 3400, 100,
> > +              AXP318_ALDO4_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL1, BIT(3)),
> > +     AXP_DESC(AXP318, ALDO5, "aldo5", "aldo156in", 500, 3400, 100,
> > +              AXP318_ALDO5_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL1, BIT(4)),
> > +     AXP_DESC(AXP318, ALDO6, "aldo6", "aldo156in", 500, 3400, 100,
> > +              AXP318_ALDO6_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL1, BIT(5)),
> > +     AXP_DESC(AXP318, BLDO1, "bldo1", "bldoin", 500, 3400, 100,
> > +              AXP318_BLDO1_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL1, BIT(6)),
> > +     AXP_DESC(AXP318, BLDO2, "bldo2", "bldoin", 500, 3400, 100,
> > +              AXP318_BLDO2_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL1, BIT(7)),
> > +     AXP_DESC(AXP318, BLDO3, "bldo3", "bldoin", 500, 3400, 100,
> > +              AXP318_BLDO3_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL2, BIT(0)),
> > +     AXP_DESC(AXP318, BLDO4, "bldo4", "bldoin", 500, 3400, 100,
> > +              AXP318_BLDO4_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL2, BIT(1)),
> > +     AXP_DESC(AXP318, BLDO5, "bldo5", "bldoin", 500, 3400, 100,
> > +              AXP318_BLDO5_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL2, BIT(2)),
> > +     AXP_DESC(AXP318, CLDO1, "cldo1", "cldoin", 500, 3400, 100,
> > +              AXP318_CLDO1_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL2, BIT(3)),
> > +     AXP_DESC(AXP318, CLDO2, "cldo2", "cldoin", 500, 3400, 100,
> > +              AXP318_CLDO2_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL2, BIT(4)),
> > +     AXP_DESC(AXP318, CLDO3, "cldo3", "cldoin", 500, 3400, 100,
> > +              AXP318_CLDO3_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL2, BIT(5)),
> > +     AXP_DESC(AXP318, CLDO4, "cldo4", "cldoin", 500, 3400, 100,
> > +              AXP318_CLDO4_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL2, BIT(6)),
> > +     AXP_DESC(AXP318, CLDO5, "cldo5", "cldoin", 500, 3400, 100,
> > +              AXP318_CLDO5_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL2, BIT(7)),
> > +     AXP_DESC(AXP318, DLDO1, "dldo1", "dldoin", 500, 3400, 100,
> > +              AXP318_DLDO1_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL3, BIT(0)),
> > +     AXP_DESC(AXP318, DLDO2, "dldo2", "dldoin", 500, 3400, 100,
> > +              AXP318_DLDO2_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL3, BIT(1)),
> > +     AXP_DESC(AXP318, DLDO3, "dldo3", "dldoin", 500, 3400, 100,
> > +              AXP318_DLDO3_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL3, BIT(2)),
> > +     AXP_DESC(AXP318, DLDO4, "dldo4", "dldoin", 500, 3400, 100,
> > +              AXP318_DLDO4_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL3, BIT(3)),
> > +     AXP_DESC(AXP318, DLDO5, "dldo5", "dldoin", 500, 3400, 100,
> > +              AXP318_DLDO5_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL3, BIT(4)),
> > +     AXP_DESC(AXP318, DLDO6, "dldo6", "dldoin", 500, 3400, 100,
> > +              AXP318_DLDO6_CONTROL, AXP318_LDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL3, BIT(5)),
> ..
> > +     AXP_DESC(AXP318, ELDO1, "eldo1", "eldoin", 500, 1500, 25,
> > +              AXP318_ELDO1_CONTROL, AXP318_ELDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL3, BIT(6)),
> > +     AXP_DESC(AXP318, ELDO2, "eldo2", "eldoin", 500, 1500, 25,
> > +              AXP318_ELDO2_CONTROL, AXP318_ELDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL3, BIT(7)),
> > +     AXP_DESC(AXP318, ELDO3, "eldo3", "eldoin", 500, 1500, 25,
> > +              AXP318_ELDO3_CONTROL, AXP318_ELDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL4, BIT(0)),
> > +     AXP_DESC(AXP318, ELDO4, "eldo4", "eldoin", 500, 1500, 25,
> > +              AXP318_ELDO4_CONTROL, AXP318_ELDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL4, BIT(1)),
> > +     AXP_DESC(AXP318, ELDO5, "eldo5", "eldoin", 500, 1500, 25,
> > +              AXP318_ELDO5_CONTROL, AXP318_ELDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL4, BIT(2)),
> > +     AXP_DESC(AXP318, ELDO6, "eldo6", "eldoin", 500, 1500, 25,
> > +              AXP318_ELDO6_CONTROL, AXP318_ELDO_V_OUT_MASK,
> > +              AXP318_LDO_OUTPUT_CONTROL4, BIT(3)),
>
> also, in section 7.1 DCDC/LCO desgin
>  3. ELDOIN can use DCDC's output as the voltage input, once in this case,
>  the LDO (output?) config voltage should lower than DCDC input voltage.
>
> Note: ELDOIN can use PS(Power Supply, should be equal to DCIN) or DCDC as=
 input
>
> in case of Radxa A7A (A733) board, it use DCDC9 as ELDOIN,
> Should we do something in the driver level? or leave up to user

That's up to the designer. They should be aware of any restrictions.
Like, it doesn't make sense to set a voltage higher than the supply
for an LDO...

There's two options here. First, a wrapper for the .set_voltage callback
(again) that checks the requested voltage against the supply voltage,
and returns something like -EINVAL if that check fails.

Second, we could set the .min_dropout_uV field. That would make the core
try to raise the supply voltage to satisfy the minimum dropout voltage
constraint.

Both require knowing the actual minimum dropout value, which doesn't seem
to be provided in the datasheet.


ChenYu


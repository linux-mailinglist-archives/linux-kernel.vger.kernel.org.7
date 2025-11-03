Return-Path: <linux-kernel+bounces-883461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45161C2D83C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCB1422BEF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A7D31B81B;
	Mon,  3 Nov 2025 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNXd2oOy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20141314D20
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762191650; cv=none; b=Wv9/0sN6v5lveuqclE2Z/ST0LoUGrhbLVt4vOgBoFltiquSnrOEYmrYELFapjoWL/hebkPiXN2CR/W1CKtu35eOnpRLyHkj7WRf4eNqxXDNfHzwXDnlz0XPH2BRRb2mI84xR9Mwk/QNpPFcOWibSzKcd0ukorvqDECm9M1Goge4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762191650; c=relaxed/simple;
	bh=bAC+I9yHYiPTep/W58Jpx44UyXtlzHsX0xnfav+6hxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5BECdG4RfTcaPGTORfRj/EUdHXcaZgsqYue0xHRAa5Zfr1i8LUPRJoVETZaqPj68JXrXOaE9LvLm7LMaqWrLl4mWxxMhXKV7u12uIOO8Z2c2ysfQQpvaKyZFWJEdgH3TDsVEgtzWEPa0KCAdJt0hEftn6QsqTumdubw6UvzjK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNXd2oOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA91AC4AF0B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762191649;
	bh=bAC+I9yHYiPTep/W58Jpx44UyXtlzHsX0xnfav+6hxE=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=HNXd2oOyPwdxCg9OopUp1c+JGxDgCMJ3EO1V/5/5vF+EopC8BDIY+H1YmxUmu7qSV
	 74Q9zRcbzJzu8aHfYeKP7UPNeYeu6eHw5T9atdj82zwn0froApdCd4ch2au3vEsXpd
	 rj3QxmQKD6lQ1k5wnoZK99V3xu1HTtsBCJzkMEPOk4qGBvgjMDG54W5851vpfieNAw
	 IUJmQ3ZHIq0+WcACoW6rIck/nLuKqcOoDrm5Jp6/lG2ckdVK6ah4DTYiixGCZlSPrF
	 FYwtp1HDOQWoOjEX3servcLNLBt4V5vf1opZbMOYMGoWs3+Rukc08FKftPaC1fU8Ch
	 olHM5YTmqcgMg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-378de7d3057so44327091fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:40:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkxjqKFrAvp/zrx4G9tBpjuj6SKQbPNbHfRUi4zqimpLC96r2oft39vPYB/zL11L9/FpzHK0TjpVtn2y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYJYTuXFiZwIfG0R/innBoyMHi8RZxrr270YRC2vdPGgNGMTDu
	K4AH1ZFB/o/AwF3PbE0PByKDk3hu+w6xAvgN2BQctxxi24F+Sc9xOc7LyyDjwSHyHoZIL4FAKjK
	4iSFXhcvej7LVKXcxLJb9/o0J0PmTTnE=
X-Google-Smtp-Source: AGHT+IEc88SO6nneu3mvccJA8ezZBwOU2YjkaaiL7uhb80v1EC13ZDp7lMH56bUG79DqRoPd94c85myfP2EF56tTjdc=
X-Received: by 2002:a2e:be8a:0:b0:37a:2b71:482e with SMTP id
 38308e7fff4ca-37a2b714a58mr22345201fa.24.1762191648173; Mon, 03 Nov 2025
 09:40:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919000020.16969-1-andre.przywara@arm.com> <20250919000020.16969-3-andre.przywara@arm.com>
In-Reply-To: <20250919000020.16969-3-andre.przywara@arm.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Nov 2025 01:40:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v67v9fXC-11WAy0-VjJVVz3BVtvbBKiEQu1VVBay6RyFTw@mail.gmail.com>
X-Gm-Features: AWmQ_bnG9nI8bojm5LxU6ZA-iDlt8LXyt_CZ5Wum2wbzIMhk62qrTul3kat7W-4
Message-ID: <CAGb2v67v9fXC-11WAy0-VjJVVz3BVtvbBKiEQu1VVBay6RyFTw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] mfd: axp20x: Refactor axp20x_is_polyphase_slave()
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Mikhail Kalashnikov <iuncuim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 8:01=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> Some X-Powers AXP PMICs allow to combine certain DC/DC rails together in
> a multi-phase fashion. So far we don't actively program those
> connections, but we detect the existing setup, and prevent the connected
> regulators from being re-programmed or turned off.

This last part is a bit incorrect. We simply don't register the secondary
phases as separate regulators anymore. The hardware ignores any changes
to their independent configuration (I assume, since otherwise the hardware
would be really hard to program...).


> At the moment this is
> done in a switch/case construct, listing the known regulator pairs for
> those PMICs supported.
>
> To get rid of this ever growing code section, create a data structure
> that describes the relationship, and have generic code that iterates
> over the entries and checks for matches.
>
> This not only cleans that function up and makes extensions much simpler,
> but also allows to reuse this information for the upcoming programming
> of those poly-phase setups.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/regulator/axp20x-regulator.c | 91 ++++++++++++++--------------
>  1 file changed, 45 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp=
20x-regulator.c
> index da891415efc0b..19c9a98d1835a 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -1481,70 +1481,69 @@ static int axp20x_set_dcdc_workmode(struct regula=
tor_dev *rdev, int id, u32 work
>         return regmap_update_bits(rdev->regmap, reg, mask, workmode);
>  }
>
> +struct dualphase_regulator {
> +       int axp_id;
> +       int reg1, reg2;

We don't care about the primary phase. The point is to make the secondary
phases disappear from the kernel's view.

reg1 should be part of the next patch, where you actually care.

> +       unsigned int polyphase_reg;
> +       unsigned int bitmask;
> +} dualphase_regulators[] =3D {
> +       { AXP323_ID, AXP313A_DCDC1, AXP313A_DCDC2,
> +               AXP323_DCDC_MODE_CTRL2, BIT(1), },
> +       { AXP803_ID, AXP803_DCDC2, AXP803_DCDC3, AXP803_POLYPHASE_CTRL,
> +               AXP803_DCDC23_POLYPHASE_DUAL, },
> +       { AXP803_ID, AXP803_DCDC5, AXP803_DCDC6, AXP803_POLYPHASE_CTRL,
> +               AXP803_DCDC56_POLYPHASE_DUAL, },
> +       /* AXP806's DCDC-A/B/C is a tri-phase regulator */

TODO: ?

ChenYu

> +       { AXP806_ID, AXP806_DCDCD, AXP806_DCDCE, AXP806_DCDC_MODE_CTRL2,
> +               AXP806_DCDCDE_POLYPHASE_DUAL, },
> +       { AXP813_ID, AXP803_DCDC2, AXP803_DCDC3, AXP803_POLYPHASE_CTRL,
> +               AXP803_DCDC23_POLYPHASE_DUAL, },
> +       { AXP813_ID, AXP803_DCDC5, AXP803_DCDC6, AXP803_POLYPHASE_CTRL,
> +               AXP803_DCDC56_POLYPHASE_DUAL, },
> +       { AXP15060_ID, AXP15060_DCDC2, AXP15060_DCDC3, AXP15060_DCDC_MODE=
_CTRL1,
> +               AXP15060_DCDC23_POLYPHASE_DUAL_MASK, },
> +       { AXP15060_ID, AXP15060_DCDC4, AXP15060_DCDC6, AXP15060_DCDC_MODE=
_CTRL1,
> +               AXP15060_DCDC46_POLYPHASE_DUAL_MASK, },
> +};
> +
>  /*
>   * This function checks whether a regulator is part of a poly-phase
>   * output setup based on the registers settings. Returns true if it is.
>   */
>  static bool axp20x_is_polyphase_slave(struct axp20x_dev *axp20x, int id)
>  {
> +       struct dualphase_regulator *dpreg;
>         u32 reg =3D 0;
> +       int i;
>
> -       /*
> -        * Currently in our supported AXP variants, only AXP803, AXP806,
> -        * AXP813 and AXP15060 have polyphase regulators.
> -        */
> -       switch (axp20x->variant) {
> -       case AXP803_ID:
> -       case AXP813_ID:
> -               regmap_read(axp20x->regmap, AXP803_POLYPHASE_CTRL, &reg);
> +       for (i =3D 0; i < ARRAY_SIZE(dualphase_regulators); i++) {
> +               dpreg =3D &dualphase_regulators[i];
>
> -               switch (id) {
> -               case AXP803_DCDC3:
> -                       return !!(reg & AXP803_DCDC23_POLYPHASE_DUAL);
> -               case AXP803_DCDC6:
> -                       return !!(reg & AXP803_DCDC56_POLYPHASE_DUAL);
> +               if (axp20x->variant !=3D dpreg->axp_id)
> +                       continue;
> +               /* Is this the second regulator from a dual-phase pair? *=
/
> +               if (id =3D=3D dpreg->reg2) {
> +                       regmap_read(axp20x->regmap, dpreg->polyphase_reg,=
 &reg);
> +
> +                       return !!(reg & dpreg->bitmask);
>                 }
> -               break;
> +       }
>
> -       case AXP806_ID:
> +       /*
> +        * DCDC-A/B/C can be configured either as a dual-phase (A+B) or
> +        * as a triple-phase regulator (A+B+C), but not in any other
> +        * combination. Treat this as a special case here.
> +        */
> +       if (axp20x->variant =3D=3D AXP806_ID) {
>                 regmap_read(axp20x->regmap, AXP806_DCDC_MODE_CTRL2, &reg)=
;
> -
> -               switch (id) {
> -               case AXP806_DCDCB:
> +               if (id =3D=3D AXP806_DCDCB)
>                         return (((reg & AXP806_DCDCABC_POLYPHASE_MASK) =
=3D=3D
>                                 AXP806_DCDCAB_POLYPHASE_DUAL) ||
>                                 ((reg & AXP806_DCDCABC_POLYPHASE_MASK) =
=3D=3D
>                                 AXP806_DCDCABC_POLYPHASE_TRI));
> -               case AXP806_DCDCC:
> +               if (id =3D=3D AXP806_DCDCC)
>                         return ((reg & AXP806_DCDCABC_POLYPHASE_MASK) =3D=
=3D
>                                 AXP806_DCDCABC_POLYPHASE_TRI);
> -               case AXP806_DCDCE:
> -                       return !!(reg & AXP806_DCDCDE_POLYPHASE_DUAL);
> -               }
> -               break;
> -
> -       case AXP15060_ID:
> -               regmap_read(axp20x->regmap, AXP15060_DCDC_MODE_CTRL1, &re=
g);
> -
> -               switch (id) {
> -               case AXP15060_DCDC3:
> -                       return !!(reg & AXP15060_DCDC23_POLYPHASE_DUAL_MA=
SK);
> -               case AXP15060_DCDC6:
> -                       return !!(reg & AXP15060_DCDC46_POLYPHASE_DUAL_MA=
SK);
> -               }
> -               break;
> -
> -       case AXP323_ID:
> -               regmap_read(axp20x->regmap, AXP323_DCDC_MODE_CTRL2, &reg)=
;
> -
> -               switch (id) {
> -               case AXP313A_DCDC2:
> -                       return !!(reg & BIT(1));
> -               }
> -               break;
> -
> -       default:
> -               return false;
>         }
>
>         return false;
> --
> 2.46.4
>


Return-Path: <linux-kernel+bounces-883392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAEDC2D481
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 77D4534B7E1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76613290F;
	Mon,  3 Nov 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8T8z27A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24C23101C2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188906; cv=none; b=q/O+hgnmt4LYUllO60uSN1PZVeuDwPGE/mLEWV4QItgjbaZUdVyvvG6j+qW4+PD/bMaByzWwt95SgE/lboV8/XnmhowLBxI3/meTAXgYUgJzz/kWMI/ra6aSyNiFjWU7Udt68KgWTQHuXJWaPU1rtAmD/eY6PmPh9DOP0EB2k+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188906; c=relaxed/simple;
	bh=FB2fXq8qI+orZjzBe0HcJfqm2snf0R2VlXVim7tZELw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfA1eMzgOKPvfngRWrJ/dmQ5yH42krOKi9uDsvKYT5LJnT2PGYgwlIv6bG/79NF5r88a8CFrtwE72QLoPXkAvQ+WJWj6RNxyDlNZO+77xUhdkTbFP6hphpafgVDKeOpdMmZgh8ELoX6ulG1/WxfphTy/Z993uWawtsjY+/tjO2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8T8z27A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC29DC113D0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188906;
	bh=FB2fXq8qI+orZjzBe0HcJfqm2snf0R2VlXVim7tZELw=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=V8T8z27AnnpKBHtEhbnLDbFPHsZv8GVbqVqel+E7gHixQpbcLsAGvizl0NGG/6Zca
	 6QYROpgCQ/+zudxsE+xz0EbzXO////Q1l6Q8VoeYg0Zwz/0p2LsF0r+0qFF0zLy0tT
	 hURdxC4U/GUEcPZSm7OGpe7j0bO2lIwAT8nD/Fx7zWos68UsxMacU2lpeh1wTmo2wh
	 UH5UUAKvnCnIuXSgsDAS8PUKouAvkxPaMfFCJo0x1jqKqFE0RF5TqT4KkVAcgfxmMH
	 lIFEFOV6U2czbw6qc6pP1XNhS5Ng+uRsacHhwnmaLAxHDPfK4sSAF+H8OKuq2eGUv9
	 DCo31S/MaCWsw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-378cfd75fb0so53630211fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:55:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFLDS2/OAJGmhNPZTZNYT0UFe5cYCHUw+OF277NX35Rugx5ID1sKT4M4Q3LzeEp0nruO03fPbGl7SNW+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZTHIQBFO6M3qeg7lSMeE1Z+C19ISHr40+gHKsyQxDTaByg6d
	ADANyQx7yNB2xBzIQv8LgyO8lptScwejvPDA3eW+mCCQxBYAAA49DA9+IGelS8s0axM8Lu4g6jC
	bgEIqMkI3zLagmV8ReSJ4aIkYXnv+r6o=
X-Google-Smtp-Source: AGHT+IESVT3wAxoqTzkJuv5v/0MWqydt3AjfMt93Ut8gKxHv8FnfFvByHx9A2eJ3N9us2Sxn3tsMRc12U585mB1Rp1E=
X-Received: by 2002:a2e:a542:0:b0:37a:2fa7:53af with SMTP id
 38308e7fff4ca-37a2fa75c90mr19439061fa.40.1762188905042; Mon, 03 Nov 2025
 08:55:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021112013.2710903-1-andre.przywara@arm.com> <20251021112013.2710903-4-andre.przywara@arm.com>
In-Reply-To: <20251021112013.2710903-4-andre.przywara@arm.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Nov 2025 00:54:51 +0800
X-Gmail-Original-Message-ID: <CAGb2v67UFUAKz7tWV1b2YtANBU7a9b4KRb1SOOs=bxM4DBPwPw@mail.gmail.com>
X-Gm-Features: AWmQ_blnI_C9_pjIZuBaEa3hzNHzRXpxHHoK0mpW9iYhv4eDs7c4vEasNevGFmo
Message-ID: <CAGb2v67UFUAKz7tWV1b2YtANBU7a9b4KRb1SOOs=bxM4DBPwPw@mail.gmail.com>
Subject: Re: [PATCH 3/3] regulator: axp20x: add support for the AXP318W
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
> The X-Powers AXP318W is a typical PMIC from X-Powers, featuring nine
> DC/DC converters and 28 LDOs, on the regulator side.
>
> Describe the chip's voltage settings and switch registers, how the
> voltages are encoded, and connect this to the MFD device via its
> regulator ID.
> We use just "318" for the internal identifiers, for easier typing and
> less churn. If something else other than the "AXP318W" shows up, that's
> an easy change, externally visible strings carry the additional letter
> already.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/regulator/axp20x-regulator.c | 170 ++++++++++++++++++++++++++-
>  include/linux/mfd/axp20x.h           |  43 +++++++
>  2 files changed, 211 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp=
20x-regulator.c
> index da891415efc0b..1576bf4178f8f 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -138,6 +138,15 @@
>  #define AXP313A_DCDC_V_OUT_MASK                GENMASK(6, 0)
>  #define AXP313A_LDO_V_OUT_MASK         GENMASK(4, 0)
>
> +#define AXP318_DCDC1_V_OUT_MASK                GENMASK(4, 0)
> +#define AXP318_DCDC2_V_OUT_MASK                GENMASK(6, 0)
> +#define AXP318_LDO_V_OUT_MASK          GENMASK(4, 0)
> +#define AXP318_ELDO_V_OUT_MASK         GENMASK(5, 0)

> +#define AXP318_DCDC2_NUM_VOLTAGES      88
> +#define AXP318_DCDC6_NUM_VOLTAGES      128
> +#define AXP318_DCDC7_NUM_VOLTAGES      103
> +#define AXP318_DCDC8_NUM_VOLTAGES      119

Upon closer inspection of the helper code, these aren't actually needed.
My bad for introducing this unused field in the first place.

[...]

> +       AXP_DESC(AXP318, ELDO4, "eldo4", "eldoin", 500, 1500, 25,
> +                AXP318_ELDO4_CONTROL, AXP318_ELDO_V_OUT_MASK,
> +                AXP318_LDO_OUTPUT_CONTROL4, BIT(1)),
> +       AXP_DESC(AXP318, ELDO5, "eldo5", "eldoin", 500, 1500, 25,
> +                AXP318_ELDO5_CONTROL, AXP318_ELDO_V_OUT_MASK,
> +                AXP318_LDO_OUTPUT_CONTROL4, BIT(2)),

eldo4 and eldo5 support operating in switch mode. We can model that as
a bypass mode control. See the *bypass* fields in regulator_desc and
regulator_set_bypass_regmap() / regulator_get_bypass_regmap().

The rest check out. But also see my other reply regarding the 1.54v
threshold.


Thanks
ChenYu


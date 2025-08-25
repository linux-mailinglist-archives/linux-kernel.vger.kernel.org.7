Return-Path: <linux-kernel+bounces-785109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5DFB34612
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08AF2A368C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CEF2FE058;
	Mon, 25 Aug 2025 15:41:33 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD7C2FB97D;
	Mon, 25 Aug 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136492; cv=none; b=BuvzQNLcis1vvEnBxsp4O2W51rCWKZEMvucufsPlCZBCfj5aBndh3JoNVX0te54jY5J1qmZPioquVvtOQW+ZJSrf+1YyYle8OhlIy5WjzjVXs+1XR36e44N9hagqTgVhgUn4Hiq/xtlRlmw70UROqkrNx/GHQliMf3VVNw8Ney0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136492; c=relaxed/simple;
	bh=iVJ9I3QV2otLbWWjQsCxDOsmCPvi3IMzSx/d+b1GE/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCT2epgcnHqoAOuoQfb6CmL/R5ufIJMffZts+1FmjECaqhrQPoePx2ljp5IsvDwy2hUkKUvC/UgYwkhv3yknvEuW7jOpAgaG75mTjng5yWmyK4BYusxoDM8NBWOjhqhRzZ6lFYZ+Jey7gF1j4gWsppGUjuQB0NvCIz28YmkHFZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3366ce6889bso9846101fa.0;
        Mon, 25 Aug 2025 08:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756136487; x=1756741287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lf0SerB/BddtiPRZt6oTCzK0uyEGO4TRGC1HhfQpBU4=;
        b=J6OCbyqh7fF2JzvRvhvn2cPiQhPKMrOimbHNjYueD5pV4FkzDtCiiPSD39FyWby+CD
         ws69PHImF32jeNM3LvLnItFp4V34PcmJRAywt/lRqVlWzH/JX4sG3RpVtmv1wV4vS7bM
         pmFVGCQFDTUAmAj7LDxfeYKMfXAXCgB283C3tKbFwllkWSWrc8PLNfgO6jfVCYFAp6Cq
         jgEre1NLYReXDMJbLl2znSmR8ryRY97/IFqgt6L+pLkT8oVKnUatw/VLJFZ9UQZtRusz
         Uto6amvX8/eeX+JZpoAN9v8hDl/MCWgiPJ6VjhqG+TmqSDlvKEy46fI8DqRkQ25jx+lG
         e+2w==
X-Forwarded-Encrypted: i=1; AJvYcCUon5ljhbKz2I47bJz5yGdB6xJ8eSXcOHcZ+JbBkSDyuu3pczEKNr2+Z3AWnyV5Edb6io519+hgJ3xK4xsd@vger.kernel.org, AJvYcCUu6rL60FxCxnin5gIiElFkvs5wK3fahjaPpwZNvGdA2gekieaUQD9DtGn8/VWcsIbXHKlPoKjLXfLs@vger.kernel.org, AJvYcCXgJqV62iJsgI4Wcbx2Gy7hPFHXNXTK4NqFm8MuyKuEBdZrkzookbrqQwnp8iIqtztLH0JmDOOJq26O@vger.kernel.org
X-Gm-Message-State: AOJu0YzPLrGzkGfM8Bijzfm2BdhoMAGWhI2s7c9fpObYx+uUinYdhQnv
	heXfSoZLwW7FK+NPyY9CfPdJueNCbwf4vyuyr0wpdtn7Xa0bgr4sSrx6kBsIDQhcSYo=
X-Gm-Gg: ASbGncsQLtSsbLrGTcqiZ3KH6/2mLCWVeFAvcElyVJ+FfrjLjwWR/aT8y4gqlQ/HJYb
	TTGWtzQKuC3fJvchhju1ExaD3nNVEs6ZTGHOUx3DF39qHXN3OO7KRnEPQZN7YD3QotTn0WvGA06
	x3bUd62fCzgxsPXycYOvWK6veBRq7ecE4FlkZsaVqLxi4hRs8tL/RazDhTAatwnihxwoz0pEhI4
	WQCT6FsoWlUCZItjGIxGwJevniatiwOExd2ZlacTJIOSyzIQGUNtIDx5kRgG10hhpqycBEHm8pd
	PIc+d+9OCaulZkrJc9FfKKbAWIVXhpZ+P2fDPV16fgCliQkEQfY/eQ8FiC7QNEgi4eeJY8WdZUH
	J2bEBWAmkplFxmL1d79o6LWMaJrmzCDE79uxogaqpZ/l1xI6/PCI8yCs=
X-Google-Smtp-Source: AGHT+IHZUzj2Gt5/ShJSTqlvwH+lIydPXeS41PwFnfciEQ1JeKFJnnWiFAkn2qK1B+L4WgBVeoMulQ==
X-Received: by 2002:a05:651c:20db:20b0:332:57b8:92eb with SMTP id 38308e7fff4ca-33650e732eemr19534371fa.10.1756136487167;
        Mon, 25 Aug 2025 08:41:27 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e5aa917sm16002931fa.41.2025.08.25.08.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 08:41:24 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3366f66a04cso10077291fa.1;
        Mon, 25 Aug 2025 08:41:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8Igos1SJ9w2R8AsQCh7+Bc1ja3+8SgmVNiJGIBoWR/uGHCZ/R0DGbDRU0Ol9ktiN8+X/z8Qy8pKeu@vger.kernel.org, AJvYcCXE7Wb4pYImyAOkI0lEKWr1ESTC7VJwSG0GQWOJzK6DFBrAbIY5LKgPnLXDROsoawxXQpqmFwsBOzrmeISF@vger.kernel.org, AJvYcCXKhyLdV7DbitsTo4Bcyrj4WUKKSsfvpLp7pp8kdCE4i/Der59pAUjHvXURB3dcFSK0V+cZ8n3I0hoL@vger.kernel.org
X-Received: by 2002:a05:651c:31c5:b0:333:b656:a685 with SMTP id
 38308e7fff4ca-33650e3812dmr36899791fa.1.1756136484611; Mon, 25 Aug 2025
 08:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816084700.569524-1-iuncuim@gmail.com> <20250816084700.569524-6-iuncuim@gmail.com>
 <20250816144936.3f2738cc@minigeek.lan>
In-Reply-To: <20250816144936.3f2738cc@minigeek.lan>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 25 Aug 2025 17:41:12 +0200
X-Gmail-Original-Message-ID: <CAGb2v64vMvs+UN4AJWZAGnU+ZQRBQBheqnRKzbMmd10UMdOxCw@mail.gmail.com>
X-Gm-Features: Ac12FXyXTRSXu5z7cM1Z4ILcGzs0omRgBCqYp8gycWr1OzOdi7Cz8MsXeBWG_GU
Message-ID: <CAGb2v64vMvs+UN4AJWZAGnU+ZQRBQBheqnRKzbMmd10UMdOxCw@mail.gmail.com>
Subject: Re: [PATCH 5/7] arm64: dts: allwinner: a523: add USB3.0 phy node
To: Andre Przywara <andre.przywara@arm.com>
Cc: iuncuim <iuncuim@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-phy@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 3:52=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> On Sat, 16 Aug 2025 16:46:58 +0800
> iuncuim <iuncuim@gmail.com> wrote:
>
> Hi,
>
> > From: Mikhail Kalashnikov <iuncuim@gmail.com>
> >
> > After adding the phy driver, we can also add phy node. In addition to t=
he
> > clk and reset lines, the power domain PD_PCIE is declared in this node
> > according to the bsp dtb. So let's mention it.
> > Currently, phy driver does not support role selection and only works in
> > USB3.0 mode.
>
> That's the current limitation of the proposed Linux driver, but should
> not affect the binding or DT:
>
> >
> > Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm6=
4/boot/dts/allwinner/sun55i-a523.dtsi
> > index e4ed4fa82..233365496 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > @@ -606,6 +606,16 @@ mdio0: mdio {
> >                       };
> >               };
> >
> > +             combophy: phy@4f00000 {
> > +                     compatible =3D "allwinner,sun55i-a523-usb3-pcie-p=
hy";
> > +                     reg =3D <0x04f00000 0x100000>;
> > +                     clocks =3D <&ccu CLK_USB3>;
>
> Will we need more clocks (or resets) when supporting PCIe later? If
> yes, we should add them already now, even if they are not used by the
> current driver.
>
> > +                     resets =3D <&ccu RST_BUS_PCIE_USB3>;
> > +                     #phy-cells =3D <0>;
>
> I think we should use one PHY cell here, to allow users to select the
> PHY path they need. A USB3.0-only driver implementation could choose to
> ignore it, or require the number to be 0 only, rejecting anything else.
> But this way we keep compatibility with newer DTs.

Agreed. It seems this is the common case for combined PHYs. The last
cell tells which type of PHY is to be used.

ChenYu

> Cheers,
> Andre
>
> > +                     power-domains =3D <&pck600 PD_PCIE>;
> > +                     status =3D "disabled";
> > +             };
> > +
> >               ppu: power-controller@7001400 {
> >                       compatible =3D "allwinner,sun55i-a523-ppu";
> >                       reg =3D <0x07001400 0x400>;
>


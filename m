Return-Path: <linux-kernel+bounces-759786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA477B1E27D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136891891C76
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9771A23AC;
	Fri,  8 Aug 2025 06:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPpimJOT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C18A38DD8;
	Fri,  8 Aug 2025 06:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754635672; cv=none; b=ppjYfIC1d9cB2K/Ko9ZaYvM/F7WCaYGqA5h9uPBKON9L0jykR/VOk5ut/4UPFEuswhnoJsykYkuKWiLN8nGl1VvJ0d97F0rgeyUEeOCPKZE0Ekkfleq79BiNb44jDqlzrBFaqKG6m3svFrTBfCkzS1SxxZBlzeR5ewLbqLSUsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754635672; c=relaxed/simple;
	bh=AVCxwYMan6Uuj8doqg4vH3GRgUseViUWmTYBb11n0Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1OirM83+H1q2oiZRPXSuLZGOEoWtxzVdzzCT25B/s2gW1zGbPThr9xdKnGig4BTtZ/cSiq3QTeoBmCS6xUKaAEbGfJGVBOhlW2GBM4QWJi4Mcq58qBIVEWog+fmgImJMlnQ5R2EG8i2ekeOto69+456rbB4Y97+GgL8iKxRNeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPpimJOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0032FC4CEED;
	Fri,  8 Aug 2025 06:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754635671;
	bh=AVCxwYMan6Uuj8doqg4vH3GRgUseViUWmTYBb11n0Lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPpimJOTeyRvYm2oRNURR0x6WRdbiro15bSBW1D9hCQqqcX8pKGhi4JlBtwOhAu4j
	 5ekrPl+Ry8MiVMls1x8H3sT9viIg0pxH76eYK1T0nfY7Ny0J+Se6SCTEZh0iGp3Xw7
	 5tBHMkT30q+C8T76fSr8EAgHdGacJLPE6LbZjSY5ks7p1f1Bz56keuokU1RCY9Q0cj
	 xKpuKSLKCGSG4kXmJsGeOeXODteHsiybJPt53E9+MyKknnFuPs4csa44xAGpVJU0ba
	 W6oSYHGPs+QlHGcZsHIh4RAmT6QKrF/4PBImyKPAosbzbOqGnB4+3c5+xmaHXmJWa5
	 SXIxEAUm3kyZw==
Date: Fri, 8 Aug 2025 08:47:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, dlemoal@kernel.org, 
	alberto.dassatti@heig-vd.ch, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: phy: rockchip,pcie3-phy: add
 rockchip,phy-ref-use-pad
Message-ID: <20250808-ubiquitous-persimmon-llama-ff350e@kuoka>
References: <20250806133824.525871-1-rick.wertenbroek@gmail.com>
 <20250806133824.525871-4-rick.wertenbroek@gmail.com>
 <20250807-inquisitive-speedy-rooster-0a8488@kuoka>
 <c86bcdf0-f692-4263-a597-f8e36a53e8d9@kernel.org>
 <CAAEEuhpHmW9hji91tbQ3MMhBZELCYc_vA+Ra3oC2W+Rf8LLC6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAEEuhpHmW9hji91tbQ3MMhBZELCYc_vA+Ra3oC2W+Rf8LLC6w@mail.gmail.com>

On Thu, Aug 07, 2025 at 10:47:18AM +0200, Rick Wertenbroek wrote:
> On Thu, Aug 7, 2025 at 9:55=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
> >
> > On 07/08/2025 09:54, Krzysztof Kozlowski wrote:
> > > On Wed, Aug 06, 2025 at 03:38:23PM +0200, Rick Wertenbroek wrote:
> > >> >From the RK3588 Technical Reference Manual, Part1,
> > >> section 6.19 PCIe3PHY_GRF Register Description: "ref_use_pad"
> > >>
> > >> "Select reference clock connected to ref_pad_clk_p/ref_pad_clk_m.
> > >> Selects the external ref_pad_clk_p and ref_pad_clk_m inputs as the
> > >> reference clock source when asserted. When de-asserted, ref_alt_clk_p
> > >> and ref_alt_clk_m are the sources of the reference clock."
> > >>
> > >> The hardware reset value for this field is 0x1 (enabled).
> > >> Note that this register field is only available on RK3588, not on RK=
3568.
> > >
> > > Then you miss restricting it (:false) in one of if:then: blocks.
> > >
> > > Also, binding cannot be after the user. You need to reorder patches.
> > >
> > > ...
> > >
> > >>
> > >> +  rockchip,phy-ref-use-pad:
> > >> +    description: which PHY should use the external pad as PCIe refe=
rence clock.
> > >> +      1 means use pad (default), 0 means use internal clock (PLL_PP=
LL).
> > >
> > > Can't you deduce it from the presence of clock inputs? IOW, if the
> > > clocks are physically connected, is it even reasonable or possible to
> > > use internal clock?
>=20
> Thank you Krzysztof,
> But no, if there is no clock, the driver deadlocks, it needs a clock
> to probe correctly.
>=20
> When there is a clock physically connected on the pad, you can still
> choose to use it or use the internal clock, this is no problem.

Why would use internal clock for such case? In few other cases this
appeared we usualyl were using the presence of the clock as determining
factor.

> The problem is when you have no clock on the pad (as it defaults to
> using the pad) and the loading the driver deadlocks the system...

This sounds like a driver, not a binding, problem.

>=20
> > >
> > >> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > >> +    minItems: 2
> > >> +    maxItems: 2
> > >> +    items:
> > >> +      minimum: 0
> > >> +      maximum: 1
> > >
> > > More precise:
> > >
> > > items:
> > >   - description: PHY0 reference clock config
> > >   - description: PHY1 reference clock config
> > >   enum: [ 0, 1 ]
> >
> > Eh, no, rather if this stays as int:
> >
> >     items:
> >       - description: PHY0 reference clock config
> >         enum: [ 0, 1 ]
> >       - description: PHY1 reference clock config
> >         enum: [ 0, 1 ]
> >     default: [ 1, 1 ]
> >
> >
> > > default: [ 1, 1 ]
> > >
> > > Anyway, default 1, 1 is pretty non-obvious, so this should be just
> > > non-unique-string-array (and property should be like
> > > rockchip,phy-ref-clk-source/sel).
> > >
> > >
> > > Best regards,
> > > Krzysztof
> > >
> >
> >
> > Best regards,
> > Krzysztof
>=20
> I based my patch on patch :
> 46492d10067660785a09db4ce9244545126a17b8
> dt-bindings: phy: rockchip,pcie3-phy: add rockchip,rx-common-refclk-mode
>=20
> As the option I add is extremely similar, it sets a feature in one of
> the PHY registers and only applies to RK3588.
> That is why I used the same style as rockchip,rx-common-refclk-mode.

So you should have used for example same property.

>=20
> Wouldn't it be confusing or at least incoherent to use enum for
> rockchip,phy-ref-use-pad but not for rx-common-refclk-mode ?

Same hardware properties should have same properties - type, name and
meaning - but you did not re-use existing one. Maybe it is too specific?

We do not write properties for registers, but for hardware (like SoC or
board) characteristics.

Best regards,
Krzysztof



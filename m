Return-Path: <linux-kernel+bounces-850517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0DFBD30FE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4018E3C0934
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA142877D5;
	Mon, 13 Oct 2025 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IYz8hkJV"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9539A26E714;
	Mon, 13 Oct 2025 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760359781; cv=none; b=os0h5Z4/S6XRvtclF0YRhODIGPVZTL+QIqezNLlWPNHrk4sRDOYUeEn5M8T02948g2qmsIM6FMj0uqAZq26auhOULx3tQowvJB0Sup2E/EvkBDwu899NnU32TWxUlfzM06whqP8WoPQ+MQBTkT2qxBer4j329lXxFStOjvbnZEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760359781; c=relaxed/simple;
	bh=ya9U9PpYHujtyWIuac/BeIHM52FnNKhuZrvKnb18v6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBFaqvHBmJOLw1NYQXlx0pQ74a9drymflk8Wa2JBWYCfcfCmv2TYeyV5VvAKzjicFKCdBqd76Y0AB9QVbM3t4SnqATjU/sHxmthCfO5aeLYEQBK5AiM1PC7OVegiMVXta65ZqalBfbeaQJupgmqjDiuhNBlCN3gq6YxIWrj/nmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IYz8hkJV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k3MQLLai5Lv1jjJP3MPQy569OXhdTSwstmrfUBxF72w=; b=IYz8hkJVfaP2cX4h8ZURsZZ4uF
	mKPN5lEiMWdLhGTGvlXkhhNTiX+V6ElB7rt+ErxHq2nWwSTGUKFpoF5Sg8Idcuf2MJi8Wa+grVvW4
	Fed16y9coFyDw/QXXQYs5I7htwlZLIz/reIUDsDX5TKjYWKtZ2aMJAkBzBIOvKjoAbMjkMvr15Tcl
	G590Viuqb+Xm6YMY7lweG+QjqEaz64p3KHCxQif1U5l8J3fgTigZ7luXotO5sKO/ECOtF2AeOXf7y
	nap9IUSzUxu1McVNIdhRmwT8/b6UD27i34sKNFzmVJy7CewBcJhCyubeppnsLP12nSJ7f2tsJ7x8e
	Mb1NJa8Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48894)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v8HzP-000000001zZ-0kKg;
	Mon, 13 Oct 2025 13:49:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v8HzH-000000000Le-1ZYr;
	Mon, 13 Oct 2025 13:49:15 +0100
Date: Mon, 13 Oct 2025 13:49:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Liangbin Lian <jjm2473@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, quentin.schulz@cherry.de,
	kever.yang@rock-chips.com, naoki@radxa.com, honyuenkwun@gmail.com,
	inindev@gmail.com, ivan8215145640@gmail.com,
	neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org,
	pbrobinson@gmail.com, alchark@gmail.com, didi.debian@cknow.org,
	jbx6244@gmail.com, andrew@lunn.ch, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] arm64: dts: rockchip: add LinkEase EasePi R1
Message-ID: <aOz1SzpzGLDQjiYQ@shell.armlinux.org.uk>
References: <20251009084416.45542-1-jjm2473@gmail.com>
 <20251009084416.45542-4-jjm2473@gmail.com>
 <aOe_0EufouURu7R2@shell.armlinux.org.uk>
 <CAP_9mL4MfzagxiMD1VdOu=jBuN_XsOrvPQT=XTVgu2+G=+nD9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP_9mL4MfzagxiMD1VdOu=jBuN_XsOrvPQT=XTVgu2+G=+nD9A@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 10, 2025 at 11:20:08AM +0800, Liangbin Lian wrote:
> Russell King (Oracle) <linux@armlinux.org.uk> 于2025年10月9日周四 21:59写道：
> >
> > On Thu, Oct 09, 2025 at 04:44:16PM +0800, Liangbin Lian wrote:
> > > +&gmac0 {
> > > +     phy-mode = "rgmii-id";
> > > +     clock_in_out = "input";
> > ...
> > > +&gmac1 {
> > > +     phy-mode = "rgmii-id";
> > > +     clock_in_out = "input";
> >
> > I am fine with what is being proposed here, but I think this
> > clock_in_out property needs fixing. The description for it is thus:
> >
> >   clock_in_out:
> >     description:
> >       For RGMII, it must be "input", means main clock(125MHz)
> >       is not sourced from SoC's PLL, but input from PHY.
> >       For RMII, "input" means PHY provides the reference clock(50MHz),
> >       "output" means GMAC provides the reference clock.
> >     $ref: /schemas/types.yaml#/definitions/string
> >     enum: [input, output]
> >     default: input
> >
> > The problems that I have here are:
> >
> > 1) the description states that the only possible value for this when in
> >    RGMII mode is "input" which is reasonable, because it's due to the
> >    RGMII specification. The driver code is perfectly able to determine
> >    whether RGMII has been specified, and set bsp_priv->clock_input
> >    itself, relieving DT of this need.
> >
> > 2) bsp_priv->clock_input is only used in gmac_clk_enable() when calling
> >    the SoC specific set_clock_selection() method. Only RK3528, RK3576,
> >    and RK3588 populate this method. Every other SoC supported by this
> >    driver still requires the property:
...
> >   clock_in_out:
> >     description:
> >       For RGMII, it must be "input"
> 
> This description does not match the actual situation,
> there are many dts using 'output':
> https://elixir.bootlin.com/linux/v6.17/source/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts#L235
> https://elixir.bootlin.com/linux/v6.17/source/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts#L241
> https://elixir.bootlin.com/linux/v6.17/source/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts#L33
> https://elixir.bootlin.com/linux/v6.17/source/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts#L78

For all of the above, whether it is "input" or "output" has no effect
as these are all rk3568, and rk3568 does not implement the
set_clock_selection() method.

static const struct rk_gmac_ops rk3568_ops = {
        .set_phy_intf_sel = rk3568_set_phy_intf_sel,
        .set_to_rgmii = rk3568_set_to_rgmii,
        .set_to_rmii = rk3568_set_to_rmii,
        .set_speed = rk_set_clk_mac_speed,
        .regs_valid = true,
        .regs = {
                0xfe2a0000, /* gmac0 */
                0xfe010000, /* gmac1 */
                0x0, /* sentinel */
        },
};

I'm going to propose:

1) that the driver should only print an error if "clock_in_out" is
missing _and_ the SoC implements the required function.

2) that the driver should print a non-fatal error if this property is
specified in DT _and_ the SoC does not implement the function to
discourage its use.

3) [tr]x_delay should not print an error for non-RGMII phy interface
modes.

I consider it a bug that a driver prints errors for properties that
have not been specified that it does not actually require. By doing
so, it encourages people to add useless properties to their DT
description that will never ever be used (e.g. because they are not
relevant for hardware the operating mode that the board is setup
for.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


Return-Path: <linux-kernel+bounces-810151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C0BB516A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2A7480ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764F5311C1B;
	Wed, 10 Sep 2025 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZTbMEACN"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6D8FC0A;
	Wed, 10 Sep 2025 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506557; cv=none; b=G1bCp0RfAV+HrxUbqx6bW7Q8iF0IdQ6TvJhDTsr7miFh10oQM2Ou0fL9ormxD5Pm8fpzEfHSryWti5QKZ5tn/S0XPNGU0lhxXZCy4GTQqnH+OkthuuSgGMdj62wWH41qfRHNadFWeWC8DToJikGZptHOd1Q4WSTTtM01v17g/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506557; c=relaxed/simple;
	bh=KwexyF4UKF/+DwYyTo1Fmr7gDsd8VpjyldGERchJczc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXvBnaQoyDfU7XNmM8hcnLKoguAqHR5SXcAwoQebtD0k2uAyusBq83jvKApL2STlVtv6pCaBMklK7bR+rq14PD4Yg/KBaM18LGeAJDbvmn879FPhRfl+Fr7jbgzeuYt2JAyYE4zDpZxtV5/cx81bCTSQh8Sk3taGzjqVtCDku2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZTbMEACN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0DyqbbA1ZUCcjEgFCs3V8UYrQ/Dy0tn2WnKs8noBz34=; b=ZTbMEACNtDoGeX4I1SHmnsNMrg
	iEm2zkz90efE9oFDeUhbiIsb5hdpZBnsmCw5qWDN+4pIp92zVImepYnA3diWOoYcqv6VnFTxUzxQN
	x771697TzZ/BCD2nZWvEzBoxS5fhuIqiYU/YjUsdePp4WM5GpGbe/RI/iZ0dWJh0nQb8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uwJjZ-007w5t-QA; Wed, 10 Sep 2025 14:15:33 +0200
Date: Wed, 10 Sep 2025 14:15:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kaison <dkx@t-chip.com.cn>
Cc: Rob Herring <robh@kernel.org>, Jimmy Hon <honyuenkwun@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Wayne Chou <zxf@t-chip.com.cn>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Peter Robinson <pbrobinson@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add devicetree for the
 ROC-RK3588-RT
Message-ID: <ec8a3649-3f8f-40b7-a534-041b3523efe4@lunn.ch>
References: <cover.1757322046.git.dkx@t-chip.com.cn>
 <42ae6d16ed9162582e7b03cbad661a7950c0db55.1757322046.git.dkx@t-chip.com.cn>
 <307a76a6-cc92-44a1-9ac0-97005bf51b4b@lunn.ch>
 <76B19AD42CA555FC+fff44db30522cf270802ec31912a9c19d29b2d39.camel@t-chip.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76B19AD42CA555FC+fff44db30522cf270802ec31912a9c19d29b2d39.camel@t-chip.com.cn>

On Wed, Sep 10, 2025 at 10:55:22AM +0800, Kaison wrote:
> hi,
> I'm very sorry. Due to the default configuration of my email, I didn't
> receive your email normally. I have fixed this issue.
> 
> On Tue, 2025-09-09 at 14:31 +0200, Andrew Lunn wrote:
> > > - 2x Gigabit Ethernet, 1x 2.5G Ethernet
> > 
> > I actually only see the 2x 1G. Is the 2.5G not supported yet?
> The 2.5G Ethernet is based on the Realtek RTL8125 network controller of
> PCIe 2.0x1.

Ah, O.K. Maybe add a comment, because i was looking for something
integrated into the SoC, not a PCIe device.

> > > +&gmac0 {
> > > +	clock_in_out = "output";
> > > +	phy-handle = <&rgmii_phy0>;
> > > +	phy-mode = "rgmii-rxid";
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&gmac0_miim
> > > +		     &gmac0_tx_bus2
> > > +		     &gmac0_rx_bus2
> > > +		     &gmac0_rgmii_clk
> > > +		     &gmac0_rgmii_bus>;
> > > +	tx_delay = <0x47>;
> > 
> > What happened about my comment that "rgmii-rxid" is probably wrong?
> > 
> > If you think it is correct, you should reply with a
> > justification. Maybe PCB is very odd? In which case, a comment would
> > be good to explain who it is odd.
> The Ethernet part of the board is designed with reference to the
> rockchip evb1 board. 
> 
> link: 
> https://github.com/Firefly-rk-linux/docs/blob/rk3588/firefly-public/en/Common/GMAC/Rockchip_Developer_Guide_Linux_GMAC_RGMII_Delayline_EN.pdf
> 
> 
> The document describes the usage of the rgmii-rxid mode:
> 
> When the hardware enables the RX delay of the PHY. Need to turn off the
> RX delay of the GMAC, and the dts configuration mode becomes "rgmii-
> rxid".

Vendors get this wrong as well, and give you bad advice. Please look
at:

https://elixir.bootlin.com/linux/v6.16.5/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L264

	Andrew


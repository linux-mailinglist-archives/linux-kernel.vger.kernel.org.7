Return-Path: <linux-kernel+bounces-844403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48177BC1D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1066F19A4601
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF5F2E267D;
	Tue,  7 Oct 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2aCWQWXq"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAD8213E7A;
	Tue,  7 Oct 2025 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849073; cv=none; b=bJVW3PN2gUaluBnm5R6KXmhX/EkY7OSzwWxlim33QTn9CWDyX54NgfPw7RiX8bOKD/i4rCJqmSL5e+aCcnMlvQONRfSiYESLw+mPYOtSXi7dZx86coJ0mDwxzl/ZrGZBZkZy4HW2Pmcg3UqB9uTX0xuszE/Hk/vYntbGpob+YjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849073; c=relaxed/simple;
	bh=K3mj/WnPQsXS94Kvuj++ux/qTDZhBvfjAAZQA4Qi09g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADWL2k+oOFQ4VddK2cTleakRlZM3LeIWuXwuddsVd7bYWSZ2iQQgwE6nMrOCyZ1pNyBCywg54milNBQaj1tp9jTPCklApRYXz4Tp9euwxuFTYMK7hRylWIvKgqA6zNenKMsYHtuX/zICeZUhukOKEYRSkR01E4IV/TQ/e4YDQhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2aCWQWXq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=DziWPGL5BCnrXGXlnLfK6L+lOv9RgOdC/X+zoXjgv1Y=; b=2a
	CWQWXq5F5H/isDImCeFmCXqqNSZQy0pPiAie+UizenttXDfEZphJ6/AjqiP5y9aybnQAstXk40jN6
	roZnrOuqIbIiBDQdDyWLyHubInBwLNhZxJwIDxFzO1FU0Ahzg1lJM8fM7Friedv+USP0WzDIHsOKs
	8N0XHuMRHcntHhI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v6988-00ANQz-D4; Tue, 07 Oct 2025 16:57:32 +0200
Date: Tue, 7 Oct 2025 16:57:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: jjm2473 <jjm2473@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, quentin.schulz@cherry.de,
	kever.yang@rock-chips.com, naoki@radxa.com, honyuenkwun@gmail.com,
	inindev@gmail.com, ivan8215145640@gmail.com,
	neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org,
	pbrobinson@gmail.com, alchark@gmail.com, didi.debian@cknow.org,
	jbx6244@gmail.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: add LinkEase EasePi R1
Message-ID: <7e219aef-88a0-4184-9553-30dcbc8dbd79@lunn.ch>
References: <20250929065714.27741-1-jjm2473@gmail.com>
 <20250929065714.27741-4-jjm2473@gmail.com>
 <d8ad476c-d0c7-4e97-9e76-540a539ffb52@lunn.ch>
 <CAP_9mL4ofig-X-w9wx1A5D_eVXROo6AVFBSwp4mh=kj7webpPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP_9mL4ofig-X-w9wx1A5D_eVXROo6AVFBSwp4mh=kj7webpPA@mail.gmail.com>

On Tue, Oct 07, 2025 at 10:32:26PM +0800, jjm2473 wrote:
> Andrew Lunn <andrew@lunn.ch> 于2025年10月6日周一 23:51写道：
> >
> > > +&gmac0 {
> > > +     phy-mode = "rgmii";
> >
> > Did i really miss this patch series in its earlier version, or did you
> > ignore me?
> >
> > https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287
> >
> > > +     tx_delay = <0x3c>;
> > > +     rx_delay = <0x2f>;
> >
> > Please change it to rgmii-id, and smaller tx/rx_delay values. Or show
> > us the schematics which clearly show extra long clock lines.
> >
> > > +/* Micro SD card slot is not mounted */
> > > +&sdmmc0 {
> > > +     max-frequency = <150000000>;
> > > +     no-sdio;
> > > +     no-mmc;
> > > +     bus-width = <4>;
> > > +     cap-mmc-highspeed;
> > > +     cap-sd-highspeed;
> > > +     disable-wp;
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
> > > +     vmmc-supply = <&vcc3v3_sd>;
> > > +     vqmmc-supply = <&vccio_sd>;
> > > +     status = "disabled";
> > > +};
> > > +
> > > +/* Wifi module is not mounted */
> > > +&sdmmc2 {
> >
> > What do you mean by "not mounted"?
> >
> > Often you would say "not populated", to indicate the PCB has all the
> > tracks in place, but the chip has simply not been soldered in place.
> >
> > Or is there a connector here, and nothing plugged into the connector?
> >
> >    Andrew
> 
> Andrew:
>  Hello! I ran `./scripts/get_maintainer.pl
> patches-v4/v4-0003-arm64-dts-rockchip-add-LinkEase-EasePi-R1.patch`
> to get maintainer list, and got:
> ```
> Rob Herring <robh@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED
> DEVICE TREE BINDINGS)
> Krzysztof Kozlowski <krzk+dt@kernel.org> (maintainer:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS,commit_signer:3/41=7%)
> Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS)
> Heiko Stuebner <heiko@sntech.de> (maintainer:ARM/Rockchip SoC
> support,commit_signer:43/41=100%,authored:4/41=10%,added_lines:12/117=10%,commit_signer:5/6=83%)
> Quentin Schulz <quentin.schulz@cherry.de>
> (commit_signer:10/41=24%,authored:8/41=20%,added_lines:63/117=54%)
> Dragan Simic <dsimic@manjaro.org> (commit_signer:5/41=12%,commit_signer:1/6=17%)
> FUKAUMI Naoki <naoki@radxa.com>
> (commit_signer:3/41=7%,authored:3/41=7%,removed_lines:1/1=100%)
> Peter Robinson <pbrobinson@gmail.com>
> (added_lines:9/117=8%,commit_signer:1/6=17%,authored:1/6=17%)
> Alexey Charkov <alchark@gmail.com> (added_lines:6/117=5%)
> Diederik de Haas <didi.debian@cknow.org>
> (commit_signer:4/6=67%,authored:3/6=50%)
> Liangbin Lian <jjm2473@gmail.com> (commit_signer:1/6=17%,authored:1/6=17%)
> Johan Jonker <jbx6244@gmail.com> (authored:1/6=17%)
> devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
> DEVICE TREE BINDINGS)
> linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support)
> linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
> linux-kernel@vger.kernel.org (open list)
> ```
> your email address is not listed above.

What i eventually found is that you posted v3 separately, and then
threaded v4 to v2, which makes no sense.

Please always start a new thread for each patchset.

> > What do you mean by "not mounted"?
> >
> > Often you would say "not populated", to indicate the PCB has all the
> > tracks in place, but the chip has simply not been soldered in place.
> >
> > Or is there a connector here, and nothing plugged into the connector?
> 
> The chip/slot has not been soldered. So here should be "not
> populated", forgive my poor English.

Thanks for the clarification. I'm not sure it is worth adding these DT
properties. When a new board is produced which does populate these
devices, you are going to need a new .dts file. So you can put the
properties into that new file.

> 
> > Please change it to rgmii-id, and smaller tx/rx_delay values. Or show
> > us the schematics which clearly show extra long clock lines.
> 
> In fact, the RTL8211F's RXDLY and TXDLY signals are both pulled low,
> just like the Banana Pi BPI-R2 Pro, so the configuration is also referenced:
> https://elixir.bootlin.com/linux/v6.15/source/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts#L237

Pull low makes no difference to the 2ns RGMII delays.

> The tx_delay and rx_delay values were obtained using Rockchip's
> automatic scanning tool:
> https://github.com/istoreos/istoreos/blob/54746dfdb5bd34d1f281cf41d1d1620d0c3ee686/target/linux/rockchip/files/drivers/net/ethernet/stmicro/stmmac/dwmac-rk-tool.c
> https://gitlab.com/firefly-linux/docs/-/blob/rk356x/firefly/Common/GMAC/Rockchip_Developer_Guide_Linux_GMAC_RGMII_Delayline_EN.pdf
> https://github.com/axlrose/rkdocs/blob/main/Common/GMAC/Rockchip_Developer_Guide_Linux_GMAC_RGMII_Delayline_EN.pdf

Vendors get things wrong, including this. 'rgmii' means the PCB adds
the 2ns delay. Nearly every Rockchip board follows Rockchip broken
vendor recommendations, and then i come along, point out how it is
wrong, and ask for it to be fixed, before being merged to Mainline.

	Andrew


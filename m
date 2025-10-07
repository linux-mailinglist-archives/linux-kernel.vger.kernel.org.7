Return-Path: <linux-kernel+bounces-844512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AD2BC21C8
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB1C84EF769
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED012E7F2A;
	Tue,  7 Oct 2025 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Yt+zyzda"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB7F2E7BDC;
	Tue,  7 Oct 2025 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854371; cv=none; b=jnEjKg7WGYS2h/VWKAjtQNDbRTdiOGGjlSojRFw0KTU3/QpUn6FDw0NSRJsnG55vDGo1ubf34cnKAzBpDLWsvGS1ZMip6hFkABfSkdLcum+VUOHg7tvbRjuisImA88Rc6La795ImHQZVi/SEgiOfYJczGqRpmwipV8BWH5/Ta38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854371; c=relaxed/simple;
	bh=nP2Zdx6rW0paU6gSmqNSwdkZxdivBILmkcFEEf8fh5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLrQxl2lwGtiyWQRb2/aCSzD9UnyMvVcHaAxsW2prckpngonlPbAyzc0Zt85iGfn2OaYLw0xD156HjPmkhlgGCXmg3IpfR1wOplz+f8drWHJ0S7ckOjVGFLOMIhSPm2bt88wagq0KGWiwfectXSO7jq1kSU0lpVEdZEYkxiG3Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Yt+zyzda; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sux+G8UYuTe6OpX0yXYNFv4IijM8dkNkYRTT0OHVyw0=; b=Yt+zyzdaOOyvXP4CN8scOQIvB7
	hMr62mIPLsssoXyHhcgac7K4DzmccMDIDSjxxYEeR/8RneyHCtA0Inha4T4G6cc99kLkMBLuYp9mE
	GaJ+IVuQgqMWNgnetTmMcsMSASET8pF08TRHopxw9XugNyFZ1Bg8dmIT/Wn9yqx8sAZN8rKQCcetI
	+D46UgqmLdVqetuBPV745ZPMCeWNxSYEKrWmXD2vvkzCUD9a4doViK4QyD94QWfQHRpu45gB4SlcC
	APYp4cD7U9E/tg6+sYz0/8sUk4Q25qD4ZqDY0LLWdjvnzN3/Iyg65K8KMd+kTIzjy9hMxRlyAEngO
	Nj8ev45w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58244)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v6AVR-000000005LF-197N;
	Tue, 07 Oct 2025 17:25:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v6AVK-0000000032Z-2vLE;
	Tue, 07 Oct 2025 17:25:34 +0100
Date: Tue, 7 Oct 2025 17:25:34 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: jjm2473 <jjm2473@gmail.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, heiko@sntech.de, quentin.schulz@cherry.de,
	kever.yang@rock-chips.com, naoki@radxa.com, honyuenkwun@gmail.com,
	inindev@gmail.com, ivan8215145640@gmail.com,
	neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org,
	pbrobinson@gmail.com, alchark@gmail.com, didi.debian@cknow.org,
	jbx6244@gmail.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: add LinkEase EasePi R1
Message-ID: <aOU-_tPOmkyuw_kx@shell.armlinux.org.uk>
References: <20250929065714.27741-1-jjm2473@gmail.com>
 <20250929065714.27741-4-jjm2473@gmail.com>
 <d8ad476c-d0c7-4e97-9e76-540a539ffb52@lunn.ch>
 <CAP_9mL4ofig-X-w9wx1A5D_eVXROo6AVFBSwp4mh=kj7webpPA@mail.gmail.com>
 <7e219aef-88a0-4184-9553-30dcbc8dbd79@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e219aef-88a0-4184-9553-30dcbc8dbd79@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 07, 2025 at 04:57:32PM +0200, Andrew Lunn wrote:
> On Tue, Oct 07, 2025 at 10:32:26PM +0800, jjm2473 wrote:
> > Andrew Lunn <andrew@lunn.ch> 于2025年10月6日周一 23:51写道：
> > > Please change it to rgmii-id, and smaller tx/rx_delay values. Or show
> > > us the schematics which clearly show extra long clock lines.
> > 
> > In fact, the RTL8211F's RXDLY and TXDLY signals are both pulled low,
> > just like the Banana Pi BPI-R2 Pro, so the configuration is also referenced:
> > https://elixir.bootlin.com/linux/v6.15/source/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts#L237
> 
> Pull low makes no difference to the 2ns RGMII delays.

To be clear, while the RXDLY and TXDLY are hardware strapping controls
the hardware configuration of the 2ns RGMII clock delays, the realtek
driver can (and does) override this according to the phy-mode property.
Thus hardware strapping makes no difference to Linux.

So, what we get at the RTL8211F PHY is:

	phy-mode	receive clock delay	transmit clock delay
	"rgmii"		0ns			0ns
	"rgmii-rxid"	2ns			0ns
	"rgmii-txid"	0ns			2ns
	"rgmii-id"	2ns			2ns

irrespective of RXDLY / TXDLY hardware strapping.

> > The tx_delay and rx_delay values were obtained using Rockchip's
> > automatic scanning tool:
> > https://github.com/istoreos/istoreos/blob/54746dfdb5bd34d1f281cf41d1d1620d0c3ee686/target/linux/rockchip/files/drivers/net/ethernet/stmicro/stmmac/dwmac-rk-tool.c
> > https://gitlab.com/firefly-linux/docs/-/blob/rk356x/firefly/Common/GMAC/Rockchip_Developer_Guide_Linux_GMAC_RGMII_Delayline_EN.pdf
> > https://github.com/axlrose/rkdocs/blob/main/Common/GMAC/Rockchip_Developer_Guide_Linux_GMAC_RGMII_Delayline_EN.pdf
> 
> Vendors get things wrong, including this. 'rgmii' means the PCB adds
> the 2ns delay. Nearly every Rockchip board follows Rockchip broken
> vendor recommendations, and then i come along, point out how it is
> wrong, and ask for it to be fixed, before being merged to Mainline.

Can we at least get the "tx_delay" and "rx_delay" DT properties (which
are register values) properly documented in the DT binding document?
I know from the driver code that a value of 0 means "no delay". Other
values add an unspecified delay - it is not obvious what any non-zero
value means, or what the default means.

This would help us understand what values such as:

	tx_delay = 0x3c or 0x4f

and

	rx_delay = 0x2f or 0x26

actually mean in terms of the resulting delay at the MAC.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


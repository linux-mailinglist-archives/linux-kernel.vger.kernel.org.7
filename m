Return-Path: <linux-kernel+bounces-846848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32420BC9392
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB313E5CB9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041EC2E7F02;
	Thu,  9 Oct 2025 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wqUZCOdC"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB15A2494D8;
	Thu,  9 Oct 2025 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015704; cv=none; b=XrU58O1p3YApQdw4TmUW9TmC+vmdiJ6nNSO4IBJBKTbBYI6kXK2RyusFx0HQgM6hgcGim6YuPATsHTwcmWtBx0ndla5jDvvOs3PmOSS8EWM+3P6Dhw9lzcvgUY8Qqe0CBe3thJYAsFA/7ltlYxw4mqieNK5AzzRbRKuwUskdOAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015704; c=relaxed/simple;
	bh=j0l9ua/U78CufSLNpx34v7XViGw39ySUB1aw/O0i6TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UorfLFCeNHYS3WYjZviuhPD5AYQGjJqag8ByNabePyOmNxQetubV6n/fdRBJ5ZKJNNtejFbb9L6qFNgHQkErjz5huo8Lb5+hu3vNDJ5qAYrVSvwcWT8+1ARULe+eN9yAej7daYg51Jdy9dCLCJ48EsyfMITriyypkZJ7oL7u9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wqUZCOdC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kK41qbPw1q3UMz4pwunY5z+aeQyJVyFxmh5g1nvkj0c=; b=wqUZCOdC1v8OPCKVMTg4GIzsbf
	Vnk4mJs8ipdjSXaq4zvP67kMxSm5Ifcq19yYYlJqn1ojevJk3jA1Fcg22Fzf8aNo4/MjMMCf0B9PG
	qvXeUYq7oJvAUOqwN5my82VqbZ/BQkIWxQ/1nvWTcYiXB09rDVOsZ8mgp5chxFcoq3OE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v6qTn-00AWyE-Eh; Thu, 09 Oct 2025 15:14:47 +0200
Date: Thu, 9 Oct 2025 15:14:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Liangbin Lian <jjm2473@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, quentin.schulz@cherry.de,
	kever.yang@rock-chips.com, naoki@radxa.com, honyuenkwun@gmail.com,
	inindev@gmail.com, ivan8215145640@gmail.com,
	neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org,
	pbrobinson@gmail.com, alchark@gmail.com, didi.debian@cknow.org,
	jbx6244@gmail.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] arm64: dts: rockchip: add LinkEase EasePi R1
Message-ID: <ceb6ab82-95a7-4f65-854f-9b04dfa1ff34@lunn.ch>
References: <20251009084416.45542-1-jjm2473@gmail.com>
 <20251009084416.45542-4-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009084416.45542-4-jjm2473@gmail.com>

> +&gmac0 {
> +	phy-mode = "rgmii-id";
> +	clock_in_out = "input";
> +
> +	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
> +	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>;
> +	assigned-clock-rates = <0>, <125000000>;
> +	phy-handle = <&rgmii_phy0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_miim
> +		     &gmac0_tx_bus2
> +		     &gmac0_rx_bus2
> +		     &gmac0_rgmii_clk
> +		     &gmac0_rgmii_bus>;
> +
> +	status = "okay";
> +};
> +
> +&gmac1 {
> +	phy-mode = "rgmii-id";
> +	clock_in_out = "input";
> +
> +	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
> +	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
> +	assigned-clock-rates = <0>, <125000000>;
> +	phy-handle = <&rgmii_phy1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac1m1_miim
> +		     &gmac1m1_tx_bus2
> +		     &gmac1m1_rx_bus2
> +		     &gmac1m1_rgmii_clk
> +		     &gmac1m1_rgmii_bus>;
> +
> +	status = "okay";
> +};
> +
> +&mdio0 {
> +	rgmii_phy0: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;
> +		pinctrl-0 = <&eth_phy0_reset_pin>;
> +		pinctrl-names = "default";
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&mdio1 {
> +	rgmii_phy1: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;
> +		pinctrl-0 = <&eth_phy1_reset_pin>;
> +		pinctrl-names = "default";
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio2 RK_PD1 GPIO_ACTIVE_LOW>;
> +	};
> +};

For these nodes only:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


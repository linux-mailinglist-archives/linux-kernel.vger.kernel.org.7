Return-Path: <linux-kernel+bounces-779855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C72A3B2FA3B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D52087BB9CF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4216133437E;
	Thu, 21 Aug 2025 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aXqgfhv8"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D784E3314D7;
	Thu, 21 Aug 2025 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782674; cv=none; b=nRxG0sqS7BS0DqQAyBbEYPQzYq8KYmuoFwXcAgocj4RhWa4dIrqMIb5rA0a9/eqi7fcAzjZnejtSyWhyriJz/COgEXgos4GYUm1dPtCCYvYuQGtAtx1PH0Ku/o3vVk1vZTj2Lq4ZktcZC4sdmEjBsECS8h4uQO0IeFPTam5RpOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782674; c=relaxed/simple;
	bh=pKhC7fbxuTvTXd2Op7gWnhvnmstqrBBATThltGesA7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldeLiAwbWRatTprteR527awKLo9kvzSSxLPmbtLwhwRyk8ytpygjyCccSaI938ovVAPmUXSYkSKyiyzTKjbtK3IGtq/BRmVQN1g4vnAWhRe2O8x7JOicZ2nONwZ5XY0oQV5MjgQdZ4KcJDh/CBt1FZKCoN6VrR5xnY8OMIxPsUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aXqgfhv8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cpXaZMqjSZbAgdwg8mSDEftWCWDwoNsLUW2Eef19G38=; b=aXqgfhv8eg6zEIGtl21VggWx5Z
	us+jnh526lU0meVen16i2u0Nzg/J148die1WZMebLepoq/W05DUw4lXttx+AGOaW8OdafpUnqUSbc
	HFDoJYaEKkD83dETjzus75JXBkQZ1ol9ale5AOPta2u1D6wSsw9cPgyojjEWL6Wbyh5U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1up5H1-005SGu-S5; Thu, 21 Aug 2025 15:24:11 +0200
Date: Thu, 21 Aug 2025 15:24:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hsun Lai <i@chainsx.cn>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, inindev@gmail.com, quentin.schulz@cherry.de,
	jonas@kwiboo.se, sfr@canb.auug.org.au,
	nicolas.frattaroli@collabora.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	krzysztof.kozlowski@linaro.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v1 2/2] arm64: dts: rockchip: add DTs for 100ASK DShanPi
 A1
Message-ID: <40b212df-2a55-48d5-8479-07c2de7b7cd6@lunn.ch>
References: <20250821110942.172150-1-i@chainsx.cn>
 <20250821110942.172150-3-i@chainsx.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821110942.172150-3-i@chainsx.cn>

> +&gmac0 {
> +	phy-mode = "rgmii-id";
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&eth0m0_miim
> +		     &eth0m0_tx_bus2
> +		     &eth0m0_rx_bus2
> +		     &eth0m0_rgmii_clk
> +		     &eth0m0_rgmii_bus>;
> +	status = "okay";
> +};
> +
> +&gmac1 {
> +	phy-mode = "rgmii-id";
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&eth1m0_miim
> +		     &eth1m0_tx_bus2
> +		     &eth1m0_rx_bus2
> +		     &eth1m0_rgmii_clk
> +		     &eth1m0_rgmii_bus
> +		     &ethm0_clk1_25m_out>;
> +	status = "okay";
> +};

> +&mdio0 {
> +	rgmii_phy0: phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;
> +		clocks = <&cru REFCLKO25M_GMAC0_OUT>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gmac0_rst>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio0 RK_PC2 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&mdio1 {
> +	rgmii_phy1: phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;
> +		clocks = <&cru REFCLKO25M_GMAC1_OUT>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gmac1_rst>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_LOW>;
> +	};
> +};

For these nodes only:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


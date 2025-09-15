Return-Path: <linux-kernel+bounces-816036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19940B56E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 05:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB38B1746D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B55215F5C;
	Mon, 15 Sep 2025 03:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q1fQlkgb"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1222A1BA;
	Mon, 15 Sep 2025 03:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757905347; cv=none; b=Xsyb/Ma8EbutQaNG8iW97TpJ7CEi15QbgxKyxBDAGqV8AdEZMDGIr0igyL4mL1TjCYjVf1+uzgkjR3bFUQSr5gU02bJT0YXJRuZwJWQ8aEvaqJnr1Y/wX5eDY4KBG799eqUvCf1sAB8RNANJPGGUa3vaRKs14MGKQ5tKVKNzXdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757905347; c=relaxed/simple;
	bh=wi0sAFfyF8bZXOncuPtyIG6ya0EEJUvG1GW4xb+o8D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0nj0rdoYjXzOGGRQ87JklKN9DiyB6u0JVOdR6T3E6UOXNoGNN8bgYLEvG6eOlsqZM8YZ5tMpNsrL2nBKV0XSbx6F8WKbdggAicP96t8hB5HgCJQN4C7xefmufcE9Qim9T/7hPvc8CJdiXCPHB4/GOEk4hCRjFSKej3KFJfhtLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q1fQlkgb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wpUJEfkdBkKRAwczqeGRWOLvBP7B0LPXqOrz9cHTX7w=; b=q1fQlkgbxn2h+zFqDxFnTbyhD7
	rNIAbOO3pCYQXhkvXYW4ax5gA+6IUg2NwHuu55ahmvHrx55T1rHkc8mt3Fb5jb78ocCAFmPo3mUdp
	yC1YLINp1ayfCPzuEMtqQ7TZq/WS0gzKB1/pq5KBPHyHQcgbvQ4B5N3iquvgEyz/OZFI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxzTY-008OGE-Tm; Mon, 15 Sep 2025 05:01:56 +0200
Date: Mon, 15 Sep 2025 05:01:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kaison Deng <dkx@t-chip.com.cn>
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
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add devicetree for the
 ROC-RK3588-RT
Message-ID: <83b50c2a-bcbc-45cc-935b-af3bc910853c@lunn.ch>
References: <cover.1757902513.git.dkx@t-chip.com.cn>
 <349c4226824efa52ceb14e3d8518c8bb5c7465fc.1757902513.git.dkx@t-chip.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <349c4226824efa52ceb14e3d8518c8bb5c7465fc.1757902513.git.dkx@t-chip.com.cn>

> +&gmac0 {
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy0>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_miim
> +		     &gmac0_tx_bus2
> +		     &gmac0_rx_bus2
> +		     &gmac0_rgmii_clk
> +		     &gmac0_rgmii_bus>;
> +	status = "okay";
> +};
> +
> +&gmac1 {
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy1>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac1_miim
> +		     &gmac1_tx_bus2
> +		     &gmac1_rx_bus2
> +		     &gmac1_rgmii_clk
> +		     &gmac1_rgmii_bus>;
> +	status = "okay";
> +};

> +&mdio0 {
> +	rgmii_phy0: ethernet-phy@1 {
> +		compatible = "ethernet-phy-id001c.c916";
> +		reg = <0x1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&rtl8211f_0_rst>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio3 RK_PC0 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&mdio1 {
> +	rgmii_phy1: ethernet-phy@1 {
> +		compatible = "ethernet-phy-id001c.c916";
> +		reg = <0x1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&rtl8211f_1_rst>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> +	};
> +};

For these nodes only:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


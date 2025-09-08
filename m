Return-Path: <linux-kernel+bounces-806376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99105B495B2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A067340927
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B3D3126CA;
	Mon,  8 Sep 2025 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W8XWzjn0"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23931D6BB;
	Mon,  8 Sep 2025 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349419; cv=none; b=b/vIRtwGHuMw51WuDXmMsShsjOknpBpBe6+peLeW0Vo/XMAppAWyz8q7xKqYCNE74WUHPoVwvs9qVbRxSWGvG0X1FxNm4wpYlB5ZbUUHdKJhO/+H/CMFv82ojqn1BlwRyXepdjtl57D6eGBtzbuhIh16IOf8Ks4dbN1JISg3DLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349419; c=relaxed/simple;
	bh=l2HUbLQbbOd4ydEVoUQUaQnQtVY7KJ/hgeR69gZA1rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzGGqqdlMxjpU2PibkuzgXZ1c4/jGGcjUPi4vdV9YGVG9HVo0Olkg6hOz+xVbfxS5cOWs2EbWOsLHEhsp6CiIkhs67TDuOWziU/djsnLCZNg8UH179XbVBKwJHdcDo6bjNBjHus1WuVqcrjDkd+AoXXN3+xPiJ+f6OvMgbjl+NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W8XWzjn0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tIo+HgFDBSGjk+ryK4PE8d8TpiiCG+5aEmtrJp8mr2Y=; b=W8XWzjn0JY78XM1rjlNQr5OpUY
	dXHyf6I+qj/yv6fEtIh9ljgEs0tYlnNlsu1SvcJJ8I83bEcJYaeJZRYsMjy7K6SlgnS9ba9ghfGfC
	akZnwBMaDbsPGXKjbbs6qDtvRfDJxQgfdXCWXDWbymYozZsfUKUTwC8Kbzdk7wW6MOH0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uver6-007gmH-9h; Mon, 08 Sep 2025 18:36:36 +0200
Date: Mon, 8 Sep 2025 18:36:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kaison Deng <dkx@t-chip.com.cn>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Wayne Chou <zxf@t-chip.com.cn>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Peter Robinson <pbrobinson@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add devicetree for the
 ROC-RK3588-RT
Message-ID: <153e5099-ee64-4ce9-b70e-feb24d8731cb@lunn.ch>
References: <20250905090115.718622-1-dkx@t-chip.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905090115.718622-1-dkx@t-chip.com.cn>

> +&gmac0 {
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy0>;
> +	phy-mode = "rgmii-rxid";

The usual problem with rockchip boards. rgmii-rxid is probably wrong,
unless you have a very odd PCB.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_miim
> +		     &gmac0_tx_bus2
> +		     &gmac0_rx_bus2
> +		     &gmac0_rgmii_clk
> +		     &gmac0_rgmii_bus>;
> +	tx_delay = <0x47>;

Please try rgmii-id, and small values here.

> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy1>;
> +	phy-mode = "rgmii-rxid";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac1_miim
> +		     &gmac1_tx_bus2
> +		     &gmac1_rx_bus2
> +		     &gmac1_rgmii_clk
> +		     &gmac1_rgmii_bus>;
> +	tx_delay = <0x42>;

Same here.

	Andrew


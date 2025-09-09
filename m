Return-Path: <linux-kernel+bounces-808158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FE3B4FAE9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67AE11C601BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40081EDA26;
	Tue,  9 Sep 2025 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DnNXlQ0+"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8ED1E834B;
	Tue,  9 Sep 2025 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421113; cv=none; b=DhyL2X9bbreL0IRnlFWXKra8TZaLNciZW9MIkXY8RxBaN+Rb3P1ToM85Y68+fSKj3okX5mkWksdm9wUzk7C1Mt4y+0DP38/dy78ahWHqnvG6gLOLx0DiPWdV4CJrHQL436Pins/slT78N3IpraUPVnBwWcPqBK4SE/i8vGqrWr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421113; c=relaxed/simple;
	bh=bXQaege6iolgoIpnVPRp6p2C/Ls2F/5piJhOZpbLPIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1GjhPhh66aJOUMqKAiktFnxLf50I96UN21HpoBeMfvkvn0m27DPozhz8GNKMtmj02blyznynHatauW3hSMdggRktWXFtn9Dfjl81nZNBZMRM/TMgLy22aPtQ73nSW6ChoVmnGaiRIMdbxwGYIEdj1I1kXL9QgiRIViGxKemHYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DnNXlQ0+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gu0aDdw2yCaFAqkxdtah8DUDl9FQjS2LgWWADairsGw=; b=DnNXlQ0+zLuyTXLWphWT9DDau3
	mFybIqE4+Vg2jII/qlncvNiqjALvYnZ00ul56WRWZBy4z5AOPKXHxqeK/UaMZUjOSvskGnV6ylGhF
	iPnkYynjB9HIAbmJplOVSA2X0OQL8vYd+luuhrEIKj3/9W43L1OC1e7FXloV/tgGajrE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uvxVQ-007nOT-18; Tue, 09 Sep 2025 14:31:28 +0200
Date: Tue, 9 Sep 2025 14:31:28 +0200
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
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add devicetree for the
 ROC-RK3588-RT
Message-ID: <307a76a6-cc92-44a1-9ac0-97005bf51b4b@lunn.ch>
References: <cover.1757322046.git.dkx@t-chip.com.cn>
 <42ae6d16ed9162582e7b03cbad661a7950c0db55.1757322046.git.dkx@t-chip.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ae6d16ed9162582e7b03cbad661a7950c0db55.1757322046.git.dkx@t-chip.com.cn>

> - 2x Gigabit Ethernet, 1x 2.5G Ethernet

I actually only see the 2x 1G. Is the 2.5G not supported yet?

> +&gmac0 {
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy0>;
> +	phy-mode = "rgmii-rxid";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_miim
> +		     &gmac0_tx_bus2
> +		     &gmac0_rx_bus2
> +		     &gmac0_rgmii_clk
> +		     &gmac0_rgmii_bus>;
> +	tx_delay = <0x47>;

What happened about my comment that "rgmii-rxid" is probably wrong?

If you think it is correct, you should reply with a
justification. Maybe PCB is very odd? In which case, a comment would
be good to explain who it is odd.

	Andrew


Return-Path: <linux-kernel+bounces-747147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E601B13054
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E8A3B1DE8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF1C21A928;
	Sun, 27 Jul 2025 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IfLEU1z+"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7410FD;
	Sun, 27 Jul 2025 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753632954; cv=none; b=JS7+xrL4pcILbZOv3o0pBF514d2wU3HefSocQm7xLnD5CJeMdKSj1iStjMc9TTRI0TLqR2ESk8B7P7Lc+pPTjyAjYzUcCi5HEoO6IaWSXBH9fEZjwVF5YvLk1YuWY42RpGfkwtarFX9pb8pWGM1g1jCF4PZTpJM5WJYF3nwCVQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753632954; c=relaxed/simple;
	bh=tIc7sWAFiBmshEeA1ugd4kIW4FsQbHOZEMZXdR/QfY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fahW/wZIO1VJFB5CUgORHOhENR8tVtecIYNWbYvcAL1/K0GOHl59KTm+7QPOT2GVTtz8PO13UXhKDO0xfM/yyAw0+Laa4kL1UsLKAmC4rE/sBUX3y687DKqcDYdxlAJp6r/ZFffRdYp6/bgP3V/vSewgy5khJ6F4+8sjER3z6kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IfLEU1z+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kW+ZOJQ+5A57SHI4wkNLifBLUPO0LzEY2L+nW9nNAMw=; b=IfLEU1z+PcoCX4MpyXlmxy8V8z
	5ZEHb7qQ1EDl5XZYu3Q8twiHPyYuZOg7dmawgozupzVJiZA4UYWK+ygeSs01hCOJeUvdE5N1aQK3v
	Qsb2nEFqHpAGmgMql3Pxdg92tcc8mX83ZKbaa7hNkLDFK2LsrkBjBRQfFRcGDV7IvNC8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ug42A-0030pL-Vc; Sun, 27 Jul 2025 18:15:34 +0200
Date: Sun, 27 Jul 2025 18:15:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Radxa E24C
Message-ID: <72d979e8-005a-4d4d-b5d2-3f59e78574de@lunn.ch>
References: <20250727144409.327740-1-jonas@kwiboo.se>
 <20250727144409.327740-4-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727144409.327740-4-jonas@kwiboo.se>

> +&gmac1 {
> +	clock_in_out = "output";
> +	phy-mode = "rgmii-id";
> +	phy-supply = <&avdd_rtl8367rb>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii_miim>, <&rgmii_tx_bus2>, <&rgmii_rx_bus2>,
> +		    <&rgmii_rgmii_clk>, <&rgmii_rgmii_bus>, <&gmac1_rstn_l>;
> +	status = "okay";
> +
> +	fixed-link {
> +		speed = <1000>;
> +		full-duplex;
> +	};

A fixed-link without an obvious reason gets me asking questions...

The schematic indicates there is a realtek 6387 switch on the other
end. rtl8365mb.c seems to support this. Is there a reason you did not
include this now?

	Andrew


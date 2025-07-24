Return-Path: <linux-kernel+bounces-744616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A51B10F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945641D022D2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C022EAB96;
	Thu, 24 Jul 2025 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dipFsxOL"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9082EA142;
	Thu, 24 Jul 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372285; cv=none; b=Klwek2ams04UypR+lvbv58DxZ2dLowiQQe4HlNoxbLcxKe6DKXnbFQXPtNEmMmGMoogjyp1SzXrS4kQ3+8X+lCvDeYWpFR3h5ow17bNdKDx8/5zELilQNV6J1NpvXmA86TNPKMN+Nh3gyG1hHAfMSj8qIQnTqlv+VFwRTiCAO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372285; c=relaxed/simple;
	bh=1ge4D9flOXAuVIts9W508hRo5GpACuOYYM9W6/tsUog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3+R1p2z4aTU1ZM/YCSKrIl0Bn/sMwuA0Ol5mEwqxZQKMcETL+YtGbM3a2YjCvO5duhyWmVDBNF4qnREdXvCZuyJRFSR2M1RyzZjRzisyHCr0rhLzG6HIpy8dEuvgqqg8olGm0UFFs6JzR2Ch8RsLLuK/gmuUKi2vva6G+VfI0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dipFsxOL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=841zC2Csr85cTavsucPR9yszjss8BCSvwiJmornsOZ4=; b=dipFsxOLF+O/7PNONN9fA+tmfI
	r0/k1NhJR56ETFx7iQNjhzYFKwuZY70M8OWlq8vE4SVINnqQfqQK3xeRjp695GEIjkT69sMhR0ljG
	baoKhaI4VDTne5f/s6cXGs0jQ+e2ANtioX1VshDhrut4dAfhOOWfqFEQNebN1s+aQQdw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ueyE0-002mMX-Op; Thu, 24 Jul 2025 17:51:16 +0200
Date: Thu, 24 Jul 2025 17:51:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH] arm64: dts: rockchip: use MAC TX delay for ROCK 4D
Message-ID: <f22243f5-759a-4ff2-8d14-6edb49d87c52@lunn.ch>
References: <20250724-rk3576-rock4d-phy-timings-v1-1-1cdce2b4aca4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724-rk3576-rock4d-phy-timings-v1-1-1cdce2b4aca4@kernel.org>

>  &gmac0 {
>  	clock_in_out = "output";
>  	phy-handle = <&rgmii_phy0>;
> -	phy-mode = "rgmii-id";
> +	phy-mode = "rgmii-rxid";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&eth0m0_miim
>  		     &eth0m0_tx_bus2
> @@ -246,6 +246,8 @@ &eth0m0_rgmii_clk
>  		     &eth0m0_rgmii_bus
>  		     &ethm0_clk0_25m_out>;
>  	status = "okay";
> +	tx_delay = <0x20>;
> +	rx_delay = <0x00>;

What does 0x20 mean? Is it less than 2ns, or greater than 2ns?

Have you tried "rgmii-id" and small values for tx_delay? If the
hardware needs 2.1ns, for example, the MAC could add 0.1ns and the PHY
adds the default 2ns. That would allow you to conform to the DT
binding.

What PHY is this? Have you looked it you can control the delays the
PHY adds? If you actually need a delay of 1.9ns, maybe the PHY can be
configured to do this? That would also allow you to conform to the DT
binding.

	Andrew


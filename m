Return-Path: <linux-kernel+bounces-812243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15670B534EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA205AA276B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB07B337682;
	Thu, 11 Sep 2025 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zAYMqDb3"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DB83314CC;
	Thu, 11 Sep 2025 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599794; cv=none; b=BShRcSC6Y2I8ugcM6cZS1xQJt+byqErK+3RDCckj8qUh6mXckEs7Fv/tFzoAB8ZATxX6PZFLFSultOjo3pe7AxI9rnL87ECK1G1dTeKd5HIa3HapxLndCaEV4fIGrSwX9jwIJ9W0SLkJNGNYpthZLcW9xyiHFCMnIVCMbUKwxiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599794; c=relaxed/simple;
	bh=oEpQbz08KIQIjmYjW4TF8QaIfqdMPLGPiCOahYPFnu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XycrcBneMfaSg5yGJN7J7UsWJNRO6sBDt2YEBRML5V18/oAu+i4QeJnmqIBxSItPwBZ16tfZHqi9AULwEIN8/KKiUhdcbh1oUDnLoXVCRb3CVs8RI2fj5Yc2LxI03n6qDpCC/CdJGEIDQM3M0XwLjFQX6PPQ115+Ew1TMzstNMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zAYMqDb3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UTOFlXWDRobea92uCzaSAenu3tACfKoporlUKOZNwkA=; b=zAYMqDb3NB78c7pxSOBOHgTqCO
	zH9pcex8Gn8Bl2yKiHF1FxhZm3/Sj1cNPlYKcA2EG0Y9eCbwBx+ALxGJt498GEKlMUupshhaQK1q7
	YoLAowsS0fLwn5NeD5tOEeDYjU9XScIYzBhn5J3o4oaBGYmo/CXkfeYFWN3E1cpUEVwQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uwhzS-0085aR-Vh; Thu, 11 Sep 2025 16:09:34 +0200
Date: Thu, 11 Sep 2025 16:09:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rebecca Cran <rebecca@bsdio.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
Message-ID: <58a092c5-5dd0-4718-831a-e25ecb184087@lunn.ch>
References: <20250911051009.4044609-1-rebecca@bsdio.com>
 <20250911051009.4044609-3-rebecca@bsdio.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911051009.4044609-3-rebecca@bsdio.com>

> +&mac0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii1_default>;
> +	clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
> +		 <&syscon ASPEED_CLK_MAC1RCLK>;
> +	clock-names = "MACCLK", "RCLK";
> +	use-ncsi;
> +
> +	nvmem-cells = <&eth0_macaddress>;
> +	nvmem-cell-names = "mac-address";
> +};

There is no phy-handle here, and no mdio node in this file. What is
the MAC connected to? Does it connect to the hosts Ethernet interface?

> +
> +&mac1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
> +
> +	nvmem-cells = <&eth1_macaddress>;
> +	nvmem-cell-names = "mac-address";
> +};

RGMII pinctrl is referenced here. This opens up the question about
RGMII delays. What is this MAC connected to?

	Andrew


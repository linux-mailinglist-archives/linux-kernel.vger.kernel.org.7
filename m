Return-Path: <linux-kernel+bounces-861525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0886ABF2F31
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94C734F818C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE1C23D7CA;
	Mon, 20 Oct 2025 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oO/nBleE"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF8418871F;
	Mon, 20 Oct 2025 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760985281; cv=none; b=Vj6LQ7tHOGhon3v5waYe5d1GNaHZFBqSVAq8RiCjCrvufXNu0RlQJpF/m9AMh09hGEsFIblBLyJNiwa95ZxddIZAVwgDvNTMFWtmG8zA3LjJNDVZgaDHOJr6T9CrbiAW1kxfFt0SszgJoJoRsFnCJxnUqAZ2dsKw9v6PLL0tXfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760985281; c=relaxed/simple;
	bh=gjS3HaZTB70SN0CMIVUcsMKXvKTA6y0cr7ybQ3Mlt9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CM3afk4ypwtXOy+jaAXeZkopa/Pfl6moiQdgceJ8VrANk2zsR+VvfjPcfqAAK/w98uCP1kFvROle+UcPSm9rg6V9IhQCWzBcd4bUWYMz8HNgyaC29Jb+jdwsBZpf1wZ8a9QoYGLhYlkz8EVp6duNiWdLEi/A8pIcCpuYQ1oSNZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oO/nBleE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mvskDAhgWUe7l3foP8MvPa+nL/C2ovcPgG7OHEUBg4A=; b=oO/nBleEU72BSGluGqPQJeZ+wr
	D4SLjlJ6hrZ2ZyhkPwVIQjHhqmHpnCF6G40Yyt8xewCREWNbzvrea4YgbKnyFqWXpf/5m34v47FEu
	1PH3dY5n5BR2wb2L5HW/EaJv+C2zuuvRHDSAMjLaxlZaB46Tbhd0qYJE7sIImVhE8ly8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vAui0-00BY2M-30; Mon, 20 Oct 2025 20:34:16 +0200
Date: Mon, 20 Oct 2025 20:34:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH v2 2/2] arm64: dts: ls1028a: Add mbls1028a and
 mbls1028a-ind devicetrees
Message-ID: <14f52170-cc5b-4808-8fc1-28685ba349dd@lunn.ch>
References: <20251020133536.303471-1-alexander.stein@ew.tq-group.com>
 <20251020133536.303471-2-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020133536.303471-2-alexander.stein@ew.tq-group.com>

> +&enetc_mdio_pf3 {
> +	mdio0_rgmii_phy00: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x00>;
> +		reset-gpios = <&gpio_exp_1v8 1 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <1>;
> +		reset-deassert-us = <200>;
> +		interrupt-parent = <&gpio_exp_1v8>;
> +		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;

PHY interrupts are generally level not edge. So this is probably
wrong.

> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_50_NS>;
> +		ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,led-function = <0x05b0>;
> +		ti,led-ctrl = <0x1001>;

I really would prefer /sys/class/leds was used. In fact, these are not
documented, and don't even seem to be implemented in mainline. So you
need to drop them.

     Andrew


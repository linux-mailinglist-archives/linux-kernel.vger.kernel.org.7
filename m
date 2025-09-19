Return-Path: <linux-kernel+bounces-823873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693B7B879F6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 520697BA111
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDF2241114;
	Fri, 19 Sep 2025 01:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vLbyscUK"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0954C34BA29;
	Fri, 19 Sep 2025 01:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758245986; cv=none; b=HIMVxNcWDqAcTBL41fwrT+86WWMwALDt26u+GOUMpkma3IIr3e8ra7dDw5B9mJ2z1RlZvKvPJ+yYqKYl4pf/QBmo7rEC5m6SuLunh6SEUUF4a0V+0Bsgghcmg9Rz06HGj1u1vd1/XXyOQsnalYO6/mBrvrxNEVDVO+feB/NNUGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758245986; c=relaxed/simple;
	bh=ynCNqnXTwPEJv2g/75Gma0Z2FrJEWnhXCHDSE1ih5b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN2QJttmqqq7o7Ezd0O9DxmYurxujeeQmCHtCKQuxQ0WOsert2hlju96mPisLA7pDmFZwSaBQT2ZnptyqCgD7PaORzGdjd9B6G5eGU7tpV5O5V0zzjM2QUOI53AsGkdv4pt07PD0Og67iSQ8hX/NUbDRG5DJ7izUl68SVzgQl8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vLbyscUK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vHqNzBq4yeNhZ0HdWOZVEemDdiXukRj8SR6GX9nPKJU=; b=vLbyscUKRqRX26JCm76EeKpREM
	IjUcX2kfnSBg/N2JDRUTKr4bnjXdSlMLnBBaabwO73++LyvhvAw+dmiZhNlxpPGUIVGWbw8YITdhy
	zMt72x83bup2sW3J0Cm/BAXnyvOHWy6U2pe8OBgw6Y+o33H4Ky9g/hcYyFKgs435gFTs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzQ5w-008tPH-6h; Fri, 19 Sep 2025 03:39:28 +0200
Date: Fri, 19 Sep 2025 03:39:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marc Olberding <molberding@nvidia.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dts: aspeed: Add a dts for the nvidia msx4 hpm
Message-ID: <ebf28e23-1ee1-456c-8cfd-ee5c02effeeb@lunn.ch>
References: <20250918-msx1_devicetree-v1-0-18dc07e02118@nvidia.com>
 <20250918-msx1_devicetree-v1-2-18dc07e02118@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-msx1_devicetree-v1-2-18dc07e02118@nvidia.com>

> +// bootloader takes care of proper mac delays for now.
> +// phy-mode is here to prevent breakage once the aspeed
> +// mac driver is fixed.
> +&mac0 {
> +	phy-mode = "rgmii-id";

Just for my understanding, by "bootloader takes care of proper mac
delays for now" you mean you have a 'hacked' bootloader which no
longer adds delays, unlike the stock aspeed bootloader which does add
delays? Because otherwise, i don't see how rgmii-id will work.

> +	phy-handle = <&ethphy3>;
> +	max-speed = <1000>;

RGMII cannot do more than 1G, so max-speed is pointless.

	Andrew


Return-Path: <linux-kernel+bounces-745774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21906B11E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9691CC61F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5E7247296;
	Fri, 25 Jul 2025 12:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uQBRNsr/"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40A81A38F9;
	Fri, 25 Jul 2025 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446095; cv=none; b=D6mq3e9iqSmQV4jadol+XhL66hASzfCKVrpo7/qFA+lzPqHAfbeT+vXKEtnFajhyDL+pl8G3LjZ1oFnCnEA9NhRjycKrxNOdn0STsYtighdCHw9IcAwNzJVMZ4NDgYxIDdGK6rOoFste8MUY5A07opVH43CT+aGHeAlwN16t9Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446095; c=relaxed/simple;
	bh=jBrw0DN+ddgb8gdLkmqFxOubLYhz6GlmgDXhA61fNr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNcHaouz7++HgNVRWPvUFc5IEN6kOpRA8MLHYu+T2Sj+pw0WUBPa8YyoJIOfAETfKDBTKyVtIzUwElebSqeHYeJ6MQShJK7M7BTcM0zPYTl7HemWhBy0gsla3LlIqspmp/eQ3kHN68a9jWvN79aXlbSGPA7pghJoxIel/bA+bos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uQBRNsr/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VzEE2wp1KsYSjP5PjapuI6k/BdRSLopq4SwBxJM0G+g=; b=uQBRNsr/1NXyUp9/NeMDwD2uZD
	Ube38Esxgns0WJBBo/eDNAdjTih+kR/vEPXVFJ1eBAsBktukl1ZJfTLioqdpPgqorYpTyOpUBcnLL
	dRpVlobuCGe1TjWAPImiP/wd0ITU/R20PjoPuf0FSnrcQzWZc7edKNsom8LXnqCSvk5w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ufHQL-002rXl-Fq; Fri, 25 Jul 2025 14:21:17 +0200
Date: Fri, 25 Jul 2025 14:21:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH] arm64: dts: rockchip: use MAC TX delay for ROCK 4D
Message-ID: <add11c8d-34b1-476c-96b3-964eb2a3de6e@lunn.ch>
References: <20250724-rk3576-rock4d-phy-timings-v1-1-1cdce2b4aca4@kernel.org>
 <f22243f5-759a-4ff2-8d14-6edb49d87c52@lunn.ch>
 <mqoyjn7mnq6tmt6n6oev4wa3herjaxlupml2fmcampwiajvj4a@r5zs4d3jdm5p>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mqoyjn7mnq6tmt6n6oev4wa3herjaxlupml2fmcampwiajvj4a@r5zs4d3jdm5p>

> > Have you tried "rgmii-id" and small values for tx_delay? If the
> > hardware needs 2.1ns, for example, the MAC could add 0.1ns and the PHY
> > adds the default 2ns. That would allow you to conform to the DT
> > binding.
> 
> The MAC code (drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c) looks
> like this, so "rgmii-id" results in no MAC delays being applied:
> 
> 	case PHY_INTERFACE_MODE_RGMII:
> 		bsp_priv->ops->set_to_rgmii(bsp_priv, bsp_priv->tx_delay,
> 					    bsp_priv->rx_delay);
> 		break;
> 	case PHY_INTERFACE_MODE_RGMII_ID:
> 		bsp_priv->ops->set_to_rgmii(bsp_priv, 0, 0);
> 		break;
> 	case PHY_INTERFACE_MODE_RGMII_RXID:
> 		bsp_priv->ops->set_to_rgmii(bsp_priv, bsp_priv->tx_delay, 0);
> 		break;
> 	case PHY_INTERFACE_MODE_RGMII_TXID:
> 		bsp_priv->ops->set_to_rgmii(bsp_priv, 0, bsp_priv->rx_delay);
> 		break;
>     ...
> 
> Also the default values (if properties are missing in DT) are
> rx_delay=0x10 and tx_delay=0x30, so changing this logic risks
> breaking some boards :(

Just as an experiment, could you enable setting delays for
PHY_INTERFACE_MODE_RGMII_ID and see if small values do work for you.

If they do, we can then figure out a way to actually do it without
breaking other boards.

	Andrew


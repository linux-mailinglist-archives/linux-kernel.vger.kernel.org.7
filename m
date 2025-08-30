Return-Path: <linux-kernel+bounces-793169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37B5B3CF8C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 23:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7FE37A6C8B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 21:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECD52066DE;
	Sat, 30 Aug 2025 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1GcTLIcV"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EB71863E;
	Sat, 30 Aug 2025 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756589444; cv=none; b=JUO2MsWBS0PPQI1zPoVAsc5eRrsha6KZuQgQakT6ZSrA08VPPrMkrpK9zvQCkE4J6TUBDZEE8k4a0fP3oOJG63ZeajCUhEtUSqUeZhQYwN3ojKjRilsqEBR8JBSUiN8vFXZL/ban/kih3CaOHfnXXpir+4bi7n52Kt0HZ12VCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756589444; c=relaxed/simple;
	bh=oV91FeE4ROwonoBbLadc43J56G97ySWPotWiaqNyJAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlXtY4XsJNE35uNCo1ohyUB8rzr2ivggbJQzPnSidoiV7iRl2JZvrNFjpobtt4pe6WsJN7rMLkPZjUgR6p18goOXLLBMYUakzGxf67ysBs6U51Dmuo3xU+FMuiYXRTVo4JpM70zOrxBfqoxjOkgKe6ZjH157edtrASkhdYhqRnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1GcTLIcV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1Baiur+XsL6xJjFj12NhEXn8Az4xq+GU7LaN0fj/cCo=; b=1GcTLIcVFiP+2ZlfyKuDE8pWvD
	Qv4pCZ+hjFDmzYM25qbASxwFYJcbBJYNEo2K/+RaAsTk2+YdFcWnQV0rvm6zdHTP/aHY4f+HYMcvj
	GDVVki5uYt5WAlcfVVUMIpud8vffMJIyYJ+GgxSAOhaTtBmFIgZt+T401xNxrJfPlnVM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1usT9g-006c6E-5c; Sat, 30 Aug 2025 23:30:36 +0200
Date: Sat, 30 Aug 2025 23:30:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Erik Beck <xunil@tahomasoft.com>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add HINLINK H68K
Message-ID: <021c2e76-cbde-4a2e-a165-a61223cdff93@lunn.ch>
References: <20250818100009.170202-1-amadeus@jmu.edu.cn>
 <20250818100009.170202-4-amadeus@jmu.edu.cn>
 <20250830171409.592c1f63.xunil@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830171409.592c1f63.xunil@tahomasoft.com>

> > +&gmac0 {
> > +	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
> > +	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>;
> > +	assigned-clock-rates = <0>, <125000000>;
> > +	clock_in_out = "output";
> > +	phy-handle = <&rgmii_phy0>;
> > +	phy-mode = "rgmii-id";
> 
> Please change phy-mode here to "rgmii". This change will yield an ethernet
> speed throughput change of a factor of 100+. 

Rockchip by default do bad things with RGMII delays.

  tx_delay:
    description: Delay value for TXD timing.
    $ref: /schemas/types.yaml#/definitions/uint32
    minimum: 0
    maximum: 0x7F
    default: 0x30

  rx_delay:
    description: Delay value for RXD timing.
    $ref: /schemas/types.yaml#/definitions/uint32
    minimum: 0
    maximum: 0x7F
    default: 0x10

Try setting both of these to 0. And then use 'rgmii-id'.

	Andrew


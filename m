Return-Path: <linux-kernel+bounces-757199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A024B1BF00
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C4062776B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB421E0DD9;
	Wed,  6 Aug 2025 03:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w+3l+Dsi"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6F3190676;
	Wed,  6 Aug 2025 03:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754449428; cv=none; b=tij0Qo5FqJcApXdwiaUipNnLwGui65Zsz0hZETso70xUBmBD7ENFuRdq3sj7I/4vbc1HS4ITok3ZnkZlnCqUlT0pkBoa4eW4eydwDFcH31d+b1xWi77u+2uR3VdcbSEdO6PCLnkr79Z4BOHPDKhI/hO2ECK9EOw2jW2jtoHKXo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754449428; c=relaxed/simple;
	bh=0ANyj2k6YdrkOVdwRG1Q2t1sdgmZXj1r7jhRTU/J5e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFXctRRJ+EtXz2hrwlvwm/k6UZ4/VrIuWnJsgLZhDzdNwE1BYsT+Ng0qsc2NwKS8WkdP2tmJvsuAjwSXlSElXdwm+YrP37g9EZpbvre2ifXAyNMuSF2bSJiqVdrdKQvsAcUUahV6FfSxeQrNyyqhc/P7nDYFYu/JgyY2HyM8GXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w+3l+Dsi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Tr7NN2jphfR6xHA/UzGXZWi6sl0YOUmnWotym5mZwz4=; b=w+3l+DsiNEdtl4SdPo25MfoSwx
	6zeqoaeDGmSxgzZ9JnskLH7Dz9SULlis8/dRT0QOqH/Y1EtVKBrEC3uQEsYfEYxYKm1c3ZEDnWwk5
	DHX5iBtN23GQB1oNZdi/GBgRSA0gned3RSnZrlzpkmj1vuZxQlxck5hyU2fafIu61at4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ujUR3-003qp3-Fc; Wed, 06 Aug 2025 05:03:25 +0200
Date: Wed, 6 Aug 2025 05:03:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mo Elbadry <elbadrym@google.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rom Lemarchand <romlem@google.com>,
	William Kennington <wak@google.com>,
	Yuxiao Zhang <yuxiaozhang@google.com>,
	"wthai@nvidia.com" <wthai@nvidia.com>,
	"leohu@nvidia.com" <leohu@nvidia.com>,
	"dkodihalli@nvidia.com" <dkodihalli@nvidia.com>,
	"spuranik@nvidia.com" <spuranik@nvidia.com>
Subject: Re: [PATCH v12 3/3] clk: aspeed: add AST2700 clock driver
Message-ID: <e53edafb-bfb0-45ab-8224-7b393af4e0ad@lunn.ch>
References: <20250708052909.4145983-1-ryan_chen@aspeedtech.com>
 <20250708052909.4145983-4-ryan_chen@aspeedtech.com>
 <OS8PR06MB7541E7FCB367AE610EBBE121F249A@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <CAOO6b=tEigCRXZ47BMgsTvxiZdO0P32+jFhQ313O044VALgaWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOO6b=tEigCRXZ47BMgsTvxiZdO0P32+jFhQ313O044VALgaWA@mail.gmail.com>

> > > +static const struct clk_div_table ast2700_rgmii_div_table[] = {
> > > +     { 0x0, 4 },
> > > +     { 0x1, 4 },
> > > +     { 0x2, 6 },
> > > +     { 0x3, 8 },
> > > +     { 0x4, 10 },
> > > +     { 0x5, 12 },
> > > +     { 0x6, 14 },
> > > +     { 0x7, 16 },
> > > +     { 0 }
> > > +};

> > > +     DIVIDER_CLK(SCU1_CLK_RGMII, "rgmii", soc1_hpll,
> > > +                 SCU1_CLK_SEL1, 25, 3, ast2700_rgmii_div_table),


Historically, aspeed has got RGMII delays wrong. Could you confirm
this has nothing to do with the 2ns delay needed by RGMII.

What exactly is this clock used for? RGMII needs 2.5MHz, 25MHz and
125MHz, which none of these dividers seems to provide.

	Andrew


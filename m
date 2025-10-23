Return-Path: <linux-kernel+bounces-867569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D95C03049
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C9C45000B4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6B6357A4C;
	Thu, 23 Oct 2025 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ycDkGYCD"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFC2357A30;
	Thu, 23 Oct 2025 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244123; cv=none; b=RbapCfyBGp8J7b0UqNcDk4NXc57CDkSr42bU3Foxvuw+CGkE5Ew3jpx6EBPXg2W2deDZDjaw8uA03wptugCU6q90XOqUrZe6TrzfAekh5ZfnBmQotc3Wj/6AiOXAXWZAEV9T5FELSXyYEf06rxP7FJbLiMLCs/D6fj0JQRI6R9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244123; c=relaxed/simple;
	bh=c3eaLxRv9DK1B2bJ++OogNfbgEJuTk+yVGexKAnPA8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgqJXXR7X2MfbjIdjDaapekE9Kmz/1wcw1FzHqQzCa37ihScJS86w5/mZkuZB1XdjNXg5fRkmINZO7HiaXQV4t02bbt8h0B6XKNLfZZikQ06Rez5ZMSDhZw90IKuLV+5lwj5uTqgTK7Eqo3tpr5SH33b2h151y06P2xzZJYCIqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ycDkGYCD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dF8Bsuxs1bOw/Vu4h6JauGctQLAvBIWDKoMFcT9IHNI=; b=ycDkGYCDrUPhwkysgMTElO7lrA
	oERm9YjauhNyWsqRqlB3gXptN4R4DH72ymIRKKbzc1/7OkCcI2fZAh76tcJ2Ij/Vkj2XkTYfdvDR9
	kHTNA76wKvjT4ijztRf1xYtkrLcZ4kgnDBdN/KpoAk4GPM4ZX169WMM14ZnspA1FGLmo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vC02b-00BuNV-VB; Thu, 23 Oct 2025 20:28:01 +0200
Date: Thu, 23 Oct 2025 20:28:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Arnd Bergmann <arnd@arndb.de>, BMC-SW <BMC-SW@aspeedtech.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Jeremy Kerr <jk@codeconstruct.com.au>, Lee Jones <lee@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Nishanth Menon <nm@ti.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Taniya Das <quic_tdas@quicinc.com>,
	"Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC
 device tree
Message-ID: <b048afc1-a143-4fd0-94c9-3677339d7f56@lunn.ch>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
 <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>

> > > +		mdio0: mdio@14040000 {
> > > +			compatible = "aspeed,ast2600-mdio";
> > > +			reg = <0 0x14040000 0 0x8>;
> > > +			resets = <&syscon1 SCU1_RESET_MII>;
> > > +			status = "disabled";
> > > +		};
> > 
> > I see that you use the old compatible="aspeed,ast2600-mdio" string exclusively
> > here. While this works, I would suggest you list both a more specific
> > "aspeed,ast2700-mdio" string to refer to the version in this chip as well as the
> > fallback "aspeed,ast2600-mdio" string as the generic identifier.
> > 
> > The binding obviously has to describe both in that case, but the driver does not
> > need to be modified as long as both behave the same way.
> 
> Thanks, will submit ast2700-mdio. 
> Question, should I add in here patch series?
> Or go for another patch thread?

Please submit it to net-next. Since you will have aspeed,ast2600-mdio
as a fail back, it will work until everything meets up in linux-next.

	Andrew


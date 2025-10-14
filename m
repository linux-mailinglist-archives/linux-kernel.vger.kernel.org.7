Return-Path: <linux-kernel+bounces-852536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2829BD93BE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C65544FFFD7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098D9311C2E;
	Tue, 14 Oct 2025 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CaQ79jPN"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F933126A1;
	Tue, 14 Oct 2025 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443735; cv=none; b=dImV/to9mRUTAIymHPIHlE78eoCKSpukORFxhQt4LEmTnXkLju4Angwr1ptYdDmPa8kKrjAkEfyOOKpqXTEn93IHGDrdn7dFrd1OzZoStZgMNl/m7Er6Ox2MfS3BM6XhMW89KN6J+PjTTXrnSy/JaSwFP0IJThzE9hS9SMPJmb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443735; c=relaxed/simple;
	bh=Pn+Q8Vt5qDMaXhybyO8jnUDB3KhXjwrS4FwaLvZqrso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h69uIN28ZqCdSn9ArWkk/fToTSZeVLozKNQB8Cpa9GcsKjy2mNSfAP92a0UTJ7Tq25X0A/JJDnY0Tv7rUbplhybt+tv+OWBEiHz05fGUHrt81LRfnY+EW9F2Z645le/ddoDDaUwzP8+mTLsM9qBgMtcYURLqVhC5hZESqyLozxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CaQ79jPN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mW5/QLinbAfVE5ha1MwCMCncckpC/haHYS4j6AucDUM=; b=CaQ79jPNVv0wPdoAWonJgGYDDJ
	gN1JXn/Rp/A1HbhvqmmaPtJDfQsExftP0rQlILsYHlyIGaFfzwj5gZmNvoZ3u+6PA6ZcL8uQm1z1U
	PFBjUFwUsrZYhAfYS3amge6/P9iVXqJ1LHl8qp+glaxGfsSXFr4Dnx0cueO2rGMbB0ZY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8dpC-00AuCb-Ud; Tue, 14 Oct 2025 14:08:18 +0200
Date: Tue, 14 Oct 2025 14:08:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tao Ren <rentao.bupt@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include
 facebook-fuji-data64.dts
Message-ID: <ea64d3c1-e517-4bd8-9a2e-56432f286347@lunn.ch>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net>
 <aO2kLyxGlGt12sKD@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO2kLyxGlGt12sKD@fedora>

On Mon, Oct 13, 2025 at 06:15:27PM -0700, Tao Ren wrote:
> Hi Guenter,
> 
> On Mon, Oct 13, 2025 at 05:20:57PM -0700, Guenter Roeck wrote:
> > Hi,
> > 
> > On Sun, Jul 27, 2025 at 10:56:13PM -0700, rentao.bupt@gmail.com wrote:
> > > From: Tao Ren <rentao.bupt@gmail.com>
> > > 
> > > Include "facebook-fuji-data64.dts" in facebook-fuji dts to avoid
> > > duplicated code.
> > > 
> > > Fuji-data64 and Fuji are identical except the BMC flash layout.
> > > 
> > > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > 
> > With this patch in the mainline kernel, the Ethernet interface I use for
> > testing does not come online when loading fuji-bmc in qemu.
> > 
> > Reverting this patch fixes the problem.
> > 
> > Looking into this patch,
> > 
> > > -
> > > -#include <dt-bindings/leds/common.h>
> > > -#include "ast2600-facebook-netbmc-common.dtsi"
> > > +#include "aspeed-bmc-facebook-fuji-data64.dts"
> > >  
> > ...
> > > -&mac3 {
> > > -	status = "okay";
> > > -	phy-mode = "rgmii";
> > > -	phy-handle = <&ethphy3>;
> > > -	pinctrl-names = "default";
> > > -	pinctrl-0 = <&pinctrl_rgmii4_default>;
> > > -};
> > 
> > I don't see this in aspeed-bmc-facebook-fuji-data64.dts, meaning that
> > interface is now disabled. Adding it back in fixes the problem.
> > Also, MAC3 is explicitly enabled for fuji-bmc in qemu.
> > 
> > Was the interface disabled on purpose ?
> > 
> > Thanks,
> > Guenter
> 
> The mac3 interface was removed in the latest patch (v4) per Andrew Lunn's
> feedback, because the rgmii setting is incorrect.
> 
> I was planning to add mac3 back as soon as rgmii support is properly
> handled in aspeed mac driver, but kindly let me know if you have other
> suggestions.

If it is already in mainline, i don't care too much if it is wrong. We
don't want to cause regressions.

I only object when adding new nodes which are wrong. If we keep adding
broken nodes, there is no incentive to fix the broken driver to do the
correct thing. Not that me NACKing nodes for the last year or more has
actually made anybody care enough to fix the issue. It seems like
developers are happy to have BMCs without Ethernet in mainline, which
i find odd. There does appear to be sufficient information out there
that anybody could fix this, not just aspeed.

	Andrew


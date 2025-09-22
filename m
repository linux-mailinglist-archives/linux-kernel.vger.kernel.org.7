Return-Path: <linux-kernel+bounces-827869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E21B934EF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115C716DF17
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095B726B779;
	Mon, 22 Sep 2025 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="tFnEbDmr"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16D819994F;
	Mon, 22 Sep 2025 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758574826; cv=none; b=BMODDPocrskQHp6tzrF2J9eALaK+QiEihulAd/dDRiBPISbENC0VZwfX7Er+6ljfw5F/8vIVraMTz5jKyNsCTMaln0CQrDLmqSdjEcU0zgFMK+sAXyvDUlBuMhCU0ewMX10ZA6maWeQVJshQjJn7Mc6FHv/jgAhamQvEF7WXK2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758574826; c=relaxed/simple;
	bh=lVR1JNWr0UqoHEys8ULYA1yMquKH3xNGi3XVd2uTi6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rv0w5BLS2INk8IVRWIPP4QVUeQX5JByt2xOtyXbmn2pzBRfUgb8+nSQEjLinwBtv2hON8MVvoqxZ594OJjNCHvQx7IaK7IguDQ2kv2PEAiGw7S0+TC76/2Qu/EyWatfVdrrmHiHWM3jXcAVEuLSxAVtBW1WejFNEyPzVXqX3JBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=tFnEbDmr; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=asyNZP9neHNXj+Sf6k7sPwKgT9c0m2eBv/rMLNDCtys=; b=tFnEbDmrs/NXUJ6T83/sGy/b1t
	Kz+6rhz0J1rz8uFgGchadwf5BXSxN4p/Pe4DS9blqRMtj98sPJC3c9Bd5Oiy2P3GfNnt+dVGzTvpA
	1bBafaJfnfCSnvIGffRmpqC8Lz426hpYMpk3oUetrXLlRQPKe9fMwTjXyATJCc89WKLXoNR8wOPLs
	VKEnHU5r55IwqRskbiZ9c4dFneKFhIMIvEMI8rQjf2h5mDdodOsL9dn5TgP5+vycrluTcxkqww0En
	mBvDRkte5i9AZdJLflXdVN6pxpuxZzmDG9arg932xgY6sWlzorOBvctN+zdstdd+oCNQqABjm8Hnt
	9TL4GIzA==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v0ndz-00AlmZ-0j;
	Mon, 22 Sep 2025 23:00:19 +0200
Date: Mon, 22 Sep 2025 23:00:18 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Yixun Lan <dlan@gentoo.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Subject: Re: [PATCH 2/3] riscv: dts: spacemit: add 24c02 eeprom on BPI-F3
Message-ID: <aNG44sQf-RfRV9Of@aurel32.net>
Mail-Followup-To: Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
References: <20250921210237.943370-1-aurelien@aurel32.net>
 <20250921210237.943370-3-aurelien@aurel32.net>
 <20250922032158-GYA1291757@gentoo.org>
 <aNDVX9IrDbH2w7yJ@aurel32.net>
 <20250922080105-GYB1291757@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922080105-GYB1291757@gentoo.org>
User-Agent: Mutt/2.2.13 (2024-03-09)

On 2025-09-22 16:01, Yixun Lan wrote:
> Hi Aurelien,
> 
> On 06:49 Mon 22 Sep     , Aurelien Jarno wrote:
> > Hi,
> > 
> > On 2025-09-22 11:21, Yixun Lan wrote:
> > > Hi Aurelien,
> > > 
> > > On 23:01 Sun 21 Sep     , Aurelien Jarno wrote:
> > > > The BPI-F3 contains a 24c02 eeprom, that contains among other things the
> > > > MAC addresses of the two network interfaces. For this reason, mark it as
> > > > read-only.
> > > > 
> > > > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > > > ---
> > > >  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 11 ++++++++++-
> > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > > > index 3b6e4f52e9aad..574d10fdf9b82 100644
> > > > --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > > > +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > > > @@ -115,6 +115,15 @@ &i2c2 {
> > > >  	pinctrl-0 = <&i2c2_0_cfg>;
> > > >  	pinctrl-names = "default";
> > > >  	status = "okay";
> > > > +
> > > > +	eeprom@50 {
> > > > +		compatible = "atmel,24c02";
> > > > +		reg = <0x50>;
> > > > +		vcc-supply = <&vcc1v8_sys>;
> > > > +		pagesize = <16>;
> > > ..
> > > > +		read-only;
> > > so you're sure there is no demand to write data to eeprom?
> > > (update info at linux env)
> > 
> > It seems to only contains board infos (mac addresses), but if there are 
> > other use cases, that can indeed be dropped.
> > 
> On my second thought, I'm ok with it being "read-only", as we flash these
> infos during firmware burning stage, then never alter them later.
> 
> > > > +		size = <256>;
> > > > +	};
> > > >  };
> > > >  
> > > >  &i2c8 {
> > > > @@ -143,7 +152,7 @@ buck2 {
> > > >  				regulator-always-on;
> > > >  			};
> > > >  
> > > > -			buck3 {
> > > > +			vcc1v8_sys: buck3 {
> > > I'm not sure if adding an alias here is a good idea, it occurs buck3
> > > serve the suppy for many devices, besides, to me it's more proper to
> > > name it as eeprom_vcc1v8 for the eeprom according to schematics in
> > > this case..
> > 
> > We need to add a label to be able to reference it for the eeprom 
> > vcc-supply, but we'll have to also reference it for other devices (e.g.  
> > emmc, wifi, phys, etc... It tried to choose a common name, ie the right 
> > most one on the schematics. Another option could be to call it buck3, 
> > but other name suggestions are welcome.
> how about simply making it "buck3_1v8", then probably add a comment
> later in the eeprom node? to mapping to the shecmatics
> 	vcc-supply = <&buck3_1v8>; /* EEPROM_VCC1V8 */

Thanks that sounds good. I'll send an updated patchset with that change.


-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net


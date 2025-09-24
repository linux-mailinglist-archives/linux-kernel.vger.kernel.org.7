Return-Path: <linux-kernel+bounces-831129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5362AB9B9EA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E012172493
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060CA31A56B;
	Wed, 24 Sep 2025 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="V/yZt/KZ"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D45A25484D;
	Wed, 24 Sep 2025 19:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741083; cv=none; b=bqpAmpr3eDiRzOkeZ+p63U98tUwIjG/Io3j+dTuClqWF4AbpO9YF/BxcFgawSzakbrt4jgxQte8xgbsRnJRyucdkSONE1EnmXBTpgAe2OOgkrMcprXSrq+fao4j1jPYxvF6IwyeLX5l4aedBfkBWK8V7oDKTCj99PNkXfcKSlLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741083; c=relaxed/simple;
	bh=Tql5B4YCX1DHSgQvuVLX2THcuwHFiJoliUvfXicXUb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPsvI7VIqjtxlnOcx6iBmKL/rnR9hZrVBNN3MJZjFqAfjatkvSgwMsuvAqUd9naE63QWMfXdAOjRjfuZuGctksJPzbiVWbwYlo8B5ewMBgNvkA4+zsS1Kl/pNiaaw4I/UxOsIicHTTil615tTuqCK6zRJ0za5/Tepq7Kao6i5dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=V/yZt/KZ; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=WLY2FkqvHLDcDGSoIam/kBKhM4hGZeSUFJS4ZsAMQ7k=; b=V/yZt/KZ/VRNT5TrMKm1LX2OCY
	wWNk2pW3rK9KN5iVgszaBEMaaHM7qheK/IpA82nLSWxtF0z/sbVkq99URVZfSCOnGdRzIAhK3HTQO
	7E9pqU8uQyeT0GiydKwuXbqTT+QhVegsU6nEszEFiF5QZSf5JUkkjwT+fO6TrvloebxsCAg2ofc8W
	hq/rNpgIYs7VC5mCSEd2c2diBXA7opqGKceanW2e0qh5MGuLSh/xJmJz5lfLOy1ugoO//W3OVutmn
	KVxBBWd3YW8CIIGTZol/Bod2z/DayJWbyxUXze98vXg+N9Kh5Z+KM9Sl3cGbOIGD4uhva/QP+BkWD
	uuLwqR2Q==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v1UtQ-00DdFY-0o;
	Wed, 24 Sep 2025 21:11:08 +0200
Date: Wed, 24 Sep 2025 21:11:07 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Subject: Re: [PATCH 1/3] riscv: dts: spacemit: enable the i2c2 adapter on
 BPI-F3
Message-ID: <aNRCS1C-M-0JY2cV@aurel32.net>
Mail-Followup-To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
References: <20250921210237.943370-1-aurelien@aurel32.net>
 <20250921210237.943370-2-aurelien@aurel32.net>
 <DC360EB139FD9DE5+aNH4l-7SP5KNu-Br@LT-Guozexi>
 <aNLyIvS-UFfplmpu@aurel32.net>
 <B8749086963B3B54+aNNh9hw4TX6tVMdP@troy-wujie14pro-arch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8749086963B3B54+aNNh9hw4TX6tVMdP@troy-wujie14pro-arch>
User-Agent: Mutt/2.2.13 (2024-03-09)

On 2025-09-24 11:13, Troy Mitchell wrote:
> On Tue, Sep 23, 2025 at 09:16:50PM +0200, Aurelien Jarno wrote:
> > Hi Troy,
> > 
> > Thanks for the review.
> > 
> > On 2025-09-23 09:32, Troy Mitchell wrote:
> > > On Sun, Sep 21, 2025 at 11:01:41PM +0200, Aurelien Jarno wrote:
> > > > Define properties for the I2C adapter, and enable it on the BPI-F3. It
> > > > will be used by the 24c02 eeprom.
> > > > 
> > > > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > > > ---
> > > > --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > > > +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > > > @@ -92,6 +92,13 @@ gmac1-pins {
> > > >  		};
> > > >  	};
> > > >  
> > > > +	i2c2_0_cfg: i2c2-0-cfg {
> > > Should this be i2c2_4_cfg here?
> > > From what I see, in the initial version the second cell was meant
> > > to be the function number rather than the serial index.
> > 
> > Ok, I wasn't aware of that convention, I just reused the same numbering 
> > of the downstream 6.6 kernel. I'll fix that and use i2c2_4_cfg.
> I'm wrong..
> The second number isn't function number.
> You can find a more detailed discussion here:
> (riscv: dts: spacemit: define a SPI controller node)

Ok, I'll revert the change in the V3

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net


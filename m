Return-Path: <linux-kernel+bounces-829547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E2DB9750C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62044C738C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBD7302CDF;
	Tue, 23 Sep 2025 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="BvVYgRT4"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D9F7464;
	Tue, 23 Sep 2025 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655041; cv=none; b=LqAxUX2CfAfRj6+mHEdNa3bSbfBYsJPhRoG/4T04v73o6SHcoV1APz1mNoZdiNGCgRxiDHlQ3EOh+l/J6F7pQ7PEtI7xJnR4spExhbntdh9HFaUKwP1/3G3K9PsSzQ+rUXHczkc0rqHDmIyQFn7OGUzvXu3ZsqYzKDgTVTjCoe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655041; c=relaxed/simple;
	bh=Pi3SNz+uShKCGXI+gMcrVi+CdYh37zlRjLmUIfJJrzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cjym6vmL0KTY9aFPe9T/sDzNy37YyyvKsz+J9O7Nt22HRSuoF9b3/mJyt/Qd6wHwP0igjbW+HJ9Yn0aZodcEBufbALTaRivymlWYnRT3CRTOdVvQcJ1IWypnjKfKyBY9KhuMKaokhx9pbUigp3rGdMF99RdekkjsQWVqxPD31DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=BvVYgRT4; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=I3aY1gk6xWay8Bb6mAUsHpvmGZGsSP2aFgE4+mhPC70=; b=BvVYgRT4iVakErzwm0W+nRRNZz
	66r393iFEHhdjEvLUOmP540XWEPOOQHFvCbXyRPi/7bh/sBW9XaP+e5HI/+5AUuPSciozGBTzlr1W
	UeAjRIHMKLexwUe/WuJBboqGaUPTy8UQO31536BL6AY71+2lcL+4u3BVUITWX8o8O5Z2mXc1J1iIq
	ZB36Nb8AYBlC1lHsxsbcn9QBtMdZ73xdLBtIixNLSHtKBnNOY4M7POPFg9ZsIs1CLsNPrUfNWfhvM
	Okd5mkjpoq8CitSV79OGoVtcJuEjVUcTiJwKZ4I7f5MORkotd/p339mAkuEPc+gWrUyRQ+dnx0IFZ
	jb3TUtWg==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v18VP-00C9on-0M;
	Tue, 23 Sep 2025 21:16:51 +0200
Date: Tue, 23 Sep 2025 21:16:50 +0200
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
Message-ID: <aNLyIvS-UFfplmpu@aurel32.net>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC360EB139FD9DE5+aNH4l-7SP5KNu-Br@LT-Guozexi>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi Troy,

Thanks for the review.

On 2025-09-23 09:32, Troy Mitchell wrote:
> On Sun, Sep 21, 2025 at 11:01:41PM +0200, Aurelien Jarno wrote:
> > Define properties for the I2C adapter, and enable it on the BPI-F3. It
> > will be used by the 24c02 eeprom.
> > 
> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > ---
> > --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > @@ -92,6 +92,13 @@ gmac1-pins {
> >  		};
> >  	};
> >  
> > +	i2c2_0_cfg: i2c2-0-cfg {
> Should this be i2c2_4_cfg here?
> From what I see, in the initial version the second cell was meant
> to be the function number rather than the serial index.

Ok, I wasn't aware of that convention, I just reused the same numbering 
of the downstream 6.6 kernel. I'll fix that and use i2c2_4_cfg.

> It looks like the pwm part is also incorrect.

Yes, and also the submitted PCIE patches.

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net


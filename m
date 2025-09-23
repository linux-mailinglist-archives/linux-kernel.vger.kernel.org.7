Return-Path: <linux-kernel+bounces-829551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D43FB97527
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED82441745
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC51303CB0;
	Tue, 23 Sep 2025 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="zHdsdxEx"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45110303A1A;
	Tue, 23 Sep 2025 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655309; cv=none; b=EKosV/S/w1pDD55YSu5bZRoNgBsclIOTVUUpVxHUb227bj63fCrBq01cYHYyoNWsIwcT2IGwv9n9vd9eJC1rvcZA9poF6oiMwWcM699dv22VnqNUel7S/rLHlSjzZWRY7WcjMJ8wnc8CsoJt/UUiJt4QEUVGd5YVedKlFz+dB4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655309; c=relaxed/simple;
	bh=CLvPFcCRMiWF+MwIQskg2w7hRlClCN44/5kjnldpPPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWxOPb83K6hKkzkSKJalVHK8O4qI0fxjKFK1G7DP1G2NVlpa36g6rtE9rY1jJPocsZAwDOzz8dmrLrAO0X/PoNjbpI5aDUoJ/36U+Q/ZDYTES02leL6Yy1uPXt0KTMJpAmrsGWuSwhPALR2REsv5oMPrIQJWmrclZ4GVScnKgIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=zHdsdxEx; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=a0W6UucVZcsa4tEXRuLEbZNgWX1QiAjb2QntoHbMXRc=; b=zHdsdxEx2uI1cGM05OkrzBseCO
	HNDD0VDiCRNkI1wUbGSRJL5+FgH1tEeR2tp/jwBH1qflQ2bBipj5MOM+OInRHAfT6EmFwg0qeSktT
	tb06SQQQmKOBXpWpqatQYHZqkamzrx2wu4P3zMjG8z6CYSwJckgT2HRFgXD4+dHYFwGcahoKXWMUV
	vFKPtCFEBsuFslYXnpxsW2RcMY8w6OA1jovT5yFOjtS+zb3CWEa5eSTQmfq1M8wZ2bvVrCLynBPGn
	gEy3cOMsmvq6egCE4wNDldIuib8Y79IzUUbBulXz5SmxlQ5Kv2g5oF/6R2owlr8CTQguXuDDhGBUA
	JREGooIw==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v18a5-00CA8A-0F;
	Tue, 23 Sep 2025 21:21:41 +0200
Date: Tue, 23 Sep 2025 21:21:40 +0200
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
Subject: Re: [PATCH 2/3] riscv: dts: spacemit: add 24c02 eeprom on BPI-F3
Message-ID: <aNLzRJcKCYOngc7z@aurel32.net>
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
 <20250921210237.943370-3-aurelien@aurel32.net>
 <6CF6078CFA2EB2F4+aNH_RmNkM_hnsAYu@LT-Guozexi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6CF6078CFA2EB2F4+aNH_RmNkM_hnsAYu@LT-Guozexi>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi,

On 2025-09-23 10:00, Troy Mitchell wrote:
> On Sun, Sep 21, 2025 at 11:01:42PM +0200, Aurelien Jarno wrote:
> > The BPI-F3 contains a 24c02 eeprom, that contains among other things the
> > MAC addresses of the two network interfaces. For this reason, mark it as
> > read-only.
> > 
> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > ---
> >  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > index 3b6e4f52e9aad..574d10fdf9b82 100644
> > --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > @@ -115,6 +115,15 @@ &i2c2 {
> >  	pinctrl-0 = <&i2c2_0_cfg>;
> >  	pinctrl-names = "default";
> >  	status = "okay";
> > +
> > +	eeprom@50 {
> > +		compatible = "atmel,24c02";
> > +		reg = <0x50>;
> > +		vcc-supply = <&vcc1v8_sys>;
> > +		pagesize = <16>;
> I'm not sure this is 16..
> Could you double check it?

Yes, this matches the datasheet:
https://www.giantec-semi.com/juchen1123/uploads/pdf/GT24C02_DS_Au.pdf

It says "Page Size: 16 bytes"

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net


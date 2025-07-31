Return-Path: <linux-kernel+bounces-751808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4841AB16DB9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245864E66EA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D2729DB99;
	Thu, 31 Jul 2025 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="sY/HNNYy"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7AA29E110;
	Thu, 31 Jul 2025 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951186; cv=none; b=GXo56YxfZFCIkbhM3koy01PaYd81qmqtey0vQ0KA/BnHUj4V8tkrrH8L9re/TpGE4CUTPn2FaQ6fehvbDbd+9g3IsjIeU1v+NHcScruuO2s2OIokWPShjrX1PQ5aHLRkIopl39p8QJsSP5b4FXzqA0hAHVV+Qq33GJ2d9SdzJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951186; c=relaxed/simple;
	bh=NxSgPn38YiZ7O0Zhbkwfd9x5HK3nHhT92+wFPLIaR1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qe7h3uP6kyaA6h2KECVtdXqPSy2BB5DdHI8t3fbxMSxv0tKY7VvZoUvimtHVy4PCuAO6USAk26rD5VPUerhKujMvPfv+qP7Nco+c+PWMIv2C7FnOecJBAZLf01ZyVMU9zKsNBshwo2UbyZD0lWtP02DAk8pSmE4Ix46mPUbJwK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=sY/HNNYy; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 237E81489CC2;
	Thu, 31 Jul 2025 10:33:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1753950840; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=zc3Mx14j8K80xB0lRd9HDLb8Pz9PXWcCBqfYHc925VM=;
	b=sY/HNNYyiMmkn4S1KEzQCimuzxSbRTRnnZ/kMULW5UTOdF773t8T3R7UQl4NWwYr0bBfT8
	QDgakuhwq8NMo/XbLR8QYWBDLoxe/KWgFmueynJmzYTX2vZTbhhnHXiKMNLqU3InIRSOtP
	z6iNOjBafb7Ns24Gws9mpjhDPWtdkqxPRp+yzjbtnF4wtZ8+ZlyEoESlwrQhy4REPuMbxc
	UToPwhbDNQF2A1pPfDYlMs4o4axJXYEgTryDNrHfu1PAu8UtyUDwqFlrqsaLfe3bnnhHRH
	azgFqqgobF+DnFZLnCLhWB2cDj7AQhaHNjORNHeijxTBPGjmNX7ZPHEwwqdiVw==
Date: Thu, 31 Jul 2025 10:33:55 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Rob Herring <robh@kernel.org>
Cc: Shiji Yang <yangshiji66@outlook.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Srinivas Kandagatla <srini@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: nvmem: add env-size property for u-boot
 env layout
Message-ID: <20250731-banana-doormat-bd7d3a484dfc@thorsis.com>
Mail-Followup-To: Rob Herring <robh@kernel.org>,
	Shiji Yang <yangshiji66@outlook.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Srinivas Kandagatla <srini@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
References: <OSBPR01MB1670FF3930C3B1736E7EFC23BC24A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
 <OSBPR01MB16702D6947772E526F64D63CBC24A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
 <20250730235214.GA1907865-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730235214.GA1907865-robh@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hei hei,

just hooking in, because it relates to a U-Boot feature I'm using, too.

Am Wed, Jul 30, 2025 at 06:52:14PM -0500 schrieb Rob Herring:
> On Wed, Jul 30, 2025 at 09:17:47PM +0800, Shiji Yang wrote:
> > This newly introduced property allows users to declare the size of
> > the environment storage area.
> 
> Why do you need it to be less than the partition size? They commit msg 
> needs to explain that.

+1

> The partition size for fixed partitions in particular are purely a DT 
> construct. No reason the partition size can't always be the env size.

You can set CONFIG_ENV_RANGE and CONFIG_ENV_SIZE to different values
in U-Boot to allow bad block handling.  I have a board here where the
U-Boot env is stored directly in NAND flash.  The mtd partition size
is 2 times the nand block size (ENV_RANGE=0x40000) while the env size
is exactly one nand block size (ENV_SIZE=0x20000).  So the partition
is 2 blocks, but the env size is only 1 block.  This way the first
block can become bad and U-Boot will skip it and use the second block.
This would not be possible if the env would always use the whole
partition.  The usable size of the partition would be too small to
keep the env then.

The help text for this is present in U-Boot since 2010, so I guess the
feature is there even longer:

  - CONFIG_ENV_RANGE (optional):
  
    Specifies the length of the region in which the environment
    can be written.  This should be a multiple of the NAND device's
    block size.  Specifying a range with more erase blocks than
    are needed to hold CONFIG_ENV_SIZE allows bad blocks within
    the range to be avoided.

HTH & Greets
Alex

> 
> > Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> > ---
> >  .../devicetree/bindings/nvmem/layouts/u-boot,env.yaml      | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
> > index 56a8f55d4..e0b65a53e 100644
> > --- a/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
> > +++ b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
> > @@ -46,6 +46,12 @@ properties:
> >      type: object
> >      description: Command to use for automatic booting
> >  
> > +  env-size:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Size of the environment storage area in bytes. If this property
> > +      is not defined, the default size is the partition size.
> > +
> >    ethaddr:
> >      type: object
> >      description: Ethernet interfaces base MAC address.
> > @@ -85,6 +91,7 @@ examples:
> >          env: partition@40000 {
> >              compatible = "u-boot,env";
> >              reg = <0x40000 0x10000>;
> > +            env-size = <0x1000>;
> >  
> >              mac: ethaddr {
> >                  #nvmem-cell-cells = <1>;
> > -- 
> > 2.50.0
> > 
> 


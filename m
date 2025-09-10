Return-Path: <linux-kernel+bounces-810684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FFBB51DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835111C270D1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F81C270ED7;
	Wed, 10 Sep 2025 16:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKmn/PdS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EDE26E712;
	Wed, 10 Sep 2025 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522193; cv=none; b=a0aJP9l3zoFFwpcpb/NOtjsv1Nfme3VJiQpFfoMRgvNRwYhAaPMoik/A6y4OHTChIZlZMJaHhDOwRQpc/Dsy0IX3qbO7jLvedpakv1+VUTwQXne+OdJUd1XXwWHtgFmC+AUT2FnSf/vMct755/pDSecTn+J6WcEPZicHuoqld+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522193; c=relaxed/simple;
	bh=coJld3U5l8nx5PJCbwdhxAenQ1u3MUhyvC5AMJBni8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKAaBjXOFFtt892KZc5AAonGcV3Iy2DrExXq6PMuO7SLBlfyFoQ5vui+TrMARR9PsHYC4qzdm+uH6UmJo2trkW0uWB/S77yMjRGqHk8oxnSI3bdMr330bMDoPbwdiSWBNTm/KjJ9GXuDdmHyv5n5FImhARC1KJLhkZ2ResolbjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKmn/PdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D85EC4CEEB;
	Wed, 10 Sep 2025 16:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757522193;
	bh=coJld3U5l8nx5PJCbwdhxAenQ1u3MUhyvC5AMJBni8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKmn/PdSjV9iWFR7rII1N4mvAGEJUx3NDyFtTdUC5vbc68oHhBQ2gStakqn/KKWIZ
	 ApWg2fD+IxhUhqBzi+pizYEDQQ19cd4i3P8+pBBC1ZZ8Iwou0r39LE2G713XuFlw6f
	 qRuWRxgt2zoNMeJRiSdn+id5V9cdwaByFoRHjYTqN8Ykv2o4UlvFGWAFJBbKe7wUV/
	 KDzfp0oxZJ/55oaZmb52ypavPPxTdMoCajkh27dRMZc4hbViokvYTTHON3SYHFQ2Lx
	 QYTllcFNL/Dh0KhTd1E+Acf4W6+fUWEeyHj1ztROEFjo1XpldGHGb0Yu5bE71YInna
	 NRC6DnAlwBucg==
Date: Wed, 10 Sep 2025 11:36:31 -0500
From: Rob Herring <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Cheng Ming Lin <linchengming884@gmail.com>, richard@nod.at,
	vigneshr@ti.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	tudor.ambarus@linaro.org, mmkurbanov@salutedevices.com,
	Takahiro.Kuwano@infineon.com, pratyush@kernel.org,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: spi-nand: Add
 enable-randomizer-otp property
Message-ID: <20250910163631.GA142639-robh@kernel.org>
References: <20250910030301.1368372-1-linchengming884@gmail.com>
 <20250910030301.1368372-2-linchengming884@gmail.com>
 <87wm66d67k.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wm66d67k.fsf@bootlin.com>

On Wed, Sep 10, 2025 at 11:09:35AM +0200, Miquel Raynal wrote:
> Hello Cheng Ming,
> 
> On 10/09/2025 at 11:02:59 +08, Cheng Ming Lin <linchengming884@gmail.com> wrote:
> 
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > Add a new boolean property "enable-randomizer-otp" to enable the
> > randomizer feature on supported SPI-NAND devices.
> >
> > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > ---
> >  Documentation/devicetree/bindings/mtd/spi-nand.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.yaml b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
> > index 77a8727c7..432bc79e9 100644
> > --- a/Documentation/devicetree/bindings/mtd/spi-nand.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
> > @@ -21,6 +21,10 @@ properties:
> >      description: Encode the chip-select line on the SPI bus
> >      maxItems: 1
> >  
> > +  enable-randomizer-otp:
> 
> This is a NAND wide feature, so we should probably add a prefix, such as
> "nand,".

'nand' is not a vendor, so no.

Rob


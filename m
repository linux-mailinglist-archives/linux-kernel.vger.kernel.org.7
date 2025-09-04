Return-Path: <linux-kernel+bounces-800720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3804B43B03
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9E6687E62
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F1C27E7DF;
	Thu,  4 Sep 2025 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="x4q2fq7M"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF493277C88
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987603; cv=none; b=iAnjtHSm07XKY1LdAhiVDGkoG/8xh3myY0gZVzjunr3zaWnW6Op0O8Opb3bb2Mi7gbbjN4ZvgXz3leD8+OGD1EbPCW+nDIXPYckylJbKSws3x9JWUXVRJPHAsB3RcFn73Ffoy7hDd4IIvmizCh4dJ4HvWHX3hn75mOvYtdkTjdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987603; c=relaxed/simple;
	bh=BQAe+JjSh2q+k6497/0Vzpn/TGXqaKHnZLgVqN30iWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VM1XGPnXoZt3ybGRzUM2dttMSwwBUT1LtQQri30IpmBvF6uW2wXp3ImeHkNOIjDFKVSjprQK5oYckM14tqgm7sIz+XXDG8FotTRHveff5OqJFwMCqWdF71vzawyx6Nu5gAgN+kIHMI3mEA55EHdfa+SVCDqwG13LEXztOud9NBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=x4q2fq7M; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1370C4E40C74;
	Thu,  4 Sep 2025 12:06:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D6570606BB;
	Thu,  4 Sep 2025 12:06:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9572C1C22CD4A;
	Thu,  4 Sep 2025 14:06:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756987595; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=mIlmuo0Gtp9GO6zHaQ/K5OHjdFMQzgyW4t7BFdCXnm8=;
	b=x4q2fq7MGG0YkXFf63P8x8iowmcOaB5uN3MXm/gDQchzTtrGTJy4+kUaSJTz90iluRHKKK
	CtVCXJu4Z42L3iJwW6uwD+6jzsA/JtuBw0YIexwEd4DlA1jXOR3Z9gqWChHkDR0lPtvAXD
	BkZ/tup6tQGrmbkfZGB1jxP0GN7WagtqlVrWzZBR5kCj4SstT/fDUoskrHKlWZisWtUY/k
	GnAI9AGTXcZj4CznV3qo1HqKoKq6tIdT8Tur0zbZpeDn/k2cHO8f70GMnKi9XBNJj9KBm8
	EML/9cfGbgLk9cbOJCXQyraNqTrt+dQEzpqCwv5a5YLAIJZCuQZEHsDxP2DnQA==
Date: Thu, 4 Sep 2025 14:06:26 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: rtc: pcf2127: add compatible string
 nxp,rtc-pcf2123
Message-ID: <20250904120626554f89c7@mail.local>
References: <20250903165536.431586-1-Frank.Li@nxp.com>
 <202509031658298690ab12@mail.local>
 <aLiHyoI6orsalmyJ@lizhi-Precision-Tower-5810>
 <202509031924363f3ca29e@mail.local>
 <20250904-mustard-lion-of-downpour-f07cea@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-mustard-lion-of-downpour-f07cea@kuoka>
X-Last-TLS-Session-Version: TLSv1.3

On 04/09/2025 11:29:25+0200, Krzysztof Kozlowski wrote:
> On Wed, Sep 03, 2025 at 09:24:36PM +0200, Alexandre Belloni wrote:
> > On 03/09/2025 14:24:10-0400, Frank Li wrote:
> > > On Wed, Sep 03, 2025 at 06:58:29PM +0200, Alexandre Belloni wrote:
> > > > On 03/09/2025 12:55:36-0400, Frank Li wrote:
> > > > > Add compatible string nxp,rtc-pcf2123, which style is not consistent with
> > > > > existed compatible string because existed driver and dts use
> > > > > nxp,rtc-pcf2123.
> > > > >
> > > > > Fix below CHECK_DTBS warning:
> > > > > arch/arm/boot/dts/nxp/imx/imx6q-evi.dtb: /soc/bus@2000000/spba-bus@2000000/spi@2018000/rtc@3: failed to match any schema with compatible: ['nxp,rtc-pcf2123']
> > > > >
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > > > > index 11fcf0ca1ae07..595c20df6a411 100644
> > > > > --- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > > > > +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > > > > @@ -20,6 +20,7 @@ properties:
> > > > >        - nxp,pcf2127
> > > > >        - nxp,pcf2129
> > > > >        - nxp,pcf2131
> > > > > +      - nxp,rtc-pcf2123
> > > >
> > > > Nope, you need to fix the devicetree.
> 
> Yep, 6 years is enough for all users to adjust, so I agree.
> 
> > > 
> > > Oh, driver drivers/rtc/rtc-pcf2123.c also use nxp,rtc-pcf2123. For such old
> > > devices, generally keep it as it.
> > > 
> > > Maybe DT team members provide more professional comments for it.
> > 
> > It is there for DT ABI compatibility, we don't need to advertise its
> > existence in the doc, you must fix the device tree.
> 
> In-tree compatibles should be documented anyway (as "deprecated: true").
> 

There is one device tree to fix, then we won't have any occurrence
in-tree anymore.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


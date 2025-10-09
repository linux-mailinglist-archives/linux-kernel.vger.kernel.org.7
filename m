Return-Path: <linux-kernel+bounces-846850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F69FBC93A1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D705F3E6095
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB8F2E11CB;
	Thu,  9 Oct 2025 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8S3Ha5J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F5C22339;
	Thu,  9 Oct 2025 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015745; cv=none; b=YjgKLVDbxYwfMPAzv661gHYnqZE+gv8t3jSZMXpEfgib+QrefvghdmGbvhhk8DC7oa4q3kOUnC9oHSF6XlC2rtXaeU6c1Yo3XVU9skzu8n4EDo/oks8dCwhQJU2AMkYUwUunILM+jZ/Xsg/9djDf9F7ahESqLK7yAqW7FxoME0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015745; c=relaxed/simple;
	bh=WDJMpljpKO6kYpsRwBtMNjw3g2PjNR8M6qWpYgVRLRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Llf0/hdLEbmE+M2ZZ7sE1XH9T7Q7/I+BxfYyf8zxb7UJ9I3ekoJUUQrKzDn/Eo9N+HiXv1pW4oy8JOZo6W0Nstvf+QHMtEydLSKElLSFpXK6hBIUKo55XEhMWF2ppYgvJaFdQtP/9GXr1o75av9AksDzrGJhJsqXkePfP+ap/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8S3Ha5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69F2C4CEE7;
	Thu,  9 Oct 2025 13:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760015745;
	bh=WDJMpljpKO6kYpsRwBtMNjw3g2PjNR8M6qWpYgVRLRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D8S3Ha5J5eTv8aqEaCXeFc2PcpMFPXmTiW2Q3rNzpv29jwFPP2G1p+n1i9xUq2rTg
	 I6RqV56fYRwvGn1n75meFtGLgygmRGbQi8FlDrROMZW1m5WKVssPa0ItqT1m1+svnQ
	 20poKhiWbbVLi2RGLS+NfA7il14wXVDVGElxRdprggFccQ9+3ukP/CP0Cjs5tpIw2p
	 l9URYe9Zq8J11uF3SJvfAne8l7879T096eQGG74eztISR2TiN4/KK3P+yWv7sNfacL
	 5aWmy3xpFw/J0aa5CKq1MtIIqqxadZ6n+dNLKz8khZwldv+Isg+287wVw20rUEJEqK
	 9epe82SvM3gSw==
Date: Thu, 9 Oct 2025 08:15:43 -0500
From: Rob Herring <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for
 VBUS based on ID state
Message-ID: <20251009131543.GA379737-robh@kernel.org>
References: <20251008175750.1770454-1-krishna.kurapati@oss.qualcomm.com>
 <20251008175750.1770454-2-krishna.kurapati@oss.qualcomm.com>
 <odikli6rfdyid5oqavurtqytgnwgh5hpmka2jt5tprpdw7cd72@icpnjnkfowt7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <odikli6rfdyid5oqavurtqytgnwgh5hpmka2jt5tprpdw7cd72@icpnjnkfowt7>

On Wed, Oct 08, 2025 at 09:31:59PM +0300, Dmitry Baryshkov wrote:
> On Wed, Oct 08, 2025 at 11:27:49PM +0530, Krishna Kurapati wrote:
> > Update the bindings to support reading ID state and VBUS, as per the
> > HD3SS3220 data sheet. The ID pin is kept high if VBUS is not at VSafe0V and
> > asserted low once VBUS is at VSafe0V, enforcing the Type-C requirement that
> > VBUS must be at VSafe0V before re-enabling VBUS.
> > 
> > Add id-gpios property to describe the input gpio for USB ID pin and vbus-
> > supply property to describe the regulator for USB VBUS.
> > 
> > Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/usb/ti,hd3ss3220.yaml       | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> > index bec1c8047bc0..c869eece39a7 100644
> > --- a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> > +++ b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> > @@ -25,6 +25,19 @@ properties:
> >    interrupts:
> >      maxItems: 1
> >  
> > +  id-gpios:
> > +    description:
> > +      An input gpio for USB ID pin. Upon detecting a UFP device, HD3SS3220
> > +      will keep ID pin high if VBUS is not at VSafe0V. Once VBUS is at VSafe0V,
> > +      the HD3SS3220 will assert ID pin low. This is done to enforce Type-C
> > +      requirement that VBUS must be at VSafe0V before re-enabling VBUS.
> > +
> 
> Stray empty line?
> 
> > +    maxItems: 1
> > +
> > +  vbus-supply:
> > +    description: A phandle to the regulator for USB VBUS if needed when host
> > +      mode or dual role mode is supported.
> 
> Why are we adding the property here while we can use the vbus-supply of
> the usb-c-connector?

Normally, that's my question on both of these, too. However, it does 
look like both are connected to the chip. There's VBUS_DET which is 
connected to Vbus (thru a 900k resistor). So having these here does look 
like accurate representation of the h/w. The commit message should make 
this more clear. Honestly, that's really the only part I care about. 
How it works is not so important. 

Rob


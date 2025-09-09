Return-Path: <linux-kernel+bounces-806973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5F8B49E4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED943B9C3A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ADD21D3EC;
	Tue,  9 Sep 2025 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFz8lzgq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29A20102C;
	Tue,  9 Sep 2025 00:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378699; cv=none; b=ACfGD5+l18J4+TVR8TRoSGrma3z6FR99HUQfk7GIrpznpW322/iii/TYNlpdZ7AO2Orb/RA1xyIC/+IFCMRTRbhQcPIronf3+4uk4TzTGOZZzeVl6z0oNlraGUU/tiJvTZc3QvXm7EY0IJ7UvBYmPdqShboDBMM9pL78/q1EzBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378699; c=relaxed/simple;
	bh=U5Udt4w7yPFZCT86OGl/Ot0b/JCIBL+lIFPb2Y9M3mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLiHDbbx+gnf0a+IXSo8ZNSJbW11p6WnLraSzbAaNSECz4j2G8VeIH5G3FbdYGTMeHshcpxap5nqT3tCSBZ2DjgPO7dDuCrxX0xIW7hw3YRF4j/FjEUxmjGuHqc4LZYLT3ud04zmYGtxPARJnN1UQ47rvX3qh7bY4StXoXmZDdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFz8lzgq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE810C4CEF1;
	Tue,  9 Sep 2025 00:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757378698;
	bh=U5Udt4w7yPFZCT86OGl/Ot0b/JCIBL+lIFPb2Y9M3mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CFz8lzgqGVfGRr5nutYDK/3Kh8HMv+XMb5BfgLSQEu0yDv3DNZdB3+h8q5tctyFD9
	 z5t4FOz4PRe4sjNaWr5XnKYHoqxUX6nJKqBEBrwTqe8EoDsG0N4wzFzeiIuBe9msM6
	 ikBy20p3NPYTQLPUX6bbLH+q+nPxwY7JcSsz5wQwGFaaTrnIEeymaaKlcwMMEEBjs4
	 cAEcqR/ULuIffRnK28Gq2lhmEz0gN11/ruIVWjopQKvvMfJfMYpBkKLUrSj942qso7
	 /GYEyIkkoHMcFYjVtI0XLiDQBAWElJy1lR04j77LSlcwqX2gEIRG7rODy9cvbkvcWW
	 emrAeX3JwQDwg==
Date: Mon, 8 Sep 2025 19:44:58 -0500
From: Rob Herring <robh@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Andreas Kemnade <akemnade@kernel.org>, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alistair Francis <alistair@alistair23.me>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: mfd: sy7636a: Add missing gpio pins and
 supply
Message-ID: <20250909004458.GA2311693-robh@kernel.org>
References: <20250906-sy7636-rsrc-v1-0-e2886a9763a7@kernel.org>
 <20250906-sy7636-rsrc-v1-1-e2886a9763a7@kernel.org>
 <288f0cf1-1ee4-4eba-b059-641120bb93f3@kernel.org>
 <c879f3e1-f64c-4cbd-97ec-646d06488d8e@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c879f3e1-f64c-4cbd-97ec-646d06488d8e@sirena.org.uk>

On Mon, Sep 08, 2025 at 03:34:00PM +0100, Mark Brown wrote:
> On Sat, Sep 06, 2025 at 02:01:25PM +0200, Krzysztof Kozlowski wrote:
> > On 06/09/2025 11:09, Andreas Kemnade wrote:
> 
> > > +  en-gpios:
> 
> > enable-gpios, unless it is something else, but then please explain in
> > the description.
> 
> > > +    description:
> > > +      If EN pin is not hardwired, specify it here to have it set up.
> > > +    maxItems: 1
> 
> It seems reasonable to name the property after the pin on the device?

Yes, but in general we've standardized on reset, enable, powerdown, etc. 
rather than all the possible variations of those names. At least with 
'reset', standardizing it has bought us the ability to handle it with 
the reset framework rather than every driver implementing its own GPIO 
twiddling.

Rob


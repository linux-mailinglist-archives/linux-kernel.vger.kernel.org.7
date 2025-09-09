Return-Path: <linux-kernel+bounces-807340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02090B4A32E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822C23A6E92
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5333305972;
	Tue,  9 Sep 2025 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="TEW/akYE"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA941F63CD;
	Tue,  9 Sep 2025 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402046; cv=none; b=PlYqI32ZzryzGtB1DKJGstoeEymvIqjzopnTQNo4nXXOb8KefIiUBYKyN7ih8iOoxvttMFg1Nj16yzlgOq5kdQ7rw5lYHKQ9CkOI4RaTENGPfNY5xzU5LLHncNBVbApcBsYRp1FIqdsD9JmUSrV0tt1BOTJZcFRngBbnisDBWDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402046; c=relaxed/simple;
	bh=RLT21W40QQic9U+kLXEBvc/R94byG6Ag6xJ9Xg4gz4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oowjIzaiEayDVoBRPHCLlMm9cQFKpCiyMwlccrcsdjlFBnhyksx96nvTBQrASFp9ok7D1WPsISs/UultW5g4bJG3kl6NNJfY89A+O9jYSv41A3i1fCsnqYvBCWe+FBcz9sangfNxYES8G/UYPFK7ryDmmGkok7Bf2QcfMkhZ0xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=TEW/akYE; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xYnn6eq9zDJfEhefiTAt9k41NDwuDU+EuoU6E1ypT30=; b=TEW/akYEAvobwhIwNwLHv1OxsP
	TRvqluGtzgOR/IiAz81Ld1z7p+3NwOuRxtoTDzhgrNzF8lPVlbe5GmVwmDd9YupEcWQtoUuatEIzM
	998FaTxhLFWOIlVKDaSG+TCicA4A68/EfPtXUMNML4HI+j+7Dq0JPy6zJr+mu2BKYQwXytm+/pTy0
	gPRk2F4bj6M3Vv8ykYlxo1PgAFWix22zQoH7JUnCGDRI6agb2naeYKPzkOsMStQbcSvFM/8n86tCb
	2Xi+0hTV4n5mIBa9X8aAMu9W8pXWAFeD4UlWPwcgEOcOBN57mThT67qAVlrHginNntb8fMq6XQ+aN
	K1eI9LHg==;
Date: Tue, 9 Sep 2025 09:13:50 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Andreas Kemnade <akemnade@kernel.org>, Lee Jones <lee@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alistair Francis <alistair@alistair23.me>, Liam
 Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: mfd: sy7636a: Add missing gpio pins
 and supply
Message-ID: <20250909091350.7732243e@akair>
In-Reply-To: <20250909004458.GA2311693-robh@kernel.org>
References: <20250906-sy7636-rsrc-v1-0-e2886a9763a7@kernel.org>
	<20250906-sy7636-rsrc-v1-1-e2886a9763a7@kernel.org>
	<288f0cf1-1ee4-4eba-b059-641120bb93f3@kernel.org>
	<c879f3e1-f64c-4cbd-97ec-646d06488d8e@sirena.org.uk>
	<20250909004458.GA2311693-robh@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Mon, 8 Sep 2025 19:44:58 -0500
schrieb Rob Herring <robh@kernel.org>:

> On Mon, Sep 08, 2025 at 03:34:00PM +0100, Mark Brown wrote:
> > On Sat, Sep 06, 2025 at 02:01:25PM +0200, Krzysztof Kozlowski wrote:  
> > > On 06/09/2025 11:09, Andreas Kemnade wrote:  
> >   
> > > > +  en-gpios:  
> >   
> > > enable-gpios, unless it is something else, but then please explain in
> > > the description.  
> >   
> > > > +    description:
> > > > +      If EN pin is not hardwired, specify it here to have it set up.
> > > > +    maxItems: 1  
> > 
> > It seems reasonable to name the property after the pin on the device?  
> 
> Yes, but in general we've standardized on reset, enable, powerdown, etc. 
> rather than all the possible variations of those names. At least with 
> 'reset', standardizing it has bought us the ability to handle it with 
> the reset framework rather than every driver implementing its own GPIO 
> twiddling.
> 
ok, then I will do
EN -> enable-gpios
VCOM_EN -> vcom-en-gpios (as is)

Regards,
Andreas




Return-Path: <linux-kernel+bounces-581663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB990A76359
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 11:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5207E3A51CA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 09:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109771DDC1D;
	Mon, 31 Mar 2025 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="brPQQZiI"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E293E1CEEBB
	for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414138; cv=none; b=CtAjepb4xr2go5DX9O62C4gfMq/7esr77YnGZzhNPOmWF0Pah0IY4YtwVeEeaaBofEv18z2w1qyCWyeFWThdzQgAKPco7EjrohEsx6SLXELBYrRghFhu/xI0g0nMvECscMKKdhlcN1Af0shqH6UYNNvNOjqNk8bcoho1nwbkcmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414138; c=relaxed/simple;
	bh=Ipmw/VwpLWtOte5GxHApLnmcwa/lmfy4/9xKN3SDeqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPAmVl8OmTPV4NMYjsnWqD9myOlAJeliBPBi5u0QFUHAiCp4n8PmxaST2Fa7gUF0ezbEYiqhSqjIg1XnJE40D9hukjrbhY4XD4aabZ/jix/Ag2mecubsy4RiwIzGDBHPnEgjFmFfbR8S8WhBIaRTVwp9dMzoRj9S086ch9Za3gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=brPQQZiI; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75B9C43153;
	Mon, 31 Mar 2025 09:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743414133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oJlbKcu3BPrvGN6++gGbM96T4lZujRmQWOCuEpWY8PM=;
	b=brPQQZiIRHAFrQRdFOwGad/WmZbW6LmF082D/MDBeDVs6Au+x27/C4OCTB58rXH4NyaTMS
	mliCvFRicL7XJzllaZcEDBAzeGxhQ/PxduigyF2Q7bzqw3Al+XbznJL44/0WFMrXMhQei4
	/pUA+cMntQY6XZCmATXB/vOAgc99/q599dydTqVpRGF424o6zPKh9J087EG2/aFVybPWD4
	2x8JRC0noMpuUfXZhvx7eZShCfiM/RnpqYZe+B0gDNb4zDGbYfCX0m0UsWEplkS/xpXveu
	NNkjsbCtSm6a57E7TuGS43uvpB9qwlF92N2O/tF7yUUPfuVBbtxZKqNeuAsAWw==
Date: Mon, 31 Mar 2025 11:42:12 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] i3c: master: Drop duplicate check before calling
 OF APIs
Message-ID: <174341411812.1099775.9355586066348391329.b4-ty@bootlin.com>
References: <20250321193044.457649-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321193044.457649-1-andriy.shevchenko@linux.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetlhgvgigrnhgurhgvuceuvghllhhonhhiuceorghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieejfefhffekjeeuheevueevjedvleevjeetudffheeutdffudefjeduffeuvddtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmegukeejvgemudgsudgsmeeltdekgeemtggtfhgtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmegukeejvgemudgsudgsmeeltdekgeemtggtfhgtpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqiheftgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesv
 hhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephfhrrghnkhdrnfhisehngihprdgtohhm
X-GND-Sasl: alexandre.belloni@bootlin.com

On Fri, 21 Mar 2025 21:30:06 +0200, Andy Shevchenko wrote:
> OF APIs are usually NULL-aware and returns an error in case when
> device node is not present or supported. We already have a check
> for the returned value, no need to check for the parameter.
> 
> 

Applied, thanks!

[1/1] i3c: master: Drop duplicate check before calling OF APIs
      https://git.kernel.org/abelloni/c/465e5486aa5e

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


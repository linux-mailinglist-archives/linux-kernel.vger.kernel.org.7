Return-Path: <linux-kernel+bounces-834102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC39FBA3DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF4ED7AE7E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56AA2EC55B;
	Fri, 26 Sep 2025 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YkUKYeux"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74131D7E5C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892884; cv=none; b=G6LExMT+5N5Ywed19Nze8j6yy4kecnUznZ8Y8o17mgDMM7QDTxtBAfkAcYwOQqn6jKhgYFz0tPrp5Gi76ogaPXcovL3sORKvT00Ij1W73TCrtjMaN4YG+2zb1l11zYik+MdqdNHa9X6GCiFZ6R/DP0uTui4W1hXoKxTJttDCWa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892884; c=relaxed/simple;
	bh=wgA/KHhjj9nh98Q2K+I0SfkA1dG5Qo6UsV0GJJR0K78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsH24sevHGer+tDdG+ax3y+RNoUQNmMLiZ9C8yeheoURMSwX/nKo6YJi+QbKhZ8fUW0LpnBF+5cPu+yLJDCkJZc5Gi1nLvtO5W5Usvg+jJ67UM09GuhZlkMHAJhYzItgLhfGkGtK9fICCcOghEAvMPYprzwFQ+9yoIxvhIfzouU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YkUKYeux; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 26 Sep 2025 21:21:00 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758892871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kS/CoKpI2O26sCXSiv4EiupTsdzTbhruWHTFDNF/B6E=;
	b=YkUKYeuxwSed5mqZY3/3VbIDplrQbnU0BQyGpRaweeUYdJumLK8deef1Tp0r7wqplNKpwg
	Cutjz+xCr/eeEfqtYnAVU6OygFzMkgLSw2KkURh6IgxBFQzc8QxwDYo14K4Ee1jQuCWLnX
	cPzJoWrUjQ7hovBJ/T49ILEI3dGg4nE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Troy Mitchell <troy.mitchell@linux.dev>
To: Guenter Roeck <linux@roeck-us.net>,
	Troy Mitchell <troy.mitchell@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (ctf2301) Add support for CTF2301
Message-ID: <aNaTPE494MMExSBz@troy-wujie14pro-arch>
References: <20250916-ctl2301-v1-0-97e7c84f2c47@linux.dev>
 <20250916-ctl2301-v1-3-97e7c84f2c47@linux.dev>
 <53f1d5d2-c871-4823-ab13-8c3dfd86dbfe@roeck-us.net>
 <aNXtJ0S5SAMsUwnD@kernel.org>
 <8c6f609e-c086-4b6c-abb5-8d33ec85df47@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c6f609e-c086-4b6c-abb5-8d33ec85df47@roeck-us.net>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 25, 2025 at 08:57:13PM -0700, Guenter Roeck wrote:
> On 9/25/25 18:32, Troy Mitchell wrote:
> > Hi Guenter, Thanks for your review.
> > There are many things to improve in this driver.
> > 
> > On Wed, Sep 24, 2025 at 08:43:35AM -0700, Guenter Roeck wrote:
> > > On Tue, Sep 16, 2025 at 12:46:46PM +0800, Troy Mitchell wrote:
> > [...]
> > > > diff --git a/drivers/hwmon/ctf2301.c b/drivers/hwmon/ctf2301.c
> > [...]
> > > > +
> > > > +#define CTF2301_LOCAL_TEMP_MSB			0x00
> > > 	LM90_REG_LOCAL_TEMP
> > > > +#define CTF2301_RMT_TEMP_MSB			0x01
> > > 	LM90_REG_REMOTE_TEMPH
> > > > +#define CTF2301_ALERT_STATUS			0x02
> > > 	LM90_REG_STATUS
> > > > +#define CTF2301_GLOBAL_CFG			0x03
> > > 	LM90_REG_CONFIG1
> > > > +#define CTF2301_RMT_TEMP_LSB			0x10
> > > 	LM90_REG_REMOTE_TEMPL
> > > > +#define CTF2301_LOCAL_TEMP_LSB			0x15
> > > 	TMP451_REG_LOCAL_TEMPL
> > > > +#define CTF2301_ALERT_MASK			0x16
> > > 	TMP461_REG_CHEN
> > > 
> > > So far this looks like a chip based on LM90 or TMP451/TMP461
> > > with an added fan controller. I can not immediatey determine
> > > if it would be better to add the pwm/tach support to the lm90
> > > driver. Given that the chip (based on registers) does support
> > > limits, which is not implemented here but essential for a chip
> > > like this, I would very much prefer adding support for it to the
> > > lm90 driver if possible.
> > > 
> > > The public datasheet does not provide register details, making it
> > > all but impossible to do a real evaluation. Any idea how to get
> > > a complete datasheet ?
> > Yeah, more register info at [1].
> > I've checked the detailed review below,
> > but I'll hold off on sending v2 until you decide if we really need a new driver.
> > 
> > Is this chip more like the LM63, by the way?
> > 
> 
> Good catch. Yes, looks like you are correct. LM63 is an almost perfect match.
> CTF2301 has a couple of extra registers, mostly local setpoint and temp LSB
> plus the registers in the 0x3x range. Actually, those registers _are_ defined
> for LM96163, so that chip is an even closer match.
Yes, so just to confirm,
you agree that the development should be done on top of the lm63 driver, right?

> 
> What happens if you just instantiate the lm63 driver, possibly after updating
> the detect function ?
I will run the tests the day after tomorrow and provide a log.

                - Troy

> 
> Guenter
> 


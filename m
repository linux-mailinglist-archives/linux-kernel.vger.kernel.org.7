Return-Path: <linux-kernel+bounces-809119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7BBB508DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BCC01889D45
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3259026E179;
	Tue,  9 Sep 2025 22:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDguUCwp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8762571A5;
	Tue,  9 Sep 2025 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757456752; cv=none; b=NP8XoJnKNKhJvs2nm2yk+nDWUGT7ypYNMeVY60Md2FhS9T/eBKYw1meBpSD3XZpwSch0XLY++xjNBtowRlVkYBdI1OkqS2lEB9DgQhYTX6bj+JyCrEJ6EuDjg9TJ0kWtNejaDlTCqxwWg1cJhsq3+O/xg4HSwLuCHWoOdauBq3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757456752; c=relaxed/simple;
	bh=645iNWZvifz2eZ9NwLWXL2PDwmHsJ84rWYVLdtzlJcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0fUWnFfhu005lVoXPZgjtAPyHLINZcp1r54C0IH4hTL2ACAU6zsFU4KJL/tOmWfP1soX0aLPhEKaSOjX07Y+zuLL9ejAwyPqn3+OIC0FifMgnVSOyf0RHFAGSEgF+A+8zt2tw4XWAD1gVELyDhiseTrPfTq5dPBqNH5Pv52flg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDguUCwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B288C4CEF4;
	Tue,  9 Sep 2025 22:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757456752;
	bh=645iNWZvifz2eZ9NwLWXL2PDwmHsJ84rWYVLdtzlJcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eDguUCwpP9DVZVJwqqXIS/8y+jxOr7scjJ9bBrqVu1QLkosCL1Q5bmmUweG86WMZs
	 WapvOtaFO0Fw14T0KpYJewJLFCHA76Ab0TaFT7asDgviu5k/H8ADlWe9OrPy8Kw1Vp
	 +GlOVH0potqCtmkT7JGk8dRFFMFi67AP5up6zC90pM/j5RP4YTw9OQ1M3YgOvazV+q
	 JUzlNqx+918BupWoYts7eeW05nAvLSc5m6AGmD06XxqXT1k4DmI5DycUEKNORgm+mj
	 xD6tAQjEYLbpYjI2BRfhJLZnOKAyFsoiUeHZEb85mVW8JJY7RBnmMWpsZMie+iIIoB
	 fXsdel/5IWekQ==
Date: Tue, 9 Sep 2025 15:25:44 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
	Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 18/22] phy: apple: Add Apple Type-C PHY
Message-ID: <20250909222544.GA3282617@ax162>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-18-52c348623ef6@kernel.org>
 <20250908181259.GC89417@robin.jannau.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908181259.GC89417@robin.jannau.net>

On Mon, Sep 08, 2025 at 08:12:59PM +0200, Janne Grunau wrote:
> On Sat, Sep 06, 2025 at 03:43:31PM +0000, Sven Peter wrote:
> > diff --git a/drivers/phy/apple/atc.c b/drivers/phy/apple/atc.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..9213485234873fcaafeb1d1d9de3ddf07767d552
> > --- /dev/null
> > +++ b/drivers/phy/apple/atc.c
> > @@ -0,0 +1,2214 @@
> 
> [...]
> 
> > +static int atcphy_load_tunables(struct apple_atcphy *atcphy)
> > +{
> > +	int ret;
> > +	struct {
> > +		const char *dt_name;
> > +		struct apple_tunable **tunable;
> > +	} tunables[] = {
> > +		{ "apple,tunable-fuses", &atcphy->tunables.fuses },
> > +		{ "apple,tunable-axi2af", &atcphy->tunables.axi2af },
> > +		{ "apple,tunable-common", &atcphy->tunables.common },
> > +		{ "apple,tunable-lane0-usb", &atcphy->tunables.lane_usb3[0] },
> > +		{ "apple,tunable-lane1-usb", &atcphy->tunables.lane_usb3[1] },
> > +		{ "apple,tunable-lane0-cio", &atcphy->tunables.lane_usb4[0] },
> > +		{ "apple,tunable-lane1-cio", &atcphy->tunables.lane_usb4[1] },
> > +		{ "apple,tunable-lane0-dp", &atcphy->tunables.lane_displayport[0] },
> > +		{ "apple,tunable-lane1-dp", &atcphy->tunables.lane_displayport[1] },
> > +	};
> > +
> > +	for (int i = 0; i < ARRAY_SIZE(tunables); i++) {
> > +		*tunables[i].tunable =
> > +			devm_apple_tunable_parse(atcphy->dev, atcphy->np, tunables[i].dt_name);
> > +		if (IS_ERR(tunables[i].tunable)) {
> > +			dev_err(atcphy->dev, "Failed to read tunable %s: %ld\n",
> > +				tunables[i].dt_name, PTR_ERR(tunables[i].tunable));
> > +			return ret;
> 
> ret is unitialized here, could be `return PTR_ERR(tunables[i].tunable);`
> instead

This could also use '%pe' to symbolically print the error name instead
of the integer value.

    dev_err(atcphy->dev, "Failed to read tunable %s: %pe\n",
            tunables[i].dt_name, tunables[i].tunable);

Cheers,
Nathan


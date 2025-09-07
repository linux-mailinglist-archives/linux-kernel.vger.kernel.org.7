Return-Path: <linux-kernel+bounces-804676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16724B47B79
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 14:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E53164A45
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C9E2737E2;
	Sun,  7 Sep 2025 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d4kJMwi2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB371C8606;
	Sun,  7 Sep 2025 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757249474; cv=none; b=ZJ7OObRw8D0p/6snFlgE3tuoEXlR6wYqu5nSJw3ljTQxgY7bbX+xpUntu1CyEC91037OvD7utztGWqpDWN+uJFnHkUPchCvlf/WDJhSz/3vmFxM2T2RkCWUDO1qAAdqWriwpv5lSzX3luBgsMEjhcE4hR7qmtFlD7wqwYKs6IEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757249474; c=relaxed/simple;
	bh=IWYocY3Q/qyYFd0mqeYzdKytf2h0IHxXtx9zAXWQ5sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fW7Tc2ZfQ637ZDPFn5cXv65AMmP/vT1gACNlCBLKhNcJHf0688mjeQgZKVgxFDAKI314kB0bqzk+sxYe9T6rAvuJS12Uy2+laNOAinSDNDcl0Rw/PUTwpR/MLjZTQHDTNhGhYAtTRi8hc0RVPjGOC/TMCOtxSUg6cI+e2J8UZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d4kJMwi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9B1C4CEF0;
	Sun,  7 Sep 2025 12:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757249474;
	bh=IWYocY3Q/qyYFd0mqeYzdKytf2h0IHxXtx9zAXWQ5sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4kJMwi2GGoks7Kj/YqNlzkZ8fzdRPWDzA8Yye8QtWHeG0O4qtLYiLNvDGGw9/ETt
	 hxpApDrcdwzYed/fwOJs1CKTfPyOtqsQcv0lY+HwPhbbmsS5JoC+iPcb2PrTS2Q24Q
	 OLHeb2bfAj7QKuRymS01IPveabspeYWifp1uRcEA=
Date: Sun, 7 Sep 2025 14:51:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alyssa Anne Rosenzweig <alyssa@rosenzweig.io>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sven Peter <sven@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
	Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 20/22] arm64: dts: apple: t8103: Add Apple Type-C PHY
 and dwc3 nodes
Message-ID: <2025090726-overcoat-unskilled-3228@gregkh>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-20-52c348623ef6@kernel.org>
 <20250907-zippy-auburn-koel-d6da32@kuoka>
 <aL199DK3XfkaelgH@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL199DK3XfkaelgH@fedora>

On Sun, Sep 07, 2025 at 08:43:32AM -0400, Alyssa Anne Rosenzweig wrote:
> > Please do not combine DTS patches in patchsets for Greg (e.g. USB). Greg
> > expressed that many times, that he takes all or nothing, and DTS cannot
> > go via driver branches/trees.
> 
> >From the cover letter, emphasis mine:
> 
> > With the dwc3 glue driver this series can now also be merged independently
> > once it's ready: Patches 1-4 can go through the dwc3 tree, 5-15 through
> > tipd, 16-18 should go together through the phy tree, and I'll take the
> > DTS changes through my tree. **If everyone's happy with the overall
> > approach here I can also just send these as individual series**
> 

That's great, but a major pain in the butt for any maintainer.  It would
require me to manually pick out the patches to be added to my tree and
manually apply them?  We have good tools now, b4, that wants to take a
whole patch series.

And you want me to take a whole patch series, as I can now add the info
that is in 00/XX to the "merge point" of a big patch series to preserve
the information that is provided here.  So you loose out if you that is
not preserved in the tree, and you make more work for maintainers to try
to sift through just what should, and should not, be taken.

Remember, some of us maintainers get 1000+ emails a day to do something
with.  Our development process is optimized for our most limited
resource, maintainers, not developers, sorry.  Think about it if you
were on the receiving end of this, what would you want to see present
for you to be able to review and then apply this to your tree?

So please, split patches up into "one series per tree".  It's the only
sane way for us to work.  Yes, it's a pain for platform/dts stuff at
times, but for everything else, it works really well.

thanks,

greg k-h


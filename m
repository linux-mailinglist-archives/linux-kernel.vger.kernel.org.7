Return-Path: <linux-kernel+bounces-807796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C01B4A94F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9671884CAD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED94E317717;
	Tue,  9 Sep 2025 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpZ8IkwH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CF228C03E;
	Tue,  9 Sep 2025 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412189; cv=none; b=V2UfMhcCfi/P0bvwkOKLQQRdZhU6LP8byaGhwhAiO/KKz1A0GrbuRVE8io0qTNrlxIz/eNDCMTWsLzuhqSYGfS8M+MRPMY+X2sZDHManKkpJTo80ywb/hUPKBTd2rwKTsAfp7ivSlMg6O9mq54VcN5INKDa8OH/DOdc9pON8xV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412189; c=relaxed/simple;
	bh=buaBwp5Yv75D60lIF0FzrJYG01n3Ms/EaLejxbELWnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSL1zmKISTvGw2TgFb1ZC+mlBeAHDH2C2o7YfkEHQMOnuK+XNbmlsi3P9EUMb9vg7Fd3i45i+oQjzpwyyjoReKqp2ANLKhKAwZHtFa55baYGjUQGTvKiCGTt7jKktGq6qrFFvmmEI98vVR7Wyk+YNADwvrrgVQFCM6S/d+O9Rfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpZ8IkwH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757412188; x=1788948188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=buaBwp5Yv75D60lIF0FzrJYG01n3Ms/EaLejxbELWnU=;
  b=lpZ8IkwH/aqJhpyFWLI3v/JmBUMXDlZbsJnrr1lllsFYoNSeZ/4F/ueX
   mf/0dFuJfgH0YDMTutQ5LO8HcwYEdrH5v7IK4yB1Q354zccP+bwjiGJPH
   lbCWGNyTP5vMxqHXzCpe11wsXjOKcQZggjFCYwqxiI3c4RhWdPE3gM4F5
   f04m3A+tRnYO3B8BleFSYwqVbCtYwZBPvSmO9GFMEgVM6gOWRmMwxIIGP
   VIOKf/wOapBrD9yH+1c7M6BspAQx3eB8SzG2LQ+XDUAkoVP+f7ygC40Mc
   aUHHssDUtQztHsD3o/FPs5U5Jc1a2qV9VliWne55MrI6aoxDenjUgQfEh
   g==;
X-CSE-ConnectionGUID: eeES2d8FQQma5S2gRJddIg==
X-CSE-MsgGUID: PbbVW0aQSIeFdmT5GJhkIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="47264685"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="47264685"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 03:03:07 -0700
X-CSE-ConnectionGUID: CSYsodW6R+KHLu/MzD4Mog==
X-CSE-MsgGUID: vbDkhzclQ7+yM2+ZtHM31Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="173837261"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa010.fm.intel.com with SMTP; 09 Sep 2025 03:03:01 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 09 Sep 2025 13:03:00 +0300
Date: Tue, 9 Sep 2025 13:03:00 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Sven Peter <sven@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 14/22] usb: typec: tipd: Read data status in probe and
 cache its value
Message-ID: <aL_7VOraIKMKkPwe@kuha.fi.intel.com>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-14-52c348623ef6@kernel.org>
 <aL_7Hklraq2ff_YA@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL_7Hklraq2ff_YA@kuha.fi.intel.com>

On Tue, Sep 09, 2025 at 01:02:13PM +0300, Heikki Krogerus wrote:
> On Sat, Sep 06, 2025 at 03:43:27PM +0000, Sven Peter wrote:
> > From: Hector Martin <marcan@marcan.st>
> > 
> > Just like for power status we also need to keep track of data status to
> > be able to detect mode changes once we introduce de-bouncing for CD321x.
> > Read it during probe and keep a cached copy of its value.
> > 
> > Signed-off-by: Hector Martin <marcan@marcan.st>
> > Signed-off-by: Sven Peter <sven@kernel.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> > ---
> >  drivers/usb/typec/tipd/core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> > index e6e9730ee6dacd8c1271b1d52a02da49ff248d3e..b558fc5ecbc35a9dabbf33c444f38173740af7c3 100644
> > --- a/drivers/usb/typec/tipd/core.c
> > +++ b/drivers/usb/typec/tipd/core.c
> > @@ -176,6 +176,7 @@ struct tps6598x {
> >  
> >  	int wakeup;
> >  	u32 status; /* status reg */
> > +	u32 data_status;
> >  	u16 pwr_status;
> >  	struct delayed_work	wq_poll;
> >  
> > @@ -538,6 +539,7 @@ static bool tps6598x_read_data_status(struct tps6598x *tps)
> >  		dev_err(tps->dev, "failed to read data status: %d\n", ret);
> >  		return false;
> >  	}
> > +	tps->data_status = data_status;
> >  
> >  	if (tps->data->trace_data_status)
> >  		tps->data->trace_data_status(data_status);
> > @@ -1551,6 +1553,8 @@ static int tps6598x_probe(struct i2c_client *client)
> >  	if (status & TPS_STATUS_PLUG_PRESENT) {
> >  		if (!tps6598x_read_power_status(tps))
> >  			goto err_unregister_port;
> > +		if (!tps->data->read_data_status(tps))
> > +			goto err_unregister_port;
> >  		ret = tps6598x_connect(tps, status);
> >  		if (ret)
> >  			dev_err(&client->dev, "failed to register partner\n");
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> heikki

-- 
heikki


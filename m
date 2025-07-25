Return-Path: <linux-kernel+bounces-745603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 220B1B11C13
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220851C25178
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171972D8778;
	Fri, 25 Jul 2025 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSSHCdKZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F992D542F;
	Fri, 25 Jul 2025 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438501; cv=none; b=Q+srSK3I7+/ToDMLT5y0/XBnWUpSkHrE+2zFGhzxslnLCLFigFpejZ0E0yhFMxc/opO4R+QrR1zDHmngCSMAXgTw7op5uJ3jgyNOk1tuf6TLyu0KSYWGuTDnbkVZU9cEIZEW1LO4IBbHnHORHSe/8RlhKXovxAB3CMhbZkxMJuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438501; c=relaxed/simple;
	bh=S7ZVntnZrGCdRCCtCS5pk77UfxN8E3nyE5vIDTCWGL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdXAFdGoOYzIjqtSN4JBJackpO9DcSCipMrbfeasTDdzmBzK8mI4kYLXt2hlmPXKFhqA3e5+WcKPb3bAXL09hmoV0ocwRMDY20jlx3POOmAHaXjPAbW8KIqLDvfXB09ni9Eunmp3/xpHQVxl92nre+TwMEOI4hqeZ+XcO0uwurM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSSHCdKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E60C4CEE7;
	Fri, 25 Jul 2025 10:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753438500;
	bh=S7ZVntnZrGCdRCCtCS5pk77UfxN8E3nyE5vIDTCWGL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSSHCdKZpd9d8t0KLl/oeEvFk+QX97kwZtwmuvGgO4qbjpcsznMNtDxCIAXW9MyxV
	 w92JUttLheCuMl1es+f2YE3tkiD6PuCvYzQFK3T2HaUJJP6nOcjICr+V5nPBAZDNFy
	 TQzQHaeb5HA/yV9/SKDPRc8NYr7SY3ckX7BLO9i7UZiUUWJI4E6z6wDSf9+pJ7Jk/a
	 97vQW0s0vIwYoqokd3kcCAo3XreMGUjW/DscGapKnQaXO79MA1H2GlcHNxahwo+Jr3
	 1abCkjlN9xaqki7CIQCgB6u7W0utrXTJWh+zXi/KW5KV8X2kfC3Ram0VZ/I3jou+H5
	 nR5jxrBwfaoHg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ufFS4-000000005GN-25LW;
	Fri, 25 Jul 2025 12:14:57 +0200
Date: Fri, 25 Jul 2025 12:14:56 +0200
From: Johan Hovold <johan@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Corentin Labbe <clabbe@baylibre.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, david@ixit.cz
Subject: Re: [PATCH v8 1/2] usb: serial: add support for CH348
Message-ID: <aINZIJTz5bxO66OW@hovoldconsulting.com>
References: <20250204135842.3703751-1-clabbe@baylibre.com>
 <20250204135842.3703751-2-clabbe@baylibre.com>
 <aCHHfY2FkVW2j0ML@hovoldconsulting.com>
 <CAFBinCAUNNfOp4qvn2p8AETossePv2aL7jBkFxVZV_XzzULgVg@mail.gmail.com>
 <2025071631-thesaurus-blissful-58f3@gregkh>
 <CAFBinCAMGR2f4M1ARKytOwG1z9ORcD-OMNLH2FqZHb+tOm0tEQ@mail.gmail.com>
 <2025071613-ethics-component-e56d@gregkh>
 <CAFBinCA8cMP3o483c40RjHkMAEt4RCmL6uCTTk5DPmrNVN6_NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCA8cMP3o483c40RjHkMAEt4RCmL6uCTTk5DPmrNVN6_NQ@mail.gmail.com>

On Wed, Jul 16, 2025 at 11:31:49AM +0200, Martin Blumenstingl wrote:
> On Wed, Jul 16, 2025 at 10:57 AM Greg KH <gregkh@linuxfoundation.org> wrote:

> > And are you trying to only have one set of urbs out for any port being
> > opened (i.e. you only have one control, one read, and one write urb for
> > the whole device, and the port info are multiplexed over these urbs?  Or
> > do you have one endpoint per port?)

> CH348 provides up to 8 serial ports using these four endpoints, so
> multiplexing is going on:
> - one bulk out for TX (see struct ch348_txbuf)
> - one bulk in for RX (see struct ch348_rxbuf)
> - one bulk out for CONFIG handling (see struct ch348_config_buf)
> - one bulk in for STATUS handling (see struct ch348_status_entry)
> 
> > If you are sharing endpoints, try looking at one of the other usb-serial
> > drivers that do this today, like io_edgeport.c, that has had shared
> > endpoints for 25 years, it's not a new thing :)

> My understanding is that io_edgeport is submits the URBs that are
> shared across ports outside of .open/.close.
> So this will be a question for Johan: am I still good with the
> original approach - or can you convince Greg that a different approach
> is better?

It's definitely better not to waste power when the device is plugged in
but not in use. :)

Take a look at f81534 for an example of how this can be implemented.

Johan


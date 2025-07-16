Return-Path: <linux-kernel+bounces-733596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF17B076C2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FBE77A59C7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864891A238C;
	Wed, 16 Jul 2025 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GOUFVzcb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E7E19ABD8
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671989; cv=none; b=m2+HB/XaSRgK+FUv0pmLwnlheTC3XH5QW3bBivTUe/EcZevHQxNyTa0OhT3Nc4p+nWpv1YRUEw2h0rUg8b09KHu7F9dzKLaVoDX7YPXRjru29LeXFdnmw5QFQKXjigzK20K5RWqP+HbqQwUihwIhZkifMO5UjBuctK2sCIbOb8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671989; c=relaxed/simple;
	bh=zFgwgl6z4iyOtfyd7QnV7un+bH7wT3Xti6zFMCCCxns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wio0plRPpICdH2CRwWZKKfbA9z6xqJRdNSUqvFkXflIamieYS1m2iNjYQcMQb+07uw+HkOO5s7nRlrXBNc7OopCNKrqHsgV8ZWChcEuTnh/PVw60hs8UmI5F+5oRQsoBB7wWSQP0+JtUtT9dNBDqahBrkt3TbAag+30HcjL8zc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GOUFVzcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF85C4CEF0;
	Wed, 16 Jul 2025 13:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752671989;
	bh=zFgwgl6z4iyOtfyd7QnV7un+bH7wT3Xti6zFMCCCxns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GOUFVzcbo/Z/44ILa9WU/ns7xqBvsHjN8g6tQ+4mjDOO1mqBRRmrIdkiQhZq3f6wK
	 oKJdIk+sjY76o2jNZJ0/V3lj1zSG3MJH5Cxh/R3EzRLCQ9L/Ag6cxaaialUs9vuOq6
	 uQrh+pO4iAMa4TS3JVf6PXoRv30qtbMrPUvQTB4I=
Date: Wed, 16 Jul 2025 15:19:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Damien =?iso-8859-1?Q?Ri=E9gel?= <damien.riegel@silabs.com>
Cc: greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-devel@silabs.com, Alex Elder <elder@kernel.org>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [RFC 5/6] greybus: match device with bundle ID
Message-ID: <2025071642-saline-concave-4ec0@gregkh>
References: <20250705004036.3828-1-damien.riegel@silabs.com>
 <20250705004036.3828-6-damien.riegel@silabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250705004036.3828-6-damien.riegel@silabs.com>

On Fri, Jul 04, 2025 at 08:40:35PM -0400, Damien Riégel wrote:
> When matching a device, only the vendor ID and product ID are used.

It shouldn't be that way.  That was not the intention.

> As
> all bundles in an interface share the same VID and PID, there is no way
> to differentiate between two bundles, and they are forced to use the
> same driver.
> 
> To allow using several vendor bundles in the same device, include the
> bundle ID when matching. The assumption here is that bundle IDs are
> stable across the lifespan of a product and never change.
> 
> The goal of this change is to open the discussion. Greybus standardizes
> a bunch of protocols like GPIO, SPI, etc. but also has provisioning for
> vendor bundle and protocol. There is only one ID reserved for vendor,
> 0xFF, so the question is did Greybus ever envision supporting several
> vendor bundles, or one vendor bundle with several vendor cports in it?
> Or the assumption always was that there could be at most only vendor
> cport?

The goal was to emulate what USB does here.  If you have a
vendor-specific protocol, then set the vendor protocol id (0xff) and
then trigger off of the VID and PID.  Then you can do whatever you want
here in your driver as it's a vendor-specific one.

So you are wanting multiple devices with the same vid/pid yet do
different things?  Why not just change the PID?

Like with USB, a bundle id is not guaranteed to be "static", BUT if you
want to make that distinction in your driver that is a vendor-specific
one, go ahead.  Again, that should be like USB interface numbers, right?

thanks,

greg k-h


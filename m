Return-Path: <linux-kernel+bounces-740025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147EAB0CEC9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 02:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D897A864E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0CB5D8F0;
	Tue, 22 Jul 2025 00:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="kuqp7Svq"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD1D2E36EB;
	Tue, 22 Jul 2025 00:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753144519; cv=none; b=Us5lPnIH2ocbNUrUg8f2fy0kjP40Y9zivwYYiv46F1muWzUimemnHGyB/bIzEVm0rCVQJNP/6ig9uYLQydMOVlMNb1Ukxml3tUNEBxMVRcUmiGW4b9tL093fjIQGFgIw9mzX0qvDrx27zX2mY03+/bMFzmqQTrKAN5Oqq5d2t34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753144519; c=relaxed/simple;
	bh=NVJSthHoVBfvJ0DprsxJsTID3or77ayMtN3PtiGsObQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVHD/rrwWpeRUgPginqCkBA2H0V7wAlMPkXSarB9HDUYVPjVpYFsWBRjajtjCbzjs0tybA51lkXRSJFhijlAAHQXY0B501g6gG7HW2mJsDGCyzLqLMEOmlHwSHmMRRUj7gMGf+GtfhVwZsfBHdL7yYjqRnhVKXwrpeKFeaQWzt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=kuqp7Svq; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 46DFF2082C;
	Tue, 22 Jul 2025 02:35:14 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2AWGV58KjTtc; Tue, 22 Jul 2025 02:35:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1753144513; bh=NVJSthHoVBfvJ0DprsxJsTID3or77ayMtN3PtiGsObQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kuqp7SvqE3+gsACQYmTXKrC6X6J/IBJVAvyya0mbiIsDkonQbEAg4tHtU90nE2fOO
	 maPB8WmFiNZIQBVtbQ5nZ1VKVgu8ehAoh0wGLNES47exI9ghg7zuUL54J4gtoTdMz5
	 tJYNXt4HOTIzqW9tNieEM2P/1o7t0VXzKJeO0orz4Bkz5+SPeuGo15x0CxAontFdWS
	 I/D91B2ADLRNe+Bu1Ta0N7jG3yVEU8LxLvF6XW7tawKRh0QjJP2JNDny4uwpMZXphy
	 uaoLs/SQ3vpfwD+kycJR2prgJzg5LDK+22uzpxHx+3Y2p1pbHW2o3yIcylVoF1fzU3
	 34If+OcvH0l6w==
Date: Tue, 22 Jul 2025 00:34:46 +0000
From: Yao Zi <ziyao@disroot.org>
To: Ze Huang <huang.ze@linux.dev>, Alex Elder <elder@ieee.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] usb: dwc3: add generic driver to support flattened
Message-ID: <aH7cpr0faRPVnxXL@pie>
References: <20250712-dwc3_generic-v6-0-cc87737cc936@linux.dev>
 <20250712-dwc3_generic-v6-2-cc87737cc936@linux.dev>
 <d2e9a521-568e-433d-a59b-9b98138ace2b@ieee.org>
 <aHyN3-uoHofF8Hg3@monica.localdomain>
 <aH4tpgVPbf9DOzSe@monica.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aH4tpgVPbf9DOzSe@monica.localdomain>

On Mon, Jul 21, 2025 at 08:08:06PM +0800, Ze Huang wrote:
> On Sun, Jul 20, 2025 at 02:34:07PM +0800, Ze Huang wrote:
> > On Tue, Jul 15, 2025 at 03:50:54PM -0500, Alex Elder wrote:
> > > On 7/12/25 2:49 AM, Ze Huang wrote:
> > > > To support flattened dwc3 dt model and drop the glue layer, introduce the
> > > > `dwc3-generic` driver. This enables direct binding of the DWC3 core driver
> > > > and offers an alternative to the existing glue driver `dwc3-of-simple`.
> > > 
> > > I'm not familiar with dwc-of-simple.c, and won't comment on
> > > how this differs from that (or does not).
> > > 
> > > Given you're implementing an alternative though, can you explain
> > > in a little more detail what's different between the two?  Why
> > > would someone choose to use this driver rather than the other one?
> > 
> > They are basically the same.
> > 
> > dwc-generic use a plain dt node while dwc-of-simple will nest the dwc3
> > node as its child.
> > 
> > Both will use dwc3_core_probe() to finish the probe process. But now we
> > can simplify the process by just calling it, instead of calling
> > of_platform_populate() and create another snps,dwc3 device driver.
> 
> [...]
> 
> > > > +	ret = reset_control_assert(dwc3->resets);
> > > > +	if (ret)
> > > > +		return dev_err_probe(dev, ret, "failed to assert resets\n");
> > > > +
> > > > +	ret = devm_add_action_or_reset(dev, dwc3_generic_reset_control_assert, dwc3->resets);
> > > > +	if (ret)
> > > > +		return ret;
> > > 
> > > The re-assert shouldn't be set up unless the deassert below
> > > succeeds.
> > > 
> > 
> > Will move behind the deassert.
> > 
> > > > +	usleep_range(10, 1000);
> > > 
> > > This seems like a large range.  You could just do msleep(1);
> > > Also, can you add a comment explaining why a delay is needed,
> > > and why 1 millisecond is the right amount of time to sleep?
> > > 
> > 
> > I will check the range with spacemit and reply soon.
> > 
> 
> the resets are asynchronous with no strict timing. But to be safe, each
> reset should stay active for at least 1 µs. I’ll switch to a udelay(2)
> and add comment accordingly.

This may be a little farsight: do you think it's better to make the
reset timing part of the of_match_data? This is more flexible and
reduces future burden when introducing a new platform that comes with a
different reset timing, which is a very likely case we'll face since
it's a "generic" driver.

> > > > +	ret = reset_control_deassert(dwc3->resets);
> > > > +	if (ret)
> > > > +		return dev_err_probe(dev, ret, "failed to deassert resets\n");
> > > > +
> > > > +	ret = devm_clk_bulk_get_all(dwc3->dev, &dwc3->clks);
> > > > +	if (ret < 0)
> > > > +		return dev_err_probe(dev, ret, "failed to get clocks\n");
> > > 
> > > Call devm_clk_bulk_get_all_enabled() instead of doing the two
> > > steps separately here.
> > > 
> > 
> > Will do, thanks.
> > 
> > > 					-Alex
> 

Regards,
Yao Zi


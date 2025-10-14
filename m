Return-Path: <linux-kernel+bounces-853253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 563CFBDB05C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37B5B4F57FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B9B2BEFEF;
	Tue, 14 Oct 2025 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xb4AaGVP"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6BB23D7D9;
	Tue, 14 Oct 2025 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469291; cv=none; b=Abgm/2dtHVcjzf1WdL5H8fRC7gwuSi0+8fDTLEKYB6HTyO6rBGn9Zhlq6gOAlT0I5rF+BIwFTwuHOC5qdOwTP/0WbtVWZtGc4dDtaREGi4Yjb93uwTAMFPwwWXauWRvKt2SflyTNe5c3yxIpiTRrQ4yCNigQHISE4TI6q+uc3OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469291; c=relaxed/simple;
	bh=bUDWiwFGl4fPYs7f2cQbNpM7+WNvkhlDCn1i6bVu0O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ez4mq7f9a8QnbHuGvlHK2N2baG62urzbvjbvHtyYFdORhBqk2T/rRWUYjV/FVcxFWT3uC3Yj09Ckhl4ITt5mUMtHON5c6Djzo/GB92l7BTnnARDx/gguQukXq5uL56v5vLq12s1S0q9QZOfR+aFBLXvZV3/RfASrA2unhtVEfJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xb4AaGVP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QNUximqet6DWhyIz4nhEhfE/R+ezClJhU7cuTBXoYag=; b=Xb4AaGVPDNsB5EUGG4ObRO3h6n
	DdfCBjHziOyMg1DbFj0LI4V46gaeDsVOVqZ7R7SJEGlu8vwilTtUnr+gm3fvdGWgvidwkYMsGBUNa
	+BM7VJDn13srbGPuxSr6UCA+jQGCqnVFKN2/6ObMDl1kAwNsnIYCuNDVFT1nZPUWoxSI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8kTV-00Awk6-Os; Tue, 14 Oct 2025 21:14:21 +0200
Date: Tue, 14 Oct 2025 21:14:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tao Ren <rentao.bupt@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include
 facebook-fuji-data64.dts
Message-ID: <33b9d6d4-bb2f-47e6-8d3d-94a2ca2b8474@lunn.ch>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net>
 <aO2kLyxGlGt12sKD@fedora>
 <ea64d3c1-e517-4bd8-9a2e-56432f286347@lunn.ch>
 <4e099ead-e6df-4489-a775-1730bc852dcf@roeck-us.net>
 <f801a4cb-3d27-439c-82f2-d5ee5aa0d810@lunn.ch>
 <7197bfc7-fef6-40b2-b3f3-182e9428dc12@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7197bfc7-fef6-40b2-b3f3-182e9428dc12@roeck-us.net>

On Tue, Oct 14, 2025 at 09:39:02AM -0700, Guenter Roeck wrote:
> On 10/14/25 08:11, Andrew Lunn wrote:
> > > > If it is already in mainline, i don't care too much if it is wrong. We
> > > > don't want to cause regressions.
> > > > 
> > > > I only object when adding new nodes which are wrong. If we keep adding
> > > > broken nodes, there is no incentive to fix the broken driver to do the
> > > 
> > > This wasn't adding an allegedly (sorry, it worked for me) broken node,
> > > it was removing one that worked for me all along. Obviously I do not know
> > > if it worked (or if it is even used) on real hardware, but it worked for
> > > the fuji-bmc qemu emulation.
> > 
> > It probably does work on real hardware, because it is one of those
> > "two wrongs makes a right" cases. So i see this as a regression. The
> > node should not be removed. It should hopefully get corrected sometime
> > in the future when somebody actually fixes the aspeed driver, and
> > fixes both wrongs.
> 
> So you are trying to force the issue by disabling the Ethernet interface
> on fuji-bmc until the problem in the driver (whatever it is) has been fixed ?
> That just seems odd.

No, i see this as a regression, it probably used to work, so it should
still work.

I'm just pushing back on adding new nodes which are broken. If it is a
new node, it should not cause a regression.

	Andrew


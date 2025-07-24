Return-Path: <linux-kernel+bounces-744306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1EBB10ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E511881F01
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1542D4B68;
	Thu, 24 Jul 2025 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZBpdSnxs"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AAA2D46DF;
	Thu, 24 Jul 2025 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361640; cv=none; b=dKPkBJqs3ZMPit12VcLd8xOo5FRtpaT0Rhmt3hjBzvomCLpP0UTXzqRKakc47LU4HWGe491FTuKpBu6L0V0OXSNJvDsMDCCWeE3CmoG+iuF+gE5HaLXLbepDUAYoMJprbkbA21fu7F8Aj+C+AftjYr9OZzdKAkF+tpW8Yq8C9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361640; c=relaxed/simple;
	bh=4nKgSBvNF6KNqFuR3NRAg8Z96QH5x2/xGsDT5KpIPKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPLDNUDS1UEMY7NZM5Cy/f+Ufoyzy0wXSoalOk7YYNgc2z2OqTgjKnJSr8iLZjYKJ/NGKGGsy6GJdQOVA8umbAc4enweBgTwxGuRHl7dArNFyEoWOEB5gHVug5Z1Cvk8aY0MsTtY5dm3H4DJ1kmkGHIVI62cSd2lVqnaUSOiuBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZBpdSnxs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n3/g4/jBSS+544GxD3Uqs3+ihWOI9sn+j4nRaeUAg7Y=; b=ZBpdSnxsorutDmupx/4WVEj1SW
	1bm4a1Sl3LhmC7jKATKv6Bj5YVbhDxxMPBxAXZG6W+WhjzDrpfbfTQgHmOFy8klPSGkde/Myqk3Pb
	SHKyusWfHkjVxeysakRsTlCMlY406YskhV+RB00hIFeaHeEgYDfq9m/MRcdqhX6PzFYo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uevS7-002lEV-5u; Thu, 24 Jul 2025 14:53:39 +0200
Date: Thu, 24 Jul 2025 14:53:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tao Ren <rentao.bupt@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v3 10/13] ARM: dts: aspeed: Add Facebook Fuji-data64
 (AST2600) Board
Message-ID: <769d6817-ee97-4a23-b013-29bc875a00cb@lunn.ch>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
 <20250723233013.142337-11-rentao.bupt@gmail.com>
 <d09667e5-992e-4ced-ae30-7a4116a72c62@lunn.ch>
 <aIGGdbIX9HaV4dB/@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIGGdbIX9HaV4dB/@localhost.localdomain>

On Wed, Jul 23, 2025 at 06:03:49PM -0700, Tao Ren wrote:
> On Thu, Jul 24, 2025 at 02:03:20AM +0200, Andrew Lunn wrote:
> > > +&mac3 {
> > > +	status = "okay";
> > > +	phy-mode = "rgmii";
> > 
> > Does the PCB have extra long clock lines to implement the 2ns delay?
> > 
> > 	Andrew
> 
> Hi Andrew,
> 
> Thank you for catching it. I didn't notice the settings because the file
> is copied from the exiting fuji.dts with minor changes.
> 
> The delay is currently introduced on MAC side (by manually setting SCU
> registers), but I guess I can update phy-mode to "rgmii-id" so the delay
> can be handled by the PHY?

That would be good, if it works. The problem with the current code is
that those SCU registers are not set as part of the MAC driver, so it
is hard to know what value they have.

	Andrew


Return-Path: <linux-kernel+bounces-857413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D05BE6BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105691892BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08C13101A0;
	Fri, 17 Oct 2025 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hjBxTQvr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC3D30F94E;
	Fri, 17 Oct 2025 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683273; cv=none; b=GbqnHMOFR7Ime4vyYQGRmLmx17aRyaiekSmtm17T6sHmJg2ZareCZjib1Esun1/flL8UgVx4vC0P8JFwkHpVSHQWR1lNeaaXTtdVwv6ADL/+SXUP2cTwc4oT3z14kcAHDRHotpxqqHjMBBR/oSa8gxWcN17gEr8NASPLQ8m5Vmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683273; c=relaxed/simple;
	bh=boNVW1ZqVyp6QPqYXslzFhQnM4rFlkUnf9eUPHMVPYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqSLie4kE6ETY4BmXwlRf1t4PLHKF2gd4qX5toP6uZvuAQH5zdqL7Qn8NvgSukBY3LR8WL2LT/IxztKC93RlQNYKCjzuCYX0nghHZ4xvhb6UDg5gdyUOz+W53EEajCUywbEuJ0jqlG5NGeCX7WXZf+CU0AnlT+VwaQHPSW7LyJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hjBxTQvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B59AC4CEE7;
	Fri, 17 Oct 2025 06:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760683272;
	bh=boNVW1ZqVyp6QPqYXslzFhQnM4rFlkUnf9eUPHMVPYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjBxTQvrAfuLPNC2keww1Wt8vFoF+J+E8ZZ0BZQWAaPazcqvI4z2lHr1qsXFDTv/E
	 HZDrhFWcgHNRAyJYhFFQ+UUaT8nUdAvkG0GMPYwg4QEnDODqyjrWgO3lvvqAvTRwdR
	 /JfiPXvXBFFDP7HmxhTJoqTqyxScFrArfwBCKeH0=
Date: Fri, 17 Oct 2025 08:41:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Brian Masney <bmasney@redhat.com>,
	Iwona Winiarska <iwona.winiarska@intel.com>,
	Joel Stanley <joel@jms.id.au>, Maxime Ripard <mripard@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] peci: controller: peci-aspeed: convert from round_rate()
 to determine_rate()
Message-ID: <2025101759-runner-landing-374b@gregkh>
References: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
 <aMatZAX6eFI1RmDH@redhat.com>
 <28dc3bd8aeca7e3164747960747f75060c596704.camel@codeconstruct.com.au>
 <aPEZSY6RC-UVclxN@redhat.com>
 <ba2e6b78e59afb7c89e5022770a142ec8c31659a.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba2e6b78e59afb7c89e5022770a142ec8c31659a.camel@codeconstruct.com.au>

On Fri, Oct 17, 2025 at 04:52:37PM +1030, Andrew Jeffery wrote:
> Hi Greg,
> 
> On Thu, 2025-10-16 at 12:11 -0400, Brian Masney wrote:
> > Hi Andrew and Iwona,
> > 
> > On Mon, Sep 15, 2025 at 02:36:48PM +0930, Andrew Jeffery wrote:
> > > Hi Brian,
> > > 
> > > On Sun, 2025-09-14 at 07:56 -0400, Brian Masney wrote:
> > > > Hi Iwona, Joel, and Andrew,
> > > > 
> > > > On Sun, Aug 10, 2025 at 06:21:51PM -0400, Brian Masney wrote:
> > > > > The round_rate() clk ops is deprecated, so migrate this driver from
> > > > > round_rate() to determine_rate() using the Coccinelle semantic patch
> > > > > appended to the "under-the-cut" portion of the patch.
> > > > > 
> > > > > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > > > 
> > > > Would it be possible to get this picked up for v6.18? I'd like to remove
> > > > this API from drivers/clk in v6.19.
> > > 
> > > My (strong) preference is that Iwona applies it, but I'll keep an eye
> > > out for any unusual delays.
> > 
> > This patch wasn't picked up for v6.18. Any chance this can get picked up
> > now for v6.19?
> > 
> > I'm hoping to get this merged so that we can remove the round_rate() clk
> > op from the clk core. The clk maintainer (Stephen) mentioned this work
> > in his last pull to Linus.
> > 
> > https://lore.kernel.org/linux-clk/20251007051720.11386-1-sboyd@kernel.org/
> 
> Are you happy to pick this up directly in Iwona's absence?

Why me?

confused,

greg k-h


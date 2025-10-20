Return-Path: <linux-kernel+bounces-861349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535F1BF27D0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105B61898776
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BED232BF48;
	Mon, 20 Oct 2025 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dlcb2Ij3"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926B932B9A3
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978580; cv=none; b=gYTvE0x8Gn3OJe9mVrR/xAO2j75chWMhug1wn+Uivo3rVeLbPNlEtrsKzr7VVdyg/h4FATb9myuKUvXlFA2uAhcLoC9QBACSl3PWond1Xdy+Ptjgii+ropvOLvtoJrhzA2OLt7CDMn8aIoS2YXBDAv5njHJbsu6Aj3i6lcBpbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978580; c=relaxed/simple;
	bh=zA0fwSMPCeE8RAk8GwR/QRgxkltbz3v/uH9m/NSde6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRQybFH4/z+GaaFg6tbEn/HWxp13nmXss1vSnp5NPFPlHhP1bjxzbUCTssm1g6bqM990wmWmUQJSr4s/rmurJm0CHXx8Nb94dAZKUgrOzkuQ0eVUKBqaZuZ7sbETusTJpbHpZKLp1Y+8trsRfXPmkMda67FhbTsh9ff9pnJ9l34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dlcb2Ij3; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 20 Oct 2025 12:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760978560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KgxwBPJlCH7sly4qDL9geQAQP/GrIRLBe36lpAtWQCc=;
	b=Dlcb2Ij3AdEJo6Xo/bBZlyinCXU2hhLGvVvzSo718fOXw/QvBOHTqnSDfFaOBj2YcPJzsW
	8iB+75VBrAhLVSXBnDiqv4PHeubByFBHYyccD6RL9xpJ2I3sDI0bug6DgIRnV7kgMJKIxa
	0fAMrDQ0vUDcU1dB0dOhERctPj8XZPA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org
Subject: Re: [GIT PULL] block-bio_iov_iter_export
Message-ID: <6bvfbwfvwtqmou27dnrznhl32ctz2rwb2a3shuelssrtrcchbi@zn24wtni7cub>
References: <ov54jszhism7mbeu74vtyoysxnx3y3tsjbj5esszlrx3edq77s@j2vtyy45gsna>
 <aPHemg-xpVLkiEt9@infradead.org>
 <6strysb6whhovk4rlaujravntyt2umocsjfsaxtl4jnuvjjbsp@sqf6ncn3yrlm>
 <aPYCbIrvAkOf5L3g@infradead.org>
 <lyqal3mcvjwmzoxltydw2aoyhjllwcvv5ix2axpw24kh2iotkx@lygocjo66enh>
 <aPY3YKzGbIKxFbl-@infradead.org>
 <wrcaluw3pxx65tgznv5z3td3xb2tdf6rwucze5sy7bqrutj4jp@srde54eo3iyz>
 <aPZNC8bKIzRmFJ21@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPZNC8bKIzRmFJ21@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 20, 2025 at 07:54:03AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 20, 2025 at 10:49:57AM -0400, Kent Overstreet wrote:
> > Christoph, I don't know what you're claiming here. I see no tweaks in
> > the original patch, that's all code I wrote.
> 
> Then look closer.
> 
> > There was no need for you to drop the EXPORT_SYMBOL.
> > What I want to know is, is this going to become a pattern?
> 
> Of course there was.  The kernel doesn't keep unused code around,
> including symbols.  So anything that is unused will eventually be
> garbage collected.  There's even folks around that run scripts and
> automate it (David Alan Gilbert is the most active one currently).

A comment would be an easy solution to that.

> 
> > I can vendorize this one function, but If you're going to make a habit
> > of ripping out exports and functionality bcachefs depends on, I can't
> > expect I'll always be able to.
> 
> I'm not sure why you're turning this personal and singling me out.
> Yes, unused exports and code are removed all the time, and that's a
> feature and not a bug.

If this is a serious question, READ FUA is another answer :)


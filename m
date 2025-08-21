Return-Path: <linux-kernel+bounces-780726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D90CB30862
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 970AF7A5531
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74D62C11E2;
	Thu, 21 Aug 2025 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mavv/NgN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132BA2C028F;
	Thu, 21 Aug 2025 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755811920; cv=none; b=jT9ptwC9LYTvWIFTmdHIhum1AaCtEiZGMHNFEZ77Owaxqz93tyMfXL0lPJnJi/EqfofKOqQIoacT3ofzxqaJFCTFo12IbNI1cHeUoycX51K5E35iR7CAZQtWrT+dNQYpcSmdqHLCTl4/THsHjmm1zF0Y0g9VkBDHuPLQ2ECT/B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755811920; c=relaxed/simple;
	bh=LmtLJZmYI/DRN+OdgAPFUV08VXJxNhS5Mue678s3WXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKbtHjq+93yOp86+u0Y7/JFw3HN/p4K6inztq+x1JGxYpJPclFOENf2pgibP1Z6VZRZUS9AIFKcLbEuyE45b/rET6+dRjCR6Q42mrQfGHiPL/UU/3xRI+JitdVKG/zkCI690QdSzw1vHauSPhNUz6/m2a0zWsb8+Boj2VBD1ahY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mavv/NgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784A9C4CEEB;
	Thu, 21 Aug 2025 21:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755811919;
	bh=LmtLJZmYI/DRN+OdgAPFUV08VXJxNhS5Mue678s3WXY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mavv/NgNv1sGGbwwmwGc8C5Gayc1g3LW3ebGFUgiRr1oAiORYq2tkGwD4sDhYNhB6
	 ztWQX6iCbh0cZ3v2Nh0pax3QHQt69zZQqIgOHKTjjcup48wyewx/uuzKPfZhmUM0dZ
	 7ycCK5O9aW1eTdGZPuvc/McJj/9Sd/yIeCLB4YdF6KrjQXRRllswJ4dk2B6ebFEc3c
	 lkZ/Av0DCgaa0lAZDfC4n1LOzdamW6B/iIN4zXIooysdxbu5hhHEzwsf7nuQbtwDJL
	 Dd1Ko2nRy+SeFRplRYW2lcmkxEjxMocQUlZvq+IKBuFaNVSq6iH6YG90Ee9zOW6d01
	 CSFjrrncWinSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 16C18CE0854; Thu, 21 Aug 2025 14:31:59 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:31:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Nikil Paul S <snikilpaul@gmail.com>, linux-doc@vger.kernel.org,
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v4] docs: rcu: Replace multiple dead OLS links in RTFP.txt
Message-ID: <972cf9c8-f8a6-4a5a-90a4-696f9a4e0f6d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250819180545.3561-2-snikilpaul@gmail.com>
 <87h5y07e6y.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h5y07e6y.fsf@trenco.lwn.net>

On Thu, Aug 21, 2025 at 11:54:45AM -0600, Jonathan Corbet wrote:
> Nikil Paul S <snikilpaul@gmail.com> writes:
> 
> > This patch updates several dead OLS links in RTFP.txt, replacing them
> > with working copies hosted on kernel.org.
> >
> > Originally posted as part of a 2-patch series, this is now being sent
> > as a standalone v4 patch to avoid confusion.
> >
> > Changes since v3:
> >  - No change in content, only resubmitted as a single patch instead of
> >    "2/2" from the earlier series.
> >
> > Signed-off-by: Nikil Paul S <snikilpaul@gmail.com>
> > ---
> >  Documentation/RCU/RTFP.txt | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> So this looks good to me, but it should really be run past the RCU folks
> (and Paul in particular) as well; adding him to the CC.

I queued this and checked it and it looks good.  By default, I would
send this during the upcoming merge window.  But if you would rather
take it:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Either way, let me know!

							Thanx, Paul

> Thanks,
> 
> jon
> 
> > diff --git a/Documentation/RCU/RTFP.txt b/Documentation/RCU/RTFP.txt
> > index db8f16b392aa..8d4e8de4c460 100644
> > --- a/Documentation/RCU/RTFP.txt
> > +++ b/Documentation/RCU/RTFP.txt
> > @@ -641,7 +641,7 @@ Orran Krieger and Rusty Russell and Dipankar Sarma and Maneesh Soni"
> >  ,Month="July"
> >  ,Year="2001"
> >  ,note="Available:
> > -\url{http://www.linuxsymposium.org/2001/abstracts/readcopy.php}
> > +\url{https://kernel.org/doc/ols/2001/read-copy.pdf}
> >  \url{http://www.rdrop.com/users/paulmck/RCU/rclock_OLS.2001.05.01c.pdf}
> >  [Viewed June 23, 2004]"
> >  ,annotation={
> > @@ -1480,7 +1480,7 @@ Suparna Bhattacharya"
> >  ,Year="2006"
> >  ,pages="v2 123-138"
> >  ,note="Available:
> > -\url{http://www.linuxsymposium.org/2006/view_abstract.php?content_key=184}
> > +\url{https://kernel.org/doc/ols/2006/ols2006v2-pages-131-146.pdf}
> >  \url{http://www.rdrop.com/users/paulmck/RCU/OLSrtRCU.2006.08.11a.pdf}
> >  [Viewed January 1, 2007]"
> >  ,annotation={
> > @@ -1511,7 +1511,7 @@ Canis Rufus and Zoicon5 and Anome and Hal Eisen"
> >  ,Year="2006"
> >  ,pages="v2 249-254"
> >  ,note="Available:
> > -\url{http://www.linuxsymposium.org/2006/view_abstract.php?content_key=184}
> > +\url{https://kernel.org/doc/ols/2006/ols2006v2-pages-249-262.pdf}
> >  [Viewed January 11, 2009]"
> >  ,annotation={
> >  	Uses RCU-protected radix tree for a lockless page cache.
> > -- 
> > 2.43.0


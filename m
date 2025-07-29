Return-Path: <linux-kernel+bounces-749892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1895B1545B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2859F5611E0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8748D272E4E;
	Tue, 29 Jul 2025 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OES2XfSz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30BE23958D;
	Tue, 29 Jul 2025 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753821266; cv=none; b=kDc1w6ein044CbfUDIU6S83F7otHu2GBx4o+++jwQNfmhhSj3UxSvslhcmTIg5JLBJXxf/nHovILcsJPphshnNbvt2mV8nErlQKJo5vncuvzzXToj8te5H9BTHffzTZ4Cz2jPoO5XyE1/IkLDYBkFAajxNdesm2uIZi0clbpkLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753821266; c=relaxed/simple;
	bh=NYTYISNdNf11NiYckUW5R3xl6hmNHHAxXkDRa3oIrCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbnRXBaYoKwOOlGBUG5HQgqGfLot4+pDROfXRlX7kjXlym5UcfOf5GErGIyU/4C28qNikWUfxOEpj+zD4zJxWD8p7he6v/z4IUgW5jZGXiItCfOBcK6wWhiZ83oHows9zBayAr1JXDw6x/yMhPjri8UQF/BcTga0heVlchcuzUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OES2XfSz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515EBC4CEF7;
	Tue, 29 Jul 2025 20:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753821265;
	bh=NYTYISNdNf11NiYckUW5R3xl6hmNHHAxXkDRa3oIrCE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=OES2XfSz8RcagmyCahhHn1WCqEcJn96cWUvyllyb8q4nlY+xFyw07o2QBMGppXzYV
	 cfjLEaxwIZ5bttVCE6TKCcR3ZWzKDdlgRtMe6pCg+TUWtDa58VMNDjDkqVPgT+5oQj
	 0AT+ReM76nwbkriVn3uyCfl+wEF9mu70MWPhCyfoD7BYNMvQ75qDv92GgC0qrDTO/3
	 F3QZb8jBdPKnXen9Q2+yr9wvCfnzbB0y6c3j8anzSahkrVEMoLmjNdwvSvHzQ/D41C
	 JJo5Jm3FsDNJ6CSQ/TVrJnqsOD4I1rrtu+aCQqqVSl0dtxuHTN49gkFSALfwzvXlQb
	 Btg+0KZRa41RQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DBD14CE0987; Tue, 29 Jul 2025 13:34:24 -0700 (PDT)
Date: Tue, 29 Jul 2025 13:34:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
	linux-kernel@vger.kernel.org, lkmm@lists.linux.dev
Subject: Re: [RFC] tools/memory-model: Rule out OOTA
Message-ID: <c47d74ef-5eb9-4994-8b73-fbb6eb6bfa8e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250106214003.504664-1-jonas.oberhauser@huaweicloud.com>
 <6fb01aea-f7b4-4f38-82b9-fd6c360514fc@paulmck-laptop>
 <3e98c47c-d354-431f-851f-494df9e6bc78@huaweicloud.com>
 <32a8f541-f760-44a1-8150-5e3d5ba98f34@paulmck-laptop>
 <2ee683dc-1e7a-48c1-b511-d49481c694ca@paulmck-laptop>
 <6f095882-6510-4746-9e59-c24335028237@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f095882-6510-4746-9e59-c24335028237@huaweicloud.com>

On Fri, Jul 25, 2025 at 07:23:23AM +0200, Hernan Ponce de Leon wrote:
> On 7/24/2025 4:14 PM, Paul E. McKenney wrote:
> > On Wed, Jul 23, 2025 at 09:39:05AM -0700, Paul E. McKenney wrote:
> > > On Wed, Jul 23, 2025 at 09:26:32AM +0200, Hernan Ponce de Leon wrote:
> > > > On 7/23/2025 2:43 AM, Paul E. McKenney wrote:
> > > > > On Mon, Jan 06, 2025 at 10:40:03PM +0100, Jonas Oberhauser wrote:
> > > > > > The current LKMM allows out-of-thin-air (OOTA), as evidenced in the following
> > > > > > example shared on this list a few years ago:
> > > > > 
> > > > > Apologies for being slow, but I have finally added the litmus tests in
> > > > > this email thread to the https://github.com/paulmckrcu/litmus repo.
> > > > 
> > > > I do not understand some of the comments in the preamble of the tests:
> > > > 
> > > > (*
> > > >   * Result: Never
> > > >   *
> > > >   * But Sometimes in LKMM as of early 2025, given that 42 is a possible
> > > >   * value for things like S19..
> > > >   *
> > > >   * https://lore.kernel.org/all/20250106214003.504664-1-jonas.oberhauser@huaweicloud.com/
> > > >   *)
> > > > 
> > > > I see that herd7 reports one of the states to be [b]=S16. Is this supposed
> > > > to be some kind of symbolic state (i.e., any value is possible)?
> > > 
> > > Exactly!
> > > 
> > > > The value in the "Result" is what we would like the model to say if we would
> > > > have a perfect version of dependencies, right?
> > > 
> > > In this case, yes.
> > 
> > I should hasten to add that, compiler optimizations being what they are,
> > "perfect" may or may not be attainable, and even if attainable, might
> > not be maintainable.
> 
> Yes, I just wanted to clarify if this is what herd7 + the current model are
> saying or what developers should expect.

Good point, and I added explicit words to this effect in the comments
of those aspirational OOTA litmus tests, so thank you!

							Thanx, Paul

> Hernan
> 
> > 
> > I am pretty sure that you all already understood that, but I felt the
> > need to make it explicit.  ;-)
> > 
> > 							Thanx, Paul
> 


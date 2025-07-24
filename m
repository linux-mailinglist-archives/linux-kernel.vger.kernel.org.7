Return-Path: <linux-kernel+bounces-744466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4EFB10D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E117A1D00F05
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565942DFA4D;
	Thu, 24 Jul 2025 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mi/ZihYn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5D92DE71E;
	Thu, 24 Jul 2025 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366486; cv=none; b=BQskp6ajsz4DFeVysU3O7/ff2pYNL5Mj+SU2vogM5L54VZuXlHt0S7dSHI8SVhU2Pe2+BjSa1FuRqW+nwNB4tTZlaNRxJCh031URDdkdykkxLMcN5msbKst8xDZayYx1a0XY8gdexQnJYmqN0ll9BaGaDf7GHcXX+wyHKSLQy2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366486; c=relaxed/simple;
	bh=8NKxaaPSwPV5OcQQaX8d94Ml3pIlsVSJ3hQ5GETn8Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lP4DWIHg3ecgxzKPZLfc0pshNHf2dI9/ndhJuiaYUNLHvJ+lX6uO/wue37dEq8EarHG5wMSl8dXMDoaH6Iqmqklkq/4bQv31ps1JposwHLFvbMnLKfm8EwV0KosFcao+7nukJpdRCP8Z9iNI5vttwJrdCKB4ceIFqu+//TSoyoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mi/ZihYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F808C4CEED;
	Thu, 24 Jul 2025 14:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753366486;
	bh=8NKxaaPSwPV5OcQQaX8d94Ml3pIlsVSJ3hQ5GETn8Hg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Mi/ZihYnF9SBNpXyY9aPfLQIZX/YFEuewiGFwj8R1ot7R6787UYJu9FIfChbTZlfP
	 pKMla2fb0wJHVtblAkxAlf6CThK5/aPDN2/9tgm/aw2WOsLfsu4GMOWDVV7png3MZn
	 +PFCaSwVdZkqOsgTdr+ETwDMjqNhPA5rSERitYsYCez2KSRO5a8NyCAVyfaF1GiyMk
	 QWfdjtaucqNLSsx7L6vydAAhjC9VbczNtNIcjSYlS9bcubgoBPrX6+VJuwMF09KoIy
	 KVF+WDcltcnmlMcHTCi1CJkqlZsOY23r8FGmNmsbDMa9MjlZ1p6d2HJ0XgU2O1u+Sf
	 4TmzBhYS3LUSg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C79C8CE0990; Thu, 24 Jul 2025 07:14:45 -0700 (PDT)
Date: Thu, 24 Jul 2025 07:14:45 -0700
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
Message-ID: <2ee683dc-1e7a-48c1-b511-d49481c694ca@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250106214003.504664-1-jonas.oberhauser@huaweicloud.com>
 <6fb01aea-f7b4-4f38-82b9-fd6c360514fc@paulmck-laptop>
 <3e98c47c-d354-431f-851f-494df9e6bc78@huaweicloud.com>
 <32a8f541-f760-44a1-8150-5e3d5ba98f34@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32a8f541-f760-44a1-8150-5e3d5ba98f34@paulmck-laptop>

On Wed, Jul 23, 2025 at 09:39:05AM -0700, Paul E. McKenney wrote:
> On Wed, Jul 23, 2025 at 09:26:32AM +0200, Hernan Ponce de Leon wrote:
> > On 7/23/2025 2:43 AM, Paul E. McKenney wrote:
> > > On Mon, Jan 06, 2025 at 10:40:03PM +0100, Jonas Oberhauser wrote:
> > > > The current LKMM allows out-of-thin-air (OOTA), as evidenced in the following
> > > > example shared on this list a few years ago:
> > > 
> > > Apologies for being slow, but I have finally added the litmus tests in
> > > this email thread to the https://github.com/paulmckrcu/litmus repo.
> > 
> > I do not understand some of the comments in the preamble of the tests:
> > 
> > (*
> >  * Result: Never
> >  *
> >  * But Sometimes in LKMM as of early 2025, given that 42 is a possible
> >  * value for things like S19..
> >  *
> >  * https://lore.kernel.org/all/20250106214003.504664-1-jonas.oberhauser@huaweicloud.com/
> >  *)
> > 
> > I see that herd7 reports one of the states to be [b]=S16. Is this supposed
> > to be some kind of symbolic state (i.e., any value is possible)?
> 
> Exactly!
> 
> > The value in the "Result" is what we would like the model to say if we would
> > have a perfect version of dependencies, right?
> 
> In this case, yes.

I should hasten to add that, compiler optimizations being what they are,
"perfect" may or may not be attainable, and even if attainable, might
not be maintainable.

I am pretty sure that you all already understood that, but I felt the
need to make it explicit.  ;-)

							Thanx, Paul


Return-Path: <linux-kernel+bounces-724635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96B2AFF517
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1463B0BDC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECD61A7AE3;
	Wed,  9 Jul 2025 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O30t7tcY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC9016DEB1
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102074; cv=none; b=cbTFxYJUxh9lpbj2rYbB+7Yi2Ro75WI3UfNVVaKAB/z6NJGc88yVWVEKZX2VgJ30GKAjH3L7ngIdmWZnO1setr5t/tKAyWVtloDXgUm3jcybRPN14xhqIt3Ztmyz8tLZaomS2VBhiWDpP7cp1aUwqqJTvihUZIRTf+TuHo257a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102074; c=relaxed/simple;
	bh=kUGwwW5sFcvvGk1bYG5rmmJB/8p0RhNDSC9MV69WAwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NatiRDY3b1AUtR+pyEr5D9B0VEQL3RmoCnQKXRE3CR4xsWMUPwIP7Dx+MILssjRXMfH3nQ/DkTkGaA80Tcncr9LyHqdgBrpHayoDkU/qmeGqnE3vHU7b4DRYj5paOEKPKlo/VTdBluWLwvvP8E3dEyZyHdWrD31GKK3O7FlFyz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O30t7tcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1291C4CEEF;
	Wed,  9 Jul 2025 23:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752102073;
	bh=kUGwwW5sFcvvGk1bYG5rmmJB/8p0RhNDSC9MV69WAwk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=O30t7tcY2VJ2WhbbWx2WmlUckhyc9TP5cQa+fyBbMbJCM+xIEhE91LfMF58CXzFHh
	 z8Hy42dngGah+Z3Q5CubepElv2XcwN3txW1JKRSHPaUUgdLWXpuvuTmmlZsTfiCuMJ
	 pdnEy+/hb/3D9nv4pP5SB8qPMjQ5mW5Ibwqz87wk2INlWYYmHG6ndpk80vgJM7vkAU
	 hwGUIPVNy4lMVUgqK6sMML80o8GhG0N/UzL+YXlkXNXgk/a9dxTs880m81YO3qksEY
	 LU4Q8CEERROc7OV2Kv+cTdxUQnm7f09icmIdNKzU/OXtOcht6Fk5DyWrnDhtlqWHlk
	 W0a6AUWdrbseg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 90A9ACE0C26; Wed,  9 Jul 2025 16:01:13 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:01:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jon Pan-Doh <pandoh@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>
Subject: Re: [PATCH v6 1/3] lib: Add trivial kunit test for ratelimit
Message-ID: <c6738701-c86d-4f25-ac71-92602aa19984@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <d1007957-97ff-4f6f-92ac-606f68c65dfa@paulmck-laptop>
 <20250709180335.1716384-1-paulmck@kernel.org>
 <20250709154152.8d2a3de8894b80e4d85d1692@linux-foundation.org>
 <20250709184629.563f0cab@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709184629.563f0cab@gandalf.local.home>

On Wed, Jul 09, 2025 at 06:46:29PM -0400, Steven Rostedt wrote:
> On Wed, 9 Jul 2025 15:41:52 -0700
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Wed,  9 Jul 2025 11:03:33 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > Add a simple single-threaded smoke test for lib/ratelimit.c
> > > 
> > > To run on x86:
> > > 
> > > 	make ARCH=x86_64 mrproper
> > > 	./tools/testing/kunit/kunit.py run --arch x86_64 --kconfig_add CONFIG_RATELIMIT_KUNIT_TEST=y --kconfig_add CONFIG_SMP=y lib_ratelimit
> > > 
> > > This will fail on old ___ratelimit(), and subsequent patches provide
> > > the fixes that are required.
> > > 
> > > [ paulmck:  Apply timeout and kunit feedback from Petr Mladek. ]  
> > 
> > The above line makes me suspect that this was paulmck tweaking someone
> > else's patch.  If the authorship correct on this one?
> 
> Looks to me that Paul just took some advice from Petr and was just giving
> credit. Perhaps he could lose the "paulmck:" part?

You got it!

> Perhaps:
> 
>   Suggested-by: Petr Mladek <pmladek@suse.com> # for timeout and kunit feedback

That would work for me.

							Thanx, Paul


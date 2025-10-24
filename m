Return-Path: <linux-kernel+bounces-869561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3416C082A9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D03354E1944
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E762FFFB9;
	Fri, 24 Oct 2025 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uENWQe8b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692EE2FFFB2;
	Fri, 24 Oct 2025 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761340745; cv=none; b=D0xciCSl3XbjBkQYB9u5siTTmRbN8vNR8t1p9Z1QcUpOTrLRiVtvuSmOloh7ZUW/FKHfpexRSPfK02++0ZdonO1PPq3ukKe+O3uIb3hgeJyFWQjHy3Wta6HX9WB1C+XHngQA6xOxUyMVp6D6BE+Mmcl7ro5uuQ95O11nzMEo5mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761340745; c=relaxed/simple;
	bh=ZKWamic7m6ZRpL9gN1BF3E5PIHieh5mZ72OC29kzCQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPg0eGGY6R6vz09oxRCgUDBWv/+BBzPGzRA9yV7sE4O4sKKKuWAzUWmC3vMSsX1BIfq5vc0z+OPtkiroqptL9HOGHm2jZZ9RxGnyy+5watjg/1uuQaf1Y3tMqBOloHxsApH3aPTEIXFbu4zyD0T03BUHpYQKUPZNd0w/QRfYkd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uENWQe8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36C9C4CEF1;
	Fri, 24 Oct 2025 21:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761340743;
	bh=ZKWamic7m6ZRpL9gN1BF3E5PIHieh5mZ72OC29kzCQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uENWQe8bIFieNVtT1CP7slpb6pdUPDSGBT+5dhNqlcc7mV7Sijgcv2mB3lTw77j3X
	 ASMo2XQEVQIr3q8J3fZA1x6zqgFGSZS1vbfkKv+GdMq0ccPOgDXRIk2/lL/VLVldQn
	 r2GZ4Amtrtkk5mfFWSFpgvuE/bBO0XGjMdAOpulq/Z/WwMKsnMl/I5Ymnmf2g8pE4E
	 L8UDEjmY6HVALqNqq9wuiXn7ET+t0W/yyCkv1+pXW+YhT3DjOo/Bp0CGw4vQzOiRCN
	 WIbEHJB1oAeJTJUmC4sc+gGWGRISTLQ27f2lyd1MY0fKKOC2oNKO9Cf1WxNP7Yv2fC
	 xTyTQlKNQD+Gg==
Date: Fri, 24 Oct 2025 14:19:01 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] sched: Remove never used code in mm_cid_get()
Message-ID: <20251024211901.GC2068@quark>
References: <20251015091935.2977229-1-andriy.shevchenko@linux.intel.com>
 <aPYKpJ4MdjlGeILa@ashevche-desk.local>
 <20251020104934.GQ3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020104934.GQ3419281@noisy.programming.kicks-ass.net>

On Mon, Oct 20, 2025 at 12:49:34PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 20, 2025 at 01:10:44PM +0300, Andy Shevchenko wrote:
> > On Wed, Oct 15, 2025 at 11:19:34AM +0200, Andy Shevchenko wrote:
> > > Clang is not happy with set but unused variable (this is visible
> > > with `make W=1` build:
> > > 
> > > kernel/sched/sched.h:3744:18: error: variable 'cpumask' set but not used [-Werror,-Wunused-but-set-variable]
> > > 
> > > It seems like the variable was never be used along with the assignment that
> > > does not have side effects as far as I can see. Remove those altogether.
> > 
> > Anybody to apply this for fixes?
> 
> Why? W=1 and WERROR is very much you get to keep the pieces land, no?

Tested-by: Eric Biggers <ebiggers@kernel.org>

Linus, could you consider applying this directly?  This seems to have
broken W=1 for basically the whole kernel.  I see many other people
already ran into this and sent the same patch
(https://lore.kernel.org/r/20251002-sched-w1-v1-1-a6fdf549d179@linaro.org
https://lore.kernel.org/r/20251009194818.1587650-1-kriish.sharma2006@gmail.com
https://lore.kernel.org/r/20251017073050.2411988-1-kevin.brodsky@arm.com
https://lore.kernel.org/r/20251020220601.176639-1-adigollamudi@gmail.com)
but unfortunately the maintainer is refusing to apply any of them.

I find W=1 to be useful, and I keep my subsystems W=1 clean.  But I
cannot do that if W=1 is broken for all kernel builds.

I think it's clear that a lot of other people find it useful too.

- Eric


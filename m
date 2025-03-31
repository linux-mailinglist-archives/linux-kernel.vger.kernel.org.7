Return-Path: <linux-kernel+bounces-581328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B83EA75DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 03:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC61D3A9059
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 01:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB8D7080D;
	Mon, 31 Mar 2025 01:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDl2uJsS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54813523A
	for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 01:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743385192; cv=none; b=f/+kyIjcOkdkWWFam594o24UEcCZrbfEcR/C02xOHBpguAXbEA2n5sb7POkhtjNWPgBHteUEKW8aOZkhnlYgEgTJ3UJsvqIfDn9i+AxU7kRg33qHj6Ps53Ck1WL83rN9jUpGOvIRir9aMx+qgeVpoVbn+/CB/basLzCgcVBmzBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743385192; c=relaxed/simple;
	bh=WofpQ5qLrWzLUcBlDJCYsikhvX94nh0bqkCL5Fqx7NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBdFrHQ8BVI+NKBhT05OBvzQkbD2Dw41SmliVHoLHIEEQ/X9qT24i0CJ6v4H12/Tv9uM9IXPXV1q6iHXGMvpbqu2HjpWaM5PYDNK8WOVepLkwiau30bcSt3YWYWzqUIXGgJN2MeZp+Gl+EDotllJkn8tl/Hth2RpSS6sfw7iLM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDl2uJsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F67EC4CEDD;
	Mon, 31 Mar 2025 01:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743385191;
	bh=WofpQ5qLrWzLUcBlDJCYsikhvX94nh0bqkCL5Fqx7NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDl2uJsSVD63QANTesA3q93OULFiBZl/fKqHi2TB2v/IrM266LvzlvC/leWua/FyT
	 NOnRUkpUZN0LYOGynNVz1enUXHktjKGrzpJgwjIJ0Wu/QR5n3X3SAr/T9XQ2MOT9s/
	 XEm3mxNgiTV+9z1EucsSHyHQlsJ4FXfLypUXW9+T8EePgxVP+IDuBegKCuZ6Io/7aA
	 dTZblgxaS5SeUGz5tUcsy4CU7vIn1xvwsgXG8RVB/8ijyHgHW9ArWcDIptsOP3Snm0
	 nGNw54dLU13nUYZenJnhQcP7edf7Dj2S6DXvPPI0/rS2EukRyN/xoUMmlaU+0K8VuO
	 DJzqEdCwXh8Yg==
Date: Sun, 30 Mar 2025 18:39:47 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [GIT PULL] objtool fixes and updates
Message-ID: <sdjfftubzcheo3dpejml54t6axfjfrd7pk6mnbkpb2n7alpfzn@6l6bldqfturq>
References: <Z-cSQXJKMyBSfAAc@gmail.com>
 <20250329153242.GAZ-gSmu8qiXufR04k@fat_crate.local>
 <CAHk-=wjqLm+eTuyLR_84vWOZK+AkhV==r=PcuAt3+3nf68SjOw@mail.gmail.com>
 <20250330231355.GFZ-nQM6NPcC7nWl__@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250330231355.GFZ-nQM6NPcC7nWl__@fat_crate.local>

On Mon, Mar 31, 2025 at 01:13:55AM +0200, Borislav Petkov wrote:
> On Sun, Mar 30, 2025 at 03:19:40PM -0700, Linus Torvalds wrote:
> > On Sat, 29 Mar 2025 at 08:33, Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > Btw, test bot complains:
> > >
> > > https://lore.kernel.org/r/202503292202.Sge7ZEUc-lkp@intel.com
> > 
> > That's not a very helpful error message
> 
> I found this:
> 
> https://lore.kernel.org/r/202503280703.OARM8SrY-lkp@intel.com
> 
> which looks like the original report.
> 
> Looks unsolved yet...

The "new" warning is just the "skipping duplicate warning", which was
already merged with commit 0a7fb6f07e3a ("objtool: Increase per-function
WARN_FUNC() rate limit").  So none of the warnings are specific to this
pull request.

Tiezhu, can you please look at this warning?
  
   arch/loongarch/kernel/traps.o: warning: objtool: show_stack+0xe0: stack state mismatch: reg1[22]=-1+0 reg2[22]=-2-160
   arch/loongarch/kernel/traps.o: warning: objtool: show_stack+0xe0: stack state mismatch: reg1[23]=-1+0 reg2[23]=-2-152

-- 
Josh


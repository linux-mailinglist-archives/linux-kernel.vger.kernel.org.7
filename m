Return-Path: <linux-kernel+bounces-839374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 691C7BB1800
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 20:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4B51947688
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 18:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A252D4B6C;
	Wed,  1 Oct 2025 18:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQWE0MOn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FEF258EDF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343605; cv=none; b=Ym3vqLZZJF/VO1CDkxMTvv2/xIb150G9PMQaClRn0La17cQ19gVLtmbHqqTylQvJ+gGuDKAglRRF2BunufGhtc2yZ1lgaZDBwWhvgeJZvjGtqYb0wm2QUoMuH/RxvRhZXGKEW23jrAiLncnheD+eWgcOGszPLn2zGcp6JOkxkV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343605; c=relaxed/simple;
	bh=ZLIoi/NYFfvh7MIGr5zx8UVJQvY41XwspSGk66LmUh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RExUbzfhxmB9n6AIDKxMqxv1vkY3XDj5SLPUY6NftCUpHlyvXQhHKgTflT4U/4eoBEhmPm8iSO2Fn6+jbK3ipbRphVVXlFktCfn2N1pGI1lQqnAq2fq+5Mr38+kSSUn+1H7aKglE5IngZp8V9dOm+yPnTVRleo6ayQKE9XyZ7rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQWE0MOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BC5C4CEF9;
	Wed,  1 Oct 2025 18:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759343604;
	bh=ZLIoi/NYFfvh7MIGr5zx8UVJQvY41XwspSGk66LmUh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQWE0MOnhjMNSXVa/1zMRyDFAdNQm/EYGzhoxA0dysuEBW5+sHphaUoLTcrA3fhZE
	 SATTt5c3i8IngdVcWA59VotNW/5nrxzWkHzxi+wbf5i7hoVihA4k6a0y1X6aQ87X9U
	 bAhkHrcLC6Z/47y0IEhk439RnjbvtZEGT/PrBVnvrno6OAkpDpbwOzWAua12TyVEjH
	 yNBG1HS/l1D5Isj0UQrlyg1GiQb2dw4FZnOprZbWQan/TCQ7J/GjUVTo0qWmTn7byA
	 FlvITMTH9WrbipDPvhIAmjRcZRd0DmHruMt8RCP4fFT26VrHaS3dojWa/ELJrsLrLL
	 N5ZfjZ/AMpwtQ==
Date: Wed, 1 Oct 2025 11:33:21 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc1
Message-ID: <20251001183321.GA2760@quark>
References: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org>
 <066d70c7-b0a7-45e5-9337-17901bc95664@codethink.co.uk>
 <CAHk-=wgfpswvq0TypePyjv3dofO5YaUC_fSd_MjzY7jogCUnCg@mail.gmail.com>
 <CAHk-=wgYcOiFvsJzFb+HfB4n6Wj6zM5H5EghUMfpXSCzyQVSfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgYcOiFvsJzFb+HfB4n6Wj6zM5H5EghUMfpXSCzyQVSfA@mail.gmail.com>

On Tue, Sep 30, 2025 at 04:53:24PM -0700, Linus Torvalds wrote:
> On Tue, 30 Sept 2025 at 09:04, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Oh Christ. Is somebody seriously working on BE support in 2025?
> 
> Ok, I just googled this, and I am putting my foot down:
> 
>  WE ARE NOT PREEMPTIVELY SUPPORTING BIG-ENDIAN ON RISC-V
> 
> The documented "reasoning" for that craziness is too stupid for words,
> but since riscv.org did put it in words, I'll just quote those words
> here:
> 
>  "There are still applications where the way data is stored matters,
> such as the protocols that move data across the Internet, which are
> defined as big-endian. So when a little-endian system needs to inspect
> or modify a network packet, it has to swap the big-endian values to
> little-endian and back, a process that can take as many as 10-20
> instructions on a RISC-V target which doesn’t implement the Zbb
> extension"
> 
> In other words, it is suggesting that RISC-V add a big-endian mode due to
> 
>  (a) internet protocols - where byte swapping is not an issue
> 
>  (b) using "some RISC-V implementations don't do the existing Zbb
> extension" as an excuse
> 
> This is plain insanity. First off, even if byte swapping was a real
> cost for networking - it's not, the real costs tend to be all in
> memory subsystems - just implement the damn Zbb extension.
> 
> Don't go "we're too incompetent to implement Zbb, so we're now asking
> that EVERYBODY ELSE feel the pain of a much *worse* extension and
> fragmenting RISC-V further".
> 
> I'm hoping this is some April fools joke, but that page is dated
> "March 10, 2025". Close, but not close enough.
> 
> This is the kind of silly stuff that just makes RISC-V look bad.
> 
> Ben - I'm afraid that that page has "further reading" pointing to codethink.
> 
> I see some CONFIG_CPU_BIG_ENDIAN has already made it in, but this
> needs to stop.
> 
> The mainline kernel is for mainline development. Not for random
> experiments that make the world a worse place.
> 
> And yes, we're open source, and that very much means that anybody is
> more than welcome to try to prove me wrong.
> 
> If it turns out that BE RISC-V becomes a real thing that is relevant
> and actually finds a place in the RISC-V ecosystem, then _of_course_
> we should support it at that point in the mainline kernel.
> 
> But I really do think that it actually makes RISC-V only worse, and
> that we should *not* actively help the fragmentation.

+1.  Please, let's not do big endian RISC-V kernels :(

This mistake was made for arm64, it's finally getting fixed.
See https://lore.kernel.org/r/20250919184025.15416-1-will@kernel.org/
Let's not make the same mistake again.

And as someone who works on optimized crypto and CRC code, the arm64 big
endian kernel support has always been really problematic.  It's rarely
tested, and code that produces incorrect outputs on arm64 big endian
regularly gets committed and released.  It sometimes gets fixed, but not
always; currently the arm64 SM3 and SM4 code produces incorrect outputs
on big endian in mainline.  (I don't really care enough to fix it, TBH.)

I recently added arm64 big endian to my own testing matrix.  But I look
forward to dropping that, as well as *not* having to start testing on
RISC-V big endian too...

Of course, that's just one example from my own experience.  There's a
lot more that CONFIG_CPU_BIG_ENDIAN creates problems for.

- Eric


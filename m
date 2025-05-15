Return-Path: <linux-kernel+bounces-649003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A22AB7EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 09:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48421BA2208
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 07:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915181FAC4B;
	Thu, 15 May 2025 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2zw9mFU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0473C00;
	Thu, 15 May 2025 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747293472; cv=none; b=BXrt1ejGzV/el37CbtShChJDETnDdFE/27FGQnZnCdsJhceKKs8xh4kzGpEKL27wbLQElW6y3JF9vrj7RKC0+h9LHwiE1Fvkyc/Kyqvm84CKC/x74Dk7z8xpD/7NYEJH3wipcLnRJ298T1vTKTH+WLVfcFeX3AfS+8ESGwKHYXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747293472; c=relaxed/simple;
	bh=SsLAI4som5AdBLbBTAAoaHXnIvb3gOFyZy6oRKj3ZYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSTSSTlE3ZvwmgVKnSwavardJMHrSJhOvUorDOZIxvZJ20/FAMAXmflnO6hmK1aXeiSsKZsrX3vs6KV6UUqPK1bTMTJTXCuWRc2wPI+X0yrzC+e9DpqMZfPO4RXqxi7YcyoG5GsViW161+KdOPViyG9rKfBygNey7LejvdvByHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2zw9mFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2778EC4CEE7;
	Thu, 15 May 2025 07:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747293471;
	bh=SsLAI4som5AdBLbBTAAoaHXnIvb3gOFyZy6oRKj3ZYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2zw9mFUc8wLSOKYRaKVw4nywKsvOF1K+FzaijttX3cWxjp5F1Zi+zPoKkxVszrwF
	 X3gGIaAI2V1Wg1MM2VizM89CZ3c9rnO69klX5apgng5I89hnDHnxbgzazgg6y9cBBK
	 te6EzYVEvZYea7DXnLEBaLJuZjpIUBqO2sdfGmD2fEhTAb3OJHcCNvqgU0ABLtAwJX
	 NtBSd4taTsKwO1IMvLDoF2swsJq7iKh3WmigyX00XjP7KLmpA8h5HuGapXTxVbaDiv
	 RkLA7JCfIErS3diyZKVgCaIAUDh+XUvIHFZV6k+ldrEmLG+rvYyrLduFgnM51GLtQ+
	 SOPn7dbTasFKQ==
Date: Thu, 15 May 2025 09:17:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb+git@google.com>,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	x86@kernel.org, Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFT PATCH v3 00/21] x86: strict separation of startup code
Message-ID: <aCWVGtLo7XhW7aT0@gmail.com>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512191705.GHaCJJMcpPTS4ioLpm@fat_crate.local>
 <aCMYrgd9DDQl7G1W@gmail.com>
 <20250513101250.GAaCMbIpk6kdVMizng@fat_crate.local>
 <aCMraFZ2yJQNyHf3@gmail.com>
 <20250513141633.GDaCNUQdRl6ci2zK5T@fat_crate.local>
 <CAMj1kXEzKEuePEiHB+HxvfQbFz0sTiHdn4B++zVBJ2mhkPkQ4Q@mail.gmail.com>
 <aCQ444zAwwkUwwm8@gmail.com>
 <CAMj1kXE0UHyTXZ31R_ps=Nk0+AsFy1tLj04Zg6cR90wdN=7pBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE0UHyTXZ31R_ps=Nk0+AsFy1tLj04Zg6cR90wdN=7pBA@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Wed, 14 May 2025 at 07:32, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> ...
> > > In any case, there is no urgency wrt these changes as far as I am
> > > concerned, and given that I already found an issue myself with v3,
> > > perhaps it is better if we disregard it for the time being, and we can
> > > come back to it for the next cycle. In the mean time, I can compare
> > > notes with Boris and Tom directly to ensure that this is in the right
> > > shape, and perhaps we could at least fix the pgtable_l5_enabled() mess
> > > as well (for which I sent out a RFC/v3 today).
> >
> ...
> > We could perhaps do the mechanical code movement to
> > arch/x86/boot/startup/ alone, without any of the followup functional
> > changes. This would reduce the cross section of the riskiest part of
> > your series substantially.
> 
> The first phase of this work, which is already queued up, was to move
> all of the source files that were using RIP_REL_REF() into
> arch/x86/boot/startup to be built with -fPIC so that RIP_REL_REF()
> could be removed.
> 
> The current phase is to separate code that really needs to live under
> startup/ from code that doesn't. This is the bit that was
> straight-forward for mapping the kernel (including the SME encryption
> pieces) because they were already in dedicated source files, but not
> so straight-forward for SEV-SNP.
> 
> In reality, the mechanical code movement in this phase is mostly in
> the opposite direction, where things are separated into startup and
> non-startup code at a high level of detail, and the latter is moved
> out again.
> 
> > If that sounds good to you, please send a
> > series for review.
> >
> 
> Not sure what happened to the tip/x86/boot branch in the meantime,

It got merged into tip:x86/core. I wrote you an email about it 
yesterday, should be somewhere in your inbox. :)

> [...] but assuming that what was already queued up is still scheduled 
> for the next cycle, I don't think there are any parts of this series 
> that could be meaningfully rearranged. IOW, the SEV-SNP refactoring 
> needs to be completed first, which accounts for most of the code 
> movement.

Understood.

Thanks,

	Ingo


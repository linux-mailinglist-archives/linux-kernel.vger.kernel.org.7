Return-Path: <linux-kernel+bounces-649893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75199AB8A71
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 17:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E620189D49E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 15:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3661120FA81;
	Thu, 15 May 2025 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqUrube6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D77E7262E;
	Thu, 15 May 2025 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747322326; cv=none; b=djeO4ATpQVMaGB4x2uwCctCQCFUvXLPZ+ycvuJNJJOYwDIzFQNkV1soSgnxYrcqhZ4LMLLutARsrJHDETs4QhFLW4wg5vxCz5Qp3WCzw16SQ5MVRLfQoJ8O5BebMnDWfC/JotkKEruE9uynqsC9E3xmnlNBJAdPHxRIHmf8/1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747322326; c=relaxed/simple;
	bh=X3XWbQq+H47jtI2k6k/3sb8AJxjpUzMbqBhGMs8AtsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OE7+XrKv15x6YPAj4ZzFi5lR8sI8WmHuLVp7bL1qmvooyu9KH7rOVl3R7JVkqKm+V5rhW2+vqbiG0uw5E96aaAtd5v3TaeYn8rVIvo2ioZfFrxUWjoc+M0nImD7tvkLBhdw5bTVWVoLqS7RuyJdhf8j5edBUxhubAcJs7e6EV4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqUrube6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03ECFC4CEEB;
	Thu, 15 May 2025 15:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747322325;
	bh=X3XWbQq+H47jtI2k6k/3sb8AJxjpUzMbqBhGMs8AtsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DqUrube6sVoeKmbRyuuHJymJMsNre+DSW+ijeQwswLfsQB9Q8xavcKmpQu350VKZf
	 Y8OpK0u4/3JZAWDahUXawNk56s9Z++MLAf+A3RYk754+ORRMNYFyxg0YGTaLA1rYge
	 Gca3N8eL5KnykWsQhDScay5GJI3SgaN0FFFD2hPI7nGnxWS5Ns2qNp3IN1RmDBSOeX
	 BJ2eRYs8rrhQ9QoMk4fE2QGv32riuRget7ihySTAj8CMLIzaeWmEt5px8Wyz6EP17N
	 VzSC4Ztoug0MJovw9s+Hba6arwOOhIAsVsC4loG4Q8yu/3Er11hoWTATExCN0VSydI
	 myAJFbBOmsCxw==
Date: Thu, 15 May 2025 17:18:40 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v3 01/21] x86/sev: Separate MSR and GHCB based
 snp_cpuid() via a callback
Message-ID: <aCYF0J0mCJdz61Ep@gmail.com>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512190834.332684-24-ardb+git@google.com>
 <aCWWPmVloPP0_St0@gmail.com>
 <CAMj1kXE0o+ody9V0APmDqRT=skiUyeDDYE3dMVi+sngQ8QxSFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE0o+ody9V0APmDqRT=skiUyeDDYE3dMVi+sngQ8QxSFA@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Thu, 15 May 2025 at 08:22, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ard Biesheuvel <ardb+git@google.com> wrote:
> >
> > > +     if (cr4 & X86_CR4_OSXSAVE)
> > > +             /* Safe to read xcr0 */
> > > +             ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
> > > +     else
> > > +             /* xgetbv will cause #UD - use reset value for xcr0 */
> > > +             ghcb_set_xcr0(ghcb, 1);
> >
> > Just a couple of style nits here - this new __sev_cpuid_hv_ghcb()
> > function
> 
> __sev_cpuid_hv_ghcb() is just being moved from one source file to
> another - I didn't change a single line, and so I don't think tweaking
> the style is appropriate for this patch.

Yeah, fair enough - in fact changing anything in a pure-movement patch 
would be counterproductive.

Thanks,

	Ingo


Return-Path: <linux-kernel+bounces-649362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7C0AB83A2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 12:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF6B8C2CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 10:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8B31DE4E3;
	Thu, 15 May 2025 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LS2zVV+o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFD222540A
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747304110; cv=none; b=uEl+tpdi7cdCuaHKz23S9SZyIVOqL2Db5V3dK1AzH8UVVKXn02xfit77sV/MBGAITNTrfn6NEQxfNfptJwRp6tUdSMZJtF9eZ2/zklBEyoddxtX+s1G5peixmdp7/0gOLuuC9QXcTzbINs9wYFFPAAXbqZZPPkRuePxwEEr+aAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747304110; c=relaxed/simple;
	bh=r3sWaoY77VDfVRoFeW9nYX3iyfdf+ShPmVfkLtWP8FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tsrcc8noJWoRkG6dvVPp3hc4LEqkTbuI5OmAiQrCox8LwPJ/fyH/SukInj9A6QmF+lkMJxpcTGsKfW81fLpYzozcaNG9vy3rXGL0/dO0NE8qGyskDeoU+sOGEmubMONGLpAn+xz/H1nR3QuiH/tnYpyUifyrr33vm4/B1p8xs+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LS2zVV+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7A4C4CEE7;
	Thu, 15 May 2025 10:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747304110;
	bh=r3sWaoY77VDfVRoFeW9nYX3iyfdf+ShPmVfkLtWP8FA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LS2zVV+ob5B0Q6bvAebAvKR7L7P+zq888o3iTTktiqstJ9DhmfCLQVSGDcdMH6jAt
	 M++LrorJBuH+gjSPIeaDqw8l2FqqLJNX37PaSVgvoW4je/+Rk3ezCGg6ZVRtF3maYt
	 +po8BAsc3imQaFEpJysvxLKkyVEBBos9lqMQAgHNN7AkILmG4ZHSPvou746L6Paw4I
	 d9yszlXFqto18aH0FWOeM43Nw/MeKdaU8iWG1w27geylLnL5KfD3nNqu8jZzqRFpoh
	 sOdeFO1aK761R/ibr/XzBjJcaDhSXsKK3YXYhZGpGsMWAXZ2sm2ERw5rX5sL6ZFTe3
	 vkL6b47LQxsGw==
Date: Thu, 15 May 2025 12:15:04 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Juergen Gross <jgross@suse.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH 02/29] x86/boot/e820: Simplify e820__print_table() a bit
Message-ID: <aCW-qKOYJWRLYgpx@gmail.com>
References: <20250421185210.3372306-1-mingo@kernel.org>
 <20250421185210.3372306-3-mingo@kernel.org>
 <aAcvmqyP5Jq2Quyl@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAcvmqyP5Jq2Quyl@kernel.org>


* Mike Rapoport <rppt@kernel.org> wrote:

> On Mon, Apr 21, 2025 at 08:51:42PM +0200, Ingo Molnar wrote:
> > Introduce 'entry' for the current table entry and shorten
> > repetitious use of e820_table->entries[i].
> > 
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: Arnd Bergmann <arnd@kernel.org>
> > Cc: David Woodhouse <dwmw@amazon.co.uk>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  arch/x86/kernel/e820.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> > index 4a81f9e94137..b1a30bca56cd 100644
> > --- a/arch/x86/kernel/e820.c
> > +++ b/arch/x86/kernel/e820.c
> > @@ -204,12 +204,14 @@ void __init e820__print_table(char *who)
> >  	int i;
> >  
> >  	for (i = 0; i < e820_table->nr_entries; i++) {
> > +		struct e820_entry *entry = e820_table->entries + i;
> > +
> >  		pr_info("%s: [mem %#018Lx-%#018Lx] ",
> >  			who,
> > -			e820_table->entries[i].addr,
> > -			e820_table->entries[i].addr + e820_table->entries[i].size - 1);
> > +			entry->addr,
> > +			entry->addr + entry->size-1);
> 
> nit: entry->size - 1

So it's a judgement call, and here IMHO it's easier on the eyes and 
more straightforward when entry->size-1 is grouped together visually, 
which is the offset of the last byte in this E820 region.

I don't agree with the mindless conversion patches that do this 
indiscriminately:

  s/x-1
   /x - 1

Typographically and stylistically there's nothing wrong with 'x-1'.

In fact the grouping has advantages, for example this hypothethical 
buggy piece of code:

	addr_next - size-1

is much more obviously incorrect 'at a glance' during review than this 
one:

	addr_next - size - 1

Thanks,

	Ingo


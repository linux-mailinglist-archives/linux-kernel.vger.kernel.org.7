Return-Path: <linux-kernel+bounces-854832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE7FBDF7F2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E6F188F279
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528F3335BAF;
	Wed, 15 Oct 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cugAuMxJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26E330D36
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543782; cv=none; b=L8N7fZGnYY1hwsSHg68GbR+gK/ANw7CFpRVr8u0rZgo2kULCyXqoM4G6PBtQb1mDI81+6dDV+KnCDE/hes/8f/NsnHHrJHl1Q5MXaUrFuAYGthwST63xDGK0AS0lpd8EotBFQDDswhGa1XD4Hbikt8VbeX6d2Jd0J05qSEoKpf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543782; c=relaxed/simple;
	bh=cJpkQkvg9fR8+CIEr74ouh8Nv7Sf2CO814B3HaMIhMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJZonF49ULZ4P4YBTcm25W8UvDjtGqAo5+a6NgZOiYhPfVBnn3H6LmbemRehmT+QQsqVeQWqOpm/fGoQxzY6BFs+i5zPDGCOt0j412nIdoqSsTQPyXVudNvyCJZNQD8474luqLFMbvdbZWuWrWLx2cmR8uoBCpcvYQzNwiMl0nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cugAuMxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FF7C4CEF8;
	Wed, 15 Oct 2025 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760543781;
	bh=cJpkQkvg9fR8+CIEr74ouh8Nv7Sf2CO814B3HaMIhMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cugAuMxJcoOZnjCzupd381imG+1qYBwS09qCp4U87zOY6N/LBaI3uNRyPY3a8D+bu
	 Q9ayIdQHnJDBi1ReTEFgECKc9qsNDwz5gQts+LAp3GC66TgHw0sAp+vWScgdHwqxUt
	 FqXYXJxvcbrSmbvE0lxqBCKBeCF2L3ujtnrmRPsvWjnl3JUTvms1I2hhM5uAMmb78e
	 BJeOMwZo3OKOe5i/7aZ4p8aBKPrxm78OpAmPpEoQMRF01lD4DtPvVxGq1x5kHCyvfs
	 x33iVZoH+f9BzT7sEd7rJUpmF+26yJ02LLy4k/5ZWc7o2WPMIMb9FHN/GId++iBmRP
	 BG4N7o0xzMmhg==
Date: Wed, 15 Oct 2025 08:56:19 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] objtool: fix failure when being compiled on x32 system
Message-ID: <scpfhyfcieyydbzpjh7r25mouuzkt7gskqftqhzzcetuwb7hwa@2bvnhvhluyv6>
References: <f80021c8-f8e1-9ed2-4791-705c4d7b7b8a@redhat.com>
 <CAMj1kXHsiSB6aQVhqTbS0vhcEgk0TpP+4bxzSA5T0s6WrK2ZjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXHsiSB6aQVhqTbS0vhcEgk0TpP+4bxzSA5T0s6WrK2ZjQ@mail.gmail.com>

On Tue, Oct 14, 2025 at 09:33:08AM +0200, Ard Biesheuvel wrote:
> (cc lkml)

Can you resend the patch and copy lkml?

> On Mon, 13 Oct 2025 at 22:21, Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > Fix compilation failure when compiling the kernel with the x32 toolchain.
> >
> > In file included from check.c:16:
> > check.c: In function ‘check_abs_references’:
> > /usr/src/git/linux-2.6/tools/objtool/include/objtool/warn.h:47:17: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 7 has type ‘u64’ {aka ‘long
> > long unsigned int’} [-Werror=format=]
> >    47 |                 "%s%s%s: objtool" extra ": " format "\n",               \
> >       |                 ^~~~~~~~~~~~~~~~~
> > /usr/src/git/linux-2.6/tools/objtool/include/objtool/warn.h:54:9: note: in expansion of macro ‘___WARN’
> >    54 |         ___WARN(severity, "", format, ##__VA_ARGS__)
> >       |         ^~~~~~~
> > /usr/src/git/linux-2.6/tools/objtool/include/objtool/warn.h:74:27: note: in expansion of macro ‘__WARN’
> >    74 | #define WARN(format, ...) __WARN(WARN_STR, format, ##__VA_ARGS__)
> >       |                           ^~~~~~
> > check.c:4713:33: note: in expansion of macro ‘WARN’
> >  4713 |                                 WARN("section %s has absolute relocation at offset 0x%lx",
> >       |                                 ^~~~
> >
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > Fixes: 0d6e4563fc03 ("objtool: Add action to check for absence of absolute relocations")
> >
> > ---
> >  tools/objtool/check.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Index: linux-2.6/tools/objtool/check.c
> > ===================================================================
> > --- linux-2.6.orig/tools/objtool/check.c        2025-10-13 21:42:48.000000000 +0200
> > +++ linux-2.6/tools/objtool/check.c     2025-10-13 21:48:33.000000000 +0200
> > @@ -4710,8 +4710,8 @@ static int check_abs_references(struct o
> >
> >                 for_each_reloc(sec->rsec, reloc) {
> >                         if (arch_absolute_reloc(file->elf, reloc)) {
> > -                               WARN("section %s has absolute relocation at offset 0x%lx",
> > -                                    sec->name, reloc_offset(reloc));
> > +                               WARN("section %s has absolute relocation at offset 0x%llx",
> > +                                    sec->name, (unsigned long long)reloc_offset(reloc));
> >                                 ret++;
> >                         }
> >                 }
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

-- 
Josh


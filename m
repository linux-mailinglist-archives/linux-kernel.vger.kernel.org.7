Return-Path: <linux-kernel+bounces-721525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4053AFCA65
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF954833DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5872DBF43;
	Tue,  8 Jul 2025 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBy4rv0o"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDDE220F4C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977684; cv=none; b=vBInLQv0eeUvirV2+FSNjHLwXrqafin32rKcuEAU7QzMkFliOM4Hhk5TJin0XlwP63etIyavRosXluQn191Zj381/fbrEIXEjkWioc9xrB4Dy/oUZmBISCcrjfJ5z/j2sxKNGtWrvpU0warRjQZGaGiognAnogMOxup9NLPfatA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977684; c=relaxed/simple;
	bh=v7wN7F5f7ddJ4DjtsXda1E0+fcbYY1SkIquo+5cA75g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtHwW8rVXQq5hugYKM4K8EcqlW5zuBDb0a8sbofcZcByk4r0DHIvRAQo/f9mjG20FHKaXtRfAJBrXC9AHlbLteQKWFXJhv4nQlavjt0mj1Wo0XtXYeo2tSgm5ijThc4F0Dv07i0XFzJibfeyalMJfp8xa+/PoeQdYLXKYD7lHRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBy4rv0o; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32f1df58f21so28035581fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 05:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751977681; x=1752582481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0DPfjyuVlXXsi5ftQdkUNQRfIJjJbSSTbPWyxHVJT3s=;
        b=BBy4rv0ollx2MRi1ED7jCJtK7DwNS8GzzF+2rdQFuB6mKLwsAaTy5l0PLse/NF9W2m
         2vUiG1edVN1bvBYnARZ5pxAaqpORI71PA8enYYq0RVkrYx+2xQjglIob0jiEcVRFnfVw
         INfoZiTyPrfYejFdDKwopTPr9eXkIRvzCoRyuercYWPQutHU/NxB14WWKh/iAOnSjJRV
         Ih7LBJobjEksgfwlJAPfFOOL0iqeRwtmB5PT7/L3FVcI5seVXSp8LLMcLi+KhVrk5sNv
         w3GrsKy0uiuDv93ChIK5VrcbwG8kZ6serzB+HAd7xssLhwAdgM4DUeff9M73S2qlC2Ww
         6u3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751977681; x=1752582481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DPfjyuVlXXsi5ftQdkUNQRfIJjJbSSTbPWyxHVJT3s=;
        b=m4e8QJtd+zgEbAVEPDM/d3chfxTf4xQlPf1pLhWUlGu5KjH8Pi27V2yYMejy0O+Gfe
         SBhLxhNcJm0iD9Nd9mg5R25iAxjWUulY8kgJmDG9XKQtczfJWkuVHvvqdMZMs8DI6vBB
         pzOVk8KFFhQYtvjmnPRngip0ofmcwO/kYMK2z39vQQuvbs1rfHSUYELnls4tiDZQFn/Y
         e2+dt0LTBxVMZxkBsDjXqoeb8kz3nnLeRZwYCEnkExxHnFI0ND8Cv+s1ntkdt/zU/70U
         K4yGPb3B6WMYyWfwfjUgGzHoyomF9kJM8w8e+avHsNSVA2udL0LOxJMnEomN2TMIbAAt
         CMUw==
X-Forwarded-Encrypted: i=1; AJvYcCVDEgnUI8OllDGZZTFdioZ86/sTzBR+svO1Q17r+7CgIi7s+ebDbbsDdzQeNLb89FYrBl/KHieIEt3Ly2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/JP9qbxE7BX1Vyq4u1N3lTPrOf+Wxddgkx8SlfDJbiUe6OcXA
	JJdcg70r02uBuzmNYaShZRHe580f2C+ojTtSn8Hv0yYGTIFGfN6pjoAr
X-Gm-Gg: ASbGncsld5Hgp0OErTznjcWT2pTXwealFz2IbiscLHmBi5hfnikLtcEP0g81uAsX9s6
	Dg2g5vZ/+kGJVPAwtv7D9gY4C8R2yIwlcovRMKsonj+7xjFMmzkXL4x0ant4kwarZuKekmrEX/+
	gNoU6+rRvr3+NOfDeciEKdsbhXXGcjNmSsVfsh/xPiOmqkVbrrCqdC50oJv+3fSNYp6X7RNJfKT
	d4uLnkkhpk3w2ziYB3lXQ8JQseMqT086ev+ecmy+w9NTDy00EOQ8YWuV/uq7HfsNDzwJDBfMgNr
	0c6xs0r2ezT6qpdaP6tVdmQlDmDLnQJ2f3vGc+hASjqRKoymishBMEVrn8Y19ZhVosuubRhTGhr
	KCktTzJpETC0=
X-Google-Smtp-Source: AGHT+IGpc6z8fSUIrwMfew6wZtyxhbGdxLVk9CwZmf1Ma6HTtQ5CZu+hNcg6avruLSsKeeTuxQBKWA==
X-Received: by 2002:a05:651c:10a1:b0:32b:387b:de0e with SMTP id 38308e7fff4ca-32e5f568d0fmr42522861fa.7.1751977680464;
        Tue, 08 Jul 2025 05:28:00 -0700 (PDT)
Received: from pc636 (host-95-203-1-180.mobileonline.telia.com. [95.203.1.180])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32e1b1216d0sm16097591fa.71.2025.07.08.05.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 05:27:59 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 8 Jul 2025 14:27:57 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>
Subject: Re: [RFC 6/7] mm/vmalloc: Support non-blocking GFP flags in
 __vmalloc_area_node()
Message-ID: <aG0Ozc3Mro95djxn@pc636>
References: <20250704152537.55724-1-urezki@gmail.com>
 <20250704152537.55724-7-urezki@gmail.com>
 <aGtzgOXdhAAOTBhs@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGtzgOXdhAAOTBhs@tiehlicka>

On Mon, Jul 07, 2025 at 09:13:04AM +0200, Michal Hocko wrote:
> On Fri 04-07-25 17:25:36, Uladzislau Rezki wrote:
> > This patch makes __vmalloc_area_node() to correctly handle non-blocking
> > allocation requests, such as GFP_ATOMIC and GFP_NOWAIT. Main changes:
> > 
> > - nested_gfp flag follows the same non-blocking constraints
> >   as the primary gfp_mask, ensuring consistency and avoiding
> >   sleeping allocations in atomic contexts.
> > 
> > - if blocking is not allowed, __GFP_NOFAIL is forcibly cleared
> >   and warning is issued if it was set, since __GFP_NOFAIL is
> >   incompatible with non-blocking contexts;
> > 
> > - Add a __GFP_HIGHMEM to gfp_mask only for blocking requests
> >   if there are no DMA constraints.
> > 
> > - in non-blocking mode we use memalloc_noreclaim_save/restore()
> >   to prevent reclaim related operations that may sleep while
> >   setting up page tables or mapping pages.
> > 
> > This is particularly important for page table allocations that
> > internally use GFP_PGTABLE_KERNEL, which may sleep unless such
> > scope restrictions are applied. For example:
> > 
> > <snip>
> >     #define GFP_PGTABLE_KERNEL (GFP_KERNEL | __GFP_ZERO)
> > 
> >     __pte_alloc_kernel()
> >         pte_alloc_one_kernel(&init_mm);
> >             pagetable_alloc_noprof(GFP_PGTABLE_KERNEL & ~__GFP_HIGHMEM, 0);
> > <snip>
> 
> The changelog doesn't explain the actual implementation and that is
> really crucial here. You rely on memalloc_noreclaim_save (i.e.
> PF_MEMALLOC) to never trigger memory reclaim but you are not explaining
> how do you prevent from the biggest caveat of this interface. Let me
> quote the documentation
>  * Users of this scope have to be extremely careful to not deplete the reserves
>  * completely and implement a throttling mechanism which controls the
>  * consumption of the reserve based on the amount of freed memory. Usage of a
>  * pre-allocated pool (e.g. mempool) should be always considered before using
>  * this scope.
> 
I am aware about that comment. I had same concern about this, but it
looks like i/you may overshot here. Yes, we have access to memory
resrves but this only for page-table manipulations, i.e. to allocate
a page for 5-level page table structure. We have PGD, P4D, PUD, PMD
and PTE which is the lowest level and which needs pages the most.

As i see we do not free pages at least on PTE level, it means that
an address space is populated forward only and never shrink back.
Most of the time you do not need to allocate, this mostly occurs
initially after the boot.

>
> Unless I am missing something _any_ vmalloc(GFP_NOWAIT|GFP_ATOMIC) user
> would get practically unbound access to the whole available memory. This
> is not really acceptable.
> 
See above comment. If there is a big concern about this, i can add
memalloc_noblock_save() memalloc_noblock_restore() pair to eliminate
that concern. The context will be converted in a way that it drops
__GFP_DIRECT_RECLAIM flag.

Thank you for your comments and input i appreciate it.

--
Uladzislau Rezki


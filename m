Return-Path: <linux-kernel+bounces-619047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD441A9B69D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 20:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2B6E7B5BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 18:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561DF28DEE8;
	Thu, 24 Apr 2025 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTMSNTZX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF13F17A2EA;
	Thu, 24 Apr 2025 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745520162; cv=none; b=YzUwzyuSUdJr43oludvv0HleypN1egw13xecF4BNrPnyZAK2M/dMi4b13g00sro7jQVWfaHZIIQ3wPggnoJ9v0m4fa29UyktRdKcGTpvphwxW5hDqh070V6U06ONPVv7TTlIVS7WhgTgYyA3M1cei3Yn8qfptaGqygjb1kAGf6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745520162; c=relaxed/simple;
	bh=2qdkE4x2W0dSoJvO6MDB0Uk8zlBi3N+zDnj/Znpt48Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7MjRP6MHuldFbc/Bat4fGFUFOZDfwageTwsZlI6sJ5JNlEpMgw7WdrabQaruC3Z7S4TfWf6a3PvI3BtXzz0B2eaC4d+vV+AgyaJ9bEbaLqtyGHqm3wc/F5S68NQsPa0UoHLP/wjHD+cbu0UP2jm24ZdNlWpUA15JtF3VFgNYzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTMSNTZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232CAC4CEE3;
	Thu, 24 Apr 2025 18:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745520162;
	bh=2qdkE4x2W0dSoJvO6MDB0Uk8zlBi3N+zDnj/Znpt48Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FTMSNTZX8kORLzAsEEIX5Ti4RgZXoKJwhdVWVtI24hgp01OaWheb1weeKKyJB23KW
	 Xhd3E/Fc4yQ0NGYhb7tJLVAKCA3URPXG7P0GRbu61HCzOtTcFTDpzXS7X6TyRQFd3y
	 TkdoRkHvUUMIv2z6tgsqktbcAXoqCmXQprReq1EQLidWND6DDcuktfmKGXxu26drCl
	 wTv1+CoLP6os8Nz4YJYlZlj48ok4+TXIgtIkObA0JuvMI29TtKGWdqkHmR9EdIO5WC
	 ClmhduuEkBYFznTm3FstgsRQVbs3AtVUGyI8S7bm//qcehRJxMumicZbIKpfCH+QqU
	 oDXvRl5ppTFdQ==
Date: Thu, 24 Apr 2025 11:42:39 -0700
From: Kees Cook <kees@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Erhard Furtner <erhard_f@mailbox.org>,
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm: vmalloc: Support more granular vrealloc() sizing
Message-ID: <202504241136.8B4E729@keescook>
References: <20250424023119.work.333-kees@kernel.org>
 <aAoAU4vhrpxiXaLF@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAoAU4vhrpxiXaLF@pollux>

On Thu, Apr 24, 2025 at 11:11:47AM +0200, Danilo Krummrich wrote:
> On Wed, Apr 23, 2025 at 07:31:23PM -0700, Kees Cook wrote:
> > Introduce struct vm_struct::requested_size so that the requested
> > (re)allocation size is retained separately from the allocated area
> > size. This means that KASAN will correctly poison the correct spans
> > of requested bytes. This also means we can support growing the usable
> > portion of an allocation that can already be supported by the existing
> > area's existing allocation.
> > 
> > Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> > Closes: https://lore.kernel.org/all/20250408192503.6149a816@outsider.home/
> > Fixes: 3ddc2fefe6f3 ("mm: vmalloc: implement vrealloc()")
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Good catch!
> 
> One question below, otherwise
> 
> 	Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> 
> > @@ -4088,14 +4093,27 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> >  	 * would be a good heuristic for when to shrink the vm_area?
> >  	 */
> >  	if (size <= old_size) {
> > -		/* Zero out spare memory. */
> > -		if (want_init_on_alloc(flags))
> > +		/* Zero out "freed" memory. */
> > +		if (want_init_on_free())
> >  			memset((void *)p + size, 0, old_size - size);
> > +		vm->requested_size = size;
> >  		kasan_poison_vmalloc(p + size, old_size - size);
> >  		kasan_unpoison_vmalloc(p, size, KASAN_VMALLOC_PROT_NORMAL);
> >  		return (void *)p;
> >  	}
> >  
> > +	/*
> > +	 * We already have the bytes available in the allocation; use them.
> > +	 */
> > +	if (size <= alloced_size) {
> > +		kasan_unpoison_vmalloc(p, size, KASAN_VMALLOC_PROT_NORMAL);
> > +		/* Zero out "alloced" memory. */
> > +		if (want_init_on_alloc(flags))
> > +			memset((void *)p + old_size, 0, size - old_size);
> > +		vm->requested_size = size;
> > +		kasan_poison_vmalloc(p + size, alloced_size - size);
> 
> Do we need this? We know that old_size < size <= alloced_size. And since
> previously [p + old_size, p + alloced_size) must have been poisoned,
> [p + size, p + alloced_size) must be poisoned already?
> 
> Maybe there was a reason, since in the above (size <= old_size) case
> kasan_unpoison_vmalloc() seems unnecessary too.

Honestly I was just copying the logic from the prior case. But yeah, it
should be possible (in both cases) to just apply the changed span. For
the "size <= old_size" case, it would just be:

	kasan_poison_vmalloc(p + size, old_size - size);

(i.e. the kasan_unpoison_vmalloc() call isn't needed at all, as you say.)

And in the "size <= alloced_size" case, it would just be:

	kasan_unpoison_vmalloc(p + old_size, size - old_size, KASAN_VMALLOC_PROT_NORMAL);

and no kasan_poison_vmalloc() should be needed.

Do the KASAN folks on CC have any opinion on best practices here?

Thanks for looking it over!

-Kees

-- 
Kees Cook


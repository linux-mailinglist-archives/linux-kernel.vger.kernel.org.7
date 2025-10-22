Return-Path: <linux-kernel+bounces-864040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21362BF9C75
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1CAE3A8982
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB6D222581;
	Wed, 22 Oct 2025 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2Q0iTku"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0EA220F5C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761102227; cv=none; b=ReXWC0iBw0WKmV6WEepjIHsCxRuQrh3sb1mwcOVveRfLkRTgqew75ZxPPyljCua0lQfe3N98ul9bzSbgNnMCygb3Wofr9pDwMj70M2Z3ipwVgHp5U4EHR4h/nQ2PVhrygVHlS6bW3TEB/aed9Lr5fr5SBVH4P6sYqzYzzWsu9ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761102227; c=relaxed/simple;
	bh=GNknf7cAYZM4vHLwFSMCKH/cU4Cxaok774v4n0rDamM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wvz1atS5SHM/ODht1KiBaY9RKTOXSzUli1eNMrAUkIdaMldkFgeTN5iOFk+bTvgKY+HgrTzVDBDgL2lRPwFYN3tv9/An3ZUnAzIxviNoeEFD9+VnsbXnSevWBQYg0h/OMmXpGQalte265agZdEJRMLN8YmNhWLf3ZHiCEtHlm5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2Q0iTku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6658C4CEF1;
	Wed, 22 Oct 2025 03:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761102227;
	bh=GNknf7cAYZM4vHLwFSMCKH/cU4Cxaok774v4n0rDamM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j2Q0iTkuDZE51Vg1wpvY8r3vZgKmfxvkzLKY+rweO+ZNQGSI97g8xU7/hnAlch1cR
	 CvyUqLGtdSAC9Kdw85mOGJte+awVvvTfPwRJguLmt7o1onqTRSnc2Mo3STs3AnB8Bo
	 AVZyZBgjFz3nnjkm/2Hw/ew/YjaLoLN0sFR/EJsnY09FfPeMKUn+w4qypO7Go7E/cc
	 878c1xWcphXL0P4UYgwUs9TMTXY6c1rKo6qeBH4NNKUZ4uWcBKJcHfXQIPbdLF6q4B
	 yrECQz9L1Ua/mQ8F67x23e2fwVsQYBjQDqG3SZms00B9AcFSuFwrHBWpZLnQ5fGfSO
	 aVD1YnzjN1nMg==
Date: Tue, 21 Oct 2025 20:02:13 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH] mm/kmsan: Fix kmsan kmalloc hook when no stack depots
 are allocated yet
Message-ID: <20251022030213.GA35717@sol>
References: <20250930115600.709776-2-aleksei.nikiforov@linux.ibm.com>
 <20251008203111.e6ce309e9f937652856d9aa5@linux-foundation.org>
 <335827e0-0a4c-43c3-a79b-6448307573fd@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335827e0-0a4c-43c3-a79b-6448307573fd@linux.ibm.com>

On Fri, Oct 10, 2025 at 10:07:04AM +0200, Aleksei Nikiforov wrote:
> On 10/9/25 05:31, Andrew Morton wrote:
> > On Tue, 30 Sep 2025 13:56:01 +0200 Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com> wrote:
> > 
> > > If no stack depot is allocated yet,
> > > due to masking out __GFP_RECLAIM flags
> > > kmsan called from kmalloc cannot allocate stack depot.
> > > kmsan fails to record origin and report issues.
> > > 
> > > Reusing flags from kmalloc without modifying them should be safe for kmsan.
> > > For example, such chain of calls is possible:
> > > test_uninit_kmalloc -> kmalloc -> __kmalloc_cache_noprof ->
> > > slab_alloc_node -> slab_post_alloc_hook ->
> > > kmsan_slab_alloc -> kmsan_internal_poison_memory.
> > > 
> > > Only when it is called in a context without flags present
> > > should __GFP_RECLAIM flags be masked.
> > > 
> > > With this change all kmsan tests start working reliably.
> > 
> > I'm not seeing reports of "hey, kmsan is broken", so I assume this
> > failure only occurs under special circumstances?
> 
> Hi,
> 
> kmsan might report less issues than it detects due to not allocating stack
> depots and not reporting issues without stack depots. Lack of reports may go
> unnoticed, that's why you don't get reports of kmsan being broken.

Yes, KMSAN seems to be at least partially broken currently.  Besides the
fact that the kmsan KUnit test is currently failing (which I reported at
https://lore.kernel.org/r/20250911175145.GA1376@sol), I've confirmed
that the poly1305 KUnit test causes a KMSAN warning with Aleksei's patch
applied but does not cause a warning without it.  The warning did get
reached via syzbot somehow
(https://lore.kernel.org/r/751b3d80293a6f599bb07770afcef24f623c7da0.1761026343.git.xiaopei01@kylinos.cn/),
so KMSAN must still work in some cases.  But it didn't work for me.

(That particular warning in the architecture-optimized Poly1305 code is
actually a false positive due to memory being initialized by assembly
code.  But that's besides the point.  The point is that I should have
seen the warning earlier, but I didn't.  And Aleksei's patch seems to
fix KMSAN to work reliably.  It also fixes the kmsan KUnit test.)

I don't really know this code, but I can at least give:

Tested-by: Eric Biggers <ebiggers@kernel.org>

If you want to add a Fixes commit I think it is either 97769a53f117e2 or
8c57b687e8331.  Earlier I had confirmed that reverting those commits
fixed the kmsan test too
(https://lore.kernel.org/r/20250911192953.GG1376@sol).

- Eric


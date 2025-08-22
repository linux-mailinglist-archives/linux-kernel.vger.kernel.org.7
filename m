Return-Path: <linux-kernel+bounces-781165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A284B30E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031AB721469
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90942E2F04;
	Fri, 22 Aug 2025 05:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BALTpbRI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDD82E2DEF;
	Fri, 22 Aug 2025 05:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842081; cv=none; b=sY/MDvGDn1o66GMyHMyOAeMXGnviLHvRLRy+xvm/S62at5gsCk2rQmFtN2uTsmlS71+jXt/nLV8Oo4oxFBGTRqNKJNkOXJ6pSK2hMGORdPiIA8Nqny/fZzYZHgz1n5swxrKBzTGLAx2/cGgFFFi6Q35e/rBGg4ARTG6Ky1TJFtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842081; c=relaxed/simple;
	bh=2tPcGfaM9fCEwka0ObLPD13Jx+z47kuisz3Emc4w6xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaWwpQbqIVoWfQsVTSBlvXJO9tikZ9C3NGwXe5TWIt7bLFTMOXUZaWdxdmsnwu/zsN5aSqoCOtJpt9hZige1ydDxXfjhsZKHBvQD1w6jd/YrKT7z0vECmKEivmQA+txospgNHvgCMbQX+2BjusNtF57ChunDcilpYbPatb+0njk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BALTpbRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24A7C4CEF1;
	Fri, 22 Aug 2025 05:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755842081;
	bh=2tPcGfaM9fCEwka0ObLPD13Jx+z47kuisz3Emc4w6xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BALTpbRISpGpz7f9L+iMxDqhbRXo+WEArVF+If32LVKoLo9g1XGL7T6MEwr6Nir4A
	 U1RLLNsCiXjyVn5PsScryWng/UsqdS1yaluv95zbxPd+E3h9mEcib97pt7lU5mP3Tf
	 sEoEHAup6UQZ3wFig68QpIntp0PO95oZbgq6qUJdwrJC8nxcPSiJyHwmPrl5okW5UR
	 yp9w7LZzfEutso9xFz2djU61/c8wD9Ncqq9AmzhwF+PkqT9IZ5aKYlBfRhnGu28+Tp
	 5v2ByFvQuIYoslZlpKtrhKVW1XH/K4w5B0Q6K/3cDdAFQ+TNj832aGAMSjL9dYjk3D
	 JU9Sivey4NMNw==
Date: Fri, 22 Aug 2025 08:54:32 +0300
From: Mike Rapoport <rppt@kernel.org>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Justin Stitt <justinstitt@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 0/4] mm/mm_init: simplify deferred init of struct pages
Message-ID: <aKgGGLEcLEKEHt0Q@kernel.org>
References: <20250818064615.505641-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818064615.505641-1-rppt@kernel.org>

On Mon, Aug 18, 2025 at 09:46:11AM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Hi,
> 
> These patches simplify deferred initialization of the memory map.
> 
> Beside nice negative diffstat I measured 3ms reduction in the
> initialization of deferred pages on single node system with 64GiB of RAM.
> 
> I don't have access to large memory machines, so I'd really appreciate
> testing of these patches on them to make sure there's no regression there.
> 
> The patches are also available at git:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=deferred-memmap-init/v1
> 
> Mike Rapoport (Microsoft) (4):
>   mm/mm_init: use deferred_init_memmap_chunk() in deferred_grow_zone()
>   mm/mm_init: deferred_init_memmap: use a job per zone
>   mm/mm_init: drop deferred_init_maxorder()
>   memblock: drop for_each_free_mem_pfn_range_in_zone_from()

I've added those to memblock tree
 
>  .clang-format            |   1 -
>  include/linux/memblock.h |  22 -----
>  mm/memblock.c            |  64 -------------
>  mm/mm_init.c             | 195 +++++++++++++--------------------------
>  4 files changed, 62 insertions(+), 220 deletions(-)
> 
> 
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> -- 
> 2.50.1
> 

-- 
Sincerely yours,
Mike.


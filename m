Return-Path: <linux-kernel+bounces-775442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DA6B2BF2F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042621BC3E19
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88F4322C68;
	Tue, 19 Aug 2025 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFDpESJr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDCF275AF7;
	Tue, 19 Aug 2025 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600103; cv=none; b=WqDr84sF07E2ruVgiI/thl19iejzGP/8VSgjpo3NARNirpngqKmTr5U1ZsuJvGwP9KvgAoAnjjhFBFU31Q3YIVy4vT019aRBatFguJaw3Lblqc0pff9ujOhy6rxcNCe/lEWINuotmbrfdaQ3KpTMq1ZPZavZMH9pCq9H2VyfaBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600103; c=relaxed/simple;
	bh=UmXA3hH10zy8+VYUZwjfKTWE12C/YJb1FO+ttbcpVBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4YNKDdh+aJn8CWWBAIYQAzdBSA7gxZ9N+W3hv0E8hK8bu5P2LUzBfLH5eYd4XgqAdgEadELdHagsSIOtgoX+3VQAe6PhAxc6GGDJ6w2gGpgchwo5aJDESV/Npf6rTvg4IXYJ7PewxuTwweP/6DowlU72oz2PwxC+FwQ1VcJ/II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFDpESJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBF8C4CEF1;
	Tue, 19 Aug 2025 10:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755600102;
	bh=UmXA3hH10zy8+VYUZwjfKTWE12C/YJb1FO+ttbcpVBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PFDpESJrYV8aSfcoHIx0slZQ6yB1VuBnKvpYI5NhuQTBF/BfpMAwkixOe9YjrC9OI
	 sMAcowjDQJ/vAi4v8aa2B0mTMB4anaZ7rhXDbF1yA+IWOOxSf/fkcO9l/RCboZmmwI
	 0Px46iqYWBa34+zCyOeXrJCLLFlPYAfR5zcTAIND9kR7BprPF9izBk7ghY8hsi/N7V
	 cMZ9gcsZiK7kZJICRHm3h7gllnrbN49CFz6DzTsTJDO84T+rdlQUYwxJz53OTihlfI
	 bY3lqRXjcAfpMioNHTh8yX8eYTEwaLWu+wg7UVX6JJxZXu+w7Ffk98HnRlTSogbvql
	 pnaPoY5j4nPBg==
Date: Tue, 19 Aug 2025 13:41:35 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Justin Stitt <justinstitt@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 0/4] mm/mm_init: simplify deferred init of struct pages
Message-ID: <aKRU37wDTYYocsEh@kernel.org>
References: <20250818064615.505641-1-rppt@kernel.org>
 <20250819073941.esl7z5ibqqeabunh@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819073941.esl7z5ibqqeabunh@master>

On Tue, Aug 19, 2025 at 07:39:41AM +0000, Wei Yang wrote:
> On Mon, Aug 18, 2025 at 09:46:11AM +0300, Mike Rapoport wrote:
> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> >Hi,
> >
> >These patches simplify deferred initialization of the memory map.
> >
> >Beside nice negative diffstat I measured 3ms reduction in the
> >initialization of deferred pages on single node system with 64GiB of RAM.
> 
> Nice cleanup.
> 
> For this series:
> 
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

Thanks!

> I guess the speed up is from "use a job per zone". So we do initialization per
> zone instead of per memblock range in the zone, right?
 
Yes, we run a job per zone instead of a job per memblock range in the zone.

> >I don't have access to large memory machines, so I'd really appreciate
> >testing of these patches on them to make sure there's no regression there.
> >
> >The patches are also available at git:
> >https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=deferred-memmap-init/v1
> >
> >Mike Rapoport (Microsoft) (4):
> >  mm/mm_init: use deferred_init_memmap_chunk() in deferred_grow_zone()
> >  mm/mm_init: deferred_init_memmap: use a job per zone
> >  mm/mm_init: drop deferred_init_maxorder()
> >  memblock: drop for_each_free_mem_pfn_range_in_zone_from()
> >
> > .clang-format            |   1 -
> > include/linux/memblock.h |  22 -----
> > mm/memblock.c            |  64 -------------
> > mm/mm_init.c             | 195 +++++++++++++--------------------------
> > 4 files changed, 62 insertions(+), 220 deletions(-)
> >
> >
> >base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> >-- 
> >2.50.1
> >
> 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.


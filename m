Return-Path: <linux-kernel+bounces-777330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C8FB2D810
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2900A7BC945
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FBD25A645;
	Wed, 20 Aug 2025 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAAWiZLL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBAC2D6E72;
	Wed, 20 Aug 2025 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681620; cv=none; b=GtbctfdXdS5G5BDYGKY6Z5/GNFg/NRUVu41kpiQlg83OA4/0ESh4kbBwp3oyJ60+ANlSmP7TccuG7hTZ5Vwq2Nz4ma+O2otLFc1z6mr3ODTLIV+EzOEQ61R98nQujSpImikREVJASsz+TrsKfaRKv4JEFGQ0qb5X8wxfgIOaVeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681620; c=relaxed/simple;
	bh=Nl938A6iJK6CdtuEzfY9cpcmFgz8OpuOP7GsG6dKCOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWon9u9vaYQWAkGSP93RL3BKZ/+ramtkbR9PVHotx5//1KW+r2tE58mkpQurWeBIK/FjfZnA0xoYxH70oUou20pfxokfxWSeteD+PAvfkJgtU9u2GZGGEAJZkEYPPuS8mOc3b9veGixoIsYfASwh6Q5kdztmFLne2QhybMTK/Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAAWiZLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD27C4CEEB;
	Wed, 20 Aug 2025 09:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755681618;
	bh=Nl938A6iJK6CdtuEzfY9cpcmFgz8OpuOP7GsG6dKCOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CAAWiZLLuG/fhxkWeWfHkjBqB++AaNSHLweBGuZodrxUvH6ox+e8OM0FPBmAY3Mi9
	 y+ay84T0sxd8wwQITOrIXvJDTFKw9B8XYisORKO3SD1y/EkzzjxCSmVw09zFFZC0/I
	 eOpcYMILUzpCDnMmkZibCZgn1BHxlZQvnlcO4zAhC0TJ2kP7aixdHG5qfCSU2WIERw
	 QXalWSW7YLhZ32iJ0PlLCtpfOeCZRXKahYZDfvx5v94NhCpEE6IWHqap81IQ5eLkmf
	 +MfpktHllLg4AMAfHb1QPf7ZTqkXAXU+c+c4bsc3BkGQlskl/nKWWLUtG9msgTAISB
	 liz+11mSpVgWw==
Date: Wed, 20 Aug 2025 12:20:10 +0300
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
Subject: Re: [PATCH 1/4] mm/mm_init: use deferred_init_memmap_chunk() in
 deferred_grow_zone()
Message-ID: <aKWTSq-JcTviuGlU@kernel.org>
References: <20250818064615.505641-1-rppt@kernel.org>
 <20250818064615.505641-2-rppt@kernel.org>
 <20250819095223.ckjdsii4gc6u4nec@master>
 <aKRX9iIe8h9fFi9v@kernel.org>
 <20250819235158.mgei7l4yraheech4@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819235158.mgei7l4yraheech4@master>

On Tue, Aug 19, 2025 at 11:51:58PM +0000, Wei Yang wrote:
> On Tue, Aug 19, 2025 at 01:54:46PM +0300, Mike Rapoport wrote:
> >On Tue, Aug 19, 2025 at 09:52:23AM +0000, Wei Yang wrote:
> >> Hi, Mike
> >> 
> >> After going through the code again, I have some trivial thoughts to discuss
> >> with you. If not right, please let me know.
> >> 
> >> On Mon, Aug 18, 2025 at 09:46:12AM +0300, Mike Rapoport wrote:
> >> 
> >> In the file above this line, there is a compare between first_deferred_pfn and
> >> its original value after grab pgdat_resize_lock.
> >
> >Do you mean this one:
> >
> >	if (first_deferred_pfn != pgdat->first_deferred_pfn) {
> >		pgdat_resize_unlock(pgdat, &flags);
> >		return true;
> >	}
> > 
> 
> Yes.
> 
> I am thinking something like this:
> 
>  	if (first_deferred_pfn != pgdat->first_deferred_pfn || 
> 	    first_deferred_pfn == ULONG_MAX)
> 
> This means
> 
>   * someone else has grow zone before we grab the lock
>   * or the whole zone has already been initialized

deferred_grow_zone() can be called only before deferred_init_memmap(), so
it's very unlikely that a zone will be completely initialized here. We
start with at least one section with each deferred zone and every call to
deferred_grow_zone() adds a section.

And even if that was a case and first_deferred_pfn is ULONG_MAX, the loop
below will end immediately, so I don't think additional condition here
would be helpful.
 
> >> I am thinking to compare first_deferred_pfn with ULONG_MAX, as it compared in
> >> deferred_init_memmap(). This indicate this zone has already been initialized
> >> totally.
> >
> >It may be another CPU ran deferred_grow_zone() and won the race for resize
> >lock. Then pgdat->first_deferred_pfn will be larger than
> >first_deferred_pfn, but still not entire zone would be initialized.
> > 
> >> Current code guard this by spfn < zone_end_pfn(zone). Maybe a check ahead
> >> would be more clear?
> >
> >Not sure I follow you here. The check that we don't pass zone_end_pfn is
> >inside the loop for every section we initialize.
> > 
> 
> In case the zone has been initialized totally, first_deferred_pfn = ULONG_MAX.
> 
> Then we come to the loop with initial state:
> 
>     spfn = ULONG_MAX
>     epfn = 0 (which is wrap around)
> 
> And loop condition check (spfn < zone_end_pfn(zone)) is false, so the loop is
> skipped. This is how we handle a fully initialized zone now.
> 
> Would this be a little un-common?

Why? The important thing is (spfn < zone_end_pfn(zone)) is false, and I
think that's good enough.
 
> >> > 
> >> >-	/* If the zone is empty somebody else may have cleared out the zone */
> >> >-	if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
> >> >-						 first_deferred_pfn)) {
> >> >-		pgdat->first_deferred_pfn = ULONG_MAX;
> >> >-		pgdat_resize_unlock(pgdat, &flags);
> >> >-		/* Retry only once. */
> >> >-		return first_deferred_pfn != ULONG_MAX;
> >> >+	/*
> >> >+	 * Initialize at least nr_pages_needed in section chunks.
> >> >+	 * If a section has less free memory than nr_pages_needed, the next
> >> >+	 * section will be also initalized.
> 
> Nit, one typo here. s/initalized/initialized/

Thanks, will fix.
 
-- 
Sincerely yours,
Mike.


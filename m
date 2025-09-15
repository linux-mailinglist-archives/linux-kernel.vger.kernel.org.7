Return-Path: <linux-kernel+bounces-817440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A15AB58232
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887171AA82CF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184B827934B;
	Mon, 15 Sep 2025 16:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBuxdlii"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DBC22068F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954193; cv=none; b=rDqstiVZ1uLrF1UHGWCi6JznZsvJAF+NC4gPM7dBncGzNxVcw6TiD67Nwu9i2BO3e8Q/KNszIe1DVT/25QrQ42Hhc9/4aACQ47u0mbQC8C37jvDtwzmkv/daAyaKiYUkbDWjnWkoe3/frG8srrExXEAdKtCl0GNbaSyMcWiTeI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954193; c=relaxed/simple;
	bh=sFKlwRvnlnlP6/mO1ynOhYF6GOBs7Psz7KEyq9qFIiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQZre9cERwiV2J8myOSi984SX1/2W8QoWlgWbchoQyMDTPgTHCcc7kHTn/eZ9o0cJ/ujuEoK7QK7O8H3oGzEZjNWfp07xciCXCOUgo0HGePg1h+YGUrewWztqRNXBqpBYFBEfcNPtniE9Ax2k4eZhs/0pZ/1C+JSej7STL09/lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBuxdlii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC6DC4CEF1;
	Mon, 15 Sep 2025 16:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757954192;
	bh=sFKlwRvnlnlP6/mO1ynOhYF6GOBs7Psz7KEyq9qFIiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iBuxdliijQWhpI3RVo+U8XJ/DnLZLfEukHRGl5721bxVKLIRHJVBjVfEKt6DfjfDS
	 whr5dFX9GZ6VWpSc7K8qe7RgRSh8AXt/Q9HJ1GOX6YTcO1FC3RNKjKiHZwf8/HVKE2
	 3IS/132qNOkP3R4c+xN7DObUcd757ZWC0tV0bAEPWBtvibWJzv3Vo7rHUchhvjxPpE
	 yR0ebyLV07fhRUVR22SpSRPYQCADdXGxUyGjlbPrZ8H5U/+j5jG67Q+Q6uG22akisP
	 uiJSaBX5O+jYoSOPl+t1jkI+dfk5sXJv05nhJq47C05CIAauKvtVfNqS9SVy8s1ptQ
	 m7BXo/kR5iHyw==
Date: Mon, 15 Sep 2025 19:36:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <me@yadavpratyush.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc
 allocations
Message-ID: <aMhAiR6qnXMA-c8r@kernel.org>
References: <20250908103528.2179934-1-rppt@kernel.org>
 <20250908103528.2179934-2-rppt@kernel.org>
 <mafs0ldmon784.fsf@kernel.org>
 <mafs0ldmnlmq0.fsf@yadavpratyush.com>
 <aMgey9qEC_XUejXm@kernel.org>
 <20250915144335.GL1024672@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915144335.GL1024672@nvidia.com>

On Mon, Sep 15, 2025 at 11:43:35AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 15, 2025 at 05:12:27PM +0300, Mike Rapoport wrote:
> > > I don't suppose I'd insist on it, but something to consider since you
> > > are likely going to do another revision anyway.
> > 
> > I think vmalloc is as basic as folio.
> 
> vmalloc() ultimately calls vm_area_alloc_pages() -> alloc_pages_bulk_node_noprof()
> 
> KHO should have functions that clearly pair with the low level
> allocators struct page related allocators, alloc_pages(order),
> folio_alloc(), etc etc
> 
> ie if you call this allocator X then you call this kho preserve, this
> kho restore, and this free function Y.
> 
> Under the covers it all uses the generic folio based code we already
> have, but we should have appropriate wrappers around that code that
> make clear these patterns.

Right, but that does not mean that vmalloc preserve/restore should use the
public KHO APIs and avoid using internal methods.
 
> Jason

-- 
Sincerely yours,
Mike.


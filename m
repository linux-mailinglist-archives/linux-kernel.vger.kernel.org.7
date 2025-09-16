Return-Path: <linux-kernel+bounces-819034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CC2B59A70
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F150D18834AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9C2321F3A;
	Tue, 16 Sep 2025 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYE8Efn+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E625928C84F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033259; cv=none; b=ZR06t7PN+tOl9wjKsy4mync/pY0jXsCLs9tSS+qlfO7j9rA8vto9V/pXtAVkWMb5KeYOI6sGfONZSMgfAjQPPeHs0fe+5/c5gWMDsekXMnTR8xxGHYK+CMwvVIQ1AuKZOy2mC6eYs71olLaPfT4NApN+nRh99QYvA53CxWHU6bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033259; c=relaxed/simple;
	bh=3MH7gD+Tsr6/+WWbc5XNbhhMDRlAVwAmSiICzgleW9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byKABeQPHxPxb8P6bib867N/m2Jk2rdffeEAwS0bMaCSzJfqvvFGJ4exp+zvCn9RDR74HBCSHyxBNutP8V3cSooNDGXb0oajlSvb5756qO89GDpqwLvuKmvph8MrXOkQ0BeKUBqrjea5a0wepUJHZNGcvRz0TIgLQDdUQY7fsY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYE8Efn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF58C4AF09;
	Tue, 16 Sep 2025 14:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758033258;
	bh=3MH7gD+Tsr6/+WWbc5XNbhhMDRlAVwAmSiICzgleW9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYE8Efn+Rtz49VyeXFT+OA9QWcbqM6ZXeDrJnDya8oYEdZbQzubfb9N/1S8hoNNCX
	 gp9rau+XytOIg1+un9Mguc/q1TX8w4O/yPllotB9qGt5PXIOpqIXJjaVFVSKy5T/Js
	 hRokgc0yIP2bQL9tlVDvbUDm6WUC6w22W6TJv3jNOc6eznzrEo36jFDnLYTKiXnvCx
	 gsRzOcL5ehCcUdEQDnpGsSGqwV9EdD+BaSUTy2xuxwEU8JRJutD7k2bDjreQ6HIXdT
	 utIlA1mGCdnleTYeWeuuFajS3OxCIufVPpSy4JBfMgNdWXy+4bXnz5Gk7otR7W0T7n
	 ym5FukQVNHB5w==
Date: Tue, 16 Sep 2025 17:34:10 +0300
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
Message-ID: <aMl1Yj7_iw1kCU2D@kernel.org>
References: <20250908103528.2179934-1-rppt@kernel.org>
 <20250908103528.2179934-2-rppt@kernel.org>
 <mafs0ldmon784.fsf@kernel.org>
 <mafs0ldmnlmq0.fsf@yadavpratyush.com>
 <aMgey9qEC_XUejXm@kernel.org>
 <20250915144335.GL1024672@nvidia.com>
 <aMhAiR6qnXMA-c8r@kernel.org>
 <20250916130516.GB1086830@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916130516.GB1086830@nvidia.com>

On Tue, Sep 16, 2025 at 10:05:16AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 15, 2025 at 07:36:25PM +0300, Mike Rapoport wrote:
> > > Under the covers it all uses the generic folio based code we already
> > > have, but we should have appropriate wrappers around that code that
> > > make clear these patterns.
> > 
> > Right, but that does not mean that vmalloc preserve/restore should use the
> > public KHO APIs and avoid using internal methods.
> 
> I think it does, the same way vmalloc is layered on top of the buddy
> allocator. Why wouldn't you build things in clean understandable
> layers like this?

Here it's more like __vmalloc_node_range_noprof() and get_vm_area() calling
__get_vm_area()
 
> Jason

-- 
Sincerely yours,
Mike.


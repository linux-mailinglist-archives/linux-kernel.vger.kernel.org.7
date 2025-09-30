Return-Path: <linux-kernel+bounces-837485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7071EBAC699
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11832321353
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D51F54918;
	Tue, 30 Sep 2025 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPFoM2jB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603732F6572
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226879; cv=none; b=ARVMBs8yAUhG7GcA8GtozaJo4sdgMj+A17FETGCuSyDC7QTuHDEEi8KPJHRJlwM6yl9h03cMsMkmAx04rw2T9IppfLxMlgiQZVnd3DO9sHGV/TpPGF79i6cRIdUoKzRwnSa+f9bd/R58zkyxf5EtDXgI5xrZxp7eTZ2fvJLrMQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226879; c=relaxed/simple;
	bh=iaTYo42AMbeWEpSjWoHhR0ggf4sFotfptbmlFUWCPr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKBxClDYMJlUZOUHF0Oa57RP9GQjzgZoGqHKNycMggWI37HvCDZqrfUQikgg6v7wiET8t0kmO63De7F4HsRxGC4QcoBpLipeTneZ5Aw7OqMmNMRzAT8VTJSZ6O5UM0Tg0mVuvcG/OAF/BIVu3d+rCpnq6ZCehCGVv351FWtJ6PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPFoM2jB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3040C4CEF7;
	Tue, 30 Sep 2025 10:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759226878;
	bh=iaTYo42AMbeWEpSjWoHhR0ggf4sFotfptbmlFUWCPr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PPFoM2jBVRv5qpyhc8HiiNBCJxADagb8/rS9CmNMB1PjEYIY9FJqprLktYosCrr4d
	 MJICc96nK4yJ8BFPoBDCLK53IsCOeKrVVGLkkTCdMO0AOyZwvvLCUeDUZgyidmJ3d1
	 l3QaFlvxESd3dsppQ9sMTAkZO3QLqHjhuHlxMDmXRXiqP5gDptFbEy4FITjKGk48Ys
	 mcUU2RrRkAm9w00OJZxz7mV9BDkAf0cWZncSX0Eg0szswZXYfvJxOoy/JsDEghgq2I
	 YMBnUxgJg3GUhhsGPiQFD0oND8EgMRh650+Qsw/WNyBV00Wlq1uFsnC3xgEKnu/pPZ
	 6Z76IJLF4SVDA==
Date: Tue, 30 Sep 2025 12:07:50 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Axel Rasmussen <axelrasmussen@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <aNur9nbdnlykqbU7@kernel.org>
References: <20250926211650.525109-1-peterx@redhat.com>
 <20250926211650.525109-2-peterx@redhat.com>
 <f1da3505-f17f-4829-80c1-696b1d99057d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1da3505-f17f-4829-80c1-696b1d99057d@redhat.com>

On Tue, Sep 30, 2025 at 11:36:53AM +0200, David Hildenbrand wrote:
> On 26.09.25 23:16, Peter Xu wrote:
> > +	/**
> > +	 * uffd_get_folio: Handler to resolve UFFDIO_CONTINUE request.
> 
> Just wondering if we could incorporate the "continue" / "minor" aspect into
> the callback name.
> 
> uffd_minor_get_folio / uffd_continue_get_folio
> 
> Or do you see use of that callback in the context of other uffd features?

If someone picks the gauntlet of refactoring the loop in mcopy_atomic()
we'd need a similar callback for uffd copy. And as I see it it would be
different enough to warrant emphasizing minor/continue in the name here.

I also think we can drop uffd_ prefix for the callback, as it's called as
uffd_ops->get_folio() or whatever it's be called.
 
> -- 
> Cheers
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.


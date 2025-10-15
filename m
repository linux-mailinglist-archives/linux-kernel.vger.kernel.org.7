Return-Path: <linux-kernel+bounces-853733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF94BDC738
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1C63BB436
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D722F25EA;
	Wed, 15 Oct 2025 04:22:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12270272E4E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760502166; cv=none; b=FD8VCZ/gwcSFnq7xbHhDpkHArCNgdpkm/TVqD/1o8WuwgNh5LMmwu/7yHXhG23+gCk/U3w2p/MuJk2xm9U+QG5mFzDSeyA6JrOVzPZtaUn1P9dO+ytWsi1z5okp7zOSwkmSVhRM4Ol/pLX5TJguKlIxLVjFKITJGExn7NQIbq5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760502166; c=relaxed/simple;
	bh=kFaB2P5lqysSo/XPjCHi01Xz+eA9FHDVIRryySgsmLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdHRGtLNepo6ZzRpmVukJLztxLiy956jobNqokjuDoHIObFY8evDuSUZqzGr+nkXKXQHFV/VIJ1D6Q6AXs4aRRscHb7AIwr7QdcYoZUJ35uHrNgTFB3iHbyuxirVqIP4qqhxldsKDrGEHUOZ+SxKArP20syKWco7mYU2QA5d8K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E7C21A32;
	Tue, 14 Oct 2025 21:22:36 -0700 (PDT)
Received: from localhost (a079125.arm.com [10.164.21.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2BB13F6A8;
	Tue, 14 Oct 2025 21:22:43 -0700 (PDT)
Date: Wed, 15 Oct 2025 09:52:40 +0530
From: Linu Cherian <linu.cherian@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	Dev Jain <dev.jain@arm.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: Re: [PATCH v2 1/2] arm64/mm: Allow __create_pgd_mapping() to
 propagate pgtable_alloc() errors
Message-ID: <aO8hkMtIQ0YjqTRt@a079125.arm.com>
References: <20251013080220.2027757-1-linu.cherian@arm.com>
 <20251013080220.2027757-2-linu.cherian@arm.com>
 <87f23627-d0cc-4d9a-a4f8-df1f61716b04@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87f23627-d0cc-4d9a-a4f8-df1f61716b04@arm.com>

Hi Kevin,

On Tue, Oct 14, 2025 at 11:29:05AM +0200, Kevin Brodsky wrote:
> On 13/10/2025 10:02, Linu Cherian wrote:
> > [...]
> >
> > @@ -1877,23 +1926,30 @@ int arch_add_memory(int nid, u64 start, u64 size,
> >  	if (force_pte_mapping())
> >  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> >  
> > -	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> > -			     size, params->pgprot, pgd_pgtable_alloc_init_mm,
> > -			     flags);
> > +	ret = __create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> > +				   size, params->pgprot, pgd_pgtable_alloc_init_mm,
> > +				   flags);
> > +
> 
> Nit: usually no empty line between a call and a trivial if (ret).

Ack.

> 
> > +	if (ret)
> > +		goto out;
> >  
> >  	memblock_clear_nomap(start, size);
> >  
> >  	ret = __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
> >  			   params);
> >  	if (ret)
> > -		__remove_pgd_mapping(swapper_pg_dir,
> > -				     __phys_to_virt(start), size);
> > +		goto out;
> >  	else {
> >  		/* Address of hotplugged memory can be smaller */
> >  		max_pfn = max(max_pfn, PFN_UP(start + size));
> >  		max_low_pfn = max_pfn;
> >  	}
> >  
> > +	return 0;
> > +
> > +out:
> 
> Nit: since this is an error path, it'd be clearer to call the label
> "err" rather than "out".

Ack.

Thanks,
Linu Cherian.


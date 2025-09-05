Return-Path: <linux-kernel+bounces-803029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C91E4B459A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 244427A63D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C2635CED4;
	Fri,  5 Sep 2025 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NV8s46If"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFBE35CECC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080403; cv=none; b=ZzbWzTOTiRjBlnqD2N6IdGp/Ye8ymgGWKKsLPxgX3Qg/O+BpqAbTN4nLVT1iLOL32EoXVh3SsScUqZtgSr+Y3JNbafH7OVwRvPq/7N3VrkcGQzCQDGYC455h5d/HPmCNXIdHfKNFIPUBx49IiR1dzeMcWJ5HN7Ir+FxxpaoO4uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080403; c=relaxed/simple;
	bh=dS0ijienYB+5i4QOSlW83sgW3RHUmENhVtIbkeS4VSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+/K2ELTM9jjmm/pgbvbPU9OZ3rpjFRPdGq79QV4lRuoZ+IvqmwIzE3eD+twzzOn1crWgsHRVz33Kgd/I+R0pJyDYnPLpSPIyjCw/lDP/8Oj4KecknGzr4Jsl5hex7bI6VrVoy3mPgmajA/CMRFoaQUgE/kzA3j0KEsfKU9N68s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NV8s46If; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1pCvM6whJF4g8toP+FeR/YSNKgWlTWUXFE1HrnRQrF4=; b=NV8s46IfJJW0zYiKPHL+fAQCow
	yvwfySzz1yr9xPH/iL4sMdoovrll+IXi/iVJYi3M4SinOH3f2iGszvZwGpMfmTjTSyRvp7IEMfygz
	qgZ/a/ouxqyPxPjtSX7OkjRcqO0UGR4AmWB1NptVEe/fJWzoPsHiVYdtteaODdBYKqv0CwNVtIjLU
	DNfR7vYiv7nox2mhCG0nUhI1CZEBm5VcVS1vVf2fCmVeEZGqlmRKuyIC5cPA/X85rjBchI0neM00I
	yfi30TgDGHcC0c82zLkCWY/mtZ8OuabXail6KDS6v1JOiumUl0atYm51Yv7QdAQZf1BSdyJlD2kvk
	+W4SVECw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuWsC-0000000HD8k-2G9m;
	Fri, 05 Sep 2025 13:53:04 +0000
Date: Fri, 5 Sep 2025 14:53:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nico Pache <npache@redhat.com>, Zi Yan <ziy@nvidia.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mcgrof@kernel.org,
	gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>,
	Kiryl Shutsemau <kas@kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] huge_memory: return -EINVAL in folio split functions
 when THP is disabled
Message-ID: <aLrrQDCBzaMwwmA-@casper.infradead.org>
References: <20250905131352.88069-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905131352.88069-1-kernel@pankajraghav.com>

On Fri, Sep 05, 2025 at 03:13:52PM +0200, Pankaj Raghav (Samsung) wrote:
> Changes since v2:
>   - use page_folio(page) directly in VM_WARN_ON_ONCE_FOLIO

... why not use VM_WARN_ON_ONCE_PAGE?


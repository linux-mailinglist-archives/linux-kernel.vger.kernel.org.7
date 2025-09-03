Return-Path: <linux-kernel+bounces-799295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5400BB429AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7A1580E06
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DE02D8DDA;
	Wed,  3 Sep 2025 19:20:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE282D8DB7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927228; cv=none; b=tYCac82WqswZiJNAZP/wKHW/7n72sEYmp6rYppLmHVUe4Z6pmlZ4t9U84q6JcOcdg1SjA259UULEABhFEAP4F/N02+2wvc6KJnALcFZfQXmSQxp0HV8ksWhvcyT/un3VfPGX3kqtnO0bvOwLLCPM/X+3xCvATMh30wjWK10Y1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927228; c=relaxed/simple;
	bh=ZnTBiWejQUnwnFHAY4ziLSSOifOwPoJgqCzynNUl0cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSuaZ1ylNUTmq2OlUZprDOUqiMVqRR/pPtjA1hW8MCq+F3z8hd2uvA1CyPH1UFe+oHchO5I5YW8NYAZFNdeRh1NmELzgQU1S7f8b/+heiPl4QXJ3geWWuWp781ZLC8KuAM89KWyqv9UAavyUtvJSpDW41FN+sM4ANaRUasTv+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA02AC4CEE7;
	Wed,  3 Sep 2025 19:20:25 +0000 (UTC)
Date: Wed, 3 Sep 2025 20:20:23 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Ard Biesheuvel <ardb@kernel.org>, Dev Jain <dev.jain@arm.com>,
	scott@os.amperecomputing.com, cl@gentwo.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v7 4/6] arm64: mm: Optimize split_kernel_leaf_mapping()
Message-ID: <aLiU9xnZl-7LBqkX@arm.com>
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <20250829115250.2395585-5-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829115250.2395585-5-ryan.roberts@arm.com>

On Fri, Aug 29, 2025 at 12:52:45PM +0100, Ryan Roberts wrote:
> The common case for split_kernel_leaf_mapping() is for a single page.
> Let's optimize this by only calling split_kernel_leaf_mapping_locked()
> once.
> 
> Since the start and end address are PAGE_SIZE apart, they must be
> contained within the same contpte block. Further, if start is at the
> beginning of the block or end is at the end of the block, then the other
> address must be in the _middle_ of the block. So if we split on this
> middle-of-the-contpte-block address, it is guaranteed that the
> containing contpte block is split to ptes and both start and end are
> therefore mapped by pte.
> 
> This avoids the second call to split_kernel_leaf_mapping_locked()
> meaning we only have to walk the pgtable once.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

And I agree with Yang, you can just fold this into the previous patch.


Return-Path: <linux-kernel+bounces-731913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D131BB05C23
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F306256481D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3CE2E3B10;
	Tue, 15 Jul 2025 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPFgiCbm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1AD2E338F;
	Tue, 15 Jul 2025 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585886; cv=none; b=fhTMI/B9n1vPvry7um6ASC6u4BKvlgK/8PWl++/qCCGbCNo38fnn087UdwW7pvzZam56BKBn3uPpVshIDgOBvxGOLKdMEtzL4MV0nojlO+ik9jle/Bp3aCFH2WiIdx33zPYi6lTLQ8I35e+FnTbPLB2LtYF3MQuyEp6GAdsATDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585886; c=relaxed/simple;
	bh=LACQRLoYbwjDJR7B8kKiL5kegf3U3j4BP+gzpY0KEsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcV3Pzr5Nm5tZ2EGeIP4oBp3T8QxG71UWPwTd0bNg3Bv5svfd12ewW+gMAglNIrtUEYRtNd7fR3TAeL9v08piDkoGo1akfRThUPlxCIWcVuxyB7iJoIwFSUp/MZ8f7LJZ/3rZJPWEID4Mou+3GZTyaNPDcW85sIXf+DlLOYBJWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPFgiCbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FF9C4CEE3;
	Tue, 15 Jul 2025 13:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752585886;
	bh=LACQRLoYbwjDJR7B8kKiL5kegf3U3j4BP+gzpY0KEsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPFgiCbmTjPFJKl5cs0OZMbXGYUAhCKvFG7enaVLf+cqb6iwHU56DujED+FM/4W/z
	 x1RFbZALiY/TbT/W30fFBxkD8Jx9QNZX2NnEp4ykPrhBMKuw2rRwvdmcmNGluj1hOg
	 6tgI9ehvM68n26LyiCkDWSHUv6WuUZnpewUtqClNHOxa3hJ8NDtd/CdbNCsmqAn0uD
	 uxUKdhsRJ0TyQKFVjUOEqMvirCzGFjGwTpkys/3DVBlMb7BMr8eOEPqJTWXx98VQWI
	 N5zqWCYnndaF/OJVGgy7A0rFygzVh8S7ElMNVCp22I186H186bp8d1LBrKVm3ZjrfS
	 x8/h4CKze7ZVw==
Date: Tue, 15 Jul 2025 14:24:38 +0100
From: Will Deacon <will@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, iommu@lists.linux.dev,
	virtualization@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 8/8] mm/hmm: migrate to physical address-based DMA
 mapping API
Message-ID: <aHZWlu7Td9ijFhhh@willie-the-truck>
References: <cover.1750854543.git.leon@kernel.org>
 <8a85f4450905fcb6b17d146cc86c11410d522de4.1750854543.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a85f4450905fcb6b17d146cc86c11410d522de4.1750854543.git.leon@kernel.org>

Hi Leon,

On Wed, Jun 25, 2025 at 04:19:05PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Convert HMM DMA operations from the legacy page-based API to the new
> physical address-based dma_map_phys() and dma_unmap_phys() functions.
> This demonstrates the preferred approach for new code that should use
> physical addresses directly rather than page+offset parameters.
> 
> The change replaces dma_map_page() and dma_unmap_page() calls with
> dma_map_phys() and dma_unmap_phys() respectively, using the physical
> address that was already available in the code. This eliminates the
> redundant page-to-physical address conversion and aligns with the
> DMA subsystem's move toward physical address-centric interfaces.
> 
> This serves as an example of how new code should be written to leverage
> the more efficient physical address API, which provides cleaner interfaces
> for drivers that already have access to physical addresses.

I'm struggling a little to see how this is cleaner or more efficient
than the old code.

From what I can tell, dma_map_page_attrs() takes a 'struct page *' and
converts it to a physical address using page_to_phys() whilst your new
dma_map_phys() interface takes a physical address and converts it to
a 'struct page *' using phys_to_page(). In both cases, hmm_dma_map_pfn()
still needs the page for other reasons. If anything, existing users of
dma_map_page_attrs() now end up with a redundant page-to-phys-to-page
conversion which hopefully the compiler folds away.

I'm assuming there's future work which builds on top of the new API
and removes the reliance on 'struct page' entirely, is that right? If
so, it would've been nicer to be clearer about that as, on its own, I'm
not really sure this patch series achieves an awful lot and the
efficiency argument looks quite weak to me.

Cheers,

Will


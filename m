Return-Path: <linux-kernel+bounces-812947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90ADB53EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 00:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4302566B49
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC202EE5FA;
	Thu, 11 Sep 2025 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TYzap3cs"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA92EDD44;
	Thu, 11 Sep 2025 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757629547; cv=none; b=u6EiosywlU1KHTdNOGlMKqyH6Q+5mLwYiyIj0ja7V/jbfRazxKvRvNxFbB4cVubkJTg1C/V0KEYVL7q99ZehRKM2QVLior39qcWA99PRzVXwjUPaRliDnEhZhgYyRnTntSbNU5mwAqFoqhYlXa6+jhpvuypcwGQXbVOwyX5+d70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757629547; c=relaxed/simple;
	bh=VhTUKknuQKZIQNlc9FeAjofdR8C1UbnCNE3GysWSRWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=kj6PVMy+saLBv0GxbND4Kr6Qw2KkX98ULYrXDHWBjpJ5nHv8jCcVFpnVDatWMmILxTcGfsr8J+mbAYl1hBRQLtvqMpB44H2R26X9x1sqxD/tRpNeLm6qgFWbc4jxie1kP+6zKxKIRaqx9IDffvWlqMeGrxN5cRr9Z2MDY0PQV+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TYzap3cs; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250911222543euoutp0181a9340dd64dc67c6339e0a47181ebf4~kWsHnYW5E2610126101euoutp01U;
	Thu, 11 Sep 2025 22:25:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250911222543euoutp0181a9340dd64dc67c6339e0a47181ebf4~kWsHnYW5E2610126101euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757629543;
	bh=pKZpcAmq/bht8ZKkJqtZPTgOAGANcQvA5kKLVuXifcI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=TYzap3cszLDOEgEsqU6EupJ7Zu8ir86kgd0ybK+4ACWZaOiATyvZFbUDShQ8MbR85
	 SejzQ/ANTvod+crbxkB+bIskmGYNCRGJfAnTK7Wx3EUgGfsfp9YrG/QNqAamMubhrs
	 7HS78hSROwDaJIS7uPVpylvDm+iDdZwL3r/+voe4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250911222542eucas1p1fd99b15e46362a0af4417b04fa0c831b~kWsHKwmS41727217272eucas1p1e;
	Thu, 11 Sep 2025 22:25:42 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250911222538eusmtip17e16b44d9939848958cad6696cc3414c~kWsDGpMzk2282122821eusmtip1T;
	Thu, 11 Sep 2025 22:25:38 +0000 (GMT)
Message-ID: <0db9bce5-40df-4cf5-85ab-f032c67d5c71@samsung.com>
Date: Fri, 12 Sep 2025 00:25:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v6 00/16] dma-mapping: migrate to physical address-based
 API
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Alexander Potapenko
	<glider@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Danilo
	Krummrich <dakr@kernel.org>, David Hildenbrand <david@redhat.com>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>, Jens Axboe
	<axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet
	<corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Michael
	Ellerman <mpe@ellerman.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, Miguel
	Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	rust-for-linux@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>, Stefano
	Stabellini <sstabellini@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <cover.1757423202.git.leonro@nvidia.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250911222542eucas1p1fd99b15e46362a0af4417b04fa0c831b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250909132821eucas1p1051ce9e0270ddbf520e105c913fa8db6
X-EPHeader: CA
X-CMS-RootMailID: 20250909132821eucas1p1051ce9e0270ddbf520e105c913fa8db6
References: <CGME20250909132821eucas1p1051ce9e0270ddbf520e105c913fa8db6@eucas1p1.samsung.com>
	<cover.1757423202.git.leonro@nvidia.com>

On 09.09.2025 15:27, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Changelog:
> v6:
>   * Based on "dma-debug: don't enforce dma mapping check on noncoherent
>     allocations" patch.
>   * Removed some unused variables from kmsan conversion.
>   * Fixed missed ! in dma check.
> v5: https://lore.kernel.org/all/cover.1756822782.git.leon@kernel.org
>   * Added Jason's and Keith's Reviewed-by tags
>   * Fixed DMA_ATTR_MMIO check in dma_direct_map_phys
>   * Jason's cleanup suggestions
> v4: https://lore.kernel.org/all/cover.1755624249.git.leon@kernel.org/
>   * Fixed kbuild error with mismatch in kmsan function declaration due to
>     rebase error.
> v3: https://lore.kernel.org/all/cover.1755193625.git.leon@kernel.org
>   * Fixed typo in "cacheable" word
>   * Simplified kmsan patch a lot to be simple argument refactoring
> v2: https://lore.kernel.org/all/cover.1755153054.git.leon@kernel.org
>   * Used commit messages and cover letter from Jason
>   * Moved setting IOMMU_MMIO flag to dma_info_to_prot function
>   * Micro-optimized the code
>   * Rebased code on v6.17-rc1
> v1: https://lore.kernel.org/all/cover.1754292567.git.leon@kernel.org
>   * Added new DMA_ATTR_MMIO attribute to indicate
>     PCI_P2PDMA_MAP_THRU_HOST_BRIDGE path.
>   * Rewrote dma_map_* functions to use thus new attribute
> v0: https://lore.kernel.org/all/cover.1750854543.git.leon@kernel.org/
> ------------------------------------------------------------------------
>
> This series refactors the DMA mapping to use physical addresses
> as the primary interface instead of page+offset parameters. This
> change aligns the DMA API with the underlying hardware reality where
> DMA operations work with physical addresses, not page structures.
>
> The series maintains export symbol backward compatibility by keeping
> the old page-based API as wrapper functions around the new physical
> address-based implementations.
>
> This series refactors the DMA mapping API to provide a phys_addr_t
> based, and struct-page free, external API that can handle all the
> mapping cases we want in modern systems:
>
>   - struct page based cacheable DRAM
>   - struct page MEMORY_DEVICE_PCI_P2PDMA PCI peer to peer non-cacheable
>     MMIO
>   - struct page-less PCI peer to peer non-cacheable MMIO
>   - struct page-less "resource" MMIO
>
> Overall this gets much closer to Matthew's long term wish for
> struct-pageless IO to cacheable DRAM. The remaining primary work would
> be in the mm side to allow kmap_local_pfn()/phys_to_virt() to work on
> phys_addr_t without a struct page.
>
> The general design is to remove struct page usage entirely from the
> DMA API inner layers. For flows that need to have a KVA for the
> physical address they can use kmap_local_pfn() or phys_to_virt(). This
> isolates the struct page requirements to MM code only. Long term all
> removals of struct page usage are supporting Matthew's memdesc
> project which seeks to substantially transform how struct page works.
>
> Instead make the DMA API internals work on phys_addr_t. Internally
> there are still dedicated 'page' and 'resource' flows, except they are
> now distinguished by a new DMA_ATTR_MMIO instead of by callchain. Both
> flows use the same phys_addr_t.
>
> When DMA_ATTR_MMIO is specified things work similar to the existing
> 'resource' flow. kmap_local_pfn(), phys_to_virt(), phys_to_page(),
> pfn_valid(), etc are never called on the phys_addr_t. This requires
> rejecting any configuration that would need swiotlb. CPU cache
> flushing is not required, and avoided, as ATTR_MMIO also indicates the
> address have no cacheable mappings. This effectively removes any
> DMA API side requirement to have struct page when DMA_ATTR_MMIO is
> used.
>
> In the !DMA_ATTR_MMIO mode things work similarly to the 'page' flow,
> except on the common path of no cache flush, no swiotlb it never
> touches a struct page. When cache flushing or swiotlb copying
> kmap_local_pfn()/phys_to_virt() are used to get a KVA for CPU
> usage. This was already the case on the unmap side, now the map side
> is symmetric.
>
> Callers are adjusted to set DMA_ATTR_MMIO. Existing 'resource' users
> must set it. The existing struct page based MEMORY_DEVICE_PCI_P2PDMA
> path must also set it. This corrects some existing bugs where iommu
> mappings for P2P MMIO were improperly marked IOMMU_CACHE.
>
> Since ATTR_MMIO is made to work with all the existing DMA map entry
> points, particularly dma_iova_link(), this finally allows a way to use
> the new DMA API to map PCI P2P MMIO without creating struct page. The
> VFIO DMABUF series demonstrates how this works. This is intended to
> replace the incorrect driver use of dma_map_resource() on PCI BAR
> addresses.
>
> This series does the core code and modern flows. A followup series
> will give the same treatment to the legacy dma_ops implementation.

Applied patches 1-13 into dma-mapping-for-next branch. Let's check if it 
works fine in linux-next.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland



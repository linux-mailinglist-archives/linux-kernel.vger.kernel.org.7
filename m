Return-Path: <linux-kernel+bounces-827938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F00B937C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1115717E7BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06EB2F7469;
	Mon, 22 Sep 2025 22:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TfGHw5db"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430C81DE2A7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758580312; cv=none; b=f5HLiOZy+LFxttQ8q9dS68k++Ukw1MZYSBpIY+21y4hNHG0DTXzh/LlSZdGLSq+DBjQ428GpB/kO1opnJlAzp7y1/l7dUcgiCwSGWxvUuWJnImlQE3G2/mHPTvGp+clboVmz8p4QvY98lrj8ybBsf7dedqpwUidAa5XQ1KNWqaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758580312; c=relaxed/simple;
	bh=3OrZhQbz19uSD8khNAY9LRibIgp1Gw96WCmpoxoMcxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/ysLu0tSVHr6mnq3ekEymcME+ghaqGigEBz9WD7os7EtNplZRnNufkAeFTnn2PtogxZPgq/o4lC/qi+z6itq73o7WLa3oII7uY365xcCq/AL/iduRZfMx1J/DlNsbBua5sMqy8xtn/LPYOjmT9KVp+tKdpidP82CI6XTbYLsqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TfGHw5db; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8f893019-bd87-4f54-8238-acd8fdeed051@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758580307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJFynAT8QIYKybUlzYSFKT2F+7TPewoBKOb/7zjaiUI=;
	b=TfGHw5dboLTINUm5ceBhu4/3su63STyUL1SNRAFy1OGLL2uZzmT+wDdaGsi8IDB4z72CcP
	rhpcpJsiEOe4opDDyF2nipICIBmz1f6zwQseYKZRj7Cld0JaBKpos+c9R6cZU95uWcAdZj
	Mdnq7nOGn0LWpOgchTGPGZIqZnGZAPg=
Date: Mon, 22 Sep 2025 15:31:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 3/4] kho: add support for preserving vmalloc
 allocations
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
 Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>,
 kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250921054458.4043761-1-rppt@kernel.org>
 <20250921054458.4043761-4-rppt@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20250921054458.4043761-4-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/20/25 10:44 PM, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> A vmalloc allocation is preserved using binary structure similar to
> global KHO memory tracker. It's a linked list of pages where each page
> is an array of physical address of pages in vmalloc area.
> 
> kho_preserve_vmalloc() hands out the physical address of the head page
> to the caller. This address is used as the argument to
> kho_vmalloc_restore() to restore the mapping in the vmalloc address
> space and populate it with the preserved pages.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> ---
>   include/linux/kexec_handover.h |  28 ++++
>   kernel/kexec_handover.c        | 281 +++++++++++++++++++++++++++++++++
>   2 files changed, 309 insertions(+)
> 
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index cc5c49b0612b..49e36d4ae5dc 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -39,12 +39,23 @@ struct page;
>   
>   struct kho_serialization;
>   
> +struct kho_vmalloc_chunk;
> +struct kho_vmalloc {
> +        DECLARE_KHOSER_PTR(first, struct kho_vmalloc_chunk *);
> +        unsigned int total_pages;
> +        unsigned short flags;
> +        unsigned short order;
> +};
> +
>   #ifdef CONFIG_KEXEC_HANDOVER
>   bool kho_is_enabled(void);
>   
>   int kho_preserve_folio(struct folio *folio);
>   int kho_preserve_pages(struct page *page, unsigned int nr_pages);
> +int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
>   struct folio *kho_restore_folio(phys_addr_t phys);
> +struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages);
> +void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
>   int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
>   int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
>   
> @@ -71,11 +82,28 @@ static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
>   	return -EOPNOTSUPP;
>   }
>   
> +static inline int kho_preserve_vmalloc(void *ptr,
> +				       struct kho_vmalloc *preservation)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   static inline struct folio *kho_restore_folio(phys_addr_t phys)
>   {
>   	return NULL;
>   }
>   
> +static inline struct page *kho_restore_pages(phys_addr_t phys,
> +					     unsigned int nr_pages)
> +{
> +	return NULL;
> +}
> +
> +static inline void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
> +{
> +	return NULL;
> +}
> +
>   static inline int kho_add_subtree(struct kho_serialization *ser,
>   				  const char *name, void *fdt)
>   {
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index fd80be3b12fd..e6380d8dce57 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -18,6 +18,7 @@
>   #include <linux/memblock.h>
>   #include <linux/notifier.h>
>   #include <linux/page-isolation.h>
> +#include <linux/vmalloc.h>
>   
>   #include <asm/early_ioremap.h>
>   
> @@ -274,6 +275,37 @@ struct folio *kho_restore_folio(phys_addr_t phys)
>   }
>   EXPORT_SYMBOL_GPL(kho_restore_folio);
>   
> +/**
> + * kho_restore_pages - restore list of contiguous order 0 pages.
> + * @phys: physical address of the first page.
> + * @nr_pages: number of pages.
> + *
> + * Restore a contiguous list of order 0 pages that was preserved with
> + * kho_preserve_pages().
> + *
> + * Return: 0 on success, error code on failure
> + */
> +struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages)
> +{
> +	const unsigned long start_pfn = PHYS_PFN(phys);
> +	const unsigned long end_pfn = start_pfn + nr_pages;
> +	unsigned long pfn = start_pfn;
> +
> +	while (pfn < end_pfn) {
> +		const unsigned int order =
> +			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
> +		struct page *page = kho_restore_page(PFN_PHYS(pfn));
> +
> +		if (!page)
> +			return NULL;
> +		split_page(page, order);
> +		pfn += 1 << order;
> +	}
> +
> +	return pfn_to_page(start_pfn);
> +}
> +EXPORT_SYMBOL_GPL(kho_restore_pages);
> +
>   /* Serialize and deserialize struct kho_mem_phys across kexec
>    *
>    * Record all the bitmaps in a linked list of pages for the next kernel to
> @@ -763,6 +795,255 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
>   }
>   EXPORT_SYMBOL_GPL(kho_preserve_pages);
>   
> +struct kho_vmalloc_hdr {
> +	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
> +};
> +
> +#define KHO_VMALLOC_SIZE				\
> +	((PAGE_SIZE - sizeof(struct kho_vmalloc_hdr)) / \
> +	 sizeof(phys_addr_t))
> +
> +struct kho_vmalloc_chunk {
> +	struct kho_vmalloc_hdr hdr;
> +	phys_addr_t phys[KHO_VMALLOC_SIZE];
> +};
> +
> +static_assert(sizeof(struct kho_vmalloc_chunk) == PAGE_SIZE);
> +
> +/* vmalloc flags KHO supports */
> +#define KHO_VMALLOC_SUPPORTED_FLAGS	(VM_ALLOC | VM_ALLOW_HUGE_VMAP)
> +
> +/* KHO internal flags for vmalloc preservations */
> +#define KHO_VMALLOC_ALLOC	0x0001
> +#define KHO_VMALLOC_HUGE_VMAP	0x0002
> +
> +static unsigned short vmalloc_flags_to_kho(unsigned int vm_flags)
> +{
> +	unsigned short kho_flags = 0;
> +
> +	if (vm_flags & VM_ALLOC)
> +		kho_flags |= KHO_VMALLOC_ALLOC;
> +	if (vm_flags & VM_ALLOW_HUGE_VMAP)
> +		kho_flags |= KHO_VMALLOC_HUGE_VMAP;
> +
> +	return kho_flags;
> +}
> +
> +static unsigned int kho_flags_to_vmalloc(unsigned short kho_flags)
> +{
> +	unsigned int vm_flags = 0;
> +
> +	if (kho_flags & KHO_VMALLOC_ALLOC)
> +		vm_flags |= VM_ALLOC;
> +	if (kho_flags & KHO_VMALLOC_HUGE_VMAP)
> +		vm_flags |= VM_ALLOW_HUGE_VMAP;
> +
> +	return vm_flags;
> +}
> +
> +static struct kho_vmalloc_chunk *new_vmalloc_chunk(struct kho_vmalloc_chunk *cur)
> +{
> +	struct kho_vmalloc_chunk *chunk;
> +	int err;
> +
> +	chunk = (struct kho_vmalloc_chunk *)get_zeroed_page(GFP_KERNEL);
> +	if (!chunk)
> +		return NULL;
> +
> +	err = kho_preserve_pages(virt_to_page(chunk), 1);
> +	if (err)
> +		goto err_free;
> +	if (cur)
> +		KHOSER_STORE_PTR(cur->hdr.next, chunk);
> +	return chunk;
> +
> +err_free:
> +	free_page((unsigned long)chunk);
> +	return NULL;
> +}
> +
> +static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk)
> +{
> +	struct kho_mem_track *track = &kho_out.ser.track;
> +	unsigned long pfn = PHYS_PFN(virt_to_phys(chunk));
> +
> +	__kho_unpreserve(track, pfn, pfn + 1);
> +
> +	for (int i = 0; chunk->phys[i]; i++) {
> +		pfn = PHYS_PFN(chunk->phys[i]);
> +		__kho_unpreserve(track, pfn, pfn + 1);
> +	}
> +}
> +
> +static void kho_vmalloc_free_chunks(struct kho_vmalloc *kho_vmalloc)
> +{
> +	struct kho_vmalloc_chunk *chunk = KHOSER_LOAD_PTR(kho_vmalloc->first);
> +
> +	while (chunk) {
> +		struct kho_vmalloc_chunk *tmp = chunk;
> +
> +		kho_vmalloc_unpreserve_chunk(chunk);
> +
> +		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
> +		kfree(tmp);
> +	}
> +}
> +
> +/**
> + * kho_preserve_vmalloc - preserve memory allocated with vmalloc() across kexec
> + * @ptr: pointer to the area in vmalloc address space
> + * @preservation: placeholder for preservation metadata
> + *
> + * Instructs KHO to preserve the area in vmalloc address space at @ptr. The
> + * physical pages mapped at @ptr will be preserved and on successful return
> + * @preservation will hold the physical address of a structure that describes
> + * the preservation.
> + *
> + * NOTE: The memory allocated with vmalloc_node() variants cannot be reliably
> + * restored on the same node
> + *
> + * Return: 0 on success, error code on failure
> + */
> +int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
> +{
> +	struct kho_vmalloc_chunk *chunk;
> +	struct vm_struct *vm = find_vm_area(ptr);
> +	unsigned int order, flags, nr_contig_pages;
> +	unsigned int idx = 0;
> +	int err;

This is a trivial issue. I’m not sure whether RCT (Reverse Christmas 
Trees) is used in the Linux MM mailing list.

If it is, the variable declarations above do not comply with the RCT rules.

Yanjun.Zhu

> +
> +	if (!vm)
> +		return -EINVAL;
> +
> +	if (vm->flags & ~KHO_VMALLOC_SUPPORTED_FLAGS)
> +		return -EOPNOTSUPP;
> +
> +	flags = vmalloc_flags_to_kho(vm->flags);
> +	order = get_vm_area_page_order(vm);
> +
> +	chunk = new_vmalloc_chunk(NULL);
> +	if (!chunk)
> +		return -ENOMEM;
> +	KHOSER_STORE_PTR(preservation->first, chunk);
> +
> +	nr_contig_pages = (1 << order);
> +	for (int i = 0; i < vm->nr_pages; i += nr_contig_pages) {
> +		phys_addr_t phys = page_to_phys(vm->pages[i]);
> +
> +		err = kho_preserve_pages(vm->pages[i], nr_contig_pages);
> +		if (err)
> +			goto err_free;
> +
> +		chunk->phys[idx++] = phys;
> +		if (idx == ARRAY_SIZE(chunk->phys)) {
> +			chunk = new_vmalloc_chunk(chunk);
> +			if (!chunk)
> +				goto err_free;
> +			idx = 0;
> +		}
> +	}
> +
> +	preservation->total_pages = vm->nr_pages;
> +	preservation->flags = flags;
> +	preservation->order = order;
> +
> +	return 0;
> +
> +err_free:
> +	kho_vmalloc_free_chunks(preservation);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
> +
> +/**
> + * kho_restore_vmalloc - recreates and populates an area in vmalloc address
> + * space from the preserved memory.
> + * @preservation: preservation metadata.
> + *
> + * Recreates an area in vmalloc address space and populates it with memory that
> + * was preserved using kho_preserve_vmalloc().
> + *
> + * Return: pointer to the area in the vmalloc address space, NULL on failure.
> + */
> +void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
> +{
> +	struct kho_vmalloc_chunk *chunk = KHOSER_LOAD_PTR(preservation->first);
> +	unsigned int align, order, shift, vm_flags;
> +	unsigned long total_pages, contig_pages;
> +	unsigned long addr, size;
> +	struct vm_struct *area;
> +	struct page **pages;
> +	unsigned int idx = 0;
> +	int err;
> +
> +	vm_flags = kho_flags_to_vmalloc(preservation->flags);
> +	if (vm_flags & ~KHO_VMALLOC_SUPPORTED_FLAGS)
> +		return NULL;
> +
> +	total_pages = preservation->total_pages;
> +	pages = kvmalloc_array(total_pages, sizeof(*pages), GFP_KERNEL);
> +	if (!pages)
> +		return NULL;
> +	order = preservation->order;
> +	contig_pages = (1 << order);
> +	shift = PAGE_SHIFT + order;
> +	align = 1 << shift;
> +
> +	while (chunk) {
> +		struct page *page;
> +
> +		for (int i = 0; chunk->phys[i]; i++) {
> +			phys_addr_t phys = chunk->phys[i];
> +
> +			if (idx + contig_pages > total_pages)
> +				goto err_free_pages_array;
> +
> +			page = kho_restore_pages(phys, contig_pages);
> +			if (!page)
> +				goto err_free_pages_array;
> +
> +			for (int j = 0; j < contig_pages; j++)
> +				pages[idx++] = page;
> +
> +			phys += contig_pages * PAGE_SIZE;
> +		}
> +
> +		page = kho_restore_pages(virt_to_phys(chunk), 1);
> +		if (!page)
> +			goto err_free_pages_array;
> +		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
> +		__free_page(page);
> +	}
> +
> +	if (idx != total_pages)
> +		goto err_free_pages_array;
> +
> +	area = __get_vm_area_node(total_pages * PAGE_SIZE, align, shift,
> +				  vm_flags, VMALLOC_START, VMALLOC_END,
> +				  NUMA_NO_NODE, GFP_KERNEL,
> +				  __builtin_return_address(0));
> +	if (!area)
> +		goto err_free_pages_array;
> +
> +	addr = (unsigned long)area->addr;
> +	size = get_vm_area_size(area);
> +	err = vmap_pages_range(addr, addr + size, PAGE_KERNEL, pages, shift);
> +	if (err)
> +		goto err_free_vm_area;
> +
> +	area->nr_pages = total_pages;
> +	area->pages = pages;
> +
> +	return area->addr;
> +
> +err_free_vm_area:
> +	free_vm_area(area);
> +err_free_pages_array:
> +	kvfree(pages);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
> +
>   /* Handling for debug/kho/out */
>   
>   static struct dentry *debugfs_root;



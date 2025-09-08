Return-Path: <linux-kernel+bounces-806520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D438B49805
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E824E18A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093E03164CB;
	Mon,  8 Sep 2025 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNEXm+fB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163763A8F7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355183; cv=none; b=nuKHVYX8mAHk2rVI3pyWRzHB5aK1XtacFS7h+cDB52nTjn8gg6jZvmlplIush0zW+T0D2Ifx65BQnzdNax8HICAMFOjNB6SiXWfJgFq1tlxsT+QLSmRTPTsWYCbt5xyJX+6j3yTh1f3oaJzwDTPzwKbT/nPOzyw0aDQijtOrTv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355183; c=relaxed/simple;
	bh=Hy+hhrBDBPrCziBe+GY3JOr6m0xt0ZTDGce2ocsMKfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cA+x7wY/hAO1SNZx0WV6Eho57LjoTKAOQN3DCBz7tSxNoszpJLLF3I3mK9+ldp7lPyJbCVIPYrnv/Jq0kqmHmFPc+3CAr8+re5BSNKuyP7msZRPdJei3Skd+KJXQT2bCFBPAJtLfBYsFTu9RWsVDGD8jXDOkTmcxE44nuIIoa5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNEXm+fB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2586CC4CEF1;
	Mon,  8 Sep 2025 18:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757355183;
	bh=Hy+hhrBDBPrCziBe+GY3JOr6m0xt0ZTDGce2ocsMKfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sNEXm+fBi2+ESVu1qlLq6abGE5Ht9Wro8TnOUmP85VFgxg/rr7FEKbZzzhLtor88b
	 NNBitv24/lCYUn/N04i5ep2sOClM7n4K5Sy/xffoeIwdhtjmTSWupQY7wfFFiUL3Ev
	 UZPXqtGruBMTDfJTaYudxWnqfbOM3WGIL7JCw0H2mPUnNvEbkGmWqOwTwiJ7YlQR/o
	 tcEwRZ9EDpMdq0MMp5k3gwT1oJwtOF6I902OvNxRRGNCqh/Oiaagf/sV1NSteIMT0v
	 MjuNOEto/fQmeoKmDCuOS4lkXYaplZ3cFYSnezVx9OqpnetD55zlrLiK0268kZci03
	 SnFSKPUiT8osw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,  Changyuan Lyu
 <changyuanl@google.com>,  Chris Li <chrisl@kernel.org>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc allocations
In-Reply-To: <20250908103528.2179934-2-rppt@kernel.org>
References: <20250908103528.2179934-1-rppt@kernel.org>
	<20250908103528.2179934-2-rppt@kernel.org>
Date: Mon, 08 Sep 2025 20:12:59 +0200
Message-ID: <mafs0ldmon784.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 08 2025, Mike Rapoport wrote:

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
> ---
>  include/linux/kexec_handover.h |  12 ++
>  kernel/kexec_handover.c        | 200 +++++++++++++++++++++++++++++++++
>  2 files changed, 212 insertions(+)
>
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index 348844cffb13..b7bf3bf11019 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -42,8 +42,10 @@ struct kho_serialization;
>  bool kho_is_enabled(void);
>  
>  int kho_preserve_folio(struct folio *folio);
> +int kho_preserve_vmalloc(void *ptr, phys_addr_t *preservation);
>  int kho_preserve_phys(phys_addr_t phys, size_t size);
>  struct folio *kho_restore_folio(phys_addr_t phys);
> +void *kho_restore_vmalloc(phys_addr_t preservation);
>  int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
>  int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
>  
> @@ -70,11 +72,21 @@ static inline int kho_preserve_phys(phys_addr_t phys, size_t size)
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int kho_preserve_vmalloc(void *ptr, phys_addr_t *preservation)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline struct folio *kho_restore_folio(phys_addr_t phys)
>  {
>  	return NULL;
>  }
>  
> +static inline void *kho_restore_vmalloc(phys_addr_t preservation)
> +{
> +	return NULL;
> +}
> +
>  static inline int kho_add_subtree(struct kho_serialization *ser,
>  				  const char *name, void *fdt)
>  {
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index 8079fc4b9189..1177cc5ffa1a 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -18,6 +18,7 @@
>  #include <linux/memblock.h>
>  #include <linux/notifier.h>
>  #include <linux/page-isolation.h>
> +#include <linux/vmalloc.h>
>  
>  #include <asm/early_ioremap.h>
>  
> @@ -742,6 +743,205 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
>  }
>  EXPORT_SYMBOL_GPL(kho_preserve_phys);
>  
> +struct kho_vmalloc_chunk;
> +
> +struct kho_vmalloc_hdr {
> +	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
> +	unsigned int total_pages;	/* only valid in the first chunk */
> +	unsigned int flags;		/* only valid in the first chunk */
> +	unsigned short order;		/* only valid in the first chunk */
> +	unsigned short num_elms;

I think it the serialization format would be cleaner if these were
defined in a separate structure that holds the metadata instead of being
defined in each page and then ignored in most of them.

If the caller can save 8 bytes (phys addr of first page), it might as
well save 16 instead. Something like the below perhaps?

struct kho_vmalloc {
	DECLARE_KHOSER_PTR(first, struct kho_vmalloc_chunk *);
	unsigned int total_pages;
	unsigned short flags;
	unsigned short order;
};

And then kho_vmalloc_hdr becomes simply:

struct kho_vmalloc_hdr {
	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
};

You don't even need num_elms since you have the list be zero-terminated.

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
> +#define KHO_VMALLOC_FLAGS_MASK	(VM_ALLOC | VM_ALLOW_HUGE_VMAP)

I don't think it is a good idea to re-use VM flags. This can make adding
more flags later down the line ugly. I think it would be better to
define KHO_VMALLOC_FL* instead.

> +
> +static struct kho_vmalloc_chunk *new_vmalloc_chunk(struct kho_vmalloc_chunk *cur)
> +{
> +	struct kho_vmalloc_chunk *chunk;
> +	int err;
> +
> +	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!chunk)
> +		return NULL;
> +
> +	err = kho_preserve_phys(virt_to_phys(chunk), PAGE_SIZE);
> +	if (err)
> +		goto err_free;
> +	if (cur)
> +		KHOSER_STORE_PTR(cur->hdr.next, chunk);
> +	return chunk;
> +
> +err_free:
> +	kfree(chunk);
> +	return NULL;
> +}
> +
> +static void kho_vmalloc_free_chunks(struct kho_vmalloc_chunk *first_chunk)
> +{
> +	struct kho_mem_track *track = &kho_out.ser.track;
> +	struct kho_vmalloc_chunk *chunk = first_chunk;
> +
> +	while (chunk) {
> +		unsigned long pfn = PHYS_PFN(virt_to_phys(chunk));
> +		struct kho_vmalloc_chunk *tmp = chunk;
> +
> +		__kho_unpreserve(track, pfn, pfn + 1);

This doesn't unpreserve the pages contained in the chunk, which
kho_preserve_vmalloc() preserved.

> +
> +		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
> +		kfree(tmp);
> +	}
> +}
> +
> +/**
> + * kho_preserve_vmalloc - preserve memory allocated with vmalloc() across kexec
> + * @ptr: pointer to the area in vmalloc address space
> + * @preservation: returned physical address of preservation metadata
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
> +int kho_preserve_vmalloc(void *ptr, phys_addr_t *preservation)
> +{
> +	struct kho_mem_track *track = &kho_out.ser.track;
> +	struct kho_vmalloc_chunk *chunk, *first_chunk;
> +	struct vm_struct *vm = find_vm_area(ptr);
> +	unsigned int order, flags;
> +	int err;
> +
> +	if (!vm)
> +		return -EINVAL;
> +
> +	if (vm->flags & ~KHO_VMALLOC_FLAGS_MASK)
> +		return -EOPNOTSUPP;
> +
> +	flags = vm->flags & KHO_VMALLOC_FLAGS_MASK;
> +	order = get_vm_area_page_order(vm);
> +
> +	chunk = new_vmalloc_chunk(NULL);
> +	if (!chunk)
> +		return -ENOMEM;
> +	first_chunk = chunk;
> +	first_chunk->hdr.total_pages = vm->nr_pages;
> +	first_chunk->hdr.flags = flags;
> +	first_chunk->hdr.order = order;
> +
> +	for (int i = 0; i < vm->nr_pages; i += (1 << order)) {
> +		phys_addr_t phys = page_to_phys(vm->pages[i]);
> +
> +		err = __kho_preserve_order(track, PHYS_PFN(phys), order);
> +		if (err)
> +			goto err_free;
> +
> +		chunk->phys[chunk->hdr.num_elms] = phys;
> +		chunk->hdr.num_elms++;
> +		if (chunk->hdr.num_elms == ARRAY_SIZE(chunk->phys)) {
> +			chunk = new_vmalloc_chunk(chunk);
> +			if (!chunk)
> +				goto err_free;
> +		}
> +	}
> +
> +	*preservation = virt_to_phys(first_chunk);
> +	return 0;
> +
> +err_free:
> +	kho_vmalloc_free_chunks(first_chunk);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
> +
> +/**
> + * kho_restore_vmalloc - recreates and populates an area in vmalloc address
> + * space from the preserved memory.
> + * @preservation: physical address of the preservation metadata.
> + *
> + * Recreates an area in vmalloc address space and populates it with memory that
> + * was preserved using kho_preserve_vmalloc().
> + *
> + * Return: pointer to the area in the vmalloc address space, NULL on failure.
> + */
> +void *kho_restore_vmalloc(phys_addr_t preservation)
> +{
> +	struct kho_vmalloc_chunk *chunk = phys_to_virt(preservation);
> +	unsigned int align, order, shift, flags;
> +	unsigned int idx = 0, nr;
> +	unsigned long addr, size;
> +	struct vm_struct *area;
> +	struct page **pages;
> +	int err;
> +
> +	flags = chunk->hdr.flags;
> +	if (flags & ~KHO_VMALLOC_FLAGS_MASK)
> +		return NULL;
> +
> +	nr = chunk->hdr.total_pages;
> +	pages = kvmalloc_array(nr, sizeof(*pages), GFP_KERNEL);
> +	if (!pages)
> +		return NULL;
> +	order = chunk->hdr.order;
> +	shift = PAGE_SHIFT + order;
> +	align = 1 << shift;
> +
> +	while (chunk) {
> +		struct page *page;
> +
> +		for (int i = 0; i < chunk->hdr.num_elms; i++) {
> +			phys_addr_t phys = chunk->phys[i];
> +
> +			for (int j = 0; j < (1 << order); j++) {
> +				page = phys_to_page(phys);
> +				kho_restore_page(page, 0);
> +				pages[idx++] = page;

This can buffer-overflow if the previous kernel was buggy and added too
many pages. Perhaps keep check for this?

> +				phys += PAGE_SIZE;
> +			}
> +		}
> +
> +		page = virt_to_page(chunk);
> +		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
> +		kho_restore_page(page, 0);
> +		__free_page(page);
> +	}
> +
> +	area = __get_vm_area_node(nr * PAGE_SIZE, align, shift, flags,
> +				  VMALLOC_START, VMALLOC_END, NUMA_NO_NODE,
> +				  GFP_KERNEL, __builtin_return_address(0));
> +	if (!area)
> +		goto err_free_pages_array;
> +
> +	addr = (unsigned long)area->addr;
> +	size = get_vm_area_size(area);
> +	err = vmap_pages_range(addr, addr + size, PAGE_KERNEL, pages, shift);
> +	if (err)
> +		goto err_free_vm_area;
> +
> +	return area->addr;

You should free the pages array before returning here.

> +
> +err_free_vm_area:
> +	free_vm_area(area);
> +err_free_pages_array:
> +	kvfree(pages);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
> +
>  /* Handling for debug/kho/out */
>  
>  static struct dentry *debugfs_root;

-- 
Regards,
Pratyush Yadav


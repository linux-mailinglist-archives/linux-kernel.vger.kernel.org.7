Return-Path: <linux-kernel+bounces-818787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F42FB59673
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244CB324502
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E88230FF3F;
	Tue, 16 Sep 2025 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW0ANfTm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5AC2D7DCD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026633; cv=none; b=kOAnqKw7Q9TtfxWCZ58qHvHh1KIeTFC9kcFtmDAlxAI3fCkP2LpYAv6uHFQIs1B0idFKJCn4dH00j71THelEg5W+RFzGobFAvr5EBXzuM8j/R6fg+76KBziTCiEESC0ckFyldm642oVsy/ElAa9l2yHSAjh/vaae6TTbwqehpw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026633; c=relaxed/simple;
	bh=SYVYoZGy/SIg0iMBfH8qcSuCZt73k2SHPgy9MLZisf4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PJdqSoSuYMAYn2GqFlVI609Bhm6GHQ20FfvSCBm+tOP8y5SJtGUDnIim820BQ61G/xk7LFWRLpg9ykbFJKitfuhKcMOcJdl2mX8s7OZcdfQ/0kZS+qC81oa0btWtplt007F/YflcEIgwNo7wQfHmOpsCezkSaUN/XEUgbkEZBpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW0ANfTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC0DC4CEFA;
	Tue, 16 Sep 2025 12:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758026633;
	bh=SYVYoZGy/SIg0iMBfH8qcSuCZt73k2SHPgy9MLZisf4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UW0ANfTmlociasU/WK/Ojn9FP1HnWWAjR/CfLsC/kvxHRUMNCO43Ke32DMFB21hMz
	 eTHzectn83NFGBF3QHZTNqQeLHSaDmbKXSoFBZchwP8xBd7jlCCTlEwg+gXapRRdFf
	 xEUfvEJo8ztsSitWodD3jtF5+SASGsRwYV2Kym5J4mXcAGW+mVXZ/vP7nLv7Il4u5t
	 d67gpOV+hARxOIW7N3mAcFvMLZaPdCpAtAzTg3DuhxPCpEHsAIzaw4FWSkYpLojRzd
	 S/K8E4rBYK7TtOppAtNFJD1GBpwLxv0zivZ/Hs68cHaYR/VupobUOZn8qp+c4m22vV
	 zY8iHvPSAeBdA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Graf <graf@amazon.com>,  Baoquan
 He <bhe@redhat.com>,  Changyuan Lyu <changyuanl@google.com>,  Chris Li
 <chrisl@kernel.org>,  Jason Gunthorpe <jgg@nvidia.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc allocations
In-Reply-To: <aMgdwE83dKdT1K7L@kernel.org>
References: <20250908103528.2179934-1-rppt@kernel.org>
	<20250908103528.2179934-2-rppt@kernel.org> <mafs0ldmon784.fsf@kernel.org>
	<aMgdwE83dKdT1K7L@kernel.org>
Date: Tue, 16 Sep 2025 14:43:50 +0200
Message-ID: <mafs0frcmin3t.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Mike,

On Mon, Sep 15 2025, Mike Rapoport wrote:

> On Mon, Sep 08, 2025 at 08:12:59PM +0200, Pratyush Yadav wrote:
>> On Mon, Sep 08 2025, Mike Rapoport wrote:
>> 
>> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >
>> > A vmalloc allocation is preserved using binary structure similar to
>> > global KHO memory tracker. It's a linked list of pages where each page
>> > is an array of physical address of pages in vmalloc area.
>> >
>> > kho_preserve_vmalloc() hands out the physical address of the head page
>> > to the caller. This address is used as the argument to
>> > kho_vmalloc_restore() to restore the mapping in the vmalloc address
>> > space and populate it with the preserved pages.
>> >
>> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
[...]
>> > +	while (chunk) {
>> > +		struct page *page;
>> > +
>> > +		for (int i = 0; i < chunk->hdr.num_elms; i++) {
>> > +			phys_addr_t phys = chunk->phys[i];
>> > +
>> > +			for (int j = 0; j < (1 << order); j++) {
>> > +				page = phys_to_page(phys);
>> > +				kho_restore_page(page, 0);
>> > +				pages[idx++] = page;
>> 
>> This can buffer-overflow if the previous kernel was buggy and added too
>> many pages. Perhaps keep check for this?
>
> You mean it added more than total_pages?
> But the preserve part adds exactly vm->nr_pages, so once we get it right
> what bugs do you expect here? 

The main reason is defensive programming. My mental model is to treat
the data from the previous kernel as external input, and so we should
always validate it. The kernel that did the preserve and the kernel that
does the restore are very different, and between them either may have a
bug or some incompatibility/disagreement on the data format. Catching
these inconsistencies and failing gracefully is a lot better than
silently corrupting memory and having hard to catch bugs. No one plans
to add bugs, but they always show up somehow :-)

And we do a lot of that KHO already. See the FDT parsing in memblock
preservation for example.

	p_start = fdt_getprop(fdt, offset, "start", &len_start);
	p_size = fdt_getprop(fdt, offset, "size", &len_size);
	if (!p_start || len_start != sizeof(*p_start) || !p_size ||
	    len_size != sizeof(*p_size)) {
		return false;
	}
	[...]

It checks that FDT contains sane data or errors out otherwise. Similar
checks exist in other places too.

>  
>> > +				phys += PAGE_SIZE;
>> > +			}
>> > +		}
>> > +
>> > +		page = virt_to_page(chunk);
>> > +		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
>> > +		kho_restore_page(page, 0);
>> > +		__free_page(page);
>> > +	}
>> > +
>> > +	area = __get_vm_area_node(nr * PAGE_SIZE, align, shift, flags,
>> > +				  VMALLOC_START, VMALLOC_END, NUMA_NO_NODE,
>> > +				  GFP_KERNEL, __builtin_return_address(0));
>> > +	if (!area)
>> > +		goto err_free_pages_array;
>> > +
>> > +	addr = (unsigned long)area->addr;
>> > +	size = get_vm_area_size(area);
>> > +	err = vmap_pages_range(addr, addr + size, PAGE_KERNEL, pages, shift);
>> > +	if (err)
>> > +		goto err_free_vm_area;
>> > +
>> > +	return area->addr;
>> 
>> You should free the pages array before returning here.
>
> Why? They get into vm->pages.

Do they? I don't see any path in vmap_pages_range() taking a reference
to the pages array. They use the array, but never take a reference to
it.

The core of vmap_pages_range() is in __vmap_pages_range_noflush(). That
function has two paths:

	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
			page_shift == PAGE_SHIFT)
		return vmap_small_pages_range_noflush(addr, end, prot, pages);

	for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
		int err;

		err = vmap_range_noflush(addr, addr + (1UL << page_shift),
					page_to_phys(pages[i]), prot,
					page_shift);
		if (err)
			return err;

		addr += 1UL << page_shift;
	}

	return 0;

The latter path (the for loop) _uses_ pages but never takes a reference
to it. The former, vmap_small_pages_range_noflush(), goes through a the
sequence of functions vmap_pages_{p4d,pud,pmd}_range(), eventually
landing in vmap_pages_pte_range(). That function's only use of the pages
array is the below:

	do {
		struct page *page = pages[*nr];
		[...]
	} while (pte++, addr += PAGE_SIZE, addr != end);

So I don't see anything setting area->pages here.

Note that vmap() does set area->pages if given the VM_MAP_PUT_PAGES
flag. It also calls vmap_pages_range() first and then sets area->pages
and area->nr_pages. So if you want to mimic that behaviour, I think you
have to explicitly make these assignments in kho_restore_vmalloc().

Similarly for __vmalloc_area_node(), it does area->pages =
__vmalloc_node_noprof() and then does vmap_pages_range() (also sets
area->nr_pages).

Side note: would it be a better idea to teach vmap() to take higher
order pages instead, to make this path simpler? I don't know the subtle
differences between these mapping primitives to know if that makes
sense. I seems to do pretty much what this function is doing with the
exception of only dealing with 0-order pages.

-- 
Regards,
Pratyush Yadav


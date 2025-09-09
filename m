Return-Path: <linux-kernel+bounces-808418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B2AB4FF7F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF751C237E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B9234A336;
	Tue,  9 Sep 2025 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadavpratyush.com header.i=@yadavpratyush.com header.b="gYZCIQqQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lOQZQoR1"
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFEF2C21FF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428414; cv=none; b=lP+2bMIIaq18n1jBLWneQU9dwnQaIOV7u4jDSJIs4bdo4Y1kSZVaKkIoysMrb//dXi+pxkyxq5t2h2cyX27BJBZA8pt5wqQ+rTLL/+0JHKOG2+teUuohw2p9VhS9rIQaly4PJiStPNK4O1PB61gdAkDMkSQnYzp4ci3+kLvuYVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428414; c=relaxed/simple;
	bh=Fo+DgNSZuGgBlIoT5GTKMN2JNajcwybRSg7ysVwHbsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JftPwaI00Jo4JxHzbxsCdwjXcB0cRDnf+3zhBuBV8jAdjtSEAr2H1HqwZPy+zx83i+K1ntdLcR6gl2PslGzqWU0ZiS7we6+9BgZDgqQFyarCqXGlLD9ZMWlFzpJYcZZz8yFFF/SwW7yNswYoq4t6mhZJ7V7frlyrfqMo3cnTSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadavpratyush.com; spf=pass smtp.mailfrom=yadavpratyush.com; dkim=pass (2048-bit key) header.d=yadavpratyush.com header.i=@yadavpratyush.com header.b=gYZCIQqQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lOQZQoR1; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadavpratyush.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadavpratyush.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 500031D000CF;
	Tue,  9 Sep 2025 10:33:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 09 Sep 2025 10:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	yadavpratyush.com; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1757428410;
	 x=1757514810; bh=1NzgFxHrA/xC71AIYDCeO+Pqbshn14KE8z9hf0hJuEQ=; b=
	gYZCIQqQ9d4PrgMN5zGFIkHsS0A9s4f4SeNfE0r2QHgAX8jctq+66NVRK29ga0WB
	dRHGr6RPflO/o4Hc8CZd/eXFxbIfWL+o0qAJQuHeG/VgDLOxGFEMWr0Ycxliskwg
	LMFGgcZM9doCALncM1l4KKk7RBNAwatvN+simu9q6YmkXPWoiIUvbbyZzCY5qfjs
	noWHGRQetv1OcRmfHW9sdbE/oFmlfr7j6uO48Gj9tochGa885ODp2/F7edqPjqyq
	aMXo1ydh8oZv4DuGeCnS5N6XOtJtn3lsC4ZmFdeq6/ounguR2CHmJtZjDn2nBgcB
	7ZGzTR0GRt+HV1SRHRSrqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757428410; x=1757514810; bh=1NzgFxHrA/xC71AIYDCeO+Pqbshn14KE8z9
	hf0hJuEQ=; b=lOQZQoR160WuWPE1/Rj8TIXIn++Hd9nc+gISVgCp80x7yccsmV4
	fnSjOK0rGYdkIj4oxPJrwTgtt1pQ4B1iyWjEyLrlzrqqE59qOzZGFu0OtSGDFehD
	IwI9KDEnxmiCZ8lD7tsbNPk+CKeqow+92xyUDRf68PFThvBzBG6PHIrylUu6dKtR
	zWPuu0F5onKhlHT4lGktWLZztsx8GcalxoUAQnawSvpAnhS53xHpRLKZ8Z1qgKUK
	6ZcQzw/gbpm0iMQ5CVJLb+V8x1W9OKAzQ8/kXLgndl7m2A+NRpJmLlLbH4KEi5Sh
	FRQyI0QWGFX+HQgyCVreFW4uzEpwWGqWHqA==
X-ME-Sender: <xms:uTrAaMgumbFSGsL8TJ1JH8Y--kEyS6q1Kzru91ejTrzrW2Qrgpv30A>
    <xme:uTrAaKgxKxUs8okBTN3GVbWnlAVg-b_ayfYAxiN4wNJuq8MQMpiWpZAiRBbr9OcmS
    SaYqcIzIUHRnbHkKa0>
X-ME-Received: <xmr:uTrAaDLm33OLcQUZU3wz-6a9Npr4z6HW0DZhCqc5KR3Wr9lmAkDv5Oc2gqwm4kmfMtTwgmqKIlgaH-rEqrNG-kQB5bhGiI_lNsCfYIFODrSzq79MatOc5imsjKBdaRbocamGXz7Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefrrhgrthihuhhs
    hhcujggruggrvhcuoehmvgeshigruggrvhhprhgrthihuhhshhdrtghomheqnecuggftrf
    grthhtvghrnhepleejgfdufeffuefhiefghfdugeegieejudelgedthfeuudffheeugfel
    hfevvdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgvseihrggurghvphhrrghthihushhhrdgtohhmpdhnsggprhgtphhtthhopeduvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghk
    rdhorhhgpdhrtghpthhtohepkhgvgigvtgeslhhishhtshdrihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopehprghshhgrrdhtrghtrghshhhinhesshholhgvvghnrdgtohhm
    pdhrtghpthhtohepjhhgghesnhhvihguihgrrdgtohhmpdhrtghpthhtoheptghhrhhish
    hlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhgrnhhghihurghnlhesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepsghhvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
    epghhrrghfsegrmhgriihonhdrtghomh
X-ME-Proxy: <xmx:uTrAaBn91tp0FOPs0iKIKwxMvsj6Gw8oSN10T7O196LShzArtoCYhg>
    <xmx:uTrAaDO4ZKh2tYnOwmSw6M1WgjiEslTAydQZrEJLRBIsk9ddTUE8ig>
    <xmx:uTrAaD5hVLY-F1Zf78ee_mQ8oDL0RInMDnhOhGx4L-qBdFBbM-p0eg>
    <xmx:uTrAaPa64D-GhZmPSGUvZa5iCOKgsk5a55fy84sik6OI_Zd130Wu0w>
    <xmx:ujrAaEpC6b8PXPU6ZeBga19Jq2p4wwfEXWGa9tS88NzXP6KdnBAjnqOv>
Feedback-ID: i93f149c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 10:33:27 -0400 (EDT)
From: Pratyush Yadav <me@yadavpratyush.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Graf <graf@amazon.com>,  Baoquan
 He <bhe@redhat.com>,  Changyuan Lyu <changyuanl@google.com>,  Chris Li
 <chrisl@kernel.org>,  Jason Gunthorpe <jgg@nvidia.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc allocations
In-Reply-To: <mafs0ldmon784.fsf@kernel.org>
References: <20250908103528.2179934-1-rppt@kernel.org>
	<20250908103528.2179934-2-rppt@kernel.org> <mafs0ldmon784.fsf@kernel.org>
Date: Tue, 09 Sep 2025 16:33:27 +0200
Message-ID: <mafs0ldmnlmq0.fsf@yadavpratyush.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Mike,

Couple more thoughts.

On Mon, Sep 08 2025, Pratyush Yadav wrote:

> On Mon, Sep 08 2025, Mike Rapoport wrote:
>
>> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>
>> A vmalloc allocation is preserved using binary structure similar to
>> global KHO memory tracker. It's a linked list of pages where each page
>> is an array of physical address of pages in vmalloc area.
>>
>> kho_preserve_vmalloc() hands out the physical address of the head page
>> to the caller. This address is used as the argument to
>> kho_vmalloc_restore() to restore the mapping in the vmalloc address
>> space and populate it with the preserved pages.
>>
>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
[...]
>> +/**
>> + * kho_restore_vmalloc - recreates and populates an area in vmalloc address
>> + * space from the preserved memory.
>> + * @preservation: physical address of the preservation metadata.
>> + *
>> + * Recreates an area in vmalloc address space and populates it with memory that
>> + * was preserved using kho_preserve_vmalloc().
>> + *
>> + * Return: pointer to the area in the vmalloc address space, NULL on failure.
>> + */
>> +void *kho_restore_vmalloc(phys_addr_t preservation)
>> +{
>> +	struct kho_vmalloc_chunk *chunk = phys_to_virt(preservation);
>> +	unsigned int align, order, shift, flags;
>> +	unsigned int idx = 0, nr;
>> +	unsigned long addr, size;
>> +	struct vm_struct *area;
>> +	struct page **pages;
>> +	int err;
>> +
>> +	flags = chunk->hdr.flags;
>> +	if (flags & ~KHO_VMALLOC_FLAGS_MASK)
>> +		return NULL;
>> +
>> +	nr = chunk->hdr.total_pages;
>> +	pages = kvmalloc_array(nr, sizeof(*pages), GFP_KERNEL);
>> +	if (!pages)
>> +		return NULL;
>> +	order = chunk->hdr.order;
>> +	shift = PAGE_SHIFT + order;
>> +	align = 1 << shift;
>> +
>> +	while (chunk) {
>> +		struct page *page;
>> +
>> +		for (int i = 0; i < chunk->hdr.num_elms; i++) {
>> +			phys_addr_t phys = chunk->phys[i];
>> +
>> +			for (int j = 0; j < (1 << order); j++) {
>> +				page = phys_to_page(phys);
>> +				kho_restore_page(page, 0);
>> +				pages[idx++] = page;
>
> This can buffer-overflow if the previous kernel was buggy and added too
> many pages. Perhaps keep check for this?

Thinking about this a bit more, I think this should check that we found
_exactly_ chunk->hdr.total_pages pages, and should error out otherwise.
If too few are found, pages array will contain bogus data, if too many,
buffer overflow.

Also, I am not a fan of using kho_restore_page() directly. I think the
vmalloc preservation is a layer above core KHO, and it should use the
public KHO APIs. It really doesn't need to poke into internal APIs. If
any of the public APIs are insufficient, we should add new ones.

I don't suppose I'd insist on it, but something to consider since you
are likely going to do another revision anyway.

>
>> +				phys += PAGE_SIZE;
>> +			}
>> +		}
>> +
>> +		page = virt_to_page(chunk);
>> +		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
>> +		kho_restore_page(page, 0);
>> +		__free_page(page);
>> +	}
>> +
>> +	area = __get_vm_area_node(nr * PAGE_SIZE, align, shift, flags,
>> +				  VMALLOC_START, VMALLOC_END, NUMA_NO_NODE,
>> +				  GFP_KERNEL, __builtin_return_address(0));
>> +	if (!area)
>> +		goto err_free_pages_array;
>> +
>> +	addr = (unsigned long)area->addr;
>> +	size = get_vm_area_size(area);
>> +	err = vmap_pages_range(addr, addr + size, PAGE_KERNEL, pages, shift);
>> +	if (err)
>> +		goto err_free_vm_area;
>> +
>> +	return area->addr;
>
> You should free the pages array before returning here.
>
>> +
>> +err_free_vm_area:
>> +	free_vm_area(area);
>> +err_free_pages_array:
>> +	kvfree(pages);
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
>> +
>>  /* Handling for debug/kho/out */
>>  
>>  static struct dentry *debugfs_root;

-- 
Regards,
Pratyush Yadav


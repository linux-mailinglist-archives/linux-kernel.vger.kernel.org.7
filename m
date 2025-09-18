Return-Path: <linux-kernel+bounces-751055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A11B164C2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D000188B064
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A852DCF6B;
	Wed, 30 Jul 2025 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tQBF5gQj"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796F22E36F1
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893171; cv=none; b=bbbpAnMHGQr7pda7mH74NNO7yJnZGvPFhey3acFucfnpnW5nHXDKGynClQh6oKUKBJ2my3y6jSbNSA0ZfVPEFg6GodfJzjNHI4oKri7KT9LB9BLOQSKJiM6w6X+HhSHMsGS4eI5SGe6IvuewCkQOGaDOpLqkpuncgoyx9g4XDUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893171; c=relaxed/simple;
	bh=IBPNoWo/MAtm+CezpvetZ1BR38F+43l2Wl9gWUUr+Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=E04HjUXcIYJ0Y21qhIuGjHdfRSTKnYT6MLDIWEP4LxbsR2Q1RTymy+kSnVz0setRPQfigas/bxdyUCmn9mCdrLN2KhSq0kESL0IVwsoUntnHADRyfpY0QeYSjCEcU8MK60uDyP3RHd6S4pRGT49uWETnYXv/P0mu9bVOJkGfm8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tQBF5gQj; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250730163247euoutp029baec712e492147ae017dd49336b5d84~XFIsow_bx0235502355euoutp02i
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:32:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250730163247euoutp029baec712e492147ae017dd49336b5d84~XFIsow_bx0235502355euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753893167;
	bh=BSL5Fd5ey+NSvWwk5RIT5oUBgeHAV3OrGjQZ6pf7CNI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tQBF5gQjRFWWD3NkMzd2sWMQdocEpPuublYXo+DODrhkpC+sAkqpV7G/5+SLj9y3k
	 FAXICFoay1/ibpDiaHyufgBQba2SMsBA7uyao3fLdxKNV0z8FjK9Dw3fJfuRxBPoak
	 rpKYzTJHpu47CanwUZWJZBKrP3JwtACld7b3bvho=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250730163246eucas1p2c966d8d5061fc0214cf993906aeab2f5~XFIrva-kQ2815928159eucas1p2i;
	Wed, 30 Jul 2025 16:32:46 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250730163244eusmtip2f48699419babf589223e18bf9ee0d79d~XFIp1n5Qn1925219252eusmtip2o;
	Wed, 30 Jul 2025 16:32:44 +0000 (GMT)
Message-ID: <ff84b386-4bfa-423b-9364-040598a1ece0@samsung.com>
Date: Wed, 30 Jul 2025 18:32:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] dma-mapping: migrate to physical address-based API
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Leon Romanovsky <leon@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
	Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, Alexander Potapenko <glider@google.com>, Marco Elver
	<elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux.dev, virtualization@lists.linux.dev,
	kasan-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <f912c446-1ae9-4390-9c11-00dce7bf0fd3@arm.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250730163246eucas1p2c966d8d5061fc0214cf993906aeab2f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf
X-EPHeader: CA
X-CMS-RootMailID: 20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf
References: <CGME20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf@eucas1p2.samsung.com>
	<cover.1750854543.git.leon@kernel.org>
	<35df6f2a-0010-41fe-b490-f52693fe4778@samsung.com>
	<20250627170213.GL17401@unreal> <20250630133839.GA26981@lst.de>
	<69b177dc-c149-40d3-bbde-3f6bad0efd0e@samsung.com>
	<f912c446-1ae9-4390-9c11-00dce7bf0fd3@arm.com>

On 30.07.2025 13:11, Robin Murphy wrote:
> On 2025-07-08 11:27 am, Marek Szyprowski wrote:
>> On 30.06.2025 15:38, Christoph Hellwig wrote:
>>> On Fri, Jun 27, 2025 at 08:02:13PM +0300, Leon Romanovsky wrote:
>>>>> Thanks for this rework! I assume that the next step is to add 
>>>>> map_phys
>>>>> callback also to the dma_map_ops and teach various dma-mapping 
>>>>> providers
>>>>> to use it to avoid more phys-to-page-to-phys conversions.
>>>> Probably Christoph will say yes, however I personally don't see any
>>>> benefit in this. Maybe I wrong here, but all existing .map_page()
>>>> implementation platforms don't support p2p anyway. They won't benefit
>>>> from this such conversion.
>>> I think that conversion should eventually happen, and rather sooner 
>>> than
>>> later.
>>
>> Agreed.
>>
>> Applied patches 1-7 to my dma-mapping-next branch. Let me know if one
>> needs a stable branch with it.
>
> As the maintainer of iommu-dma, please drop the iommu-dma patch 
> because it is broken. It does not in any way remove the struct page 
> dependency from iommu-dma, it merely hides it so things can crash more 
> easily in circumstances that clearly nobody's bothered to test.
>
>> Leon, it would be great if You could also prepare an incremental patch
>> adding map_phys callback to the dma_maps_ops, so the individual
>> arch-specific dma-mapping providers can be then converted (or simplified
>> in many cases) too.
>
> Marek, I'm surprised that even you aren't seeing why that would at 
> best be pointless churn. The fundamental design of dma_map_page() 
> operating on struct page is that it sits in between alloc_pages() at 
> the caller and kmap_atomic() deep down in the DMA API implementation 
> (which also subsumes any dependencies on having a kernel virtual 
> address at the implementation end). The natural working unit for 
> whatever replaces dma_map_page() will be whatever the replacement for 
> alloc_pages() returns, and the replacement for kmap_atomic() operates 
> on. Until that exists (and I simply cannot believe it would be an 
> unadorned physical address) there cannot be any *meaningful* progress 
> made towards removing the struct page dependency from the DMA API. If 
> there is also a goal to kill off highmem before then, then logically 
> we should just wait for that to land, then revert back to 
> dma_map_single() being the first-class interface, and dma_map_page() 
> can turn into a trivial page_to_virt() wrapper for the long tail of 
> caller conversions.
>
> Simply obfuscating the struct page dependency today by dressing it up 
> as a phys_addr_t with implicit baggage is not not in any way helpful. 
> It only makes the code harder to understand and more bug-prone. 
> Despite the disingenuous claims, it is quite blatantly the opposite of 
> "efficient" for callers to do extra work to throw away useful 
> information with page_to_phys(), and the implementation then have to 
> re-derive that information with pfn_valid()/phys_to_page().
>
> And by "bug-prone" I also include greater distractions like this 
> misguided idea that the same API could somehow work for non-memory 
> addresses too, so then everyone can move on bikeshedding VFIO while 
> overlooking the fundamental flaws in the whole premise. I mean, 
> besides all the issues I've already pointed out in that regard, not 
> least the glaring fact that it's literally just a worse version of *an 
> API we already have*, as DMA API maintainer do you *really* approve of 
> a design that depends on callers abusing DMA_ATTR_SKIP_CPU_SYNC, yet 
> will still readily blow up if they did then call a dma_sync op?
>
Robin, Your concerns are right. I missed the fact that making everything 
depend on phys_addr_t would make DMA-mapping API prone for various 
abuses. I need to think a bit more on this and try to understand more 
the PCI P2P case, what means that I will probably miss this merge 
window. I'm sorry for the lack of being active in the discussion, but I 
just got back from my holidays and I'm trying to catch up.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland



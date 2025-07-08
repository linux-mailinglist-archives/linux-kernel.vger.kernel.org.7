Return-Path: <linux-kernel+bounces-721949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0FCAFCFE1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37FC53B7140
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7492E4267;
	Tue,  8 Jul 2025 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PAX9aPjm"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42A12E1C74
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990259; cv=none; b=urfiCQhs9ug3EHuB1+e2eTc7J2uaF9vl+BTaDcSF5qo5hc6W1F1LTeg0eKzcCSz5QNEtle6hO5cZOYx+4m9GH1XtIrw3dYY1UVtp4o4mjjt/ZLIz7BqqRPF7hIA9ls/5xuW3Nx2DhnLBYRGhxlfziLkl7DTECeJKCAtCUymxQBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990259; c=relaxed/simple;
	bh=CkzfE94IorgBBRqnMAAmMmq24EJdqyfxe6lmBjXxP6U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type:References; b=WArnoqqiATX6rfs/1pmBdLw90bS1Ft1OR/ImjBksq3FhEUzz88N9O/nZlaiwrztve5oCTZpdR8QpDfbgKqNq/wNTpnchNulhcpvLLqoyZGqcEtwuNGkAoxS6DxztvZYkPh52dj3iO10jiOvaf+NUvd+x7QOQfpAadLi58XBHJmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PAX9aPjm; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250708155734euoutp02bbf9b89e623487a5f5bf25279c99b84f~QUdqy8zkP1580815808euoutp028
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:57:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250708155734euoutp02bbf9b89e623487a5f5bf25279c99b84f~QUdqy8zkP1580815808euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751990254;
	bh=uyab8dr49wEubYW85hrXKyGCcYl1OC56FE0kAT8DEIc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PAX9aPjmQKMw6GLmeGQtiXElLQtSpy3YzZ/VZyQdgAMom5kiPE/FjvCg3WC/1+nPy
	 10u5WabCCNOfLJhq7QAU3B1PpRxFQR3S//A+2qstDRiCAC24ehoVJf28O8MpDNi/Zp
	 1CxnqxNQY3PzCfWVombnnMFfy4sDHCYVZ/YIErc0=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250708155734eucas1p1407185657d9833058c6b35d11e1d0b01~QUdqUADk60849108491eucas1p1v;
	Tue,  8 Jul 2025 15:57:34 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250708155731eusmtip2162f9813a1cd05daa31b4d62d2bead82~QUdnRS2nc2073620736eusmtip2d;
	Tue,  8 Jul 2025 15:57:30 +0000 (GMT)
Message-ID: <b542bfa3-d680-4952-98fe-0a44ae3bddd7@samsung.com>
Date: Tue, 8 Jul 2025 17:57:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] dma-mapping: migrate to physical address-based API
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Robin Murphy <robin.murphy@arm.com>, Joerg
	Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Michael S.
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
In-Reply-To: <39d43309-9f34-48bc-a9ad-108c607ba175@samsung.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250708155734eucas1p1407185657d9833058c6b35d11e1d0b01
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
	<20250708110007.GF592765@unreal>
	<261f2417-78a9-45b8-bcec-7e36421a243c@samsung.com>
	<20250708120647.GG592765@unreal>
	<39d43309-9f34-48bc-a9ad-108c607ba175@samsung.com>

On 08.07.2025 14:56, Marek Szyprowski wrote:
> On 08.07.2025 14:06, Leon Romanovsky wrote:
>> On Tue, Jul 08, 2025 at 01:45:20PM +0200, Marek Szyprowski wrote:
>>> On 08.07.2025 13:00, Leon Romanovsky wrote:
>>>> On Tue, Jul 08, 2025 at 12:27:09PM +0200, Marek Szyprowski wrote:
>>>>> On 30.06.2025 15:38, Christoph Hellwig wrote:
>>>>>> On Fri, Jun 27, 2025 at 08:02:13PM +0300, Leon Romanovsky wrote:
>>>>>>>> Thanks for this rework! I assume that the next step is to add 
>>>>>>>> map_phys
>>>>>>>> callback also to the dma_map_ops and teach various dma-mapping 
>>>>>>>> providers
>>>>>>>> to use it to avoid more phys-to-page-to-phys conversions.
>>>>>>> Probably Christoph will say yes, however I personally don't see any
>>>>>>> benefit in this. Maybe I wrong here, but all existing .map_page()
>>>>>>> implementation platforms don't support p2p anyway. They won't 
>>>>>>> benefit
>>>>>>> from this such conversion.
>>>>>> I think that conversion should eventually happen, and rather 
>>>>>> sooner than
>>>>>> later.
>>>>> Agreed.
>>>>>
>>>>> Applied patches 1-7 to my dma-mapping-next branch. Let me know if one
>>>>> needs a stable branch with it.
>>>> Thanks a lot, I don't think that stable branch is needed. 
>>>> Realistically
>>>> speaking, my VFIO DMA work won't be merged this cycle, We are in -rc5,
>>>> it is complete rewrite from RFC version and touches pci-p2p code (to
>>>> remove dependency on struct page) in addition to VFIO, so it will take
>>>> time.
>>>>
>>>> Regarding, last patch (hmm), it will be great if you can take it.
>>>> We didn't touch anything in hmm.c this cycle and have no plans to 
>>>> send PR.
>>>> It can safely go through your tree.
>>> Okay, then I would like to get an explicit ack from Jérôme for this.
>> Jerome is not active in HMM world for a long time already.
>> HMM tree is managed by us (RDMA) 
>> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=hmm
>> ➜  kernel git:(m/dmabuf-vfio) git log --merges mm/hmm.c
>> ...
>> Pull HMM updates from Jason Gunthorpe:
>> ...
>>
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=58ba80c4740212c29a1cf9b48f588e60a7612209 
>>
>> +hmm        git 
>> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git#hmm
>>
>> We just never bothered to reflect current situation in MAINTAINERS file.
>
> Maybe this is the time to update it :)
>
> I was just a bit confused that no-one commented the HMM patch, but if 
> You maintain it, then this is okay.


I've applied the last patch to dma-mapping-for-next branch.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland



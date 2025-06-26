Return-Path: <linux-kernel+bounces-703916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4700AAE96AA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 09:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CD31C27281
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 07:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF5723B608;
	Thu, 26 Jun 2025 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UmJM2otD"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A903F2367D2
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750922466; cv=none; b=qbtPXaalcenn9ySDWxyniGMwtL/jgZ4kxdevJ/01Y7zNl+PXS2lFmOw0jAPKC4LpsbCKdu4P9p5CuxKDMmPbUg8Ll9/UWR2AjtYOkE2tERtmHxFr/zIrQdgLeTdrmNuHNxcbcSjU5k3HTihfO6HlpXRZ3mi5WocL8FAcYHCYURU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750922466; c=relaxed/simple;
	bh=8BEqZFGNNPYAx8EANxy+tw8P/Y+o0527pa2JR+l2NpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=TTcUt4hZLbnpCiiDuQsL/yKGzSACLKhtOrRZqRy00CqUxULpAf9hfUywLUfvomLbdVI6qdfy73ItcKsk/iy03ODDHYzUcU13SEMJdCbN7R78xDPt5EA5QJU9Sgv5J2uVMMZESwf59L8ww1e93u2OBI6tfov+x8i4RjROl3G0ypc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UmJM2otD; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250626072102euoutp02cdee4da3fdb0754f347311c6dc781e1e~MhrP0XrlG0825908259euoutp02W
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 07:21:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250626072102euoutp02cdee4da3fdb0754f347311c6dc781e1e~MhrP0XrlG0825908259euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750922462;
	bh=LPimFjjxe7jfdwBjYJXhsorVGtUpD3BI2ZbS3ELJhYk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=UmJM2otDrqRpBzvO2qj99Ds4/cZ0bS9VDuqkdaaSi1UUfpRMRFQlRdRF0rircsutJ
	 p5YlojDXfZA2+rw9jdxegvh60GGV1UhpS0IrZN1g2GhQWjlqt9GAcAhXmQPLU2x4vq
	 fpJ1B/WFbK3MxgwHzhZ8F3/ROYC1+69fnBMm5Ft4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250626072102eucas1p1be8a47bb942ca25436f9985c45a01c95~MhrPYoBcn1644116441eucas1p14;
	Thu, 26 Jun 2025 07:21:02 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250626072101eusmtip17c426e105c6e0e527e20a4ad58cc97a1~MhrOgUKZ22676026760eusmtip1X;
	Thu, 26 Jun 2025 07:21:01 +0000 (GMT)
Message-ID: <3acea31c-054c-43a8-a6f7-ab4b5b6a7dca@samsung.com>
Date: Thu, 26 Jun 2025 09:21:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] docs: dma-api: replace consistent with coherent
To: Petr Tesarik <ptesarik@suse.com>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton
	<akpm@linux-foundation.org>, Leon Romanovsky <leon@kernel.org>, Keith Busch
	<kbusch@kernel.org>, Caleb Sander Mateos <csander@purestorage.com>, Sagi
	Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, John Garry
	<john.g.garry@oracle.com>, "open list:DOCUMENTATION"
	<linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, iommu@lists.linux.dev
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250626065123.646bd954@mordecai.tesarici.cz>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250626072102eucas1p1be8a47bb942ca25436f9985c45a01c95
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250626045133eucas1p1d5070046a3303f6b2fe7f9ec75d08f02
X-EPHeader: CA
X-CMS-RootMailID: 20250626045133eucas1p1d5070046a3303f6b2fe7f9ec75d08f02
References: <20250624133923.1140421-1-ptesarik@suse.com>
	<20250624133923.1140421-3-ptesarik@suse.com>
	<CGME20250626045133eucas1p1d5070046a3303f6b2fe7f9ec75d08f02@eucas1p1.samsung.com>
	<20250626065123.646bd954@mordecai.tesarici.cz>

On 26.06.2025 06:51, Petr Tesarik wrote:
> On Tue, 24 Jun 2025 15:39:17 +0200
> Petr Tesarik <ptesarik@suse.com> wrote:
>
>> For consistency, always use the term "coherent" when talking about memory
>> that is not subject to CPU caching effects. The term "consistent" is a
>> relic of a long-removed pci_alloc_consistent() function.
> I realize that I'm not an authoritative source for this, but I forgot
> to add more trusted maintainers to the recipient list.
>
> Now, all you DMA experts, do you agree that the word "consistent"
> should be finally eradicated from DMA API documentation?

Well, this was always puzzling for me, why there are those 2 names used 
(especially in case of dma_alloc_coherent() vs. 
dma_alloc_nonconsistent()). I'm for unifying them to "coherent" as this 
is the term use more often.


> > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland



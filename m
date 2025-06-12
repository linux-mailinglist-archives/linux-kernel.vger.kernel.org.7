Return-Path: <linux-kernel+bounces-683038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044F2AD6820
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 08:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04D67A4FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 06:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B461F4CA4;
	Thu, 12 Jun 2025 06:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KJGJ7Z2K"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF1E1F473A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749710495; cv=none; b=bRm0qUQkFSoBiIK6Qd9abAzMZ4EkZkq0aPFFOxmdGbHdyQtwAGTWgad+ymZf/9yqL7bgAL9aiwlWpHMTF1wdegr+3XRNY22X5B1xvvpCPnAS6ffjDrd1uD+rFf4v8DY0AoiC6fpE95LuB9xJvkhho8oXo71tOWi0MqbjgeCugKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749710495; c=relaxed/simple;
	bh=A7TqxuB8t9bmTFkapNPal+O9p2AhATY2thZsPhLxr6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:In-Reply-To:
	 Content-Type:References; b=MpuMGAsaY2UDmj1stl3NDMtpF4IHdDQ6+rbjpsfyg5IkS3GNjOfyPfnFIp1l7eqYMu8lY1UEcRkEZ2sIC46FU9T3vzaxbbK0melYpQAeHJtM3+q/Xxv3Yr4+JGh/VQd5PAQGj7N75DdXP8mmZmg+1mpfkM1rObOIiAoJv9XxVuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KJGJ7Z2K; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250612064131euoutp02d26bb8d1b8e56ffd4b49cee153602af2~IOGvkL1pn3007030070euoutp02d
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 06:41:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250612064131euoutp02d26bb8d1b8e56ffd4b49cee153602af2~IOGvkL1pn3007030070euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749710491;
	bh=7nYk7226mhpYPqAZ23fAfF9iNBbc+f6mM4CczYyFCIQ=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=KJGJ7Z2KRe6nwAJupdsYYMq7TGP1oGW628D9+BaS2tIb66lABtfShBULkRLe0EIqL
	 4UHYM5OfqJzMMG7QTvaRxrC89YEEn4G7ClylxB6iRwEjdRnt1xCwfOW1hH0LMqtRxw
	 lUuKPj9EisVcUmdK/B1QCR0iyvRRsSmBFu5bLjhU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250612064130eucas1p1f607c3f7d9b1751ee1bc48ccc5a0eea7~IOGvJlcn80968109681eucas1p15;
	Thu, 12 Jun 2025 06:41:30 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250612064130eusmtip1b9141f05b400d99bbb5c3913c5bc51a4~IOGuc7ewg2952629526eusmtip1M;
	Thu, 12 Jun 2025 06:41:30 +0000 (GMT)
Message-ID: <1da11218-64d4-49bc-a484-77390a5cd9bc@samsung.com>
Date: Thu, 12 Jun 2025 08:41:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-contiguous: hornor the cma address limit setup by
 user
To: Feng Tang <feng.tang@linux.alibaba.com>, Robin Murphy
	<robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrew
	Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250612021417.44929-1-feng.tang@linux.alibaba.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250612064130eucas1p1f607c3f7d9b1751ee1bc48ccc5a0eea7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250612021422eucas1p16c777f6fa46aa130d9b83ba80c2c11c3
X-EPHeader: CA
X-CMS-RootMailID: 20250612021422eucas1p16c777f6fa46aa130d9b83ba80c2c11c3
References: <CGME20250612021422eucas1p16c777f6fa46aa130d9b83ba80c2c11c3@eucas1p1.samsung.com>
	<20250612021417.44929-1-feng.tang@linux.alibaba.com>

On 12.06.2025 04:14, Feng Tang wrote:
> When porting a cma related usage from x86_64 server to arm64 server,
> the "cma=4G@4G" setup failed on arm64. The reason is arm64 and some
> other architectures have specific physical address limit for reserved
> cma area, like 4GB due to the device's need for 32 bit dma. Actually
> lots of platforms of those architectures don't have this device dma
> limit, but still have to obey it, and are not able to reserve a huge
> cma pool.
>
> This situation could be improved by honoring the user input cma
> physical address than the arch limit. As when users specify it, they
> already knows what the default is which probably can't suit them.
>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>

Thanks, applied to dma-mapping-fixes branch.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland



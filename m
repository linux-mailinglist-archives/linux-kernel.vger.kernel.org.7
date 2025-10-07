Return-Path: <linux-kernel+bounces-844065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C53CBBC0EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E2819A1C31
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AA546BF;
	Tue,  7 Oct 2025 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qzlUXul4"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CC935972
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830569; cv=none; b=TeASfrntwF5aqWCM0mT5nC4AGNmr3e/dGFxgHQL1dH/R+K+d8OFk7GWQhQmkT3tZZ5P5sIvSh6hHfqrhE4SZIlwcp9MspBgnIkjpd/yP6lWYxWYf52+gCLIhdU7k9Fc9LKee77pgP5N1vllx0xq+5/t3sJsYt9aly3DLkrrkwJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830569; c=relaxed/simple;
	bh=u8u0NmnSLZuaOxL/A+X/WOzOBBwdkhSqtKoSjgf4Owg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=hiAJspxLUArEqPUzwu8J93AthEU/mnHGGrZ+DHwTrSRPppAC4a3FjSzk/tAaGnbUSUPXsF5RSxNJRVLiV35lHNWLSPi7lBa9DZ/BrQtbgAUkYa4y2UH68SwmpS1ydlKgv+CZzdegUO5Em3vkyF2LvSyT+wzvpClrV4u0wrVe1uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qzlUXul4; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251007094918euoutp01fdc11654e0484c259e71262332b352c1~sLJHChWk90117301173euoutp01a
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:49:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251007094918euoutp01fdc11654e0484c259e71262332b352c1~sLJHChWk90117301173euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759830558;
	bh=1Wbns4tsawHIT2n+WE+qQ2RONhK37Q87C8TzJuMp5Ss=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=qzlUXul4UDizHJNVk5fsCcjCNVG5XLGHm1bZIynJN7XivSovXyAPy3QiLzq5OYn+X
	 tOXfAj5QNlQFiZyY7H9+aWQVgJZ9LSOxEHjQyi7Es6VlhryALHTvz8odJ/vZ+sh/ap
	 otunaujvwggM5ojvIu7D48V2Mz9e8bIBaOq9DdUE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251007094918eucas1p156e46178b9f1073d96a93b0342cca05c~sLJGnoJ061180611806eucas1p1J;
	Tue,  7 Oct 2025 09:49:18 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251007094917eusmtip270ccf3e223167cded56393464922a0a6~sLJFxeArE2792027920eusmtip2B;
	Tue,  7 Oct 2025 09:49:17 +0000 (GMT)
Message-ID: <51795930-680c-49cc-a4e0-c7ae7e017bad@samsung.com>
Date: Tue, 7 Oct 2025 11:49:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2 03/14] iommu/exynos: fix device leak on of_xlate()
To: Johan Hovold <johan@kernel.org>, Joerg Roedel <joro@8bytes.org>, Will
	Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@kernel.org>, Janne
	Grunau <j@jannau.net>, Rob Clark <robin.clark@oss.qualcomm.com>, Yong Wu
	<yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Yu Kuai
	<yukuai3@huawei.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251007094327.11734-4-johan@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251007094918eucas1p156e46178b9f1073d96a93b0342cca05c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251007094459eucas1p2474c07d6c4fe475c02d4210d8f184643
X-EPHeader: CA
X-CMS-RootMailID: 20251007094459eucas1p2474c07d6c4fe475c02d4210d8f184643
References: <20251007094327.11734-1-johan@kernel.org>
	<CGME20251007094459eucas1p2474c07d6c4fe475c02d4210d8f184643@eucas1p2.samsung.com>
	<20251007094327.11734-4-johan@kernel.org>

On 07.10.2025 11:43, Johan Hovold wrote:
> Make sure to drop the reference taken to the iommu platform device when
> looking up its driver data during of_xlate().
>
> Note that commit 1a26044954a6 ("iommu/exynos: add missing put_device()
> call in exynos_iommu_of_xlate()") fixed the leak in a couple of error
> paths, but the reference is still leaking on success.
>
> Fixes: aa759fd376fb ("iommu/exynos: Add callback for initializing devices from device tree")
> Cc: stable@vger.kernel.org	# 4.2: 1a26044954a6
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/iommu/exynos-iommu.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index b6edd178fe25..ce9e935cb84c 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1446,17 +1446,14 @@ static int exynos_iommu_of_xlate(struct device *dev,
>   		return -ENODEV;
>   
>   	data = platform_get_drvdata(sysmmu);
> -	if (!data) {
> -		put_device(&sysmmu->dev);
> +	put_device(&sysmmu->dev);
> +	if (!data)
>   		return -ENODEV;
> -	}
>   
>   	if (!owner) {
>   		owner = kzalloc(sizeof(*owner), GFP_KERNEL);
> -		if (!owner) {
> -			put_device(&sysmmu->dev);
> +		if (!owner)
>   			return -ENOMEM;
> -		}
>   
>   		INIT_LIST_HEAD(&owner->controllers);
>   		mutex_init(&owner->rpm_lock);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland



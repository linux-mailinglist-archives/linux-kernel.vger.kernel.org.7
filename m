Return-Path: <linux-kernel+bounces-614917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD81AA973D4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 19:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1FBE1886B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 17:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0871DDC28;
	Tue, 22 Apr 2025 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="S/Ymvbru"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE921A841E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343816; cv=none; b=ohV+X2mX3e9TXiKGksPDmbdgcuGmCynAObLoOEqMhtgiyEbpiOSqqsXLQoNZ/RAI7rqnZZk7GMJ1/dCgBfQgwO2XerrJG7QSo/Jt4JpvRJzrv+PUQzN8aQ1jRMjUc3pOuS8tWjV+AmiRFXNHivpsR9kjhEkUnUrFXQpHxGTHfV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343816; c=relaxed/simple;
	bh=NviU6SQzuL493BKC1FWAfe1zZoM2PxsVx/bhf94dJoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=mOJfGnLQFCBMavH6egYHnTrT9b4tBmYuXf44RatCMlYS+DMREocQAVWbwhJ4287UC08RAoqcxLOCgcN9VnBJuboE5qG3o36Hr+sYYyLHAmJ9jCpqBZ0tJ0Q6AU85/rY3XzPwvc4i1JmX6hHWbZ++7I1dT1EPsBqJu/qwqFufXCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=S/Ymvbru; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250422174330euoutp02b5563054bca50f5155943c5c918d14f0~4tPLPUP1x1074410744euoutp02T
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 17:43:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250422174330euoutp02b5563054bca50f5155943c5c918d14f0~4tPLPUP1x1074410744euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1745343810;
	bh=9U3uF317mii8pPt+5q0xLwj6q8godP4ITs+SG9wMiBQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=S/Ymvbru8UUFNfB8UbkGQrNPj+y8s4oW2FxPn8GU+WksoGAtwZ0Apwz804Avo1XBV
	 ZwU1krR/ZmBJLdi/YipWLvZ7ymkbKYX8kAhoFVqEBZuvyhlYfIZldOtghBfkmfiEdV
	 iceWR59HrYpYgWMiCxyfx6gsKZOGRdXXdC0h2WoE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250422174329eucas1p143e18103a92e69a0205ecb218829aa54~4tPKitG8p2174021740eucas1p1H;
	Tue, 22 Apr 2025 17:43:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id F6.FD.17807.145D7086; Tue, 22
	Apr 2025 18:43:29 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250422174329eucas1p11b7f6c8988d8f84ff1f197de8595a0ac~4tPKD8az-2174021740eucas1p1G;
	Tue, 22 Apr 2025 17:43:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250422174329eusmtrp20744e497f091347872965af57f37356a~4tPKDSV510800908009eusmtrp2K;
	Tue, 22 Apr 2025 17:43:29 +0000 (GMT)
X-AuditID: cbfec7f4-1fbfe7000000458f-7c-6807d541f020
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D9.70.19920.145D7086; Tue, 22
	Apr 2025 18:43:29 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250422174328eusmtip2c55430542403d9f8072a9000e4b2a0b0~4tPJrnjE-1535115351eusmtip2E;
	Tue, 22 Apr 2025 17:43:28 +0000 (GMT)
Message-ID: <6f6ea4c2-01f0-4eff-8b04-66a655f75cca@samsung.com>
Date: Tue, 22 Apr 2025 19:43:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-coherent: Warn if OF reserved memory is beyond
 current coherent DMA mask
To: Chen-Yu Tsai <wenst@chromium.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250421083930.374173-1-wenst@chromium.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduznOV3Hq+wZBtuX61j8+mJhcXnXHDaL
	gx+esFrMaLvM6sDisWbeGkaP2Q0XWTxebJ7J6PF5k1wASxSXTUpqTmZZapG+XQJXxsF/89gL
	1nNUPOn/wNrAeIuti5GTQ0LAROLk3leMXYxcHEICKxglJvTsYwdJCAl8YZR4dKQIIvGZUeLW
	+ueMMB0dc64xQSSWM0p8eTyfBaLjI6PEqo8ZIDavgJ3Eu6vvwFawCKhK7F59jA0iLihxcuYT
	sHpRAXmJ+7dmgG0TFkiWOHGjmbmLkYNDRMBL4sC+AJAws4C5xNHpx5khbHGJW0/mM4HYbAKG
	El1vu8BGcgpYSrz8+I0RokZeYvvbOcwgt0kI7OGQuDJ7NtSbLhKbm38wQdjCEq+Ob2GHsGUk
	/u+czwTR0M4oseD3fShnAqNEw/NbUC9bS9w594sN5DpmAU2J9bv0IcKOEiu2zmcECUsI8Enc
	eCsIcQSfxKRt05khwrwSHW1CENVqErOOr4Nbe/DCJeYJjEqzkEJlFpI3ZyF5ZxbC3gWMLKsY
	xVNLi3PTU4uN8lLL9YoTc4tL89L1kvNzNzEC08rpf8e/7GBc/uqj3iFGJg7GQ4wSHMxKIry/
	3NgzhHhTEiurUovy44tKc1KLDzFKc7AoifMu2t+aLiSQnliSmp2aWpBaBJNl4uCUamCKrt/g
	2F5UuCk39ti+yslmpsyP93zwbjJS3P7v91lv9lk27Z/mr+SZln7tn9CMets/4kfrD5ZpLzSq
	iiiatXPvgikrD0dvDPBhPucvZ356+/8OXYMbbivuys1xk9Q+pZF6a2fVo0t/T3F6TUtVWNrB
	tdpGY4qk8tsd20w/rbhR+qJKrXZRuPe8q7GZpY+vyUwXfcOQlKGmE3AsTGmj2AEWlVtMehqr
	/jmH6GmcOL3G/LflnK764qmhp+/3Htt3Zu+mOS82fVsVZuir11J4f2f698WBdxxnZaglXL2t
	lOXRKmXZmi9z9JFFzHaZ7/yhvqpLmvU+HddQcuGcLPTjRpP4wVrfeYeFt5/SaUhf53NXiaU4
	I9FQi7moOBEAd/aErpoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7qOV9kzDP62cVv8+mJhcXnXHDaL
	gx+esFrMaLvM6sDisWbeGkaP2Q0XWTxebJ7J6PF5k1wAS5SeTVF+aUmqQkZ+cYmtUrShhZGe
	oaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexsF/89gL1nNUPOn/wNrAeIuti5GTQ0LA
	RKJjzjWmLkYuDiGBpYwSu6Y/ZYZIyEicnNbACmELS/y51sUGUfSeUWLr1YssIAleATuJd1ff
	gU1iEVCV2L36GBtEXFDi5MwnYDWiAvIS92/NYAexhQWSJU7caAZawMEhIuAlcWBfAEiYWcBc
	4uj048wQ83sYJeZOOscIkRCXuPVkPhOIzSZgKNH1tgtsPqeApcTLj9+gaswkurZ2QdnyEtvf
	zmGewCg0C8kZs5CMmoWkZRaSlgWMLKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECY2nbsZ+b
	dzDOe/VR7xAjEwfjIUYJDmYlEd5fbuwZQrwpiZVVqUX58UWlOanFhxhNgWExkVlKNDkfGM15
	JfGGZgamhiZmlgamlmbGSuK8bpfPpwkJpCeWpGanphakFsH0MXFwSjUw+UzbIyGvV/Ez6Vd1
	rtdMx8jGD78u6r1SlnAQ/ViwSCBaxqJFU6cw3PGZYsTjbr0b78InVj31+FEvcSrmf8mHyMRT
	SfMECl833Uj52/A+N0ozbgbHJZmIiWsv3Z6/YBv7Daneabqm89QFHUPizbr1SuzP2CeGl2u5
	HWf7x7Tu6uKAyI8xSScfiB9ylhO33vfaqsEoW/pZ95y0b3+sVm/2i8iR4Pio+e3xiQl3nJeu
	jf7o/kndfx2HW7gWp+mSu2uPRJxg//BK4Ofi87P16tO1VNZuzE02emlWdGLHsnTLt3WcT/YF
	x5gttbkUntcdlKA+syrxus/xcN2WFVzbFy90VxRrEny46nRkmG63drESS3FGoqEWc1FxIgAp
	R742LgMAAA==
X-CMS-MailID: 20250422174329eucas1p11b7f6c8988d8f84ff1f197de8595a0ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250421083941eucas1p28b1de88f77e9de88f52b2c72918c9561
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250421083941eucas1p28b1de88f77e9de88f52b2c72918c9561
References: <CGME20250421083941eucas1p28b1de88f77e9de88f52b2c72918c9561@eucas1p2.samsung.com>
	<20250421083930.374173-1-wenst@chromium.org>

On 21.04.2025 10:39, Chen-Yu Tsai wrote:
> When a reserved memory region described in the device tree is attached
> to a device, it is expected that the device's limitations are correctly
> included in that description.
>
> However, if the device driver failed to implement DMA address masking
> or addressing beyond the default 32 bits (on arm64), then bad things
> could happen because the DMA address was truncated, such as playing
> back audio with no actual audio coming out, or DMA overwriting random
> blocks of kernel memory.
>
> Check against the coherent DMA mask when the memory regions are attached
> to the device. Give a warning when the memory region can not be covered
> by the mask.
>
> A warning instead of a hard error was chosen, because it is possible
> that existing drivers could be working fine even if they forgot to
> extend the coherent DMA mask.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Thanks, applied to dma-mapping-fixes branch.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland



Return-Path: <linux-kernel+bounces-610210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B670DA931E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 08:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2025447F15
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 06:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396D71FBE87;
	Fri, 18 Apr 2025 06:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EW1d9dJ/"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665CE2E40B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 06:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744957161; cv=none; b=dOGkIaLsL718VdJxK3ZhDCcWlvoz4d9RuG7+nU6b7Q7uEYR1NJC4yWq7XaDN/i6wFYfSYawpGMGEyWh21t3Z5EW5GSrUtGE9+AFE1z4wVYUXzRNCKhCcLzsfbprAG1D6JMj15ivNEKdmqVLdPzVmSvpFyAEeJ1CzXzd+cO+61qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744957161; c=relaxed/simple;
	bh=WcVXQNppAfOyvpsjjFd5FhPEFnm/FQJNMa2Z2XpGJ4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=eR0rZZmy7sXzLV+PRhPH7CgCC+sEh+KqQgLGpQpfLKs8+W1YUAZurps1hqJs264g9IGhwduKYthjGbb1GG+YpDjvr7FZn127mKXy6hHNJQ/jk8NpHvp+SLcaznWtmRcK92WCGKECoSu2DUcg11qb/tfgOYl+M69gRdcCgT4sNSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EW1d9dJ/; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250418061916euoutp01d9211a70e4f75fcd0215495add735ea4~3VUn19_7K2746927469euoutp01L
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 06:19:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250418061916euoutp01d9211a70e4f75fcd0215495add735ea4~3VUn19_7K2746927469euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744957156;
	bh=S2JQV1AgO14R7WYcM0wLJaSuv7E1N9Zgr1tZNZPzywA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=EW1d9dJ/o0awh/qaVhCVolpSf05CQt3nV30Z5/VTJtitbsCE/zN+V1Py2GJ4FtaGT
	 jskgT18y3Wn5BSPkGCNJAH/dcZdbWtPHhz4HVl+ZCPTJR278EIk+AqiO57vig1i/3X
	 SK/2rqhj+1TOrvgD5Xzy+HPzg2hwUaacz98QXDnY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250418061916eucas1p17df1db26f6fc0b019fd374af9ff5a3b1~3VUndX11c1817818178eucas1p1l;
	Fri, 18 Apr 2025 06:19:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 51.9D.20821.4EEE1086; Fri, 18
	Apr 2025 07:19:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250418061915eucas1p275a0d6e23c262981277109d6d0db95d6~3VUnGOa8s0841508415eucas1p2Z;
	Fri, 18 Apr 2025 06:19:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250418061915eusmtrp14968a24dcc40da86089721a35449a276~3VUnFqBUV3118131181eusmtrp1e;
	Fri, 18 Apr 2025 06:19:15 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-f8-6801eee41dfe
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id F3.C1.19654.3EEE1086; Fri, 18
	Apr 2025 07:19:15 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250418061915eusmtip2e899d892d07912e35aebee8f28071eec~3VUmmCK0n2270222702eusmtip20;
	Fri, 18 Apr 2025 06:19:15 +0000 (GMT)
Message-ID: <304860b1-cd01-4d27-92eb-0bf6e30398fb@samsung.com>
Date: Fri, 18 Apr 2025 08:19:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-mapping: avoid potential unused data compilation
 warning
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Christoph Hellwig
	<hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <Z_4pZm_tQ6qmmj35@smile.fi.intel.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se2xLYRzNd+/t3V2jc3Xob5tnGUF0xug1zCNERQQRxDwbvbqyddJumJA1
	xKvzbM2jG5sitlra2ZhtItJlVFM6amqW2ZIZw1J0s5htxtbrsf/OOb/zfed3vnwULjTzwimV
	OoXVqOWJYpJPlDz6UTW56TNKmFJ8fyBz4sB5jMm/+RBjOr8xzLOSkzzmRXk2yTzKHcrYvzbx
	5gXJCi4XIFmR5Rgpu+xcKftQfBHJ7r3WkbK2ohEryHj+bAWbqNrFaqLitvATGrqOop0HeXv0
	heeQDp0l9CiYAjoGDvzy8PSITwnpPATe+seII98Q5LZ8JjnShuCNrgP9PfKl3YBzgxsIjl/3
	YRzxI2h2dwb1uQR0HOT528k+TNCRcCfrBsHpg8B5sSmAh9AjoaH2QsAfSq+CDGdZQB9MS8Fq
	MAeicbocQY+3PDDAaRHUNuVgfZiko0Hv0wcCgumpYH7/Aec8I+GuLzuwHtB1FFhe3SK5vRdC
	Zrc1iMOh8Mlx+w8eBi7jcYI7cKS3dVcDxpHTCHTNtX9az4I6d2fvTVRvxASwlUdx8nzIyv6O
	9clAh0CNbxC3RAgYSs7jnCyAo4eFnHscmBzWf7H2Zx78NBKb+r2LqV9NU786pv+5uYiwIBGb
	qk1SstpoNbtbopUnaVPVSsnW5KQi1PuNXD2O1lJ06ZNfUoEwClUgoHDxYIFb2qMUChTytL2s
	JnmzJjWR1VagCIoQiwTmB4eUQlopT2F3sOxOVvN3ilHB4TpMv9h9b5G845B6f/IQiRVfd+3t
	rzGW0KuilO5dY8uuF4Yw4kJjRiX/xXdfZKbdjtfPGhj5xYlU80MzjOvF69NjLMyaGT8zUhXd
	PYpWSvR0S75Laq6Km3vNK2rRuJ9Pjx8/2/Rm25MIwlY9Nv/C6lFJYY7ilzlxDZcOx2ywpX11
	GbqDTtV4lxdsLIkarS99MunkuxHSxvBRlcJlr/wenc5lD/uoG1CWJy311PCVRr5E7MBr91YN
	7eywVXsah+1/neZtvEPFLjHGqwoX4BGb0vc5ISw23dBeN23hnIq1/pwzzZU8Y2P1zQWyd/XD
	w7O2b6xZ+iNTlZ210qaY2WIjr1jFhDZBHj0R12jlvwFGFXTBtQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xe7qP3zFmGHRON7PobZrOZLFy9VEm
	i19fLCwubOtjtbi8aw6bxbEFYhYHPzxhdWD3WDNvDaPHplWdbB7zTgZ6vNg8k9Fj980GNo/P
	m+QC2KL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0
	Mu7/7mAsaGat6NowjbGBcQpLFyMnh4SAicT7r5OYuxi5OIQEljJKzOi4xASRkJE4Oa2BFcIW
	lvhzrYsNoug9o8Tv27vBErwCdhIrPn5lA7FZBFQlts5ezgIRF5Q4OfMJmC0qIC9x/9YMdhBb
	WCBYovvkTrC4iIC5xLpJi8CGMgvsYpTYsegXI8QGIOde61JmkCpmAXGJW0/mg53EJmAo0fW2
	C2wbp4CRxKJnL6BqzCS6tnYxQtjyEtvfzmGewCg0C8khs5CMmoWkZRaSlgWMLKsYRVJLi3PT
	c4uN9IoTc4tL89L1kvNzNzECo2/bsZ9bdjCufPVR7xAjEwfjIUYJDmYlEd5z5v/ShXhTEiur
	Uovy44tKc1KLDzGaAkNjIrOUaHI+MP7zSuINzQxMDU3MLA1MLc2MlcR52a6cTxMSSE8sSc1O
	TS1ILYLpY+LglGpg4s4sOf1S+PbliOmXvGdNVhGZ5dX4feWh2+wrHuQ8uhmRGTfP7ivrtbBI
	JWHhFHcj5tRXSh8ql1/3Ebg340vOiZrfq9Kfe5fL6bt8KDSTy/g4yUHp8rvVP5Nup31IsuJ0
	3jfhcVxsfYvhse1d5ZeOzvhTKOChEnVxF5+FvriEZ33hSevjlotnaBpEMztor98j3NbrVZ9d
	ftJao7rHRtxIJ51Xq2JW9LLVc33//ShzqDjFf2vJ/OdTKpSnWikdTeAMkL2w+qL5/ao1UksZ
	XBq5b751j+Nu2Rvu9Eb8xuR5Z+Umvpvz+pllPeNZwRTFI19uFLm633gX/ri7QpXt/9mr5jG2
	R/+2Gz8PeTshgalBiaU4I9FQi7moOBEAGYc69kcDAAA=
X-CMS-MailID: 20250418061915eucas1p275a0d6e23c262981277109d6d0db95d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250415075716eucas1p1a5343f5dec617f82f5adca300eb47485
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250415075716eucas1p1a5343f5dec617f82f5adca300eb47485
References: <CGME20250415075716eucas1p1a5343f5dec617f82f5adca300eb47485@eucas1p1.samsung.com>
	<20250415075659.428549-1-m.szyprowski@samsung.com>
	<Z_4pZm_tQ6qmmj35@smile.fi.intel.com>

On 15.04.2025 11:39, Andy Shevchenko wrote:
> On Tue, Apr 15, 2025 at 09:56:59AM +0200, Marek Szyprowski wrote:
>> When CONFIG_NEED_DMA_MAP_STATE is not defined, dma-mapping clients might
>> report unused data compilation warnings for dma_unmap_*() calls
>> arguments. Redefine macros for those calls to let compiler to notice that
>> it is okay when the provided arguments are not used.
> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> (GCC on default i386_defconfig with `make W=1` on v6.15-rc2)

Applied to dma-mapping-fixes branch.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland



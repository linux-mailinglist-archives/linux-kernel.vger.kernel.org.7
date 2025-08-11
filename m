Return-Path: <linux-kernel+bounces-762520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E836B207EA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C39423844
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895B42D3A9F;
	Mon, 11 Aug 2025 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UrNEJu54"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CDD2D3ECA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911750; cv=none; b=jPmyCEIUBeHGa64G6lBn9oT+ga+0RkH/amrwwlOsDert1r4ex2tfXycZF0Xts3QAHNTyurLzxVxDDk1bH+3t22nZkIdlx13whyqM/wPPnjUZiPKA+aZ8zvVHndijSZJFEEvVij9YG5rWIQFMkRf20Kblo+6/rQRGkC65Wz3rghY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911750; c=relaxed/simple;
	bh=9UCNCqLJ4ZgDuGCaCNHhTpZ8j9q19vNou6WfiLYZmUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Y/AQDFCy3ahUhLBhT8aOruZ7xNPc6QwodGODJ39wh5Z+GJHG0t6rrsI8KCqH4tvyWSzrxXbCnlGvkQ7AvT6gXp+6G9pAULU86qNXx6F6AONy16kPZ3JqyVJ9FlrfUulY+4Z8E0kfbBlaC5RUlG7o9LN7hJ3RjV9CLd07tf/VNNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UrNEJu54; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250811112906euoutp01924f76e657b0c7770938a72eacc3559d~asu92BatV1717617176euoutp01i
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:29:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250811112906euoutp01924f76e657b0c7770938a72eacc3559d~asu92BatV1717617176euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754911746;
	bh=E1gFTug5OpkfouB4pnTieGtNqu32kyFBleCamPbcijo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=UrNEJu54txFo+mB1fG6p9EGmRurFdplJLJoK2BbZntWdzxSuIY7Ik3i7ckJNky4N2
	 KwzuVgkK+XsvxhID83kQJ/gntays6wM+t7GZqxMAhWRHSeWAXllHVf8Z5rDQpUojU/
	 zo/Bnz8lfNV7iaJjjXt0asGEjJuh2OFZSxz8vMJY=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250811112906eucas1p1cac2fe9a47686308614d87af71e6e4d5~asu9nWy183122431224eucas1p1k;
	Mon, 11 Aug 2025 11:29:06 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250811112905eusmtip134d75eb2c131e9a2c9d5dbb4e2d97691~asu9FgEKe2191521915eusmtip10;
	Mon, 11 Aug 2025 11:29:05 +0000 (GMT)
Message-ID: <2d20d625-065d-455e-a559-9d192b56dc55@samsung.com>
Date: Mon, 11 Aug 2025 13:29:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-direct: clean up the logic in
 __dma_direct_alloc_pages()
To: Petr Tesarik <ptesarik@suse.com>, Robin Murphy <robin.murphy@arm.com>
Cc: "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250710083829.1853466-1-ptesarik@suse.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250811112906eucas1p1cac2fe9a47686308614d87af71e6e4d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250710083845eucas1p26704ee50d9c05b0689ff17a1f8a1fca5
X-EPHeader: CA
X-CMS-RootMailID: 20250710083845eucas1p26704ee50d9c05b0689ff17a1f8a1fca5
References: <CGME20250710083845eucas1p26704ee50d9c05b0689ff17a1f8a1fca5@eucas1p2.samsung.com>
	<20250710083829.1853466-1-ptesarik@suse.com>

On 10.07.2025 10:38, Petr Tesarik wrote:
> Convert a goto-based loop to a while() loop. To allow the simplification,
> return early when allocation from CMA is successful. As a bonus, this early
> return avoids a repeated dma_coherent_ok() check.
>
> No functional change.
>
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>

Thanks, applied to dma-mapping-for-next branch.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland



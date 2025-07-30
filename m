Return-Path: <linux-kernel+bounces-750756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 394F8B160A4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6207A2562
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213CE267F57;
	Wed, 30 Jul 2025 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NS8Ro2Q7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B21839ACC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879787; cv=none; b=c8WURzGuV2btTZRM4c9HzxpJ/wrYTBuphI21upqj+rODZdQMl+qBHNAt5/apjdw6AoCWb/BVSyWHoFh3H6IT1nRBeWZpTdhaA/j/PGqi/ddFZCp+fXSjP/8AO/PrUASlyyirOcCulra3UjvaOF0tY+zR5WLP+WBm3PWxlwXK/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879787; c=relaxed/simple;
	bh=piipJ1CZoNF3GZK3m0mmbuy7e2kJrLD9R387GcQ6V9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHLX5qxxPkDkXBck2PHxpqB6GYL2RGFbYRF7zdM64BcJPLdetdiVNPtipLEwpVAGInKE8yeeM56ekar3qOiwKz+442gYwmQlU5nFSmgtXyjFONC3qIQ7ZCLveD3wCJWgX4NoxznvWV9dWPGdsqebnNJsMoZg7fMo3VehSOtrm3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NS8Ro2Q7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=oXjbbzRW9TrXGpMOJwCvoOk0ZBJ+mMgDqBJb4Q1gY94=; b=NS8Ro2Q7lUz68JJPsJvPf5BZOW
	gZEroRiPD12Jv5J0snMDiLKi++eAt+CGOjlGdUumtUHOjq2QJt2Y1KUVt6cHw3kYKA524TOIgt4lx
	Q3Uxi8bvIckE3snuynXGWwkns8VQwHr+y4hcr7VgH81RY3mSyI/McyrbCXA0042qsVzPAaU1d8e5p
	MYRatbiBBQGwlhc5mXl3JAnoTuiIOWSKo1gwDwRgHR2c4UjFQjOuWxQLZ+BLcatCusQsRkhAA17+8
	TrCIasldVYipK3VL+rHZf+3//kRaE7Q9Q/sk23RiW+qHccnx4XM2O22cMn92XdOU7inVOHTmvt9b6
	k2rTKwOg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh6FS-0000000CVGZ-3Fep;
	Wed, 30 Jul 2025 12:49:34 +0000
Date: Wed, 30 Jul 2025 13:49:34 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zhang Qilong <zhangqilong3@huawei.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, david@redhat.com,
	wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH resend v2] /dev/zero: try to align PMD_SIZE for private
 mapping
Message-ID: <aIoU3hO9JBAyuTcy@casper.infradead.org>
References: <20250730091905.383353-1-zhangqilong3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250730091905.383353-1-zhangqilong3@huawei.com>

On Wed, Jul 30, 2025 at 05:19:05PM +0800, Zhang Qilong wrote:
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +		return thp_get_unmapped_area(file, addr, len, pgoff, flags);
> +
>  	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);

I'm sure the build bots will give us a compiler error.
If CONFIG_TRANSPARENT_HUGEPAGE is not enabled, we get:
include/linux/huge_mm.h:#define thp_get_unmapped_area   NULL

and we chose that so that various filesystems can unconditionally set
their .get_unmapped_area method to it.

Which means the cpp will turn this into:

	if (0)
		return NULL(file, addr, len, pgoff, flags);

and the compiler will say:

error: implicit declaration of function ‘NULL’ [-Wimplicit-function-declaration]



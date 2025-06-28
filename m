Return-Path: <linux-kernel+bounces-707967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5233CAEC9D1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 21:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65531897AE0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 19:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3D3246771;
	Sat, 28 Jun 2025 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K2snykvp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B53C2BCFB;
	Sat, 28 Jun 2025 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751137179; cv=none; b=ET0vA+GNKmt++b1qvBytOFBffECcxRSNIa+LwkFWR1ZvvWTFXkhnqk2fKJNHoEoLWlVhzM5g4ym0n4/WWipmnobw1qxbEbc1jge+VHRERW7QeYd3nkosS+6NKJgfaEEbpqcPtNlzfEBbcFENvJUWy6clEoWRKpQCjj0gItMiuAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751137179; c=relaxed/simple;
	bh=yvjuWw+Vvw3ZEc/UQwo9HZ4h3YTfhcuxfThnk0WUa9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3jPSJu7audVGfkcbbrarcEDROhVyzntyXFoqKw9gYz6rUafYfPD2PQsNuZTv4VGKeQk/fkWXDCJd7GT9MG60l3IECxOfg+38eqTJ/bWyiMf9AgVeb3Gwn0k//nKuJAhvq1I2zyC/RV/uXc8qIvy3YEyaN+349fJGJhsJPCDpiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K2snykvp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=+V31Sb7lyUAetps5kXX6jaGXqJOXR4iB8FLG9YZKZb8=; b=K2snykvpAxbQdQbj1t5VH3C8M5
	QKrHoblJGRl9vbFcaNpCOUEjUhNlAlePRanLo21WEmOzE1Mmwa40wTKewY0dPifJMQssiH9a5Hsk0
	qcLYqjSQr/QCTNXnEnX6SFLG+Vzp1Ff23b1k5bkMB/R6p+ocVf6OykwONFAvLyfdrV+ZU52NfWR/6
	zCah8vs9vGUniDV6wmpjcugntvNGB57qyl+e245jjgKZBbUYc7SLMi41Oqot0VSuhADNWR5z3hztr
	h/lPswLUh4efaIzJD5es/IWOK24EWYo7YVnU0+AsYCR5x1VDjs7NeEhLD2ppjJ78FWOJdm9LEujYc
	kUD8+55Q==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uValy-0000000H7yS-22SC;
	Sat, 28 Jun 2025 18:59:34 +0000
Message-ID: <337ea10d-d6b6-496e-b1e3-4ee912067e8e@infradead.org>
Date: Sat, 28 Jun 2025 11:59:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] docs: dma-api: update streaming DMA physical
 address constraints
To: Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, iommu@lists.linux.dev
References: <20250627101015.1600042-1-ptesarik@suse.com>
 <20250627101015.1600042-8-ptesarik@suse.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250627101015.1600042-8-ptesarik@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/27/25 3:10 AM, Petr Tesarik wrote:
> Add an introductory paragraph to Part Id - Streaming DMA mappings and move
> the explanation of address constraints there, because it applies to all map
> functions.
> 
> Clarify that streaming DMA can be used with memory which does not meet the
> addressing constraints of a device, but it may fail in that case.
> 
> Make a note about SWIOTLB and link to the detailed description of it.
> 
> Do not mention platform-dependent allocation flags. The note may mislead
> device driver authors into thinking that they should poke into and try to
> second-guess the DMA API implementation. They definitely shouldn't.
> 
> Remove the claim that platforms with an IOMMU may not require physically
> contiguous buffers. The current implementation explicitly rejects vmalloc
> addresses, regardless of IOMMU.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/core-api/dma-api.rst | 36 +++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 15 deletions(-)

-- 
~Randy


Return-Path: <linux-kernel+bounces-734227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29976B07E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E89A170B77
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572E62BE645;
	Wed, 16 Jul 2025 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N8ZodEu6"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CB719C566
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752696723; cv=none; b=NGAdZdvhu1xTG2YbXoIJEESzxBpvpd58KGvh3W8Cn/5jjZQ8grc4e8tubQ/GaLCZvuPkPBWhwx1x9X9kyzk09qxYFmyaqgDZKcpOpPO78Ua58m/gWKkoJx79TlANrBNH48ps7yATllNS7Rdt/e5w4Lp30l2eYKHwbaWUNz9k5c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752696723; c=relaxed/simple;
	bh=sV9x0KM4cBRnlnmOMDIuZu//q5dxMfZg4n/R7O+sTNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WKG9NxXAVol1rSqmqPocafsxRoO5hGPN3odD89oUplIRqqUHhHMATHHBlB7khQY2bcYb1O9ZjxW89luM92/KrybTtmDUvlkQcGeYsLzA33ZODGV1V5+Skk9UayJsP9qNQCVqMqh3vT+MBSJ+6fZx4HvMnrz7X4C95io56thDyDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N8ZodEu6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=WgFYKDUl2s0B5xaygGlNTLzWaP9+dYqOCM1lu07/6HU=; b=N8ZodEu6jElTPv3umW68WE8mmX
	odIRJNgbydyF5s/XbAPPttwyQtrM+IPKDyB5cGs4AGiKpBQNyb6h64Lft0M+vwotNDFa1zfVZmTkd
	mKfsWrEB+qcSa3N2BI1m6F9DMbVnfSTX4LwV3agj/wwysn7h394O3fZQYqEUTVr50RtDvkc6HN4Ce
	z0VOUmVBIH4zFsZG8AZVYO46GOhQVRO4/oMEOJn7fuDElZQYwYfKqop9xYMzj+92UyHb8jMbZ8ffv
	CI+6VOQl29M+wV+3r9HMk7puBf1bDLi4AWhvWQcWm8CMYuFr+7e9rWLPPF8eFaVxyjTLSOadmzz4P
	IRE700kg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc8Tx-00000008a8Z-17fM;
	Wed, 16 Jul 2025 20:12:01 +0000
Message-ID: <defde301-c594-4e35-a033-f9410a681b62@infradead.org>
Date: Wed, 16 Jul 2025 13:12:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cdx: Fix missing GENERIC_MSI_IRQ on compile test
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
References: <20250716064903.52397-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250716064903.52397-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/15/25 11:49 PM, Krzysztof Kozlowski wrote:
> CDX_BUS driver uses msi_setup_device_data() which is selected by
> GENERIC_MSI_IRQ, thus compile testing without the latter failed:
> 
>   /usr/bin/ld: drivers/cdx/cdx.o: in function `cdx_probe':
>   build/drivers/cdx/cdx.c:314: undefined reference to `msi_setup_device_data'
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/all/b2c54a12-480c-448a-8b90-333cb03d9c14@infradead.org/
> Fixes: 7f81907b7e3f ("cdx: Enable compile testing")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/cdx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
> index 1f1e360507d7..3af41f51cf38 100644
> --- a/drivers/cdx/Kconfig
> +++ b/drivers/cdx/Kconfig
> @@ -8,6 +8,7 @@
>  config CDX_BUS
>  	bool "CDX Bus driver"
>  	depends on OF && ARM64 || COMPILE_TEST
> +	select GENERIC_MSI_IRQ
>  	help
>  	  Driver to enable Composable DMA Transfer(CDX) Bus. CDX bus
>  	  exposes Fabric devices which uses composable DMA IP to the

-- 
~Randy


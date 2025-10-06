Return-Path: <linux-kernel+bounces-843544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 296D8BBFB28
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B67B44E19DD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE75A1F37D3;
	Mon,  6 Oct 2025 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K3GK5gjD"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6B5196C7C
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 22:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759790318; cv=none; b=gHSPL861Za/HvRz5TeG2oT7I3OZiummUDz+TRvFRd0/2tmGVrShIorv34hdfKiReWHEM/cXA8zZTdUm+rYjvjUrtwv5UfMdMQyrAOyIhCZLP0OoBOrtiu3bwztN+cDpsrpKrGwv+NQjarM86B3bMRwPElsuaHOYIbuBR7SfkI34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759790318; c=relaxed/simple;
	bh=XLlA+k9x7mm8GgqyzRlgaNvgq0Wf1m5JDE638oBb7mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+c6driaeHAPRMDYmPE/pbozfz6pS+vthGd9FBHBqrRHkGIy5x1p9ktCEAd4LrZnwlDJYqnsFli8xkNjuJqs/GTMQI/xY4LgaPj4MeNCYPfjqDoe0uIc+u903W1I9e1Ykn1wqyoFf/k9a/z2+9r+I3aRaZyjOuqaO88KLVLWI3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K3GK5gjD; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <21760ebf-99f8-4ea3-8841-e023e00ae574@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759790310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kOFih1hTDf2jYUgbN3HvZ18kSxomlomXmLCFXqJg8d4=;
	b=K3GK5gjDGx4ZJRh0lp7zOoB97hI8lH74FO15WAvIQ9Oz2QPqHxBjs16jyWnvb7uNwx0Wvc
	Q/KQQiPWNHzTsvkCb0NDH7fWCMtLGFZMzcNvu/zxnZ0qCrx3NVBzxdO39lh327DtG4OoaK
	DaqcNAcoNPT9p73/QxbwulUQA7OyvyE=
Date: Mon, 6 Oct 2025 18:38:27 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mtd: spi-nor: Enable locking for n25q00a
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 linux-mtd@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20251006223409.3475001-1-sean.anderson@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20251006223409.3475001-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/6/25 18:34, Sean Anderson wrote:
> The datasheet for n25q00a shows that the status register has the same
> layout as for n25q00, so use the same flags to enable locking support.
> These flags should have been added back in commit 150ccc181588 ("mtd:
> spi-nor: Enable locking for n25q128a11"), but they were removed by the

Sorry, this should be commit f80ff13135cb ("mtd: spi-nor: micron-st: Enable locking for n25q00")

https://lore.kernel.org/all/20200421063313.32655-1-js07.lee@samsung.com/

> maintainer...
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> Tested with a mt25qu01gbbb, which shares the same flash ID.
> 
>  drivers/mtd/spi-nor/micron-st.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index 187239ccd549..17c7d6322508 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -486,6 +486,8 @@ static const struct flash_info st_nor_parts[] = {
>  		.id = SNOR_ID(0x20, 0xbb, 0x21),
>  		.name = "n25q00a",
>  		.size = SZ_128M,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
> +			 SPI_NOR_BP3_SR_BIT6,
>  		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
>  		.mfr_flags = USE_FSR,
>  		.fixups = &n25q00_fixups,



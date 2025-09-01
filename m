Return-Path: <linux-kernel+bounces-795134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EDAB3ED39
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009231896893
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891CC320A04;
	Mon,  1 Sep 2025 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH5BhxLS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB562E6CB6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746795; cv=none; b=giNxQ2DD3gnFIxzmpWCrzJVeWb/jrfNJP2DtToF67QssvMxUYMPl3I3tfPET7eZ7LBWANJBPbHT1vINrPMNIQHMCYHpURw8X3xNR1ZSgvHOsgdZUyiXAkqj/LR0AjwqnQrzOQAGPY+YlZ9VmHaRP4ptxT6yBcShnk26G5cu22WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746795; c=relaxed/simple;
	bh=b3vKI8fFpk4ot7c3L2An3wZn2xJ1jPwGfNQAQJFKjUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iTaKrn2Rwxp0AvVk6Sjv99s84IxRPDwP7t6NhfYx1bFfEdUBXwz5AJnFkgjy0F4WVINnHPoNOg71RUnc9tU/JhjlxLHufc10gW3zdoONT9nHTafluLRETH8roIV0SPi5GLwDWIJE4xCW/yimxxuwJEmWSd+Rk5P1j7T5TpsPcpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH5BhxLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CC2C4CEF0;
	Mon,  1 Sep 2025 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756746795;
	bh=b3vKI8fFpk4ot7c3L2An3wZn2xJ1jPwGfNQAQJFKjUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VH5BhxLSvCeDnQIDJA/+lgFpzLOxgPlOehPOAmn9iNcFOT2N+BnIay5THpb/avmdA
	 yxSe5uXrH65Yczllm2KpPJ6Ox3P+G4y6sntuQBCdLyoNt/AbhfYzw1p6TF8RfqlMVE
	 unQPpp2g8raUacjHZHtkaqjW3vWVo1pNtgb4eUqb6kW/1G5JLSRPIWGoFYLoHm5L74
	 wMeCoYv+6H7XRm0lvAmLaR+CknreZUoeI1sFNUK+j8EfaXjMeI82qc44N5khYr9luX
	 0mL9b5l859W4ZnXwiEWwwEkDEiA2+Rp/QTR72s2fWIDv7z4qU+QBqjhusziE12+kzm
	 y2wXBdrr0T1Yw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Miquel Raynal
 <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: issi: Add support for is25wx01g
In-Reply-To: <20250901164218.11165-1-flaviu.nistor@gmail.com>
References: <20250901164218.11165-1-flaviu.nistor@gmail.com>
Date: Mon, 01 Sep 2025 19:13:12 +0200
Message-ID: <mafs0cy8aw0yf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Flaviu,

On Mon, Sep 01 2025, Flaviu Nistor wrote:

> Add support for the IS25WX01G 128MB (1Gb) ISSI Serial Flash Memory.
>
> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
> ---
>  drivers/mtd/spi-nor/issi.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
> index 18d9a00aa22e..e4997f9bd557 100644
> --- a/drivers/mtd/spi-nor/issi.c
> +++ b/drivers/mtd/spi-nor/issi.c
> @@ -126,6 +126,9 @@ static const struct flash_info issi_nor_parts[] = {
>  		.flags = SPI_NOR_QUAD_PP,
>  		.fixups = &is25lp256_fixups,
>  		.fixup_flags = SPI_NOR_4B_OPCODES,
> +	}, {
> +		/* IS25WX01G */
> +		.id = SNOR_ID(0x9d, 0x5b, 0x1b),

It seems the flash needs no special configuration. IIUC it can be driven
entirely based on SFDP data. In that case, I don't think there is a need
for an entry at all. The generic SFDP-based driver should already be
enough for your flash. Just add a "jedec,spi-nor" node to your DT and it
should work.

>  	}
>  };

-- 
Regards,
Pratyush Yadav


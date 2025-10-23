Return-Path: <linux-kernel+bounces-866394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB22FBFF9DC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3809235AC3E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CAE2D1F7E;
	Thu, 23 Oct 2025 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A5L0/6Mb"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCDE186E58
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204629; cv=none; b=mDZW43naJWpmkoUox8T36Zen6Yvudv+uRftnAkKCs8qrAG+AMhhnbKHL+ey4IXbqUVsi6wPN5++4ihq6uhLCTk40cv2wHjQOfuamH1jYEWqW7s0MqWgHrQPXXwxgUUqnNIlUif3CNqTHi1pOeroVCx5gqCgq9bh6sJveHYQbGhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204629; c=relaxed/simple;
	bh=F+Wm5uqQXLHzFrk1So+9Xz8MFgAla+tQ6p0qrW/l+qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1WHGY8GPH5TP+fBIm2fFYi81BnHqHBPZwBo5gHEX4xdA5M8FewKo6W1PrS++ORbu7NZc3m7eYJLFZzOwgse/z87srfzrNzA6wp3rtko2TK6zeyhe0S0xVUaEWjH8ypFGU+ZYxfZxbxos1dnwX7R4W9w5/KkVkuYElVR0jZtbJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A5L0/6Mb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-471075c0a18so4760595e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761204625; x=1761809425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xU2+l2oWXaSdZaV2lCEesAap59k6WqOAEa+s1mYsl4k=;
        b=A5L0/6Mbf/uWiuSbWyQM0uENXuJRt4UeSEoVuC7YgwZUe0Gn5do2XL974Q2Xbwu0pl
         emsHoJHDC03wDUbLJ8yXVdaCMPsikmAJEbZsidydxru029RfXREMZweYeUlP80LnBhgd
         em7/I+XPFEsSB/t49ClvVRRoFTf/M41ZGXzot3n4BRy1Z5gnhuSC9DTxE57cM7f4jGLj
         sipveG9Vi8mSjSuQ7wDlKYc+Q+Zw55oG26U+hBxMg5//2RgA0DiUKKs7c23m+LlcTBX9
         RMzmVOgBjiiz0ZDv5cO5wyLGtFj6WsQ7BLWYDyby+li82bGwJWhqZ/mYkZHAHB/O6V+3
         HWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761204625; x=1761809425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xU2+l2oWXaSdZaV2lCEesAap59k6WqOAEa+s1mYsl4k=;
        b=v6FVwFytponNUkRDcxv9e6M3vbU2jACbb8JRUU6Ak8UKW36X91MOBoVykp7pedjhFp
         8m/gtKUmEhTcl+QF+W/dLtiq98V/bRkJLLXvt+lW66KqmcU7Vdpx9mV45TP2TiIWp8Ss
         /n5B5IOgW0U8C3extdT+ZqkCh8t/fbTxzz/WzhZgBDHNVqW4GH7QCnqf9guIj8TPpbEk
         z2ShCDjJVqFokqeEWOksu00WpTS8pABNL1CTkddIO+vHNeADd7hfheUxyCBxbzyiu/Rp
         AydrrccqCszThY4cKsRW/zadYAW9xgU8QXW+lPYxboeNfCHeJi7KQsn+RJbd+R6TAaxG
         12mw==
X-Forwarded-Encrypted: i=1; AJvYcCVNmK9Khl8zzoYd3t6NPZlX+0yqBp1TerAXSmBtddgM8rcovVqgV3xgv4CrNhKN1T/7vuQB/BcP21OzgEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2MjdP8tD8GZBQBDkki393Hl70CkKJwk1kayZVZoVCROo3/rqT
	GxkmPt8OqCh/ZJzs7+K/lb+c+qIgMHdhGQY3s5QBjKcNHVTHGY+RotPsGgQa1+NfWhU=
X-Gm-Gg: ASbGncsN/Pw1JZ15Q0Myi6SFprfd+bA7M77avkt6X+fo08NoXJX4DtSeok1C9FrILnd
	+NwqruxylrrrYG8tvuBeYI7Yrw3La5JKtS0ojRdvDlZhtXtL7yF0LH97jBnkIQwHI1Ha4Q4oE1D
	m7M4XO+MDGVsxzqiR1LrsE26wCtwWFEiw7Q2p6iRG6AQGdHLHZZOJxKGVfGzrX/wheQEZbtmNSW
	Pk3dObvCEHJIm3ehwdH+ljGi+m4KYTdgOMu6bSFUqCIht7owfjxUkxDKSZ1g63rPYVHy2uhZnqO
	l18lcxkrC/vsgxIwvLDoFkurLuLVOZ4lSUAthi7z8kZSDYKLKtRRsaeBoFw93+4XS5u0sEEH8LD
	NSlGCGGb76CAmWjjKMt713PHCmrWUD6Poi5yY55RBDlotFEJ7Bf+A405gWXgcBXJwXogTmBe/4Q
	tZGk7bBWuG
X-Google-Smtp-Source: AGHT+IGdW6Zt/VmLDLhC0rSwjvMj4I4YzehzmiCpNFLtAN8Xf4TUyFOcY+/2y6jYWq6rNVFlPM38Xw==
X-Received: by 2002:a05:600c:820b:b0:471:1717:40a with SMTP id 5b1f17b1804b1-471178a8245mr165146145e9.18.1761204625412;
        Thu, 23 Oct 2025 00:30:25 -0700 (PDT)
Received: from [10.11.12.107] ([79.115.63.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b33sm80778205e9.14.2025.10.23.00.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 00:30:24 -0700 (PDT)
Message-ID: <b5f36114-f5d2-44c4-8902-f7d7e68b29d4@linaro.org>
Date: Thu, 23 Oct 2025 08:30:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mtd: spi-nor: sfdp: introduce smpt_map_id fixup hook
To: Takahiro Kuwano <tkuw584924@gmail.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <20251022-s25fs-s-smpt-fixup-v1-0-ce26d4084b2d@infineon.com>
 <20251022-s25fs-s-smpt-fixup-v1-2-ce26d4084b2d@infineon.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251022-s25fs-s-smpt-fixup-v1-2-ce26d4084b2d@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/22/25 11:07 AM, Takahiro Kuwano wrote:
> Some chips have inconsistency in SMPT that derives wrong map ID and
> fails to detect correct sector map. Introduce smpt_map_id() into
> struct spi_nor_fixups. That is called after map ID detection by SMPT
> and chip specific implementation can correct map ID.

You may reword the commit message a bit:
Certain chips have inconsistent Serial Mapping Parameter Table (SMPT)
data, which leads to the wrong map ID being identified, causing failures
to detect the correct sector map.

To fix this, introduce smpt_map_id() into the struct spi_nor_fixups.
This function will be called after the initial SMPT-based detection,
allowing chip-specific logic to correct the map ID.

And maybe give an example which flash needs it.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>> 
> Co-developed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---
>  drivers/mtd/spi-nor/core.h |  3 +++
>  drivers/mtd/spi-nor/sfdp.c | 12 ++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 5ad46d95d09cc9d527f71579a71eed210e726f68..16b382d4f04f207aa26190ed8bdf2d19885f7315 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -411,6 +411,8 @@ struct spi_nor_flash_parameter {
>   * @post_bfpt: called after the BFPT table has been parsed
>   * @smpt_read_dummy: called during SMPT table is being parsed. Used to fix the
>   *                   number of dummy cycles in read register ops.
> + * @smpt_map_id: called after map ID in SMPT table has been determined for the
> + *               case the map ID is wrong and needs to be fixed.
>   * @post_sfdp: called after SFDP has been parsed (is also called for SPI NORs
>   *             that do not support RDSFDP). Typically used to tweak various
>   *             parameters that could not be extracted by other means (i.e.
> @@ -429,6 +431,7 @@ struct spi_nor_fixups {
>  			 const struct sfdp_parameter_header *bfpt_header,
>  			 const struct sfdp_bfpt *bfpt);
>  	void (*smpt_read_dummy)(const struct spi_nor *nor, u8 *read_dummy);
> +	void (*smpt_map_id)(const struct spi_nor *nor, u8 *map_id);
>  	int (*post_sfdp)(struct spi_nor *nor);
>  	int (*late_init)(struct spi_nor *nor);
>  };
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index 9a47dcaca06ae2ad85ac8503658083b1d56d8b96..a8324c2da0acf2953a4a62e2a9f7ed31fcd8b4f2 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -730,6 +730,16 @@ static u8 spi_nor_smpt_read_dummy(const struct spi_nor *nor, const u32 settings)
>  	return read_dummy;
>  }
>  
> +static void spi_nor_smpt_map_id_fixups(const struct spi_nor *nor, u8 *map_id)
> +{
> +	if (nor->manufacturer && nor->manufacturer->fixups &&
> +	    nor->manufacturer->fixups->smpt_map_id)
> +		nor->manufacturer->fixups->smpt_map_id(nor, map_id);
> +
> +	if (nor->info->fixups && nor->info->fixups->smpt_map_id)
> +		nor->info->fixups->smpt_map_id(nor, map_id);
> +}
> +
>  /**
>   * spi_nor_get_map_in_use() - get the configuration map in use
>   * @nor:	pointer to a 'struct spi_nor'
> @@ -783,6 +793,8 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt,
>  		map_id = map_id << 1 | !!(*buf & read_data_mask);
>  	}
>  
> +	spi_nor_smpt_map_id_fixups(nor, &map_id);
> +
>  	/*
>  	 * If command descriptors are provided, they always precede map
>  	 * descriptors in the table. There is no need to start the iteration
> 



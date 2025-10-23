Return-Path: <linux-kernel+bounces-866385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58102BFFA3E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFE10566863
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3442DEA6F;
	Thu, 23 Oct 2025 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmF6Bm9c"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EBC2BE7BB
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204347; cv=none; b=iUpylcn1q1vi61mza3naPLYL2Tz5E2O4J6qx9PKbeVqIArlWYZH2GuLKQ1GQmcabzxhAy4xb1qo3rgbdhEwjbm+vUB9UFpifHf4GsS1bC7ZyuFot6pEjR5jxEMg961JJV1YVcLRIWTEf46L8mVmh+5oXuQ/4Z9qtdAJdrBT6VMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204347; c=relaxed/simple;
	bh=Fzd1/33bhqG2vNUwxnZ9ga9aIr6yWlevkViCOkqrbyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlnmwjMrNgaEeQrF6yP6WVNjofqEAHr1hnSP72IZXPAGzSWBdYhxgTINV8yLSrgsb/hEIqI9Csc7WN0pC7bD+M4BJdmbPXSSgWWxr3w0DJy45lvV6kSwL1OU2ED22LYg2/ZxgXx/byefDnOWWm+e8bM6xQYPtg0dF+fD+dCdA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kmF6Bm9c; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47117e75258so3177555e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761204344; x=1761809144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSw39SqLym77Kz0EfuXzuM8L9Cr8WdrcJwSU8kcy73A=;
        b=kmF6Bm9cmhMcldduHVo7S8koPJra4X3GjfeUI1KXUBojiUSmC6QGnKMuJhstYVGmsW
         2HPY4d/lKzOzdZ+Nq+ksR+8Xyylt896qt35OhrbSNhyPx3u14hv0cbOcejQDPb1UqD0/
         5tR+pDIvBK5StfZ3jil9ZlFFtBfYKPj/hUMRKs2zEVNlTZTv9Yh36y0wkP2t7Dnrbm++
         4a9DQ9EGgg0f9oCL299SpiwHmm8le/WJTwpF3eWb10mBPvqYudxcXegUTzCSAEfcSLmf
         5huF+e19DLVyOBO2My6cmm+N2d8aORVw2gSVxA37yw/hZiNPLD48G/vS//7s//M02sqb
         W6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761204344; x=1761809144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSw39SqLym77Kz0EfuXzuM8L9Cr8WdrcJwSU8kcy73A=;
        b=H74jLd1mAS5QhXZOTsyyhdhh/g6/nc6FSeNhRSnHAZAmaJaQobhf0UuvAM6tW1xNeY
         9cjvGJDpAFh5PoR86orOxYmqRIR3k2zdARe2R5EVHzeo/rHKkUri3hNpwAsM/xXbjSHO
         +0Xz111BJ1b8Z+hx7bv5fhxHbfV2gXZBNPmc78TNp5l9XD+t7VuW47CPMdV0ZY0PGmrV
         lRpz7Yu4Nzrs3SS95WGbSGmoK/ecJuXkbOcaKwz7g2tt5szrbOuMmyJ6PQJhOlrvyWaS
         uIhyTCrgNAt+mq8LjDH0BwKfMylKsfiwh4pJsRdnjS9zwSRAH3NtXjArvE4aoUhbHfbq
         F2bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZkBvs43yRGq5Z7FIkj0z3J1Gg1WenupxOJ0RmuquPOFQFsA9jN5+crbj+upHAFLY8ZU5hCJFpQmXAvxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4RPo23lYUz1mTUOZG1scZBNzheZ6DZuEF1C9BXuui/pCIP3W4
	VN3NSrfx+hMqF5MyGiT6sqbxlofsksGsdJ1PF3MzNGFZVU+pWzAjgTlKcvhz+EcBS1E=
X-Gm-Gg: ASbGnctS2mW6aiwe+MNWLY8JxGiziJqar1JCYMnmuvPuD8Kin1kj3R+huWE+CFZ5OyN
	RoNpaXwppL7XpKYVHMMfA4JAV5zN9o0SlIHeVAwCPkYoNLX6Of0G0l24nDvHFHXLGUcednaVlHD
	QNX565iFcqVJvhLbStj3IAv3hfvCj61+BTciEsA2zoGuizYiLvyqtg4ZQoxidmVKLIgr1gCK+jE
	MSHMHzZYRaedsXycqiGZxevMDuvr11eWRh7kh390rcLHC6n7xgVLvhvA4Z8NE+w8LAVIC0qv5cX
	ttHiARjuhPVChc8Vc6TiIqXX5/P1QFIK+hyqy24zNe/oYHgm8LIpxjVpbzXG/nm8VZoc8Z0EpAD
	gCQKyfbBOO4yG6ubeD9/HEbkkQqOMrMUFj6MsNRGId9jdOjDod9hIwg7oWHt19U1OnNIM+wpwl8
	iJYZoarUkO
X-Google-Smtp-Source: AGHT+IF9nR8Ok+zwbm9/f5vQvS2ChRoQgsa3Zb3XVq4vKe0l+/WhD27/DmLD8deyWjml5hAHlzgCiw==
X-Received: by 2002:a05:600c:4686:b0:46f:b340:75e7 with SMTP id 5b1f17b1804b1-475caf92ae1mr9003785e9.8.1761204343558;
        Thu, 23 Oct 2025 00:25:43 -0700 (PDT)
Received: from [10.11.12.107] ([79.115.63.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b5esm94386495e9.15.2025.10.23.00.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 00:25:42 -0700 (PDT)
Message-ID: <59c3d45b-13ff-4393-a87c-f0504f224acb@linaro.org>
Date: Thu, 23 Oct 2025 08:25:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mtd: spi-nor: sfdp: introduce smpt_read_dummy fixup
 hook
To: Takahiro Kuwano <tkuw584924@gmail.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <20251022-s25fs-s-smpt-fixup-v1-0-ce26d4084b2d@infineon.com>
 <20251022-s25fs-s-smpt-fixup-v1-1-ce26d4084b2d@infineon.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251022-s25fs-s-smpt-fixup-v1-1-ce26d4084b2d@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Takahiro,

On 10/22/25 11:07 AM, Takahiro Kuwano wrote:
> SMPT contains config detection info that descibes opcode, address, and

typo: describes> dummy cycles to read sector map config. The dummy cycles parameter can
> be 'variable' and should be determined in device specific fixup hook.

This doesn't describe why we need the hook. I'd advise to describe what
value has nor->read_dummy before the fixup hook (zero you said), why the
zero value does always fit some flashes like the IFX one, which for that
particular read reg command it always needs 8 dummy cycles. This also
reveals that the SMPT table on that flash instead of defining
SMPT_CMD_READ_DUMMY_IS_VARIABLE is should have actually used the number of
needed dummy cycles: 8.

Please adapt and add something around these lines, otherwise in 5 years
from now we'll forget what was this about.

The patch looks okay to me.
Cheers,
ta

> 
> Inroduce smpt_read_dummy() in struct spi_nor_fixups. It is called when
> the dummy cycle field in SMPT config detection is 'varialble'.
> 
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---
>  drivers/mtd/spi-nor/core.h |  3 +++
>  drivers/mtd/spi-nor/sfdp.c | 18 ++++++++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index ceff412f7d65ab7b856795ca5c092cddbf598cd6..5ad46d95d09cc9d527f71579a71eed210e726f68 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -409,6 +409,8 @@ struct spi_nor_flash_parameter {
>   *                flash parameters when information provided by the flash_info
>   *                table is incomplete or wrong.
>   * @post_bfpt: called after the BFPT table has been parsed
> + * @smpt_read_dummy: called during SMPT table is being parsed. Used to fix the
> + *                   number of dummy cycles in read register ops.
>   * @post_sfdp: called after SFDP has been parsed (is also called for SPI NORs
>   *             that do not support RDSFDP). Typically used to tweak various
>   *             parameters that could not be extracted by other means (i.e.
> @@ -426,6 +428,7 @@ struct spi_nor_fixups {
>  	int (*post_bfpt)(struct spi_nor *nor,
>  			 const struct sfdp_parameter_header *bfpt_header,
>  			 const struct sfdp_bfpt *bfpt);
> +	void (*smpt_read_dummy)(const struct spi_nor *nor, u8 *read_dummy);
>  	int (*post_sfdp)(struct spi_nor *nor);
>  	int (*late_init)(struct spi_nor *nor);
>  };
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index 21727f9a4ac6926080a116e30830c9533122fdad..9a47dcaca06ae2ad85ac8503658083b1d56d8b96 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -699,6 +699,17 @@ static u8 spi_nor_smpt_addr_nbytes(const struct spi_nor *nor, const u32 settings
>  	}
>  }
>  
> +static void spi_nor_smpt_read_dummy_fixups(const struct spi_nor *nor,
> +					   u8 *read_dummy)
> +{
> +	if (nor->manufacturer && nor->manufacturer->fixups &&
> +	    nor->manufacturer->fixups->smpt_read_dummy)
> +		nor->manufacturer->fixups->smpt_read_dummy(nor, read_dummy);
> +
> +	if (nor->info->fixups && nor->info->fixups->smpt_read_dummy)
> +		nor->info->fixups->smpt_read_dummy(nor, read_dummy);
> +}
> +
>  /**
>   * spi_nor_smpt_read_dummy() - return the configuration detection command read
>   *			       latency, in clock cycles.
> @@ -711,8 +722,11 @@ static u8 spi_nor_smpt_read_dummy(const struct spi_nor *nor, const u32 settings)
>  {
>  	u8 read_dummy = SMPT_CMD_READ_DUMMY(settings);
>  
> -	if (read_dummy == SMPT_CMD_READ_DUMMY_IS_VARIABLE)
> -		return nor->read_dummy;
> +	if (read_dummy == SMPT_CMD_READ_DUMMY_IS_VARIABLE) {
> +		read_dummy = nor->read_dummy;
> +		spi_nor_smpt_read_dummy_fixups(nor, &read_dummy);
> +	}
> +
>  	return read_dummy;
>  }
>  
> 


Return-Path: <linux-kernel+bounces-892449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C1FC451E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2F93A25BD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A3E218AB0;
	Mon, 10 Nov 2025 06:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RP50pboa"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C74634D38B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757165; cv=none; b=YrtGCEHa0o87DRxaCWtPLIdeFx3UklKdy2WUBr4ru5Nm6aipUQnoMb69MtlaP/F8HgwiH6I8Gpn6CHxT1BfBeLBSM1LIo1cUN6FdWxZW2Y0eAbbxrujm+0K60DmdNAddE6MxEWULCMtv+V2sJE+8xcx4bnXB5Y3zZYAw447WW8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757165; c=relaxed/simple;
	bh=lYwuLN473OxBWExBwnMZ8BirNa7UvPGxy7Z7qn7dsis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzLivBi1PzY26DEDnObUsvm9t0GXsb/6BuRnIudW8S16cSDeQmo0QkVlE/UYxpm2PzGIcoIWEPtjeVrDJfv++IlZMA5pmURVi1wYryuBBtsOBBJvOssb9jSLacAqOCAAQ4wGqU1o2zGIyqnes8GSkmjU4/bzlOLPqxS5imlNbPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RP50pboa; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b32a5494dso462593f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 22:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762757161; x=1763361961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pu1XhH2ZxG6Wd4en1D4CkiVWQG6H8ikgU7y2tqQz8Z4=;
        b=RP50pboavOa7gYiiCs8yZ5LGgannydWkIg/SBu/V1ji45Q5VwUjGcOPMGW6rTVRQ6M
         pQwRK6sXt9l3TqKF4CfSb0IjzqIoVbZUEMoEMtjYwuSUSS0nWgaGbTvUpBj7cf0gX0yW
         ve71mFcC6bMZp90A37bKECZJZcN4TOkOau4CY9OP9PzfAyzFnjkW4VHRjPkeuir7wHGc
         v3/rZYjgMVtzA+dplJNV7vm3aY6jvBXSYMBjCgpjNb7wws4gyRNMguXwqEDGDToWQLnT
         XpFny93LPwDCMJjc/ggN8d4dJh0AzgXbRae3ikRswQcRhBEneOCbV4MBEPthkQuNxkiH
         rPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762757161; x=1763361961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pu1XhH2ZxG6Wd4en1D4CkiVWQG6H8ikgU7y2tqQz8Z4=;
        b=GU1gNyO6yyHPmfX/xbb3/vtu3hGFaJXtYVnzW34/A/ClsGnYOA70VvbxdXS5sCmRn/
         EgTrZAY/UE9MzDqEYXUep6GkFwjKIqFpBLUL75gXceGWFhgyngg+GcPm/On46g8RywaZ
         SkN6tbNGNrc2yt4byCqfmwV5E0C+VcgvOzaU4SmgN22os6k7EmksKFo0m1fjdNQglyoU
         b7Lr4YDy3XQQ4nvJ75CWf85RoFWHtwuSldC6/Egmc5YqKhhgViBnyyP6qsyqCTAcAeCK
         dqoPttI8hUpAvIhPmN17MNyKuaK1a0ZPPj1fPKm4g0Xf+PQAhY4rSixMUr4LuO2/p0LX
         ueOg==
X-Forwarded-Encrypted: i=1; AJvYcCVo0SpclKhWE3eyXQGKqaGkJgh8ZQU9M3nH7rHKzQlImMQ9t2yJskvh0ImEppOO42pxYTTU4BTY0vXtLnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm3YYdH27yFtLOzKqvoBHPDLo1ixxKwWIlgQ8d4nwvjuz50EZB
	dKkt9ERCG1aKjwnXn0w76xaprsmKH3mlU+PyYonk/tKyJvX/o71DF8FhCmIqAi2TkHQ=
X-Gm-Gg: ASbGncuWGtSdU0Kyy9CJnCOwqj5fP5KA60iUdZk93/R7SmAm9FvnWcQr7ydOBWNHRPG
	57JeKVUvUOjBOys84frkdew7aNTcBeqBYgGHRCvg055EQUR1luuyKOy9Kaj7ymboSEeKC9KANpy
	RpRox2rAObhRbGt9yMsS4ynUNl7gWFmXOY34+5FDlzN0lVErbMDk4cvaXhSCvnxfHLM3eUbnOe4
	fymc4ibQCubJVHiDpiYcE43O/c+8i3TQJi5c56CE3EjwXZkggaE+0icJ+Ag+akAM8/Ssj0IumqL
	+vvdCS1/Ogj9i3ckvyedxp+8FXAT73ubeR7YPzCGs2utorYC2NgPEb75o8ElOl2ajJ5uKfG/YUM
	ZLcP2c8PKdDa8gBvJX5+U93c7QQZcFr8fqasboNQZ1EQIMlPl+s/rYBaV+e2JJCNnoOYLIPv5ae
	7CKeh8jKg75Niw4Vkx
X-Google-Smtp-Source: AGHT+IH7hyQPKhcZy8yzJus1HIGOBdpu+NzRSyrvlskw5IUKjuHbd1YMpjBQn0eJHTMLn2IbItWT0w==
X-Received: by 2002:a05:6000:1847:b0:429:cf88:f7ac with SMTP id ffacd0b85a97d-42b2dca2e52mr5114061f8f.44.1762757161534;
        Sun, 09 Nov 2025 22:46:01 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2dd927d5sm13577288f8f.24.2025.11.09.22.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 22:46:01 -0800 (PST)
Message-ID: <7d8b0062-a6ec-43a9-ab00-3e11f0e2fb26@linaro.org>
Date: Mon, 10 Nov 2025 08:45:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mtd: spi-nor: micron-st: enable 8D-8D-8D mode and die
 erase for mt35xu02gcba
To: Haibo Chen <haibo.chen@nxp.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
References: <20251110-nor-v1-0-cde50c81db05@nxp.com>
 <20251110-nor-v1-4-cde50c81db05@nxp.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251110-nor-v1-4-cde50c81db05@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/10/25 6:02 AM, Haibo Chen wrote:
> mt35xu02gcba is similar with mt35xu01gbba and mt35xu512aba, but with
> four dies inside. And it also support 8D-8D-8D mode, but SFDP lack
> SNOR_F_IO_MODE_EN_VOLATILE, so add this fixup flags here.
> 
> Link: https://datasheet.octopart.com/MT35XU02GCBA1G12-0AAT-Micron-datasheet-138896808.pdf
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---

please dump the SFDP data for every flash that you touch, it helps
us with the sfdp database

>  drivers/mtd/spi-nor/micron-st.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index f724313f4dd3720908968c670e8d3d58f41c099c..b36174436b7aa0f7768dbe48e4ad4927c08a3d6d 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -214,6 +214,12 @@ static const struct spi_nor_fixups mt35xu01gbba_fixups = {
>  	.late_init = micron_st_nor_two_die_late_init,
>  };
>  
> +static const struct spi_nor_fixups mt35xu02gcba_fixups = {
> +	.default_init = mt35xu512aba_default_init,
> +	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
> +	.late_init = micron_st_nor_four_die_late_init,
> +};
> +
>  static const struct flash_info micron_nor_parts[] = {
>  	{
>  		.id = SNOR_ID(0x2c, 0x5b, 0x1a),
> @@ -237,12 +243,13 @@ static const struct flash_info micron_nor_parts[] = {
>  		.fixups = &mt35xu01gbba_fixups,
>  	}, {
>  		.id = SNOR_ID(0x2c, 0x5b, 0x1c),
> -		.name = "mt35xu02g",
> +		.name = "mt35xu02gcba",

we don't care about the name, drop the name and add it as a comment.

>  		.sector_size = SZ_128K,
>  		.size = SZ_256M,
>  		.no_sfdp_flags = SECT_4K | SPI_NOR_OCTAL_READ,
>  		.mfr_flags = USE_FSR,
> -		.fixup_flags = SPI_NOR_4B_OPCODES,
> +		.fixup_flags = SPI_NOR_4B_OPCODES | SPI_NOR_IO_MODE_EN_VOLATILE,

Whenever you can, remove the non-sfdp static data and rely on the SFDP
driver to handle it. Can you please drop sector_size, no_sfdp_flags and
SPI_NOR_4B_OPCODES?

Then do the testing and sysfs/debugfs dumps to prove the flash works okay.
Thanks!
ta> +		.fixups = &mt35xu02gcba_fixups,
>  	},
>  };
>  
> 



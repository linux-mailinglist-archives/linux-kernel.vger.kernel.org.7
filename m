Return-Path: <linux-kernel+bounces-892442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CC0C451B9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5EFA4E7D08
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1B12E92B4;
	Mon, 10 Nov 2025 06:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePRcT3vf"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF82E8B95
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762756723; cv=none; b=ZgA11EJFEhKcWqnJrX1gbK2u0+r8yR70DW733wJmudO6GUPNgT/SOWqNjK9ACaLThxRakLeby3xfGslFfhmoyP8P5d0Z9A6uPOenHpAB5DKHDAQsqP72m1B0Pi77E1ostEnNNeLLQTvN5NkwXRm213dGSi0LYvgie669KihHseI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762756723; c=relaxed/simple;
	bh=GS5S/kAL5cB0dyezw9Y2bdHtxdBpYhgJJzuBS8KofsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8NS4x6e/7Dl3E6ygGQ4lBDC19e3UMG7yX4UPutOROgvE62iNoH6KW8rx14Sv8YG0J/jctYEbffGIIj20bcSUxo9TkMv8yHmKYZ6wvDDYV6PdAjDBru+RLISXiABaqdJbxRPzNahDYlqkPHaE+Urwi10MVbGYHccRrM3LDkzksA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ePRcT3vf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso20126095e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 22:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762756720; x=1763361520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7kSQR2mHljVM9pPmspMiUraHJjkPCCeKTaNFeu9c9xc=;
        b=ePRcT3vf4E4fMrTbGe3pLH2BI5yhJi0W39PxZwwc/PJZCIbsHgkVYVQcJDvUAx+YP/
         yF4NNhjUU24pomxpVgN4IeJuSOxpRYg1PJTn19POZN2wdw+ATxlZeTWCXoaPZiYyulGQ
         WGBOrF8Pf5asQgsTM9fnp9OnmDOzhn+7bk9nCqkYKsHzzEdWcvzTufMsYQ4wWsUZyU+A
         pSykHuMCbRITFegkCAWms7BS9QredTLjkcBoI8oVbacmz1zNixe+0ycwdENhD3sv4LeI
         vsFEcPDdr8w3DXpEmc5atjZekOrdNlTpAbl66v1Ri6w+l1xyfKHJdHjglg1CR3DpMLcz
         zA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762756720; x=1763361520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kSQR2mHljVM9pPmspMiUraHJjkPCCeKTaNFeu9c9xc=;
        b=PHFui8oCRnIg+37UvkSXw6Jqo32mj9Orkwes2oRGwfDGRvvrlVc5CfvH7ReegQYlts
         I2OdZbZ8/sjmIYEP7gvyisAWEKwqnMGGRsKvoSvzTQZHwJi3FlCrPnH/rHxgRajHaEe/
         wA76QV+YKsEKWWrregcPVps/jDdO40hIzFqyZhoZXa6MpYMYfp7Z0oOy8ioLJAxWZOrf
         BEfz25b24bavV7NousAmBnras0IfrQCYQEaeS1hBtsRaoAW3ls9S8TpTUC1ax/qeneoa
         apybczM3TbNCzSkq5ntD4nRWtPP7Kll5WJQt610WjGL6/3gipGs23NhHGnd3NKFa5NOo
         jGOg==
X-Forwarded-Encrypted: i=1; AJvYcCUJAPR5Ch1wCC4XNmzdQldfA/YjZRS1SHGAQz3db1otzd2hgAbqek4azVaohbDSXksInXhxQgGTv2d5qoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSOBJooCZIj3AUQANc29WsB/sYJxFUiuq4P1WVbVBUSqiH79hz
	6vs7MX1f3g4Xr3BdwwroRwyTNwUm38z2Adtj7+HQk5veJs4ynDIuiJHVNHxKoF+TV/I=
X-Gm-Gg: ASbGncu8vQmBfmWQ/n6sC8OM/UTV+N06rKE9qv4TpypACRJoIY5GKrU2cJiwgyqjj0Q
	a9jq4iuSgskUw7Yl42hy3p6b2pKjIer3efXUhwVqfWvE7wd9lMoHto4nHfPeWwms2oTYaTtugmM
	dWR/aDbZ+07ESEnLQUUsARx9zmI4Fmo3unqKvPSBvciAWCr8ULUVxwFt2IMArDYHPsWogSfVWSV
	izYAJSVxee3f9Nr0ejtHx+8wAkbDukz4IqkkcbMGzEEcgxaPy3TBlNE71A/TyrlX/YeW6lh6Nsz
	d47vH8zFmXbP/JKxURZWTPVyb63pwqh+2MiPs5/wLyzdSa8OoCdcpVHrH8MFi4i0h0Atu6+dkDr
	dqbL28Hy5NrtrAfuwHkykpKOZtUWKdsmQbirf7+6VccmjO7ZCsqvRjrvvDM/p1kn1ZHRvSAWevd
	Ws9KiqlKBcXERbUCQ2
X-Google-Smtp-Source: AGHT+IFMcnA9pYYlnbLP/XD39suwrsBDerGX9hKDXL4+G1Ps4KoXb3zZoLCORFMf9T8PgOyp+I/FKQ==
X-Received: by 2002:a05:6000:3107:b0:427:914:7468 with SMTP id ffacd0b85a97d-42b2dc1e528mr6060266f8f.15.1762756719387;
        Sun, 09 Nov 2025 22:38:39 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67920fcsm20181653f8f.39.2025.11.09.22.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 22:38:38 -0800 (PST)
Message-ID: <4479a34b-58b3-45aa-9d2e-5e2a64f61e9d@linaro.org>
Date: Mon, 10 Nov 2025 08:38:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mtd: spi-nor: micron-st: add die erase for
 mt35xu512aba
To: Haibo Chen <haibo.chen@nxp.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
References: <20251110-nor-v1-0-cde50c81db05@nxp.com>
 <20251110-nor-v1-2-cde50c81db05@nxp.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251110-nor-v1-2-cde50c81db05@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/10/25 6:02 AM, Haibo Chen wrote:
> mt35xu512aba do not support chip erase command, and it contains one
> die, and only support die erase.

does this need a fixes tag then? With that:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>> 
> Unfortunately the die erase opcode does not have a 4-byte opcode,
> here forced to enter in the 4 byte address mode in order to benefit
> of the die erase.
> 
> Link: https://datasheet.octopart.com/MT35XU02GCBA1G12-0AAT-Micron-datasheet-138896808.pdf
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---

Also, would you please help us with SFDP dumps, as you did in the next patches?
It helps ups keep a database and update flashes to get rid of the non SFDP data.

Thanks!

>  drivers/mtd/spi-nor/micron-st.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index 92eb14ca76c57f29ece1edb3fe652c56d1c2888f..89cd146095584ddebdd258a186f6398b420e5800 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -159,6 +159,22 @@ static int micron_st_nor_two_die_late_init(struct spi_nor *nor)
>  	return spi_nor_set_4byte_addr_mode(nor, true);
>  }
>  
> +static int micron_st_nor_one_die_late_init(struct spi_nor *nor)
> +{
> +	struct spi_nor_flash_parameter *params = nor->params;
> +
> +	params->die_erase_opcode = SPINOR_OP_MT_DIE_ERASE;
> +	params->n_dice = 1;
> +
> +	/*
> +	 * Unfortunately the die erase opcode does not have a 4-byte opcode
> +	 * correspondent for these flashes. The SFDP 4BAIT table fails to
> +	 * consider the die erase too. We're forced to enter in the 4 byte
> +	 * address mode in order to benefit of the die erase.
> +	 */
> +	return spi_nor_set_4byte_addr_mode(nor, true);
> +}
> +
>  static void mt35xu512aba_default_init(struct spi_nor *nor)
>  {
>  	nor->params->set_octal_dtr = micron_st_nor_set_octal_dtr;
> @@ -189,6 +205,7 @@ static int mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
>  static const struct spi_nor_fixups mt35xu512aba_fixups = {
>  	.default_init = mt35xu512aba_default_init,
>  	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
> +	.late_init = micron_st_nor_one_die_late_init,
>  };
>  
>  static const struct flash_info micron_nor_parts[] = {
> 



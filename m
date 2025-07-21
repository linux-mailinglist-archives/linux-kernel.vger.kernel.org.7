Return-Path: <linux-kernel+bounces-738989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B88B0C04C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001083BA240
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101E528C2B9;
	Mon, 21 Jul 2025 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k5mR0Mro"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1B028B514
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753090118; cv=none; b=CZFf2lr2RIhs2Xl8xfeej/uBydaa3HJZTLLDgq1Ji/b7uheRYCax0Aq/Xc2ysB4RjfwoGKzjxCEPtQME9thM4h2tqLwPemnPnxX5Y7IMRdIAI2VEWovnrP07VYiWSCDn0YbFXckS374icThkms5USwynN0VBUcEDgY9enxHytMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753090118; c=relaxed/simple;
	bh=4xFw3jS3NQtl6syAGugnt+x2gBnxNrr0yh7XHlK6vkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txoDcrFjRPGEAcrGNrjgxMU2vl7ffrvwQjcai8Onb3Lp4qc+Q/QXb/i0s9YtKRsfVDm6cxqJENUux1qqMajFq8bPMhgdr7fuavLuPjEk1+wYen0GKOVUL0ySnpyK0HOmFhgWtSTjYQPyheiPJ/zvGJKiAJXFfJ6hUa+fE8wUDXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k5mR0Mro; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so756925766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753090114; x=1753694914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f/BHaibXouyJJJIITGb7mo1gX1MqrXoOg0xGberIkNQ=;
        b=k5mR0MroP08Mm0AUl91E0oScVEUs+V9BMy50mRmV+1VFmSd0XN81oCrn2s/8QVVHpl
         qgdz5EfaOHDz8J7p390GY5qZga9ZD48mi9lx6rjurBM4jnF/+2eBvnrrum158UVcazI6
         kX+64BSCRdam+iBhufHd945YP9Hm64aGUblon3LadZU1hSpEjfn6BPdGsOhCF+1MgCmj
         nHfc5RTzX9b8rsnVIf7L7IpIdGr7fcvjQ8LMJnFfM2vjsakGobC9/Mr178yiW+KmXEwC
         Y+Z06bSIUI/n0S/3LzjVkG4zD707WX8OtEjLxna5eSWPn+FGVZr94FmDLRnoHaw7ICky
         Bylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753090114; x=1753694914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/BHaibXouyJJJIITGb7mo1gX1MqrXoOg0xGberIkNQ=;
        b=CK4thnu4PeAZlcXqjc8wrReNQzxFq6Oqkefn5KBlA3oJiLUcfytDEJsdcukO/pXA1A
         1GKpWWr6f2PBfppzjGqtpKe4VNCveXAvkTRHVDhFMbRUSUnTBds7f+XdAQOLR04hoFsZ
         zaEEadAyRyXyj4bZuCdYO8dyPjbgULTFYsUCt0fXtPGHj4xOy/26uXMI+QFmssvxJ4qE
         5cXV682hdBBFwCTX9ifAvGRk0syKCjqOcVFNc32nno+wsfZaiHm8AO5SVPo/6FCXzXIM
         aFXUOMh1woi2nII1jWy7fOx1bEkpG6+8M+VxCvPqs3mwxAxHBBP5gfJsgVlRbR5Nv6+d
         HC7g==
X-Forwarded-Encrypted: i=1; AJvYcCWoJXdglJHJ+YakmZ+UGXkpiNAI7yVElXnnUejOIaF2fjIWV8e08XGm8V6jnlAS0w0oYbr2xef636z49s4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Etke1ethNbQqAcOG0vYxCwqCLR9JSSNhH+/rWLYyk5Gf5eFP
	pD6F/usXTHftt4+s8Iz/K4Lb4lJ/yV76q7emNUtP3EXMvLTk4mJWgjfEiAzHtdpcAmM=
X-Gm-Gg: ASbGncsqo3JCTY4e8bgZiZBEaWmvy8nOYcP7w9D9QGPdIPX9jWha2RIHJSbuuz+FgOS
	/re0cw0w5ow+XcC22NBEqeyT7rqxRXBBV/MNmkaDxOLe5Pb2jCrD6eRPgMsV5aYYl5iLEJbN3H0
	zZHOnzQ5wL4R3iPx+QOqlVmXLmoWsKhBqiKXMromB7MhdXhUNHseGGiLcpKNzEc3/uGoJFnpCmc
	XNmsYCj+dDBEDKRHGsmqCPhm4XqLib+F685OvamGsjUQ/b/OCux6hi7PAErkXJJ7PDYANwasJaH
	X2Q88jVZTxLRHxcJ7Yzl30QMzYNdR8mKg1I3ijmvGov7HeJ4kuezVVRppaF/2q0b9b5BcneLYm3
	OuI/QlbjJ6piS6Gz9ccChI6qcMMQU5LG6
X-Google-Smtp-Source: AGHT+IH5pEjp5OVfP4V6m/xEQhFWCrBNIS/9Wi9bH07cLDhVJAN+xvW7EGjxgLgAepiqHSMv9UiC8A==
X-Received: by 2002:a17:906:d54a:b0:ae0:a590:bc64 with SMTP id a640c23a62f3a-aec6a4e2f0fmr1163437566b.18.1753090113651;
        Mon, 21 Jul 2025 02:28:33 -0700 (PDT)
Received: from [172.20.10.10] ([213.233.104.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca5a029sm642550266b.75.2025.07.21.02.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 02:28:33 -0700 (PDT)
Message-ID: <11349679-f1c4-4648-83ec-2292f1c2ae3f@linaro.org>
Date: Mon, 21 Jul 2025 10:28:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: winbond: Add support for W77Q51NW
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 linux-mtd@lists.infradead.org
Cc: Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Pratyush Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
References: <20250720195625.413715-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250720195625.413715-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

hiya, Marek,

On 7/20/25 8:55 PM, Marek Vasut wrote:
> Add IDs for Winbond W77Q51NW, 512M-bit Secure Serial Flash Memory
> with Post-Quantum Cryptography, Dual/Quad SPI, QPI and DTR . The
> flash part is similar to W25Q512NWM .
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Michael Walle <mwalle@kernel.org>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mtd@lists.infradead.org
> ---
>  drivers/mtd/spi-nor/winbond.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index 63a93c9eb917..dcb6c9ec862a 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -343,6 +343,10 @@ static const struct flash_info winbond_nor_parts[] = {
>  		.id = SNOR_ID(0xef, 0x80, 0x20),
>  		.name = "w25q512nwm",
>  		.otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
> +	}, {
> +		.id = SNOR_ID(0xef, 0x8a, 0x1a),
> +		.name = "w77q51nw",

we concluded that the name is not relevant, as there can be flashes
that update their name or worse, entirely different flashes that use
the same flash ID. So please add the name as a comment, above the flash
definition. See recent flash additions.

Also, we introduced some minimum testing requirements, so that we make
sure that the flash was tested at the time of submission and also to
save the dtb database in case other flashes reuse the flash ID, or
different flavors appear, etc. Please do the tests described at:
https://docs.kernel.org/driver-api/mtd/spi-nor.html#minimum-testing-requirements

Cheers,
ta


> +		.otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
>  	},
>  };
>  



Return-Path: <linux-kernel+bounces-892446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14A3C451D1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024503A5203
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DF52E8E0E;
	Mon, 10 Nov 2025 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yAokXkzR"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B1C2E6CA4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762756932; cv=none; b=ZzZPZWwedJemOEO0CFSLzeHZs6FFv6tyTJf5eGguI/zAIY46H+NHUxg5QWdC2XYUFQTivEn+4xck2FLhrtkRP4xGDJTRPIctSRs6MDzKzFODDkjjEvTTnNQxGs4VibQ+yY1r8+tIADMgT8MbCYZHQ5K0DFkTc9PfaakrHwsSPEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762756932; c=relaxed/simple;
	bh=5mmjX1IaaDVJLVWgVFdt55MCv1YS4eHSLixMCjLkZ1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dk3lhXQQhV9l9pqaWkSylosMl4Hj5cpq8df+j4n7n3gO8Qb1E1hdCKbeGr3KcnZOpZbiUKyMa5nt5pbUYGOI3BPeWsh1ppcI2BSVhdRlK412LPC9J4Lj9SSEkO+Q8zknWomTUuFj1JOF74WDjag/x8C1dLE/QcemfLSwSD9elLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yAokXkzR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4777a9aeedaso7330325e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 22:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762756929; x=1763361729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l6bovgW6M7IaME8m+3MWwurxo5DAnDQ6F4m1f8PyL1M=;
        b=yAokXkzR5KJ0xFcNxGDbXOxA0XFHTxH48If3wdfCentOksGXZJ78cCLPFqwuh9YsTD
         s1LaX4+Ge/Wx+zQfdnoDz/4Gwbd0RO9Yt9EDcxCKLmtuZjex4AIWQK3NyzWNmfnlbOVw
         AIW5jA3gqBNH52mYksw/UU5fgHLfwa6buXtoptM1Ql26HBwvQG2fdu9q5aGl08OnalUu
         aCcoMGrbftecJPyy8jrsRFZ2imdvjB70EY8vQe2FA9Rj2umF1kWC7tZsRQpwB95JlBKZ
         W/uHUff92YAUuhlnGUzYRrWVtwU42dXvUZFqzeMa4oppQx+6nwhos9Cygvd5p0ciBsWH
         VfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762756929; x=1763361729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6bovgW6M7IaME8m+3MWwurxo5DAnDQ6F4m1f8PyL1M=;
        b=U2uRHsdeJwH7rNsNrL8O+W42jTvrfnqoT7BXHyupw8wvM69W/+A1X2hYOY8xWLeCL/
         LQW++On11vLTD4pHgn8EkiAK+v8yvJE9SH9ROJ6asEgLxGUCXdFmA57ABQVQz7or0PpM
         59r4hHc4cU2v95jrvOszIVqw7gVktq9P6d2/270Ur2AWMD1TPqtTjKKBt7/HNGfPJAUw
         PudEWxurI8pme/WhX17cKH+0jQ0kCZfdn+oCi6Eig0IIP4dix2kpR3yJoDigjmaFV6eA
         Gda7HzT01oJ2ZzQ/Nd6cQp6pT1UisPQQR9lBCZnFzukuqcoSSvc1o5Ds7Ox+PuJ5+fMk
         6fSA==
X-Forwarded-Encrypted: i=1; AJvYcCW9/AEsb3fkbZOFS5mol93/GB6EWPikSARoDUxqXAgVlxdtDl10TgFUEm5gE1SoSPK6SarOAA1tntSZK+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+YiEANc05HkDnABSRwI1JSGnWtN5x2I5DfTLzh3VLmX/5orUf
	X15w2bikzf95OmQJL4DYj7zDz7UTs4Cr64qF5+LXz0FTbzHBcC+mcNXqPV2kiFbw//E=
X-Gm-Gg: ASbGncsqodyz0xdxKM8jG08S6wHg3iZH+JEgPWqlRxOOc8LvypDgpMJBwnr6UmNThbK
	9LPnyC+ZdyhH0o9d1vR7PrRvUCxD1XpMFIwg9/wyepKe97b16IKPjbCfSJmpKZPbQwlkw0rf6aM
	bA+I3Ov5W04JCxkaRh6TITs4YxGb8KCgPfMeGxGtUG1GLzwOP8hh5Ddf2gRAPNjMgKYAcuo55Pt
	37ih6XzHuZjO0sEr0EPmbA9m0MtYUwYmWBvTwTmNS+xQ+c7Ke7DbBbeQqo0MwDF9Czx2Fh4/tIz
	zpu7IgGlW6XDSO7NKF7Ejs9+EXfej/GdfTT4TAPEtMWAGrkmRezaeyCWeH00PEFMKZJm0+hgd67
	K4ka8tNGpkKjXbrVMHJTmSdu/h+yO8P2PjrUm/pFk7F8+lsstrLwPy4ShYDgxsiG8JCa/zNGZVg
	9cxSu4bamcbz59mlO0eSBdA8gtXIg=
X-Google-Smtp-Source: AGHT+IFeQlHe6Lgxh0t0G+yg4ltlGLrSe2rLWiTzLA7NtqazJKMqLz3Vmd4kQU1Tog7Gnfuon0XUgA==
X-Received: by 2002:a05:600c:1c8e:b0:475:dc5c:3a89 with SMTP id 5b1f17b1804b1-47773288fa6mr64526045e9.34.1762756929296;
        Sun, 09 Nov 2025 22:42:09 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63e13csm20193170f8f.19.2025.11.09.22.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 22:42:08 -0800 (PST)
Message-ID: <b046d19f-6e55-47db-b7a8-6c8766da2e7f@linaro.org>
Date: Mon, 10 Nov 2025 08:42:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mtd: spi-nor: micron-st: add mt35xu01gbba support
To: Haibo Chen <haibo.chen@nxp.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
References: <20251110-nor-v1-0-cde50c81db05@nxp.com>
 <20251110-nor-v1-3-cde50c81db05@nxp.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251110-nor-v1-3-cde50c81db05@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/10/25 6:02 AM, Haibo Chen wrote:
> mt35xu01gbba is similar with mt35xu512aba, but with two dies.
> SFDP contain the wrong size, so define the size dierctly in
> the flash info. And it also support 8D-8D-8D mode, but SFDP
> lack SNOR_F_IO_MODE_EN_VOLATILE, so add this fixup flags here.
> 
> Link: https://datasheet.octopart.com/MT35XU02GCBA1G12-0AAT-Micron-datasheet-138896808.pdf
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> 
> ---
> 1) This mt35xu01gbba is populated on the imx95-19x19-evk board, was
>    tested at 200MHz using nxp,imx95-fspi SPI controller.
> 2) root@imx95evk:~# cat /sys/bus/spi/devices/spi1.0/spi-nor/partname
>    mt35xu01gbba
>    root@imx95evk:~# cat /sys/bus/spi/devices/spi1.0/spi-nor/jedec_id
>    2c5b1b
>    root@imx95evk:~# cat /sys/bus/spi/devices/spi1.0/spi-nor/manufacturer
>    micron
>    root@imx95evk:~# hexdump -Cv /sys/bus/spi/devices/spi1.0/spi-nor/sfdp
>    00000000  53 46 44 50 0a 01 03 ff  00 08 01 17 30 00 00 ff  |SFDP........0...|
>    00000010  84 00 01 02 90 00 00 ff  05 01 01 06 a0 00 00 ff  |................|
>    00000020  0a 00 01 08 b0 00 00 ff  ff ff ff ff ff ff ff ff  |................|
>    00000030  e5 20 8a ff ff ff ff 3f  00 00 00 00 00 00 00 00  |. .....?........|
>    00000040  ee ff ff ff ff ff 00 00  ff ff 00 00 0c 20 11 d8  |............. ..|
>    00000050  0f 52 00 00 39 61 99 00  87 8e 03 d3 ac a1 27 3d  |.R..9a........'=|
>    00000060  7a 75 7a 75 fb bd d5 5c  00 00 70 ff 81 50 f8 a1  |zuzu...\..p..P..|
>    00000070  2f cb 27 8b 00 00 04 01  00 06 01 00 ff ff ff 8e  |/.'.............|
>    00000080  00 00 00 00 00 00 00 00  00 00 00 00 ff ff ff ff  |................|
>    00000090  43 0e ff ff 21 dc 5c ff  ff ff ff ff ff ff ff ff  |C...!.\.........|
>    000000a0  00 0b 80 9e b1 81 b5 85  00 f0 ff 9f 00 0a 00 00  |................|
>    000000b0  00 0a 1a 88 10 00 00 00  ff ff ff ff ff ff ff ff  |................|
>    000000c0  00 00 06 01 00 00 00 00  14 01 81 03 00 00 00 00  |................|
>    000000d0

you have SFDP here

cut

> +	}, {
> +		.id = SNOR_ID(0x2c, 0x5b, 0x1b),
> +		.name = "mt35xu01gbba",

drop the name field and add it as a comment. See recent flash additions commits.> +		.sector_size = SZ_128K,
> +		.size = SZ_128M,

drop these, SFDP shall handle them.

> +		.no_sfdp_flags = SECT_4K | SPI_NOR_OCTAL_READ |
> +				 SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP,

Drop this line, let SFDP handle it

> +		.mfr_flags = USE_FSR,
> +		.fixup_flags = SPI_NOR_4B_OPCODES | SPI_NOR_IO_MODE_EN_VOLATILE,

can we drop SPI_NOR_4B_OPCODES?

> +		.fixups = &mt35xu01gbba_fixups,
>  	}, {
>  		.id = SNOR_ID(0x2c, 0x5b, 0x1c),
>  		.name = "mt35xu02g",
> 



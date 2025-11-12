Return-Path: <linux-kernel+bounces-896836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F339C515AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703CE3A4183
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EE22FE075;
	Wed, 12 Nov 2025 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ny8InQDb"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E0F2F998D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939280; cv=none; b=Y1ENie0LISz1i5AxrsXRybX32G9ibsSP873GEDHHSTWjXQx/Vk8X92JRYOsAbtkltYSUKNzf+d+x8TxQQqmLyBKwow812mZ37568BI2jIivvqfYarFxi2scrvFTqVlD0KTRF/szgNFLQ+ExHhYa9EGpC7DEUVSviOu9bz6cZpRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939280; c=relaxed/simple;
	bh=2Qa5FpPwJauM2+K/bV7Ipmy84+Vvwqx8tkvxHl3fUKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K25VFEFKFP30MZFjABy306gP3HYhvTQmTaWB40h/WeUP6gw3NajOB+NoD0WlYG6wrtKleL/lfO2+uSCxyAcsyw5yokMZc97PYD3NCbDl9FszK/arbkk8B7xIbF8O6aKwu4PQZ5G5SZsIzXdRmezsWNJykM4KwnoLZd6S3AIN3l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ny8InQDb; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso276138f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762939277; x=1763544077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5vExX5lYwjZciNY84xOIPIx1RLXQKLj0IP41hX0dBbo=;
        b=Ny8InQDbE2p9jZmUMCAXcfejHrghf4qJMjubGPoX3Ltm9mJtXPyEbFlilTtdQw1CXg
         ooAqJJG20PFaBUyvCHgDP+p/6GR3g4kO++BRBY5/EoIGUQvZLt+WFlqZDV6qKPOq+w9I
         UkGQOtT3HCTGAXn1A2Yy0dsvbk9eV8ZXJ2IFMqq6nIithDgrLaGwSAVhUXUSvUXmorGP
         rHUKQmXsuxUjrJECcNUsbRXWD1u6Noj2Xub1BB3bdMtFucvofQ3pEoI2vL1PKdKk8kLb
         j8uL2FquQ1SZMN5kTxcAcvpdUMQyLk37chtdYuFT+0ppFXJdOH+ykibUt0yRdZHxqKRE
         mBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762939277; x=1763544077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vExX5lYwjZciNY84xOIPIx1RLXQKLj0IP41hX0dBbo=;
        b=CGHQIFnfocOgdLRwnrh+a3pUavXG7Iw0hrSpFAteeKxABQeSYDssKzV6fA4D0vPxrb
         8OVkbqrg9ckUFknr8/Fs0o/yhj+p0yJP9Rfr2PU104issfjAQyYe5OmOpvyX2Y+00B4k
         J+65McTyMdanjIk6MbbsNq/6CzYJW4JgBYTRYL4KSaouZ9MEJzrVGxnt51UrHl0FBS79
         z2Ct2WgZIOrmrMzMs8m0Z2/5oLbVR7ka185EndM9hDnj/dw2yLbgjH0kjpGL2DHZhdhF
         iZq5hJQr97MAmADS3FYaufQ3b5kfFdGsKlcx7GG6FC32PzISTw2c2WlOwFktX9gPh2E6
         lFpA==
X-Forwarded-Encrypted: i=1; AJvYcCUW1gtk+xE3NBoNiiGuQgVg+LMoZHzDb4S2jS2xJNg6sYGcXZngHmDhonZVGZuC2oPYxysRmOJ7RvHcTPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWj3itwxyzuW9edaaIuIHUbyQ2nes/M2Xr0KyPZL9TeFq5Vunc
	Gj2BEN5SkEYrVorKt8DPPZMnUft4fSkxFMI8u5U7aNrqIPoIYO68IVGZWdTYqgCApjE=
X-Gm-Gg: ASbGncvTP/EAgJrDkQel9xOE04KwEIcqfb5V4LKRFyUC2e4BXAntJYY2B8rdbcBmIOZ
	iIcFqskdSfWEgSkJ6uSLzqEvpuFsNewtiqbqQj0NQwgwiMGiJOxeBAsuaYG1VRV7jLYVnksVMim
	lJ+6hS14hNYJ5AfOx+zplftT9Os/czyQaLDftvMG/niD6kQPpSd8OayyllLUOPFJk/e/lUlk9G+
	BkkHBh/S8InZF3lC3CzfPmcNXpfW5MA/+vQbKbEBfwKWGILVuCH8JQyeXcnBKRZoKu2EjlB/3Fu
	83HxSfgAYs0RE58qOqJaFF0W3c/c07ugYpuMF9E2xmIEQsuoU1X2yn9G6WPI87qAVuu3AMPX59v
	Mb1LaFu2x9N0U5j4t1TJIEFFeqGeuC737bu1vCgkTk1aGc2aLFODEnTCTtAKGlFHPluEcvtTzkD
	ngn8UnLiksKWUPVLJ4
X-Google-Smtp-Source: AGHT+IHoGl5ziEi7Ua+rMKa465Ycd1bn5Q+l1lO6xafRsuDtW0ahp1R+CiWWX89YTNLNjpqEi0+GKA==
X-Received: by 2002:a05:6000:3107:b0:42b:3366:634b with SMTP id ffacd0b85a97d-42b4bdafecfmr1846042f8f.31.1762939276840;
        Wed, 12 Nov 2025 01:21:16 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63dfecsm33332368f8f.12.2025.11.12.01.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:21:16 -0800 (PST)
Message-ID: <013215bb-3562-484f-868d-485d0da095d8@linaro.org>
Date: Wed, 12 Nov 2025 11:21:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] mtd: spi-nor: micron-st: add comment for
 mt35xu02gcba
To: Haibo Chen <haibo.chen@nxp.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
References: <20251112-nor-v3-0-20aaff727c7d@nxp.com>
 <20251112-nor-v3-5-20aaff727c7d@nxp.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251112-nor-v3-5-20aaff727c7d@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/12/25 8:48 AM, Haibo Chen wrote:
> mt35xu02gcba is similar with mt35xu01gbba, but with four
> dies inside. According to datasheet, it contain SFDP and
> support 8D-8D-8D mode. Add comments here, remider to change
> the code in future if has a chance to test on this chip.

you'll need to rephrase a bit the above> 
> Link: https://datasheet.octopart.com/MT35XU02GCBA1G12-0AAT-Micron-datasheet-138896808.pdf
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mtd/spi-nor/micron-st.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index 6d081ec176c37249e5ddb724b61bd70f68088163..cc053b4d615ade3f12068618f8355779561dce55 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -206,6 +206,12 @@ static const struct flash_info micron_nor_parts[] = {
>  		.fixup_flags = SPI_NOR_IO_MODE_EN_VOLATILE,
>  		.fixups = &mt35xu01gbba_fixups,
>  	}, {
> +		/*
> +		 * MT35XU02GCBA contain SFDP, so no need the size
> +		 * and no_sfdp_flags here, should similar with

this is expected for all the flashes that have SFDP, so no need to
specify this again here.

> +		 * MT35XU01GBBA, but with 4 dies. If someone can
> +		 * test on this chip, can change accordingly.
> +		 */

How about we rephrase this to:
The MT35XU02GCBA flash device does not support chip erase, according to
its datasheet. It only supports die erase, which means the current driver
implementation will likely need to be converted to use die erase.
Furthermore, similar to the MT35XU01GBBA, the SPI_NOR_IO_MODE_EN_VOLATILE
flag probably needs to be enabled.

With something along the above lines you can add:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

>  		.id = SNOR_ID(0x2c, 0x5b, 0x1c),
>  		.name = "mt35xu02g",
>  		.sector_size = SZ_128K,
> 



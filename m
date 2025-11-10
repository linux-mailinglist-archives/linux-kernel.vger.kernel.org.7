Return-Path: <linux-kernel+bounces-892433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6030FC45159
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084E7188CAA3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164512E8B71;
	Mon, 10 Nov 2025 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJ3oVl04"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85164216E32
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762756326; cv=none; b=BX0S/eUjwiyWiPP7xb74Su8NbgxLYoSRy5OBt5b2lc17wqhBDr09MJ+dKftRKi131iSNuSQuCYHy2E+DCGBiuQXBMmRNP0yFp1qO7sVlGfgubeOhgtimmX+Pm2mOfMHOq4YfRvvH/9Aopy3uy/Ej6XbAYSAf6TzjAdPICge72tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762756326; c=relaxed/simple;
	bh=SiASzPOTqxzOQZqsSiwUyYUrWviV4w+oB4ux8KVNcBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9/toA3vaonswJTJdagtQgmqGRKSs8Dk2hki/n+H13njxfqmTq8vgPmQvq8DtxrUaeRo0wY6uNgOgQNGrTFtpglukhTnbuinarvrCXa5XBdSW0bdv16pkFzG2tImRXxj1AIvxJt3HjanP3SP1Y9FWDBtVEkUkz3W7Wbde3e5Nco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LJ3oVl04; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-471191ac79dso27320025e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 22:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762756323; x=1763361123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fD41ZL4TlCiwqwxi6QcBrdLjUd39djAdPK6JdkJ0Gzo=;
        b=LJ3oVl04wQMSfKgWWXNrQgc40ir+C1waf7yK9+VuuekK2iuz/bzr2dS6BRNjxQ9veh
         nyCMnjC8XNOXg7SNIKds3QWhaZqJOAniSoMNGP2CQDlfNvpEYuAyD+yvXMEvD1a8hWlK
         lB1i2wWYM0Hd3BcPqJRqeVCwhWvF0Yrx4gP4aWILazB6c7pI8UPAaCNRP19R0DqW33Fy
         OcFyehmQCwza6m1+bIag65YkSDuAGMiJS4Ep0I0nqOqtoFiGqgCFRM6k/784yr1tpacV
         40uCdAL4HIChUxbM+UnrKkMguBxRuXrO4lhN8+jGloEpjAe3OgLQkEShIqWCpE2fmGZo
         NPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762756323; x=1763361123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fD41ZL4TlCiwqwxi6QcBrdLjUd39djAdPK6JdkJ0Gzo=;
        b=e+0LPP3GWG0WZDiIrbonpgc5idyc0iZoaOHdC9UOGgGhJ4GAAO9P/Mg4ynl32Po1ve
         +lGih3RXiseNcYr8cn8TqI3nuk8yQPbG4OgFVUEjSHe+ZeSQd6lgt+RVmhKsNI4LIhhw
         /esb+zot/BTkV37MlSu/uxXdxOlerY1aRWMV9f28eyDU0nUHdNU5DVmM3/d/2imhoNNt
         oZRozelL5llV1M0Vo7YYvnSLkMLPufoF44cVx7drdU0SFdoTtPHlXmzWzP7PhzdzSBCC
         C+Dlx02Fm+Fnkwj6rmJDRjb2iSPhrAtpvzq430VfUHHstYx3HVVct+PCJSpoFydgwOxv
         fEJA==
X-Forwarded-Encrypted: i=1; AJvYcCWTVFtHpfCBDIDGMb4gXI9kDUTqDIEbYMgAwF3VlpA1qkFn5FprZ2MXMOgXWW+u85oFSVzahONb3/ERAJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzehEmYVp5/lpL2PkOWIhrsCQUuC2v7qqWxMsNSeqfP84R3Dhj6
	mOdTf+/kFh3ieShUd5Ux8TuxsdACiBxOvngAxKv6zvWh316+0XmeqCmNlYKHG2D2XLI=
X-Gm-Gg: ASbGnctpxyApOtGNd4LXrzVxL/czTX+4cftahr2YJLshDzOvwJRDB1eMTg/vXPB+lqm
	UFwB4JD14J7FEEMbbE/DJI1Tr9i0akS6PVt5mkGdGFVSCZYE5JA/Y3B7ZVZQ7Vc0u3A80VnqESJ
	jFHEzAm2+euhEStdxlItQIvjOMSnxZ/BvCxaZaAhtwVnmLmCmu737XfJGI5LSNC0DG1xJjfu8Lf
	Lm0cdgXoDjoQG12AumYrFg5Y6X+WMLTkue5xwai6b/Mp+FFAhpDhQagODWEV2JkyAOw9nM/Ts6X
	0nx8lRQePHrmXHuyafEsyAkojDn38sCBmHAqLfOvLI0cxdSZm905gL5fH84X2Ow8iImxnWUDQGo
	de2VVU0LNRmroH65kvPZMaoVzD/tMHPf7sFMC6d8+cBQmfENUQw3J0VGFXEomE6EKjOliHamtb1
	Y/cU8lNLTQ8mPEcVo0
X-Google-Smtp-Source: AGHT+IH7itPdnN3+CMIJFyI8o/5N3sDOzt/9g2GEzbgtOpPZGmoToNN4ZHSLHno+aeXqtWyjmYzHGA==
X-Received: by 2002:a05:600c:5247:b0:477:7cac:508d with SMTP id 5b1f17b1804b1-4777cac524cmr11045475e9.16.1762756322721;
        Sun, 09 Nov 2025 22:32:02 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac6794f6esm23183356f8f.41.2025.11.09.22.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 22:32:02 -0800 (PST)
Message-ID: <85b973b1-ec1a-4508-a9f5-fbf6917eab85@linaro.org>
Date: Mon, 10 Nov 2025 08:32:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mtd: spi-nor: micron-st: rename the die_late_init
 functions
To: Haibo Chen <haibo.chen@nxp.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
References: <20251110-nor-v1-0-cde50c81db05@nxp.com>
 <20251110-nor-v1-1-cde50c81db05@nxp.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251110-nor-v1-1-cde50c81db05@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/10/25 6:02 AM, Haibo Chen wrote:
> st_nor_two/four_die_late_init() also suit for micron chips, so
> rename to micron_st_nor_two/four_die_late_init().
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mtd/spi-nor/micron-st.c | 70 ++++++++++++++++++++---------------------
>  1 file changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index 187239ccd549510c6e9a6eacf4ae41158287e077..92eb14ca76c57f29ece1edb3fe652c56d1c2888f 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -127,6 +127,38 @@ static int micron_st_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
>  			micron_st_nor_octal_dtr_dis(nor);
>  }
>  
> +static int micron_st_nor_four_die_late_init(struct spi_nor *nor)
> +{
> +	struct spi_nor_flash_parameter *params = nor->params;
> +
> +	params->die_erase_opcode = SPINOR_OP_MT_DIE_ERASE;
> +	params->n_dice = 4;
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
> +static int micron_st_nor_two_die_late_init(struct spi_nor *nor)
> +{
> +	struct spi_nor_flash_parameter *params = nor->params;
> +
> +	params->die_erase_opcode = SPINOR_OP_MT_DIE_ERASE;
> +	params->n_dice = 2;
> +
> +	/*
> +	 * Unfortunately the die erase opcode does not have a 4-byte opcode
> +	 * correspondent for these flashes. The SFDP 4BAIT table fails to
> +	 * consider the die erase too. We're forced to enter in the 4 byte
> +	 * address mode in order to benefit of the die erase.
> +	 */
> +	return spi_nor_set_4byte_addr_mode(nor, true);
> +}

I see you also moved the methods a bit up, maybe to have all micron_st methods
in one place. Specify this in the commit message to spare reviewers of checking
bit-to-bit exact move.

With that:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> +
>  static void mt35xu512aba_default_init(struct spi_nor *nor)
>  {
>  	nor->params->set_octal_dtr = micron_st_nor_set_octal_dtr;
> @@ -193,48 +225,16 @@ static const struct spi_nor_fixups mt25qu512a_fixups = {
>  	.post_bfpt = mt25qu512a_post_bfpt_fixup,
>  };
>  
> -static int st_nor_four_die_late_init(struct spi_nor *nor)
> -{
> -	struct spi_nor_flash_parameter *params = nor->params;
> -
> -	params->die_erase_opcode = SPINOR_OP_MT_DIE_ERASE;
> -	params->n_dice = 4;
> -
> -	/*
> -	 * Unfortunately the die erase opcode does not have a 4-byte opcode
> -	 * correspondent for these flashes. The SFDP 4BAIT table fails to
> -	 * consider the die erase too. We're forced to enter in the 4 byte
> -	 * address mode in order to benefit of the die erase.
> -	 */
> -	return spi_nor_set_4byte_addr_mode(nor, true);
> -}
> -
> -static int st_nor_two_die_late_init(struct spi_nor *nor)
> -{
> -	struct spi_nor_flash_parameter *params = nor->params;
> -
> -	params->die_erase_opcode = SPINOR_OP_MT_DIE_ERASE;
> -	params->n_dice = 2;
> -
> -	/*
> -	 * Unfortunately the die erase opcode does not have a 4-byte opcode
> -	 * correspondent for these flashes. The SFDP 4BAIT table fails to
> -	 * consider the die erase too. We're forced to enter in the 4 byte
> -	 * address mode in order to benefit of the die erase.
> -	 */
> -	return spi_nor_set_4byte_addr_mode(nor, true);
> -}
> -
>  static const struct spi_nor_fixups n25q00_fixups = {
> -	.late_init = st_nor_four_die_late_init,
> +	.late_init = micron_st_nor_four_die_late_init,
>  };
>  
>  static const struct spi_nor_fixups mt25q01_fixups = {
> -	.late_init = st_nor_two_die_late_init,
> +	.late_init = micron_st_nor_two_die_late_init,
>  };
>  
>  static const struct spi_nor_fixups mt25q02_fixups = {
> -	.late_init = st_nor_four_die_late_init,
> +	.late_init = micron_st_nor_four_die_late_init,
>  };
>  
>  static const struct flash_info st_nor_parts[] = {
> 


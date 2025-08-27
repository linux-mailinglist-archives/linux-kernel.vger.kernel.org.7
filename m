Return-Path: <linux-kernel+bounces-788276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAA3B38215
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F343200886
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3143019B7;
	Wed, 27 Aug 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxAW6jPM"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C82921ADA4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296997; cv=none; b=iAoMAnFqZMOlRs6EU6LUjiAvBr2DXP6S5D4zpZNQ/NEzllu4NMPN1awKEmko4lvy5ge9dQRYhrOgGPBMFQKlupLUxPwRlWnnD6VQS72QGdPNlM+54nuUtk0t87gyUm/ZOKYZM2KWqlVPPtSN4OD9qbU6GzUcIb0Wz+E32DtpfMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296997; c=relaxed/simple;
	bh=6afP3JGdSF5+WRW1WU+EjRrsvtZ+hFqZy+HPKDnl0OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKd+RT7vCRskGE7EvIEZsIQ/hB1WPGmm+Ff3RONhkkg2VOpIpj1scqDfCGXRZDbfK00Xum8QWkpxpu+P2za2ahtcq0HHPzhrFMw5ukBCC5W3UmMeM3aoJ8XW/arFpxMaXYz0byvwmmEdIDr/YqqtOb4pykZgciCLGet/MtTV/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dxAW6jPM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c4e9efb88aso3704726f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756296993; x=1756901793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CzWMrazf1iXoHpSc4zbm1dvGcCsF29470EBb0U9ecSk=;
        b=dxAW6jPMsZsTY/I2UsaASQqxBOufsgh0oK1gr6WUTLjPEnoZIe2TpIuYxmP3fcjimJ
         u0VYUnTL3oz+hI82EJL0cQc3vAXmxOCLQ/dLp67eN28Hcw8dxvqnndi3JEJN+B+3MKDZ
         o6NPO8AB93EidHXHVs6AkFdYqLiRl8ntZFfIAJCsG6JMAdzfDRRgNqLMLfPVI/11PmvX
         Vj2PrdHr1ppsHEzbZ6vW3CqHGAUfrAy6todxpqkTJmsOFPDS1ZvKs3ANHzJ1oqmTzMz0
         lpGWeQlO29/jIYR/XjRcXVWc3DS5w6sbd4QNdeGeAZoAqFePmxuPADnoz1eHh9cSlSxu
         GYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756296993; x=1756901793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzWMrazf1iXoHpSc4zbm1dvGcCsF29470EBb0U9ecSk=;
        b=OS8F0VZ7qbOvy5w1Ok6HZJ936vaM1C++BfQRzInc1chIeX7lXssT3SN4590HG/S+uL
         53fbvEFk/X0Jpup2OcgQUSf+KBdNOD/zNXqJAy/BNT80DHUktidLxv7hXFxC/k1BhrLu
         jKxiFucT8WYzmCG9A0R0NskcbkMbCP9JVAHmxwzT/Fduy/N70WFjwK91cR/SOePu0oxt
         GpgWBIQ1A7rUbrSif7dVJwuIvYJxf24eq9YDel2VtzbzmrKAyyRtG2/Tvi/PxHuC/cWg
         k79C1EvbI4PPRne57u6BT7mRuFoHDznGbu/4nt9nU3cSd976t3DH1HnCB+SEwqdO3pMT
         C7aw==
X-Forwarded-Encrypted: i=1; AJvYcCWDxaDkRVgkCoLMG3KseR+QC5hl7tf4vzmpmShT5znPUeGK9PoeXmiMDgTorLqIosdJjqQK6SSMNiTiVrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbt7e9rQpjJnBa9FdwRv9ojOjniEqe3vfHGCbBTQsswPGx1H45
	q3JVE9Cl+bJ5ipW8oH+lRySqIOst1/YSPBfmmb3LC1nubhNPSuuiwQTVLjWq25+//Tc=
X-Gm-Gg: ASbGncsWmwfhdCzcexs8Rv3KnZ1WsXGalSf70RaSrrG50iipIb+pu2QkOcbpJ9PjzQi
	ACv8+lrX0JagUt5JNp6mI+iNGUtjm/wP9v3W7z5AY/DW2A0qF0bUq8OMowjrixhWsdfZ9X+TFrc
	JNyEVQdRTXFz20gDKHtTGGrjvdUHx25ePD6FOMiIJj/QMXWGz/ArqGlAiDX2gjbPmgIH1/dSdA2
	NlGnwHCigrHZ04ysIoDtsSads31pAB0qTAXIMuSyqzpYcUfIZEpNVEzxxrplpwt9UKwgeOYZHci
	ocJZki9LW8yw0vlbbdbPvVFoBM1uDRO07bONNSlcbcmlwPC9tX7SNTIDAfL/wC8rW8baMRv9Dzd
	mr5Ly2g9d0tXKVw/SA6K01YNpzLE=
X-Google-Smtp-Source: AGHT+IGgg8De7RE7Ql6a6iRKfTa/K3diiP5L1gX09i5MplkQcx7MQCeB9Oarr+2CgGS8lKSCVWsfrQ==
X-Received: by 2002:a05:6000:2888:b0:3b7:9613:adef with SMTP id ffacd0b85a97d-3c5de347ce5mr12999054f8f.55.1756296992639;
        Wed, 27 Aug 2025 05:16:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c70ef566dcsm20200486f8f.24.2025.08.27.05.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:16:32 -0700 (PDT)
Date: Wed, 27 Aug 2025 15:16:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: gregkh@linuxfoundation.org, dpenkler@gmail.com,
	matchstick@neverthere.org, arnd@arndb.de,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: gpib: simplify and fix get_data_lines
Message-ID: <aK73HPDKu6rqg9Ya@stanley.mountain>
References: <20250827113858.17265-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827113858.17265-1-osama.abdelkader@gmail.com>

On Wed, Aug 27, 2025 at 01:38:57PM +0200, Osama Abdelkader wrote:
> The function `get_data_lines()` in gpib_bitbang.c currently reads 8
> GPIO descriptors individually and combines them into a byte.
> This has two issues:
> 
>   * `gpiod_get_value()` returns an `int` which may be negative on
>     error. Assigning it directly into a `u8` may propagate unexpected
>     values. Masking ensures only the LSB is used.

This part isn't really true any more.

>   * The code is repetitive and harder to extend.
> 
> Fix this by introducing a local array of GPIO descriptors and looping
> over them, while masking the return value to its least significant bit.

There really isn't any need to mask now that we're checking for
negatives.

> 
> This reduces duplication, makes the code more maintainable, and avoids
> possible data corruption from negative `gpiod_get_value()` returns.
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
> v2:
> Just print the gpio pin error and leave the bit as zero
> ---
>  drivers/staging/gpib/gpio/gpib_bitbang.c | 28 ++++++++++++++----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
> index 17884810fd69..f4ca59c007dd 100644
> --- a/drivers/staging/gpib/gpio/gpib_bitbang.c
> +++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
> @@ -1403,17 +1403,23 @@ static void set_data_lines(u8 byte)
>  
>  static u8 get_data_lines(void)
>  {
> -	u8 ret;
> -
> -	ret = gpiod_get_value(D01);
> -	ret |= gpiod_get_value(D02) << 1;
> -	ret |= gpiod_get_value(D03) << 2;
> -	ret |= gpiod_get_value(D04) << 3;
> -	ret |= gpiod_get_value(D05) << 4;
> -	ret |= gpiod_get_value(D06) << 5;
> -	ret |= gpiod_get_value(D07) << 6;
> -	ret |= gpiod_get_value(D08) << 7;
> -	return ~ret;
> +	struct gpio_desc *lines[8] = {
> +		D01, D02, D03, D04, D05, D06, D07, D08
> +	};
> +

Delete this blank line.

> +	u8 val = 0;
> +	int ret, i;
> +
> +	for (i = 0; i < 8; i++) {
> +		ret = gpiod_get_value(lines[i]);
> +		if (ret < 0) {
> +			pr_err("get GPIO pin %d error: %d\n", i, ret);
> +			continue;
> +		}
> +		val |= (ret & 1) << i;

Delete the mask.

(I wavered on whether I should comment on the nit picky things I've
said in this email, but in the end it was the out of date commit
message which pushed me over the edge.  I would have ignored the
other things otherwise).

regards,
dan carpenter




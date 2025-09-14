Return-Path: <linux-kernel+bounces-815717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57936B56A4E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4A9E7A5012
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C1E2D9EF3;
	Sun, 14 Sep 2025 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gE/5JzCX"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C7C2D9ED8
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757864642; cv=none; b=qA+COpxDoEHXaDXiLPnAwpNsXs7aGrAoJyzfrz/XSAObP60KOl6jaYsZvEvxDt7PiQ4n4w2nUm9QlBfXJXOiFWJoHSMSyRWc40XzsHIv0tQ74sAcCBvJTz9hMsDK7upmXIpxEfQCFjoiDyp+ofH6j2mHWewE95xjHTOVQHiO1zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757864642; c=relaxed/simple;
	bh=cP0K/fO+03hivuzCPBr9UJRxnuVoSdNkA2qEl1wBq1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T49zs/b7pG43R3HAllGAYUTwo6uPRXEEPUVuYw0AAiaP1zgoeTRT9RV6dBZnmwNp7V+GtAfYnfV1utNC5adMlwgOrX6omzipv3ZbPsGF6+VVChuZGmecq/rgv3Pv78PBjVFv6VSmFxo+i/dx7zWmJqX8P7vRENrwsvGG5pVhGwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=gE/5JzCX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ea115556b2so278463f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 08:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757864639; x=1758469439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=17ifI2mYE1NgbBTyTNuir4pDtVCiq8BMt8N76nRgoes=;
        b=gE/5JzCXB0cQCDXvC2d5bHqmJsCwY9zPhYQo57k5htoP4NMh9+LOujN586e3uQldMf
         0OVMQo336R+S0rokscRux8+rUTUw2CXHdoGzQEdJ7+xkg2aLFNEhbEYahIw9OfzZqAX6
         pdkDoE1G7hcIJQUSyR+pm9rMxe2Xih2VbaRsBFArSVl1W02BobUS1vToWSM0/HMbtH+z
         QUscixrb3yO0cMpeVjIFG10x9nLGGCV6VnmJOZySfVDcfCGKGXzCaNYDyq9SuYgwGBX7
         mkBIvzzxJ8Ufq1j4I7KCUH8SWdi0RcU6o9d/0B0ZaF8epkdcsUMOdpaOuU0qQEQB4l43
         Lhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757864639; x=1758469439;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17ifI2mYE1NgbBTyTNuir4pDtVCiq8BMt8N76nRgoes=;
        b=oWBJFLLqtaStZ8hWE8Obdnadvzls/XejeQE5IXzSi2cxews7Ihz7/9RQ/h70RF2aU6
         luUXp09oBg0b8cBgTao8N4QAwp11hLp84BYrbxzOMKPGjheSecZNIkK1TRzvWqupfX+Y
         cvuUbwgwnzyf+oxEmFammdqKETYvZzHZkFeSXOoLe2eK1XIdmBvepnwSDIsRMiMmbQPq
         opzh3Sm+qAC/oHrH99aKT5pxqag3JwBYWrNRK+SlQkuchdXdHpJNWSb7ISeC6KUD5UvX
         BL0qUbTAt20B84P1gjVeNbLLCzJT2/12KGzf0WasI4VufOHhKVAlSViENPucJdEwVmCs
         dkAA==
X-Forwarded-Encrypted: i=1; AJvYcCWgFqe3ejsAzH/ViTZ1glB6eI0pSTGa5916kYQ4J9ANePV+AsDYJaXgU5yypGfmcIG2TSdKjGf0b4a0egk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxPV5FSl9ebeW+V85hKCZyFD5Kx7ZId97PczdlXmUe3QLw9Np9
	juyxdGshLzdaiTd7ASogXvpIp1tUXzsMQqAGDNXIb8ihNQB+onqpuE2AYDfv3eTOtzM=
X-Gm-Gg: ASbGncskWJAngXAEtQxXJA6CrmelgETAlCOJmWDc/5yk/6MLlDpyL4JbqhKr/MjVHHX
	5E9Og8vISWcctR+g1nH58gZS2Qp81vottKIWvJB6icHDupp4ABm3YPS/GQOaJ4bNqy2T7l+jZG4
	Xf9C9uQ8rGaIsWp19Hdm7tWhb1RJ2FJLNadjIet5qWL3Upt3Ac5cdFLPgI+Ys/21OR4wkW29mmC
	MJ3kTgqpkSuKOxtN215qlyxQDOGdBILhIilkMJAC77sqN88TYXZJlVQNJuIMUHJR0ScGQiWIkGy
	uBrDsdebYJyFjrZ5Su5J9zlb/c9J1eZr/9ppIbWyZCPXJvbGAqZNShD77CoWZynFQhFwQrBBvTs
	FizcXsQ9/ZV2tR3VdspDKL8WCZK5Hl170Jiy0po6mYw==
X-Google-Smtp-Source: AGHT+IHL6egG0n/SaYA5xvNQA+X+v1J8Dbx8go0tlT2XCBBZEzMIXumDBUCMKSubOS2pVf3FdBCGfA==
X-Received: by 2002:a05:6000:2510:b0:3e4:ea11:f7df with SMTP id ffacd0b85a97d-3e7659db441mr8532807f8f.40.1757864638550;
        Sun, 14 Sep 2025 08:43:58 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0153fbd5sm74655275e9.5.2025.09.14.08.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 08:43:57 -0700 (PDT)
Message-ID: <038ea3e7-53d5-4e49-ad35-cc2a58e4d808@tuxon.dev>
Date: Sun, 14 Sep 2025 18:43:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] iio: adc: at91-sama5d2_adc: update calibration
 index, validation condition
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 eugen.hristev@linaro.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, srini@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250804100219.63325-1-varshini.rajendran@microchip.com>
 <20250804100219.63325-5-varshini.rajendran@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250804100219.63325-5-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Varshini,

On 8/4/25 13:02, Varshini Rajendran wrote:
> Add additional condition for validating the calibration data read from
> the OTP through nvmem device interface. Adjust the calibration indexes
> of sama7g5 according to the buffer received from the OTP memory.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index c3450246730e..d952109a64a9 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -445,6 +445,14 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
>  #define at91_adc_writel(st, reg, val)					\
>  	writel_relaxed(val, (st)->base + (st)->soc_info.platform->layout->reg)
>  
> +/*
> + * The calibration data has a TAG to recognize the packet
> + * The tag has a constant value "ACST" with the ASCII
> + * equivalent 0x41435354. This is used to validate the
> + * calibration data obtained from the OTP.
> + */
> +#define AT91_TEMP_CALIB_TAG	0x41435354
> +
>  /**
>   * struct at91_adc_platform - at91-sama5d2 platform information struct
>   * @layout:		pointer to the reg layout struct
> @@ -504,10 +512,10 @@ struct at91_adc_temp_sensor_clb {
>   * @AT91_ADC_TS_CLB_IDX_MAX: max index for temperature calibration packet in OTP
>   */
>  enum at91_adc_ts_clb_idx {
> -	AT91_ADC_TS_CLB_IDX_P1 = 2,
> -	AT91_ADC_TS_CLB_IDX_P4 = 5,
> -	AT91_ADC_TS_CLB_IDX_P6 = 7,
> -	AT91_ADC_TS_CLB_IDX_MAX = 19,
> +	AT91_ADC_TS_CLB_IDX_P1 = 1,
> +	AT91_ADC_TS_CLB_IDX_P4 = 4,
> +	AT91_ADC_TS_CLB_IDX_P6 = 6,
> +	AT91_ADC_TS_CLB_IDX_MAX = 18,
>  };
>  
>  /* Temperature sensor calibration - Vtemp voltage sensitivity to temperature. */
> @@ -2281,7 +2289,7 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
>  		dev_err(dev, "Failed to read calibration data!\n");
>  		return PTR_ERR(buf);
>  	}
> -	if (len < AT91_ADC_TS_CLB_IDX_MAX * 4) {
> +	if (len < AT91_ADC_TS_CLB_IDX_MAX * 4  || buf[0] != AT91_TEMP_CALIB_TAG) {

Can buf[0] != AT91_TEMP_CALIB_TAG with the new code?


>  		dev_err(dev, "Invalid calibration data!\n");
>  		ret = -EINVAL;
>  		goto free_buf;



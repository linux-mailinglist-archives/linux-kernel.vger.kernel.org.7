Return-Path: <linux-kernel+bounces-739956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A8DB0CD8B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DD93A5072
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6FD242D8F;
	Mon, 21 Jul 2025 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ogy0KaXE"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE4C23D2B6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139205; cv=none; b=oLdgSoPUBqtQSFkny/9C+QsuXe9J5Yx0T7rL1JGgHYgqQppTVcUMcweBmWsjG18NYVg8PTxQjkzSuWiinrUkMndSH6Pw0eTgQzyz7f0ynXD60yLf0eNSqHbK1xD9yt/zFTglguQQ98Qaihbb3ni6DoviRRQH182LZZsO3M0HQKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139205; c=relaxed/simple;
	bh=Vh2ep+9f8ojJA+8YXN6ithipvT2LyfzS6eaFXdjJFiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDpMaCRFEYBoaI2BfpkoQA7tVFFIyEmOq4FE5TXfxWyr/QAgl0JIaAgwiwRQ8A+V2/eR4LmYKxgZQWKTguHyu2kxrdHt4prsQTeQINEV6s2vwAIIvEfjX+fYrm0jnLmtkWm6DOqN0SN3ooC9fTwAv/veqrwUbCMJ7QZ6RerCHVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ogy0KaXE; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72c27166ab3so3635408a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753139202; x=1753744002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7OF+E9PghLDLPYp48MPzkPJPODuYTZfqpGJds42BzkI=;
        b=Ogy0KaXEm2hiR/HNBFUAlfpV1KFfxMxS8fiPP5cEfkwe/cIBi2J3e1zwpLmAQRlWos
         TS2OKASTCrgBiKeQq9bYFhvPN5lojb3mdnIf4/xLo+Ch0mWfC4D3efGCq+3sqn4YYqQh
         VLBnonFCzIGt8bP0fVSza/qCrgT4RPmpqVWoReps1noSK12SDAbZhNi9FtFdH9BBAW9X
         TIJhjsdhKf7tH1/qlDLAq8Wn20B52pYa6+5yCVJ6xk0+oO9zWYqytku22Xa1Y7qt+Yn4
         2yVVUWD+F7HiOptklP8TtZ0GYEhmqaJyO7lHwU5P3SvwaPxhVflM9wsM3qzx7WrAoOOJ
         XA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753139202; x=1753744002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OF+E9PghLDLPYp48MPzkPJPODuYTZfqpGJds42BzkI=;
        b=rQnJq1k/XD+liyajBlSgbpgwc87uipUgS/6nKi17agDjEfEc5IYCOrTElWjLRpYthm
         pvLhYjnSammX8SRCc4YbANwoJvTQN63gIFEWgckLit14PhQcKQWb3E2r09+mTBya7B7r
         XS9kKId+UkL+yvn6yt2tpxO1/FASPP6e9Hk940eghl8AL27CRVsWan6chFQyLXq5YfTT
         TFO0NrpAs2mkMDz4TqyNdlD71VM+1nyOGT7LZse2mTlmNBo4SXJo9ZpOqlwsH6eM9I06
         lIUtPhPGsIruz+M73nIFpPJejp0YEb6JXN3mM+A7N0tduivjtdGvuR0vnM8XG9UoSMe7
         krUw==
X-Forwarded-Encrypted: i=1; AJvYcCV/8pVpRyK9h+EFfZge8+yTTpye92aROZ+EEPSfD3MEfMVtaXjaR9OHPPK7JdUXy9exLnkffMnqkDO1TB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz09L7toG2wrXp9g2JqfCzdYVRbCb1GkrBWp4622rZbP2X61gwy
	IMn0JZVrBc6dN1u3qJ+lABP0bX+hVQmfLtIpglCW3Op1xdHK5WNC8mOy2o2wHv5qLMEdWATUaSP
	1IElqN+U=
X-Gm-Gg: ASbGncu1sxEfr6U9yJHvzFx1gJdL+FzoQgMJ80LXcd6XzwPRvN/BIz+T8AVKtVLLlPv
	G3tGQc0mKWzJjtNtCiOVANwtYtaKp50tlbvdCvPaqFM5s5n7+B54cF/OLtblCwQvs9rrV1PHo5B
	cQXf1S5Ixbpm0H3pSRRK31vbRpYvaVLJeHm4ZYsSQhODjCNJOs81wLKuBTr3nMTSobv7ISUBKr6
	m81G9V4zXDQePXCnfaI/HcLPyyo41OjT9kLGAzjtD5pKaEipijIamQEhEtZHl8TJLh7qZKPDIkA
	vz8yWSxyEapHcmgsqsV1GOpei2SftgQRKpUvVvVI2OVEpC2tVu7azgFSo/2T+uQO0VmIm6xjL5n
	JyJ9M1EplZUFnobe+mWaD5T+CTJs0VtXn74xmMSh6Gm4Z5KiTfsJuSfwNCppve+wPBIrl+69mr4
	A=
X-Google-Smtp-Source: AGHT+IGGNnmoSqscKREZUByKeQUeagY9m9zmd/pNm8JlN4TTLEuv5MopATx3dUBUpoMmrXq/RU4Nuw==
X-Received: by 2002:a05:6830:418c:b0:73c:ee21:f360 with SMTP id 46e09a7af769-73e6660342bmr14913494a34.20.1753139201645;
        Mon, 21 Jul 2025 16:06:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2a79:4b55:6a01:85d7? ([2600:8803:e7e4:1d00:2a79:4b55:6a01:85d7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30101ccfbdbsm4034202fac.10.2025.07.21.16.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 16:06:41 -0700 (PDT)
Message-ID: <bd5c1587-c830-40e6-90d5-be7fad215cef@baylibre.com>
Date: Mon, 21 Jul 2025 18:06:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: temperature: maxim_thermocouple: use DMA-safe
 buffer for spi_read()
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Matt Ranostay <mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250721-iio-use-more-iio_declare_buffer_with_ts-3-v2-1-0c68d41ccf6c@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250721-iio-use-more-iio_declare_buffer_with_ts-3-v2-1-0c68d41ccf6c@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/25 6:04 PM, David Lechner wrote:
> Replace using stack-allocated buffers with a DMA-safe buffer for use
> with spi_read(). This allows the driver to be safely used with
> DMA-enabled SPI controllers.
> 
> The buffer array is also converted to a struct with a union to make the
> usage of the memory in the buffer more clear and ensure proper alignment.
> 
> Fixes: 1f25ca11d84a ("iio: temperature: add support for Maxim thermocouple chips")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Changes in v2:
> - This is a new patch since when looking at it again, I noticed a bug
>   with passing stack-allocated memory to spi_read(). So now the primary
>   purpose is a fix and converting the array to a struct comes free with
>   it.
> - Link to v1: https://lore.kernel.org/r/20250711-iio-use-more-iio_declare_buffer_with_ts-3-v1-1-f6dd3363fd85@baylibre.com
> ---
>  drivers/iio/temperature/maxim_thermocouple.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
> index cae8e84821d7fd521d59432580d51def939fa4d1..fa648a6542a4e2f08adb556c776b68331ae69631 100644
> --- a/drivers/iio/temperature/maxim_thermocouple.c
> +++ b/drivers/iio/temperature/maxim_thermocouple.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/err.h>
>  #include <linux/spi/spi.h>
> +#include <linux/types.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger.h>
> @@ -121,8 +122,15 @@ struct maxim_thermocouple_data {
>  	struct spi_device *spi;
>  	const struct maxim_thermocouple_chip *chip;
>  	char tc_type;
> -
> -	u8 buffer[16] __aligned(IIO_DMA_MINALIGN);
> +	/* Buffer for reading up to 2 hardware channels. */
> +	struct {
> +		union {
> +			__be16 raw16;
> +			__be32 raw32;
> +			__be16 raw[2];
> +		};
> +		aligned_s64 timestamp;
> +	} buffer __aligned(IIO_DMA_MINALIGN);
>  };
>  
>  static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
> @@ -130,18 +138,16 @@ static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
>  {
>  	unsigned int storage_bytes = data->chip->read_size;
>  	unsigned int shift = chan->scan_type.shift + (chan->address * 8);
> -	__be16 buf16;
> -	__be32 buf32;
>  	int ret;
>  
>  	switch (storage_bytes) {
>  	case 2:
> -		ret = spi_read(data->spi, (void *)&buf16, storage_bytes);
> -		*val = be16_to_cpu(buf16);
> +		ret = spi_read(data->spi, &data->buffer.raw16, storage_bytes);
> +		*val = be16_to_cpu(data->buffer.raw16);
>  		break;
>  	case 4:
> -		ret = spi_read(data->spi, (void *)&buf32, storage_bytes);
> -		*val = be32_to_cpu(buf32);
> +		ret = spi_read(data->spi, &data->buffer.raw32, storage_bytes);
> +		*val = be32_to_cpu(data->buffer.raw32);
>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -166,9 +172,9 @@ static irqreturn_t maxim_thermocouple_trigger_handler(int irq, void *private)
>  	struct maxim_thermocouple_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = spi_read(data->spi, data->buffer, data->chip->read_size);
> +	ret = spi_read(data->spi, &data->buffer.raw, data->chip->read_size);

Compile check didn't catch this. Need to drop the &.
data->buffer.raw is already an array.


>  	if (!ret) {
> -		iio_push_to_buffers_with_ts(indio_dev, data->buffer,
> +		iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
>  					    sizeof(data->buffer),
>  					    iio_get_time_ns(indio_dev));
>  	}
> 
> ---
> base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
> change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-3-2cc387a66bdc
> 
> Best regards,



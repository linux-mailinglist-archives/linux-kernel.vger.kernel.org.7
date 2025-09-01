Return-Path: <linux-kernel+bounces-795081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D14B3EC9E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD001A88103
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991DF2EF66A;
	Mon,  1 Sep 2025 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZHrIBw8X"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43812E041D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756745284; cv=none; b=qYaUBvQcWOKVnChJ01vrdznTBY61ih7vrhR/OFBmYR1shrEhgjM6eay1NcKxxxKmufuxSlZCKLVhOX+oaGpyHR5YJ4FigGMEFoC3LS2T61HfGvPuxFa6ibIFyRIZniDg7RlkLv2Lm30g41YrjMKa+a1swe8v7oHVTW+0/QH3z5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756745284; c=relaxed/simple;
	bh=fkryIHu4I1xIx2CWEKCdM9po9RrcPxRizn7i/jnNbiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IdWaKF7PpzG2lMFNR0C9jioV2o1WBoYHMTpQrNv9ejmGI8S8hNHrECmty8D1sVxY2wVTPYlXAjvUYL8tBOKbWB1cJ+Khh/IEs1630YadgMmFFPZUdHvx4sVRY6hzviyY+HineFzHQaMJyWP73W5tTHylGOgAIpb6uKy9cWrEcFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZHrIBw8X; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-319814953a8so547900fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756745281; x=1757350081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YmhTGKLssoVeGJ2/TQJ8RgkIS6rn9bKv2i70wU++5KI=;
        b=ZHrIBw8XBHYvgBUXr9f+x5ZTOGLA7cl6R8C2x+JzQkcVJCw187sJAe8ynhjuM8qNE9
         xGSP/ZrOHm2UnDwyBlflHa5pxtjL5m8ClpyRvRiqZ/j5BfXvF3jjudrHkwJ5M0KteWO+
         3YEd44ITmZMeOTFXyF4XzxNQgPhpN/+iaYCILAGNrKcDV579kzLhASzvzPMbiKf49HZJ
         oFbHK+3VncBHv0nDnuMr6fL85PvrZUFrI2USXZasZCtQV0/Pwg0PDc9P70Qmdr/ThYfl
         6azE08ZErPVZBkRz6UuiFVDTRYcCoKUTiNjzN6DbNROEQ1ZUmMOHdJy2NiaFC+2NphpE
         zUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756745281; x=1757350081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmhTGKLssoVeGJ2/TQJ8RgkIS6rn9bKv2i70wU++5KI=;
        b=mDkQ2yxlGmsF7yuVLZ0qS9hmtz2OmpzxrbHn55rbvPnPCHuJZ33Ct+KFvUsgcTfe3C
         QynXGz39q0IA+hBimL19hlPPAxrqO6o6sLMrn2wK0lW9kxJ8ugmUZdHzbECE8sDFTU9u
         EnIqkI4Bhn9/RMPQV7Sq4j6HhIbgYUbgEYp/EvANRtWMps+ryp/+/ZAL/Fzb/PnY0kUO
         xN1VPH0fF4mYoJF8GhuZPTZj/bfWORjaice3GtydqKdm+9Kwsn0IGmX3CojuiYsuI8eX
         hVB+W9QSgW7LzLeLf+RqNuKU4AdlJLWJopp3A5M0SwAUj4TyWpqGcUINjymwpJwTEed5
         CSdg==
X-Gm-Message-State: AOJu0YwbVN3v9XVrdO3sMxXOsH3WGdyMAiXFHRUgyHJk59w8qR3Vpf6R
	13u/HG1lh1c9sGctBckYH+pt9NXI/muQtEwWc674zRcJKPf+BOzbU4HXPa54DfKAK0Q=
X-Gm-Gg: ASbGncsCLDM/UbSki41JIHR2KVtqq3GrK3IgrhJRwDyL6qDwccpdU8BClguOdfP7iDJ
	XxYXn5lba4HKOcnQALRj09usY75UEGTRRO28kuRadErTgeEn4Hp+D3YF4bszGY6ab7tD7TJHx67
	WHdtQY31fb3l1SLq7pT8tcAZ31E1soov1B5kwcjtjeqSzflbSAGkuwxYf6JKDrOmjSLcWS2YD+G
	/JGXFJvBdTLzhbVZ2t8MEyKta2Wv1AQmGTru447N0dFeIJ78lQZamKdooCxQtSDsE3te5WGu9/B
	dJnTRrtHXahwvgwAE/MFqyDjYct4qqIxbpRV4+3EJHxffRCVw5odtIpUk2N1C8cyJ3ehn/RN6OO
	rkzyJe3EprhPe8zb/caeXFqRCOURrAemveF9zFOBzR/7urKMTrlHuuCR7dg4MulnUCIshOxO3Xc
	3VwGXNlCjHbxMj0zUsIw==
X-Google-Smtp-Source: AGHT+IFMcJUfkp0DBfp/hK2wpKwhpqBEsHP4VYRpkRr7ud68ywPh/oMdr28/f25+B6OHHS1ppf8vDg==
X-Received: by 2002:a05:6871:4b8a:b0:30b:85e1:d3ea with SMTP id 586e51a60fabf-31963183f91mr3959730fac.21.1756745279707;
        Mon, 01 Sep 2025 09:47:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3c0d:2a9:2478:d89e? ([2600:8803:e7e4:1d00:3c0d:2a9:2478:d89e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7457428c153sm1091594a34.8.2025.09.01.09.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 09:47:58 -0700 (PDT)
Message-ID: <b6c2ac13-2781-49ba-964f-ca821b32e2a2@baylibre.com>
Date: Mon, 1 Sep 2025 11:47:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: iio: adc: ad7816: add mutex to serialize
 SPI/GPIO operations
To: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, andy@kernel.org
References: <20250831153741.8820-1-moahmmad.hosseinii@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250831153741.8820-1-moahmmad.hosseinii@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/25 10:37 AM, Mohammad Amin Hosseini wrote:
> From: mohammad amin hosseini <moahmmad.hosseinii@gmail.com>
> 
> The ad7816 driver was accessing SPI and GPIO lines without
> synchronization, which could lead to race conditions when accessed
> concurrently from multiple contexts. This might result in corrupted
> readings or inconsistent GPIO states.
> 
> Introduce an io_lock mutex in the driver structure to serialize:
> - SPI transactions in ad7816_spi_read() and ad7816_spi_write()
> - GPIO pin toggling sequences
> - Updates to device state via sysfs store functions (mode, channel, oti)
> 
> The mutex ensures proper mutual exclusion and prevents race
> conditions under concurrent access.
> 
> Signed-off-by: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 4774df778de9..06567d048a6d 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -50,6 +50,7 @@ struct ad7816_chip_info {
>  	u8  oti_data[AD7816_CS_MAX + 1];
>  	u8  channel_id;	/* 0 always be temperature */
>  	u8  mode;
> +	struct mutex io_lock;	/* Protects SPI transactions and GPIO toggling */
>  };
>  
>  enum ad7816_type {
> @@ -67,13 +68,13 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  	int ret;
>  	__be16 buf;
>  
> +	mutex_lock(&chip->io_lock);

Could avoid the gotos by using:

	guard(mutex)(&chip->io_lock);

> +
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));
> -	if (ret < 0) {
> -		dev_err(&spi_dev->dev, "SPI channel setting error\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto unlock;
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  
>  	if (chip->mode == AD7816_PD) { /* operating mode 2 */
> @@ -92,13 +93,13 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  	ret = spi_read(spi_dev, &buf, sizeof(*data));
> -	if (ret < 0) {
> -		dev_err(&spi_dev->dev, "SPI data read error\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto unlock;
>  
>  	*data = be16_to_cpu(buf);
>  
> +unlock:
> +	mutex_unlock(&chip->io_lock);
>  	return ret;
>  }
>  
> @@ -107,12 +108,13 @@ static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
>  	struct spi_device *spi_dev = chip->spi_dev;
>  	int ret;
>  
> +	mutex_lock(&chip->io_lock);
> +
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	ret = spi_write(spi_dev, &data, sizeof(data));
> -	if (ret < 0)
> -		dev_err(&spi_dev->dev, "SPI oti data write error\n");
>  
> +	mutex_unlock(&chip->io_lock);
>  	return ret;
>  }
>  

...

> @@ -363,6 +371,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  	dev_set_drvdata(&spi_dev->dev, indio_dev);
>  
>  	chip->spi_dev = spi_dev;
> +	mutex_init(&chip->io_lock);

Prefer devm_mutex_init() instead.

>  	for (i = 0; i <= AD7816_CS_MAX; i++)
>  		chip->oti_data[i] = 203;
>  



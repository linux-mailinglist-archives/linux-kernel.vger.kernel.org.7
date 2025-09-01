Return-Path: <linux-kernel+bounces-795207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E5CB3EE38
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 21:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E612C0BDA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE0F320A1B;
	Mon,  1 Sep 2025 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bwXzVogp"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9414F18991E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756753232; cv=none; b=McsXQ/o35wuLBkmRoGfFkcg9iJFHq+tjciZ8FPlv6IWUwuQrpZRQGnmDTaZrs27w2dluygQiHxroMO/E9n4Z7cdYDVFtNg/4JAxWOTXxjLZn2lBJE6bufQWQj9DDTOIKyXdK7PCkyslO8m5vvJJLfsrdoQb9ZDvYjthg2YPYrrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756753232; c=relaxed/simple;
	bh=gf4IYk3K2PfGc4RTqakeHBdylqOfPRv6NkGs4SsFEQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uo9LUYXYFY8HospuyU25pLzeOJNPq83bpZNbeOsgkGx4TLRtFJI5z6qiaQ79/Cd97YsSvIk1gSebuln+MQntykUbT55+/w84RUoTNi8kUk4E/ZrBOsoH7dP2pLDsWaLi1K+PD0fFENxip5ywJ07T6SRNkpSPG2WNCbkGYNRmsu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bwXzVogp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b82a21eeeso28145115e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756753227; x=1757358027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1O8FjK66AqNnmQ/rojI71jA/rAU1P8hUrneaFUczcc=;
        b=bwXzVogpcYSzV3JE2G62cKjPxk0aCRPxWGduXwC97apqxQHJvspBQfC0DB9kitDQoa
         4sZNQ2mHZx3Bmouj3YWVJfADibhVuHi5TtYdvI0tDJmN8HIyZ9oaS5r4xXMwN0iO80dN
         Am0OfNrW9stIQ+YyWNqRzmTdmBP2eRC19jO7UwcvsxQTQW6UVgsTwHSdKrmuyReUCQMK
         dRyiRiKMCXNMMJiVuOdPRKLV/ukKe5+A+XVFxYo8+3z5j62ANgKSlDVk3bmEPxRmKYK1
         G+LRgrVt9W9hTvxc2oe31qAC1dB1B/SIx3fFZihGA51ju9Hxityp7p2XUHsRr8Z9fUJv
         G4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756753227; x=1757358027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1O8FjK66AqNnmQ/rojI71jA/rAU1P8hUrneaFUczcc=;
        b=XT+7CfUXWf0WKUkDozeV3tsz9CmAWScLtQ3mLAjYFFZ4T1Pw+fMUoWUDAaFlaSwqPd
         YmdPloJ2AvDVFTg7pnvNcAl1hXP+En//K+Qm5NDIAeCWepzlAUqBvufck2Spts7zfNtg
         i8Fi8IOO/GugZfmZBBw5UN/822A5yypgL3O9gbVXpuz6o5d5gC6ZBSYL8KV+8lZP+nLW
         c40/2ic8Eqw0KvncZ0LBRB5zqvxKi8J4WulNdU5pogOCKZMw5YqEoeV5EzwJDviP1m5u
         hAX7UZSHwfAXhNyiAfduQqaeY6u4fDRsYVFD8LNkUoVyQlUj1ZJmpOSWgUZIzzE5w3K6
         vqBg==
X-Forwarded-Encrypted: i=1; AJvYcCX/xBNJtRC2CAhELTlkSL/icYV8hO6vLtACOzqcTAQtJ8l8cQ5pMfpEqagoSt/jkB1U73FKLCLydzYFTW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydXsBUrHREVLL2fYZDcx13XjddnegUBfSuZwAhssKvyhRxYmMQ
	0a/g+MFEWuDUoWD54UjSHhw8PJfiSgxBeMPkLEj5sAZrIIXHMlorKYXuKc6v9Vgr4rc=
X-Gm-Gg: ASbGncvSS2Pg6sKuw3aZ8wONlOVH8X1ih8uBmXMnDdHQhHvLGBuG/C4c8IBI/noJbmA
	/xAjqbxhOVI16ZUT5RJUX5AXOkYES/CWwj8AlrXXG+n/M+0HBH6BYe3iekd5V1E9ws9jnuN9QSC
	QGyAghLxKzDtXDUnivmq29NR9gDb7t5PgP47lb3/8QV2M4UAgcfStO9ubtaJ4HyixHYcT/w1mQR
	akkRgWj/4n3NBccLz3HE51JOe4MoKxMlJHNxU1jK5oC2Xsc0RDG60liTb1pOPuZAS+OcmAy5IV1
	4u9QH/DlZ16Lj1lWgAjG0g9rjDpCwzTBtxQg45f9gQwl+wwHX/aprmuVZDXstGvuWlcM/KLyn9H
	KWW+5KmKmwzT5rtIlBqFWezJ84cN/vQlboH3kdg==
X-Google-Smtp-Source: AGHT+IFxJ6FYnWkikV6Isn4nA6LfF4cXVZigYTQciv2jZiVMfB4xvl9z73TVeunhELvAD8fPDorUnQ==
X-Received: by 2002:a05:600c:c4aa:b0:45b:47e1:ef69 with SMTP id 5b1f17b1804b1-45b855beda0mr67963885e9.36.1756753226813;
        Mon, 01 Sep 2025 12:00:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf270fc3fasm16179470f8f.5.2025.09.01.12.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 12:00:26 -0700 (PDT)
Date: Mon, 1 Sep 2025 22:00:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	sonic.zhang@analog.com, vapier@gentoo.org
Subject: Re: [PATCH v4] staging: iio: adc: ad7816: fix race condition in SPI
 operations
Message-ID: <aLXtRvJBrPGNmRZ3@stanley.mountain>
References: <20250901160310.399-1-moahmmad.hosseinii@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901160310.399-1-moahmmad.hosseinii@gmail.com>

On Mon, Sep 01, 2025 at 07:33:10PM +0330, Mohammad Amin Hosseini wrote:
> The ad7816 driver lacks proper synchronization around SPI operations
> and device state access. Concurrent access from multiple threads can
> lead to data corruption and inconsistent device state.
> 
> The driver performs sequences of GPIO pin manipulations followed by
> SPI transactions without any locking. Device state variables (mode,
> channel_id, oti_data) are also accessed without synchronization.
> 
> This bug was found through manual code review using static analysis
> techniques. The review focused on identifying unsynchronized access
> patterns to shared resources. Key indicators were:
> - GPIO pin state changes followed by SPI operations without atomicity
> - Shared state variables accessed from multiple sysfs entry points
> - No mutex or spinlock protection around sections
> - Potential for interleaved execution in multi-threaded environments
> 
> The review methodology involved tracing data flow paths and identifying
> points where concurrent access could corrupt device state or SPI
> communication sequences.
> 
> Add io_lock mutex to protect:
> - SPI transactions and GPIO sequences in read/write functions
> - Device state variables in sysfs show/store functions
> - Concurrent access to chip configuration
> 
> This prevents race conditions when multiple processes access the device
> simultaneously through sysfs attributes or device file operations.
> 
> Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
> 
> Signed-off-by: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
> 
> ---
> Changes in v4:
> - Added locking to reader functions (show_mode, show_channel, show_oti)
> - Fixed incomplete reader/writer synchronization that could still race
> - Ensured all device state access is properly synchronized
> - Replace sprintf() with sysfs_emit() in all sysfs show functions
> - Use sysfs_streq() instead of strcmp() for proper input parsing
> - Implement locked/unlocked SPI function variants to prevent deadlock
> - Use channel snapshot to ensure atomic read operations
> - Fix sizeof() usage in spi_read to be more explicit (sizeof(buf))
> - Make oti write operations atomic (SPI write + shadow update under lock)
> - Fix race condition in ad7816_set_oti() by taking channel_id snapshot under lock
> - Fix return type consistency (ssize_t vs int) in show functions
> - Use chip->id instead of string comparison for channel validation
> - Add explicit cast for narrowing assignment
> - Add default case for unknown chip ID validation
> - Use cansleep GPIO variants in sleepable context

Why?  This isn't described in the commit message.

(This is not a rhetorical question and the answer will change how we
approach this).

> - Improve lock documentation for protected resources
> ---
>  drivers/staging/iio/adc/ad7816.c | 210 ++++++++++++++++++++-----------
>  1 file changed, 138 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 4774df778de9..49a67e1b76f6 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -50,6 +50,15 @@ struct ad7816_chip_info {
>  	u8  oti_data[AD7816_CS_MAX + 1];
>  	u8  channel_id;	/* 0 always be temperature */
>  	u8  mode;
> +  /*
> +   * Protects:
> +   *  - SPI transactions
> +   *  - GPIO toggling
> +   *  - channel_id
> +   *  - mode
> +   *  - oti_data
> +   */

Indenting is wrong.

> +	struct mutex io_lock;
>  };
>  
>  enum ad7816_type {
> @@ -59,60 +68,71 @@ enum ad7816_type {
>  };
>  
>  /*
> - * ad7816 data access by SPI
> + * ad7816 data access by SPI - locked versions assume io_lock is held
>   */
> -static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
> +static int ad7816_spi_read_locked(struct ad7816_chip_info *chip, u8 channel, u16 *data)
>  {
>  	struct spi_device *spi_dev = chip->spi_dev;
>  	int ret;
>  	__be16 buf;
>  
> -	gpiod_set_value(chip->rdwr_pin, 1);
> -	gpiod_set_value(chip->rdwr_pin, 0);
> -	ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));
> -	if (ret < 0) {
> -		dev_err(&spi_dev->dev, "SPI channel setting error\n");
> +	gpiod_set_value_cansleep(chip->rdwr_pin, 1);
> +	gpiod_set_value_cansleep(chip->rdwr_pin, 0);
> +	/* AD7816_CS_MASK: broadcast/all-channels per hw programming model */
> +	ret = spi_write(spi_dev, &channel, sizeof(channel));
> +	if (ret < 0)
>  		return ret;
> -	}
> -	gpiod_set_value(chip->rdwr_pin, 1);
> +	gpiod_set_value_cansleep(chip->rdwr_pin, 1);
>  
>  	if (chip->mode == AD7816_PD) { /* operating mode 2 */
> -		gpiod_set_value(chip->convert_pin, 1);
> -		gpiod_set_value(chip->convert_pin, 0);
> +		gpiod_set_value_cansleep(chip->convert_pin, 1);
> +		gpiod_set_value_cansleep(chip->convert_pin, 0);
>  	} else { /* operating mode 1 */
> -		gpiod_set_value(chip->convert_pin, 0);
> -		gpiod_set_value(chip->convert_pin, 1);
> +		gpiod_set_value_cansleep(chip->convert_pin, 0);
> +		gpiod_set_value_cansleep(chip->convert_pin, 1);
>  	}
>  
>  	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
> -		while (gpiod_get_value(chip->busy_pin))
> +		while (gpiod_get_value_cansleep(chip->busy_pin))
>  			cpu_relax();
>  	}
>  
> -	gpiod_set_value(chip->rdwr_pin, 0);
> -	gpiod_set_value(chip->rdwr_pin, 1);
> -	ret = spi_read(spi_dev, &buf, sizeof(*data));
> -	if (ret < 0) {
> -		dev_err(&spi_dev->dev, "SPI data read error\n");
> +	gpiod_set_value_cansleep(chip->rdwr_pin, 0);
> +	gpiod_set_value_cansleep(chip->rdwr_pin, 1);
> +	ret = spi_read(spi_dev, &buf, sizeof(buf));
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	*data = be16_to_cpu(buf);
> +	return 0;
> +}
>  
> +static int __maybe_unused ad7816_spi_read(struct ad7816_chip_info *chip, u8 channel, u16 *data)
> +{
> +	int ret;
> +
> +	mutex_lock(&chip->io_lock);
> +	ret = ad7816_spi_read_locked(chip, channel, data);
> +	mutex_unlock(&chip->io_lock);
>  	return ret;
>  }
>  
> -static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
> +static int ad7816_spi_write_locked(struct ad7816_chip_info *chip, u8 data)
>  {
>  	struct spi_device *spi_dev = chip->spi_dev;
> -	int ret;
>  
> -	gpiod_set_value(chip->rdwr_pin, 1);
> -	gpiod_set_value(chip->rdwr_pin, 0);
> -	ret = spi_write(spi_dev, &data, sizeof(data));
> -	if (ret < 0)
> -		dev_err(&spi_dev->dev, "SPI oti data write error\n");
> +	gpiod_set_value_cansleep(chip->rdwr_pin, 1);
> +	gpiod_set_value_cansleep(chip->rdwr_pin, 0);
> +	return spi_write(spi_dev, &data, sizeof(data));
> +}
> +
> +static int __maybe_unused ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
> +{
> +	int ret;
>  
> +	mutex_lock(&chip->io_lock);
> +	ret = ad7816_spi_write_locked(chip, data);
> +	mutex_unlock(&chip->io_lock);
>  	return ret;
>  }
>  
> @@ -122,10 +142,13 @@ static ssize_t ad7816_show_mode(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7816_chip_info *chip = iio_priv(indio_dev);
> +	ssize_t ret;
> +
> +	mutex_lock(&chip->io_lock);
> +	ret = sysfs_emit(buf, "%s\n", chip->mode ? "power-save" : "full");
> +	mutex_unlock(&chip->io_lock);

This locking isn't required.  If you're deliberately racing against
yourself and you trick the driver into briefly printing that it's
in power-save mode instead of full then, you know, who cares?  You're
allowed to change the mode so you just pranked your ownself for no
reason.

>  
> -	if (chip->mode)
> -		return sprintf(buf, "power-save\n");
> -	return sprintf(buf, "full\n");
> +	return ret;
>  }
>  
>  static ssize_t ad7816_store_mode(struct device *dev,
> @@ -136,13 +159,18 @@ static ssize_t ad7816_store_mode(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7816_chip_info *chip = iio_priv(indio_dev);
>  
> -	if (strcmp(buf, "full") == 0) {
> -		gpiod_set_value(chip->rdwr_pin, 1);
> +	mutex_lock(&chip->io_lock);
> +	if (sysfs_streq(buf, "full")) {

Using sysfs_streq() is unrelated.  Don't mix unrelated stuff into the
same patch.

> +		gpiod_set_value_cansleep(chip->rdwr_pin, 1);
>  		chip->mode = AD7816_FULL;
> -	} else {
> -		gpiod_set_value(chip->rdwr_pin, 0);
> +	} else if (sysfs_streq(buf, "power-save")) {
> +		gpiod_set_value_cansleep(chip->rdwr_pin, 0);
>  		chip->mode = AD7816_PD;
> +	} else {
> +		mutex_unlock(&chip->io_lock);
> +		return -EINVAL;
>  	}
> +	mutex_unlock(&chip->io_lock);
>  
>  	return len;
>  }
> @@ -156,7 +184,7 @@ static ssize_t ad7816_show_available_modes(struct device *dev,
>  					   struct device_attribute *attr,
>  					   char *buf)
>  {
> -	return sprintf(buf, "full\npower-save\n");
> +	return sysfs_emit(buf, "full\npower-save\n");

Unrelated.

>  }
>  
>  static IIO_DEVICE_ATTR(available_modes, 0444, ad7816_show_available_modes,
> @@ -168,8 +196,13 @@ static ssize_t ad7816_show_channel(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7816_chip_info *chip = iio_priv(indio_dev);
> +	ssize_t ret;
>  
> -	return sprintf(buf, "%d\n", chip->channel_id);
> +	mutex_lock(&chip->io_lock);
> +	ret = sysfs_emit(buf, "%u\n", chip->channel_id);
> +	mutex_unlock(&chip->io_lock);
> +
> +	return ret;
>  }
>  
>  static ssize_t ad7816_store_channel(struct device *dev,
> @@ -190,17 +223,34 @@ static ssize_t ad7816_store_channel(struct device *dev,
>  		dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for %s.\n",
>  			data, indio_dev->name);
>  		return -EINVAL;
> -	} else if (strcmp(indio_dev->name, "ad7818") == 0 && data > 1) {
> -		dev_err(&chip->spi_dev->dev,
> -			"Invalid channel id %lu for ad7818.\n", data);
> -		return -EINVAL;
> -	} else if (strcmp(indio_dev->name, "ad7816") == 0 && data > 0) {
> -		dev_err(&chip->spi_dev->dev,
> -			"Invalid channel id %lu for ad7816.\n", data);
> +	}
> +
> +	switch (chip->id) {
> +	case ID_AD7816:
> +		if (data > 0) {
> +			dev_err(&chip->spi_dev->dev,
> +				"Invalid channel id %lu for ad7816.\n", data);
> +			return -EINVAL;
> +		}
> +		break;
> +	case ID_AD7818:
> +		if (data > 1) {
> +			dev_err(&chip->spi_dev->dev,
> +				"Invalid channel id %lu for ad7818.\n", data);
> +			return -EINVAL;
> +		}
> +		break;
> +	case ID_AD7817:
> +		/* AD7817 allows all channels up to AD7816_CS_MAX */
> +		break;
> +	default:
> +		dev_err(&chip->spi_dev->dev, "Unknown chip id %lu\n", chip->id);
>  		return -EINVAL;
>  	}
>  
> -	chip->channel_id = data;
> +	mutex_lock(&chip->io_lock);
> +	chip->channel_id = (u8)data;

There are way too many unrelated things happening and a bunch of them are
controversial in ways that you aren't expecting.  For example, a lot of
people (me) hate pointless casts...  We already have bounds checked data
so there is no need to cast.  If we wanted to we could declare data as a
u8, and that would also be pointless since we have to bounds check it
anyway but at least it's better than casting.

Version 3 wasn't very far off from being correct and in version 4 you
fixed the remaining locking issues I saw.  But the patch does way too
many other things too.

regards,
dan carpenter



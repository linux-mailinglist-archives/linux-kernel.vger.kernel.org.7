Return-Path: <linux-kernel+bounces-775953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B56F2B2C6B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B837D188ABD3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408CE230BE1;
	Tue, 19 Aug 2025 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BiFzRXsl"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B024D2356B9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612783; cv=none; b=CG2l1y/K+ANohROIY8Y3ec7wvf9/cCmdeztpWTRGmgvLqxqoWqzcYp+Nxrkkzd/VTsemVGjsusXs89Z9uzqaMfUnFUSHL9Sg/yZkfv7Yjd2WkrM2L37LMgS6P1dz48qNi0DfE6IbQExg15sWrPxWs20fSNnFJCgSSc5Iabdnr4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612783; c=relaxed/simple;
	bh=tcvLkDZhSYdC1JNpLYire5yRg2GM/bnYtQffZEEQXGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DqVVlYRlsCznv0gnJ0KEINGN5j4771uoJopZRn67fzZivhZoYpXAVTpIOvR8rIqs+xVIdl4jKrVQXyxayDiA56+8XIQrrW6jeYE//P8wW5lucpOW0Xpi/9RguFUJGExc4mwOj+ugDCqyUDJlH9RuKxxZbm/1pLBnTwGtf9J86TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BiFzRXsl; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-30cce83fb5fso3537146fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755612781; x=1756217581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sC03Vtb6Z+xfVGAeKON3EIuIsQUVP+6HYJOuJwwhIu4=;
        b=BiFzRXslk+oMevMPklgoSW2wLsL701J0bKGiYZSBzLwnq3xWA5RLN1utN07NVrURVC
         dP2+9qW/o7fhtgBLKBLlTJXXxRhtRfzahGxDwwiHF1k5xeIJxVNWKX/ztz61R1kSFxbJ
         mBp1HwofUuMQtwSDtTx/iMlmTrIuRfoHONBKRu/dFQ4X9AlekdzFy0i4o3ngvAC0l2d0
         qsb6jmspKoZ674tZ14ki+U9lCbjc9lp0CwWbJTDIjJiPhOtbMI11a6Hj+AarhUHsaLke
         jgqbCnwis83tR6giwQF7ILcX+/yfQ1XIBj+g8f8oVn+DxPZMdyb5DAFlUHI+ziub33gg
         zoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755612781; x=1756217581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sC03Vtb6Z+xfVGAeKON3EIuIsQUVP+6HYJOuJwwhIu4=;
        b=ZyOAO0NUP3K4BxRN5GzR9uchkA2aq+kO2wLrogQ9cR7d/lBX1A7Pybi5IMu4tH8vip
         VrEFcJCNYt8lbj3L2Lpo8K67M3cFvPujzNTlaVc5FcLP0n86rD7vLWGaBHOO3/+Gpf93
         dE5I9wdOZ7iM+DEsX6YPYUWgbWINaptXF9YFGw9R69JsiHGri40njATlWAuBeNUjeX97
         AJ9OaKxYySk4d8tkK+UuKfnx0LuvvsSuCboPHPoFhFRVAADemtYjf54zEh8PoFyGmBA2
         YQyB1sfYI2FxH/GZeSLTxjcjTwG7vP2YMi7q0KTMIXazbXRD6PxtxfCHnM5/kUzbxdQi
         os4g==
X-Forwarded-Encrypted: i=1; AJvYcCVKX9i1EupbLdJn1SkS3m009RkrjyyKMmXgZIIQRB/ppbM1aOYMBH2CF57KatjWJYnEl+VE7C3EVMoLZHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyueTCnpcIBhbOSIuNHFEwdophPjWafUJewVuTlyd+i5lhTLng2
	nQStNGS0cKLmI3+xOVrLoXFSly+EPFME8aU/Y47PpN+W0DSMDgnCp2Nh+l6b9jyiF3c=
X-Gm-Gg: ASbGncvxcYbu3vLPNiH0lA1VbcdgyrD3u2LS53tvLOBB3g63Xg6oG2P/1oJT0Tm/oUq
	oMsxpSHIVw5qfITB8tO8SK1V1dXqcGJX77hv7DFP9OmpRvqwSALVDG0QFlDVPAosw3AJU8YP3GK
	xJHDHY4Gk3OCJzxusL/tD66k6KxCqvQXkRzram00GA54xG0vsE5qQPcBDN4w3a/l82MXAV7DkL8
	cOXPtgEg7hBvlwQNepD7ExIl0gYBps4cop8oqhb67FJX0s7Bnp95kw42L02DQpml5KktRLSnAGk
	vOVTjOv8o/gfLZTRveEA4dnnGB3ShkInXU2kDbs9H6vyg6UMpk8gMRsL+o/jAOAobp2IBgIWBd6
	GGBaMg1C+8dwlAERPOqLAZCbtofyX577NV00A0mE23U8EXz6crVPQdu/qOWVuXIrNv+1wDEi8CZ
	w=
X-Google-Smtp-Source: AGHT+IE/mtp9q8E9onSsRDxS37DeKqaFV5tEDirGChhOYgu4v9D31FyRKTaNPgh6rP0QWQ29DpP8GA==
X-Received: by 2002:a05:6870:1f07:b0:2f3:e087:678d with SMTP id 586e51a60fabf-3110c0629c2mr1810405fac.11.1755612780668;
        Tue, 19 Aug 2025 07:13:00 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:990c:4d50:9c6c:f367? ([2600:8803:e7e4:1d00:990c:4d50:9c6c:f367])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439203bd13sm2416648a34.24.2025.08.19.07.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 07:13:00 -0700 (PDT)
Message-ID: <6b915b3a-8e6d-485a-9050-474bce154fec@baylibre.com>
Date: Tue, 19 Aug 2025 09:12:59 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: iio: adc: ad7816: Use spi_set_drvdata() for
 clarity
To: Salah Triki <salah.triki@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <aKRigf3TtH-x-i1C@pc>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aKRigf3TtH-x-i1C@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/25 6:39 AM, Salah Triki wrote:
> Replace the use of `dev_set_drvdata()` with the `spi_set_drvdata()`
> helper. This is functionally identical, but improves readability.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 4774df778de9..599f75103cb0 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -360,7 +360,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  		return -ENOMEM;
>  	chip = iio_priv(indio_dev);
>  	/* this is only used for device removal purposes */

This comment is no longer true. The driver does not have a .remove
callback. So we can just remove the comment and the dev_set_drvdata().

> -	dev_set_drvdata(&spi_dev->dev, indio_dev);
> +	spi_set_drvdata(spi_dev, indio_dev);
>  
>  	chip->spi_dev = spi_dev;
>  	for (i = 0; i <= AD7816_CS_MAX; i++)



Return-Path: <linux-kernel+bounces-751149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 747A6B165BF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2C23A5889
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079D02DECC2;
	Wed, 30 Jul 2025 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aSYP8dp4"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2AF1D61BC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753897622; cv=none; b=t2B5MkPJuu2JxnJCbxC+NELeFIX/ThQ+1/Dx41+9ra1gKzlKHPEE5Ofiu3pW6RgW0qk4DG0EGGk/ciclAug0eZ1Sac4kNIpOtV36SZl4jGsN3TuIor2J9jed7Z14aDNf9mGPHzKwiAkMW4wfTzl+RuWT6rlngveiEyLIts9A/7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753897622; c=relaxed/simple;
	bh=vstGY6DbCgcFoC3+TZn/4Uvo9/0rT9LK56HOh16Ijnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L21JC1Q6ldjHayxw/h4Kd2HKL/+y4smpSSi9eRvQBGkA+JJV0+E9TD5ijscdnx6S18fNg85YghhpqPWQZjBrnd9WMlbRf8E4HXwYyCSoxDxV6Po32opz7+o+iSmcEqFrZzaEOpa6dLTHi85XwN8TVjExbbS8002WNqeQrod7p1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aSYP8dp4; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-41baecbdd33so29159b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753897618; x=1754502418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8BafCbJzq5iIrs0nU1dbhPScQLFmm2TElBkzFfqp0o=;
        b=aSYP8dp48hPZ/NcismDANvc9+QvmHsBp6o/gyzThtPku+BQ1RHVKaZCP1KL2kx1pa3
         QTveOMXHLgZgJ/KrWcFvibWZaicm5fioQIFGF3qrOwEwcc/KyD/EB20OSXJWKSM9hbYa
         gz7hq5iFnpVSZatyWdDMk/Fc1ezToK9HRkvBNJ8REUgGzMMUy1ygTVRTISJu9zvGP8nN
         FUZ7Rk5gWpdIdcaT0k0SkN+/3zCrds87qpiZcWeWIUCRMifTm9y5053y/b6RwnK9uSRK
         sltYVQ3SF/eRnv2bkX/ive+pI4OdDzzXyrVyREPUzFULNioaVn6kb+HYfxcDxd/wxZon
         erZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753897618; x=1754502418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8BafCbJzq5iIrs0nU1dbhPScQLFmm2TElBkzFfqp0o=;
        b=Jrq0FTSznzhm0/FtknRCaxvDhVLI2zdsLt3F1VMelThyAAyFIQiDlh6BYf5mSqiPMo
         nPNOWfzTe77YLxmFd5uZpq5xUZ46hJ9O68NpRjrWgSuViYSbTenJhT2CguGus/as0TUw
         fuqXl7mOUyzElb79hwHmeovv/jOm39O7eZfbfKhOMw9Xy9M3t+6t1ygjVtYuvYiFquSU
         gtGXDOT1nNA8PGKDLZlvpw+aaSfgDRCQQZdTk5EjbMzTNDZ71voi2F2T9HFbCKFebu9f
         e4HCh+Q9d1qqbD/2ZI8pr+TLzOsAeE+1TRNfcuhGF4ACTA2AD9ky429mge817IWozI49
         TI4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZkQrtfD7LurYmVkD4asbOoAfkMa8tVegeRAv6R2ITiA+Oszqg7HJsOgvPIXYKWPfdOoVWP+Qs26H+SCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJxf5KD04JvFAI6HveoBHV8Umuz6cRxkbl+puc1PECrW09qTo2
	MnVBf6b2tvgYHVLR+C5dX/ROhy2a0dDZfdpwG6TeGeCj+zSIU3r28fQv0glcYP1+xQs=
X-Gm-Gg: ASbGncvIlh+aQSCEVPBLkSaZ8SmKLNdXUgeYAd1TEx0BBCJwWmf2si7vwrqoh6igdsy
	Tpau3+t/w8/XKZf24w8z4l3kSycb8nct5ANkSRU+NBqZqZUTVfynnMi0nNhWu0RchT1aia2JFkq
	FP6eKYK+dWej06S6Fb1Aff56Q8hhlW7Jv4MhVGU3m3g2zRfmgHdQ3SXthj3Fh+H1L/2mvfhjpQi
	qEkbSWEBGZ3XbZ3EfH8bR6jPyFw+w+69dSS9mic7dFizwVrgFtTwMZLrU1lps3mBb3LLA2/TONd
	jW45ndRFEIasTsBrfEUUKpNeQ82DU9YnC9NhZ7OI9fgGWrbWyV0z00oT56StOLrdU7spP1vgtRg
	O/5NP7KhuQ6LTAAEwFHYHtU8lCxv2pptSpv1GLdPnr/k+TBHIFC4Sa+93fDY/ean2ABNa4ssNmM
	4=
X-Google-Smtp-Source: AGHT+IEifJucP/eacVZAMP36FQVIR6gfU6jag+oTHFzJIvfA2TG+IFX/67SN9dFv6yILiPPBrkAEtA==
X-Received: by 2002:a05:6808:4fe1:b0:420:c2cc:ab97 with SMTP id 5614622812f47-4319b63246cmr2746868b6e.19.1753897617624;
        Wed, 30 Jul 2025 10:46:57 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1791:d65f:27a4:8c38? ([2600:8803:e7e4:1d00:1791:d65f:27a4:8c38])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-42c7d9b19e3sm2000488b6e.32.2025.07.30.10.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 10:46:57 -0700 (PDT)
Message-ID: <cf90537d-bdb3-4770-91f1-4039c727f7c6@baylibre.com>
Date: Wed, 30 Jul 2025 12:46:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: bmi270: Match ACPI ID found on newer GPD
 firmware
To: liziyao@uniontech.com, Alex Lanzano <lanzano.alex@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yao Zi <ziyao@disroot.org>, WangYuli <wangyuli@uniontech.com>,
 Jun Zhan <zhanjun@uniontech.com>
References: <20250730-bmi270-gpd-acpi-v1-1-1ffc85b17266@uniontech.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250730-bmi270-gpd-acpi-v1-1-1ffc85b17266@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/25 7:56 AM, Cryolitia PukNgae via B4 Relay wrote:
> From: Cryolitia PukNgae <liziyao@uniontech.com>
> 
> Some GPD devices ship a buggy firmware that describes on-device BMI260
> with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40,
> let's match the correct ID to detect the device. The buggy ID "BMI0160"
> is kept as well to maintain compatibility with older firmwares.
> 
> Signed-off-by: Cryolitia PukNgae <liziyao@uniontech.com>
> ---
> Some GPD devices ship a buggy firmware that describes on-device BMI260
> with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40[1],
> let's match the correct ID to detect the device. The buggy ID "BMI0160"
> is kept as well to maintain compatibility with older firmwares.
> 
> Link: http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0.41.zip
> 
> [1]. See the update nodes in the archive file above
> ---
>  drivers/iio/imu/bmi270/bmi270_i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
> index c77839b03a969f6f149c025a0305c4b9b8ac6571..b909a421ad0176ee414f2f96ff09db2297586ded 100644
> --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
> +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
> @@ -41,6 +41,8 @@ static const struct i2c_device_id bmi270_i2c_id[] = {
>  static const struct acpi_device_id bmi270_acpi_match[] = {
>  	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
>  	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
> +	/* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */

Is this supposed to say "since" instead of "sincice"?

> +	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
>  	{ }
>  };
>  
> 
> ---
> base-commit: 0db240bc077fd16cc16bcecfd7f4645bc474aa7e
> change-id: 20250206-bmi270-gpd-acpi-de4d12bce567
> 
> Best regards,



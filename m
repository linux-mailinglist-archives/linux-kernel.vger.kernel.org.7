Return-Path: <linux-kernel+bounces-830894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E051B9AD01
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724A14C505A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39B831281C;
	Wed, 24 Sep 2025 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmAW9wrD"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9F826D4E8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729979; cv=none; b=TzRO3jvrdpUvSBLdiOgnhKvCD20yhQj29xJXUN5I85A0ePmQ+KD95gbZhys/E6XgTRcqfssKR/5+lh86DPKfMKsMSwDvlLbZ6PDuNpHDkpPfT9jNV8KISVNuLbn7Qvv+6ljvO0FnIN/MJGXOnrKmipQWwlnR8nv4AcSAG+AVKzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729979; c=relaxed/simple;
	bh=RlgzAqEmJctrExkohclF3JO07Tmu3wf5hlNJ/lE7s9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiICZL0cJ2rprB03Ni25SKrLldsIBgJGvSJx3UtN4sW8wHSiiC9d+EcEkxqABRsTfJ2qj2t2Ihdx0wKMSLS1mKUOUf+sixvGOSla0Iw/MafmnqyPVczjxkyv/URpdDU6lQKfjxVdtKYZA1QCX8NbQQVzwqIguEnaTgUOPLxC7Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmAW9wrD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7800ff158d5so3821b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758729977; x=1759334777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSQu/2RCtWocxRG8xJXQfc/9cGGCdtiO/pXeSzUp62k=;
        b=fmAW9wrDc/mmS0qsAWyQ98Y7msPqpFWHKPh3TUuYnDpEiF1id91lY3V+AbMRameE5i
         qkOEpKysQS2uS70R1uOzvJIwRGiknySKfEwsRSzpRf1VSIsMCmcVaNDJozRfer1XLN4G
         4bt8RR1EnsBMKN6H55ZTbHMOlMDNGnKkzToNlxeZhU6Ixrhe96g2DhIgW2krJTLFlu8n
         Y4wdO3wXkrO2Ym6woZ8mPcz6GINDGz0NqD3krJ3gmfotX15rnVzUP8oBTC0Um/KZ364V
         idNeDRrrlXvNy2gmOVvZq7pngu9RVKpeHXCwP4GyZVyXPBC2tpwC8xnA/KEmKlGT9QpA
         N7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758729977; x=1759334777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSQu/2RCtWocxRG8xJXQfc/9cGGCdtiO/pXeSzUp62k=;
        b=vg7crC9OxFTfi2V65ke7dfJwR5EMAWmwItr1o0HqVPjSe5s4Sp44D4Q6zmlQbrwWW1
         JgxpHpHiUu5/VeAePKoM1wZTt1tTWGhGyNduTCwRRfdIJBUdOGM2LJkCT28uK2dFl4nW
         B18kz6Q9VCOUs/Y+P8K55HYT9rllsb744NStfh5ILZMjJ4yeHMID19DEqFs2RsYpPTpo
         7HF2syGlC6/ZNH+zJXOiXsn2uiW7rrKcqTXL5OqhS2XhX5rvrkeom8L741BvjeDsBCRR
         +1a+/9sKR7bstZbAaZ/BxWjLVGYBSrOOvjpgBCu7Bj+oAeUPTURGx6Vg1ryag4G+KeTm
         1XIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaMARCVr2FBVoAHL+X5zGI3gElg5KZ7dCtLna61/yvCOBZCoMEqgPQneo/Z+QZi5Ephdg7EetmjXipIsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5PAnQ+GafhDXtfxtIXTTBG+yXGA9fLj9ygSICQz+iTDuet5pd
	zP4+IGSF/AHflJWnRgoUkj0SQGtjTrBcph4WZgLcaAZwSurcVOJoUsk6
X-Gm-Gg: ASbGnctPWJHFXH0h8NJD7OmJ48vTDqXWQPFIOtqLxxJdUzot97f6fku2pr8HeE16tuK
	rR5B+8l1EAyt6y5/SMUJIVbUACYehdPJVdHqC90ZDkB/vr/RxMXK0qMUMDhsWU2USJ0iCEhRYfq
	RxKgQIRhJgmnnUj2JETtLfVIDF86YQG14PfmW9gpq7E7OLQq8YO5yfHlTmrrsVZOHzR26FDdV2R
	yaT13dSJb+aTNqIy8XV8L1wfi0gi6YvQbWUp1H42W+54zypLx6oFCPYmViVIknWsyIXhKxh4ICM
	JFIlYqc9K6W4aPNlenX+79NeeoDl9EDg5IN1eovbP+Ez+65cpodyPynaRgVVsDq2qYVrCOJkR+t
	up1URDgEvJYF7KDIwXTp2OaMMsBuvGBN91N8=
X-Google-Smtp-Source: AGHT+IGNtKUIe+fhs7JwdpbdHjDoCm1EBcvJPx7BHY+BU8eg+XY3rYFS80UFfMM6cMn1jgotagqw2A==
X-Received: by 2002:a05:6a00:139a:b0:77f:47e3:310b with SMTP id d2e1a72fcca58-780fcdfe486mr542247b3a.1.1758729976940;
        Wed, 24 Sep 2025 09:06:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f60b0d7e1sm3649468b3a.24.2025.09.24.09.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 09:06:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 09:06:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: jdelvare@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH 2/2] hwmon: (sy7636a) enable regulator only if needed
Message-ID: <25ef8eef-a4e6-436b-87cd-c77506b4b215@roeck-us.net>
References: <20250920114311.291450-1-andreas@kemnade.info>
 <20250920114311.291450-3-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920114311.291450-3-andreas@kemnade.info>

On Sat, Sep 20, 2025 at 01:43:11PM +0200, Andreas Kemnade wrote:
> Avoid having all the regulators in the SY7636A enabled all the time
> to significantly reduce current consumption. In pratical scenarios,
> the regulators are only needed when a refresh is done on the epaper
> display powered by the SY7636A. This is can save around 10mA which
> is much for this kind of devices.
> Also fixes the asymmetrical single enable call.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/hwmon/sy7636a-hwmon.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmon.c
> index e83d0e50c735..0fda69bea3b4 100644
> --- a/drivers/hwmon/sy7636a-hwmon.c
> +++ b/drivers/hwmon/sy7636a-hwmon.c
> @@ -18,14 +18,26 @@
>  
>  #include <linux/mfd/sy7636a.h>
>  
> +struct sy7636a_hwmon_data {
> +	struct regmap *regmap;
> +	struct regulator *regulator;
> +};
> +
> +
>  static int sy7636a_read(struct device *dev, enum hwmon_sensor_types type,
>  			u32 attr, int channel, long *temp)
>  {
> -	struct regmap *regmap = dev_get_drvdata(dev);
> +	struct sy7636a_hwmon_data *drvdata = dev_get_drvdata(dev);
>  	int ret, reg_val;
>  
> -	ret = regmap_read(regmap,
> +	ret = regulator_enable(drvdata->regulator);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(drvdata->regmap,
>  			  SY7636A_REG_TERMISTOR_READOUT, &reg_val);

Does that really work without delay ? Usually it takes some time for a chip
to return useful data after its power supply has been enabled.

Guenter

> +	regulator_disable(drvdata->regulator);
> +
>  	if (ret)
>  		return ret;
>  
> @@ -66,23 +78,24 @@ static const struct hwmon_chip_info sy7636a_chip_info = {
>  static int sy7636a_sensor_probe(struct platform_device *pdev)
>  {
>  	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
> -	struct regulator *regulator;
> +	struct sy7636a_hwmon_data *drvdata;
>  	struct device *hwmon_dev;
>  	int err;
>  
>  	if (!regmap)
>  		return -EPROBE_DEFER;
>  
> -	regulator = devm_regulator_get_optional(&pdev->dev, "vcom");
> -	if (IS_ERR_OR_NULL(regulator))
> -		return -EPROBE_DEFER;
> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
>  
> -	err = regulator_enable(regulator);
> -	if (err)
> -		return err;
> +	drvdata->regmap = regmap;
> +	drvdata->regulator = devm_regulator_get_optional(&pdev->dev, "vcom");
> +	if (IS_ERR_OR_NULL(drvdata->regulator))
> +		return -EPROBE_DEFER;
>  
>  	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
> -							 "sy7636a_temperature", regmap,
> +							 "sy7636a_temperature", drvdata,
>  							 &sy7636a_chip_info, NULL);
>  
>  	if (IS_ERR(hwmon_dev)) {
> @@ -102,5 +115,6 @@ static struct platform_driver sy7636a_sensor_driver = {
>  };
>  module_platform_driver(sy7636a_sensor_driver);
>  
> +MODULE_ALIAS("platform:sy7636a-temperature");
>  MODULE_DESCRIPTION("SY7636A sensor driver");
>  MODULE_LICENSE("GPL");


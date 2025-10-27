Return-Path: <linux-kernel+bounces-872324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77063C0FEF0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B52C94EA7F2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5CE319611;
	Mon, 27 Oct 2025 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OaXrUnXo"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6C2D7806
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590146; cv=none; b=GqcnBkSyDdy/lNNzg5IkVpq/mz28McI/iVU4IBT3qJxG1/LnEhcFgazXQkN+NTzmnD/yWyaR4Byh8hGUmXpAhcKhMPNK7FAdAoJa6ivNdmlGa4PF1lgdG3/utyNe+Gv7OtaJXhp8OKfutVwb1Rs+v+mfl5PXIJMWiPjcj1TTm+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590146; c=relaxed/simple;
	bh=PqKvPU0noBkdOcVjQUoD06IiGN+IODWXYRlWBSnglh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHu6wwZwLK0tu7fLYvG3viPWVECt80JXbfnbhW07FVIhYw+lnrAKEHOb/Qoc/tbWSaJiVcZhPdGwWOiDJ2DsPnlcI0u2o1Af9Ie0aZDR9GxVDWy00mQuAb+PotB3b1u4lg8Ge4zRAvyqNotz0992G3PTUXej5JVIoBT0KrYWis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OaXrUnXo; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c28ff7a42eso1678734a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761590143; x=1762194943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lvdP54SX5DIvg5ddC4TkLzn7pRZGLq9mZQ1eodiVzk4=;
        b=OaXrUnXoKv6Nsxa1PoJ+HHhXW6ISObM5qw0IKdLLmBYldolKEOpBf5X2KVC0If6gYn
         JkrH9FkdiiG7mv73n2j1hNGwS5spHo6VlL2jD9w8Ym5ArgsHLkUkERYanH891DNnZQ/2
         JV/ZNaDpGfQs0d+PonA466jBXsswabk4T7gT4vF2CNYMCa1xH+ajTy7zA/koUFpiKRNy
         Mqtf3edryksJ9lhC1cpnN6okGzGW6Dgh2CcXDnjNzxs/90gweAmoXaL/N1fDHSb6+pBt
         gntjEI22QFLyeB1kmy6MU/GzojNZlTMSnKfy2ZJ1zoHY34v+B7KjB8eoY8sj49KYjf6B
         9bjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761590143; x=1762194943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvdP54SX5DIvg5ddC4TkLzn7pRZGLq9mZQ1eodiVzk4=;
        b=VdO2x0qwFp+6T4cvWtiFlwWsq5hlWvguIVuHgormQyGTAu03xLp9U5V1DX1Z6H27tk
         0bqNDLf2ABaPNjWtdLXHtwdnpdufm8Kyjgjx6lYqltLW0kxBPg8PX5w5QhOlGcPlyVvN
         GMzVFw5G5nthFjSeBKh82E9ZXIUysd8Ti4T63gm8AqGs4+ORZ+CHjeNHvr7pfDMJj0jQ
         kpGHrddfqF/3rKU/BwRDzQS1jTlLrA2zo2/HLIxfd8pBaEJ1No/AM0JstwqyR0j/n7Wx
         KGNoclg41DNeBF4yoDjvucYmuqsxpy2wbEZ+Rx+4yEajzL1b5YJf0OrcrzD6ZOEoshfe
         Nr/w==
X-Forwarded-Encrypted: i=1; AJvYcCW2Zi3+z00ErXTvI8DZ1lakOMgb75hQuvwYxAqXk2jSYEhrMOKj8ur9N44CKSadJFDYC/hZXdu2WwudgUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU7/7E+RzFWd52GIEGYkWmtngN6xoV4NGRVpbfA75yBWQIj60f
	MDLFJackbPcGW5swDyRizFlzwSZ3BimizbiPiwuHtu+2fbT5XHZ4kGnNbf7MIZeG8keXBcZcatA
	xCzg0
X-Gm-Gg: ASbGncvNp1cKEOmTHuUKw0jtaSJlq5jSFhcUnQkkpdzLgCbcaF7HOZdlzGh5Q+qHI/O
	NxwASuHzbFkuEtMzxUIDtavEYGJGrgTcyTd3IPuQJLF30oVbh0wv7WMtJihb77+q4J9BtE681Ht
	nr18ZB/uxAh6HTg0Uc/hXcgQLZ0o5k8khx8kOV+e7/6RkVNJqfQc/+MDHIcxU/TzH9GqVHPOR7s
	Ubi3bthqToahbFM4AGx35OiSjBwKG6Bu4JboQqYVepjTUF1jqW/9rLY/fPvXZQC67c63ybEkE/Z
	4ywqmByT+k5mu72uzfskCQbvN5H0d0/cQNSamaT/e4Y0iW9524XE9ZaK5oxcAb2+CcLAZwIdA4A
	MW+UGMGT9T/L8iSBZU9gbOj+U73wRnUORCJUIJiCn9c2smWGGTVEBroxsNZwQYGVeGx+A7dpTcu
	gBKEpqNfnznilypf+5om9UThBZAMhSeJ0KjKQel+L2fcTMX/GwNw==
X-Google-Smtp-Source: AGHT+IEsmQUfxd0dOcE/jYcTPBywE5Kc9BNx03k/QXwOh0ziGd8tdi38iwIv7izg1KS44yKfbURGxQ==
X-Received: by 2002:a05:6808:188f:b0:44d:a271:fce4 with SMTP id 5614622812f47-44f6bb494e0mr343776b6e.47.1761590143393;
        Mon, 27 Oct 2025 11:35:43 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:46d5:c880:64c8:f854? ([2600:8803:e7e4:500:46d5:c880:64c8:f854])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-654ef2eff7fsm1997150eaf.17.2025.10.27.11.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 11:35:42 -0700 (PDT)
Message-ID: <0eea7e4c-ec3b-421c-8522-aa3f52b5cb13@baylibre.com>
Date: Mon, 27 Oct 2025 13:35:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: qcom-pm8xxx-xoadc: fix incorrect
 calibration values
To: Antony Kurniawan Soemardi <linux@smankusors.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251028-pm8xxx-xoadc-fix-v1-0-b000e1036e41@smankusors.com>
 <20251028-pm8xxx-xoadc-fix-v1-2-b000e1036e41@smankusors.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251028-pm8xxx-xoadc-fix-v1-2-b000e1036e41@smankusors.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 12:29 PM, Antony Kurniawan Soemardi wrote:
> On msm8960 phones, the XOADC driver was using incorrect calibration
> values:
> absolute calibration dx = 625000 uV, dy = 4 units
> ratiometric calibration dx = 1800, dy = -29041 units
> 
> As a result, reading from the IIO bus returned unexpected results:
> in_voltage_7 (USB_VBUS): 0
> in_voltage_10 (125V): 0
> 
> The issue was caused by not setting the ratiometric scale (amux_ip_rsv)
> from the predefined channels. Additionally, the downstream code always

Mentioning downstream kernels is usually a red flag. :-) 

We can justify it here though by saying that there is no documentation
available other than downstream source code, so we are just using it
as a reference.

> set the ADC_ARB_USRP_DIG_PARAM register to PM8XXX_ADC_ARB_ANA_DIG [1].
> That value does not include the SEL_SHIFT0 and SEL_SHIFT1 bits. Enabling
> those bits caused calibration errors too, so they were removed.
> 
> With these fixes, calibration now uses the correct values:
> absolute calibration dx = 625000 uV, dy = 6307 units
> ratiometric calibration dx = 1800, dy = 18249 units
> 
> Reading from the IIO bus now returns expected results:
> in_voltage_7 (USB_VBUS): 4973836
> in_voltage_10 (125V): 1249405

Would be useful to mention which hardware you tested with in case
it turns out that there is some other hardware that does require the
SHIFT0/1 bits to be set.

> 
> [1] https://github.com/LineageOS/android_kernel_sony_msm8960t/blob/93319b1e5aa343ec1c1aabcb028c5e88c7df7c01/drivers/hwmon/pm8xxx-adc.c#L407-L408
> 

Since this is a fix, it should have a Fixes: tag. And it sounds like
possibly two separate fixes. In that case, it should be two separate
patches.

> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> ---
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> index 8555f34036fb13c41ac720dc02c1dc39876e9198..a53d361456ec36b66d258041877bd96ab37838c4 100644
> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> @@ -503,10 +503,11 @@ static int pm8xxx_read_channel_rsv(struct pm8xxx_xoadc *adc,
>  		goto unlock;
>  
>  	/* Decimation factor */
> -	ret = regmap_write(adc->map, ADC_ARB_USRP_DIG_PARAM,
> -			   ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT0 |
> -			   ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT1 |
> -			   ch->decimation << ADC_DIG_PARAM_DEC_SHIFT);
> +	ret = regmap_update_bits(adc->map,
> +				 ADC_ARB_USRP_DIG_PARAM,
> +				 ADC_ARB_USRP_DIG_PARAM_DEC_RATE0 |
> +				 ADC_ARB_USRP_DIG_PARAM_DEC_RATE1,
> +				 ch->decimation << ADC_DIG_PARAM_DEC_SHIFT);

As a follow-up patch, it would be nice to update the driver to use FIELD_PREP().

I.e. remove ADC_ARB_USRP_DIG_PARAM_DEC_RATE0, ADC_ARB_USRP_DIG_PARAM_DEC_RATE1
and ADC_DIG_PARAM_DEC_SHIFT macros and replace them with one macro:

#define ADC_ARB_USRP_DIG_PARAM_DEC_RATE		GENMASK(6, 5)

Then use it like:

	ret = regmap_update_bits(adc->map,
				 ADC_ARB_USRP_DIG_PARAM,
				 ADC_ARB_USRP_DIG_PARAM_DEC_RATE,
				 FIELD_PREP(ADC_ARB_USRP_DIG_PARAM_DEC_RATE,
					    ch->decimation));

This should be done for all of the similar multi-bit fields.

>  	if (ret)
>  		goto unlock;
>  
> @@ -783,6 +784,7 @@ static int pm8xxx_xoadc_parse_channel(struct device *dev,
>  	ch->calibration = VADC_CALIB_ABSOLUTE;
>  	/* Everyone seems to use default ("type 2") decimation */
>  	ch->decimation = VADC_DEF_DECIMATION;
> +	ch->amux_ip_rsv = hwchan->amux_ip_rsv;
>  
>  	if (!fwnode_property_read_u32(fwnode, "qcom,ratiometric", &rsv)) {
>  		ch->calibration = VADC_CALIB_RATIOMETRIC;
> 



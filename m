Return-Path: <linux-kernel+bounces-749645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADADB150F4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BCB18A251C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468CF29994C;
	Tue, 29 Jul 2025 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MNFZOA4c"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D87D29617A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805314; cv=none; b=agtQoF+Zkc2+wqSHRKL7AZDzxgMDYLcQmrf5Ce91rsEk/0KgTUcsSsxuhMzkhuIw/s3tBzjtHM3FZMEclAIHmCkp9nFO1+7WVGHL06LU4B4Fc9EiA7n8f1HqtiaHEvf5kk/U0jC288gTv0YCvUD1kutdbaDwkHLQps/jZ/VUrWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805314; c=relaxed/simple;
	bh=Y9zplbesg+n+uaqGf/jqos/my3gJKcrm77xTP40xPCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhJHuJlAji7oxLeuaVckaK1lbf6gUuAaovvj/j1sN/4BVCMhsDr1TgfSpIY82BK7uv0L94wn+vTIpN6TjTGTBxhjMdCp+kViWnBVQ/olhR1R9oawTUMkdB1B+Hqp9jPcNUkysNXrmvRpeG7IJbHM8QCemJ3qjSL6aCKSat4GCFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MNFZOA4c; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-73e810dc4cdso2030020a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753805311; x=1754410111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iisZZW4Cr/AQvtrcy4WRz8ws+tzToFhKZHiBGfmsH9Y=;
        b=MNFZOA4cBh3Z4tnXgHSr8ZmPVZs+VILKkMJQHgDriuNUJnkUOhxop6HK6Z5PcMtpZH
         A7SlM+/ULh3b0W4yUpqMiDg6uIt+tW5uazk/hktbFiXogGM7l66a8woXVTdnc1ZNt847
         FLicGF0T5i+KxOQ8nzS+jDK79lBwLqcQJW10cYJ0yaDOLkqdY2QOgXrIr1Lrzt00amS8
         xV1ZelKLz8XoL7gnJGb0oksgYtHB9mIZBJOohE9w5E7n+nkPuK8nzA3ktC4SyAV05sA8
         AZMBqxXz0yOhkquTVNjkG59ZQ1eqP3d2fDsuJPH50dtl8YcY/dIxZuEueGN12AV7TRff
         BlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753805311; x=1754410111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iisZZW4Cr/AQvtrcy4WRz8ws+tzToFhKZHiBGfmsH9Y=;
        b=NZ2UId+nRb5V8MVjyHsf2AVQTngv5zgjm6cEzwxD5OuIS/8KVw94EgglPatzShzTIv
         M7mJqlXMCDe9Ec0+MHiqGxVty3DVc2/c01Qrh0SxNE7Tk+fCqYSn+0DXn1U1RuFfcTBW
         Q1/z/iM8uWLVvhI7cw0KmEMnO3cPxSU90CKO+TJQHGMEhl8fgJXY7nCzaIRTB2/OeCW7
         q7Tp8HVQl4nTrYx0JtK4PJQuJsITGampY8iJqF992vlWbLySPYcyuKtsBP2jufzCPw3W
         Svc/8SgcqvEe/dEnSssRSgUv9VTHA70S/034YYjPVfmO/t38StNfurLYPVX7mxXhsg7Y
         jyUw==
X-Forwarded-Encrypted: i=1; AJvYcCWcsSa+haJxcPP3NBLSnjvxcE8YHTCWQync4a08BPq+2S+6y9SQVVk/u2mxWrR0rWHoLi+b+L710PJNYJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGWD6BdB68Zc7GPgWn5yb8y2K5Uh7iHbbDiTCqCvgzwsrPeTA4
	ojALAjuxO8ax7HdnkjugcdZc189zRYPiM6DzsWDpnwNu4HRY2VEo4FGLlVKkMJLyHtu+OhKdnDn
	su+wh
X-Gm-Gg: ASbGncvwJOIhuH9g8AlN/yf4elcISJSVRH+wgPNLMRSw05EJ2IKB4BW8CCdF2ig4P49
	5Z6TfrP8bW3ID6BmLtES4FYKqVbVDhydPey6ORd6G+Ya7oSt9L1GDhMoGSMnnHB51oeZtRwZHQi
	FC152cCB1DaQ65KHKWpkbtiz8hX4BcYHjXRabO5UpYcX4SFit99LXRdWFlaqk3cQy+TLSy6X7L9
	HkVuHAUTMI0YwYZBfM5mGlzzFHUzUJXjJ/um/TPrlJmWkpc9AyreGHSvfzKcdi9VvfjRLj0z/1F
	9T5zbdTYF2tBnLjMUl3B27rNnJqqdi+SABgIUdc8/ENDhNiYQk+VBo270j4FHiHLfq4IA/f1fyx
	lzZJhsLx8ccfLY3I07Tq1PXn8A5tAj/dWEKiKMZ67lYsih2B1wypgBFe3SWR3QUQtddnSA01vnT
	c=
X-Google-Smtp-Source: AGHT+IFDGl5SETxkBjW/H31hwu1U5JxJwMyDzgnv3ruh05bOarPZvWxXwwo3/ACHAvk332S0oYi2Fg==
X-Received: by 2002:a05:6830:4d8b:10b0:727:3111:1416 with SMTP id 46e09a7af769-74177ca43d4mr203693a34.24.1753805311343;
        Tue, 29 Jul 2025 09:08:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c7d5:61e1:68d6:dd54? ([2600:8803:e7e4:1d00:c7d5:61e1:68d6:dd54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74147f9460csm1597928a34.17.2025.07.29.09.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 09:08:30 -0700 (PDT)
Message-ID: <1c897cf7-dc31-4e39-84c1-f8ab4b3e0aa8@baylibre.com>
Date: Tue, 29 Jul 2025 11:08:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] iio: adc: ad7124: do not require mclk
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250724-iio-adc-ad7124-proper-clock-support-v1-0-88f35db2fcaf@baylibre.com>
 <20250724-iio-adc-ad7124-proper-clock-support-v1-2-88f35db2fcaf@baylibre.com>
 <20250727132143.35a44547@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250727132143.35a44547@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/25 7:21 AM, Jonathan Cameron wrote:
> On Thu, 24 Jul 2025 18:25:23 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 

...

>> @@ -1111,21 +1112,49 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
>>  static int ad7124_setup(struct ad7124_state *st)
>>  {
>>  	struct device *dev = &st->sd.spi->dev;
>> -	unsigned int fclk, power_mode;
>> +	unsigned int power_mode;
>> +	struct clk *mclk;
>>  	int i, ret;
>>  
>> -	fclk = clk_get_rate(st->mclk);
>> -	if (!fclk)
>> -		return dev_err_probe(dev, -EINVAL, "Failed to get mclk rate\n");
>> +	/*
>> +	 * Always use full power mode for max performance. If needed, the driver
>> +	 * could be adapted to use a dynamic power mode based on the requested
>> +	 * output data rate.
>> +	 */
>> +	power_mode = AD7124_ADC_CONTROL_POWER_MODE_FULL;
>>  
>> -	/* The power mode changes the master clock frequency */
>> -	power_mode = ad7124_find_closest_match(ad7124_master_clk_freq_hz,
>> -					ARRAY_SIZE(ad7124_master_clk_freq_hz),
>> -					fclk);
>> -	if (fclk != ad7124_master_clk_freq_hz[power_mode]) {
>> -		ret = clk_set_rate(st->mclk, fclk);
>> -		if (ret)
>> -			return dev_err_probe(dev, ret, "Failed to set mclk rate\n");
>> +	/*
>> +	 * HACK: This "mclk" business is needed for backwards compatibility with
> 
> I'd drop the HACK bit of this. Whilst I understand the spirit of the comment
> that term tends to make people try to 'fix' things ;)
> 
>> +	 * old devicetrees that specified a fake clock named "mclk" to select
>> +	 * the power mode.
>> +	 */
>> +	mclk = devm_clk_get_optional_enabled(dev, "mclk");
>> +	if (IS_ERR(mclk))
>> +		return dev_err_probe(dev, PTR_ERR(mclk), "Failed to get mclk\n");
>> +
>> +	if (mclk) {
>> +		unsigned long mclk_hz;
>> +
>> +		mclk_hz = clk_get_rate(mclk);
>> +		if (!mclk_hz)
>> +			return dev_err_probe(dev, -EINVAL, "Failed to get mclk rate\n");
>> +
>> +		/*
>> +		 * This logic is a bit backwards, which is why it is considered
>> +		 * a hack and is only here for backwards compatibility. The
>> +		 * driver should be able to set the power mode as it sees fit
>> +		 * and the f_clk/mclk rate should be dynamic accordingly. But
>> +		 * here, we are selecting a fixed power mode based on the given
>> +		 * "mclk" rate.
> 
> My assumption is that someone had a board with a fixed rate clock on this pin.
> So it might not be possible to have the driver do that adjustment.
> If anyone ever adds that support, we'll have to be careful about handling fixed
> clocks.

In order to use an external clock, you have to program a register field to
allow that. Since the driver isn't doing that, we can be sure that even if
someone had an external clock, the driver was still using the internal clock.

> 
> This looks fine though.
> 
>> +		 */
>> +		power_mode = ad7124_find_closest_match(ad7124_master_clk_freq_hz,
>> +			ARRAY_SIZE(ad7124_master_clk_freq_hz), mclk_hz);
>> +
>> +		if (mclk_hz != ad7124_master_clk_freq_hz[power_mode]) {
>> +			ret = clk_set_rate(mclk, mclk_hz);
>> +			if (ret)
>> +				return dev_err_probe(dev, ret, "Failed to set mclk rate\n");
>> +		}
>>  	}


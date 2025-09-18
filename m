Return-Path: <linux-kernel+bounces-823489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8B3B86A26
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5423BF990
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F932D7DE5;
	Thu, 18 Sep 2025 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uO6yzOKv"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1C82D480D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222747; cv=none; b=pM4hBukZd+BaB7iNJ5Jy3/78+ckqKBco9dXlZATV6nlpt+oiFb4j0ENiMMB1dJxWTfsgVVT97Dz+afeZSgUQew3MJHH9Kg9UZbulDwTpJ0q1/kV8fNNaZATHe1zJY8ild58YesXwLoHnWbpNP6uMNKuCLMErCkUqudnFYBR4Mow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222747; c=relaxed/simple;
	bh=E3LZSLXMdPL95SK+eNzUYQ+vwbzIS9yTVFJp5UGnXkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEPdyDjrQ12g/2CNlV2Qa7shnhpqIkkYRexYlZde8lc6yVU78qX3SDla7NuR7DyS/Nje4M9PVBvskSUZ0hZl6xMeEjK3F7TnT/vNNJbQQqN/YfL8TL2xhrWgZh7bKzG2BMdtzyCZU27INNoR9WXy7aVM10IZ1mLW6BkAyc2ZtBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uO6yzOKv; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-621cecfcc04so694750eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758222744; x=1758827544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=um+v4dONIJk0v05u5ixJ2EK0PctWSqMZX1xGPJUVQyk=;
        b=uO6yzOKvHUrj5vWlRb7yExzuBt4XiR9P5NmhnwiJ5bDrhv3Z7Hecd53lI8VrcTd3II
         zrJRfzsTwktoU7s0CI1ssCCylnu+AgbFR2rgrGckzPm1s7kWUdkQ4l/Wnxbh1XBK1Sqg
         txFm5A42/uv01tv4x0ttQMt02T5j46PApO1ppJqN46vyFrfx2959VxxCvWgPl8Xk9Hn5
         jxswfcqlP9f8LrIm+FI9jCco3LHKSOKqLDcx5cxGXcv1MjW4agW+wZY3WA+5YJxJm5AP
         BkHi1dlGWCpBTpVo0tH1DUP6tfPQARud50O/JiatwTiFwN9t/wwdToBLf8HoVDAYvLmO
         Wd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758222744; x=1758827544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=um+v4dONIJk0v05u5ixJ2EK0PctWSqMZX1xGPJUVQyk=;
        b=ZxXRwEyHGV0f+slPapNvpJ6WUNcuWmaumMVQfvRWr9JMxER1I3dan6ZvtLlb1aYDh9
         bZepFXEQEaGeKYWqwIlOMnxrpv5AAMv8izNJZFw4KEBa+WnjXaT3NzDk5AzL6pWCm/Qt
         KWuRpZbH6tt8v06NuSVVKxvi0pmzP7RRy7CqVHY3Kb3NU5ZlPZVeOO2lqJIDZWXIIChP
         FsMm4HHt+vVXPIVN1ctWKN37jg0tB6RC4R4gRH2QRXnnM2/8/Px19fyVI+6npiVZ1wq8
         5i5w3M8p8BEiEk+NOZbLzS7pFgHThj2D+YMgHdC2YfeFp3KJLeKByDArT4735fxzi5BE
         JF2A==
X-Forwarded-Encrypted: i=1; AJvYcCWH25HtMNlFb0OnlsBPLRoIl2B75l0ftdg3lolg33+An33T3zEPkij5+Knn4Avzt3xvJRLokA0jfJXD8Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzecF+EJ4nOAbQqeornC+6fm//8X4hVEf0F45pX6j/L+wfK9Yu
	3a9wKnbF2vOXYX7X3NHVyxUp7B3xhHD+1yHFzNBR5UnBoPFnml8C3pGTd/0LGtIR0nc=
X-Gm-Gg: ASbGncsBdhsp2m0KQ0qpZwCRgDFCr0I4UFeBJN5i/awadRO6p8Ywdje6NJ+CglEqtZh
	aNz6KXgHOwh36SWIf8sOKsTlTiysuL6BOvrBp+S9mVqlaEu4tVr1M2VrNzq2OdhFNqCnYtf2qrs
	heIFTrZvKKei6hJ4FMIcEVtjwWO985Hkw4Pqj5BH+/IaXpXdJp6Xwdn+c+6vl0ZwluiThlepEIq
	TMM29SIGiUJCBu1BBMzdyXZIWjrN3fzSoqfhMQUe1nJqV7xpibV68UA9her1YGUfTVq6euhh4D7
	rRDA76dmM1Mb3iX330bhKWzZbH7tK5FiL/1MSEpg0OuRM19jsPgydc23DSkb8FTjP+Z28SooJvW
	nczAsYtF+kkstpgVZvF/x2DQiDc9QoW0t18Enwkq9t6FZVEKnF1iQbBGAe/fXd41BTY6cOEZRVW
	HwTzUhOBHbxqeMeh9ebw==
X-Google-Smtp-Source: AGHT+IEjWUgvc4lTOFTwV5s3qOByTrBRgcgcc0xXFcx8Jx0Wu7qnzn0uZbvp8NWcWQQ5wdeD4/BMIA==
X-Received: by 2002:a05:6820:2218:b0:61f:f591:8a2c with SMTP id 006d021491bc7-627256b01b1mr242474eaf.0.1758222744202;
        Thu, 18 Sep 2025 12:12:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625db105811sm995869eaf.15.2025.09.18.12.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:12:23 -0700 (PDT)
Message-ID: <5607a969-2e42-4530-94b2-caca21de11aa@baylibre.com>
Date: Thu, 18 Sep 2025 14:12:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] spi: offload: types: add offset parameter
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-spi@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Axel Haslam <ahaslam@baylibre.com>, broonie@kernel.org, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com
References: <cover.1758206554.git.marcelo.schmitt@analog.com>
 <cc049e25c9633f41eeaacc94bed5db2a1aa299d8.1758206554.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <cc049e25c9633f41eeaacc94bed5db2a1aa299d8.1758206554.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 12:34 PM, Marcelo Schmitt wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> Add an offset parameter that can be passed in the periodic trigger.
> This is useful for example when ADC drivers implement a separate periodic
> signal to trigger conversion and need offload to read the result with
> some delay.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  include/linux/spi/offload/types.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/spi/offload/types.h b/include/linux/spi/offload/types.h
> index 6f7892347871..0170fd1f42e5 100644
> --- a/include/linux/spi/offload/types.h
> +++ b/include/linux/spi/offload/types.h
> @@ -59,6 +59,7 @@ enum spi_offload_trigger_type {
>  


I think this would be a good time to add some documentation comments:

/**
 * spi_offload_trigger_periodic - configuration parameters for periodic triggers
 * @frequency_hz: The rate that the trigger should fire in Hz.
 * @offset_ns: A delay in nanoseconds between when this trigger fires
 *	compared to another trigger. This requires specialized hardware
 *	that supports such synchronization with a delay between two or
 *	more triggers. Set to 0 when not needed.
 */

>  struct spi_offload_trigger_periodic {
>  	u64 frequency_hz;
> +	u64 offset_ns;
>  };
>  
>  struct spi_offload_trigger_config {



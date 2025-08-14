Return-Path: <linux-kernel+bounces-769123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C29B26A80
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B911E9E4888
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EA520101D;
	Thu, 14 Aug 2025 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hvnhPjAD"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE27C1A256B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183701; cv=none; b=WarskmmsKMzep3rClr6YPG3bkFB1miSbSX3T1LTDRXx8KhZsTzx6yMw5hS4A9Xj0bKNvmNydhp3OsC45+RFfXyN0HtmwGvrsPxaW9MBSmrEHOx6lu8l2NojVeb55zHO7QhKNsfzRz2nZpxts3+bnYobaOopT0uvawKQk3GMLSEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183701; c=relaxed/simple;
	bh=eAX3ikxNe6MVJTImuD3GJ14HQEmQ973JjkPPycFOdDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEDlkwvzu0AymmC0NSgb3VhrNq1JvUyYVLFTv9eojbcjrSAMkBSF2DVDXHG7T/XMTT8+3LMuNNXoKKyXvEP9dNNhn/r6eCQvmwEvyRhDAEgWdxj5r5CH9NT7Sg3cARnbwnVUzWTtqJSeRH2OS3/PBU3S0oc80+c9uWDlP+ASKsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hvnhPjAD; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61bd4e24ac7so373777eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755183698; x=1755788498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+bdefBK94Sf3p8b0pm5TB+67GcihuPdogRAGM60PoM=;
        b=hvnhPjADLatwG0nLHls0CJ2kWhVd8V+0FKFB7KHcn28lDDzC6zrdyCn2XmKMrSJ6PC
         8qH9t1CMYdB6mygv0ltkT81HYaGT22Mk5C+7PHBRdTpf4HCnI2HiZMCaNQEo5bRaKOvV
         LMhtcUzD4NG/q89qzU+SRcrXplGI/1oBOFnk+B9S7/Uv78U9sY6YlAWsmD3CpDNUqWoc
         J8sYrGw8mcyfDJtoGbzDiy7LNRHaYC5YdKQ/WftVB9VuUn3UADG2ZIy+A7LKms/jLAQW
         N4+gsnhsQPzl/pfv1DHxhKESN+3eROS9V4IE7McUGlX0psqwYNLruqJbO5zNwbwwO3Kd
         pFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183698; x=1755788498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+bdefBK94Sf3p8b0pm5TB+67GcihuPdogRAGM60PoM=;
        b=lVyec35CVYtg9EYk20LrqeyT55ZwW5c5BvTZ+tT6oASBWqJwbGbvlsccmKlYwWSHtx
         lkXyg0ty3z9ztr6151fmWe2vjDwCiKL95vuWFHPqLeaFCMcP6XQ4c2y6OSzug19MfSdY
         9poTVRa6ZmnJIQUX728XX1GFuWy9rQTsY3FR3beAFXfD9Xpc1ifN+5Joi2KyCpb8e9rK
         5J/cPnySU6qe2RwK0gdprVrxGyU/m2+xyZT3/3ZTRpx8NnLYzeeqrLGoljRp1h6TPy+3
         n0TQso9Q78jqi8qngn6oDooi5NtS8n0JoiQvjq1mIiGwN4cA9DsQfVjFNo69EJe9DFwy
         o4VA==
X-Forwarded-Encrypted: i=1; AJvYcCUpaSXso94iypTDvyf6SwtVJGLf9L/pqztTBMu7ZK5SY6VRw91oDBBqBNvoaYgpkgK2PPr0qsJfTmJPwfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBax/Mx/fRjfESOb5m3IiP4MgiXNDngGm30+SAud/sQlFXdIVq
	ynTDFQM3LZnpzP2Ifbx+KcaFuC8ukPlq1Q5FzwfpE2DveMK5o0qOgzvvofvf2DcTTGM=
X-Gm-Gg: ASbGncs+T4OFd96lEfkprmmFvzi/X/G8eXzTyz7WdnJvXW/kHpH1D5F6gGx6IPl2Foo
	QmhKehDH2sq3AUl5PWl5t7YnRPaTJ18WMXXTnj/GCr/8IOPVkIf7Ky18LOvCWIySDje4ZOBauyY
	RmN0MXd/JYle7ezuad6gpEHRhzgfpqsDYGh8bt1KMOU12NWNiHuM8zcdBqR701L/wEHAlMAMcxu
	jbR8zOP+G8FTYP0n4PZxGQs+QfMNPVbQLQmUAHcgb3h4RuOzaze9+IoyM5ZEZH9onT+kbrlzGDy
	2Hf6a7Tf9tC9qEgxZp2Q+0WPgvgYYs62xtSBnXSPbgmSsLDH8D/vaevknX69Fpcwlg5BQOfAAuF
	VrmrKgMNHDbZFAT7NWqbRcxtViueI4mURScozaXCfHNo/dPHTC6cNuG/AWwL10DtiuUJ2+7JvoF
	s=
X-Google-Smtp-Source: AGHT+IGB723bs75DAprqEIh1aSatPfXgi38wq6Ht4Qk9bR/OoLw1uP5inRG9suzj74+4IyK4RgkUQQ==
X-Received: by 2002:a05:6808:4fe4:b0:435:8699:40b1 with SMTP id 5614622812f47-435df7cc62dmr1944390b6e.24.1755183696164;
        Thu, 14 Aug 2025 08:01:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2d9b:959c:3c59:5831? ([2600:8803:e7e4:1d00:2d9b:959c:3c59:5831])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ce87aa55sm1105850b6e.25.2025.08.14.08.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 08:01:35 -0700 (PDT)
Message-ID: <014487e4-f8c7-42e6-a68a-9e984002fd46@baylibre.com>
Date: Thu, 14 Aug 2025 10:01:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: adc: adc128s052: Support ROHM BD7910[0,1,2,3]
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sukrut Bellary <sbellary@baylibre.com>,
 Lothar Rubusch <l.rubusch@gmail.com>
References: <cover.1755159847.git.mazziesaccount@gmail.com>
 <e43c184fc6aa5c768045fc772b64d812fdb06254.1755159847.git.mazziesaccount@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <e43c184fc6aa5c768045fc772b64d812fdb06254.1755159847.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 3:35 AM, Matti Vaittinen wrote:
> The ROHM BD79100, BD79101, BD79102, BD79103 are very similar ADCs as the
> ROHM BD79104. The BD79100 has only 1 channel. BD79101 has 2 channels and
> the BD79102 has 4 channels. Both BD79103 and BD79104 have 4 channels,
> and, based on the data sheets, they seem identical from the software
> point-of-view.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---

One small suggestion. With that:

Reviewed-by: David Lechner <dlechner@baylibre.com>

> ---
>  drivers/iio/adc/ti-adc128s052.c | 36 +++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 81153253529e..2f2ed438cf4e 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -122,6 +122,10 @@ static const struct iio_chan_spec adc124s021_channels[] = {
>  	ADC128_VOLTAGE_CHANNEL(3),
>  };
>  
> +static const struct iio_chan_spec bd79100_channels[] = {

Even though the driver doesn't support it yet, there is a
adc121s021 [1] so would be nice to use that instead of bd79100
to keep the naming consistent.

[1]: https://www.ti.com/product/ADC121C021

> +	ADC128_VOLTAGE_CHANNEL(0),
> +};
> +


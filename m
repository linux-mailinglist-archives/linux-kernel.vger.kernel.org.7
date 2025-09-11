Return-Path: <linux-kernel+bounces-812746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1732B53C22
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8B4588138
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E1725A333;
	Thu, 11 Sep 2025 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jlMN9IQT"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8B117C21C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757618062; cv=none; b=hQUvscYR8iPSvGw71kPkYi4/TZ6hzf0GnRJjGm8gTAaQ3AyJO5BSvDFKHcgv7l4po6GZRD88kBPREP+KQzjR9u4L9vIlu1yatjQ3GXc7GxB7xU+RlfE+KpJ2HM5fqYGZ3ulIAJE4YdC6JuTOm/o4HfnMY2t2L/bvJ/MJPNdu5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757618062; c=relaxed/simple;
	bh=+suFI+idrm8tbVBw6RQ+HBmKYx+LKei3w+o4S9QMfIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=je+uAd1PnKtOL9aqgWbBtJw58QWGxuJRhjXZC0fajx3oVIzTLOJ8JS8FJ0oxgS71o/lfKncU5MiO24X1UnYvSS6ZksXDkCPot2KFE243dkSg5W7BOqa7ZWoQIQ82jy+WepnLqDdrsiKjZ9WsNh+dHGIoOuAje66J1Q+QNVTsAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jlMN9IQT; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-745a415bf72so431722a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757618059; x=1758222859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbjYXNzG+8uMQPqbjs02jQdJu30kPDTAC+8ZcrYbPZM=;
        b=jlMN9IQTZ2TOry97ijK61bU06qsc2+axe+iUWSpqgwbcvVryX/DccD8veFdRnEV4ET
         XdkWhKUQzLuKE6e3582JwLTgs0hk4gjEZTOp9VigGTrGAN9/OlicMkSOMqOd2UYPhsIE
         EPI3fI2Izzpnqzsx93WVejg/JftWNdxC1oSEreBhRsndIpR7ijMkZ7YSGO5O74e90Qtp
         g4oY3xJHbA637iMSsVZntHnRVkYRQWUiA34nddX/cxhfDxuRriGhhinVt6QS24ntCJwY
         y0exkAlIxSrRiX10fuKNjqgUWaP95U+0+muI58EMGdc8+DlN3OyDN1/WS9FwwwwGszsV
         JaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757618059; x=1758222859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbjYXNzG+8uMQPqbjs02jQdJu30kPDTAC+8ZcrYbPZM=;
        b=PO49jRO6ycGXqbxqtS3tJLdntnX1zy8H92XEEm7MFiX2AWHcX1jv5Y4rqsBgVNQrit
         yuo0DppPmw8/oTJcT98grAN8FXYczhSMnZ9LAhtHfo5zyicGuHNayyG/K/3QS5HK3a5R
         aoms35JhZaWKwiYBiVnUxlHIz2fYUtJLB1VYHmc2otbwTPkWO/grMCGS/M86Q+sDm+Ky
         Sfulfn0cX8q1UsvGozNzF0KowEJx8mFZSkZ3DnMEtjHFyI2bZ5rEYyN45124l41trc7E
         +jhn/EsPfC0SAHVTIbihMP/wjNZhjfyIqS2tn9OadM0cw9Ht4wvEqrpjwvIaXs2fPcKa
         +YTw==
X-Forwarded-Encrypted: i=1; AJvYcCVUURQkU7WVVLSilbvESxeJ3Ryuzr7DzGL4oHjLRW9pPZgd52cOZUMsIkOzKb1k7BfuD2IrGS5wvn4rgzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSsEE+hFDK+hqOg+v6VtM4KFyPQW5j6arLGz0pcYujMhPKVfAG
	W2iRzyEuoi4kevJonXu2TN2bHor87zkYQzyt8GGNtXMcxs6sopK0aN/zFwYjgzq2IGc=
X-Gm-Gg: ASbGnctFj6nB87p1oT3PqPMe7FcVFHyzV5DJs+vbpzOn5ZbhyXikuntoHvlpG9yvT7r
	n9TJjFMnU5e7NhySYrToL1j0Lcqb9FzdRRmf4geDmJst2LZsjp0DnQueF/BMVY80OOI56r3N6HG
	6ydX7HTrhLPcQuq/jhd2YQTt6QqhXFdZkIbrvGRIAGbmzD2QVECrJ6B6gRScpQuwSttXDFFGYe7
	z5efVhMvWlKQwk0wp+0XgwSio/KBO98ubwqAtIiCZYrTzL1yc7x/P9ZDdNBakS5YWS2hP0SBPIM
	hnksp5eMZzrDVi9q8Me8bmvzRVCwzxAS58CtyCU3qV/l/5KrKJm5eZKhdP+Fw5JjoxGPnXWCnWA
	tCAuaHQMY2IsDOHP6c6cfcHRZe6HXBdoLzbNqwxQrEGUqo/af8bdwbmAR2gaZj+z6ZnbN3ukjj0
	o=
X-Google-Smtp-Source: AGHT+IHWRt3mNvpfuD9mvG71VJuG/JHH61334tAU2612NEkWoiUHxRSWsgSKkz5m9U8/2/mYJTwISw==
X-Received: by 2002:a05:6808:178f:b0:439:b82f:a8 with SMTP id 5614622812f47-43b8d8a09e4mr180795b6e.13.1757618058769;
        Thu, 11 Sep 2025 12:14:18 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d684:59db:8b2a:5451? ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b82af6cf2sm386793b6e.29.2025.09.11.12.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:14:18 -0700 (PDT)
Message-ID: <f40f39a5-3115-4eef-a660-59dcd07c973f@baylibre.com>
Date: Thu, 11 Sep 2025 14:14:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] iio: accel: bma220: reset registers during init
 stage
To: Petre Rodan <petre.rodan@subdimension.ro>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
 <20250910-bma220_improvements-v2-7-e23f4f2b9745@subdimension.ro>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250910-bma220_improvements-v2-7-e23f4f2b9745@subdimension.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 2:57 AM, Petre Rodan wrote:
> Bring all configuration registers to default values during device probe().
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---

...

>  static int bma220_power(struct spi_device *spi, bool up)
> @@ -244,16 +244,43 @@ static int bma220_power(struct spi_device *spi, bool up)
>  		if (ret < 0)
>  			return ret;
>  
> -		if (up && ret == BMA220_SUSPEND_SLEEP)
> +		if (up && (ret == BMA220_SUSPEND_SLEEP))

Over 80% of existing kernel code doesn't have the unnecessary ()
on similar expressions so I think we should leave it that way.

(just seems like adding noise to me)

>  			return 0;
>  
> -		if (!up && ret == BMA220_SUSPEND_WAKE)
> +		if (!up && (ret == BMA220_SUSPEND_WAKE))
>  			return 0;
>  	}
>  
>  	return -EBUSY;
>  }
>  


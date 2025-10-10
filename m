Return-Path: <linux-kernel+bounces-848624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 666DEBCE31F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F47719A72E5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79182FBDF8;
	Fri, 10 Oct 2025 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PBX1mq5r"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D232F6198
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760119939; cv=none; b=FyTcy+0/rWNXUFWE85iwNlZtBwrFG4R6wLen7Kz3tUCGIhS6hf/4xLLX05crDxMigMusIzDQoU4jxgMw3sOTGdN/0XODAw5idvWCYjOYKXEuVlYc15gA0KEIlbQwMHQC8DHPWatL1MAVAl04zWoe+a9Wz5Vo9J2xxuyj9uUPweU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760119939; c=relaxed/simple;
	bh=5sOPNs/pVYr2aEdLdYkxtrupFFKn+aERSvll06ITe7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5SXkSj9JC0RbV6dj7eLT4taYBJo/T4l90a5U+y52SMau9eC/YnoRIrlCDnvDAG8TVjixmuKvzisz8rPiNhhqxfh8Xvd4C9YPR/V97AfWTWJAOe2ElmfstFukQ9a2kFK5LU/0HUpgKXyJilweNF7B+cGjTaeQAeRkpWPMdbfli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PBX1mq5r; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c0e357ab51so1937141a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760119936; x=1760724736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kJITi+/a5Uy4Ywybn43TGus/0RCOWKapqQ9K/U9rCqU=;
        b=PBX1mq5r9veqx2nhSMlcRzjG3ZXNZ9XKO0P3mfcjQjQD8uBRKof0H5usVKH1PJ1D3n
         OC1mFKC2hhXvY/jJCBYq/WHUNrKuJKcAW+r7pB3cWDJz26HdKJXPW+H9K9WY6Rhtl829
         Xgh4jNNgtgVJu0ZvwwopeQ0BzIwxAg3kTIViaickRGBjH9vTUwPhB7LfUj0eZwB2OC7L
         nDvQMJApSYJC7d3yw4qz5COMORlGmk/cQyeqGAwlbHLMPdo9Y37ym58fV2tzsaa6uNBF
         8ZuQV9N9+UlrMhHkI4IqrXYkfhYHGpwCkq4TMqGnj8UI+4jDyCKXpXFpM5BzLXVB3hNV
         nFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760119936; x=1760724736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJITi+/a5Uy4Ywybn43TGus/0RCOWKapqQ9K/U9rCqU=;
        b=GIjZWTvtETy8ckl4s0C5Se04wTabFkEkIvuFfD1LVLvGHc2gzbwvROoulolbnhqr6x
         QHuioF5pVzHIvilkSxwt3dBhifCAE/MAQwBPhBwwn4+233RZFebw4TnDN1qq9Rv0ThBX
         vZCAj4PRQr3+coYCzabJrw52hVWY3Gy3uzl3b/yhcU9B671dQjm4JcT6tf6cCaCmE31o
         E8UiGVHk2O1lqRpreBw1jKp6YrlapxJ66uSBJ6U6O8Z5EKLgahVuAgspj8x3rtf9uA72
         5jQImVJ88w6Sd6PgpAkjKqVZEuDDRfZZjwt9kYBlWvThwM1GjNxH6ZGP0Ca7suDuLQG4
         Ae+w==
X-Forwarded-Encrypted: i=1; AJvYcCVAk667rXFisDDHxv2uMOx5fzZatL65tUThoikB0uuvIRoyz4yl84+/dVXbmv/PUcaYuAQyxANNWEvTOb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlPtcSoH5zceuQZGY/PyWeOWsoLJfZcxY8aTE932ezq4QSwOlF
	1P+PNvF76UUaK+Ozn9XsuXAE8RlKG+XeXeJUUEyMSX4GjP8ADaQD/7BPy2Wr/8JT/gwz+AwjPup
	AdfIH
X-Gm-Gg: ASbGncvWXvcweMEe/tO8Y0DeA0agFVdgzrp72M+2OdZnHoVmZ7Ghk3DxPniUaF7YJ3i
	BER557LZoxU05R7YmlbiWdVfFiJZV/fzhnEf8vCOebiTBiUWQWL+D5+bE/e9iG0lmLEbHfTQHmk
	BP5KPG3WP6nsU3j2LAJ3W1fVLgE4oyxdXbbgAxn29jSF5SrhZhGy6lOOU8gq3xKcHkF4xFf+zmK
	GWE8OdHa6zjLiQ0bzKx40yQdHZx6p700q7Bked8bl4B9wAFgcbQ6h8iBSWMEdX5ASsQoP/tPk/t
	g62sY8uSQyRnivt3eJP8exx6SzSmFk5PHkPGC1VZ9fy34+qxf9pO1OuSAMYlv4pxOYLY29YtXZX
	v1tEFwAnJpvy/4/E+uTudjbgbKOkwlj+SD62+C3T1/uqcCAIc2h8J8z1fIQZ/VXwEtjHUL1XRO1
	q29zEsSj4nHGJ0+wYXr/RlCN6JvA==
X-Google-Smtp-Source: AGHT+IGdiPP3DRGOJKjYj4pluDC86vZ/Ybmz+/mK35EcOXVcyBnRq20OMLL70oFsIcshIMYVWisL+w==
X-Received: by 2002:a05:6830:210d:b0:746:d22b:11f2 with SMTP id 46e09a7af769-7c0df752992mr6630275a34.4.1760119936239;
        Fri, 10 Oct 2025 11:12:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6d3b:e3bd:4210:32e2? ([2600:8803:e7e4:500:6d3b:e3bd:4210:32e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f911aefasm1045881a34.31.2025.10.10.11.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 11:12:14 -0700 (PDT)
Message-ID: <07c11aae-6440-46bb-880f-80d09da1bf40@baylibre.com>
Date: Fri, 10 Oct 2025 13:12:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] iio: adc: ad4030: Add support for ADAQ4216 and
 ADAQ4224
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, ukleinek@kernel.org, michael.hennerich@analog.com,
 nuno.sa@analog.com, eblanc@baylibre.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
 marcelo.schmitt1@gmail.com
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
 <7f8a65deb597d2d26e1d1d373d70851c7cb3d3e3.1759929814.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <7f8a65deb597d2d26e1d1d373d70851c7cb3d3e3.1759929814.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/25 8:51 AM, Marcelo Schmitt wrote:

...

> +static const int adaq4216_hw_gains_db[] = {
> +	-10,	/* 1/3 V/V gain */
> +	-5,	/* 5/9 V/V gain */
> +	7,	/* 20/9 V/V gain */
> +	16,	/* 20/3 V/V gain */
> +};

This is only being used for ARRAY_SIZE() and can be dropped.

> +
> +/*
> + * Gains computed as fractions of 1000 so they can be expressed by integers.
> + */
> +static const int adaq4216_hw_gains_vpv[] = {
> +	MILLI / 3,		/* 333 */
> +	(5 * MILLI / 9),	/* 555 */
> +	(20 * MILLI / 9),	/* 2222 */
> +	(20 * MILLI / 3),	/* 6666 */
> +};
> +
> +static const int adaq4216_hw_gains_frac[][2] = {
> +	{ 1, 3 },  /* 1/3 V/V gain */
> +	{ 5, 9 },  /* 5/9 V/V gain */
> +	{ 20, 9 }, /* 20/9 V/V gain */
> +	{ 20, 3 }, /* 20/3 V/V gain */
> +};
> +

...

> @@ -432,7 +533,14 @@ static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
>  
>  	*val2 = scan_type->realbits;
>  
> -	return IIO_VAL_FRACTIONAL_LOG2;
> +	/* The LSB of the 8-bit common-mode data is always vref/256. */
> +	if (scan_type->realbits == 8 || !st->chip->has_pga)
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	*val = st->scale_avail[st->pga_index][0];
> +	*val2 = st->scale_avail[st->pga_index][1];

Instead of writing over val and val2, it would make more sense to
move the if up a bit, invert the condition, and have it return early.

> +
> +	return IIO_VAL_INT_PLUS_NANO;
>  }
>  


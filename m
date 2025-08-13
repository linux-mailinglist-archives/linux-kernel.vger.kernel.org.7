Return-Path: <linux-kernel+bounces-767490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AFCB25519
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8AE97B2A09
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4569C2D77E4;
	Wed, 13 Aug 2025 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dlEyGOU6"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C562877C2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119955; cv=none; b=q5hBIAOOr8lSukyvQhUr9IeB44l/uHaMWYvFx7Ii6mEtm0tmduXbBeiS1dM5T/T6+lQyvOQcxbmpc+DR6GGewvPpuQz6l3XeEW+g76hVV1udEQJvehfUHoUBgkgXWz825RZU4veWJytkOXqDNUMkZNplnT1pzp0GD23f+XOyHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119955; c=relaxed/simple;
	bh=5Dtc8i2j9SZ7V4cNxuQ2cMweRkAia6s3wQYOCEF0+k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FzJHE05xPe2cXYEaDQ8lkDaxLJOmdlq8SMQD3dhtrZPmZAk6z71eB84LT30Pvd2qoS16GTFl3II0ZKrU588hmmESNB1koi4GSlP4Yb6ZFREkbdtISbwQD9TTQfCz3CWG+P/P4USjInXbODdk1+MWyrqPZuYmB3O+xPKuTavTutI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dlEyGOU6; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-435de937578so208304b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755119952; x=1755724752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RAZbSGzMF2aCOavRS9phDDmLw+wZHgg5nRlBuGSNPYY=;
        b=dlEyGOU67qauKmm0S91jJ3I/RELB+Sl7XLjlf6FWkpZciybF3rko5cU1YIFkApFSvu
         HxuWRBZhDDBdOPJPy6qiEkF3hODoeL4xUer+5AL/Sdg8j4xiDs1JFqEc6S8fY/n7adbo
         vwbL+6yR9csELGEVJoKiS9CYu7Btz2GeaNwUylqoQOhT73WbTD0mEb57ZxpczkUu2ww7
         GE9F2axaXlIWpTTY28czSWeUWI8gBWPmQnygRKHylf46wzr6tUyMuG/6cC+nEDCUBQuA
         Yp5d07RJYqv49JEcZtL0OP0ub+vMh0MmEXf0J8Cre9TaNCghGqFVSvgQ40Jx6tZksfWN
         jotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755119952; x=1755724752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAZbSGzMF2aCOavRS9phDDmLw+wZHgg5nRlBuGSNPYY=;
        b=WVjHTCdyWh4gA95u1QNhbbLqg6T4ZmSko7AZpg9X++iF8DE1L4FBpYXfYKxXdn8uQG
         MHxwxiRxZHoZoixVoRWu/1S54Bz+5QqzDoExpiiMW3CB6ljWZUunFRfhU7y1XNe+3STH
         G7lZa0n0XW9JnM57HZLJ+4B73FAF/NLxNCzg41ysgDGak6Dx+F7oqB9sOsl3wRgfnsQv
         zNBk55wlvrHKWZkwOVY86Qi5TzbgTiDTNnpdY5zVC9jscC62gBzqESffMGGZMpD1GXSt
         EM2U3Cjldki8sgx90esRef11lLHtOTSDvSkwuMxlxrU3CM0SFePKYY1d5Kn2je7iDajt
         GOHw==
X-Forwarded-Encrypted: i=1; AJvYcCWH5sZR7yJCGtNDSS1kST5eAnmNTtwho9B/nPKT/wjmfNJw8EqUQPGI6r/wS17w61mPx+sYieDLp7WoVEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7rC/TevWjJswHPoCQHl4zvnRwih8biXGOpuR26EmG1SomOfNq
	7ltUdbWE1DqJ23kUgWQxzcLe9htRppK59Wn2SxJ7xLGadM8zhdyBQmoa60PXXb5/lVU=
X-Gm-Gg: ASbGncuabmClnJaflRlektW4w87KcMjeDXfxXGh+fG4MCInZ1iO0CgLWIec4r28ni8+
	Bggrp1dPjAeGUtNca6OYdcpSWnH0ZvNaCgCgG/HJAfG5Lg2O6dO3geRH2GINbseBTOlYsRMGD6V
	yzTgSWtuYqerhBuz1cdzTQ+D8Nj6YlKM6DfNlfXK//in89MqG/YdVO6Y7VcvsyIna8xdfXnnCEj
	vZ8iS0+gCLwiqgvipPa1l/dTMlqRzrsUvYrC3Jue0p4dorG8a5CzRlm56StqtyLbOvPN1VoQLkH
	FLKeKbEqlwGTFwNSPq9cLKLNIOVOiyq8/HMAVvYfQeTsX2r0JEC0h3Osyr6ufdxKINew1xqXEjV
	aeDdFdMlla4E34UdVkRLKCDcFErmY4NByQs04+K2ci0Bk5x35TLmMqb9NulztFwJIhDEqIWhm
X-Google-Smtp-Source: AGHT+IGHPcA55SVa24yWW3URShXaLfqVASGeLPjXlijGLEddyw8GnVhiSSMBPgkVFwlHujOhRbTPHQ==
X-Received: by 2002:a05:6808:4a41:10b0:435:8506:2263 with SMTP id 5614622812f47-435df7a7f40mr289564b6e.24.1755119952173;
        Wed, 13 Aug 2025 14:19:12 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ae46:dfe2:81c8:dde? ([2600:8803:e7e4:1d00:ae46:dfe2:81c8:dde])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ce856832sm844327b6e.23.2025.08.13.14.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:19:11 -0700 (PDT)
Message-ID: <00a3c27f-34a4-4e56-8f7d-4eeaa3c19556@baylibre.com>
Date: Wed, 13 Aug 2025 16:19:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] iio: mcp9600: Add support for dtbinding of
 thermocouple-type
To: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250813151614.12098-1-bcollins@watter.com>
 <20250813151614.12098-5-bcollins@watter.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250813151614.12098-5-bcollins@watter.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 10:15 AM, Ben Collins wrote:
> Adds dtbinding check for thermocouple-type and sets sensor config
> to match. Add iio info attribute to show state as well.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---

...

> @@ -447,6 +492,20 @@ static int mcp9600_probe(struct i2c_client *client)
>  	data = iio_priv(indio_dev);
>  	data->client = client;
>  
> +	/* Accept type from dt with default of Type-K. */
> +	data->thermocouple_type = THERMOCOUPLE_TYPE_K;
> +	ret = device_property_read_u32(&client->dev, "thermocouple-type",
> +				       &data->thermocouple_type);

ret is not checked. We should either check it or drop it and add
a comment explaining why it is OK to ignore the return value.

Typically, for optional properties, we would ignore only -EINVAL
meaning the property is not present and fail on other errors.

We also need another dt-bindings patch to add the default in the
bindings.

> +	if (data->thermocouple_type >= ARRAY_SIZE(mcp9600_type_map))
> +		return dev_err_probe(&client->dev, -EINVAL,
> +				     "Invalid thermocouple-type property %d.\n",
> +				     data->thermocouple_type);
> +
> +	/* Set initial config. */
> +	ret = mcp9600_config(data);
> +	if (ret < 0)
> +		return ret;
> +
>  	ch_sel = mcp9600_probe_alerts(indio_dev);
>  	if (ch_sel < 0)
>  		return ch_sel;



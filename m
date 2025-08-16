Return-Path: <linux-kernel+bounces-772218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F80B29013
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 20:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27AAB1C879A7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 18:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD9E2EA14B;
	Sat, 16 Aug 2025 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1FAVt5eW"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3160D15C15F
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755368669; cv=none; b=ZTyh3OGE7NGnGUGUgq1S3dTM5iEVSfWj5u5h2qe6oCXrzJXo0uuGEjavf5NKbapYp1HSHREFcYEou25bab8NDMMfecqtoIZMYQ2LZ3zYQkP3EEjYgkNBdOBCOKqLcCPq2znTnSTp/H6sEI5V2+oo6hp4O5HkNfTuQaNFJ/BoN4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755368669; c=relaxed/simple;
	bh=JnJIOlsGDO2UgNwnN1Ia+2CZfap16BIfk8Z5hv3zESg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8kH9EWUYsV91wKOpQsJocOw+IQ737O9LP4vB7IP0X2XapyPOPPz1YOvZdzSz6fx+Z9zdkAtg3lXBGgqBh5BFAV775+9MoOupLYzLsxacKnEF451MPwgLv9/jYoia5XKAjIjqydHyvxGbYosYWT3SXhRZeCVynzSMwTJmsA7A20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1FAVt5eW; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-74381ff668cso1579917a34.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 11:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755368666; x=1755973466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qNUlCKf+PozSMhiOiUc8QNdxtKMKbQOVsk7v2FaWGKw=;
        b=1FAVt5eWY8DS0VDeHQN1P/lVuT7fjFXnqX9KoiolRwnSg8zjv/Z7VVZm/gXVKcwEL+
         KnCAjPuJ4cLpkiipHRAoVipMG32MK/IWfkcxmW3INNm+xgBl8ddH+N/l0sjM+xcQkwa8
         gim0Kp9fq8efYBsGG+URQjY/GNvE2VIeKDxQOpQuxhc63fHl0s9/1qx/BhZ6x+ScgAhs
         NMjVhCKraYxm3CTLYIjc21Oo6wh3hpB9gnRYUDKzRg6ztdFQNzPhUpcxgMuGDWOK/ttd
         fpF5CxYn0M1E5QmlOb43cBIxixol7avtbfaECWWHQaCnVEsgcupis4CcvHJF+JegkoY+
         6bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755368666; x=1755973466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNUlCKf+PozSMhiOiUc8QNdxtKMKbQOVsk7v2FaWGKw=;
        b=UU7xSycyZZxQOYr1tXnvYrk97DGMB2oHZ9Hk3Uw3C7ImbVwCFqAHYZ9aoTb2753vea
         vZjDxh/ccmNHFpomBXWZCiprgaFOS3CYDKBPVGniN+Beu32X3puVBxAN43JNSmcVPInl
         Om0pPYCqVrUgZvSyX5RYBO5qMFEyh6nIQLNa7FUAsDTy+fxkCfNl3ogcdyaju3gG6v5o
         Rov6QVbE6qs7uOtJ6JlFUN2yJ00kRLMugH3/+V/QTDk1cZJlba2KtxQBiuC1ceUKI4de
         +5XdzvkA9fuiCBi016uZGSGgvROFMcxLVAdBUOJy7YtbSKgi7+FY81TIOkcl9PqGgwmP
         keuA==
X-Forwarded-Encrypted: i=1; AJvYcCWYtObJ9yaQGx1888VrrBAl7Q5ec4N1Rwbwv14LH9OgF61kx4QS2UtquzSZKLJvV7TNex34hNl2/Npi6wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLkeDc2XrMHdatdRpMROc8l79oidzAyRlbJ+YmRhtMPhlNQTxw
	b2wT4wr6CZCLKQMBMvCWn4Y9/a5eRWfyGHytUGroVHcAMsFQZpZAFoq2zyYjlye5Bm0=
X-Gm-Gg: ASbGncubwzjsU/ofTJfbmPGWjxKPL5cScoCtmSyGWLiF+SNzd2hrR7PJp+YWJhsMfdH
	FstX6kz8wybcNpq5ReNvQuODaFxio0dn0qmX17RhgG4DWC9yLn3V6iHofBvIj8WddVSo0nMIJoK
	/W6LASx714sbTVGufn+M80/5J9IeH/24CB+R2tuowbYeTxwrUrP8AiE3DX+o/Vf7GqionjczaRt
	jTpaWYmAXZMe67ikCKWTDDJWTT0/DOAD1wJRqc2hQIm/i70XrgxsCleAxcfkHOQeJ3GwixL68EQ
	QfFrG7eBB4yR82a41/5oVIqbZ1wgcIdLXJH+fX+C963Bv+/FrtOYW8yA6EKenlC7jL2OPFBvVod
	eMG3wsP3HSnMfh4WkdERRN/clRz+c51HrAe++YYaoYpXp4RM6ydPZFGqqX4SSxK4kYEjqAK04aF
	gYZD6HpWk=
X-Google-Smtp-Source: AGHT+IG4x9+lZonQLtZAv5o+14TpRzPIGvwvJFP8LMAyvwlY/f86+nqIN4zZje7xbJPshmzcKpQvVA==
X-Received: by 2002:a05:6830:2a8a:b0:743:823:a094 with SMTP id 46e09a7af769-743923d34b2mr4625028a34.10.1755368666249;
        Sat, 16 Aug 2025 11:24:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fcf8:116:11db:fbac? ([2600:8803:e7e4:1d00:fcf8:116:11db:fbac])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61bebfb2a02sm456819eaf.11.2025.08.16.11.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 11:24:24 -0700 (PDT)
Message-ID: <7cd6f642-b26a-45aa-a2f2-ccb7fbc28b20@baylibre.com>
Date: Sat, 16 Aug 2025 13:24:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] iio: mcp9600: Add support for thermocouple-type
To: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250815164627.22002-1-bcollins@watter.com>
 <20250815164627.22002-5-bcollins@watter.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250815164627.22002-5-bcollins@watter.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 11:46 AM, Ben Collins wrote:
> dt-bindings documentation for this driver claims to support
> thermocouple-type, but the driver does not actually make use of
> the property.
> 
> Implement usage of the property to configure the chip for the
> selected thermocouple-type.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---

...

> @@ -453,6 +504,24 @@ static int mcp9600_probe(struct i2c_client *client)
>  	data = iio_priv(indio_dev);
>  	data->client = client;
>  
> +	/* Accept type from dt with default of Type-K. */

We still also need a dt-bindings patch to specify the default there as well.

> +	data->thermocouple_type = THERMOCOUPLE_TYPE_K;
> +	ret = device_property_read_u32(&client->dev, "thermocouple-type",
> +				       &data->thermocouple_type);
> +	if (ret < 0 && ret != -EINVAL)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Error reading thermocouple-type property\n");
> +
> +	if (data->thermocouple_type >= ARRAY_SIZE(mcp9600_type_map))
> +		return dev_err_probe(&client->dev, -EINVAL,
> +				     "Invalid thermocouple-type property %u.\n",
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



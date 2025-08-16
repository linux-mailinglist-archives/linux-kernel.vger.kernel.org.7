Return-Path: <linux-kernel+bounces-772193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0B8B28FC1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997061CC316A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6292F9C23;
	Sat, 16 Aug 2025 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gOqQ0K2k"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA2E244665
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755364937; cv=none; b=PQEh6LXZZGAYd6u91IBoGeMMkYkhNfUEI/Hp+lTURNwHdSyTrbVjHsPT7uMjGrG0DGVLkMsovk4r0u7Z3K8uSaGyC5qebxFC5J4wyjEFwSaDqxNB3kxnjjZLOu/8+UGBXwnDxNlOW4ch5DgZJYwf0fLA6FN007sWcofG0uSSYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755364937; c=relaxed/simple;
	bh=uo+OncJI4Myjpz8f2aJumPsc1iN2S7NFiH4P5XJOOOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWqgredF0HmBigoI0YW2F96QuvtuO5HkHB2y4hGyCEVvDuax08GTFhS6aqWjC6cnjclu3hIqE7Kk41qEzvDPVs57QHjmTYs/iEfTcNbUp5jcnAm9+KeSMq0gKUBO82HtwoI6Xg3op/PPV66sFNz4OJCQMDUfziSXWS02Jc6sAkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gOqQ0K2k; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-30cce58bb89so2616919fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755364935; x=1755969735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ABxHftxzLrHC817RM36mVaTvJR4++06Og795T+rFPJI=;
        b=gOqQ0K2kLVhZXsQMfIO5N4M3JMsSri8urwqRoaHwe45tPq7ydsg7QJ7tyHreSHAdaT
         ZqNIY4GAdlCStKWow4mWFM38CHmoE78P38UMZnBXbUsg4URBUDKBvvxhEWkZEtVQyK9z
         jdzK/iDw0mQVBm9W7K8RWDPd6p43RR2ao07lG8G1zE8enkE8JfkSLM8oWQf5DQcdvgHq
         RGRXOhOz0ztbbyalvia5jEX4Cw07neZMoSyoeBA54LWPYlDg9cTzYSJL3oCGHsTdcNjv
         yFjgy2qrAHsszmWEV5//DnboV+xncKgqhw3PR+JmtsLAmzjYzewhTq1G66QzzzVvKUFp
         IppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755364935; x=1755969735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABxHftxzLrHC817RM36mVaTvJR4++06Og795T+rFPJI=;
        b=dJhF6J3tS+IOWm8kDnpSzo6usWXwSEk2/rV27TIvyGrBIKelNkenjCOcN52JDDeAUr
         mEHoarE5BFswelF+CnL4uuGWG+LQo80ElG0Y3if06WqFc+bEllVZo5sNCsCpDuUsPvH5
         cf7BRMUi5IuZRrS/tTz3R/7QX/HHzBlvKh7Y2/QDKHL2N3UY8QwdCbuGml4JnHCnAe7K
         Lqj/ItQQ3A4RvtYimY06aAfwJzqwBWsMB+aBp57qsO4l+zMSA3h7aFNiiF0jeju4TyVi
         30e0WlgrE9GcgV7exFaSzCpLNMonyI1wsKaiPY2YdILcjseG+g/wm/HrWF5ncAJK6foL
         te8g==
X-Forwarded-Encrypted: i=1; AJvYcCUK7+pO+esuCMN5YEcqbbbvsKEo89ZaSM2Z1JmgP6h9w3JjTv2hCaHuinKSrN8pl3PlKu3SYhu/z92QQ34=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlPVBsKwm2iEgSbJQH3h8qqNcLqiM/nrfhZnKvPkKRLjvwtRWh
	RnQAvrbZiQ+iNIACSuTqb+grII0o7xVMCeT3ZMMcq8c6OeXnxfswlg0JpcQj4UDNKWYE/apdE+b
	a2LM8
X-Gm-Gg: ASbGncvHhFaERAy1gZXEXIaENf7FDfpUtb9gOwTG7X/oxkmVHHQrS+RkNCM+idTgNfV
	gwrkTxopYo45u1bfMJs2mRI5uoXyo2CfDug95AJ3bgO2qn983/B+Lhk0mk3DyeBcAi4TgIpS3fQ
	dZy6Lhcsnzt3zi1X3Kp/CAc7tjwOoGU/4db9Yp7tNpF4xcagwXw5ouw8EFIqeXMYykPIuoEZTJc
	ZjNotvb2J+IzPspJUeqKNgh6k2GmWQbNqKIzCOfGtVDyRkS7qH9dNXdtUyM7Lg+y016bkMU+H0u
	5TuMLGJbc8kcHoUpbup/52FU69jHjeLqs3xC7/ZOH2utWgteXpBlp+y4eSQzqtjD32Cfjbyf75b
	R2e0B9gXpfY8VStZhB0yl/8iqDkRrSwUtsVrVUdB5zra2cTnfdtbn0eBgGQl/QPOamKZuHGy1
X-Google-Smtp-Source: AGHT+IF/Ida+uaip0/WJfage6wEN5F2NxxDcGtxRMU+BcoaqB7p+zdaxJBA5J2D7Usg9YF3tOg62yw==
X-Received: by 2002:a05:6870:c907:b0:30b:85a0:eb66 with SMTP id 586e51a60fabf-310aab55b9bmr3559443fac.12.1755364934826;
        Sat, 16 Aug 2025 10:22:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fcf8:116:11db:fbac? ([2600:8803:e7e4:1d00:fcf8:116:11db:fbac])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310abb34366sm1329353fac.23.2025.08.16.10.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 10:22:14 -0700 (PDT)
Message-ID: <c6fb37b0-e904-4fbc-8666-9eb747861af9@baylibre.com>
Date: Sat, 16 Aug 2025 12:22:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] iio: mcp9600: Add support for IIR filter
To: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250815164627.22002-1-bcollins@watter.com>
 <20250815164627.22002-6-bcollins@watter.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250815164627.22002-6-bcollins@watter.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 11:46 AM, Ben Collins wrote:
> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> to allow get/set of this value.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---

...

>  static int mcp9600_read(struct mcp9600_data *data,
> @@ -191,13 +200,36 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  		return IIO_VAL_INT;
> +
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 62;
>  		*val2 = 500000;
>  		return IIO_VAL_INT_PLUS_MICRO;
> +
>  	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
>  		*val = mcp9600_tc_types[data->thermocouple_type];
>  		return IIO_VAL_CHAR;
> +
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		*val = mcp_iir_coefficients_avail[data->filter_level];

We already calculated the correct values, so we should be using
those instead of made-up values.

And the suggestion of using filter_type takes care of the
turning the filter off so we don't need an "infinity" value
here.

That does bring up the question though, if the filter is off,
should this attribute return an error in that case?

> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}


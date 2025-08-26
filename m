Return-Path: <linux-kernel+bounces-787045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF03CB370C0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79A71BA128A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF5B2D4806;
	Tue, 26 Aug 2025 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B8CqnLlo"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143D2275AF9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227121; cv=none; b=rUtJ5364uZbj16m8ZOtgTkjD7U/3BVXD4A3BOqUcuKpPTUAE9JJamhKJ371nLCeeiugIzZhcSnu4FLIvCObZ+/h0lyofCNWjI4bGPDDTRtljiEWBDionJ9xiHwvQAg9t/Qu7UPn7n6GtPxPoL9NhNeopS4GWJ/qRIyF/FU/e9rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227121; c=relaxed/simple;
	bh=NUcZKV8df5rig7NX6M4s/xJBeet4lgy0T5VRXlEbfXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yg2+UNxPTR/ake0qq7/ddNS8b0jEocbgu9KWSWhYwYO8KN4TY/Ak29Jhe3FZGS+1NnQc5JiWE6aGJGX1BxrtkHm9BnJ6P+wF3SthdxMq70kziYj3ewLZ+lk/MEP6G7oyk9p4AjjOT7dUmqqNf+qgMeK/JPXmCMs5jB5Ncs9OxUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B8CqnLlo; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-437816d993eso1420358b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756227117; x=1756831917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkmnRAVuaMi37w1JYDjop35pm7ZANUoykRDCIFcP0Zw=;
        b=B8CqnLlogYZHRFxpmA2vz3GIzwgR+KFVIIgCkIXvMo2ZBiEHl4ytjNljmI1TOf78gs
         KJp791oogBdSSSkW84wbRgVb4I2sEuZTFH2i1XnN8USAfs5b1rNv8rA7+8MNmcmXmrM6
         ybPLzhBxPSKEHa536EuDTBJvh4q7M7arAvBnkwtkuC3EdZYfsFhPanw3rvlx7tpvt9Wh
         +N2mNULHKjM5zlB0Qgp7Kscq0/ZCmmJ4iOntXD0ProGLIQOex4g9iKFm0B0Yz+1aHwfR
         A3c2t/xdJqh38APkVy5Mzk1Cs6mvwbxVXWsMpTj48EQMcFO1jZ6Hiw8TjBwprBIJmeYV
         YhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756227117; x=1756831917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkmnRAVuaMi37w1JYDjop35pm7ZANUoykRDCIFcP0Zw=;
        b=nAiAiNqXBmoza6OLiwlqluLTMCA5yIRFuXoUc7syxj5RVBYSJupgR9Bh6XEQVSv5A6
         6qwrUTPKcxB6ufzYvcLy4KTE0qRw6eT8gVyWuJDTeGbkZ9zAMOS3NZNnnSLFNDlWubu9
         TSnOg/L7JGjummacR/VthP23fRC/POP/ZJoBfmm21myHTXbM+3WFTZuYgZzjLmmqKUgZ
         tJiZnd60CNBbkFC2NfTeTN9a8TLKceLyzDImqmjEn2o8npJbqoX/4+LeskS+BFCp/MVq
         TbbWKSvHXLN9P/3+KUk7zp7CE35jbcJ57kus+WITUuCHhc5kwYnBMMvUr1VqzXVoHruo
         7w9g==
X-Forwarded-Encrypted: i=1; AJvYcCUGJ+w4WRbn3c1uL9beWeOtdhm1B4ONX9nmKZ45y3O+98BgWfBTPD6+zsqXXn4uUncphFL+uM8mq0LmdiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg1sO26j/ou/BfmOVcjAWAKiU1abPHkqn7Pah0G25OSm3guaYa
	5blLdy4fCWqGtLM5C3KtcwAHYxcrZNlb4D4b+7VeK3wE/PIDJtkN28GDRFAh7wJu9aQ=
X-Gm-Gg: ASbGncuXXFg90OHXHzEYLyI+PgpfxdD01BVtIvbWi2jJ6Re+LnIva0hWoAMXXaxN44M
	0Fs+Xsx3goVK5Vx603SskxVLrjzY/c8qiTj/nMHZ67zU9kINC/VC0w16ZfmYPcH681++93WsP1Q
	HjaLfTmUPJPZKe5qvZ/wYWm/FJcJ8rwwQTDDm7htvpfF0YWUQwfMtvVNc6Orsj2MDiyiOytyyUr
	9+zZ/gjKdMv1zs2mAnpyOz30whZ0qWYQyu1vvLM27oRQYOtYt54fqVHJn5AtQulDQzSMP0jcquo
	P+mA7C5MhkQBgySNNjOJJmsySrd6Af2Bx/KS8cPEBQdB8RIOQAWAzHcfCbP55WA72rD5UMR86GJ
	sjSPOjyrJgUrRJhWhxYLOX6wxHnJ3o05GUKmtu4cgzX/kGCxqEZBOTitnD2Cnave92TDFB9bV8X
	/A2sexkFuFjA==
X-Google-Smtp-Source: AGHT+IHxBXhPEJybl7P4HEPGX9JTSlL5MLKukYLeM1w9n0qe26Izv4pejXieqDxLJKKZZHQT0HdNNA==
X-Received: by 2002:a05:6808:f16:b0:409:f8e:72a7 with SMTP id 5614622812f47-4378527a910mr6487426b6e.33.1756227117171;
        Tue, 26 Aug 2025 09:51:57 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb? ([2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-314f7a2dbffsm2514682fac.13.2025.08.26.09.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 09:51:56 -0700 (PDT)
Message-ID: <0f515c35-b2ac-4d23-b8bb-77151ed2eb9f@baylibre.com>
Date: Tue, 26 Aug 2025 11:51:56 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] iio: ad4080: Rework filter_type "none" logic
To: Ben Collins <bcollins@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
 <20250825-mcp9600-iir-v7-5-2ba676a52589@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250825-mcp9600-iir-v7-5-2ba676a52589@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/25 7:10 PM, Ben Collins wrote:
> The filter_type logic for "none" needed to be reworked to be more
> general.
> 
> As documented, return IIO_VAL_EMPTY for sampling rates in "none" type
> and EINVAL when there's an attempt to write a rate for "none" type.

This patch breaks usespace, which is something we always must avoid.

> 
> Signed-off-by: Ben Collins <bcollins@kernel.org>
> ---
>  drivers/iio/adc/ad4080.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index 6e61787ed3213fe4332bd92b938a7a717dada99f..c7408b9703731ee5d4229a85ffa91ea64b233cd9 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -154,8 +154,6 @@ static const int ad4080_dec_rate_avail[] = {
>  	2, 4, 8, 16, 32, 64, 128, 256, 512, 1024,
>  };
>  
> -static const int ad4080_dec_rate_none[] = { 1 };
> -
>  static const char * const ad4080_power_supplies[] = {
>  	"vdd33", "vdd11", "vddldo", "iovdd", "vrefin",
>  };
> @@ -268,13 +266,13 @@ static int ad4080_read_raw(struct iio_dev *indio_dev,
>  			*val = st->clk_rate;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		if (st->filter_type == FILTER_NONE) {
> -			*val = 1;
> -		} else {
> -			*val = ad4080_get_dec_rate(indio_dev, chan);
> -			if (*val < 0)
> -				return *val;
> -		}
> +		if (st->filter_type == FILTER_NONE)
> +			return IIO_VAL_EMPTY;
> +
> +		*val = ad4080_get_dec_rate(indio_dev, chan);
> +		if (*val < 0)
> +			return *val;
> +
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
> @@ -289,7 +287,7 @@ static int ad4080_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		if (st->filter_type == FILTER_NONE && val > 1)
> +		if (st->filter_type == FILTER_NONE)
>  			return -EINVAL;
>  
>  		return ad4080_set_dec_rate(indio_dev, chan, val);
> @@ -376,17 +374,16 @@ static int ad4080_read_avail(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		switch (st->filter_type) {
>  		case FILTER_NONE:
> -			*vals = ad4080_dec_rate_none;
> -			*length = ARRAY_SIZE(ad4080_dec_rate_none);
> +			*type = IIO_VAL_EMPTY;
>  			break;
>  		default:
>  			*vals = ad4080_dec_rate_avail;
>  			*length = st->filter_type >= SINC_5 ?
>  				  (ARRAY_SIZE(ad4080_dec_rate_avail) - 2) :
>  				  ARRAY_SIZE(ad4080_dec_rate_avail);
> +			*type = IIO_VAL_INT;
>  			break;
>  		}
> -		*type = IIO_VAL_INT;
>  		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;
> 

Returning a value of 1 for the oversampling ratio when there is no
oversampling going on is perfectly reasonable and mathematically correct.
So I don't consider this change an improvement.


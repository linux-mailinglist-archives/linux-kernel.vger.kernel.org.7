Return-Path: <linux-kernel+bounces-765027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 840D6B22A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3529D5A34D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A252ED15E;
	Tue, 12 Aug 2025 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ByJWkm5E"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CACA2E9EC9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008066; cv=none; b=qjjsMbD/l5JAN811eZZJUrmrSbB/hRZBVwF0m3wMTbZn1csvkbwJULG3Qcb7kij3cQoOCtrrRXsqtvFghqrfB2tPg58t//h6I/FPyPl7EYnRBO98M8IbMsbHFzrRNYbOaqLeIg8FTIdy/OpB9MVdhLAwMvf3rTpvsNyXYD+Ksdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008066; c=relaxed/simple;
	bh=VOrN2ubbBIqZL6ACC5YLGsBML4O76tGsoWugdQXqhFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NRvlZqrNJ+mqo6BgH1ixoITDh2OzDGaR02KLMr4ayfdtRbdZH/MIdiL3VPZmxDROUTeJUiHwHYBptjk3wLSbGYAgaDK9eTy2AbPqrook+SxGMS+YXiXUvt2xhco3+ohbGoBY+L9ZxURLzLxVZEdF1Lsyym55mfgdNuyCSnkESqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ByJWkm5E; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-433f984820dso3681128b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755008062; x=1755612862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S9JFvODxrp3INgeLQ2lh71r04HRljjS+BMggYVRuom4=;
        b=ByJWkm5E1YS4exYdd/GQJvLbGdzJRRpUG+aGqy0c88CR21g+5gVtCXA4jD7MPXQiLc
         XChJLMLLWjT2vI4X2hZrAi4vpg4VLl60PnNrdioQq8tdriiQsRtcCH7eu0d9eJvJM95m
         pJOip0vDu/gQrb1+XaXtf8FBZRNTYufLx7weSuyifSsygposJ4+XrnuCbq/5QAm0YP1a
         vL4YVFEaFzA/r8oirETR7A44BxAXwkKT2f7sZ8dx3aJ8eztaSLbme2wYc4VU2TjcgTLQ
         gojraIENTLlRHz/5Sz8qORB1VUbH1Tf9TCUFgAHgxSHD3JNcw6LdbERjlIeQGtYjOFgM
         AoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755008062; x=1755612862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9JFvODxrp3INgeLQ2lh71r04HRljjS+BMggYVRuom4=;
        b=JKIR5NKqfa17BIGukVCo3R1jU+Ib71mFD0e0WE91CRrlsritYA/HSe8m1H8mTOvFRX
         CGk9mVtoe93ueX0MOuiYsYbfkdJIQpui+wuKsY+/TOYRyrfCTGgY/liy0wSo74BbNHBE
         RwfMOyf1ysHuR6WVh6Fg4AXtiOjdKC+Cw5XuvPfHOLN7J+PuQTQ9uzmdkcDFhA/7aR0w
         daqNaTiidHYxUggWnSUHZq+uYAeHfCbbOW+gpidNFmpqpHMQu871XiFRr376rdt8EwJ3
         4Do0eztsWkO3BlRGgGeLbjNhGCEY6EWHXMscKmkcJWi/7IeU2Nempg1zTZZHMnGIvnMA
         2X/g==
X-Forwarded-Encrypted: i=1; AJvYcCWKbBGvWbDHaHedXv9fYnhGugL07sbuCiTAFKDyJXkA2dnLs4GFDs7SEjQy5MqD+4jt1IAmZ1Xv5t2cZp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvu1y9Ro/PMhfbioyNVsHRF1YFLjY+dXEOqx4S6njBZfuRXEIj
	PHuT9TBYrYvEqmpYf0BbvyFNIWYgd8CICfehsAHMzpmpawGIggCH8mQ6nfaFxEAst74=
X-Gm-Gg: ASbGnctXjXDj1qTCXVvB4pg9JET8WZeAqhn1dMN3lR3nhQKIjFN9cZ9oUKy7qsJagp6
	rjOwi6VziHdmRra9JZ+uyZ/r3kUNJWvgM0HJcgUTtGIy5r3SfGRwqxNS+eRg6wzUVf3F0KHNWwG
	M9bPBI2dkYjKA5XsPfrPaOaSYTuP91TKG/tDJH03oODKo1Upo74V0CGQQtOHkDbYDXXNK9F4wL+
	cQoVu7DMD5OQ4m2IXg3Lu8mbSr5Ik8kpQXuW+CiEEJYL+1zjMnoeFabp6JnvYVMgLusUBECzyq5
	jHYW2bR/uCroSH3UFMpc1qGYl4XefG2T1iT6UeJ+bFN8mH8fPQzqaUeTnkJdOWCzA1UA0tls3kf
	LBmyi3Ur7PZVQy2tPK7v8MNKis5/8V1e7MlqkqLndCEFpZFxDOYUzPTHU+0D8EbRT85FNLdsRRo
	rVYfUYbnCwQg==
X-Google-Smtp-Source: AGHT+IEtoJxvREztmmLyayeVebmTU4emvKlWvLczPhI9CWi+q8javZL4aDKPipxHraD95DmGO59i1g==
X-Received: by 2002:a05:6808:1527:b0:434:a19:b926 with SMTP id 5614622812f47-43598024f1bmr9898701b6e.37.1755008062424;
        Tue, 12 Aug 2025 07:14:22 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1fd1:71c7:ca6b:f533? ([2600:8803:e7e4:1d00:1fd1:71c7:ca6b:f533])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ce8efb8bsm194220b6e.36.2025.08.12.07.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 07:14:21 -0700 (PDT)
Message-ID: <36e135d2-0952-484f-ac6b-b753dbc1b4db@baylibre.com>
Date: Tue, 12 Aug 2025 09:14:21 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: iio_format_list() should set stride=1 for
 IIO_VAL_CHAR
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@anaog.com>, Andy Shevchenko <andy@kernel.org>
References: <vidvwybkm3vwmtopihyaj6tlvswwa5ixmgptfzpk5ujl2ixjjb@olz6275ftabs>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <vidvwybkm3vwmtopihyaj6tlvswwa5ixmgptfzpk5ujl2ixjjb@olz6275ftabs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/12/25 6:12 AM, Ben Collins wrote:
> iio_format_list() sets a stride across the val array of 1 for INT
> type, and 2 for all others. Add IIO_VAL_CHAR so it also gets a
> stride of 1 assuming val is an array of integers with char type
> values.
> 
> No drivers currently use this, but I found this issue adding an
> avail callback for IIO_INFO_THERMOCOUPLE_TYPE for a driver I'm
> working on.
> 
> Signed-off-by: Ben Collins <bcollins@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Nuno Sá <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> 
> ---
>  drivers/iio/industrialio-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 159d6c5ca3cec..eb6a54f8115de 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -790,6 +790,7 @@ static ssize_t iio_format_list(char *buf, const int *vals, int type, int length,
>  
>  	switch (type) {
>  	case IIO_VAL_INT:
> +	case IIO_VAL_CHAR:
>  		stride = 1;
>  		break;
>  	default:

Reviewed-by: David Lechner <dlechner@baylibre.com>



Return-Path: <linux-kernel+bounces-758564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E77AB1D0D7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 04:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B8916E8ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 02:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334451B4223;
	Thu,  7 Aug 2025 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UJinqgBH"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EB381741
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754532448; cv=none; b=oQN3jHgoBuOfmjOfoq4aNIUqV0HJc8Yhxd8XgkF3LsGfNUc3v2QO5C3g/1KyNnGgk6+dOp3NEQ5dNYqlZNp8CeDUJvd/By0isE0EdOVBIhSulQlph6hIHbJLc9DxjS+h1cx7Ek+H026WiFw/OJa3DAOL1U4COr1dGnpa/6ZiDhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754532448; c=relaxed/simple;
	bh=HBtduZm08CzNWE71PmJ3hjXi+bmiwcXHmAvy9wR/cew=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pG3SDTULwbaCkAXHxVhaIpvqAyq2KxdH1QVjFoIuAY8Zndlws8eLHesAiPVdNKKzrKINEQukzxzETXyIPf21teaDDhBMVitaXd+2lQYYimJY41PlF/l5ytDkHWJkZPnlGbYxOJ7spCbmXpv79zQlwRFpoLUqyqwwV5YlhxTWfUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UJinqgBH; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3004ade907bso333484fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 19:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754532445; x=1755137245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0lxZC3/m+cJBEpmd6BJGiG3LzJfwfvLfaDT4UZ4rJbk=;
        b=UJinqgBHqLxtzCDlodKaNphJeCxqnUosuU1fAMa0n/BuPboBqZGOn0iy66ove9CWtW
         +htLX2Lzv7wmbpi14wbUbSgal5bEOGRFIV/akUrv9d4/xbxA9yqtBm9wfQ2rfcNtuMXD
         UMpScedfOrUaWvOxQGweDGiMjd3ftEoUDWfz9L445I8si5tZK4vrQCqqVNIvITBAt0Qb
         IffsSsTusYBpM1d0MdmmEQI5gvQRm48pPEMssPya8l9elQyJQjbKpjE93ELE8DskYJci
         BOVXAIE1tqoY0HMZyictTK2wRedvQxZozO/VBuLxirdAjCrI3ObpILo7cZDQvcBcVjNG
         6HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754532445; x=1755137245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lxZC3/m+cJBEpmd6BJGiG3LzJfwfvLfaDT4UZ4rJbk=;
        b=Qo5TYPVszIDLvjC1Bk7pek0IZX8Usw5P/hb/EwW+NNUXdsuY4CODFayDm3kR2IwCX2
         UtOOcTh4YqLK+AMLOpsDeLoKLHQREtQKz8LEVOYO9Pg/6Vg2HI5aoJVGQx5l19CfhOHr
         0BGOSzKwUSDzSbuO9cQHEUjYaDt9nqQ2XsYAiN9H+Fc5f4jfkFv7OxRmGhY55Nifpf0N
         EQs71W+hRFctuIGcf/vRUZlhB/SHo5SWWAXCpWrSVAywLRevnUz4BAddULxMhdEgpC2w
         IaeNCUBl6o3PeZ2P26iOX6V1aA0iwc3ji2e50zg2jNMjxbhTnJ29nnVbtz561CL9M4gu
         ksEw==
X-Forwarded-Encrypted: i=1; AJvYcCXvXlc1jSsgylcOEeTivZBQkd7oys7/7IlMBpwOqqFdjJd7sOORVHjiyXOqBFr3aqqB3IGr4UmUWkcJKSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkb6nmSNMTmV4OOhtUb2ajFzVOLyFwwI/c9dMRbpGyty5z8s+X
	npKAwRt6lU96u5QmtolUutHujRQ2aTatH8TQVrp165Pi7y++PimhQOjb20NQiUXPGiA=
X-Gm-Gg: ASbGncsLZ4++1MHRfocvknjS5o0L+L3ZSXVVgFprXpCSzM2/8dG0Kf5P1acFO5d86Kf
	CyTeKbV6kfTIWe2WfmLevsohHbG6VtNiJQhTduyN4w5Nx0CN6fOnyFIMw8OTrdb05kGlHY4ujQg
	ofjETXCH1odEtXJf7Kq/9iiCJWUlN+iGYujA+ei0TS1EtPshT7qe/S4SkzQxUNdx21kZKaiF3D2
	f5+yl5rV9pgP/9ka7F8fojO2GMmAwlEPVZH3WckSMAhmREf/LEQmj10Uza/6+JgD2ccexuvO3Kh
	5VVNoivcTzlVZhVpCBmOxQmmhQciJpDforwUWngQMkkSk9syDxwOY0+/eCNrRP+cltrY3G5s1TX
	6dL80m55IJS9MLJZ93VabdYGUWD3k7eC4SNkYLHcDDkrNSIrnBeBmtiwNMFeLukdiT4NI9SyITR
	1wgFyo/nXbqQ==
X-Google-Smtp-Source: AGHT+IHiJ5GYT+LDy0yvZa+3XXEXuBRlcKah5N8pdvv4QHyH+wukBVKdpxhP94RWeXsr6iK84NuLOw==
X-Received: by 2002:a05:6871:a591:b0:2d5:336f:1b5c with SMTP id 586e51a60fabf-30be604107cmr2814704fac.34.1754532444965;
        Wed, 06 Aug 2025 19:07:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a4aa:5c40:1610:d43d? ([2600:8803:e7e4:1d00:a4aa:5c40:1610:d43d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-741b3779730sm2209142a34.50.2025.08.06.19.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 19:07:24 -0700 (PDT)
Message-ID: <d2b3fe8b-9f86-4b39-ae95-399cb7da685a@baylibre.com>
Date: Wed, 6 Aug 2025 21:07:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad9467: Replace PTR_ERR_OR_ZERO() in
 ad9467_reset()
To: Salah Triki <salah.triki@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aJQDyzoxLsF8nKYW@pc>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aJQDyzoxLsF8nKYW@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 8:39 PM, Salah Triki wrote:
> PTR_ERR_OR_ZERO() returns 0 if the argument is NULL, which can hide real
> issues when the caller expects an ERR_PTR on failure. Use a ternary
> expression instead to return the appropriate error code.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/iio/adc/ad9467.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index f7a9f46ea0dc..70aee2666ff1 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -945,7 +945,7 @@ static int ad9467_reset(struct device *dev)
>  
>  	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>  	if (IS_ERR_OR_NULL(gpio))
> -		return PTR_ERR_OR_ZERO(gpio);
> +		return gpio ? PTR_ERR(gpio) : -ENODEV;
>  
>  	fsleep(1);
>  	gpiod_set_value_cansleep(gpio, 0);

The existing code looks correct to me. The reset gpio is optional
so early return of 0 when there is no gpio seems fine. Changing it
to return an error could break existing users since it will cause
probe to fail.

Also, if the original intention was to make the gpio required, then
it should just not use devm_gpiod_get_optional() and simplify the
whole thing. But I don't think that was the intention.



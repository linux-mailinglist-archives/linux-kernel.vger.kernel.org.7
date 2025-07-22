Return-Path: <linux-kernel+bounces-740825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A89B0B0D9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D776A547A68
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5A228C5AC;
	Tue, 22 Jul 2025 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="mn8J/94c"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614B123AB8D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187583; cv=none; b=rJAXqg3oP/gtt1SQvfE9hpmgYdnx6qvOY0eJ+J8OQTBPu4aFlbeHdFmBwf/6SZza5ETdaILlF+5+QWQ53nQaNzo7cI0DfXpHvClSqBruzoeNH0t+jaOtzZQeSA0h0LYihbLJ1f6k9fhKaQpgKJt1TQZEiGi2hMJmspne+dhQV6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187583; c=relaxed/simple;
	bh=XhhXlVRw6F1HLo12SCcAfi2XIRnFu3XLfX0xBUiPuF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suZ0hdTvt2N10pf5OIvAwj/xQwXTQuYal3ZjWb0AkqPjV+8ZAhcQDXbGl3SmXrFywlVqcdLKCxF4m/RP4r3Ai1MHtOhDZfxPlJPphfl5uUGbt6GJRN5W/U7bqW6cipHuqFH6MskBhD9yLN/24XnQ5uX5VZkGG5cBj3OTfaVnvw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=mn8J/94c; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-700c7e4c048so85791586d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1753187580; x=1753792380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIXKcH5BFLN2ZbzCLvQD1G6ItZu5liVuUr8w7IySvR4=;
        b=mn8J/94ckas+qD6AHT1wxCGpWUUDbTsFqRK2rmVvvc2KJP+c37eNIDchT4R232r0V9
         JICl9zzUkYIkjSRJY+h3o7vY5fQFOEWUzjgTUBxhk89P7WAQZuQz9N6OzFIUVommiUdK
         e9DqWKT3cCZEvsSshQXzoLnD3/gWD2srsF6lHwNa3MdkuB5gTrw0HJ+4+OL/zF1OdLDD
         Hk+jE+yqqqNzVe6WvPWMGNiN97rfPjRlrMpg7EfwBZaYQ2dXdO490NqSM1YJlZ9bv0Dk
         UvL7km8+wBo8iqBB+Ir+S1c0LDEoNiURLpQn6tUSF621M0vbt/FF4pZaabKtpq6L//po
         WimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753187580; x=1753792380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIXKcH5BFLN2ZbzCLvQD1G6ItZu5liVuUr8w7IySvR4=;
        b=WedZ4arBL+HOgHjS7bOa9tegq428tI0WqWAhupAk0YqlN/T95g7GtNSFVX4XQZTeiW
         fz6AKi93YeTc60R+XoqLNdcWIspeAWTu7gT4wCPfWU4aVohot5GpPwiL2GYmSFjfaSC6
         ZifZNUhAe9o62JHjzuSpdKKPstoLtVTAk1HO3eTiwRBD44Nl0Y/Tx0Yng7CmYm9jJ7oi
         Qv+/9H6DRj8aKBx+HmLSCT7+j4RXziOItCOcFGeQauawRq9lPk0g5c3IdlP6kkRT8aB5
         ViATIb+WFCJAJpUH9GEZk8EwDj2DzrZDKrbaCq3LgTi8rpgKbZjbdJ+7xmrRllIQ2iS4
         ohTw==
X-Forwarded-Encrypted: i=1; AJvYcCVC/8C7OXpSa6jGtJKRT4TXhFD5IHssbe4VQ2wvMe2jS22gf35uqi6ipCY4MrTsKn9jw+2Uta3oSQagm4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfAAcLpxwhaWZRltNfdN83rDKQOvErp+AwuUbG8+FgzdeFE8XC
	e2MEDxqOnRCgGVkofe0mzUkVDd+5Riot8MWmD5RTrprPC2q7Sr9Iv+LGeCSlBOjGZnQ=
X-Gm-Gg: ASbGncuP6LgJsxtkpLq0BUmaxvXnmUB7+ExbwuFSi/4DGKi2dlwt8X0YyRLvFVEqkck
	HOnbA7WWGHmBYwAoCLcuCUeh3iyh4FkoEcmPFrnA8/jQFukWNDO2jN6S3M3TmWd5XoFnSj+1cls
	8R7qUrSkwOsxomiqIOs8VPFfC1Hgw69ICEd/oM4ygv+C6ieP8V7khgu8ys4wRCCdjCGhNGc79iU
	c6mJUBO8TtGIop1EbMfRuqtp0ULI1DKgkAqz77xXtv+7+2ez4e49YYDCE7zL7CiyGVMBIVgSYMg
	qitIzenytaHvK0Yn6oXofCADl2TrzKJFKBp9k6DZXNwq8QA77wSr4WeqvqYG4EJnQE+dpmk7NpS
	Ab1owoEylERevCeeqOhOv3Wgi6RY+QCE35n9U7RtqiM/Uic0yAKxJJqjVwkVSxBM8zKd9/hI=
X-Google-Smtp-Source: AGHT+IG1XORWN4jprJEi5Zq8+C3EGaNg8eBzovmEwMCoERAkUr764LT8y1WytHb49WzOljrg37pQSg==
X-Received: by 2002:a05:6214:5886:b0:6fa:c2a4:f806 with SMTP id 6a1803df08f44-7051a11461dmr225240826d6.29.1753187578843;
        Tue, 22 Jul 2025 05:32:58 -0700 (PDT)
Received: from [10.211.55.5] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051baa8760sm50251346d6.92.2025.07.22.05.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 05:32:58 -0700 (PDT)
Message-ID: <d6f147bf-2816-47d7-9a48-47562b8dde06@riscstar.com>
Date: Tue, 22 Jul 2025 07:32:56 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: spacemit: ccu_pll: fix error return value in
 recalc_rate callback
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>, mturquette@baylibre.com,
 sboyd@kernel.org, dlan@gentoo.org, heylenay@4d2.org, inochiama@outlook.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heylenay@outlook.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 unicornxdotw@foxmail.com, jszhang@kernel.org,
 zhangmeng.kevin@linux.spacemit.com, akhileshpatilvnit@gmail.com,
 skhan@linuxfoundation.org
References: <aH6P3lChCXhi3pe4@bhairav-test.ee.iitb.ac.in>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aH6P3lChCXhi3pe4@bhairav-test.ee.iitb.ac.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/25 2:07 PM, Akhilesh Patil wrote:
> Return 0 instead of -EINVAL if function ccu_pll_recalc_rate() fails to
> get correct rate entry. Follow .recalc_rate callback documentation
> as mentioned in include/linux/clk-provider.h for error return value.

"If the driver cannot figure out a rate for this clock, it
must return 0."

Looks good.

Reviewed-by: Alex Elder <elder@riscstar.com>

> 
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---
>   drivers/clk/spacemit/ccu_pll.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/spacemit/ccu_pll.c b/drivers/clk/spacemit/ccu_pll.c
> index 4427dcfbbb97..45f540073a65 100644
> --- a/drivers/clk/spacemit/ccu_pll.c
> +++ b/drivers/clk/spacemit/ccu_pll.c
> @@ -122,7 +122,7 @@ static unsigned long ccu_pll_recalc_rate(struct clk_hw *hw,
>   
>   	WARN_ON_ONCE(!entry);
>   
> -	return entry ? entry->rate : -EINVAL;
> +	return entry ? entry->rate : 0;
>   }
>   
>   static long ccu_pll_round_rate(struct clk_hw *hw, unsigned long rate,



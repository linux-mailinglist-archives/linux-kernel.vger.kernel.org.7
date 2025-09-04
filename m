Return-Path: <linux-kernel+bounces-801074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98274B43F7A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C3BAB61742
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A288214236;
	Thu,  4 Sep 2025 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNGBbHAs"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD115E5BB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997202; cv=none; b=eSPxpENxJQ0gCgNcSWpLQGyyZhpQ2adKoMpjd0Emh6ZLcTfOgz/1qNkrJDkVnJf2TqGDerlBa8ppgUcV4NN4Wf2TZ9/R9Qsl7WdV6JcOHSuhGN9fSnMY0A1hTCXGc/MWgKSJrAugIU2PawkGy41lWTRViuiyTJAy8a0doHjnspU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997202; c=relaxed/simple;
	bh=J2ZgLS9pNh/PSzEYpgg+p/RMTuuHFmaev7qtLtrDkgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbf+sPxzNpfzpa+NqYA5O1VHk8m5hk3KUT2MVS22SrBv57SI1YrB73t5MLLIURXCF66aDZBH/26WiFFf5l9b0XBE2L5QQFqi5yVaKvO1wRaKg3+WxJdNzOsDuvWdnurvC6ocKDg4f7zy8x02YqSziL8paycOOE6T34uQFA/vzEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VNGBbHAs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so7605945e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756997199; x=1757601999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rie4NtT+lhI/VU3pftqdPT332lGA5fFGRROI4ZDW40c=;
        b=VNGBbHAsPo0T95eMFPU9fRdz3+Nxi/3TenssQlC1Gk5P3qe5uu+JzSMepiZSKeQKxL
         nr/dubDiHMECRE9cWYiPRaSkZfqiyQhSqUcLA1+UK0DsFIKYmA1he2fwvPlSkXJgHUgz
         eL4LZLko8olxg1Ib2MGsrsM4vvcPRrTSO5J8ujwVrZcsxg2Y3GuuJlDxQGhXcsxYfIQa
         ioXE5YJdY9JWmXS3KjK/iFZ7aEhNxFEoXfgDwoEvH7KBhchJczQSIis/yL9K5wLK7Wj+
         2YNs/G6cBa4DUWWtUNvwG76diwCT76vnE/TLnTTYRYIVnc8A1PZxhDTGYn9h9gD2cQ0K
         bBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756997199; x=1757601999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rie4NtT+lhI/VU3pftqdPT332lGA5fFGRROI4ZDW40c=;
        b=ds6wPnq9V+s5NC5iuYuh7w7Sk2hPa69XrKQ9+xu7cUpUy37UzrDwiLKj2C1QasSqoW
         awm1Oq4TEg2JSkIsTE4r25DI3EerrHMpSCv+006oG1HRllmQQf8/wkYUCwdJXhTCcP/Z
         M48wGENAfDig/69zcd5CwKv8gJujPB/Vw1SduayS2oMj5XWZMboQ0TtP74kErhel9n+U
         3WdE0Fl/lFqev5cxVbUczNuuuWrDKFSB7D+eOIeLcCCMCV45HAOqQujMV5M2/h9gE8KU
         rrkQYHttB/yODE/9+XpwE65ow/QUbeZDw5GvlmWZ7F2M9toyr/cWxTzJOli1EwohDY5Z
         K/Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVA2eeqg+Uvo6uOA5e95PIzd8PNOkwDxzn0tNO0vW2sjnyHdBNtv/MOQWTshR1kXafWD0dCbplQt+g220U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNNsq2jyfwYb4D22hWD1JemSEIFi0BtmkqFgubSjo5vOkhVjk2
	ovYuqherTSqPvVw52gJda0L20Zud6rV34RNZpiQcL/JQUqvJNrotld3K540KUhMx8cQ=
X-Gm-Gg: ASbGnctUit1RstUijsA4pSJ3UgjyhJ55LMQc7l6Y9w4jqbfSrYoYtWKwZa8bP9JWnxJ
	jcCbwTQVtj2SgD4fEyW8cgeJevFZAFH6WAxFl0bX6bdYCpWyTEBDVFFQZvtb2ntzVTuAbPISXjd
	AsLAsPh8ggtWyxaeXphHUGEnOeaqiV0YVM3hKvo7xY6dyC6FjYH8nb1U/N128OeI/be+wIjjVXe
	zMOuHPaa6BTSmbXYFHXvlhfqZm8jpj67I8AWJmAbFohDGD12BzAXEBXL569bQG3mnu4eaSC1tEG
	HG0h1hgrLLb8yHzrJDzPXxrlkQF54ypUCMbZuLDk3ODcia9myywCZkOQ2HXtrcgv4B0557qEaIS
	tD7WeVXWWcH4NkTEk5qY230LDrFxYGKDoqkD5Gg==
X-Google-Smtp-Source: AGHT+IFI/E5qAIKfXdhNEpKBbEZViYZqEL++gyAmn9sf9BLf2v535PWLf+n1Md00yBlgDCzJA4lVmw==
X-Received: by 2002:a05:6000:1a8c:b0:3cf:74e0:55ac with SMTP id ffacd0b85a97d-3d1dfb108b2mr16861958f8f.38.1756997198893;
        Thu, 04 Sep 2025 07:46:38 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb5693921sm86639035e9.0.2025.09.04.07.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 07:46:38 -0700 (PDT)
Message-ID: <fabea1ff-cff0-4496-ae82-40c38f293ad5@linaro.org>
Date: Thu, 4 Sep 2025 15:46:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] coresight: trbe: Return NULL pointer for allocation
 failures
To: Leo Yan <leo.yan@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Mike Leach <mike.leach@linaro.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250904-cs_etm_auxsetup_fix_error_handling-v2-1-a502d0bafb95@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250904-cs_etm_auxsetup_fix_error_handling-v2-1-a502d0bafb95@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/09/2025 3:13 pm, Leo Yan wrote:
> When the TRBE driver fails to allocate a buffer, it currently returns
> the error code "-ENOMEM". However, the caller etm_setup_aux() only
> checks for a NULL pointer, so it misses the error. As a result, the
> driver continues and eventually causes a kernel panic.
> 
> Fix this by returning a NULL pointer from arm_trbe_alloc_buffer() on
> allocation failures. This allows that the callers can properly handle
> the failure.
> 
> Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
> Reported-by: Tamas Zsoldos <tamas.zsoldos@arm.com>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> Changes in v2:
> - Fix TRBE driver instead of changing coresight-etm-perf.c.
> - Link to v1: https://lore.kernel.org/r/20250904-cs_etm_auxsetup_fix_error_handling-v1-1-ecc5edf282a5@arm.com
> ---
>   drivers/hwtracing/coresight/coresight-trbe.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 10f3fb401edf6a00b24b38cdaa7c2865e7a191ac..8f9bbef71f236b327d35a288689df9b0dd8ff3f4 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -748,12 +748,12 @@ static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
>   
>   	buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, trbe_alloc_node(event));
>   	if (!buf)
> -		return ERR_PTR(-ENOMEM);
> +		return NULL;
>   
>   	pglist = kcalloc(nr_pages, sizeof(*pglist), GFP_KERNEL);
>   	if (!pglist) {
>   		kfree(buf);
> -		return ERR_PTR(-ENOMEM);
> +		return NULL;
>   	}
>   
>   	for (i = 0; i < nr_pages; i++)
> @@ -763,7 +763,7 @@ static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
>   	if (!buf->trbe_base) {
>   		kfree(pglist);
>   		kfree(buf);
> -		return ERR_PTR(-ENOMEM);
> +		return NULL;
>   	}
>   	buf->trbe_limit = buf->trbe_base + nr_pages * PAGE_SIZE;
>   	buf->trbe_write = buf->trbe_base;
> 
> ---
> base-commit: fa71e9cb4cfa59abb196229667ec84929bdc18fe
> change-id: 20250904-cs_etm_auxsetup_fix_error_handling-cb7e07ed9adf
> 
> Best regards,

Reviewed-by: James Clark <james.clark@linaro.org>


